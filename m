Return-Path: <netdev+bounces-53776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7A8049D9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FA81C20DAA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0803DDDF;
	Tue,  5 Dec 2023 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+oJ05cN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0810958
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E63C433C9;
	Tue,  5 Dec 2023 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756822;
	bh=r2rqm1uggNDu9X1XBjCuF8rR41EF5hXmLTVLnHI/bco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+oJ05cN7GxbYGjRONvHkqMEDtNhAEbc13PfS3G3ODBy4al8SbZPjo8ez7Y/GU9Ce
	 PzJcTtdHxTDkxtT+X98jmsMGxxBpvA4wFwtQDTATeoalzFzsoA2oUAfQsP0ox8rJ91
	 R1qZRbOP+nFe/jB9fdv1x4Tr8zCwUwIyUfbYzfo/l9Z+5BvZB4qXP3hJc8UwpFAhZM
	 G9X75tsqEEBQFikWx6s+LVRoMWeIdHbu+RySWG7OIlL5jQN+c7QUIJJHSuIFrycVmU
	 Gu+JtAtvPqSnAVhkDatwudKMoLb7xgEE+am1qzJ9hr6C3tsZFpHn+/5vzn65hdt5GK
	 hkz66X6Z/0MQQ==
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
Subject: [net V2 03/14] net/mlx5e: Unify esw and normal IPsec status table creation/destruction
Date: Mon,  4 Dec 2023 22:13:16 -0800
Message-ID: <20231205061327.44638-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205061327.44638-1-saeed@kernel.org>
References: <20231205061327.44638-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Change normal IPsec flow to use the same creation/destruction functions
for status flow table as that of ESW, which first of all refines the
code to have less code duplication.

And more importantly, the ESW status table handles IPsec syndrome
checks at steering by HW, which is more efficient than the previous
behaviour we had where it was copied to WQE meta data and checked
by the driver.

Fixes: 1762f132d542 ("net/mlx5e: Support IPsec packet offload for RX in switchdev mode")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 187 +++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 152 --------------
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  15 --
 3 files changed, 141 insertions(+), 213 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index f41c976dc33f..85ed5171e835 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -128,63 +128,166 @@ static struct mlx5_flow_table *ipsec_ft_create(struct mlx5_flow_namespace *ns,
 	return mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 }
 
-static int ipsec_status_rule(struct mlx5_core_dev *mdev,
-			     struct mlx5e_ipsec_rx *rx,
-			     struct mlx5_flow_destination *dest)
+static void ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
 {
-	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	mlx5_del_flow_rules(rx->status_drop.rule);
+	mlx5_destroy_flow_group(rx->status_drop.group);
+	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
+}
+
+static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	mlx5_del_flow_rules(rx->status.rule);
+
+	if (rx != ipsec->rx_esw)
+		return;
+
+#ifdef CONFIG_MLX5_ESWITCH
+	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
+#endif
+}
+
+static int ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5_modify_hdr *modify_hdr;
-	struct mlx5_flow_handle *fte;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *flow_counter;
 	struct mlx5_flow_spec *spec;
-	int err;
+	struct mlx5_flow_group *g;
+	u32 *flow_group_in;
+	int err = 0;
 
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
+	if (!flow_group_in || !spec) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
-	/* Action to copy 7 bit ipsec_syndrome to regB[24:30] */
-	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
-	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME);
-	MLX5_SET(copy_action_in, action, src_offset, 0);
-	MLX5_SET(copy_action_in, action, length, 7);
-	MLX5_SET(copy_action_in, action, dst_field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
-	MLX5_SET(copy_action_in, action, dst_offset, 24);
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
+	g = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop flow group, err=%d\n", err);
+		goto err_out;
+	}
 
-	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL,
-					      1, action);
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt;
+	}
 
-	if (IS_ERR(modify_hdr)) {
-		err = PTR_ERR(modify_hdr);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
 		mlx5_core_err(mdev,
-			      "fail to alloc ipsec copy modify_header_id err=%d\n", err);
-		goto out_spec;
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule;
 	}
 
-	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
-			  MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+	rx->status_drop.group = g;
+	rx->status_drop.rule = rule;
+	rx->status_drop_cnt = flow_counter;
+
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return 0;
+
+err_rule:
+	mlx5_fc_destroy(mdev, flow_counter);
+err_cnt:
+	mlx5_destroy_flow_group(g);
+err_out:
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return err;
+}
+
+static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int err;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.ipsec_syndrome, 0);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	flow_act.flags = FLOW_ACT_NO_APPEND;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	flow_act.modify_hdr = modify_hdr;
-	fte = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
-	if (IS_ERR(fte)) {
-		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add ipsec rx err copy rule err=%d\n", err);
-		goto out;
+	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_warn(ipsec->mdev,
+			       "Failed to add ipsec rx status pass rule, err=%d\n", err);
+		goto err_rule;
 	}
 
+	rx->status.rule = rule;
 	kvfree(spec);
-	rx->status.rule = fte;
-	rx->status.modify_hdr = modify_hdr;
 	return 0;
 
-out:
-	mlx5_modify_header_dealloc(mdev, modify_hdr);
-out_spec:
+err_rule:
 	kvfree(spec);
 	return err;
 }
 
+static void mlx5_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	ipsec_rx_status_pass_destroy(ipsec, rx);
+	ipsec_rx_status_drop_destroy(ipsec, rx);
+}
+
+static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5_flow_destination *dest)
+{
+	int err;
+
+	err = ipsec_rx_status_drop_create(ipsec, rx);
+	if (err)
+		return err;
+
+	err = ipsec_rx_status_pass_create(ipsec, rx, dest);
+	if (err)
+		goto err_pass_create;
+
+	return 0;
+
+err_pass_create:
+	ipsec_rx_status_drop_destroy(ipsec, rx);
+	return err;
+}
+
 static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 			     struct mlx5_flow_table *ft,
 			     struct mlx5e_ipsec_miss *miss,
@@ -333,12 +436,7 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_destroy_flow_table(rx->ft.sa);
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	if (rx == ipsec->rx_esw) {
-		mlx5_esw_ipsec_rx_status_destroy(ipsec, rx);
-	} else {
-		mlx5_del_flow_rules(rx->status.rule);
-		mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
-	}
+	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 	mlx5_destroy_flow_table(rx->ft.status);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
@@ -428,10 +526,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter_id = mlx5_fc_id(rx->fc->cnt);
-	if (rx == ipsec->rx_esw)
-		err = mlx5_esw_ipsec_rx_status_create(ipsec, rx, dest);
-	else
-		err = ipsec_status_rule(mdev, rx, dest);
+	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
 	if (err)
 		goto err_add;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 095f31f380fa..13b5916b64e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -21,158 +21,6 @@ enum {
 	MLX5_ESW_IPSEC_TX_ESP_FT_CNT_LEVEL,
 };
 
-static void esw_ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
-					     struct mlx5e_ipsec_rx *rx)
-{
-	mlx5_del_flow_rules(rx->status_drop.rule);
-	mlx5_destroy_flow_group(rx->status_drop.group);
-	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
-}
-
-static void esw_ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
-					     struct mlx5e_ipsec_rx *rx)
-{
-	mlx5_del_flow_rules(rx->status.rule);
-	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
-}
-
-static int esw_ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
-					   struct mlx5e_ipsec_rx *rx)
-{
-	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
-	struct mlx5_flow_table *ft = rx->ft.status;
-	struct mlx5_core_dev *mdev = ipsec->mdev;
-	struct mlx5_flow_destination dest = {};
-	struct mlx5_flow_act flow_act = {};
-	struct mlx5_flow_handle *rule;
-	struct mlx5_fc *flow_counter;
-	struct mlx5_flow_spec *spec;
-	struct mlx5_flow_group *g;
-	u32 *flow_group_in;
-	int err = 0;
-
-	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
-	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!flow_group_in || !spec) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
-	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
-	g = mlx5_create_flow_group(ft, flow_group_in);
-	if (IS_ERR(g)) {
-		err = PTR_ERR(g);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop flow group, err=%d\n", err);
-		goto err_out;
-	}
-
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
-		err = PTR_ERR(flow_counter);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
-		goto err_cnt;
-	}
-
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(flow_counter);
-	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
-	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
-		goto err_rule;
-	}
-
-	rx->status_drop.group = g;
-	rx->status_drop.rule = rule;
-	rx->status_drop_cnt = flow_counter;
-
-	kvfree(flow_group_in);
-	kvfree(spec);
-	return 0;
-
-err_rule:
-	mlx5_fc_destroy(mdev, flow_counter);
-err_cnt:
-	mlx5_destroy_flow_group(g);
-err_out:
-	kvfree(flow_group_in);
-	kvfree(spec);
-	return err;
-}
-
-static int esw_ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
-					   struct mlx5e_ipsec_rx *rx,
-					   struct mlx5_flow_destination *dest)
-{
-	struct mlx5_flow_act flow_act = {};
-	struct mlx5_flow_handle *rule;
-	struct mlx5_flow_spec *spec;
-	int err;
-
-	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
-
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-			 misc_parameters_2.ipsec_syndrome);
-	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.ipsec_syndrome, 0);
-	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
-	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
-	flow_act.flags = FLOW_ACT_NO_APPEND;
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		mlx5_core_warn(ipsec->mdev,
-			       "Failed to add ipsec rx status pass rule, err=%d\n", err);
-		goto err_rule;
-	}
-
-	rx->status.rule = rule;
-	kvfree(spec);
-	return 0;
-
-err_rule:
-	kvfree(spec);
-	return err;
-}
-
-void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-				      struct mlx5e_ipsec_rx *rx)
-{
-	esw_ipsec_rx_status_pass_destroy(ipsec, rx);
-	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
-}
-
-int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-				    struct mlx5e_ipsec_rx *rx,
-				    struct mlx5_flow_destination *dest)
-{
-	int err;
-
-	err = esw_ipsec_rx_status_drop_create(ipsec, rx);
-	if (err)
-		return err;
-
-	err = esw_ipsec_rx_status_pass_create(ipsec, rx, dest);
-	if (err)
-		goto err_pass_create;
-
-	return 0;
-
-err_pass_create:
-	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
-	return err;
-}
-
 void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx_create_attr *attr)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index 0c90f7a8b0d3..ac9c65b89166 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -8,11 +8,6 @@ struct mlx5e_ipsec;
 struct mlx5e_ipsec_sa_entry;
 
 #ifdef CONFIG_MLX5_ESWITCH
-void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-				      struct mlx5e_ipsec_rx *rx);
-int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-				    struct mlx5e_ipsec_rx *rx,
-				    struct mlx5_flow_destination *dest);
 void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx_create_attr *attr);
 int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
@@ -26,16 +21,6 @@ void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
 void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
 #else
-static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-						    struct mlx5e_ipsec_rx *rx) {}
-
-static inline int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-						  struct mlx5e_ipsec_rx *rx,
-						  struct mlx5_flow_destination *dest)
-{
-	return  -EINVAL;
-}
-
 static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_rx_create_attr *attr) {}
 
-- 
2.43.0


