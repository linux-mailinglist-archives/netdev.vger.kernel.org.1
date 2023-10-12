Return-Path: <netdev+bounces-40449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68BD7C76BE
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D823282B2B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A73B29F;
	Thu, 12 Oct 2023 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnKXp9Qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C53CCF8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F82C433CA;
	Thu, 12 Oct 2023 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138884;
	bh=cTpVo3ClkIBXX6G/SMD+pUL56K8aY1GmOGL+WReQIno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnKXp9QjUFIRZp9KSpeVMXo6G3PAtyF/ABxNVzOjC5JdxmFCDwrW2gQWdTGL5/Qay
	 WF3XOTi131+DHW70FIPEdfTvgW/KU/DS4xaZs3HTW+Xt/gu39bIZTWXUmIsoz+smOd
	 eV7uiw0JqF7M+MLZDAQc99YCaqfjgsDgJ7DCHVyw6zzXLjxfj1xaQrplgmd7pMqZ0p
	 rRgCGibtX6st4lsGve1fm9POH5FBXDec31R/ziem9qgoATRlMX1eXcVnsoWD+71Xa8
	 LsxBYgT8T2GsGtX1qhvpFQBv8NOM5GkPVaJwYFRJdJqWtBYe9oDVkz2if/Ru7Lu58b
	 pdRACDUAtWCaA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next V2 12/15] net/mlx5e: Refactor mlx5e_rss_init() and mlx5e_rss_free() API's
Date: Thu, 12 Oct 2023 12:27:47 -0700
Message-ID: <20231012192750.124945-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Introduce code refactoring below:
1) Introduce single API for creating and destroying rss object,
   mlx5e_rss_create() and mlx5e_rss_destroy() respectively.
2) mlx5e_rss_create() constructs and initializes RSS object depends
   on a function new param enum mlx5e_rss_create_type. Callers (like
   rx_res.c) will no longer need to allocate RSS object via
   mlx5e_rss_alloc() and initialize it immediately via
   mlx5e_rss_init_no_tirs() or mlx5e_rss_init(), this will be done by
   a single call to mlx5e_rss_create(). Hence, mlx5e_rss_alloc() and
   mlx5e_rss_init_no_tirs() have been removed from rss.h file and became
   static functions.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 44 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  | 15 ++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 35 ++++-----------
 3 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index fd52541e5508..654b5c45e4a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -81,12 +81,12 @@ struct mlx5e_rss {
 	refcount_t refcnt;
 };
 
-struct mlx5e_rss *mlx5e_rss_alloc(void)
+static struct mlx5e_rss *mlx5e_rss_alloc(void)
 {
 	return kvzalloc(sizeof(struct mlx5e_rss), GFP_KERNEL);
 }
 
-void mlx5e_rss_free(struct mlx5e_rss *rss)
+static void mlx5e_rss_free(struct mlx5e_rss *rss)
 {
 	kvfree(rss);
 }
@@ -282,28 +282,35 @@ static int mlx5e_rss_update_tirs(struct mlx5e_rss *rss)
 	return retval;
 }
 
-int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss, struct mlx5_core_dev *mdev,
-			   bool inner_ft_support, u32 drop_rqn)
+static int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss)
 {
-	rss->mdev = mdev;
-	rss->inner_ft_support = inner_ft_support;
-	rss->drop_rqn = drop_rqn;
-
 	mlx5e_rss_params_init(rss);
 	refcount_set(&rss->refcnt, 1);
 
-	return mlx5e_rqt_init_direct(&rss->rqt, mdev, true, drop_rqn);
+	return mlx5e_rqt_init_direct(&rss->rqt, rss->mdev, true, rss->drop_rqn);
 }
 
-int mlx5e_rss_init(struct mlx5e_rss *rss, struct mlx5_core_dev *mdev,
-		   bool inner_ft_support, u32 drop_rqn,
-		   const struct mlx5e_packet_merge_param *init_pkt_merge_param)
+struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+				 enum mlx5e_rss_init_type type)
 {
+	struct mlx5e_rss *rss;
 	int err;
 
-	err = mlx5e_rss_init_no_tirs(rss, mdev, inner_ft_support, drop_rqn);
+	rss = mlx5e_rss_alloc();
+	if (!rss)
+		return ERR_PTR(-ENOMEM);
+
+	rss->mdev = mdev;
+	rss->inner_ft_support = inner_ft_support;
+	rss->drop_rqn = drop_rqn;
+
+	err = mlx5e_rss_init_no_tirs(rss);
 	if (err)
-		goto err_out;
+		goto err_free_rss;
+
+	if (type == MLX5E_RSS_INIT_NO_TIRS)
+		goto out;
 
 	err = mlx5e_rss_create_tirs(rss, init_pkt_merge_param, false);
 	if (err)
@@ -315,14 +322,16 @@ int mlx5e_rss_init(struct mlx5e_rss *rss, struct mlx5_core_dev *mdev,
 			goto err_destroy_tirs;
 	}
 
-	return 0;
+out:
+	return rss;
 
 err_destroy_tirs:
 	mlx5e_rss_destroy_tirs(rss, false);
 err_destroy_rqt:
 	mlx5e_rqt_destroy(&rss->rqt);
-err_out:
-	return err;
+err_free_rss:
+	mlx5e_rss_free(rss);
+	return ERR_PTR(err);
 }
 
 int mlx5e_rss_cleanup(struct mlx5e_rss *rss)
@@ -336,6 +345,7 @@ int mlx5e_rss_cleanup(struct mlx5e_rss *rss)
 		mlx5e_rss_destroy_tirs(rss, true);
 
 	mlx5e_rqt_destroy(&rss->rqt);
+	mlx5e_rss_free(rss);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index c6b216416344..8b2290727641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -8,18 +8,19 @@
 #include "tir.h"
 #include "fs.h"
 
+enum mlx5e_rss_init_type {
+	MLX5E_RSS_INIT_NO_TIRS = 0,
+	MLX5E_RSS_INIT_TIRS
+};
+
 struct mlx5e_rss_params_traffic_type
 mlx5e_rss_get_default_tt_config(enum mlx5_traffic_types tt);
 
 struct mlx5e_rss;
 
-struct mlx5e_rss *mlx5e_rss_alloc(void);
-void mlx5e_rss_free(struct mlx5e_rss *rss);
-int mlx5e_rss_init(struct mlx5e_rss *rss, struct mlx5_core_dev *mdev,
-		   bool inner_ft_support, u32 drop_rqn,
-		   const struct mlx5e_packet_merge_param *init_pkt_merge_param);
-int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss, struct mlx5_core_dev *mdev,
-			   bool inner_ft_support, u32 drop_rqn);
+struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+				 enum mlx5e_rss_init_type type);
 int mlx5e_rss_cleanup(struct mlx5e_rss *rss);
 
 void mlx5e_rss_refcnt_inc(struct mlx5e_rss *rss);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index abbd08b6d1a9..81b13338bfdf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -39,36 +39,27 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
 	struct mlx5e_rss *rss;
-	int err;
 
 	if (WARN_ON(res->rss[0]))
 		return -EINVAL;
 
-	rss = mlx5e_rss_alloc();
-	if (!rss)
-		return -ENOMEM;
-
-	err = mlx5e_rss_init(rss, res->mdev, inner_ft_support, res->drop_rqn,
-			     &res->pkt_merge_param);
-	if (err)
-		goto err_rss_free;
+	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
+			     &res->pkt_merge_param, MLX5E_RSS_INIT_TIRS);
+	if (IS_ERR(rss))
+		return PTR_ERR(rss);
 
 	mlx5e_rss_set_indir_uniform(rss, init_nch);
 
 	res->rss[0] = rss;
 
 	return 0;
-
-err_rss_free:
-	mlx5e_rss_free(rss);
-	return err;
 }
 
 int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int init_nch)
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
 	struct mlx5e_rss *rss;
-	int err, i;
+	int i;
 
 	for (i = 1; i < MLX5E_MAX_NUM_RSS; i++)
 		if (!res->rss[i])
@@ -77,13 +68,10 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int i
 	if (i == MLX5E_MAX_NUM_RSS)
 		return -ENOSPC;
 
-	rss = mlx5e_rss_alloc();
-	if (!rss)
-		return -ENOMEM;
-
-	err = mlx5e_rss_init_no_tirs(rss, res->mdev, inner_ft_support, res->drop_rqn);
-	if (err)
-		goto err_rss_free;
+	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
+			     &res->pkt_merge_param, MLX5E_RSS_INIT_NO_TIRS);
+	if (IS_ERR(rss))
+		return PTR_ERR(rss);
 
 	mlx5e_rss_set_indir_uniform(rss, init_nch);
 	if (res->rss_active)
@@ -93,10 +81,6 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int i
 	*rss_idx = i;
 
 	return 0;
-
-err_rss_free:
-	mlx5e_rss_free(rss);
-	return err;
 }
 
 static int __mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx)
@@ -108,7 +92,6 @@ static int __mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx)
 	if (err)
 		return err;
 
-	mlx5e_rss_free(rss);
 	res->rss[rss_idx] = NULL;
 
 	return 0;
-- 
2.41.0


