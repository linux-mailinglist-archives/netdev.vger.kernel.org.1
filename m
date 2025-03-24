Return-Path: <netdev+bounces-177261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA4DA6E6C3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641CC1898D3D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E61EFF85;
	Mon, 24 Mar 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQgKJW+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05C1EF092
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856378; cv=none; b=Ez/PjE/zxmgXfKtERZJ3budcpS2QKbEXLzRD4ZgukQpFbO5h/PGvfn21Cw7arH9bUtJsn0TEwbzKbPE52QJzmYBoCmVN4nrI7WySbWW+xjVf8MDKbs2Zt2C0sPtszS+xkZw89W9mQCSsyQifK39dJKSAp4bK+zGno5vxCXAnneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856378; c=relaxed/simple;
	bh=xRv1UD8qVJqW/FKNvUkdOCzK4lkqrdz8hvC31IgcWE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QenxENuF2Aq+rO17Rujnr/iJRd0qBK3JzVrHkOqC6PGIcpmCSgElNlB25Oq06as8OYTmE+I/TVrpUQu/i+MfSBIVtxG5uFgN4M33A3GGuCsXw9FoEY4w0u0tTOwbb9gR0MDB+J883Muuyfug4qhBx67GMQgMQaxQO7G3qQyc59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQgKJW+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF19C4CEE4;
	Mon, 24 Mar 2025 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856375;
	bh=xRv1UD8qVJqW/FKNvUkdOCzK4lkqrdz8hvC31IgcWE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQgKJW+pzX5B/IQpCDgVDgVliI55yQcTIZv/rqUBuS+L+qW76WRM9jysMNfTnL0LF
	 zNfOE9j8KFG++mCkEvmN3tCZcHz5YveWErMdQHH6qHEtWF3JQyFVpkKWKYM12MVgFA
	 WygJNAu22Wdco81uMELj/UKFLTI932SQ8omEA3NKhh6ZQToxRk8kYlpB1lMJCVh/qc
	 W2OcVGdIyTIPYyIrr4NQX8U+v0nqggiYziByl/yDku4GG0skupmE9AUoXRh44relJZ
	 SCCp4H0EcPfULS631PyDw39PZcpxaDAnQPCm6gzFvVz5NsZA1KdmpTW8FvP4bE9bp4
	 +J3sopQeZOd4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/11] net: protect rxq->mp_params with the instance lock
Date: Mon, 24 Mar 2025 15:45:33 -0700
Message-ID: <20250324224537.248800-8-kuba@kernel.org>
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

Ensure that all accesses to mp_params are under the netdev
instance lock. The only change we need is to move
dev_memory_provider_uninstall() under the lock.

Appropriately swap the asserts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c       | 4 ++--
 net/core/page_pool.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 690d46497b2f..652f2c6f5674 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10353,7 +10353,7 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
 {
 	int i;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	for (i = dev->real_num_rx_queues - 1; i >= 0; i--)
 		if (dev->_rx[i].mp_params.mp_priv)
@@ -11957,9 +11957,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		dev_memory_provider_uninstall(dev);
 		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
-		dev_memory_provider_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddc..7745ad924ae2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
@@ -279,11 +280,7 @@ static int page_pool_init(struct page_pool *pool,
 		get_device(pool->p.dev);
 
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
-		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
-		 * configuration doesn't change while we're initializing
-		 * the page_pool.
-		 */
-		ASSERT_RTNL();
+		netdev_assert_locked(pool->slow.netdev);
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
-- 
2.49.0


