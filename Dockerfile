FROM gliderlabs/alpine:3.7
MAINTAINER Althea Voyle <althea@voyle.nz>

COPY rootfs /
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.1/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz

# about nsswitch.conf - see https://registry.hub.docker.com/u/frolvlad/alpine-oraclejdk8/dockerfile/

RUN tar xvfz /tmp/s6-overlay.tar.gz -C / && \
  apk -U add dnsmasq jq curl && \
  chmod 755 /bin/*.sh /etc/services.d/dns/run /etc/services.d/dns-hack/run /etc/services.d/syslog/run && \
  mkdir /app && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  addgroup -g 998 app && \
  adduser -D  -G app -s /bin/false -u 998 app

ENTRYPOINT ["/init"]
CMD []
