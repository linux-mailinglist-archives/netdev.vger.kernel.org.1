Return-Path: <netdev+bounces-162797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DAFA27F2B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363CD18885C1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1221CA00;
	Tue,  4 Feb 2025 23:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D521C19F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710065; cv=none; b=SfJUzNrpUC6yrYRIk27ULRmh8nUIYctRrF3y9x1wCcSqVm6oUCxMlXUnAx/HBGElVK8YubCPPuaxTrd7bju8UslxAAyTRmprm6HSlkxhoilAvXC7fuyBj76Ou3XVI7Zn/qhh1ApdnRPoZAGYd/oycsxC5An0vndDwie0zMk8kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710065; c=relaxed/simple;
	bh=kElv2szNBWBbxKK8NRkVYveCTgrstoch1qBTR699a6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/+c66pBgOIgRtvLfNJSiZIYB2W3fCGxwFvQMNEt3e9acuzVKA6z+kKsszRAq0wOLNz+M5JipmdXLFLPRgPJ8bXWKEbxtOsJOD4XgRkooDgK1jEJZ5pgAWoROu5QN69wSj+J16OqFcOv9NKTM8bnJ9ixHz68HriUwBVT0kCnOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so1681389a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 15:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710063; x=1739314863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CsxBP0ibbJQrbtR9vPHba3ffwbyUFme6Ne8I4mjKAc=;
        b=MzAhCqyCx9lsnMyoSbIcB2SfYY1u6eHNJ9fGdWh06OqeKF80I2s7uvI7u+9RlH04wE
         UU3PQ+P/VxwHzg7P0tKbMkCQ8hVaJFdZ6n0w0hJtP3HmFeNZgd9mQBvw1ukQEuJsqM9a
         0TxZyOdxOetUs7on07bfh5N3aFrfqeW6V2SCEYYg5RJOBDMI6FAP/sDL33phU5RCDA2A
         XWGFucoc7sJxnmXsW1FfrfKPLCiKVGplezvCUo122qopLeNQmimnJqwyaVctF7ReTZla
         PaxVPe/Uw/Ln+xZrohjGveJQDFv5T7ai4MSUBhOXEAYx/dnBybsPKd5VFpZdJqud+ojP
         5asQ==
X-Gm-Message-State: AOJu0YypNIhELs11GUHizE6PWAXcDS1h4aOerAJz82398iA4zlWQEvtv
	jN3eczjeDrhWXJctVSoSJ+vbxoo7m4auKEW5LKrMAR/V1xYjjGRo8kwQ
X-Gm-Gg: ASbGncsTllzHvpj0GXcybkKtiv3sjaAdKQdQxF/A/rqDjOcd2VeReCopePJbinS9uYI
	JP4FSvFlVXtxBy+LOEUvAycC+0IdiMdaSS54+/fqlO5Z09UBJ9y+UIuENMLf8qKEj23cd0n3fZb
	TcH+qsc2uWJELMfPoxmHookBXzBMLR1iaM705i4Bdq7By3rYS8WexLl1Z7zbkwkn+GJbnUnpaxY
	yIxR48gD0QGL13Ax4jRITqkDnc+zhRSyxEEqRJzDssiXw0JNso9RQxeAlYXYODIMm6jvVh75w8c
	UzYooE/QEjzqPk4=
X-Google-Smtp-Source: AGHT+IHP3kzsE/1q+yYSQcspjnLr24+TWIXSIdLRi/kET42qT0UfXwQqNIgUC+cmi5cnGOhqUCWd3w==
X-Received: by 2002:a17:90b:2fcf:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2f9e076d86cmr1027813a91.12.1738710062506;
        Tue, 04 Feb 2025 15:01:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f06e7d4f6sm18939255ad.112.2025.02.04.15.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:01:02 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [RFC net-next 3/4] net: Hold netdev instance lock for more NDOs
Date: Tue,  4 Feb 2025 15:00:56 -0800
Message-ID: <20250204230057.1270362-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204230057.1270362-1-sdf@fomichev.me>
References: <20250204230057.1270362-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert all ndo_eth_ioctl invocations to dev_eth_ioctl which does the
locking. Reflow some of the dev_siocxxx to drop else clause.
Fix tabs vs spaces in neighboring lines while at it..
Remove rtnl_lock from ndo_get_stats and clarify that read path can
race with the write path. Still shaper-only drivers (iavf/netdevim).

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 28 +++++++++-------
 drivers/net/bonding/bond_main.c         |  9 +++--
 include/linux/netdevice.h               |  2 ++
 net/8021q/vlan_dev.c                    |  4 +--
 net/core/dev_ioctl.c                    | 44 +++++++++++++++++--------
 net/ieee802154/socket.c                 |  2 ++
 net/phonet/pn_dev.c                     |  2 ++
 7 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index c6087d92d740..3ed1bf322a5c 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -221,40 +221,46 @@ struct net_device synchronization rules
 	Note: netif_running() is guaranteed false
 
 ndo_do_ioctl:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 
-        This is only called by network subsystems internally,
-        not by user space calling ioctl as it was in before
-        linux-5.14.
+	This is only called by network subsystems internally,
+	not by user space calling ioctl as it was in before
+	linux-5.14.
 
 ndo_siocbond:
-        Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
         Context: process
 
-        Used by the bonding driver for the SIOCBOND family of
-        ioctl commands.
+	Used by the bonding driver for the SIOCBOND family of
+	ioctl commands.
 
 ndo_siocwandev:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 
 	Used by the drivers/net/wan framework to handle
 	the SIOCWANDEV ioctl with the if_settings structure.
 
 ndo_siocdevprivate:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 
 	This is used to implement SIOCDEVPRIVATE ioctl helpers.
 	These should not be added to new drivers, so don't use.
 
 ndo_eth_ioctl:
-	Synchronization: rtnl_lock() semaphore.
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
 	Context: process
 
 ndo_get_stats:
-	Synchronization: rtnl_lock() semaphore, or RCU.
+	Synchronization: RCU (can be called concurrently with the stats
+	update path).
 	Context: atomic (can't sleep under RCU)
 
 ndo_setup_tc:
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..025d605166c3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -858,7 +858,6 @@ static int bond_check_dev_link(struct bonding *bond,
 			       struct net_device *slave_dev, int reporting)
 {
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
-	int (*ioctl)(struct net_device *, struct ifreq *, int);
 	struct ifreq ifr;
 	struct mii_ioctl_data *mii;
 
@@ -874,8 +873,7 @@ static int bond_check_dev_link(struct bonding *bond,
 			BMSR_LSTATUS : 0;
 
 	/* Ethtool can't be used, fallback to MII ioctls. */
-	ioctl = slave_ops->ndo_eth_ioctl;
-	if (ioctl) {
+	if (slave_ops->ndo_eth_ioctl) {
 		/* TODO: set pointer to correct ioctl on a per team member
 		 *       bases to make this more efficient. that is, once
 		 *       we determine the correct ioctl, we will always
@@ -891,9 +889,10 @@ static int bond_check_dev_link(struct bonding *bond,
 		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
 		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
 		mii = if_mii(&ifr);
-		if (ioctl(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
+
+		if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
 			mii->reg_num = MII_BMSR;
-			if (ioctl(slave_dev, &ifr, SIOCGMIIREG) == 0)
+			if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIREG) == 0)
 				return mii->val_out & BMSR_LSTATUS;
 		}
 	}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6f2eb129ef3e..e49b818054b9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4159,6 +4159,8 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		void __user *data, bool *need_copyout);
 int dev_ifconf(struct net *net, struct ifconf __user *ifc);
+int dev_eth_ioctl(struct net_device *dev,
+		  struct ifreq *ifr, unsigned int cmd);
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg);
 int generic_hwtstamp_set_lower(struct net_device *dev,
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 91d134961357..ee3283400716 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -377,7 +377,6 @@ static int vlan_hwtstamp_set(struct net_device *dev,
 static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
-	const struct net_device_ops *ops = real_dev->netdev_ops;
 	struct ifreq ifrr;
 	int err = -EOPNOTSUPP;
 
@@ -388,8 +387,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
-		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl)
-			err = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
+		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
 		break;
 	}
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 4c2098ac9d72..8dc2c323fe58 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -240,19 +240,23 @@ int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
 	return 0;
 }
 
-static int dev_eth_ioctl(struct net_device *dev,
-			 struct ifreq *ifr, unsigned int cmd)
+int dev_eth_ioctl(struct net_device *dev,
+		  struct ifreq *ifr, unsigned int cmd)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret = -ENODEV;
 
 	if (!ops->ndo_eth_ioctl)
 		return -EOPNOTSUPP;
 
-	if (!netif_device_present(dev))
-		return -ENODEV;
+	netdev_lock_ops(dev);
+	if (netif_device_present(dev))
+		ret = ops->ndo_eth_ioctl(dev, ifr, cmd);
+	netdev_unlock_ops(dev);
 
-	return ops->ndo_eth_ioctl(dev, ifr, cmd);
+	return ret;
 }
+EXPORT_SYMBOL(dev_eth_ioctl);
 
 /**
  * dev_get_hwtstamp_phylib() - Get hardware timestamping settings of NIC
@@ -504,10 +508,14 @@ static int dev_siocbond(struct net_device *dev,
 	const struct net_device_ops *ops = dev->netdev_ops;
 
 	if (ops->ndo_siocbond) {
+		int ret = -ENODEV;
+
+		netdev_lock_ops(dev);
 		if (netif_device_present(dev))
-			return ops->ndo_siocbond(dev, ifr, cmd);
-		else
-			return -ENODEV;
+			ret = ops->ndo_siocbond(dev, ifr, cmd);
+		netdev_unlock_ops(dev);
+
+		return ret;
 	}
 
 	return -EOPNOTSUPP;
@@ -519,10 +527,14 @@ static int dev_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 	const struct net_device_ops *ops = dev->netdev_ops;
 
 	if (ops->ndo_siocdevprivate) {
+		int ret = -ENODEV;
+
+		netdev_lock_ops(dev);
 		if (netif_device_present(dev))
-			return ops->ndo_siocdevprivate(dev, ifr, data, cmd);
-		else
-			return -ENODEV;
+			ret = ops->ndo_siocdevprivate(dev, ifr, data, cmd);
+		netdev_unlock_ops(dev);
+
+		return ret;
 	}
 
 	return -EOPNOTSUPP;
@@ -533,10 +545,14 @@ static int dev_siocwandev(struct net_device *dev, struct if_settings *ifs)
 	const struct net_device_ops *ops = dev->netdev_ops;
 
 	if (ops->ndo_siocwandev) {
+		int ret = -ENODEV;
+
+		netdev_lock_ops(dev);
 		if (netif_device_present(dev))
-			return ops->ndo_siocwandev(dev, ifs);
-		else
-			return -ENODEV;
+			ret = ops->ndo_siocwandev(dev, ifs);
+		netdev_unlock_ops(dev);
+
+		return ret;
 	}
 
 	return -EOPNOTSUPP;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 18d267921bb5..b86d090a2ba5 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -139,8 +139,10 @@ static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
 	if (!dev)
 		return -ENODEV;
 
+	netdev_lock_ops(dev);
 	if (dev->type == ARPHRD_IEEE802154 && dev->netdev_ops->ndo_do_ioctl)
 		ret = dev->netdev_ops->ndo_do_ioctl(dev, &ifr, cmd);
+	netdev_unlock_ops(dev);
 
 	if (!ret && put_user_ifreq(&ifr, arg))
 		ret = -EFAULT;
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 5c36bae37b8f..945f2315499a 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -246,8 +246,10 @@ static int phonet_device_autoconf(struct net_device *dev)
 	if (!dev->netdev_ops->ndo_siocdevprivate)
 		return -EOPNOTSUPP;
 
+	netdev_lock_ops(dev);
 	ret = dev->netdev_ops->ndo_siocdevprivate(dev, (struct ifreq *)&req,
 						  NULL, SIOCPNGAUTOCONF);
+	netdev_unlock_ops(dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.48.1


