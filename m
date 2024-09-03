Return-Path: <netdev+bounces-124356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3AD9691B8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8391F2360B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A11CDFB8;
	Tue,  3 Sep 2024 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxz1ZyXG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E91CDFB4
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333592; cv=none; b=Jj0PUKr+ZpafEHshBDxSOYxbIfgWlWBwtbsr/c3Gwmnp4WpaVxlzSmC8ALLiYo3uxWMuwd39btzMElikA14fuawnQxwh7dffwoCP5yK4iyq8Hk/xfHuf5jZL2KDu9gM22U9d3U+xOf9sthb2yFp2wMaDeJYnB6wiGHokOdmnTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333592; c=relaxed/simple;
	bh=mOnyexlpakk2G8MOcuaLPdALyHi+kCpR4fm406pObYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcF2RGLiWbCo7Bsg5FXmPiNc5HARN1Wt8GRPNliynjpbd/UWn3iD18iX5j0uo1wQYqYv3Da8HyB9ryofcEREqSzP9U+XNLYbV6/fjFway5u145IP4Bjxvxf05toeeuYuTUzTZtu48jIWgkpic+4ZyELyrA6Lz40oTVXx3IGT/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxz1ZyXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F179C4CEC2;
	Tue,  3 Sep 2024 03:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725333591;
	bh=mOnyexlpakk2G8MOcuaLPdALyHi+kCpR4fm406pObYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxz1ZyXG9+3EnY2I7+UZcYZdssmICMcE9IRGToGi7CUuWeyL+ozQF0HjHlgfkMHGb
	 vdUYWZSyVo/aBGKc8rMxl5ZEkRcbg8N5wnWwXpj6x0jO1R0CxF8/OWzJvD9Mr004U0
	 svTA+W6dZKx7ASt9hQ5gDrYN8AS39GLVhWmREuj6i0dj68A2OqhZVrZ6nw5/jUiwJ+
	 XRhAYNN+YaDcw2+O0DdwGL3n/XNdQz76rEj11+NAXaemLtj8DGQScXovxRX7/F1FqN
	 uqPffOoj0obh4AmwNxUMSXdRh8uLr2FxuZMhNdN8eKQF1+5HiPeZOk0JylOglf7kaB
	 JGclkvU/bB3xw==
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
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Hamdan Agbariya <hamdani@nvidia.com>
Subject: [net-next 01/15] net/mlx5: Added missing mlx5_ifc definition for HW Steering
Date: Mon,  2 Sep 2024 20:19:32 -0700
Message-ID: <20240903031948.78006-2-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903031948.78006-1-saeed@kernel.org>
References: <20240903031948.78006-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Add mlx5_ifc definitions that are required for HWS support.

Note that due to change in the mlx5_ifc_flow_table_context_bits
structure that now includes both SWS and HWS bits in a union,
this patch also includes small change in one of SWS files that
was required for compilation.

Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_cmd.c      |  12 +-
 include/linux/mlx5/mlx5_ifc.h                 | 189 +++++++++++++++---
 2 files changed, 167 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 8c2a34a0d6be..baefb9a3fa05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -251,9 +251,9 @@ int mlx5dr_cmd_query_flow_table(struct mlx5_core_dev *dev,
 	output->level = MLX5_GET(query_flow_table_out, out, flow_table_context.level);
 
 	output->sw_owner_icm_root_1 = MLX5_GET64(query_flow_table_out, out,
-						 flow_table_context.sw_owner_icm_root_1);
+						 flow_table_context.sws.sw_owner_icm_root_1);
 	output->sw_owner_icm_root_0 = MLX5_GET64(query_flow_table_out, out,
-						 flow_table_context.sw_owner_icm_root_0);
+						 flow_table_context.sws.sw_owner_icm_root_0);
 
 	return 0;
 }
@@ -480,15 +480,15 @@ int mlx5dr_cmd_create_flow_table(struct mlx5_core_dev *mdev,
 		 */
 		if (attr->table_type == MLX5_FLOW_TABLE_TYPE_NIC_RX) {
 			MLX5_SET64(flow_table_context, ft_mdev,
-				   sw_owner_icm_root_0, attr->icm_addr_rx);
+				   sws.sw_owner_icm_root_0, attr->icm_addr_rx);
 		} else if (attr->table_type == MLX5_FLOW_TABLE_TYPE_NIC_TX) {
 			MLX5_SET64(flow_table_context, ft_mdev,
-				   sw_owner_icm_root_0, attr->icm_addr_tx);
+				   sws.sw_owner_icm_root_0, attr->icm_addr_tx);
 		} else if (attr->table_type == MLX5_FLOW_TABLE_TYPE_FDB) {
 			MLX5_SET64(flow_table_context, ft_mdev,
-				   sw_owner_icm_root_0, attr->icm_addr_rx);
+				   sws.sw_owner_icm_root_0, attr->icm_addr_rx);
 			MLX5_SET64(flow_table_context, ft_mdev,
-				   sw_owner_icm_root_1, attr->icm_addr_tx);
+				   sws.sw_owner_icm_root_1, attr->icm_addr_tx);
 		}
 	}
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 234ad6f16e92..b6f8e3834bd3 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -80,23 +80,15 @@ enum {
 
 enum {
 	MLX5_OBJ_TYPE_SW_ICM = 0x0008,
-	MLX5_OBJ_TYPE_HEADER_MODIFY_ARGUMENT  = 0x23,
-};
-
-enum {
-	MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM = (1ULL << MLX5_OBJ_TYPE_SW_ICM),
-	MLX5_GENERAL_OBJ_TYPES_CAP_GENEVE_TLV_OPT = (1ULL << 11),
-	MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q = (1ULL << 13),
-	MLX5_GENERAL_OBJ_TYPES_CAP_HEADER_MODIFY_ARGUMENT =
-		(1ULL << MLX5_OBJ_TYPE_HEADER_MODIFY_ARGUMENT),
-	MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD = (1ULL << 39),
-};
-
-enum {
 	MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
 	MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
 	MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS = 0x001c,
 	MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
+	MLX5_OBJ_TYPE_HEADER_MODIFY_ARGUMENT  = 0x23,
+	MLX5_OBJ_TYPE_STC = 0x0040,
+	MLX5_OBJ_TYPE_RTC = 0x0041,
+	MLX5_OBJ_TYPE_STE = 0x0042,
+	MLX5_OBJ_TYPE_MODIFY_HDR_PATTERN = 0x0043,
 	MLX5_OBJ_TYPE_PAGE_TRACK = 0x46,
 	MLX5_OBJ_TYPE_MKEY = 0xff01,
 	MLX5_OBJ_TYPE_QP = 0xff02,
@@ -112,6 +104,16 @@ enum {
 	MLX5_OBJ_TYPE_RQT = 0xff0e,
 	MLX5_OBJ_TYPE_FLOW_COUNTER = 0xff0f,
 	MLX5_OBJ_TYPE_CQ = 0xff10,
+	MLX5_OBJ_TYPE_FT_ALIAS = 0xff15,
+};
+
+enum {
+	MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM = (1ULL << MLX5_OBJ_TYPE_SW_ICM),
+	MLX5_GENERAL_OBJ_TYPES_CAP_GENEVE_TLV_OPT = (1ULL << 11),
+	MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q = (1ULL << 13),
+	MLX5_GENERAL_OBJ_TYPES_CAP_HEADER_MODIFY_ARGUMENT =
+		(1ULL << MLX5_OBJ_TYPE_HEADER_MODIFY_ARGUMENT),
+	MLX5_GENERAL_OBJ_TYPES_CAP_MACSEC_OFFLOAD = (1ULL << 39),
 };
 
 enum {
@@ -313,6 +315,7 @@ enum {
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
 	MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS       = 0xb16,
+	MLX5_CMD_OP_GENERATE_WQE                  = 0xb17,
 	MLX5_CMD_OP_MAX
 };
 
@@ -485,7 +488,13 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         reserved_at_66[0x2];
 	u8         reformat_add_macsec[0x1];
 	u8         reformat_remove_macsec[0x1];
-	u8         reserved_at_6a[0xe];
+	u8         reparse[0x1];
+	u8         reserved_at_6b[0x1];
+	u8         cross_vhca_object[0x1];
+	u8         reformat_l2_to_l3_audp_tunnel[0x1];
+	u8         reformat_l3_audp_tunnel_to_l2[0x1];
+	u8         ignore_flow_level_rtc_valid[0x1];
+	u8         reserved_at_70[0x8];
 	u8         log_max_ft_num[0x8];
 
 	u8         reserved_at_80[0x10];
@@ -522,7 +531,15 @@ struct mlx5_ifc_ipv6_layout_bits {
 	u8         ipv6[16][0x8];
 };
 
+struct mlx5_ifc_ipv6_simple_layout_bits {
+	u8         ipv6_127_96[0x20];
+	u8         ipv6_95_64[0x20];
+	u8         ipv6_63_32[0x20];
+	u8         ipv6_31_0[0x20];
+};
+
 union mlx5_ifc_ipv6_layout_ipv4_layout_auto_bits {
+	struct mlx5_ifc_ipv6_simple_layout_bits ipv6_simple_layout;
 	struct mlx5_ifc_ipv6_layout_bits ipv6_layout;
 	struct mlx5_ifc_ipv4_layout_bits ipv4_layout;
 	u8         reserved_at_0[0x80];
@@ -911,7 +928,9 @@ struct mlx5_ifc_flow_table_eswitch_cap_bits {
 	u8      reserved_at_8[0x5];
 	u8      fdb_uplink_hairpin[0x1];
 	u8      fdb_multi_path_any_table_limit_regc[0x1];
-	u8      reserved_at_f[0x3];
+	u8      reserved_at_f[0x1];
+	u8      fdb_dynamic_tunnel[0x1];
+	u8      reserved_at_11[0x1];
 	u8      fdb_multi_path_any_table[0x1];
 	u8      reserved_at_13[0x2];
 	u8      fdb_modify_header_fwd_to_table[0x1];
@@ -950,6 +969,73 @@ struct mlx5_ifc_flow_table_eswitch_cap_bits {
 	u8      reserved_at_1900[0x6700];
 };
 
+struct mlx5_ifc_wqe_based_flow_table_cap_bits {
+	u8         reserved_at_0[0x3];
+	u8         log_max_num_ste[0x5];
+	u8         reserved_at_8[0x3];
+	u8         log_max_num_stc[0x5];
+	u8         reserved_at_10[0x3];
+	u8         log_max_num_rtc[0x5];
+	u8         reserved_at_18[0x3];
+	u8         log_max_num_header_modify_pattern[0x5];
+
+	u8         rtc_hash_split_table[0x1];
+	u8         rtc_linear_lookup_table[0x1];
+	u8         reserved_at_22[0x1];
+	u8         stc_alloc_log_granularity[0x5];
+	u8         reserved_at_28[0x3];
+	u8         stc_alloc_log_max[0x5];
+	u8         reserved_at_30[0x3];
+	u8         ste_alloc_log_granularity[0x5];
+	u8         reserved_at_38[0x3];
+	u8         ste_alloc_log_max[0x5];
+
+	u8         reserved_at_40[0xb];
+	u8         rtc_reparse_mode[0x5];
+	u8         reserved_at_50[0x3];
+	u8         rtc_index_mode[0x5];
+	u8         reserved_at_58[0x3];
+	u8         rtc_log_depth_max[0x5];
+
+	u8         reserved_at_60[0x10];
+	u8         ste_format[0x10];
+
+	u8         stc_action_type[0x80];
+
+	u8         header_insert_type[0x10];
+	u8         header_remove_type[0x10];
+
+	u8         trivial_match_definer[0x20];
+
+	u8         reserved_at_140[0x1b];
+	u8         rtc_max_num_hash_definer_gen_wqe[0x5];
+
+	u8         reserved_at_160[0x18];
+	u8         access_index_mode[0x8];
+
+	u8         reserved_at_180[0x10];
+	u8         ste_format_gen_wqe[0x10];
+
+	u8         linear_match_definer_reg_c3[0x20];
+
+	u8         fdb_jump_to_tir_stc[0x1];
+	u8         reserved_at_1c1[0x1f];
+};
+
+struct mlx5_ifc_esw_cap_bits {
+	u8         reserved_at_0[0x1d];
+	u8         merged_eswitch[0x1];
+	u8         reserved_at_1e[0x2];
+
+	u8         reserved_at_20[0x40];
+
+	u8         esw_manager_vport_number_valid[0x1];
+	u8         reserved_at_61[0xf];
+	u8         esw_manager_vport_number[0x10];
+
+	u8         reserved_at_80[0x780];
+};
+
 enum {
 	MLX5_COUNTER_SOURCE_ESWITCH = 0x0,
 	MLX5_COUNTER_FLOW_ESWITCH   = 0x1,
@@ -1443,9 +1529,13 @@ enum {
 };
 
 enum {
+	MLX5_FLEX_IPV4_OVER_VXLAN_ENABLED	= 1 << 0,
+	MLX5_FLEX_IPV6_OVER_VXLAN_ENABLED	= 1 << 1,
+	MLX5_FLEX_IPV6_OVER_IP_ENABLED		= 1 << 2,
 	MLX5_FLEX_PARSER_GENEVE_ENABLED		= 1 << 3,
 	MLX5_FLEX_PARSER_MPLS_OVER_GRE_ENABLED	= 1 << 4,
 	MLX5_FLEX_PARSER_MPLS_OVER_UDP_ENABLED	= 1 << 5,
+	MLX5_FLEX_P_BIT_VXLAN_GPE_ENABLED	= 1 << 6,
 	MLX5_FLEX_PARSER_VXLAN_GPE_ENABLED	= 1 << 7,
 	MLX5_FLEX_PARSER_ICMP_V4_ENABLED	= 1 << 8,
 	MLX5_FLEX_PARSER_ICMP_V6_ENABLED	= 1 << 9,
@@ -1650,7 +1740,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         pci_sync_for_fw_update_event[0x1];
 	u8         reserved_at_1f2[0x6];
 	u8         init2_lag_tx_port_affinity[0x1];
-	u8         reserved_at_1fa[0x3];
+	u8         reserved_at_1fa[0x2];
+	u8         wqe_based_flow_table_update_cap[0x1];
 	u8         cqe_version[0x4];
 
 	u8         compact_address_vector[0x1];
@@ -1959,7 +2050,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_760[0x3];
 	u8         log_max_num_header_modify_argument[0x5];
-	u8         reserved_at_768[0x4];
+	u8         log_header_modify_argument_granularity_offset[0x4];
 	u8         log_header_modify_argument_granularity[0x4];
 	u8         reserved_at_770[0x3];
 	u8         log_header_modify_argument_max_alloc[0x5];
@@ -2006,7 +2097,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_140[0x60];
 
 	u8	   flow_table_type_2_type[0x8];
-	u8	   reserved_at_1a8[0x3];
+	u8	   reserved_at_1a8[0x2];
+	u8         format_select_dw_8_6_ext[0x1];
 	u8	   log_min_mkey_entity_size[0x5];
 	u8	   reserved_at_1b0[0x10];
 
@@ -2022,6 +2114,16 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_250[0x10];
 
 	u8	   reserved_at_260[0x120];
+
+	u8	   format_select_dw_gtpu_dw_0[0x8];
+	u8	   format_select_dw_gtpu_dw_1[0x8];
+	u8	   format_select_dw_gtpu_dw_2[0x8];
+	u8	   format_select_dw_gtpu_first_ext_dw_0[0x8];
+
+	u8	   generate_wqe_type[0x20];
+
+	u8	   reserved_at_2c0[0xc0];
+
 	u8	   reserved_at_380[0xb];
 	u8	   min_mkey_log_entity_size_fixed_buffer[0x5];
 	u8	   ec_vf_vport_base[0x10];
@@ -2037,9 +2139,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 
 	u8	   reserved_at_400[0x1];
 	u8	   min_mkey_log_entity_size_fixed_buffer_valid[0x1];
-	u8	   reserved_at_402[0x1e];
+	u8	   reserved_at_402[0xe];
+	u8	   return_reg_id[0x10];
 
-	u8	   reserved_at_420[0x20];
+	u8	   reserved_at_420[0x1c];
+	u8	   flow_table_hash_type[0x4];
 
 	u8	   reserved_at_440[0x8];
 	u8	   max_num_eqs_24b[0x18];
@@ -2086,7 +2190,7 @@ struct mlx5_ifc_extended_dest_format_bits {
 	u8         reserved_at_60[0x20];
 };
 
-union mlx5_ifc_dest_format_struct_flow_counter_list_auto_bits {
+union mlx5_ifc_dest_format_flow_counter_list_auto_bits {
 	struct mlx5_ifc_extended_dest_format_bits extended_dest_format;
 	struct mlx5_ifc_flow_counter_list_bits flow_counter_list;
 };
@@ -2178,7 +2282,10 @@ struct mlx5_ifc_wq_bits {
 	u8         reserved_at_139[0x4];
 	u8         log_wqe_stride_size[0x3];
 
-	u8         reserved_at_140[0x80];
+	u8         dbr_umem_id[0x20];
+	u8         wq_umem_id[0x20];
+
+	u8         wq_umem_offset[0x40];
 
 	u8         headers_mkey[0x20];
 
@@ -3562,6 +3669,8 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_per_protocol_networking_offload_caps_bits per_protocol_networking_offload_caps;
 	struct mlx5_ifc_flow_table_nic_cap_bits flow_table_nic_cap;
 	struct mlx5_ifc_flow_table_eswitch_cap_bits flow_table_eswitch_cap;
+	struct mlx5_ifc_wqe_based_flow_table_cap_bits wqe_based_flow_table_cap;
+	struct mlx5_ifc_esw_cap_bits esw_cap;
 	struct mlx5_ifc_e_switch_cap_bits e_switch_cap;
 	struct mlx5_ifc_port_selection_cap_bits port_selection_cap;
 	struct mlx5_ifc_qos_cap_bits qos_cap;
@@ -3678,7 +3787,7 @@ struct mlx5_ifc_flow_context_bits {
 
 	u8         reserved_at_1300[0x500];
 
-	union mlx5_ifc_dest_format_struct_flow_counter_list_auto_bits destination[];
+	union mlx5_ifc_dest_format_flow_counter_list_auto_bits destination[];
 };
 
 enum {
@@ -3919,7 +4028,8 @@ struct mlx5_ifc_sqc_bits {
 	u8         reg_umr[0x1];
 	u8         allow_swp[0x1];
 	u8         hairpin[0x1];
-	u8         reserved_at_f[0xb];
+	u8         non_wire[0x1];
+	u8         reserved_at_10[0xa];
 	u8	   ts_format[0x2];
 	u8	   reserved_at_1c[0x4];
 
@@ -4961,6 +5071,16 @@ struct mlx5_ifc_set_fte_in_bits {
 	struct mlx5_ifc_flow_context_bits flow_context;
 };
 
+struct mlx5_ifc_dest_format_bits {
+	u8         destination_type[0x8];
+	u8         destination_id[0x18];
+
+	u8         destination_eswitch_owner_vhca_id_valid[0x1];
+	u8         packet_reformat[0x1];
+	u8         reserved_at_22[0xe];
+	u8         destination_eswitch_owner_vhca_id[0x10];
+};
+
 struct mlx5_ifc_rts2rts_qp_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -6127,7 +6247,8 @@ struct mlx5_ifc_flow_table_context_bits {
 	u8         termination_table[0x1];
 	u8         table_miss_action[0x4];
 	u8         level[0x8];
-	u8         reserved_at_10[0x8];
+	u8         rtc_valid[0x1];
+	u8         reserved_at_11[0x7];
 	u8         log_size[0x8];
 
 	u8         reserved_at_20[0x8];
@@ -6137,11 +6258,21 @@ struct mlx5_ifc_flow_table_context_bits {
 	u8         lag_master_next_table_id[0x18];
 
 	u8         reserved_at_60[0x60];
+	union {
+		struct {
+			u8         sw_owner_icm_root_1[0x40];
+
+			u8         sw_owner_icm_root_0[0x40];
+		} sws;
+		struct {
+			u8         rtc_id_0[0x20];
 
-	u8         sw_owner_icm_root_1[0x40];
+			u8         rtc_id_1[0x20];
 
-	u8         sw_owner_icm_root_0[0x40];
+			u8         reserved_at_100[0x40];
 
+		} hws;
+	};
 };
 
 struct mlx5_ifc_query_flow_table_out_bits {
@@ -8923,7 +9054,9 @@ struct mlx5_ifc_create_qp_in_bits {
 
 	struct mlx5_ifc_qpc_bits qpc;
 
-	u8         reserved_at_800[0x60];
+	u8         wq_umem_offset[0x40];
+
+	u8         wq_umem_id[0x20];
 
 	u8         wq_umem_valid[0x1];
 	u8         reserved_at_861[0x1f];
-- 
2.46.0


