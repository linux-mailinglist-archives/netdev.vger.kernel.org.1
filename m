Return-Path: <netdev+bounces-173787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C25A5BAFF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8D63AEE8E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F80229B18;
	Tue, 11 Mar 2025 08:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9522170A;
	Tue, 11 Mar 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682713; cv=none; b=bgk2RNbSp6RPn328h9A8u0cm6lDtyaXHVTSD57x6eDrVlTFFcs61kpIRWfjGhRS9kcGN4DaRXhFLILlPp/QT2jrkQX/Z8HxsKco/R/NkshjKsPtR64oiKUXBobbdjdxX4V96C6SC4LgKe89L1udTxGQjFiPp0zC7BV/exhPUE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682713; c=relaxed/simple;
	bh=+3CmN/hQnydkKUnM5uIxjVQDt8oxaE5y4SW4pVBWnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuVkE42fe+vIYIsZ60CwFdPXv2dqOwB8368L49wH61h+WA1BOoy2TMp9BkJRv7w0wb4n1KBCzOdTC+a++C6Ln5uLe9Y5FNJIORukkoPQblsOV+0urImDVdFpnbDP19ltwayV8/3+gY7fTpWO9qZplA4tRF7gBEJ7vFzZDEzQTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22349bb8605so94706025ad.0;
        Tue, 11 Mar 2025 01:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741682710; x=1742287510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuAh2RSgJjAezLxauY4sdNf9iEvDGbpYz+rU1XxvKrQ=;
        b=QEbS1L3s9L226anVtYFctCqcufuipQ8EN6aUIxSGuF1h3rYism1oTXpGDUDx6iNqUF
         aU4naQYX1i0/RPGk+mQ1ib3PQTM2Bqkt07ju82rMSqLRd27xTxC2zclKhm6tIIpDCjNS
         /qBP9JFDfUyR03fvyQfpTMU8iSVzSgiChd0DLBfHaWUL9Uu04Ml7XtQSRGCZBmyMZEKG
         3AxEkfzvRQYW1DDbmtDBRYrGJEeiUd8MIQk0I5khvEeWo/xdM/82rTLy64SHO4R1RYx0
         65Cpr1s9+Hh9gNR9s3N7RnYz+Cu/26JomuQ79dTF2J/XW3dnlG2vWytqQ3Y6WSSZ9Ltx
         EMIA==
X-Forwarded-Encrypted: i=1; AJvYcCWo/TR4ljZpNtphgRRrq1YDZYWz0IsQxrbf+UX4HkTNS09lH98PCitu8w1+aHJuysrwd4Cx6IehHKcZidc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dmbeh4BeDPrQSODxIAJPPi2HXcolLa89l4lYQpvOz2sBfbKz
	x50roC/8sQPXeWdx0xGXMn0mrkqJzIcXE4dGjKNxI941BpFdqKyZzPffSYkdsA==
X-Gm-Gg: ASbGncskm3hY5I0SzOLsVIsUat7mJEyzXsPguMFARlv+T2NCJj2KnRy3uiYOKB8zIhC
	yZfY1Pq28DfOC8tF6GYUEsOHNl2PWh1dU2ZB8KrHA+0yd5CxVehlFxGu9o7PNwd+6LZDJXLNaLG
	ktpfJoumQaacLENyyjPOqerWaW/Z8PAR3wSK7Y44+rZ3u4fZ4+du0Q5FZadK3OGtfyFCMvsPOwQ
	5BfHQjfDe7w4cKU8jxw9SfZHwSStcqJry94Sj8GEvxdGD0ZXfhIBRZj2UEe+j3B5v+/YhjHRh/A
	dxuFqJD3qYkMHS4UzV/bNJwUWBdi9kwoOIMNBnWmU0WD
X-Google-Smtp-Source: AGHT+IEQs6DDe/oWH3AMOWS/T0vwEoYPShu0BVFY2O4Dri6XvVkbj2ncyyh4YUSVv79SHKHc2dGvrQ==
X-Received: by 2002:a05:6a20:d491:b0:1f3:418d:91b5 with SMTP id adf61e73a8af0-1f544b2272amr28282918637.24.1741682710203;
        Tue, 11 Mar 2025 01:45:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af52f391035sm2980035a12.77.2025.03.11.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:45:09 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	jdamato@fastly.com,
	kory.maincent@bootlin.com,
	atenart@kernel.org,
	kuniyu@amazon.com,
	Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next 1/2] Revert "net: replace dev_addr_sem with netdev instance lock"
Date: Tue, 11 Mar 2025 01:45:06 -0700
Message-ID: <20250311084507.3978048-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311084507.3978048-1-sdf@fomichev.me>
References: <20250311084507.3978048-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit df43d8bf10316a7c3b1e47e3cc0057a54df4a5b8.

Cc: Kohei Enju <enjuk@amazon.com>
Fixes: df43d8bf1031 ("net: replace dev_addr_sem with netdev instance lock")

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/tap.c         |  2 +-
 drivers/net/tun.c         |  2 +-
 include/linux/netdevice.h |  6 ++++-
 net/core/dev.c            | 52 +++++++++++++++++++--------------------
 net/core/dev.h            |  3 ++-
 net/core/dev_api.c        | 17 +++++++++++--
 net/core/dev_ioctl.c      |  2 +-
 net/core/net-sysfs.c      |  7 ++++--
 net/core/rtnetlink.c      |  6 +----
 9 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 4382f5e323b0..d4ece538f1b2 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1017,7 +1017,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			rtnl_unlock();
 			return -ENOLINK;
 		}
-		ret = dev_set_mac_address(tap->dev, &sa, NULL);
+		ret = dev_set_mac_address_user(tap->dev, &sa, NULL);
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 55b60cb68d00..f75f912a0225 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3193,7 +3193,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCSIFHWADDR:
 		/* Set hw address */
-		ret = dev_set_mac_address(tun->dev, &ifr.ifr_hwaddr, NULL);
+		ret = dev_set_mac_address_user(tun->dev, &ifr.ifr_hwaddr, NULL);
 		break;
 
 	case TUNGETSNDBUF:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a297757df7e..42c75cb028e7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2498,7 +2498,7 @@ struct net_device {
 	 *
 	 * Protects:
 	 *	@gro_flush_timeout, @napi_defer_hard_irqs, @napi_list,
-	 *	@net_shaper_hierarchy, @reg_state, @threaded, @dev_addr
+	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
@@ -4198,6 +4198,10 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
+int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			       struct netlink_ext_ack *extack);
+int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1cb134ff7327..5a64389461e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1059,28 +1059,6 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev);
 }
 
-/**
- * netdev_get_by_name_lock() - find a device by its name
- * @net: the applicable net namespace
- * @name: name of device
- *
- * Search for an interface by name. If a valid device
- * with @name is found it will be returned with netdev->lock held.
- * netdev_unlock() must be called to release it.
- *
- * Return: pointer to a device with lock held, NULL if not found.
- */
-struct net_device *netdev_get_by_name_lock(struct net *net, const char *name)
-{
-	struct net_device *dev;
-
-	dev = dev_get_by_name(net, name);
-	if (!dev)
-		return NULL;
-
-	return __netdev_put_lock(dev);
-}
-
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -9612,24 +9590,44 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	return 0;
 }
 
+DECLARE_RWSEM(dev_addr_sem);
+
+int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			       struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	down_write(&dev_addr_sem);
+	ret = netif_set_mac_address(dev, sa, extack);
+	up_write(&dev_addr_sem);
+	return ret;
+}
+
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
+	int ret = 0;
 
-	dev = netdev_get_by_name_lock(net, dev_name);
-	if (!dev)
-		return -ENODEV;
+	down_read(&dev_addr_sem);
+	rcu_read_lock();
 
+	dev = dev_get_by_name_rcu(net, dev_name);
+	if (!dev) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 	if (!dev->addr_len)
 		memset(sa->sa_data, 0, size);
 	else
 		memcpy(sa->sa_data, dev->dev_addr,
 		       min_t(size_t, size, dev->addr_len));
 	sa->sa_family = dev->type;
-	netdev_unlock(dev);
 
-	return 0;
+unlock:
+	rcu_read_unlock();
+	up_read(&dev_addr_sem);
+	return ret;
 }
 EXPORT_SYMBOL(dev_get_mac_address);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 0ddd3631acb0..7ee203395d8e 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -29,7 +29,6 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
-struct net_device *netdev_get_by_name_lock(struct net *net, const char *name);
 struct net_device *__netdev_put_lock(struct net_device *dev);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
@@ -71,6 +70,8 @@ extern int		weight_p;
 extern int		dev_weight_rx_bias;
 extern int		dev_weight_tx_bias;
 
+extern struct rw_semaphore dev_addr_sem;
+
 /* rtnl helpers */
 extern struct list_head net_todo_list;
 void netdev_run_todo(void);
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 1f0e24849bc6..2e17548af685 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -84,6 +84,19 @@ void dev_set_group(struct net_device *dev, int new_group)
 	netdev_unlock_ops(dev);
 }
 
+int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			     struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_mac_address_user(dev, sa, extack);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_mac_address_user);
+
 /**
  * dev_change_net_namespace() - move device to different nethost namespace
  * @dev: device
@@ -299,9 +312,9 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 {
 	int ret;
 
-	netdev_lock(dev);
+	netdev_lock_ops(dev);
 	ret = netif_set_mac_address(dev, sa, extack);
-	netdev_unlock(dev);
+	netdev_unlock_ops(dev);
 
 	return ret;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 5471cf4fc984..eb8b41ec5523 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -575,7 +575,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	case SIOCSIFHWADDR:
 		if (dev->addr_len > sizeof(struct sockaddr))
 			return -EINVAL;
-		return dev_set_mac_address(dev, &ifr->ifr_hwaddr, NULL);
+		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
 
 	case SIOCSIFHWBROADCAST:
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 529a0f721268..abaa1c919b98 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -263,11 +263,14 @@ static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	netdev_lock(ndev);
+	down_read(&dev_addr_sem);
+
+	rcu_read_lock();
 	if (dev_isalive(ndev))
 		ret = sysfs_format_mac(buf, ndev->dev_addr, ndev->addr_len);
-	netdev_unlock(ndev);
+	rcu_read_unlock();
 
+	up_read(&dev_addr_sem);
 	return ret;
 }
 static DEVICE_ATTR_RO(address);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 90597bf84e3d..9355058bf996 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3090,11 +3090,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		sa->sa_family = dev->type;
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		if (!netdev_need_ops_lock(dev))
-			netdev_lock(dev);
-		err = netif_set_mac_address(dev, sa, extack);
-		if (!netdev_need_ops_lock(dev))
-			netdev_unlock(dev);
+		err = netif_set_mac_address_user(dev, sa, extack);
 		kfree(sa);
 		if (err)
 			goto errout;
-- 
2.48.1


