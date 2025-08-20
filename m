Return-Path: <netdev+bounces-215120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D50B2D224
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569881C22BB8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD322C21EA;
	Wed, 20 Aug 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVlhNFLM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A52C21DC
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658638; cv=none; b=ZQhS2i+DqT1lW3+YfA95fZLWjZE7HzkOUZygp6CkWaVEmp7aNBs/1XOsN24oMPvG7dV5lu5qqKTvF7ZFJuk3mKjT0B4qQNVrepgiDdPqezbXH2nz/BGnAUhLeEdb+4T9/khaDVjUdMpwspzEXkxboMUofSebG5rWm/qY3Ukb/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658638; c=relaxed/simple;
	bh=yQNxpmG4DVOb3JO+x6XNUc8z0pQcnmTCTu14Yo/KrHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzfBpN+Aa7A8yNp9PWbhJmVumD8v01TdxEGkbnpZs3BgemEpULgYZG8cWF9B3+S3w0DEiyPRSBYC8rXI9FVLxyTzmSyRQp8l2l5YFDoP/t7nwnEIJ8EFLl1ozvorU4geHIbuWp6ob1Kx2awb4rAbDFWtzCdfAjWHvITW7y4QiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVlhNFLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0568FC16AAE;
	Wed, 20 Aug 2025 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658638;
	bh=yQNxpmG4DVOb3JO+x6XNUc8z0pQcnmTCTu14Yo/KrHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVlhNFLMm4J4jrYW1hoNpbroek2ljEeS+PKfLnGvOu/eD7ao1PHgl+NfWt8DS9OVg
	 sTBAcgPScSBQ/3oi/o8F1O8+FZ/rJqh51r+2tWquLVhaYYb4MoO15B51jl7C2O6JVH
	 FXUEBxlQTrdPJhVA4uRmsHVOsvZkmICgQIav364LOUeC+5WNT4thylt2nMwlWshNzP
	 Ffp2A66VHXOPL95PNuJfZ6K+l0rqN42RQUW18pG0XxjZK8UTvscq+AgNd9TPjZx4XC
	 9+yDpVJV6zVxJXnWZpRqGyzuIvRvGjnbQzI35Z/fiNU0MXGOwOMJG+fMBDYVIk9e4h
	 8m6WBJkjKVxkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/15] net: page_pool: add helper to pre-check if PP will be unreadable
Date: Tue, 19 Aug 2025 19:57:00 -0700
Message-ID: <20250820025704.166248-12-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 pokes into the rxq state to check if the queue has a memory
provider, and therefore whether it may produce unreable mem.
Add a helper for doing this in the page pool API. fbnic will want
a similar thing (tho, for a slightly different reason).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool/helpers.h                   |  9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++--------
 net/core/page_pool.c                              |  8 ++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index aa3719f28216..307c2436fa12 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -505,6 +505,15 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+bool __page_pool_rxq_wants_unreadable(struct net_device *dev, unsigned int qid);
+
+static inline bool
+page_pool_rxq_wants_unreadable(const struct page_pool_params *pp_params)
+{
+	return __page_pool_rxq_wants_unreadable(pp_params->netdev,
+						pp_params->queue_idx);
+}
+
 static inline bool page_pool_is_unreadable(struct page_pool *pool)
 {
 	return !!pool->mp_ops;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..cee96ded300e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -42,6 +42,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/helpers.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -777,13 +778,6 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
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
@@ -822,7 +816,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
 		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
 
-	if (mlx5_rq_needs_separate_hd_pool(rq)) {
+	if (__page_pool_rxq_wants_unreadable(rq->netdev, rq->ix)) {
 		/* Separate page pool for shampo headers */
 		struct page_pool_params pp_params = { };
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 343a6cac21e3..9f087a6742c3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -190,6 +190,14 @@ static void page_pool_struct_check(void)
 				    PAGE_POOL_FRAG_GROUP_ALIGN);
 }
 
+bool __page_pool_rxq_wants_unreadable(struct net_device *dev, unsigned int qid)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, qid);
+
+	return !!rxq->mp_params.mp_ops;
+}
+EXPORT_SYMBOL(__page_pool_rxq_wants_unreadable);
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
-- 
2.50.1


