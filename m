Return-Path: <netdev+bounces-239481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88271C68AFB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BC513555A8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C332E6B5;
	Tue, 18 Nov 2025 10:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E741C32D0C6;
	Tue, 18 Nov 2025 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460062; cv=none; b=YSKE41V9tMkKKIHPJ8sqElUE6BjwaEvG0Z/nX37+Sbc36YIohHb9m+p9FURNFDqMz1qJHcwZtnTuW2WgBCs8n2ewQr5Yy19vbRegH7C3v9v65zzsaFcM9B8L5aNZnCAHVmd+SxcyEnP1Cak5a1J5qkurr99dNMG7UrZf3EMjw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460062; c=relaxed/simple;
	bh=wonYv5bpydqubTs0CPBpMWoAA10Hr8CRRsF2MQ8dYoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGKOs3QBg0xFHmQsAw5y0IkqPc1AVfSCTYhg1NCq6W9H0M1x0L1g4WIIs02teMsT/r3y5pknaE3ZVj5tUHRICf6GpjcOBKoNTtnvhezqmalwOKHiZqvG/lzdjQu67NJl4pgDEHBG+tO34lvrBjSIvj0Wozq0a/Lefeo3rsC7Muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9g8c0zM9zJ46jr;
	Tue, 18 Nov 2025 18:00:16 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 30D34140277;
	Tue, 18 Nov 2025 18:00:58 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 13:00:57 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 04/13] ipvlan: Support IPv6 in macnat mode.
Date: Tue, 18 Nov 2025 13:00:36 +0300
Message-ID: <20251118100046.2944392-5-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

To make IPv6 work with macnat mode, need to
process the TX-path:
* Replace Source-ll-addr in Solicitation ndisc,
* Replace Target-ll-addr in Advertisement ndisc

No need to do anything in RX-path

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 128 ++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index aa79368b4559..97107d9ce20c 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -4,6 +4,7 @@
 
 #include <net/flow.h>
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 
 #include "ipvlan.h"
 
@@ -225,6 +226,115 @@ unsigned int ipvlan_mac_hash(const unsigned char *addr)
 	return hash & IPVLAN_MAC_FILTER_MASK;
 }
 
+static void ipvlan_macnat_patch_tx_arp(struct ipvl_port *port,
+				       struct sk_buff *skb)
+{
+	struct arphdr *arph;
+	int addr_type;
+
+	arph = (struct arphdr *)ipvlan_get_L3_hdr(port, skb,
+						 &addr_type);
+	ether_addr_copy((u8 *)(arph + 1), port->dev->dev_addr);
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
+	ndsize = (int)ntohs(ip6h->payload_len);
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
+static void ipvlan_macnat_patch_tx_ipv6(struct ipvl_port *port,
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
+	ndsize = (int)ntohs(ip6h->payload_len);
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h) + ndsize)))
+		return;
+
+	lladdr = ipvlan_search_icmp6_ll_addr(skb, icmp_option);
+	if (!lladdr)
+		return;
+
+	ether_addr_copy(lladdr, port->dev->dev_addr);
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
+static void ipvlan_macnat_patch_tx_ipv6(struct ipvl_port *port,
+					struct sk_buff *skb)
+{
+}
+#endif
+
 static int ipvlan_macnat_xmit_phydev(struct ipvl_port *port,
 				     struct sk_buff *skb,
 				     bool lyr3h_valid,
@@ -244,18 +354,12 @@ static int ipvlan_macnat_xmit_phydev(struct ipvl_port *port,
 		lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
 		orig_skb = skb; /* no need to reparse */
 	}
-
-	/* ToDo: Handle ICMPv6 for neighbours discovery.*/
-	if (lyr3h && addr_type == IPVL_ARP) {
-		if (skb != orig_skb)
-			lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
-
-		if (lyr3h) {
-			struct arphdr *arph = (struct arphdr *)lyr3h;
-
-			ether_addr_copy((u8 *)(arph + 1), port->dev->dev_addr);
-		}
-	}
+	if (!lyr3h)
+		addr_type = -1;
+	else if (addr_type == IPVL_ARP)
+		ipvlan_macnat_patch_tx_arp(port, skb);
+	else if (addr_type == IPVL_ICMPV6 || addr_type == IPVL_IPV6)
+		ipvlan_macnat_patch_tx_ipv6(port, skb);
 
 	skb->dev = port->dev;
 	return dev_queue_xmit(skb);
-- 
2.25.1


