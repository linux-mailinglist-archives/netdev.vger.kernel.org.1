Return-Path: <netdev+bounces-204949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72FAFCA7D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31D016F31B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240B2DC33D;
	Tue,  8 Jul 2025 12:34:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F42DBF46
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978089; cv=none; b=sNZjn0jVSYQOqxIuUNiDV5/+WbSpom9wc/mwBaWCZaMoO96M8HDgywWIYuYs6v3nqmrSoYiPB970T8ceHZYNyXTiQqGwvTzZZe9S7BvcLV8DyVKsgmPRKitgpqg6vxLigMQ0a7fTDlwtNOw0MYTD91mUoYsmU87bXkM0NV0vE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978089; c=relaxed/simple;
	bh=ies18x09tANAsjRXyxb7KDlpnT/JI8EFYzkRe9/K6gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KH9PPnx+P9u8J5AWC13uSYcM/hn8CdGlo5HrPyxV6Zhkv25hIWEbPsHGlN41o28oLH57FgjyqdXoDfjzzEKHzaflgg9g177XJELYP8XFNaABxCDv7I8JFFgRI+RIFvTXrRPsWLzfkO/gsuMnZ6oD4QTRV5pjjEOl7kukDS70q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1751977987t722b6bfc
X-QQ-Originating-IP: 7Fg8pQxoEyXo2Eaj55VCJRBXwUHiKEJjMIRoX24HtEo=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 20:33:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5867798305354333178
EX-QQ-RecipientCnt: 12
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
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next RESEND] net: bonding: add bond_is_icmpv6_nd() helper
Date: Tue,  8 Jul 2025 20:32:51 +0800
Message-Id: <20250708123251.2475-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NWth7vBa++Gddime9RlqWhBTbsbByT5BDUGRE8j0RZH/ZvlFC3kl9DYO
	nSjBnRj+OhgKBlGAkI8HliERIjU89niwJwVBObZ38Np/+MDHi2FsPZP4+gz9mPAat+1kBLG
	aY88n+f/c+y55gtIWUNrFfIJ38GM5NhtMEx1ziEdbfEh1GrxsvqybNDxMHYawrPo4UZu4DQ
	kDKHeNi2vByK+sDR4NDPzAMOpIUi7XkBx61f58CnYfezjSvj2M7/N4jxjJvIC3rEznZbAUM
	pTRMhGEc+/8N55OnXmdcRlYszdGxNY845S/iDUKCUBgM9+GFho2ou+/vI1cLTzVQeawAzmQ
	zglq/jxkwCihBlXHZhihf1ziUN4TlejiYgx291N4FB2aJ9dJq6+nJ8UinFGyVFVd5S3AQ15
	Tz7UKR2p4XOZIMvNmqq/ATCz6Ow7VNUsoUQCrQimF3LMO09zzF2ohP6ISR821jRZLEtfQby
	PtmmHqsG+F2ENKKZTNztQTfRnu8vidsJuiYh4z1GTkufMc4IsjZY9k3rIabTClzS97v/51b
	v2D8XiGP1BpMssZ/gu6hCs9efb2OjX+7iRAx8KWVJ3PRy/rbHW0uSeqGPYEuNk03nlSEalF
	pvpA+MPRxyAgNtp1o3fFJ0apgfhILprcIkWrnXY+8l77c16pIyS31cTxJwITocRiDN1IrwG
	CEBzNYGTmRecDfKQN1I4Wbg9Qh/GQiNrZZIRZ5tIMpRiIv102Tq+cYZCEaTjztfS1ARXs5o
	RkRGKSTi2i6apSsX2sy94Q0L4oLrY1R+2g2sXAvhXMxYp/m6u8Ls+idA3Mg3qXAaTAqSD2Q
	erScgtvntFHBOf4wr+7vFjygcfpj5KLfYR3CxLYXXwH1CtJOIkJm/os0VrJB9U/nen6u5pe
	LZcJH9Ri6t+rnXjBQA4uV3HPsSyaTxno5uJDSlA0VIT8AcZOOLy7qQ+dyNQnjc2RnKLNzRk
	g/rUbyoLcntMkMpJktv8VZR1YgmwAvbawkmAZ5VlIrl5eUGe7kur638+I
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
 drivers/net/bonding/bond_alb.c  | 32 +++++++-------------------------
 drivers/net/bonding/bond_main.c | 17 ++---------------
 include/net/bonding.h           | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 2d37b07c8215..8e5b9ce52077 100644
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
@@ -1467,16 +1445,20 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 			break;
 		}
 
-		if (alb_determine_nd(skb, bond)) {
+		if (bond_is_icmpv6_nd(skb)) {
 			do_tx_balance = false;
 			break;
 		}
 
-		/* The IPv6 header is pulled by alb_determine_nd */
 		/* Additionally, DAD probes should not be tx-balanced as that
 		 * will lead to false positives for duplicate addresses and
 		 * prevent address configuration from working.
 		 */
+		if (!pskb_network_may_pull(skb, sizeof(*ip6hdr))) {
+			do_tx_balance = false;
+			break;
+		}
+
 		ip6hdr = ipv6_hdr(skb);
 		if (ipv6_addr_any(&ip6hdr->saddr)) {
 			do_tx_balance = false;
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


