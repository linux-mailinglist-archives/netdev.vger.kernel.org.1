Return-Path: <netdev+bounces-164881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A21A2F87A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90A37A2597
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0662257AF4;
	Mon, 10 Feb 2025 19:20:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD7257441
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215254; cv=none; b=Kh89D34l34g+H6+cWWiTl39toPouAQjBr09DsuJHJVd1Ym7Kq9vIvZeWNIie1y+h4p6K/2NreunMHuXyuMXNwHKadve8mhJzqN0RfifNl6II0TTAhHzvmcz3uKp1p5z1++OMY16au/zS5TcOMPblD424NkENp5iV6e2+rWpY/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215254; c=relaxed/simple;
	bh=oeGAFGL0YipG/wePfOLqRgDQd+7zAbQt0mH02sf+TsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7pRjNVPd/8qkEZPM4Aj17NBUlvDGsj0XgC6xLd/m3ZXRl+y5u0w2nfMjk5qnAou6u2+6UnPv3M2jSUpKm+Vmi6dIRYiqqWBA3qY3iuTY/BRy/FU72Mg/GPGDUDukVPjIrUWFrjE/sgw7F/UrFtZ9jz7usqIxkToq9NiMdihlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f7f1e1194so47787965ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215252; x=1739820052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMNaBSpYiLcaszYIETq8H1HfeWZH/Qxg3b7WE42eXYY=;
        b=X8/R0L/OsFGNlg3dA+xVTsVl42/RGfx3+da9FO2ODn7s0Uwnb9IPuJeJh/F1MlyUvH
         LFLqchIXk2F+ptmyux2qw4Ipk4/+Sv9e6W1Qm5sSU3Q394KV7372WCifFN6WcU4Ua89A
         iFHjVrz0p11hJHK+Z46IeduNmQASzAArvew/aFJJX1aolmD7xexkMAD0eCR+orwsHRCo
         kFhs+M1VVWpzeYl/68ju7+UsCJtyPMn68Dn4z2jNm+LB07meBlbtH7qVh9QTtCYU13oF
         X5zS0PXdXvaQ4i5MvSnIKXqisUYI96V01oPKVdy6wjextX8CRP30AQoJfWUS5waUdX68
         4s0A==
X-Gm-Message-State: AOJu0YzuZetGiwqWeYtaE4oEYxUB4nWH6LYNN7DaQdNQqbpoxYSaMd3C
	4x2Pmz6o+JTMtWmBSARNioEaNG9GUKDuqANlrCSFjUMYiI1SvmwDOL5M
X-Gm-Gg: ASbGncsS2MJUgqMm+hvbTpXhPGOE9cWdI/zxYhqKpej8sd441qy/8eU5tfq4e/4L3A/
	+E091rl+LtYhP70/gcuqH14Ax1n16qCO4x79jUl1TqujI749+GjazbpUadfb8EMspP5BdQQbno2
	7Ku7uR1XPsIhm7rNGx3Ox662B5LDtL1MLKVGsfb7moga3vNASqQw7ygWc+duj+8CdmE8M9WkXie
	FyITFf0A0wkqV9L2W2c3Foeq/hP8VjiEVNWOg2bQMmj7W+CNnp8sgRZM4tdPaEJ4uao+F3BwIdK
	4y5Ax9h315HcThc=
X-Google-Smtp-Source: AGHT+IEhK/qo7Est8jaiWa1krHykbnVncnXJlGZ+mwLPB4KYpRt/UUhLEsKBP3XDS0TLmft63+TwFA==
X-Received: by 2002:a05:6a21:3416:b0:1e1:af74:a236 with SMTP id adf61e73a8af0-1ee03a9adb5mr25913840637.21.1739215252162;
        Mon, 10 Feb 2025 11:20:52 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-730887b0fa8sm2860582b3a.8.2025.02.10.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:51 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 06/11] net: hold netdev instance lock during sysfs operations
Date: Mon, 10 Feb 2025 11:20:38 -0800
Message-ID: <20250210192043.439074-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of them are already covered by the converted dev_xxx APIs.
Add the locking wrappers for the remaining ones.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c |  7 ++--
 include/linux/netdevice.h       |  4 +++
 net/core/dev.c                  | 60 +++++++------------------------
 net/core/dev_api.c              | 62 +++++++++++++++++++++++++++++++++
 net/core/net-sysfs.c            |  2 ++
 5 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 19775e9d7341..05afda23829f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2644,10 +2644,13 @@ static int __bond_release_one(struct net_device *bond_dev,
 		dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, NULL);
 	}
 
-	if (unregister)
+	if (unregister) {
+		netdev_lock_ops(slave_dev);
 		__dev_set_mtu(slave_dev, slave->original_mtu);
-	else
+		netdev_unlock_ops(slave_dev);
+	} else {
 		dev_set_mtu(slave_dev, slave->original_mtu);
+	}
 
 	if (!netif_is_bond_master(slave_dev))
 		slave_dev->priv_flags &= ~IFF_BONDING;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dc5b95ae58e0..c4f182e4563e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3326,6 +3326,7 @@ void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data);
+void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
@@ -4195,6 +4196,8 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
+int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
@@ -4954,6 +4957,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index ac2f8a9aef50..bc027cc8276a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1730,15 +1730,7 @@ int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 }
 EXPORT_SYMBOL(dev_setup_tc);
 
-/**
- *	dev_disable_lro - disable Large Receive Offload on a device
- *	@dev: device
- *
- *	Disable Large Receive Offload (LRO) on a net device.  Must be
- *	called under RTNL.  This is needed if received packets may be
- *	forwarded to another interface.
- */
-void dev_disable_lro(struct net_device *dev)
+void netif_disable_lro(struct net_device *dev)
 {
 	struct net_device *lower_dev;
 	struct list_head *iter;
@@ -1749,10 +1741,12 @@ void dev_disable_lro(struct net_device *dev)
 	if (unlikely(dev->features & NETIF_F_LRO))
 		netdev_WARN(dev, "failed to disable LRO!\n");
 
-	netdev_for_each_lower_dev(dev, lower_dev, iter)
-		dev_disable_lro(lower_dev);
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		netdev_lock_ops(lower_dev);
+		netif_disable_lro(lower_dev);
+		netdev_unlock_ops(lower_dev);
+	}
 }
-EXPORT_SYMBOL(dev_disable_lro);
 
 /**
  *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
@@ -5976,7 +5970,7 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			dev_disable_lro(dev);
+			netif_disable_lro(dev);
 			dev_disable_gro_hw(dev);
 		}
 		break;
@@ -8999,7 +8993,7 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 }
 EXPORT_SYMBOL(dev_set_promiscuity);
 
-static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
@@ -9034,25 +9028,6 @@ static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
-/**
- *	dev_set_allmulti	- update allmulti count on a device
- *	@dev: device
- *	@inc: modifier
- *
- *	Add or remove reception of all multicast frames to a device. While the
- *	count in the device remains above zero the interface remains listening
- *	to all interfaces. Once it hits zero the device reverts back to normal
- *	filtering operation. A negative @inc value is used to drop the counter
- *	when releasing a resource needing all multicasts.
- *	Return 0 if successful or a negative errno code on error.
- */
-
-int dev_set_allmulti(struct net_device *dev, int inc)
-{
-	return __dev_set_allmulti(dev, inc, true);
-}
-EXPORT_SYMBOL(dev_set_allmulti);
-
 /*
  *	Upload unicast and multicast address lists to device and
  *	configure RX filtering. When the device doesn't support unicast
@@ -9185,7 +9160,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		int inc = (flags & IFF_ALLMULTI) ? 1 : -1;
 
 		dev->gflags ^= IFF_ALLMULTI;
-		__dev_set_allmulti(dev, inc, false);
+		netif_set_allmulti(dev, inc, false);
 	}
 
 	return ret;
@@ -9317,7 +9292,7 @@ int netif_set_mtu(struct net_device *dev, int new_mtu)
 	int err;
 
 	memset(&extack, 0, sizeof(extack));
-	err = netdev_set_mtu_ext_locked(dev, new_mtu, &extack);
+	err = netif_set_mtu_ext(dev, new_mtu, &extack);
 	if (err && extack._msg)
 		net_err_ratelimited("%s: %s\n", dev->name, extack._msg);
 	return err;
@@ -9377,16 +9352,8 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 }
 EXPORT_SYMBOL(dev_pre_changeaddr_notify);
 
-/**
- *	dev_set_mac_address - Change Media Access Control Address
- *	@dev: device
- *	@sa: new address
- *	@extack: netlink extended ack
- *
- *	Change the hardware (MAC) address of the device
- */
-int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
-			struct netlink_ext_ack *extack)
+int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			  struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
@@ -9410,7 +9377,6 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	add_device_randomness(dev->dev_addr, dev->addr_len);
 	return 0;
 }
-EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
@@ -9420,7 +9386,7 @@ int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 	int ret;
 
 	down_write(&dev_addr_sem);
-	ret = dev_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, sa, extack);
 	up_write(&dev_addr_sem);
 	return ret;
 }
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index cd8cb04b5a0f..d654db36ecc9 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -239,3 +239,65 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
 	return ret;
 }
 EXPORT_SYMBOL(dev_set_mtu);
+
+/**
+ *	dev_disable_lro - disable Large Receive Offload on a device
+ *	@dev: device
+ *
+ *	Disable Large Receive Offload (LRO) on a net device.  Must be
+ *	called under RTNL.  This is needed if received packets may be
+ *	forwarded to another interface.
+ */
+void dev_disable_lro(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_disable_lro(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(dev_disable_lro);
+
+/**
+ *	dev_set_allmulti	- update allmulti count on a device
+ *	@dev: device
+ *	@inc: modifier
+ *
+ *	Add or remove reception of all multicast frames to a device. While the
+ *	count in the device remains above zero the interface remains listening
+ *	to all interfaces. Once it hits zero the device reverts back to normal
+ *	filtering operation. A negative @inc value is used to drop the counter
+ *	when releasing a resource needing all multicasts.
+ *	Return 0 if successful or a negative errno code on error.
+ */
+
+int dev_set_allmulti(struct net_device *dev, int inc)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_allmulti(dev, inc, true);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_allmulti);
+
+/**
+ *	dev_set_mac_address - Change Media Access Control Address
+ *	@dev: device
+ *	@sa: new address
+ *	@extack: netlink extended ack
+ *
+ *	Change the hardware (MAC) address of the device
+ */
+int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_mac_address(dev, sa, extack);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_mac_address);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3fe2c521e574..35f79a308d7b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1480,8 +1480,10 @@ static ssize_t tx_maxrate_store(struct kobject *kobj, struct attribute *attr,
 		return err;
 
 	err = -EOPNOTSUPP;
+	netdev_lock_ops(dev);
 	if (dev->netdev_ops->ndo_set_tx_maxrate)
 		err = dev->netdev_ops->ndo_set_tx_maxrate(dev, index, rate);
+	netdev_unlock_ops(dev);
 
 	if (!err) {
 		queue->tx_maxrate = rate;
-- 
2.48.1


