Return-Path: <netdev+bounces-57177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456E8124FF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F2128252D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227E803;
	Thu, 14 Dec 2023 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/h7B8zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6C7FD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE8BC433C8;
	Thu, 14 Dec 2023 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519721;
	bh=5wLmtHkhVZj8Q+G6EAgk0gdVv61OwWBpSTrut/1FVO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/h7B8zhOkEHFwG6rSekqsgTZLsAeVQSGxbI4eBtFtCt75bZrwAUdsRKuvYV0bj2B
	 +6fcFoP4w2YyJHYn2/sb5hGY34F1aylcERtcP3NPRBOhToiBbXrbAm2g6BQMXKB2vc
	 9+8swB+Om0ay4XZxXhtIKRliWNU5SrgS3x4+w7NfAjcg2RYYMcBYGEg9jc6ZM6fMvs
	 gVyCwI/71hJ9ZnNZCtOkEkdbV3P2gjSR8TovFupW+CDqvXAZ1isjCZZRkl+fK8N4fU
	 PFKJhTUzSG4q6u+lXjdqAJGUhtx2DSBSweq3/i9uG5Jadq7595AZKDJaL1SrttfKXS
	 ri56GpfLZ924Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 01/11] net/mlx5: Add mlx5_ifc bits used for supporting single netdev Socket-Direct
Date: Wed, 13 Dec 2023 18:08:22 -0800
Message-ID: <20231214020832.50703-2-saeed@kernel.org>
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

Multiple device caps and features are required to support
single netdev Socket-Direct.
Add them here in preparation for the feature implementation.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index ce2e71cd6d2a..405d141b4a08 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -435,7 +435,7 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 	u8         flow_table_modify[0x1];
 	u8         reformat[0x1];
 	u8         decap[0x1];
-	u8         reserved_at_9[0x1];
+	u8         reset_root_to_default[0x1];
 	u8         pop_vlan[0x1];
 	u8         push_vlan[0x1];
 	u8         reserved_at_c[0x1];
@@ -1801,7 +1801,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         disable_local_lb_uc[0x1];
 	u8         disable_local_lb_mc[0x1];
 	u8         log_min_hairpin_wq_data_sz[0x5];
-	u8         reserved_at_3e8[0x2];
+	u8         reserved_at_3e8[0x1];
+	u8         silent_mode[0x1];
 	u8         vhca_state[0x1];
 	u8         log_max_vlan_list[0x5];
 	u8         reserved_at_3f0[0x3];
@@ -1818,7 +1819,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_460[0x1];
 	u8         ats[0x1];
-	u8         reserved_at_462[0x1];
+	u8         cross_vhca_rqt[0x1];
 	u8         log_max_uctx[0x5];
 	u8         reserved_at_468[0x1];
 	u8         crypto[0x1];
@@ -1943,6 +1944,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 enum {
 	MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS  = 0x80000,
+	MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_ROOT_TO_REMOTE_FLOW_TABLE  = (1ULL << 20),
 };
 
 enum {
@@ -1992,7 +1994,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_260[0x120];
 	u8	   reserved_at_380[0x10];
 	u8	   ec_vf_vport_base[0x10];
-	u8	   reserved_at_3a0[0x460];
+
+	u8	   reserved_at_3a0[0x10];
+	u8	   max_rqt_vhca_id[0x10];
+
+	u8	   reserved_at_3c0[0x440];
 };
 
 enum mlx5_ifc_flow_destination_type {
@@ -2151,6 +2157,13 @@ struct mlx5_ifc_rq_num_bits {
 	u8         rq_num[0x18];
 };
 
+struct mlx5_ifc_rq_vhca_bits {
+	u8         reserved_at_0[0x8];
+	u8         rq_num[0x18];
+	u8         reserved_at_20[0x10];
+	u8         rq_vhca_id[0x10];
+};
+
 struct mlx5_ifc_mac_address_layout_bits {
 	u8         reserved_at_0[0x10];
 	u8         mac_addr_47_32[0x10];
@@ -3901,7 +3914,10 @@ struct mlx5_ifc_rqtc_bits {
 
 	u8    reserved_at_e0[0x6a0];
 
-	struct mlx5_ifc_rq_num_bits rq_num[];
+	union {
+		DECLARE_FLEX_ARRAY(struct mlx5_ifc_rq_num_bits, rq_num);
+		DECLARE_FLEX_ARRAY(struct mlx5_ifc_rq_vhca_bits, rq_vhca);
+	};
 };
 
 enum {
@@ -4744,7 +4760,10 @@ struct mlx5_ifc_set_l2_table_entry_in_bits {
 
 	u8         reserved_at_c0[0x20];
 
-	u8         reserved_at_e0[0x13];
+	u8         reserved_at_e0[0x10];
+	u8         silent_mode_valid[0x1];
+	u8         silent_mode[0x1];
+	u8         reserved_at_f2[0x1];
 	u8         vlan_valid[0x1];
 	u8         vlan[0xc];
 
-- 
2.43.0


