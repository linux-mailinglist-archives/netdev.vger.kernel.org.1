Return-Path: <netdev+bounces-77751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360B872D31
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F09028E4DF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479E18EB8;
	Wed,  6 Mar 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/nriq5L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50518EA8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694201; cv=none; b=re9SOlxr8oJ0gCHjkxJLGUk2KSuTAsY1+wzf/1NkG7Tt51gajRxGqAke/WaHJ93wbmdedMpQtFIf3dqGrRy6hBr8mFUMXDGvRB4+jPxQ7N5cUKKq9e+9DLATCaqFluv3t3bhUbiYGMQBYiIq/pEOu8iVAw7PQrHz0YQ+pe/3qA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694201; c=relaxed/simple;
	bh=5Vb3j8j1QYNBZ3YithQP4qpzyl1tKhiVEagkOUJDsPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWUTd6zqXz/XyIg+0v6VgIsHCUWjRKQKQ1/Sr8wFK2S3q7oQbksA3mLjirOA70tlGz9jYFheTGvl13/tZ/rmp9WiRh1SJ6yxnNICL7W7Rjr0F/I6d4glUDzotWhOKEo0v7SkHyB7X9Yb0T+qbtd8CZvrJLbkl9cuIFCQHiKrhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/nriq5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D345DC433C7;
	Wed,  6 Mar 2024 03:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694201;
	bh=5Vb3j8j1QYNBZ3YithQP4qpzyl1tKhiVEagkOUJDsPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/nriq5Lq8YNiahJKTAhvtjzJuTP2igvAqzR8W6jpDzhtM/owSqo/k8A6+y+3iitm
	 aroPCuauRXKLi8IC7Wu4WKZgriYD7mo37XoGoAciEflraWmBMAxhAr7JnN5doJO0Ks
	 yUd8nAfe5QL42AFoDeOUzt8tDD6tZxVTQfBoN9Zgg38kbYTGrdakE/lB92N1eby4LC
	 RxXURcM7Hn4PqeASTTJszE6UINY+pUtsziqiSUgcZssNy8TadQF3rJGys7zYRhHIqc
	 dtCAkCW0K5q7CAeqN3ilBR0xnjyDWMI958Cjb0FwdNt7xayR1jtMrqn96t2Jv/h5Ce
	 nGTrwXkL8vR8w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V5 11/15] net/mlx5e: Support cross-vhca RSS
Date: Tue,  5 Mar 2024 19:02:54 -0800
Message-ID: <20240306030258.16874-12-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Implement driver support for the HW feature that allows RX steering of
one device to target other device's RQs.

In SD multi-pf netdev mode, we set the secondaries into silent mode,
disconnecting them from the network. This feature is then used to steer
traffic from the primary to the secondaries.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/channels.c |  10 +-
 .../ethernet/mellanox/mlx5/core/en/channels.h |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  | 123 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |  17 +--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  62 ++++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   2 +-
 10 files changed, 179 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
index 48581ea3adcb..874a1016623c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
@@ -23,20 +23,26 @@ bool mlx5e_channels_is_xsk(struct mlx5e_channels *chs, unsigned int ix)
 	return test_bit(MLX5E_CHANNEL_STATE_XSK, c->state);
 }
 
-void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn)
+void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn,
+				    u32 *vhca_id)
 {
 	struct mlx5e_channel *c = mlx5e_channels_get(chs, ix);
 
 	*rqn = c->rq.rqn;
+	if (vhca_id)
+		*vhca_id = MLX5_CAP_GEN(c->mdev, vhca_id);
 }
 
-void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn)
+void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn,
+				u32 *vhca_id)
 {
 	struct mlx5e_channel *c = mlx5e_channels_get(chs, ix);
 
 	WARN_ON_ONCE(!test_bit(MLX5E_CHANNEL_STATE_XSK, c->state));
 
 	*rqn = c->xskrq.rqn;
+	if (vhca_id)
+		*vhca_id = MLX5_CAP_GEN(c->mdev, vhca_id);
 }
 
 bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
index 637ca90daaa8..6715aa9383b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
@@ -10,8 +10,10 @@ struct mlx5e_channels;
 
 unsigned int mlx5e_channels_get_num(struct mlx5e_channels *chs);
 bool mlx5e_channels_is_xsk(struct mlx5e_channels *chs, unsigned int ix);
-void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
-void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
+void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn,
+				    u32 *vhca_id);
+void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn,
+				u32 *vhca_id);
 bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn);
 
 #endif /* __MLX5_EN_CHANNELS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index 7b8ff7a71003..bcafb4bf9415 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -4,6 +4,33 @@
 #include "rqt.h"
 #include <linux/mlx5/transobj.h>
 
+static bool verify_num_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
+				unsigned int size)
+{
+	unsigned int max_num_vhca_id = MLX5_CAP_GEN_2(mdev, max_rqt_vhca_id);
+	int i;
+
+	/* Verify that all vhca_ids are in range [0, max_num_vhca_ids - 1] */
+	for (i = 0; i < size; i++)
+		if (vhca_ids[i] >= max_num_vhca_id)
+			return false;
+	return true;
+}
+
+static bool rqt_verify_vhca_ids(struct mlx5_core_dev *mdev, u32 *vhca_ids,
+				unsigned int size)
+{
+	if (!vhca_ids)
+		return true;
+
+	if (!MLX5_CAP_GEN(mdev, cross_vhca_rqt))
+		return false;
+	if (!verify_num_vhca_ids(mdev, vhca_ids, size))
+		return false;
+
+	return true;
+}
+
 void mlx5e_rss_params_indir_init_uniform(struct mlx5e_rss_params_indir *indir,
 					 unsigned int num_channels)
 {
@@ -13,19 +40,38 @@ void mlx5e_rss_params_indir_init_uniform(struct mlx5e_rss_params_indir *indir,
 		indir->table[i] = i % num_channels;
 }
 
+static void fill_rqn_list(void *rqtc, u32 *rqns, u32 *vhca_ids, unsigned int size)
+{
+	unsigned int i;
+
+	if (vhca_ids) {
+		MLX5_SET(rqtc, rqtc, rq_vhca_id_format, 1);
+		for (i = 0; i < size; i++) {
+			MLX5_SET(rqtc, rqtc, rq_vhca[i].rq_num, rqns[i]);
+			MLX5_SET(rqtc, rqtc, rq_vhca[i].rq_vhca_id, vhca_ids[i]);
+		}
+	} else {
+		for (i = 0; i < size; i++)
+			MLX5_SET(rqtc, rqtc, rq_num[i], rqns[i]);
+	}
+}
 static int mlx5e_rqt_init(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
-			  u16 max_size, u32 *init_rqns, u16 init_size)
+			  u16 max_size, u32 *init_rqns, u32 *init_vhca_ids, u16 init_size)
 {
+	int entry_sz;
 	void *rqtc;
 	int inlen;
 	int err;
 	u32 *in;
-	int i;
+
+	if (!rqt_verify_vhca_ids(mdev, init_vhca_ids, init_size))
+		return -EOPNOTSUPP;
 
 	rqt->mdev = mdev;
 	rqt->size = max_size;
 
-	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + sizeof(u32) * init_size;
+	entry_sz = init_vhca_ids ? MLX5_ST_SZ_BYTES(rq_vhca) : MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + entry_sz * init_size;
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -33,10 +79,9 @@ static int mlx5e_rqt_init(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
 
 	MLX5_SET(rqtc, rqtc, rqt_max_size, rqt->size);
-
 	MLX5_SET(rqtc, rqtc, rqt_actual_size, init_size);
-	for (i = 0; i < init_size; i++)
-		MLX5_SET(rqtc, rqtc, rq_num[i], init_rqns[i]);
+
+	fill_rqn_list(rqtc, init_rqns, init_vhca_ids, init_size);
 
 	err = mlx5_core_create_rqt(rqt->mdev, in, inlen, &rqt->rqtn);
 
@@ -49,7 +94,7 @@ int mlx5e_rqt_init_direct(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 {
 	u16 max_size = indir_enabled ? indir_table_size : 1;
 
-	return mlx5e_rqt_init(rqt, mdev, max_size, &init_rqn, 1);
+	return mlx5e_rqt_init(rqt, mdev, max_size, &init_rqn, NULL, 1);
 }
 
 static int mlx5e_bits_invert(unsigned long a, int size)
@@ -63,7 +108,8 @@ static int mlx5e_bits_invert(unsigned long a, int size)
 	return inv;
 }
 
-static int mlx5e_calc_indir_rqns(u32 *rss_rqns, u32 *rqns, unsigned int num_rqns,
+static int mlx5e_calc_indir_rqns(u32 *rss_rqns, u32 *rqns, u32 *rss_vhca_ids, u32 *vhca_ids,
+				 unsigned int num_rqns,
 				 u8 hfunc, struct mlx5e_rss_params_indir *indir)
 {
 	unsigned int i;
@@ -82,30 +128,42 @@ static int mlx5e_calc_indir_rqns(u32 *rss_rqns, u32 *rqns, unsigned int num_rqns
 			 */
 			return -EINVAL;
 		rss_rqns[i] = rqns[ix];
+		if (vhca_ids)
+			rss_vhca_ids[i] = vhca_ids[ix];
 	}
 
 	return 0;
 }
 
 int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
-			 u32 *rqns, unsigned int num_rqns,
+			 u32 *rqns, u32 *vhca_ids, unsigned int num_rqns,
 			 u8 hfunc, struct mlx5e_rss_params_indir *indir)
 {
-	u32 *rss_rqns;
+	u32 *rss_rqns, *rss_vhca_ids = NULL;
 	int err;
 
 	rss_rqns = kvmalloc_array(indir->actual_table_size, sizeof(*rss_rqns), GFP_KERNEL);
 	if (!rss_rqns)
 		return -ENOMEM;
 
-	err = mlx5e_calc_indir_rqns(rss_rqns, rqns, num_rqns, hfunc, indir);
+	if (vhca_ids) {
+		rss_vhca_ids = kvmalloc_array(indir->actual_table_size, sizeof(*rss_vhca_ids),
+					      GFP_KERNEL);
+		if (!rss_vhca_ids) {
+			kvfree(rss_rqns);
+			return -ENOMEM;
+		}
+	}
+
+	err = mlx5e_calc_indir_rqns(rss_rqns, rqns, rss_vhca_ids, vhca_ids, num_rqns, hfunc, indir);
 	if (err)
 		goto out;
 
-	err = mlx5e_rqt_init(rqt, mdev, indir->max_table_size, rss_rqns,
+	err = mlx5e_rqt_init(rqt, mdev, indir->max_table_size, rss_rqns, rss_vhca_ids,
 			     indir->actual_table_size);
 
 out:
+	kvfree(rss_vhca_ids);
 	kvfree(rss_rqns);
 	return err;
 }
@@ -126,15 +184,20 @@ void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt)
 	mlx5_core_destroy_rqt(rqt->mdev, rqt->rqtn);
 }
 
-static int mlx5e_rqt_redirect(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int size)
+static int mlx5e_rqt_redirect(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
+			      unsigned int size)
 {
-	unsigned int i;
+	int entry_sz;
 	void *rqtc;
 	int inlen;
 	u32 *in;
 	int err;
 
-	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + sizeof(u32) * size;
+	if (!rqt_verify_vhca_ids(rqt->mdev, vhca_ids, size))
+		return -EINVAL;
+
+	entry_sz = vhca_ids ? MLX5_ST_SZ_BYTES(rq_vhca) : MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + entry_sz * size;
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -143,8 +206,8 @@ static int mlx5e_rqt_redirect(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int siz
 
 	MLX5_SET(modify_rqt_in, in, bitmask.rqn_list, 1);
 	MLX5_SET(rqtc, rqtc, rqt_actual_size, size);
-	for (i = 0; i < size; i++)
-		MLX5_SET(rqtc, rqtc, rq_num[i], rqns[i]);
+
+	fill_rqn_list(rqtc, rqns, vhca_ids, size);
 
 	err = mlx5_core_modify_rqt(rqt->mdev, rqt->rqtn, in, inlen);
 
@@ -152,17 +215,21 @@ static int mlx5e_rqt_redirect(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int siz
 	return err;
 }
 
-int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn)
+int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn, u32 *vhca_id)
 {
-	return mlx5e_rqt_redirect(rqt, &rqn, 1);
+	return mlx5e_rqt_redirect(rqt, &rqn, vhca_id, 1);
 }
 
-int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_rqns,
+int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
+			     unsigned int num_rqns,
 			     u8 hfunc, struct mlx5e_rss_params_indir *indir)
 {
-	u32 *rss_rqns;
+	u32 *rss_rqns, *rss_vhca_ids = NULL;
 	int err;
 
+	if (!rqt_verify_vhca_ids(rqt->mdev, vhca_ids, num_rqns))
+		return -EINVAL;
+
 	if (WARN_ON(rqt->size != indir->max_table_size))
 		return -EINVAL;
 
@@ -170,13 +237,23 @@ int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_
 	if (!rss_rqns)
 		return -ENOMEM;
 
-	err = mlx5e_calc_indir_rqns(rss_rqns, rqns, num_rqns, hfunc, indir);
+	if (vhca_ids) {
+		rss_vhca_ids = kvmalloc_array(indir->actual_table_size, sizeof(*rss_vhca_ids),
+					      GFP_KERNEL);
+		if (!rss_vhca_ids) {
+			kvfree(rss_rqns);
+			return -ENOMEM;
+		}
+	}
+
+	err = mlx5e_calc_indir_rqns(rss_rqns, rqns, rss_vhca_ids, vhca_ids, num_rqns, hfunc, indir);
 	if (err)
 		goto out;
 
-	err = mlx5e_rqt_redirect(rqt, rss_rqns, indir->actual_table_size);
+	err = mlx5e_rqt_redirect(rqt, rss_rqns, rss_vhca_ids, indir->actual_table_size);
 
 out:
+	kvfree(rss_vhca_ids);
 	kvfree(rss_rqns);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index 77fba3ebd18d..e0bc30308c77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -20,7 +20,7 @@ void mlx5e_rss_params_indir_init_uniform(struct mlx5e_rss_params_indir *indir,
 					 unsigned int num_channels);
 
 struct mlx5e_rqt {
-	struct mlx5_core_dev *mdev;
+	struct mlx5_core_dev *mdev; /* primary */
 	u32 rqtn;
 	u16 size;
 };
@@ -28,7 +28,7 @@ struct mlx5e_rqt {
 int mlx5e_rqt_init_direct(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
 			  bool indir_enabled, u32 init_rqn, u32 indir_table_size);
 int mlx5e_rqt_init_indir(struct mlx5e_rqt *rqt, struct mlx5_core_dev *mdev,
-			 u32 *rqns, unsigned int num_rqns,
+			 u32 *rqns, u32 *vhca_ids, unsigned int num_rqns,
 			 u8 hfunc, struct mlx5e_rss_params_indir *indir);
 void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt);
 
@@ -38,8 +38,9 @@ static inline u32 mlx5e_rqt_get_rqtn(struct mlx5e_rqt *rqt)
 }
 
 u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels);
-int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn);
-int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, unsigned int num_rqns,
+int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn, u32 *vhca_id);
+int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
+			     unsigned int num_rqns,
 			     u8 hfunc, struct mlx5e_rss_params_indir *indir);
 
 #endif /* __MLX5_EN_RQT_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index c1545a2e8d6d..5f742f896600 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -74,7 +74,7 @@ struct mlx5e_rss {
 	struct mlx5e_tir *tir[MLX5E_NUM_INDIR_TIRS];
 	struct mlx5e_tir *inner_tir[MLX5E_NUM_INDIR_TIRS];
 	struct mlx5e_rqt rqt;
-	struct mlx5_core_dev *mdev;
+	struct mlx5_core_dev *mdev; /* primary */
 	u32 drop_rqn;
 	bool inner_ft_support;
 	bool enabled;
@@ -473,21 +473,22 @@ int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
 	return 0;
 }
 
-static int mlx5e_rss_apply(struct mlx5e_rss *rss, u32 *rqns, unsigned int num_rqns)
+static int mlx5e_rss_apply(struct mlx5e_rss *rss, u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	int err;
 
-	err = mlx5e_rqt_redirect_indir(&rss->rqt, rqns, num_rqns, rss->hash.hfunc, &rss->indir);
+	err = mlx5e_rqt_redirect_indir(&rss->rqt, rqns, vhca_ids, num_rqns, rss->hash.hfunc,
+				       &rss->indir);
 	if (err)
 		mlx5e_rss_warn(rss->mdev, "Failed to redirect RQT %#x to channels: err = %d\n",
 			       mlx5e_rqt_get_rqtn(&rss->rqt), err);
 	return err;
 }
 
-void mlx5e_rss_enable(struct mlx5e_rss *rss, u32 *rqns, unsigned int num_rqns)
+void mlx5e_rss_enable(struct mlx5e_rss *rss, u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	rss->enabled = true;
-	mlx5e_rss_apply(rss, rqns, num_rqns);
+	mlx5e_rss_apply(rss, rqns, vhca_ids, num_rqns);
 }
 
 void mlx5e_rss_disable(struct mlx5e_rss *rss)
@@ -495,7 +496,7 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss)
 	int err;
 
 	rss->enabled = false;
-	err = mlx5e_rqt_redirect_direct(&rss->rqt, rss->drop_rqn);
+	err = mlx5e_rqt_redirect_direct(&rss->rqt, rss->drop_rqn, NULL);
 	if (err)
 		mlx5e_rss_warn(rss->mdev, "Failed to redirect RQT %#x to drop RQ %#x: err = %d\n",
 			       mlx5e_rqt_get_rqtn(&rss->rqt), rss->drop_rqn, err);
@@ -568,7 +569,7 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       const u8 *key, const u8 *hfunc,
-		       u32 *rqns, unsigned int num_rqns)
+		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	bool changed_indir = false;
 	bool changed_hash = false;
@@ -608,7 +609,7 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 	}
 
 	if (changed_indir && rss->enabled) {
-		err = mlx5e_rss_apply(rss, rqns, num_rqns);
+		err = mlx5e_rss_apply(rss, rqns, vhca_ids, num_rqns);
 		if (err) {
 			mlx5e_rss_copy(rss, old_rss);
 			goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index d1d0bc350e92..d0df98963c8d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -39,7 +39,7 @@ int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
 			  const struct mlx5e_packet_merge_param *init_pkt_merge_param,
 			  bool inner, u32 *tirn);
 
-void mlx5e_rss_enable(struct mlx5e_rss *rss, u32 *rqns, unsigned int num_rqns);
+void mlx5e_rss_enable(struct mlx5e_rss *rss, u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
@@ -47,7 +47,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc);
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       const u8 *key, const u8 *hfunc,
-		       u32 *rqns, unsigned int num_rqns);
+		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 struct mlx5e_rss_params_hash mlx5e_rss_get_hash(struct mlx5e_rss *rss);
 u8 mlx5e_rss_get_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt);
 int mlx5e_rss_set_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index b23e224e3763..a86eade9a9e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -8,7 +8,7 @@
 #define MLX5E_MAX_NUM_RSS 16
 
 struct mlx5e_rx_res {
-	struct mlx5_core_dev *mdev;
+	struct mlx5_core_dev *mdev; /* primary */
 	enum mlx5e_rx_res_features features;
 	unsigned int max_nch;
 	u32 drop_rqn;
@@ -19,6 +19,7 @@ struct mlx5e_rx_res {
 	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
 	bool rss_active;
 	u32 *rss_rqns;
+	u32 *rss_vhca_ids;
 	unsigned int rss_nch;
 
 	struct {
@@ -34,6 +35,13 @@ struct mlx5e_rx_res {
 
 /* API for rx_res_rss_* */
 
+static u32 *get_vhca_ids(struct mlx5e_rx_res *res, int offset)
+{
+	bool multi_vhca = res->features & MLX5E_RX_RES_FEATURE_MULTI_VHCA;
+
+	return multi_vhca ? res->rss_vhca_ids + offset : NULL;
+}
+
 void mlx5e_rx_res_rss_update_num_channels(struct mlx5e_rx_res *res, u32 nch)
 {
 	int i;
@@ -85,8 +93,11 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 *rss_idx, unsigned int i
 		return PTR_ERR(rss);
 
 	mlx5e_rss_set_indir_uniform(rss, init_nch);
-	if (res->rss_active)
-		mlx5e_rss_enable(rss, res->rss_rqns, res->rss_nch);
+	if (res->rss_active) {
+		u32 *vhca_ids = get_vhca_ids(res, 0);
+
+		mlx5e_rss_enable(rss, res->rss_rqns, vhca_ids, res->rss_nch);
+	}
 
 	res->rss[i] = rss;
 	*rss_idx = i;
@@ -153,10 +164,12 @@ static void mlx5e_rx_res_rss_enable(struct mlx5e_rx_res *res)
 
 	for (i = 0; i < MLX5E_MAX_NUM_RSS; i++) {
 		struct mlx5e_rss *rss = res->rss[i];
+		u32 *vhca_ids;
 
 		if (!rss)
 			continue;
-		mlx5e_rss_enable(rss, res->rss_rqns, res->rss_nch);
+		vhca_ids = get_vhca_ids(res, 0);
+		mlx5e_rss_enable(rss, res->rss_rqns, vhca_ids, res->rss_nch);
 	}
 }
 
@@ -200,6 +213,7 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			      const u32 *indir, const u8 *key, const u8 *hfunc)
 {
+	u32 *vhca_ids = get_vhca_ids(res, 0);
 	struct mlx5e_rss *rss;
 
 	if (rss_idx >= MLX5E_MAX_NUM_RSS)
@@ -209,7 +223,8 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, res->rss_nch);
+	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, vhca_ids,
+				  res->rss_nch);
 }
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
@@ -280,11 +295,13 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
 
 static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
 {
+	kvfree(res->rss_vhca_ids);
 	kvfree(res->rss_rqns);
 	kvfree(res);
 }
 
-static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsigned int max_nch)
+static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsigned int max_nch,
+					       bool multi_vhca)
 {
 	struct mlx5e_rx_res *rx_res;
 
@@ -298,6 +315,15 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
 		return NULL;
 	}
 
+	if (multi_vhca) {
+		rx_res->rss_vhca_ids = kvcalloc(max_nch, sizeof(*rx_res->rss_vhca_ids), GFP_KERNEL);
+		if (!rx_res->rss_vhca_ids) {
+			kvfree(rx_res->rss_rqns);
+			kvfree(rx_res);
+			return NULL;
+		}
+	}
+
 	return rx_res;
 }
 
@@ -424,10 +450,11 @@ mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features featu
 		    const struct mlx5e_packet_merge_param *init_pkt_merge_param,
 		    unsigned int init_nch)
 {
+	bool multi_vhca = features & MLX5E_RX_RES_FEATURE_MULTI_VHCA;
 	struct mlx5e_rx_res *res;
 	int err;
 
-	res = mlx5e_rx_res_alloc(mdev, max_nch);
+	res = mlx5e_rx_res_alloc(mdev, max_nch, multi_vhca);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
@@ -504,10 +531,11 @@ static void mlx5e_rx_res_channel_activate_direct(struct mlx5e_rx_res *res,
 						 struct mlx5e_channels *chs,
 						 unsigned int ix)
 {
+	u32 *vhca_id = get_vhca_ids(res, ix);
 	u32 rqn = res->rss_rqns[ix];
 	int err;
 
-	err = mlx5e_rqt_redirect_direct(&res->channels[ix].direct_rqt, rqn);
+	err = mlx5e_rqt_redirect_direct(&res->channels[ix].direct_rqt, rqn, vhca_id);
 	if (err)
 		mlx5_core_warn(res->mdev, "Failed to redirect direct RQT %#x to RQ %#x (channel %u): err = %d\n",
 			       mlx5e_rqt_get_rqtn(&res->channels[ix].direct_rqt),
@@ -519,7 +547,7 @@ static void mlx5e_rx_res_channel_deactivate_direct(struct mlx5e_rx_res *res,
 {
 	int err;
 
-	err = mlx5e_rqt_redirect_direct(&res->channels[ix].direct_rqt, res->drop_rqn);
+	err = mlx5e_rqt_redirect_direct(&res->channels[ix].direct_rqt, res->drop_rqn, NULL);
 	if (err)
 		mlx5_core_warn(res->mdev, "Failed to redirect direct RQT %#x to drop RQ %#x (channel %u): err = %d\n",
 			       mlx5e_rqt_get_rqtn(&res->channels[ix].direct_rqt),
@@ -534,10 +562,12 @@ void mlx5e_rx_res_channels_activate(struct mlx5e_rx_res *res, struct mlx5e_chann
 	nch = mlx5e_channels_get_num(chs);
 
 	for (ix = 0; ix < chs->num; ix++) {
+		u32 *vhca_id = get_vhca_ids(res, ix);
+
 		if (mlx5e_channels_is_xsk(chs, ix))
-			mlx5e_channels_get_xsk_rqn(chs, ix, &res->rss_rqns[ix]);
+			mlx5e_channels_get_xsk_rqn(chs, ix, &res->rss_rqns[ix], vhca_id);
 		else
-			mlx5e_channels_get_regular_rqn(chs, ix, &res->rss_rqns[ix]);
+			mlx5e_channels_get_regular_rqn(chs, ix, &res->rss_rqns[ix], vhca_id);
 	}
 	res->rss_nch = chs->num;
 
@@ -554,7 +584,7 @@ void mlx5e_rx_res_channels_activate(struct mlx5e_rx_res *res, struct mlx5e_chann
 		if (!mlx5e_channels_get_ptp_rqn(chs, &rqn))
 			rqn = res->drop_rqn;
 
-		err = mlx5e_rqt_redirect_direct(&res->ptp.rqt, rqn);
+		err = mlx5e_rqt_redirect_direct(&res->ptp.rqt, rqn, NULL);
 		if (err)
 			mlx5_core_warn(res->mdev, "Failed to redirect direct RQT %#x to RQ %#x (PTP): err = %d\n",
 				       mlx5e_rqt_get_rqtn(&res->ptp.rqt),
@@ -573,7 +603,7 @@ void mlx5e_rx_res_channels_deactivate(struct mlx5e_rx_res *res)
 		mlx5e_rx_res_channel_deactivate_direct(res, ix);
 
 	if (res->features & MLX5E_RX_RES_FEATURE_PTP) {
-		err = mlx5e_rqt_redirect_direct(&res->ptp.rqt, res->drop_rqn);
+		err = mlx5e_rqt_redirect_direct(&res->ptp.rqt, res->drop_rqn, NULL);
 		if (err)
 			mlx5_core_warn(res->mdev, "Failed to redirect direct RQT %#x to drop RQ %#x (PTP): err = %d\n",
 				       mlx5e_rqt_get_rqtn(&res->ptp.rqt),
@@ -584,10 +614,12 @@ void mlx5e_rx_res_channels_deactivate(struct mlx5e_rx_res *res)
 void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *chs,
 			     unsigned int ix, bool xsk)
 {
+	u32 *vhca_id = get_vhca_ids(res, ix);
+
 	if (xsk)
-		mlx5e_channels_get_xsk_rqn(chs, ix, &res->rss_rqns[ix]);
+		mlx5e_channels_get_xsk_rqn(chs, ix, &res->rss_rqns[ix], vhca_id);
 	else
-		mlx5e_channels_get_regular_rqn(chs, ix, &res->rss_rqns[ix]);
+		mlx5e_channels_get_regular_rqn(chs, ix, &res->rss_rqns[ix], vhca_id);
 
 	mlx5e_rx_res_rss_enable(res);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 82aaba8a82b3..7b1a9f0f1874 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -18,6 +18,7 @@ struct mlx5e_rss_params_hash;
 enum mlx5e_rx_res_features {
 	MLX5E_RX_RES_FEATURE_INNER_FT = BIT(0),
 	MLX5E_RX_RES_FEATURE_PTP = BIT(1),
+	MLX5E_RX_RES_FEATURE_MULTI_VHCA = BIT(2),
 };
 
 /* Setup */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8d9b0cdb4e01..8cc636cf995a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5389,6 +5389,8 @@ static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
 	features = MLX5E_RX_RES_FEATURE_PTP;
 	if (mlx5_tunnel_inner_ft_supported(mdev))
 		features |= MLX5E_RX_RES_FEATURE_INNER_FT;
+	if (mlx5_get_sd(priv->mdev))
+		features |= MLX5E_RX_RES_FEATURE_MULTI_VHCA;
 
 	priv->rx_res = mlx5e_rx_res_create(priv->mdev, features, priv->max_nch, priv->drop_rq.rqn,
 					   &priv->channels.params.packet_merge,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9fb2c057bd78..080d79d80dd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -766,7 +766,7 @@ static int mlx5e_hairpin_create_indirect_rqt(struct mlx5e_hairpin *hp)
 		return err;
 
 	mlx5e_rss_params_indir_init_uniform(&indir, hp->num_channels);
-	err = mlx5e_rqt_init_indir(&hp->indir_rqt, mdev, hp->pair->rqn, hp->num_channels,
+	err = mlx5e_rqt_init_indir(&hp->indir_rqt, mdev, hp->pair->rqn, NULL, hp->num_channels,
 				   mlx5e_rx_res_get_current_hash(priv->rx_res).hfunc,
 				   &indir);
 
-- 
2.44.0


