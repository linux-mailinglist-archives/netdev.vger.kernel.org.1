Return-Path: <netdev+bounces-235854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59857C36A31
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F161661A7C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873F336EEC;
	Wed,  5 Nov 2025 16:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DF32D0E3;
	Wed,  5 Nov 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358885; cv=none; b=cjPoMbxB069uzXOkFj/pYr/1poGNy2rt1gTgjm2Jn6+p1gU0ZphqCcdFc933qjaxMU7VloI92cffPa1edeoLo5fykaBZahAVxqyd9I979mp0T/SjNQYiR0luS9aDDTjnT5HelwInLZ9EWxkLSyBqROF5iUFxzxNGkmExPxfA2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358885; c=relaxed/simple;
	bh=nNuYNJjV4h1Jom4iGtK47z9Nbz5KXyKpFcLPdflGuCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1tTaNzZpJfe3M975IATSl4OSokTQMmO4/SBc0/7tzQBfw84SPBWhIQ9rmLZ+/QKOkMgpIi6P8vGWpShGToMJhfCw8bCQd7GWW1TVB4q9LgFTqwPUg3K4rso7qhtni3i04QYWzqd3WWqlJqKmWipfBQOpD5SeVW6qxy1AdvVdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1qwr4BkMzHnGkN;
	Thu,  6 Nov 2025 00:07:56 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FA4C1400D9;
	Thu,  6 Nov 2025 00:08:02 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:08:01 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/14] ipvlan: Make the addrs_lock be per port
Date: Wed, 5 Nov 2025 19:07:12 +0300
Message-ID: <20251105160713.1727206-9-skorodumov.dmitry@huawei.com>
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

Also, it's quite convenient to have addrs_lock on
ipvl_port, to dynamically prevent conflict of IPs
with addresses on main port.

CC: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_core.c |  4 ++--
 drivers/net/ipvlan/ipvlan_main.c | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index c690e313ef6b..0ab1797c6128 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -71,7 +71,6 @@ struct ipvl_dev {
 	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
 	netdev_features_t	sfeatures;
 	u32			msg_enable;
-	spinlock_t		addrs_lock;
 };
 
 struct ipvl_addr {
@@ -94,6 +93,7 @@ struct ipvl_port {
 	struct net_device	*dev;
 	possible_net_t		pnet;
 	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
+	spinlock_t		addrs_lock; /* guards hash-table and addrs */
 	struct list_head	ipvlans;
 	struct packet_type	ipvl_ptype;
 	u16			mode;
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 659aed8fc4ff..a952a257a791 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -476,7 +476,7 @@ static void __ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *addr, bool is_v6,
 	struct ipvl_addr *ipvladdr, *oldest = NULL;
 	unsigned int naddrs = 0;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 
 	if (ipvlan_addr_busy(ipvlan->port, addr, is_v6))
 		goto out_unlock;
@@ -499,7 +499,7 @@ static void __ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *addr, bool is_v6,
 	ipvlan_add_addr(ipvlan, addr, is_v6, hwaddr);
 
 out_unlock:
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	if (oldest)
 		kfree_rcu(oldest, rcu);
 }
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ec53cc0ada3b..56f65ac8ecef 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -172,6 +172,7 @@ static int ipvlan_port_create(struct net_device *dev)
 	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
+	spin_lock_init(&port->addrs_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -686,7 +687,6 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (!tb[IFLA_MTU])
 		ipvlan_adjust_mtu(ipvlan, phy_dev);
 	INIT_LIST_HEAD(&ipvlan->addrs);
-	spin_lock_init(&ipvlan->addrs_lock);
 
 	/* Flags are per port and latest update overrides. User has
 	 * to be consistent in setting it just like the mode attribute.
@@ -770,13 +770,13 @@ static void ipvlan_addrs_forget_all(struct ipvl_dev *ipvlan)
 {
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
 }
 
 void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
@@ -997,16 +997,16 @@ void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
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
 
@@ -1015,14 +1015,14 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip6_addr, true))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv6=%pI6c addr for %s intf\n",
 			  ip6_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip6_addr, true, NULL);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
@@ -1086,14 +1086,14 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
 {
 	int ret = -EINVAL;
 
-	spin_lock_bh(&ipvlan->addrs_lock);
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	if (ipvlan_addr_busy(ipvlan->port, ip4_addr, false))
 		netif_err(ipvlan, ifup, ipvlan->dev,
 			  "Failed to add IPv4=%pI4 on %s intf.\n",
 			  ip4_addr, ipvlan->dev->name);
 	else
 		ret = ipvlan_add_addr(ipvlan, ip4_addr, false, NULL);
-	spin_unlock_bh(&ipvlan->addrs_lock);
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
-- 
2.25.1


