Return-Path: <netdev+bounces-162654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00AA277C6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1CF3A849D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75DD21639F;
	Tue,  4 Feb 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXlfXtjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295621639B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688613; cv=none; b=eHEz/I/LjH8gyK/3WAM9fpf6xY6+Dw/pkuQAAZ0+wSdN1VF4Oen5CfcoezsVGBrKRYXWR94fJX2UV4M3KOUxm6NKXOc6bPfok1OAyPQc8gl02nTOyizKz00KnXAS0qrRcNW8u37/gt//ttfo7g2/o0PsSPunsAgsDTm+4hlvUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688613; c=relaxed/simple;
	bh=Djsqh69Z7pgmV4ptpurN29HxZrX1GMDuwPe3a5AhwhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx96K9AMlmCKmXng0fFboTSlwfy8ZVd6vlAAmQEPCCSn5W5UVesel3lltv9J90IKKdzDZF1AXfIFxUk8Wa1MSuuLTHm3Oe2Y3WtomQf5DxiL3zBnuWURbvccvoc49E4QtC51LARg00CU8o6yHNGDIemyCNjs+wOa0iqGtdk5kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXlfXtjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EF1C4CEDF;
	Tue,  4 Feb 2025 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688613;
	bh=Djsqh69Z7pgmV4ptpurN29HxZrX1GMDuwPe3a5AhwhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXlfXtjYTR3py0XSYL7rQKO/Eb+cgWADURw1f2QbB3vDDFO68tWuFZEFToPmwIkVy
	 Ev38XNFePMIm6FFHLksjMQKTaqELN/Wt0znf4jVfGpe1nnVa2CYQWq8lHwk+NxLP1p
	 Pr9iitJwte8+brwZSlZvlj/yKU3rfX3hwupNNPXCzYDlsWvZ6mFsCgTn0zqVG9gPt2
	 IpTj/qZ5kCSyZSXJetoYE/AT3zPXIlQf4E+JYXb8XM8nVdni6Pqehg6waQKKUsuA4u
	 D6aY8eAHWWoCXQJje9QjXQdUN9u2fboDWYSdnHDUDL/MqZk4VCUDHp2ANtUHOoO75d
	 wMESOmZwPLKtg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net-sysfs: remove rtnl_trylock from queue attributes
Date: Tue,  4 Feb 2025 18:03:13 +0100
Message-ID: <20250204170314.146022-5-atenart@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204170314.146022-1-atenart@kernel.org>
References: <20250204170314.146022-1-atenart@kernel.org>
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
 net/core/net-sysfs.c | 147 ++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 58 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 027af27517fa..3fe2c521e574 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1348,9 +1348,11 @@ static int net_rx_queue_change_owner(struct net_device *dev, int num,
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
@@ -1367,7 +1369,7 @@ static ssize_t netdev_queue_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	return attribute->show(queue, buf);
+	return attribute->show(kobj, attr, queue, buf);
 }
 
 static ssize_t netdev_queue_attr_store(struct kobject *kobj,
@@ -1381,7 +1383,7 @@ static ssize_t netdev_queue_attr_store(struct kobject *kobj,
 	if (!attribute->store)
 		return -EIO;
 
-	return attribute->store(queue, buf, count);
+	return attribute->store(kobj, attr, queue, buf, count);
 }
 
 static const struct sysfs_ops netdev_queue_sysfs_ops = {
@@ -1389,7 +1391,8 @@ static const struct sysfs_ops netdev_queue_sysfs_ops = {
 	.store = netdev_queue_attr_store,
 };
 
-static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
+static ssize_t tx_timeout_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	unsigned long trans_timeout = atomic_long_read(&queue->trans_timeout);
 
@@ -1407,18 +1410,18 @@ static unsigned int get_netdev_queue_index(struct netdev_queue *queue)
 	return i;
 }
 
-static ssize_t traffic_class_show(struct netdev_queue *queue,
-				  char *buf)
+static ssize_t traffic_class_show(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
-	int num_tc, tc;
-	int index;
+	int num_tc, tc, index, ret;
 
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, queue->dev);
+	if (ret)
+		return ret;
 
 	index = get_netdev_queue_index(queue);
 
@@ -1445,24 +1448,25 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
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
 	u32 rate = 0;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	/* The check is also done later; this helps returning early without
-	 * hitting the trylock/restart below.
+	 * hitting the locking section below.
 	 */
 	if (!dev->netdev_ops->ndo_set_tx_maxrate)
 		return -EOPNOTSUPP;
@@ -1471,18 +1475,21 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 	if (err < 0)
 		return err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err)
+		return err;
 
 	err = -EOPNOTSUPP;
 	if (dev->netdev_ops->ndo_set_tx_maxrate)
 		err = dev->netdev_ops->ndo_set_tx_maxrate(dev, index, rate);
 
-	rtnl_unlock();
 	if (!err) {
 		queue->tx_maxrate = rate;
+		rtnl_unlock();
 		return len;
 	}
+
+	rtnl_unlock();
 	return err;
 }
 
@@ -1526,16 +1533,17 @@ static ssize_t bql_set(const char *buf, const size_t count,
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
@@ -1554,15 +1562,17 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
 	= __ATTR(hold_time, 0644,
 		 bql_show_hold_time, bql_set_hold_time);
 
-static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_thrs(struct kobject *kobj, struct attribute *attr,
+				   struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
 }
 
-static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
-				  const char *buf, size_t len)
+static ssize_t bql_set_stall_thrs(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, const char *buf,
+				  size_t len)
 {
 	struct dql *dql = &queue->dql;
 	unsigned int value;
@@ -1588,13 +1598,15 @@ static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
 static struct netdev_queue_attribute bql_stall_thrs_attribute __ro_after_init =
 	__ATTR(stall_thrs, 0644, bql_show_stall_thrs, bql_set_stall_thrs);
 
-static ssize_t bql_show_stall_max(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_max(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	return sysfs_emit(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
 }
 
-static ssize_t bql_set_stall_max(struct netdev_queue *queue,
-				 const char *buf, size_t len)
+static ssize_t bql_set_stall_max(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, const char *buf,
+				 size_t len)
 {
 	WRITE_ONCE(queue->dql.stall_max, 0);
 	return len;
@@ -1603,7 +1615,8 @@ static ssize_t bql_set_stall_max(struct netdev_queue *queue,
 static struct netdev_queue_attribute bql_stall_max_attribute __ro_after_init =
 	__ATTR(stall_max, 0644, bql_show_stall_max, bql_set_stall_max);
 
-static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_cnt(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1613,8 +1626,8 @@ static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
 static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =
 	__ATTR(stall_cnt, 0444, bql_show_stall_cnt, NULL);
 
-static ssize_t bql_show_inflight(struct netdev_queue *queue,
-				 char *buf)
+static ssize_t bql_show_inflight(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1625,13 +1638,16 @@ static struct netdev_queue_attribute bql_inflight_attribute __ro_after_init =
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
@@ -1717,19 +1733,21 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
 	return len < PAGE_SIZE ? len : -EINVAL;
 }
 
-static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_cpus_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
 	unsigned int index;
-	int len, tc;
+	int len, tc, ret;
 
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, queue->dev);
+	if (ret)
+		return ret;
 
 	/* If queue belongs to subordinate dev use its map */
 	dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
@@ -1740,18 +1758,21 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
 		return -EINVAL;
 	}
 
-	/* Make sure the subordinate device can't be freed */
-	get_device(&dev->dev);
+	/* Increase the net device refcnt to make sure it won't be freed while
+	 * xps_queue_show is running.
+	 */
+	dev_hold(dev);
 	rtnl_unlock();
 
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
 	unsigned int index;
@@ -1775,9 +1796,10 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err) {
 		free_cpumask_var(mask);
-		return restart_syscall();
+		return err;
 	}
 
 	err = netif_set_xps_queue(dev, mask, index);
@@ -1791,26 +1813,34 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init
 	= __ATTR_RW(xps_cpus);
 
-static ssize_t xps_rxqs_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_rxqs_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
 	unsigned int index;
-	int tc;
+	int tc, ret;
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, dev);
+	if (ret)
+		return ret;
 
 	tc = netdev_txq_to_tc(dev, index);
+
+	/* Increase the net device refcnt to make sure it won't be freed while
+	 * xps_queue_show is running.
+	 */
+	dev_hold(dev);
 	rtnl_unlock();
-	if (tc < 0)
-		return -EINVAL;
 
-	return xps_queue_show(dev, index, tc, buf, XPS_RXQS);
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
@@ -1834,9 +1864,10 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err) {
 		bitmap_free(mask);
-		return restart_syscall();
+		return err;
 	}
 
 	cpus_read_lock();
-- 
2.48.1


