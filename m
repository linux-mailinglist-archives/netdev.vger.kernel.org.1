Return-Path: <netdev+bounces-25065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F2772D62
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A129281364
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368D156FE;
	Mon,  7 Aug 2023 17:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341815AE8
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEFC433D9;
	Mon,  7 Aug 2023 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431018;
	bh=9aADMXSOtE1dp51htiRBLE2j8HO+wFQNiwDW5BkEbzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YS3QWS8KCoPufd3uGFdUghZ/QwD0J1Ufi/cC6k82aFtzGD0wxP3thHpseZAMs/Mam
	 yza/h6TPTBt+1+v6IfGGY3k4djGX/orbmzifdh+PNDbpqsZoFtDE7wubnJcB89ZGHn
	 akZBb42HmTeo+toWIUlYffxKvWqLyUo7qTlx3F6lkM9Ujqy6WoqX80sNvxt5i/0TE2
	 +xtRzAo8Tb8Vu4PDiCsi/3e6UGJ0FS00DfQYNI348TnJGA+y8A26EyD/VFH06VEZ2w
	 /xQvhCJouJ5L5EhrRylH837cGyBqNiKnme7PTdNNGtcJ+8L4riuQQTV3S/a2nJgSFf
	 OK2WE2/M+rtaA==
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
Subject: [net-next 05/15] net/mlx5: Use xarray to store and manage completion EQs
Date: Mon,  7 Aug 2023 10:56:32 -0700
Message-ID: <20230807175642.20834-6-saeed@kernel.org>
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

Use xarray to store the completion EQs instead of a linked list.
The xarray offers more scalability, reduced memory overhead, and
facilitates the lookup of a certain EQ given a vector index.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 50 ++++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index c01a5d8dbe9b..b343c0fd621e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -47,7 +47,7 @@ enum {
 static_assert(MLX5_EQ_POLLING_BUDGET <= MLX5_NUM_SPARE_EQE);
 
 struct mlx5_eq_table {
-	struct list_head        comp_eqs_list;
+	struct xarray           comp_eqs;
 	struct mlx5_eq_async    pages_eq;
 	struct mlx5_eq_async    cmd_eq;
 	struct mlx5_eq_async    async_eq;
@@ -455,6 +455,7 @@ int mlx5_eq_table_init(struct mlx5_core_dev *dev)
 
 	eq_table->irq_table = mlx5_irq_table_get(dev);
 	cpumask_clear(&eq_table->used_cpus);
+	xa_init(&eq_table->comp_eqs);
 	xa_init(&eq_table->comp_irqs);
 	eq_table->curr_comp_eqs = 0;
 	return 0;
@@ -466,6 +467,7 @@ void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev)
 
 	mlx5_eq_debugfs_cleanup(dev);
 	xa_destroy(&table->comp_irqs);
+	xa_destroy(&table->comp_eqs);
 	kvfree(table);
 }
 
@@ -928,12 +930,12 @@ static void free_rmap(struct mlx5_core_dev *mdev) {}
 static void destroy_comp_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	struct mlx5_eq_comp *eq, *n;
+	struct mlx5_eq_comp *eq;
 	struct mlx5_irq *irq;
 	unsigned long index;
 
-	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
-		list_del(&eq->list);
+	xa_for_each(&table->comp_eqs, index, eq) {
+		xa_erase(&table->comp_eqs, index);
 		mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
 		if (destroy_unmap_eq(dev, &eq->core))
 			mlx5_core_warn(dev, "failed to destroy comp EQ 0x%x\n",
@@ -988,7 +990,6 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 		goto err_irqs_req;
 
 	table->max_comp_eqs = vecidx;
-	INIT_LIST_HEAD(&table->comp_eqs_list);
 	nent = comp_eq_depth_devlink_param_get(dev);
 
 	xa_for_each(&table->comp_irqs, index, irq)
@@ -1022,13 +1023,16 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 		}
 
 		mlx5_core_dbg(dev, "allocated completion EQN %d\n", eq->core.eqn);
-		/* add tail, to keep the list ordered, for mlx5_vector2eqn to work */
-		list_add_tail(&eq->list, &table->comp_eqs_list);
+		err = xa_err(xa_store(&table->comp_eqs, index, eq, GFP_KERNEL));
+		if (err)
+			goto disable_eq;
 		table->curr_comp_eqs++;
 	}
 
 	return 0;
 
+disable_eq:
+	mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
 clean_eq:
 	kfree(eq);
 clean:
@@ -1043,21 +1047,16 @@ static int vector2eqnirqn(struct mlx5_core_dev *dev, int vector, int *eqn,
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq;
-	int err = -ENOENT;
-	int i = 0;
 
-	list_for_each_entry(eq, &table->comp_eqs_list, list) {
-		if (i++ == vector) {
-			if (irqn)
-				*irqn = eq->core.irqn;
-			if (eqn)
-				*eqn = eq->core.eqn;
-			err = 0;
-			break;
-		}
-	}
+	eq = xa_load(&table->comp_eqs, vector);
+	if (!eq)
+		return -ENOENT;
 
-	return err;
+	if (irqn)
+		*irqn = eq->core.irqn;
+	if (eqn)
+		*eqn = eq->core.eqn;
+	return 0;
 }
 
 int mlx5_vector2eqn(struct mlx5_core_dev *dev, int vector, int *eqn)
@@ -1082,12 +1081,10 @@ mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq;
-	int i = 0;
 
-	list_for_each_entry(eq, &table->comp_eqs_list, list) {
-		if (i++ == vector)
-			return mlx5_irq_get_affinity_mask(eq->core.irq);
-	}
+	eq = xa_load(&table->comp_eqs, vector);
+	if (eq)
+		return mlx5_irq_get_affinity_mask(eq->core.irq);
 
 	WARN_ON_ONCE(1);
 	return NULL;
@@ -1105,8 +1102,9 @@ struct mlx5_eq_comp *mlx5_eqn2comp_eq(struct mlx5_core_dev *dev, int eqn)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq;
+	unsigned long index;
 
-	list_for_each_entry(eq, &table->comp_eqs_list, list) {
+	xa_for_each(&table->comp_eqs, index, eq) {
 		if (eq->core.eqn == eqn)
 			return eq;
 	}
-- 
2.41.0


