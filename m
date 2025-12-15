Return-Path: <netdev+bounces-244821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F62CBF146
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB03D3037E2C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992682BF000;
	Mon, 15 Dec 2025 16:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597E2E7F27;
	Mon, 15 Dec 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817802; cv=none; b=Gb3pHQ8Pg7+V7szWUHwZODcnCqQIJsVywwpoMrMBQl8DL8FW3B+oWtWY8J8UguwWSQZdupW5UpiX1i6xCB+UkneMA/pc2pCnIAm1eASj7PWO4iPmH3uiFbLiA8CqqYeXkEdoGrHrtqYnzG2RgA2mKP6Y+4bnCXLPr3VDfPMoqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817802; c=relaxed/simple;
	bh=+uja6Ajxs+eNWyLshdphoXTFDrhj7cDFAql14wuwdio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f58mhY5kOtC/kOBgVdQOr5FHBiHcqXXpxRs9F7lfgGF5hgAfDGF06zuBfj5N91F9ZcydoJtDYlbr28nXY6vKo940KRvgp9ny95O1JIQeNTuFpCW/AO3Uiz8wSfJdTjxXI39FTVGe4mjL4ukoald1/ksgNRYwC+Ae3/ViIW7pHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVR671ChBzHnH5c;
	Tue, 16 Dec 2025 00:56:15 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id BC97240539;
	Tue, 16 Dec 2025 00:56:36 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 19:56:36 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Xiao Liang <shaw.leon@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Guillaume
 Nault <gnault@redhat.com>, Julian Vetter <julian@outer-limits.org>, Eric
 Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Etienne
 Champetier <champetier.etienne@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net] ipvlan: Make the addrs_lock be per port
Date: Mon, 15 Dec 2025 19:54:46 +0300
Message-ID: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Make the addrs_lock be per port, not per ipvlan dev.

Initial code seems to be written in the assumption,
that any address change must occur under RTNL.
But it is not so for the case of IPv6. So

1) Introduce per-port addrs_lock.

2) It was needed to fix places where it was forgotten
to take lock (ipvlan_open/ipvlan_close)

3) Fix places, where list_for_each_entry_rcu()
was used to iterate the list while holding a lock

This appears to be a very minor problem though.
Since it's highly unlikely that ipvlan_add_addr() will
be called on 2 CPU simultaneously. But nevertheless,
this could cause:

1) False-negative of ipvlan_addr_busy(): one interface
iterated through all port->ipvlans + ipvlan->addrs
under some ipvlan spinlock, and another added IP
under its own lock. Though this is only possible
for IPv6, since looks like only ipvlan_addr6_event() can be
called without rtnl_lock.

2) Race since ipvlan_ht_addr_add(port) is called under
different ipvlan->addrs_lock locks

This should not affect performance, since add/remove IP
is a rare situation and spinlock is not taken on fast
paths.

Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      |  2 +-
 drivers/net/ipvlan/ipvlan_core.c | 12 ++++----
 drivers/net/ipvlan/ipvlan_main.c | 52 ++++++++++++++++++--------------
 3 files changed, 37 insertions(+), 29 deletions(-)

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
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2efa3ba148aa..22cb5ee7a231 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -109,14 +109,14 @@ struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 {
 	struct ipvl_addr *addr, *ret = NULL;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode) {
+	assert_spin_locked(&ipvlan->port->addrs_lock);
+
+	list_for_each_entry(addr, &ipvlan->addrs, anode) {
 		if (addr_equal(is_v6, addr, iaddr)) {
 			ret = addr;
 			break;
 		}
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -125,14 +125,14 @@ bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
 	struct ipvl_dev *ipvlan;
 	bool ret = false;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ipvlan, &port->ipvlans, pnode) {
+	assert_spin_locked(&port->addrs_lock);
+
+	list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 		if (ipvlan_find_addr(ipvlan, iaddr, is_v6)) {
 			ret = true;
 			break;
 		}
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 660f3db11766..b0b4f747f162 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -75,6 +75,7 @@ static int ipvlan_port_create(struct net_device *dev)
 	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
 		INIT_HLIST_HEAD(&port->hlhead[idx]);
 
+	spin_lock_init(&port->addrs_lock);
 	skb_queue_head_init(&port->backlog);
 	INIT_WORK(&port->wq, ipvlan_process_multicast);
 	ida_init(&port->ida);
@@ -181,18 +182,18 @@ static void ipvlan_uninit(struct net_device *dev)
 static int ipvlan_open(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ipvl_port *port = ipvlan->port;
 	struct ipvl_addr *addr;
 
-	if (ipvlan->port->mode == IPVLAN_MODE_L3 ||
-	    ipvlan->port->mode == IPVLAN_MODE_L3S)
+	if (port->mode == IPVLAN_MODE_L3 || port->mode == IPVLAN_MODE_L3S)
 		dev->flags |= IFF_NOARP;
 	else
 		dev->flags &= ~IFF_NOARP;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
+	spin_lock_bh(&port->addrs_lock);
+	list_for_each_entry(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_add(ipvlan, addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&port->addrs_lock);
 
 	return 0;
 }
@@ -206,10 +207,10 @@ static int ipvlan_stop(struct net_device *dev)
 	dev_uc_unsync(phy_dev, dev);
 	dev_mc_unsync(phy_dev, dev);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
+	spin_lock_bh(&ipvlan->port->addrs_lock);
+	list_for_each_entry(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_del(addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 
 	return 0;
 }
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
@@ -817,6 +817,8 @@ static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
+	assert_spin_locked(&ipvlan->port->addrs_lock);
+
 	addr = kzalloc(sizeof(struct ipvl_addr), GFP_ATOMIC);
 	if (!addr)
 		return -ENOMEM;
@@ -847,16 +849,16 @@ static void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
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
 
@@ -878,14 +880,14 @@ static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
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
 
@@ -924,21 +926,24 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)i6vi->i6vi_dev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
 
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
 		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
 			NL_SET_ERR_MSG(i6vi->extack,
 				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
+			ret = notifier_from_errno(-EADDRINUSE);
 		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		break;
 	}
 
-	return NOTIFY_OK;
+	return ret;
 }
 #endif
 
@@ -946,14 +951,14 @@ static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
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
 
@@ -995,21 +1000,24 @@ static int ipvlan_addr4_validator_event(struct notifier_block *unused,
 	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)ivi->ivi_dev->dev;
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
 
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
 		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
 			NL_SET_ERR_MSG(ivi->extack,
 				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
+			ret = notifier_from_errno(-EADDRINUSE);
 		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
 		break;
 	}
 
-	return NOTIFY_OK;
+	return ret;
 }
 
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
-- 
2.25.1


