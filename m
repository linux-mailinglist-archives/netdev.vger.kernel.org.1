Return-Path: <netdev+bounces-231293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9ABF724D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5512A4F05E4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BF33F8BD;
	Tue, 21 Oct 2025 14:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0233F8BC;
	Tue, 21 Oct 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057991; cv=none; b=Q4ZTKkYr2jX0fgYmqpb40dNFMtTwWDsEEJ7qhR2UambDosu/uoFLYio9g+nGwZXdeduJTOaXW0VNx3T7avDctTGt3cjZQYeeSS67MA3euG6W7/bEcx171/qHd3VxqrYjSQS/vf3SyYGkJNmv6SyHX5ZJTp0FjdpXncPZapTI6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057991; c=relaxed/simple;
	bh=lK/l4Mo51DWvIEf4keqrmAF5OnnHIV1TKC2TIUYW1FA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwldR36JiX+hgDlOeQwJaIQeoJeb4JIz94qLkI3B5iYLRf67KsQ2Eoo5RAdbbLIYavrLJPXd3loOetmmUz1j9Mt/ZNw/pXj7msodcf2DxVlTcrhvBagifx7yfonoOHX3nCEOFI/sn0x3gVNl5UOVIdc4eLEqCwasyYmck9p8vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZp75T3sz6K6MQ;
	Tue, 21 Oct 2025 22:45:03 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 315EF140133;
	Tue, 21 Oct 2025 22:46:25 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:24 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next 1/8] ipvlan: Implement learnable L2-bridge
Date: Tue, 21 Oct 2025 17:44:03 +0300
Message-ID: <20251021144410.257905-2-skorodumov.dmitry@huawei.com>
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

Now it is possible to create link in L2E mode: learnable
bridge. The IPs will be learned from TX-packets of child interfaces.

Also, dev_add_pack() protocol is attached to the main port
to support communication from main to child interfaces.

This mode is intended for the desktop virtual machines, for
bridging to Wireless interfaces.

The mode should be specified while creating first child interface.
It is not possible to change it after this.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 Documentation/networking/ipvlan.rst |  11 ++
 drivers/net/ipvlan/ipvlan.h         |  21 ++++
 drivers/net/ipvlan/ipvlan_core.c    | 163 +++++++++++++++++++++++++---
 drivers/net/ipvlan/ipvlan_main.c    | 140 +++++++++++++++++++++---
 include/uapi/linux/if_link.h        |   1 +
 5 files changed, 301 insertions(+), 35 deletions(-)

diff --git a/Documentation/networking/ipvlan.rst b/Documentation/networking/ipvlan.rst
index 895d0ccfd596..9539e8ac99f4 100644
--- a/Documentation/networking/ipvlan.rst
+++ b/Documentation/networking/ipvlan.rst
@@ -90,6 +90,17 @@ works in this mode and hence it is L3-symmetric (L3s). This will have slightly l
 performance but that shouldn't matter since you are choosing this mode over plain-L3
 mode to make conn-tracking work.
 
+4.4 L2E mode:
+-------------
+
+This mode is an extension for the L2 mode. It is primarily intended for
+desktop virtual machines for bridging to Wireless interfaces. In plain L2
+mode you have to configure IPs on slave interface to make it possible
+mux-ing frames between slaves/master. In the L2E mode, ipvlan will
+learn itself IPv4/IPv6 address from outgoing packets. Moreover,
+the dev_add_pack() is configured on master interface to capture
+outgoing frames and mux-ing it to slave interfaces, if needed.
+
 5. Mode flags:
 ==============
 
diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 50de3ee204db..020e80df1e38 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -91,6 +91,7 @@ struct ipvl_port {
 	possible_net_t		pnet;
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
 	struct list_head	ipvlans;
+	struct packet_type	ipvl_ptype;
 	u16			mode;
 	u16			flags;
 	u16			dev_id_start;
@@ -103,6 +104,7 @@ struct ipvl_port {
 
 struct ipvl_skb_cb {
 	bool tx_pkt;
+	void *mark;
 };
 #define IPVL_SKB_CB(_skb) ((struct ipvl_skb_cb *)&((_skb)->cb[0]))
 
@@ -151,12 +153,31 @@ static inline void ipvlan_clear_vepa(struct ipvl_port *port)
 	port->flags &= ~IPVLAN_F_VEPA;
 }
 
+static inline bool ipvlan_is_learnable(struct ipvl_port *port)
+{
+	return port->mode == IPVLAN_MODE_L2E;
+}
+
+static inline void ipvlan_mark_skb(struct sk_buff *skb, struct net_device *dev)
+{
+	IPVL_SKB_CB(skb)->mark = dev;
+}
+
+static inline bool ipvlan_is_skb_marked(struct sk_buff *skb, struct net_device *dev)
+{
+	return (IPVL_SKB_CB(skb)->mark == dev);
+}
+
 void ipvlan_init_secret(void);
 unsigned int ipvlan_mac_hash(const unsigned char *addr);
 rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb);
+void ipvlan_skb_crossing_ns(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_process_multicast(struct work_struct *work);
+void ipvlan_multicast_enqueue(struct ipvl_port *port,
+			      struct sk_buff *skb, bool tx_pkt);
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
+int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
 bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index d7e3ddbcab6f..ffe8efd2f1aa 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -284,6 +284,18 @@ void ipvlan_process_multicast(struct work_struct *work)
 		rcu_read_unlock();
 
 		if (tx_pkt) {
+			if (ipvlan_is_learnable(port)) {
+				/* Inject packet to main dev */
+				nskb = skb_clone(skb, GFP_ATOMIC);
+				if (nskb) {
+					local_bh_disable();
+					nskb->pkt_type = pkt_type;
+					nskb->dev = port->dev;
+					dev_forward_skb(port->dev, nskb);
+					local_bh_enable();
+				}
+			}
+
 			/* If the packet originated here, send it out. */
 			skb->dev = port->dev;
 			skb->pkt_type = pkt_type;
@@ -299,7 +311,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 	}
 }
 
-static void ipvlan_skb_crossing_ns(struct sk_buff *skb, struct net_device *dev)
+void ipvlan_skb_crossing_ns(struct sk_buff *skb, struct net_device *dev)
 {
 	bool xnet = true;
 
@@ -414,6 +426,77 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 	return addr;
 }
 
+static inline bool is_ipv4_usable(__be32 addr)
+{
+	return !ipv4_is_lbcast(addr) && !ipv4_is_multicast(addr) &&
+	       !ipv4_is_zeronet(addr);
+}
+
+static inline bool is_ipv6_usable(const struct in6_addr *addr)
+{
+	return !ipv6_addr_is_multicast(addr) && !ipv6_addr_loopback(addr) &&
+	       !ipv6_addr_any(addr);
+}
+
+static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
+			      int addr_type)
+{
+	void *addr = NULL;
+	bool is_v6;
+
+	switch (addr_type) {
+#if IS_ENABLED(CONFIG_IPV6)
+	/* No need to handle IPVL_ICMPV6, since it never has valid src-address */
+	case IPVL_IPV6: {
+		struct ipv6hdr *ip6h;
+
+		ip6h = (struct ipv6hdr *)lyr3h;
+		if (!is_ipv6_usable(&ip6h->saddr))
+			return;
+		is_v6 = true;
+		addr = &ip6h->saddr;
+		break;
+	}
+#endif
+	case IPVL_IPV4: {
+		struct iphdr *ip4h;
+		__be32 *i4addr;
+
+		ip4h = (struct iphdr *)lyr3h;
+		i4addr = &ip4h->saddr;
+		if (!is_ipv4_usable(*i4addr))
+			return;
+		is_v6 = false;
+		addr = i4addr;
+		break;
+	}
+	case IPVL_ARP: {
+		struct arphdr *arph;
+		unsigned char *arp_ptr;
+		__be32 *i4addr;
+
+		arph = (struct arphdr *)lyr3h;
+		arp_ptr = (unsigned char *)(arph + 1);
+		arp_ptr += ipvlan->port->dev->addr_len;
+		i4addr = (__be32 *)arp_ptr;
+		if (!is_ipv4_usable(*i4addr))
+			return;
+		is_v6 = false;
+		addr = i4addr;
+		break;
+	}
+	default:
+		return;
+	}
+
+	if (!ipvlan_ht_addr_lookup(ipvlan->port, addr, is_v6)) {
+		spin_lock_bh(&ipvlan->addrs_lock);
+		if (!ipvlan_addr_busy(ipvlan->port, addr, is_v6))
+			ipvlan_add_addr(ipvlan, addr, is_v6);
+		spin_unlock_bh(&ipvlan->addrs_lock);
+	}
+}
+
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
@@ -561,8 +644,8 @@ static int ipvlan_process_outbound(struct sk_buff *skb)
 	return ret;
 }
 
-static void ipvlan_multicast_enqueue(struct ipvl_port *port,
-				     struct sk_buff *skb, bool tx_pkt)
+void ipvlan_multicast_enqueue(struct ipvl_port *port,
+			      struct sk_buff *skb, bool tx_pkt)
 {
 	if (skb->protocol == htons(ETH_P_PAUSE)) {
 		kfree_skb(skb);
@@ -618,15 +701,56 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 
 static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 {
-	const struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct ethhdr *eth = skb_eth_hdr(skb);
-	struct ipvl_addr *addr;
 	void *lyr3h;
+	struct ipvl_addr *addr;
 	int addr_type;
+	bool same_mac_addr;
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ethhdr *eth = skb_eth_hdr(skb);
+
+	if (ipvlan_is_learnable(ipvlan->port) &&
+	    ether_addr_equal(eth->h_source, dev->dev_addr)) {
+		/* ignore tx-packets from host */
+		goto out_drop;
+	}
+
+	same_mac_addr = ether_addr_equal(eth->h_dest, eth->h_source);
+
+	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
 
-	if (!ipvlan_is_vepa(ipvlan->port) &&
-	    ether_addr_equal(eth->h_dest, eth->h_source)) {
-		lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
+	if (ipvlan_is_learnable(ipvlan->port)) {
+		if (lyr3h)
+			ipvlan_addr_learn(ipvlan, lyr3h, addr_type);
+		/* Mark SKB in advance */
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+		ipvlan_mark_skb(skb, ipvlan->phy_dev);
+	}
+
+	if (is_multicast_ether_addr(eth->h_dest)) {
+		skb_reset_mac_header(skb);
+		ipvlan_skb_crossing_ns(skb, NULL);
+		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (ipvlan_is_vepa(ipvlan->port))
+		goto tx_phy_dev;
+
+	if (!same_mac_addr &&
+	    ether_addr_equal(eth->h_dest, ipvlan->phy_dev->dev_addr)) {
+		/* It is a packet from child with destination to main port.
+		 * Pass it to main.
+		 */
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+		skb->pkt_type = PACKET_HOST;
+		skb->dev = ipvlan->phy_dev;
+		dev_forward_skb(ipvlan->phy_dev, skb);
+		return NET_XMIT_SUCCESS;
+	} else if (same_mac_addr) {
 		if (lyr3h) {
 			addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
 			if (addr) {
@@ -649,16 +773,14 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		 */
 		dev_forward_skb(ipvlan->phy_dev, skb);
 		return NET_XMIT_SUCCESS;
-
-	} else if (is_multicast_ether_addr(eth->h_dest)) {
-		skb_reset_mac_header(skb);
-		ipvlan_skb_crossing_ns(skb, NULL);
-		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
-		return NET_XMIT_SUCCESS;
 	}
 
+tx_phy_dev:
 	skb->dev = ipvlan->phy_dev;
 	return dev_queue_xmit(skb);
+out_drop:
+	consume_skb(skb);
+	return NET_XMIT_DROP;
 }
 
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -674,6 +796,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch(port->mode) {
 	case IPVLAN_MODE_L2:
+	case IPVLAN_MODE_L2E:
 		return ipvlan_xmit_mode_l2(skb, dev);
 	case IPVLAN_MODE_L3:
 #ifdef CONFIG_IPVLAN_L3S
@@ -737,17 +860,22 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 	struct ethhdr *eth = eth_hdr(skb);
 	rx_handler_result_t ret = RX_HANDLER_PASS;
 
+	/* Ignore already seen packets. */
+	if (ipvlan_is_skb_marked(skb, port->dev))
+		return RX_HANDLER_PASS;
+
 	if (is_multicast_ether_addr(eth->h_dest)) {
 		if (ipvlan_external_frame(skb, port)) {
-			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
-
 			/* External frames are queued for device local
 			 * distribution, but a copy is given to master
 			 * straight away to avoid sending duplicates later
 			 * when work-queue processes this frame. This is
 			 * achieved by returning RX_HANDLER_PASS.
 			 */
+			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
 			if (nskb) {
+				ipvlan_mark_skb(skb, port->dev);
 				ipvlan_skb_crossing_ns(nskb, NULL);
 				ipvlan_multicast_enqueue(port, nskb, false);
 			}
@@ -770,6 +898,7 @@ rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
 
 	switch (port->mode) {
 	case IPVLAN_MODE_L2:
+	case IPVLAN_MODE_L2E:
 		return ipvlan_handle_mode_l2(pskb, port);
 	case IPVLAN_MODE_L3:
 		return ipvlan_handle_mode_l3(pskb, port);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 660f3db11766..df5275bc30fc 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -7,6 +7,11 @@
 
 #include "ipvlan.h"
 
+static void ipvlan_set_learnable(struct ipvl_port *port)
+{
+	dev_add_pack(&port->ipvl_ptype);
+}
+
 static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 				struct netlink_ext_ack *extack)
 {
@@ -16,6 +21,15 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 
 	ASSERT_RTNL();
 	if (port->mode != nval) {
+		/* Don't allow switch off the learnable bridge mode.
+		 * Flags also must be set from the first port-link setup.
+		 */
+		if (port->mode == IPVLAN_MODE_L2E ||
+		    (nval == IPVLAN_MODE_L2E && port->count > 1)) {
+			netdev_err(port->dev, "L2E mode cannot be changed.\n");
+			return -EINVAL;
+		}
+
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			flags = ipvlan->dev->flags;
 			if (nval == IPVLAN_MODE_L3 || nval == IPVLAN_MODE_L3S) {
@@ -40,7 +54,10 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 			ipvlan_l3s_unregister(port);
 		}
 		port->mode = nval;
+		if (port->mode == IPVLAN_MODE_L2E)
+			ipvlan_set_learnable(port);
 	}
+
 	return 0;
 
 fail:
@@ -59,6 +76,64 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 	return err;
 }
 
+static int ipvlan_port_receive(struct sk_buff *skb, struct net_device *wdev,
+			       struct packet_type *pt, struct net_device *orig_wdev)
+{
+	struct ipvl_port *port;
+	struct ipvl_addr *addr;
+	struct ethhdr *eth;
+	void *lyr3h;
+	int addr_type;
+
+	port = container_of(pt, struct ipvl_port, ipvl_ptype);
+	/* We are interested only in outgoing packets.
+	 * rx-path is handled in rx_handler().
+	 */
+	if (skb->pkt_type != PACKET_OUTGOING || ipvlan_is_skb_marked(skb, port->dev))
+		goto out;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto no_mem;
+
+	/* data should point to eth-header */
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	skb->dev = port->dev;
+	eth = eth_hdr(skb);
+
+	if (is_multicast_ether_addr(eth->h_dest)) {
+		ipvlan_skb_crossing_ns(skb, NULL);
+		skb->protocol = eth_type_trans(skb, skb->dev);
+		skb->pkt_type = PACKET_HOST;
+		ipvlan_mark_skb(skb, port->dev);
+		ipvlan_multicast_enqueue(port, skb, false);
+		return 0;
+	}
+
+	lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
+	if (!lyr3h)
+		goto out;
+
+	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
+	if (addr) {
+		int ret, len;
+
+		ipvlan_skb_crossing_ns(skb, addr->master->dev);
+		skb->protocol = eth_type_trans(skb, skb->dev);
+		skb->pkt_type = PACKET_HOST;
+		ipvlan_mark_skb(skb, port->dev);
+		len = skb->len + ETH_HLEN;
+		ret = netif_rx(skb);
+		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
+		return 0;
+	}
+
+out:
+	dev_kfree_skb(skb);
+no_mem:
+	return 0; // actually, ret value is ignored
+}
+
 static int ipvlan_port_create(struct net_device *dev)
 {
 	struct ipvl_port *port;
@@ -84,6 +159,11 @@ static int ipvlan_port_create(struct net_device *dev)
 	if (err)
 		goto err;
 
+	port->ipvl_ptype.func = ipvlan_port_receive;
+	port->ipvl_ptype.type = htons(ETH_P_ALL);
+	port->ipvl_ptype.dev = dev;
+	port->ipvl_ptype.list.prev = LIST_POISON2;
+
 	netdev_hold(dev, &port->dev_tracker, GFP_KERNEL);
 	return 0;
 
@@ -100,6 +180,8 @@ static void ipvlan_port_destroy(struct net_device *dev)
 	netdev_put(dev, &port->dev_tracker);
 	if (port->mode == IPVLAN_MODE_L3S)
 		ipvlan_l3s_unregister(port);
+	if (port->ipvl_ptype.list.prev != LIST_POISON2)
+		dev_remove_pack(&port->ipvl_ptype);
 	netdev_rx_handler_unregister(dev);
 	cancel_work_sync(&port->wq);
 	while ((skb = __skb_dequeue(&port->backlog)) != NULL) {
@@ -189,10 +271,13 @@ static int ipvlan_open(struct net_device *dev)
 	else
 		dev->flags &= ~IFF_NOARP;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
-		ipvlan_ht_addr_add(ipvlan, addr);
-	rcu_read_unlock();
+	/* for learnable, addresses will be obtained from tx-packets. */
+	if (!ipvlan_is_learnable(ipvlan->port)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
+			ipvlan_ht_addr_add(ipvlan, addr);
+		rcu_read_unlock();
+	}
 
 	return 0;
 }
@@ -581,11 +666,21 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	INIT_LIST_HEAD(&ipvlan->addrs);
 	spin_lock_init(&ipvlan->addrs_lock);
 
-	/* TODO Probably put random address here to be presented to the
-	 * world but keep using the physical-dev address for the outgoing
-	 * packets.
+	/* Flags are per port and latest update overrides. User has
+	 * to be consistent in setting it just like the mode attribute.
 	 */
-	eth_hw_addr_set(dev, phy_dev->dev_addr);
+	if (data && data[IFLA_IPVLAN_MODE])
+		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
+
+	if (mode != IPVLAN_MODE_L2E) {
+		/* TODO Probably put random address here to be presented to the
+		 * world but keep using the physical-dev address for the outgoing
+		 * packets.
+		 */
+		eth_hw_addr_set(dev, phy_dev->dev_addr);
+	} else {
+		eth_hw_addr_random(dev);
+	}
 
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 
@@ -597,6 +692,9 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	port = ipvlan_port_get_rtnl(phy_dev);
 	ipvlan->port = port;
 
+	if (data && data[IFLA_IPVLAN_FLAGS])
+		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
+
 	/* If the port-id base is at the MAX value, then wrap it around and
 	 * begin from 0x1 again. This may be due to a busy system where lots
 	 * of slaves are getting created and deleted.
@@ -625,19 +723,13 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err)
 		goto remove_ida;
 
-	/* Flags are per port and latest update overrides. User has
-	 * to be consistent in setting it just like the mode attribute.
-	 */
-	if (data && data[IFLA_IPVLAN_FLAGS])
-		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
-
-	if (data && data[IFLA_IPVLAN_MODE])
-		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
-
 	err = ipvlan_set_port_mode(port, mode, extack);
 	if (err)
 		goto unlink_netdev;
 
+	if (ipvlan_is_learnable(port))
+		dev_set_allmulti(dev, 1);
+
 	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
 	netif_stacked_transfer_operstate(phy_dev, dev);
 	return 0;
@@ -657,6 +749,9 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
 
+	if (ipvlan_is_learnable(ipvlan->port))
+		dev_set_allmulti(dev, -1);
+
 	spin_lock_bh(&ipvlan->addrs_lock);
 	list_for_each_entry_safe(addr, next, &ipvlan->addrs, anode) {
 		ipvlan_ht_addr_del(addr);
@@ -793,6 +888,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
 		break;
 
 	case NETDEV_CHANGEADDR:
+		if (ipvlan_is_learnable(ipvlan->port))
+			break;
+
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			eth_hw_addr_set(ipvlan->dev, dev->dev_addr);
 			call_netdevice_notifiers(NETDEV_CHANGEADDR, ipvlan->dev);
@@ -813,7 +911,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 }
 
 /* the caller must held the addrs lock */
-static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
@@ -928,6 +1026,9 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
+	if (ipvlan_is_learnable(ipvlan->port))
+		return notifier_from_errno(-EADDRNOTAVAIL);
+
 	switch (event) {
 	case NETDEV_UP:
 		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
@@ -999,6 +1100,9 @@ static int ipvlan_addr4_validator_event(struct notifier_block *unused,
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
+	if (ipvlan_is_learnable(ipvlan->port))
+		return notifier_from_errno(-EADDRNOTAVAIL);
+
 	switch (event) {
 	case NETDEV_UP:
 		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b491d96e52e..6b543c05392d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1269,6 +1269,7 @@ enum ipvlan_mode {
 	IPVLAN_MODE_L2 = 0,
 	IPVLAN_MODE_L3,
 	IPVLAN_MODE_L3S,
+	IPVLAN_MODE_L2E,
 	IPVLAN_MODE_MAX
 };
 
-- 
2.25.1


