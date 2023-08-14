Return-Path: <netdev+bounces-27502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E277C29B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5491C20B8B
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409F111A7;
	Mon, 14 Aug 2023 21:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8311197
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40555C433AB;
	Mon, 14 Aug 2023 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049322;
	bh=6YA5PETPbxnNgRSN/6ZMyfFv7qyyjjEd7FYgm1IguKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPpTSoxr8l7k24eDo/SgMta5ANWh0yIVOih2eQm8RSaU+ZCRuSDmGvc9Qx0c036zO
	 nKc3q6tyKm4tZbDrtuilw4Jf+S7Cs/QqPoYvYi9nJsO3oab5fV1GjJfWe6uSHKmDGn
	 5lq9obeQ3ikN5dLoo3yMHipTpFhAp5HZxC7tSQXY85NgO+Q4iJhnPNqfGcfxhyNxeX
	 Yrtvjfyemn7wAc5FZMu1TqTsvhLMKryTj1syUtTgoxe6fO6aWx6SJpFFNZ0qGurGin
	 rIvUFbEXsx8sCm+ooIq2If6TEWFpITd1USOeVGzH9/B9M6J6ROv2h/AHWtnR0Xyfwx
	 fpUNIDOZuQwmg==
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
Subject: [net-next 13/14] net/mlx5: Remove unused MAX HCA capabilities
Date: Mon, 14 Aug 2023 14:41:43 -0700
Message-ID: <20230814214144.159464-14-saeed@kernel.org>
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

Each device cap has two modes: MAX and CUR. The driver maintains a
cache of both modes of the capabilities. For most device caps, the MAX
cap mode is never used.

Hence, remove all driver queries of the MAX mode of the said caps as
well as their helper MACROs.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  | 34 ++++++------
 .../net/ethernet/mellanox/mlx5/core/main.c    | 14 ++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  3 ++
 include/linux/mlx5/device.h                   | 52 -------------------
 include/linux/mlx5/driver.h                   |  1 -
 5 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index c982ce06d7a3..0e394408af75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -160,13 +160,15 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	}
 
 	if (MLX5_CAP_GEN(dev, eth_net_offloads)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ETHERNET_OFFLOADS);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ETHERNET_OFFLOADS,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, ipoib_enhanced_offloads)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_IPOIB_ENHANCED_OFFLOADS);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_IPOIB_ENHANCED_OFFLOADS,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
@@ -191,29 +193,30 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 
 	if (MLX5_CAP_GEN(dev, nic_flow_table) ||
 	    MLX5_CAP_GEN(dev, ipoib_enhanced_offloads)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_FLOW_TABLE);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_FLOW_TABLE, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_ESWITCH_MANAGER(dev)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ESWITCH_FLOW_TABLE);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ESWITCH_FLOW_TABLE,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ESWITCH);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ESWITCH, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, qos)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_QOS);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_QOS, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, debug))
-		mlx5_core_get_caps(dev, MLX5_CAP_DEBUG);
+		mlx5_core_get_caps_mode(dev, MLX5_CAP_DEBUG, HCA_CAP_OPMOD_GET_CUR);
 
 	if (MLX5_CAP_GEN(dev, pcam_reg))
 		mlx5_get_pcam_reg(dev);
@@ -227,51 +230,52 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 		mlx5_get_qcam_reg(dev);
 
 	if (MLX5_CAP_GEN(dev, device_memory)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_MEM);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_DEV_MEM, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, event_cap)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_EVENT);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_DEV_EVENT, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, tls_tx) || MLX5_CAP_GEN(dev, tls_rx)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_TLS);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_TLS, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN_64(dev, general_obj_types) &
 		MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_VDPA_EMULATION);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_VDPA_EMULATION, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, ipsec_offload)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_IPSEC);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_IPSEC, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, crypto)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_CRYPTO);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_CRYPTO, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN_64(dev, general_obj_types) &
 	    MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_MACSEC);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_MACSEC, HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, adv_virtualization)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ADV_VIRTUALIZATION);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ADV_VIRTUALIZATION,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index cb77b5774aad..15561965d2af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -361,9 +361,8 @@ void mlx5_core_uplink_netdev_event_replay(struct mlx5_core_dev *dev)
 }
 EXPORT_SYMBOL(mlx5_core_uplink_netdev_event_replay);
 
-static int mlx5_core_get_caps_mode(struct mlx5_core_dev *dev,
-				   enum mlx5_cap_type cap_type,
-				   enum mlx5_cap_mode cap_mode)
+int mlx5_core_get_caps_mode(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_type,
+			    enum mlx5_cap_mode cap_mode)
 {
 	u8 in[MLX5_ST_SZ_BYTES(query_hca_cap_in)];
 	int out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
@@ -1620,21 +1619,24 @@ static int mlx5_query_hca_caps_light(struct mlx5_core_dev *dev)
 		return err;
 
 	if (MLX5_CAP_GEN(dev, eth_net_offloads)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_ETHERNET_OFFLOADS);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_ETHERNET_OFFLOADS,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN(dev, nic_flow_table) ||
 	    MLX5_CAP_GEN(dev, ipoib_enhanced_offloads)) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_FLOW_TABLE);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_FLOW_TABLE,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
 
 	if (MLX5_CAP_GEN_64(dev, general_obj_types) &
 		MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
-		err = mlx5_core_get_caps(dev, MLX5_CAP_VDPA_EMULATION);
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_VDPA_EMULATION,
+					      HCA_CAP_OPMOD_GET_CUR);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 8e2028d20a9e..124352459c23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -174,6 +174,9 @@ static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
 #define MLX5_FLEXIBLE_INLEN(dev, fixed, item_size, num_items) \
 	mlx5_flexible_inlen(dev, fixed, item_size, num_items, __func__, __LINE__)
 
+int mlx5_core_get_caps(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_type);
+int mlx5_core_get_caps_mode(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_type,
+			    enum mlx5_cap_mode cap_mode);
 int mlx5_query_hca_caps(struct mlx5_core_dev *dev);
 int mlx5_query_board_id(struct mlx5_core_dev *dev);
 int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num);
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 5041965250f6..93399802ba77 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1275,10 +1275,6 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(per_protocol_networking_offload_caps,\
 		 mdev->caps.hca[MLX5_CAP_ETHERNET_OFFLOADS]->cur, cap)
 
-#define MLX5_CAP_ETH_MAX(mdev, cap) \
-	MLX5_GET(per_protocol_networking_offload_caps,\
-		 mdev->caps.hca[MLX5_CAP_ETHERNET_OFFLOADS]->max, cap)
-
 #define MLX5_CAP_IPOIB_ENHANCED(mdev, cap) \
 	MLX5_GET(per_protocol_networking_offload_caps,\
 		 mdev->caps.hca[MLX5_CAP_IPOIB_ENHANCED_OFFLOADS]->cur, cap)
@@ -1301,77 +1297,40 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP64_FLOWTABLE(mdev, cap) \
 	MLX5_GET64(flow_table_nic_cap, (mdev)->caps.hca[MLX5_CAP_FLOW_TABLE]->cur, cap)
 
-#define MLX5_CAP_FLOWTABLE_MAX(mdev, cap) \
-	MLX5_GET(flow_table_nic_cap, mdev->caps.hca[MLX5_CAP_FLOW_TABLE]->max, cap)
-
 #define MLX5_CAP_FLOWTABLE_NIC_RX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_receive.cap)
 
-#define MLX5_CAP_FLOWTABLE_NIC_RX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_receive.cap)
-
 #define MLX5_CAP_FLOWTABLE_NIC_TX(mdev, cap) \
 		MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_transmit.cap)
 
-#define MLX5_CAP_FLOWTABLE_NIC_TX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_transmit.cap)
-
 #define MLX5_CAP_FLOWTABLE_SNIFFER_RX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_receive_sniffer.cap)
 
-#define MLX5_CAP_FLOWTABLE_SNIFFER_RX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_receive_sniffer.cap)
-
 #define MLX5_CAP_FLOWTABLE_SNIFFER_TX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_transmit_sniffer.cap)
 
-#define MLX5_CAP_FLOWTABLE_SNIFFER_TX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_transmit_sniffer.cap)
-
 #define MLX5_CAP_FLOWTABLE_RDMA_RX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_receive_rdma.cap)
 
-#define MLX5_CAP_FLOWTABLE_RDMA_RX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_receive_rdma.cap)
-
 #define MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_transmit_rdma.cap)
 
-#define MLX5_CAP_FLOWTABLE_RDMA_TX_MAX(mdev, cap) \
-	MLX5_CAP_FLOWTABLE_MAX(mdev, flow_table_properties_nic_transmit_rdma.cap)
-
 #define MLX5_CAP_ESW_FLOWTABLE(mdev, cap) \
 	MLX5_GET(flow_table_eswitch_cap, \
 		 mdev->caps.hca[MLX5_CAP_ESWITCH_FLOW_TABLE]->cur, cap)
 
-#define MLX5_CAP_ESW_FLOWTABLE_MAX(mdev, cap) \
-	MLX5_GET(flow_table_eswitch_cap, \
-		 mdev->caps.hca[MLX5_CAP_ESWITCH_FLOW_TABLE]->max, cap)
-
 #define MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) \
 	MLX5_CAP_ESW_FLOWTABLE(mdev, flow_table_properties_nic_esw_fdb.cap)
 
-#define MLX5_CAP_ESW_FLOWTABLE_FDB_MAX(mdev, cap) \
-	MLX5_CAP_ESW_FLOWTABLE_MAX(mdev, flow_table_properties_nic_esw_fdb.cap)
-
 #define MLX5_CAP_ESW_EGRESS_ACL(mdev, cap) \
 	MLX5_CAP_ESW_FLOWTABLE(mdev, flow_table_properties_esw_acl_egress.cap)
 
-#define MLX5_CAP_ESW_EGRESS_ACL_MAX(mdev, cap) \
-	MLX5_CAP_ESW_FLOWTABLE_MAX(mdev, flow_table_properties_esw_acl_egress.cap)
-
 #define MLX5_CAP_ESW_INGRESS_ACL(mdev, cap) \
 	MLX5_CAP_ESW_FLOWTABLE(mdev, flow_table_properties_esw_acl_ingress.cap)
 
-#define MLX5_CAP_ESW_INGRESS_ACL_MAX(mdev, cap) \
-	MLX5_CAP_ESW_FLOWTABLE_MAX(mdev, flow_table_properties_esw_acl_ingress.cap)
-
 #define MLX5_CAP_ESW_FT_FIELD_SUPPORT_2(mdev, cap) \
 	MLX5_CAP_ESW_FLOWTABLE(mdev, ft_field_support_2_esw_fdb.cap)
 
-#define MLX5_CAP_ESW_FT_FIELD_SUPPORT_2_MAX(mdev, cap) \
-	MLX5_CAP_ESW_FLOWTABLE_MAX(mdev, ft_field_support_2_esw_fdb.cap)
-
 #define MLX5_CAP_ESW(mdev, cap) \
 	MLX5_GET(e_switch_cap, \
 		 mdev->caps.hca[MLX5_CAP_ESWITCH]->cur, cap)
@@ -1380,10 +1339,6 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET64(flow_table_eswitch_cap, \
 		(mdev)->caps.hca[MLX5_CAP_ESWITCH_FLOW_TABLE]->cur, cap)
 
-#define MLX5_CAP_ESW_MAX(mdev, cap) \
-	MLX5_GET(e_switch_cap, \
-		 mdev->caps.hca[MLX5_CAP_ESWITCH]->max, cap)
-
 #define MLX5_CAP_PORT_SELECTION(mdev, cap) \
 	MLX5_GET(port_selection_cap, \
 		 mdev->caps.hca[MLX5_CAP_PORT_SELECTION]->cur, cap)
@@ -1396,16 +1351,9 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(adv_virtualization_cap, \
 		 mdev->caps.hca[MLX5_CAP_ADV_VIRTUALIZATION]->cur, cap)
 
-#define MLX5_CAP_ADV_VIRTUALIZATION_MAX(mdev, cap) \
-	MLX5_GET(adv_virtualization_cap, \
-		 mdev->caps.hca[MLX5_CAP_ADV_VIRTUALIZATION]->max, cap)
-
 #define MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) \
 	MLX5_CAP_PORT_SELECTION(mdev, flow_table_properties_port_selection.cap)
 
-#define MLX5_CAP_FLOWTABLE_PORT_SELECTION_MAX(mdev, cap) \
-	MLX5_CAP_PORT_SELECTION_MAX(mdev, flow_table_properties_port_selection.cap)
-
 #define MLX5_CAP_ODP(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, cap)
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e1c7e502a4fc..c9d82e74daaa 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1022,7 +1022,6 @@ bool mlx5_cmd_is_down(struct mlx5_core_dev *dev);
 void mlx5_core_uplink_netdev_set(struct mlx5_core_dev *mdev, struct net_device *netdev);
 void mlx5_core_uplink_netdev_event_replay(struct mlx5_core_dev *mdev);
 
-int mlx5_core_get_caps(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_type);
 void mlx5_health_cleanup(struct mlx5_core_dev *dev);
 int mlx5_health_init(struct mlx5_core_dev *dev);
 void mlx5_start_health_poll(struct mlx5_core_dev *dev);
-- 
2.41.0


