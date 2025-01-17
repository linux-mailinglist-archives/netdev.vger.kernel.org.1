Return-Path: <netdev+bounces-159226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71FA14D84
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A915168AC8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB451FC7F7;
	Fri, 17 Jan 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br5BZtgW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C21FA8EB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109591; cv=none; b=YpDpIqQIbLwBuNKfEEw0bMCHbT/NP1WcctfzpfsmntY27GPIFH6NX9Mh4KzCayvkS9N0GzMst5TxlIvKiICjhFTFseaiVZeL0AJFD5sUVBLCuYOkPvk/I/wpI5HKrXt2T/nPy4dwiMMS20NrApAAwkkLVVRjcuQFdeKmyj4aUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109591; c=relaxed/simple;
	bh=gjEm9ltXelpyXEKkLangT7YUFPyWS4BTKE4NvDDwMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjcS1LQq6OlOaB6Qv7C/TBDD9HbL34jIkRo2zKDklSurmx95m8jyXvubi2jG0DoNuipC+q9C8RHGEjZpo7GEHeZYaV/BpsKvpPB1dDWfq5R5Zagg5QdU2q7mvXrDy6TG7HmhkJCrP8X15wZGLRA1HvR9UBWDCBXl8bOkI6g7Idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br5BZtgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E9EC4CEDD;
	Fri, 17 Jan 2025 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737109591;
	bh=gjEm9ltXelpyXEKkLangT7YUFPyWS4BTKE4NvDDwMsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=br5BZtgW1la2Z70YG7jI7K/co74z2jOxW97y/SP7n9oyjVe3SnQKH21lkz8RCozlr
	 vM0iM/qWp9vDaVLymgk9AY+1OkdOD0Tooz05rIzoY2nXhBFaVYmQi0oVubPp1RA1rp
	 kri/qgjaBvcdNEuOeHaUA+uJYxlLCu/UnUbvaqPsb/eE1qUyEeo89nbJZ9AR5zUo4l
	 4SUnjH8DKmB8xw/NEtYeDBWDGPmI+IlvHbeBBVAPnemN6dhNv7n95qmfqkBOC16UeG
	 l74AXUM2sbR6ndkcuesAflnLikBZltVgpozFVl1Xi0PJCMxwZmDT8HS6NfNBTz6tOr
	 rWHIAskqaD+AQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] net-sysfs: remove rtnl_trylock from queue attributes
Date: Fri, 17 Jan 2025 11:26:11 +0100
Message-ID: <20250117102612.132644-5-atenart@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117102612.132644-1-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
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
index fdfcc91c3412..fbedc1876dc6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1346,9 +1346,11 @@ static int net_rx_queue_change_owner(struct net_device *dev, int num,
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
@@ -1365,7 +1367,7 @@ static ssize_t netdev_queue_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	return attribute->show(queue, buf);
+	return attribute->show(kobj, attr, queue, buf);
 }
 
 static ssize_t netdev_queue_attr_store(struct kobject *kobj,
@@ -1379,7 +1381,7 @@ static ssize_t netdev_queue_attr_store(struct kobject *kobj,
 	if (!attribute->store)
 		return -EIO;
 
-	return attribute->store(queue, buf, count);
+	return attribute->store(kobj, attr, queue, buf, count);
 }
 
 static const struct sysfs_ops netdev_queue_sysfs_ops = {
@@ -1387,7 +1389,8 @@ static const struct sysfs_ops netdev_queue_sysfs_ops = {
 	.store = netdev_queue_attr_store,
 };
 
-static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
+static ssize_t tx_timeout_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	unsigned long trans_timeout = atomic_long_read(&queue->trans_timeout);
 
@@ -1405,18 +1408,18 @@ static unsigned int get_netdev_queue_index(struct netdev_queue *queue)
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
 
@@ -1443,24 +1446,25 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
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
@@ -1469,18 +1473,21 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
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
 
@@ -1524,16 +1531,17 @@ static ssize_t bql_set(const char *buf, const size_t count,
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
@@ -1552,15 +1560,17 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
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
@@ -1586,13 +1596,15 @@ static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
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
@@ -1601,7 +1613,8 @@ static ssize_t bql_set_stall_max(struct netdev_queue *queue,
 static struct netdev_queue_attribute bql_stall_max_attribute __ro_after_init =
 	__ATTR(stall_max, 0644, bql_show_stall_max, bql_set_stall_max);
 
-static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_cnt(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1611,8 +1624,8 @@ static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
 static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =
 	__ATTR(stall_cnt, 0444, bql_show_stall_cnt, NULL);
 
-static ssize_t bql_show_inflight(struct netdev_queue *queue,
-				 char *buf)
+static ssize_t bql_show_inflight(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1623,13 +1636,16 @@ static struct netdev_queue_attribute bql_inflight_attribute __ro_after_init =
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
@@ -1715,19 +1731,21 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
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
@@ -1738,18 +1756,21 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
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
@@ -1773,9 +1794,10 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
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
@@ -1789,26 +1811,34 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
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
@@ -1832,9 +1862,10 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
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
2.48.0


