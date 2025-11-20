Return-Path: <netdev+bounces-240519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36BC75D42
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2591F35FBAE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004833570A6;
	Thu, 20 Nov 2025 17:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FF3242CB;
	Thu, 20 Nov 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661063; cv=none; b=tKcQiUcZVRyJtcmhk+OyOeweSQ8AxvxNi5/syeG4+68QIIww8NlsSMho3FOpjf/8RSD8rFR++l+dkHZaERBhoLSI9QjZy4wEByNr74g1lJm8QFmJpPrI9VGpgyR0AvgV26H0qvMBXKSLJAtSrXCJA4T7Ci/guScKXXC1jASyHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661063; c=relaxed/simple;
	bh=kGW9fkpVdjrY9RcZUEDZPYcHtYCmI6lLJFDUCJCAdmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMNBQuX2vHgl27hdRwahzihFUvWm8yY1Zt8y1Jvt1DU8/OWr9nc0cjPTzD5MeqpcqNjljUqo1sLpD2dKbxblLWfAn2WkcsZxAT5d/A6XQ9kLMt1kr3Uh9fqkVyKLm79QhAaejnA7aBSrNqXLXbNw0ceOYXvO47d4m4XGROAh7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5V35Wt0zHnGhN;
	Fri, 21 Nov 2025 01:50:19 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id E5A561402FD;
	Fri, 21 Nov 2025 01:50:54 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:50:54 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Xiao Liang
	<shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Etienne Champetier
	<champetier.etienne@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net-next 10/12] ipvlan: common code to handle ipv6/ipv4 address events
Date: Thu, 20 Nov 2025 20:49:47 +0300
Message-ID: <20251120174949.3827500-11-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
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

Both IPv4 and IPv6 addr-event functions are very similar. Refactor
to use common funcitons.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 117 ++++++++++---------------------
 1 file changed, 37 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ff8f249bb32e..c0708cddf05f 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1180,33 +1180,39 @@ static int ipvlan_addr_validator_event(struct net_device *dev,
 	return NOTIFY_OK;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
+static int ipvlan_add_addr_event(struct ipvl_dev *ipvlan, const void *iaddr,
+				 bool is_v6)
 {
 	int ret = -EINVAL;
 
 	spin_lock_bh(&ipvlan->port->addrs_lock);
-	if (ipvlan_addr_busy(ipvlan->port, ip6_addr, true))
-		netif_err(ipvlan, ifup, ipvlan->dev,
-			  "Failed to add IPv6=%pI6c addr for %s intf\n",
-			  ip6_addr, ipvlan->dev->name);
-	else
-		ret = ipvlan_add_addr(ipvlan, ip6_addr, true, NULL);
+	if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
+		if (is_v6) {
+			netif_err(ipvlan, ifup, ipvlan->dev,
+				  "Failed to add IPv6=%pI6c on %s intf.\n",
+				  iaddr, ipvlan->dev->name);
+		} else {
+			netif_err(ipvlan, ifup, ipvlan->dev,
+				  "Failed to add IPv4=%pI4 on %s intf.\n",
+				  iaddr, ipvlan->dev->name);
+		}
+	} else {
+		ret = ipvlan_add_addr(ipvlan, iaddr, is_v6, NULL);
+	}
 	spin_unlock_bh(&ipvlan->port->addrs_lock);
 	return ret;
 }
 
-static void ipvlan_del_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
+static void ipvlan_del_addr_event(struct ipvl_dev *ipvlan, const void *iaddr,
+				  bool is_v6)
 {
-	return ipvlan_del_addr(ipvlan, ip6_addr, true);
+	return ipvlan_del_addr(ipvlan, iaddr, is_v6);
 }
 
-static int ipvlan_addr6_event(struct notifier_block *unused,
-			      unsigned long event, void *ptr)
+static int ipvlan_addr_event(struct net_device *dev, unsigned long event,
+			     const void *iaddr, bool is_v6)
 {
-	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
-	struct net_device *dev = (struct net_device *)if6->idev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ipvl_dev *ipvlan;
 
 	if (netif_is_ipvlan_port(dev)) {
 		struct ipvl_port *port = ipvlan_port_get_rcu_rtnl(dev);
@@ -1216,11 +1222,9 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 
 		switch (event) {
 		case NETDEV_UP:
-			return ipvlan_port_add_addr_event(port, &if6->addr,
-							  true);
+			return ipvlan_port_add_addr_event(port, iaddr, is_v6);
 		case NETDEV_DOWN:
-			return ipvlan_port_del_addr_event(port, &if6->addr,
-							  true);
+			return ipvlan_port_del_addr_event(port, iaddr, is_v6);
 		default:
 			return NOTIFY_OK;
 		}
@@ -1229,20 +1233,31 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 	if (!ipvlan_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
+	ipvlan = netdev_priv(dev);
 	switch (event) {
 	case NETDEV_UP:
-		if (ipvlan_add_addr6(ipvlan, &if6->addr))
+		if (ipvlan_add_addr_event(ipvlan, iaddr, is_v6))
 			return NOTIFY_BAD;
 		break;
 
 	case NETDEV_DOWN:
-		ipvlan_del_addr6(ipvlan, &if6->addr);
+		ipvlan_del_addr_event(ipvlan, iaddr, is_v6);
 		break;
 	}
 
 	return NOTIFY_OK;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static int ipvlan_addr6_event(struct notifier_block *unused,
+			      unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
+	struct net_device *dev = (struct net_device *)if6->idev->dev;
+
+	return ipvlan_addr_event(dev, event, &if6->addr, true);
+}
+
 static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 					unsigned long event, void *ptr)
 {
@@ -1254,71 +1269,13 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 }
 #endif
 
-static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
-{
-	int ret = -EINVAL;
-
-	spin_lock_bh(&ipvlan->port->addrs_lock);
-	if (ipvlan_addr_busy(ipvlan->port, ip4_addr, false))
-		netif_err(ipvlan, ifup, ipvlan->dev,
-			  "Failed to add IPv4=%pI4 on %s intf.\n",
-			  ip4_addr, ipvlan->dev->name);
-	else
-		ret = ipvlan_add_addr(ipvlan, ip4_addr, false, NULL);
-	spin_unlock_bh(&ipvlan->port->addrs_lock);
-	return ret;
-}
-
-static void ipvlan_del_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
-{
-	return ipvlan_del_addr(ipvlan, ip4_addr, false);
-}
-
 static int ipvlan_addr4_event(struct notifier_block *unused,
 			      unsigned long event, void *ptr)
 {
 	struct in_ifaddr *if4 = (struct in_ifaddr *)ptr;
 	struct net_device *dev = (struct net_device *)if4->ifa_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct in_addr ip4_addr;
-
-	if (netif_is_ipvlan_port(dev)) {
-		struct ipvl_port *port = ipvlan_port_get_rcu_rtnl(dev);
-
-		if (!ipvlan_is_macnat(port))
-			return NOTIFY_DONE;
-
-		switch (event) {
-		case NETDEV_UP:
-			return ipvlan_port_add_addr_event(port,
-							  &if4->ifa_address,
-							  false);
-		case NETDEV_DOWN:
-			return ipvlan_port_del_addr_event(port,
-							  &if4->ifa_address,
-							  false);
-		default:
-			return NOTIFY_OK;
-		}
-	}
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
 
-	switch (event) {
-	case NETDEV_UP:
-		ip4_addr.s_addr = if4->ifa_address;
-		if (ipvlan_add_addr4(ipvlan, &ip4_addr))
-			return NOTIFY_BAD;
-		break;
-
-	case NETDEV_DOWN:
-		ip4_addr.s_addr = if4->ifa_address;
-		ipvlan_del_addr4(ipvlan, &ip4_addr);
-		break;
-	}
-
-	return NOTIFY_OK;
+	return ipvlan_addr_event(dev, event, &if4->ifa_address, false);
 }
 
 static int ipvlan_addr4_validator_event(struct notifier_block *unused,
-- 
2.25.1


