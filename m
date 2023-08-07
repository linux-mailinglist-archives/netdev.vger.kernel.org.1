Return-Path: <netdev+bounces-25070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2354772D68
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE792814E3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A21643E;
	Mon,  7 Aug 2023 17:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA116418
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FB3C433CC;
	Mon,  7 Aug 2023 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431023;
	bh=36FhU5Ly+L6Ru+/KcavJ46GpWd8tKR9UbqvRgq7AJsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SW1A9Ku04BSR1bQ5cKJM3jkkqAqDX1CP64o1CaZ+Ov8LarpXfHDde1W4qBZM2adVa
	 0wcL2Az+EeAKxtUCPRed0KI5Tdw32fYVfOn6R9CWWD+1X+74YKggv9i0wD8PKEc6h5
	 MStVSHr6nTvZBsHs23lJaaagd8/en14vuGPnq8Nunp1uvwqQ3sYX7KjuvKEDfoIPZ1
	 pq3sD3gzs9vUaMODA28cnly+Jh924H0ypQhx738gJollNB8sOK1IR+opCdman0tJ+A
	 LYAw1EUrevYy2OtyDqBj8x6yrjfU9MaEy+KTILYfyGBiJiJesPzlrKnJl59JZ9nIze
	 GvBeNtEhHmu2Q==
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
Subject: [net-next 10/15] net/mlx5: Handle SF IRQ request in the absence of SF IRQ pool
Date: Mon,  7 Aug 2023 10:56:37 -0700
Message-ID: <20230807175642.20834-11-saeed@kernel.org>
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

In case the SF IRQ pool is not available due to setup limitations,
SF currently relies on the already allocated PF IRQs to fulfill
its IRQ vector requests.

However, with the dynamic EQ allocation introduced in the next patch,
it is possible that not all IRQs of PF will be allocated after the driver
is loaded. In such case, if a SF requests a completion IRQ without having
its own independent IRQ pool, SF will lack a PF IRQ to utilize.

To address this scenario, allocate an IRQ for the SF from the PF's IRQ pool
on demand. The new IRQ will be shared between the SF and it's PF.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 24 +++++++++++++++++--
 .../mellanox/mlx5/core/irq_affinity.c         | 12 ++++------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 6272962ea077..6e6e0a1c12b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -850,14 +850,29 @@ static int mlx5_cpumask_default_spread(int numa_node, int index)
 	return found_cpu;
 }
 
+static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
+{
+#ifdef CONFIG_RFS_ACCEL
+#ifdef CONFIG_MLX5_SF
+	if (mlx5_core_is_sf(dev))
+		return dev->priv.parent_mdev->priv.eq_table->rmap;
+#endif
+	return dev->priv.eq_table->rmap;
+#else
+	return NULL;
+#endif
+}
+
 static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct cpu_rmap *rmap;
 	struct mlx5_irq *irq;
 	int cpu;
 
+	rmap = mlx5_eq_table_get_pci_rmap(dev);
 	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
-	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &table->rmap);
+	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
@@ -883,8 +898,13 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 	struct mlx5_irq *irq;
 
 	irq = mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, vecidx);
-	if (IS_ERR(irq))
+	if (IS_ERR(irq)) {
+		/* In case SF irq pool does not exist, fallback to the PF irqs*/
+		if (PTR_ERR(irq) == -ENOENT)
+			return comp_irq_request_pci(dev, vecidx);
+
 		return PTR_ERR(irq);
+	}
 
 	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index ed51800f9f67..047d5fed5f89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -191,17 +191,13 @@ struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 	struct irq_affinity_desc af_desc = {};
 	struct mlx5_irq *irq;
 
+	if (!mlx5_irq_pool_is_sf_pool(pool))
+		return ERR_PTR(-ENOENT);
+
 	af_desc.is_managed = 1;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
 	cpumask_andnot(&af_desc.mask, &af_desc.mask, used_cpus);
-	if (mlx5_irq_pool_is_sf_pool(pool))
-		irq = mlx5_irq_affinity_request(pool, &af_desc);
-	else
-		/* In case SF pool doesn't exists, fallback to the PF IRQs.
-		 * The PF IRQs are already allocated and binded to CPU
-		 * at this point. Hence, only an index is needed.
-		 */
-		irq = mlx5_irq_request(dev, vecidx, NULL, NULL);
+	irq = mlx5_irq_affinity_request(pool, &af_desc);
 
 	if (IS_ERR(irq))
 		return irq;
-- 
2.41.0


