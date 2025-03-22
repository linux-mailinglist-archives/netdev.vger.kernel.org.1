Return-Path: <netdev+bounces-176875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B11A6CAA8
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F4518915A1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7D22D7B3;
	Sat, 22 Mar 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="hX10MzcT"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F21F236C;
	Sat, 22 Mar 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654334; cv=none; b=dsSaM9T4xAvXYzMJ5w0eAQuUxj/Mg/iD5ZhMOrH0FpDpXJ//u1c2WX4jI3ZWUo66EKPpa+jfWB1QDY0AsKNez7p/sQD8bRCSRgff47NjbzFDrAt4Te8suh1/Q6MmI6w1jBwNXg9RDr7RAMZ+JVoDyZr8x+4gnx7pY75TkbEFo/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654334; c=relaxed/simple;
	bh=4Lq1GLfmOLk1xk9hfZidI9Ty1CLMb85ko4f0Wa78Rfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVPeEfJXldThmlzQ8BZxP29IPYqaA69aEk+YhrZKpPOwORoYdbyMZNL6Bg3ylj2Ix2iB/bdC8Kda+JRhtzeacz+Id1gcJ+CrjS6K6J7XjyCU1ijbIAqa7cNbr9f1WBFPOvXsJk2qW+QM6iUumIlRIrwq5FLcHBwjyyCpk4UtWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=hX10MzcT; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:797:0:640:5446:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 1186260B3D;
	Sat, 22 Mar 2025 17:38:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kcNEheWLbqM0-usP3l1rH;
	Sat, 22 Mar 2025 17:38:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654328; bh=8PpMN+UBkUvgIIZEtTpVi/a33OjJVhN/5ilyau34FzM=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=hX10MzcTEHxlLYRyn+d1+/IL4G/3G4XucmWyxznymKBiPUGjklaL/G99wxZGyb61y
	 37xiCWp6aBNmiP02JcnFJuy99dnuuIjn/ep5CSnP9+IGeLgG/YsKm+kjE6iBzFzZv+
	 cMEhiIrptWBndehRyuVl5jkMNnjkx0DgBavZRJXE=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 07/51] net: Introduce nd_lock and primitives to work with it
Date: Sat, 22 Mar 2025 17:38:46 +0300
Message-ID: <174265432664.356712.15568949959158340088.stgit@pro.pro>
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

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 include/linux/netdevice.h |   28 ++++
 net/core/dev.c            |  329 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 357 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 614ec5d3d75b..e36e64310bd4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1716,6 +1716,14 @@ enum netdev_reg_state {
 	NETREG_DUMMY,		/* dummy device for NAPI poll */
 };
 
+struct nd_lock {
+	struct mutex mutex;
+	struct list_head list;
+	int nr; /* number of entries in list */
+	refcount_t usage;
+	struct rcu_head rcu;
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2081,6 +2089,8 @@ struct net_device {
 	char			name[IFNAMSIZ];
 	struct netdev_name_node	*name_node;
 	struct dev_ifalias	__rcu *ifalias;
+	struct nd_lock		__rcu *nd_lock; /* lock protecting this dev */
+	struct list_head	nd_lock_entry; /* entry in nd_lock::list */
 	/*
 	 *	I/O specific fields
 	 *	FIXME: Merge these and struct ifmap into one
@@ -3094,6 +3104,24 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 	return ret;
 }
 
+void unlock_netdev(struct nd_lock *nd_lock);
+bool lock_netdev(struct net_device *dev, struct nd_lock **nd_lock);
+bool lock_netdev_nested(struct net_device *dev, struct nd_lock **nd_lock,
+				      struct nd_lock *held_lock);
+bool double_lock_netdev(struct net_device *dev, struct nd_lock **nd_lock,
+			struct net_device *dev2, struct nd_lock **nd_lock2);
+void double_unlock_netdev(struct nd_lock *nd_lock, struct nd_lock *nd_lock2);
+
+struct nd_lock *alloc_nd_lock(void);
+void put_nd_lock(struct nd_lock *nd_lock);
+void attach_nd_lock(struct net_device *dev, struct nd_lock *nd_lock);
+void detach_nd_lock(struct net_device *dev);
+struct nd_lock *attach_new_nd_lock(struct net_device *dev);
+
+extern struct nd_lock fallback_nd_lock;
+
+void nd_lock_transfer_devices(struct nd_lock **p_lock, struct nd_lock **p_lock2);
+
 int register_netdevice(struct net_device *dev);
 void unregister_netdevice_queue(struct net_device *dev, struct list_head *head);
 void unregister_netdevice_many(struct list_head *head);
diff --git a/net/core/dev.c b/net/core/dev.c
index 0d0b983a6c21..9d98ab1e76bd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -170,6 +170,25 @@ static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
 
+/* While unregistering many devices at once, e.g., in ->exit_batch_rtnl
+ * methods, every netdev must be locked.
+ * Instead of taking all original nd_locks of devices at once, we transfer
+ * devices to relate to this @fallback_nd_lock. It allows to own a single
+ * lock during the unregistration. See locks_ordered() for locking order
+ * details.
+ *
+ * Not a first priority TODO is to change this algorithm to use one
+ * of original locks of these devices to transfer every device to.
+ *
+ * XXX: look at comment to nd_lock_transfer_devices().
+ */
+struct nd_lock fallback_nd_lock = {
+	.mutex = __MUTEX_INITIALIZER(fallback_nd_lock.mutex),
+	.list = LIST_HEAD_INIT(fallback_nd_lock.list),
+	.usage = REFCOUNT_INIT(1),
+};
+EXPORT_SYMBOL(fallback_nd_lock);
+
 static DEFINE_MUTEX(ifalias_mutex);
 
 /* protects napi_hash addition/deletion and napi_gen_id */
@@ -10322,6 +10341,315 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
 	}
 }
 
+struct nd_lock *alloc_nd_lock(void)
+{
+	struct nd_lock *nd_lock = kmalloc(sizeof(*nd_lock), GFP_KERNEL);
+
+	if (!nd_lock)
+		return NULL;
+
+	mutex_init(&nd_lock->mutex);
+	INIT_LIST_HEAD(&nd_lock->list);
+	nd_lock->nr = 0;
+	refcount_set(&nd_lock->usage, 1);
+	return nd_lock;
+}
+EXPORT_SYMBOL(alloc_nd_lock);
+
+void put_nd_lock(struct nd_lock *nd_lock)
+{
+	if (!refcount_dec_and_test(&nd_lock->usage))
+		return;
+	BUG_ON(!list_empty(&nd_lock->list));
+	kfree_rcu(nd_lock, rcu);
+}
+EXPORT_SYMBOL(put_nd_lock);
+
+/* Locking order: fallback_nd_lock is first,
+ * then prefer lock with smaller address.
+ */
+static bool locks_ordered(struct nd_lock *nd_lock, struct nd_lock *nd_lock2)
+{
+	if ((nd_lock <= nd_lock2 && nd_lock2 != &fallback_nd_lock) ||
+	    nd_lock == &fallback_nd_lock)
+		return true;
+	return false;
+}
+
+/* Lock alive @dev or return false. @held_lock is optional argument.
+ * In case of @held_lock is passed, the caller must guarantee that
+ * dev->nd_lock is after @held_lock in the locking order (for details
+ * see locks_ordered()).
+ * Usually, held_lock is fallback_nd_lock.
+ */
+static bool __lock_netdev(struct net_device *dev, struct nd_lock **ret_nd_lock,
+			  struct nd_lock *held_lock)
+{
+	struct nd_lock *nd_lock;
+	bool got;
+
+	if (held_lock)
+		lockdep_assert_held(&held_lock->mutex);
+
+	while (1) {
+		rcu_read_lock();
+		nd_lock = rcu_dereference(dev->nd_lock);
+		if (nd_lock && nd_lock != held_lock)
+			got = refcount_inc_not_zero(&nd_lock->usage);
+		rcu_read_unlock();
+
+		if (unlikely(!nd_lock)) {
+			/* Someone is unregistering @dev in parallel */
+			*ret_nd_lock = NULL;
+			return false;
+		}
+
+		/* The same lock as we own. Nothing to do. */
+		if (nd_lock == held_lock)
+			break;
+
+		if (unlikely(!got)) {
+			/* @dev->nd_lock changed or @dev is unregistering */
+			cond_resched();
+			continue;
+		}
+
+		WARN_ON(held_lock && !locks_ordered(held_lock, nd_lock));
+
+		if (!held_lock)
+			mutex_lock(&nd_lock->mutex);
+		else
+			mutex_lock_nested(&nd_lock->mutex, SINGLE_DEPTH_NESTING);
+		/* Check after mutex is locked it has not changed */
+		if (likely(nd_lock == rcu_access_pointer(dev->nd_lock)))
+			break;
+		mutex_unlock(&nd_lock->mutex);
+		put_nd_lock(nd_lock);
+		cond_resched();
+	}
+
+	*ret_nd_lock = nd_lock;
+	return true;
+}
+
+bool lock_netdev(struct net_device *dev, struct nd_lock **nd_lock)
+{
+	return __lock_netdev(dev, nd_lock, NULL);
+}
+EXPORT_SYMBOL(lock_netdev);
+
+bool lock_netdev_nested(struct net_device *dev, struct nd_lock **nd_lock,
+			struct nd_lock *held_lock)
+{
+	return __lock_netdev(dev, nd_lock, held_lock);
+}
+EXPORT_SYMBOL(lock_netdev_nested);
+
+void unlock_netdev(struct nd_lock *nd_lock)
+{
+	mutex_unlock(&nd_lock->mutex);
+	put_nd_lock(nd_lock);
+}
+EXPORT_SYMBOL(unlock_netdev);
+
+/* Double lock two devices and return locks they currently attached to.
+ * It's acceptable for one of devices to be NULL, or @dev and @dev2 may
+ * point to the same device. Pair bracket double_unlock_netdev() are able
+ * to handle such cases.
+ */
+bool double_lock_netdev(struct net_device *dev, struct nd_lock **ret_nd_lock,
+			struct net_device *dev2, struct nd_lock **ret_nd_lock2)
+{
+	struct nd_lock *nd_lock, *nd_lock2;
+	bool got, got2, ret;
+
+	if (WARN_ON_ONCE(!dev && !dev2))
+		return false;
+
+	if (dev == dev2 || !dev != !dev2) {
+		ret = lock_netdev(dev ? : dev2, ret_nd_lock);
+		*ret_nd_lock2 = *ret_nd_lock;
+		return ret;
+	}
+
+	while (1) {
+		got = got2 = false;
+		rcu_read_lock();
+		nd_lock = rcu_dereference(dev->nd_lock);
+		if (nd_lock)
+			got = refcount_inc_not_zero(&nd_lock->usage);
+		nd_lock2 = rcu_dereference(dev2->nd_lock);
+		if (nd_lock2) {
+			if (nd_lock2 != nd_lock)
+				got2 = refcount_inc_not_zero(&nd_lock2->usage);
+		}
+		rcu_read_unlock();
+		if (!got || (!got2 && nd_lock2 != nd_lock))
+			goto restart;
+
+		if (locks_ordered(nd_lock, nd_lock2)){
+			mutex_lock(&nd_lock->mutex);
+			if (nd_lock != nd_lock2)
+				mutex_lock_nested(&nd_lock2->mutex, SINGLE_DEPTH_NESTING);
+		} else {
+			mutex_lock(&nd_lock2->mutex);
+			if (nd_lock != nd_lock2)
+				mutex_lock_nested(&nd_lock->mutex, SINGLE_DEPTH_NESTING);
+		}
+
+		if (likely(nd_lock == rcu_access_pointer(dev->nd_lock) &&
+			   nd_lock2 == rcu_access_pointer(dev2->nd_lock))) {
+			/* Both locks are acquired and correct */
+			break;
+		}
+		if (nd_lock != nd_lock2)
+			mutex_unlock(&nd_lock2->mutex);
+		mutex_unlock(&nd_lock->mutex);
+restart:
+		if (got)
+			put_nd_lock(nd_lock);
+		if (got2)
+			put_nd_lock(nd_lock2);
+		if (!nd_lock || !nd_lock2) {
+			*ret_nd_lock = *ret_nd_lock2 = NULL;
+			return false;
+		}
+	}
+
+	*ret_nd_lock = nd_lock;
+	*ret_nd_lock2 = nd_lock2;
+	return true;
+}
+EXPORT_SYMBOL(double_lock_netdev);
+
+void double_unlock_netdev(struct nd_lock *nd_lock, struct nd_lock *nd_lock2)
+{
+	if (nd_lock != nd_lock2)
+		unlock_netdev(nd_lock);
+	unlock_netdev(nd_lock2);
+}
+EXPORT_SYMBOL(double_unlock_netdev);
+
+/* Make set of devices protected by @p_lock and set of devices protected
+ * by @p_lock2 to be protected the same lock (this function chooses one
+ * of @p_lock and @p_lock2 as that common lock).
+ *
+ * 1)We call this in drivers which make two or more devices bound each other.
+ *   E.g., drivers using newlink (like bonding, bridge and veth), or connecting
+ *   several devices in switch (like dsa). Nested configurations are also
+ *   handled to relate the same nd_lock (e.g., if veth is attached to bridge,
+ *   the same lock will be shared by both veth peers, all bridge ports
+ *   and the bridge itself).
+ *
+ *   This allow to introduce sane locking like:
+ *
+ *   lock_netdev(bridge, &nd_lock)
+ *   ioctl(change bridge)
+ *     netdevice notifier for bridge       // protected by nd_lock
+ *       netdevice notifier for veth       // protected by nd_lock
+ *         change veth parameter           // protected by nd_lock
+ *       netdevice notifier for other port // protected by nd_lock
+ *         change port device parameter    // protected by nd_lock
+ *   unlock_netdev(nd_lock)
+ *
+ * So, each lock protects some group devices in the system, and all
+ * of devices in the group are connected in some logical way.
+ *
+ * 2)The main rule for choosing common lock is simple: we prefer fallback_nd_lock.
+ *   Why it is so? Along with common used virtual devices, there are
+ *   several hardware devices, which connect devices in groups and
+ *   touches or modifies several devices together in one ioctl
+ *   or netdevice event (e.g., mlx5). Not having every of devices zoo
+ *   physically, it's impossible to organize them in small exact groups
+ *   and test. So, we attach them to bigger fallback group.
+ *
+ *   Let we have converted bridge driver and not converted my_driver. In case
+ *   of we attach my_driver dev1 to the bridge, the bridge and my_driver dev1
+ *   must relate to the same nd_lock. But the only nd_lock we can attach is
+ *   fallback_nd_lock, otherwise my_driver dev1 may appear in different lock
+ *   groups with some my_driver dev2 after my_driver dev2 is loaded. This
+ *   would be wrong, since dev1 and dev2 may be used  in same ioctl or netdevice
+ *   event. So, fallback_nd_lock will be used as result lock.
+ *
+ *   Note, that after all hardware drivers organize their logically connected
+ *   devices in correct nd_lock groups, we remove this rule.
+ *
+ *   The second rule is we prefer to migrate from smaller list, since
+ *   there are less iterations.
+ *
+ * 3)Note, that reverse operation (splitting a lock into two locks) is not
+ *   implemented at the moment (and it maybe useless).
+ *
+ * 4)Newly used lock for both sets is returned in @p_lock2 argument.
+ */
+void nd_lock_transfer_devices(struct nd_lock **p_lock, struct nd_lock **p_lock2)
+{
+	struct nd_lock *lock = *p_lock, *lock2 = *p_lock2;
+	struct net_device *dev;
+
+	lockdep_assert_held(&lock->mutex);
+	lockdep_assert_held(&lock2->mutex);
+
+	if (lock == lock2)
+		return;
+
+	if (lock == &fallback_nd_lock ||
+	    (lock2 != &fallback_nd_lock && lock->nr > lock2->nr))
+		swap(lock, lock2);
+
+	list_for_each_entry(dev, &lock->list, nd_lock_entry)
+		rcu_assign_pointer(dev->nd_lock, lock2);
+
+	list_splice(&lock->list, &lock2->list);
+	refcount_add(lock->nr, &lock2->usage);
+	lock2->nr += lock->nr;
+	lock->nr = 0;
+	/* Our caller must own @lock since its locked */
+	WARN_ON(refcount_sub_and_test(lock->nr, &lock->usage));
+
+	*p_lock = lock;
+	*p_lock2 = lock2;
+}
+EXPORT_SYMBOL(nd_lock_transfer_devices);
+
+void attach_nd_lock(struct net_device *dev, struct nd_lock *nd_lock)
+{
+	lockdep_assert_held(&nd_lock->mutex);
+	rcu_assign_pointer(dev->nd_lock, nd_lock);
+	list_add(&dev->nd_lock_entry, &nd_lock->list);
+	refcount_inc(&nd_lock->usage);
+	nd_lock->nr++;
+}
+EXPORT_SYMBOL(attach_nd_lock);
+
+void detach_nd_lock(struct net_device *dev)
+{
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
+
+	lockdep_assert_held(&nd_lock->mutex);
+	rcu_assign_pointer(dev->nd_lock, NULL);
+	list_del_init(&dev->nd_lock_entry);
+	nd_lock->nr--;
+	/* Our caller must own @lock since its locked */
+	WARN_ON(refcount_dec_and_test(&nd_lock->usage));
+}
+EXPORT_SYMBOL(detach_nd_lock);
+
+struct nd_lock *attach_new_nd_lock(struct net_device *dev)
+{
+	struct nd_lock *nd_lock = alloc_nd_lock();
+	if (!nd_lock)
+		return NULL;
+
+	mutex_lock(&nd_lock->mutex);
+	attach_nd_lock(dev, nd_lock);
+	mutex_unlock(&nd_lock->mutex);
+	put_nd_lock(nd_lock);
+
+	return nd_lock;
+}
+EXPORT_SYMBOL(attach_new_nd_lock);
+
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -11094,6 +11422,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	INIT_LIST_HEAD(&dev->link_watch_list);
 	INIT_LIST_HEAD(&dev->adj_list.upper);
 	INIT_LIST_HEAD(&dev->adj_list.lower);
+	INIT_LIST_HEAD(&dev->nd_lock_entry);
 	INIT_LIST_HEAD(&dev->ptype_all);
 	INIT_LIST_HEAD(&dev->ptype_specific);
 	INIT_LIST_HEAD(&dev->net_notifier_list);


