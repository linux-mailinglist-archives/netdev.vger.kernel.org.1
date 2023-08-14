Return-Path: <netdev+bounces-27501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855FD77C29A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D2B2804D9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1C111BA;
	Mon, 14 Aug 2023 21:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F04111A7
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F02C433B7;
	Mon, 14 Aug 2023 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049321;
	bh=qwtWAcq398BF7b8zWRUOchoAzg2a13wqvWaBJISMH1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjbpOk/NFKDXlgOps0qCXhzVe5Jp6ARcShz5V4+yJuWbqNaFACmBx1WxZgs1Rax2r
	 EFfAED4YfLrvuUBUNo4ANJDP/pjgtKwQJOv7XGV6b3lXwvbDlr0iWAJA6zPtGk1wO0
	 UatI6yMgnwYkZUhspvR9+D57SMvNM0iQbFB2mpSmNWdW93GxwgE7RdtxwBLPGanLrg
	 e0FfRpUyEBjOIvZJ84dbzBA0f+CuwKAjlwc8/YD9OXSH4oCEPQe0s+6Pi56qm53qjq
	 Quvpt8STgexso+SDBwTpbAhTg/cpFZKT1KSaZheiNsUyxYghKxkBL2nMEb8Y/yJYmt
	 igMX0AGzY2Aqw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [net-next 12/14] net/mlx5: Remove unused CAPs
Date: Mon, 14 Aug 2023 14:41:42 -0700
Message-ID: <20230814214144.159464-13-saeed@kernel.org>
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

mlx5 driver queries the device for VECTOR_CALC and SHAMPO caps, but
there isn't any user who requires them.
As well as, MLX5_MCAM_REGS_0x9080_0x90FF is queried but not used.

Thus, drop all usages and definitions of the mentioned caps above.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 13 ------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  2 -
 include/linux/mlx5/device.h                   | 17 +-------
 include/linux/mlx5/mlx5_ifc.h                 | 43 -------------------
 4 files changed, 1 insertion(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index fb2035a5ec99..c982ce06d7a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -206,12 +206,6 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
-	if (MLX5_CAP_GEN(dev, vector_calc)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_VECTOR_CALC);
-		if (err)
-			return err;
-	}
-
 	if (MLX5_CAP_GEN(dev, qos)) {
 		err = mlx5_core_get_caps(dev, MLX5_CAP_QOS);
 		if (err)
@@ -226,7 +220,6 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 
 	if (MLX5_CAP_GEN(dev, mcam_reg)) {
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_FIRST_128);
-		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9080_0x90FF);
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9100_0x917F);
 	}
 
@@ -270,12 +263,6 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
-	if (MLX5_CAP_GEN(dev, shampo)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_SHAMPO);
-		if (err)
-			return err;
-	}
-
 	if (MLX5_CAP_GEN_64(dev, general_obj_types) &
 	    MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD) {
 		err = mlx5_core_get_caps(dev, MLX5_CAP_MACSEC);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index f4fe06a5042e..cb77b5774aad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1714,7 +1714,6 @@ static const int types[] = {
 	MLX5_CAP_FLOW_TABLE,
 	MLX5_CAP_ESWITCH_FLOW_TABLE,
 	MLX5_CAP_ESWITCH,
-	MLX5_CAP_VECTOR_CALC,
 	MLX5_CAP_QOS,
 	MLX5_CAP_DEBUG,
 	MLX5_CAP_DEV_MEM,
@@ -1723,7 +1722,6 @@ static const int types[] = {
 	MLX5_CAP_VDPA_EMULATION,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_PORT_SELECTION,
-	MLX5_CAP_DEV_SHAMPO,
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 80cc12a9a531..5041965250f6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1208,9 +1208,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_FLOW_TABLE,
 	MLX5_CAP_ESWITCH_FLOW_TABLE,
 	MLX5_CAP_ESWITCH,
-	MLX5_CAP_RESERVED,
-	MLX5_CAP_VECTOR_CALC,
-	MLX5_CAP_QOS,
+	MLX5_CAP_QOS = 0xc,
 	MLX5_CAP_DEBUG,
 	MLX5_CAP_RESERVED_14,
 	MLX5_CAP_DEV_MEM,
@@ -1220,7 +1218,6 @@ enum mlx5_cap_type {
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_CRYPTO = 0x1a,
-	MLX5_CAP_DEV_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
@@ -1239,7 +1236,6 @@ enum mlx5_pcam_feature_groups {
 
 enum mlx5_mcam_reg_groups {
 	MLX5_MCAM_REGS_FIRST_128                    = 0x0,
-	MLX5_MCAM_REGS_0x9080_0x90FF                = 0x1,
 	MLX5_MCAM_REGS_0x9100_0x917F                = 0x2,
 	MLX5_MCAM_REGS_NUM                          = 0x3,
 };
@@ -1416,10 +1412,6 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_ODP_MAX(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->max, cap)
 
-#define MLX5_CAP_VECTOR_CALC(mdev, cap) \
-	MLX5_GET(vector_calc_cap, \
-		 mdev->caps.hca[MLX5_CAP_VECTOR_CALC]->cur, cap)
-
 #define MLX5_CAP_QOS(mdev, cap)\
 	MLX5_GET(qos_cap, mdev->caps.hca[MLX5_CAP_QOS]->cur, cap)
 
@@ -1436,10 +1428,6 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_FIRST_128], \
 		 mng_access_reg_cap_mask.access_regs.reg)
 
-#define MLX5_CAP_MCAM_REG1(mdev, reg) \
-	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9080_0x90FF], \
-		 mng_access_reg_cap_mask.access_regs1.reg)
-
 #define MLX5_CAP_MCAM_REG2(mdev, reg) \
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9100_0x917F], \
 		 mng_access_reg_cap_mask.access_regs2.reg)
@@ -1485,9 +1473,6 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_CRYPTO(mdev, cap)\
 	MLX5_GET(crypto_cap, (mdev)->caps.hca[MLX5_CAP_CRYPTO]->cur, cap)
 
-#define MLX5_CAP_DEV_SHAMPO(mdev, cap)\
-	MLX5_GET(shampo_cap, mdev->caps.hca_cur[MLX5_CAP_DEV_SHAMPO], cap)
-
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 9aed7e9b9f29..08dcb1f43be7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1314,33 +1314,6 @@ struct mlx5_ifc_odp_cap_bits {
 	u8         reserved_at_120[0x6E0];
 };
 
-struct mlx5_ifc_calc_op {
-	u8        reserved_at_0[0x10];
-	u8        reserved_at_10[0x9];
-	u8        op_swap_endianness[0x1];
-	u8        op_min[0x1];
-	u8        op_xor[0x1];
-	u8        op_or[0x1];
-	u8        op_and[0x1];
-	u8        op_max[0x1];
-	u8        op_add[0x1];
-};
-
-struct mlx5_ifc_vector_calc_cap_bits {
-	u8         calc_matrix[0x1];
-	u8         reserved_at_1[0x1f];
-	u8         reserved_at_20[0x8];
-	u8         max_vec_count[0x8];
-	u8         reserved_at_30[0xd];
-	u8         max_chunk_size[0x3];
-	struct mlx5_ifc_calc_op calc0;
-	struct mlx5_ifc_calc_op calc1;
-	struct mlx5_ifc_calc_op calc2;
-	struct mlx5_ifc_calc_op calc3;
-
-	u8         reserved_at_c0[0x720];
-};
-
 struct mlx5_ifc_tls_cap_bits {
 	u8         tls_1_2_aes_gcm_128[0x1];
 	u8         tls_1_3_aes_gcm_128[0x1];
@@ -3435,20 +3408,6 @@ struct mlx5_ifc_roce_addr_layout_bits {
 	u8         reserved_at_e0[0x20];
 };
 
-struct mlx5_ifc_shampo_cap_bits {
-	u8    reserved_at_0[0x3];
-	u8    shampo_log_max_reservation_size[0x5];
-	u8    reserved_at_8[0x3];
-	u8    shampo_log_min_reservation_size[0x5];
-	u8    shampo_min_mss_size[0x10];
-
-	u8    reserved_at_20[0x3];
-	u8    shampo_max_log_headers_entry_size[0x5];
-	u8    reserved_at_28[0x18];
-
-	u8    reserved_at_40[0x7c0];
-};
-
 struct mlx5_ifc_crypto_cap_bits {
 	u8    reserved_at_0[0x3];
 	u8    synchronize_dek[0x1];
@@ -3484,14 +3443,12 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_flow_table_eswitch_cap_bits flow_table_eswitch_cap;
 	struct mlx5_ifc_e_switch_cap_bits e_switch_cap;
 	struct mlx5_ifc_port_selection_cap_bits port_selection_cap;
-	struct mlx5_ifc_vector_calc_cap_bits vector_calc_cap;
 	struct mlx5_ifc_qos_cap_bits qos_cap;
 	struct mlx5_ifc_debug_cap_bits debug_cap;
 	struct mlx5_ifc_fpga_cap_bits fpga_cap;
 	struct mlx5_ifc_tls_cap_bits tls_cap;
 	struct mlx5_ifc_device_mem_cap_bits device_mem_cap;
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
-	struct mlx5_ifc_shampo_cap_bits shampo_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	u8         reserved_at_0[0x8000];
-- 
2.41.0


