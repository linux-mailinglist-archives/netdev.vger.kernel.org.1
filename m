Return-Path: <netdev+bounces-25061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC8772D59
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615851C20C7B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B8156EC;
	Mon,  7 Aug 2023 17:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3B156D6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BA4C433C9;
	Mon,  7 Aug 2023 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431014;
	bh=R5gg7WR3WkVLxE0UPf6rnXaB+MurObAXpkSGtEW59a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sy7XrdrD1p70CxRL8C8zaBm6dJcJGj1OFwfI6jbhAXb7b/cXANQI1rjoDn7uR06tw
	 Rnxi9/ASsIntLi2gzVmdS+ibbQ6dzanYrMjr7AKL9FYdIImHtLMzxsZlKzNVpJCpqZ
	 hHValLVGQjGZdk0oEVvv88SPNKuE4FpJMVDWUvaRv2BFuAvZQVfM/PMbgJxvFCWzEa
	 SGEWqne3MbyY68xSaw616eyLFLMNw2g2CiMn7E/ukaHGxol0bKh+XSgiCvsePusGvo
	 kb/yKOzuM6k7Ma7zrwdTNxCXcsFFSPKdSjLrvkufYwpBBy+yvI8vFeRe6gXGWYmn3T
	 B2c1GkX7P0Wiw==
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
Subject: [net-next 01/15] net/mlx5: Track the current number of completion EQs
Date: Mon,  7 Aug 2023 10:56:28 -0700
Message-ID: <20230807175642.20834-2-saeed@kernel.org>
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

In preparation to allocate completion EQs, add a counter to track the
number of completion EQs currently allocated. Store the maximum number
of EQs in max_comp_eqs variable.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 3db4866d7880..66257f7879b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -58,7 +58,8 @@ struct mlx5_eq_table {
 	struct mlx5_nb          cq_err_nb;
 
 	struct mutex            lock; /* sync async eqs creations */
-	int			num_comp_eqs;
+	int			curr_comp_eqs;
+	int			max_comp_eqs;
 	struct mlx5_irq_table	*irq_table;
 	struct mlx5_irq         **comp_irqs;
 	struct mlx5_irq         *ctrl_irq;
@@ -452,6 +453,7 @@ int mlx5_eq_table_init(struct mlx5_core_dev *dev)
 		ATOMIC_INIT_NOTIFIER_HEAD(&eq_table->nh[i]);
 
 	eq_table->irq_table = mlx5_irq_table_get(dev);
+	eq_table->curr_comp_eqs = 0;
 	return 0;
 }
 
@@ -807,7 +809,7 @@ static void comp_irqs_release_pci(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 
-	mlx5_irqs_release_vectors(table->comp_irqs, table->num_comp_eqs);
+	mlx5_irqs_release_vectors(table->comp_irqs, table->max_comp_eqs);
 }
 
 static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
@@ -821,7 +823,7 @@ static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 	int cpu;
 	int i;
 
-	ncomp_eqs = table->num_comp_eqs;
+	ncomp_eqs = table->max_comp_eqs;
 	cpus = kcalloc(ncomp_eqs, sizeof(*cpus), GFP_KERNEL);
 	if (!cpus)
 		return -ENOMEM;
@@ -847,13 +849,13 @@ static void comp_irqs_release_sf(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 
-	mlx5_irq_affinity_irqs_release(dev, table->comp_irqs, table->num_comp_eqs);
+	mlx5_irq_affinity_irqs_release(dev, table->comp_irqs, table->max_comp_eqs);
 }
 
 static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	int ncomp_eqs = table->num_comp_eqs;
+	int ncomp_eqs = table->max_comp_eqs;
 
 	return mlx5_irq_affinity_irqs_request_auto(dev, ncomp_eqs, table->comp_irqs);
 }
@@ -874,7 +876,7 @@ static int comp_irqs_request(struct mlx5_core_dev *dev)
 	int ncomp_eqs;
 	int ret;
 
-	ncomp_eqs = table->num_comp_eqs;
+	ncomp_eqs = table->max_comp_eqs;
 	table->comp_irqs = kcalloc(ncomp_eqs, sizeof(*table->comp_irqs), GFP_KERNEL);
 	if (!table->comp_irqs)
 		return -ENOMEM;
@@ -901,7 +903,7 @@ static int alloc_rmap(struct mlx5_core_dev *mdev)
 	if (mlx5_core_is_sf(mdev))
 		return 0;
 
-	eq_table->rmap = alloc_irq_cpu_rmap(eq_table->num_comp_eqs);
+	eq_table->rmap = alloc_irq_cpu_rmap(eq_table->max_comp_eqs);
 	if (!eq_table->rmap)
 		return -ENOMEM;
 	return 0;
@@ -934,6 +936,7 @@ static void destroy_comp_eqs(struct mlx5_core_dev *dev)
 				       eq->core.eqn);
 		tasklet_disable(&eq->tasklet_ctx.task);
 		kfree(eq);
+		table->curr_comp_eqs--;
 	}
 	comp_irqs_release(dev);
 	free_rmap(dev);
@@ -973,6 +976,7 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 		goto err_irqs_req;
 	}
 
+	table->max_comp_eqs = ncomp_eqs;
 	INIT_LIST_HEAD(&table->comp_eqs_list);
 	nent = comp_eq_depth_devlink_param_get(dev);
 
@@ -1008,9 +1012,9 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 		mlx5_core_dbg(dev, "allocated completion EQN %d\n", eq->core.eqn);
 		/* add tail, to keep the list ordered, for mlx5_vector2eqn to work */
 		list_add_tail(&eq->list, &table->comp_eqs_list);
+		table->curr_comp_eqs++;
 	}
 
-	table->num_comp_eqs = ncomp_eqs;
 	return 0;
 
 clean_eq:
@@ -1057,7 +1061,7 @@ int mlx5_vector2irqn(struct mlx5_core_dev *dev, int vector, unsigned int *irqn)
 
 unsigned int mlx5_comp_vectors_count(struct mlx5_core_dev *dev)
 {
-	return dev->priv.eq_table->num_comp_eqs;
+	return dev->priv.eq_table->max_comp_eqs;
 }
 EXPORT_SYMBOL(mlx5_comp_vectors_count);
 
@@ -1148,7 +1152,7 @@ int mlx5_eq_table_create(struct mlx5_core_dev *dev)
 	struct mlx5_eq_table *eq_table = dev->priv.eq_table;
 	int err;
 
-	eq_table->num_comp_eqs = get_num_eqs(dev);
+	eq_table->max_comp_eqs = get_num_eqs(dev);
 	err = create_async_eqs(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to create async EQs\n");
-- 
2.41.0


