Return-Path: <netdev+bounces-159066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A6A14447
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883273A2EAD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1424224B;
	Thu, 16 Jan 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJjADaAX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D38242249
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064555; cv=none; b=oDaPh2g1kFbbkJdy2V3fMMNoG3qW+t8IlNbl4ddfxiSuag0d7rUbDImvoEdNXBNUapPldpiPIXS/5O61s6AmU76olfoYugWpspSJHmlSWlQDFQeme4rKJhxgF5kmFAdOPwbblpwvF8rScq3mRyjem6EFWM4qdKkUCn8cCcSwSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064555; c=relaxed/simple;
	bh=zBYG2TJMANasobCEKxxvDpa61sS318nQSHPEqKax4MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzbNLGis9+wHMe7hy01I6VeznXhi+RX6+vCnMcsxirp9QmjfeBRAGN44Reesq/2xBYwRGwL0/g+UD1y6aFuohc6EY1nUCIbTi3wllUEF5lKmKrxJUSKnTo9AUBzPK5QczC5xkoeeUm0Kx0VqkpO2VimFq32DouzMhjnfmwu3/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJjADaAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1301FC4CED6;
	Thu, 16 Jan 2025 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064555;
	bh=zBYG2TJMANasobCEKxxvDpa61sS318nQSHPEqKax4MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJjADaAXesVD6V/hVpeC+wtgctzd8rO+9rFAOwqs0AyFgkKOrKUZ2pIA+ZObrQjPv
	 OeLw7VpbxytoHgw76xPCS0b5gWdetELqVah2yTJuB3FXP3MujSJ1821bg05eHhfvcf
	 4X3FY6apllyAxL+imHHUm6xkVXRS0CnEmhxumt7vNwwehQ3ZDEZ3SD4eKLP2KTtpiz
	 NOSz4yxwzP8JkTgvndAyidzDG07DNpqV83i3t9YEEXWnTOrPvwVQokCCUKigX2p33J
	 lGNso/FOqRqRNnSjAxEZJc4f53MsedM0f+YyFeNc4VT4HXB03dm8e1mAWb3sP1pyjg
	 1YcZ662oMvCqw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 05/11] net/mlx5e: SHAMPO: Separate pool for headers
Date: Thu, 16 Jan 2025 13:55:23 -0800
Message-ID: <20250116215530.158886-6-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Allocate a separate page pool for headers when SHAMPO is enabled.
This will be useful for adding support to zc page pool, which has to be
different from the headers page pool.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 37 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 35 +++++++++---------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 18f8c00f4d7f..29b9bcecd125 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -706,7 +706,10 @@ struct mlx5e_rq {
 	struct bpf_prog __rcu *xdp_prog;
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
+
+	/* page pools */
 	struct page_pool      *page_pool;
+	struct page_pool      *hd_page_pool;
 
 	/* AF_XDP zero-copy */
 	struct xsk_buff_pool  *xsk_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 66d1b3fe3134..02c9737868b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -745,12 +745,10 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
 				struct mlx5e_rq *rq,
-				u32 *pool_size,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
 	u16 hd_per_wq;
-	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
@@ -774,9 +772,33 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* separate page pool for shampo headers */
+	{
+		int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+		struct page_pool_params pp_params = { };
+		u32 pool_size;
+
+		pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+				MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+		pp_params.order     = 0;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = pool_size;
+		pp_params.nid       = node;
+		pp_params.dev       = rq->pdev;
+		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
+		pp_params.dma_dir   = rq->buff.map_dir;
+		pp_params.max_len   = PAGE_SIZE;
+
+		rq->hd_page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->hd_page_pool)) {
+			err = PTR_ERR(rq->hd_page_pool);
+			rq->hd_page_pool = NULL;
+			goto err_hds_page_pool;
+		}
+	}
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
@@ -788,6 +810,8 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	return 0;
 
 err_hw_gro_data:
+	page_pool_destroy(rq->hd_page_pool);
+err_hds_page_pool:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
@@ -802,6 +826,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 		return;
 
 	kvfree(rq->hw_gro_data);
+	page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
 	kvfree(rq->mpwqe.shampo);
@@ -881,7 +906,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, &pool_size, node);
+		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, node);
 		if (err)
 			goto err_free_mpwqe_info;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1963bc5adb18..df561251b30b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,12 +273,12 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
 				       struct mlx5e_frag_page *frag_page)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
+	page = page_pool_dev_alloc_pages(pool);
 	if (unlikely(!page))
 		return -ENOMEM;
 
@@ -292,14 +292,14 @@ static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
+static void mlx5e_page_release_fragmented(struct page_pool *pool,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
 	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
+		page_pool_put_unrefed_page(pool, page, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -313,7 +313,7 @@ static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
 		 * offset) should just use the new one without replenishing again
 		 * by themselves.
 		 */
-		err = mlx5e_page_alloc_fragmented(rq, frag->frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag->frag_page);
 
 	return err;
 }
@@ -332,7 +332,7 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 				     struct mlx5e_wqe_frag_info *frag)
 {
 	if (mlx5e_frag_can_release(frag))
-		mlx5e_page_release_fragmented(rq, frag->frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag->frag_page);
 }
 
 static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
@@ -584,7 +584,7 @@ mlx5e_free_rx_mpwqe(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi)
 				struct mlx5e_frag_page *frag_page;
 
 				frag_page = &wi->alloc_units.frag_pages[i];
-				mlx5e_page_release_fragmented(rq, frag_page);
+				mlx5e_page_release_fragmented(rq->page_pool, frag_page);
 			}
 		}
 	}
@@ -679,11 +679,10 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 
-
 		addr = page_pool_get_dma_addr(frag_page->page);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
@@ -715,7 +714,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
-			mlx5e_page_release_fragmented(rq, frag_page);
+			mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
 		}
 	}
 
@@ -791,7 +790,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	for (i = 0; i < rq->mpwqe.pages_per_wqe; i++, frag_page++) {
 		dma_addr_t addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 		addr = page_pool_get_dma_addr(frag_page->page);
@@ -836,7 +835,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 err_unmap:
 	while (--i >= 0) {
 		frag_page--;
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
 	}
 
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
@@ -855,7 +854,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
 	}
 	clear_bit(header_index, shampo->bitmap);
 }
@@ -1100,6 +1099,8 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 
 	if (rq->page_pool)
 		page_pool_nid_changed(rq->page_pool, numa_mem_id());
+	if (rq->hd_page_pool)
+		page_pool_nid_changed(rq->hd_page_pool, numa_mem_id());
 
 	head = rq->mpwqe.actual_wq_head;
 	i = missing;
@@ -2001,7 +2002,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(page_address(frag_page->page) + frag_offset);
-		if (unlikely(mlx5e_page_alloc_fragmented(rq, &wi->linear_page))) {
+		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool, &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
@@ -2063,7 +2064,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				wi->linear_page.frags++;
 			}
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -2072,13 +2073,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
 					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
 		if (unlikely(!skb)) {
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
 		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq, &wi->linear_page);
+		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf.xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.48.0


