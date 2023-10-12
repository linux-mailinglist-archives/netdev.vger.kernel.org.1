Return-Path: <netdev+bounces-40441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689C7C76B6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BCE1C210F9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174193B2BC;
	Thu, 12 Oct 2023 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2tzY6QQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B33B2B6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1932C433C8;
	Thu, 12 Oct 2023 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138877;
	bh=yVkb8PR/hYZLmBK60UdRcK3jWqwVnSY2b6fS3mGpqAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2tzY6QQjsoBGOSbc6dNA4TLZsbs8t03RuGZHt5BVG/Pn8kDuiU41/NhKCjDLT4It
	 hFS34ijU0eurozzstN0ZvmcSiuNnxU/K5H5rqocIEWsosx5vQoqeBFSc2wpN6jHJ0K
	 Q35dd0Lmh1CQzK1SPo7/7kFbtbJqfReJIRCOS68Ep7uHt+e1i4SE5vAg0a0FkCYnUk
	 oDlLF6d9Gb891jOehGl7wHxbG+nSwRcJTMaQke6WAt9CCL6DPP/Rr+oO+08Mly6TLe
	 BufI3nBWVHW+k+wehv9C7Hw/zWHxtWdtemPpc8dFuXEnKicjDsV0g/kHIJ2ZVVfViW
	 oeojx5d/6QP4w==
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
Subject: [net-next V2 04/15] net/mlx5: Refactor LAG peer device lookout bus logic to mlx5 devcom
Date: Thu, 12 Oct 2023 12:27:39 -0700
Message-ID: <20231012192750.124945-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

LAG peer device lookout bus logic required the usage of global lock,
mlx5_intf_mutex.
As part of the effort to remove this global lock, refactor LAG peer
device lookout to use mlx5 devcom layer.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 68 -------------------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++--
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 14 ++++
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    | 25 +++++++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 -
 include/linux/mlx5/driver.h                   |  1 +
 7 files changed, 52 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 1fc03480c2ff..6e3a8c22881f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -566,74 +566,6 @@ bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev
 	return (fsystem_guid && psystem_guid && fsystem_guid == psystem_guid);
 }
 
-static u32 mlx5_gen_pci_id(const struct mlx5_core_dev *dev)
-{
-	return (u32)((pci_domain_nr(dev->pdev->bus) << 16) |
-		     (dev->pdev->bus->number << 8) |
-		     PCI_SLOT(dev->pdev->devfn));
-}
-
-static int _next_phys_dev(struct mlx5_core_dev *mdev,
-			  const struct mlx5_core_dev *curr)
-{
-	if (!mlx5_core_is_pf(mdev))
-		return 0;
-
-	if (mdev == curr)
-		return 0;
-
-	if (!mlx5_same_hw_devs(mdev, (struct mlx5_core_dev *)curr) &&
-	    mlx5_gen_pci_id(mdev) != mlx5_gen_pci_id(curr))
-		return 0;
-
-	return 1;
-}
-
-static void *pci_get_other_drvdata(struct device *this, struct device *other)
-{
-	if (this->driver != other->driver)
-		return NULL;
-
-	return pci_get_drvdata(to_pci_dev(other));
-}
-
-static int next_phys_dev_lag(struct device *dev, const void *data)
-{
-	struct mlx5_core_dev *mdev, *this = (struct mlx5_core_dev *)data;
-
-	mdev = pci_get_other_drvdata(this->device, dev);
-	if (!mdev)
-		return 0;
-
-	if (!mlx5_lag_is_supported(mdev))
-		return 0;
-
-	return _next_phys_dev(mdev, data);
-}
-
-static struct mlx5_core_dev *mlx5_get_next_dev(struct mlx5_core_dev *dev,
-					       int (*match)(struct device *dev, const void *data))
-{
-	struct device *next;
-
-	if (!mlx5_core_is_pf(dev))
-		return NULL;
-
-	next = bus_find_device(&pci_bus_type, NULL, dev, match);
-	if (!next)
-		return NULL;
-
-	put_device(next);
-	return pci_get_drvdata(to_pci_dev(next));
-}
-
-/* Must be called with intf_mutex held */
-struct mlx5_core_dev *mlx5_get_next_phys_dev_lag(struct mlx5_core_dev *dev)
-{
-	lockdep_assert_held(&mlx5_intf_mutex);
-	return mlx5_get_next_dev(dev, &next_phys_dev_lag);
-}
-
 void mlx5_dev_list_lock(void)
 {
 	mutex_lock(&mlx5_intf_mutex);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index af3fac090b82..f0b57f97739f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1212,13 +1212,14 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
 	dev->priv.lag = NULL;
 }
 
-/* Must be called with intf_mutex held */
+/* Must be called with HCA devcom component lock held */
 static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 {
+	struct mlx5_devcom_comp_dev *pos = NULL;
 	struct mlx5_lag *ldev = NULL;
 	struct mlx5_core_dev *tmp_dev;
 
-	tmp_dev = mlx5_get_next_phys_dev_lag(dev);
+	tmp_dev = mlx5_devcom_get_next_peer_data(dev->priv.hca_devcom_comp, &pos);
 	if (tmp_dev)
 		ldev = mlx5_lag_dev(tmp_dev);
 
@@ -1275,10 +1276,13 @@ void mlx5_lag_add_mdev(struct mlx5_core_dev *dev)
 	if (!mlx5_lag_is_supported(dev))
 		return;
 
+	if (IS_ERR_OR_NULL(dev->priv.hca_devcom_comp))
+		return;
+
 recheck:
-	mlx5_dev_list_lock();
+	mlx5_devcom_comp_lock(dev->priv.hca_devcom_comp);
 	err = __mlx5_lag_dev_add_mdev(dev);
-	mlx5_dev_list_unlock();
+	mlx5_devcom_comp_unlock(dev->priv.hca_devcom_comp);
 
 	if (err) {
 		msleep(100);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 89ac3209277e..f4d5c300ddd6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -387,3 +387,17 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
 	*pos = tmp;
 	return data;
 }
+
+void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom)
+{
+	if (IS_ERR_OR_NULL(devcom))
+		return;
+	down_write(&devcom->comp->sem);
+}
+
+void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom)
+{
+	if (IS_ERR_OR_NULL(devcom))
+		return;
+	up_write(&devcom->comp->sem);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 8389ac0af708..ed249bafd07c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -8,6 +8,7 @@
 
 enum mlx5_devcom_component {
 	MLX5_DEVCOM_ESW_OFFLOADS,
+	MLX5_DEVCOM_HCA_PORTS,
 	MLX5_DEVCOM_NUM_COMPONENTS,
 };
 
@@ -51,4 +52,7 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
 	     data;								  \
 	     data = mlx5_devcom_get_next_peer_data_rcu(devcom, &pos))
 
+void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom);
+void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom);
+
 #endif /* __LIB_MLX5_DEVCOM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index d17c9c31b165..6bb3c4f45292 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -73,6 +73,7 @@
 #include "sf/sf.h"
 #include "mlx5_irq.h"
 #include "hwmon.h"
+#include "lag/lag.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -946,6 +947,27 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 	mlx5_pci_disable_device(dev);
 }
 
+static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
+{
+	/* This component is use to sync adding core_dev to lag_dev and to sync
+	 * changes of mlx5_adev_devices between LAG layer and other layers.
+	 */
+	if (!mlx5_lag_is_supported(dev))
+		return;
+
+	dev->priv.hca_devcom_comp =
+		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
+					       mlx5_query_nic_system_image_guid(dev),
+					       NULL, dev);
+	if (IS_ERR_OR_NULL(dev->priv.hca_devcom_comp))
+		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
+}
+
+static void mlx5_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
+{
+	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
+}
+
 static int mlx5_init_once(struct mlx5_core_dev *dev)
 {
 	int err;
@@ -954,6 +976,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	if (IS_ERR(dev->priv.devc))
 		mlx5_core_warn(dev, "failed to register devcom device %ld\n",
 			       PTR_ERR(dev->priv.devc));
+	mlx5_register_hca_devcom_comp(dev);
 
 	err = mlx5_query_board_id(dev);
 	if (err) {
@@ -1088,6 +1111,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 err_irq_cleanup:
 	mlx5_irq_table_cleanup(dev);
 err_devcom:
+	mlx5_unregister_hca_devcom_comp(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
 
 	return err;
@@ -1117,6 +1141,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_events_cleanup(dev);
 	mlx5_eq_table_cleanup(dev);
 	mlx5_irq_table_cleanup(dev);
+	mlx5_unregister_hca_devcom_comp(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 94f809f52f27..bbc96aa6cbcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -250,7 +250,6 @@ int mlx5_register_device(struct mlx5_core_dev *dev);
 void mlx5_unregister_device(struct mlx5_core_dev *dev);
 void mlx5_dev_set_lightweight(struct mlx5_core_dev *dev);
 bool mlx5_dev_is_lightweight(struct mlx5_core_dev *dev);
-struct mlx5_core_dev *mlx5_get_next_phys_dev_lag(struct mlx5_core_dev *dev);
 void mlx5_dev_list_lock(void);
 void mlx5_dev_list_unlock(void);
 int mlx5_dev_list_trylock(void);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 50025fe90026..37c2101e4f63 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -624,6 +624,7 @@ struct mlx5_priv {
 	struct mlx5_lag		*lag;
 	u32			flags;
 	struct mlx5_devcom_dev	*devc;
+	struct mlx5_devcom_comp_dev *hca_devcom_comp;
 	struct mlx5_fw_reset	*fw_reset;
 	struct mlx5_core_roce	roce;
 	struct mlx5_fc_stats		fc_stats;
-- 
2.41.0


