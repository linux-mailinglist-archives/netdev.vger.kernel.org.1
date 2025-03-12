Return-Path: <netdev+bounces-174402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B168A5E78A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD42A3BD940
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C491F09B3;
	Wed, 12 Mar 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk8Ikopj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD31F03DE
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818940; cv=none; b=qHSxcw82AOtNUAY/Z7B19e0GxfesZBm09qgoVlaRYUgyv09qeO+eu67yxzPButkSn0/uQpGYVBA4veyjTE1iv7fQb1Kpl5lygq0JjsaWF3cXXg9OiKgrK5d4L5svQdjkX25J5k7zQzDa2DS/2jTiaOWYKx95oMW5OMzVgCW/IKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818940; c=relaxed/simple;
	bh=PjuiaYD06gAwzkwu3j5pZ5a8JqKZBfknOwKtVNJjoYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+7E11dNnJVhZwy+tMvXfokdyBA5KbytdjxviEIqoCibutMAZvh8nDp5pkAVaHBN2x7FsS+oSqKftK+sGe0Jdfqk0IeJvmDnRVvymwh5etNmi7qlCe3Sxgewt+EnGxkru6sLpJ1MrgY4mKdF0cIgBemqr26GmakYG4IVt7zu5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk8Ikopj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB1C4CEDD;
	Wed, 12 Mar 2025 22:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818940;
	bh=PjuiaYD06gAwzkwu3j5pZ5a8JqKZBfknOwKtVNJjoYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sk8Ikopj2ZjF0hFxhqFP/m8zWJ3psAe9lRveJ8840hJT+GrHyOZoPBsRj8K643JGN
	 cQfKHMuI2JKvywYQLb0vxZvTjM29x5aOctTAeBKAPU5Q2qdjXaRetZ6atQZtm2wuDr
	 uw5cYc+RkAWkm0O2nxi1ePorodr/w5bHGXKalXCRGsBjHAioMMd/TYigFVDh2HQb6V
	 lDzKezW2dNsX6dvssuyi1rQQDe93G7xA3wg1ChWCzWVlLHC7x5PJQlbkjCQDVtd8D8
	 l4+tybrpdn64jDL/fsLb/nAJ+mjJBMifIMxVETlZUWy2uKfrn9lUbFTDelhSm+0bBu
	 7BkhCFBbLwnnQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] net: designate XSK pool pointers in queues as "ops protected"
Date: Wed, 12 Mar 2025 23:35:05 +0100
Message-ID: <20250312223507.805719-10-kuba@kernel.org>
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

Read accesses go via xsk_get_pool_from_qid(), the call coming
from the core and gve look safe (other "ops locked" drivers
don't support XSK).

Write accesses go via xsk_reg_pool_at_qid() and xsk_clear_pool_at_qid().
Former is already under the ops lock, latter needs to be locked when
coming from the workqueue via xp_clear_dev().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h     | 1 +
 include/net/netdev_rx_queue.h | 6 +++---
 net/xdp/xsk_buff_pool.c       | 3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0fc79ae60ff5..7d802ef1c864 100644
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
index 14716ad3d7bc..60b3adb7b2d7 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -279,9 +279,12 @@ static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
 						  work);
+	struct net_device *netdev = pool->netdev;
 
 	rtnl_lock();
+	netdev_lock_ops(netdev);
 	xp_clear_dev(pool);
+	netdev_unlock_ops(netdev);
 	rtnl_unlock();
 
 	if (pool->fq) {
-- 
2.48.1


