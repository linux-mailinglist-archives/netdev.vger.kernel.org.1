Return-Path: <netdev+bounces-235877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E35C36ACA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FE368066A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6CA34404B;
	Wed,  5 Nov 2025 16:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BF33F8AB;
	Wed,  5 Nov 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359311; cv=none; b=l/0vEDSigN6yq8iPO0qxJe0adeX+JlXFiz9oOqtH/xrH/synRWrcnFM/wuuIy+I8hOx82Ybzbe+5VZfPbg+57a32M3g67d6zrn7WmmMcgKrjYvHsK2MlCkgbKywIPSXiwXMVSc1tZk6DK8xYKsRxclSXOT7oPn2B4Uy7ClHy6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359311; c=relaxed/simple;
	bh=Te6oDT5N2FvfvUO2P5RtSdbubsvoNc6vc7R7IvQ5r2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMvr+MaKHlKghNS6+6oDyUgafkbMHbiOKJvlFLEm76L8td57yzTJrjrHBuBVRdm+QnftNv2gVpOXRDzOsYhkuQye1L9Ba7HfxXGiTreXjAeYcmoNuL3+ldCjJ0PXx05ETXTo9SxbhSPyN8OWefXCiC1GyDE16L3DHNADTReqYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1r4j3FyDzJ46BG;
	Thu,  6 Nov 2025 00:14:45 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id C8A3314020A;
	Thu,  6 Nov 2025 00:15:06 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:15:06 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 13/14] ipvlan: common code to handle ipv6/ipv4 address events
Date: Wed, 5 Nov 2025 19:14:49 +0300
Message-ID: <20251105161450.1730216-14-skorodumov.dmitry@huawei.com>
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

Both IPv4 and IPv6 addr-event functions are very similar. Refactor
to use common funcitons.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 117 ++++++++++---------------------
 1 file changed, 37 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5b4bfd00544b..bc6db32f59bf 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1195,33 +1195,39 @@ static int ipvlan_addr_validator_event(struct net_device *dev,
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
 		struct ipvl_port *port = ipvlan_port_get_rcu(dev);
@@ -1231,11 +1237,9 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 
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
@@ -1244,20 +1248,31 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
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
@@ -1269,71 +1284,13 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
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
-		struct ipvl_port *port = ipvlan_port_get_rcu(dev);
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


