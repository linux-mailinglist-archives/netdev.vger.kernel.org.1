Return-Path: <netdev+bounces-170570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FEA4908F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A7F188DD0F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB31B0F21;
	Fri, 28 Feb 2025 04:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C211ADC7E
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718443; cv=none; b=t4vvgsYrER7ih7mgFu+KosDpZEA5mooTOcBF0zT2C6KMqfhcuyQNgWtA3V4Gvg0h8Ze06N4lSS3U+ExX4j8pX3/ISFEua/UoDBz6tl+xrAQRCxX45xAQe0us0MDZQ1WLnWaw4nCbbfah145axfAZT8RgAwEGJ6CuslsCYDiL9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718443; c=relaxed/simple;
	bh=hDfiG55/hUubkAUJm+rY60sLZQMADbkXrrEyWCiM3lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8x+SRE8r35JngUu4DWxrldhkkqSlZPKeDgV1sJ1suQKH3GKRTkxPic/79n7UQigcj/2/NQ74jcCCO8DSzSFmkFm63D710Bdy6JdLuzJnnyMtr8GEYNSi8FxhUYyy14h4KjxKiMyzu9Rw47kI7MCd60BPSyLFGvQL20Z03y499s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223480ea43aso42763075ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 20:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740718440; x=1741323240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mXJpawLcrdWtg6HIsael7iyuX2VTdusPjQkJGm1SYA=;
        b=mL24kGUm9gw1lQ76Ykkpi1qrjxVytsp29lP3pJpcfnarBgznlFs1ccdU4WC8bnK3mC
         9hL0W4afN5qVeloGX+jEVJWham8ZdhsjDiw9UEdJKYKrN/egzN0tOkx7pYJVgRdFip3y
         fIlH4h9QJ1qH+fh6ECKwS90VyiCbSdRz5rE7yegePnNC/OU/4FD7Put/n0DgluV4/lsT
         TqiUtjOAs7njDmyNpWFpYFutS+1CDnVVzbbORUoFgwKNlwYZz8DvhyF1drqKVcWi460n
         He/6ZwwOO2ZGkydGsa+yAKqE84Q2wPtwFOhe3f0hFG4fEwPtPwlc6fzSxxtA1oiOehrz
         gbzw==
X-Gm-Message-State: AOJu0Yxs+R5D0KQv36NOKLusFcM2PtMsnN3SGC1bkwjOiBv8XTzKJSDj
	M1YgLch/BBMjlf6GlsRr99N0h6f/nMbJLx/tuT2G6ECgMPvxRwuzwTCb
X-Gm-Gg: ASbGnctwh+ZkMdbMmy4YN4NhKruQm94eFZStCnAbtQ1ivA94qoSrH2JwA74DYdKKLZP
	/LkCfsX2kbMfsKlbHn4SsAUNI+c1tYKZiv680HQ6x6HfyRuvqro6zyTbNJApkJZalFux65oCW8g
	9K7adtG+nB9tOF6u38p420a+j5q6Zlc9DKqZQCH6Dbcx6mDQ6AyC85EX3i+s9eu++++jFeMZPTs
	dOB/tqUlY7mBdtcwXQNt9iuKiV/YbHePvEvRrMpi0a50jNlX0byV2yxRAE9cJFC20rAs905MEif
	baw7qHwoYhMlvK6HqCQtW3RQ9Q==
X-Google-Smtp-Source: AGHT+IGycQVQ3mjkejUcLrXRAAdVg8wHME0GAo5tncMS6qRA2uzm1zR5ktS3I1NA6B7mbwnuFc8o5g==
X-Received: by 2002:a05:6a00:3903:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-734ac34c898mr2787901b3a.6.1740718439669;
        Thu, 27 Feb 2025 20:53:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a0060081sm2719905b3a.167.2025.02.27.20.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:53:59 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v9 04/12] net: hold netdev instance lock during rtnetlink operations
Date: Thu, 27 Feb 2025 20:53:45 -0800
Message-ID: <20250228045353.1155942-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228045353.1155942-1-sdf@fomichev.me>
References: <20250228045353.1155942-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To preserve the atomicity, hold the lock while applying multiple
attributes. The major issue with a full conversion to the instance
lock are software nesting devices (bonding/team/vrf/etc). Those
devices call into the core stack for their lower (potentially
real hw) devices. To avoid explicitly wrapping all those places
into instance lock/unlock, introduce new API boundaries:

- (some) existing dev_xxx calls are now considered "external"
  (to drivers) APIs and they transparently grab the instance
  lock if needed (dev_api.c)
- new netif_xxx calls are internal core stack API (naming is
  sketchy, I've tried netdev_xxx_locked per Jakub's suggestion,
  but it feels a bit verbose; but happy to get back to this
  naming scheme if this is the preference)

This avoids touching most of the existing ioctl/sysfs/drivers paths.

Note the special handling of ndo_xxx_slave operations: I exploit
the fact that none of the drivers that call these functions
need/use instance lock. At the same time, they use dev_xxx
APIs, so the lower device has to be unlocked.

Changes in unregister_netdevice_many_notify (to protect dev->state
with instance lock) trigger lockdep - the loop over close_list
(mostly from cleanup_net) introduces spurious ordering issues.
netdev_lock_cmp_fn has a justification on why it's ok to suppress
for now.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  40 ++++++-
 net/core/Makefile         |   2 +-
 net/core/dev.c            | 153 +++++---------------------
 net/core/dev.h            |  13 ++-
 net/core/dev_api.c        | 224 ++++++++++++++++++++++++++++++++++++++
 net/core/rtnetlink.c      |  46 +++++---
 6 files changed, 329 insertions(+), 149 deletions(-)
 create mode 100644 net/core/dev_api.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a8ee0d277fa9..377a7fa4056c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2620,16 +2620,35 @@ static inline void netdev_for_each_tx_queue(struct net_device *dev,
 		f(dev, &dev->_tx[i], arg);
 }
 
+static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
+				     const struct lockdep_map *b)
+{
+	/* Only lower devices currently grab the instance lock, so no
+	 * real ordering issues can occur. In the near future, only
+	 * hardware devices will grab instance lock which also does not
+	 * involve any ordering. Suppress lockdep ordering warnings
+	 * until (if) we start grabbing instance lock on pure SW
+	 * devices (bond/team/veth/etc).
+	 */
+	if (a == b)
+		return 0;
+	return -1;
+}
+
 #define netdev_lockdep_set_classes(dev)				\
 {								\
 	static struct lock_class_key qdisc_tx_busylock_key;	\
 	static struct lock_class_key qdisc_xmit_lock_key;	\
 	static struct lock_class_key dev_addr_list_lock_key;	\
+	static struct lock_class_key dev_instance_lock_key;	\
 	unsigned int i;						\
 								\
 	(dev)->qdisc_tx_busylock = &qdisc_tx_busylock_key;	\
 	lockdep_set_class(&(dev)->addr_list_lock,		\
 			  &dev_addr_list_lock_key);		\
+	lockdep_set_class(&(dev)->lock,				\
+			  &dev_instance_lock_key);		\
+	lock_set_cmp_fn(&dev->lock, netdev_lock_cmp_fn, NULL);	\
 	for (i = 0; i < (dev)->num_tx_queues; i++)		\
 		lockdep_set_class(&(dev)->_tx[i]._xmit_lock,	\
 				  &qdisc_xmit_lock_key);	\
@@ -2776,6 +2795,12 @@ static inline void netdev_unlock_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
+static inline void netdev_ops_assert_locked(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		lockdep_assert_held(&dev->lock);
+}
+
 void netif_napi_set_irq_locked(struct napi_struct *napi, int irq);
 
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
@@ -3350,7 +3375,9 @@ struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
 struct net_device *__dev_get_by_name(struct net *net, const char *name);
 bool netdev_name_in_use(struct net *net, const char *name);
 int dev_alloc_name(struct net_device *dev, const char *name);
+int netif_open(struct net_device *dev, struct netlink_ext_ack *extack);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
+void netif_close(struct net_device *dev);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
@@ -4211,24 +4238,25 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		       struct netlink_ext_ack *extack);
+int netif_change_flags(struct net_device *dev, unsigned int flags,
+		       struct netlink_ext_ack *extack);
 int dev_change_flags(struct net_device *dev, unsigned int flags,
 		     struct netlink_ext_ack *extack);
+int netif_set_alias(struct net_device *dev, const char *alias, size_t len);
 int dev_set_alias(struct net_device *, const char *, size_t);
 int dev_get_alias(const struct net_device *, char *, size_t);
-int __dev_change_net_namespace(struct net_device *dev, struct net *net,
+int netif_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex);
-static inline
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
-			     const char *pat)
-{
-	return __dev_change_net_namespace(dev, net, pat, 0);
-}
+			     const char *pat);
 int __dev_set_mtu(struct net_device *, int);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
+int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			       struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
diff --git a/net/core/Makefile b/net/core/Makefile
index d9326600e289..a10c3bd96798 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -9,7 +9,7 @@ obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
+obj-y		     += dev.o dev_api.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
diff --git a/net/core/dev.c b/net/core/dev.c
index 6161a7a964ec..b765c848280d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1371,15 +1371,7 @@ static int dev_get_valid_name(struct net *net, struct net_device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-/**
- *	dev_change_name - change name of a device
- *	@dev: device
- *	@newname: name (or format string) must be at least IFNAMSIZ
- *
- *	Change name of a device, can pass format strings "eth%d".
- *	for wildcarding.
- */
-int dev_change_name(struct net_device *dev, const char *newname)
+int netif_change_name(struct net_device *dev, const char *newname)
 {
 	struct net *net = dev_net(dev);
 	unsigned char old_assign_type;
@@ -1449,15 +1441,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	return err;
 }
 
-/**
- *	dev_set_alias - change ifalias of a device
- *	@dev: device
- *	@alias: name up to IFALIASZ
- *	@len: limit of bytes to copy from info
- *
- *	Set ifalias for a device,
- */
-int dev_set_alias(struct net_device *dev, const char *alias, size_t len)
+int netif_set_alias(struct net_device *dev, const char *alias, size_t len)
 {
 	struct dev_ifalias *new_alias = NULL;
 
@@ -1483,7 +1467,6 @@ int dev_set_alias(struct net_device *dev, const char *alias, size_t len)
 
 	return len;
 }
-EXPORT_SYMBOL(dev_set_alias);
 
 /**
  *	dev_get_alias - get ifalias of a device
@@ -1627,10 +1610,10 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		return ret;
 
-	netdev_lock_ops(dev);
-
 	set_bit(__LINK_STATE_START, &dev->state);
 
+	netdev_ops_assert_locked(dev);
+
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
 
@@ -1648,25 +1631,10 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 		add_device_randomness(dev->dev_addr, dev->addr_len);
 	}
 
-	netdev_unlock_ops(dev);
-
 	return ret;
 }
 
-/**
- *	dev_open	- prepare an interface for use.
- *	@dev: device to open
- *	@extack: netlink extended ack
- *
- *	Takes a device from down to up state. The device's private open
- *	function is invoked and then the multicast lists are loaded. Finally
- *	the device is moved into the up state and a %NETDEV_UP message is
- *	sent to the netdev notifier chain.
- *
- *	Calling this function on an active interface is a nop. On a failure
- *	a negative errno code is returned.
- */
-int dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
+int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
 	int ret;
 
@@ -1682,7 +1650,6 @@ int dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	return ret;
 }
-EXPORT_SYMBOL(dev_open);
 
 static void __dev_close_many(struct list_head *head)
 {
@@ -1721,18 +1688,13 @@ static void __dev_close_many(struct list_head *head)
 		 *	event.
 		 */
 
-		/* TODO: move the lock up before clearing __LINK_STATE_START.
-		 * Generates spurious lockdep warning.
-		 */
-		netdev_lock_ops(dev);
+		netdev_ops_assert_locked(dev);
 
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
-
-		netdev_unlock_ops(dev);
 	}
 }
 
@@ -1765,16 +1727,7 @@ void dev_close_many(struct list_head *head, bool unlink)
 }
 EXPORT_SYMBOL(dev_close_many);
 
-/**
- *	dev_close - shutdown an interface.
- *	@dev: device to shutdown
- *
- *	This function moves an active device into down state. A
- *	%NETDEV_GOING_DOWN is sent to the netdev notifier chain. The device
- *	is then deactivated and finally a %NETDEV_DOWN is sent to the notifier
- *	chain.
- */
-void dev_close(struct net_device *dev)
+void netif_close(struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
 		LIST_HEAD(single);
@@ -1784,7 +1737,6 @@ void dev_close(struct net_device *dev)
 		list_del(&single);
 	}
 }
-EXPORT_SYMBOL(dev_close);
 
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data)
@@ -9479,17 +9431,8 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 	}
 }
 
-/**
- *	dev_change_flags - change device settings
- *	@dev: device
- *	@flags: device state flags
- *	@extack: netlink extended ack
- *
- *	Change settings on device based state flags. The flags are
- *	in the userspace exported format.
- */
-int dev_change_flags(struct net_device *dev, unsigned int flags,
-		     struct netlink_ext_ack *extack)
+int netif_change_flags(struct net_device *dev, unsigned int flags,
+		       struct netlink_ext_ack *extack)
 {
 	int ret;
 	unsigned int changes, old_flags = dev->flags, old_gflags = dev->gflags;
@@ -9502,7 +9445,6 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
 	__dev_notify_flags(dev, old_flags, changes, 0, NULL);
 	return ret;
 }
-EXPORT_SYMBOL(dev_change_flags);
 
 int __dev_set_mtu(struct net_device *dev, int new_mtu)
 {
@@ -9534,15 +9476,15 @@ int dev_validate_mtu(struct net_device *dev, int new_mtu,
 }
 
 /**
- *	dev_set_mtu_ext - Change maximum transfer unit
+ *	netif_set_mtu_ext - Change maximum transfer unit
  *	@dev: device
  *	@new_mtu: new transfer unit
  *	@extack: netlink extended ack
  *
  *	Change the maximum transfer size of the network device.
  */
-int dev_set_mtu_ext(struct net_device *dev, int new_mtu,
-		    struct netlink_ext_ack *extack)
+int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
+		      struct netlink_ext_ack *extack)
 {
 	int err, orig_mtu;
 
@@ -9586,19 +9528,14 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
 	int err;
 
 	memset(&extack, 0, sizeof(extack));
-	err = dev_set_mtu_ext(dev, new_mtu, &extack);
+	err = netif_set_mtu_ext(dev, new_mtu, &extack);
 	if (err && extack._msg)
 		net_err_ratelimited("%s: %s\n", dev->name, extack._msg);
 	return err;
 }
 EXPORT_SYMBOL(dev_set_mtu);
 
-/**
- *	dev_change_tx_queue_len - Change TX queue length of a netdevice
- *	@dev: device
- *	@new_len: new tx queue length
- */
-int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
+int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 {
 	unsigned int orig_len = dev->tx_queue_len;
 	int res;
@@ -9625,12 +9562,7 @@ int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 	return res;
 }
 
-/**
- *	dev_set_group - Change group this device belongs to
- *	@dev: device
- *	@new_group: group this device should belong to
- */
-void dev_set_group(struct net_device *dev, int new_group)
+void netif_set_group(struct net_device *dev, int new_group)
 {
 	dev->group = new_group;
 }
@@ -9693,8 +9625,8 @@ EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
-			     struct netlink_ext_ack *extack)
+int netif_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+			       struct netlink_ext_ack *extack)
 {
 	int ret;
 
@@ -9703,7 +9635,6 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 	up_write(&dev_addr_sem);
 	return ret;
 }
-EXPORT_SYMBOL(dev_set_mac_address_user);
 
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
@@ -9733,14 +9664,7 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 }
 EXPORT_SYMBOL(dev_get_mac_address);
 
-/**
- *	dev_change_carrier - Change device carrier
- *	@dev: device
- *	@new_carrier: new value
- *
- *	Change device carrier
- */
-int dev_change_carrier(struct net_device *dev, bool new_carrier)
+int netif_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9851,13 +9775,7 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 }
 EXPORT_SYMBOL(netdev_port_same_parent_id);
 
-/**
- *	dev_change_proto_down - set carrier according to proto_down.
- *
- *	@dev: device
- *	@proto_down: new value
- */
-int dev_change_proto_down(struct net_device *dev, bool proto_down)
+int netif_change_proto_down(struct net_device *dev, bool proto_down)
 {
 	if (!dev->change_proto_down)
 		return -EOPNOTSUPP;
@@ -9872,14 +9790,14 @@ int dev_change_proto_down(struct net_device *dev, bool proto_down)
 }
 
 /**
- *	dev_change_proto_down_reason - proto down reason
+ *	netdev_change_proto_down_reason_locked - proto down reason
  *
  *	@dev: device
  *	@mask: proto down mask
  *	@value: proto down value
  */
-void dev_change_proto_down_reason(struct net_device *dev, unsigned long mask,
-				  u32 value)
+void netdev_change_proto_down_reason_locked(struct net_device *dev,
+					    unsigned long mask, u32 value)
 {
 	u32 proto_down_reason;
 	int b;
@@ -10687,6 +10605,7 @@ int __netdev_update_features(struct net_device *dev)
 	int err = -1;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	features = netdev_get_wanted_features(dev);
 
@@ -12036,11 +11955,14 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	}
 
 	/* If device is running, close it first. */
-	list_for_each_entry(dev, head, unreg_list)
+	list_for_each_entry(dev, head, unreg_list) {
 		list_add_tail(&dev->close_list, &close_head);
+		netdev_lock_ops(dev);
+	}
 	dev_close_many(&close_head, true);
 
 	list_for_each_entry(dev, head, unreg_list) {
+		netdev_unlock_ops(dev);
 		/* And unlink it from device chain. */
 		unlist_netdevice(dev);
 		netdev_lock(dev);
@@ -12153,23 +12075,7 @@ void unregister_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-/**
- *	__dev_change_net_namespace - move device to different nethost namespace
- *	@dev: device
- *	@net: network namespace
- *	@pat: If not NULL name pattern to try if the current device name
- *	      is already taken in the destination network namespace.
- *	@new_ifindex: If not zero, specifies device index in the target
- *	              namespace.
- *
- *	This function shuts down a device interface and moves it
- *	to a new network namespace. On success 0 is returned, on
- *	a failure a netagive errno code is returned.
- *
- *	Callers must hold the rtnl semaphore.
- */
-
-int __dev_change_net_namespace(struct net_device *dev, struct net *net,
+int netif_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex)
 {
 	struct netdev_name_node *name_node;
@@ -12231,7 +12137,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	 */
 
 	/* If device is running close it first. */
-	dev_close(dev);
+	netif_close(dev);
 
 	/* And unlink it from device chain */
 	unlist_netdevice(dev);
@@ -12313,7 +12219,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 out:
 	return err;
 }
-EXPORT_SYMBOL_GPL(__dev_change_net_namespace);
 
 static int dev_cpu_dead(unsigned int oldcpu)
 {
diff --git a/net/core/dev.h b/net/core/dev.h
index 25bb9d6afbce..41b0831aba60 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -85,6 +85,7 @@ struct netdev_name_node {
 };
 
 int netdev_get_name(struct net *net, char *name, int ifindex);
+int netif_change_name(struct net_device *dev, const char *newname);
 int dev_change_name(struct net_device *dev, const char *newname);
 
 #define netdev_for_each_altname(dev, namenode)				\
@@ -98,24 +99,28 @@ int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
 
 int dev_validate_mtu(struct net_device *dev, int mtu,
 		     struct netlink_ext_ack *extack);
-int dev_set_mtu_ext(struct net_device *dev, int mtu,
-		    struct netlink_ext_ack *extack);
+int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
+		      struct netlink_ext_ack *extack);
 
 int dev_get_phys_port_id(struct net_device *dev,
 			 struct netdev_phys_item_id *ppid);
 int dev_get_phys_port_name(struct net_device *dev,
 			   char *name, size_t len);
 
+int netif_change_proto_down(struct net_device *dev, bool proto_down);
 int dev_change_proto_down(struct net_device *dev, bool proto_down);
-void dev_change_proto_down_reason(struct net_device *dev, unsigned long mask,
-				  u32 value);
+void netdev_change_proto_down_reason_locked(struct net_device *dev,
+					    unsigned long mask, u32 value);
 
 typedef int (*bpf_op_t)(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 		      int fd, int expected_fd, u32 flags);
 
+int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len);
 int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len);
+void netif_set_group(struct net_device *dev, int new_group);
 void dev_set_group(struct net_device *dev, int new_group);
+int netif_change_carrier(struct net_device *dev, bool new_carrier);
 int dev_change_carrier(struct net_device *dev, bool new_carrier);
 
 void __dev_set_rx_mode(struct net_device *dev);
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
new file mode 100644
index 000000000000..ce3a38c8e326
--- /dev/null
+++ b/net/core/dev_api.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/netdevice.h>
+
+#include "dev.h"
+
+/**
+ * dev_change_name() - change name of a device
+ * @dev: device
+ * @newname: name (or format string) must be at least IFNAMSIZ
+ *
+ * Change name of a device, can pass format strings "eth%d".
+ * for wildcarding.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_name(struct net_device *dev, const char *newname)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_name(dev, newname);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+
+/**
+ * dev_set_alias() - change ifalias of a device
+ * @dev: device
+ * @alias: name up to IFALIASZ
+ * @len: limit of bytes to copy from info
+ *
+ * Set ifalias for a device.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_set_alias(struct net_device *dev, const char *alias, size_t len)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_alias(dev, alias, len);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_alias);
+
+/**
+ * dev_change_flags() - change device settings
+ * @dev: device
+ * @flags: device state flags
+ * @extack: netlink extended ack
+ *
+ * Change settings on device based state flags. The flags are
+ * in the userspace exported format.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_flags(struct net_device *dev, unsigned int flags,
+		     struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_flags(dev, flags, extack);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_change_flags);
+
+/**
+ * dev_set_group() - change group this device belongs to
+ * @dev: device
+ * @new_group: group this device should belong to
+ */
+void dev_set_group(struct net_device *dev, int new_group)
+{
+	netdev_lock_ops(dev);
+	netif_set_group(dev, new_group);
+	netdev_unlock_ops(dev);
+}
+
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
+/**
+ * dev_change_net_namespace() - move device to different nethost namespace
+ * @dev: device
+ * @net: network namespace
+ * @pat: If not NULL name pattern to try if the current device name
+ *       is already taken in the destination network namespace.
+ *
+ * This function shuts down a device interface and moves it
+ * to a new network namespace. On success 0 is returned, on
+ * a failure a netagive errno code is returned.
+ *
+ * Callers must hold the rtnl semaphore.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_net_namespace(struct net_device *dev, struct net *net,
+			     const char *pat)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_net_namespace(dev, net, pat, 0);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_change_net_namespace);
+
+/**
+ * dev_change_carrier() - change device carrier
+ * @dev: device
+ * @new_carrier: new value
+ *
+ * Change device carrier
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_carrier(struct net_device *dev, bool new_carrier)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_carrier(dev, new_carrier);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+
+/**
+ * dev_change_tx_queue_len() - change TX queue length of a netdevice
+ * @dev: device
+ * @new_len: new tx queue length
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_tx_queue_len(dev, new_len);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+
+/**
+ * dev_change_proto_down() - set carrier according to proto_down
+ * @dev: device
+ * @proto_down: new value
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_change_proto_down(struct net_device *dev, bool proto_down)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_change_proto_down(dev, proto_down);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+
+/**
+ * dev_open() - prepare an interface for use
+ * @dev: device to open
+ * @extack: netlink extended ack
+ *
+ * Takes a device from down to up state. The device's private open
+ * function is invoked and then the multicast lists are loaded. Finally
+ * the device is moved into the up state and a %NETDEV_UP message is
+ * sent to the netdev notifier chain.
+ *
+ * Calling this function on an active interface is a nop. On a failure
+ * a negative errno code is returned.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_open(dev, extack);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_open);
+
+/**
+ * dev_close() - shutdown an interface
+ * @dev: device to shutdown
+ *
+ * This function moves an active device into down state. A
+ * %NETDEV_GOING_DOWN is sent to the netdev notifier chain. The device
+ * is then deactivated and finally a %NETDEV_DOWN is sent to the notifier
+ * chain.
+ */
+void dev_close(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_close(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(dev_close);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b52e610e157e..7828584a6791 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2909,12 +2909,19 @@ static int do_set_master(struct net_device *dev, int ifindex,
 	const struct net_device_ops *ops;
 	int err;
 
+	/* Release the lower lock, the upper is responsible for locking
+	 * the lower if needed. None of the existing upper devices
+	 * use netdev instance lock, so don't grab it.
+	 */
+
 	if (upper_dev) {
 		if (upper_dev->ifindex == ifindex)
 			return 0;
 		ops = upper_dev->netdev_ops;
 		if (ops->ndo_del_slave) {
+			netdev_unlock_ops(dev);
 			err = ops->ndo_del_slave(upper_dev, dev);
+			netdev_lock_ops(dev);
 			if (err)
 				return err;
 		} else {
@@ -2928,7 +2935,9 @@ static int do_set_master(struct net_device *dev, int ifindex,
 			return -EINVAL;
 		ops = upper_dev->netdev_ops;
 		if (ops->ndo_add_slave) {
+			netdev_unlock_ops(dev);
 			err = ops->ndo_add_slave(upper_dev, dev, extack);
+			netdev_lock_ops(dev);
 			if (err)
 				return err;
 		} else {
@@ -2978,7 +2987,7 @@ static int do_set_proto_down(struct net_device *dev,
 		if (pdreason[IFLA_PROTO_DOWN_REASON_MASK])
 			mask = nla_get_u32(pdreason[IFLA_PROTO_DOWN_REASON_MASK]);
 
-		dev_change_proto_down_reason(dev, mask, value);
+		netdev_change_proto_down_reason_locked(dev, mask, value);
 	}
 
 	if (nl_proto_down) {
@@ -2989,8 +2998,7 @@ static int do_set_proto_down(struct net_device *dev,
 			NL_SET_ERR_MSG(extack, "Cannot clear protodown, active reasons");
 			return -EBUSY;
 		}
-		err = dev_change_proto_down(dev,
-					    proto_down);
+		err = netif_change_proto_down(dev, proto_down);
 		if (err)
 			return err;
 	}
@@ -3010,6 +3018,8 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	char ifname[IFNAMSIZ];
 	int err;
 
+	netdev_lock_ops(dev);
+
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
 		goto errout;
@@ -3025,7 +3035,8 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
-		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
+		err = netif_change_net_namespace(dev, tgt_net, pat,
+						 new_ifindex);
 		if (err)
 			goto errout;
 
@@ -3075,7 +3086,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		sa->sa_family = dev->type;
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		err = dev_set_mac_address_user(dev, sa, extack);
+		err = netif_set_mac_address_user(dev, sa, extack);
 		kfree(sa);
 		if (err)
 			goto errout;
@@ -3083,14 +3094,14 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (tb[IFLA_MTU]) {
-		err = dev_set_mtu_ext(dev, nla_get_u32(tb[IFLA_MTU]), extack);
+		err = netif_set_mtu_ext(dev, nla_get_u32(tb[IFLA_MTU]), extack);
 		if (err < 0)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
 	}
 
 	if (tb[IFLA_GROUP]) {
-		dev_set_group(dev, nla_get_u32(tb[IFLA_GROUP]));
+		netif_set_group(dev, nla_get_u32(tb[IFLA_GROUP]));
 		status |= DO_SETLINK_NOTIFY;
 	}
 
@@ -3100,15 +3111,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	 * requested.
 	 */
 	if (ifm->ifi_index > 0 && ifname[0]) {
-		err = dev_change_name(dev, ifname);
+		err = netif_change_name(dev, ifname);
 		if (err < 0)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
 	}
 
 	if (tb[IFLA_IFALIAS]) {
-		err = dev_set_alias(dev, nla_data(tb[IFLA_IFALIAS]),
-				    nla_len(tb[IFLA_IFALIAS]));
+		err = netif_set_alias(dev, nla_data(tb[IFLA_IFALIAS]),
+				      nla_len(tb[IFLA_IFALIAS]));
 		if (err < 0)
 			goto errout;
 		status |= DO_SETLINK_NOTIFY;
@@ -3120,8 +3131,8 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (ifm->ifi_flags || ifm->ifi_change) {
-		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
-				       extack);
+		err = netif_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
+					 extack);
 		if (err < 0)
 			goto errout;
 	}
@@ -3134,7 +3145,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (tb[IFLA_CARRIER]) {
-		err = dev_change_carrier(dev, nla_get_u8(tb[IFLA_CARRIER]));
+		err = netif_change_carrier(dev, nla_get_u8(tb[IFLA_CARRIER]));
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
@@ -3143,7 +3154,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	if (tb[IFLA_TXQLEN]) {
 		unsigned int value = nla_get_u32(tb[IFLA_TXQLEN]);
 
-		err = dev_change_tx_queue_len(dev, value);
+		err = netif_change_tx_queue_len(dev, value);
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
@@ -3374,6 +3385,8 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 					     dev->name);
 	}
 
+	netdev_unlock_ops(dev);
+
 	return err;
 }
 
@@ -3807,6 +3820,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		goto out;
 	}
 
+	netdev_lock_ops(dev);
+
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
@@ -3815,9 +3830,12 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		if (err)
 			goto out_unregister;
 	}
+
+	netdev_unlock_ops(dev);
 out:
 	return err;
 out_unregister:
+	netdev_unlock_ops(dev);
 	if (ops->newlink) {
 		LIST_HEAD(list_kill);
 
-- 
2.48.1


