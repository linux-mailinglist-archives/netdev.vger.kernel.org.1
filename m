Return-Path: <netdev+bounces-68687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC2847966
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2191F2811C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936112D765;
	Fri,  2 Feb 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOG92QKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849912D761
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900952; cv=none; b=oZYtJk3aDVLtdd5tVefng49d3WsPZg+edK5k836/DE5QGF7RI7J9aAP0mECgfILanvxkwKUBsIg88kfKl0H3zHYijD6MNuLsjZ5hY1Lq8YRp5kz3Wurz9PXEqaHuJf0f2tworwljwYJW/U2TpovZ94nLUcNDuFpmj84V4jutnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900952; c=relaxed/simple;
	bh=GpkFGTPQ68oEp+xKbVIPAikT2jaSar++mwHaxZ4Gc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htsxdT13h9Ramo81JhNRtjuiLtoBN0mwyygioZzdOC/ypMzYxKQb9Q9qEexZvSyyjr+OW6sqRdBuXZUdfHEmmN3ttPzWq3TFOcx0efWZyEtlITExiOOs5KbYrH+eaJJIR57ltgfmXBeNkeCsNWVWUfe7C3/JqYFoAap3/MTcqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOG92QKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B658C433C7;
	Fri,  2 Feb 2024 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900952;
	bh=GpkFGTPQ68oEp+xKbVIPAikT2jaSar++mwHaxZ4Gc8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOG92QKhnaibUhBwfQfic0SkmZHpTGT32+l6GuiQhrBjc4Ul9kcvTMfGh0znyMH/I
	 JzQVOl1aIm9atsktXd8PY9FPmYGmCDsotErGIFtjc6r5MKQjSj2ozvpXSyc/37Cp7I
	 l0g3YIVSkCoYl2pFDKROS+jw0DRi09tYKMd2U04bKfNnFlWOEXXiY1i+WDkr0j2hlZ
	 C51WBcg5w7Jj8rOZff3ou4giM1stv5QNNqIksuXakEy44J8ql4y8BapWTuifxzjyfr
	 9G8J5nadUxiecoXvGymwcAAXEVFYFX3OmGzwlQ3R20kD9l8FItWaizYsPjHcrhpyyp
	 lZZT5nESyPjGw==
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
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net-next V3 11/15] net/mlx5: Remove initial segmentation duplicate definitions
Date: Fri,  2 Feb 2024 11:08:50 -0800
Message-ID: <20240202190854.1308089-12-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Device definitions belong in mlx5_ifc, remove the duplicates in
mlx5_core.h.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  6 +++---
 .../net/ethernet/mellanox/mlx5/core/health.c  | 20 +++++++++----------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  7 -------
 include/linux/mlx5/mlx5_ifc.h                 |  1 +
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..e7faf7e73ca4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -366,18 +366,18 @@ int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev)
 		return -EIO;
 	}
 
-	mlx5_set_nic_state(dev, MLX5_NIC_IFC_DISABLED);
+	mlx5_set_nic_state(dev, MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED);
 
 	/* Loop until device state turns to disable */
 	end = jiffies + msecs_to_jiffies(delay_ms);
 	do {
-		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
+		if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED)
 			break;
 
 		cond_resched();
 	} while (!time_after(jiffies, end));
 
-	if (mlx5_get_nic_state(dev) != MLX5_NIC_IFC_DISABLED) {
+	if (mlx5_get_nic_state(dev) != MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED) {
 		dev_err(&dev->pdev->dev, "NIC IFC still %d after %lums.\n",
 			mlx5_get_nic_state(dev), delay_ms);
 		return -EIO;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 5c2ac2d9dbd9..9463ede84d8d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -116,9 +116,9 @@ u32 mlx5_health_check_fatal_sensors(struct mlx5_core_dev *dev)
 		return MLX5_SENSOR_PCI_COMM_ERR;
 	if (pci_channel_offline(dev->pdev))
 		return MLX5_SENSOR_PCI_ERR;
-	if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
+	if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED)
 		return MLX5_SENSOR_NIC_DISABLED;
-	if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_SW_RESET)
+	if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_SW_RESET)
 		return MLX5_SENSOR_NIC_SW_RESET;
 	if (sensor_fw_synd_rfr(dev))
 		return MLX5_SENSOR_FW_SYND_RFR;
@@ -185,7 +185,7 @@ static bool reset_fw_if_needed(struct mlx5_core_dev *dev)
 	/* Write the NIC interface field to initiate the reset, the command
 	 * interface address also resides here, don't overwrite it.
 	 */
-	mlx5_set_nic_state(dev, MLX5_NIC_IFC_SW_RESET);
+	mlx5_set_nic_state(dev, MLX5_INITIAL_SEG_NIC_INTERFACE_SW_RESET);
 
 	return true;
 }
@@ -246,13 +246,13 @@ void mlx5_error_sw_reset(struct mlx5_core_dev *dev)
 	/* Recover from SW reset */
 	end = jiffies + msecs_to_jiffies(delay_ms);
 	do {
-		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
+		if (mlx5_get_nic_state(dev) == MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED)
 			break;
 
 		msleep(20);
 	} while (!time_after(jiffies, end));
 
-	if (mlx5_get_nic_state(dev) != MLX5_NIC_IFC_DISABLED) {
+	if (mlx5_get_nic_state(dev) != MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED) {
 		dev_err(&dev->pdev->dev, "NIC IFC still %d after %lums.\n",
 			mlx5_get_nic_state(dev), delay_ms);
 	}
@@ -272,26 +272,26 @@ static void mlx5_handle_bad_state(struct mlx5_core_dev *dev)
 	u8 nic_interface = mlx5_get_nic_state(dev);
 
 	switch (nic_interface) {
-	case MLX5_NIC_IFC_FULL:
+	case MLX5_INITIAL_SEG_NIC_INTERFACE_FULL_DRIVER:
 		mlx5_core_warn(dev, "Expected to see disabled NIC but it is full driver\n");
 		break;
 
-	case MLX5_NIC_IFC_DISABLED:
+	case MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED:
 		mlx5_core_warn(dev, "starting teardown\n");
 		break;
 
-	case MLX5_NIC_IFC_NO_DRAM_NIC:
+	case MLX5_INITIAL_SEG_NIC_INTERFACE_NO_DRAM_NIC:
 		mlx5_core_warn(dev, "Expected to see disabled NIC but it is no dram nic\n");
 		break;
 
-	case MLX5_NIC_IFC_SW_RESET:
+	case MLX5_INITIAL_SEG_NIC_INTERFACE_SW_RESET:
 		/* The IFC mode field is 3 bits, so it will read 0x7 in 2 cases:
 		 * 1. PCI has been disabled (ie. PCI-AER, PF driver unloaded
 		 *    and this is a VF), this is not recoverable by SW reset.
 		 *    Logging of this is handled elsewhere.
 		 * 2. FW reset has been issued by another function, driver can
 		 *    be reloaded to recover after the mode switches to
-		 *    MLX5_NIC_IFC_DISABLED.
+		 *    MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED.
 		 */
 		if (dev->priv.health.fatal_error != MLX5_SENSOR_PCI_COMM_ERR)
 			mlx5_core_warn(dev, "NIC SW reset in progress\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index a79b7959361b..58732f44940f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -312,13 +312,6 @@ static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 	return ret;
 }
 
-enum {
-	MLX5_NIC_IFC_FULL		= 0,
-	MLX5_NIC_IFC_DISABLED		= 1,
-	MLX5_NIC_IFC_NO_DRAM_NIC	= 2,
-	MLX5_NIC_IFC_SW_RESET		= 7
-};
-
 u8 mlx5_get_nic_state(struct mlx5_core_dev *dev);
 void mlx5_set_nic_state(struct mlx5_core_dev *dev, u8 state);
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6c44f107b8ba..7f5e846eb46d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10661,6 +10661,7 @@ enum {
 	MLX5_INITIAL_SEG_NIC_INTERFACE_FULL_DRIVER  = 0x0,
 	MLX5_INITIAL_SEG_NIC_INTERFACE_DISABLED     = 0x1,
 	MLX5_INITIAL_SEG_NIC_INTERFACE_NO_DRAM_NIC  = 0x2,
+	MLX5_INITIAL_SEG_NIC_INTERFACE_SW_RESET     = 0x7,
 };
 
 enum {
-- 
2.43.0


