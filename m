Return-Path: <netdev+bounces-239487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58519C68B37
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0213D35D057
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8C3346B2;
	Tue, 18 Nov 2025 10:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482C3314CC;
	Tue, 18 Nov 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460068; cv=none; b=oj2TJz7Rx2+sZTXgimJFHifwBw75JBYJ6fjSJ0qgUDqQwYyd0iT4cA6bFlgPKLm3fZas8yG98V5Re3Ka1ckngixhnDRHOW5e9MVHCzp9G3M9Dnv7g87zu8nISWZVs+e7SLLHHUkHnVBAxkCYawrLydnGubBiFMmoMNhwOOwmcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460068; c=relaxed/simple;
	bh=0388uW1g1G0TRrt5+t5rYCef/axQ4dI2kblZvv1fQvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGGkjFm+mEbn4n3rsVgttUlgFqht6Kc2viYdkr47e//ERpvUBcChB8wcUvMDL+dcla+5ynZQ1TDFkskhgFTBb5mEns7XPQlB2tJbdKTMRL4prxgKvmJGiIwbozDQZds3xQ16nxbI0ySPd+0ZRn7d1TeiPUcK43HILZr1lBExDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9g8h52l3zJ46hC;
	Tue, 18 Nov 2025 18:00:20 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id BC2AC140446;
	Tue, 18 Nov 2025 18:01:02 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 13:01:02 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 10/13] ipvlan: Common code from v6/v4 validator_event
Date: Tue, 18 Nov 2025 13:00:42 +0300
Message-ID: <20251118100046.2944392-11-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
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

Extract commond code for ipvlan_addr4_validator_event()/
ipvlan_addr6_validator_event() to own function

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 67 +++++++++++++++-----------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index e99285bca1cd..e50dd9022557 100644
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


