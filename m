Return-Path: <netdev+bounces-69992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCD84D312
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716A01F22ED1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F881DFC1;
	Wed,  7 Feb 2024 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YSyKl1aH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8961E525
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338137; cv=none; b=pWIqkOhsR/gMcYLDW0ifoXkEAwtOvzKRwvsaaNXGeLtNMCfeRQ8DyXrqtFapuWoLcLWXCGoqxakmIrJaDXD0mmO6Ps3RNQOYqlV2aG4CPE6hAFxLmFZRDp2OY273TNRdVTCsRUUq1rBpNqNBZNthS8/XKWn6SWeJoeA4jneMZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338137; c=relaxed/simple;
	bh=xRezsPyrMmcWpoqHxxGflx+F/i6P7AEn4jI6XLdWQS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r+7WTUavDBq18LJQpTqEXRhuJYnoTGzJQPKutvnad9fGfK7HHPHyz+ayrK2a0j7lEKNl2VnIuZmwq5Zag/og2NePAPOBMtTb+n5fdCVfXeESAyccJW5aY/cIpmNAj2Xdf5L4WUPBnNlkN6u1PHDXodjZyEG/11ITRxguyBaUEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YSyKl1aH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d066b532f0so16236681fa.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707338133; x=1707942933; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN/5impcpG49BrraXlVb8tLALmWXDoV+Tzy/hBNpHUM=;
        b=YSyKl1aHCMbUtJhMWx2rUKNeoDmQrLS5aIPqQhaf5tVOI6WyX1RxF2Z2WcMEQUvyYZ
         /nalsKHdqfqztOEmkweQqe8LIQXOK/Gq5koCDtypCcBlArTH1on3eHp3J2Bqig0X8JS7
         t2f2i5I34i4M6mNdguzqj5S5Il4r8y5rPbEkqI3bTdPK6hPDasV5+TJeTeqyUTn/V6rh
         Myv5UJ4FIEpRSOsUBfG/ieKkmGVTj7XJPo425hKKBW4QfkMmCW/IodGYP0Donmk5+Ogz
         ueGIZ72gu7yEJoO0B4J/8qlMybV0bhsS/wV5wApeQno9LS78RN1swYwwp7f+2J5jPv2P
         2/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338133; x=1707942933;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN/5impcpG49BrraXlVb8tLALmWXDoV+Tzy/hBNpHUM=;
        b=pBENiMVLPzoHw9pUQkf+lPmmwv1fHOwdtksje7MiOstiYrMpRU1b5i1bX3AvgXhn26
         iSzfiP2VLcVkSlu6W3PsLFbwD4Mdph68KH/fz2wd3Hxtkq2z15tT9olqEJJLW0Xy8z4y
         KNsIOkxHYXJJhQxELxij/42uyWDMa/teNdQwdsQYw1Q+cfJ00MEr5mDu5LKQhbHxAyk3
         JCbej2YxYF47HaUWwhjuOj/lDDxuIW8e2TWLe5QoWbfkVh/+Ph+3ln1jyYIufadWXy2d
         i+UhoNqCcY0WqVB0Fpe5Cutv3BinwOHAu/lGNiDtV33x5n9kAitiCIC6lr7AFxm+Ezcs
         xXCA==
X-Gm-Message-State: AOJu0YznesXEOZyPDgC3KStEbKyl0SvamZxDtrsrjuYfuOdY27G87SAV
	/jNC6etepvTo7lvYtA1m+NY7VC3Gco/ALWq968qkreBz81g2OVQi9vL5YliK36c=
X-Google-Smtp-Source: AGHT+IE38s9YDan8wsueTkKuvrlSUMxrOdAd6RB0RRPQV7jjGaNE7hSGsgW49vcC+h6NPgW1x+m5Sg==
X-Received: by 2002:a2e:3208:0:b0:2d0:b750:514c with SMTP id y8-20020a2e3208000000b002d0b750514cmr5919426ljy.9.1707338133214;
        Wed, 07 Feb 2024 12:35:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsa/2W4EICgKHL/bhhRL01PlQ4w4/S4TDhvZhGZfrT9KTnyMscYS4do1RWJiJZmLp98TEKaO6Ydb+I/eHGjjIB8LSgeyDBnMVsbmNbv/dpaBBq+5AReFnxNdUjXjZMqp7bKZRayQ77bFH3QHthvvytz7rYRN1L4KrxFELBi+QHkFu36rro3Bi3ni/bBIQVPF8Wrkg8Zl0tfpJBY/o/lpEZA54lmJsIed4no7qWRQ==
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:83])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7db94000000b0056011a877dasm72509edt.29.2024.02.07.12.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:35:32 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Feb 2024 21:35:22 +0100
Subject: [PATCH net-next v3] selftests: udpgso: Pull up network setup into
 shell script
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-jakub-krn-635-v3-1-3dfa3da8a7d3@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAInpw2UC/2WOQQqDMBBFr1KybiQZNWpXvUfpIiZjTbVJiRos4
 t0bQqHQwmw+n/f+bGRCb3Aip8NGPAYzGWdjyI8Honppb0iNjpkAg4IB4/Quh6Wlg7dU5CXVrda
 KccVQ1iQyT4+dWZPvQizO1OI6k2tsejPNzr/SUOCpT06ex+MFQMbzshEl/Uyc1egW3Y3SY6bcI
 zkCfDlg4ueXAJGtuaoaUbVMQPGn2Pf9Ddnll7zxAAAA
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.13-dev-2d940

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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v3:
- Tabify udpgso.sh script
- Link to v2: https://lore.kernel.org/r/20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com

Changes in v2:
- Switch from documentation to private IP range
- Clean up debug comment from shell script
- Link to v1: https://lore.kernel.org/r/20240130131422.135965-1-jakub@cloudflare.com
---
 tools/testing/selftests/net/udpgso.c  | 134 ++--------------------------------
 tools/testing/selftests/net/udpgso.sh |  49 ++++++++++---
 2 files changed, 47 insertions(+), 136 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de2..1d975bf52af3 100644
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
+	{ { 0xfd, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } }, /* fd00::1 */
+};
+
+const struct in_addr addr4 = {
+	__constant_htonl(0x0a000001), /* 10.0.0.1 */
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
index fec24f584fe9..6c63178086b0 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -3,27 +3,56 @@
 #
 # Run a series of udpgso regression tests
 
+set -o errexit
+set -o nounset
+
+setup_loopback() {
+	ip addr add dev lo 10.0.0.1/32
+	ip addr add dev lo fd00::1/128 nodad noprefixroute
+}
+
+test_dev_mtu() {
+	setup_loopback
+	# Reduce loopback MTU
+	ip link set dev lo mtu 1500
+}
+
+test_route_mtu() {
+	setup_loopback
+	# Remove default local routes
+	ip route del local 10.0.0.1/32 table local dev lo
+	ip route del local fd00::1/128 table local dev lo
+	# Install local routes with reduced MTU
+	ip route add local 10.0.0.1/32 table local dev lo mtu 1500
+	ip route add local fd00::1/128 table local dev lo mtu 1500
+}
+
+if [ "$#" -gt 0 ]; then
+	"$1"
+	shift 2 # pop "test_*" arg and "--" delimiter
+	exec "$@"
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


