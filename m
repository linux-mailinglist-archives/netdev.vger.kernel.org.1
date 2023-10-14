Return-Path: <netdev+bounces-41013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F457C959D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340061C20969
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AEC1CA8B;
	Sat, 14 Oct 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maJ0mqNC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6731C69E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF9C433C9;
	Sat, 14 Oct 2023 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303965;
	bh=x6SBR2geRNJwjmeMbjjNwOrmHioH94qfYR8VqCJQ610=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maJ0mqNCPBHR5enQcwNa09kSTb8UCQUgvsfDmaHRyrLjXxC1HQGLe93lZ2CCqp9KN
	 BGGDDYS9cGaICFdy9smV/R+2JRP31FpDX6gL03tvBPomFA946wPUndI2ujWbTrFcmH
	 aUZnxYN54yHOhwdETHwj9oXycaemjFRrCG7RIEfCRHLLbGXXPVANHhKDqSD6o0UIjC
	 0Dh//1hVd+L6YU1R77P3c+fSJJWi+WtdaBGr4DZsVZpbRCXH33VB6u5L8MwSf4k0It
	 tOQf02M0wkDqoDiVlhZY3lc+1CXLeUBxXXOdTyCu4+xzjhIIIY+c6x8jeXk4g5RnpR
	 DJwZRHKQ7GrSw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Wei Zhang <weizhang@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 01/15] net/mlx5: Parallelize vhca event handling
Date: Sat, 14 Oct 2023 10:18:54 -0700
Message-ID: <20231014171908.290428-2-saeed@kernel.org>
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

At present, mlx5 driver have a general purpose
event handler which not only handles vhca event
but also many other events. This incurs a huge
bottleneck because the event handler is
implemented by single threaded workqueue and all
events are forced to be handled in serial manner
even though application tries to create multiple
SFs simultaneously.

Introduce a dedicated vhca event handler which
manages SFs parallel creation.

Signed-off-by: Wei Zhang <weizhang@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/events.c  |  5 --
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  3 +-
 .../mellanox/mlx5/core/sf/vhca_event.c        | 57 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 3ec892d51f57..d91ea53eb394 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -441,8 +441,3 @@ int mlx5_blocking_notifier_call_chain(struct mlx5_core_dev *dev, unsigned int ev
 
 	return blocking_notifier_call_chain(&events->sw_nh, event, data);
 }
-
-void mlx5_events_work_enqueue(struct mlx5_core_dev *dev, struct work_struct *work)
-{
-	queue_work(dev->priv.events->wq, work);
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 19ffd1816474..d348a7f9511f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -159,6 +159,8 @@ enum mlx5_semaphore_space_address {
 
 #define MLX5_DEFAULT_PROF       2
 #define MLX5_SF_PROF		3
+#define MLX5_NUM_FW_CMD_THREADS 8
+#define MLX5_DEV_MAX_WQS	MLX5_NUM_FW_CMD_THREADS
 
 static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
 				      size_t item_size, size_t num_items,
@@ -347,7 +349,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
 	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
 
-void mlx5_events_work_enqueue(struct mlx5_core_dev *dev, struct work_struct *work);
 static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
index d908fba968f0..c6fd729de8b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
@@ -21,6 +21,15 @@ struct mlx5_vhca_event_work {
 	struct mlx5_vhca_state_event event;
 };
 
+struct mlx5_vhca_event_handler {
+	struct workqueue_struct *wq;
+};
+
+struct mlx5_vhca_events {
+	struct mlx5_core_dev *dev;
+	struct mlx5_vhca_event_handler handler[MLX5_DEV_MAX_WQS];
+};
+
 int mlx5_cmd_query_vhca_state(struct mlx5_core_dev *dev, u16 function_id, u32 *out, u32 outlen)
 {
 	u32 in[MLX5_ST_SZ_DW(query_vhca_state_in)] = {};
@@ -99,6 +108,12 @@ static void mlx5_vhca_state_work_handler(struct work_struct *_work)
 	kfree(work);
 }
 
+static void
+mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
+{
+	queue_work(dev->priv.vhca_events->handler[idx].wq, work);
+}
+
 static int
 mlx5_vhca_state_change_notifier(struct notifier_block *nb, unsigned long type, void *data)
 {
@@ -106,6 +121,7 @@ mlx5_vhca_state_change_notifier(struct notifier_block *nb, unsigned long type, v
 				mlx5_nb_cof(nb, struct mlx5_vhca_state_notifier, nb);
 	struct mlx5_vhca_event_work *work;
 	struct mlx5_eqe *eqe = data;
+	int wq_idx;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work)
@@ -113,7 +129,8 @@ mlx5_vhca_state_change_notifier(struct notifier_block *nb, unsigned long type, v
 	INIT_WORK(&work->work, &mlx5_vhca_state_work_handler);
 	work->notifier = notifier;
 	work->event.function_id = be16_to_cpu(eqe->data.vhca_state.function_id);
-	mlx5_events_work_enqueue(notifier->dev, &work->work);
+	wq_idx = work->event.function_id % MLX5_DEV_MAX_WQS;
+	mlx5_vhca_events_work_enqueue(notifier->dev, wq_idx, &work->work);
 	return NOTIFY_OK;
 }
 
@@ -132,28 +149,62 @@ void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *set_hca_cap)
 int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_vhca_state_notifier *notifier;
+	char wq_name[MLX5_CMD_WQ_MAX_NAME];
+	struct mlx5_vhca_events *events;
+	int err, i;
 
 	if (!mlx5_vhca_event_supported(dev))
 		return 0;
 
-	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
-	if (!notifier)
+	events = kzalloc(sizeof(*events), GFP_KERNEL);
+	if (!events)
 		return -ENOMEM;
 
+	events->dev = dev;
+	dev->priv.vhca_events = events;
+	for (i = 0; i < MLX5_DEV_MAX_WQS; i++) {
+		snprintf(wq_name, MLX5_CMD_WQ_MAX_NAME, "mlx5_vhca_event%d", i);
+		events->handler[i].wq = create_singlethread_workqueue(wq_name);
+		if (!events->handler[i].wq) {
+			err = -ENOMEM;
+			goto err_create_wq;
+		}
+	}
+
+	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
+	if (!notifier) {
+		err = -ENOMEM;
+		goto err_notifier;
+	}
+
 	dev->priv.vhca_state_notifier = notifier;
 	notifier->dev = dev;
 	BLOCKING_INIT_NOTIFIER_HEAD(&notifier->n_head);
 	MLX5_NB_INIT(&notifier->nb, mlx5_vhca_state_change_notifier, VHCA_STATE_CHANGE);
 	return 0;
+
+err_notifier:
+err_create_wq:
+	for (--i; i >= 0; i--)
+		destroy_workqueue(events->handler[i].wq);
+	kfree(events);
+	return err;
 }
 
 void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev)
 {
+	struct mlx5_vhca_events *vhca_events;
+	int i;
+
 	if (!mlx5_vhca_event_supported(dev))
 		return;
 
 	kfree(dev->priv.vhca_state_notifier);
 	dev->priv.vhca_state_notifier = NULL;
+	vhca_events = dev->priv.vhca_events;
+	for (i = 0; i < MLX5_DEV_MAX_WQS; i++)
+		destroy_workqueue(vhca_events->handler[i].wq);
+	kvfree(vhca_events);
 }
 
 void mlx5_vhca_event_start(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 52e982bc0f50..7968c5ee85c4 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -615,6 +615,7 @@ struct mlx5_priv {
 	int			adev_idx;
 	int			sw_vhca_id;
 	struct mlx5_events      *events;
+	struct mlx5_vhca_events *vhca_events;
 
 	struct mlx5_flow_steering *steering;
 	struct mlx5_mpfs        *mpfs;
-- 
2.41.0


