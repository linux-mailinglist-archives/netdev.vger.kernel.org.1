Return-Path: <netdev+bounces-291338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEJ3GNdcFGqPMwcAu9opvQ
	(envelope-from <netdev+bounces-291338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0555CBBBA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729A03037DD3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD563EDABA;
	Mon, 25 May 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O9rCkwU3"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103E3ED127;
	Mon, 25 May 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719268; cv=none; b=RnA5tRPMAlTiE3//uTroXnhcZda6irO6nrA3m+Ql5mY0sh653YHCdXIb6xbDgN8kmqC675VrMVXU5ho7aFznyTJapOpUXwTBwq6gSy5Vb9k+0gjKPHiXpSC+V6ppJ8B1EEKpoocsQ3as/merINC1yYlZBzlGlWFecC2+0o8OOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719268; c=relaxed/simple;
	bh=nRT9V/DsnVxNYDdUWYyDZDu/FHB0PQ+e4HHWIqsAGe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdk17yB7BhgyQ+6e001hrLO41oKreyJUwEQR3GDAbvihnSZ9Tf5R41qEqjPbT5l4h73Ua8+clGPFIiffr+sesFx8cAkzedcfeHchQ/VxlYHXL+dZGmSGj7SpSFPLXi1cdOM0yPNY+cC9X8Ux6FwoiURfOGBWhK+Bzan8Y9gxKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9rCkwU3; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779719263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRoVe+qJMM4Pt+pMhrRaXPRHtqG635B7U5kU89n5zho=;
	b=O9rCkwU3oE6dk3Ud2VOZzWkwR8LzunmTgUR6ryC2Mvuj6HPbaMj/PgtdR4DdrFvlcL8v6N
	d9DGMfQ7AjYQYZPK0SJjMhleCcq+NHIj9Q+2TQbw5uqjtYkwOsh8InOWLvSMwHwk1BjDHp
	uV8BV/waLqaUUdVf71bMBZjZpzWCsDw=
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
Subject: [PATCH bpf 2/2] selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt
Date: Mon, 25 May 2026 22:26:50 +0800
Message-ID: <20260525142650.2569-3-leon.hwang@linux.dev>
In-Reply-To: <20260525142650.2569-1-leon.hwang@linux.dev>
References: <20260525142650.2569-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291338-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC0555CBBBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add two tests to verify the transport header of skb has been set when
encapsulating VxLAN using bpf_lwt_push_encap() helper.

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
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 153 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 112 +++++++++++++
 .../bpf/progs/test_lwt_ip_encap_fix.c         |  36 +++++
 3 files changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index b6391af5f6f9..04fc35470f21 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <netinet/in.h>
 
 #include "network_helpers.h"
 #include "test_progs.h"
+#include "test_lwt_ip_encap_fix.skel.h"
 
 #define BPF_FILE "test_lwt_ip_encap.bpf.o"
 
@@ -35,6 +38,10 @@
 #define IP6_ADDR_SRC IP6_ADDR_1
 #define IP6_ADDR_DST IP6_ADDR_4
 
+/* VxLAN tunnel endpoints, reachable via the bottom route (veth5/6/7/8). */
+#define IP4_ADDR_VXLAN  "172.16.17.100"
+#define IP6_ADDR_VXLAN  "fb20::1"
+
 /* Setup/topology:
  *
  *    NS1             NS2             NS3
@@ -538,3 +545,149 @@ void test_lwt_ip_encap_ipv4(void)
 	if (test__start_subtest("ingress"))
 		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
 }
+
+/* VxLAN Setup/topology:
+ *
+ * NS1 (IP*_ADDR_1)                NS2                  NS3 (IP*_ADDR_4)
+ *       [ping src]
+ *           |                          top route
+ *         veth1 (LWT encap)  <<-- veth2        veth3  -X-  veth4 (ping dst)
+ *           |                                                ^
+ *       (bottom route)                                       | (inner pkt)
+ *           v                        bottom route            |
+ *         veth5              -->> veth6        veth7  -->> veth8 (vxlan decap)
+ *                                                          (IP*_ADDR_VXLAN)
+ *
+ * Add the VxLAN endpoint addresses to NS3's veth8, create standard
+ * VxLAN decap devices bound to those addresses, and install routes so
+ * NS1/NS2 can reach the endpoints via the bottom route.
+ */
+static int setup_vxlan_routes(const char *ns3, const char *ns1, const char *ns2,
+			      const char *vrf)
+{
+	struct nstoken *nstoken;
+
+	nstoken = open_netns(ns3);
+	if (!ASSERT_OK_PTR(nstoken, "open ns3 for vxlan"))
+		return -1;
+
+	SYS(fail_close, "ip    a add %s/32  dev veth8", IP4_ADDR_VXLAN);
+	SYS(fail_close, "ip -6 a add %s/128 dev veth8", IP6_ADDR_VXLAN);
+	/* Standard VxLAN devices to decap the encapsulated packets.  The inner
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
+	SYS(fail, "ip -n %s    route add %s/32  dev veth5 via %s %s",
+	    ns1, IP4_ADDR_VXLAN, IP4_ADDR_6, vrf);
+	SYS(fail, "ip -n %s    route add %s/32  dev veth7 via %s %s",
+	    ns2, IP4_ADDR_VXLAN, IP4_ADDR_8, vrf);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth5 via %s %s",
+	    ns1, IP6_ADDR_VXLAN, IP6_ADDR_6, vrf);
+	SYS(fail, "ip -n %s -6 route add %s/128 dev veth7 via %s %s",
+	    ns2, IP6_ADDR_VXLAN, IP6_ADDR_8, vrf);
+	return 0;
+
+fail_close:
+	close_netns(nstoken);
+fail:
+	return -1;
+}
+
+/* VxLAN encap tests (IPv4-outer and IPv6-outer variants).
+ *
+ * Test 1 - functional: the BPF LWT xmit program encapsulates the packet
+ *   (protocol=UDP, port=4789) and re-routes it without dropping it.
+ *   Verified by ping success.
+ *
+ * Test 2 - fix verification: after bpf_lwt_push_ip_encap() the
+ *   skb->transport_header must point at the outer UDP header, i.e.
+ *   transport_header - network_header == sizeof(outer IP header).
+ *   Without the fix the transport_header still points at the inner
+ *   transport layer, giving a wrong (larger) offset.
+ */
+static void lwt_ip_encap_vxlan(bool ipv4_encap)
+{
+	char ns1[NETNS_NAME_SIZE] = NETNS_BASE "-1-";
+	char ns2[NETNS_NAME_SIZE] = NETNS_BASE "-2-";
+	char ns3[NETNS_NAME_SIZE] = NETNS_BASE "-3-";
+	const char *sec = ipv4_encap ? "encap_vxlan" : "encap_vxlan6";
+	int expected_offset = ipv4_encap ? (int)sizeof(struct iphdr)
+					 : (int)sizeof(struct ipv6hdr);
+	struct test_lwt_ip_encap_fix *skel = NULL;
+	int thdr_offset;
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
+	if (!ASSERT_OK(setup_vxlan_routes(ns3, ns1, ns2, ""), "setup vxlan routes"))
+		goto out;
+
+	/* Attach fexit to bpf_lwt_push_ip_encap() before installing the
+	 * LWT route so we don't miss the first encap call.
+	 */
+	skel = test_lwt_ip_encap_fix__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_lwt_ip_encap_fix__open_and_load"))
+		goto out;
+
+	if (!ASSERT_OK(test_lwt_ip_encap_fix__attach(skel), "test_lwt_ip_encap_fix__attach"))
+		goto out;
+
+	/* Remove the direct NS2->DST route so packets must go via LWT encap. */
+	SYS(out, "ip -n %s    route del %s/32  dev veth3", ns2, IP4_ADDR_DST);
+	SYS(out, "ip -n %s -6 route del %s/128 dev veth3", ns2, IP6_ADDR_DST);
+
+	/* Install the VxLAN BPF LWT xmit route. */
+	if (ipv4_encap)
+		SYS(out, "ip -n %s route add %s encap bpf xmit obj %s sec %s dev veth1",
+		    ns1, IP4_ADDR_DST, BPF_FILE, sec);
+	else
+		SYS(out, "ip -n %s -6 route add %s encap bpf xmit obj %s sec %s dev veth1",
+		    ns1, IP6_ADDR_DST, BPF_FILE, sec);
+
+	skel->bss->fexit_triggered = false;
+	if (ipv4_encap)
+		SYS(out, "ip netns exec %s ping  -c 1 -W1 %s", ns1, IP4_ADDR_DST);
+	else
+		SYS(out, "ip netns exec %s ping6 -c 1 -W1 %s", ns1, IP6_ADDR_DST);
+
+	/* Test 1: fexit triggered means bpf_lwt_push_ip_encap() succeeded. */
+	if (!ASSERT_TRUE(skel->bss->fexit_triggered, "fexit_triggered"))
+		goto out;
+
+	/* Test 2: transport_header must sit immediately after the outer IP
+	 * header, pointing at the UDP header of the VxLAN encap.
+	 */
+	thdr_offset = (int)skel->bss->transport_hdr - (int)skel->bss->network_hdr;
+	ASSERT_EQ(thdr_offset, expected_offset, "transport_hdr offset");
+
+out:
+	test_lwt_ip_encap_fix__destroy(skel);
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
index d6cb986e7533..36f0fc682ffb 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
@@ -2,8 +2,10 @@
 #include <stddef.h>
 #include <string.h>
 #include <linux/bpf.h>
+#include <linux/if_ether.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
@@ -82,4 +84,114 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	return BPF_LWT_REROUTE;
 }
 
+struct vxlanhdr {
+	__be32 vx_flags;  /* I flag = 0x08000000 (valid VNI) */
+	__be32 vx_vni;    /* VNI in top 24 bits */
+};
+
+#define VXLAN_PORT  4789
+#define VXLAN_FLAGS 0x08000000
+#define VXLAN_VNI   1
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
+	} __attribute__((__packed__)) /* packed is required to avoid padding */ hdr;
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
+	} __attribute__((__packed__)) /* packed is required to avoid padding */ hdr;
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
+	hdr.ip6hdr.saddr.s6_addr[0]  = 0xfb;
+	hdr.ip6hdr.saddr.s6_addr[1]  = 0x05;
+	hdr.ip6hdr.saddr.s6_addr[15] = 1;
+	/* fb20::1 */
+	hdr.ip6hdr.daddr.s6_addr[0]  = 0xfb;
+	hdr.ip6hdr.daddr.s6_addr[1]  = 0x20;
+	hdr.ip6hdr.daddr.s6_addr[15] = 1;
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
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
new file mode 100644
index 000000000000..e9043fe654eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fexit on bpf_lwt_push_ip_encap() to verify skb->transport_header is
+ * correctly updated when a UDP-based tunnel (e.g. VxLAN) is pushed.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+/* Written by fexit, read by the user-space test via skeleton BSS. */
+__u16 transport_hdr = 0;
+__u16 network_hdr = 0;
+bool fexit_triggered = false;
+
+/*
+ * bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
+ *
+ * After a successful push the transport_header must point at the outer
+ * transport header (UDP for VxLAN), i.e.
+ *   transport_header - network_header == sizeof(outer IP header)
+ */
+SEC("fexit/bpf_lwt_push_ip_encap")
+int BPF_PROG(fexit_lwt_push_ip_encap, struct sk_buff *skb, void *hdr, u32 len, bool ingress,
+	     int retval)
+{
+	if (retval || fexit_triggered)
+		return 0;
+
+	fexit_triggered = true;
+	transport_hdr = BPF_CORE_READ(skb, transport_header);
+	network_hdr   = BPF_CORE_READ(skb, network_header);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0


