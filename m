Return-Path: <netdev+bounces-301751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kphcI/IfPGrkkAgAu9opvQ
	(envelope-from <netdev+bounces-301751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157AA6C0B45
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NbT3TNdn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301751-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFCCA302AF59
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C83290C2;
	Wed, 24 Jun 2026 18:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43031F98E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325226; cv=none; b=e8+rdw+IUbKoKtos2YfRum0oHbLjT+XH8RAm47g7r7eDnyO3ql32iJ63E+Em8v1x4iLniiMLSg2JqbTFMvpCkZdbnhd/nwdVOWqmPDASLq2peXiSU1m6f+heMdE1Y58nINeFLd/VJ3Oo+0PjgW+fQvLHxWWZNgkb0aE7LG4lrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325226; c=relaxed/simple;
	bh=ltMQRuanWryKXji8Es2aKWDKVtzLrUmKg3r4WJZ3NyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBoV3cY1l/rB6t17oOaghqlxWw2DH7Xz5zilEGpyusAprsHHTGOCUDE4cfklrXySTPLH0CdWh8Z7BPjf+FlGwKKop+oi1wzCuhgeyN8uyx2AX7wriAceMZgLkK09jtqt/04uOckZZw9CGiCD/ml4AWGhU8yQR4+YyKjyq30OuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbT3TNdn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D41F00A3D;
	Wed, 24 Jun 2026 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325225;
	bh=cIH1vfKRDpa3+NcIKKWC+5YdLZqJXXspl8eEuzyLtEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbT3TNdnRkHRHjPm1Ya/2gzE5YtJvUlMwFw6ciqxcssBPlizVad7rxqxZ1NtcKXRs
	 ZXdFqnwVAmoUE3tvXvt6o0t4OR4X7EFkbhR3j9/igxGtECwqxMEtFml1W0it/mRlTj
	 n7voMRwJ8I3GBIr5WhzFOwpzWqNIW48ISZL6alHw5aWya92TXtZfU6dwCtb5asu9rf
	 5kTFU8qbY5YTuHkW66WO08vVrwkDPTSXSKfx4YW/lhd/bWWneZZoZ84FJicyxtpnc5
	 BP77sugqUV9XSaGwu2LiKNrak+6PGDUXQVovi1dWAMNLgna4dkomIaeobIcYwAHIxv
	 IDcL8ibOP3VSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	sdf@fomichev.me,
	dongchenchen2@huawei.com,
	idosch@nvidia.com,
	n05ec@lzu.edu.cn,
	yuantan098@gmail.com,
	kuniyu@google.com,
	nb@tipi-net.de,
	aleksandr.loktionov@intel.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/4] net: turn the rx_mode work into a generic netdev_work facility
Date: Wed, 24 Jun 2026 11:20:15 -0700
Message-ID: <20260624182018.2445732-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624182018.2445732-1-kuba@kernel.org>
References: <20260624182018.2445732-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 157AA6C0B45

The rx_mode update runs from a workqueue: drivers have their
ndo_set_rx_mode_async() callback executed by a single global
work item under RTNL and ops lock. This is a useful pattern.

Support multiple "events" that need to be serviced and make RX_MODE
sync the first one. Call the events "core" because later on
we will let drivers define and schedule their own.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/Makefile         |   2 +-
 include/linux/netdevice.h |  10 ++--
 net/core/dev.h            |  11 +++-
 net/core/dev.c            |   1 +
 net/core/dev_addr_lists.c |  77 +------------------------
 net/core/netdev_work.c    | 117 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 138 insertions(+), 80 deletions(-)
 create mode 100644 net/core/netdev_work.c

diff --git a/net/core/Makefile b/net/core/Makefile
index dc17c5a61e9a..b3fdcb4e355f 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_api.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o gso.o
+			netdev-genl.o netdev-genl-gen.o netdev_work.o gso.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b67a12541eac..732506787db3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1930,8 +1930,9 @@ enum netdev_reg_state {
  *				has been enabled due to the need to listen to
  *				additional unicast addresses in a device that
  *				does not implement ndo_set_rx_mode()
- *	@rx_mode_node:		List entry for rx_mode work processing
- *	@rx_mode_tracker:	Refcount tracker for rx_mode work
+ *	@work_node:		List entry for async netdev_work processing
+ *	@work_tracker:		Refcount tracker for async netdev_work
+ *	@work_core_pending:	Core-defined pending netdev_work (NETDEV_WORK_*)
  *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
  *	@rx_mode_retry_timer:	Timer that re-queues rx_mode work after failure
  *	@rx_mode_retry_count:	Number of consecutive retries already scheduled
@@ -2326,8 +2327,9 @@ struct net_device {
 	unsigned int		promiscuity;
 	unsigned int		allmulti;
 	bool			uc_promisc;
-	struct list_head	rx_mode_node;
-	netdevice_tracker	rx_mode_tracker;
+	struct list_head	work_node;
+	netdevice_tracker	work_tracker;
+	unsigned long		work_core_pending;
 	struct netdev_hw_addr_list	rx_mode_addr_cache;
 	struct timer_list	rx_mode_retry_timer;
 	unsigned int		rx_mode_retry_count;
diff --git a/net/core/dev.h b/net/core/dev.h
index 4121c50e7c88..5d0b0305d3ba 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -167,10 +167,19 @@ int dev_change_carrier(struct net_device *dev, bool new_carrier);
 void __dev_set_rx_mode(struct net_device *dev);
 int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify);
 void netif_rx_mode_init(struct net_device *dev);
-bool netif_rx_mode_clean(struct net_device *dev);
+void netif_rx_mode_run(struct net_device *dev);
 void netif_rx_mode_sync(struct net_device *dev);
 void netif_rx_mode_cancel_retry(struct net_device *dev);
 
+/* Events for the async netdev work, tracked in netdev->work_core_pending. */
+enum netdev_work_core {
+	NETDEV_WORK_RX_MODE	= BIT(0),	/* run the rx_mode update */
+};
+
+void __netdev_work_core_sched(struct net_device *dev, unsigned long event);
+unsigned long
+__netdev_work_core_cancel(struct net_device *dev, unsigned long mask);
+
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
 			const struct nlmsghdr *nlh);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5c01dfaa6c44..e1d8af0ef6ab 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12093,6 +12093,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	INIT_LIST_HEAD(&dev->ptype_all);
 	INIT_LIST_HEAD(&dev->ptype_specific);
 	INIT_LIST_HEAD(&dev->net_notifier_list);
+	INIT_LIST_HEAD(&dev->work_node);
 #ifdef CONFIG_NET_SCHED
 	hash_init(dev->qdisc_hash);
 #endif
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index e17f64a65e17..08528ca0a8b3 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -12,17 +12,10 @@
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <kunit/visibility.h>
 
 #include "dev.h"
 
-static void netdev_rx_mode_work(struct work_struct *work);
-
-static LIST_HEAD(rx_mode_list);
-static DEFINE_SPINLOCK(rx_mode_lock);
-static DECLARE_WORK(rx_mode_work, netdev_rx_mode_work);
-
 /*
  * General list handling functions
  */
@@ -1281,7 +1274,7 @@ void netif_rx_mode_cancel_retry(struct net_device *dev)
 	dev->rx_mode_retry_count = 0;
 }
 
-static void netif_rx_mode_run(struct net_device *dev)
+void netif_rx_mode_run(struct net_device *dev)
 {
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -1339,49 +1332,9 @@ static void netif_rx_mode_run(struct net_device *dev)
 	}
 }
 
-static void netdev_rx_mode_work(struct work_struct *work)
-{
-	struct net_device *dev;
-
-	rtnl_lock();
-
-	while (true) {
-		spin_lock_bh(&rx_mode_lock);
-		if (list_empty(&rx_mode_list)) {
-			spin_unlock_bh(&rx_mode_lock);
-			break;
-		}
-		dev = list_first_entry(&rx_mode_list, struct net_device,
-				       rx_mode_node);
-		list_del_init(&dev->rx_mode_node);
-		/* We must free netdev tracker under
-		 * the spinlock protection.
-		 */
-		netdev_tracker_free(dev, &dev->rx_mode_tracker);
-		spin_unlock_bh(&rx_mode_lock);
-
-		netdev_lock_ops(dev);
-		netif_rx_mode_run(dev);
-		netdev_unlock_ops(dev);
-		/* Use __dev_put() because netdev_tracker_free() was already
-		 * called above. Must be after netdev_unlock_ops() to prevent
-		 * netdev_run_todo() from freeing the device while still in use.
-		 */
-		__dev_put(dev);
-	}
-
-	rtnl_unlock();
-}
-
 static void netif_rx_mode_queue(struct net_device *dev)
 {
-	spin_lock_bh(&rx_mode_lock);
-	if (list_empty(&dev->rx_mode_node)) {
-		list_add_tail(&dev->rx_mode_node, &rx_mode_list);
-		netdev_hold(dev, &dev->rx_mode_tracker, GFP_ATOMIC);
-	}
-	spin_unlock_bh(&rx_mode_lock);
-	schedule_work(&rx_mode_work);
+	__netdev_work_core_sched(dev, NETDEV_WORK_RX_MODE);
 }
 
 static void netif_rx_mode_retry(struct timer_list *t)
@@ -1394,7 +1347,6 @@ static void netif_rx_mode_retry(struct timer_list *t)
 
 void netif_rx_mode_init(struct net_device *dev)
 {
-	INIT_LIST_HEAD(&dev->rx_mode_node);
 	__hw_addr_init(&dev->rx_mode_addr_cache);
 	timer_setup(&dev->rx_mode_retry_timer, netif_rx_mode_retry, 0);
 }
@@ -1442,24 +1394,6 @@ void dev_set_rx_mode(struct net_device *dev)
 	netif_addr_unlock_bh(dev);
 }
 
-bool netif_rx_mode_clean(struct net_device *dev)
-{
-	bool clean = false;
-
-	spin_lock_bh(&rx_mode_lock);
-	if (!list_empty(&dev->rx_mode_node)) {
-		list_del_init(&dev->rx_mode_node);
-		clean = true;
-		/* We must release netdev tracker under
-		 * the spinlock protection.
-		 */
-		netdev_tracker_free(dev, &dev->rx_mode_tracker);
-	}
-	spin_unlock_bh(&rx_mode_lock);
-
-	return clean;
-}
-
 /**
  * netif_rx_mode_sync() - sync rx mode inline
  * @dev: network device
@@ -1473,11 +1407,6 @@ bool netif_rx_mode_clean(struct net_device *dev)
  */
 void netif_rx_mode_sync(struct net_device *dev)
 {
-	if (netif_rx_mode_clean(dev)) {
+	if (__netdev_work_core_cancel(dev, NETDEV_WORK_RX_MODE))
 		netif_rx_mode_run(dev);
-		/* Use __dev_put() because netdev_tracker_free() was already
-		 * called inside netif_rx_mode_clean().
-		 */
-		__dev_put(dev);
-	}
 }
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
new file mode 100644
index 000000000000..c121c24dc493
--- /dev/null
+++ b/net/core/netdev_work.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <net/netdev_lock.h>
+
+#include "dev.h"
+
+static void netdev_work_proc(struct work_struct *work);
+
+/* @netdev_work_lock protects:
+ *  - @netdev_work_list
+ *  - within the list entries (struct net_device fields):
+ *	- work_node
+ *	- work_tracker
+ *	- work_core_pending
+ */
+static LIST_HEAD(netdev_work_list);
+static DEFINE_SPINLOCK(netdev_work_lock);
+static DECLARE_WORK(netdev_work, netdev_work_proc);
+
+void __netdev_work_core_sched(struct net_device *dev, unsigned long event)
+{
+	spin_lock_bh(&netdev_work_lock);
+	if (list_empty(&dev->work_node)) {
+		list_add_tail(&dev->work_node, &netdev_work_list);
+		netdev_hold(dev, &dev->work_tracker, GFP_ATOMIC);
+	}
+	dev->work_core_pending |= event;
+	spin_unlock_bh(&netdev_work_lock);
+
+	schedule_work(&netdev_work);
+}
+
+/**
+ * __netdev_work_core_cancel() - cancel selected core work for a netdev
+ * @dev: net_device
+ * @mask: events to cancel
+ *
+ * Clear @mask from the device's work pending mask. If no work is left pending
+ * the device is dequeued.
+ *
+ * No expectations on locking, but also no guarantees provided. If the caller
+ * wants to touch @dev afterwards (e.g. call the work that got canceled)
+ * they have to ensure @dev does not get freed.
+ *
+ * Returns: the subset of @mask that was actually pending, so the caller can run
+ * those events inline.
+ */
+unsigned long
+__netdev_work_core_cancel(struct net_device *dev, unsigned long mask)
+{
+	unsigned long event;
+
+	spin_lock_bh(&netdev_work_lock);
+	event = dev->work_core_pending & mask;
+	dev->work_core_pending &= ~mask;
+	if (!list_empty(&dev->work_node) && !dev->work_core_pending) {
+		list_del_init(&dev->work_node);
+		netdev_put(dev, &dev->work_tracker);
+	}
+	spin_unlock_bh(&netdev_work_lock);
+
+	return event;
+}
+
+static void netdev_work_proc(struct work_struct *work)
+{
+	rtnl_lock();
+
+	while (true) {
+		netdevice_tracker tracker;
+		struct net_device *dev;
+		unsigned long core = 0;
+
+		spin_lock_bh(&netdev_work_lock);
+		if (list_empty(&netdev_work_list)) {
+			spin_unlock_bh(&netdev_work_lock);
+			break;
+		}
+		dev = list_first_entry(&netdev_work_list, struct net_device,
+				       work_node);
+		/* Take a temporary reference so @dev can't be freed while we
+		 * drop the lock to grab its ops lock; the work reference is
+		 * only released once we claim the work below.
+		 * The re-locking dance is to ensure that ops lock is enough
+		 * to ensure canceling work is not racy with dequeue.
+		 */
+		netdev_hold(dev, &tracker, GFP_ATOMIC);
+		spin_unlock_bh(&netdev_work_lock);
+
+		netdev_lock_ops(dev);
+		spin_lock_bh(&netdev_work_lock);
+		if (!list_empty(&dev->work_node)) {
+			list_del_init(&dev->work_node);
+			core = dev->work_core_pending;
+			dev->work_core_pending = 0;
+			/* We took another ref above */
+			netdev_put(dev, &dev->work_tracker);
+
+			if (!dev_isalive(dev))
+				core = 0;
+		}
+		spin_unlock_bh(&netdev_work_lock);
+
+		if (core & NETDEV_WORK_RX_MODE)
+			netif_rx_mode_run(dev);
+		netdev_unlock_ops(dev);
+
+		netdev_put(dev, &tracker);
+	}
+
+	rtnl_unlock();
+}
-- 
2.54.0


