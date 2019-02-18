FROM golang:1.11.5

COPY clean-install /usr/local/bin/clean-install
RUN chmod +x /usr/local/bin/clean-install

ARG ARCH=amd64
ARG DOCKER_VERSION="18.06.*"

RUN clean-install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common

RUN curl -fsSL "https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg" | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && ARCH="${ARCH}" add-apt-repository \
        "deb [arch=${ARCH}] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && clean-install "docker-ce=${DOCKER_VERSION}"
