Return-Path: <netdev+bounces-21579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036D763F15
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DE281EAB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C77E1;
	Wed, 26 Jul 2023 18:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D117EE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B209BC433CD;
	Wed, 26 Jul 2023 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690397735;
	bh=v+fiQdjrnzHEjYPibsVGQhG3kOy5yW/FZ0fpHOPLELQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwfH+z/f5jgRH/Xe7DiBs22DZEQOLl0L0uOiECmhvBkkrZdwI6X53aW16MKtolBaI
	 vAUargrv+RXcn6g2LlH+D6uXyXzny8seocqtxDcZgWbArPHzwzsU8uh/p6WokcITgD
	 aB2U/Dpm+QcCI+adWG5obEyBiwpJjuz5SA8eY4Ulw9nfh+XUAjsEcRuITY/Pqlisxo
	 nTrL+Yg4wNnWkcjamAOQrVSDlxL4HlMAhnKQqSasj5RcM55zIHqT1iCFjv5u+LGx3t
	 9Q3ccBBffm14CgIH9Jkruqmys2l6sjP90JMFnoaUh9t8Sry2bb+vt/qzYfDQfWtjWI
	 2XDQc9vbvdfKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	leon@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Date: Wed, 26 Jul 2023 11:55:29 -0700
Message-ID: <20230726185530.2247698-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726185530.2247698-1-kuba@kernel.org>
References: <20230726185530.2247698-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterating over the netdev hash table for netlink dumps is hard.
Dumps are done in "chunks" so we need to save the position
after each chunk, so we know where to restart from. Because
netdevs are stored in a hash table we remember which bucket
we were in and how many devices we dumped.

Since we don't hold any locks across the "chunks" - devices may
come and go while we're dumping. If that happens we may miss
a device (if device is deleted from the bucket we were in).
We indicate to user space that this may have happened by setting
NLM_F_DUMP_INTR. User space is supposed to dump again (I think)
if it sees that. Somehow I doubt most user space gets this right..

To illustrate let's look at an example:

               System state:
  start:       # [A, B, C]
  del:  B      # [A, C]

with the hash table we may dump [A, B], missing C completely even
tho it existed both before and after the "del B".

Add an xarray and use it to allocate ifindexes. This way we
can iterate ifindexes in order, without the worry that we'll
skip one. We may still generate a dump of a state which "never
existed", for example for a set of values and sequence of ops:

               System state:
  start:       # [A, B]
  add:  C      # [A, C, B]
  del:  B      # [A, C]

we may generate a dump of [A], if C got an index between A and B.
System has never been in such state. But I'm 90% sure that's perfectly
fine, important part is that we can't _miss_ devices which exist before
and after. User space which wants to mirror kernel's state subscribes
to notifications and does periodic dumps so it will know that C exists
from the notification about its creation or from the next dump
(next dump is _guaranteed_ to include C, if it doesn't get removed).

To avoid any perf regressions keep the hash table for now. Most
net namespaces have very few devices and microbenchmarking 1M lookups
on Skylake I get the following results (not counting loopback
to number of devs):

 #devs | hash |  xa  | delta
    2  | 18.3 | 20.1 | + 9.8%
   16  | 18.3 | 20.1 | + 9.5%
   64  | 18.3 | 26.3 | +43.8%
  128  | 20.4 | 26.3 | +28.6%
  256  | 20.0 | 26.4 | +32.1%
 1024  | 26.6 | 26.7 | + 0.2%
 8192  |541.3 | 33.5 | -93.8%

No surprises since the hash table has 256 entries.
The microbenchmark scans indexes in order, if the pattern is more
random xa starts to win at 512 devices already. But that's a lot
of devices, in practice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix error checking on xa_alloc_cyclic() (Leon)
---
 include/net/net_namespace.h |  4 +-
 net/core/dev.c              | 82 ++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 78beaa765c73..9f6add96de2d 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -42,6 +42,7 @@
 #include <linux/idr.h>
 #include <linux/skbuff.h>
 #include <linux/notifier.h>
+#include <linux/xarray.h>
 
 struct user_namespace;
 struct proc_dir_entry;
@@ -69,7 +70,7 @@ struct net {
 	atomic_t		dev_unreg_count;
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
-	int			ifindex;
+	u32			ifindex;
 
 	spinlock_t		nsid_lock;
 	atomic_t		fnhe_genid;
@@ -110,6 +111,7 @@ struct net {
 
 	struct hlist_head 	*dev_name_head;
 	struct hlist_head	*dev_index_head;
+	struct xarray		dev_by_index;
 	struct raw_notifier_head	netdev_chain;
 
 	/* Note that @hash_mix can be read millions times per second,
diff --git a/net/core/dev.c b/net/core/dev.c
index e7ffcfa037f7..b58674774a57 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -388,6 +388,8 @@ static void list_netdevice(struct net_device *dev)
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
 	write_unlock(&dev_base_lock);
+	/* We reserved the ifindex, this can't fail */
+	WARN_ON(xa_store(&net->dev_by_index, dev->ifindex, dev, GFP_KERNEL));
 
 	dev_base_seq_inc(net);
 }
@@ -397,8 +399,12 @@ static void list_netdevice(struct net_device *dev)
  */
 static void unlist_netdevice(struct net_device *dev, bool lock)
 {
+	struct net *net = dev_net(dev);
+
 	ASSERT_RTNL();
 
+	xa_erase(&net->dev_by_index, dev->ifindex);
+
 	/* Unlink dev from the device chain */
 	if (lock)
 		write_lock(&dev_base_lock);
@@ -9565,23 +9571,35 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
 }
 
 /**
- *	dev_new_index	-	allocate an ifindex
- *	@net: the applicable net namespace
+ * dev_index_reserve() - allocate an ifindex in a namespace
+ * @net: the applicable net namespace
+ * @ifindex: requested ifindex, pass %0 to get one allocated
  *
- *	Returns a suitable unique value for a new device interface
- *	number.  The caller must hold the rtnl semaphore or the
- *	dev_base_lock to be sure it remains unique.
+ * Allocate a ifindex for a new device. Caller must either use the ifindex
+ * to store the device (via list_netdevice()) or call dev_index_release()
+ * to give the index up.
+ *
+ * Return: a suitable unique value for a new device interface number or -errno.
  */
-static int dev_new_index(struct net *net)
+static int dev_index_reserve(struct net *net, u32 ifindex)
 {
-	int ifindex = net->ifindex;
+	int err;
 
-	for (;;) {
-		if (++ifindex <= 0)
-			ifindex = 1;
-		if (!__dev_get_by_index(net, ifindex))
-			return net->ifindex = ifindex;
-	}
+	if (!ifindex)
+		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
+				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
+	else
+		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
+	if (err < 0)
+		return err;
+
+	return ifindex;
+}
+
+static void dev_index_release(struct net *net, int ifindex)
+{
+	/* Expect only unused indexes, unlist_netdevice() removes the used */
+	WARN_ON(xa_erase(&net->dev_by_index, ifindex));
 }
 
 /* Delayed registration/unregisteration */
@@ -10051,11 +10069,10 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
-	ret = -EBUSY;
-	if (!dev->ifindex)
-		dev->ifindex = dev_new_index(net);
-	else if (__dev_get_by_index(net, dev->ifindex))
+	ret = dev_index_reserve(net, dev->ifindex);
+	if (ret < 0)
 		goto err_uninit;
+	dev->ifindex = ret;
 
 	/* Transfer changeable features to wanted_features and enable
 	 * software offloads (GSO and GRO).
@@ -10102,7 +10119,7 @@ int register_netdevice(struct net_device *dev)
 	ret = call_netdevice_notifiers(NETDEV_POST_INIT, dev);
 	ret = notifier_to_errno(ret);
 	if (ret)
-		goto err_uninit;
+		goto err_ifindex_release;
 
 	ret = netdev_register_kobject(dev);
 	write_lock(&dev_base_lock);
@@ -10158,6 +10175,8 @@ int register_netdevice(struct net_device *dev)
 
 err_uninit_notify:
 	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
+err_ifindex_release:
+	dev_index_release(net, dev->ifindex);
 err_uninit:
 	if (dev->netdev_ops->ndo_uninit)
 		dev->netdev_ops->ndo_uninit(dev);
@@ -11035,9 +11054,19 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	}
 
 	/* Check that new_ifindex isn't used yet. */
-	err = -EBUSY;
-	if (new_ifindex && __dev_get_by_index(net, new_ifindex))
-		goto out;
+	if (new_ifindex) {
+		err = dev_index_reserve(net, new_ifindex);
+		if (err < 0)
+			goto out;
+	} else {
+		/* If there is an ifindex conflict assign a new one */
+		err = dev_index_reserve(net, dev->ifindex);
+		if (err == -EBUSY)
+			err = dev_index_reserve(net, 0);
+		if (err < 0)
+			goto out;
+		new_ifindex = err;
+	}
 
 	/*
 	 * And now a mini version of register_netdevice unregister_netdevice.
@@ -11065,13 +11094,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	rcu_barrier();
 
 	new_nsid = peernet2id_alloc(dev_net(dev), net, GFP_KERNEL);
-	/* If there is an ifindex conflict assign a new one */
-	if (!new_ifindex) {
-		if (__dev_get_by_index(net, dev->ifindex))
-			new_ifindex = dev_new_index(net);
-		else
-			new_ifindex = dev->ifindex;
-	}
 
 	rtmsg_ifinfo_newnet(RTM_DELLINK, dev, ~0U, GFP_KERNEL, &new_nsid,
 			    new_ifindex);
@@ -11249,6 +11271,9 @@ static int __net_init netdev_init(struct net *net)
 	if (net->dev_index_head == NULL)
 		goto err_idx;
 
+	net->ifindex = 1;
+	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC);
+
 	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
 
 	return 0;
@@ -11346,6 +11371,7 @@ static void __net_exit netdev_exit(struct net *net)
 {
 	kfree(net->dev_name_head);
 	kfree(net->dev_index_head);
+	xa_destroy(&net->dev_by_index);
 	if (net != &init_net)
 		WARN_ON_ONCE(!list_empty(&net->dev_base_head));
 }
-- 
2.41.0


