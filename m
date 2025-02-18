Return-Path: <netdev+bounces-167180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A4A390B4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B177A3055
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A2214A4C7;
	Tue, 18 Feb 2025 02:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8131494CF
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844601; cv=none; b=K1n8k4whvJfQa+49jhR2GPVISCDE4Nqn8vfnyUFpoDiZ/05A2ELnWNEtxak27v1t7TuaPsrWXYpPzLG55pNZ66Np/LsPJB4QdyxcKs7TXU/9bHzAin9oe36kwet9Z3KiFwndkygKrrMI4gASECE69vCpvnxD/7lyG5sZ7e7psUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844601; c=relaxed/simple;
	bh=+8DFiV7WV+JSLlBnOMmXPHTUUnC2WkZe5RK6lJ2iXrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVTzq4OFawSImPStJEHcFLRxwMRlLhXPTs0A2TZ3H0nWKp2XU6lJEi+hwUBsNNsXtIwqMHUTEqC0fuWI/BdB0QtT8kzfFL1bWNmk3828x4umQAxPFne40+kuWNofFYGWYPeXnEu9j2cjOEmlGhjmJ/l34l6Z5oSLoO3H+9cc96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so9215727a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844599; x=1740449399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgyNoD4mLqEYbqZIkRGBhE4Znn3ajTryWX0ATzCpUrM=;
        b=WzvGMnFHBWqSn8negwYI1GitzbEbyUWrqmvX+hQmX7vvNdKMKA2QQ191CU5jnCGBG+
         643WaFMXE8EuPl62iF6nCMCRUlqhdY3b6e4aB94nVGknTXBXGVXeB3EaJQ1qSLV0BzUO
         2kM1Uik0FzLoUxj5TjfPupJshfugRjgklztkEfy9w1A1XxXSrghr07GYH+v1MFzD8Yon
         GXxdWwYOEx7+ENAq/g/lWm2Ce+sO462axFCQ95kz8m6iKaLcb+UGk9izsonORjsZ0oue
         l4XfPIbUV955Zied7rQKVcwgRQh1hdwfxRMVxYjJUHuHQO5hjg9pionQsf9YvBDtkVbT
         hoxg==
X-Gm-Message-State: AOJu0YxXKT+zc8tp2yPbnETMKakaRvJb301fODPKQBM7o6Yh9vJ0xfmC
	Ho/6tpbskC/Oe6mz8rKFbt3gaJ/FXHJFpgfiyi5TAJhIViMfNRqIR+LC
X-Gm-Gg: ASbGncuQCLKuTjgAZyLdIBdKoEhd6RFg/bZuFpGps43Hx3h5uCIqzK4iGPZ26TwSiac
	PkzE29O+Ji7bt11HcjU7VAaJsHifqDkSXO6oLOS6XCIgFDB9GOONGE7rVCh3PH5VywnxWIAhfxg
	L0SaItAcJjLLhq+MmZmnFg21ua0a2fGbIBcQw1FX8s7ZNXmnKXFI0E2zGEK/m7sNHVR1ZY2TPjP
	fu9/8SM6lHb/LEO6OPBgUkTJa5VNvKvIjuBhKffFum7vzB6fzWny05Et2TR018PR1LNToX27vs8
	cEvX013LEnqUOhU=
X-Google-Smtp-Source: AGHT+IFdF3RACflGZ4127eEL1ASFndgARKWuoPAd3O9zHQApfqgUNOioXKnOhShWG6VyX2UBA9BhWA==
X-Received: by 2002:a05:6a00:4f88:b0:732:516f:21fa with SMTP id d2e1a72fcca58-732617d014fmr18299875b3a.14.1739844599101;
        Mon, 17 Feb 2025 18:09:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732814ebb76sm2434311b3a.141.2025.02.17.18.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:09:58 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 06/12] net: hold netdev instance lock during sysfs operations
Date: Mon, 17 Feb 2025 18:09:42 -0800
Message-ID: <20250218020948.160643-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218020948.160643-1-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
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
index ce0017633374..cc707b2bbf4b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3349,6 +3349,7 @@ void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data);
+void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
@@ -4218,6 +4219,8 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
+int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
@@ -4977,6 +4980,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 97d3b657dd4e..25696caa1071 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1726,15 +1726,7 @@ int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
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
@@ -1745,10 +1737,12 @@ void dev_disable_lro(struct net_device *dev)
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
@@ -5972,7 +5966,7 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			dev_disable_lro(dev);
+			netif_disable_lro(dev);
 			dev_disable_gro_hw(dev);
 		}
 		break;
@@ -8995,7 +8989,7 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 }
 EXPORT_SYMBOL(dev_set_promiscuity);
 
-static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
+int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
@@ -9030,25 +9024,6 @@ static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
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
@@ -9181,7 +9156,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		int inc = (flags & IFF_ALLMULTI) ? 1 : -1;
 
 		dev->gflags ^= IFF_ALLMULTI;
-		__dev_set_allmulti(dev, inc, false);
+		netif_set_allmulti(dev, inc, false);
 	}
 
 	return ret;
@@ -9373,16 +9348,8 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
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
@@ -9406,7 +9373,6 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	add_device_randomness(dev->dev_addr, dev->addr_len);
 	return 0;
 }
-EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
@@ -9416,7 +9382,7 @@ int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
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


