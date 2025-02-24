Return-Path: <netdev+bounces-169145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35DA42AB7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C7D7A773E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39545266565;
	Mon, 24 Feb 2025 18:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577B266574
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420504; cv=none; b=OIn6RbclhEhE/7R/toqMscLa2nfCabXHCEbAMADXk32rhzblGelL2PJTlVQaYk/bwiUkrb6F/xoSelGp6GNf2ZhESY14YBaPxRawbR17ypaJ24ChR6NDAMsDLA9XeXyqAxDc+K3q6m7F9wDbXZRRJGG5TI2Tu/CF20gwKeJeNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420504; c=relaxed/simple;
	bh=MWpQS8YA0C0nSohGjyruE/gfBMGiMFUbCVpyRSliEFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFwcWPxLY2Yt10/DN8vBJCdousRC3glynebk3f/DuCFTQTZV4QbRrhwwkKWm55widdB/MvHznuGYG7f3j15AfjZ9icPY3lPo49K1myQt/a49JZ/Fc1uzhyw/CK5UcDcAToDE/elktqyNNwKywLd2u3if2ENLSJxbrRzDHhdl3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22100006bc8so83006405ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420501; x=1741025301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wURDceIbs4wwGY3W8uFT4aCzy65LzyYD9J7I/stat5k=;
        b=UzER+HU20SYY7L6E7OkPPivi7KwIO/jv6HUFNGrWzIr7nFKzKXfL+2nFmjoILLYj01
         5WVG/joIkx/KdQtcT/fbNf32XXgLcVWPwf9LELi8bGgKvzWys+K7nwfY9mPSksTl6T77
         eCRPuEKG+BL7Ny4NmOON1lgpMtyKjoQzTvjWCjzB6ROzZ491LOw9N78JSYk/Pnyof8DP
         YULNK0k34p//v6VHNY7n1SaaIhDmBrDJHbAP9sj3CXhm0fRtSBozZ1UWWRNc6HDDPwtO
         lb31cFosVIdVw+ON+DBCS89kJjw8ywE1V3Dz9s3ILFTnQW6NHodO5n6naZ5EBBQ5rg/+
         Ul9Q==
X-Gm-Message-State: AOJu0Yx8klWxEJI/1bOXKsElLyz1yz/zfejtzXJVfx8UDYvkqjJUsBal
	q8ac0jgBrFyv//UbMUbXT+FKEuDpDq5L/t/opPP158Ut8Pf61FubOxxz
X-Gm-Gg: ASbGnctYSRy25WForXe5u8I2V2l19jCINcHuk6R/foZDBGpKH18r1sRzRhd9LYW0gbO
	LypKZ2oQo5bja6qDW251/SPJhQjmMMhfK2XDboGMWoLHOijSq1gMHEGt5xGXXNY9x2PdDzQVQg/
	JmkdeDzMyd7188/HR3IRRtPOibgGj8rCa9JBgLXYCNKepEnuLUKYH0TJLYwbsr/9nU/z7+ljtpY
	RdmIe4OkOIE2vCeNql6SE+APjMnZGoVAux2d4I4D8lsCPC80JnPr0tAMD8n1vcj11/Xfi3Rb23E
	uDlFIxA70OueNBA35MrNvdb5rA==
X-Google-Smtp-Source: AGHT+IF/VLKfqqrc165bv9X7v0uZWERtH+BcODiFejMqzTeUVUzNxzBmQT+vXIudIAq7l3kqCDVtIQ==
X-Received: by 2002:a17:903:2284:b0:216:2426:767f with SMTP id d9443c01a7336-22307e72782mr2610925ad.49.1740420501387;
        Mon, 24 Feb 2025 10:08:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d66fsm184395605ad.180.2025.02.24.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:08:21 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v7 09/12] net: replace dev_addr_sem with netdev instance lock
Date: Mon, 24 Feb 2025 10:08:05 -0800
Message-ID: <20250224180809.3653802-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180809.3653802-1-sdf@fomichev.me>
References: <20250224180809.3653802-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep reports possible circular dependency in [0]. Instead of
fixing the ordering, replace global dev_addr_sem with netdev
instance lock. Most of the paths that set/get mac are RTNL
protected. Two places where it's not, convert to explicit
locking:
- sysfs address_show
- dev_get_mac_address via dev_ioctl

0: https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/993321/24-router-bridge-1d-lag-sh/stderr

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/tap.c         |  2 +-
 drivers/net/tun.c         |  2 +-
 include/linux/netdevice.h |  6 +----
 net/core/dev.c            | 52 ++++++++++++++++++++-------------------
 net/core/dev.h            |  3 +--
 net/core/dev_api.c        | 17 ++-----------
 net/core/dev_ioctl.c      |  2 +-
 net/core/net-sysfs.c      |  7 ++----
 net/core/rtnetlink.c      |  6 ++++-
 9 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..4382f5e323b0 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1017,7 +1017,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			rtnl_unlock();
 			return -ENOLINK;
 		}
-		ret = dev_set_mac_address_user(tap->dev, &sa, NULL);
+		ret = dev_set_mac_address(tap->dev, &sa, NULL);
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..1e645d5e225c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3175,7 +3175,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCSIFHWADDR:
 		/* Set hw address */
-		ret = dev_set_mac_address_user(tun->dev, &ifr.ifr_hwaddr, NULL);
+		ret = dev_set_mac_address(tun->dev, &ifr.ifr_hwaddr, NULL);
 		break;
 
 	case TUNGETSNDBUF:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7eabcb203e92..57dff4cc5cee 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2463,7 +2463,7 @@ struct net_device {
 	 *
 	 * Protects:
 	 *	@gro_flush_timeout, @napi_defer_hard_irqs, @napi_list,
-	 *	@net_shaper_hierarchy, @reg_state, @threaded
+	 *	@net_shaper_hierarchy, @reg_state, @threaded, @dev_addr
 	 *
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
@@ -4224,10 +4224,6 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
-int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			       struct netlink_ext_ack *extack);
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
diff --git a/net/core/dev.c b/net/core/dev.c
index 80c2ee985dc6..91242d77e444 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1058,6 +1058,28 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev);
 }
 
+/**
+ * netdev_get_by_name_lock() - find a device by its name
+ * @net: the applicable net namespace
+ * @name: name of device
+ *
+ * Search for an interface by name. If a valid device
+ * with @name is found it will be returned with netdev->lock held.
+ * netdev_unlock() must be called to release it.
+ *
+ * Return: pointer to a device with lock held, NULL if not found.
+ */
+struct net_device *netdev_get_by_name_lock(struct net *net, const char *name)
+{
+	struct net_device *dev;
+
+	dev = dev_get_by_name(net, name);
+	if (!dev)
+		return NULL;
+
+	return __netdev_put_lock(dev);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -9463,44 +9485,24 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	return 0;
 }
 
-DECLARE_RWSEM(dev_addr_sem);
-
-int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			       struct netlink_ext_ack *extack)
-{
-	int ret;
-
-	down_write(&dev_addr_sem);
-	ret = netif_set_mac_address(dev, sa, extack);
-	up_write(&dev_addr_sem);
-	return ret;
-}
-
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
-	int ret = 0;
 
-	down_read(&dev_addr_sem);
-	rcu_read_lock();
+	dev = netdev_get_by_name_lock(net, dev_name);
+	if (!dev)
+		return -ENODEV;
 
-	dev = dev_get_by_name_rcu(net, dev_name);
-	if (!dev) {
-		ret = -ENODEV;
-		goto unlock;
-	}
 	if (!dev->addr_len)
 		memset(sa->sa_data, 0, size);
 	else
 		memcpy(sa->sa_data, dev->dev_addr,
 		       min_t(size_t, size, dev->addr_len));
 	sa->sa_family = dev->type;
+	netdev_unlock(dev);
 
-unlock:
-	rcu_read_unlock();
-	up_read(&dev_addr_sem);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(dev_get_mac_address);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 41b0831aba60..b50ca645c086 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -28,6 +28,7 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
+struct net_device *netdev_get_by_name_lock(struct net *net, const char *name);
 struct net_device *__netdev_put_lock(struct net_device *dev);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
@@ -69,8 +70,6 @@ extern int		weight_p;
 extern int		dev_weight_rx_bias;
 extern int		dev_weight_tx_bias;
 
-extern struct rw_semaphore dev_addr_sem;
-
 /* rtnl helpers */
 extern struct list_head net_todo_list;
 void netdev_run_todo(void);
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 0db20ed086d3..68d294e6d48d 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -82,19 +82,6 @@ void dev_set_group(struct net_device *dev, int new_group)
 	netdev_unlock_ops(dev);
 }
 
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			     struct netlink_ext_ack *extack)
-{
-	int ret;
-
-	netdev_lock_ops(dev);
-	ret = netif_set_mac_address_user(dev, sa, extack);
-	netdev_unlock_ops(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL(dev_set_mac_address_user);
-
 /**
  * dev_change_net_namespace() - move device to different nethost namespace
  * @dev: device
@@ -310,9 +297,9 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 {
 	int ret;
 
-	netdev_lock_ops(dev);
+	netdev_lock(dev);
 	ret = netif_set_mac_address(dev, sa, extack);
-	netdev_unlock_ops(dev);
+	netdev_unlock(dev);
 
 	return ret;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index d9f350593121..296e52d1395d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -574,7 +574,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	case SIOCSIFHWADDR:
 		if (dev->addr_len > sizeof(struct sockaddr))
 			return -EINVAL;
-		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
+		return dev_set_mac_address(dev, &ifr->ifr_hwaddr, NULL);
 
 	case SIOCSIFHWBROADCAST:
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 35f79a308d7b..960c78f1fa21 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -262,14 +262,11 @@ static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	down_read(&dev_addr_sem);
-
-	rcu_read_lock();
+	netdev_lock(ndev);
 	if (dev_isalive(ndev))
 		ret = sysfs_format_mac(buf, ndev->dev_addr, ndev->addr_len);
-	rcu_read_unlock();
+	netdev_unlock(ndev);
 
-	up_read(&dev_addr_sem);
 	return ret;
 }
 static DEVICE_ATTR_RO(address);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7828584a6791..968060c0ebb4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3086,7 +3086,11 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		sa->sa_family = dev->type;
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		err = netif_set_mac_address_user(dev, sa, extack);
+		if (!netdev_need_ops_lock(dev))
+			netdev_lock(dev);
+		err = netif_set_mac_address(dev, sa, extack);
+		if (!netdev_need_ops_lock(dev))
+			netdev_unlock(dev);
 		kfree(sa);
 		if (err)
 			goto errout;
-- 
2.48.1


