Return-Path: <netdev+bounces-27493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F377C28B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8961C28120C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3D100D7;
	Mon, 14 Aug 2023 21:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3933100AD
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CF1C43395;
	Mon, 14 Aug 2023 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049312;
	bh=a4oiqe5VfuAXHiPcnBxIHzPx+/0ybpqQH5lsc2XnOtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhE3q47n0pfIFK2+P7ufGQVfZS/Sto79ulYP3A3zf5exIK+d8s443T1pgXVoTp91n
	 EbkOdiI9qCLLZ7K4nwoK8MjMAkeQzKxRcGuBKaK9a09RUH6pczZnh+zKWNXK5cea7I
	 D0NA7F6Oy6p/NdtL44BpN4Gx9IoveovFEhv7Dkr65ifGu2ZLFLB+Encc/JrzzUBHb9
	 ze48+ZD/5ctv+cbsz0y5jesM7ChA35KzS+jmp3fLMqzoAoRPZnBbASGQXHEqr/gMS+
	 mEkUukdVwC3btwj4CGrRu7zBLCY3SWsu0mM71iXcVJ7Yjt+xVnDas6L6NxU/xkFx4w
	 Nb1+GUR3O77wg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 04/14] net/mlx5: Expose max possible SFs via devlink resource
Date: Mon, 14 Aug 2023 14:41:34 -0700
Message-ID: <20230814214144.159464-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Introduce devlink resource for exposing max possible SFs on mlx5
devices.

For example:
$ devlink resource show pci/0000:00:0b.0
pci/0000:00:0b.0:
  name max_local_SFs size 5 unit entry dpipe_tables none
  name max_external_SFs size 0 unit entry dpipe_tables none

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.h |  8 ++++
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c | 44 +++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index defba5bd91d9..961f75da6227 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -6,6 +6,14 @@
 
 #include <net/devlink.h>
 
+enum mlx5_devlink_resource_id {
+	MLX5_DL_RES_MAX_LOCAL_SFS = 1,
+	MLX5_DL_RES_MAX_EXTERNAL_SFS,
+
+	__MLX5_ID_RES_MAX,
+	MLX5_ID_RES_MAX = __MLX5_ID_RES_MAX - 1,
+};
+
 enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	MLX5_DEVLINK_PARAM_ID_FLOW_STEERING_MODE,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
index 17aa348989cb..c4daeaaafead 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
@@ -9,6 +9,7 @@
 #include "mlx5_core.h"
 #include "eswitch.h"
 #include "diag/sf_tracepoint.h"
+#include "devlink.h"
 
 struct mlx5_sf_hw {
 	u32 usr_sfnum;
@@ -243,6 +244,32 @@ static void mlx5_sf_hw_table_hwc_cleanup(struct mlx5_sf_hwc_table *hwc)
 	kfree(hwc->sfs);
 }
 
+static void mlx5_sf_hw_table_res_unregister(struct mlx5_core_dev *dev)
+{
+	devl_resources_unregister(priv_to_devlink(dev));
+}
+
+static int mlx5_sf_hw_table_res_register(struct mlx5_core_dev *dev, u16 max_fn,
+					 u16 max_ext_fn)
+{
+	struct devlink_resource_size_params size_params;
+	struct devlink *devlink = priv_to_devlink(dev);
+	int err;
+
+	devlink_resource_size_params_init(&size_params, max_fn, max_fn, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+	err = devl_resource_register(devlink, "max_local_SFs", max_fn, MLX5_DL_RES_MAX_LOCAL_SFS,
+				     DEVLINK_RESOURCE_ID_PARENT_TOP, &size_params);
+	if (err)
+		return err;
+
+	devlink_resource_size_params_init(&size_params, max_ext_fn, max_ext_fn, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+	return devl_resource_register(devlink, "max_external_SFs", max_ext_fn,
+				      MLX5_DL_RES_MAX_EXTERNAL_SFS, DEVLINK_RESOURCE_ID_PARENT_TOP,
+				      &size_params);
+}
+
 int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_hw_table *table;
@@ -262,12 +289,17 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 	if (err)
 		return err;
 
+	if (mlx5_sf_hw_table_res_register(dev, max_fn, max_ext_fn))
+		mlx5_core_dbg(dev, "failed to register max SFs resources");
+
 	if (!max_fn && !max_ext_fn)
 		return 0;
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
+	if (!table) {
+		err = -ENOMEM;
+		goto alloc_err;
+	}
 
 	mutex_init(&table->table_lock);
 	table->dev = dev;
@@ -291,6 +323,8 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 table_err:
 	mutex_destroy(&table->table_lock);
 	kfree(table);
+alloc_err:
+	mlx5_sf_hw_table_res_unregister(dev);
 	return err;
 }
 
@@ -299,12 +333,14 @@ void mlx5_sf_hw_table_cleanup(struct mlx5_core_dev *dev)
 	struct mlx5_sf_hw_table *table = dev->priv.sf_hw_table;
 
 	if (!table)
-		return;
+		goto res_unregister;
 
-	mutex_destroy(&table->table_lock);
 	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_EXTERNAL]);
 	mlx5_sf_hw_table_hwc_cleanup(&table->hwc[MLX5_SF_HWC_LOCAL]);
+	mutex_destroy(&table->table_lock);
 	kfree(table);
+res_unregister:
+	mlx5_sf_hw_table_res_unregister(dev);
 }
 
 static int mlx5_sf_hw_vhca_event(struct notifier_block *nb, unsigned long opcode, void *data)
-- 
2.41.0


