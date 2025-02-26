Return-Path: <netdev+bounces-170010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B93A46D24
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17B516BEAE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464225C6E2;
	Wed, 26 Feb 2025 21:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0F25B697
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604278; cv=none; b=Dav5C1N8QtcWWDilMRK/TzKP0IwM/R7OApxTrNxtSR1PzBOLzvvFBaGjAZjMMiHzCmoVLeFfPpg/qXB80COpC8ZQhUq56aSpXn+XxPtW32uPBr+gP5tKph4/Y8Xih/YVHt1ABZd2OYVcrPlVG6lJTva5b2lq9KUjmEw6gXV1kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604278; c=relaxed/simple;
	bh=DUgqoG6JOIwTO9EvkHjDkM7BFb1LN6kcLbtR4sqBdII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scypZEvct+hSVBeBA/L7BIoTKCcVadsaDY4ZoS0woTfmjykUjqPXyscf+XjEUtwkeVPrcn9PdtFuQU+fXSodWVddlsBjimRXo912h2IroSEmClVxWTMY5897QfKHf6/uGVz81LHPrekihF+Q0zZ/d5wxmGhG5rJIBpKw+yY3y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349bb8605so4221555ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604276; x=1741209076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkSWZJ57bdz1fDjz8p2lxwhvUxaGUfVvMM5iW9q6VWs=;
        b=YiRRMIBlKiy+/2c3cxP0kUxMCe7vA77FpEiSKKRMpEgwezu9mb40kgC2u/PT6Ja3YH
         +Vq+apfyn/edv2OXe6oNrAh035obVNGzSuF2BGrPDIypMIiUfJ8aV1vOUYS+UgJaxXYQ
         vKZdNZ7hZf4TM+OIcRGL1/fmkL8122hiQ9tXWnL+l10uEwd9QSGsrFMkmw2sTQv1+YNr
         aeF0EXXLxcShjXE2M9+h5pd/wqyz9T27qJPBhnJGilFZwJVY6uETRFK4BjboLYaa6/Qs
         yA7JJqpW1Gkc/YRGyNxUppuT75fUc3pzSlP4jrg2C6J1ljZ+mtfJC7k5L29ni5xP6XzL
         w6Iw==
X-Gm-Message-State: AOJu0Yx55wBuvweHM0ETZN6qvS8eY5lDaizpgqUbWvuZSNg8oPht4qM1
	5k8Y9Mb9ZfxhVH5b1MOAYus7slvvz9l4lIFAJf+nTOSg6wJLz14vyngm
X-Gm-Gg: ASbGncv+y/gJ9OwbcMPxWRKpp8KpDRls6OjkSRJAl6HRM8wuSsD+5QZUri0+XXAnIrH
	oGsp8iS+Hmmp6N9Y/2dyWnJ24OBXlY2qUFMkw+C/cil7cGW9BD2GZN41XCkM3IEnVQsinCe6P0f
	0l47W6+cepS+JUcIBq19a/Ehp8BOiGKfW8nG97WJIeOOBvTKEjMOaFqXClWooCrwdyBuT3Aq8gT
	4CVV20SkclOVL81YojcdrXaZsIzMZu4vtD3GfYCZGN9V+Oja5SkF8lTHNLniLhTRqY7tVxsbbVp
	mX+czrs8KXrU8tSyYNe5O0NYow==
X-Google-Smtp-Source: AGHT+IHop2ZbvtRWL/M+sznjU0gGbNne7OLyET8ys7VjilsNBM2/d5DadDFv/SQ9RiNUiZHr4Y6Tmg==
X-Received: by 2002:a05:6a20:d045:b0:1ee:cab3:426e with SMTP id adf61e73a8af0-1f0fbff7608mr15644600637.7.1740604275614;
        Wed, 26 Feb 2025 13:11:15 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee6868952asm2057026a12.18.2025.02.26.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:15 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v8 05/12] net: hold netdev instance lock during ioctl operations
Date: Wed, 26 Feb 2025 13:11:01 -0800
Message-ID: <20250226211108.387727-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211108.387727-1-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
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
index 7d716e90a84c..fcaf47101a56 100644
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
index 9c7eca400b9a..3391b497fe99 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4194,6 +4194,8 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		void __user *data, bool *need_copyout);
 int dev_ifconf(struct net *net, struct ifconf __user *ifc);
+int dev_eth_ioctl(struct net_device *dev,
+		  struct ifreq *ifr, unsigned int cmd);
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg);
 int generic_hwtstamp_set_lower(struct net_device *dev,
@@ -4215,6 +4217,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
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
index 841c8ce690f0..3ae1cbcc090e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9396,7 +9396,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 	return err;
 }
 
-int dev_set_mtu(struct net_device *dev, int new_mtu)
+int netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	struct netlink_ext_ack extack;
 	int err;
@@ -9407,7 +9407,7 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
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


