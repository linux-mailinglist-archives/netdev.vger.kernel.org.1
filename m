Return-Path: <netdev+bounces-202577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9837AEE4D9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D49F18988D7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0242900B2;
	Mon, 30 Jun 2025 16:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC628FFEC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301753; cv=none; b=MlBul6/GsGWxeH+rqMY2JSmXABFGzlxbcHDj1XPA/cUY2iaFJSWEdG1UcZIoT4r6cWXquO903IMxarPGlHfEAm21Z5TAa15Pq5Dwohl1hXiDIpBzs/bwILHFrj0BXf3HWxALekXd079nalUdmyY4GS1Kuo9G2UdNOvgEMmAgEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301753; c=relaxed/simple;
	bh=e6gu8kppvkVMD/xiFfa9P8SrzVpJGusodKuuVFNY7qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP/Gk6SYxUgL2TbtX/XzFNEz/4jNYMoGK4FW8AkoLBD1+K9tHsKV/X8utlEsEDVexsfdCtd+815NWknnYnSze3D28PlxYUxbE2DgbRsMogD9Xfg+7MTtSQ8whv+2Zf0mYtEqhCiiUOMmy1fkCpIbARH/zaFi2gBjRSw+bOSUE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso19978655ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301751; x=1751906551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJCS+ao8Xhj12sZylwaVZVSOZFbjMsK5DtPTgsdyY3w=;
        b=En+QsTRfCkJ9J9HKjgI0SgnEkwqiIF+zFVzLUL+wlqW4TLmMO6r0hgQRgFggmBKURZ
         nqELul7JHDsMbn5GFD1YFPn2BVR1138Svkz9lPYPgthQUZlm/QOPqy9gdfHV7jWSXPx7
         wS7HuLwemTahyfQYZxoxacRVZSteW9914JJ6rzyoKIxhxswTT2KfR/aJT3zXjiQzwCIr
         8Tc5+SZ6l6b+871yRuDcJ8jUQYrY8Xnx2qZeXWDcFOm9c2EwviEKcJY825ozO1AL8q9q
         gmjGB/JJGVqAgybhhqrYz6DvVrn0ckI3gBzd7TW0p1VAqOuQXuYAgUiRC2HV1HPA++/n
         d11g==
X-Gm-Message-State: AOJu0YwZPyxmIpEzN4tcsv1/7bxiU4yP2Zn1ixHlBcEuPmGNHA0TSdqK
	s0sh4D3Y/JgXba9DOWI4KMcqKjmfJjNaOYfJPbqHefR7zfIU4GWTf9eZyNu9
X-Gm-Gg: ASbGncvifsWj0ivdSq/MqHmrmHoo0eZ/RxS9+6UwuAjGr6jwqmh25BSRzM4UO7QZ7c5
	mP6UHaVDGojkuW9QHt1uvgWbqq2LWjMp7Tjh6gXgQUpkjLAbujNN0MPguhr2g0w+2/mROq4MUk3
	hKCLpxGCoKA/OhL395hHLpqhPmrbYlPAiZEVx2/zAuCNr7G6elB89LtDUho/3LoKSvDkgdu1uzy
	qUW4wDPeMAwdv0ofr5/NN0kY0UjAOgN8r3WxXITD9DOSWEYSSx9qzMGwlfr0S7PAafbkXoymP67
	b3dFSKOSCO240aeXx8GiGiJFCGOP8fO7WVuUOn+8ZqwxTaMlSvp9CsUkkmvcHNK7OxSG7bV/bYQ
	BB5AQRO8kaPiHQPm4scN3uQU=
X-Google-Smtp-Source: AGHT+IH/8OXZgbs4ZX/tbm+awHinVDvS4S3sq3k4Vx6LtAitUXfOznQKY9dDCUugFYUcceE3LgJNyw==
X-Received: by 2002:a17:902:d2cf:b0:235:be0:db6b with SMTP id d9443c01a7336-23ac46072cdmr220311335ad.45.1751301750799;
        Mon, 30 Jun 2025 09:42:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39b8easm83219425ad.96.2025.06.30.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:42:28 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 4/8] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Date: Mon, 30 Jun 2025 09:42:18 -0700
Message-ID: <20250630164222.712558-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630164222.712558-1-sdf@fomichev.me>
References: <20250630164222.712558-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

netif_pre_changeaddr_notify is used only by ipvlan/bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c  |  4 +++-
 drivers/net/ipvlan/ipvlan_main.c |  8 +++++---
 include/linux/netdevice.h        |  4 ++--
 net/bridge/br.c                  |  6 +++---
 net/bridge/br_if.c               |  3 ++-
 net/core/dev.c                   | 16 ++++++++--------
 net/core/dev_addr_lists.c        |  2 +-
 7 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 43a580a444af..805e50eee979 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -95,6 +95,8 @@
 
 #include "bonding_priv.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 /*---------------------------- Module parameters ----------------------------*/
 
 /* monitor all links that often (in milliseconds). <=0 disables monitoring */
@@ -1038,7 +1040,7 @@ static int bond_set_dev_addr(struct net_device *bond_dev,
 
 	slave_dbg(bond_dev, slave_dev, "bond_dev=%p slave_dev=%p slave_dev->addr_len=%d\n",
 		  bond_dev, slave_dev, slave_dev->addr_len);
-	err = dev_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
+	err = netif_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..c951f0ee3cf9 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -7,6 +7,8 @@
 
 #include "ipvlan.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 				struct netlink_ext_ack *extack)
 {
@@ -784,9 +786,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_PRE_CHANGEADDR:
 		prechaddr_info = ptr;
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
-			err = dev_pre_changeaddr_notify(ipvlan->dev,
-						    prechaddr_info->dev_addr,
-						    extack);
+			err = netif_pre_changeaddr_notify(ipvlan->dev,
+							  prechaddr_info->dev_addr,
+							  extack);
 			if (err)
 				return notifier_from_errno(err);
 		}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2f3fba5c67c2..85c0dec0177e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4213,8 +4213,8 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
 int __dev_set_mtu(struct net_device *, int);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack);
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack);
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 0adeafe11a36..9d3748396795 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -74,9 +74,9 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		if (br->dev->addr_assign_type == NET_ADDR_SET)
 			break;
 		prechaddr_info = ptr;
-		err = dev_pre_changeaddr_notify(br->dev,
-						prechaddr_info->dev_addr,
-						extack);
+		err = netif_pre_changeaddr_notify(br->dev,
+						  prechaddr_info->dev_addr,
+						  extack);
 		if (err)
 			return notifier_from_errno(err);
 		break;
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 2450690f98cf..98c5b9c3145f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -668,7 +668,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		/* Ask for permission to use this MAC address now, even if we
 		 * don't end up choosing it below.
 		 */
-		err = dev_pre_changeaddr_notify(br->dev, dev->dev_addr, extack);
+		err = netif_pre_changeaddr_notify(br->dev, dev->dev_addr,
+						  extack);
 		if (err)
 			goto err6;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index ff7fde1a1ac9..fc3720d11267 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9688,13 +9688,13 @@ void netif_set_group(struct net_device *dev, int new_group)
 }
 
 /**
- *	dev_pre_changeaddr_notify - Call NETDEV_PRE_CHANGEADDR.
- *	@dev: device
- *	@addr: new address
- *	@extack: netlink extended ack
+ * netif_pre_changeaddr_notify() - Call NETDEV_PRE_CHANGEADDR.
+ * @dev: device
+ * @addr: new address
+ * @extack: netlink extended ack
  */
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack)
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack)
 {
 	struct netdev_notifier_pre_changeaddr_info info = {
 		.info.dev = dev,
@@ -9706,7 +9706,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 	rc = call_netdevice_notifiers_info(NETDEV_PRE_CHANGEADDR, &info.info);
 	return notifier_to_errno(rc);
 }
-EXPORT_SYMBOL(dev_pre_changeaddr_notify);
+EXPORT_SYMBOL_NS_GPL(netif_pre_changeaddr_notify, "NETDEV_INTERNAL");
 
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
@@ -9720,7 +9720,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
+	err = netif_pre_changeaddr_notify(dev, ss->__data, extack);
 	if (err)
 		return err;
 	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 90716bd736f3..76c91f224886 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -603,7 +603,7 @@ int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 
 	ASSERT_RTNL();
 
-	err = dev_pre_changeaddr_notify(dev, addr, NULL);
+	err = netif_pre_changeaddr_notify(dev, addr, NULL);
 	if (err)
 		return err;
 	err = __hw_addr_add(&dev->dev_addrs, addr, dev->addr_len, addr_type);
-- 
2.49.0


