Return-Path: <netdev+bounces-42298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2BB7CE19E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2DD281D0B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD43B7B4;
	Wed, 18 Oct 2023 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCcOTB1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E94BE62
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E529BC433C9;
	Wed, 18 Oct 2023 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644093;
	bh=8VrO2XK6EPwuECvMc1tWMEmYMKy93Q5HNAycs9pP93s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCcOTB1QYCXzh/jiRSbGrVTUij8t4W14ORWbFP6JYNmc+cPC7SwHl3YfuWtjiUIUq
	 MkKCP51lXkrC10AqA5s/UkLlgRi2W3E6oq6DOWv5LleswHInt9z7nNxJsam3h2Y37l
	 J66Ql33hxWwkiO1TBSvNr9CdwVDuxB4f4Ivx0M6BLgWcOnt7i/fofZOXRu4XUg7dbw
	 +yINFhlQzy/ndRE2V2516N6wRcKyKLsYk/1e/P6GJ6hXecmScPk7SwiqdGIMWsPRGs
	 ogFhCevNZsaLj/3fmwhdKGzLzid2AdmMtix+b0qhzsMpErx2rg7e45WkJ8l7Rqmf6S
	 mTqmMmdUz4LBA==
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
Subject: [RFC PATCH net-next 2/4] net-sysfs: move queue attribute groups outside the default groups
Date: Wed, 18 Oct 2023 17:47:44 +0200
Message-ID: <20231018154804.420823-3-atenart@kernel.org>
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

Rx/tx queues embed their own kobject for registering their per-queue
sysfs files. The issue is they're using the kobject default groups for
this and entirely rely on the kobject refcounting for releasing their
sysfs paths.

In order to remove rtnl_trylock calls we need sysfs files not to rely on
their associated kobject refcounting for their release. Thus we here
move queues sysfs files from the kobject default groups to their own
groups which can be removed separately.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 include/linux/netdevice.h     |  1 +
 include/net/netdev_rx_queue.h |  1 +
 net/core/net-sysfs.c          | 27 ++++++++++++++++++++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c7681263d30..90fa1aa93155 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -626,6 +626,7 @@ struct netdev_queue {
 	struct Qdisc __rcu	*qdisc_sleeping;
 #ifdef CONFIG_SYSFS
 	struct kobject		kobj;
+	const struct attribute_group	**groups;
 #endif
 #if defined(CONFIG_XPS) && defined(CONFIG_NUMA)
 	int			numa_node;
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..b77bbc027176 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -15,6 +15,7 @@ struct netdev_rx_queue {
 	struct rps_dev_flow_table __rcu	*rps_flow_table;
 #endif
 	struct kobject			kobj;
+	const struct attribute_group	**groups;
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 76d8729340b7..a9f712ef9925 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1138,7 +1138,6 @@ static void rx_queue_get_ownership(const struct kobject *kobj,
 static const struct kobj_type rx_queue_ktype = {
 	.sysfs_ops = &rx_queue_sysfs_ops,
 	.release = rx_queue_release,
-	.default_groups = rx_queue_default_groups,
 	.namespace = rx_queue_namespace,
 	.get_ownership = rx_queue_get_ownership,
 };
@@ -1172,10 +1171,15 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		goto err;
 
+	queue->groups = rx_queue_default_groups;
+	error = sysfs_create_groups(kobj, queue->groups);
+	if (error)
+		goto err;
+
 	if (dev->sysfs_rx_queue_group) {
 		error = sysfs_create_group(kobj, dev->sysfs_rx_queue_group);
 		if (error)
-			goto err;
+			goto err_default_groups;
 	}
 
 	error = rx_queue_default_mask(dev, queue);
@@ -1186,6 +1190,8 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 
 	return error;
 
+err_default_groups:
+	sysfs_remove_groups(kobj, queue->groups);
 err:
 	kobject_put(kobj);
 	return error;
@@ -1230,12 +1236,14 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 	}
 
 	while (--i >= new_num) {
-		struct kobject *kobj = &dev->_rx[i].kobj;
+		struct netdev_rx_queue *queue = &dev->_rx[i];
+		struct kobject *kobj = &queue->kobj;
 
 		if (!refcount_read(&dev_net(dev)->ns.count))
 			kobj->uevent_suppress = 1;
 		if (dev->sysfs_rx_queue_group)
 			sysfs_remove_group(kobj, dev->sysfs_rx_queue_group);
+		sysfs_remove_groups(kobj, queue->groups);
 		kobject_put(kobj);
 	}
 
@@ -1757,7 +1765,6 @@ static void netdev_queue_get_ownership(const struct kobject *kobj,
 static const struct kobj_type netdev_queue_ktype = {
 	.sysfs_ops = &netdev_queue_sysfs_ops,
 	.release = netdev_queue_release,
-	.default_groups = netdev_queue_default_groups,
 	.namespace = netdev_queue_namespace,
 	.get_ownership = netdev_queue_get_ownership,
 };
@@ -1779,15 +1786,24 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		goto err;
 
+	queue->groups = netdev_queue_default_groups;
+	error = sysfs_create_groups(kobj, queue->groups);
+	if (error)
+		goto err;
+
 #ifdef CONFIG_BQL
 	error = sysfs_create_group(kobj, &dql_group);
 	if (error)
-		goto err;
+		goto err_default_groups;
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);
 	return 0;
 
+#ifdef CONFIG_BQL
+err_default_groups:
+	sysfs_remove_groups(kobj, queue->groups);
+#endif
 err:
 	kobject_put(kobj);
 	return error;
@@ -1841,6 +1857,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 #ifdef CONFIG_BQL
 		sysfs_remove_group(&queue->kobj, &dql_group);
 #endif
+		sysfs_remove_groups(&queue->kobj, queue->groups);
 		kobject_put(&queue->kobj);
 	}
 
-- 
2.41.0


