FROM alpine:3.11
MAINTAINER Alexander Jung-Loddenkemper <alexander@julo.ch>

ENV DG_VERSION 0.7.4
ENV DG_URL https://github.com/jwilder/docker-gen/releases/download/$DG_VERSION/docker-gen-alpine-linux-amd64-$DG_VERSION.tar.gz

RUN apk add --no-cache ca-certificates && apk add --virtual deps wget tar \
  && wget -qO- $DG_URL | tar xvz -C /usr/local/bin \
  && apk del deps

RUN mkdir -p /opt/caddy-gen /etc/caddy
WORKDIR /opt/caddy-gen

COPY . /opt/caddy-gen
CMD /usr/local/bin/docker-gen -notify ./reload.sh -notify-output -only-exposed -watch Caddyfile.tmpl /etc/caddy/Caddyfile
