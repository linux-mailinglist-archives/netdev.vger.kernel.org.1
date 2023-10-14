Return-Path: <netdev+bounces-41014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2C7C959E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF09B20CA8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606D1F5EA;
	Sat, 14 Oct 2023 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4EeJrxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C61D6AF
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0591C433CD;
	Sat, 14 Oct 2023 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303965;
	bh=ThBNBZqR1t9fWohzeAjws9GEH9JtUKojWG2q0ciEjwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4EeJrxfSFe6TAU5ysP7sdd2V6IDEMrxXMh43hbsQsg00Hw/lZ8gAI/47VkRo8iPv
	 iXbHMUYcnUSKcvi0xSIEtAJo/oSId050qHf9c43laRS9MMZ9AjWe8y9b9hLCdRLk3c
	 zt3yemcSRaxw3gimKfGLQHxRbZCuJKQo2JFNtdek2TsCnkJy9CY6EG7xH9+ONRbWgW
	 vZ9eP490hi4tJHof+sflE9EnS5Go5kl1XQL8S6wNJLo8p0zEhd3CnwLQWcHxYeTsI0
	 ji9orwl7ne6EU+lCr7WM+Xj/JdqoTRJ1nf2XZFQN12HkwN+3wYh4ff34YxLBNne4Vb
	 prZNP5kbfaRIw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Wei Zhang <weizhang@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 02/15] net/mlx5: Redesign SF active work to remove table_lock
Date: Sat, 14 Oct 2023 10:18:55 -0700
Message-ID: <20231014171908.290428-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Zhang <weizhang@nvidia.com>

active_work is a work that iterates over all
possible SF devices which their SF port
representors are located on different function,
and in case SF is in active state, probes it.
Currently, the active_work in active_wq is
synced with mlx5_vhca_events_work via table_lock
and this lock causing a bottleneck in performance.

To remove table_lock, redesign active_wq logic
so that it now pushes active_work per SF to
mlx5_vhca_events_workqueues. Since the latter
workqueues are ordered, active_work and
mlx5_vhca_events_work with same index will be
pushed into same workqueue, thus it completely
eliminates the need for a lock.

Signed-off-by: Wei Zhang <weizhang@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  | 86 ++++++++++++-------
 .../mellanox/mlx5/core/sf/vhca_event.c        | 16 +++-
 .../mellanox/mlx5/core/sf/vhca_event.h        |  3 +
 3 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 0f9b280514b8..c93492b67788 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -17,13 +17,19 @@ struct mlx5_sf_dev_table {
 	phys_addr_t base_address;
 	u64 sf_bar_length;
 	struct notifier_block nb;
-	struct mutex table_lock; /* Serializes sf life cycle and vhca state change handler */
 	struct workqueue_struct *active_wq;
 	struct work_struct work;
 	u8 stop_active_wq:1;
 	struct mlx5_core_dev *dev;
 };
 
+struct mlx5_sf_dev_active_work_ctx {
+	struct work_struct work;
+	struct mlx5_vhca_state_event event;
+	struct mlx5_sf_dev_table *table;
+	int sf_index;
+};
+
 static bool mlx5_sf_dev_supported(const struct mlx5_core_dev *dev)
 {
 	return MLX5_CAP_GEN(dev, sf) && mlx5_vhca_event_supported(dev);
@@ -165,7 +171,6 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
 		return 0;
 
 	sf_index = event->function_id - base_id;
-	mutex_lock(&table->table_lock);
 	sf_dev = xa_load(&table->devices, sf_index);
 	switch (event->new_vhca_state) {
 	case MLX5_VHCA_STATE_INVALID:
@@ -189,7 +194,6 @@ mlx5_sf_dev_state_change_handler(struct notifier_block *nb, unsigned long event_
 	default:
 		break;
 	}
-	mutex_unlock(&table->table_lock);
 	return 0;
 }
 
@@ -214,15 +218,44 @@ static int mlx5_sf_dev_vhca_arm_all(struct mlx5_sf_dev_table *table)
 	return 0;
 }
 
-static void mlx5_sf_dev_add_active_work(struct work_struct *work)
+static void mlx5_sf_dev_add_active_work(struct work_struct *_work)
 {
-	struct mlx5_sf_dev_table *table = container_of(work, struct mlx5_sf_dev_table, work);
+	struct mlx5_sf_dev_active_work_ctx *work_ctx;
+
+	work_ctx = container_of(_work, struct mlx5_sf_dev_active_work_ctx, work);
+	if (work_ctx->table->stop_active_wq)
+		goto out;
+	/* Don't probe device which is already probe */
+	if (!xa_load(&work_ctx->table->devices, work_ctx->sf_index))
+		mlx5_sf_dev_add(work_ctx->table->dev, work_ctx->sf_index,
+				work_ctx->event.function_id, work_ctx->event.sw_function_id);
+	/* There is a race where SF got inactive after the query
+	 * above. e.g.: the query returns that the state of the
+	 * SF is active, and after that the eswitch manager set it to
+	 * inactive.
+	 * This case cannot be managed in SW, since the probing of the
+	 * SF is on one system, and the inactivation is on a different
+	 * system.
+	 * If the inactive is done after the SF perform init_hca(),
+	 * the SF will fully probe and then removed. If it was
+	 * done before init_hca(), the SF probe will fail.
+	 */
+out:
+	kfree(work_ctx);
+}
+
+/* In case SFs are generated externally, probe active SFs */
+static void mlx5_sf_dev_queue_active_works(struct work_struct *_work)
+{
+	struct mlx5_sf_dev_table *table = container_of(_work, struct mlx5_sf_dev_table, work);
 	u32 out[MLX5_ST_SZ_DW(query_vhca_state_out)] = {};
+	struct mlx5_sf_dev_active_work_ctx *work_ctx;
 	struct mlx5_core_dev *dev = table->dev;
 	u16 max_functions;
 	u16 function_id;
 	u16 sw_func_id;
 	int err = 0;
+	int wq_idx;
 	u8 state;
 	int i;
 
@@ -242,27 +275,22 @@ static void mlx5_sf_dev_add_active_work(struct work_struct *work)
 			continue;
 
 		sw_func_id = MLX5_GET(query_vhca_state_out, out, vhca_state_context.sw_function_id);
-		mutex_lock(&table->table_lock);
-		/* Don't probe device which is already probe */
-		if (!xa_load(&table->devices, i))
-			mlx5_sf_dev_add(dev, i, function_id, sw_func_id);
-		/* There is a race where SF got inactive after the query
-		 * above. e.g.: the query returns that the state of the
-		 * SF is active, and after that the eswitch manager set it to
-		 * inactive.
-		 * This case cannot be managed in SW, since the probing of the
-		 * SF is on one system, and the inactivation is on a different
-		 * system.
-		 * If the inactive is done after the SF perform init_hca(),
-		 * the SF will fully probe and then removed. If it was
-		 * done before init_hca(), the SF probe will fail.
-		 */
-		mutex_unlock(&table->table_lock);
+		work_ctx = kzalloc(sizeof(*work_ctx), GFP_KERNEL);
+		if (!work_ctx)
+			return;
+
+		INIT_WORK(&work_ctx->work, &mlx5_sf_dev_add_active_work);
+		work_ctx->event.function_id = function_id;
+		work_ctx->event.sw_function_id = sw_func_id;
+		work_ctx->table = table;
+		work_ctx->sf_index = i;
+		wq_idx = work_ctx->event.function_id % MLX5_DEV_MAX_WQS;
+		mlx5_vhca_events_work_enqueue(dev, wq_idx, &work_ctx->work);
 	}
 }
 
 /* In case SFs are generated externally, probe active SFs */
-static int mlx5_sf_dev_queue_active_work(struct mlx5_sf_dev_table *table)
+static int mlx5_sf_dev_create_active_works(struct mlx5_sf_dev_table *table)
 {
 	if (MLX5_CAP_GEN(table->dev, eswitch_manager))
 		return 0; /* the table is local */
@@ -273,12 +301,12 @@ static int mlx5_sf_dev_queue_active_work(struct mlx5_sf_dev_table *table)
 	table->active_wq = create_singlethread_workqueue("mlx5_active_sf");
 	if (!table->active_wq)
 		return -ENOMEM;
-	INIT_WORK(&table->work, &mlx5_sf_dev_add_active_work);
+	INIT_WORK(&table->work, &mlx5_sf_dev_queue_active_works);
 	queue_work(table->active_wq, &table->work);
 	return 0;
 }
 
-static void mlx5_sf_dev_destroy_active_work(struct mlx5_sf_dev_table *table)
+static void mlx5_sf_dev_destroy_active_works(struct mlx5_sf_dev_table *table)
 {
 	if (table->active_wq) {
 		table->stop_active_wq = true;
@@ -305,14 +333,13 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 	table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
 	table->base_address = pci_resource_start(dev->pdev, 2);
 	xa_init(&table->devices);
-	mutex_init(&table->table_lock);
 	dev->priv.sf_dev_table = table;
 
 	err = mlx5_vhca_event_notifier_register(dev, &table->nb);
 	if (err)
 		goto vhca_err;
 
-	err = mlx5_sf_dev_queue_active_work(table);
+	err = mlx5_sf_dev_create_active_works(table);
 	if (err)
 		goto add_active_err;
 
@@ -322,9 +349,10 @@ void mlx5_sf_dev_table_create(struct mlx5_core_dev *dev)
 	return;
 
 arm_err:
-	mlx5_sf_dev_destroy_active_work(table);
+	mlx5_sf_dev_destroy_active_works(table);
 add_active_err:
 	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
+	mlx5_vhca_event_work_queues_flush(dev);
 vhca_err:
 	kfree(table);
 	dev->priv.sf_dev_table = NULL;
@@ -350,9 +378,9 @@ void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
 	if (!table)
 		return;
 
-	mlx5_sf_dev_destroy_active_work(table);
+	mlx5_sf_dev_destroy_active_works(table);
 	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
-	mutex_destroy(&table->table_lock);
+	mlx5_vhca_event_work_queues_flush(dev);
 
 	/* Now that event handler is not running, it is safe to destroy
 	 * the sf device without race.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
index c6fd729de8b2..cda01ba441ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
@@ -108,8 +108,7 @@ static void mlx5_vhca_state_work_handler(struct work_struct *_work)
 	kfree(work);
 }
 
-static void
-mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
+void mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
 {
 	queue_work(dev->priv.vhca_events->handler[idx].wq, work);
 }
@@ -191,6 +190,19 @@ int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 	return err;
 }
 
+void mlx5_vhca_event_work_queues_flush(struct mlx5_core_dev *dev)
+{
+	struct mlx5_vhca_events *vhca_events;
+	int i;
+
+	if (!mlx5_vhca_event_supported(dev))
+		return;
+
+	vhca_events = dev->priv.vhca_events;
+	for (i = 0; i < MLX5_DEV_MAX_WQS; i++)
+		flush_workqueue(vhca_events->handler[i].wq);
+}
+
 void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_vhca_events *vhca_events;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
index 013cdfe90616..1725ba64f8af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
@@ -28,6 +28,9 @@ int mlx5_modify_vhca_sw_id(struct mlx5_core_dev *dev, u16 function_id, u32 sw_fn
 int mlx5_vhca_event_arm(struct mlx5_core_dev *dev, u16 function_id);
 int mlx5_cmd_query_vhca_state(struct mlx5_core_dev *dev, u16 function_id,
 			      u32 *out, u32 outlen);
+void mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work);
+void mlx5_vhca_event_work_queues_flush(struct mlx5_core_dev *dev);
+
 #else
 
 static inline void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *set_hca_cap)
-- 
2.41.0


