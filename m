Return-Path: <netdev+bounces-174397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CAA5E785
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF591899DBE
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879511F0E2C;
	Wed, 12 Mar 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beB8sxUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640201F0E26
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818928; cv=none; b=ZXDlh4axUq5VJY6ogZesUpULwnP+HwFoSAYTRrspAmEqe1vfuNbhb5AQWAsLr/e9yVPAfPUIFAjualnS0GCupjz3979N+O1s+Z7oifNU2LESKKgKbRsrbS0noxamp0RZRUvcH3CbUs+/SAXerk+ylyKAkhc9F64w7UaCPdwUJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818928; c=relaxed/simple;
	bh=ju48Qgbreq1JnAKm3gumpOguqdUyJKjT2HnadJSjg1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnqY3Iv3j4R8gm03WbvGe/Utw1eFb4q3+bcRXsynwx9IySUIoaYOnZV40sk9fZ1ILQDTZjT6uSLDuxH1vhs1785psGuILMKCuadvN86F63uCRubx8bAJuJWk3Oua3fSOHCYus+uaRap7VhQtzoR+jx6ytZBilr0LFj/pNOgS1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beB8sxUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA7C4CEDD;
	Wed, 12 Mar 2025 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818927;
	bh=ju48Qgbreq1JnAKm3gumpOguqdUyJKjT2HnadJSjg1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beB8sxUb2FIV7+41YPGZvMRvOtG7pFxX/MFxoen2BHVFK4CpdAVhG7mJz7LxAMHWL
	 tpca0q0vLrMp2clw46NFBLtOIs8d0nC1JvgUrsHaVNSJjIpXninmRPiq4TtrtuWmlz
	 lDL8TmPbWTcaXjj/i/gph0YMoK+JruTWHYln8Fmx+KAuj+R5V4Rwco3crE3kew9LFS
	 ZPXeqvNdRRrwRAlNg4taiBUaCkvtvrDWVcw4FaWUk+/5lpdeWJEhadm5+kjaq25R1s
	 8f1SASVrXMQQmMsGXjrqPubR/OuEDjuCofvCAvidtg1Eidg28kkZegg3FUAb7wNsOW
	 rnElBjiNawLVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/11] net: explain "protection types" for the instance lock
Date: Wed, 12 Mar 2025 23:35:00 +0100
Message-ID: <20250312223507.805719-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
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
index 2f344d5ad953..e8e4e6fbcef4 100644
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
 	 *	@net_shaper_hierarchy, @reg_state, @threaded, @dev_addr
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
2.48.1


