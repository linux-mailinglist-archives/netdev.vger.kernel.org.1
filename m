Return-Path: <netdev+bounces-69612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274784BD95
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246331C24A50
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A65134DB;
	Tue,  6 Feb 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FPuQf2fa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696213AD9
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245928; cv=none; b=jeTMy1qLaF7Nftkspnp0/hxK3zD1YyWQdVoDCLJWSc48jJTfMVwu7evAenAvkekP3HuVld9jR0P8C9mV0ZZGQm33P7cbEyjWNGlALgLNELoh7KTiO2S7BuEv20N2ImRZFVTRY5c0RpIeYBpIEUBymuDgcHAsgILnn7P4G243xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245928; c=relaxed/simple;
	bh=p3VcebzeTuAYKj+6sFPNJAgV5f3a4BVyLqBZMKEqB9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jup6/KlJezdzMzPlAa3Sm81a1dtXwzFDUhrv7LV0TLp+SPEoqtcEV7yv+OsMci4tojt3MoralPaizJa3DGIWYQIcwF5PiKelVESVhaaWH12+1RxNju0VuSnFVq05iv/ieqJPAuWR9ULtxPcuSDYAlCDk9x+DOkXGqEoH1jJEb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FPuQf2fa; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5601eb97b29so1815816a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707245924; x=1707850724; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbQeUWvVIPW/0EmkGijBJgYhB8zpSOdV/8xLyuX0gS8=;
        b=FPuQf2fat0CGvVmb/0RQnOAj9v9iPTqpjhmuLG1HruOhTfj3uvCo1BEvY1qFGF+oS7
         Vr1Cppa0khi1cfgO5OcX5hg8mtlbBk/krgA2skEklvI9J7tBbwu2lfP5JFj3iu4A7OqM
         aQEuumK+mvMuQi7j1fRkgSc95vvDblK/IboZ8X33TzlVSiArBxddd/V9gNaKKzdf9+Vu
         ExJx9yCvgoPO9rqVIRzDe9DEy3L1hyJUQGd6qUNx9rxfnWoO1/e899oqyPFGPeT57q/n
         IRCZW3j9bAR4LNXQPNHrPT8/NJK1CTxw/kJvTgd8YyUtIlAMU9lSuwZ0PoAy0AxqDXfr
         ao+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245924; x=1707850724;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbQeUWvVIPW/0EmkGijBJgYhB8zpSOdV/8xLyuX0gS8=;
        b=fQyM7JGp2xnf1/CVxj5Xpp0xz5aZGlrAQwyG7s0L9gv28xnmm6Xq3HpNiQmyN1rz+y
         5ws9laAMcdh1+KWRMdOym0IPm4iaFATGMgLWvzLedOz910K3/8jfbJSrafRnjpuGnkY/
         qyJS8b0gBhuD6ziII6pTJ47/ZCypDXxAJo860wRiBon6MJ9uwRr93uvKvlWe/Epu8Tl9
         GDxSnHluJS9MuRbHXxgyGn2+vukzQnn+qDqQt0Ao+f35Cje64R1gxHHfZM4aeC4V3+8o
         ORIzfAdibLYJBAbXJVh/08foeZAiI/N3GMVacNhRFDkYhg2VJ+PJP1qErv1mDmah8oTH
         BleQ==
X-Gm-Message-State: AOJu0Yy5RPtpSbccj2AV858lcVuC9XabiAWdz2njDTrvm3mv2dJkE2Yi
	DFTL/2sJ1Qx4ly5Gk9xKH5mPOxs4KlhIyWhieZ+cd3+8uWxvAWWtxBY63AaeR/8=
X-Google-Smtp-Source: AGHT+IGCg+hlZO8ptjpk12Z2QVUkCYoQVuA2cJJKp9+wjwGaArS+lRgyzGh/UTY4ppmah4h9na/Vww==
X-Received: by 2002:a50:9f2b:0:b0:55f:e682:c933 with SMTP id b40-20020a509f2b000000b0055fe682c933mr10242015edf.12.1707245924357;
        Tue, 06 Feb 2024 10:58:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCqXojif3bARW7DYkse76sAg7dI3YRnLFJCRlOjE+W/4JjBN+GB6PzXBIVdlLaN+SIALEt4My0/mPNQd36i/WrDGeEEBmKntWIdaYX6Wbkau3N+3axtUqNRCqrr1QpwHQfcfip5YOsyG31qu6p9vcQG04myciHaObNH77VYLdZxi31KF7b3r1ejUzGimAEdQZUtByPzYcd62jgCMNtR7Aa99Yc4oAkfkX7YvzW0T7p8Yiw44IFZhkp4e4=
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:82])
        by smtp.gmail.com with ESMTPSA id q24-20020a50cc98000000b0055fcec89774sm1365115edi.24.2024.02.06.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:58:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 06 Feb 2024 19:58:31 +0100
Subject: [PATCH net-next v2] selftests: udpgso: Pull up network setup into
 shell script
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAFaBwmUC/y2NywqDMBREf0XuulfyUGm78j+Ki5hca6pNSqJiE
 f+9IRRmMxzmzAGRgqUI9+KAQJuN1rtUxKUAPSr3JLQmdRBMVEwwji81rT1OwWEjazS9MZpxzUh
 dIW0+gQa7Z98DHC3oaF+gS2S0cfHhm482nnl2cpnCKyFKLutbU+P/otWzX80wq0Cl9m/ozvP8A
 epykQeuAAAA
To: netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
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
index fec24f584fe9..796324765c80 100755
--- a/tools/testing/selftests/net/udpgso.sh
+++ b/tools/testing/selftests/net/udpgso.sh
@@ -3,27 +3,56 @@
 #
 # Run a series of udpgso regression tests
 
+set -o errexit
+set -o nounset
+
+setup_loopback() {
+  ip addr add dev lo 10.0.0.1/32
+  ip addr add dev lo fd00::1/128 nodad noprefixroute
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
+  ip route del local 10.0.0.1/32 table local dev lo
+  ip route del local fd00::1/128 table local dev lo
+  # Install local routes with reduced MTU
+  ip route add local 10.0.0.1/32 table local dev lo mtu 1500
+  ip route add local fd00::1/128 table local dev lo mtu 1500
+}
+
+if [ "$#" -gt 0 ]; then
+  "$1"
+  shift 2 # pop "test_*" arg and "--" delimiter
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


