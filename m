Return-Path: <netdev+bounces-110986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B192F315
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAD42828CA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65696FB0;
	Fri, 12 Jul 2024 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWv5ayp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F8567D
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744409; cv=none; b=ZLCOruDFxaZmP8EAdVbinTOnQfa5M4Gel95yJUgcGIcEi2YtLJLUXYQqfAO8QOTUWKJcArMm7yGRfcN3GjcPohksMqxba89qxfuVI7hLPRvPQdRNzbzQkQMtTOAbbm2S5YFrO9YYh1eEhh9gLSr3cVNwmVflf44eFpmNROZLSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744409; c=relaxed/simple;
	bh=ggqQkyQDos9wXOvPtlefHVRNH7Qn17AIOkcpI+38AC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFpV27nCm6wnBeP2CQyAczDGdtUWweELyI9cUVVIscxpihYN95XjKMS7T8RycDIccTek3SZfefVxsZjxg8CwzhK/BrHlBLtQ7ftq8GlD4eT90gVvPr1P1oOLKZNPVme+SvGcBnSe/20iqqSzn4PMA/5EPBFJ4RDbSkpINvwq7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWv5ayp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96DC4AF0C;
	Fri, 12 Jul 2024 00:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744409;
	bh=ggqQkyQDos9wXOvPtlefHVRNH7Qn17AIOkcpI+38AC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWv5ayp8Q1Rc9vAvF8ahHkxV9iPSwP3eD6YIDQkt6MaAquae7U7JZnwrsZm7CDTLx
	 2VBAMKe3CHijMi7hxGT30e0jb9EVUMHxSW7h+rSIof+aP2ZPfPzghlBSuP0cU9P41Y
	 tnZiRmYrqAT/kGk18CVAmNsDyBOP+/Ao0o+LUsBe/1gEvgJdvW829n8Yb5e53TfY+i
	 4vx+KaNfJtbmgaybzslmSlVc5XWWlhDMbhEmYIPPJIiFmZcHBPe1F5SCvxiyOKKTTF
	 CnTdkGUpfX8MtMqfGxkU35lzcPJ6glP67S1OR0dgzo7Ah2TfbHF820kQFxRZ/ygadp
	 VCMOm1ebFS1VA==
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
	Daniel Jurgens <danielj@nvidia.com>,
	William Tu <witu@nvidia.com>
Subject: [PATCH net-next V3 4/4] net/mlx5: Use set number of max EQs
Date: Thu, 11 Jul 2024 17:33:10 -0700
Message-ID: <20240712003310.355106-5-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712003310.355106-1-saeed@kernel.org>
References: <20240712003310.355106-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

If a maximum number of EQs has been set for an SF, use that amount.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c      |  7 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 ++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ac1565c0c8af..4326aa42bf2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1187,7 +1187,6 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *eq_table = dev->priv.eq_table;
 	int max_dev_eqs;
-	int max_eqs_sf;
 	int num_eqs;
 
 	/* If ethernet is disabled we use just a single completion vector to
@@ -1202,7 +1201,11 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 	num_eqs = min_t(int, mlx5_irq_table_get_num_comp(eq_table->irq_table),
 			max_dev_eqs - MLX5_MAX_ASYNC_EQS);
 	if (mlx5_core_is_sf(dev)) {
-		max_eqs_sf = min_t(int, MLX5_COMP_EQS_PER_SF,
+		int max_eqs_sf = MLX5_CAP_GEN_2(dev, sf_eq_usage) ?
+				 MLX5_CAP_GEN_2(dev, max_num_eqs_24b) :
+				 MLX5_COMP_EQS_PER_SF;
+
+		max_eqs_sf = min_t(int, max_eqs_sf,
 				   mlx5_irq_table_get_sfs_vec(eq_table->irq_table));
 		num_eqs = min_t(int, num_eqs, max_eqs_sf);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 401d39069680..86208b86eea8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -16,6 +16,7 @@
 #endif
 
 #define MLX5_SFS_PER_CTRL_IRQ 64
+#define MLX5_MAX_MSIX_PER_SF 256
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
@@ -589,8 +590,6 @@ static void irq_pool_free(struct mlx5_irq_pool *pool)
 static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 {
 	struct mlx5_irq_table *table = dev->priv.irq_table;
-	int num_sf_ctrl_by_msix;
-	int num_sf_ctrl_by_sfs;
 	int num_sf_ctrl;
 	int err;
 
@@ -608,10 +607,8 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 	}
 
 	/* init sf_ctrl_pool */
-	num_sf_ctrl_by_msix = DIV_ROUND_UP(sf_vec, MLX5_COMP_EQS_PER_SF);
-	num_sf_ctrl_by_sfs = DIV_ROUND_UP(mlx5_sf_max_functions(dev),
-					  MLX5_SFS_PER_CTRL_IRQ);
-	num_sf_ctrl = min_t(int, num_sf_ctrl_by_msix, num_sf_ctrl_by_sfs);
+	num_sf_ctrl = DIV_ROUND_UP(mlx5_sf_max_functions(dev),
+				   MLX5_SFS_PER_CTRL_IRQ);
 	num_sf_ctrl = min_t(int, MLX5_IRQ_CTRL_SF_MAX, num_sf_ctrl);
 	table->sf_ctrl_pool = irq_pool_alloc(dev, pcif_vec, num_sf_ctrl,
 					     "mlx5_sf_ctrl",
@@ -726,8 +723,7 @@ int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 
 	total_vec = pcif_vec;
 	if (mlx5_sf_max_functions(dev))
-		total_vec += MLX5_IRQ_CTRL_SF_MAX +
-			MLX5_COMP_EQS_PER_SF * mlx5_sf_max_functions(dev);
+		total_vec += MLX5_MAX_MSIX_PER_SF * mlx5_sf_max_functions(dev);
 	total_vec = min_t(int, total_vec, pci_msix_vec_count(dev->pdev));
 	pcif_vec = min_t(int, pcif_vec, pci_msix_vec_count(dev->pdev));
 
-- 
2.45.2


