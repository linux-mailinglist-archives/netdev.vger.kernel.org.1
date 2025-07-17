Return-Path: <netdev+bounces-207985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E2B0931B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC371C47582
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625C2FE337;
	Thu, 17 Jul 2025 17:23:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DA2FE313
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773020; cv=none; b=Q9dpZwWPS8V1GOhUfDVrXcCu8WxL9hTQ9LcSZaTCtGvCAxHGnys+Q+486FtPoKt/6emRWjfTbjm0piV96mgzzrPJ1CMm4MSAyqguW6/SujDXYx73+YiYAqSYdgYvGYn35a7du6SmB6RzKPW7ulOvRlHF9DbWv77I7EYyFLBbGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773020; c=relaxed/simple;
	bh=Ba2Tp+UsirhhBcane7mdEb+fGJyqIKa8d/GegG03R4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWrfaOT2h+99V+uDlOEGsWXpxbfMnuhuEWIv/a2rZUo9zF2rWu+N3zwoVe8eXmNEC2rgReun3d1ro7WlJ3aml2MUAMp1gwdZ2H5k39XhJ69a9LfFMh1kwJznHUYHktc02a7pqIJ6/6q/MTXTaAhCRYpVSglDuk718cGUyVVT+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234f17910d8so11564085ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773018; x=1753377818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt0iapPhusZg7jVvAyFhG+n1rv4TClO0P8Zr4R+yVso=;
        b=OPM3fk7jqrh7k49UwES0j7DjMRh26F+4KBnngq/0dmPlze7X8ZUBZsfamOSYGY4NBT
         23Ivd/aOPLEo2eYrG9PKGz7P4DT3H4b2OLPljT5GP55D8ytJPOEdiMRFm1zWJGTeAlfu
         ETFU66vV22zR0VW2DMk3HgM4XQJVaSwoWwS0BahUZe/hjfcoydz9day9CIo/1EZpf3ez
         f50sso7G3PYan1vw2tQCGedFMOrpJYko4x8m+hwcDq8ltd4tvGFbDr4gGR3Hvb7ei+oY
         Hu7kH7b+uOPTZN9C96RAbS4Ie4TlzzqEnmpOJaeSabtXEP2jhstkAVjeyRQV5nQpOToK
         0imQ==
X-Gm-Message-State: AOJu0YwcFfVWYMiE/rLvTuo/Un9I8wip080i1gZMrPGVTDc1zSvWieSq
	XWhBcUw1+o6ug9iJS6fCiV4Gof1ZX13QtAmBGxus8wwkT8/Y2q0bvTaEiyhr
X-Gm-Gg: ASbGnctMq0Yyv8BWf+F8Z+q/9cUNeNEcsJzhFT8rqvNxUOqlBvLBRgjXafZTmf0JyV1
	e+ILCEKRaenWl5qfxu00VLJOR/qo3VqiQE9t/9dHNnuz6Iob2Qr7PqcnksTwbXBZvR3l4DBx0j4
	lvQaZXX1gsnOlbrMel0uvAyQH/PrtohZNSAKcQ2siLsIGGenwd6s7yu/OJH6yFD3ZykHw6ozT0Q
	5qdYNPtmJ6biOaRA12xyP7OxpSko7lEwzD/YpYBCflwbJiPjdZuHwCC/N7lARapieaqjE/GLgDl
	59rMYzUEwODz+dwSHgI09u0lqdVrJ6dopQQxBMnF8is4pjfuQ6Jq0rrOO7mzLCA1t+HpvivzoFV
	jpRGtkMDL1iefAQo9Ly5w0p5hdaoy5AJUYSvMqxmMEiKo9AqWYZIDSb21w7M=
X-Google-Smtp-Source: AGHT+IGPTPkum6f+VrEy/2uVviY3He4y0REw4SqPPb359Z4ghg74V2f7gKeb6cfCjV2glzRfjmYvGw==
X-Received: by 2002:a17:903:3bc6:b0:234:9068:ed99 with SMTP id d9443c01a7336-23e24f44f05mr152114195ad.24.1752773017519;
        Thu, 17 Jul 2025 10:23:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de434d5a7sm143569935ad.204.2025.07.17.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:37 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 3/7] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Date: Thu, 17 Jul 2025 10:23:29 -0700
Message-ID: <20250717172333.1288349-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717172333.1288349-1-sdf@fomichev.me>
References: <20250717172333.1288349-1-sdf@fomichev.me>
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
 drivers/net/bonding/bond_main.c  |  3 ++-
 drivers/net/ipvlan/ipvlan_main.c |  7 ++++---
 include/linux/netdevice.h        |  4 ++--
 net/bridge/br.c                  |  7 ++++---
 net/bridge/br_if.c               |  3 ++-
 net/core/dev.c                   | 18 ++++++++++--------
 net/core/dev_addr_lists.c        |  2 +-
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17c7542be6a5..d8281c486a44 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1040,7 +1040,7 @@ static int bond_set_dev_addr(struct net_device *bond_dev,
 
 	slave_dbg(bond_dev, slave_dev, "bond_dev=%p slave_dev=%p slave_dev->addr_len=%d\n",
 		  bond_dev, slave_dev, slave_dev->addr_len);
-	err = dev_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
+	err = netif_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
 	if (err)
 		return err;
 
@@ -6743,3 +6743,4 @@ module_exit(bonding_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR("Thomas Davis, tadavis@lbl.gov and many others");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..660f3db11766 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -784,9 +784,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
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
@@ -1094,3 +1094,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
 MODULE_DESCRIPTION("Driver for L3 (IPv6/IPv4) based VLANs");
 MODULE_ALIAS_RTNL_LINK("ipvlan");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b3a48934b4cb..55c5cd9d1929 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4214,8 +4214,8 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
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
index 0adeafe11a36..1885d0c315f0 100644
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
@@ -484,3 +484,4 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(BR_VERSION);
 MODULE_ALIAS_RTNL_LINK("bridge");
 MODULE_DESCRIPTION("Ethernet bridge driver");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
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
index 71597252313c..09851f042b86 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9712,13 +9712,15 @@ void netif_set_group(struct net_device *dev, int new_group)
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
+ *
+ * Return: 0 on success, -errno on failure.
  */
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack)
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack)
 {
 	struct netdev_notifier_pre_changeaddr_info info = {
 		.info.dev = dev,
@@ -9730,7 +9732,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 	rc = call_netdevice_notifiers_info(NETDEV_PRE_CHANGEADDR, &info.info);
 	return notifier_to_errno(rc);
 }
-EXPORT_SYMBOL(dev_pre_changeaddr_notify);
+EXPORT_SYMBOL_NS_GPL(netif_pre_changeaddr_notify, "NETDEV_INTERNAL");
 
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
@@ -9744,7 +9746,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
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
2.50.1


