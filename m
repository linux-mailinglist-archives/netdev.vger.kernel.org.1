Return-Path: <netdev+bounces-231296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953D2BF727B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216853BE73D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23E340292;
	Tue, 21 Oct 2025 14:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3F33FE38;
	Tue, 21 Oct 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057996; cv=none; b=MtGi+Rq06yv5w8Cd1J6AbQNoiEcSwAhwYIMvtHZAPB4yV4iWyG3vlcHQrRqW0BFkQsEq3NiEn24Y3MLsR0F18cRrbq7+W8rC18GkXvJRJb6w5O7yNx18aawC+lsv0zU9580ewrz1o9cjy7OOKYqmUnTyeU3E2lU1acWrNhRRaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057996; c=relaxed/simple;
	bh=EZ8iZmxtEjY5S/kY8DrOi3XNiSGLrtvYBs3T4mkMqbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2/gjM2cFzGFaWB+zACsWs9kYmoNf9LrSDotM+o72cZ1TNpNSPOM4PAl7GgiWNjwnM8u9lFWgrNNn4KE41WI+7tbsUwMWemy+sjCTeBxGE9e3meAakef8b4SqLA7k56j1+3+GyfYVPgnUilWlAytpVmxSrl+a8g9PxcG0bLjFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZld2Sqmz6D98B;
	Tue, 21 Oct 2025 22:42:53 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id EBA17140133;
	Tue, 21 Oct 2025 22:46:31 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:31 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/8] ipvlan: Added some kind of MAC SNAT
Date: Tue, 21 Oct 2025 17:44:06 +0300
Message-ID: <20251021144410.257905-5-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
References: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

We remember the SRC MAC address of outgoing packets
together with IP addresses.

While RX, we patch MAC address with remembered MAC.

We do patching for both eth_dst and ARPs.

ToDo: support IPv6 Neighbours Discovery.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      |   5 +-
 drivers/net/ipvlan/ipvlan_core.c | 144 +++++++++++++++++++++++--------
 drivers/net/ipvlan/ipvlan_main.c |  11 ++-
 3 files changed, 118 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 020e80df1e38..02a705bf9d42 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -78,6 +78,7 @@ struct ipvl_addr {
 		struct in6_addr	ip6;	 /* IPv6 address on logical interface */
 		struct in_addr	ip4;	 /* IPv4 address on logical interface */
 	} ipu;
+	u8			hwaddr[ETH_ALEN];
 #define ip6addr	ipu.ip6
 #define ip4addr ipu.ip4
 	struct hlist_node	hlnode;  /* Hash-table linkage */
@@ -177,7 +178,9 @@ void ipvlan_multicast_enqueue(struct ipvl_port *port,
 			      struct sk_buff *skb, bool tx_pkt);
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
-int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
+int ipvlan_add_addr(struct ipvl_dev *ipvlan,
+		    void *iaddr, bool is_v6, const u8 *hwaddr);
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
 bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 41059639f307..fe8e59066c46 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -320,8 +320,36 @@ void ipvlan_skb_crossing_ns(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = dev;
 }
 
-static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
-			    bool local)
+static int ipvlan_snat_rx_skb(struct ipvl_addr *addr, int addr_type,
+			      struct sk_buff *skb)
+{
+	/* Here we have non-shared skb and free to modify it. */
+	struct ethhdr *eth = eth_hdr(skb);
+
+	if (addr_type == IPVL_ARP) {
+		struct arphdr *arph = arp_hdr(skb);
+		u8 *arp_ptr = (u8 *)(arph + 1);
+		u8 *dsthw = arp_ptr + addr->master->dev->addr_len + sizeof(u32);
+		const u8 *phy_addr = addr->master->phy_dev->dev_addr;
+
+		/* Some access points may do ARP-proxy and answers us back.
+		 * Client may treat this as address-conflict.
+		 */
+		if (ether_addr_equal(eth->h_source, phy_addr) &&
+		    ether_addr_equal(eth->h_dest, phy_addr) &&
+		    is_zero_ether_addr(dsthw)) {
+			return NET_RX_DROP;
+		}
+		if (ether_addr_equal(dsthw, phy_addr))
+			ether_addr_copy(dsthw, addr->hwaddr);
+	}
+
+	ether_addr_copy(eth->h_dest, addr->hwaddr);
+	return NET_RX_SUCCESS;
+}
+
+static int ipvlan_rcv_frame(struct ipvl_addr *addr, int addr_type,
+			    struct sk_buff **pskb, bool local)
 {
 	struct ipvl_dev *ipvlan = addr->master;
 	struct net_device *dev = ipvlan->dev;
@@ -331,10 +359,8 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
 	struct sk_buff *skb = *pskb;
 
 	len = skb->len + ETH_HLEN;
-	/* Only packets exchanged between two local slaves need to have
-	 * device-up check as well as skb-share check.
-	 */
-	if (local) {
+
+	if (local || ipvlan_is_learnable(ipvlan->port)) {
 		if (unlikely(!(dev->flags & IFF_UP))) {
 			kfree_skb(skb);
 			goto out;
@@ -345,6 +371,13 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
 			goto out;
 
 		*pskb = skb;
+		if (!local && ipvlan_is_learnable(ipvlan->port)) {
+			if (ipvlan_snat_rx_skb(addr, addr_type, skb) !=
+			    NET_RX_SUCCESS) {
+				kfree_skb(skb);
+				goto out;
+			}
+		}
 	}
 
 	if (local) {
@@ -436,8 +469,9 @@ static inline bool is_ipv6_usable(const struct in6_addr *addr)
 }
 
 static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
-			      int addr_type)
+			      int addr_type, const u8 *hwaddr)
 {
+	struct ipvl_addr *ipvladdr;
 	void *addr = NULL;
 	bool is_v6;
 
@@ -486,10 +520,18 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 		return;
 	}
 
-	if (!ipvlan_ht_addr_lookup(ipvlan->port, addr, is_v6)) {
+	/* handle situation when MAC changed, but IP is the same. */
+	ipvladdr = ipvlan_ht_addr_lookup(ipvlan->port, addr, is_v6);
+	if (ipvladdr && !ether_addr_equal(ipvladdr->hwaddr, hwaddr)) {
+		/* del_addr is safe to call, because we are inside xmit*/
+		ipvlan_del_addr(ipvladdr->master, addr, is_v6);
+		ipvladdr = NULL;
+	}
+
+	if (!ipvladdr) {
 		spin_lock_bh(&ipvlan->addrs_lock);
 		if (!ipvlan_addr_busy(ipvlan->port, addr, is_v6))
-			ipvlan_add_addr(ipvlan, addr, is_v6);
+			ipvlan_add_addr(ipvlan, addr, is_v6, hwaddr);
 		spin_unlock_bh(&ipvlan->addrs_lock);
 	}
 }
@@ -687,7 +729,7 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 				consume_skb(skb);
 				return NET_XMIT_DROP;
 			}
-			ipvlan_rcv_frame(addr, &skb, true);
+			ipvlan_rcv_frame(addr, addr_type, &skb, true);
 			return NET_XMIT_SUCCESS;
 		}
 	}
@@ -712,12 +754,14 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	same_mac_addr = ether_addr_equal(eth->h_dest, eth->h_source);
+	if (same_mac_addr && ipvlan_is_learnable(ipvlan->port))
+		goto out_drop;
 
 	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
 
 	if (ipvlan_is_learnable(ipvlan->port)) {
 		if (lyr3h)
-			ipvlan_addr_learn(ipvlan, lyr3h, addr_type);
+			ipvlan_addr_learn(ipvlan, lyr3h, addr_type, eth->h_source);
 		/* Mark SKB in advance */
 		skb = skb_share_check(skb, GFP_ATOMIC);
 		if (!skb)
@@ -734,47 +778,74 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 			ipvlan_multicast_enqueue(ipvlan->port, nskb, true);
 		}
 
-		goto tx_phy_dev;
+		goto tx_frame_out;
 	}
 
 	if (ipvlan_is_vepa(ipvlan->port))
 		goto tx_phy_dev;
 
-	if (!same_mac_addr &&
+	if (ipvlan_is_learnable(ipvlan->port) &&
 	    ether_addr_equal(eth->h_dest, ipvlan->phy_dev->dev_addr)) {
 		/* It is a packet from child with destination to main port.
 		 * Pass it to main.
 		 */
-		skb = skb_share_check(skb, GFP_ATOMIC);
-		if (!skb)
-			return NET_XMIT_DROP;
 		skb->pkt_type = PACKET_HOST;
 		skb->dev = ipvlan->phy_dev;
 		dev_forward_skb(ipvlan->phy_dev, skb);
 		return NET_XMIT_SUCCESS;
-	} else if (same_mac_addr) {
-		if (lyr3h) {
-			addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
-			if (addr) {
-				if (ipvlan_is_private(ipvlan->port)) {
-					consume_skb(skb);
-					return NET_XMIT_DROP;
-				}
-				ipvlan_rcv_frame(addr, &skb, true);
-				return NET_XMIT_SUCCESS;
-			}
+	}
+
+	if (lyr3h) {
+		addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
+		if (addr) {
+			if (ipvlan_is_private(ipvlan->port))
+				goto out_drop;
+
+			ipvlan_rcv_frame(addr, addr_type, &skb, true);
+			return NET_XMIT_SUCCESS;
 		}
+	}
+
+tx_frame_out:
+	/* We don't know destination. Now we have to handle case for
+	 * non-learnable bridge and learnable case.
+	 */
+	if (!ipvlan_is_learnable(ipvlan->port)) {
 		skb = skb_share_check(skb, GFP_ATOMIC);
 		if (!skb)
 			return NET_XMIT_DROP;
+		if (same_mac_addr) {
+			/* Packet definitely does not belong to any of the
+			 * virtual devices, but the dest is local. So forward
+			 * the skb for the main-dev. At the RX side we just return
+			 * RX_PASS for it to be processed further on the stack.
+			 */
+			dev_forward_skb(ipvlan->phy_dev, skb);
+			return NET_XMIT_SUCCESS;
+		}
+	} else {
+		/* Ok. It is a packet to outside on learnable. Fix source eth-address. */
+		struct sk_buff *orig_skb = skb;
 
-		/* Packet definitely does not belong to any of the
-		 * virtual devices, but the dest is local. So forward
-		 * the skb for the main-dev. At the RX side we just return
-		 * RX_PASS for it to be processed further on the stack.
-		 */
-		dev_forward_skb(ipvlan->phy_dev, skb);
-		return NET_XMIT_SUCCESS;
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+
+		skb_reset_mac_header(skb);
+		ether_addr_copy(skb_eth_hdr(skb)->h_source,
+				ipvlan->phy_dev->dev_addr);
+
+		/* ToDo: Handle ICMPv6 for neighbours discovery.*/
+		if (lyr3h && addr_type == IPVL_ARP) {
+			struct arphdr *arph;
+			/* must reparse new skb */
+			if (skb != orig_skb && lyr3h && addr_type == IPVL_ARP)
+				lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb,
+							  &addr_type);
+			arph = (struct arphdr *)lyr3h;
+			ether_addr_copy((u8 *)(arph + 1),
+					ipvlan->phy_dev->dev_addr);
+		}
 	}
 
 tx_phy_dev:
@@ -849,8 +920,7 @@ static rx_handler_result_t ipvlan_handle_mode_l3(struct sk_buff **pskb,
 
 	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
 	if (addr)
-		ret = ipvlan_rcv_frame(addr, pskb, false);
-
+		ret = ipvlan_rcv_frame(addr, addr_type, pskb, false);
 out:
 	return ret;
 }
@@ -918,7 +988,7 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 		return RX_HANDLER_PASS;
 
 	if (ipvlan_is_l2_mcast(port, skb, &need_eth_fix)) {
-		if (ipvlan_external_frame(skb, port)) {
+		if (ipvlan_is_learnable(port) || ipvlan_external_frame(skb, port)) {
 			/* External frames are queued for device local
 			 * distribution, but a copy is given to master
 			 * straight away to avoid sending duplicates later
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index df5275bc30fc..6fdfeca6081d 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -911,7 +911,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 }
 
 /* the caller must held the addrs lock */
-int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
+		    const u8 *hwaddr)
 {
 	struct ipvl_addr *addr;
 
@@ -929,6 +930,8 @@ int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 		addr->atype = IPVL_IPV6;
 #endif
 	}
+	if (hwaddr)
+		ether_addr_copy(addr->hwaddr, hwaddr);
 
 	list_add_tail_rcu(&addr->anode, &ipvlan->addrs);
 
@@ -941,7 +944,7 @@ int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 	return 0;
 }
 
-static void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
@@ -982,7 +985,7 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 			  "Failed to add IPv6=%pI6c addr for %s intf\n",
 			  ip6_addr, ipvlan->dev->name);
 	else
-		ret = ipvlan_add_addr(ipvlan, ip6_addr, true);
+		ret = ipvlan_add_addr(ipvlan, ip6_addr, true, NULL);
 	spin_unlock_bh(&ipvlan->addrs_lock);
 	return ret;
 }
@@ -1053,7 +1056,7 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
 			  "Failed to add IPv4=%pI4 on %s intf.\n",
 			  ip4_addr, ipvlan->dev->name);
 	else
-		ret = ipvlan_add_addr(ipvlan, ip4_addr, false);
+		ret = ipvlan_add_addr(ipvlan, ip4_addr, false, NULL);
 	spin_unlock_bh(&ipvlan->addrs_lock);
 	return ret;
 }
-- 
2.25.1


