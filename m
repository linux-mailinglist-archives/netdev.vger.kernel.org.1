Return-Path: <netdev+bounces-235868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC475C36E76
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D48667478
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753833C503;
	Wed,  5 Nov 2025 16:15:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE338925;
	Wed,  5 Nov 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359304; cv=none; b=MJn0OR3eEJThPAzG2ErD0/Q15VvxLO3f8X7G+6Wl2bL6ZWLJ3hKFPjUaN4CW3qKiA0Tj2WXQao3sI4kaMCJ3pYFTQOa5JhTagqZN8cgkThYyM9mPfqMyEoDj1+qTY2OXAFIMgeWaAMhQEj6KsI46VOkAR1HcmjVr9P4MeR2QeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359304; c=relaxed/simple;
	bh=Qzk3zOQVHx7u75n+hDorZCpL4aZAbklq6u7pa1taI7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhoPoOeSs6C/M8RwC52OzJe3BGQbn5PyG0TWETa2DWOr2G94A+P5J9IYsYxIgHF0tJA9zVm+Y8wrsEdtJDyOWdI7aFM1rxKN6J6tttWKF2celRd7N0il7c5XQ/fbi5yso+sh9+HlmM6mHZnsnxgeVvOjgj5eKaLlnhp5+TJ2B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1r0X1vBHz6L4wf;
	Thu,  6 Nov 2025 00:11:08 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id E9A05140371;
	Thu,  6 Nov 2025 00:15:00 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:15:00 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/14] ipvlan: Forget all IP when device goes down
Date: Wed, 5 Nov 2025 19:14:41 +0300
Message-ID: <20251105161450.1730216-6-skorodumov.dmitry@huawei.com>
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

When ipvlan interface goes down, forget all learned addresses.

This is a way to cleanup addresses when master dev switches to
another network.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 49 ++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 8ccf35a24e95..18a69b4fb58c 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -741,14 +741,10 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_new);
 
-void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+static void ipvlan_addrs_forget_all(struct ipvl_dev *ipvlan)
 {
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_addr *addr, *next;
 
-	if (ipvlan_is_macnat(ipvlan->port))
-		dev_set_allmulti(dev, -1);
-
 	spin_lock_bh(&ipvlan->addrs_lock);
 	list_for_each_entry_safe(addr, next, &ipvlan->addrs, anode) {
 		ipvlan_ht_addr_del(addr);
@@ -756,6 +752,16 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 		kfree_rcu(addr, rcu);
 	}
 	spin_unlock_bh(&ipvlan->addrs_lock);
+}
+
+void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	if (ipvlan_is_macnat(ipvlan->port))
+		dev_set_allmulti(dev, -1);
+
+	ipvlan_addrs_forget_all(ipvlan);
 
 	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
@@ -813,6 +819,19 @@ int ipvlan_link_register(struct rtnl_link_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ipvlan_link_register);
 
+static bool ipvlan_is_valid_dev(const struct net_device *dev)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	if (!netif_is_ipvlan(dev))
+		return false;
+
+	if (!ipvlan || !ipvlan->port)
+		return false;
+
+	return true;
+}
+
 static int ipvlan_device_event(struct notifier_block *unused,
 			       unsigned long event, void *ptr)
 {
@@ -824,6 +843,13 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	LIST_HEAD(lst_kill);
 	int err;
 
+	if (event == NETDEV_DOWN && ipvlan_is_valid_dev(dev)) {
+		struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+		ipvlan_addrs_forget_all(ipvlan);
+		return NOTIFY_DONE;
+	}
+
 	if (!netif_is_ipvlan_port(dev))
 		return NOTIFY_DONE;
 
@@ -959,19 +985,6 @@ void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 	kfree_rcu(addr, rcu);
 }
 
-static bool ipvlan_is_valid_dev(const struct net_device *dev)
-{
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-
-	if (!netif_is_ipvlan(dev))
-		return false;
-
-	if (!ipvlan || !ipvlan->port)
-		return false;
-
-	return true;
-}
-
 #if IS_ENABLED(CONFIG_IPV6)
 static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
-- 
2.25.1


