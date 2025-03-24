Return-Path: <netdev+bounces-177264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A52A6E6C6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F473B4ADC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040641F0E22;
	Mon, 24 Mar 2025 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csBjWbni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E1F03FF
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856386; cv=none; b=htn3eagqI+ywJ+FHrlaQirzAHHVZCincWdsYEKTSwe8niis1JCO4A3y1eWtkOuqzS7AvXG27yyGAD6I46V4G3lq/jIImK5vEawedgLdCe+yXpJzORnfD96ah41S454wA2JPeRi8Y6xwCooS8FwV8fe+aRuhUaBxCvZOWKpDv71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856386; c=relaxed/simple;
	bh=h/mtOsvuECjaC2R3nd+Z9hHhktziYVYcFtpdVFN4gH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urL6ujg1PFx/JMXzTs7VcDOmYpnpTtKbhqrb8SI73niFMA5kVx3j6S6k7fKFs/JF1g83rIw0XDE6sFMh3gdZRB/5HuQpLJ43Q8g5BZyxqmBrJ6kQ55P8W4v2Y92PSBG5ph4oN0K57VbDQQ7ym25yfQoTwfp4NrY341TkeJ9PbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csBjWbni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A0C4CEE4;
	Mon, 24 Mar 2025 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856386;
	bh=h/mtOsvuECjaC2R3nd+Z9hHhktziYVYcFtpdVFN4gH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csBjWbnimDkkBjUFvUpvtUcbx9cVVPZOwoBwk02oQovW2wZGMQEPgryeKpeRWycvc
	 kBWilUySjMRKXkAWYXyTcgbLe81hQwsaAdK0xN1Oh8L0Eu48TIO1SnzvBMW69OzVj/
	 R8v4hNWge93XNo/qJSAkrzQ0s2Jk8z6fPoASTR08YuollMWNZhck57k6dQLcRNK/GC
	 pIYN8v/dYtO8vd8iQuUOUtDP19BDVOSQq25RWvLI887RYxeXEjCRrMZg5kBrkbKBMZ
	 sCLnmEObBSE3a6RdJY1atWrUag9VRlEY2ryP/XDfw8ZbNT/QSTxoB4Q0LxTJDPpU3i
	 VaqaLIwog2ftg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 10/11] netdev: add "ops compat locking" helpers
Date: Mon, 24 Mar 2025 15:45:36 -0700
Message-ID: <20250324224537.248800-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
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
 include/net/netdev_lock.h | 16 +++++++++++++
 net/core/dev.h            | 15 ++++++++++++
 net/core/dev.c            | 49 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 1c0c9a94cc22..76cbf5a449b6 100644
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
index 7ee203395d8e..c4b645120d72 100644
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
index 7bd8bd82f66f..01139d8ef840 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1051,6 +1051,18 @@ struct net_device *__netdev_put_lock(struct net_device *dev)
 	return dev;
 }
 
+static struct net_device *__netdev_put_lock_ops_compat(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+	if (dev->reg_state > NETREG_REGISTERED) {
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
@@ -1073,6 +1085,18 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev);
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
+	return __netdev_put_lock_ops_compat(dev);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -1098,6 +1122,31 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
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
+		dev = __netdev_put_lock_ops_compat(dev);
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


