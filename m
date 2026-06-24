Return-Path: <netdev+bounces-301752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id amrVDBYgPGrrkAgAu9opvQ
	(envelope-from <netdev+bounces-301752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D76C0B5D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M9f2a+Rx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301752-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24F623010F0E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386F32B108;
	Wed, 24 Jun 2026 18:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF932570D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325227; cv=none; b=a490USX0jBo/Vumz65sg06fJKSgDwanKG3sX0aFKIeTWU0SNvI2oiTt+mCKlCcQ8u5e+rjSbhpV4P629iV6RNvrS/7lcjXOkOt8sqo1iyhJoFefF8IeWSmpZzKgDMJux0ZHHvxHMUCKduITflICuSEOgguwEbBI2Y+TF+oJEL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325227; c=relaxed/simple;
	bh=tZQisQRC97j2UoTZNnDJtTj3zQlcytZNDwXXyqFp2Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ7ZpciAaUVJmBHhh7XQICI0gsKDZ3zZPm12rfZ6b0R0/FoWzbnCuD30WlQ5tVO9lwZL7CtICZHJMDpbY22NHMx1ZSo0rebNlMN6TVdU39RcSF2R6HyH1tv2THpV4arRZomcWzMvv1vy02fXmB38hwQo4hr6jYn/WUm+w6jrqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9f2a+Rx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9031F00A3A;
	Wed, 24 Jun 2026 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325226;
	bh=PYAN5CMj8avxykqfd4JHO3fl91sE8q0BfKnYem5LUpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9f2a+RxuKj9NLdS+NGxtvGYEMdvO5tiMSxMenoRPTnNutAGZqNjfPB5vkUjAaikA
	 /1HnudmapiK/9nmvtO4QgnmfnT5D0KebA6jmK1BBYRFm4M0ol+oiw3fpAg6u1uHle1
	 e8PFung3sODVhdjnVASakBwwJUQifDYh7sV6wfffGEY1oaAbGzUfKoJJx6tMWt4ZEI
	 ltBjJ/XwUSJf/oyoHY+YQ7vsCip/f8tPGObrMeNFaEJzjWJ7uzX4pzs1Rf3lcF3t0S
	 rW4zI2pOQZeWu3O6aFH1gz13c4wPtJ4aFvVCDHl10reNtaxlYQIsCD1M0nzh5vV6B6
	 GwigvI++YGeLA==
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
Subject: [PATCH net 2/4] net: add the driver-facing netdev_work scheduling API
Date: Wed, 24 Jun 2026 11:20:16 -0700
Message-ID: <20260624182018.2445732-3-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301752-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 332D76C0B5D

With an extra event mask we can easily extend the netdev work
to also service driver-defined events. For advanced drivers
this is probably not a perfect match, but it makes running
deferred work easier in simple cases.

Expose the netdev_work facility to drivers. Add helpers
to schedule work and a dedicated ndo to perform the driver-
-scheduled actions.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 11 ++++++
 net/core/netdev_work.c    | 81 ++++++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 732506787db3..9981d637f8b5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1131,6 +1131,9 @@ struct netdev_net_notifier {
  *	netdev_hw_addr_list_for_each(ha, uc). Return 0 on success or a
  *	negative errno to request a retry via the core backoff.
  *
+ * void (*ndo_work)(struct net_device *dev, unsigned long events);
+ *	Run deferred work scheduled with netdev_work_sched(@events).
+ *
  * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
  *	This function  is called when the Media Access Control address
  *	needs to be changed. If this interface is not defined, the
@@ -1460,6 +1463,8 @@ struct net_device_ops {
 					struct net_device *dev,
 					struct netdev_hw_addr_list *uc,
 					struct netdev_hw_addr_list *mc);
+	void			(*ndo_work)(struct net_device *dev,
+					    unsigned long events);
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
@@ -1932,6 +1937,8 @@ enum netdev_reg_state {
  *				does not implement ndo_set_rx_mode()
  *	@work_node:		List entry for async netdev_work processing
  *	@work_tracker:		Refcount tracker for async netdev_work
+ *	@work_pending:		Driver-defined pending netdev_work, passed to
+ *				ndo_work() (see netdev_work_sched())
  *	@work_core_pending:	Core-defined pending netdev_work (NETDEV_WORK_*)
  *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
  *	@rx_mode_retry_timer:	Timer that re-queues rx_mode work after failure
@@ -2329,6 +2336,7 @@ struct net_device {
 	bool			uc_promisc;
 	struct list_head	work_node;
 	netdevice_tracker	work_tracker;
+	unsigned long		work_pending;
 	unsigned long		work_core_pending;
 	struct netdev_hw_addr_list	rx_mode_addr_cache;
 	struct timer_list	rx_mode_retry_timer;
@@ -5178,6 +5186,9 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 			   const struct pcpu_sw_netstats __percpu *netstats);
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 
+void netdev_work_sched(struct net_device *dev, unsigned long events);
+unsigned long netdev_work_cancel(struct net_device *dev, unsigned long mask);
+
 enum {
 	NESTED_SYNC_IMM_BIT,
 	NESTED_SYNC_TODO_BIT,
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index c121c24dc493..3109fae132ad 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/export.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
@@ -16,32 +17,63 @@ static void netdev_work_proc(struct work_struct *work);
  *  - within the list entries (struct net_device fields):
  *	- work_node
  *	- work_tracker
+ *	- work_pending
  *	- work_core_pending
  */
 static LIST_HEAD(netdev_work_list);
 static DEFINE_SPINLOCK(netdev_work_lock);
 static DECLARE_WORK(netdev_work, netdev_work_proc);
 
-void __netdev_work_core_sched(struct net_device *dev, unsigned long event)
+static void netdev_work_enqueue(struct net_device *dev, unsigned long events,
+				unsigned long core)
 {
+	if (!events && !core)
+		return;
+
 	spin_lock_bh(&netdev_work_lock);
 	if (list_empty(&dev->work_node)) {
 		list_add_tail(&dev->work_node, &netdev_work_list);
 		netdev_hold(dev, &dev->work_tracker, GFP_ATOMIC);
 	}
-	dev->work_core_pending |= event;
+	dev->work_pending |= events;
+	dev->work_core_pending |= core;
 	spin_unlock_bh(&netdev_work_lock);
 
 	schedule_work(&netdev_work);
 }
 
+static unsigned long
+netdev_work_dequeue(struct net_device *dev, unsigned long *pending,
+		    unsigned long mask)
+{
+	unsigned long events;
+
+	spin_lock_bh(&netdev_work_lock);
+	events = *pending & mask;
+	*pending &= ~events;
+	if (!list_empty(&dev->work_node) &&
+	    !dev->work_pending && !dev->work_core_pending) {
+		list_del_init(&dev->work_node);
+		netdev_put(dev, &dev->work_tracker);
+	}
+	spin_unlock_bh(&netdev_work_lock);
+
+	return events;
+}
+
+void netdev_work_sched(struct net_device *dev, unsigned long events)
+{
+	netdev_work_enqueue(dev, events, 0);
+}
+EXPORT_SYMBOL(netdev_work_sched);
+
 /**
- * __netdev_work_core_cancel() - cancel selected core work for a netdev
+ * netdev_work_cancel() - cancel selected work for a netdev
  * @dev: net_device
  * @mask: events to cancel
  *
  * Clear @mask from the device's work pending mask. If no work is left pending
- * the device is dequeued.
+ * the device is dequeued and its ndo_work won't be called.
  *
  * No expectations on locking, but also no guarantees provided. If the caller
  * wants to touch @dev afterwards (e.g. call the work that got canceled)
@@ -50,21 +82,33 @@ void __netdev_work_core_sched(struct net_device *dev, unsigned long event)
  * Returns: the subset of @mask that was actually pending, so the caller can run
  * those events inline.
  */
+unsigned long netdev_work_cancel(struct net_device *dev, unsigned long mask)
+{
+	return netdev_work_dequeue(dev, &dev->work_pending, mask);
+}
+EXPORT_SYMBOL(netdev_work_cancel);
+
+void __netdev_work_core_sched(struct net_device *dev, unsigned long events)
+{
+	netdev_work_enqueue(dev, 0, events);
+}
+
 unsigned long
 __netdev_work_core_cancel(struct net_device *dev, unsigned long mask)
 {
-	unsigned long event;
+	return netdev_work_dequeue(dev, &dev->work_core_pending, mask);
+}
 
-	spin_lock_bh(&netdev_work_lock);
-	event = dev->work_core_pending & mask;
-	dev->work_core_pending &= ~mask;
-	if (!list_empty(&dev->work_node) && !dev->work_core_pending) {
-		list_del_init(&dev->work_node);
-		netdev_put(dev, &dev->work_tracker);
-	}
-	spin_unlock_bh(&netdev_work_lock);
+static void netdev_work_run(struct net_device *dev, unsigned long events,
+			    unsigned long core)
+{
+	if (!netif_device_present(dev))
+		return;
 
-	return event;
+	if (core & NETDEV_WORK_RX_MODE)
+		netif_rx_mode_run(dev);
+	if (events && dev->netdev_ops->ndo_work)
+		dev->netdev_ops->ndo_work(dev, events);
 }
 
 static void netdev_work_proc(struct work_struct *work)
@@ -72,9 +116,9 @@ static void netdev_work_proc(struct work_struct *work)
 	rtnl_lock();
 
 	while (true) {
+		unsigned long events = 0, core = 0;
 		netdevice_tracker tracker;
 		struct net_device *dev;
-		unsigned long core = 0;
 
 		spin_lock_bh(&netdev_work_lock);
 		if (list_empty(&netdev_work_list)) {
@@ -98,16 +142,17 @@ static void netdev_work_proc(struct work_struct *work)
 			list_del_init(&dev->work_node);
 			core = dev->work_core_pending;
 			dev->work_core_pending = 0;
+			events = dev->work_pending;
+			dev->work_pending = 0;
 			/* We took another ref above */
 			netdev_put(dev, &dev->work_tracker);
 
 			if (!dev_isalive(dev))
-				core = 0;
+				core = events = 0;
 		}
 		spin_unlock_bh(&netdev_work_lock);
 
-		if (core & NETDEV_WORK_RX_MODE)
-			netif_rx_mode_run(dev);
+		netdev_work_run(dev, events, core);
 		netdev_unlock_ops(dev);
 
 		netdev_put(dev, &tracker);
-- 
2.54.0


