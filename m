Return-Path: <netdev+bounces-35386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C119E7A9417
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77381C20970
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B44B65C;
	Thu, 21 Sep 2023 12:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A2B64B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468E4C4E667;
	Thu, 21 Sep 2023 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695298258;
	bh=P72h0L+ZVrn+TdGMG16f/UywYyrtaoYrOTrlMxfbBqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8I/ZWsbjX++7ZXIiIjLxlStjroC7Jm97O0P5DS04/X63ynTw6MfOGXfgaw+jhvd4
	 aC/ebMcMfBI4MJHHU4yJ5nZbGBEgr0ZrjzHKOkmTvtxOPKQJuZf2mFzNhRpXe4QUrQ
	 0fUVUzU5rexyty3+Jci/Uy8j+wA6TvEuq6PiK/iplNxIVDNjoJqfgWRQsvYKu7JQW9
	 BWa2rf9Q6AwQIjhUDVzljpypailTRWoQ9/H/6C0n32p+ERnAxXJhSgN2M1IEOrZEz5
	 xvvSjzYR9ako4d7xl9OT7ihSP5jPzeVh4VRLdZR5QXml/bD1idCMQvFq/HEvOGuOSj
	 7jGdJzwfFBcBw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 4/9] net/mlx5: Add alias flow table bits
Date: Thu, 21 Sep 2023 15:10:30 +0300
Message-ID: <544c030f2a78c4adf3fe6b64f97a39cc1bbdabb9.1695296682.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add all the capabilities needed to check for alias object support.
As well as all the fields or commands needed for its creation and
the creation of flow table that is able to jump to an alias object.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 56 ++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index dd8421d021cf..2b5ae4192de4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -312,6 +312,7 @@ enum {
 	MLX5_CMD_OP_QUERY_VHCA_STATE              = 0xb0d,
 	MLX5_CMD_OP_MODIFY_VHCA_STATE             = 0xb0e,
 	MLX5_CMD_OP_SYNC_CRYPTO                   = 0xb12,
+	MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS       = 0xb16,
 	MLX5_CMD_OP_MAX
 };
 
@@ -1934,6 +1935,14 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         match_definer_format_supported[0x40];
 };
 
+enum {
+	MLX5_CROSS_VHCA_OBJ_TO_OBJ_SUPPORTED_LOCAL_FLOW_TABLE_TO_REMOTE_FLOW_TABLE_MISS  = 0x80000,
+};
+
+enum {
+	MLX5_ALLOWED_OBJ_FOR_OTHER_VHCA_ACCESS_FLOW_TABLE       = 0x200,
+};
+
 struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_0[0x80];
 
@@ -1950,7 +1959,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   migration_tracking_state[0x1];
 	u8	   reserved_at_ca[0x16];
 
-	u8	   reserved_at_e0[0xc0];
+	u8         cross_vhca_object_to_object_supported[0x20];
+
+	u8         allowed_object_for_other_vhca_access[0x40];
+
+	u8	   reserved_at_140[0x60];
 
 	u8	   flow_table_type_2_type[0x8];
 	u8	   reserved_at_1a8[0x3];
@@ -6369,6 +6382,28 @@ struct mlx5_ifc_general_obj_out_cmd_hdr_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_allow_other_vhca_access_in_bits {
+	u8 opcode[0x10];
+	u8 uid[0x10];
+	u8 reserved_at_20[0x10];
+	u8 op_mod[0x10];
+	u8 reserved_at_40[0x50];
+	u8 object_type_to_be_accessed[0x10];
+	u8 object_id_to_be_accessed[0x20];
+	u8 reserved_at_c0[0x40];
+	union {
+		u8 access_key_raw[0x100];
+		u8 access_key[8][0x20];
+	};
+};
+
+struct mlx5_ifc_allow_other_vhca_access_out_bits {
+	u8 status[0x8];
+	u8 reserved_at_8[0x18];
+	u8 syndrome[0x20];
+	u8 reserved_at_40[0x40];
+};
+
 struct mlx5_ifc_modify_header_arg_bits {
 	u8         reserved_at_0[0x80];
 
@@ -6391,6 +6426,24 @@ struct mlx5_ifc_create_match_definer_out_bits {
 	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
 };
 
+struct mlx5_ifc_alias_context_bits {
+	u8 vhca_id_to_be_accessed[0x10];
+	u8 reserved_at_10[0xd];
+	u8 status[0x3];
+	u8 object_id_to_be_accessed[0x20];
+	u8 reserved_at_40[0x40];
+	union {
+		u8 access_key_raw[0x100];
+		u8 access_key[8][0x20];
+	};
+	u8 metadata[0x80];
+};
+
+struct mlx5_ifc_create_alias_obj_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
+	struct mlx5_ifc_alias_context_bits alias_ctx;
+};
+
 enum {
 	MLX5_QUERY_FLOW_GROUP_OUT_MATCH_CRITERIA_ENABLE_OUTER_HEADERS    = 0x0,
 	MLX5_QUERY_FLOW_GROUP_OUT_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS  = 0x1,
@@ -11919,6 +11972,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
+	MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS = 0xff15,
 };
 
 enum {
-- 
2.41.0


