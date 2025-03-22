Return-Path: <netdev+bounces-176876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA8A6CAA6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1017BF7A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D393225A23;
	Sat, 22 Mar 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="vV35RyE2"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5F22F392;
	Sat, 22 Mar 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654342; cv=none; b=Gffg8om55GO3aPpifdFv4Ny0Hh8Q1bqdm6J9IuwAYowPhofnoGDJS/jYxKcUT0vOUCFmOKGKQsvHqDMRUAnmMklhy2/hKewhVxYsQD2kPq7A05cWuj8N/zmRb93CCNwHaYsgQPdx4g47eN5vROUWLE39sE+JDiEeorNot+4R1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654342; c=relaxed/simple;
	bh=nyppS/iyawbNnFTDJHJLHzuq6RlcspnOv8Zx4xz8BN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9mpm4zPY7EYikRY9DB4OtdFTbNfwNb35ctHu6B8Z2iECBMjENbytDL9UiRDLFJW3LVe/Xrz8GWf+0IDeXCXKNrzi9/WgkkUK/fY3JoPMgYej0JXreYQqG9SDkR1ZynYTsaZdBCc0XOoUwCtoXIA3fNXifB++JrNK7QRXvn0h8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=vV35RyE2; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:c54a:0:640:3e90:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id A3A72609F1;
	Sat, 22 Mar 2025 17:38:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id scNr9xULoSw0-0qDLKt66;
	Sat, 22 Mar 2025 17:38:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654337; bh=PdmUOeI2SLWW2h20m8+h+YwxguzxL4m3BRkoNYMw3XU=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=vV35RyE2L1TZ6z6XNTwhmb5+4O2nvcJlJ/88toAkstGcJl99i089Pm6nGY238vdc4
	 of8Q/o+wwABVQoRmj2b7RTS6O3rBUcgS9dyu9uetBm4drqn7AXEP5+kt9dzW+IKJYD
	 moY5dXA1dhLw8w9epeib48JaU52OgAXh3Bf8XyhI=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 08/51] net: Initially attaching and detaching nd_lock
Date: Sat, 22 Mar 2025 17:38:54 +0300
Message-ID: <174265433421.356712.3881511284479009706.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

To start convertation devices one by one, we need
defaults assigned to rest of devices.

Here we add default lock assignment and a branch
for already converted drivers in register_netdevice.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 include/linux/netdevice.h |    8 +++
 net/core/dev.c            |  127 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e36e64310bd4..2e9052e808a4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3122,14 +3122,22 @@ extern struct nd_lock fallback_nd_lock;
 
 void nd_lock_transfer_devices(struct nd_lock **p_lock, struct nd_lock **p_lock2);
 
+int __register_netdevice(struct net_device *dev);
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
+/* XXX: This will be converted to take nd_lock after drivers are ready */
 static inline void unregister_netdevice(struct net_device *dev)
 {
 	unregister_netdevice_queue(dev, NULL);
 }
 
+/* XXX: This will be used in places, where nd_lock is already taken */
+static inline void __unregister_netdevice(struct net_device *dev)
+{
+	unregister_netdevice_queue(dev, NULL);
+}
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 void init_dummy_netdev(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9d98ab1e76bd..63ece39c9286 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10651,7 +10651,7 @@ struct nd_lock *attach_new_nd_lock(struct net_device *dev)
 EXPORT_SYMBOL(attach_new_nd_lock);
 
 /**
- * register_netdevice() - register a network device
+ * __register_netdevice() - register a network device
  * @dev: device to register
  *
  * Take a prepared network device structure and make it externally accessible.
@@ -10659,7 +10659,7 @@ EXPORT_SYMBOL(attach_new_nd_lock);
  * Callers must hold the rtnl lock - you may want register_netdev()
  * instead of this.
  */
-int register_netdevice(struct net_device *dev)
+int __register_netdevice(struct net_device *dev)
 {
 	int ret;
 	struct net *net = dev_net(dev);
@@ -10675,6 +10675,9 @@ int register_netdevice(struct net_device *dev)
 	BUG_ON(dev->reg_state != NETREG_UNINITIALIZED);
 	BUG_ON(!net);
 
+	if (WARN_ON(!rcu_access_pointer(dev->nd_lock)))
+		return -ENOLCK;
+
 	ret = ethtool_check_ops(dev->ethtool_ops);
 	if (ret)
 		return ret;
@@ -10837,6 +10840,40 @@ int register_netdevice(struct net_device *dev)
 	netdev_name_node_free(dev->name_node);
 	goto out;
 }
+EXPORT_SYMBOL(__register_netdevice);
+
+int register_netdevice(struct net_device *dev)
+{
+	struct nd_lock *nd_lock;
+	int err;
+
+	/* XXX: This "if" is to start one by one convertation
+	 * to use __register_netdevice() in devices, that
+	 * want to attach nd_lock themself (e.g., having newlink).
+	 * After all of them are converted, we remove this.
+	 */
+	if (rcu_access_pointer(dev->nd_lock))
+		return __register_netdevice(dev);
+
+	nd_lock = alloc_nd_lock();
+	if (!nd_lock)
+		return -ENOMEM;
+
+	/* This may be called from netdevice notifier, which is not converted
+	 * yet. The context is unknown: either some nd_lock is locked or not.
+	 * Sometimes here is nested mutex and sometimes is not. We use trylock
+	 * to silence lockdep assert about that.
+	 * It will be replaced by mutex_lock(), see next patches.
+	 */
+	BUG_ON(!mutex_trylock(&nd_lock->mutex));
+	attach_nd_lock(dev, nd_lock);
+	err = __register_netdevice(dev);
+	if (err)
+		detach_nd_lock(dev);
+	mutex_unlock(&nd_lock->mutex);
+	put_nd_lock(nd_lock);
+	return err;
+}
 EXPORT_SYMBOL(register_netdevice);
 
 /* Initialize the core of a dummy net device.
@@ -10907,7 +10944,23 @@ int register_netdev(struct net_device *dev)
 
 	if (rtnl_lock_killable())
 		return -EINTR;
-	err = register_netdevice(dev);
+
+	/* Since this function is called without rtnl_lock(),
+	 * nested registration is not possible here (compare
+	 * to .newlink). So it's not interesting for us as
+	 * much as register_netdevice(). Here are possible some
+	 * real cross-device links between devices related
+	 * to specific driver family, and they are handled by
+	 * using fallback_nd_lock for all devices.
+	 * Also, see comment in nd_lock_transfer_devices().
+	 */
+	mutex_lock(&fallback_nd_lock.mutex);
+	attach_nd_lock(dev, &fallback_nd_lock);
+	err = __register_netdevice(dev);
+	if (err)
+		detach_nd_lock(dev);
+	mutex_unlock(&fallback_nd_lock.mutex);
+
 	rtnl_unlock();
 	return err;
 }
@@ -11474,6 +11527,54 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
 
+static DEFINE_SPINLOCK(put_lock);
+static LIST_HEAD(put_list);
+
+static void put_work_func(struct work_struct *unused)
+{
+	struct nd_lock *nd_lock;
+	struct net_device *dev;
+	LIST_HEAD(list);
+
+	spin_lock(&put_lock);
+	list_replace_init(&put_list, &list);
+	spin_unlock(&put_lock);
+
+	while (!list_empty(&list)) {
+		dev = list_first_entry(&list,
+				       struct net_device,
+				       todo_list);
+		list_del_init(&dev->todo_list);
+
+		/* XXX: this nd_lock finaly should be held during
+		 * the whole unregistering. Since not all of devices
+		 * are converted yet, we place the detach_nd_lock here
+		 * to be able to start attaching nd_lock to every device
+		 * one by one in separate patches of this series.
+		 * Then, it will be moved to callers (unregister_netdevice()
+		 * and others).
+		 *
+		 * Note, we can't place the below to free_netdev(), because
+		 * of free_netdev() currently may be called locked and unlocked
+		 * from different callers.
+		 *
+		 * Also note, that lock may be detached here in case of
+		 * this is cleanup after failed __register_netdevice().
+		 */
+		if (lock_netdev(dev, &nd_lock)) {
+			detach_nd_lock(dev);
+			unlock_netdev(nd_lock);
+		}
+
+		if (dev->reg_state == NETREG_RELEASED)
+			put_device(&dev->dev); /* free via device release */
+		else /* Compatibility with error handling in drivers */
+			kvfree(dev);
+	}
+}
+
+static DECLARE_WORK(put_work, put_work_func);
+
 /**
  * free_netdev - free network device
  * @dev: device
@@ -11486,6 +11587,7 @@ EXPORT_SYMBOL(alloc_netdev_mqs);
 void free_netdev(struct net_device *dev)
 {
 	struct napi_struct *p, *n;
+	bool work;
 
 	might_sleep();
 
@@ -11521,18 +11623,19 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->xdp_bulkq);
 	dev->xdp_bulkq = NULL;
 
-	/*  Compatibility with error handling in drivers */
-	if (dev->reg_state == NETREG_UNINITIALIZED ||
-	    dev->reg_state == NETREG_DUMMY) {
-		kvfree(dev);
-		return;
+	if (dev->reg_state != NETREG_UNINITIALIZED &&
+	    dev->reg_state != NETREG_DUMMY) {
+		BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
+		WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 	}
 
-	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
-	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
+	spin_lock(&put_lock);
+	list_add_tail(&dev->todo_list, &put_list);
+	work = list_is_singular(&put_list);
+	spin_unlock(&put_lock);
 
-	/* will free via device release */
-	put_device(&dev->dev);
+	if (work)
+		schedule_work(&put_work);
 }
 EXPORT_SYMBOL(free_netdev);
 


