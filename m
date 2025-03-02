Return-Path: <netdev+bounces-170980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D4A4AE89
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2E316F8E4
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE41CAA4;
	Sun,  2 Mar 2025 00:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89923A6
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874155; cv=none; b=OTczPotT9FWtLj0Ia0z0/XH7dIvo9Rq1A2Z3Xuiz4JEQi9IIe8/lP2sIO9Bej15fhwY480rFEt5+U1bERcZNGKli3qRrPNsjm/mrOavLP3udALDEcz5s2dw41xR683k95wyy1OEGVLwbCxZ2kVCDVIMfuWrj1cWgVZi9M5gwS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874155; c=relaxed/simple;
	bh=FqXVh5/4rXt+P4lPSPwpUlqPI6RSYc7NQoPdrDGSBNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slmESnBze4tp/MUP/p1QNMzCegIZMls826ti/HTBdQDUKptSZm18KA6Dl4vaaiEiwMk4DJcFkuMjChngcsuXn0pTr1dMInQ8S8W3L6hU9sUhK0km0IHfUvKRZHaPAJmFd6llsrdQARKgFsuNrZtXtR5C3rnDGgkm7HxxMeNLZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232aead377so63100515ad.0
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874152; x=1741478952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am6kqJugK74fIYa8DNLvjMe++QAq4s/rnYBjQF1ILuw=;
        b=ejsVQbTfFe5LobxOk7XLEXj/B6Ek6Ei6qMQPKDNluY1wM2Xm1Ae7aZVJcn5Xu7otoA
         tZrxS0Ygs58EUVC3emQPPE5lHECw7M97xFcwwAelD8CLxCG5EqUTcOEnO+/bozGWpEGa
         troUbUEc0Vj0NjUENdzQXbwGc4w/aUsFeElHRl+3iNniEy4Ul2YGGzTcShsjf7JT22gQ
         6K5n15WvrU1Dv0zFoIYy92KXRYutpjJnO3qv/ViRN8fN98ztwLJUqp+XIT98MJ9dHtcF
         mGodOz9L6B9EywgrXxJV2M1O/tXa0Cer8WeKRhzljKQRqouNtXzlfPOZa4jTiARArhp1
         jL5A==
X-Gm-Message-State: AOJu0YzPRDdvOWGZU6Mlb1cg/mFcSQTHqdoxNZDkcwgByM5o9L2r3Qug
	kdF5LSqV99yD0ELPR4GFSHkLXZyL/ChJMv4vPG46rxDOdIJ1cZ2U58dz
X-Gm-Gg: ASbGnctpc/7UMYmev6hzrxoL7ooqAkjr89EgBSe7O3HGNS3Dk2SYa8g6vMJ8lQYwttb
	M10ybZyuAGJEUT4kXnt07FT98zMgGBMu/59VMvT7FT83i0OniRVMs254qoXWBnq+9pI6EdDplCj
	8WyTH41BOfSYRz0L5WdQmYoQI1RD7RKgug0sFpHq3IFqDu8/YS92A220IxkN2YxUdxSCL2Hor/x
	rQLhjU0uNTpzXrhoQj+6wwuLU12+BZZ0I5OrXihn0hDuhOiebzFQtjnOMoNzXI1K/LqONj13ZkX
	pJUmIAvTTQPLE3xG3DN79So96i8rIp8iTT1mICp1xjeI
X-Google-Smtp-Source: AGHT+IHY6qttLH7kC6k+66hoRUFkciO2EpxEb6ojVcVf+c5+UpRtWNzpHfYKsH+OhcoDVrjkfloOaA==
X-Received: by 2002:a05:6a21:1518:b0:1ee:68e3:ff45 with SMTP id adf61e73a8af0-1f2f4e4c740mr16365920637.35.1740874152335;
        Sat, 01 Mar 2025 16:09:12 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe48865sm6261706b3a.50.2025.03.01.16.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:09:11 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 07/14] net: hold netdev instance lock during ioctl operations
Date: Sat,  1 Mar 2025 16:08:54 -0800
Message-ID: <20250302000901.2729164-8-sdf@fomichev.me>
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

Convert all ndo_eth_ioctl invocations to dev_eth_ioctl which does the
locking. Reflow some of the dev_siocxxx to drop else clause.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c |  9 ++---
 include/linux/netdevice.h       |  3 ++
 net/8021q/vlan_dev.c            |  4 +-
 net/core/dev.c                  |  4 +-
 net/core/dev_api.c              | 30 +++++++++++++++
 net/core/dev_ioctl.c            | 67 ++++++++++++++++++++-------------
 6 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7d98fee5a27f..916e90d54c0b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -855,7 +855,6 @@ static int bond_check_dev_link(struct bonding *bond,
 			       struct net_device *slave_dev, int reporting)
 {
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
-	int (*ioctl)(struct net_device *, struct ifreq *, int);
 	struct ifreq ifr;
 	struct mii_ioctl_data *mii;
 
@@ -871,8 +870,7 @@ static int bond_check_dev_link(struct bonding *bond,
 			BMSR_LSTATUS : 0;
 
 	/* Ethtool can't be used, fallback to MII ioctls. */
-	ioctl = slave_ops->ndo_eth_ioctl;
-	if (ioctl) {
+	if (slave_ops->ndo_eth_ioctl) {
 		/* TODO: set pointer to correct ioctl on a per team member
 		 *       bases to make this more efficient. that is, once
 		 *       we determine the correct ioctl, we will always
@@ -888,9 +886,10 @@ static int bond_check_dev_link(struct bonding *bond,
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
index 377a7fa4056c..2aabd4ba1471 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4229,6 +4229,8 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		void __user *data, bool *need_copyout);
 int dev_ifconf(struct net *net, struct ifconf __user *ifc);
+int dev_eth_ioctl(struct net_device *dev,
+		  struct ifreq *ifr, unsigned int cmd);
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg);
 int generic_hwtstamp_set_lower(struct net_device *dev,
@@ -4250,6 +4252,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat);
 int __dev_set_mtu(struct net_device *, int);
+int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
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
 
diff --git a/net/core/dev.c b/net/core/dev.c
index b765c848280d..d5cf27933699 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9522,7 +9522,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 	return err;
 }
 
-int dev_set_mtu(struct net_device *dev, int new_mtu)
+int netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	struct netlink_ext_ack extack;
 	int err;
@@ -9533,7 +9533,7 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
 		net_err_ratelimited("%s: %s\n", dev->name, extack._msg);
 	return err;
 }
-EXPORT_SYMBOL(dev_set_mtu);
+EXPORT_SYMBOL(netif_set_mtu);
 
 int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 {
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index ce3a38c8e326..7dae30781411 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -222,3 +222,33 @@ void dev_close(struct net_device *dev)
 	netdev_unlock_ops(dev);
 }
 EXPORT_SYMBOL(dev_close);
+
+int dev_eth_ioctl(struct net_device *dev,
+		  struct ifreq *ifr, unsigned int cmd)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret = -ENODEV;
+
+	if (!ops->ndo_eth_ioctl)
+		return -EOPNOTSUPP;
+
+	netdev_lock_ops(dev);
+	if (netif_device_present(dev))
+		ret = ops->ndo_eth_ioctl(dev, ifr, cmd);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_eth_ioctl);
+
+int dev_set_mtu(struct net_device *dev, int new_mtu)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_mtu(dev, new_mtu);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_mtu);
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 4c2098ac9d72..d9f350593121 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -110,7 +110,7 @@ static int dev_getifmap(struct net_device *dev, struct ifreq *ifr)
 	return 0;
 }
 
-static int dev_setifmap(struct net_device *dev, struct ifreq *ifr)
+static int netif_setifmap(struct net_device *dev, struct ifreq *ifr)
 {
 	struct compat_ifmap *cifmap = (struct compat_ifmap *)&ifr->ifr_map;
 
@@ -240,20 +240,6 @@ int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg)
 	return 0;
 }
 
-static int dev_eth_ioctl(struct net_device *dev,
-			 struct ifreq *ifr, unsigned int cmd)
-{
-	const struct net_device_ops *ops = dev->netdev_ops;
-
-	if (!ops->ndo_eth_ioctl)
-		return -EOPNOTSUPP;
-
-	if (!netif_device_present(dev))
-		return -ENODEV;
-
-	return ops->ndo_eth_ioctl(dev, ifr, cmd);
-}
-
 /**
  * dev_get_hwtstamp_phylib() - Get hardware timestamping settings of NIC
  *	or of attached phylib PHY
@@ -305,7 +291,9 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return -ENODEV;
 
 	kernel_cfg.ifr = ifr;
+	netdev_lock_ops(dev);
 	err = dev_get_hwtstamp_phylib(dev, &kernel_cfg);
+	netdev_unlock_ops(dev);
 	if (err)
 		return err;
 
@@ -429,7 +417,9 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
+	netdev_lock_ops(dev);
 	err = dev_set_hwtstamp_phylib(dev, &kernel_cfg, &extack);
+	netdev_unlock_ops(dev);
 	if (err)
 		return err;
 
@@ -504,10 +494,14 @@ static int dev_siocbond(struct net_device *dev,
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
@@ -519,10 +513,14 @@ static int dev_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
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
@@ -533,10 +531,14 @@ static int dev_siocwandev(struct net_device *dev, struct if_settings *ifs)
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
@@ -580,11 +582,16 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
 		       min(sizeof(ifr->ifr_hwaddr.sa_data_min),
 			   (size_t)dev->addr_len));
+		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
+		netdev_unlock_ops(dev);
 		return 0;
 
 	case SIOCSIFMAP:
-		return dev_setifmap(dev, ifr);
+		netdev_lock_ops(dev);
+		err = netif_setifmap(dev, ifr);
+		netdev_unlock_ops(dev);
+		return err;
 
 	case SIOCADDMULTI:
 		if (!ops->ndo_set_rx_mode ||
@@ -592,7 +599,10 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 			return -EINVAL;
 		if (!netif_device_present(dev))
 			return -ENODEV;
-		return dev_mc_add_global(dev, ifr->ifr_hwaddr.sa_data);
+		netdev_lock_ops(dev);
+		err = dev_mc_add_global(dev, ifr->ifr_hwaddr.sa_data);
+		netdev_unlock_ops(dev);
+		return err;
 
 	case SIOCDELMULTI:
 		if (!ops->ndo_set_rx_mode ||
@@ -600,7 +610,10 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 			return -EINVAL;
 		if (!netif_device_present(dev))
 			return -ENODEV;
-		return dev_mc_del_global(dev, ifr->ifr_hwaddr.sa_data);
+		netdev_lock_ops(dev);
+		err = dev_mc_del_global(dev, ifr->ifr_hwaddr.sa_data);
+		netdev_unlock_ops(dev);
+		return err;
 
 	case SIOCSIFTXQLEN:
 		if (ifr->ifr_qlen < 0)
-- 
2.48.1


