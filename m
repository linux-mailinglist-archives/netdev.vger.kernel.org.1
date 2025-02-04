Return-Path: <netdev+bounces-162652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE2A277BF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692191886D76
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C0215773;
	Tue,  4 Feb 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0jTe/CX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A27214816
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688606; cv=none; b=ZYZ3Dt4HUkNEHWaa4olw+4A9cJHE/18/JfuxRpinw7+AoeY0t8q60u2j2mL3ubyRiVMmJq7ftSWHXx3mdSofzLhjSvCoM8gu7Pb2JiaWF8nbeSkwNKCBAcx6O3GUhUUZMUGtYnsatv41HK3W3v02ECClciy4yhfrdajR6zZHhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688606; c=relaxed/simple;
	bh=1mlZfp0WnCK2B1kUs5p+Pr2ojv5AGdf8ughBOUXzZto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHuQ83JUvxMK5NSgyhCMNYORGxbV3m4PuIHYUEtW5T/6zfFgNLx4KLt7n9SKTYgaGl3R0TgFqbvElmqcC8Fz+EyrM0NcM216mq4RyONBjVe237b8AhiYIWBViRLUELVXLPbBzrIpd4pXKJ6sz5V45qHO+oy9s50o33dPiofj8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0jTe/CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F994C4CEE2;
	Tue,  4 Feb 2025 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688606;
	bh=1mlZfp0WnCK2B1kUs5p+Pr2ojv5AGdf8ughBOUXzZto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0jTe/CX3WR8GQ4M/EzMTJkXhsGfyIFC7zYDw+MSDw3vCdmn8s9BnX6Im4MIyjkge
	 34InlDOnGW1pM/RDOo6KF/bT7L5Xp3uXazV5TDfUgOMqVkIYRo5PZV8m/17Pf9adql
	 NjvAayZz+T+IRyyXCXa7mVDh6lYYJnu63+U0lZgsSVG7V3NWyF1mFHkq1J8w8etlpx
	 WaLyYAcoeq8edoFe5cGlLF58BV8jx5H4By8kJDrXO08Gi1p6/ahp/nFpZNmDYs8pjO
	 S5wYHV4KDaps91IK40dlnCtuCI9W6IM7nkfhpVWrRh79rWEQiAPs1YKNVr6eu6MNYE
	 kMwhh6uEF7i0A==
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
Subject: [PATCH net-next v2 2/4] net-sysfs: move queue attribute groups outside the default groups
Date: Tue,  4 Feb 2025 18:03:11 +0100
Message-ID: <20250204170314.146022-3-atenart@kernel.org>
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
index 2a59034a5fa2..1dcc76af7520 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -658,6 +658,7 @@ struct netdev_queue {
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
2.48.1


