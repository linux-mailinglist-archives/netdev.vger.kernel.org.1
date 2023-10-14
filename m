Return-Path: <netdev+bounces-41025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2C7C95A9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566B5B20D1E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080126E27;
	Sat, 14 Oct 2023 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmv9JEo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5D26E20
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F118C433C7;
	Sat, 14 Oct 2023 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303976;
	bh=GXVGdCLPqWxyof5wUJZCmzqbYE7DC7crXYlYrivXCaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qmv9JEo7STGfnFKcZf3UkR+aoATGe9+f1wiYEp6BzEQlElvoZ4ZxT6LApojkCb32G
	 fwCIwdVmcn5FbBuZUBRUp5yG/YD3EatAyRxli2H4YYkeaD1TENU0C5Fxf/1NYw1GXu
	 nS1wEnIxIFH6yEeka5DS4PjVkHDm7Jc6/YaUMtSEHTztTA+pZD1ETmUO10IbvYyyVY
	 0y3rodmo4h7ptI7JgIq9DqqHnP5gC1z+o4JGRMzO7GwAd6aj6alYthIXlMQER+Y8AS
	 N9B5x18mEWTTzOiD807HniJAMzhw+NbaMjJCz1l9jWHnTPv2Q8dwvQvypn52YPHMgb
	 Tn/DsxJ6ziaXA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 13/15] net/mlx5e: Preparations for supporting larger number of channels
Date: Sat, 14 Oct 2023 10:19:06 -0700
Message-ID: <20231014171908.290428-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Data center server CPUs number keeps getting larger with time.
Currently, our driver limits the number of channels to 128.

Maximum channels number is enforced and bounded by hardcoded
defines (en.h/MLX5E_MAX_NUM_CHANNELS) even though the device and machine
(CPUs num) can allow more.

Refactor current implementation in order to handle further channels.

The maximum supported channels number will be increased in the followup
patch.

Introduce RQT size calculation/allocation scheme below:
1) Preserve current RQT size of 256 for channels number up to 128 (the
   old limit).
2) For greater channels number, RQT size is calculated by multiplying
   the channels number by 2 and rounding up the result to the nearest
   power of 2. If the calculated RQT size exceeds the maximum supported
   size by the NIC, fallback to this maximum RQT size
   (1 << log_max_rqt_size).

Since RQT size is no more static, allocate and free the indirection
table SW shadow dynamically.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  32 ++++--
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 108 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   7 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  42 +++++--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +--
 10 files changed, 178 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2b3254e33fe5..be8f62998ac2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -141,7 +141,7 @@ struct page_pool;
 #define MLX5E_PARAMS_DEFAULT_MIN_RX_WQES_MPW            0x2
 
 #define MLX5E_MIN_NUM_CHANNELS         0x1
-#define MLX5E_MAX_NUM_CHANNELS         (MLX5E_INDIR_RQT_SIZE / 2)
+#define MLX5E_MAX_NUM_CHANNELS         128
 #define MLX5E_TX_CQ_POLL_BUDGET        128
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
@@ -200,7 +200,8 @@ static inline int mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
 {
 	return is_kdump_kernel() ?
 		MLX5E_MIN_NUM_CHANNELS :
-		min_t(int, mlx5_comp_vectors_max(mdev), MLX5E_MAX_NUM_CHANNELS);
+		min3(mlx5_comp_vectors_max(mdev), (u32)MLX5E_MAX_NUM_CHANNELS,
+		     (u32)(1 << MLX5_CAP_GEN(mdev, log_max_rqt_size)));
 }
 
 /* The maximum WQE size can be retrieved by max_wqe_sz_sq in
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index b915fb29dd2c..7b8ff7a71003 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -9,7 +9,7 @@ void mlx5e_rss_params_indir_init_uniform(struct mlx5e_rss_params_indir *indir,
 {
 	unsigned int i;
 
-	for (i = 0; i < MLX5E_INDIR_RQT_SIZE; i++)
+	for (i = 0; i < indir->actual_table_size; i++)
 		indir->table[i] = i % num_channels;
 }
 
@@ -45,9 +45,9 @@ static int mlx5e_rqt_init(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 }
 
 int mlx5e_rqt_init_direct(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
-			  bool indir_enabled, u32 init_rqn)
+			  bool indir_enabled, u32 init_rqn, u32 indir_table_size)
 {
-	u16 max_size = indir_enabled ? MLX5E_INDIR_RQT_SIZE : 1;
+	u16 max_size = indir_enabled ? indir_table_size : 1;
 
 	return mlx5e_rqt_init(rqt, mdev, max_size, &init_rqn, 1);
 }
@@ -68,11 +68,11 @@ static int mlx5e_calc_indir_rqns(u32 *rss_rqns, u32 *rqns, unsigned int num_rqns
 {
 	unsigned int i;
 
-	for (i = 0; i < MLX5E_INDIR_RQT_SIZE; i++) {
+	for (i = 0; i < indir->actual_table_size; i++) {
 		unsigned int ix = i;
 
 		if (hfunc == ETH_RSS_HASH_XOR)
-			ix = mlx5e_bits_invert(ix, ilog2(MLX5E_INDIR_RQT_SIZE));
+			ix = mlx5e_bits_invert(ix, ilog2(indir->actual_table_size));
 
 		ix = indir->table[ix];
 
@@ -94,7 +94,7 @@ int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 	u32 *rss_rqns;
 	int err;
 
-	rss_rqns = kvmalloc_array(MLX5E_INDIR_RQT_SIZE, sizeof(*rss_rqns), GFP_KERNEL);
+	rss_rqns = kvmalloc_array(indir->actual_table_size, sizeof(*rss_rqns), GFP_KERNEL);
 	if (!rss_rqns)
 		return -ENOMEM;
 
@@ -102,13 +102,25 @@ int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 	if (err)
 		goto out;
 
-	err = mlx5e_rqt_init(rqt, mdev, MLX5E_INDIR_RQT_SIZE, rss_rqns, MLX5E_INDIR_RQT_SIZE);
+	err = mlx5e_rqt_init(rqt, mdev, indir->max_table_size, rss_rqns,
+			     indir->actual_table_size);
 
 out:
 	kvfree(rss_rqns);
 	return err;
 }
 
+#define MLX5E_UNIFORM_SPREAD_RQT_FACTOR 2
+
+u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels)
+{
+	u32 rqt_size = max_t(u32, MLX5E_INDIR_MIN_RQT_SIZE,
+			     roundup_pow_of_two(num_channels * MLX5E_UNIFORM_SPREAD_RQT_FACTOR));
+	u32 max_cap_rqt_size = 1 << MLX5_CAP_GEN(mdev, log_max_rqt_size);
+
+	return min_t(u32, rqt_size, max_cap_rqt_size);
+}
+
 void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt)
 {
 	mlx5_core_destroy_rqt(rqt->mdev, rqt->rqtn);
@@ -151,10 +163,10 @@ int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_
 	u32 *rss_rqns;
 	int err;
 
-	if (WARN_ON(rqt->size != MLX5E_INDIR_RQT_SIZE))
+	if (WARN_ON(rqt->size != indir->max_table_size))
 		return -EINVAL;
 
-	rss_rqns = kvmalloc_array(MLX5E_INDIR_RQT_SIZE, sizeof(*rss_rqns), GFP_KERNEL);
+	rss_rqns = kvmalloc_array(indir->actual_table_size, sizeof(*rss_rqns), GFP_KERNEL);
 	if (!rss_rqns)
 		return -ENOMEM;
 
@@ -162,7 +174,7 @@ int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_
 	if (err)
 		goto out;
 
-	err = mlx5e_rqt_redirect(rqt, rss_rqns, MLX5E_INDIR_RQT_SIZE);
+	err = mlx5e_rqt_redirect(rqt, rss_rqns, indir->actual_table_size);
 
 out:
 	kvfree(rss_rqns);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index 60c985a12f24..77fba3ebd18d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -6,12 +6,14 @@
 
 #include <linux/kernel.h>
 
-#define MLX5E_INDIR_RQT_SIZE (1 << 8)
+#define MLX5E_INDIR_MIN_RQT_SIZE (BIT(8))
 
 struct mlx5_core_dev;
 
 struct mlx5e_rss_params_indir {
-	u32 table[MLX5E_INDIR_RQT_SIZE];
+	u32 *table;
+	u32 actual_table_size;
+	u32 max_table_size;
 };
 
 void mlx5e_rss_params_indir_init_uniform(struct mlx5e_rss_params_indir *indir,
@@ -24,7 +26,7 @@ struct mlx5e_rqt {
 };
 
 int mlx5e_rqt_init_direct(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
-			  bool indir_enabled, u32 init_rqn);
+			  bool indir_enabled, u32 init_rqn, u32 indir_table_size);
 int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 			 u32 *rqns, unsigned int num_rqns,
 			 u8 hfunc, struct mlx5e_rss_params_indir *indir);
@@ -35,6 +37,7 @@ static inline u32 mlx5e_rqt_get_rqtn(struct mlx5e_rqt *rqt)
 	return rqt->rqtn;
 }
 
+u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels);
 int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn);
 int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_rqns,
 			     u8 hfunc, struct mlx5e_rss_params_indir *indir);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 654b5c45e4a5..c1545a2e8d6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -81,14 +81,75 @@ struct mlx5e_rss {
 	refcount_t refcnt;
 };
 
-static struct mlx5e_rss *mlx5e_rss_alloc(void)
+void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels)
 {
-	return kvzalloc(sizeof(struct mlx5e_rss), GFP_KERNEL);
+	rss->indir.actual_table_size = mlx5e_rqt_size(rss->mdev, num_channels);
 }
 
-static void mlx5e_rss_free(struct mlx5e_rss *rss)
+int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir, struct mlx5_core_dev *mdev,
+				u32 actual_table_size, u32 max_table_size)
 {
+	indir->table = kvmalloc_array(max_table_size, sizeof(*indir->table), GFP_KERNEL);
+	if (!indir->table)
+		return -ENOMEM;
+
+	indir->max_table_size = max_table_size;
+	indir->actual_table_size = actual_table_size;
+
+	return 0;
+}
+
+void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir)
+{
+	kvfree(indir->table);
+}
+
+static int mlx5e_rss_copy(struct mlx5e_rss *to, const struct mlx5e_rss *from)
+{
+	u32 *dst_indir_table;
+
+	if (to->indir.actual_table_size != from->indir.actual_table_size ||
+	    to->indir.max_table_size != from->indir.max_table_size) {
+		mlx5e_rss_warn(to->mdev,
+			       "Failed to copy RSS due to size mismatch, src (actual %u, max %u) != dst (actual %u, max %u)\n",
+			       from->indir.actual_table_size, from->indir.max_table_size,
+			       to->indir.actual_table_size, to->indir.max_table_size);
+		return -EINVAL;
+	}
+
+	dst_indir_table = to->indir.table;
+	*to = *from;
+	to->indir.table = dst_indir_table;
+	memcpy(to->indir.table, from->indir.table,
+	       from->indir.actual_table_size * sizeof(*from->indir.table));
+	return 0;
+}
+
+static struct mlx5e_rss *mlx5e_rss_init_copy(const struct mlx5e_rss *from)
+{
+	struct mlx5e_rss *rss;
+	int err;
+
+	rss = kvzalloc(sizeof(*rss), GFP_KERNEL);
+	if (!rss)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlx5e_rss_params_indir_init(&rss->indir, from->mdev, from->indir.actual_table_size,
+					  from->indir.max_table_size);
+	if (err)
+		goto err_free_rss;
+
+	err = mlx5e_rss_copy(rss, from);
+	if (err)
+		goto err_free_indir;
+
+	return rss;
+
+err_free_indir:
+	mlx5e_rss_params_indir_cleanup(&rss->indir);
+err_free_rss:
 	kvfree(rss);
+	return ERR_PTR(err);
 }
 
 static void mlx5e_rss_params_init(struct mlx5e_rss *rss)
@@ -287,27 +348,35 @@ static int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss)
 	mlx5e_rss_params_init(rss);
 	refcount_set(&rss->refcnt, 1);
 
-	return mlx5e_rqt_init_direct(&rss->rqt, rss->mdev, true, rss->drop_rqn);
+	return mlx5e_rqt_init_direct(&rss->rqt, rss->mdev, true,
+				     rss->drop_rqn, rss->indir.max_table_size);
 }
 
 struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
 				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				 enum mlx5e_rss_init_type type)
+				 enum mlx5e_rss_init_type type, unsigned int nch,
+				 unsigned int max_nch)
 {
 	struct mlx5e_rss *rss;
 	int err;
 
-	rss = mlx5e_rss_alloc();
+	rss = kvzalloc(sizeof(*rss), GFP_KERNEL);
 	if (!rss)
 		return ERR_PTR(-ENOMEM);
 
+	err = mlx5e_rss_params_indir_init(&rss->indir, mdev,
+					  mlx5e_rqt_size(mdev, nch),
+					  mlx5e_rqt_size(mdev, max_nch));
+	if (err)
+		goto err_free_rss;
+
 	rss->mdev = mdev;
 	rss->inner_ft_support = inner_ft_support;
 	rss->drop_rqn = drop_rqn;
 
 	err = mlx5e_rss_init_no_tirs(rss);
 	if (err)
-		goto err_free_rss;
+		goto err_free_indir;
 
 	if (type == MLX5E_RSS_INIT_NO_TIRS)
 		goto out;
@@ -329,8 +398,10 @@ struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_suppo
 	mlx5e_rss_destroy_tirs(rss, false);
 err_destroy_rqt:
 	mlx5e_rqt_destroy(&rss->rqt);
+err_free_indir:
+	mlx5e_rss_params_indir_cleanup(&rss->indir);
 err_free_rss:
-	mlx5e_rss_free(rss);
+	kvfree(rss);
 	return ERR_PTR(err);
 }
 
@@ -345,7 +416,8 @@ int mlx5e_rss_cleanup(struct mlx5e_rss *rss)
 		mlx5e_rss_destroy_tirs(rss, true);
 
 	mlx5e_rqt_destroy(&rss->rqt);
-	mlx5e_rss_free(rss);
+	mlx5e_rss_params_indir_cleanup(&rss->indir);
+	kvfree(rss);
 
 	return 0;
 }
@@ -482,7 +554,7 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
-		       MLX5E_INDIR_RQT_SIZE * sizeof(*rss->indir.table));
+		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
 
 	if (key)
 		memcpy(key, rss->hash.toeplitz_hash_key,
@@ -503,11 +575,9 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 	struct mlx5e_rss *old_rss;
 	int err = 0;
 
-	old_rss = mlx5e_rss_alloc();
-	if (!old_rss)
-		return -ENOMEM;
-
-	*old_rss = *rss;
+	old_rss = mlx5e_rss_init_copy(rss);
+	if (IS_ERR(old_rss))
+		return PTR_ERR(old_rss);
 
 	if (hfunc && *hfunc != rss->hash.hfunc) {
 		switch (*hfunc) {
@@ -534,13 +604,13 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		changed_indir = true;
 
 		memcpy(rss->indir.table, indir,
-		       MLX5E_INDIR_RQT_SIZE * sizeof(*rss->indir.table));
+		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
 	}
 
 	if (changed_indir && rss->enabled) {
 		err = mlx5e_rss_apply(rss, rqns, num_rqns);
 		if (err) {
-			*rss = *old_rss;
+			mlx5e_rss_copy(rss, old_rss);
 			goto out;
 		}
 	}
@@ -549,7 +619,9 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		mlx5e_rss_update_tirs(rss);
 
 out:
-	mlx5e_rss_free(old_rss);
+	mlx5e_rss_params_indir_cleanup(&old_rss->indir);
+	kvfree(old_rss);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 8b2290727641..d1d0bc350e92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -18,9 +18,14 @@ mlx5e_rss_get_default_tt_config(enum mlx5_traffic_types tt);
 
 struct mlx5e_rss;
 
+int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir, struct mlx5_core_dev *mdev,
+				u32 actual_table_size, u32 max_table_size);
+void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
+void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels);
 struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
 				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				 enum mlx5e_rss_init_type type);
+				 enum mlx5e_rss_init_type type, unsigned int nch,
+				 unsigned int max_nch);
 int mlx5e_rss_cleanup(struct mlx5e_rss *rss);
 
 void mlx5e_rss_refcnt_inc(struct mlx5e_rss *rss);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 81b13338bfdf..b23e224e3763 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -18,7 +18,7 @@ struct mlx5e_rx_res {
 
 	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
 	bool rss_active;
-	u32 rss_rqns[MLX5E_INDIR_RQT_SIZE];
+	u32 *rss_rqns;
 	unsigned int rss_nch;
 
 	struct {
@@ -34,6 +34,16 @@ struct mlx5e_rx_res {
 
 /* API for rx_res_rss_* */
 
+void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch)
+{
+	int i;
+
+	for (i = 0; i < MLX5E_MAX_NUM_RSS; i++) {
+		if (res->rss[i])
+			mlx5e_rss_params_indir_modify_actual_size(res->rss[i], nch);
+	}
+}
+
 static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 				     unsigned int init_nch)
 {
@@ -44,7 +54,7 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 		return -EINVAL;
 
 	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &res->pkt_merge_param, MLX5E_RSS_INIT_TIRS);
+			     &res->pkt_merge_param, MLX5E_RSS_INIT_TIRS, init_nch, res->max_nch);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
@@ -69,7 +79,8 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int i
 		return -ENOSPC;
 
 	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &res->pkt_merge_param, MLX5E_RSS_INIT_NO_TIRS);
+			     &res->pkt_merge_param, MLX5E_RSS_INIT_NO_TIRS, init_nch,
+			     res->max_nch);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
@@ -269,12 +280,25 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
 
 static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
 {
+	kvfree(res->rss_rqns);
 	kvfree(res);
 }
 
-static struct mlx5e_rx_res *mlx5e_rx_res_alloc(void)
+static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsigned int max_nch)
 {
-	return kvzalloc(sizeof(struct mlx5e_rx_res), GFP_KERNEL);
+	struct mlx5e_rx_res *rx_res;
+
+	rx_res = kvzalloc(sizeof(*rx_res), GFP_KERNEL);
+	if (!rx_res)
+		return NULL;
+
+	rx_res->rss_rqns = kvcalloc(max_nch, sizeof(*rx_res->rss_rqns), GFP_KERNEL);
+	if (!rx_res->rss_rqns) {
+		kvfree(rx_res);
+		return NULL;
+	}
+
+	return rx_res;
 }
 
 static int mlx5e_rx_res_channels_init(struct mlx5e_rx_res *res)
@@ -296,7 +320,8 @@ static int mlx5e_rx_res_channels_init(struct mlx5e_rx_res *res)
 
 	for (ix = 0; ix < res->max_nch; ix++) {
 		err = mlx5e_rqt_init_direct(&res->channels[ix].direct_rqt,
-					    res->mdev, false, res->drop_rqn);
+					    res->mdev, false, res->drop_rqn,
+					    mlx5e_rqt_size(res->mdev, res->max_nch));
 		if (err) {
 			mlx5_core_warn(res->mdev, "Failed to create a direct RQT: err = %d, ix = %u\n",
 				       err, ix);
@@ -350,7 +375,8 @@ static int mlx5e_rx_res_ptp_init(struct mlx5e_rx_res *res)
 	if (!builder)
 		return -ENOMEM;
 
-	err = mlx5e_rqt_init_direct(&res->ptp.rqt, res->mdev, false, res->drop_rqn);
+	err = mlx5e_rqt_init_direct(&res->ptp.rqt, res->mdev, false, res->drop_rqn,
+				    mlx5e_rqt_size(res->mdev, res->max_nch));
 	if (err)
 		goto out;
 
@@ -401,7 +427,7 @@ mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features featu
 	struct mlx5e_rx_res *res;
 	int err;
 
-	res = mlx5e_rx_res_alloc();
+	res = mlx5e_rx_res_alloc(mdev, max_nch);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 4fa8366db31f..82aaba8a82b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -59,6 +59,7 @@ int mlx5e_rx_res_rss_destroy(struct mlx5e_rx_res *res, u32 rss_idx);
 int mlx5e_rx_res_rss_cnt(struct mlx5e_rx_res *res);
 int mlx5e_rx_res_rss_index(struct mlx5e_rx_res *res, struct mlx5e_rss *rss);
 struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx);
+void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch);
 
 /* Workaround for hairpin */
 struct mlx5e_rss_params_hash mlx5e_rx_res_get_current_hash(struct mlx5e_rx_res *res);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index dff02434ff45..215261a69255 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1247,7 +1247,7 @@ static u32 mlx5e_get_rxfh_key_size(struct net_device *netdev)
 
 u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv)
 {
-	return MLX5E_INDIR_RQT_SIZE;
+	return mlx5e_rqt_size(priv->mdev, priv->channels.params.num_channels);
 }
 
 static u32 mlx5e_get_rxfh_indir_size(struct net_device *netdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5daec30380fc..9325b8f00af0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2948,8 +2948,12 @@ static int mlx5e_num_channels_changed(struct mlx5e_priv *priv)
 	mlx5e_set_default_xps_cpumasks(priv, &priv->channels.params);
 
 	/* This function may be called on attach, before priv->rx_res is created. */
-	if (!netif_is_rxfh_configured(priv->netdev) && priv->rx_res)
-		mlx5e_rx_res_rss_set_indir_uniform(priv->rx_res, count);
+	if (priv->rx_res) {
+		mlx5e_rx_res_rss_update_num_channels(priv->rx_res, count);
+
+		if (!netif_is_rxfh_configured(priv->netdev))
+			mlx5e_rx_res_rss_set_indir_uniform(priv->rx_res, count);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index c24828b688ac..4e09ebcfff3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -753,19 +753,21 @@ static int mlx5e_hairpin_create_indirect_rqt(struct mlx5e_hairpin *hp)
 {
 	struct mlx5e_priv *priv = hp->func_priv;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	struct mlx5e_rss_params_indir *indir;
+	struct mlx5e_rss_params_indir indir;
 	int err;
 
-	indir = kvmalloc(sizeof(*indir), GFP_KERNEL);
-	if (!indir)
-		return -ENOMEM;
+	err = mlx5e_rss_params_indir_init(&indir, mdev,
+					  mlx5e_rqt_size(mdev, hp->num_channels),
+					  mlx5e_rqt_size(mdev, priv->max_nch));
+	if (err)
+		return err;
 
-	mlx5e_rss_params_indir_init_uniform(indir, hp->num_channels);
+	mlx5e_rss_params_indir_init_uniform(&indir, hp->num_channels);
 	err = mlx5e_rqt_init_indir(&hp->indir_rqt, mdev, hp->pair->rqn, hp->num_channels,
 				   mlx5e_rx_res_get_current_hash(priv->rx_res).hfunc,
-				   indir);
+				   &indir);
 
-	kvfree(indir);
+	mlx5e_rss_params_indir_cleanup(&indir);
 	return err;
 }
 
-- 
2.41.0


