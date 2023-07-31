Return-Path: <netdev+bounces-22790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A77694CB
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FC42815FE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9201800D;
	Mon, 31 Jul 2023 11:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2618016
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28B3C433C7;
	Mon, 31 Jul 2023 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802914;
	bh=a2b7y3jwDJBHxP3Nwz9b9O2lbE4PY6IpxDDjwH4Wn4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc2kg+h98Z83mTMbciQogEVBYaEYCHCeQIwHCUcGxNj9R6eZGQe+8Djv6CKdnM3xm
	 LYeEDcxhB9nBjaUnNCxooNHUwcNPB6eS7v4T4FTvD1xbCWsuo/Y+Blrw0o5Y+nafCw
	 XUXCmG9Xir4dkWxHI87x7XhC9vB1T3sSmF83OKxIS42vbp+2W3/LqGqUALtvbEezkT
	 QjjrQ6cOQClbbh2hVLst/u2qOiDqf6sq+YcaEvhyOgRkGnzsl3GTL0bsmLcNizrEq6
	 ZQ2YhLnsZasyp1HB2RrgYw9oYptp6CbgKhXWR0bustFBU3lZ3hXkYHGNF/AFDSikr7
	 cRpXaNQ/4W6jQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 01/13] net/mlx5e: Add function to get IPsec offload namespace
Date: Mon, 31 Jul 2023 14:28:12 +0300
Message-ID: <ac2982c34f1ed3288d4670cacfd7e1b87a8c96d9.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Add function to get namespace in different directions. It will be
extended for switchdev mode in later patch, but no functionality change
for now.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 47baf983147f..7ec92f0cf1bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -814,11 +814,20 @@ static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upsp
 	}
 }
 
-static int setup_modify_header(struct mlx5_core_dev *mdev, u32 val, u8 dir,
+static enum mlx5_flow_namespace_type ipsec_fs_get_ns(struct mlx5e_ipsec *ipsec, u8 dir)
+{
+	if (dir == XFRM_DEV_OFFLOAD_IN)
+		return MLX5_FLOW_NAMESPACE_KERNEL;
+
+	return MLX5_FLOW_NAMESPACE_EGRESS;
+}
+
+static int setup_modify_header(struct mlx5e_ipsec *ipsec, u32 val, u8 dir,
 			       struct mlx5_flow_act *flow_act)
 {
+	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, dir);
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
-	enum mlx5_flow_namespace_type ns_type;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_modify_hdr *modify_hdr;
 
 	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
@@ -826,12 +835,10 @@ static int setup_modify_header(struct mlx5_core_dev *mdev, u32 val, u8 dir,
 	case XFRM_DEV_OFFLOAD_IN:
 		MLX5_SET(set_action_in, action, field,
 			 MLX5_ACTION_IN_FIELD_METADATA_REG_B);
-		ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
 		MLX5_SET(set_action_in, action, field,
 			 MLX5_ACTION_IN_FIELD_METADATA_REG_C_0);
-		ns_type = MLX5_FLOW_NAMESPACE_EGRESS;
 		break;
 	default:
 		return -EINVAL;
@@ -1024,26 +1031,16 @@ setup_pkt_transport_reformat(struct mlx5_accel_esp_xfrm_attrs *attrs,
 	return 0;
 }
 
-static int setup_pkt_reformat(struct mlx5_core_dev *mdev,
+static int setup_pkt_reformat(struct mlx5e_ipsec *ipsec,
 			      struct mlx5_accel_esp_xfrm_attrs *attrs,
 			      struct mlx5_flow_act *flow_act)
 {
+	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, attrs->dir);
 	struct mlx5_pkt_reformat_params reformat_params = {};
+	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_pkt_reformat *pkt_reformat;
-	enum mlx5_flow_namespace_type ns_type;
 	int ret;
 
-	switch (attrs->dir) {
-	case XFRM_DEV_OFFLOAD_IN:
-		ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
-		break;
-	case XFRM_DEV_OFFLOAD_OUT:
-		ns_type = MLX5_FLOW_NAMESPACE_EGRESS;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	switch (attrs->mode) {
 	case XFRM_MODE_TRANSPORT:
 		ret = setup_pkt_transport_reformat(attrs, &reformat_params);
@@ -1101,14 +1098,14 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	setup_fte_esp(spec);
 	setup_fte_no_frags(spec);
 
-	err = setup_modify_header(mdev, sa_entry->ipsec_obj_id | BIT(31),
+	err = setup_modify_header(ipsec, sa_entry->ipsec_obj_id | BIT(31),
 				  XFRM_DEV_OFFLOAD_IN, &flow_act);
 	if (err)
 		goto err_mod_header;
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_PACKET:
-		err = setup_pkt_reformat(mdev, attrs, &flow_act);
+		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
 		break;
@@ -1202,7 +1199,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	case XFRM_DEV_OFFLOAD_PACKET:
 		if (attrs->reqid)
 			setup_fte_reg_c0(spec, attrs->reqid);
-		err = setup_pkt_reformat(mdev, attrs, &flow_act);
+		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
 		break;
@@ -1259,15 +1256,16 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 {
 	struct mlx5_accel_pol_xfrm_attrs *attrs = &pol_entry->attrs;
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_pol2dev(pol_entry);
-	struct mlx5e_ipsec_tx *tx = pol_entry->ipsec->tx;
+	struct mlx5e_ipsec *ipsec = pol_entry->ipsec;
 	struct mlx5_flow_destination dest[2] = {};
+	struct mlx5e_ipsec_tx *tx = ipsec->tx;
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	struct mlx5_flow_table *ft;
 	int err, dstn = 0;
 
-	ft = tx_ft_get_policy(mdev, pol_entry->ipsec, attrs->prio);
+	ft = tx_ft_get_policy(mdev, ipsec, attrs->prio);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 
@@ -1291,7 +1289,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		if (!attrs->reqid)
 			break;
 
-		err = setup_modify_header(mdev, attrs->reqid,
+		err = setup_modify_header(ipsec, attrs->reqid,
 					  XFRM_DEV_OFFLOAD_OUT, &flow_act);
 		if (err)
 			goto err_mod_header;
@@ -1331,7 +1329,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 err_mod_header:
 	kvfree(spec);
 err_alloc:
-	tx_ft_put_policy(pol_entry->ipsec, attrs->prio);
+	tx_ft_put_policy(ipsec, attrs->prio);
 	return err;
 }
 
-- 
2.41.0


