Return-Path: <netdev+bounces-192615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB154AC0818
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D089E3751
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC75286893;
	Thu, 22 May 2025 08:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D12857FB
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904320; cv=none; b=sMZrpAVooVQBULEIPb3hGHUynf7MFJ62Pe6H6BD5Oy9VPkut3bUQD5jVkfqWxnQe8K0nqWHHdzJRqaKgTbkzE3LFaGwausOaeXdO6QJZW188ivXO4VjdbzDbFdG+bPuwdDthzrf/YwDNMoRIBMtEPvm4TAthH15o5pAtZm73UZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904320; c=relaxed/simple;
	bh=D++HUoGf+vJruVD7tStBvlSRU0YM+1KP7cStULiJfA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DkdKHTW5Uhmk/diH6p5f/VlLxBMzz//U9AKCV03t3zPrn1azlgtdvBdd+9uhwc8OMd3Os0c3e+eZKGvQm6xeQBwhTv5DbW7ziiBct6GBUuCWhhWz5Nyn9WLt3ZtVIQhMdxTLyqkN0Yf0ODbDxCCyinCjgwkn0NBNY8skIx0vKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1747904227t32f739ae
X-QQ-Originating-IP: tUHh4PhqS9RwoC4K++3lZpJ8ChXSDqbow6Yz8nC0TGk=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 16:57:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 119096427622245062
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
Subject: [PATCH net-next v1 1/1] net: bonding: add bond_is_icmpv6_nd() helper
Date: Thu, 22 May 2025 16:57:03 +0800
Message-Id: <20250522085703.16475-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MTR5disOECbFiDPQ1Kz9kpLn5ZSyMMepcQXNIYKTz08YPI8p+TBiBZyy
	ERk1ntpe6HxcMxcrLv/aRadOTQKzsbmYx2sOucVT1USe9V9aLNF3mU7cGO3vgGDeUP9FQi4
	kx2sOlWKKGT2XFzJLo6vg+R3SG077zMFAIxO6XX5ceXJQe0OCIcvd68V19FYE20fbOWq9ds
	8UgbkkF8JmY0/SRn0C47PVOfe54MgxxWGh8Y+74e8LeWCz+C51qK+4iizklwSO29Ow2rROq
	Kn82/hSE2ifqjy0/5yYBNc50l4BWQTzFPT1anXtG2VHv5FddRP4pjXHxLwRbYgpYHEMnVcv
	Z8JU4iTfU2GB6y3HEfe9knrlxJpVtieR3z/5rHS4oQ85KDHGfgMr0WE8iVAQxgImZsYiG/m
	ggh6XvZL9j0z7byefOdx0Mg6L9FjBQW5Z7MINjmLZsbHNSC/0iIR6scYG0flfRYeoLSzq4q
	1u8CQOunyi8atcOih8nCk+BOh6IpxwuPftEEd9hYrV+mlj+CPg+jYXKCQPKLHrvXMBhJCPo
	e9EzVi8/5R0I9r8q2gLH7WbYCDuBLBjBGBe9U04BBkrGcLRqVZlsHqgt13OSlssAeSyc12K
	ySwNqY5UUXmeCGpP1xTeRgem6s0C4R1n630P9tMrdyz/lcdorK/P79vHmx5q6au9GxyEL64
	Ut8YhoH0ZqizENlvT1tgVfgQjZJayCrLneaV3fbCvg6eIcvpoPl57eppjUesgKcfMX8tugZ
	nIypXG/zc1rn6ssnzu3PCiE94xWIaldESTYPvr9gyG55vMtxmdrnoNrYa27qSO9PPLNK2XR
	I8QIN85qTP05CQcIOfUrvkBrJC1jJB3ipFhQ2l+SBFqzuTpoVFCWU+0Ad8RWH9IIgSUScFe
	lx/vCeG+KwdNMttpUofj3X+gP+evtSd0nCHrp9x+zZc1ehsrs4+vw3RKncOQEjPrlk7rYmW
	h6p7Gd8ydV+TZ4ooh6O2/8LZxRSo67VV/kppJzl+u3aZXuMTIymqLfu6bFdh5VIKmJCKnS0
	J7xlM6bl2cnpm4CvBp/hZFHk8wVIAE/DO40htKUQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index 7edf0fd58c34..beb80c487a29 100644
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
@@ -1281,27 +1280,6 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
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
@@ -1382,7 +1360,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IPV6):
-			if (alb_determine_nd(skb, bond))
+			if (bond_is_icmpv6_nd(skb))
 				break;
 			fallthrough;
 		case htons(ETH_P_IP):
@@ -1468,16 +1446,20 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
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
index 7f03ca9bcbba..b3f0ac8e0720 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5340,10 +5340,6 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 					   struct net_device *dev)
 {
 	struct bonding *bond = netdev_priv(dev);
-	struct {
-		struct ipv6hdr ip6;
-		struct icmp6hdr icmp6;
-	} *combined, _combined;
 
 	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
 		return false;
@@ -5351,19 +5347,10 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
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


