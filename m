Return-Path: <netdev+bounces-180465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91328A81635
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A6B189D5E8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7932459C5;
	Tue,  8 Apr 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhHEhBMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6C254845
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142409; cv=none; b=oGGP5l2fZPjltXMiGUPvN0rO2bXD1DJzXqf0b3wPY9/gEqYcRCTiXDCAtS1+pkfh8FLKYJGY7D4Li+J73ciGnCo/Ay3FPW70JbTlOGK1pPvvCjJPyMy93fiQPQjVDyZJrbYeON/LlqPTvh3q7RCEvpPXAd0iAwAHrKNziPZGHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142409; c=relaxed/simple;
	bh=HqJELTk/fzDR4MXGhZtQUNqBGMWacZrOt+4A7Bvs6Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onBY2gRch6ASwiWo8c4po5Fd5zWOirFtW28JV1RpFmU5QwLko+SMlvPD4BMH+ROGZW1fWC0Wao37jZishAdev2N5w6utui6yrjJBC678x4bS/g4M44MRzwvph+budXRgriM+6iOyN+6fLOSD+SnPZ7Qkh1jSZ2JgvsEMa+AdIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhHEhBMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DBEC4CEEA;
	Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142408;
	bh=HqJELTk/fzDR4MXGhZtQUNqBGMWacZrOt+4A7Bvs6Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhHEhBMMIu+SR9555ytbXaJGZ6aox58FEslOT/4biYniWcLbZFI9vNzdKs160z1Rc
	 nAyJ5dI+yVhtDgaGDHYipblS36r75t1eizjHa5CsRLPLcqq5iT4aa66Kz14UMwmWjX
	 f1A9+65BlgPclDRAexpXxXY+BimQAdhK49bC5qHrSFc759i99Yy8qTA7B9tY7ZCgY4
	 6IeodV8R4P9VSH3HdJd4A3PYvaAAOdaaNHlk2p0ubJ4fQJ5q8cpsly/F67KKiEqe8k
	 WBnW2g/9++TJqzhU8LG+jQKrxvmXlxoORDoykfd2geBIlF8A3emyojniSRsLMgB0Rm
	 7t8boH3MXM8ag==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/8] netdev: add "ops compat locking" helpers
Date: Tue,  8 Apr 2025 12:59:50 -0700
Message-ID: <20250408195956.412733-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
References: <20250408195956.412733-1-kuba@kernel.org>
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

Reviewed-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
index e7bf21f52fc7..e93f36b7ddf3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -42,6 +42,21 @@ DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
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
index 8c13e5339cc9..b52efa4cec56 100644
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


