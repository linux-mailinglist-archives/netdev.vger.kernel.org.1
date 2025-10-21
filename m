Return-Path: <netdev+bounces-231300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE647BF7295
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D0F3A8C4B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A889340286;
	Tue, 21 Oct 2025 14:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D7340DB4;
	Tue, 21 Oct 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058005; cv=none; b=KxdeckXEW+RK/CCnQK1ORb67x+tOzmN91moF6QTkBr0FRdAA4leqqiTuzJrWDErNOZZGT7J0N/sVuPMeaRxa5XWYh/UlTzig2Zjw5DvnifZR140Q3ZVcCdjtnVjJd2VsNOqwqr8L7d0j9DB3yYBVQWfY4nd1t8X0yeeJmJYOqnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058005; c=relaxed/simple;
	bh=L7LxDwzIsXZI93MMbHR6CFwpLDDh/EZqvGdICWGPMjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGPD1DoN2ZoTadO/qKp3n5QZ6hjiYNqvJ0MYRYf2bXRW6Hd0SiN6RJ3VUm3SSBCvPbvAdxNbCmFJPviULr0xppyOkUgzw84l/jU1dwonux3ubGFBTtWf11EA3IDC10Yn8++vq/gWSAMxudMZguzvZrtWT9LI2Sr/HB2Y7szaQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZpQ3wKwz6K6NF;
	Tue, 21 Oct 2025 22:45:18 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id F0D38140275;
	Tue, 21 Oct 2025 22:46:39 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:39 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 8/8] ipvlan: Don't learn child with host-ip
Date: Tue, 21 Oct 2025 17:44:10 +0300
Message-ID: <20251021144410.257905-9-skorodumov.dmitry@huawei.com>
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

When some child attempts to send a packet with host ip,
remember host IP in the list of ipvlan-addrs with mark "blocked".

Don't send anything if child tries to send a packet with IP of main.

ToDo: track addresses on main port and mark them as blocked if bridge
already learned some of them from some of the children.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      |  4 ++-
 drivers/net/ipvlan/ipvlan_core.c | 61 +++++++++++++++++++++++++-------
 drivers/net/ipvlan/ipvlan_main.c |  9 ++---
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 02a705bf9d42..7de9794efbda 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -74,6 +74,7 @@ struct ipvl_dev {
 
 struct ipvl_addr {
 	struct ipvl_dev		*master; /* Back pointer to master */
+	bool			is_blocked; /* Blocked. Addr from main iface */
 	union {
 		struct in6_addr	ip6;	 /* IPv6 address on logical interface */
 		struct in_addr	ip4;	 /* IPv4 address on logical interface */
@@ -179,7 +180,8 @@ void ipvlan_multicast_enqueue(struct ipvl_port *port,
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
 int ipvlan_add_addr(struct ipvl_dev *ipvlan,
-		    void *iaddr, bool is_v6, const u8 *hwaddr);
+		    void *iaddr, bool is_v6, const u8 *hwaddr,
+		    bool is_blocked);
 void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index ce06a06d8a28..8b2c2d455ea5 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -468,8 +468,30 @@ static inline bool is_ipv6_usable(const struct in6_addr *addr)
 	       !ipv6_addr_any(addr);
 }
 
-static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
-			      int addr_type, const u8 *hwaddr)
+static bool ipvlan_is_portaddr_busy(struct ipvl_dev *ipvlan,
+				    void *addr, bool is_v6)
+{
+	const struct in_ifaddr *ifa;
+	struct in_device *in_dev;
+
+	if (is_v6)
+		return ipv6_chk_addr(dev_net(ipvlan->phy_dev), addr,
+				    ipvlan->phy_dev, 1);
+
+	in_dev = __in_dev_get_rcu(ipvlan->phy_dev);
+	if (!in_dev)
+		return false;
+
+	in_dev_for_each_ifa_rcu(ifa, in_dev)
+		if (ifa->ifa_local == *(__be32 *)addr)
+			return true;
+
+	return false;
+}
+
+/* return -1 if frame should be dropped. */
+static int ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
+			     int addr_type, const u8 *hwaddr)
 {
 	struct ipvl_addr *ipvladdr;
 	void *addr = NULL;
@@ -483,7 +505,7 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 
 		ip6h = (struct ipv6hdr *)lyr3h;
 		if (!is_ipv6_usable(&ip6h->saddr))
-			return;
+			return 0;
 		is_v6 = true;
 		addr = &ip6h->saddr;
 		break;
@@ -496,7 +518,7 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 		ip4h = (struct iphdr *)lyr3h;
 		i4addr = &ip4h->saddr;
 		if (!is_ipv4_usable(*i4addr))
-			return;
+			return 0;
 		is_v6 = false;
 		addr = i4addr;
 		break;
@@ -511,17 +533,20 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 		arp_ptr += ipvlan->port->dev->addr_len;
 		i4addr = (__be32 *)arp_ptr;
 		if (!is_ipv4_usable(*i4addr))
-			return;
+			return 0;
 		is_v6 = false;
 		addr = i4addr;
 		break;
 	}
 	default:
-		return;
+		return 0;
 	}
 
 	/* handle situation when MAC changed, but IP is the same. */
 	ipvladdr = ipvlan_ht_addr_lookup(ipvlan->port, addr, is_v6);
+	if (ipvladdr && ipvladdr->is_blocked)
+		return -1;
+
 	if (ipvladdr && !ether_addr_equal(ipvladdr->hwaddr, hwaddr)) {
 		/* del_addr is safe to call, because we are inside xmit*/
 		ipvlan_del_addr(ipvladdr->master, addr, is_v6);
@@ -529,11 +554,17 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 	}
 
 	if (!ipvladdr) {
+		bool is_port_ip = ipvlan_is_portaddr_busy(ipvlan, addr, is_v6);
+
 		spin_lock_bh(&ipvlan->addrs_lock);
 		if (!ipvlan_addr_busy(ipvlan->port, addr, is_v6))
-			ipvlan_add_addr(ipvlan, addr, is_v6, hwaddr);
+			ipvlan_add_addr(ipvlan, addr, is_v6, hwaddr, is_port_ip);
 		spin_unlock_bh(&ipvlan->addrs_lock);
+
+		return is_port_ip ? -1 : 0;
 	}
+
+	return 0;
 }
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
@@ -724,11 +755,12 @@ static int ipvlan_xmit_mode_l3(struct sk_buff *skb, struct net_device *dev)
 
 	if (!ipvlan_is_vepa(ipvlan->port)) {
 		addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
-		if (addr) {
+		if (addr && !addr->is_blocked) {
 			if (ipvlan_is_private(ipvlan->port)) {
 				consume_skb(skb);
 				return NET_XMIT_DROP;
 			}
+
 			ipvlan_rcv_frame(addr, addr_type, &skb, true);
 			return NET_XMIT_SUCCESS;
 		}
@@ -866,8 +898,12 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
 
 	if (ipvlan_is_learnable(ipvlan->port)) {
-		if (lyr3h)
-			ipvlan_addr_learn(ipvlan, lyr3h, addr_type, eth->h_source);
+		if (lyr3h) {
+			if (ipvlan_addr_learn(ipvlan, lyr3h, addr_type,
+					      eth->h_source) < 0)
+				goto out_drop;
+		}
+
 		/* Mark SKB in advance */
 		skb = skb_share_check(skb, GFP_ATOMIC);
 		if (!skb)
@@ -903,7 +939,7 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 
 	if (lyr3h) {
 		addr = ipvlan_addr_lookup(ipvlan->port, lyr3h, addr_type, true);
-		if (addr) {
+		if (addr && !addr->is_blocked) {
 			if (ipvlan_is_private(ipvlan->port))
 				goto out_drop;
 
@@ -1016,8 +1052,9 @@ static rx_handler_result_t ipvlan_handle_mode_l3(struct sk_buff **pskb,
 		goto out;
 
 	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
-	if (addr)
+	if (addr && !addr->is_blocked)
 		ret = ipvlan_rcv_frame(addr, addr_type, pskb, false);
+
 out:
 	return ret;
 }
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index f1b1f91f94c0..5df6bdeadef5 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -151,7 +151,7 @@ static int ipvlan_port_receive(struct sk_buff *skb, struct net_device *wdev,
 		goto out;
 
 	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
-	if (addr)
+	if (addr && !addr->is_blocked)
 		return ipvlan_receive(addr->master, skb);
 
 out:
@@ -964,7 +964,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 /* the caller must held the addrs lock */
 int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
-		    const u8 *hwaddr)
+		    const u8 *hwaddr, bool is_blocked)
 {
 	struct ipvl_addr *addr;
 
@@ -973,6 +973,7 @@ int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
 		return -ENOMEM;
 
 	addr->master = ipvlan;
+	addr->is_blocked = is_blocked;
 	if (!is_v6) {
 		memcpy(&addr->ip4addr, iaddr, sizeof(struct in_addr));
 		addr->atype = IPVL_IPV4;
@@ -1024,7 +1025,7 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 			  "Failed to add IPv6=%pI6c addr for %s intf\n",
 			  ip6_addr, ipvlan->dev->name);
 	else
-		ret = ipvlan_add_addr(ipvlan, ip6_addr, true, NULL);
+		ret = ipvlan_add_addr(ipvlan, ip6_addr, true, NULL, false);
 	spin_unlock_bh(&ipvlan->addrs_lock);
 	return ret;
 }
@@ -1095,7 +1096,7 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
 			  "Failed to add IPv4=%pI4 on %s intf.\n",
 			  ip4_addr, ipvlan->dev->name);
 	else
-		ret = ipvlan_add_addr(ipvlan, ip4_addr, false, NULL);
+		ret = ipvlan_add_addr(ipvlan, ip4_addr, false, NULL, false);
 	spin_unlock_bh(&ipvlan->addrs_lock);
 	return ret;
 }
-- 
2.25.1


