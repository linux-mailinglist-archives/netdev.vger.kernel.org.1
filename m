Return-Path: <netdev+bounces-42297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C498B7CE19D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227BBB20F21
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D773B79D;
	Wed, 18 Oct 2023 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWdvQ66g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCBCBE62
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A87C433C8;
	Wed, 18 Oct 2023 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644090;
	bh=e6WdhWT7uLorGiereKdNb2V7Boad3dLhWG4qLXS9Hf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWdvQ66gSbZ2iIHTU/LWtReVBd4RWrCOWZ+G89/+4aw7ddY5Bw6vCVn64W7eeHD5N
	 yYIdqtJQliSS7xnm8OjCbAwIw/nAn3MUAawJlshTJujVH7VeYfACAA7t3SeOmw9Dg1
	 waUq6PxY2LUgRtGookLaghOskpZlRypHnrUA4NZT6SLpG92ziqYgEHbOchLN+4Zj7n
	 tEme+l7vDJco4HiPrtAHCA8lSI35UyswJ2DC97r7sy42fvINRWFlYgZFU47w4IQ6Bt
	 GtEPJ5O/sp3e3lpObLClxISGVT012HAuWM43ALlRCMgi8fzqEbPPApIYEE7OAwPGPF
	 Lh7tFnWnfiBzw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mhocko@suse.com,
	stephen@networkplumber.org
Subject: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device attributes
Date: Wed, 18 Oct 2023 17:47:43 +0200
Message-ID: <20231018154804.420823-2-atenart@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154804.420823-1-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have an ABBA deadlock between net device unregistration and sysfs
files being accessed[1][2]. To prevent this from happening all paths
taking the rtnl lock after the sysfs one (actually kn->active refcount)
use rtnl_trylock and return early (using restart_syscall)[3] which can
make syscalls to spin for a long time when there is contention on the
rtnl lock[4].

There are not many possibilities to improve the above:
- Rework the entire net/ locking logic.
- Invert two locks in one of the paths — not possible.

But here it's actually possible to drop one of the locks safely: the
kernfs_node refcount. More details in the code itself, which comes with
lots of comments.

[1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
[2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
[3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
[4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.org/T/

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/net-sysfs.c | 142 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 30 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fccaa5bac0ed..76d8729340b7 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -40,6 +40,88 @@ static inline int dev_isalive(const struct net_device *dev)
 	return dev->reg_state <= NETREG_REGISTERED;
 }
 
+/* We have a possible ABBA deadlock between rtnl_lock and kernfs_node->active,
+ * when unregistering a net device and accessing associated sysfs files. Tx/Rx
+ * queues do embed their own kobject for their sysfs files but the same issue
+ * applies as a net device being unresgistered will remove those sysfs files as
+ * well. The potential deadlock is as follow:
+ *
+ *         CPU 0                                         CPU 1
+ *
+ *    rtnl_lock                                   vfs_read
+ *    unregister_netdevice_many                   kernfs_seq_start
+ *    device_del / kobject_put                      kernfs_get_active (kn->active++)
+ *    kernfs_drain                                sysfs_kf_seq_show
+ *    wait_event(                                 rtnl_lock
+ *       kn->active == KN_DEACTIVATED_BIAS)       -> waits on CPU 0 to release
+ *    -> waits on CPU 1 to decrease kn->active       the rtnl lock.
+ *
+ * The historical fix was to use rtnl_trylock with restart_syscall to bail out
+ * of sysfs accesses when the lock wasn't taken. This fixed the above issue as
+ * it allowed CPU 1 to bail out of the ABBA situation.
+ *
+ * But this comes with performances issues, as syscalls are being restarted in
+ * loops when there is contention, with huge slow downs in specific scenarios
+ * (e.g. lots of virtual interfaces created at startup and userspace daemons
+ * querying their attributes).
+ *
+ * The idea below is to bail out of the active kernfs_node protection
+ * (kn->active) while still being in a safe position to continue the execution
+ * of our sysfs helpers.
+ */
+static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
+						  struct attribute *attr,
+						  struct net_device *ndev)
+{
+	struct kernfs_node *kn;
+
+	/* First, we hold a reference to the net device we might use in the
+	 * locking section as the unregistration path might run in parallel.
+	 * This will ensure the net device won't be freed before we return.
+	 */
+	dev_hold(ndev);
+	/* sysfs_break_active_protection was introduced to allow self-removal of
+	 * devices and their associated sysfs files by bailing out of the
+	 * sysfs/kernfs protection. We do this here to allow the unregistration
+	 * path to complete in parallel. The following takes a reference on the
+	 * kobject and the kernfs_node being accessed.
+	 *
+	 * This works because we hold a reference onto the net device and the
+	 * unregistration path will wait for us eventually in netdev_run_todo
+	 * (outside an rtnl lock section).
+	 */
+	kn = sysfs_break_active_protection(kobj, attr);
+	WARN_ON_ONCE(!kn);
+	/* Finally we do take the rtnl lock. This can't deadlock us as the
+	 * unregistration path will be able to drain sysfs files (kernfs_node).
+	 */
+	rtnl_lock();
+	return kn;
+}
+
+static inline void __sysfs_rtnl_unlock(struct net_device *ndev,
+				       struct kernfs_node *kn)
+{
+	rtnl_unlock();
+	/* This will drop our references on the kobject and kernfs_node. A
+	 * limitation is we can't have the sysfs removal logic depend on the
+	 * kobject reference counting, we have to do this manually in our
+	 * unregistration paths.
+	 */
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
+}
+
+static inline void sysfs_rtnl_unlock(struct net_device *ndev,
+				     struct kernfs_node *kn)
+{
+	__sysfs_rtnl_unlock(ndev, kn);
+	/* Might unlock the last unregistration path step. It's not safe to
+	 * access the net device after this.
+	 */
+	dev_put(ndev);
+}
+
 /* use same locking rules as GIF* ioctl's */
 static ssize_t netdev_show(const struct device *dev,
 			   struct device_attribute *attr, char *buf,
@@ -83,6 +165,7 @@ static ssize_t netdev_store(struct device *dev, struct device_attribute *attr,
 {
 	struct net_device *netdev = to_net_dev(dev);
 	struct net *net = dev_net(netdev);
+	struct kernfs_node *kn;
 	unsigned long new;
 	int ret;
 
@@ -93,15 +176,14 @@ static ssize_t netdev_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		goto err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev)) {
 		ret = (*set)(netdev, new);
 		if (ret == 0)
 			ret = len;
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
  err:
 	return ret;
 }
@@ -181,7 +263,7 @@ static ssize_t carrier_store(struct device *dev, struct device_attribute *attr,
 	struct net_device *netdev = to_net_dev(dev);
 
 	/* The check is also done in change_carrier; this helps returning early
-	 * without hitting the trylock/restart in netdev_store.
+	 * without hitting the locking section in netdev_store.
 	 */
 	if (!netdev->netdev_ops->ndo_change_carrier)
 		return -EOPNOTSUPP;
@@ -205,16 +287,16 @@ static ssize_t speed_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	int ret = -EINVAL;
 
 	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the locking section below.
 	 */
 	if (!netdev->ethtool_ops->get_link_ksettings)
 		return ret;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
@@ -222,7 +304,7 @@ static ssize_t speed_show(struct device *dev,
 		if (!__ethtool_get_link_ksettings(netdev, &cmd))
 			ret = sysfs_emit(buf, fmt_dec, cmd.base.speed);
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 	return ret;
 }
 static DEVICE_ATTR_RO(speed);
@@ -231,16 +313,16 @@ static ssize_t duplex_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	int ret = -EINVAL;
 
 	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the locking section below.
 	 */
 	if (!netdev->ethtool_ops->get_link_ksettings)
 		return ret;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
@@ -262,7 +344,7 @@ static ssize_t duplex_show(struct device *dev,
 			ret = sysfs_emit(buf, "%s\n", duplex);
 		}
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 	return ret;
 }
 static DEVICE_ATTR_RO(duplex);
@@ -428,6 +510,7 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 {
 	struct net_device *netdev = to_net_dev(dev);
 	struct net *net = dev_net(netdev);
+	struct kernfs_node *kn;
 	size_t count = len;
 	ssize_t ret = 0;
 
@@ -438,8 +521,7 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 	if (len >  0 && buf[len - 1] == '\n')
 		--count;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev)) {
 		ret = dev_set_alias(netdev, buf, count);
@@ -449,7 +531,7 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 		netdev_state_change(netdev);
 	}
 err:
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 
 	return ret;
 }
@@ -499,16 +581,16 @@ static ssize_t phys_port_id_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	ssize_t ret = -EINVAL;
 
 	/* The check is also done in dev_get_phys_port_id; this helps returning
-	 * early without hitting the trylock/restart below.
+	 * early without hitting the locking section below.
 	 */
 	if (!netdev->netdev_ops->ndo_get_phys_port_id)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev)) {
 		struct netdev_phys_item_id ppid;
@@ -517,7 +599,7 @@ static ssize_t phys_port_id_show(struct device *dev,
 		if (!ret)
 			ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 
 	return ret;
 }
@@ -527,17 +609,17 @@ static ssize_t phys_port_name_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	ssize_t ret = -EINVAL;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the locking section below.
 	 */
 	if (!netdev->netdev_ops->ndo_get_phys_port_name &&
 	    !netdev->devlink_port)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev)) {
 		char name[IFNAMSIZ];
@@ -546,7 +628,7 @@ static ssize_t phys_port_name_show(struct device *dev,
 		if (!ret)
 			ret = sysfs_emit(buf, "%s\n", name);
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 
 	return ret;
 }
@@ -556,18 +638,18 @@ static ssize_t phys_switch_id_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	ssize_t ret = -EINVAL;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the trylock/restart below. This works
+	 * returning early without hitting the locking section below. This works
 	 * because recurse is false when calling dev_get_port_parent_id.
 	 */
 	if (!netdev->netdev_ops->ndo_get_port_parent_id &&
 	    !netdev->devlink_port)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev)) {
 		struct netdev_phys_item_id ppid = { };
@@ -576,7 +658,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
 		if (!ret)
 			ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
 	}
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 
 	return ret;
 }
@@ -586,15 +668,15 @@ static ssize_t threaded_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	struct kernfs_node *kn;
 	ssize_t ret = -EINVAL;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 
 	if (dev_isalive(netdev))
 		ret = sysfs_emit(buf, fmt_dec, netdev->threaded);
 
-	rtnl_unlock();
+	sysfs_rtnl_unlock(netdev, kn);
 	return ret;
 }
 
-- 
2.41.0


