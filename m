Return-Path: <netdev+bounces-127551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B6B975B90
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653BDB217C5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A31BC06D;
	Wed, 11 Sep 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fydra1iw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A71B791A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085887; cv=none; b=EFcGHC9zKq9xcnywI17kPIIeiIgtVDrqphF46D8j/+QkQBKojBZgFJVHnZOOeuQxTGX0rbn2pF8pe6m3mp39VOW34qV/VUXUwm33GlUPo6yWWfjllnzoVCUwsrUZ2q8fqISVHm2K2ixjnQnIhoHGKrYcccQw2Ast/c6jyE6va1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085887; c=relaxed/simple;
	bh=PrNQgEOhBxFkpEQIEyqw4C46N/04WbeNIrD0kn1Ae6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ0dtbzUHfea+6BQ9e8F+gtXeKlx9lIZZcgpLgSo3Mip8uESGY84rrquPbrMk0sNligf5k9BL4U+hoD+CDRAIRIIMQhTfHUGOkdPrJkqOP2BWj7+GauXp/MnS4ZVqFBbOzSdhP1k1pD2DjbTimx8in0RWVWXzAo2mBykpEgKVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fydra1iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0373EC4CEC0;
	Wed, 11 Sep 2024 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085887;
	bh=PrNQgEOhBxFkpEQIEyqw4C46N/04WbeNIrD0kn1Ae6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fydra1iw8bLgw5K94RVNF1YNXftAFE1wJlEK+J5x/y9mbiSEcVICOuOxuHUihkqbQ
	 6pqgLSvowNIeJyYfp2CD57RvvCAdf8ODFbi6EH6XQKk7cHWlV6gFIaHMF+aIHZ2szW
	 31dvE5CAbfjzIXlUR4utA4egbs/vR8Aj8ZhqAoKGgouJtFGUV+jwIycMbd6p3Ylafi
	 OnuCSW72Fx0rK6ikQQBNRZHbs+ZRqjeHC3qT7FVndMXk8wPGs2Jg8poYovRLovKcLR
	 Fh+F8x1Df3BNnq9GXP2bCOkgiELJJGokuJTMjNjRQgCghfCiOppvFP8B7odjSobhXK
	 wm4QEQF63qEew==
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
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 07/15] net/mlx5: fs, separate action and destination into distinct struct
Date: Wed, 11 Sep 2024 13:17:49 -0700
Message-ID: <20240911201757.1505453-8-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Introduce a dedicated structure to encapsulate flow context, actions,
destination count, and modification mask. This refactoring lays the
groundwork for forthcoming patches that will integrate the NO APPEND
software logic. Future modifications should focus solely on these
specific fields.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/diag/fs_tracepoint.h   |  8 +--
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 60 ++++++++---------
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 56 ++++++++--------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h | 14 ++--
 .../mellanox/mlx5/core/steering/fs_dr.c       | 64 ++++++++++---------
 5 files changed, 104 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
index ddf1b87f1bc0..9aed29fa4900 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
@@ -203,10 +203,10 @@ TRACE_EVENT(mlx5_fs_set_fte,
 			   fs_get_obj(__entry->fg, fte->node.parent);
 			   __entry->group_index = __entry->fg->id;
 			   __entry->index = fte->index;
-			   __entry->action = fte->action.action;
+			   __entry->action = fte->act_dests.action.action;
 			   __entry->mask_enable = __entry->fg->mask.match_criteria_enable;
-			   __entry->flow_tag = fte->flow_context.flow_tag;
-			   __entry->flow_source = fte->flow_context.flow_source;
+			   __entry->flow_tag = fte->act_dests.flow_context.flow_tag;
+			   __entry->flow_source = fte->act_dests.flow_context.flow_source;
 			   memcpy(__entry->mask_outer,
 				  MLX5_ADDR_OF(fte_match_param,
 					       &__entry->fg->mask.match_criteria,
@@ -284,7 +284,7 @@ TRACE_EVENT(mlx5_fs_add_rule,
 	    TP_fast_assign(
 			   __entry->rule = rule;
 			   fs_get_obj(__entry->fte, rule->node.parent);
-			   __entry->index = __entry->fte->dests_size - 1;
+			   __entry->index = __entry->fte->act_dests.dests_size - 1;
 			   __entry->sw_action = rule->sw_action;
 			   memcpy(__entry->destination,
 				  &rule->dest_attr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 9b8599c200e2..1a14f8dd878f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -463,7 +463,7 @@ static int mlx5_set_extended_dest(struct mlx5_core_dev *dev,
 	int num_encap = 0;
 
 	*extended_dest = false;
-	if (!(fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST))
+	if (!(fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST))
 		return 0;
 
 	list_for_each_entry(dst, &fte->node.children, node.list) {
@@ -502,17 +502,17 @@ mlx5_cmd_set_fte_flow_meter(struct fs_fte *fte, void *in_flow_context)
 				   execute_aso[0]);
 	MLX5_SET(execute_aso, execute_aso, valid, 1);
 	MLX5_SET(execute_aso, execute_aso, aso_object_id,
-		 fte->action.exe_aso.object_id);
+		 fte->act_dests.action.exe_aso.object_id);
 
 	exe_aso_ctrl = MLX5_ADDR_OF(execute_aso, execute_aso, exe_aso_ctrl);
 	MLX5_SET(exe_aso_ctrl_flow_meter, exe_aso_ctrl, return_reg_id,
-		 fte->action.exe_aso.return_reg_id);
+		 fte->act_dests.action.exe_aso.return_reg_id);
 	MLX5_SET(exe_aso_ctrl_flow_meter, exe_aso_ctrl, aso_type,
-		 fte->action.exe_aso.type);
+		 fte->act_dests.action.exe_aso.type);
 	MLX5_SET(exe_aso_ctrl_flow_meter, exe_aso_ctrl, init_color,
-		 fte->action.exe_aso.flow_meter.init_color);
+		 fte->act_dests.action.exe_aso.flow_meter.init_color);
 	MLX5_SET(exe_aso_ctrl_flow_meter, exe_aso_ctrl, meter_id,
-		 fte->action.exe_aso.flow_meter.meter_idx);
+		 fte->act_dests.action.exe_aso.flow_meter.meter_idx);
 }
 
 static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
@@ -541,7 +541,7 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	else
 		dst_cnt_size = MLX5_ST_SZ_BYTES(extended_dest_format);
 
-	inlen = MLX5_ST_SZ_BYTES(set_fte_in) + fte->dests_size * dst_cnt_size;
+	inlen = MLX5_ST_SZ_BYTES(set_fte_in) + fte->act_dests.dests_size * dst_cnt_size;
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -553,7 +553,7 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	MLX5_SET(set_fte_in, in, table_id,   ft->id);
 	MLX5_SET(set_fte_in, in, flow_index, fte->index);
 	MLX5_SET(set_fte_in, in, ignore_flow_level,
-		 !!(fte->action.flags & FLOW_ACT_IGNORE_FLOW_LEVEL));
+		 !!(fte->act_dests.action.flags & FLOW_ACT_IGNORE_FLOW_LEVEL));
 
 	MLX5_SET(set_fte_in, in, vport_number, ft->vport);
 	MLX5_SET(set_fte_in, in, other_vport,
@@ -563,23 +563,23 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	MLX5_SET(flow_context, in_flow_context, group_id, group_id);
 
 	MLX5_SET(flow_context, in_flow_context, flow_tag,
-		 fte->flow_context.flow_tag);
+		 fte->act_dests.flow_context.flow_tag);
 	MLX5_SET(flow_context, in_flow_context, flow_source,
-		 fte->flow_context.flow_source);
+		 fte->act_dests.flow_context.flow_source);
 	MLX5_SET(flow_context, in_flow_context, uplink_hairpin_en,
-		 !!(fte->flow_context.flags & FLOW_CONTEXT_UPLINK_HAIRPIN_EN));
+		 !!(fte->act_dests.flow_context.flags & FLOW_CONTEXT_UPLINK_HAIRPIN_EN));
 
 	MLX5_SET(flow_context, in_flow_context, extended_destination,
 		 extended_dest);
 
-	action = fte->action.action;
+	action = fte->act_dests.action.action;
 	if (extended_dest)
 		action &= ~MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
 
 	MLX5_SET(flow_context, in_flow_context, action, action);
 
-	if (!extended_dest && fte->action.pkt_reformat) {
-		struct mlx5_pkt_reformat *pkt_reformat = fte->action.pkt_reformat;
+	if (!extended_dest && fte->act_dests.action.pkt_reformat) {
+		struct mlx5_pkt_reformat *pkt_reformat = fte->act_dests.action.pkt_reformat;
 
 		if (pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_SW) {
 			reformat_id = mlx5_fs_dr_action_get_pkt_reformat_id(pkt_reformat);
@@ -591,46 +591,46 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 				goto err_out;
 			}
 		} else {
-			reformat_id = fte->action.pkt_reformat->id;
+			reformat_id = fte->act_dests.action.pkt_reformat->id;
 		}
 	}
 
 	MLX5_SET(flow_context, in_flow_context, packet_reformat_id, (u32)reformat_id);
 
-	if (fte->action.modify_hdr) {
-		if (fte->action.modify_hdr->owner == MLX5_FLOW_RESOURCE_OWNER_SW) {
+	if (fte->act_dests.action.modify_hdr) {
+		if (fte->act_dests.action.modify_hdr->owner == MLX5_FLOW_RESOURCE_OWNER_SW) {
 			mlx5_core_err(dev, "Can't use SW-owned modify_hdr in FW-owned table\n");
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
 
 		MLX5_SET(flow_context, in_flow_context, modify_header_id,
-			 fte->action.modify_hdr->id);
+			 fte->act_dests.action.modify_hdr->id);
 	}
 
 	MLX5_SET(flow_context, in_flow_context, encrypt_decrypt_type,
-		 fte->action.crypto.type);
+		 fte->act_dests.action.crypto.type);
 	MLX5_SET(flow_context, in_flow_context, encrypt_decrypt_obj_id,
-		 fte->action.crypto.obj_id);
+		 fte->act_dests.action.crypto.obj_id);
 
 	vlan = MLX5_ADDR_OF(flow_context, in_flow_context, push_vlan);
 
-	MLX5_SET(vlan, vlan, ethtype, fte->action.vlan[0].ethtype);
-	MLX5_SET(vlan, vlan, vid, fte->action.vlan[0].vid);
-	MLX5_SET(vlan, vlan, prio, fte->action.vlan[0].prio);
+	MLX5_SET(vlan, vlan, ethtype, fte->act_dests.action.vlan[0].ethtype);
+	MLX5_SET(vlan, vlan, vid, fte->act_dests.action.vlan[0].vid);
+	MLX5_SET(vlan, vlan, prio, fte->act_dests.action.vlan[0].prio);
 
 	vlan = MLX5_ADDR_OF(flow_context, in_flow_context, push_vlan_2);
 
-	MLX5_SET(vlan, vlan, ethtype, fte->action.vlan[1].ethtype);
-	MLX5_SET(vlan, vlan, vid, fte->action.vlan[1].vid);
-	MLX5_SET(vlan, vlan, prio, fte->action.vlan[1].prio);
+	MLX5_SET(vlan, vlan, ethtype, fte->act_dests.action.vlan[1].ethtype);
+	MLX5_SET(vlan, vlan, vid, fte->act_dests.action.vlan[1].vid);
+	MLX5_SET(vlan, vlan, prio, fte->act_dests.action.vlan[1].prio);
 
 	in_match_value = MLX5_ADDR_OF(flow_context, in_flow_context,
 				      match_value);
 	memcpy(in_match_value, &fte->val, sizeof(fte->val));
 
 	in_dests = MLX5_ADDR_OF(flow_context, in_flow_context, destination);
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 		int list_size = 0;
 
 		list_for_each_entry(dst, &fte->node.children, node.list) {
@@ -706,7 +706,7 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 			 list_size);
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		int max_list_size = BIT(MLX5_CAP_FLOWTABLE_TYPE(dev,
 					log_max_flow_counter,
 					ft->type));
@@ -731,8 +731,8 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 			 list_size);
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
-		if (fte->action.exe_aso.type == MLX5_EXE_ASO_FLOW_METER) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
+		if (fte->act_dests.action.exe_aso.type == MLX5_EXE_ASO_FLOW_METER) {
 			mlx5_cmd_set_fte_flow_meter(fte, in_flow_context);
 		} else {
 			err = -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 899d91577a54..57df2a6bcb42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -605,12 +605,12 @@ static void modify_fte(struct fs_fte *fte)
 	dev = get_dev(&fte->node);
 
 	root = find_root(&ft->node);
-	err = root->cmds->update_fte(root, ft, fg, fte->modify_mask, fte);
+	err = root->cmds->update_fte(root, ft, fg, fte->act_dests.modify_mask, fte);
 	if (err)
 		mlx5_core_warn(dev,
 			       "%s can't del rule fg id=%d fte_index=%d\n",
 			       __func__, fg->id, fte->index);
-	fte->modify_mask = 0;
+	fte->act_dests.modify_mask = 0;
 }
 
 static void del_sw_hw_rule(struct fs_node *node)
@@ -628,29 +628,29 @@ static void del_sw_hw_rule(struct fs_node *node)
 	}
 
 	if (rule->dest_attr.type == MLX5_FLOW_DESTINATION_TYPE_COUNTER) {
-		--fte->dests_size;
-		fte->modify_mask |=
+		--fte->act_dests.dests_size;
+		fte->act_dests.modify_mask |=
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION) |
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_FLOW_COUNTERS);
-		fte->action.action &= ~MLX5_FLOW_CONTEXT_ACTION_COUNT;
+		fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_COUNT;
 		goto out;
 	}
 
 	if (rule->dest_attr.type == MLX5_FLOW_DESTINATION_TYPE_PORT) {
-		--fte->dests_size;
-		fte->modify_mask |= BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION);
-		fte->action.action &= ~MLX5_FLOW_CONTEXT_ACTION_ALLOW;
+		--fte->act_dests.dests_size;
+		fte->act_dests.modify_mask |= BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION);
+		fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_ALLOW;
 		goto out;
 	}
 
 	if (is_fwd_dest_type(rule->dest_attr.type)) {
-		--fte->dests_size;
-		--fte->fwd_dests;
+		--fte->act_dests.dests_size;
+		--fte->act_dests.fwd_dests;
 
-		if (!fte->fwd_dests)
-			fte->action.action &=
+		if (!fte->act_dests.fwd_dests)
+			fte->act_dests.action.action &=
 				~MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-		fte->modify_mask |=
+		fte->act_dests.modify_mask |=
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST);
 		goto out;
 	}
@@ -672,7 +672,7 @@ static void del_hw_fte(struct fs_node *node)
 	fs_get_obj(ft, fg->node.parent);
 
 	trace_mlx5_fs_del_fte(fte);
-	WARN_ON(fte->dests_size);
+	WARN_ON(fte->act_dests.dests_size);
 	dev = get_dev(&ft->node);
 	root = find_root(&ft->node);
 	if (node->active) {
@@ -784,8 +784,8 @@ static struct fs_fte *alloc_fte(struct mlx5_flow_table *ft,
 
 	memcpy(fte->val, &spec->match_value, sizeof(fte->val));
 	fte->node.type =  FS_TYPE_FLOW_ENTRY;
-	fte->action = *flow_act;
-	fte->flow_context = spec->flow_context;
+	fte->act_dests.action = *flow_act;
+	fte->act_dests.flow_context = spec->flow_context;
 
 	tree_init_node(&fte->node, del_hw_fte, del_sw_fte);
 
@@ -1116,7 +1116,7 @@ static int _mlx5_modify_rule_destination(struct mlx5_flow_rule *rule,
 	int err = 0;
 
 	fs_get_obj(fte, rule->node.parent);
-	if (!(fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST))
+	if (!(fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST))
 		return -EINVAL;
 	down_write_ref_node(&fte->node, false);
 	fs_get_obj(fg, fte->node.parent);
@@ -1462,7 +1462,7 @@ static void destroy_flow_handle(struct fs_fte *fte,
 {
 	for (; --i >= 0;) {
 		if (refcount_dec_and_test(&handle->rule[i]->node.refcount)) {
-			fte->dests_size--;
+			fte->act_dests.dests_size--;
 			list_del(&handle->rule[i]->node.list);
 			kfree(handle->rule[i]);
 		}
@@ -1512,10 +1512,10 @@ create_flow_handle(struct fs_fte *fte,
 		else
 			list_add_tail(&rule->node.list, &fte->node.children);
 		if (dest) {
-			fte->dests_size++;
+			fte->act_dests.dests_size++;
 
 			if (is_fwd_dest_type(dest[i].type))
-				fte->fwd_dests++;
+				fte->act_dests.fwd_dests++;
 
 			type = dest[i].type ==
 				MLX5_FLOW_DESTINATION_TYPE_COUNTER;
@@ -1776,17 +1776,17 @@ static int check_conflicting_ftes(struct fs_fte *fte,
 				  const struct mlx5_flow_context *flow_context,
 				  const struct mlx5_flow_act *flow_act)
 {
-	if (check_conflicting_actions(flow_act, &fte->action)) {
+	if (check_conflicting_actions(flow_act, &fte->act_dests.action)) {
 		mlx5_core_warn(get_dev(&fte->node),
 			       "Found two FTEs with conflicting actions\n");
 		return -EEXIST;
 	}
 
 	if ((flow_context->flags & FLOW_CONTEXT_HAS_TAG) &&
-	    fte->flow_context.flow_tag != flow_context->flow_tag) {
+	    fte->act_dests.flow_context.flow_tag != flow_context->flow_tag) {
 		mlx5_core_warn(get_dev(&fte->node),
 			       "FTE flow tag %u already exists with different flow tag %u\n",
-			       fte->flow_context.flow_tag,
+			       fte->act_dests.flow_context.flow_tag,
 			       flow_context->flow_tag);
 		return -EEXIST;
 	}
@@ -1810,12 +1810,12 @@ static struct mlx5_flow_handle *add_rule_fg(struct mlx5_flow_group *fg,
 	if (ret)
 		return ERR_PTR(ret);
 
-	old_action = fte->action.action;
-	fte->action.action |= flow_act->action;
+	old_action = fte->act_dests.action.action;
+	fte->act_dests.action.action |= flow_act->action;
 	handle = add_rule_fte(fte, fg, dest, dest_num,
 			      old_action != flow_act->action);
 	if (IS_ERR(handle)) {
-		fte->action.action = old_action;
+		fte->act_dests.action.action = old_action;
 		return handle;
 	}
 	trace_mlx5_fs_set_fte(fte, false);
@@ -2269,8 +2269,8 @@ void mlx5_del_flow_rules(struct mlx5_flow_handle *handle)
 		fte->node.del_hw_func(&fte->node);
 		up_write_ref_node(&fte->node, false);
 		tree_put_node(&fte->node, false);
-	} else if (fte->dests_size) {
-		if (fte->modify_mask)
+	} else if (fte->act_dests.dests_size) {
+		if (fte->act_dests.modify_mask)
 			modify_fte(fte);
 		up_write_ref_node(&fte->node, false);
 	} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 5eacf64232f7..19ba63063d09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -230,19 +230,23 @@ struct mlx5_ft_underlay_qp {
 			   MLX5_BYTE_OFF(fte_match_param,		     \
 					 MLX5_FTE_MATCH_PARAM_RESERVED)))
 
+struct fs_fte_action {
+	int				modify_mask;
+	u32				dests_size;
+	u32				fwd_dests;
+	struct mlx5_flow_context	flow_context;
+	struct mlx5_flow_act		action;
+};
+
 /* Type of children is mlx5_flow_rule */
 struct fs_fte {
 	struct fs_node			node;
 	struct mlx5_fs_dr_rule		fs_dr_rule;
 	u32				val[MLX5_ST_SZ_DW_MATCH_PARAM];
-	u32				dests_size;
-	u32				fwd_dests;
+	struct fs_fte_action		act_dests;
 	u32				index;
-	struct mlx5_flow_context	flow_context;
-	struct mlx5_flow_act		action;
 	enum fs_fte_status		status;
 	struct rhash_head		hash;
-	int				modify_mask;
 };
 
 /* Type of children is mlx5_flow_table/namespace */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 40d06051cdc6..15ef118eade0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -298,12 +298,12 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 	match_sz = sizeof(fte->val);
 
 	/* Drop reformat action bit if destination vport set with reformat */
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 		list_for_each_entry(dst, &fte->node.children, node.list) {
 			if (!contain_vport_reformat_action(dst))
 				continue;
 
-			fte->action.action &= ~MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
+			fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
 			break;
 		}
 	}
@@ -313,7 +313,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 	 * TX: modify header -> push vlan -> encap
 	 * RX: decap -> pop vlan -> modify header
 	 */
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_DECAP) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_DECAP) {
 		enum mlx5dr_action_reformat_type decap_type =
 			DR_ACTION_REFORMAT_TYP_TNL_L2_TO_L2;
 
@@ -329,26 +329,26 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT) {
 		bool is_decap;
 
-		if (fte->action.pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
+		if (fte->act_dests.action.pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
 			err = -EINVAL;
 			mlx5dr_err(domain, "FW-owned reformat can't be used in SW rule\n");
 			goto free_actions;
 		}
 
-		is_decap = fte->action.pkt_reformat->reformat_type ==
+		is_decap = fte->act_dests.action.pkt_reformat->reformat_type ==
 			   MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2;
 
 		if (is_decap)
 			actions[num_actions++] =
-				fte->action.pkt_reformat->action.dr_action;
+				fte->act_dests.action.pkt_reformat->action.dr_action;
 		else
 			delay_encap_set = true;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) {
 		tmp_action =
 			mlx5dr_action_create_pop_vlan();
 		if (!tmp_action) {
@@ -359,7 +359,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP_2) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP_2) {
 		tmp_action =
 			mlx5dr_action_create_pop_vlan();
 		if (!tmp_action) {
@@ -370,12 +370,12 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
 		actions[num_actions++] =
-			fte->action.modify_hdr->action.dr_action;
+			fte->act_dests.action.modify_hdr->action.dr_action;
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
-		tmp_action = create_action_push_vlan(domain, &fte->action.vlan[0]);
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
+		tmp_action = create_action_push_vlan(domain, &fte->act_dests.action.vlan[0]);
 		if (!tmp_action) {
 			err = -ENOMEM;
 			goto free_actions;
@@ -384,8 +384,8 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH_2) {
-		tmp_action = create_action_push_vlan(domain, &fte->action.vlan[1]);
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH_2) {
+		tmp_action = create_action_push_vlan(domain, &fte->act_dests.action.vlan[1]);
 		if (!tmp_action) {
 			err = -ENOMEM;
 			goto free_actions;
@@ -396,11 +396,11 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 
 	if (delay_encap_set)
 		actions[num_actions++] =
-			fte->action.pkt_reformat->action.dr_action;
+			fte->act_dests.action.pkt_reformat->action.dr_action;
 
 	/* The order of the actions below is not important */
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
 		tmp_action = mlx5dr_action_create_drop();
 		if (!tmp_action) {
 			err = -ENOMEM;
@@ -410,9 +410,9 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		term_actions[num_term_actions++].dest = tmp_action;
 	}
 
-	if (fte->flow_context.flow_tag) {
+	if (fte->act_dests.flow_context.flow_tag) {
 		tmp_action =
-			mlx5dr_action_create_tag(fte->flow_context.flow_tag);
+			mlx5dr_action_create_tag(fte->act_dests.flow_context.flow_tag);
 		if (!tmp_action) {
 			err = -ENOMEM;
 			goto free_actions;
@@ -421,7 +421,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 		list_for_each_entry(dst, &fte->node.children, node.list) {
 			enum mlx5_flow_destination_type type = dst->dest_attr.type;
 			u32 id;
@@ -502,7 +502,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		}
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		list_for_each_entry(dst, &fte->node.children, node.list) {
 			u32 id;
 
@@ -529,19 +529,21 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		}
 	}
 
-	if (fte->action.action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
-		if (fte->action.exe_aso.type != MLX5_EXE_ASO_FLOW_METER) {
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
+		struct mlx5_flow_act *action = &fte->act_dests.action;
+
+		if (fte->act_dests.action.exe_aso.type != MLX5_EXE_ASO_FLOW_METER) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
 		}
 
 		tmp_action =
 			mlx5dr_action_create_aso(domain,
-						 fte->action.exe_aso.object_id,
-						 fte->action.exe_aso.return_reg_id,
-						 fte->action.exe_aso.type,
-						 fte->action.exe_aso.flow_meter.init_color,
-						 fte->action.exe_aso.flow_meter.meter_idx);
+						 action->exe_aso.object_id,
+						 action->exe_aso.return_reg_id,
+						 action->exe_aso.type,
+						 action->exe_aso.flow_meter.init_color,
+						 action->exe_aso.flow_meter.meter_idx);
 		if (!tmp_action) {
 			err = -ENOMEM;
 			goto free_actions;
@@ -568,8 +570,8 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = term_actions->dest;
 	} else if (num_term_actions > 1) {
 		bool ignore_flow_level =
-			!!(fte->action.flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
-		u32 flow_source = fte->flow_context.flow_source;
+			!!(fte->act_dests.action.flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
+		u32 flow_source = fte->act_dests.flow_context.flow_source;
 
 		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 		    fs_dr_num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
@@ -593,7 +595,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 				  &params,
 				  num_actions,
 				  actions,
-				  fte->flow_context.flow_source);
+				  fte->act_dests.flow_context.flow_source);
 	if (!rule) {
 		err = -EINVAL;
 		goto free_actions;
-- 
2.46.0


