Return-Path: <netdev+bounces-243217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C14C9BBB5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8438A4E3F11
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130132143C;
	Tue,  2 Dec 2025 14:12:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42D3242A3;
	Tue,  2 Dec 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684746; cv=none; b=mkM0Fgb+mgheOdTTicRNeNN6G7FoU4f7eHkXsQQfVyvQJPHLl0X6cqQkItoniYnvn3EjCBbzKedmS0p5TJYReTamjD4i8GklJt56d/VjpD4ZIB/vYjF05z+/Al89LixYtqDJ1b0cVL8cNi1KSSM5/GczGADLeoYwtKGB0bLhK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684746; c=relaxed/simple;
	bh=/r90uZyF8pFJI7wl+QmkuXm1IgRY/BNnBWhpuwxrCBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsdU+Gic+XepzB4mCGHpL+vq12blO8vW98BK9cT5W05TMNz32MR6s+Qh+9k2OknmoKuct0Gmg0WwycBBd0QN45u98lAq3RMobU6U9XQ5FvLoXWBW1mzXN26pcFt8f6VxsnThaot7XLESMLrGDaOKgOzu9jMWd0mCRBuz6yx+DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLN3t6p6HzHnGhc;
	Tue,  2 Dec 2025 22:11:22 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 6648240565;
	Tue,  2 Dec 2025 22:12:21 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 17:12:20 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Xiao Liang <shaw.leon@gmail.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Etienne Champetier
	<champetier.etienne@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 1/2] ipvlan: Make the addrs_lock be per port
Date: Tue, 2 Dec 2025 17:11:48 +0300
Message-ID: <20251202141149.4144248-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
References: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
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

Make the addrs_lock be per port, not per ipvlan dev.

This appears to be a very minor problem though.
Since it's highly unlikely that ipvlan_add_addr() will
be called on 2 CPU simultaneously. But nevertheless,
this may cause:

1. False-negative of ipvlan_addr_busy(): one interface
iterated through all port->ipvlans + ipvlan->addrs
under some ipvlan spinlock, and another added IP
under its own lock. Though this is only possible
for IPv6, since looks like only ipvlan_addr6_event() can be
called without rtnl_lock.

2. Race since ipvlan_ht_addr_add(port) is called under
different ipvlan->addrs_lock locks

This should not affect performance, since add/remove IP
is a rare situation and spinlock is not locked on fast
paths.

Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_main.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 50de3ee204db..80f84fc87008 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -69,7 +69,6 @@ struct ipvl_dev {
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
-	spinlock_t		addrs_lock;
 };
 
 struct ipvl_addr {
@@ -90,6 +89,7 @@ struct ipvl_port {
 	struct net_device	*dev;
 	possible_net_t		pnet;
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
+	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
 	u16			mode;
 	u16			flags;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 660f3db11766..c390f4241621 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -75,6 +75,7 @@ static int ipvlan_port_create(struct net_device *dev)
 	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
+	spin_lock_init(&port->addrs_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -579,7 +580,6 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (!tb[IFLA_MTU])
 		ipvlan_adjust_mtu(ipvlan, phy_dev);
 	INIT_LIST_HEAD(&ipvlan->addrs);
-	spin_lock_init(&ipvlan->addrs_lock);
 
 	/* TODO Probably put random address here to be presented to the
 	 * world but keep using the physical-dev address for the outgoing
@@ -657,13 +657,13 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	list_for_each_entry_safe(addr, next, &ipvlan->addrs, anode) {
 		ipvlan_ht_addr_del(addr);
 		list_del_rcu(&addr->anode);
 		kfree_rcu(addr, rcu);
 	}
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 
 	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
@@ -847,16 +847,16 @@ static void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	addr = ipvlan_find_addr(ipvlan, iaddr, is_v6);
 	if (!addr) {
-		spin_unlock_bh(&ipvlan->addrs_lock);
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		return;
 	}
 
 	ipvlan_ht_addr_del(addr);
 	list_del_rcu(&addr->anode);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	kfree_rcu(addr, rcu);
 }
 
@@ -878,14 +878,14 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip6_addr, true))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv6=%pI6c addr for %s intf\n",
 			  ip6_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip6_addr, true);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
@@ -946,14 +946,14 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip4_addr, false))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv4=%pI4 on %s intf.\n",
 			  ip4_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip4_addr, false);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
-- 
2.25.1


