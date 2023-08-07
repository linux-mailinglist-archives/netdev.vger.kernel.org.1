Return-Path: <netdev+bounces-25064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C5772D5F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064401C204F0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FA156E7;
	Mon,  7 Aug 2023 17:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BA156D6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C959C433C9;
	Mon,  7 Aug 2023 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431017;
	bh=ByG38slnjgUSSV9tkY0i2KscLZgdxOITorw5YuO4tPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRO6lPPvUIGa8UGdKqvGybRMS3fZOAfw0cJBCqReLG3U74Y4FUo5XVauExuhpyLO8
	 F+AiEVcOxgmeU2dfzESCC0Ij0En0WC4R2fXYRjbhiES3m7PJseQPrFLUCpFPuz1kZd
	 mP1ZTWXOc3S99A0bRChXWkyY9xINGt96HyL5LAmfBIO8+Dth9x9NVi/L7ilr6DqWEm
	 3xMUtqecxDr9jk07vGmxrw+4j9raeo0NWd9tbf/82tquhPJg9JVPuHpL798Zdnkc0A
	 8wrETE/TlJ1gm5T2XVKnjIv5zuEIZE+/z4ma/zOTPgOFmZ3LChK12VYzF11NM3TQV6
	 FxDZJJU+/2duQ==
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
Subject: [net-next 04/15] net/mlx5: Refactor completion IRQ request/release handlers in EQ layer
Date: Mon,  7 Aug 2023 10:56:31 -0700
Message-ID: <20230807175642.20834-5-saeed@kernel.org>
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

Break the completion IRQ request/release functions into per-vector
handlers for both PCI devices and SFs in the EQ layer.

On EQ table creation, loop over all vectors and request an IRQ for each
one using the new per-vector functions. Perform the symmetrical change
when releasing IRQs on EQ table cleanup.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 109 +++++++++----------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ac22d4d6b94b..c01a5d8dbe9b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -811,99 +811,84 @@ void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)
 }
 EXPORT_SYMBOL(mlx5_eq_update_ci);
 
-static void comp_irqs_release_pci(struct mlx5_core_dev *dev)
+static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_irq *irq;
-	unsigned long index;
 
-	xa_for_each(&table->comp_irqs, index, irq) {
-		xa_erase(&table->comp_irqs, index);
-		mlx5_irq_release_vector(irq);
-	}
+	irq = xa_load(&table->comp_irqs, vecidx);
+	if (!irq)
+		return;
+
+	xa_erase(&table->comp_irqs, vecidx);
+	mlx5_irq_release_vector(irq);
 }
 
-static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
+static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	const struct cpumask *prev = cpu_none_mask;
 	const struct cpumask *mask;
 	struct mlx5_irq *irq;
-	int ncomp_eqs;
-	u16 *cpus;
+	int found_cpu = 0;
+	int i = 0;
 	int cpu;
-	int i;
-
-	ncomp_eqs = table->max_comp_eqs;
-	cpus = kcalloc(ncomp_eqs, sizeof(*cpus), GFP_KERNEL);
-	if (!cpus)
-		return -ENOMEM;
 
-	i = 0;
 	rcu_read_lock();
 	for_each_numa_hop_mask(mask, dev->priv.numa_node) {
 		for_each_cpu_andnot(cpu, mask, prev) {
-			cpus[i] = cpu;
-			if (++i == ncomp_eqs)
+			if (i++ == vecidx) {
+				found_cpu = cpu;
 				goto spread_done;
+			}
 		}
 		prev = mask;
 	}
+
 spread_done:
 	rcu_read_unlock();
-	for (i = 0; i < ncomp_eqs; i++) {
-		irq = mlx5_irq_request_vector(dev, cpus[i], i, &table->rmap);
-		if (IS_ERR(irq))
-			break;
-
-		if (xa_err(xa_store(&table->comp_irqs, i, irq, GFP_KERNEL)))
-			break;
-	}
+	irq = mlx5_irq_request_vector(dev, found_cpu, vecidx, &table->rmap);
+	if (IS_ERR(irq))
+		return PTR_ERR(irq);
 
-	kfree(cpus);
-	return i ? i : PTR_ERR(irq);
+	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 }
 
-static void comp_irqs_release_sf(struct mlx5_core_dev *dev)
+static void comp_irq_release_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_irq *irq;
-	unsigned long index;
 
-	xa_for_each(&table->comp_irqs, index, irq) {
-		xa_erase(&table->comp_irqs, index);
-		mlx5_irq_affinity_irq_release(dev, irq);
-	}
+	irq = xa_load(&table->comp_irqs, vecidx);
+	if (!irq)
+		return;
+
+	xa_erase(&table->comp_irqs, vecidx);
+	mlx5_irq_affinity_irq_release(dev, irq);
 }
 
-static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
+static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_irq *irq;
-	int i;
-
-	for (i = 0; i < table->max_comp_eqs; i++) {
-		irq = mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, i);
-		if (IS_ERR(irq))
-			break;
 
-		if (xa_err(xa_store(&table->comp_irqs, i, irq, GFP_KERNEL)))
-			break;
-	}
+	irq = mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, vecidx);
+	if (IS_ERR(irq))
+		return PTR_ERR(irq);
 
-	return i ? i : PTR_ERR(irq);
+	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 }
 
-static void comp_irqs_release(struct mlx5_core_dev *dev)
+static void comp_irq_release(struct mlx5_core_dev *dev, u16 vecidx)
 {
-	mlx5_core_is_sf(dev) ? comp_irqs_release_sf(dev) :
-			       comp_irqs_release_pci(dev);
+	mlx5_core_is_sf(dev) ? comp_irq_release_sf(dev, vecidx) :
+			       comp_irq_release_pci(dev, vecidx);
 }
 
-static int comp_irqs_request(struct mlx5_core_dev *dev)
+static int comp_irq_request(struct mlx5_core_dev *dev, u16 vecidx)
 {
-	return mlx5_core_is_sf(dev) ? comp_irqs_request_sf(dev) :
-				      comp_irqs_request_pci(dev);
+	return mlx5_core_is_sf(dev) ? comp_irq_request_sf(dev, vecidx) :
+				      comp_irq_request_pci(dev, vecidx);
 }
 
 #ifdef CONFIG_RFS_ACCEL
@@ -944,6 +929,8 @@ static void destroy_comp_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq, *n;
+	struct mlx5_irq *irq;
+	unsigned long index;
 
 	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
 		list_del(&eq->list);
@@ -955,7 +942,10 @@ static void destroy_comp_eqs(struct mlx5_core_dev *dev)
 		kfree(eq);
 		table->curr_comp_eqs--;
 	}
-	comp_irqs_release(dev);
+
+	xa_for_each(&table->comp_irqs, index, irq)
+		comp_irq_release(dev, index);
+
 	free_rmap(dev);
 }
 
@@ -980,7 +970,7 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 	struct mlx5_eq_comp *eq;
 	struct mlx5_irq *irq;
 	unsigned long index;
-	int ncomp_eqs;
+	int vecidx;
 	int nent;
 	int err;
 
@@ -988,13 +978,16 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 	if (err)
 		return err;
 
-	ncomp_eqs = comp_irqs_request(dev);
-	if (ncomp_eqs < 0) {
-		err = ncomp_eqs;
-		goto err_irqs_req;
+	for (vecidx = 0; vecidx < table->max_comp_eqs; vecidx++) {
+		err = comp_irq_request(dev, vecidx);
+		if (err < 0)
+			break;
 	}
 
-	table->max_comp_eqs = ncomp_eqs;
+	if (!vecidx)
+		goto err_irqs_req;
+
+	table->max_comp_eqs = vecidx;
 	INIT_LIST_HEAD(&table->comp_eqs_list);
 	nent = comp_eq_depth_devlink_param_get(dev);
 
-- 
2.41.0


