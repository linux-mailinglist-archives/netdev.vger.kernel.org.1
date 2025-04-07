Return-Path: <netdev+bounces-179881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E47A7ECC3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70999445BEE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0525D1E2;
	Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc2/5blT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754325C71D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052481; cv=none; b=KwxcQBFhVHp3axZZ9Oy18QmlaRUWNXeeVSdtsU1ZaY1msLMsQKDE/ZhS2W8swDM9ip7iJdTFCG5Xd5TjYeWBpSLkPTTk4jpPG5Bq2witdMyIkMxnA354KaG0yxLaXrDyUvZ9E9B2K/uj6lR3xw8aUD9zRLnah4MyO9iBb6OiIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052481; c=relaxed/simple;
	bh=bnY6roFw4wBUzLkKqV/QhjP+bqrrZdZbcwFS3O6/h/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGlUwYsbvHo8aD/JBFn0aVLrCsmWZ3mR6j02H5LPoUqzi+cKBgwvHUpDPnoL+SHiGFyPy0IxHhOfRpVTAYgiVF/eErmoOWBjbFK3A2bwfOVLqeTeyKQ+ZnQoGGCSVTmX+6nI8sRnhJtvP2ZcTp7bJh69I5qW0eBnbs0SlaRCxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc2/5blT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F5C4CEE7;
	Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052481;
	bh=bnY6roFw4wBUzLkKqV/QhjP+bqrrZdZbcwFS3O6/h/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc2/5blTCBjjRh72/eH3YyZhK1PFCKj9QFo/Zknbxf9s5vBwFLRvfEO0brjuj/S4A
	 XD71V9SOL715qvkCF+0nwEQ6mdmg7ZGG4ViCP2bJkk1scPHy6258esbE5NgTJQBM0Y
	 ONKqqcVKzr9duJsA2nEZtLW418HCQnBX9eNSJRAD8AhYg7j23rvHLSXV+7jkuA5QBW
	 qNwl9FT+XHLcmfPNoqL2PGCZG/gf8i7YzXPX4ZbYv1JOfdADayHj61nBETlaBKvdzH
	 HudCktPjFAFrD9n5r7Dt5nH/WgTzyNLTnZoDNoejNus8kpKmdEzI5s3YNiW9grAOBv
	 mSR2+pJxYNTkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com
Subject: [PATCH net-next 8/8] netdev: depend on netdev->lock for qstats in ops locked drivers
Date: Mon,  7 Apr 2025 12:01:17 -0700
Message-ID: <20250407190117.16528-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407190117.16528-1-kuba@kernel.org>
References: <20250407190117.16528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We mostly needed rtnl_lock in qstat to make sure the queue count
is stable while we work. For "ops locked" drivers the instance
lock protects the queue count, so we don't have to take rtnl_lock.

For currently ops-locked drivers: netdevsim and bnxt need
the protection from netdev going down while we dump, which
instance lock provides. gve doesn't care.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst |  6 +++++
 include/net/netdev_queues.h             |  4 +++-
 net/core/netdev-genl.c                  | 29 +++++++++++++++----------
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 0cfff56b436e..ec9d9a2cefe7 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -356,6 +356,12 @@ Similarly to ``ndos`` the instance lock is only held for select drivers.
 For "ops locked" drivers all ethtool ops without an exception should
 be called under the instance lock.
 
+struct netdev_stat_ops
+----------------------
+
+"qstat" ops are invoked under the instance lock for "ops locked" drivers,
+and under rtnl_lock for all other drivers.
+
 struct net_shaper_ops
 ---------------------
 
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 825141d675e5..ea709b59d827 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -85,9 +85,11 @@ struct netdev_queue_stats_tx {
  * for some of the events is not maintained, and reliable "total" cannot
  * be provided).
  *
+ * Ops are called under the instance lock if netdev_need_ops_lock()
+ * returns true, otherwise under rtnl_lock.
  * Device drivers can assume that when collecting total device stats,
  * the @get_base_stats and subsequent per-queue calls are performed
- * "atomically" (without releasing the rtnl_lock).
+ * "atomically" (without releasing the relevant lock).
  *
  * Device drivers are encouraged to reset the per-queue statistics when
  * number of queues change. This is because the primary use case for
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 8c58261de969..b64c614a00c4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -795,26 +795,31 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	if (info->attrs[NETDEV_A_QSTATS_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QSTATS_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
-		netdev = __dev_get_by_index(net, ifindex);
-		if (netdev && netdev->stat_ops) {
+		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
+		if (!netdev) {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
+			return -ENODEV;
+		}
+		if (netdev->stat_ops) {
 			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
 							    info, ctx);
 		} else {
 			NL_SET_BAD_ATTR(info->extack,
 					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
-			err = netdev ? -EOPNOTSUPP : -ENODEV;
-		}
-	} else {
-		for_each_netdev_dump(net, netdev, ctx->ifindex) {
-			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
-							    info, ctx);
-			if (err < 0)
-				break;
+			err = -EOPNOTSUPP;
 		}
+		netdev_unlock_ops_compat(netdev);
+		return err;
+	}
+
+	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
+		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
+						    info, ctx);
+		if (err < 0)
+			break;
 	}
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.49.0


