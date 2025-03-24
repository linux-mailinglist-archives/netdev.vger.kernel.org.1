Return-Path: <netdev+bounces-177263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75CA6E6C0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1178E7A5BF8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032511F03DC;
	Mon, 24 Mar 2025 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIqOFYAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344E1EFFB4
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856382; cv=none; b=S/13z/hgLYgVIaidDlch+8cHtPDIcwCpcTd3gUhrCy/yOSeV7yRs6cprMwaKjbgd+m5hu9dMdd1r9OXaNg5t0Hq02/xvkvXhKBxhus3xtssNsrg99UCGijoTG4EDtqqzA6uaeuTaWf3VQ1ldsw3DMQj1gU63BhfGqE5nNqAt02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856382; c=relaxed/simple;
	bh=8jyNDr+eYZir264pbPdlC6Gm7Uz7FyKF6wEuoqFukd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BktmwNYphoPpIrcxIcwd9yv8UJli6+gr0rVYYbTUX3gyG2o/e7+eGG2cuu+CK3yXM6Mu583Wcm2I+HFkFN/BI2X0vIY2Cr82kot3xyPu9EZieBXOkAOPXciJi2mxdZK3EFzVmcZJrCfAN+b8N79rWuuITyOsaDT1LSFh7fPzgAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIqOFYAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9D0C4CEDD;
	Mon, 24 Mar 2025 22:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856382;
	bh=8jyNDr+eYZir264pbPdlC6Gm7Uz7FyKF6wEuoqFukd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIqOFYALTYZdA71mPcykaBqOZWJfM8h3kCyXsuHQcqraf+oSmS/fPX3kCARCOO8lk
	 Da8+Jg6JeT8qn/JkJXzdiNJHp3iFPVnKH4Wz2DTcy2rvt8jWXqmFKwD+94yAxGc+8G
	 rB0tZ4g0DkW8eST/eNwE14FaolAv4vjc4H8Djk0LYQPqnNCSlBxSU0EkVsRoIhCBCm
	 +YhJ7stDWK2F70m2vE9I865nGNLO/EcsZQ3aiHGxeTyXmq53Sj6/pZf/tMXfR5fwOd
	 3tHREXIbuGk54TV0breuHVHhtg3zLmMc2vSkjcUFOgt4BzbfcsSAo2jC4IeukaoKkl
	 DGLrJbV1as23A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Mon, 24 Mar 2025 15:45:35 -0700
Message-ID: <20250324224537.248800-10-kuba@kernel.org>
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

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter needs to be locked when
coming from the workqueue via xp_clear_dev().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - only clear if netdev still set
v1: https://lore.kernel.org/20250312223507.805719-10-kuba@kernel.org
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk_buff_pool.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fd508e9f148c..15f8b596da66 100644
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


