Return-Path: <netdev+bounces-294265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gik+Jnr5HmoObQAAu9opvQ
	(envelope-from <netdev+bounces-294265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5D62FE15
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jdT7PDDu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152283174731
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919E3E95B3;
	Tue,  2 Jun 2026 15:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985893EC2FF
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413021; cv=none; b=OocITj7Ti0hrsHPWyoJD631WHOjMy0Lgx5KxExIxoqFOrC9cwesaLEPixX4iAKgRHi43+vczaNKIFxmmnmIWWj6II6w9RgfojhqgVnZFRadVeaKl5a8nEkN890rnQaZ1MgNdjWQ/ao4dq4nJrLM8weHYaQoh1fIst9j5vGqmbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413021; c=relaxed/simple;
	bh=aNiYV6eks9AWxansqt7a9QeRU2sU+D70Y0WnA0lziDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWxu3PnSw2RAo8QDpllLk3DgaG5EgSm5uNKsyriDhXMaFkc9/6vyKHVCKmZKJwKAWXUZh+TqXOWm3YonbwMqaA05fiSuzHBc53iRTG5xXiOhW8k4wVhiAknaMGVHkOpYAUcVPElJ3b7yyOG1bb0MPmTy0obH1cljRqho42cabJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdT7PDDu; arc=none smtp.client-ip=95.215.58.187
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780413016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aJ8UsRt56L+UYhTOTDwNHFuUJw1GXfsMzTmYDtBGsY=;
	b=jdT7PDDuoUBBQo9vX8UK2mlR1YlfyHkCkQhFNYNlUGZdj34nr6omYD6XEFaIAK/vlB6BTz
	PgRUACgK7aud4KT0vuQLD27IY4pnwlc3tjudNIQskuVSZ8bJMZcJ0Z5Jaa3gHVyX9uMdaR
	95cPZ+P7W9aIUmfzH5YL2btFrv+XyPc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt
Date: Tue,  2 Jun 2026 23:09:31 +0800
Message-ID: <20260602150931.49629-3-leon.hwang@linux.dev>
In-Reply-To: <20260602150931.49629-1-leon.hwang@linux.dev>
References: <20260602150931.49629-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294265-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:gnault@redhat.com,m:leon.hwang@linux.dev,m:idosch@nvidia.com,m:fmancera@suse.de,m:posk@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-patches-bot@fb.com,m:leon.huangfu@shopee.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBB5D62FE15

Add two tests to verify the transport header of skb has been set when
encapsulate VxLAN using bpf_lwt_push_encap() helper.

1. VxLAN over IPv4.
2. VxLAN over IPv6.

Without the fix, the tests would fail:

 lwt_ip_encap_vxlan:FAIL:transport_hdr offset unexpected transport_hdr offset: actual 70 != expected 20
 #208     lwt_ip_encap_vxlan_ipv4:FAIL
 lwt_ip_encap_vxlan:FAIL:transport_hdr offset unexpected transport_hdr offset: actual 110 != expected 40
 #209     lwt_ip_encap_vxlan_ipv6:FAIL

The unexpected offsets are: outer encap headers
(IPv4: iphdr+udp+vxlan+eth = 50 bytes, IPv6: ipv6hdr+udp+vxlan+eth = 70 bytes)
plus the inner IP header (20 or 40 bytes), because without the fix
transport_header still points at the inner transport layer instead of the
outer UDP header.

Assisted-by: Claude:claude-sonnet-4-6
Cc: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 145 ++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 155 ++++++++++++++++--
 2 files changed, 290 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index b6391af5f6f9..6606f0ed9a9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -3,6 +3,7 @@
 
 #include "network_helpers.h"
 #include "test_progs.h"
+#include "test_lwt_ip_encap.skel.h"
 
 #define BPF_FILE "test_lwt_ip_encap.bpf.o"
 
@@ -32,6 +33,9 @@
 #define IP6_ADDR_8 "fb08::1"
 #define IP6_ADDR_GRE "fb10::1"
 
+#define IP4_ADDR_VXLAN  "172.16.17.100"
+#define IP6_ADDR_VXLAN  "fb11::1"
+
 #define IP6_ADDR_SRC IP6_ADDR_1
 #define IP6_ADDR_DST IP6_ADDR_4
 
@@ -538,3 +542,144 @@ void test_lwt_ip_encap_ipv4(void)
 	if (test__start_subtest("ingress"))
 		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
 }
+
+/*
+ * VxLAN Setup/topology:
+ *
+ * NS1 (IP*_ADDR_1)                NS2                  NS3 (IP*_ADDR_4)
+ *       [ping src]
+ *           |                          top route
+ *         veth1 (LWT encap)  <<-- veth2        veth3  <<-- veth4 (ping dst)
+ *           |                                                ^
+ *       (bottom route)                                       | (inner pkt)
+ *           v                        bottom route            |
+ *         veth5              -->> veth6        veth7  -->> veth8 (vxlan decap)
+ *                                                          (IP*_ADDR_VXLAN)
+ *
+ * Add the VxLAN endpoint addresses to NS3's veth8, create standard
+ * VxLAN decap devices bound to those addresses, and install routes so
+ * NS1/NS2 can reach the endpoints via the bottom route.  NS2 here is to
+ * make sure the LWT-encap VxLAN packets are routed to NS3 correctly.
+ */
+static int setup_vxlan_routes(const char *ns3, const char *ns1, const char *ns2)
+{
+	struct nstoken *nstoken;
+
+	nstoken = open_netns(ns3);
+	if (!ASSERT_OK_PTR(nstoken, "open ns3 for vxlan"))
+		return -1;
+
+	SYS(fail_close, "ip    a add %s/32  dev veth8", IP4_ADDR_VXLAN);
+	SYS(fail_close, "ip -6 a add %s/128 dev veth8", IP6_ADDR_VXLAN);
+	/*
+	 * Standard VxLAN devices to decap the encapsulated packets.  The inner
+	 * Ethernet frame uses a broadcast dst MAC so the IP stack accepts it
+	 * without ARP or FDB configuration.
+	 */
+	SYS(fail_close, "ip link add vxlan4 type vxlan id 1 dstport 4789 local %s dev veth8 nolearning noudpcsum",
+	    IP4_ADDR_VXLAN);
+	SYS(fail_close, "ip link set vxlan4 up");
+	SYS(fail_close, "ip link add vxlan6 type vxlan id 1 dstport 4789 local %s dev veth8 nolearning udp6zerocsumrx",
+	    IP6_ADDR_VXLAN);
+	SYS(fail_close, "ip link set vxlan6 up");
+	close_netns(nstoken);
+
+	SYS(fail, "ip -n %s    route add %s/32  dev veth5 via %s",
+	    ns1, IP4_ADDR_VXLAN, IP4_ADDR_6);
+	SYS(fail, "ip -n %s    route add %s/32  dev veth7 via %s",
+	    ns2, IP4_ADDR_VXLAN, IP4_ADDR_8);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth5 via %s",
+	    ns1, IP6_ADDR_VXLAN, IP6_ADDR_6);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth7 via %s",
+	    ns2, IP6_ADDR_VXLAN, IP6_ADDR_8);
+	return 0;
+
+fail_close:
+	close_netns(nstoken);
+fail:
+	return -1;
+}
+
+static void lwt_ip_encap_vxlan(bool ipv4_encap)
+{
+	char ns1[NETNS_NAME_SIZE] = NETNS_BASE "-1-";
+	char ns2[NETNS_NAME_SIZE] = NETNS_BASE "-2-";
+	char ns3[NETNS_NAME_SIZE] = NETNS_BASE "-3-";
+	const char *sec = ipv4_encap ? "encap_vxlan" : "encap_vxlan6";
+	int expected_offset = ipv4_encap ? (int)sizeof(struct iphdr)
+					 : (int)sizeof(struct ipv6hdr);
+	struct test_lwt_ip_encap *skel = NULL;
+	int thdr_offset, err;
+
+	if (!ASSERT_OK(create_ns(ns1, NETNS_NAME_SIZE), "create ns1"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns2, NETNS_NAME_SIZE), "create ns2"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns3, NETNS_NAME_SIZE), "create ns3"))
+		goto out;
+
+	if (!ASSERT_OK(setup_network(ns1, ns2, ns3, ""), "setup network"))
+		goto out;
+
+	if (!ASSERT_OK(setup_vxlan_routes(ns3, ns1, ns2), "setup vxlan routes"))
+		goto out;
+
+	skel = test_lwt_ip_encap__open();
+	if (!ASSERT_OK_PTR(skel, "test_lwt_ip_encap__open"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_gre, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_gre6, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_vxlan, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_vxlan6, false);
+	bpf_program__set_autoload(skel->progs.fexit_lwt_push_ip_encap, true);
+	skel->rodata->tgt_ip_version = ipv4_encap ? 4 : 6;
+
+	err = test_lwt_ip_encap__load(skel);
+	if (!ASSERT_OK(err, "test_lwt_ip_encap__load"))
+		goto out;
+
+	err = test_lwt_ip_encap__attach(skel);
+	if (!ASSERT_OK(err, "test_lwt_ip_encap__attach"))
+		goto out;
+
+	/* Remove the direct NS2->DST route so packets must go via LWT encap. */
+	SYS(out, "ip -n %s    route del %s/32  dev veth3", ns2, IP4_ADDR_DST);
+	SYS(out, "ip -n %s -6 route del %s/128 dev veth3", ns2, IP6_ADDR_DST);
+
+	if (ipv4_encap)
+		SYS(out, "ip -n %s route add %s encap bpf xmit obj %s sec %s dev veth1",
+		    ns1, IP4_ADDR_DST, BPF_FILE, sec);
+	else
+		SYS(out, "ip -n %s -6 route add %s encap bpf xmit obj %s sec %s dev veth1",
+		    ns1, IP6_ADDR_DST, BPF_FILE, sec);
+
+	skel->bss->fexit_triggered = false;
+
+	if (ipv4_encap)
+		SYS(out, "ip netns exec %s ping  -c 1 -W1 %s", ns1, IP4_ADDR_DST);
+	else
+		SYS(out, "ip netns exec %s ping6 -c 1 -W1 %s", ns1, IP6_ADDR_DST);
+
+	if (!ASSERT_TRUE(skel->bss->fexit_triggered, "fexit_triggered"))
+		goto out;
+
+	thdr_offset = (int)skel->bss->transport_hdr - (int)skel->bss->network_hdr;
+	ASSERT_EQ(thdr_offset, expected_offset, "transport_hdr offset");
+
+out:
+	test_lwt_ip_encap__destroy(skel);
+	SYS_NOFAIL("ip netns del %s", ns1);
+	SYS_NOFAIL("ip netns del %s", ns2);
+	SYS_NOFAIL("ip netns del %s", ns3);
+}
+
+void test_lwt_ip_encap_vxlan_ipv4(void)
+{
+	lwt_ip_encap_vxlan(IPV4_ENCAP);
+}
+
+void test_lwt_ip_encap_vxlan_ipv6(void)
+{
+	lwt_ip_encap_vxlan(IPV6_ENCAP);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
index d6cb986e7533..4a934fccf8f5 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stddef.h>
+#include "vmlinux.h"
 #include <string.h>
-#include <linux/bpf.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
 
 struct grehdr {
 	__be16 flags;
@@ -64,13 +62,13 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	hdr.ip6hdr.nexthdr = 47;  /* IPPROTO_GRE */
 	hdr.ip6hdr.hop_limit = 0x40;
 	/* fb01::1 */
-	hdr.ip6hdr.saddr.s6_addr[0] = 0xfb;
-	hdr.ip6hdr.saddr.s6_addr[1] = 1;
-	hdr.ip6hdr.saddr.s6_addr[15] = 1;
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[0] = 0xfb;
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[1] = 1;
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[15] = 1;
 	/* fb10::1 */
-	hdr.ip6hdr.daddr.s6_addr[0] = 0xfb;
-	hdr.ip6hdr.daddr.s6_addr[1] = 0x10;
-	hdr.ip6hdr.daddr.s6_addr[15] = 1;
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[0] = 0xfb;
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[1] = 0x10;
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[15] = 1;
 
 	hdr.greh.protocol = skb->protocol;
 
@@ -82,4 +80,141 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	return BPF_LWT_REROUTE;
 }
 
+#define VXLAN_PORT  4789
+#define VXLAN_FLAGS 0x08000000
+#define VXLAN_VNI   1
+
+#define ETH_ALEN	6		/* Octets in one ethernet addr	 */
+#define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
+#define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
+
+static const __u8 bcast[ETH_ALEN] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+static const __u8 srcmac[ETH_ALEN] = {
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x01,
+};
+
+SEC("encap_vxlan")
+int bpf_lwt_encap_vxlan(struct __sk_buff *skb)
+{
+	struct encap_hdr {
+		struct iphdr    iph;
+		struct udphdr   udph;
+		struct vxlanhdr vxh;
+		struct ethhdr   eth;
+	} __attribute__((__packed__)) hdr;
+	int err;
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	hdr.iph.ihl      = 5;
+	hdr.iph.version  = 4;
+	hdr.iph.ttl      = 0x40;
+	hdr.iph.protocol = 17; /* IPPROTO_UDP */
+	hdr.iph.tot_len  = bpf_htons(skb->len + sizeof(hdr));
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	hdr.iph.saddr = 0x640510ac;  /* 172.16.5.100  */
+	hdr.iph.daddr = 0x641110ac;  /* 172.16.17.100 */
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	hdr.iph.saddr = 0xac100564;  /* 172.16.5.100 */
+	hdr.iph.daddr = 0xac101164;  /* 172.16.17.100 */
+#else
+#error "Fix your compiler's __BYTE_ORDER__?!"
+#endif
+
+	hdr.udph.source = bpf_htons(VXLAN_PORT);
+	hdr.udph.dest   = bpf_htons(VXLAN_PORT);
+	hdr.udph.len    = bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.vxh) +
+				    sizeof(hdr.eth));
+
+	hdr.vxh.vx_flags = bpf_htonl(VXLAN_FLAGS);
+	hdr.vxh.vx_vni   = bpf_htonl(VXLAN_VNI << 8);
+
+	__builtin_memcpy(hdr.eth.h_dest, bcast, ETH_ALEN);
+	__builtin_memcpy(hdr.eth.h_source, srcmac, ETH_ALEN);
+	hdr.eth.h_proto = bpf_htons(ETH_P_IP);
+
+	err = bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr, sizeof(hdr));
+	if (err)
+		return BPF_DROP;
+
+	return BPF_LWT_REROUTE;
+}
+
+SEC("encap_vxlan6")
+int bpf_lwt_encap_vxlan6(struct __sk_buff *skb)
+{
+	struct encap_hdr {
+		struct ipv6hdr  ip6hdr;
+		struct udphdr   udph;
+		struct vxlanhdr vxh;
+		struct ethhdr   eth;
+	} __attribute__((__packed__)) hdr;
+	int err;
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	hdr.ip6hdr.version     = 6;
+	hdr.ip6hdr.nexthdr     = 17; /* IPPROTO_UDP */
+	hdr.ip6hdr.hop_limit   = 0x40;
+	hdr.ip6hdr.payload_len = bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.vxh) +
+					   sizeof(hdr.eth));
+	/* fb05::1 */
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[0]  = 0xfb;
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[1]  = 0x05;
+	hdr.ip6hdr.saddr.in6_u.u6_addr8[15] = 1;
+	/* fb11::1 */
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[0]  = 0xfb;
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[1]  = 0x11;
+	hdr.ip6hdr.daddr.in6_u.u6_addr8[15] = 1;
+
+	hdr.udph.source = bpf_htons(VXLAN_PORT);
+	hdr.udph.dest   = bpf_htons(VXLAN_PORT);
+	hdr.udph.len    = bpf_htons(skb->len + sizeof(hdr.udph) + sizeof(hdr.vxh) +
+				    sizeof(hdr.eth));
+
+	hdr.vxh.vx_flags = bpf_htonl(VXLAN_FLAGS);
+	hdr.vxh.vx_vni   = bpf_htonl(VXLAN_VNI << 8);
+
+	__builtin_memcpy(hdr.eth.h_dest, bcast, ETH_ALEN);
+	__builtin_memcpy(hdr.eth.h_source, srcmac, ETH_ALEN);
+	hdr.eth.h_proto = bpf_htons(ETH_P_IPV6);
+
+	err = bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr, sizeof(hdr));
+	if (err)
+		return BPF_DROP;
+
+	return BPF_LWT_REROUTE;
+}
+
+volatile const int tgt_ip_version;
+
+__u16 transport_hdr = 0;
+__u16 network_hdr = 0;
+bool fexit_triggered = false;
+
+SEC("?fexit/bpf_lwt_push_ip_encap")
+int BPF_PROG(fexit_lwt_push_ip_encap, struct sk_buff *skb, void *hdr, u32 len, bool ingress,
+	     int retval)
+{
+	struct iphdr *iph;
+
+	if (retval || fexit_triggered)
+		return 0;
+
+	iph = (typeof(iph)) (skb->head + skb->network_header);
+	if (iph->version != tgt_ip_version)
+		return 0;
+
+	if ((iph->version == 4 && iph->protocol == 17 /* IPPROTO_UDP */) ||
+	    (iph->version == 6 && ((struct ipv6hdr *)iph)->nexthdr == 17 /* IPPROTO_UDP */)) {
+		fexit_triggered = true;
+		transport_hdr   = skb->transport_header;
+		network_hdr     = skb->network_header;
+	}
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0


