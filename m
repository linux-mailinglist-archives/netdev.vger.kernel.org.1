Return-Path: <netdev+bounces-179878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2DA7ECF8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93E1426F48
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486625C6EB;
	Mon,  7 Apr 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkIkFF9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315422172D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052480; cv=none; b=g/p0uTVUstntZQ/vmJ6RIKXBdqfujSkf9zgA7+Q4NdvdF4qGoLX8KfiEk1MFcrNo10Kb5WsqTc+zWpMC9L4gbT1rSc5evFWpzW2qHLHRmfbPVCMYiNAXTWEUUwfnSUqGLcZDRnm2LIL5IIM4KMqWDLfsZNMSz123ZLmpLhg5PI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052480; c=relaxed/simple;
	bh=+QbQmqZH10sakCr/POrniulCH44DF2n45krBGPyj0Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZR4XITf2UzwYdLu3zarK6OKpocg4Ucv4yp+0VdETtsuy271A1Fd00I6ePuet70YHa25vry/o1fDOGE+aRCBEF6HddGTZ8mL9Bep68M9m8NclDdeOzSfExg9oPABpiKwsTxFguc21XnMHfEPTcytnkYm9xgEURHEnfe24/UkvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkIkFF9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D761C4CEE9;
	Mon,  7 Apr 2025 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052479;
	bh=+QbQmqZH10sakCr/POrniulCH44DF2n45krBGPyj0Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkIkFF9x/8RnzKLXWyOHr5bf37tzjbuLXzCz1Wn5alGIz1lb1ezagX7Y14ccexIaF
	 NsS5kgljGCrlshvFNTGMRedOTdJN0COSy8yAqNEjMbTVbdi8uvNu/IBl9JjBNk3iMf
	 M23h1Qvgn+vrFh0rQHHwZnmjuZxE5pSC+mmaWq+5uIiDhkoN5/ZZcpgpdIadLE/6N7
	 j8ZWPQEeox2hUT7RW3kbt7k2Z0qE4Dgmdl21B1H4WKMBP3kA3DC1UkrPvvdwHB7zmN
	 ZD0JuyYQ/m8u+evaUNlQPHOGEUDpvYHwzJRYTdPgrJKAk8xj/z1MpHmrOpKmzNnCpQ
	 7sixwzJ5C5t1Q==
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
Subject: [PATCH net-next 3/8] netdev: add "ops compat locking" helpers
Date: Mon,  7 Apr 2025 12:01:12 -0700
Message-ID: <20250407190117.16528-4-kuba@kernel.org>
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

Add helpers to "lock a netdev in a backward-compatible way",
which for ops-locked netdevs will mean take the instance lock.
For drivers which haven't opted into the ops locking we'll take
rtnl_lock.

The scoped foreach is dropping and re-taking the lock for each
device, even if prev and next are both under rtnl_lock.
I hope that's fine since we expect that netdev nl to be mostly
supported by modern drivers, and modern drivers should also
opt into the instance locking.

Note that these helpers are mostly needed for queue related state,
because drivers modify queue config in their ops in a non-atomic
way. Or differently put, queue changes don't have a clear-cut API
like NAPI configuration. Any state that can should just use the
instance lock directly, not the "compat" hacks.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_lock.h | 16 ++++++++++++
 net/core/dev.h            | 15 ++++++++++++
 net/core/dev.c            | 51 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index c316b551df8d..5706835a660c 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -64,6 +64,22 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
 		netdev_ops_assert_locked(dev);
 }
 
+static inline void netdev_lock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+	else
+		rtnl_lock();
+}
+
+static inline void netdev_unlock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+	else
+		rtnl_unlock();
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
diff --git a/net/core/dev.h b/net/core/dev.h
index 3cc2d8787c83..3fd7847d6d60 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -41,6 +41,21 @@ DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
 	     (var_name = netdev_xa_find_lock(net, var_name, &ifindex)); \
 	     ifindex++)
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex);
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index);
+
+DEFINE_FREE(netdev_unlock_ops_compat, struct net_device *,
+	    if (_T) netdev_unlock_ops_compat(_T));
+
+#define for_each_netdev_lock_ops_compat_scoped(net, var_name, ifindex)	\
+	for (struct net_device *var_name __free(netdev_unlock_ops_compat) = NULL; \
+	     (var_name = netdev_xa_find_lock_ops_compat(net, var_name,	\
+							&ifindex));	\
+	     ifindex++)
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
diff --git a/net/core/dev.c b/net/core/dev.c
index 7060c3171cd8..baf615e0ae27 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1052,6 +1052,20 @@ struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net)
 	return dev;
 }
 
+static struct net_device *
+__netdev_put_lock_ops_compat(struct net_device *dev, struct net *net)
+{
+	netdev_lock_ops_compat(dev);
+	if (dev->reg_state > NETREG_REGISTERED ||
+	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
+		netdev_unlock_ops_compat(dev);
+		dev_put(dev);
+		return NULL;
+	}
+	dev_put(dev);
+	return dev;
+}
+
 /**
  *	netdev_get_by_index_lock() - find a device by its ifindex
  *	@net: the applicable net namespace
@@ -1074,6 +1088,18 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev, net);
 }
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
+{
+	struct net_device *dev;
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev)
+		return NULL;
+
+	return __netdev_put_lock_ops_compat(dev, net);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -1099,6 +1125,31 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
 	} while (true);
 }
 
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index)
+{
+	if (dev)
+		netdev_unlock_ops_compat(dev);
+
+	do {
+		rcu_read_lock();
+		dev = xa_find(&net->dev_by_index, index, ULONG_MAX, XA_PRESENT);
+		if (!dev) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		dev_hold(dev);
+		rcu_read_unlock();
+
+		dev = __netdev_put_lock_ops_compat(dev, net);
+		if (dev)
+			return dev;
+
+		(*index)++;
+	} while (true);
+}
+
 static DEFINE_SEQLOCK(netdev_rename_lock);
 
 void netdev_copy_name(struct net_device *dev, char *name)
-- 
2.49.0


