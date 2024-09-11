Return-Path: <netdev+bounces-127555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE037975B94
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E84B21168
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265C1BC9E8;
	Wed, 11 Sep 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys8DxNlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0B1BC9E2
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085891; cv=none; b=h0whJ9ZAIywF3yaWjjmX0zC2g6i07dwGOXIgKIs03+X7BzsVAUASeSOCqCjnGwGRd6WfjI31jhrs67SV+jS/IxdM8ENrsRACA1p/lGvQdRaHjSy0xKX5swzCTg86Rm2I3tXKl6dj5x57jW0VhrrqXK+OURk/K/7fNoog/QKU4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085891; c=relaxed/simple;
	bh=hB/yJerxAEPQD7Xj8UrrO6U4K27YYUUA2WfKYe9wjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQJyQg6ZxBr4MZyTJB6quoFkcFUvvMg+v/75F6Lim+QlgpWR8JNjHhnN1kVlXZb79nORIIveCFyWSh/vvxT0G6UY1oLdiMs6oZrrbUeelCIKSv+nBed/d/Ye/evLs9o7B1khJFM5AU7i6HYLJf8RuH3YUahEnA9IcvbzTsOhER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys8DxNlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AEAC4CEC0;
	Wed, 11 Sep 2024 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085889;
	bh=hB/yJerxAEPQD7Xj8UrrO6U4K27YYUUA2WfKYe9wjX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ys8DxNlXtb0wSnaUnzTzYsJVuXcif60O2igMOzRhoEVOi+7Fxlur14xHsojntVlVg
	 2jQkEKcBpiqYCSLqyyPH+ISn5159jz3NTxBExGBm3RqkObTWw7S/TpTWZDm3JJHxWG
	 K4qzpx2MHoDGZ02Zi05rqiiJiikGMVSwM4Q09q2GKjgvRG+bKMzH/+rN8R3kdXCUFQ
	 IdJLxUlTmgZPcfh16mcbCLGzAbpSZ3AXu3avn7WaPY63aviAY0iPirfmLK2hzsne0r
	 39JGKoc5Metx0KqBHTbSj6nhcC93rEEwUMzN+5uev7nMnft4pdm7+rkpYE8Vd3cBfS
	 XPLrORorAigRA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 10/15] net/mlx5: Add support for sync reset using hot reset
Date: Wed, 11 Sep 2024 13:17:52 -0700
Message-ID: <20240911201757.1505453-11-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

On device that supports sync reset for firmware activate using hot
reset, the driver queries the required reset method while handling the
sync reset request. If the required reset method is hot reset, the
driver will use pci_reset_bus() to reset the PCI link instead of the
link toggle.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 82 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/main.c    |  3 +
 2 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index b43ca0b762c3..bda74cb9c975 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -26,6 +26,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_now_work;
 	struct work_struct reset_abort_work;
 	unsigned long reset_flags;
+	u8 reset_method;
 	struct timer_list timer;
 	struct completion done;
 	int ret;
@@ -95,7 +96,7 @@ static int mlx5_reg_mfrl_set(struct mlx5_core_dev *dev, u8 reset_level,
 }
 
 static int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level,
-			       u8 *reset_type, u8 *reset_state)
+			       u8 *reset_type, u8 *reset_state, u8 *reset_method)
 {
 	u32 out[MLX5_ST_SZ_DW(mfrl_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(mfrl_reg)] = {};
@@ -111,13 +112,26 @@ static int mlx5_reg_mfrl_query(struct mlx5_core_dev *dev, u8 *reset_level,
 		*reset_type = MLX5_GET(mfrl_reg, out, reset_type);
 	if (reset_state)
 		*reset_state = MLX5_GET(mfrl_reg, out, reset_state);
+	if (reset_method)
+		*reset_method = MLX5_GET(mfrl_reg, out, pci_reset_req_method);
 
 	return 0;
 }
 
 int mlx5_fw_reset_query(struct mlx5_core_dev *dev, u8 *reset_level, u8 *reset_type)
 {
-	return mlx5_reg_mfrl_query(dev, reset_level, reset_type, NULL);
+	return mlx5_reg_mfrl_query(dev, reset_level, reset_type, NULL, NULL);
+}
+
+static int mlx5_fw_reset_get_reset_method(struct mlx5_core_dev *dev,
+					  u8 *reset_method)
+{
+	if (!MLX5_CAP_GEN(dev, pcie_reset_using_hotreset_method)) {
+		*reset_method = MLX5_MFRL_REG_PCI_RESET_METHOD_LINK_TOGGLE;
+		return 0;
+	}
+
+	return mlx5_reg_mfrl_query(dev, NULL, NULL, NULL, reset_method);
 }
 
 static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
@@ -125,7 +139,7 @@ static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
 {
 	u8 reset_state;
 
-	if (mlx5_reg_mfrl_query(dev, NULL, NULL, &reset_state))
+	if (mlx5_reg_mfrl_query(dev, NULL, NULL, &reset_state, NULL))
 		goto out;
 
 	if (!reset_state)
@@ -427,7 +441,11 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 	struct mlx5_core_dev *dev = fw_reset->dev;
 	int err;
 
-	if (test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
+	err = mlx5_fw_reset_get_reset_method(dev, &fw_reset->reset_method);
+	if (err)
+		mlx5_core_warn(dev, "Failed reading MFRL, err %d\n", err);
+
+	if (err || test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
 	    !mlx5_is_reset_now_capable(dev)) {
 		err = mlx5_fw_reset_set_reset_sync_nack(dev);
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Nack %s",
@@ -444,21 +462,15 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack. Device reset is expected.\n");
 }
 
-static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
+static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev, u16 dev_id)
 {
 	struct pci_bus *bridge_bus = dev->pdev->bus;
 	struct pci_dev *bridge = bridge_bus->self;
 	unsigned long timeout;
 	struct pci_dev *sdev;
-	u16 reg16, dev_id;
 	int cap, err;
+	u16 reg16;
 
-	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
-	if (err)
-		return pcibios_err_to_errno(err);
-	err = mlx5_check_dev_ids(dev, dev_id);
-	if (err)
-		return err;
 	cap = pci_find_capability(bridge, PCI_CAP_ID_EXP);
 	if (!cap)
 		return -EOPNOTSUPP;
@@ -528,6 +540,44 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	return err;
 }
 
+static int mlx5_pci_reset_bus(struct mlx5_core_dev *dev)
+{
+	if (!MLX5_CAP_GEN(dev, pcie_reset_using_hotreset_method))
+		return -EOPNOTSUPP;
+
+	return pci_reset_bus(dev->pdev);
+}
+
+static int mlx5_sync_pci_reset(struct mlx5_core_dev *dev, u8 reset_method)
+{
+	u16 dev_id;
+	int err;
+
+	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
+	if (err)
+		return pcibios_err_to_errno(err);
+	err = mlx5_check_dev_ids(dev, dev_id);
+	if (err)
+		return err;
+
+	switch (reset_method) {
+	case MLX5_MFRL_REG_PCI_RESET_METHOD_LINK_TOGGLE:
+		err = mlx5_pci_link_toggle(dev, dev_id);
+		if (err)
+			mlx5_core_warn(dev, "mlx5_pci_link_toggle failed\n");
+		break;
+	case MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET:
+		err = mlx5_pci_reset_bus(dev);
+		if (err)
+			mlx5_core_warn(dev, "mlx5_pci_reset_bus failed\n");
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static void mlx5_sync_reset_now_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
@@ -546,9 +596,9 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 		goto done;
 	}
 
-	err = mlx5_pci_link_toggle(dev);
+	err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
 	if (err) {
-		mlx5_core_warn(dev, "mlx5_pci_link_toggle failed, no reset done, err %d\n", err);
+		mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, no reset done, err %d\n", err);
 		set_bit(MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED, &fw_reset->reset_flags);
 	}
 
@@ -610,9 +660,9 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 
 	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n", rst_state);
 	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
-		err = mlx5_pci_link_toggle(dev);
+		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
 		if (err) {
-			mlx5_core_warn(dev, "mlx5_pci_link_toggle failed, err %d\n", err);
+			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n", err);
 			fw_reset->ret = err;
 		}
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 4b88d969a66c..285e8fa1b7b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -619,6 +619,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 	if (MLX5_CAP_GEN_MAX(dev, pci_sync_for_fw_update_with_driver_unload))
 		MLX5_SET(cmd_hca_cap, set_hca_cap,
 			 pci_sync_for_fw_update_with_driver_unload, 1);
+	if (MLX5_CAP_GEN_MAX(dev, pcie_reset_using_hotreset_method))
+		MLX5_SET(cmd_hca_cap, set_hca_cap,
+			 pcie_reset_using_hotreset_method, 1);
 
 	if (MLX5_CAP_GEN_MAX(dev, num_vhca_ports))
 		MLX5_SET(cmd_hca_cap,
-- 
2.46.0


