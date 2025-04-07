Return-Path: <netdev+bounces-179876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC47A7ECE0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF574481DB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681425B69D;
	Mon,  7 Apr 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLtp9z6d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F87223302
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052479; cv=none; b=LGp0zDkTaoDvVZqXViblxIDbauo/y5nIzRAVjM2RW4aCzlTbVLaw/aMg+g0FZBzNT9k6X3nU7lifBf7pWOGzFaMvZmTJTV2uGUmvZydyvubxSkjE5VcNdAbJqRsqX7rkSBm9i3EZGX3002PamgxJWfBw6cu575YjfGQGO5ScF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052479; c=relaxed/simple;
	bh=qiWKN2+V0g2trh+EbLOKdigX+zrLTn13OWq1qeHarIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj+D+b3bwaNOvWHzu8A6aC+Pja9nihPq0KFeEbjcqAKC98GX5B0SV+Brr2dX3ePah4E9HkXhMwFmATDWhBRY34V+JA65KzUDiJxdJzl7d5r1ngaYbzb1tQzsBkpmUg0A+jP0QfeyJy11CWWfnLfXSwxrEjWYTwkCiATtEEBDN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLtp9z6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A735CC4CEEC;
	Mon,  7 Apr 2025 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052479;
	bh=qiWKN2+V0g2trh+EbLOKdigX+zrLTn13OWq1qeHarIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLtp9z6dU9MppmKQ7EGmvKqpd22wDpIU596cmtv0EGyUQVU2dJo3tVCm9BZpq5EF9
	 8yx7T06D9XOGcvTxETYNDHW+zEekI6yQZRZt39AMK5MFQ32qfnSLSZUKn69jD6QOO4
	 ggLIoJOEo5JuWY72hFkLWqFRvhlcYiEhuWHuF3cYntBGGlAauVLp3KL8japeE1SLR3
	 ENchIG81AU66UuX9KDBw7Wvsi3QzNKi1yTowXRs8YtcUIqqHjsybz/1oHrfCkaTYVp
	 9AzGOPFejaZ5VbrVhQOkvdHv9hRlSncQpTPE3qoCM7AV1CqkmJk5pWDQGLGTRtFE8v
	 CUAhnCw+wMczA==
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
Subject: [PATCH net-next 2/8] net: designate XSK pool pointers in queues as "ops protected"
Date: Mon,  7 Apr 2025 12:01:11 -0700
Message-ID: <20250407190117.16528-3-kuba@kernel.org>
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

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter needs to be locked when
coming from the workqueue via xp_clear_dev().

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk.c                 | 2 ++
 net/xdp/xsk_buff_pool.c       | 7 ++++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

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
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5696af45bcf7..2ecf063a2c38 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1654,7 +1654,9 @@ static int xsk_notifier(struct notifier_block *this,
 				xsk_unbind_dev(xs);
 
 				/* Clear device references. */
+				netdev_lock_ops(dev);
 				xp_clear_dev(xs->pool);
+				netdev_unlock_ops(dev);
 			}
 			mutex_unlock(&xs->mutex);
 		}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 25a76c5ce0f1..c7e50fd86c6a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -279,9 +279,14 @@ static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
 						  work);
+	struct net_device *netdev = pool->netdev;
 
 	rtnl_lock();
-	xp_clear_dev(pool);
+	if (netdev) {
+		netdev_lock_ops(netdev);
+		xp_clear_dev(pool);
+		netdev_unlock_ops(netdev);
+	}
 	rtnl_unlock();
 
 	if (pool->fq) {
-- 
2.49.0


