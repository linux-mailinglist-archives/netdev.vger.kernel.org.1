Return-Path: <netdev+bounces-16747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73A74EA88
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243EF281404
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3E1800C;
	Tue, 11 Jul 2023 09:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB917FFF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34FBC433C9;
	Tue, 11 Jul 2023 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067767;
	bh=aIpz2EMlQFkGAAESr8rapPy0mdG6SDwpq2hlN0UNf80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3/YL2NmTsetCXTITfffZINPCenQ8pdZsx4hAW0eUbhXpzdvpglDofUg5/rueEmiE
	 eaPR37TyYoXDk9UBWq/cwcjjZdjURk5CRKX+7xIZoUMnDHhP/2QO7kYe9SmT6Uf/6m
	 iG5mJfS/YuCrGeFNFOdJJWvobJNaA5u+qXppxs601Jbhbp5P4SF9Ms2fXU1Vcv2PuJ
	 Vx9dcgoM0I3vkkZ9WBfNeubxec2T85z33Aig6pC4lOksL8ZjZe3nHxzNN3+oGVuQAn
	 j5LPfpId1PBDH+BtjHlvUP14jU4QZ7qH4+Xp8Xl08oNEQ5ibBWsD2AfspK/yHtlZUr
	 hlYfwvOj2+jNw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 01/12] net/mlx5e: Add function to get IPsec offload namespace
Date: Tue, 11 Jul 2023 12:28:59 +0300
Message-ID: <84493f604cd51b2b68f2bdc315c6d658ac6d7a63.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
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
index dbe87bf89c0d..7976469108de 100644
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
@@ -991,26 +998,16 @@ setup_pkt_transport_reformat(struct mlx5_accel_esp_xfrm_attrs *attrs,
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
@@ -1068,14 +1065,14 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
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
@@ -1169,7 +1166,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	case XFRM_DEV_OFFLOAD_PACKET:
 		if (attrs->reqid)
 			setup_fte_reg_c0(spec, attrs->reqid);
-		err = setup_pkt_reformat(mdev, attrs, &flow_act);
+		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
 		break;
@@ -1226,15 +1223,16 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
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
 
@@ -1258,7 +1256,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		if (!attrs->reqid)
 			break;
 
-		err = setup_modify_header(mdev, attrs->reqid,
+		err = setup_modify_header(ipsec, attrs->reqid,
 					  XFRM_DEV_OFFLOAD_OUT, &flow_act);
 		if (err)
 			goto err_mod_header;
@@ -1298,7 +1296,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 err_mod_header:
 	kvfree(spec);
 err_alloc:
-	tx_ft_put_policy(pol_entry->ipsec, attrs->prio);
+	tx_ft_put_policy(ipsec, attrs->prio);
 	return err;
 }
 
-- 
2.41.0


