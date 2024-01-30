Return-Path: <netdev+bounces-67216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39D8425F2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FDB1C20F6F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CE6BB38;
	Tue, 30 Jan 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YIdNrATV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493C6DCF9
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620468; cv=none; b=E8oq6W3KugbCCTQ7Yp3pE+qw2wypAAUszUggZu1Lzjww3XfCP99RSisORBMAbf7YskLGS09GMXQ4x5/QusOBOLpYBanz4bybVnRXFlwJyjmwLBYIXQ5TcMpjrYRrY3nNQ6zQR0BaYDQu+VYvLOaJKleIawhjLy3GERr3rjm3lDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620468; c=relaxed/simple;
	bh=0zXTH6nhZ47FCooqWOMwcVCaPGuE5e+qqRVIHvIkvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJzRFqHID1lz1LrlEa7hBSvUYUeIdVr8ZLOi068YcqChwDLRGMK4O6W66X4l0NIkdOTPd8UQL7HhShA3+Y1cZwriVc2ZrI9erGTGz93AqwT1SaSCpBfbR0U8HoEI1zgUmUEKS4Dfqe37WjEwMzHjOgyzuNYd0E5fK7jjHtV58vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YIdNrATV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so559931466b.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706620464; x=1707225264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/YpI2GpC/NZsSOushha7oUJzCMkvEbdGlNcCkyHN9k=;
        b=YIdNrATV7jrAgf18BR4QY/FG4cHb5qcohDalWkcBqm2Vttyya0AApTavEvpCmC9rCY
         yMGqWZmQ5LmQ1oLIXa2gYd5QrgCqeS6nvXzVgxRpA6I2YMBHar3ffM12wHQueaJncrr3
         tQ1Ihzehx10cUXMIAqiXWd9SDjuigjzYtX9+T+R4ADqQdGO917YLJDxRwMAPkT3FGkIc
         Pa3wcT5sLl2a7BxLyBM1QJuT7sT5QPXOWJ2BDTkJzgolSGQmn6g2XBPbXvXvKH1qbLhR
         jiFDvOAlwVYtcMIIYcfGDpr6j8eCC1Bh96RkYbHi+EzUJ6tZdIq7tq0dWNXhZ7UlGICI
         KEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706620464; x=1707225264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/YpI2GpC/NZsSOushha7oUJzCMkvEbdGlNcCkyHN9k=;
        b=sZXoLplqjQ2BwtcPjGqSt/V06q3Wqm9l0n97Zp0uVBBiy/zMx0rcn1SG7lVdlGskhh
         JicdQviBm3OyR63NpNhwg3xSZsKyySGjD8YpLo99V2UyKd18puWDI+6ZkWi4LON6lEy4
         HBRjxTsgBUy97dek2igu4IjG00Uw1bCgW+fGzOBQUsVHIhDE0xM/c6BYUH8xQibKQuyu
         Lun7bdBpBr3xu63O4IcCt1qMcZSjuBTHUJE3NRwCe3uIdZMRioxpLz1d2c7j5ik2hmUR
         LidiFAkyNh7OclYW43evXlCJLVr6dS/2ox1+pU0VtBPf8oM1A7xj3i+xEnMNPJIEW6m0
         n38g==
X-Gm-Message-State: AOJu0YwnnQ17n0ZsMscTUJV+X4JmQe0NL1XuABqJejWgDproNLQnyre7
	J4NYqwUHw4TKhBYEqrgDXDpZOBN2fGeB2gj4s9+fF7NSkBMAgxsjSi9GZQdoxt0Oear+6YoEnS6
	T
X-Google-Smtp-Source: AGHT+IE+B0LewHHvxucE6cpo0s7xqo7qxISVcEbdW1AKJCWzAAu3oRc/Hu+dlTHi5l78V72jYXfn2A==
X-Received: by 2002:a17:906:848:b0:a2c:b5a1:f8 with SMTP id f8-20020a170906084800b00a2cb5a100f8mr7158317ejd.37.1706620463969;
        Tue, 30 Jan 2024 05:14:23 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5be0:40::49:126])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a355a34f1f3sm3629261ejn.225.2024.01.30.05.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 05:14:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com
Subject: [PATCH net-next] selftests: udpgso: Pull up network setup into shell script
Date: Tue, 30 Jan 2024 14:14:22 +0100
Message-ID: <20240130131422.135965-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udpgso regression test configures routing and device MTU directly through
uAPI (Netlink, ioctl) to do its job. While there is nothing wrong with it,
it takes more effort than doing it from shell.

Looking forward, we would like to extend the udpgso regression tests to
cover the EIO corner case [1], once it gets addressed. That will require a
dummy device and device feature manipulation to set it up. Which means more
Netlink code.

So, in preparation, pull out network configuration into the shell script
part of the test, so it is easily extendable in the future.

Also, because it now easy to setup routing, add a second local IPv6
address. Because the second address is not managed by the kernel, we can
"replace" the corresponding local route with a reduced-MTU one. This
unblocks the disabled "ipv6 connected" test case. Add a similar setup for
IPv4 for symmetry.

[1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/udpgso.c  | 134 ++------------------------
 tools/testing/selftests/net/udpgso.sh |  50 ++++++++--
 2 files changed, 48 insertions(+), 136 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..79fd3287ff60 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -56,7 +56,6 @@ static bool		cfg_do_msgmore;
 static bool		cfg_do_setsockopt;
 static int		cfg_specific_test_id = -1;
 
-static const char	cfg_ifname[] = "lo";
 static unsigned short	cfg_port = 9000;
 
 static char buf[ETH_MAX_MTU];
@@ -69,8 +68,13 @@ struct testcase {
 	int r_len_last;		/* recv(): size of last non-mss dgram, if any */
 };
 
-const struct in6_addr addr6 = IN6ADDR_LOOPBACK_INIT;
-const struct in_addr addr4 = { .s_addr = __constant_htonl(INADDR_LOOPBACK + 2) };
+const struct in6_addr addr6 = {
+	{ { 0x20, 0x01, 0x0d, 0xb8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x00, 0x01 } },
+};
+
+const struct in_addr addr4 = {
+	__constant_htonl(0xc0000201), /* 192.0.2.1 */
+};
 
 struct testcase testcases_v4[] = {
 	{
@@ -274,48 +278,6 @@ struct testcase testcases_v6[] = {
 	}
 };
 
-static unsigned int get_device_mtu(int fd, const char *ifname)
-{
-	struct ifreq ifr;
-
-	memset(&ifr, 0, sizeof(ifr));
-
-	strcpy(ifr.ifr_name, ifname);
-
-	if (ioctl(fd, SIOCGIFMTU, &ifr))
-		error(1, errno, "ioctl get mtu");
-
-	return ifr.ifr_mtu;
-}
-
-static void __set_device_mtu(int fd, const char *ifname, unsigned int mtu)
-{
-	struct ifreq ifr;
-
-	memset(&ifr, 0, sizeof(ifr));
-
-	ifr.ifr_mtu = mtu;
-	strcpy(ifr.ifr_name, ifname);
-
-	if (ioctl(fd, SIOCSIFMTU, &ifr))
-		error(1, errno, "ioctl set mtu");
-}
-
-static void set_device_mtu(int fd, int mtu)
-{
-	int val;
-
-	val = get_device_mtu(fd, cfg_ifname);
-	fprintf(stderr, "device mtu (orig): %u\n", val);
-
-	__set_device_mtu(fd, cfg_ifname, mtu);
-	val = get_device_mtu(fd, cfg_ifname);
-	if (val != mtu)
-		error(1, 0, "unable to set device mtu to %u\n", val);
-
-	fprintf(stderr, "device mtu (test): %u\n", val);
-}
-
 static void set_pmtu_discover(int fd, bool is_ipv4)
 {
 	int level, name, val;
@@ -354,81 +316,6 @@ static unsigned int get_path_mtu(int fd, bool is_ipv4)
 	return mtu;
 }
 
-/* very wordy version of system("ip route add dev lo mtu 1500 127.0.0.3/32") */
-static void set_route_mtu(int mtu, bool is_ipv4)
-{
-	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
-	struct nlmsghdr *nh;
-	struct rtattr *rta;
-	struct rtmsg *rt;
-	char data[NLMSG_ALIGN(sizeof(*nh)) +
-		  NLMSG_ALIGN(sizeof(*rt)) +
-		  NLMSG_ALIGN(RTA_LENGTH(sizeof(addr6))) +
-		  NLMSG_ALIGN(RTA_LENGTH(sizeof(int))) +
-		  NLMSG_ALIGN(RTA_LENGTH(0) + RTA_LENGTH(sizeof(int)))];
-	int fd, ret, alen, off = 0;
-
-	alen = is_ipv4 ? sizeof(addr4) : sizeof(addr6);
-
-	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
-	if (fd == -1)
-		error(1, errno, "socket netlink");
-
-	memset(data, 0, sizeof(data));
-
-	nh = (void *)data;
-	nh->nlmsg_type = RTM_NEWROUTE;
-	nh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE;
-	off += NLMSG_ALIGN(sizeof(*nh));
-
-	rt = (void *)(data + off);
-	rt->rtm_family = is_ipv4 ? AF_INET : AF_INET6;
-	rt->rtm_table = RT_TABLE_MAIN;
-	rt->rtm_dst_len = alen << 3;
-	rt->rtm_protocol = RTPROT_BOOT;
-	rt->rtm_scope = RT_SCOPE_UNIVERSE;
-	rt->rtm_type = RTN_UNICAST;
-	off += NLMSG_ALIGN(sizeof(*rt));
-
-	rta = (void *)(data + off);
-	rta->rta_type = RTA_DST;
-	rta->rta_len = RTA_LENGTH(alen);
-	if (is_ipv4)
-		memcpy(RTA_DATA(rta), &addr4, alen);
-	else
-		memcpy(RTA_DATA(rta), &addr6, alen);
-	off += NLMSG_ALIGN(rta->rta_len);
-
-	rta = (void *)(data + off);
-	rta->rta_type = RTA_OIF;
-	rta->rta_len = RTA_LENGTH(sizeof(int));
-	*((int *)(RTA_DATA(rta))) = 1; //if_nametoindex("lo");
-	off += NLMSG_ALIGN(rta->rta_len);
-
-	/* MTU is a subtype in a metrics type */
-	rta = (void *)(data + off);
-	rta->rta_type = RTA_METRICS;
-	rta->rta_len = RTA_LENGTH(0) + RTA_LENGTH(sizeof(int));
-	off += NLMSG_ALIGN(rta->rta_len);
-
-	/* now fill MTU subtype. Note that it fits within above rta_len */
-	rta = (void *)(((char *) rta) + RTA_LENGTH(0));
-	rta->rta_type = RTAX_MTU;
-	rta->rta_len = RTA_LENGTH(sizeof(int));
-	*((int *)(RTA_DATA(rta))) = mtu;
-
-	nh->nlmsg_len = off;
-
-	ret = sendto(fd, data, off, 0, (void *)&nladdr, sizeof(nladdr));
-	if (ret != off)
-		error(1, errno, "send netlink: %uB != %uB\n", ret, off);
-
-	if (close(fd))
-		error(1, errno, "close netlink");
-
-	fprintf(stderr, "route mtu (test): %u\n", mtu);
-}
-
 static bool __send_one(int fd, struct msghdr *msg, int flags)
 {
 	int ret;
@@ -591,15 +478,10 @@ static void run_test(struct sockaddr *addr, socklen_t alen)
 	/* Do not fragment these datagrams: only succeed if GSO works */
 	set_pmtu_discover(fdt, addr->sa_family == AF_INET);
 
-	if (cfg_do_connectionless) {
-		set_device_mtu(fdt, CONST_MTU_TEST);
+	if (cfg_do_connectionless)
 		run_all(fdt, fdr, addr, alen);
-	}
 
 	if (cfg_do_connected) {
-		set_device_mtu(fdt, CONST_MTU_TEST + 100);
-		set_route_mtu(CONST_MTU_TEST, addr->sa_family == AF_INET);
-
 		if (connect(fdt, addr, alen))
 			error(1, errno, "connect");
 
diff --git a/tools/testing/selftests/net/udpgso.sh b/tools/testing/selftests/net/udpgso.sh
index fec24f584fe9..d7fb71e132bb 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -3,27 +3,57 @@
 #
 # Run a series of udpgso regression tests
 
+set -o errexit
+set -o nounset
+# set -o xtrace
+
+setup_loopback() {
+  ip addr add dev lo 192.0.2.1/32
+  ip addr add dev lo 2001:db8::1/128 nodad noprefixroute
+}
+
+test_dev_mtu() {
+  setup_loopback
+  # Reduce loopback MTU
+  ip link set dev lo mtu 1500
+}
+
+test_route_mtu() {
+  setup_loopback
+  # Remove default local routes
+  ip route del local 192.0.2.1/32 table local dev lo
+  ip route del local 2001:db8::1/128 table local dev lo
+  # Install local routes with reduced MTU
+  ip route add local 192.0.2.1/32 table local dev lo mtu 1500
+  ip route add local 2001:db8::1/128 table local dev lo mtu 1500
+}
+
+if [ "$#" -gt 0 ]; then
+  "$1"
+  shift 2 # pop "test_*" function arg and "--" delimiter
+  exec "$@"
+fi
+
 echo "ipv4 cmsg"
-./in_netns.sh ./udpgso -4 -C
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C
 
 echo "ipv4 setsockopt"
-./in_netns.sh ./udpgso -4 -C -s
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C -s
 
 echo "ipv6 cmsg"
-./in_netns.sh ./udpgso -6 -C
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C
 
 echo "ipv6 setsockopt"
-./in_netns.sh ./udpgso -6 -C -s
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C -s
 
 echo "ipv4 connected"
-./in_netns.sh ./udpgso -4 -c
+./in_netns.sh "$0" test_route_mtu -- ./udpgso -4 -c
 
-# blocked on 2nd loopback address
-# echo "ipv6 connected"
-# ./in_netns.sh ./udpgso -6 -c
+echo "ipv6 connected"
+./in_netns.sh "$0" test_route_mtu -- ./udpgso -6 -c
 
 echo "ipv4 msg_more"
-./in_netns.sh ./udpgso -4 -C -m
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -4 -C -m
 
 echo "ipv6 msg_more"
-./in_netns.sh ./udpgso -6 -C -m
+./in_netns.sh "$0" test_dev_mtu -- ./udpgso -6 -C -m
-- 
2.43.0


