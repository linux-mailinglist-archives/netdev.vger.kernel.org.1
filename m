Return-Path: <netdev+bounces-49874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0B7F3B75
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BDDB21B16
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138A5386;
	Wed, 22 Nov 2023 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvk4v+pb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D0882F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7FAC433C8;
	Wed, 22 Nov 2023 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617690;
	bh=oxatphgwWETMm1GPRNkVKMbI39/BUoEv4HUI1KJiL+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvk4v+pbH8ASvvPNA/fS6WQTLK2So3pTPtcM8TvooggugISMadDEgEgt/otEuUurl
	 UohrZexpuinXGV2+iKbCfajNpr3k/vGl9Lw5cIweb8IuSaTwATM3pj6HeH/Yis/TUW
	 dj5SKjWW6Uqxm/+SDbElutwvhehdpAIpLtc+7Zy95Auz6a4qs7VINB4liwUr+Iv8v4
	 tFenG/nGKBp312z1GTYLbhdPycyhoKV0GjBZ2LWVRqHbcsATIL79RQFP8Zi1UTL75o
	 8QomlRv00jQN9XqCb5W87SaCHPLw+2jHkwz1ToklQXIstGm4VSQ5g8V9RxSZAM/hVc
	 kcpGOrR1IwuMA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 05/15] net/mlx5e: Add IPsec and ASO syndromes check in HW
Date: Tue, 21 Nov 2023 17:47:54 -0800
Message-ID: <20231122014804.27716-6-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

After IPsec decryption it isn't enough to only check the IPsec syndrome
but need to also check the ASO syndrome in order to verify that the
operation was actually successful.

Verify that both syndromes are actually zero and in case not drop the
packet and increment the appropriate flow counter for the drop reason.

Fixes: 6b5c45e16e43 ("net/mlx5e: Configure IPsec packet offload flow steering")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   8 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 235 ++++++++++++++++--
 2 files changed, 223 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index c3a40bf11952..adaea3493193 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -189,11 +189,19 @@ struct mlx5e_ipsec_ft {
 	u32 refcnt;
 };
 
+struct mlx5e_ipsec_drop {
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *fc;
+};
+
 struct mlx5e_ipsec_rule {
 	struct mlx5_flow_handle *rule;
 	struct mlx5_modify_hdr *modify_hdr;
 	struct mlx5_pkt_reformat *pkt_reformat;
 	struct mlx5_fc *fc;
+	struct mlx5e_ipsec_drop replay;
+	struct mlx5e_ipsec_drop auth;
+	struct mlx5e_ipsec_drop trailer;
 };
 
 struct mlx5e_ipsec_miss {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index aa74a2422869..aeb399d8dae5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -32,13 +32,17 @@ struct mlx5e_ipsec_tx {
 	u8 allow_tunnel_mode : 1;
 };
 
+struct mlx5e_ipsec_status_checks {
+	struct mlx5_flow_group *drop_all_group;
+	struct mlx5e_ipsec_drop all;
+};
+
 struct mlx5e_ipsec_rx {
 	struct mlx5e_ipsec_ft ft;
 	struct mlx5e_ipsec_miss pol;
 	struct mlx5e_ipsec_miss sa;
 	struct mlx5e_ipsec_rule status;
-	struct mlx5e_ipsec_miss status_drop;
-	struct mlx5_fc *status_drop_cnt;
+	struct mlx5e_ipsec_status_checks status_drops;
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fs_chains *chains;
 	u8 allow_tunnel_mode : 1;
@@ -143,9 +147,9 @@ static struct mlx5_flow_table *ipsec_ft_create(struct mlx5_flow_namespace *ns,
 static void ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
 					 struct mlx5e_ipsec_rx *rx)
 {
-	mlx5_del_flow_rules(rx->status_drop.rule);
-	mlx5_destroy_flow_group(rx->status_drop.group);
-	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
+	mlx5_del_flow_rules(rx->status_drops.all.rule);
+	mlx5_fc_destroy(ipsec->mdev, rx->status_drops.all.fc);
+	mlx5_destroy_flow_group(rx->status_drops.drop_all_group);
 }
 
 static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
@@ -161,8 +165,149 @@ static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 #endif
 }
 
-static int ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
-				       struct mlx5e_ipsec_rx *rx)
+static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *flow_counter;
+	struct mlx5_flow_spec *spec;
+	int err;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	flow_counter = mlx5_fc_create(mdev, true);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt;
+	}
+	sa_entry->ipsec_rule.auth.fc = flow_counter;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_act.flags = FLOW_ACT_NO_APPEND;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.ipsec_syndrome);
+	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 1);
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_2,
+		 sa_entry->ipsec_obj_id | BIT(31));
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule;
+	}
+	sa_entry->ipsec_rule.auth.rule = rule;
+
+	flow_counter = mlx5_fc_create(mdev, true);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt_2;
+	}
+	sa_entry->ipsec_rule.trailer.fc = flow_counter;
+
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 2);
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule_2;
+	}
+	sa_entry->ipsec_rule.trailer.rule = rule;
+
+	kvfree(spec);
+	return 0;
+
+err_rule_2:
+	mlx5_fc_destroy(mdev, sa_entry->ipsec_rule.trailer.fc);
+err_cnt_2:
+	mlx5_del_flow_rules(sa_entry->ipsec_rule.auth.rule);
+err_rule:
+	mlx5_fc_destroy(mdev, sa_entry->ipsec_rule.auth.fc);
+err_cnt:
+	kvfree(spec);
+	return err;
+}
+
+static int rx_add_rule_drop_replay(struct mlx5e_ipsec_sa_entry *sa_entry, struct mlx5e_ipsec_rx *rx)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *flow_counter;
+	struct mlx5_flow_spec *spec;
+	int err;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	flow_counter = mlx5_fc_create(mdev, true);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt;
+	}
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_act.flags = FLOW_ACT_NO_APPEND;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_4);
+	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_c_4, 1);
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
+	MLX5_SET(fte_match_param, spec->match_value,  misc_parameters_2.metadata_reg_c_2,
+		 sa_entry->ipsec_obj_id | BIT(31));
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule;
+	}
+
+	sa_entry->ipsec_rule.replay.rule = rule;
+	sa_entry->ipsec_rule.replay.fc = flow_counter;
+
+	kvfree(spec);
+	return 0;
+
+err_rule:
+	mlx5_fc_destroy(mdev, flow_counter);
+err_cnt:
+	kvfree(spec);
+	return err;
+}
+
+static int ipsec_rx_status_drop_all_create(struct mlx5e_ipsec *ipsec,
+					   struct mlx5e_ipsec_rx *rx)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_flow_table *ft = rx->ft.status;
@@ -214,9 +359,9 @@ static int ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
 		goto err_rule;
 	}
 
-	rx->status_drop.group = g;
-	rx->status_drop.rule = rule;
-	rx->status_drop_cnt = flow_counter;
+	rx->status_drops.drop_all_group = g;
+	rx->status_drops.all.rule = rule;
+	rx->status_drops.all.fc = flow_counter;
 
 	kvfree(flow_group_in);
 	kvfree(spec);
@@ -247,8 +392,12 @@ static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
 			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.metadata_reg_c_4);
 	MLX5_SET(fte_match_param, spec->match_value,
 		 misc_parameters_2.ipsec_syndrome, 0);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_4, 0);
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
@@ -285,7 +434,7 @@ static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
 {
 	int err;
 
-	err = ipsec_rx_status_drop_create(ipsec, rx);
+	err = ipsec_rx_status_drop_all_create(ipsec, rx);
 	if (err)
 		return err;
 
@@ -529,7 +678,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
-	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 1, 0);
+	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 3, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft_status;
@@ -1159,29 +1308,48 @@ static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8
 			       struct mlx5_flow_act *flow_act)
 {
 	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, type, dir);
-	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	u8 action[3][MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_modify_hdr *modify_hdr;
+	u8 num_of_actions = 1;
 
-	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
+	MLX5_SET(set_action_in, action[0], action_type, MLX5_ACTION_TYPE_SET);
 	switch (dir) {
 	case XFRM_DEV_OFFLOAD_IN:
-		MLX5_SET(set_action_in, action, field,
+		MLX5_SET(set_action_in, action[0], field,
 			 MLX5_ACTION_IN_FIELD_METADATA_REG_B);
+
+		num_of_actions++;
+		MLX5_SET(set_action_in, action[1], action_type, MLX5_ACTION_TYPE_SET);
+		MLX5_SET(set_action_in, action[1], field, MLX5_ACTION_IN_FIELD_METADATA_REG_C_2);
+		MLX5_SET(set_action_in, action[1], data, val);
+		MLX5_SET(set_action_in, action[1], offset, 0);
+		MLX5_SET(set_action_in, action[1], length, 32);
+
+		if (type == XFRM_DEV_OFFLOAD_CRYPTO) {
+			num_of_actions++;
+			MLX5_SET(set_action_in, action[2], action_type,
+				 MLX5_ACTION_TYPE_SET);
+			MLX5_SET(set_action_in, action[2], field,
+				 MLX5_ACTION_IN_FIELD_METADATA_REG_C_4);
+			MLX5_SET(set_action_in, action[2], data, 0);
+			MLX5_SET(set_action_in, action[2], offset, 0);
+			MLX5_SET(set_action_in, action[2], length, 32);
+		}
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
-		MLX5_SET(set_action_in, action, field,
+		MLX5_SET(set_action_in, action[0], field,
 			 MLX5_ACTION_IN_FIELD_METADATA_REG_C_4);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	MLX5_SET(set_action_in, action, data, val);
-	MLX5_SET(set_action_in, action, offset, 0);
-	MLX5_SET(set_action_in, action, length, 32);
+	MLX5_SET(set_action_in, action[0], data, val);
+	MLX5_SET(set_action_in, action[0], offset, 0);
+	MLX5_SET(set_action_in, action[0], length, 32);
 
-	modify_hdr = mlx5_modify_header_alloc(mdev, ns_type, 1, action);
+	modify_hdr = mlx5_modify_header_alloc(mdev, ns_type, num_of_actions, action);
 	if (IS_ERR(modify_hdr)) {
 		mlx5_core_err(mdev, "Failed to allocate modify_header %ld\n",
 			      PTR_ERR(modify_hdr));
@@ -1479,6 +1647,15 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		mlx5_core_err(mdev, "fail to add RX ipsec rule err=%d\n", err);
 		goto err_add_flow;
 	}
+	if (attrs->type == XFRM_DEV_OFFLOAD_PACKET)
+		err = rx_add_rule_drop_replay(sa_entry, rx);
+	if (err)
+		goto err_add_replay;
+
+	err = rx_add_rule_drop_auth_trailer(sa_entry, rx);
+	if (err)
+		goto err_drop_reason;
+
 	kvfree(spec);
 
 	sa_entry->ipsec_rule.rule = rule;
@@ -1487,6 +1664,13 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	sa_entry->ipsec_rule.pkt_reformat = flow_act.pkt_reformat;
 	return 0;
 
+err_drop_reason:
+	if (sa_entry->ipsec_rule.replay.rule) {
+		mlx5_del_flow_rules(sa_entry->ipsec_rule.replay.rule);
+		mlx5_fc_destroy(mdev, sa_entry->ipsec_rule.replay.fc);
+	}
+err_add_replay:
+	mlx5_del_flow_rules(rule);
 err_add_flow:
 	mlx5_fc_destroy(mdev, counter);
 err_add_cnt:
@@ -1994,6 +2178,17 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	if (ipsec_rule->modify_hdr)
 		mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
+
+	mlx5_del_flow_rules(ipsec_rule->trailer.rule);
+	mlx5_fc_destroy(mdev, ipsec_rule->trailer.fc);
+
+	mlx5_del_flow_rules(ipsec_rule->auth.rule);
+	mlx5_fc_destroy(mdev, ipsec_rule->auth.fc);
+
+	if (ipsec_rule->replay.rule) {
+		mlx5_del_flow_rules(ipsec_rule->replay.rule);
+		mlx5_fc_destroy(mdev, ipsec_rule->replay.fc);
+	}
 	mlx5_esw_ipsec_rx_id_mapping_remove(sa_entry);
 	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
 }
-- 
2.42.0


