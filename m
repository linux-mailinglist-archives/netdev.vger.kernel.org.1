Return-Path: <netdev+bounces-25063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE744772D5E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6312813FE
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F8A15AD2;
	Mon,  7 Aug 2023 17:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F3156FC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5B9C433D9;
	Mon,  7 Aug 2023 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431016;
	bh=uD8Ol8LGYe5GuKI5VMDV7GwaVkoHUUuDSxSKgz6NqQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5AojTBQdWja2kkivZYRVWiKHMrhuq5omhFSpB9m/5ZTAo/+Hch+YvyM/9lxtxmiR
	 khkZkvB9ZPP2nEgz4qZyPp90feZYm3AbMO3GBxMiv5qVORV8/sbUd5jBX3OcfmmPWR
	 aDkCj3ewsyOrhS6MP10X3TYf9iI3WMshpzUJD9r+wP9GtCP5sXSxFGKukmCdfNNl8m
	 XEy2zQmlifxM6oGzTWpha7JBFxTcrWZv9+yclZGONXTvW/GO5VagUuRw9nIveyKRer
	 R9nwFVa1/Vg2sfeS88MDsvYmiljX/eKOUA+6kfftymZTVYPdHCidEr4StcRnTgpS1v
	 fIhHPBPGf+d2w==
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
Subject: [net-next 03/15] net/mlx5: Use xarray to store and manage completion IRQs
Date: Mon,  7 Aug 2023 10:56:30 -0700
Message-ID: <20230807175642.20834-4-saeed@kernel.org>
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

Use xarray to store the completion IRQs instead of a fixed-size allocated
array as not all completion IRQs will be requested on driver load, but
rather on demand when an EQ is created. The xarray offers more scalability,
reduced memory overhead, and provides the ability to dynamically resize the
array when needed.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 61 ++++++++++----------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 268fd61ae8c0..ac22d4d6b94b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -61,7 +61,7 @@ struct mlx5_eq_table {
 	int			curr_comp_eqs;
 	int			max_comp_eqs;
 	struct mlx5_irq_table	*irq_table;
-	struct mlx5_irq         **comp_irqs;
+	struct xarray           comp_irqs;
 	struct mlx5_irq         *ctrl_irq;
 	struct cpu_rmap		*rmap;
 	struct cpumask          used_cpus;
@@ -455,14 +455,18 @@ int mlx5_eq_table_init(struct mlx5_core_dev *dev)
 
 	eq_table->irq_table = mlx5_irq_table_get(dev);
 	cpumask_clear(&eq_table->used_cpus);
+	xa_init(&eq_table->comp_irqs);
 	eq_table->curr_comp_eqs = 0;
 	return 0;
 }
 
 void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev)
 {
+	struct mlx5_eq_table *table = dev->priv.eq_table;
+
 	mlx5_eq_debugfs_cleanup(dev);
-	kvfree(dev->priv.eq_table);
+	xa_destroy(&table->comp_irqs);
+	kvfree(table);
 }
 
 /* Async EQs */
@@ -810,10 +814,13 @@ EXPORT_SYMBOL(mlx5_eq_update_ci);
 static void comp_irqs_release_pci(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	int i;
+	struct mlx5_irq *irq;
+	unsigned long index;
 
-	for (i = 0; i < table->max_comp_eqs; i++)
-		mlx5_irq_release_vector(table->comp_irqs[i]);
+	xa_for_each(&table->comp_irqs, index, irq) {
+		xa_erase(&table->comp_irqs, index);
+		mlx5_irq_release_vector(irq);
+	}
 }
 
 static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
@@ -849,7 +856,8 @@ static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 		if (IS_ERR(irq))
 			break;
 
-		table->comp_irqs[i] = irq;
+		if (xa_err(xa_store(&table->comp_irqs, i, irq, GFP_KERNEL)))
+			break;
 	}
 
 	kfree(cpus);
@@ -859,10 +867,13 @@ static int comp_irqs_request_pci(struct mlx5_core_dev *dev)
 static void comp_irqs_release_sf(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
-	int i;
+	struct mlx5_irq *irq;
+	unsigned long index;
 
-	for (i = 0; i < table->max_comp_eqs; i++)
-		mlx5_irq_affinity_irq_release(dev, table->comp_irqs[i]);
+	xa_for_each(&table->comp_irqs, index, irq) {
+		xa_erase(&table->comp_irqs, index);
+		mlx5_irq_affinity_irq_release(dev, irq);
+	}
 }
 
 static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
@@ -876,7 +887,8 @@ static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
 		if (IS_ERR(irq))
 			break;
 
-		table->comp_irqs[i] = irq;
+		if (xa_err(xa_store(&table->comp_irqs, i, irq, GFP_KERNEL)))
+			break;
 	}
 
 	return i ? i : PTR_ERR(irq);
@@ -884,31 +896,14 @@ static int comp_irqs_request_sf(struct mlx5_core_dev *dev)
 
 static void comp_irqs_release(struct mlx5_core_dev *dev)
 {
-	struct mlx5_eq_table *table = dev->priv.eq_table;
-
 	mlx5_core_is_sf(dev) ? comp_irqs_release_sf(dev) :
 			       comp_irqs_release_pci(dev);
-
-	kfree(table->comp_irqs);
 }
 
 static int comp_irqs_request(struct mlx5_core_dev *dev)
 {
-	struct mlx5_eq_table *table = dev->priv.eq_table;
-	int ncomp_eqs;
-	int ret;
-
-	ncomp_eqs = table->max_comp_eqs;
-	table->comp_irqs = kcalloc(ncomp_eqs, sizeof(*table->comp_irqs), GFP_KERNEL);
-	if (!table->comp_irqs)
-		return -ENOMEM;
-
-	ret = mlx5_core_is_sf(dev) ? comp_irqs_request_sf(dev) :
-				     comp_irqs_request_pci(dev);
-	if (ret < 0)
-		kfree(table->comp_irqs);
-
-	return ret;
+	return mlx5_core_is_sf(dev) ? comp_irqs_request_sf(dev) :
+				      comp_irqs_request_pci(dev);
 }
 
 #ifdef CONFIG_RFS_ACCEL
@@ -983,10 +978,11 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_eq_comp *eq;
+	struct mlx5_irq *irq;
+	unsigned long index;
 	int ncomp_eqs;
 	int nent;
 	int err;
-	int i;
 
 	err = alloc_rmap(dev);
 	if (err)
@@ -1002,7 +998,8 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 	INIT_LIST_HEAD(&table->comp_eqs_list);
 	nent = comp_eq_depth_devlink_param_get(dev);
 
-	for (i = 0; i < ncomp_eqs; i++) {
+	xa_for_each(&table->comp_irqs, index, irq)
+	{
 		struct mlx5_eq_param param = {};
 
 		eq = kzalloc_node(sizeof(*eq), GFP_KERNEL, dev->priv.numa_node);
@@ -1018,7 +1015,7 @@ static int create_comp_eqs(struct mlx5_core_dev *dev)
 
 		eq->irq_nb.notifier_call = mlx5_eq_comp_int;
 		param = (struct mlx5_eq_param) {
-			.irq = table->comp_irqs[i],
+			.irq = irq,
 			.nent = nent,
 		};
 
-- 
2.41.0


