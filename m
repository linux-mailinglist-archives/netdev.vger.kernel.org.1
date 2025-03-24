Return-Path: <netdev+bounces-177258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A4A6E6BF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C4C175434
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86E1EF368;
	Mon, 24 Mar 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp9YVRgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5C1DFD8B
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856364; cv=none; b=TVMvpwSEQ3fSuVytbVEg8CoFob1UsVe/t23tT8GdEdZMxR7lBIYFCvjrGXMm4udOlTYVPxc/cM133H8IB3ipU3GRX8f+UfirjCRdWr8iEUVHqOAu5xQL6y/4TqMamu+kNrtcMa0svmDPzoQPeDNuZGLRbDTXBqNLF5jhPQgDS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856364; c=relaxed/simple;
	bh=fze7toAYLrwXIQgj4K9hYHKNQagZ6zZ8bnnevx9Ngwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG5s9DcUHaQTGbycY+n9ktKJyTqXzWGxxH4BuXJM36n3X6B0oV7xSeL0+o7l0m045YOUeGDw7sThC2ZGZ2fqoA6mDjtNz4FZ6qOFKA1YHVp2vyRArTax5oKp59hEZG9rDngtJo6BLNCIltzFoJBf0gin5RbdKxr13r0c25RcO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp9YVRgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6673AC4CEDD;
	Mon, 24 Mar 2025 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856364;
	bh=fze7toAYLrwXIQgj4K9hYHKNQagZ6zZ8bnnevx9Ngwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hp9YVRgJrAdfxonWg/1ztkT9w6osGK/9hlvOUgMBXK+q6oRZXxcAVr2gXx39GOgAD
	 2Lv8rn/1Aj46kcGsc5w39OK+s9lYPqs1dzbO82d98hWeGVoIyIjRgh0GPw4IuBD1Rt
	 zE0uanoB6oO17zJDpbPFdkc/C9vrCk0k1SHeE18luYbGRIJXc4i5ZHB9FfNuD+Y0J2
	 V9oHljk/1VGugdzLh2bfxpXW3w5Fxyji2q/K63OTYqvyCtTm2PtKQkvVfxVbLElhXw
	 8hOoNDayu+pWYfmc6vrLRYHnJdyIAYG+QTm8pCAKNix5X/0piNGQmfInzndueWMZrS
	 4oDXuEji1Er1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/11] net: explain "protection types" for the instance lock
Date: Mon, 24 Mar 2025 15:45:30 -0700
Message-ID: <20250324224537.248800-5-kuba@kernel.org>
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

Try to define some terminology for which fields are protected
by which lock and how. Some fields are protected by both rtnl_lock
and instance lock which is hard to talk about without having
a "key phrase" to refer to a particular protection scheme.

"ops protected" fields are defined later in the series, one by one.

Add ASSERT_RTNL() to netdev_ops_assert_locked() for drivers
not other instance protection of ops. Hopefully it's not too
confusion that netdev_lock_ops() does not match the lock which
netdev_ops_assert_locked() will assert, exactly. The noun "ops"
is in a different place in the name, so I think it's acceptable...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 24 ++++++++++++++++++------
 include/net/netdev_lock.h |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 55859c565f84..09773e5c109a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2496,19 +2496,31 @@ struct net_device {
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
 	 * Drivers are free to use it for other protection.
 	 *
-	 * Protects:
+	 * For the drivers that implement shaper or queue API, the scope
+	 * of this lock is expanded to cover most ndo/queue/ethtool/sysfs
+	 * operations. Drivers may opt-in to this behavior by setting
+	 * @request_ops_lock.
+	 *
+	 * @lock protection mixes with rtnl_lock in multiple ways, fields are
+	 * either:
+	 * - simply protected by the instance @lock;
+	 * - double protected - writers hold both locks, readers hold either;
+	 * - ops protected - protected by the lock held around the NDOs
+	 *   and other callbacks, that is the instance lock on devices for
+	 *   which netdev_need_ops_lock() returns true, otherwise by rtnl_lock;
+	 * - double ops protected - always protected by rtnl_lock but for
+	 *   devices for which netdev_need_ops_lock() returns true - also
+	 *   the instance lock.
+	 *
+	 * Simply protects:
 	 *	@gro_flush_timeout, @napi_defer_hard_irqs, @napi_list,
 	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
-	 * Partially protects (writers must hold both @lock and rtnl_lock):
+	 * Double protects:
 	 *	@up
 	 *
 	 * Also protects some fields in struct napi_struct.
 	 *
-	 * For the drivers that implement shaper or queue API, the scope
-	 * of this lock is expanded to cover most ndo/queue/ethtool/sysfs
-	 * operations.
-	 *
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 689ffdfae50d..efd302375ef2 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -5,6 +5,7 @@
 
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 static inline bool netdev_trylock(struct net_device *dev)
 {
@@ -51,6 +52,8 @@ static inline void netdev_ops_assert_locked(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
 		lockdep_assert_held(&dev->lock);
+	else
+		ASSERT_RTNL();
 }
 
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
-- 
2.49.0


