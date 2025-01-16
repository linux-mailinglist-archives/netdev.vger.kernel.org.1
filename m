Return-Path: <netdev+bounces-159063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61377A14444
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6F3AA50C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81B2416A1;
	Thu, 16 Jan 2025 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpIgT3GA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839B241696
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064552; cv=none; b=rL1pTiXMpMp2JGPyhwEH35E90MOU82VYpQmwGaZ1eRu9uNM8l+RywnpUz1iOrdzRrI70uId/kBgwrYg2nWe0MVkVdJrVgUKe63/GQcnIMI4HTEcDGU+8NKqJrNRVvnXJcPy1byMXtUp2NdQHYPMCNGUbKYXN663w68eNCHrpQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064552; c=relaxed/simple;
	bh=ezAUu1jEM9wg0f3iyBxIgHCoCnF1eyTUXF+0fCPcLbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+tqVMJ0XlZvIFfE0yMhQGWcmRfyOWgjRMevp04lRqavfiKHHCzTA6oKQLzG2f2z8RkZ1CXGxad1yZNz0/pC78Tp9OjeUE5jPv409sPCL/c/r9I1bR7X2YwzcvHCopQiBhPtPhHfC0pZ3w9zxcfleKhrzKhI89pHFtbrDkTwGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpIgT3GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B4C4CED6;
	Thu, 16 Jan 2025 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064552;
	bh=ezAUu1jEM9wg0f3iyBxIgHCoCnF1eyTUXF+0fCPcLbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpIgT3GAek5AqAG6G26frYbdqhVdEnoWYEBk0JEyPMhrDCW3FkeaOoCf4fzbOHnUs
	 FikTGx6UyoYVdqxrt2ux+F8ipowT9JtPeXhidEZTrH3ravBLmgT+kEgXbDlj5ESZsv
	 H2eIft08CyhnGmEJDmoXpjDzFGwB/HkvSqzZXQHxtU1/C5EVgvrfqaM9IKdYHtVMzs
	 HaFi+gA0aBVX0PyFqZfy282M249YSR8RAIZx5+5Ny+81VFbtZAbVQGmfbQNjkQXw2+
	 Z7RWK/IDTAvhrDt065pElVQXaQx4t0PYjRho7iWwf0PVy9nyhvO1hSLNCHOlNMJ8gi
	 sK03nysPXDZfg==
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
Subject: [net-next 02/11] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Thu, 16 Jan 2025 13:55:20 -0800
Message-ID: <20250116215530.158886-3-saeed@kernel.org>
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

Drop redundant SHAMPO structure alloc/free functions.

Gather together function calls pertaining to header split info, pass
header per WQE (hd_per_wqe) as parameter to those function to avoid use
before initialization future mistakes.

Allocate HW GRO related info outside of the header related info scope.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 132 +++++++++---------
 2 files changed, 63 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..66c93816803e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -628,7 +628,6 @@ struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
-	u16 pages_per_wq;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bd41b75d246e..c687c926cba3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -330,47 +330,6 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 	ucseg->mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static int mlx5e_rq_shampo_hd_alloc(struct mlx5e_rq *rq, int node)
-{
-	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
-					 GFP_KERNEL, node);
-	if (!rq->mpwqe.shampo)
-		return -ENOMEM;
-	return 0;
-}
-
-static void mlx5e_rq_shampo_hd_free(struct mlx5e_rq *rq)
-{
-	kvfree(rq->mpwqe.shampo);
-}
-
-static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	shampo->bitmap = bitmap_zalloc_node(shampo->hd_per_wq, GFP_KERNEL,
-					    node);
-	shampo->pages = kvzalloc_node(array_size(shampo->hd_per_wq,
-						 sizeof(*shampo->pages)),
-				     GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->pages)
-		goto err_nomem;
-
-	return 0;
-
-err_nomem:
-	kvfree(shampo->bitmap);
-	kvfree(shampo->pages);
-
-	return -ENOMEM;
-}
-
-static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
-{
-	kvfree(rq->mpwqe.shampo->bitmap);
-	kvfree(rq->mpwqe.shampo->pages);
-}
-
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 {
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
@@ -581,19 +540,18 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 }
 
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       struct mlx5e_rq *rq)
+				       u16 hd_per_wq, u32 *umr_mkey)
 {
 	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
 
-	if (max_ksm_size < rq->mpwqe.shampo->hd_per_wq) {
+	if (max_ksm_size < hd_per_wq) {
 		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_ksm_size, rq->mpwqe.shampo->hd_per_wq);
+			      max_ksm_size, hd_per_wq);
 		return -EINVAL;
 	}
-
-	return mlx5e_create_umr_ksm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+	return mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
 					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					 &rq->mpwqe.shampo->mkey);
+					 umr_mkey);
 }
 
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
@@ -755,6 +713,33 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 				  xdp_frag_size);
 }
 
+static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, u16 hd_per_wq, int node)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+
+	shampo->hd_per_wq = hd_per_wq;
+
+	shampo->bitmap = bitmap_zalloc_node(hd_per_wq, GFP_KERNEL, node);
+	shampo->pages = kvzalloc_node(array_size(hd_per_wq, sizeof(*shampo->pages)),
+				      GFP_KERNEL, node);
+	if (!shampo->bitmap || !shampo->pages)
+		goto err_nomem;
+
+	return 0;
+
+err_nomem:
+	kvfree(shampo->pages);
+	bitmap_free(shampo->bitmap);
+
+	return -ENOMEM;
+}
+
+static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
+{
+	kvfree(rq->mpwqe.shampo->pages);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -762,42 +747,51 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				u32 *pool_size,
 				int node)
 {
+	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u16 hd_per_wq;
+	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
-	err = mlx5e_rq_shampo_hd_alloc(rq, node);
-	if (err)
-		goto out;
-	rq->mpwqe.shampo->hd_per_wq =
-		mlx5e_shampo_hd_per_wq(mdev, params, rqp);
-	err = mlx5e_create_rq_hd_umr_mkey(mdev, rq);
+
+	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
+					 GFP_KERNEL, node);
+	if (!rq->mpwqe.shampo)
+		return -ENOMEM;
+
+	/* split headers data structures */
+	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
+	err = mlx5e_rq_shampo_hd_info_alloc(rq, hd_per_wq, node);
 	if (err)
-		goto err_shampo_hd;
-	err = mlx5e_rq_shampo_hd_info_alloc(rq, node);
+		goto err_shampo_hd_info_alloc;
+
+	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq, &rq->mpwqe.shampo->mkey);
 	if (err)
-		goto err_shampo_info;
+		goto err_umr_mkey;
+
+	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
+	rq->mpwqe.shampo->hd_per_wqe =
+		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
 	if (!rq->hw_gro_data) {
 		err = -ENOMEM;
 		goto err_hw_gro_data;
 	}
-	rq->mpwqe.shampo->key =
-		cpu_to_be32(rq->mpwqe.shampo->mkey);
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	rq->mpwqe.shampo->pages_per_wq =
-		rq->mpwqe.shampo->hd_per_wq / MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
-	*pool_size += rq->mpwqe.shampo->pages_per_wq;
+
 	return 0;
 
 err_hw_gro_data:
-	mlx5e_rq_shampo_hd_info_free(rq);
-err_shampo_info:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
-err_shampo_hd:
-	mlx5e_rq_shampo_hd_free(rq);
-out:
+err_umr_mkey:
+	mlx5e_rq_shampo_hd_info_free(rq);
+err_shampo_hd_info_alloc:
+	kvfree(rq->mpwqe.shampo);
 	return err;
 }
 
@@ -809,7 +803,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	kvfree(rq->hw_gro_data);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
-	mlx5e_rq_shampo_hd_free(rq);
+	kvfree(rq->mpwqe.shampo);
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
-- 
2.48.0


