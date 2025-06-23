Return-Path: <netdev+bounces-200310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF7AE47EF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5D57A1F36
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D049275AE2;
	Mon, 23 Jun 2025 15:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60938256C88
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691303; cv=none; b=dbVgW01rvHhS5cmnAFmaof55A/1sosjU9sp8MNuHw0yOjHMEvRLPr7wmGOeGGeC+b41/kgdpiqRkZ4G9qJb3ZVlqn7atoJZsgmzSvO4aWLFhTQUg3Id8lbMmu6qUQzYCylqHb2ivTSn9FVvd+fJ+7fJbnYGE0J3tGDVFI8HaBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691303; c=relaxed/simple;
	bh=ksVHcuhie3JQk7IJB7u7uuLunzE8ho35JLpVyBR6y94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiH9T/0xCq37VTDSV4uRgyh0HQmbWNTIkCAoJKo4MYbWzBsBmWIvq2Jg34rKcthwzmQ75ieRgDr408iuTu2pQ9gcRCi64OmwLfOvsCafh1fvULVHFtRDnuiIa3v2m4RPleECHeAgpgHMEw08jqjxzDJTgIaYel+QHhkYvje7yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235ef62066eso57642115ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691301; x=1751296101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cGgl9a97ya8viTX+lbl56DYWxQeLEcbDlQJQTAkB3A=;
        b=TWPxUwmph1ro5S0d28eJ8WIMVVbzfn8fELGz/0hhjuWaiasCqQrXE9nc8RJ3Sg+nov
         37x0Ef+/+eEDrgYY5q8fqnJ0pJVMDpzPOK0Z5kcwL+7QsYVKusy9+5+r/O5nlbr9Y9v0
         ZE45UYZLW8GPty5QAH1rBap98QHFzs2T3MBM+7u/YpUmhJVb15Qk8uekVBzn7umucapR
         tqZMdUYuNuOM8vA+ho4bEpXob9i0GnhYb9+yy8CzKBFQ7q5zrtF/zOF//YqpqgAUob3N
         z9Vam55VFEyPOIG/JGQdrBWz58j7yh/8fF7oAyJWSaNaMdYEiQ5o61WHtDoNZrEP6rL8
         CLhg==
X-Gm-Message-State: AOJu0YxCiNFbp76bXO59IrED79m+C6amB7J4KiB1zY+7A1i93YN3TL4H
	/9O0vJk6mhiNfbxKJyR8OEkgTHskKVa/3+gVeuHac9doQO71aZ8lt3D8HAi8
X-Gm-Gg: ASbGnctOjW9P3n/ka63kIjBjC6DITL0G9WZPMDaDxUoNl+2Jmaq+m9YQgs7SSxbHC1t
	cDNXhaajmFYW6ZYwoYb6U61usxzfLYy7eu5dSxILXLTMvsJtZSE5mIhMMu4MWHSaMTHIMzKcogx
	nfsgFlcY8+QWpK2pgTNjts4N2lmSZEJNQArTZqsWmFjmYyHZlj6Q5hdB4BEJvgviK11iUYMqeZv
	I1AqjxqNdwOCvOIIALexsPEMDwCuPW4P6bbK+t2FDtDMzkSCPTkwbIPEqs2J9Zf30GtIeSeKCc5
	eBwrolQQd7PTvldy5g5NVF6reNl4qpxRmEiuy9G5eCP5wzBf+gE2nZomjvoqL0oGQ0l2vQaOJSf
	ySjVqBwz9BxcC8BrF8fNeGAE=
X-Google-Smtp-Source: AGHT+IGn6D0gPxiVgbbZorXDZFYY8V3DexgD6fuJsSFtgbQDw7AypsQFU9N48QN2pgqtmuraWuopAg==
X-Received: by 2002:a17:90b:2651:b0:311:ad7f:329c with SMTP id 98e67ed59e1d1-3159d7c8f9cmr24512948a91.18.1750691301080;
        Mon, 23 Jun 2025 08:08:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8393292sm85568705ad.13.2025.06.23.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 4/8] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Date: Mon, 23 Jun 2025 08:08:10 -0700
Message-ID: <20250623150814.3149231-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain netif vs dev semantics.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c  |  2 +-
 drivers/net/ipvlan/ipvlan_main.c |  6 +++---
 include/linux/netdevice.h        |  4 ++--
 net/bridge/br.c                  |  6 +++---
 net/bridge/br_if.c               |  3 ++-
 net/core/dev.c                   | 16 ++++++++--------
 net/core/dev_addr_lists.c        |  2 +-
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 43a580a444af..17b17584de83 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1038,7 +1038,7 @@ static int bond_set_dev_addr(struct net_device *bond_dev,
 
 	slave_dbg(bond_dev, slave_dev, "bond_dev=%p slave_dev=%p slave_dev->addr_len=%d\n",
 		  bond_dev, slave_dev, slave_dev->addr_len);
-	err = dev_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
+	err = netif_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..3841dd527137 100644
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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f861edc5f539..678ddeada19c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4220,8 +4220,8 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
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
index 0307fa0727aa..750abd345bdc 100644
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
+EXPORT_SYMBOL(netif_pre_changeaddr_notify);
 
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


