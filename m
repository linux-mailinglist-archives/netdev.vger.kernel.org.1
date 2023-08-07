Return-Path: <netdev+bounces-25068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD5772D65
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551E41C20C87
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFF16423;
	Mon,  7 Aug 2023 17:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2816418
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB5C433C8;
	Mon,  7 Aug 2023 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431021;
	bh=S1A9IarbqckPwekS8ZS/ikRbj2ImKTRbMJH2Y115MnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TswAJV8k0Sp+G91q+KZv0ebaa1I+mBBdDImgPkshQ9MRm+UmpiiSTnK3qwaW37Zas
	 casTUZdk4qvd1Na6kKTwCOfGTnt1meT4AmsBvEKHRZAEetM+pL2SAl+E56iVEqGeoL
	 gCzMp0ekZ99fDvNcl0CWLlHAwC5rdEGs0qVg2VyRygssKdROhE34j5EwwMvkmaU5lg
	 vm+UZgaDHC0tmbvrYY8X3ndYDzzXkRaPtJS170DpxE+OcUEh1DJGwpzi5lubva91m6
	 0tjvKCw7V8wg46EVqA/gUwWRotxKStH0LotVIXtYpR17PS8kiO04fcoKnNAHDya5Pe
	 aApgg3XVyA2Aw==
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
Subject: [net-next 08/15] net/mlx5: Add IRQ vector to CPU lookup function
Date: Mon,  7 Aug 2023 10:56:35 -0700
Message-ID: <20230807175642.20834-9-saeed@kernel.org>
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

Currently, once driver load completes, IRQ requests were performed for all
vectors. However, as we move to support dynamic creation of EQs, this will
not be the case as some IRQs will not exist at this stage. Thus, in such
case, use the default CPU to IRQ mapping which is the serial mapping based
on IRQ vector index. Meaning, the n'th vector gets mapped to the n'th CPU.

Introduce an API function mlx5_comp_vector_cpu() that takes an IRQ index and
provides the corresponding CPU mapping. It utilizes the existing IRQ
affinity if defined, or resorts to the default serialized CPU mapping
otherwise.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 19 ++++++++++++++++---
 include/linux/mlx5/driver.h                   |  3 +--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index 201ac7dd338f..bcf9807a5556 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -128,7 +128,7 @@ static void mlx5e_build_trap_params(struct mlx5_core_dev *mdev,
 
 static struct mlx5e_trap *mlx5e_open_trap(struct mlx5e_priv *priv)
 {
-	int cpu = cpumask_first(mlx5_comp_irq_get_affinity_mask(priv->mdev, 0));
+	int cpu = mlx5_comp_vector_get_cpu(priv->mdev, 0);
 	struct net_device *netdev = priv->netdev;
 	struct mlx5e_trap *t;
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1c820119e438..9ec7b975c549 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2445,7 +2445,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct xsk_buff_pool *xsk_pool,
 			      struct mlx5e_channel **cp)
 {
-	int cpu = cpumask_first(mlx5_comp_irq_get_affinity_mask(priv->mdev, ix));
+	int cpu = mlx5_comp_vector_get_cpu(priv->mdev, ix);
 	struct net_device *netdev = priv->netdev;
 	struct mlx5e_xsk_param xsk;
 	struct mlx5e_channel *c;
@@ -2862,7 +2862,7 @@ static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
 		cpumask_clear(priv->scratchpad.cpumask);
 
 		for (irq = ix; irq < num_comp_vectors; irq += params->num_channels) {
-			int cpu = cpumask_first(mlx5_comp_irq_get_affinity_mask(mdev, irq));
+			int cpu = mlx5_comp_vector_get_cpu(mdev, irq);
 
 			cpumask_set_cpu(cpu, priv->scratchpad.cpumask);
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ad654d460d0c..2f5c0d00285f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1058,7 +1058,7 @@ unsigned int mlx5_comp_vectors_count(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_comp_vectors_count);
 
-struct cpumask *
+static struct cpumask *
 mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
@@ -1068,10 +1068,23 @@ mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector)
 	if (eq)
 		return mlx5_irq_get_affinity_mask(eq->core.irq);
 
-	WARN_ON_ONCE(1);
 	return NULL;
 }
-EXPORT_SYMBOL(mlx5_comp_irq_get_affinity_mask);
+
+int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
+{
+	struct cpumask *mask;
+	int cpu;
+
+	mask = mlx5_comp_irq_get_affinity_mask(dev, vector);
+	if (mask)
+		cpu = cpumask_first(mask);
+	else
+		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
+
+	return cpu;
+}
+EXPORT_SYMBOL(mlx5_comp_vector_get_cpu);
 
 #ifdef CONFIG_RFS_ACCEL
 struct cpu_rmap *mlx5_eq_table_get_rmap(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fa70c25423b2..e686722fa4ca 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1109,8 +1109,7 @@ int mlx5_alloc_bfreg(struct mlx5_core_dev *mdev, struct mlx5_sq_bfreg *bfreg,
 void mlx5_free_bfreg(struct mlx5_core_dev *mdev, struct mlx5_sq_bfreg *bfreg);
 
 unsigned int mlx5_comp_vectors_count(struct mlx5_core_dev *dev);
-struct cpumask *
-mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector);
+int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector);
 unsigned int mlx5_core_reserved_gids_count(struct mlx5_core_dev *dev);
 int mlx5_core_roce_gid_set(struct mlx5_core_dev *dev, unsigned int index,
 			   u8 roce_version, u8 roce_l3_type, const u8 *gid,
-- 
2.41.0


