Return-Path: <netdev+bounces-170981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F69A4AE8B
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF04A3B5F1D
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AD4C81;
	Sun,  2 Mar 2025 00:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20C23774
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874157; cv=none; b=lM/VkLwcegP+dkqRInbAhdR0Pl2sw7BfEJBYhq7RxQFDtCIBSuG3TY396UkE438qZt0HuLcF+zVT1z1IQZmzRSKYWnbVVnY4l/G5PoMzUHyXEw5Ttqx+B3G1v2PJ97UfKz40VNIDT3eqBalqxutvTlafqY9fvhMlZTiLqHJwW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874157; c=relaxed/simple;
	bh=AXuPatgI6JYh65SXbP/s0MAfMkxj9+67nkhCGsyh+SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDP6tkIR/Dz3FQ6WmqGYvOxg+901iyF76HgkC4MFi9qtwxnaWH6dnJJX75ht5TXFTXPMGOmB6F+n03mNjE1yOa+zvanTuD6QX4+lgdpIzRmdflmbq0RMiwrueQxGNFBcQTCR5PHR2G5tXrB+jFtaw6chrqJ020uzvwk4Fpkdi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22339936bbfso49114505ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874153; x=1741478953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GbArhpot/rdRkmXTytt5Baj/3rBns75b0alG0TAw8I=;
        b=uCI0LZr3yQIeMoxVij6+w6x9F/vN9HxMkUEpLtpbfQFR/WUYPs9QVMBqttx8CxKmg+
         CWQb5awRRnEnsr1aSYErxyhGS1DS221QfF4D6LvXoqOCwbbczcMjHul44bGcLLG6Qz1q
         2BUmtBy3s6gjR09cAvMRnyZyCGrpzIEorofokfT57p1o42LSl1kzyd6n8WCboBYDZB9v
         Y7/lB2n8gergwlBVdikUgdVRNjwDWCQLHLHN9ANMKZoXN3BlsCJRkdWI+Oz/8asu6Ca6
         CcFWSiu88OgpHX6PC24cGrRuP1La61FxcxaBbTx42qPqG8ewnH01DBbBvg4VrIXCL196
         p7OQ==
X-Gm-Message-State: AOJu0YxswGHRReUQsbPpYnbugyOz4EH8yrbbBFnH1QA+rE8xVgdRgaNn
	WqPG2uMAE0mCO6uDl5fDB6+QkfgtT16MzAMhUUCXWSmT91bti7yiNciY
X-Gm-Gg: ASbGncsg5o0Gcl8dmIa401ia1CjMZZkMVtERKju3NkIHRQmMSFK/38ac838Ke5dSd+a
	Ke8GZK/a7zOKXu6YL5Jbe9hfQEpsZxm7i3QiVfg7aNzS0ravATp5Gj36Cv97P6OBHZgNc66tFdv
	4oJ/uiye7JbiyeB6HUFm0ZGai/Q6sm5opfKfxdb/1iKOWsEEBPAn8Vbt6jEU62qllgzdfNF3RFc
	qdNqYPwNydOsnidE+oATlgMwE67mPC29+zBzdMKmvC9VQw1HBHrt4infY18WjDd74Ut+WcOpN2t
	wMDSHTDRz56eVeYck3VtqhbXT2Cwii1fbNrHr8++jLAh
X-Google-Smtp-Source: AGHT+IH3M4WFX1bMV9IlGnP/BxBUz01Zjlt3WUO4Gi7TQakz9zyJbuSML1X0czVNg6cQZsxoCB9LGQ==
X-Received: by 2002:a17:902:e750:b0:21f:81f4:21b8 with SMTP id d9443c01a7336-2236926a6e9mr117035045ad.50.1740874153620;
        Sat, 01 Mar 2025 16:09:13 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5bfesm53641505ad.131.2025.03.01.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:13 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 08/14] net: hold netdev instance lock during sysfs operations
Date: Sat,  1 Mar 2025 16:08:55 -0800
Message-ID: <20250302000901.2729164-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302000901.2729164-1-sdf@fomichev.me>
References: <20250302000901.2729164-1-sdf@fomichev.me>
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
 drivers/net/bonding/bond_main.c |  7 +++-
 include/linux/netdevice.h       |  4 ++
 net/core/dev.c                  | 58 ++++++-----------------------
 net/core/dev_api.c              | 65 +++++++++++++++++++++++++++++++++
 net/core/net-sysfs.c            |  2 +
 5 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 916e90d54c0b..d20fc984adb4 100644
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
index 2aabd4ba1471..f95d389959d0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3382,6 +3382,7 @@ void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data);
+void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
@@ -4256,6 +4257,8 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
+int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
@@ -5015,6 +5018,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index d5cf27933699..fd12bb119372 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1757,15 +1757,7 @@ int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
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
@@ -1776,10 +1768,12 @@ void dev_disable_lro(struct net_device *dev)
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
@@ -6038,7 +6032,7 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			dev_disable_lro(dev);
+			netif_disable_lro(dev);
 			dev_disable_gro_hw(dev);
 		}
 		break;
@@ -9210,7 +9204,7 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 }
 EXPORT_SYMBOL(dev_set_promiscuity);
 
-static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
@@ -9245,25 +9239,6 @@ static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
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
@@ -9396,7 +9371,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		int inc = (flags & IFF_ALLMULTI) ? 1 : -1;
 
 		dev->gflags ^= IFF_ALLMULTI;
-		__dev_set_allmulti(dev, inc, false);
+		netif_set_allmulti(dev, inc, false);
 	}
 
 	return ret;
@@ -9588,16 +9563,8 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
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
@@ -9621,7 +9588,6 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	add_device_randomness(dev->dev_addr, dev->addr_len);
 	return 0;
 }
-EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
@@ -9631,7 +9597,7 @@ int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 	int ret;
 
 	down_write(&dev_addr_sem);
-	ret = dev_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, sa, extack);
 	up_write(&dev_addr_sem);
 	return ret;
 }
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 7dae30781411..87a62022ef1c 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -252,3 +252,68 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
 	return ret;
 }
 EXPORT_SYMBOL(dev_set_mtu);
+
+/**
+ * dev_disable_lro() - disable Large Receive Offload on a device
+ * @dev: device
+ *
+ * Disable Large Receive Offload (LRO) on a net device.  Must be
+ * called under RTNL.  This is needed if received packets may be
+ * forwarded to another interface.
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
+ * dev_set_allmulti() - update allmulti count on a device
+ * @dev: device
+ * @inc: modifier
+ *
+ * Add or remove reception of all multicast frames to a device. While the
+ * count in the device remains above zero the interface remains listening
+ * to all interfaces. Once it hits zero the device reverts back to normal
+ * filtering operation. A negative @inc value is used to drop the counter
+ * when releasing a resource needing all multicasts.
+ *
+ * Return: 0 on success, -errno on failure.
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
+ * dev_set_mac_address() - change Media Access Control Address
+ * @dev: device
+ * @sa: new address
+ * @extack: netlink extended ack
+ *
+ * Change the hardware (MAC) address of the device
+ *
+ * Return: 0 on success, -errno on failure.
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
index 8d9dc048a548..27eea34d1b41 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1483,8 +1483,10 @@ static ssize_t tx_maxrate_store(struct kobject *kobj, struct attribute *attr,
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


