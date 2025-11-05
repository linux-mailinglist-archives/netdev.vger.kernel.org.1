Return-Path: <netdev+bounces-235874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D7C36B42
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F232507263
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBA341654;
	Wed,  5 Nov 2025 16:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74233EAF9;
	Wed,  5 Nov 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359309; cv=none; b=r4El8Aisaa7/2qf+5eIApF9H00bgArcewk5PrgBJ7oQFgZb/f9LHIfwymbY+ar7AnyB+NSUYfZBGPbICuiKSoBoKlqHJ7s9juil1/yBxM6lyvB3i8hBDDX541p0yB3uT9ttJEA56DV366wsBxt8scsTJbfs6bSyPs0iFcJNOgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359309; c=relaxed/simple;
	bh=MPfuni+5i9E8mSIOUUg/hxyhGcbqWqkhlzxGu0eyAXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJcczlXyAOE7qrSVtyj/Zq8ErP8BO7gN+aAaqiPyjU0+wENXa/NdHKv+S/H2Xe3TtBukjdQCdbvPra65I8nPyDMGXSSk53qyT5j8s0uKYW4fROODOPZraFdUYZapxRUYEngvz+tbOC0DKcdLUUATIGJhUyNluk/uqkOKjnuP+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1r4g2lCZzJ468s;
	Thu,  6 Nov 2025 00:14:43 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id B6A4714020A;
	Thu,  6 Nov 2025 00:15:04 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:15:04 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 10/14] ipvlan: Don't allow children to use IPs of main
Date: Wed, 5 Nov 2025 19:14:46 +0300
Message-ID: <20251105161450.1730216-11-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
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

Remember all ip-addresses on main iface and check
in ipvlan_addr_busy() that addr is not used on main.

Store IPs in separate list. Remember IP address at port create
and listen for addr-change events. Don't allow to configure
addresses on children with addresses of main.

In learning mode, child may not learn the address if
it is used on main.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      |  13 ++
 drivers/net/ipvlan/ipvlan_core.c |  39 ++++--
 drivers/net/ipvlan/ipvlan_main.c | 196 +++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 0ab1797c6128..faba1308c135 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -89,10 +89,21 @@ struct ipvl_addr {
 	struct rcu_head		rcu;
 };
 
+struct ipvl_port_addr {
+	union {
+		struct in6_addr	ip6;
+		struct in_addr	ip4;
+	} ipu;
+	ipvl_hdr_type		atype;
+	struct list_head	anode;
+	struct rcu_head		rcu;
+};
+
 struct ipvl_port {
 	struct net_device	*dev;
 	possible_net_t		pnet;
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
+	struct list_head	port_addrs; /* addresses of main iface.*/
 	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
 	struct packet_type	ipvl_ptype;
@@ -199,6 +210,8 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 void ipvlan_link_delete(struct net_device *dev, struct list_head *head);
 void ipvlan_link_setup(struct net_device *dev);
 int ipvlan_link_register(struct rtnl_link_ops *ops);
+struct ipvl_port_addr *ipvlan_port_find_addr(struct ipvl_port *port,
+					     const void *iaddr, bool is_v6);
 #ifdef CONFIG_IPVLAN_L3S
 int ipvlan_l3s_register(struct ipvl_port *port);
 void ipvlan_l3s_unregister(struct ipvl_port *port);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index a952a257a791..cba1378cc920 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -133,6 +133,8 @@ bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
 			break;
 		}
 	}
+	if (!ret)
+		ret = !!ipvlan_port_find_addr(port, iaddr, is_v6);
 	rcu_read_unlock();
 	return ret;
 }
@@ -469,17 +471,21 @@ static bool is_ipv6_usable(const struct in6_addr *addr)
 	       !ipv6_addr_any(addr);
 }
 
-static void __ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *addr, bool is_v6,
-				const u8 *hwaddr)
+static int __ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *addr, bool is_v6,
+			       const u8 *hwaddr)
 {
 	const ipvl_hdr_type atype = is_v6 ? IPVL_IPV6 : IPVL_IPV4;
 	struct ipvl_addr *ipvladdr, *oldest = NULL;
 	unsigned int naddrs = 0;
+	int ret = -1;
 
 	spin_lock_bh(&ipvlan->port->addrs_lock);
 
+	if (ipvlan_port_find_addr(ipvlan->port, addr, is_v6))
+		goto out_unlock; /* used by main. */
+
 	if (ipvlan_addr_busy(ipvlan->port, addr, is_v6))
-		goto out_unlock;
+		goto out_unlock; /* used by other ipvlan. */
 
 	list_for_each_entry_rcu(ipvladdr, &ipvlan->addrs, anode) {
 		if (ipvladdr->atype != atype)
@@ -497,15 +503,19 @@ static void __ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *addr, bool is_v6,
 	}
 
 	ipvlan_add_addr(ipvlan, addr, is_v6, hwaddr);
+	ret = 0;
 
 out_unlock:
 	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	if (oldest)
 		kfree_rcu(oldest, rcu);
+
+	return ret;
 }
 
-static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
-			      int addr_type, const u8 *hwaddr)
+/* return -1 if frame should be dropped. */
+static int ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
+			     int addr_type, const u8 *hwaddr)
 {
 	struct ipvl_addr *ipvladdr;
 	void *addr = NULL;
@@ -519,7 +529,7 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 
 		ip6h = (struct ipv6hdr *)lyr3h;
 		if (!is_ipv6_usable(&ip6h->saddr))
-			return;
+			return 0;
 		is_v6 = true;
 		addr = &ip6h->saddr;
 		break;
@@ -532,7 +542,7 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 		ip4h = (struct iphdr *)lyr3h;
 		i4addr = &ip4h->saddr;
 		if (!is_ipv4_usable(*i4addr))
-			return;
+			return 0;
 		is_v6 = false;
 		addr = i4addr;
 		break;
@@ -547,17 +557,18 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
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
+
 	if (ipvladdr && !ether_addr_equal(ipvladdr->hwaddr, hwaddr)) {
 		/* del_addr is safe to call, because we are inside xmit. */
 		ipvlan_del_addr(ipvladdr->master, addr, is_v6);
@@ -565,7 +576,9 @@ static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
 	}
 
 	if (!ipvladdr)
-		__ipvlan_addr_learn(ipvlan, addr, is_v6, hwaddr);
+		return __ipvlan_addr_learn(ipvlan, addr, is_v6, hwaddr);
+
+	return 0;
 }
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
@@ -905,9 +918,9 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 		lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
 
 		if (ipvlan_is_macnat(ipvlan->port)) {
-			if (lyr3h)
-				ipvlan_addr_learn(ipvlan, lyr3h, addr_type,
-						  eth->h_source);
+			if (lyr3h && ipvlan_addr_learn(ipvlan, lyr3h, addr_type,
+						       eth->h_source) < 0)
+				goto out_drop;
 			/* Mark SKB in advance */
 			skb = skb_share_check(skb, GFP_ATOMIC);
 			if (!skb)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index b888c2ef77ca..18b49f74dc35 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -156,6 +156,115 @@ static int ipvlan_port_rcv(struct sk_buff *skb, struct net_device *wdev,
 	return NET_RX_DROP;
 }
 
+static int ipvlan_port_add_addr(struct ipvl_port *port, const void *iaddr,
+				bool is_v6)
+{
+	struct ipvl_port_addr *addr;
+
+	addr = kzalloc(sizeof(*addr), GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+	if (!is_v6) {
+		memcpy(&addr->ip4addr, iaddr, sizeof(struct in_addr));
+		addr->atype = IPVL_IPV4;
+	} else {
+		memcpy(&addr->ip6addr, iaddr, sizeof(struct in6_addr));
+		addr->atype = IPVL_IPV6;
+	}
+
+	spin_lock_bh(&port->addrs_lock);
+	list_add_tail_rcu(&addr->anode, &port->port_addrs);
+	spin_unlock_bh(&port->addrs_lock);
+
+	return 0;
+}
+
+static bool portaddr_equal(bool is_v6, const struct ipvl_port_addr *addr,
+			   const void *iaddr)
+{
+	if (!is_v6 && addr->atype == IPVL_IPV4) {
+		struct in_addr *i4addr = (struct in_addr *)iaddr;
+
+		return addr->ip4addr.s_addr == i4addr->s_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (is_v6 && addr->atype == IPVL_IPV6) {
+		struct in6_addr *i6addr = (struct in6_addr *)iaddr;
+
+		return ipv6_addr_equal(&addr->ip6addr, i6addr);
+#endif
+	}
+
+	return false;
+}
+
+struct ipvl_port_addr *ipvlan_port_find_addr(struct ipvl_port *port,
+					     const void *iaddr, bool is_v6)
+{
+	struct ipvl_port_addr *addr;
+
+	list_for_each_entry_rcu(addr, &port->port_addrs, anode)
+		if (portaddr_equal(is_v6, addr, iaddr))
+			return addr;
+	return NULL;
+}
+
+static void ipvlan_port_del_addr(struct ipvl_port *port, const void *iaddr,
+				 bool is_v6)
+{
+	struct ipvl_port_addr *addr;
+
+	spin_lock_bh(&port->addrs_lock);
+	addr = ipvlan_port_find_addr(port, iaddr, is_v6);
+	if (addr)
+		list_del_rcu(&addr->anode);
+	spin_unlock_bh(&port->addrs_lock);
+
+	if (addr)
+		kfree_rcu(addr, rcu);
+}
+
+static int ipvlan_port_enum_addrs(struct ipvl_port *port)
+{
+	const struct inet6_dev *in6_dev __maybe_unused;
+	const struct inet6_ifaddr *ifa6 __maybe_unused;
+	const struct in_device *in_dev;
+	const struct in_ifaddr *ifa;
+	int r = 0;
+
+	ASSERT_RTNL();
+
+	in_dev = __in_dev_get_rcu(port->dev);
+	if (in_dev)
+		in_dev_for_each_ifa_rcu(ifa, in_dev) {
+			r = ipvlan_port_add_addr(port, &ifa->ifa_local, false);
+			if (r < 0)
+				return r;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	in6_dev = __in6_dev_get(port->dev);
+	if (in6_dev)
+		list_for_each_entry_rcu(ifa6, &in6_dev->addr_list, if_list) {
+			r = ipvlan_port_add_addr(port, &ifa6->addr, true);
+			if (r < 0)
+				return r;
+		}
+#endif
+	return r;
+}
+
+static void ipvlan_port_free_port_addrs(struct ipvl_port *port)
+{
+	struct ipvl_port_addr *addr, *next;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry_safe(addr, next, &port->port_addrs, anode) {
+		list_del_rcu(&addr->anode);
+		kfree_rcu(addr, rcu);
+	}
+}
+
 static int ipvlan_port_create(struct net_device *dev)
 {
 	struct ipvl_port *port;
@@ -172,12 +281,15 @@ static int ipvlan_port_create(struct net_device *dev)
 	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
+	INIT_LIST_HEAD(&port->port_addrs);
 	spin_lock_init(&port->addrs_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
 	port->dev_id_start = 1;
 
+	ipvlan_port_enum_addrs(port);
+
 	err = netdev_rx_handler_register(dev, ipvlan_handle_frame, port);
 	if (err)
 		goto err;
@@ -191,6 +303,7 @@ static int ipvlan_port_create(struct net_device *dev)
 	return 0;
 
 err:
+	ipvlan_port_free_port_addrs(port);
 	kfree(port);
 	return err;
 }
@@ -212,6 +325,7 @@ static void ipvlan_port_destroy(struct net_device *dev)
 		kfree_skb(skb);
 	}
 	ida_destroy(&port->ida);
+	ipvlan_port_free_port_addrs(port);
 	kfree(port);
 }
 
@@ -1010,6 +1124,50 @@ void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 	kfree_rcu(addr, rcu);
 }
 
+static void ipvlan_port_del_addr_ipvlans(struct ipvl_port *port,
+					 const void *iaddr, bool is_v6)
+{
+	struct ipvl_addr *addr = NULL;
+	struct ipvl_dev *ipvlan;
+
+	list_for_each_entry_rcu(ipvlan, &port->ipvlans, pnode) {
+		spin_lock_bh(&port->addrs_lock);
+		addr = ipvlan_find_addr(ipvlan, iaddr, is_v6);
+		if (addr) {
+			ipvlan_ht_addr_del(addr);
+			list_del_rcu(&addr->anode);
+			spin_unlock_bh(&port->addrs_lock);
+			break;
+		}
+		spin_unlock_bh(&port->addrs_lock);
+	}
+
+	if (addr)
+		kfree_rcu(addr, rcu);
+}
+
+static int ipvlan_port_add_addr_event(struct ipvl_port *port,
+				      const void *iaddr, bool is_v6)
+{
+	int r;
+
+	r = ipvlan_port_add_addr(port, iaddr, is_v6);
+	if (r < 0)
+		return r;
+
+	ipvlan_port_del_addr_ipvlans(port, iaddr, is_v6);
+
+	return NOTIFY_OK;
+}
+
+static int ipvlan_port_del_addr_event(struct ipvl_port *port,
+				      const void *iaddr, bool is_v6)
+{
+	ipvlan_port_del_addr(port, iaddr, is_v6);
+
+	return NOTIFY_OK;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
@@ -1038,6 +1196,24 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 	struct net_device *dev = (struct net_device *)if6->idev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 
+	if (netif_is_ipvlan_port(dev)) {
+		struct ipvl_port *port = ipvlan_port_get_rcu(dev);
+
+		if (!ipvlan_is_macnat(port))
+			return NOTIFY_DONE;
+
+		switch (event) {
+		case NETDEV_UP:
+			return ipvlan_port_add_addr_event(port, &if6->addr,
+							  true);
+		case NETDEV_DOWN:
+			return ipvlan_port_del_addr_event(port, &if6->addr,
+							  true);
+		default:
+			return NOTIFY_OK;
+		}
+	}
+
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
@@ -1110,6 +1286,26 @@ static int ipvlan_addr4_event(struct notifier_block *unused,
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct in_addr ip4_addr;
 
+	if (netif_is_ipvlan_port(dev)) {
+		struct ipvl_port *port = ipvlan_port_get_rcu(dev);
+
+		if (!ipvlan_is_macnat(port))
+			return NOTIFY_DONE;
+
+		switch (event) {
+		case NETDEV_UP:
+			return ipvlan_port_add_addr_event(port,
+							  &if4->ifa_address,
+							  false);
+		case NETDEV_DOWN:
+			return ipvlan_port_del_addr_event(port,
+							  &if4->ifa_address,
+							  false);
+		default:
+			return NOTIFY_OK;
+		}
+	}
+
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
-- 
2.25.1


