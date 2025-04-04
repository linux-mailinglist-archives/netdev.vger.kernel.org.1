Return-Path: <netdev+bounces-179348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19CA7C150
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEF3BC6DB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E5207A26;
	Fri,  4 Apr 2025 16:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0C2036E8;
	Fri,  4 Apr 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783087; cv=none; b=ou0n0FId6pkIKrW9AlLTUcY1hB06FsdcCBHHvvF8Z49cRXiAIH5XAQmEaxeV2JLc8iYNTrN4sSUE5naZ1WyCSahiY0WREkfCoNW0poBDg/Hef+Unh+xUCPwa359erEiL3Vx0mKjn46hUEcqdbmY8A4YwGgqH+1tisPSq+ODwX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783087; c=relaxed/simple;
	bh=H5MQWT7nCLDyNR+Z4Y9keYaUN0IujSyqpxw4zl4sTbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiv17Q4FV0d699Gd8KcdxA904gdjmpS7Wsx28y05Hd7kX83LgQ7wBkwp2UlF/glk5IBm4ZZ6HPF39NlZ7Qj2iDKlQG81kyQyLvfkBcAIN9dZiyUBzZ6rrbjcWfi3NxhntfgghAAuDISXcl7Navu167NuutkIHn8B0TPCWsFKz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af241f0a4beso1906958a12.2;
        Fri, 04 Apr 2025 09:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783083; x=1744387883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYibj8v1WsCdAupbON054VLeROn+dyl08ImUB4vo6kA=;
        b=oibQNtsxzL3SorUFd6q+hjsw7C0mwD4xtzwSHQ6wiXIKuAkpOMggHZ2U3ao4NyRDjc
         4v9EkBoj8538UvuBhaNQ1YxUjay5stYbExIzedK5Ja4KG8N4gev2/a7Qx/qnZZwf0C4s
         7BV4eRWdbSYUxVhVUxq9WPE4tx9koSdzVxFWykxu2lkBtXAo7zdKI/pWXcnBDjzNTEuM
         D7EQOHQVd8E48WSAovs2N5AEl0GE6ZputWJrI6bYvyaQclgh2Osv0r4ZSANqSm1yj2Ot
         aBdDnDsN1BRInlUZJSpbgKLli8Gl19peWqylWMY9mfPnw0cZIVfvvluSKckNHazJrbhN
         oX+A==
X-Forwarded-Encrypted: i=1; AJvYcCX1cX9UdBUDex39e7k3g+RmeoAIkpPjn0/tGhydkxpyDboG+gIhIgKrFp6PZnD4UkbW7PCeCxBOegI=@vger.kernel.org, AJvYcCXss+iQa4yorlQEuBLW/mYV5Kp9EYPoxxcdSXUEZpbInO9MU+Up63k7Ejfka+zUwrbp4iibOervPi1oc1cv@vger.kernel.org
X-Gm-Message-State: AOJu0YzOenNjeSI3oLqO0fbLSLwfi4TkuttuKGO935y8x4WI4u/UlNOE
	xUFw/6L6ZdCX0FfvrZjWECSCjmGwQ0GHDIhR7/63o4wQoEyzs+ysfXQz
X-Gm-Gg: ASbGncvjOVY9J6t5i7gV3Wm92kR/rJVEh2xzlCpU+sWAPtxSDOGCXJaaMmkz4ytIvJu
	cSi1WPajZNEIBjXr7zazglk9JvuMP7La7zYQBikKXUCyZk8JUoQpmcynlE0HITGUSEdmTG1pagY
	LCG1BNvvqD4LsUw1WnAF3bVi8mrPipT5ueCGgtsCPs34O3QbxEmhOoD5/kMMHWC2iAxhPbplAQe
	yM+Z6eL+F1iq2oNtZuygxKhfnrt0oEefjsxBE75v2sFxx7VQ2TGpPp3UD1AZ5jngzqBI6oQp31E
	xVyw99+p6iDuWBYysqIaQRYTZlAobyoULLZcR6S0Hf32ZIKH8imrNZk=
X-Google-Smtp-Source: AGHT+IFzE1kDsi69TyzkhNxhskXb1xZHh0zhCJwRW6uZ4w6F9lWUlVuP47ZPARnize2RCt2M7g2L9g==
X-Received: by 2002:a17:90b:5190:b0:301:6343:1626 with SMTP id 98e67ed59e1d1-306a6120a09mr4224266a91.1.1743783083504;
        Fri, 04 Apr 2025 09:11:23 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305983d801csm4027687a91.43.2025.04.04.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 09:11:23 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	kuniyu@amazon.com,
	vladimir.oltean@nxp.com,
	ecree.xilinx@gmail.com,
	lukma@denx.de,
	m-karicheri2@ti.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net] net: hold instance lock during NETDEV_CHANGE
Date: Fri,  4 Apr 2025 09:11:22 -0700
Message-ID: <20250404161122.3907628-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmin reports an issue with ipv6_add_dev being called from
NETDEV_CHANGE notifier:

[ 3455.008776]  ? ipv6_add_dev+0x370/0x620
[ 3455.010097]  ipv6_find_idev+0x96/0xe0
[ 3455.010725]  addrconf_add_dev+0x1e/0xa0
[ 3455.011382]  addrconf_init_auto_addrs+0xb0/0x720
[ 3455.013537]  addrconf_notify+0x35f/0x8d0
[ 3455.014214]  notifier_call_chain+0x38/0xf0
[ 3455.014903]  netdev_state_change+0x65/0x90
[ 3455.015586]  linkwatch_do_dev+0x5a/0x70
[ 3455.016238]  rtnl_getlink+0x241/0x3e0
[ 3455.019046]  rtnetlink_rcv_msg+0x177/0x5e0

Similarly, linkwatch might get to ipv6_add_dev without ops lock:
[ 3456.656261]  ? ipv6_add_dev+0x370/0x620
[ 3456.660039]  ipv6_find_idev+0x96/0xe0
[ 3456.660445]  addrconf_add_dev+0x1e/0xa0
[ 3456.660861]  addrconf_init_auto_addrs+0xb0/0x720
[ 3456.661803]  addrconf_notify+0x35f/0x8d0
[ 3456.662236]  notifier_call_chain+0x38/0xf0
[ 3456.662676]  netdev_state_change+0x65/0x90
[ 3456.663112]  linkwatch_do_dev+0x5a/0x70
[ 3456.663529]  __linkwatch_run_queue+0xeb/0x200
[ 3456.663990]  linkwatch_event+0x21/0x30
[ 3456.664399]  process_one_work+0x211/0x610
[ 3456.664828]  worker_thread+0x1cc/0x380
[ 3456.665691]  kthread+0xf4/0x210

Reclassify NETDEV_CHANGE as a notifier that consistently runs under the
instance lock.

Link: https://lore.kernel.org/netdev/aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com/
Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Tested-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 10 +++++----
 include/linux/netdevice.h               |  2 ++
 include/linux/rtnetlink.h               |  2 +-
 net/core/dev.c                          | 11 +---------
 net/core/dev_api.c                      | 16 ++++++++++++++
 net/core/link_watch.c                   | 28 ++++++++++++++++++++-----
 net/core/lock_debug.c                   |  2 +-
 net/core/rtnetlink.c                    | 15 +++++++------
 net/ethtool/ioctl.c                     |  2 +-
 net/hsr/hsr_device.c                    |  6 +++---
 10 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 6c2d8945f597..eab601ab2db0 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -338,10 +338,11 @@ operations directly under the netdev instance lock.
 Devices drivers are encouraged to rely on the instance lock where possible.
 
 For the (mostly software) drivers that need to interact with the core stack,
-there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
-``dev_set_mtu`` and ``netif_set_mtu``). The ``dev_xxx`` functions handle
-acquiring the instance lock themselves, while the ``netif_xxx`` functions
-assume that the driver has already acquired the instance lock.
+there are two sets of interfaces: ``dev_xxx``/``netdev_xxx`` and ``netif_xxx``
+(e.g., ``dev_set_mtu`` and ``netif_set_mtu``). The ``dev_xxx``/``netdev_xxx``
+functions handle acquiring the instance lock themselves, while the
+``netif_xxx`` functions assume that the driver has already acquired
+the instance lock.
 
 Notifiers and netdev instance lock
 ==================================
@@ -354,6 +355,7 @@ For devices with locked ops, currently only the following notifiers are
 running under the lock:
 * ``NETDEV_REGISTER``
 * ``NETDEV_UP``
+* ``NETDEV_CHANGE``
 
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..2d11d013cabe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4429,6 +4429,7 @@ void linkwatch_fire_event(struct net_device *dev);
  * pending work list (if queued).
  */
 void linkwatch_sync_dev(struct net_device *dev);
+void __linkwatch_sync_dev(struct net_device *dev);
 
 /**
  *	netif_carrier_ok - test if carrier present
@@ -4974,6 +4975,7 @@ void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
+void netif_state_change(struct net_device *dev);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
 void netdev_notify_peers(struct net_device *dev);
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ccaaf4c7d5f6..ea39dd23a197 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -240,6 +240,6 @@ rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
 	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
 }
 
-void netdev_set_operstate(struct net_device *dev, int newstate);
+void netif_set_operstate(struct net_device *dev, int newstate);
 
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 0608605cfc24..75e104322ad5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1518,15 +1518,7 @@ void netdev_features_change(struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_features_change);
 
-/**
- *	netdev_state_change - device changes state
- *	@dev: device to cause notification
- *
- *	Called to indicate a device has changed state. This function calls
- *	the notifier chains for netdev_chain and sends a NEWLINK message
- *	to the routing socket.
- */
-void netdev_state_change(struct net_device *dev)
+void netif_state_change(struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
 		struct netdev_notifier_change_info change_info = {
@@ -1538,7 +1530,6 @@ void netdev_state_change(struct net_device *dev)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, 0, GFP_KERNEL, 0, NULL);
 	}
 }
-EXPORT_SYMBOL(netdev_state_change);
 
 /**
  * __netdev_notify_peers - notify network peers about existence of @dev,
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 90bafb0b1b8c..90898cd540ce 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -327,3 +327,19 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_xdp_propagate);
+
+/**
+ * netdev_state_change() - device changes state
+ * @dev: device to cause notification
+ *
+ * Called to indicate a device has changed state. This function calls
+ * the notifier chains for netdev_chain and sends a NEWLINK message
+ * to the routing socket.
+ */
+void netdev_state_change(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_state_change(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(netdev_state_change);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index cb04ef2b9807..864f3bbc3a4c 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -183,7 +183,7 @@ static void linkwatch_do_dev(struct net_device *dev)
 		else
 			dev_deactivate(dev);
 
-		netdev_state_change(dev);
+		netif_state_change(dev);
 	}
 	/* Note: our callers are responsible for calling netdev_tracker_free().
 	 * This is the reason we use __dev_put() instead of dev_put().
@@ -240,7 +240,9 @@ static void __linkwatch_run_queue(int urgent_only)
 		 */
 		netdev_tracker_free(dev, &dev->linkwatch_dev_tracker);
 		spin_unlock_irq(&lweventlist_lock);
+		netdev_lock_ops(dev);
 		linkwatch_do_dev(dev);
+		netdev_unlock_ops(dev);
 		do_dev--;
 		spin_lock_irq(&lweventlist_lock);
 	}
@@ -253,25 +255,41 @@ static void __linkwatch_run_queue(int urgent_only)
 	spin_unlock_irq(&lweventlist_lock);
 }
 
-void linkwatch_sync_dev(struct net_device *dev)
+static bool linkwatch_clean_dev(struct net_device *dev)
 {
 	unsigned long flags;
-	int clean = 0;
+	bool clean = false;
 
 	spin_lock_irqsave(&lweventlist_lock, flags);
 	if (!list_empty(&dev->link_watch_list)) {
 		list_del_init(&dev->link_watch_list);
-		clean = 1;
+		clean = true;
 		/* We must release netdev tracker under
 		 * the spinlock protection.
 		 */
 		netdev_tracker_free(dev, &dev->linkwatch_dev_tracker);
 	}
 	spin_unlock_irqrestore(&lweventlist_lock, flags);
-	if (clean)
+
+	return clean;
+}
+
+void __linkwatch_sync_dev(struct net_device *dev)
+{
+	netdev_ops_assert_locked(dev);
+
+	if (linkwatch_clean_dev(dev))
 		linkwatch_do_dev(dev);
 }
 
+void linkwatch_sync_dev(struct net_device *dev)
+{
+	if (linkwatch_clean_dev(dev)) {
+		netdev_lock_ops(dev);
+		linkwatch_do_dev(dev);
+		netdev_unlock_ops(dev);
+	}
+}
 
 /* Must be called with the rtnl semaphore held */
 void linkwatch_run_queue(void)
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index b7f22dc92a6f..941e26c1343d 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -20,11 +20,11 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	switch (cmd) {
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
+	case NETDEV_CHANGE:
 		netdev_ops_assert_locked(dev);
 		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
-	case NETDEV_CHANGE:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c23852835050..d8d03ff87a3b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1043,7 +1043,7 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 }
 EXPORT_SYMBOL_GPL(rtnl_put_cacheinfo);
 
-void netdev_set_operstate(struct net_device *dev, int newstate)
+void netif_set_operstate(struct net_device *dev, int newstate)
 {
 	unsigned int old = READ_ONCE(dev->operstate);
 
@@ -1052,9 +1052,9 @@ void netdev_set_operstate(struct net_device *dev, int newstate)
 			return;
 	} while (!try_cmpxchg(&dev->operstate, &old, newstate));
 
-	netdev_state_change(dev);
+	netif_state_change(dev);
 }
-EXPORT_SYMBOL(netdev_set_operstate);
+EXPORT_SYMBOL(netif_set_operstate);
 
 static void set_operstate(struct net_device *dev, unsigned char transition)
 {
@@ -1080,7 +1080,7 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	netdev_set_operstate(dev, operstate);
+	netif_set_operstate(dev, operstate);
 }
 
 static unsigned int rtnl_dev_get_flags(const struct net_device *dev)
@@ -3396,7 +3396,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 errout:
 	if (status & DO_SETLINK_MODIFIED) {
 		if ((status & DO_SETLINK_NOTIFY) == DO_SETLINK_NOTIFY)
-			netdev_state_change(dev);
+			netif_state_change(dev);
 
 		if (err < 0)
 			net_warn_ratelimited("A link change request failed with some changes committed already. Interface %s may have been left with an inconsistent configuration, please check.\n",
@@ -3676,8 +3676,11 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 				nla_len(tb[IFLA_BROADCAST]));
 	if (tb[IFLA_TXQLEN])
 		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
-	if (tb[IFLA_OPERSTATE])
+	if (tb[IFLA_OPERSTATE]) {
+		netdev_lock_ops(dev);
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
+		netdev_unlock_ops(dev);
+	}
 	if (tb[IFLA_LINKMODE])
 		dev->link_mode = nla_get_u8(tb[IFLA_LINKMODE]);
 	if (tb[IFLA_GROUP])
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 221639407c72..8262cc10f98d 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -60,7 +60,7 @@ static struct devlink *netdev_to_devlink_get(struct net_device *dev)
 u32 ethtool_op_get_link(struct net_device *dev)
 {
 	/* Synchronize carrier state with link watch, see also rtnl_getlink() */
-	linkwatch_sync_dev(dev);
+	__linkwatch_sync_dev(dev);
 
 	return netif_carrier_ok(dev) ? 1 : 0;
 }
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 439cfb7ad5d1..1b1b700ec05e 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -33,14 +33,14 @@ static void hsr_set_operstate(struct hsr_port *master, bool has_carrier)
 	struct net_device *dev = master->dev;
 
 	if (!is_admin_up(dev)) {
-		netdev_set_operstate(dev, IF_OPER_DOWN);
+		netif_set_operstate(dev, IF_OPER_DOWN);
 		return;
 	}
 
 	if (has_carrier)
-		netdev_set_operstate(dev, IF_OPER_UP);
+		netif_set_operstate(dev, IF_OPER_UP);
 	else
-		netdev_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
+		netif_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
 }
 
 static bool hsr_check_carrier(struct hsr_port *master)
-- 
2.49.0


