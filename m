Return-Path: <netdev+bounces-304307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rjabMR3+RmpCgQsAu9opvQ
	(envelope-from <netdev+bounces-304307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C36FD8E8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IvO0dFeM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304307-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33937301A07A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907E19D8AC;
	Fri,  3 Jul 2026 00:10:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BA18A6D4
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037418; cv=none; b=U3XgR7Ww1A3DCsDWbckQt12J1Gc59JbSDb+zUyznvSwWwkdSidOTUmYeOSqAY9GF5DYtCFh6YSSN2vuvJ/SkOt8AG1Yh4Sczx8EtkDnKV1sBSyBI/U5lx/56vNtV0BS4uUrqk5DR8J/0tIm9eR/Hfjo+EmAN2RXg6MzYLJCPQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037418; c=relaxed/simple;
	bh=welNH07BO1ExBA1327OckuMcvDvSEV//5DNdLFMtiMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZTYMVgHdYkE/3hJnws88B8fR/dSEMsbdkfMJLn7awMP462oXEB4HeT6kvTc+9sBeXoAesqgdrtql9dLXaad0vG8t2t6d7YbFFh695E011vOqHFtoMCHDCjkDV6v23j9qQQTUjaJP2l99cgNymQvExwUjxJParuDj2jeLOCBuX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvO0dFeM; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so3154742a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037416; x=1783642216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUFCLX5a9IgRPHV3iNFlUGTGQ267Y1Ou4T/rnAG9dc0=;
        b=IvO0dFeMTgLRby/Cy1qhEftY8vcWZ6WbLP/DFXm9ZeqyL4JqZZ6lqa5521JsIjk52o
         VDq4fQB6i6iReDZ0GuowXCHrN3sjEarygxp7fLH4Eqc2zYmkdKbsXBIjvbdRKvakMzVX
         reQtO1QpSlsHmlwLdByzTazZwNtRRtdPBOoeNFRbw/dyb6lNUVIPw9k0+P3TmrvrISyO
         gZLJlxA7wbhLghRgfaCRAxy9JYkpcEK0euKNGA9wVc6XVJQ201upjCeokRQsDbBLvP+p
         xKBS+xCMfjgutyoKfmwd69HLFVW5UDbj4n6tXmvlcnWxHnRZ4fISl4h7fCYTL92M4q7C
         Dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037416; x=1783642216;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUFCLX5a9IgRPHV3iNFlUGTGQ267Y1Ou4T/rnAG9dc0=;
        b=aVRC4bGRLdDXqTuSR/W8Am67X00MS75JfQNiw4Tcy7i53yH8suRyn3GKAvWJhPV2lh
         ngBP5VLk3UCmwkBFnJLAvsFChUQVBme0W+eJ4diQOTF+QXD4zbGBPZzbaZPSHwiW59NB
         BA7K23fStd3ykVTRhlmj3L067x8aK2jH7DnKzQvgxoYY8+GUHCYxufTd0JAATXyoTgPM
         R9onK0LqivJzvORZtdeNLTDoB6ARzTgl/j4rGoC0PhTpRcXlQgCnUEeBrMClk65cFNAg
         pvmVjGza9t8QfXhV/x2fZ0Bu7LEnQFKfU4/60VZA+thbl6es1/QopmNiSHpGGSb1sZAg
         vXkg==
X-Forwarded-Encrypted: i=1; AFNElJ90tDVKevdlwnWFWEr1ChHj3BZmdtpHdSQrqcUTMIDM6Cz+7VdsoxIp/BFDCjrXLPaaBRkMeU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1e8voFDbdJLZP93RGGgrJNzQTKK9Pg4v9BMjaROSzorc/XOiO
	38Rry6rJDwa+hfgQUh/3isahSUMKvWvoCY+C53d4GJYrCiTzftrE2Fz9X+i3HXiUyqeorrnbSXC
	Ujuj9mg==
X-Received: from pgbeu10.prod.google.com ([2002:a05:6a02:478a:b0:c85:a528:228f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2211:b0:3b4:65ac:e2e3
 with SMTP id adf61e73a8af0-3bfed11e0d6mr9722575637.5.1783037416115; Thu, 02
 Jul 2026 17:10:16 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:17 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/14] net: Add per-netns netdev unregistration infra.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304307-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 003C36FD8E8

When we need to unregister a netdev in a different netns, we will
delegate its unregistration to per-netns work.

There are three types of such cross-netns devices:

  1. Paired devices (e.g., netkit, veth, vxcan)
     -> Unregistering one device also deletes its peer, which
        may reside in another netns.

  2. Tunnel devices (e.g., bareudp, geneve, etc)
     -> Destroying a netns removes devices in another netns if
        their backend sockets reside in the dying netns

  3. Stacked devices (e.g., ipvlan, macvlan, etc)
     -> Removing the lower device also removes multiple upper
        devices, each of which may reside in different namespaces.

In these cases, we will use unregister_netdevice_queue_net() to
queue such potential cross-netns devices for destruction.

Each driver must not call both unregister_netdevice_queue_net()
and unregister_netdevice_queue() for the same device.  See the
subsequent veth/bareudp/ipvlan patches for how they avoid double
queueing.

unregister_netdevice_queue_net() takes net and dev.  If dev resides
in the net, it simply calls unregister_netdevice_queue().

If dev_net(dev) is different from the net, it enqueues the device
to dev_net(dev)->dev_unreg_head and schedules the per-netns work.

When __rtnl_net_unlock() is called from the per-netns work (or another
thread already holding the lock), unregister_netdevice_many_net()
collects the queued devices and calls unregister_netdevice_many()
to perform the actual unregistration.

During netns dismantle, rtnl_net_flush_workqueue() is called at the
end of default_device_exit_batch() to ensure that cross-netns
devices in the other alive netns are unregistered.

Once RTNL is removed, a device could be moved to another netns while
being queued to net->dev_unreg_head.

__dev_change_net_namespace() handles this race by acquiring
net->dev_unreg_lock of both the old and new netns after dev_set_net()
and moving the device between their dev_unreg_head lists.

Since dev_set_net() and unregister_netdevice_queue_net() are
synchronised by netdev_lock(), the device is either queued to the
old netns's dev_unreg_head and then moved, or queued directly to
the new netns.

Note that unregister_netdevice_move_net() does not need to call
rtnl_net_queue_work() because __dev_change_net_namespace() is
(supposed to be) called with rtnl_net_lock().  (Not all callers
hold it yet, but the race does not happen until all callers
are converted and RTNL is removed.)

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Use spin_lock_nested() in unregister_netdevice_move_net()
  * Add kdoc for dev->unreg_list_net
  * Add DEBUG_NET_WARN_ON_ONCE() in unregister_netdevice_queue()
---
 include/linux/netdevice.h   | 18 ++++++++
 include/net/net_namespace.h |  2 +
 net/core/dev.c              | 91 +++++++++++++++++++++++++++++++++++++
 net/core/net_namespace.c    |  2 +
 net/core/rtnetlink.c        |  4 ++
 5 files changed, 117 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..108d8d7ea75b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1845,6 +1845,8 @@ enum netdev_reg_state {
  *	@napi_list:	List entry used for polling NAPI devices
  *	@unreg_list:	List entry  when we are unregistering the
  *			device; see the function unregister_netdev
+ *	@unreg_list_net:List entry when we are unregistering the cross-netns
+ *			device; see the function unregister_netdevice_queue_net()
  *	@close_list:	List entry used when we are closing the device
  *	@ptype_all:     Device-specific packet handlers for all protocols
  *	@ptype_specific: Device-specific, protocol-specific packet handlers
@@ -2241,6 +2243,9 @@ struct net_device {
 	struct list_head	dev_list;
 	struct list_head	napi_list;
 	struct list_head	unreg_list;
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	struct list_head	unreg_list_net;
+#endif
 	struct list_head	close_list;
 	struct list_head	ptype_all;
 
@@ -3472,6 +3477,19 @@ static inline void unregister_netdevice(struct net_device *dev)
 	unregister_netdevice_queue(dev, NULL);
 }
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
+				    struct list_head *head);
+void unregister_netdevice_many_net(struct net *net);
+#else
+static inline void unregister_netdevice_queue_net(struct net *net,
+						  struct net_device *dev,
+						  struct list_head *head)
+{
+	unregister_netdevice_queue(dev, head);
+}
+#endif
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a989019af5f7..501af1999fe8 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -198,6 +198,8 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 	struct work_struct	rtnl_work;
+	struct list_head	dev_unreg_head;
+	spinlock_t		dev_unreg_lock;
 #endif
 #if IS_ENABLED(CONFIG_VSOCKETS)
 	struct netns_vsock	vsock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 48818a194fa5..ed41c704c941 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12092,6 +12092,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	INIT_LIST_HEAD(&dev->napi_list);
 	INIT_LIST_HEAD(&dev->unreg_list);
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	INIT_LIST_HEAD(&dev->unreg_list_net);
+#endif
 	INIT_LIST_HEAD(&dev->close_list);
 	INIT_LIST_HEAD(&dev->link_watch_list);
 	INIT_LIST_HEAD(&dev->adj_list.upper);
@@ -12309,6 +12312,10 @@ void unregister_netdevice_queue(struct net_device *dev, struct list_head *head)
 {
 	ASSERT_RTNL();
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->unreg_list_net));
+#endif
+
 	if (head) {
 		list_move_tail(&dev->unreg_list, head);
 	} else {
@@ -12485,6 +12492,16 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+		struct net *net = dev_net(dev);
+
+		/* spin_lock() can be moved outside of the loop
+		 * once the per-netns RTNL conversion completes.
+		 */
+		spin_lock(&net->dev_unreg_lock);
+		list_del(&dev->unreg_list_net);
+		spin_unlock(&net->dev_unreg_lock);
+#endif
 		netdev_put(dev, &dev->dev_registered_tracker);
 		net_set_todo(dev);
 		cnt++;
@@ -12507,6 +12524,74 @@ void unregister_netdevice_many(struct list_head *head)
 }
 EXPORT_SYMBOL(unregister_netdevice_many);
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
+				    struct list_head *head)
+{
+	netdev_lock(dev);
+
+	if (net_eq(dev_net(dev), net)) {
+		netdev_unlock(dev);
+		unregister_netdevice_queue(dev, head);
+		return;
+	}
+
+	net = dev_net(dev);
+
+	spin_lock(&net->dev_unreg_lock);
+
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->unreg_list));
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->unreg_list_net));
+
+	list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	rtnl_net_queue_work(net);
+
+	spin_unlock(&net->dev_unreg_lock);
+
+	netdev_unlock(dev);
+}
+EXPORT_SYMBOL(unregister_netdevice_queue_net);
+
+static void unregister_netdevice_move_net(struct net *net_old,
+					  struct net *net,
+					  struct net_device *dev)
+{
+	if (net_old > net) {
+		spin_lock(&net->dev_unreg_lock);
+		spin_lock_nested(&net_old->dev_unreg_lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock(&net_old->dev_unreg_lock);
+		spin_lock_nested(&net->dev_unreg_lock, SINGLE_DEPTH_NESTING);
+	}
+
+	if (!list_empty(&dev->unreg_list_net)) {
+		list_del(&dev->unreg_list_net);
+		list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	}
+
+	spin_unlock(&net_old->dev_unreg_lock);
+	spin_unlock(&net->dev_unreg_lock);
+}
+
+void unregister_netdevice_many_net(struct net *net)
+{
+	struct net_device *dev, *tmp;
+	LIST_HEAD(unreg_head_net);
+	LIST_HEAD(unreg_head);
+
+	spin_lock(&net->dev_unreg_lock);
+	list_splice_init(&net->dev_unreg_head, &unreg_head_net);
+	spin_unlock(&net->dev_unreg_lock);
+
+	list_for_each_entry_safe(dev, tmp, &unreg_head_net, unreg_list_net) {
+		list_del_init(&dev->unreg_list_net);
+		list_add_tail(&dev->unreg_list, &unreg_head);
+	}
+
+	unregister_netdevice_many(&unreg_head);
+}
+#endif
+
 /**
  *	unregister_netdev - remove device from the kernel
  *	@dev: device
@@ -12663,6 +12748,10 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	netdev_unlock(dev);
 	dev->ifindex = new_ifindex;
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	unregister_netdevice_move_net(net_old, net, dev);
+#endif
+
 	if (new_name[0]) {
 		/* Rename the netdev to prepared name */
 		write_seqlock_bh(&netdev_rename_lock);
@@ -13105,6 +13194,8 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	}
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
+
+	rtnl_net_flush_workqueue();
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d1aeff9de580..578b48cf5318 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -423,6 +423,8 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	mutex_init(&net->rtnl_mutex);
 	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
 	INIT_WORK(&net->rtnl_work, rtnl_net_work_func);
+	INIT_LIST_HEAD(&net->dev_unreg_head);
+	spin_lock_init(&net->dev_unreg_lock);
 #endif
 
 	INIT_LIST_HEAD(&net->ptype_all);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7959519e7375..544498d3c325 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -197,6 +197,7 @@ void __rtnl_net_unlock(struct net *net)
 {
 	ASSERT_RTNL();
 
+	unregister_netdevice_many_net(net);
 	mutex_unlock(&net->rtnl_mutex);
 }
 EXPORT_SYMBOL(__rtnl_net_unlock);
@@ -290,6 +291,9 @@ void rtnl_net_work_func(struct work_struct *work)
 {
 	struct net *net = container_of(work, struct net, rtnl_work);
 
+	if (list_empty(&net->dev_unreg_head))
+		return;
+
 	rtnl_net_lock(net);
 	rtnl_net_unlock(net);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


