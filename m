Return-Path: <netdev+bounces-240520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647FC75D39
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E319355BBF
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95E33C50F;
	Thu, 20 Nov 2025 17:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38E2EAD10;
	Thu, 20 Nov 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661063; cv=none; b=fyTPJk1buef8S008B6yfHURYZNfNWOD6icS5LyS1vzTLzIxsLmu3yvXh4UVbBmK4ySa3BjX2yNuAbWH4eYpwI57ZE/l2aIukB/Sl6FpcILP77qFWRSyxyBu9nnwzHy79+7XhzKdatdTltDZj0Os2T8zOXyavmS+ZGmKLac8yeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661063; c=relaxed/simple;
	bh=hba8MrbAt8U1meXjPQUVTph4DHCCQrX66Bo9W1zNTio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHKlzjtTl9zfagynZ5g+ABXpT5MxcM51pE30/++RmD2mcIDKM9JQRy/ApyfxfXOu8K3ryGyqDvQZgeXvciaEui/MVgUPVbgRM3O3D73bvPwjaxsUyILF0riD4FkvtwXxjylIrh8H1jUXTnfcS0QuEvyhvFX7YTMYp6jB0vkRLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Tn3srYzJ467v;
	Fri, 21 Nov 2025 01:50:05 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D24C1402EF;
	Fri, 21 Nov 2025 01:50:51 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:50:50 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Etienne Champetier
	<champetier.etienne@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net-next 09/12] ipvlan: Common code from v6/v4 validator_event
Date: Thu, 20 Nov 2025 20:49:46 +0300
Message-ID: <20251120174949.3827500-10-skorodumov.dmitry@huawei.com>
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

Extract commond code for ipvlan_addr4_validator_event()/
ipvlan_addr6_validator_event() to own function

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 67 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 7be0722e688f..ff8f249bb32e 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1153,6 +1153,33 @@ static int ipvlan_port_del_addr_event(struct ipvl_port *port,
 	return NOTIFY_OK;
 }
 
+static int ipvlan_addr_validator_event(struct net_device *dev,
+				       unsigned long event,
+				       struct netlink_ext_ack *extack,
+				       const void *iaddr,
+				       bool is_v6)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+
+	if (!ipvlan_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	if (ipvlan_is_macnat(ipvlan->port))
+		return notifier_from_errno(-EADDRNOTAVAIL);
+
+	switch (event) {
+	case NETDEV_UP:
+		if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
+			NL_SET_ERR_MSG(extack,
+				       "Address already assigned to an ipvlan device");
+			return notifier_from_errno(-EADDRINUSE);
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
@@ -1221,25 +1248,9 @@ static int ipvlan_addr6_validator_event(struct notifier_block *unused,
 {
 	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)i6vi->i6vi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	if (ipvlan_is_macnat(ipvlan->port))
-		return notifier_from_errno(-EADDRNOTAVAIL);
 
-	switch (event) {
-	case NETDEV_UP:
-		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
-			NL_SET_ERR_MSG(i6vi->extack,
-				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
-		}
-		break;
-	}
-
-	return NOTIFY_OK;
+	return ipvlan_addr_validator_event(dev, event, i6vi->extack,
+					   &i6vi->i6vi_addr, true);
 }
 #endif
 
@@ -1315,25 +1326,9 @@ static int ipvlan_addr4_validator_event(struct notifier_block *unused,
 {
 	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
 	struct net_device *dev = (struct net_device *)ivi->ivi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	if (ipvlan_is_macnat(ipvlan->port))
-		return notifier_from_errno(-EADDRNOTAVAIL);
 
-	switch (event) {
-	case NETDEV_UP:
-		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
-			NL_SET_ERR_MSG(ivi->extack,
-				       "Address already assigned to an ipvlan device");
-			return notifier_from_errno(-EADDRINUSE);
-		}
-		break;
-	}
-
-	return NOTIFY_OK;
+	return ipvlan_addr_validator_event(dev, event, ivi->extack,
+					   &ivi->ivi_addr, false);
 }
 
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
-- 
2.25.1


