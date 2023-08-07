Return-Path: <netdev+bounces-25071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC8772D69
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4B9280D6C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8116418;
	Mon,  7 Aug 2023 17:57:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700C1640B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD209C4339A;
	Mon,  7 Aug 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431024;
	bh=6mrjMKgVRp8C2aBt39maQiP/njrGsEfHeCJ/tFd1Agw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHFPkMeaizOGSomXkZKXcG7R5B2Lthm/kx7PSeRiNd0xFkIgjejYhHH6zDbe7G+Y2
	 0Cbt5GG8XYRchuGdPjMGiDJJsARyTlCtaZW2XsJ4q1a2/yTJL6OTJFJ4pC8xzCeeTN
	 IJCOk32bf6EktCWqO8pwha/BcOMmNfc40WaQxcjJBDwUGvvlk1Vj2oPv4epc9D//G7
	 +bYN+J4oOxr/dOcWSK+pXHNSJQKpk7Cb1aRIb1c6aJkyzXc4wNE7Pe5LvjEDR9N+Pk
	 V/pzDopVo3HJSg2fI6Y6yERengCr//qKfMT/hpzX4mz+uDG4ydJOjuPbZIpLO0RmhZ
	 bHZP1hYhqPxKw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 11/15] net/mlx5: Allocate completion EQs dynamically
Date: Mon,  7 Aug 2023 10:56:38 -0700
Message-ID: <20230807175642.20834-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

This commit enables the dynamic allocation of EQs at runtime, allowing
for more flexibility in managing completion EQs and reducing the memory
overhead of driver load. Whenever a CQ is created for a given vector
index, the driver will lookup to see if there is an already mapped
completion EQ for that vector, if so, utilize it. Otherwise, allocate a
new EQ on demand and then utilize it for the CQ completion events.

Add a protection lock to the EQ table to protect from concurrent EQ
creation attempts.

While at it, replace mlx5_vector2irqn()/mlx5_vector2eqn() with
mlx5_comp_eqn_get() and mlx5_comp_irqn_get() which will allocate an
EQ on demand if no EQ is found for the given vector.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c               |  2 +-
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 80 ++++++++++---------
 .../ethernet/mellanox/mlx5/core/fpga/conn.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/aso.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/eq.h  |  2 +-
 .../mellanox/mlx5/core/steering/dr_send.c     |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  2 +-
 drivers/vfio/pci/mlx5/cmd.c                   |  2 +-
 include/linux/mlx5/driver.h                   |  2 +-
 11 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index efc9e4a6df04..9773d2a3d97f 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -993,7 +993,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		INIT_WORK(&cq->notify_work, notify_soft_wc_handler);
 	}
 
-	err = mlx5_vector2eqn(dev->mdev, vector, &eqn);
+	err = mlx5_comp_eqn_get(dev->mdev, vector, &eqn);
 	if (err)
 		goto err_cqb;
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index db5fb196c728..8ba53edf2311 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1002,7 +1002,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_QUERY_EQN)(
 		return PTR_ERR(c);
 	dev = to_mdev(c->ibucontext.device);
 
-	err = mlx5_vector2eqn(dev->mdev, user_vector, &dev_eqn);
+	err = mlx5_comp_eqn_get(dev->mdev, user_vector, &dev_eqn);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5710d755c2c4..5919b889479f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1989,7 +1989,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	int eqn;
 	int err;
 
-	err = mlx5_vector2eqn(mdev, param->eq_ix, &eqn);
+	err = mlx5_comp_eqn_get(mdev, param->eq_ix, &eqn);
 	if (err)
 		return err;
 
@@ -2452,7 +2452,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	unsigned int irq;
 	int err;
 
-	err = mlx5_vector2irqn(priv->mdev, ix, &irq);
+	err = mlx5_comp_irqn_get(priv->mdev, ix, &irq);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 6e6e0a1c12b5..ea0405e0a43f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -58,6 +58,7 @@ struct mlx5_eq_table {
 	struct mlx5_nb          cq_err_nb;
 
 	struct mutex            lock; /* sync async eqs creations */
+	struct mutex            comp_lock; /* sync comp eqs creations */
 	int			curr_comp_eqs;
 	int			max_comp_eqs;
 	struct mlx5_irq_table	*irq_table;
@@ -457,6 +458,7 @@ int mlx5_eq_table_init(struct mlx5_core_dev *dev)
 	cpumask_clear(&eq_table->used_cpus);
 	xa_init(&eq_table->comp_eqs);
 	xa_init(&eq_table->comp_irqs);
+	mutex_init(&eq_table->comp_lock);
 	eq_table->curr_comp_eqs = 0;
 	return 0;
 }
@@ -985,6 +987,7 @@ static u16 comp_eq_depth_devlink_param_get(struct mlx5_core_dev *dev)
 	return MLX5_COMP_EQ_SIZE;
 }
 
+/* Must be called with EQ table comp_lock held */
 static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
@@ -994,6 +997,13 @@ static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 	int nent;
 	int err;
 
+	lockdep_assert_held(&table->comp_lock);
+	if (table->curr_comp_eqs == table->max_comp_eqs) {
+		mlx5_core_err(dev, "maximum number of vectors is allocated, %d\n",
+			      table->max_comp_eqs);
+		return -ENOMEM;
+	}
+
 	err = comp_irq_request(dev, vecidx);
 	if (err)
 		return err;
@@ -1033,7 +1043,7 @@ static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 		goto disable_eq;
 
 	table->curr_comp_eqs++;
-	return 0;
+	return eq->core.eqn;
 
 disable_eq:
 	mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
@@ -1044,32 +1054,47 @@ static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 	return err;
 }
 
-static int vector2eqnirqn(struct mlx5_core_dev *dev, int vector, int *eqn,
-			  unsigned int *irqn)
+int mlx5_comp_eqn_get(struct mlx5_core_dev *dev, u16 vecidx, int *eqn)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq;
+	int ret = 0;
 
-	eq = xa_load(&table->comp_eqs, vector);
-	if (!eq)
-		return -ENOENT;
-
-	if (irqn)
-		*irqn = eq->core.irqn;
-	if (eqn)
+	mutex_lock(&table->comp_lock);
+	eq = xa_load(&table->comp_eqs, vecidx);
+	if (eq) {
 		*eqn = eq->core.eqn;
+		goto out;
+	}
+
+	ret = create_comp_eq(dev, vecidx);
+	if (ret < 0) {
+		mutex_unlock(&table->comp_lock);
+		return ret;
+	}
+
+	*eqn = ret;
+out:
+	mutex_unlock(&table->comp_lock);
 	return 0;
 }
+EXPORT_SYMBOL(mlx5_comp_eqn_get);
 
-int mlx5_vector2eqn(struct mlx5_core_dev *dev, int vector, int *eqn)
+int mlx5_comp_irqn_get(struct mlx5_core_dev *dev, int vector, unsigned int *irqn)
 {
-	return vector2eqnirqn(dev, vector, eqn, NULL);
-}
-EXPORT_SYMBOL(mlx5_vector2eqn);
+	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct mlx5_eq_comp *eq;
+	int eqn;
+	int err;
 
-int mlx5_vector2irqn(struct mlx5_core_dev *dev, int vector, unsigned int *irqn)
-{
-	return vector2eqnirqn(dev, vector, NULL, irqn);
+	/* Allocate the EQ if not allocated yet */
+	err = mlx5_comp_eqn_get(dev, vector, &eqn);
+	if (err)
+		return err;
+
+	eq = xa_load(&table->comp_eqs, vector);
+	*irqn = eq->core.irqn;
+	return 0;
 }
 
 unsigned int mlx5_comp_vectors_max(struct mlx5_core_dev *dev)
@@ -1119,10 +1144,9 @@ struct mlx5_eq_comp *mlx5_eqn2comp_eq(struct mlx5_core_dev *dev, int eqn)
 	struct mlx5_eq_comp *eq;
 	unsigned long index;
 
-	xa_for_each(&table->comp_eqs, index, eq) {
+	xa_for_each(&table->comp_eqs, index, eq)
 		if (eq->core.eqn == eqn)
 			return eq;
-	}
 
 	return ERR_PTR(-ENOENT);
 }
@@ -1130,11 +1154,7 @@ struct mlx5_eq_comp *mlx5_eqn2comp_eq(struct mlx5_core_dev *dev, int eqn)
 /* This function should only be called after mlx5_cmd_force_teardown_hca */
 void mlx5_core_eq_free_irqs(struct mlx5_core_dev *dev)
 {
-	struct mlx5_eq_table *table = dev->priv.eq_table;
-
-	mutex_lock(&table->lock); /* sync with create/destroy_async_eq */
 	mlx5_irq_table_free_irqs(dev);
-	mutex_unlock(&table->lock);
 }
 
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
@@ -1176,7 +1196,6 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *eq_table = dev->priv.eq_table;
 	int err;
-	int i;
 
 	eq_table->max_comp_eqs = get_num_eqs(dev);
 	err = create_async_eqs(dev);
@@ -1191,21 +1210,8 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 		goto err_rmap;
 	}
 
-	for (i = 0; i < eq_table->max_comp_eqs; i++) {
-		err = create_comp_eq(dev, i);
-		if (err < 0)
-			break;
-	}
-
-	if (!i) {
-		mlx5_core_err(dev, "Failed to create completion EQs\n");
-		goto err_comp_eqs;
-	}
-
 	return 0;
 
-err_comp_eqs:
-	free_rmap(dev);
 err_rmap:
 	destroy_async_eqs(dev);
 err_async_eqs:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
index 12abe991583a..c4de6bf8d1b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
@@ -445,7 +445,7 @@ static int mlx5_fpga_conn_create_cq(struct mlx5_fpga_conn *conn, int cq_size)
 		goto err_cqwq;
 	}
 
-	err = mlx5_vector2eqn(mdev, smp_processor_id(), &eqn);
+	err = mlx5_comp_eqn_get(mdev, smp_processor_id(), &eqn);
 	if (err) {
 		kvfree(in);
 		goto err_cqwq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
index 5a80fb7dbbca..40c7be124041 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
@@ -81,7 +81,7 @@ static int create_aso_cq(struct mlx5_aso_cq *cq, void *cqc_data)
 	int inlen, eqn;
 	int err;
 
-	err = mlx5_vector2eqn(mdev, 0, &eqn);
+	err = mlx5_comp_eqn_get(mdev, 0, &eqn);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index d3d628b862f3..69a75459775d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -104,6 +104,6 @@ void mlx5_core_eq_free_irqs(struct mlx5_core_dev *dev);
 struct cpu_rmap *mlx5_eq_table_get_rmap(struct mlx5_core_dev *dev);
 #endif
 
-int mlx5_vector2irqn(struct mlx5_core_dev *dev, int vector, unsigned int *irqn);
+int mlx5_comp_irqn_get(struct mlx5_core_dev *dev, int vector, unsigned int *irqn);
 
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index 24bb30b5008c..6fa06ba2d346 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -1097,7 +1097,7 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 		goto err_cqwq;
 
 	vector = raw_smp_processor_id() % mlx5_comp_vectors_max(mdev);
-	err = mlx5_vector2eqn(mdev, vector, &eqn);
+	err = mlx5_comp_eqn_get(mdev, vector, &eqn);
 	if (err) {
 		kvfree(in);
 		goto err_cqwq;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..bece4df7b8dd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -580,7 +580,7 @@ static int cq_create(struct mlx5_vdpa_net *ndev, u16 idx, u32 num_ent)
 	/* Use vector 0 by default. Consider adding code to choose least used
 	 * vector.
 	 */
-	err = mlx5_vector2eqn(mdev, 0, &eqn);
+	err = mlx5_comp_eqn_get(mdev, 0, &eqn);
 	if (err)
 		goto err_vec;
 
diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index eee20f04a469..c82c1f4fc588 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -1026,7 +1026,7 @@ static int mlx5vf_create_cq(struct mlx5_core_dev *mdev,
 	}
 
 	vector = raw_smp_processor_id() % mlx5_comp_vectors_max(mdev);
-	err = mlx5_vector2eqn(mdev, vector, &eqn);
+	err = mlx5_comp_eqn_get(mdev, vector, &eqn);
 	if (err)
 		goto err_vec;
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 43c4fd26c69a..3e1017d764b7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1058,7 +1058,7 @@ void mlx5_unregister_debugfs(void);
 
 void mlx5_fill_page_frag_array_perm(struct mlx5_frag_buf *buf, __be64 *pas, u8 perm);
 void mlx5_fill_page_frag_array(struct mlx5_frag_buf *frag_buf, __be64 *pas);
-int mlx5_vector2eqn(struct mlx5_core_dev *dev, int vector, int *eqn);
+int mlx5_comp_eqn_get(struct mlx5_core_dev *dev, u16 vecidx, int *eqn);
 int mlx5_core_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 int mlx5_core_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 
-- 
2.41.0


