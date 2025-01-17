Return-Path: <netdev+bounces-159224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB0A14D82
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554EC188C132
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DD1FBC91;
	Fri, 17 Jan 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFQplOt+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601D1FA8F1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109584; cv=none; b=TKKCy1c0P13MfbWCF1p8y1ri+VBxxBm5jvy32WVbQb4IHiGH0Qp9Lfr2av33bFkehBReV1bca87dJMXvv1DxWV2vETXo3oDM4aQ2YNZt12Os/3qnQVUgm+CjKqulI6nAWu1/cAjYBkU6aPFSHxltJ2DexOlhSDRM6itDy0xt/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109584; c=relaxed/simple;
	bh=q/nPLsVOYxeL5qttkNNddLGabW2kjOtsP2g4ktMMJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeOl+LBwgFPFoXwW/7mz3idHmpvHhBOR3rf+hg0NXPRtjF8tLS5UPOuKXOZOhkTfYKwALQdvGLY4Amt6A8gDN7irLXaReSzm2o/0J/gUoG6Hvo/GLRqimPKI0YFgLZQ1N/qrQ6Yw/oPNIiJbxbCOsnhvc6VyWJptMnMr1cbqItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFQplOt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503DCC4CEDD;
	Fri, 17 Jan 2025 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737109583;
	bh=q/nPLsVOYxeL5qttkNNddLGabW2kjOtsP2g4ktMMJzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFQplOt+Ss6IJfPb8K4hVPUKfq5LlQCG53EP+BgNc7P56E1HumoKmeVINII5EvsK9
	 TYcD6N8wzopLrqDroYr2AOSwQCsFoSgexw1WDSh11CPzXmA6vNpyrKor4IxSDrve/d
	 tlEg8P9xaBmtPQSOUyyqXXoL/SY4fD/XNeEgP4R5UnzzLWltaU9/yRA6MnpbIaMWph
	 iCPVq3jGRl4L4FCGWjhgxjMZluEEsbpIori8Zkso4HBH2AQAVRywmRWz+rI29ZE7/W
	 qZ+kuHRaAGQ+Swe1aJcTVpMabuxhk43tiVNZwFNsTSdkYAvYt4y96gANI4Mf5faJOX
	 +KYxU2qgzXA0Q==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] net-sysfs: move queue attribute groups outside the default groups
Date: Fri, 17 Jan 2025 11:26:09 +0100
Message-ID: <20250117102612.132644-3-atenart@kernel.org>
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
 net/core/net-sysfs.c          | 27 +++++++++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8308d9c75918..a8e3a414893b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -657,6 +657,7 @@ struct netdev_queue {
 	struct Qdisc __rcu	*qdisc_sleeping;
 #ifdef CONFIG_SYSFS
 	struct kobject		kobj;
+	const struct attribute_group	**groups;
 #endif
 	unsigned long		tx_maxrate;
 	/*
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 596836abf7bf..af40842f229d 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -16,6 +16,7 @@ struct netdev_rx_queue {
 	struct rps_dev_flow_table __rcu	*rps_flow_table;
 #endif
 	struct kobject			kobj;
+	const struct attribute_group	**groups;
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e012234c739a..0b7ee260613d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1188,7 +1188,6 @@ static void rx_queue_get_ownership(const struct kobject *kobj,
 static const struct kobj_type rx_queue_ktype = {
 	.sysfs_ops = &rx_queue_sysfs_ops,
 	.release = rx_queue_release,
-	.default_groups = rx_queue_default_groups,
 	.namespace = rx_queue_namespace,
 	.get_ownership = rx_queue_get_ownership,
 };
@@ -1222,20 +1221,27 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
 	if (error)
-		goto err;
+		goto err_default_groups;
 
 	kobject_uevent(kobj, KOBJ_ADD);
 
 	return error;
 
+err_default_groups:
+	sysfs_remove_groups(kobj, queue->groups);
 err:
 	kobject_put(kobj);
 	return error;
@@ -1280,12 +1286,14 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
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
 
@@ -1872,7 +1880,6 @@ static void netdev_queue_get_ownership(const struct kobject *kobj,
 static const struct kobj_type netdev_queue_ktype = {
 	.sysfs_ops = &netdev_queue_sysfs_ops,
 	.release = netdev_queue_release,
-	.default_groups = netdev_queue_default_groups,
 	.namespace = netdev_queue_namespace,
 	.get_ownership = netdev_queue_get_ownership,
 };
@@ -1902,15 +1909,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		goto err;
 
+	queue->groups = netdev_queue_default_groups;
+	error = sysfs_create_groups(kobj, queue->groups);
+	if (error)
+		goto err;
+
 	if (netdev_uses_bql(dev)) {
 		error = sysfs_create_group(kobj, &dql_group);
 		if (error)
-			goto err;
+			goto err_default_groups;
 	}
 
 	kobject_uevent(kobj, KOBJ_ADD);
 	return 0;
 
+err_default_groups:
+	sysfs_remove_groups(kobj, queue->groups);
 err:
 	kobject_put(kobj);
 	return error;
@@ -1965,6 +1979,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 		if (netdev_uses_bql(dev))
 			sysfs_remove_group(&queue->kobj, &dql_group);
 
+		sysfs_remove_groups(&queue->kobj, queue->groups);
 		kobject_put(&queue->kobj);
 	}
 
-- 
2.48.0


