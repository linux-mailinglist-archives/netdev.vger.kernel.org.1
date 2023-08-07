Return-Path: <netdev+bounces-25062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB1772D5C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4441928135C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26515AC1;
	Mon,  7 Aug 2023 17:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C3156E7
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68935C433C7;
	Mon,  7 Aug 2023 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431015;
	bh=FMu3HSLRRvm8urJNQ31qIGI5wrI2/w9YBXdoldPKdEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwUwBf0jVRmBlMMyqn/iHu7D4T8wL0Od91PtqbbyqWe3P+4y89/LlGoi9nAC4N1f9
	 IiYqLcnN1Ka6NXUisUoyvwa1TEAXI71KTZPy6VflOp9A3+VZCOtPmYMyll6u96dKYG
	 FJkzCZdIiUqBSrnnZ9O7sSENOu9yY1s6a8LgvVZwFrglIWVDysq95awCwOI2aDaz8a
	 LDd34j2e77xFe7TEnWLACUNDZVl+KLdQqyyl9Kc1a/OxzljjG51ePDN+oFIqF2dcLU
	 VSrrpgspdz2wJTdf0Xxs+ajajqjVHii0zljFPjMZwpRCV+uVe+maHb2IJJ1kxXabtJ
	 CPNb0U7zvEflA==
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
Subject: [net-next 02/15] net/mlx5: Refactor completion IRQ request/release API
Date: Mon,  7 Aug 2023 10:56:29 -0700
Message-ID: <20230807175642.20834-3-saeed@kernel.org>
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

Introduce a per-vector completion IRQ request API that requests a
single IRQ for a given vector index instead of multiple IRQs request API.
On driver load, loop over all completion vectors and request an IRQ for
each one via the newly introduced API.

Symmetrically, introduce an IRQ release API per vector. On driver
unload, loop over all vectors and release each completion IRQ via
the new per-vector API.

As IRQ vectors will be requested dynamically later in the patchset,
add a cpumask of the bounded CPUs to avoid the possible mapping of
two IRQs of the same device to the same cpu.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 36 ++++++--
 .../mellanox/mlx5/core/irq_affinity.c         | 82 +++++++++----------
 .../ethernet/mellanox/mlx5/core/mlx5_irq.h    | 26 +++---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 60 +++++---------
 4 files changed, 101 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 66257f7879b7..268fd61ae8c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -64,6 +64,7 @@ struct mlx5_eq_table {
 	struct mlx5_irq         **comp_irqs;
 	struct mlx5_irq         *ctrl_irq;
 	struct cpu_rmap		*rmap;
+	struct cpumask          used_cpus;
 };
 
 #define MLX5_ASYNC_EVENT_MASK ((1ull << MLX5_EVENT_TYPE_PATH_MIG)	    | \
@@ -453,6 +454,7 @@ int mlx5_eq_table_init(struct mlx5_core_dev *dev)
 		ATOMIC_INIT_NOTIFIER_HEAD(&eq_table->nh[i]);
 
 	eq_table->irq_table = mlx5_irq_table_get(dev);
+	cpumask_clear(&eq_table->used_cpus);
 	eq_table->curr_comp_eqs = 0;
 	return 0;
 }
@@ -808,8 +810,10 @@ EXPORT_SYMBOL(mlx5_eq_update_ci);
 static void comp_irqs_release_pci(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
+	int i;
 
-	mlx5_irqs_release_vectors(table->comp_irqs, table->max_comp_eqs);
+	for (i = 0; i < table->max_comp_eqs; i++)
+		mlx5_irq_release_vector(table->comp_irqs[i]);
 }
 
 static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
@@ -817,9 +821,9 @@ static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	const struct cpumask *prev = cpu_none_mask;
 	const struct cpumask *mask;
+	struct mlx5_irq *irq;
 	int ncomp_eqs;
 	u16 *cpus;
-	int ret;
 	int cpu;
 	int i;
 
@@ -840,24 +844,42 @@ static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 	}
 spread_done:
 	rcu_read_unlock();
-	ret = mlx5_irqs_request_vectors(dev, cpus, ncomp_eqs, table->comp_irqs, &table->rmap);
+	for (i = 0; i < ncomp_eqs; i++) {
+		irq = mlx5_irq_request_vector(dev, cpus[i], i, &table->rmap);
+		if (IS_ERR(irq))
+			break;
+
+		table->comp_irqs[i] = irq;
+	}
+
 	kfree(cpus);
-	return ret;
+	return i ? i : PTR_ERR(irq);
 }
 
 static void comp_irqs_release_sf(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
+	int i;
 
-	mlx5_irq_affinity_irqs_release(dev, table->comp_irqs, table->max_comp_eqs);
+	for (i = 0; i < table->max_comp_eqs; i++)
+		mlx5_irq_affinity_irq_release(dev, table->comp_irqs[i]);
 }
 
 static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	int ncomp_eqs = table->max_comp_eqs;
+	struct mlx5_irq *irq;
+	int i;
+
+	for (i = 0; i < table->max_comp_eqs; i++) {
+		irq = mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, i);
+		if (IS_ERR(irq))
+			break;
+
+		table->comp_irqs[i] = irq;
+	}
 
-	return mlx5_irq_affinity_irqs_request_auto(dev, ncomp_eqs, table->comp_irqs);
+	return i ? i : PTR_ERR(irq);
 }
 
 static void comp_irqs_release(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index fa467335526e..ed51800f9f67 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -156,67 +156,61 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 	return least_loaded_irq;
 }
 
-void mlx5_irq_affinity_irqs_release(struct mlx5_core_dev *dev, struct mlx5_irq **irqs,
-				    int num_irqs)
+void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq)
 {
 	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
-	int i;
-
-	for (i = 0; i < num_irqs; i++) {
-		int cpu = cpumask_first(mlx5_irq_get_affinity_mask(irqs[i]));
+	int cpu;
 
-		synchronize_irq(pci_irq_vector(pool->dev->pdev,
-					       mlx5_irq_get_index(irqs[i])));
-		if (mlx5_irq_put(irqs[i]))
-			if (pool->irqs_per_cpu)
-				cpu_put(pool, cpu);
-	}
+	cpu = cpumask_first(mlx5_irq_get_affinity_mask(irq));
+	synchronize_irq(pci_irq_vector(pool->dev->pdev,
+				       mlx5_irq_get_index(irq)));
+	if (mlx5_irq_put(irq))
+		if (pool->irqs_per_cpu)
+			cpu_put(pool, cpu);
 }
 
 /**
- * mlx5_irq_affinity_irqs_request_auto - request one or more IRQs for mlx5 device.
- * @dev: mlx5 device that is requesting the IRQs.
- * @nirqs: number of IRQs to request.
- * @irqs: an output array of IRQs pointers.
+ * mlx5_irq_affinity_irq_request_auto - request one IRQ for mlx5 device.
+ * @dev: mlx5 device that is requesting the IRQ.
+ * @used_cpus: cpumask of bounded cpus by the device
+ * @vecidx: vector index to request an IRQ for.
  *
  * Each IRQ is bounded to at most 1 CPU.
- * This function is requesting IRQs according to the default assignment.
+ * This function is requesting an IRQ according to the default assignment.
  * The default assignment policy is:
- * - in each iteration, request the least loaded IRQ which is not bound to any
+ * - request the least loaded IRQ which is not bound to any
  *   CPU of the previous IRQs requested.
  *
- * This function returns the number of IRQs requested, (which might be smaller than
- * @nirqs), if successful, or a negative error code in case of an error.
+ * On success, this function updates used_cpus mask and returns an irq pointer.
+ * In case of an error, an appropriate error pointer is returned.
  */
-int mlx5_irq_affinity_irqs_request_auto(struct mlx5_core_dev *dev, int nirqs,
-					struct mlx5_irq **irqs)
+struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
+						    struct cpumask *used_cpus, u16 vecidx)
 {
 	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
 	struct irq_affinity_desc af_desc = {};
 	struct mlx5_irq *irq;
-	int i = 0;
 
 	af_desc.is_managed = 1;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	for (i = 0; i < nirqs; i++) {
-		if (mlx5_irq_pool_is_sf_pool(pool))
-			irq = mlx5_irq_affinity_request(pool, &af_desc);
-		else
-			/* In case SF pool doesn't exists, fallback to the PF IRQs.
-			 * The PF IRQs are already allocated and binded to CPU
-			 * at this point. Hence, only an index is needed.
-			 */
-			irq = mlx5_irq_request(dev, i, NULL, NULL);
-		if (IS_ERR(irq))
-			break;
-		irqs[i] = irq;
-		cpumask_clear_cpu(cpumask_first(mlx5_irq_get_affinity_mask(irq)), &af_desc.mask);
-		mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
-			      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
-			      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
-			      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
-	}
-	if (!i)
-		return PTR_ERR(irq);
-	return i;
+	cpumask_andnot(&af_desc.mask, &af_desc.mask, used_cpus);
+	if (mlx5_irq_pool_is_sf_pool(pool))
+		irq = mlx5_irq_affinity_request(pool, &af_desc);
+	else
+		/* In case SF pool doesn't exists, fallback to the PF IRQs.
+		 * The PF IRQs are already allocated and binded to CPU
+		 * at this point. Hence, only an index is needed.
+		 */
+		irq = mlx5_irq_request(dev, vecidx, NULL, NULL);
+
+	if (IS_ERR(irq))
+		return irq;
+
+	cpumask_or(used_cpus, used_cpus, mlx5_irq_get_affinity_mask(irq));
+	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
+		      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
+		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
+		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
+
+	return irq;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
index aa403a5ea34e..1088114e905d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
@@ -29,9 +29,9 @@ void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq);
 struct mlx5_irq *mlx5_irq_request(struct mlx5_core_dev *dev, u16 vecidx,
 				  struct irq_affinity_desc *af_desc,
 				  struct cpu_rmap **rmap);
-int mlx5_irqs_request_vectors(struct mlx5_core_dev *dev, u16 *cpus, int nirqs,
-			      struct mlx5_irq **irqs, struct cpu_rmap **rmap);
-void mlx5_irqs_release_vectors(struct mlx5_irq **irqs, int nirqs);
+struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
+					 u16 vecidx, struct cpu_rmap **rmap);
+void mlx5_irq_release_vector(struct mlx5_irq *irq);
 int mlx5_irq_attach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 int mlx5_irq_detach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq);
@@ -39,17 +39,17 @@ int mlx5_irq_get_index(struct mlx5_irq *irq);
 
 struct mlx5_irq_pool;
 #ifdef CONFIG_MLX5_SF
-int mlx5_irq_affinity_irqs_request_auto(struct mlx5_core_dev *dev, int nirqs,
-					struct mlx5_irq **irqs);
+struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
+						    struct cpumask *used_cpus, u16 vecidx);
 struct mlx5_irq *mlx5_irq_affinity_request(struct mlx5_irq_pool *pool,
 					   struct irq_affinity_desc *af_desc);
-void mlx5_irq_affinity_irqs_release(struct mlx5_core_dev *dev, struct mlx5_irq **irqs,
-				    int num_irqs);
+void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq);
 #else
-static inline int mlx5_irq_affinity_irqs_request_auto(struct mlx5_core_dev *dev, int nirqs,
-						      struct mlx5_irq **irqs)
+static inline
+struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
+						    struct cpumask *used_cpus, u16 vecidx)
 {
-	return -EOPNOTSUPP;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct mlx5_irq *
@@ -58,7 +58,9 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline void mlx5_irq_affinity_irqs_release(struct mlx5_core_dev *dev,
-						  struct mlx5_irq **irqs, int num_irqs) {}
+static inline
+void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq)
+{
+}
 #endif
 #endif /* __MLX5_IRQ_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index cba2a4afb5fd..33a133c9918c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -432,19 +432,10 @@ static struct mlx5_irq_pool *ctrl_irq_pool_get(struct mlx5_core_dev *dev)
 	return pool ? pool : irq_table->pcif_pool;
 }
 
-/**
- * mlx5_irqs_release - release one or more IRQs back to the system.
- * @irqs: IRQs to be released.
- * @nirqs: number of IRQs to be released.
- */
-static void mlx5_irqs_release(struct mlx5_irq **irqs, int nirqs)
+static void _mlx5_irq_release(struct mlx5_irq *irq)
 {
-	int i;
-
-	for (i = 0; i < nirqs; i++) {
-		synchronize_irq(irqs[i]->map.virq);
-		mlx5_irq_put(irqs[i]);
-	}
+	synchronize_irq(irq->map.virq);
+	mlx5_irq_put(irq);
 }
 
 /**
@@ -453,7 +444,7 @@ static void mlx5_irqs_release(struct mlx5_irq **irqs, int nirqs)
  */
 void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq)
 {
-	mlx5_irqs_release(&ctrl_irq, 1);
+	_mlx5_irq_release(ctrl_irq);
 }
 
 /**
@@ -569,53 +560,42 @@ void mlx5_msix_free(struct mlx5_core_dev *dev, struct msi_map map)
 EXPORT_SYMBOL(mlx5_msix_free);
 
 /**
- * mlx5_irqs_release_vectors - release one or more IRQs back to the system.
- * @irqs: IRQs to be released.
- * @nirqs: number of IRQs to be released.
+ * mlx5_irq_release_vector - release one IRQ back to the system.
+ * @irq: the irq to release.
  */
-void mlx5_irqs_release_vectors(struct mlx5_irq **irqs, int nirqs)
+void mlx5_irq_release_vector(struct mlx5_irq *irq)
 {
-	mlx5_irqs_release(irqs, nirqs);
+	_mlx5_irq_release(irq);
 }
 
 /**
- * mlx5_irqs_request_vectors - request one or more IRQs for mlx5 device.
- * @dev: mlx5 device that is requesting the IRQs.
- * @cpus: CPUs array for binding the IRQs
- * @nirqs: number of IRQs to request.
- * @irqs: an output array of IRQs pointers.
+ * mlx5_irq_request_vector - request one IRQ for mlx5 device.
+ * @dev: mlx5 device that is requesting the IRQ.
+ * @cpu: CPU to bind the IRQ to.
+ * @vecidx: vector index to request an IRQ for.
  * @rmap: pointer to reverse map pointer for completion interrupts
  *
  * Each IRQ is bound to at most 1 CPU.
- * This function is requests nirqs IRQs, starting from @vecidx.
+ * This function is requests one IRQ, for the given @vecidx.
  *
- * This function returns the number of IRQs requested, (which might be smaller than
- * @nirqs), if successful, or a negative error code in case of an error.
+ * This function returns a pointer to the irq on success, or an error pointer
+ * in case of an error.
  */
-int mlx5_irqs_request_vectors(struct mlx5_core_dev *dev, u16 *cpus, int nirqs,
-			      struct mlx5_irq **irqs, struct cpu_rmap **rmap)
+struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
+					 u16 vecidx, struct cpu_rmap **rmap)
 {
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
 	struct irq_affinity_desc af_desc;
-	struct mlx5_irq *irq;
 	int offset = 1;
-	int i;
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
 
 	af_desc.is_managed = false;
-	for (i = 0; i < nirqs; i++) {
-		cpumask_clear(&af_desc.mask);
-		cpumask_set_cpu(cpus[i], &af_desc.mask);
-		irq = mlx5_irq_request(dev, i + offset, &af_desc, rmap);
-		if (IS_ERR(irq))
-			break;
-		irqs[i] = irq;
-	}
-
-	return i ? i : PTR_ERR(irq);
+	cpumask_clear(&af_desc.mask);
+	cpumask_set_cpu(cpu, &af_desc.mask);
+	return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
 }
 
 static struct mlx5_irq_pool *
-- 
2.41.0


