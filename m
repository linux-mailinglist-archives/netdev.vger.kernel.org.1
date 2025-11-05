Return-Path: <netdev+bounces-235853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC52C36D85
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AD65680DB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664F336ECA;
	Wed,  5 Nov 2025 16:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4603314C4;
	Wed,  5 Nov 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358885; cv=none; b=DnkRQMpAjaj7HUXiXNluqV4R7ktmRQFIIT1xk75udKB0XGMz3lxn8sGkMH+JUVcnVwYDYoP4KgCCsvkbuGQqbVyAjIDISf0b/YxvxeEbE9fRDeEqw9VWFL0uE4C1+cekq4WnzdhMWCGxbvEmANYuSEnBQ4zf9xiPqjdQNagge+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358885; c=relaxed/simple;
	bh=u9YpyQlwindyhEri1ZWLiSQPKv7WiPv8mZHXYF/4aEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Txs6qzEGkYXQjXFBps/+Hm0ML3nbCnqPkuAlboRspNQo/X8aGK8H5lw9yA29ARKifnUX5+oDWWjXnhl7nKPuGEXKv6YUGmsgm78MbmM2P+yh6vvU8Gl27AXEQnTkFTIoWEzAHDh+bkxgg2r4HKw3h0k5voauQcpIRGrQBPVDYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1qwW6sdczJ46Dg;
	Thu,  6 Nov 2025 00:07:39 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DF751400DB;
	Thu,  6 Nov 2025 00:08:01 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:08:00 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 07/14] ipvlan: Support IPv6 for learnable l2-bridge
Date: Wed, 5 Nov 2025 19:07:11 +0300
Message-ID: <20251105160713.1727206-8-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
References: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

To make IPv6 work with learnable l2-bridge, need to
process the TX-path:
* Replace Source-ll-addr in Solicitation ndisc,
* Replace Target-ll-addr in Advertisement ndisc

No need to do anything in RX-path

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 129 +++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 547016e3ca8c..659aed8fc4ff 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -4,6 +4,7 @@
 
 #include <net/flow.h>
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 
 #include "ipvlan.h"
 
@@ -769,13 +770,122 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 	return ipvlan_process_outbound(skb);
 }
 
+static void ipvlan_macnat_patch_tx_arp(struct ipvl_dev *ipvlan,
+				       struct sk_buff *skb)
+{
+	struct arphdr *arph;
+	int addr_type;
+
+	arph = (struct arphdr *)ipvlan_get_L3_hdr(ipvlan->port, skb,
+						 &addr_type);
+	ether_addr_copy((u8 *)(arph + 1), ipvlan->phy_dev->dev_addr);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+static u8 *ipvlan_search_icmp6_ll_addr(struct sk_buff *skb, u8 icmp_option)
+{
+	/* skb is ensured to pullable for all ipv6 payload_len by caller */
+	struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	struct icmp6hdr *icmph;
+	int ndsize, curr_off;
+
+	icmph = (struct icmp6hdr *)(ip6h + 1);
+	ndsize = (int)htons(ip6h->payload_len);
+	curr_off = sizeof(*icmph);
+
+	if (icmph->icmp6_type != NDISC_ROUTER_SOLICITATION)
+		curr_off += sizeof(struct in6_addr);
+
+	while ((curr_off + 2) < ndsize) {
+		u8  *data = (u8 *)icmph + curr_off;
+		u32 opt_len = data[1] << 3;
+
+		if (unlikely(opt_len == 0))
+			return NULL;
+
+		if (data[0] != icmp_option) {
+			curr_off += opt_len;
+			continue;
+		}
+
+		if (unlikely(opt_len < ETH_ALEN + 2))
+			return NULL;
+
+		if (unlikely(curr_off + opt_len > ndsize))
+			return NULL;
+
+		return data + 2;
+	}
+
+	return NULL;
+}
+
+static void ipvlan_macnat_patch_tx_ipv6(struct ipvl_dev *ipvlan,
+					struct sk_buff *skb)
+{
+	struct ipv6hdr *ip6h;
+	struct icmp6hdr *icmph;
+	u8 icmp_option;
+	u8 *lladdr;
+	u16 ndsize;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
+		return;
+
+	if (ipv6_hdr(skb)->nexthdr != NEXTHDR_ICMP)
+		return;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h) + sizeof(*icmph))))
+		return;
+
+	ip6h = ipv6_hdr(skb);
+	icmph = (struct icmp6hdr *)(ip6h + 1);
+
+	/* Patch Source-LL for solicitation, Target-LL for advertisement */
+	if (icmph->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
+	    icmph->icmp6_type == NDISC_ROUTER_SOLICITATION)
+		icmp_option = ND_OPT_SOURCE_LL_ADDR;
+	else if (icmph->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT)
+		icmp_option = ND_OPT_TARGET_LL_ADDR;
+	else
+		return;
+
+	ndsize = (int)htons(ip6h->payload_len);
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h) + ndsize)))
+		return;
+
+	lladdr = ipvlan_search_icmp6_ll_addr(skb, icmp_option);
+	if (!lladdr)
+		return;
+
+	ether_addr_copy(lladdr, ipvlan->phy_dev->dev_addr);
+
+	ip6h = ipv6_hdr(skb);
+	icmph = (struct icmp6hdr *)(ip6h + 1);
+	icmph->icmp6_cksum = 0;
+	icmph->icmp6_cksum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+					     ndsize,
+					     IPPROTO_ICMPV6,
+					     csum_partial(icmph,
+							  ndsize,
+							  0));
+	skb->ip_summed = CHECKSUM_COMPLETE;
+}
+#else
+static void ipvlan_macnat_patch_tx_ipv6(struct ipvl_dev *ipvlan,
+					struct sk_buff *skb)
+{
+}
+#endif
+
 static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan;
 	struct ipvl_addr *addr;
 	struct ethhdr *eth;
 	bool same_mac_addr;
-	int addr_type;
+	int addr_type = -1;
 	void *lyr3h;
 
 	ipvlan = netdev_priv(dev);
@@ -862,8 +972,6 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		}
 	} else {
 		/* Packet to outside on learnable. Fix source eth-addr. */
-		struct sk_buff *orig_skb = skb;
-
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (!skb)
 			return NET_XMIT_DROP;
@@ -872,17 +980,10 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		ether_addr_copy(skb_eth_hdr(skb)->h_source,
 				ipvlan->phy_dev->dev_addr);
 
-		/* ToDo: Handle ICMPv6 for neighbours discovery.*/
-		if (lyr3h && addr_type == IPVL_ARP) {
-			struct arphdr *arph;
-			/* must reparse new skb */
-			if (skb != orig_skb && lyr3h && addr_type == IPVL_ARP)
-				lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb,
-							  &addr_type);
-			arph = (struct arphdr *)lyr3h;
-			ether_addr_copy((u8 *)(arph + 1),
-					ipvlan->phy_dev->dev_addr);
-		}
+		if (addr_type == IPVL_ARP)
+			ipvlan_macnat_patch_tx_arp(ipvlan, skb);
+		else if (addr_type == IPVL_ICMPV6 || addr_type == IPVL_IPV6)
+			ipvlan_macnat_patch_tx_ipv6(ipvlan, skb);
 	}
 
 tx_phy_dev:
-- 
2.25.1


