Return-Path: <netdev+bounces-42300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089E7CE1A0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5F2281EBA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1D3B7A2;
	Wed, 18 Oct 2023 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxBPNxnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF15BE62
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D937C433C8;
	Wed, 18 Oct 2023 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644099;
	bh=FAdcenIHw35N/BQIfshjMUdQiCYcYcQAoKRQgmuaMtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxBPNxnbnSxW3+zQ1eENrVVN43rl1x8XlEoN+rRRy3r1qkOdklYEiulcivOCX7jvA
	 1tw0sVHyuQO7ZaDOobm4A2r7vAyMjTnwnbf7GU/UHOGYQqJUcG5olNGJfi8+V5jnvP
	 p8b9DWz56y9Po0Yu9APoMk/3n+zRB3DtXZvC4oMpx/sY77Zgs92PaRKYeU1ks+3RQQ
	 IVCHi+8DFEZ5h1e1BUZYwvEmfo8vd4jE/DZ3ErB5NKfDSHQhP8iiFbPBkHhhNBpYvJ
	 ItnRzs+EpJ01oIIoDRegEmVr7XiZBsVPZ7cSMLY4OkzwUS5Ektd0p59vt1SUFfjvFH
	 QV0/+lKjCzM9A==
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
Subject: [RFC PATCH net-next 4/4] net-sysfs: remove rtnl_trylock from queue attributes
Date: Wed, 18 Oct 2023 17:47:46 +0200
Message-ID: <20231018154804.420823-5-atenart@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154804.420823-1-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the commit removing remove rtnl_trylock from device
attributes we here apply the same technique to networking queues.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/net-sysfs.c | 132 ++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 59 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 75fb92c44291..1ef93a3ef4a5 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1296,9 +1296,11 @@ static int net_rx_queue_change_owner(struct net_device *dev, int num,
  */
 struct netdev_queue_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct netdev_queue *queue, char *buf);
-	ssize_t (*store)(struct netdev_queue *queue,
-			 const char *buf, size_t len);
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			struct netdev_queue *queue, char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			 struct netdev_queue *queue, const char *buf,
+			 size_t len);
 };
 #define to_netdev_queue_attr(_attr) \
 	container_of(_attr, struct netdev_queue_attribute, attr)
@@ -1315,7 +1317,7 @@ static ssize_t netdev_queue_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	return attribute->show(queue, buf);
+	return attribute->show(kobj, attr, queue, buf);
 }
 
 static ssize_t netdev_queue_attr_store(struct kobject *kobj,
@@ -1329,7 +1331,7 @@ static ssize_t netdev_queue_attr_store(struct kobject *kobj,
 	if (!attribute->store)
 		return -EIO;
 
-	return attribute->store(queue, buf, count);
+	return attribute->store(kobj, attr, queue, buf, count);
 }
 
 static const struct sysfs_ops netdev_queue_sysfs_ops = {
@@ -1337,7 +1339,8 @@ static const struct sysfs_ops netdev_queue_sysfs_ops = {
 	.store = netdev_queue_attr_store,
 };
 
-static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
+static ssize_t tx_timeout_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	unsigned long trans_timeout = atomic_long_read(&queue->trans_timeout);
 
@@ -1355,18 +1358,18 @@ static unsigned int get_netdev_queue_index(struct netdev_queue *queue)
 	return i;
 }
 
-static ssize_t traffic_class_show(struct netdev_queue *queue,
-				  char *buf)
+static ssize_t traffic_class_show(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
+	struct kernfs_node *kn;
 	int num_tc, tc;
 	int index;
 
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(kobj, attr, queue->dev);
 
 	index = get_netdev_queue_index(queue);
 
@@ -1376,7 +1379,7 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
 	num_tc = dev->num_tc;
 	tc = netdev_txq_to_tc(dev, index);
 
-	rtnl_unlock();
+	sysfs_rtnl_unlock(queue->dev, kn);
 
 	if (tc < 0)
 		return -EINVAL;
@@ -1393,24 +1396,26 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
 }
 
 #ifdef CONFIG_XPS
-static ssize_t tx_maxrate_show(struct netdev_queue *queue,
-			       char *buf)
+static ssize_t tx_maxrate_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	return sysfs_emit(buf, "%lu\n", queue->tx_maxrate);
 }
 
-static ssize_t tx_maxrate_store(struct netdev_queue *queue,
-				const char *buf, size_t len)
+static ssize_t tx_maxrate_store(struct kobject *kobj, struct attribute *attr,
+				struct netdev_queue *queue, const char *buf,
+				size_t len)
 {
-	struct net_device *dev = queue->dev;
 	int err, index = get_netdev_queue_index(queue);
+	struct net_device *dev = queue->dev;
+	struct kernfs_node *kn;
 	u32 rate = 0;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	/* The check is also done later; this helps returning early without
-	 * hitting the trylock/restart below.
+	 * hitting the locking section below.
 	 */
 	if (!dev->netdev_ops->ndo_set_tx_maxrate)
 		return -EOPNOTSUPP;
@@ -1419,18 +1424,19 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 	if (err < 0)
 		return err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(kobj, attr, dev);
 
 	err = -EOPNOTSUPP;
 	if (dev->netdev_ops->ndo_set_tx_maxrate)
 		err = dev->netdev_ops->ndo_set_tx_maxrate(dev, index, rate);
 
-	rtnl_unlock();
 	if (!err) {
 		queue->tx_maxrate = rate;
+		sysfs_rtnl_unlock(dev, kn);
 		return len;
 	}
+
+	sysfs_rtnl_unlock(dev, kn);
 	return err;
 }
 
@@ -1474,16 +1480,17 @@ static ssize_t bql_set(const char *buf, const size_t count,
 	return count;
 }
 
-static ssize_t bql_show_hold_time(struct netdev_queue *queue,
-				  char *buf)
+static ssize_t bql_show_hold_time(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->slack_hold_time));
 }
 
-static ssize_t bql_set_hold_time(struct netdev_queue *queue,
-				 const char *buf, size_t len)
+static ssize_t bql_set_hold_time(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, const char *buf,
+				 size_t len)
 {
 	struct dql *dql = &queue->dql;
 	unsigned int value;
@@ -1502,8 +1509,8 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
 	= __ATTR(hold_time, 0644,
 		 bql_show_hold_time, bql_set_hold_time);
 
-static ssize_t bql_show_inflight(struct netdev_queue *queue,
-				 char *buf)
+static ssize_t bql_show_inflight(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1514,13 +1521,16 @@ static struct netdev_queue_attribute bql_inflight_attribute __ro_after_init =
 	__ATTR(inflight, 0444, bql_show_inflight, NULL);
 
 #define BQL_ATTR(NAME, FIELD)						\
-static ssize_t bql_show_ ## NAME(struct netdev_queue *queue,		\
-				 char *buf)				\
+static ssize_t bql_show_ ## NAME(struct kobject *kobj,			\
+				 struct attribute *attr,		\
+				 struct netdev_queue *queue, char *buf)	\
 {									\
 	return bql_show(buf, queue->dql.FIELD);				\
 }									\
 									\
-static ssize_t bql_set_ ## NAME(struct netdev_queue *queue,		\
+static ssize_t bql_set_ ## NAME(struct kobject *kobj,			\
+				struct attribute *attr,			\
+				struct netdev_queue *queue,		\
 				const char *buf, size_t len)		\
 {									\
 	return bql_set(buf, len, &queue->dql.FIELD);			\
@@ -1600,9 +1610,11 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
 	return len < PAGE_SIZE ? len : -EINVAL;
 }
 
-static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_cpus_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
+	struct kernfs_node *kn;
 	unsigned int index;
 	int len, tc;
 
@@ -1611,32 +1623,34 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(kobj, attr, queue->dev);
 
 	/* If queue belongs to subordinate dev use its map */
 	dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
 
 	tc = netdev_txq_to_tc(dev, index);
 	if (tc < 0) {
-		rtnl_unlock();
+		sysfs_rtnl_unlock(queue->dev, kn);
 		return -EINVAL;
 	}
 
-	/* Make sure the subordinate device can't be freed */
-	get_device(&dev->dev);
-	rtnl_unlock();
+	/* Do not release the net device refcnt to make sure it won't be freed
+	 * while xps_queue_show is running.
+	 */
+	__sysfs_rtnl_unlock(queue->dev, kn);
 
 	len = xps_queue_show(dev, index, tc, buf, XPS_CPUS);
 
-	put_device(&dev->dev);
+	dev_put(dev);
 	return len;
 }
 
-static ssize_t xps_cpus_store(struct netdev_queue *queue,
-			      const char *buf, size_t len)
+static ssize_t xps_cpus_store(struct kobject *kobj, struct attribute *attr,
+			      struct netdev_queue *queue, const char *buf,
+			      size_t len)
 {
 	struct net_device *dev = queue->dev;
+	struct kernfs_node *kn;
 	unsigned int index;
 	cpumask_var_t mask;
 	int err;
@@ -1658,13 +1672,9 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
-		free_cpumask_var(mask);
-		return restart_syscall();
-	}
-
+	kn = sysfs_rtnl_lock(kobj, attr, dev);
 	err = netif_set_xps_queue(dev, mask, index);
-	rtnl_unlock();
+	sysfs_rtnl_unlock(dev, kn);
 
 	free_cpumask_var(mask);
 
@@ -1674,30 +1684,37 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init
 	= __ATTR_RW(xps_cpus);
 
-static ssize_t xps_rxqs_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_rxqs_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
+	struct kernfs_node *kn;
 	unsigned int index;
-	int tc;
+	int tc, ret;
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	kn = sysfs_rtnl_lock(kobj, attr, dev);
 
 	tc = netdev_txq_to_tc(dev, index);
-	rtnl_unlock();
-	if (tc < 0)
-		return -EINVAL;
 
-	return xps_queue_show(dev, index, tc, buf, XPS_RXQS);
+	/* Do not release the net device refcnt to make sure it won't be freed
+	 * while xps_queue_show is running.
+	 */
+	__sysfs_rtnl_unlock(dev, kn);
+
+	ret = tc >= 0 ? xps_queue_show(dev, index, tc, buf, XPS_RXQS) : -EINVAL;
+	dev_put(dev);
+	return ret;
 }
 
-static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
+static ssize_t xps_rxqs_store(struct kobject *kobj, struct attribute *attr,
+			      struct netdev_queue *queue, const char *buf,
 			      size_t len)
 {
 	struct net_device *dev = queue->dev;
 	struct net *net = dev_net(dev);
+	struct kernfs_node *kn;
 	unsigned long *mask;
 	unsigned int index;
 	int err;
@@ -1717,16 +1734,13 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
-		bitmap_free(mask);
-		return restart_syscall();
-	}
+	kn = sysfs_rtnl_lock(kobj, attr, dev);
 
 	cpus_read_lock();
 	err = __netif_set_xps_queue(dev, mask, index, XPS_RXQS);
 	cpus_read_unlock();
 
-	rtnl_unlock();
+	sysfs_rtnl_unlock(dev, kn);
 
 	bitmap_free(mask);
 	return err ? : len;
-- 
2.41.0


