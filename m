Return-Path: <netdev+bounces-39834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8917C49B5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D694282397
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88C14F97;
	Wed, 11 Oct 2023 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxMadYaz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33314F94
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B574C433CA;
	Wed, 11 Oct 2023 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004757;
	bh=+BktYwl1eAkZbVc2gregVGT9dMMDtwTLlaoQxdkxsMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxMadYazTziTS61ElRBLpCGM0laIDb671JkW02gNYBWrv3YUW0raZPCwteI20BxwF
	 NzZBGo8AS8Pw9tmL34OvuLI6Z4CQySJj5HVhJc7F+zCta1tEY6XaL5hlqaO2xthPpI
	 sUxNI1lH2hv3JC+XpkGpr01xLWZsZnenqerlqiWIUEZJJiSDedZLLuiOgCz9WEqzRt
	 RsYsQs02myWxsVzUr8BjdI6KUNXMMkgjIniiHyQUAIKgFX2gz2FPIg3URjRGhqV4n8
	 0Q2TdNQoAV3I6uTDIbFb/r7WhujRRC+0wn3CFJ4UtDP0/+E2FHoEerAAujqsyPmnAs
	 LNFljjOrC9tDw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 05/15] net/mlx5: Replace global mlx5_intf_lock with HCA devcom component lock
Date: Tue, 10 Oct 2023 23:12:20 -0700
Message-ID: <20231011061230.11530-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061230.11530-1-saeed@kernel.org>
References: <20231011061230.11530-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

mlx5_intf_lock is used to sync between LAG changes and its slaves
mlx5 core dev aux devices changes, which means every time mlx5 core
dev add/remove aux devices, mlx5 is taking this global lock, even if
LAG functionality isn't supported over the core dev.
This cause a bottleneck when probing VFs/SFs in parallel.

Hence, replace mlx5_intf_lock with HCA devcom component lock, or no
lock if LAG functionality isn't supported.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 37 +++++--------------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 35 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  9 ++++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |  7 ++++
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  1 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  8 ++--
 7 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 6e3a8c22881f..cf0477f53dc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -38,8 +38,6 @@
 #include "devlink.h"
 #include "lag/lag.h"
 
-/* intf dev list mutex */
-static DEFINE_MUTEX(mlx5_intf_mutex);
 static DEFINE_IDA(mlx5_adev_ida);
 
 static bool is_eth_rep_supported(struct mlx5_core_dev *dev)
@@ -337,9 +335,9 @@ static void del_adev(struct auxiliary_device *adev)
 
 void mlx5_dev_set_lightweight(struct mlx5_core_dev *dev)
 {
-	mutex_lock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV;
-	mutex_unlock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 }
 
 bool mlx5_dev_is_lightweight(struct mlx5_core_dev *dev)
@@ -355,7 +353,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
 	int ret = 0, i;
 
 	devl_assert_locked(priv_to_devlink(dev));
-	mutex_lock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	priv->flags &= ~MLX5_PRIV_FLAGS_DETACH;
 	for (i = 0; i < ARRAY_SIZE(mlx5_adev_devices); i++) {
 		if (!priv->adev[i]) {
@@ -400,7 +398,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
 			break;
 		}
 	}
-	mutex_unlock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 	return ret;
 }
 
@@ -413,7 +411,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
 	int i;
 
 	devl_assert_locked(priv_to_devlink(dev));
-	mutex_lock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	for (i = ARRAY_SIZE(mlx5_adev_devices) - 1; i >= 0; i--) {
 		if (!priv->adev[i])
 			continue;
@@ -443,7 +441,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
 		priv->adev[i] = NULL;
 	}
 	priv->flags |= MLX5_PRIV_FLAGS_DETACH;
-	mutex_unlock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 }
 
 int mlx5_register_device(struct mlx5_core_dev *dev)
@@ -451,10 +449,10 @@ int mlx5_register_device(struct mlx5_core_dev *dev)
 	int ret;
 
 	devl_assert_locked(priv_to_devlink(dev));
-	mutex_lock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV;
 	ret = mlx5_rescan_drivers_locked(dev);
-	mutex_unlock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 	if (ret)
 		mlx5_unregister_device(dev);
 
@@ -464,10 +462,10 @@ int mlx5_register_device(struct mlx5_core_dev *dev)
 void mlx5_unregister_device(struct mlx5_core_dev *dev)
 {
 	devl_assert_locked(priv_to_devlink(dev));
-	mutex_lock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	dev->priv.flags = MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV;
 	mlx5_rescan_drivers_locked(dev);
-	mutex_unlock(&mlx5_intf_mutex);
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 }
 
 static int add_drivers(struct mlx5_core_dev *dev)
@@ -545,7 +543,6 @@ int mlx5_rescan_drivers_locked(struct mlx5_core_dev *dev)
 {
 	struct mlx5_priv *priv = &dev->priv;
 
-	lockdep_assert_held(&mlx5_intf_mutex);
 	if (priv->flags & MLX5_PRIV_FLAGS_DETACH)
 		return 0;
 
@@ -565,17 +562,3 @@ bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev
 
 	return (fsystem_guid && psystem_guid && fsystem_guid == psystem_guid);
 }
-
-void mlx5_dev_list_lock(void)
-{
-	mutex_lock(&mlx5_intf_mutex);
-}
-void mlx5_dev_list_unlock(void)
-{
-	mutex_unlock(&mlx5_intf_mutex);
-}
-
-int mlx5_dev_list_trylock(void)
-{
-	return mutex_trylock(&mlx5_intf_mutex);
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f0b57f97739f..d14459e5c04f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -943,6 +943,26 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 	}
 }
 
+/* The last mdev to unregister will destroy the workqueue before removing the
+ * devcom component, and as all the mdevs use the same devcom component we are
+ * guaranteed that the devcom is valid while the calling work is running.
+ */
+struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
+{
+	struct mlx5_devcom_comp_dev *devcom = NULL;
+	int i;
+
+	mutex_lock(&ldev->lock);
+	for (i = 0; i < ldev->ports; i++) {
+		if (ldev->pf[i].dev) {
+			devcom = ldev->pf[i].dev->priv.hca_devcom_comp;
+			break;
+		}
+	}
+	mutex_unlock(&ldev->lock);
+	return devcom;
+}
+
 static void mlx5_queue_bond_work(struct mlx5_lag *ldev, unsigned long delay)
 {
 	queue_delayed_work(ldev->wq, &ldev->bond_work, delay);
@@ -953,9 +973,14 @@ static void mlx5_do_bond_work(struct work_struct *work)
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct mlx5_lag *ldev = container_of(delayed_work, struct mlx5_lag,
 					     bond_work);
+	struct mlx5_devcom_comp_dev *devcom;
 	int status;
 
-	status = mlx5_dev_list_trylock();
+	devcom = mlx5_lag_get_devcom_comp(ldev);
+	if (!devcom)
+		return;
+
+	status = mlx5_devcom_comp_trylock(devcom);
 	if (!status) {
 		mlx5_queue_bond_work(ldev, HZ);
 		return;
@@ -964,14 +989,14 @@ static void mlx5_do_bond_work(struct work_struct *work)
 	mutex_lock(&ldev->lock);
 	if (ldev->mode_changes_in_progress) {
 		mutex_unlock(&ldev->lock);
-		mlx5_dev_list_unlock();
+		mlx5_devcom_comp_unlock(devcom);
 		mlx5_queue_bond_work(ldev, HZ);
 		return;
 	}
 
 	mlx5_do_bond(ldev);
 	mutex_unlock(&ldev->lock);
-	mlx5_dev_list_unlock();
+	mlx5_devcom_comp_unlock(devcom);
 }
 
 static int mlx5_handle_changeupper_event(struct mlx5_lag *ldev,
@@ -1435,7 +1460,7 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	if (!ldev)
 		return;
 
-	mlx5_dev_list_lock();
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
@@ -1443,7 +1468,7 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 		mlx5_disable_lag(ldev);
 
 	mutex_unlock(&ldev->lock);
-	mlx5_dev_list_unlock();
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 }
 
 void mlx5_lag_enable_change(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 481e92f39fe6..50fcb1eee574 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -112,6 +112,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev);
 void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
 int mlx5_deactivate_lag(struct mlx5_lag *ldev);
 void mlx5_lag_add_devices(struct mlx5_lag *ldev);
+struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev);
 
 static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 0857eebf4f07..82889f30506e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -129,9 +129,14 @@ static void disable_mpesw(struct mlx5_lag *ldev)
 static void mlx5_mpesw_work(struct work_struct *work)
 {
 	struct mlx5_mpesw_work_st *mpesww = container_of(work, struct mlx5_mpesw_work_st, work);
+	struct mlx5_devcom_comp_dev *devcom;
 	struct mlx5_lag *ldev = mpesww->lag;
 
-	mlx5_dev_list_lock();
+	devcom = mlx5_lag_get_devcom_comp(ldev);
+	if (!devcom)
+		return;
+
+	mlx5_devcom_comp_lock(devcom);
 	mutex_lock(&ldev->lock);
 	if (ldev->mode_changes_in_progress) {
 		mpesww->result = -EAGAIN;
@@ -144,7 +149,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 		disable_mpesw(ldev);
 unlock:
 	mutex_unlock(&ldev->lock);
-	mlx5_dev_list_unlock();
+	mlx5_devcom_comp_unlock(devcom);
 	complete(&mpesww->comp);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index f4d5c300ddd6..e8e50563e956 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -401,3 +401,10 @@ void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom)
 		return;
 	up_write(&devcom->comp->sem);
 }
+
+int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom)
+{
+	if (IS_ERR_OR_NULL(devcom))
+		return 0;
+	return down_write_trylock(&devcom->comp->sem);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index ed249bafd07c..1549edd19aa8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -54,5 +54,6 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
 
 void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom);
 void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom);
+int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom);
 
 #endif /* __LIB_MLX5_DEVCOM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index bbc96aa6cbcc..0b60b02518c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -41,6 +41,7 @@
 #include <linux/mlx5/cq.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/driver.h>
+#include "lib/devcom.h"
 
 extern uint mlx5_core_debug_mask;
 
@@ -250,9 +251,6 @@ int mlx5_register_device(struct mlx5_core_dev *dev);
 void mlx5_unregister_device(struct mlx5_core_dev *dev);
 void mlx5_dev_set_lightweight(struct mlx5_core_dev *dev);
 bool mlx5_dev_is_lightweight(struct mlx5_core_dev *dev);
-void mlx5_dev_list_lock(void);
-void mlx5_dev_list_unlock(void);
-int mlx5_dev_list_trylock(void);
 
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev);
 int mlx5_query_mtpps(struct mlx5_core_dev *dev, u32 *mtpps, u32 mtpps_size);
@@ -291,9 +289,9 @@ static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 {
 	int ret;
 
-	mlx5_dev_list_lock();
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	ret = mlx5_rescan_drivers_locked(dev);
-	mlx5_dev_list_unlock();
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 	return ret;
 }
 
-- 
2.41.0


