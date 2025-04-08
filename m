Return-Path: <netdev+bounces-180464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F057A81634
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0C19E16E3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AA253F39;
	Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd701VuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503E253F34
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142408; cv=none; b=LrBVraqY++rylg2fISQwRDObWW7l+KXp4sdq6TUmQ+qjjxKVneHketOJEhq+6yW/+kW+WoDdRY8FCv1Ly/J33jzGQsO9Stb2wFe3g6hIppJ9G24YfXYW+/S7tMmSHh/h5a9b0+l5xJJS5dxrjBvvw/rDrL2Gl/cvH3JCkajzezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142408; c=relaxed/simple;
	bh=HY8vjiN7cWdHZwLwICMWmJPKxy2625FyuX07WDnP+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9XSBbz0GUOAMWXJc4DRjAgh55YZJyt4zcxIbTnbEjFdgYvfwoBuDwoXetXlQ3PmYcnhrv6moPp5jSZAuYd8mOgzH6mQjoCxOtB10MsxBqtwsHQXZ73CSJcbYsVBudycRnyfRPBEEWrFQlVJPmLDOGZcAicYFS80vPUBv4jNCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd701VuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E49C4CEE5;
	Tue,  8 Apr 2025 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142408;
	bh=HY8vjiN7cWdHZwLwICMWmJPKxy2625FyuX07WDnP+C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pd701VuEqndMzxBs+QHKrUjxrzxLcOSG8We+JiBPGC85Vn00L1hihs3ib0X3cztay
	 5/aPE1Q4aRCUzHkoQiLMgLEFzbFwPAnHmXxgSiFtm7XvD8cOtEBIF2beR53TATGmc7
	 460YArQNODgDMRiOuDJY+SwKyjINbD/aVXdy8UFam4mj+bfkm7tR4dZWuDqf+M2M3B
	 kUvB0cCW11KHCnljWkF3yVkFfh5Vv0Nrabh7KTy1Xlue2z6mBsNNz+Xfmf88gy0ZML
	 HmUQ0qBBJubYPxPXqulgSE7AyBTuDgJj8bFuOin/ZHqZQ67OmxUCYa23/NIPtAZo9r
	 tzYl3sT93wepg==
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
Subject: [PATCH net-next v2 2/8] net: designate XSK pool pointers in queues as "ops protected"
Date: Tue,  8 Apr 2025 12:59:49 -0700
Message-ID: <20250408195956.412733-3-kuba@kernel.org>
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

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter is not (both coming from
the workqueue via xp_clear_dev() and NETDEV_UNREGISTER via xsk_notifier()).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v2:
 - move the locking to xp_clear_dev()
v1: https://lore.kernel.org/20250407190117.16528-3-kuba@kernel.org
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk_buff_pool.c       | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8e9be80bc167..7242fb8a22fc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -688,6 +688,7 @@ struct netdev_queue {
 	/* Subordinate device that the queue has been assigned to */
 	struct net_device	*sb_dev;
 #ifdef CONFIG_XDP_SOCKETS
+	/* "ops protected", see comment about net_device::lock */
 	struct xsk_buff_pool    *pool;
 #endif
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index b2238b551dce..8cdcd138b33f 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -20,12 +20,12 @@ struct netdev_rx_queue {
 	struct net_device		*dev;
 	netdevice_tracker		dev_tracker;
 
+	/* All fields below are "ops protected",
+	 * see comment about net_device::lock
+	 */
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
-	/* NAPI instance for the queue
-	 * "ops protected", see comment about net_device::lock
-	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
 } ____cacheline_aligned_in_smp;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 25a76c5ce0f1..cbf2129e808b 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -266,13 +266,17 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 
 void xp_clear_dev(struct xsk_buff_pool *pool)
 {
+	struct net_device *netdev = pool->netdev;
+
 	if (!pool->netdev)
 		return;
 
+	netdev_lock_ops(netdev);
 	xp_disable_drv_zc(pool);
 	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
-	dev_put(pool->netdev);
 	pool->netdev = NULL;
+	netdev_unlock_ops(netdev);
+	dev_put(netdev);
 }
 
 static void xp_release_deferred(struct work_struct *work)
-- 
2.49.0


