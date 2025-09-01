Return-Path: <netdev+bounces-218923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E3B3F060
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72914E052A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFBE279331;
	Mon,  1 Sep 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k281GSNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38233279329
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761145; cv=none; b=Nf8JwAsuMVAJ0OGd6owJXiRyhM+CYafktgl/f+rM7bjKdz62plVZO0vlqLgDL+P/RZQ8+Z9AzJztGiSzHu22gL87RkuNf7tNCiYWXPM5wUWWrhj2PlSktRIGMgZ2nT4zpISoqMA8lOAxnlsaBYDrSY3/jfefwhIZt/cSYPyDmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761145; c=relaxed/simple;
	bh=k0XReyJRIRkulRN2jc1H8DqLYbMu7v2xFhGJXc64trw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWmQTn/Rn0vr8KmJDuLP5uQqCmxgrdilhI+g83D9Q1QU3LHvIYEt1eV2ewF+jLVHqCtkorEUnDoN9XN/WQ0QmLzvNhskWBbEvPTB3BEjCGRB4v5DsM0PAzO/auT5L9s7dWPRf2pAIs7tm7/CIRlVYU7iKbECQT/qdB/1RYWGulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k281GSNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DDEC4CEF7;
	Mon,  1 Sep 2025 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761145;
	bh=k0XReyJRIRkulRN2jc1H8DqLYbMu7v2xFhGJXc64trw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k281GSNThs9gkysyFHe6TpLdcoJOi16OPbRknoqW8rYO5g4TSOv4Y0e/g1m9nEcxc
	 waDtq7UjXj7IrkfARDJLuBI61IfPXH0JzV0NuQbVTm+uUwMGGz9XHQ+u2ry3wyIr7G
	 TU4YU5eCy1nNyc2rm/RzwqIU/ZIHS+S1NR+3O8D7xeG0OyceEb6UY23+B7pvSouz0L
	 thfSAZwxu3PPfBkmgeQveF1FppfMR0K7MkM5Dd5bYIM+FvYkt3wkdwuVi3k2iLC9b2
	 TVpUKSg68M+AKIMD94L1UdC5Gur4meeop3ivTruiafaY7o7TbveSs3UAqZHHY6ojEP
	 XImwKBhKRFkoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 10/14] net: add helper to pre-check if PP for an Rx queue will be unreadable
Date: Mon,  1 Sep 2025 14:12:10 -0700
Message-ID: <20250901211214.1027927-11-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 pokes into the rxq state to check if the queue has a memory
provider, and therefore whether it may produce unreadable mem.
Add a helper for doing this in the page pool API. fbnic will want
a similar thing (tho, for a slightly different reason).

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - make the helper an rxq helper rather than PP helper
v1: https://lore.kernel.org/20250820025704.166248-12-kuba@kernel.org
---
 include/net/netdev_queues.h                       |  2 ++
 include/net/page_pool/helpers.h                   | 12 ++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  9 +--------
 net/core/netdev_rx_queue.c                        |  9 +++++++++
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index b9d02bc65c97..cd00e0406cf4 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -151,6 +151,8 @@ struct netdev_queue_mgmt_ops {
 							 int idx);
 };
 
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index aa3719f28216..3247026e096a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -505,6 +505,18 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+/**
+ * page_pool_is_unreadable() - will allocated buffers be unreadable for the CPU
+ * @pool: queried page pool
+ *
+ * Check if page pool will return buffers which are unreadable to the CPU /
+ * kernel. This will only be the case if user space bound a memory provider (mp)
+ * which returns unreadable memory to the queue served by the page pool.
+ * If %PP_FLAG_ALLOW_UNREADABLE_NETMEM was set but there is no mp bound
+ * this helper will return false. See also netif_rxq_has_unreadable_mp().
+ *
+ * Return: true if memory allocated by the page pool may be unreadable
+ */
 static inline bool page_pool_is_unreadable(struct page_pool *pool)
 {
 	return !!pool->mp_ops;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3970d0ddbcdc..714cce595692 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -780,13 +780,6 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 	bitmap_free(rq->mpwqe.shampo->bitmap);
 }
 
-static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
-{
-	struct netdev_rx_queue *rxq = __netif_get_rx_queue(rq->netdev, rq->ix);
-
-	return !!rxq->mp_params.mp_ops;
-}
-
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -825,7 +818,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
 		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
 
-	if (mlx5_rq_needs_separate_hd_pool(rq)) {
+	if (netif_rxq_has_unreadable_mp(rq->netdev, rq->ix)) {
 		/* Separate page pool for shampo headers */
 		struct page_pool_params pp_params = { };
 
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 3bf1151d8061..c7d9341b7630 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -9,6 +9,15 @@
 
 #include "page_pool_priv.h"
 
+/* See also page_pool_is_unreadable() */
+bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
+
+	return !!rxq->mp_params.mp_ops;
+}
+EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
-- 
2.51.0


