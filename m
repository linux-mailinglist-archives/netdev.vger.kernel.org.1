Return-Path: <netdev+bounces-57178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EECD812500
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E8F1F21892
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207EEC2;
	Thu, 14 Dec 2023 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUOZzdQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F50A59
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E20FC433C9;
	Thu, 14 Dec 2023 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519722;
	bh=fn6AHD3nYrOncwEalObxBDa7zHaxiw21FeUCxAT2u1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUOZzdQoyjav7JLCHgyuevLv2sUVrEK9i8cBXGeqzYCfkKj7JhbaOP4BU7AZMriZV
	 jXnyZXRBsJG0fDVOBD27jmw/ouVaZoLe5HDj0EawqgNkeiE86x86gSwYZLweToPpAJ
	 W2W2IePBkAHZBLsdK+Q7906Tnu1oAyRCdZFtqNDhOIAhL88OB0GzIa+qtTlesuWHHg
	 PSJ1+Hpstm6pKRmppxzA9Wy1XDNLyt/P6RXa2sT0cUy2Q4mhROOz5DXkexHuucqZL4
	 mz6pImM4mw/n3aVhjHozZqUH6NBP1dehiaEeO90Kd+TuQaClbPaBPVkF+st7cDKq7E
	 eU6Y8lnarIKrw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 02/11] net/mlx5: Expose Management PCIe Index Register (MPIR)
Date: Wed, 13 Dec 2023 18:08:23 -0800
Message-ID: <20231214020832.50703-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

MPIR register allows to query the PCIe indexes
and Socket-Direct related parameters.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     | 10 ++++++++++
 include/linux/mlx5/driver.h                        |  1 +
 include/linux/mlx5/mlx5_ifc.h                      | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 6b14e347d914..a79b7959361b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -243,6 +243,7 @@ int mlx5_query_mcam_reg(struct mlx5_core_dev *dev, u32 *mcap, u8 feature_group,
 			u8 access_reg_group);
 int mlx5_query_qcam_reg(struct mlx5_core_dev *mdev, u32 *qcam,
 			u8 feature_group, u8 access_reg_group);
+int mlx5_query_mpir_reg(struct mlx5_core_dev *dev, u32 *mpir);
 
 void mlx5_lag_add_netdev(struct mlx5_core_dev *dev, struct net_device *netdev);
 void mlx5_lag_remove_netdev(struct mlx5_core_dev *dev, struct net_device *netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 7d8c732818f2..7fba1c46e2ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1206,3 +1206,13 @@ int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)
 	*speed = max_speed;
 	return 0;
 }
+
+int mlx5_query_mpir_reg(struct mlx5_core_dev *dev, u32 *mpir)
+{
+	u32 in[MLX5_ST_SZ_DW(mpir_reg)] = {};
+	int sz = MLX5_ST_SZ_BYTES(mpir_reg);
+
+	MLX5_SET(mpir_reg, in, local_port, 1);
+
+	return mlx5_core_access_reg(dev, in, sz, mpir, sz, MLX5_REG_MPIR, 0, 0);
+}
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d2b8d4a74a30..2f67cec1a898 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -150,6 +150,7 @@ enum {
 	MLX5_REG_MTPPSE		 = 0x9054,
 	MLX5_REG_MTUTC		 = 0x9055,
 	MLX5_REG_MPEGC		 = 0x9056,
+	MLX5_REG_MPIR		 = 0x9059,
 	MLX5_REG_MCQS		 = 0x9060,
 	MLX5_REG_MCQI		 = 0x9061,
 	MLX5_REG_MCC		 = 0x9062,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 405d141b4a08..828938368fb7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10108,6 +10108,20 @@ struct mlx5_ifc_mpegc_reg_bits {
 	u8         reserved_at_60[0x100];
 };
 
+struct mlx5_ifc_mpir_reg_bits {
+	u8         sdm[0x1];
+	u8         reserved_at_1[0x1b];
+	u8         host_buses[0x4];
+
+	u8         reserved_at_20[0x20];
+
+	u8         local_port[0x8];
+	u8         reserved_at_28[0x15];
+	u8         sd_group[0x3];
+
+	u8         reserved_at_60[0x20];
+};
+
 enum {
 	MLX5_MTUTC_FREQ_ADJ_UNITS_PPB          = 0x0,
 	MLX5_MTUTC_FREQ_ADJ_UNITS_SCALED_PPM   = 0x1,
-- 
2.43.0


