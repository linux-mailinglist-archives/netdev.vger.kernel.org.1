Return-Path: <netdev+bounces-205723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E44AFFDBA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EDF1C286C4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8829345A;
	Thu, 10 Jul 2025 09:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFF291C0C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139017; cv=none; b=NJl69FB7nZee8uNix0HsDdJJV2fX89gmmbI1rvwdFhqnlcfjvu1DPrlGhn6GAxv9IMm7LkNczM/i6EdccwZ7ppHKPmPNaN1YMwNZiqDntv/cQdmY6apowBPUdzGFtoWGMgc/JtZhvNEKPQzBv9bW9tfoGuUscsNCDL/Iv5bK/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139017; c=relaxed/simple;
	bh=V2tnCgton6vhbha+oB659CttOmTMNOA7kAd1TAYVH78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyLNV70ckD1K2bgcV30YWSL/Xub1Pj4WvmHsqz7wYq3JMFxy5yk03JiFbakhgVB3yf/y0BHhNAuiq9+XWRQxbwxmsSyjIlpuA5PgGhJwUhhpMoldDEsutmbAmhv0XHhjkYui+nllqS8ED68lRJ0ktExcQgoHV56EdB4E+VU9/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz5t1752139000t9a151c77
X-QQ-Originating-IP: Gyq3JCsHsLJ67MvX490jXv9+ab2cpy8aaq4u00mqKtM=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 17:16:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14324904729782450806
EX-QQ-RecipientCnt: 13
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v2] net: bonding: add bond_is_icmpv6_nd() helper
Date: Thu, 10 Jul 2025 17:16:36 +0800
Message-Id: <20250710091636.90641-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NkLA2q2LD229CnhIJ/JwTKaxLt8nAebDuo5Qlvii5r4qR+/OLM97X6Nz
	U07INZDKEvgpiRRhwmqmrTyfid++O9tEuZexg4Kc9AbvlBgRkwbSC1m1Mpbaq/G+I6Zj33j
	szE3pnbAr6zmYMXGOtet/YWGrVfc7WTxlEMu2fowFi7I31aG9+PiA5pKAYG73Zxmq76dwNx
	HeZyoFCpy97EftnllzzigTQyCkuINJoUAHyreiyLnFtcmzuTI10J0/WeNHqfp5pIJPONPaO
	Bc5pGlCg1VqZSrc5lHWDULYsvuPGvX4JwqdnxmB/waoX2CWh4VK0uweqXBMqrN2K05fvfM+
	m2uVGaUMBMgjOAN3VCl1yjrLsHgiaTUH/aaCAKDtxqdzR1QZJcrt9vHOz5O+mff3r4f8pVs
	8PoxRoiVxfh49qH8+hXVQx9kCiXQoEQydBF886no0E4C2t8DaMBEOqHN+c9n5AT1UInqhl6
	Ccc5v62N0efJnycJRvzX62y8yimLwIwHfyP5nhUAleBMRb/FKijwK9Futy96ECe6wOtvNw2
	DG5NBkhYQOSZgRjh8NhEzLjKLDIbDvYLGL+6DZmuQftOkwiH07ayrjWc6f2GPm3fV3bOWpQ
	0TkhaFk4cW1JPLRpNPxvxJbGLNqDz5+C5Jz7Kx43gepSsGeMur1t9R68xI94OaXnTB2FF0u
	LFABXWlkdPjAyOAYvv8xtla/es/LX3LSMY2Cxadaao67leHwAsVGpHgtJEgipM7rw4kv0zp
	4g0XkF08Id3XLOm7WDFoxlPOnwKl22toaV9L4msxLeFJtC1khQvrO137J95u5JnowVh+U8o
	rgyTjo3BlVeu3ELmSxkizxqdVCfrqd1WPAslQVccPDvbV0lJ+7dnfajSDm3Usa007LWGlGe
	mm27nOmYyAAQI8FAdEGqDjX/f7f4OgC+Dev93gUO8PbLE8urNRLI/LmysLXx9aBoDi0J8Eu
	fqQRhEIdDG3F4evJmPuFkhkozSyb9h/5qJ0TsSZHdfR3Eb8HhJ+7jlnhWl4j9bh9pCDU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
instead of pskb_network_may_pull() on tx path.

alb_determine_nd introduced from commit 0da8aa00bfcfe

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
v2:
- in alb mode, replace bond_is_icmpv6_nd with skb_header_pointer directly,
- and then reuse its returned data for the hash computation.

v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20250708123251.2475-1-tonghao@bamaicloud.com/
---
 drivers/net/bonding/bond_alb.c  | 47 +++++++++++----------------------
 drivers/net/bonding/bond_main.c | 17 ++----------
 include/net/bonding.h           | 19 +++++++++++++
 3 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 2d37b07c8215..a37709fd7475 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -19,7 +19,6 @@
 #include <linux/in.h>
 #include <net/arp.h>
 #include <net/ipv6.h>
-#include <net/ndisc.h>
 #include <asm/byteorder.h>
 #include <net/bonding.h>
 #include <net/bond_alb.h>
@@ -1280,27 +1279,6 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
 	return res;
 }
 
-/* determine if the packet is NA or NS */
-static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
-{
-	struct ipv6hdr *ip6hdr;
-	struct icmp6hdr *hdr;
-
-	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
-		return true;
-
-	ip6hdr = ipv6_hdr(skb);
-	if (ip6hdr->nexthdr != IPPROTO_ICMPV6)
-		return false;
-
-	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
-		return true;
-
-	hdr = icmp6_hdr(skb);
-	return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
-		hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
-}
-
 /************************ exported alb functions ************************/
 
 int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
@@ -1381,7 +1359,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IPV6):
-			if (alb_determine_nd(skb, bond))
+			if (bond_is_icmpv6_nd(skb))
 				break;
 			fallthrough;
 		case htons(ETH_P_IP):
@@ -1426,6 +1404,10 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 	struct ethhdr *eth_data;
 	u32 hash_index = 0;
 	int hash_size = 0;
+	struct {
+		struct ipv6hdr ip6;
+		struct icmp6hdr icmp6;
+	} *combined, _combined;
 
 	skb_reset_mac_header(skb);
 	eth_data = eth_hdr(skb);
@@ -1449,8 +1431,6 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 		break;
 	}
 	case ETH_P_IPV6: {
-		const struct ipv6hdr *ip6hdr;
-
 		/* IPv6 doesn't really use broadcast mac address, but leave
 		 * that here just in case.
 		 */
@@ -1467,24 +1447,29 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 			break;
 		}
 
-		if (alb_determine_nd(skb, bond)) {
+		/* Do not tx balance any IPv6 NS/NA packets. */
+		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
+					      sizeof(_combined), &_combined);
+		if (!combined || (combined->ip6.nexthdr == NEXTHDR_ICMP &&
+				  (combined->icmp6.icmp6_type ==
+					   NDISC_NEIGHBOUR_SOLICITATION ||
+				   combined->icmp6.icmp6_type ==
+					   NDISC_NEIGHBOUR_ADVERTISEMENT))) {
 			do_tx_balance = false;
 			break;
 		}
 
-		/* The IPv6 header is pulled by alb_determine_nd */
 		/* Additionally, DAD probes should not be tx-balanced as that
 		 * will lead to false positives for duplicate addresses and
 		 * prevent address configuration from working.
 		 */
-		ip6hdr = ipv6_hdr(skb);
-		if (ipv6_addr_any(&ip6hdr->saddr)) {
+		if (ipv6_addr_any(&combined->ip6.saddr)) {
 			do_tx_balance = false;
 			break;
 		}
 
-		hash_start = (char *)&ip6hdr->daddr;
-		hash_size = sizeof(ip6hdr->daddr);
+		hash_start = (char *)&combined->ip6.daddr;
+		hash_size = sizeof(combined->ip6.daddr);
 		break;
 	}
 	case ETH_P_ARP:
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17c7542be6a5..a8034a561011 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5338,10 +5338,6 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 					   struct net_device *dev)
 {
 	struct bonding *bond = netdev_priv(dev);
-	struct {
-		struct ipv6hdr ip6;
-		struct icmp6hdr icmp6;
-	} *combined, _combined;
 
 	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
 		return false;
@@ -5349,19 +5345,10 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 	if (!bond->params.broadcast_neighbor)
 		return false;
 
-	if (skb->protocol == htons(ETH_P_ARP))
+	if (skb->protocol == htons(ETH_P_ARP) ||
+	    (skb->protocol == htons(ETH_P_IPV6) && bond_is_icmpv6_nd(skb)))
 		return true;
 
-	if (skb->protocol == htons(ETH_P_IPV6)) {
-		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
-					      sizeof(_combined),
-					      &_combined);
-		if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
-		    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
-		     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
-			return true;
-	}
-
 	return false;
 }
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..32d9fcca858c 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -29,6 +29,7 @@
 #include <net/bond_options.h>
 #include <net/ipv6.h>
 #include <net/addrconf.h>
+#include <net/ndisc.h>
 
 #define BOND_MAX_ARP_TARGETS	16
 #define BOND_MAX_NS_TARGETS	BOND_MAX_ARP_TARGETS
@@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
+{
+	struct {
+		struct ipv6hdr ip6;
+		struct icmp6hdr icmp6;
+	} *combined, _combined;
+
+	combined = skb_header_pointer(skb, skb_mac_header_len(skb),
+				      sizeof(_combined),
+				      &_combined);
+	if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
+	    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
+	     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
+		return true;
+
+	return false;
+}
+
 #endif /* _NET_BONDING_H */
-- 
2.34.1


