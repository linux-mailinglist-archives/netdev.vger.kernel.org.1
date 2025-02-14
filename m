Return-Path: <netdev+bounces-166475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A2DA361E0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDD718961D8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747D2676EB;
	Fri, 14 Feb 2025 15:34:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CB266F05
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547292; cv=none; b=Z1oQqo5tnUJKXYiSe8c4dRYAwq0MCHvwqYmzWeiMIgvUmOupHS0HQlk9/qu7IolVwGTczRfTPlvG7yB6dHO9AqtI4xykrY7wxZJKzPaQ2aa11V4mE5gIkXWxButEAzkUtFsl4Wtj+TgmxCeOYct4xJDwUcrTa9Zvuz38MjSLGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547292; c=relaxed/simple;
	bh=Kytw/LYRvj8i/tvpULX/cyszBCZQCtyLPa3n9ShgZ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSJNBa2MAfWkj70hfKSC8dgaqo1awCVkLuRoqSizhgeoaI0tu2crW1Ej95462ureWN3zdIAMCDa/at7UVsxJUOmOfHYPV8MEs632Y+x5M/vsKReOVeV+8LB38V4xvAUguO7x/D7NHEH2PsKsTrMMp2hMsN3l86C4KBeZUq4kuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3281695a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547289; x=1740152089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QNUBLOTQkeaIRCnw5oHHHnBbP+x4osHckmpDKI5G1o=;
        b=qhme4EQtpga9NHXFjfiSYWF6a3eIr2yK4WpopfItpTg08ima7a5spER135ZgTq10WA
         NpWbH8wdjYqW7Th+j0d0+GvjrtoDyRp21zTP+SAzOYVMgUKYFqU9iMCZgvYdJn+T7Dc+
         hOj2LNKYCX5g+Hb439cS/OwNKzZTpJ1b+4mUaqCbHtOSg/JBFIE+hxdokCWmRJnVTAoz
         f0jz4U+FECU+yJgu+s/VsQWNYu3qPpXMKsRHAgMpI5mGlYEsJ/O53XzQ77oYXzO3UHms
         VDOgJzUmt0wuZBWXVQWffiqn9wkL6ym//SpMlnK6lskQviT8JkNs27CKxqKmmkL956Eo
         4j7A==
X-Gm-Message-State: AOJu0YwEe7MYTkkiyGbWoqwzc/JTRv3J+vuJEUIAWJV+o2ZegspUsfM+
	FoeHg6vGeQX1qnBlJ/0JBAug86noVOy+gcuYAtyLJQW59fZpH6NcNsfh
X-Gm-Gg: ASbGnctOnihgG/NipO1qVK6gXh2yuBrfBCBd6U1VZTyMxqK24a5lctRc24PWNxj6YH5
	iQXYqjqYsZIr9XsiyosyGbvHX5w8IQTzcJDu4sdQoFUei0kgEk+7zJmx/KL2sEfZMRmn3AWQLnq
	gsoKEcurr39RK6nVVYoDTLm3QtmZtqMiP6EiEqR1AEQQTfKozJyJncavnbaWRwQYcBhWHGrfXZ3
	BDzUniKpMrEeg3ixLh2/dsIHfaVHBWPjTMU8kDV9ZKdHfAnw1dAVmi54C27x8mo+PA3fycc/g9T
	6k96xbZM4IuiGM0=
X-Google-Smtp-Source: AGHT+IFcTa4uYW3XmUmMa0FAdv5LjA5o7kCWWj5ohClQxGYZKqsP7/F0myVbx+KD036zdEhWeZkJ6Q==
X-Received: by 2002:a17:90b:2f03:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2fbf5bc0254mr16198995a91.6.1739547289402;
        Fri, 14 Feb 2025 07:34:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ab103dsm3253646a91.6.2025.02.14.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:48 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 06/11] net: hold netdev instance lock during sysfs operations
Date: Fri, 14 Feb 2025 07:34:35 -0800
Message-ID: <20250214153440.1994910-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
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
index 67d6417fbb39..ccd41f2fc3db 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3332,6 +3332,7 @@ void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data);
+void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
@@ -4201,6 +4202,8 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
+int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
@@ -4960,6 +4963,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 2aaed0baba45..949b2f29b4ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1728,15 +1728,7 @@ int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
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
@@ -1747,10 +1739,12 @@ void dev_disable_lro(struct net_device *dev)
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
@@ -5974,7 +5968,7 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			dev_disable_lro(dev);
+			netif_disable_lro(dev);
 			dev_disable_gro_hw(dev);
 		}
 		break;
@@ -8997,7 +8991,7 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 }
 EXPORT_SYMBOL(dev_set_promiscuity);
 
-static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
@@ -9032,25 +9026,6 @@ static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
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
@@ -9183,7 +9158,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		int inc = (flags & IFF_ALLMULTI) ? 1 : -1;
 
 		dev->gflags ^= IFF_ALLMULTI;
-		__dev_set_allmulti(dev, inc, false);
+		netif_set_allmulti(dev, inc, false);
 	}
 
 	return ret;
@@ -9375,16 +9350,8 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
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
@@ -9408,7 +9375,6 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	add_device_randomness(dev->dev_addr, dev->addr_len);
 	return 0;
 }
-EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
@@ -9418,7 +9384,7 @@ int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
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


