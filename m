Return-Path: <netdev+bounces-25066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895B772D63
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA47281408
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1A1640C;
	Mon,  7 Aug 2023 17:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F715AFF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB5C433C8;
	Mon,  7 Aug 2023 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431019;
	bh=RDm0STx9XnWhLMgQicUqt60gw0hgvA3iLiUAGCpHLGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gq27vA6Ta93yBU+kgOwIts179m/Vgf7Ms9GyX4n8OogIwZ79FKXqwsfkFqhn9D9pN
	 oiZoOf/XwZT+4CiBIaL8zeM9SaZdHxT4UIvydJmhSD2wTBoVv7l0IRitBVx2Q6+toz
	 3S3KdDQY+mlV5pUd9QppP3VOsP7HMq0m4xN7ImXyyUtqFTkgOgEtiNSqW2FR6nGoBQ
	 LUpyaobFcX7Jz4mFQo4DfI/2zWs61lSvwoNUeK+PgdT+k9JWtLR9Cbt73av3mmKNHq
	 RDbUt3eB+lzCNp6b7jOyvefGuTTaHJ6K3Y0M19LVJAIY8XE2J/EXsPTdhaR//AZ0tf
	 2PdA96tLgpWIg==
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
Subject: [net-next 06/15] net/mlx5: Implement single completion EQ create/destroy methods
Date: Mon,  7 Aug 2023 10:56:33 -0700
Message-ID: <20230807175642.20834-7-saeed@kernel.org>
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

Currently, create_comp_eqs() function handles the creation of all
completion EQs for all the vectors on driver load. While on driver
unload, destroy_comp_eqs() performs the equivalent job.

In preparation for dynamic EQ creation, replace create_comp_eqs() /
destroy_comp_eqs() with  create_comp_eq() / destroy_comp_eq() functions
which will receive a vector index and allocate/destroy an EQ for that
specific vector. Thus, allowing more flexibility in the management
of completion EQs.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 137 +++++++++----------
 1 file changed, 66 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index b343c0fd621e..41fa15757101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -927,28 +927,19 @@ static int alloc_rmap(struct mlx5_core_dev *mdev) { return 0; }
 static void free_rmap(struct mlx5_core_dev *mdev) {}
 #endif
 
-static void destroy_comp_eqs(struct mlx5_core_dev *dev)
+static void destroy_comp_eq(struct mlx5_core_dev *dev, struct mlx5_eq_comp *eq, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	struct mlx5_eq_comp *eq;
-	struct mlx5_irq *irq;
-	unsigned long index;
-
-	xa_for_each(&table->comp_eqs, index, eq) {
-		xa_erase(&table->comp_eqs, index);
-		mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
-		if (destroy_unmap_eq(dev, &eq->core))
-			mlx5_core_warn(dev, "failed to destroy comp EQ 0x%x\n",
-				       eq->core.eqn);
-		tasklet_disable(&eq->tasklet_ctx.task);
-		kfree(eq);
-		table->curr_comp_eqs--;
-	}
 
-	xa_for_each(&table->comp_irqs, index, irq)
-		comp_irq_release(dev, index);
-
-	free_rmap(dev);
+	xa_erase(&table->comp_eqs, vecidx);
+	mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
+	if (destroy_unmap_eq(dev, &eq->core))
+		mlx5_core_warn(dev, "failed to destroy comp EQ 0x%x\n",
+			       eq->core.eqn);
+	tasklet_disable(&eq->tasklet_ctx.task);
+	kfree(eq);
+	comp_irq_release(dev, vecidx);
+	table->curr_comp_eqs--;
 }
 
 static u16 comp_eq_depth_devlink_param_get(struct mlx5_core_dev *dev)
@@ -966,79 +957,62 @@ static u16 comp_eq_depth_devlink_param_get(struct mlx5_core_dev *dev)
 	return MLX5_COMP_EQ_SIZE;
 }
 
-static int create_comp_eqs(struct mlx5_core_dev *dev)
+static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct mlx5_eq_param param = {};
 	struct mlx5_eq_comp *eq;
 	struct mlx5_irq *irq;
-	unsigned long index;
-	int vecidx;
 	int nent;
 	int err;
 
-	err = alloc_rmap(dev);
+	err = comp_irq_request(dev, vecidx);
 	if (err)
 		return err;
 
-	for (vecidx = 0; vecidx < table->max_comp_eqs; vecidx++) {
-		err = comp_irq_request(dev, vecidx);
-		if (err < 0)
-			break;
-	}
-
-	if (!vecidx)
-		goto err_irqs_req;
-
-	table->max_comp_eqs = vecidx;
 	nent = comp_eq_depth_devlink_param_get(dev);
 
-	xa_for_each(&table->comp_irqs, index, irq)
-	{
-		struct mlx5_eq_param param = {};
+	eq = kzalloc_node(sizeof(*eq), GFP_KERNEL, dev->priv.numa_node);
+	if (!eq) {
+		err = -ENOMEM;
+		goto clean_irq;
+	}
 
-		eq = kzalloc_node(sizeof(*eq), GFP_KERNEL, dev->priv.numa_node);
-		if (!eq) {
-			err = -ENOMEM;
-			goto clean;
-		}
+	INIT_LIST_HEAD(&eq->tasklet_ctx.list);
+	INIT_LIST_HEAD(&eq->tasklet_ctx.process_list);
+	spin_lock_init(&eq->tasklet_ctx.lock);
+	tasklet_setup(&eq->tasklet_ctx.task, mlx5_cq_tasklet_cb);
 
-		INIT_LIST_HEAD(&eq->tasklet_ctx.list);
-		INIT_LIST_HEAD(&eq->tasklet_ctx.process_list);
-		spin_lock_init(&eq->tasklet_ctx.lock);
-		tasklet_setup(&eq->tasklet_ctx.task, mlx5_cq_tasklet_cb);
-
-		eq->irq_nb.notifier_call = mlx5_eq_comp_int;
-		param = (struct mlx5_eq_param) {
-			.irq = irq,
-			.nent = nent,
-		};
-
-		err = create_map_eq(dev, &eq->core, &param);
-		if (err)
-			goto clean_eq;
-		err = mlx5_eq_enable(dev, &eq->core, &eq->irq_nb);
-		if (err) {
-			destroy_unmap_eq(dev, &eq->core);
-			goto clean_eq;
-		}
+	irq = xa_load(&table->comp_irqs, vecidx);
+	eq->irq_nb.notifier_call = mlx5_eq_comp_int;
+	param = (struct mlx5_eq_param) {
+		.irq = irq,
+		.nent = nent,
+	};
 
-		mlx5_core_dbg(dev, "allocated completion EQN %d\n", eq->core.eqn);
-		err = xa_err(xa_store(&table->comp_eqs, index, eq, GFP_KERNEL));
-		if (err)
-			goto disable_eq;
-		table->curr_comp_eqs++;
+	err = create_map_eq(dev, &eq->core, &param);
+	if (err)
+		goto clean_eq;
+	err = mlx5_eq_enable(dev, &eq->core, &eq->irq_nb);
+	if (err) {
+		destroy_unmap_eq(dev, &eq->core);
+		goto clean_eq;
 	}
 
+	mlx5_core_dbg(dev, "allocated completion EQN %d\n", eq->core.eqn);
+	err = xa_err(xa_store(&table->comp_eqs, vecidx, eq, GFP_KERNEL));
+	if (err)
+		goto disable_eq;
+
+	table->curr_comp_eqs++;
 	return 0;
 
 disable_eq:
 	mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
 clean_eq:
 	kfree(eq);
-clean:
-	destroy_comp_eqs(dev);
-err_irqs_req:
-	free_rmap(dev);
+clean_irq:
+	comp_irq_release(dev, vecidx);
 	return err;
 }
 
@@ -1161,6 +1135,7 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *eq_table = dev->priv.eq_table;
 	int err;
+	int i;
 
 	eq_table->max_comp_eqs = get_num_eqs(dev);
 	err = create_async_eqs(dev);
@@ -1169,8 +1144,19 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 		goto err_async_eqs;
 	}
 
-	err = create_comp_eqs(dev);
+	err = alloc_rmap(dev);
 	if (err) {
+		mlx5_core_err(dev, "Failed to allocate rmap\n");
+		goto err_rmap;
+	}
+
+	for (i = 0; i < eq_table->max_comp_eqs; i++) {
+		err = create_comp_eq(dev, i);
+		if (err < 0)
+			break;
+	}
+
+	if (!i) {
 		mlx5_core_err(dev, "Failed to create completion EQs\n");
 		goto err_comp_eqs;
 	}
@@ -1178,6 +1164,8 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 	return 0;
 
 err_comp_eqs:
+	free_rmap(dev);
+err_rmap:
 	destroy_async_eqs(dev);
 err_async_eqs:
 	return err;
@@ -1185,7 +1173,14 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 
 void mlx5_eq_table_destroy(struct mlx5_core_dev *dev)
 {
-	destroy_comp_eqs(dev);
+	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct mlx5_eq_comp *eq;
+	unsigned long index;
+
+	xa_for_each(&table->comp_eqs, index, eq)
+		destroy_comp_eq(dev, eq, index);
+
+	free_rmap(dev);
 	destroy_async_eqs(dev);
 }
 
-- 
2.41.0


