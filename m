Return-Path: <netdev+bounces-66310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809183E5A0
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A61C2382C
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFC656B60;
	Fri, 26 Jan 2024 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoPPnmbb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EE51015
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308627; cv=none; b=PHdo/pKOR81Mvsb+O1phuz8eHMUoIxgtUQfjDTlrKGPSapf72NhBzcF0Z7UKEiym0ceB1KkEBJM9vVBDqqY1XbgwmL4XKJWxCPBQGFYStaDf7B55pCVbwrzz+1WlPm3cl9uOC9mwS68d1NaDcYorXD29fxfvRwlutYHD8++BcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308627; c=relaxed/simple;
	bh=r2Nx3LGZ/8ugci9YfundjTW72u84V/lzCLtj+Nevevw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI44sCj4jA0IvB69OEuqprcdxe/edo1mNDl+Sr9Mced5rTMtaxMmmqphjNsndUgSJgz7HZVKoIqyWTj6r21ezSS2ChQ3VOsoq47ZeBcovpxIM1mw0qKBn/j7G0Ecjl6iW5OGgDS5T1YD2vaEyYlN82bAHFLf4UmILdFnhmPGt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoPPnmbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765DBC43390;
	Fri, 26 Jan 2024 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308626;
	bh=r2Nx3LGZ/8ugci9YfundjTW72u84V/lzCLtj+Nevevw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoPPnmbb/wZ6EKtj3R9aRh2BEv+TCNPE1XN5nBsNmJdNjKIcWyfPMJShAVhhqVK2h
	 56tI+pZsfJui8JgQpDdTR+geWgGyAlzcszXp9gB42+g6rPtwK/0fnyKmL3id6i2a5r
	 n3NeONPrbdDMW0nz+qcM+l7LyeLTpyWCHdOPVwhAohtuV1VufwaSYnTtc7hER9HayK
	 r15boUjukCt2nab8AOhLXVkgdeuAiuHrpu/gFPsrA0poAfh+jO9dIQTUkoDCzVW4lp
	 Mo3Y2ULQ2BM1Y0F+sp7EPgW8fGw0IFJG6uuPFbixe/LRJjY1AndnUdLTYrgequIQ7u
	 lurmuRuMFEocg==
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
	Hamdan Igbaria <hamdani@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 13/15] net/mlx5: DR, Change SWS usage to debug fs seq_file interface
Date: Fri, 26 Jan 2024 14:36:14 -0800
Message-ID: <20240126223616.98696-14-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223616.98696-1-saeed@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hamdan Igbaria <hamdani@nvidia.com>

In current SWS debug dump mechanism we implement the seq_file interface,
but we only implement the 'show' callback to dump the whole steering DB
with a single call to this callback.

However, for large data size the seq_printf function will fail to
allocate a buffer with the adequate capacity to hold such data.

This patch solves this problem by utilizing the seq_file interface
mechanism in the following way:
 - when the user triggers a dump procedure, we will allocate a list of
   buffers that hold the whole data dump (in the start callback)
 - using the start, next, show and stop callbacks of the seq_file
   API we iterate through the list and dump the whole data

Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_dbg.c      | 726 ++++++++++++++----
 .../mellanox/mlx5/core/steering/dr_dbg.h      |  20 +
 2 files changed, 615 insertions(+), 131 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
index 7e36e1062139..ff5f24583613 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
@@ -54,6 +54,105 @@ enum dr_dump_rec_type {
 	DR_DUMP_REC_TYPE_ACTION_MATCH_RANGE = 3425,
 };
 
+static struct mlx5dr_dbg_dump_buff *
+mlx5dr_dbg_dump_data_init_new_buff(struct mlx5dr_dbg_dump_data *dump_data)
+{
+	struct mlx5dr_dbg_dump_buff *new_buff;
+
+	new_buff = kzalloc(sizeof(*new_buff), GFP_KERNEL);
+	if (!new_buff)
+		return NULL;
+
+	new_buff->buff = kvzalloc(MLX5DR_DEBUG_DUMP_BUFF_SIZE, GFP_KERNEL);
+	if (!new_buff->buff) {
+		kfree(new_buff);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&new_buff->node);
+	list_add_tail(&new_buff->node, &dump_data->buff_list);
+
+	return new_buff;
+}
+
+static struct mlx5dr_dbg_dump_data *
+mlx5dr_dbg_create_dump_data(void)
+{
+	struct mlx5dr_dbg_dump_data *dump_data;
+
+	dump_data = kzalloc(sizeof(*dump_data), GFP_KERNEL);
+	if (!dump_data)
+		return NULL;
+
+	INIT_LIST_HEAD(&dump_data->buff_list);
+
+	if (!mlx5dr_dbg_dump_data_init_new_buff(dump_data))
+		kfree(dump_data);
+
+	return dump_data;
+}
+
+static void
+mlx5dr_dbg_destroy_dump_data(struct mlx5dr_dbg_dump_data *dump_data)
+{
+	struct mlx5dr_dbg_dump_buff *dump_buff, *tmp_buff;
+
+	if (!dump_data)
+		return;
+
+	list_for_each_entry_safe(dump_buff, tmp_buff, &dump_data->buff_list, node) {
+		kvfree(dump_buff->buff);
+		list_del(&dump_buff->node);
+		kfree(dump_buff);
+	}
+
+	kfree(dump_data);
+}
+
+static int
+mlx5dr_dbg_dump_data_print(struct seq_file *file, char *str, u32 size)
+{
+	struct mlx5dr_domain *dmn = file->private;
+	struct mlx5dr_dbg_dump_data *dump_data;
+	struct mlx5dr_dbg_dump_buff *buff;
+	u32 buff_capacity, write_size;
+	int remain_size, ret;
+
+	if (size >= MLX5DR_DEBUG_DUMP_BUFF_SIZE)
+		return -EINVAL;
+
+	dump_data = dmn->dump_info.dump_data;
+	buff = list_last_entry(&dump_data->buff_list,
+			       struct mlx5dr_dbg_dump_buff, node);
+
+	buff_capacity = (MLX5DR_DEBUG_DUMP_BUFF_SIZE - 1) - buff->index;
+	remain_size = buff_capacity - size;
+	write_size = (remain_size > 0) ? size : buff_capacity;
+
+	if (likely(write_size)) {
+		ret = snprintf(buff->buff + buff->index, write_size + 1, "%s", str);
+		if (ret < 0)
+			return ret;
+
+		buff->index += write_size;
+	}
+
+	if (remain_size < 0) {
+		remain_size *= -1;
+		buff = mlx5dr_dbg_dump_data_init_new_buff(dump_data);
+		if (!buff)
+			return -ENOMEM;
+
+		ret = snprintf(buff->buff, remain_size + 1, "%s", str + write_size);
+		if (ret < 0)
+			return ret;
+
+		buff->index += remain_size;
+	}
+
+	return 0;
+}
+
 void mlx5dr_dbg_tbl_add(struct mlx5dr_table *tbl)
 {
 	mutex_lock(&tbl->dmn->dump_info.dbg_mutex);
@@ -109,36 +208,68 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 {
 	struct mlx5dr_action *action = action_mem->action;
 	const u64 action_id = DR_DBG_PTR_TO_ID(action);
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	u64 hit_tbl_ptr, miss_tbl_ptr;
 	u32 hit_tbl_id, miss_tbl_id;
+	int ret;
 
 	switch (action->action_type) {
 	case DR_ACTION_TYP_DROP:
-		seq_printf(file, "%d,0x%llx,0x%llx\n",
-			   DR_DUMP_REC_TYPE_ACTION_DROP, action_id, rule_id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx\n",
+			       DR_DUMP_REC_TYPE_ACTION_DROP, action_id,
+			       rule_id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_FT:
 		if (action->dest_tbl->is_fw_tbl)
-			seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%x\n",
-				   DR_DUMP_REC_TYPE_ACTION_FT, action_id,
-				   rule_id, action->dest_tbl->fw_tbl.id,
-				   -1);
+			ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+				       "%d,0x%llx,0x%llx,0x%x,0x%x\n",
+				       DR_DUMP_REC_TYPE_ACTION_FT, action_id,
+				       rule_id, action->dest_tbl->fw_tbl.id,
+				       -1);
 		else
-			seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%llx\n",
-				   DR_DUMP_REC_TYPE_ACTION_FT, action_id,
-				   rule_id, action->dest_tbl->tbl->table_id,
-				   DR_DBG_PTR_TO_ID(action->dest_tbl->tbl));
+			ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+				       "%d,0x%llx,0x%llx,0x%x,0x%llx\n",
+				       DR_DUMP_REC_TYPE_ACTION_FT, action_id,
+				       rule_id, action->dest_tbl->tbl->table_id,
+				       DR_DBG_PTR_TO_ID(action->dest_tbl->tbl));
+
+		if (ret < 0)
+			return ret;
 
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_CTR:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_CTR, action_id, rule_id,
-			   action->ctr->ctr_id + action->ctr->offset);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_CTR, action_id, rule_id,
+			       action->ctr->ctr_id + action->ctr->offset);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_TAG:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_TAG, action_id, rule_id,
-			   action->flow_tag->flow_tag);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_TAG, action_id, rule_id,
+			       action->flow_tag->flow_tag);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_MODIFY_HDR:
 	{
@@ -150,83 +281,171 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 
 		ptrn_arg = !action->rewrite->single_action_opt && ptrn && arg;
 
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x,%d,0x%x,0x%x,0x%x",
-			   DR_DUMP_REC_TYPE_ACTION_MODIFY_HDR, action_id,
-			   rule_id, action->rewrite->index,
-			   action->rewrite->single_action_opt,
-			   ptrn_arg ? action->rewrite->num_of_actions : 0,
-			   ptrn_arg ? ptrn->index : 0,
-			   ptrn_arg ? mlx5dr_arg_get_obj_id(arg) : 0);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x,%d,0x%x,0x%x,0x%x",
+			       DR_DUMP_REC_TYPE_ACTION_MODIFY_HDR, action_id,
+			       rule_id, action->rewrite->index,
+			       action->rewrite->single_action_opt,
+			       ptrn_arg ? action->rewrite->num_of_actions : 0,
+			       ptrn_arg ? ptrn->index : 0,
+			       ptrn_arg ? mlx5dr_arg_get_obj_id(arg) : 0);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 
 		if (ptrn_arg) {
 			for (i = 0; i < action->rewrite->num_of_actions; i++) {
-				seq_printf(file, ",0x%016llx",
-					   be64_to_cpu(((__be64 *)rewrite_data)[i]));
+				ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+					       ",0x%016llx",
+					       be64_to_cpu(((__be64 *)rewrite_data)[i]));
+				if (ret < 0)
+					return ret;
+
+				ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+				if (ret)
+					return ret;
 			}
 		}
 
-		seq_puts(file, "\n");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, "\n");
+		if (ret < 0)
+			return ret;
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	}
 	case DR_ACTION_TYP_VPORT:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_VPORT, action_id, rule_id,
-			   action->vport->caps->num);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_VPORT, action_id, rule_id,
+			       action->vport->caps->num);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_TNL_L2_TO_L2:
-		seq_printf(file, "%d,0x%llx,0x%llx\n",
-			   DR_DUMP_REC_TYPE_ACTION_DECAP_L2, action_id,
-			   rule_id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx\n",
+			       DR_DUMP_REC_TYPE_ACTION_DECAP_L2, action_id,
+			       rule_id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_TNL_L3_TO_L2:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_DECAP_L3, action_id,
-			   rule_id,
-			   (action->rewrite->ptrn && action->rewrite->arg) ?
-			   mlx5dr_arg_get_obj_id(action->rewrite->arg) :
-			   action->rewrite->index);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_DECAP_L3, action_id,
+			       rule_id,
+			       (action->rewrite->ptrn && action->rewrite->arg) ?
+			       mlx5dr_arg_get_obj_id(action->rewrite->arg) :
+			       action->rewrite->index);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_L2_TO_TNL_L2:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_ENCAP_L2, action_id,
-			   rule_id, action->reformat->id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_ENCAP_L2, action_id,
+			       rule_id, action->reformat->id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_L2_TO_TNL_L3:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_ENCAP_L3, action_id,
-			   rule_id, action->reformat->id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_ENCAP_L3, action_id,
+			       rule_id, action->reformat->id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_POP_VLAN:
-		seq_printf(file, "%d,0x%llx,0x%llx\n",
-			   DR_DUMP_REC_TYPE_ACTION_POP_VLAN, action_id,
-			   rule_id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx\n",
+			       DR_DUMP_REC_TYPE_ACTION_POP_VLAN, action_id,
+			       rule_id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_PUSH_VLAN:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_PUSH_VLAN, action_id,
-			   rule_id, action->push_vlan->vlan_hdr);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_PUSH_VLAN, action_id,
+			       rule_id, action->push_vlan->vlan_hdr);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_INSERT_HDR:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_INSERT_HDR, action_id,
-			   rule_id, action->reformat->id,
-			   action->reformat->param_0,
-			   action->reformat->param_1);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_INSERT_HDR, action_id,
+			       rule_id, action->reformat->id,
+			       action->reformat->param_0,
+			       action->reformat->param_1);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_REMOVE_HDR:
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_REMOVE_HDR, action_id,
-			   rule_id, action->reformat->id,
-			   action->reformat->param_0,
-			   action->reformat->param_1);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_REMOVE_HDR, action_id,
+			       rule_id, action->reformat->id,
+			       action->reformat->param_0,
+			       action->reformat->param_1);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_SAMPLER:
-		seq_printf(file,
-			   "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x,0x%llx,0x%llx\n",
-			   DR_DUMP_REC_TYPE_ACTION_SAMPLER, action_id, rule_id,
-			   0, 0, action->sampler->sampler_id,
-			   action->sampler->rx_icm_addr,
-			   action->sampler->tx_icm_addr);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x,0x%x,0x%x,0x%llx,0x%llx\n",
+			       DR_DUMP_REC_TYPE_ACTION_SAMPLER, action_id,
+			       rule_id, 0, 0, action->sampler->sampler_id,
+			       action->sampler->rx_icm_addr,
+			       action->sampler->tx_icm_addr);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	case DR_ACTION_TYP_RANGE:
 		if (action->range->hit_tbl_action->dest_tbl->is_fw_tbl) {
@@ -247,10 +466,17 @@ dr_dump_rule_action_mem(struct seq_file *file, const u64 rule_id,
 				DR_DBG_PTR_TO_ID(action->range->miss_tbl_action->dest_tbl->tbl);
 		}
 
-		seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%llx,0x%x,0x%llx,0x%x\n",
-			   DR_DUMP_REC_TYPE_ACTION_MATCH_RANGE, action_id, rule_id,
-			   hit_tbl_id, hit_tbl_ptr, miss_tbl_id, miss_tbl_ptr,
-			   action->range->definer_id);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,0x%llx,0x%x,0x%llx,0x%x,0x%llx,0x%x\n",
+			       DR_DUMP_REC_TYPE_ACTION_MATCH_RANGE, action_id,
+			       rule_id, hit_tbl_id, hit_tbl_ptr, miss_tbl_id,
+			       miss_tbl_ptr, action->range->definer_id);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return 0;
@@ -263,8 +489,10 @@ static int
 dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
 		 bool is_rx, const u64 rule_id, u8 format_ver)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	char hw_ste_dump[DR_HEX_SIZE];
 	u32 mem_rec_type;
+	int ret;
 
 	if (format_ver == MLX5_STEERING_FORMAT_CONNECTX_5) {
 		mem_rec_type = is_rx ? DR_DUMP_REC_TYPE_RULE_RX_ENTRY_V0 :
@@ -277,9 +505,16 @@ dr_dump_rule_mem(struct seq_file *file, struct mlx5dr_ste *ste,
 	dr_dump_hex_print(hw_ste_dump, (char *)mlx5dr_ste_get_hw_ste(ste),
 			  DR_STE_SIZE_REDUCED);
 
-	seq_printf(file, "%d,0x%llx,0x%llx,%s\n", mem_rec_type,
-		   dr_dump_icm_to_idx(mlx5dr_ste_get_icm_addr(ste)), rule_id,
-		   hw_ste_dump);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx,%s\n", mem_rec_type,
+		       dr_dump_icm_to_idx(mlx5dr_ste_get_icm_addr(ste)),
+		       rule_id, hw_ste_dump);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -309,6 +544,7 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 {
 	struct mlx5dr_rule_action_member *action_mem;
 	const u64 rule_id = DR_DBG_PTR_TO_ID(rule);
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	struct mlx5dr_rule_rx_tx *rx = &rule->rx;
 	struct mlx5dr_rule_rx_tx *tx = &rule->tx;
 	u8 format_ver;
@@ -316,8 +552,15 @@ static int dr_dump_rule(struct seq_file *file, struct mlx5dr_rule *rule)
 
 	format_ver = rule->matcher->tbl->dmn->info.caps.sw_format_ver;
 
-	seq_printf(file, "%d,0x%llx,0x%llx\n", DR_DUMP_REC_TYPE_RULE, rule_id,
-		   DR_DBG_PTR_TO_ID(rule->matcher));
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx\n", DR_DUMP_REC_TYPE_RULE,
+		       rule_id, DR_DBG_PTR_TO_ID(rule->matcher));
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	if (rx->nic_matcher) {
 		ret = dr_dump_rule_rx_tx(file, rx, true, rule_id, format_ver);
@@ -344,46 +587,94 @@ static int
 dr_dump_matcher_mask(struct seq_file *file, struct mlx5dr_match_param *mask,
 		     u8 criteria, const u64 matcher_id)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	char dump[DR_HEX_SIZE];
+	int ret;
 
-	seq_printf(file, "%d,0x%llx,", DR_DUMP_REC_TYPE_MATCHER_MASK,
-		   matcher_id);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, "%d,0x%llx,",
+		       DR_DUMP_REC_TYPE_MATCHER_MASK, matcher_id);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	if (criteria & DR_MATCHER_CRITERIA_OUTER) {
 		dr_dump_hex_print(dump, (char *)&mask->outer, sizeof(mask->outer));
-		seq_printf(file, "%s,", dump);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%s,", dump);
 	} else {
-		seq_puts(file, ",");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, ",");
 	}
 
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	if (criteria & DR_MATCHER_CRITERIA_INNER) {
 		dr_dump_hex_print(dump, (char *)&mask->inner, sizeof(mask->inner));
-		seq_printf(file, "%s,", dump);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%s,", dump);
 	} else {
-		seq_puts(file, ",");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, ",");
 	}
 
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	if (criteria & DR_MATCHER_CRITERIA_MISC) {
 		dr_dump_hex_print(dump, (char *)&mask->misc, sizeof(mask->misc));
-		seq_printf(file, "%s,", dump);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%s,", dump);
 	} else {
-		seq_puts(file, ",");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, ",");
 	}
 
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	if (criteria & DR_MATCHER_CRITERIA_MISC2) {
 		dr_dump_hex_print(dump, (char *)&mask->misc2, sizeof(mask->misc2));
-		seq_printf(file, "%s,", dump);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%s,", dump);
 	} else {
-		seq_puts(file, ",");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, ",");
 	}
 
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	if (criteria & DR_MATCHER_CRITERIA_MISC3) {
 		dr_dump_hex_print(dump, (char *)&mask->misc3, sizeof(mask->misc3));
-		seq_printf(file, "%s\n", dump);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%s\n", dump);
 	} else {
-		seq_puts(file, ",\n");
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH, ",\n");
 	}
 
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -391,9 +682,19 @@ static int
 dr_dump_matcher_builder(struct seq_file *file, struct mlx5dr_ste_build *builder,
 			u32 index, bool is_rx, const u64 matcher_id)
 {
-	seq_printf(file, "%d,0x%llx,%d,%d,0x%x\n",
-		   DR_DUMP_REC_TYPE_MATCHER_BUILDER, matcher_id, index, is_rx,
-		   builder->lu_type);
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
+	int ret;
+
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,%d,%d,0x%x\n",
+		       DR_DUMP_REC_TYPE_MATCHER_BUILDER, matcher_id, index,
+		       is_rx, builder->lu_type);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -403,6 +704,7 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 		      struct mlx5dr_matcher_rx_tx *matcher_rx_tx,
 		      const u64 matcher_id)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	enum dr_dump_rec_type rec_type;
 	u64 s_icm_addr, e_icm_addr;
 	int i, ret;
@@ -412,11 +714,19 @@ dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
 
 	s_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(matcher_rx_tx->s_htbl->chunk);
 	e_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(matcher_rx_tx->e_anchor->chunk);
-	seq_printf(file, "%d,0x%llx,0x%llx,%d,0x%llx,0x%llx\n",
-		   rec_type, DR_DBG_PTR_TO_ID(matcher_rx_tx),
-		   matcher_id, matcher_rx_tx->num_of_builders,
-		   dr_dump_icm_to_idx(s_icm_addr),
-		   dr_dump_icm_to_idx(e_icm_addr));
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx,%d,0x%llx,0x%llx\n",
+		       rec_type, DR_DBG_PTR_TO_ID(matcher_rx_tx),
+		       matcher_id, matcher_rx_tx->num_of_builders,
+		       dr_dump_icm_to_idx(s_icm_addr),
+		       dr_dump_icm_to_idx(e_icm_addr));
+
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < matcher_rx_tx->num_of_builders; i++) {
 		ret = dr_dump_matcher_builder(file,
@@ -434,13 +744,22 @@ dr_dump_matcher(struct seq_file *file, struct mlx5dr_matcher *matcher)
 {
 	struct mlx5dr_matcher_rx_tx *rx = &matcher->rx;
 	struct mlx5dr_matcher_rx_tx *tx = &matcher->tx;
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	u64 matcher_id;
 	int ret;
 
 	matcher_id = DR_DBG_PTR_TO_ID(matcher);
 
-	seq_printf(file, "%d,0x%llx,0x%llx,%d\n", DR_DUMP_REC_TYPE_MATCHER,
-		   matcher_id, DR_DBG_PTR_TO_ID(matcher->tbl), matcher->prio);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx,%d\n", DR_DUMP_REC_TYPE_MATCHER,
+		       matcher_id, DR_DBG_PTR_TO_ID(matcher->tbl),
+		       matcher->prio);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	ret = dr_dump_matcher_mask(file, &matcher->mask,
 				   matcher->match_criteria, matcher_id);
@@ -486,15 +805,24 @@ dr_dump_table_rx_tx(struct seq_file *file, bool is_rx,
 		    struct mlx5dr_table_rx_tx *table_rx_tx,
 		    const u64 table_id)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	enum dr_dump_rec_type rec_type;
 	u64 s_icm_addr;
+	int ret;
 
 	rec_type = is_rx ? DR_DUMP_REC_TYPE_TABLE_RX :
 			   DR_DUMP_REC_TYPE_TABLE_TX;
 
 	s_icm_addr = mlx5dr_icm_pool_get_chunk_icm_addr(table_rx_tx->s_anchor->chunk);
-	seq_printf(file, "%d,0x%llx,0x%llx\n", rec_type, table_id,
-		   dr_dump_icm_to_idx(s_icm_addr));
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx\n", rec_type, table_id,
+		       dr_dump_icm_to_idx(s_icm_addr));
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -503,11 +831,19 @@ static int dr_dump_table(struct seq_file *file, struct mlx5dr_table *table)
 {
 	struct mlx5dr_table_rx_tx *rx = &table->rx;
 	struct mlx5dr_table_rx_tx *tx = &table->tx;
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	int ret;
 
-	seq_printf(file, "%d,0x%llx,0x%llx,%d,%d\n", DR_DUMP_REC_TYPE_TABLE,
-		   DR_DBG_PTR_TO_ID(table), DR_DBG_PTR_TO_ID(table->dmn),
-		   table->table_type, table->level);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx,%d,%d\n", DR_DUMP_REC_TYPE_TABLE,
+		       DR_DBG_PTR_TO_ID(table), DR_DBG_PTR_TO_ID(table->dmn),
+		       table->table_type, table->level);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	if (rx->nic_dmn) {
 		ret = dr_dump_table_rx_tx(file, true, rx,
@@ -546,9 +882,21 @@ static int
 dr_dump_send_ring(struct seq_file *file, struct mlx5dr_send_ring *ring,
 		  const u64 domain_id)
 {
-	seq_printf(file, "%d,0x%llx,0x%llx,0x%x,0x%x\n",
-		   DR_DUMP_REC_TYPE_DOMAIN_SEND_RING, DR_DBG_PTR_TO_ID(ring),
-		   domain_id, ring->cq->mcq.cqn, ring->qp->qpn);
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
+	int ret;
+
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%llx,0x%x,0x%x\n",
+		       DR_DUMP_REC_TYPE_DOMAIN_SEND_RING,
+		       DR_DBG_PTR_TO_ID(ring), domain_id,
+		       ring->cq->mcq.cqn, ring->qp->qpn);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -558,9 +906,20 @@ dr_dump_domain_info_flex_parser(struct seq_file *file,
 				const u8 flex_parser_value,
 				const u64 domain_id)
 {
-	seq_printf(file, "%d,0x%llx,%s,0x%x\n",
-		   DR_DUMP_REC_TYPE_DOMAIN_INFO_FLEX_PARSER, domain_id,
-		   flex_parser_name, flex_parser_value);
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
+	int ret;
+
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,%s,0x%x\n",
+		       DR_DUMP_REC_TYPE_DOMAIN_INFO_FLEX_PARSER, domain_id,
+		       flex_parser_name, flex_parser_value);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -568,24 +927,41 @@ static int
 dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
 			 const u64 domain_id)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	struct mlx5dr_cmd_vport_cap *vport_caps;
 	unsigned long i, vports_num;
+	int ret;
 
 	xa_for_each(&caps->vports.vports_caps_xa, vports_num, vport_caps)
 		; /* count the number of vports in xarray */
 
-	seq_printf(file, "%d,0x%llx,0x%x,0x%llx,0x%llx,0x%x,%lu,%d\n",
-		   DR_DUMP_REC_TYPE_DOMAIN_INFO_CAPS, domain_id, caps->gvmi,
-		   caps->nic_rx_drop_address, caps->nic_tx_drop_address,
-		   caps->flex_protocols, vports_num, caps->eswitch_manager);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,0x%x,0x%llx,0x%llx,0x%x,%lu,%d\n",
+		       DR_DUMP_REC_TYPE_DOMAIN_INFO_CAPS, domain_id, caps->gvmi,
+		       caps->nic_rx_drop_address, caps->nic_tx_drop_address,
+		       caps->flex_protocols, vports_num, caps->eswitch_manager);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	xa_for_each(&caps->vports.vports_caps_xa, i, vport_caps) {
 		vport_caps = xa_load(&caps->vports.vports_caps_xa, i);
 
-		seq_printf(file, "%d,0x%llx,%lu,0x%x,0x%llx,0x%llx\n",
-			   DR_DUMP_REC_TYPE_DOMAIN_INFO_VPORT, domain_id, i,
-			   vport_caps->vport_gvmi, vport_caps->icm_address_rx,
-			   vport_caps->icm_address_tx);
+		ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+			       "%d,0x%llx,%lu,0x%x,0x%llx,0x%llx\n",
+			       DR_DUMP_REC_TYPE_DOMAIN_INFO_VPORT,
+			       domain_id, i, vport_caps->vport_gvmi,
+			       vport_caps->icm_address_rx,
+			       vport_caps->icm_address_tx);
+		if (ret < 0)
+			return ret;
+
+		ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -630,21 +1006,29 @@ dr_dump_domain_info(struct seq_file *file, struct mlx5dr_domain_info *info,
 static int
 dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
 {
+	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];
 	u64 domain_id = DR_DBG_PTR_TO_ID(dmn);
 	int ret;
 
-	seq_printf(file, "%d,0x%llx,%d,0%x,%d,%u.%u.%u,%s,%d,%u,%u,%u\n",
-		   DR_DUMP_REC_TYPE_DOMAIN,
-		   domain_id, dmn->type, dmn->info.caps.gvmi,
-		   dmn->info.supp_sw_steering,
-		   /* package version */
-		   LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL,
-		   LINUX_VERSION_SUBLEVEL,
-		   pci_name(dmn->mdev->pdev),
-		   0, /* domain flags */
-		   dmn->num_buddies[DR_ICM_TYPE_STE],
-		   dmn->num_buddies[DR_ICM_TYPE_MODIFY_ACTION],
-		   dmn->num_buddies[DR_ICM_TYPE_MODIFY_HDR_PTRN]);
+	ret = snprintf(buff, MLX5DR_DEBUG_DUMP_BUFF_LENGTH,
+		       "%d,0x%llx,%d,0%x,%d,%u.%u.%u,%s,%d,%u,%u,%u\n",
+		       DR_DUMP_REC_TYPE_DOMAIN,
+		       domain_id, dmn->type, dmn->info.caps.gvmi,
+		       dmn->info.supp_sw_steering,
+		       /* package version */
+		       LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL,
+		       LINUX_VERSION_SUBLEVEL,
+		       pci_name(dmn->mdev->pdev),
+		       0, /* domain flags */
+		       dmn->num_buddies[DR_ICM_TYPE_STE],
+		       dmn->num_buddies[DR_ICM_TYPE_MODIFY_ACTION],
+		       dmn->num_buddies[DR_ICM_TYPE_MODIFY_HDR_PTRN]);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx5dr_dbg_dump_data_print(file, buff, ret);
+	if (ret)
+		return ret;
 
 	ret = dr_dump_domain_info(file, &dmn->info, domain_id);
 	if (ret < 0)
@@ -683,11 +1067,91 @@ static int dr_dump_domain_all(struct seq_file *file, struct mlx5dr_domain *dmn)
 	return ret;
 }
 
-static int dr_dump_show(struct seq_file *file, void *priv)
+static void *
+dr_dump_start(struct seq_file *file, loff_t *pos)
+{
+	struct mlx5dr_domain *dmn = file->private;
+	struct mlx5dr_dbg_dump_data *dump_data;
+
+	if (atomic_read(&dmn->dump_info.state) != MLX5DR_DEBUG_DUMP_STATE_FREE) {
+		mlx5_core_warn(dmn->mdev, "Dump already in progress\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	atomic_set(&dmn->dump_info.state, MLX5DR_DEBUG_DUMP_STATE_IN_PROGRESS);
+	dump_data = dmn->dump_info.dump_data;
+
+	if (dump_data) {
+		return seq_list_start(&dump_data->buff_list, *pos);
+	} else if (*pos == 0) {
+		dump_data = mlx5dr_dbg_create_dump_data();
+		if (!dump_data)
+			goto exit;
+
+		dmn->dump_info.dump_data = dump_data;
+		if (dr_dump_domain_all(file, dmn)) {
+			mlx5dr_dbg_destroy_dump_data(dump_data);
+			dmn->dump_info.dump_data = NULL;
+			goto exit;
+		}
+
+		return seq_list_start(&dump_data->buff_list, *pos);
+	}
+
+exit:
+	atomic_set(&dmn->dump_info.state, MLX5DR_DEBUG_DUMP_STATE_FREE);
+	return NULL;
+}
+
+static void *
+dr_dump_next(struct seq_file *file, void *v, loff_t *pos)
 {
-	return dr_dump_domain_all(file, file->private);
+	struct mlx5dr_domain *dmn = file->private;
+	struct mlx5dr_dbg_dump_data *dump_data;
+
+	dump_data = dmn->dump_info.dump_data;
+
+	return seq_list_next(v, &dump_data->buff_list, pos);
 }
-DEFINE_SHOW_ATTRIBUTE(dr_dump);
+
+static void
+dr_dump_stop(struct seq_file *file, void *v)
+{
+	struct mlx5dr_domain *dmn = file->private;
+	struct mlx5dr_dbg_dump_data *dump_data;
+
+	if (v && IS_ERR(v))
+		return;
+
+	if (!v) {
+		dump_data = dmn->dump_info.dump_data;
+		if (dump_data) {
+			mlx5dr_dbg_destroy_dump_data(dump_data);
+			dmn->dump_info.dump_data = NULL;
+		}
+	}
+
+	atomic_set(&dmn->dump_info.state, MLX5DR_DEBUG_DUMP_STATE_FREE);
+}
+
+static int
+dr_dump_show(struct seq_file *file, void *v)
+{
+	struct mlx5dr_dbg_dump_buff *entry;
+
+	entry = list_entry(v, struct mlx5dr_dbg_dump_buff, node);
+	seq_printf(file, "%s", entry->buff);
+
+	return 0;
+}
+
+static const struct seq_operations dr_dump_sops = {
+	.start	= dr_dump_start,
+	.next	= dr_dump_next,
+	.stop	= dr_dump_stop,
+	.show	= dr_dump_show,
+};
+DEFINE_SEQ_ATTRIBUTE(dr_dump);
 
 void mlx5dr_dbg_init_dump(struct mlx5dr_domain *dmn)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
index def6cf853eea..13511716cdbc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
@@ -1,10 +1,30 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
+#define MLX5DR_DEBUG_DUMP_BUFF_SIZE (64 * 1024 * 1024)
+#define MLX5DR_DEBUG_DUMP_BUFF_LENGTH 1024
+
+enum {
+	MLX5DR_DEBUG_DUMP_STATE_FREE,
+	MLX5DR_DEBUG_DUMP_STATE_IN_PROGRESS,
+};
+
+struct mlx5dr_dbg_dump_buff {
+	char *buff;
+	u32 index;
+	struct list_head node;
+};
+
+struct mlx5dr_dbg_dump_data {
+	struct list_head buff_list;
+};
+
 struct mlx5dr_dbg_dump_info {
 	struct mutex dbg_mutex; /* protect dbg lists */
 	struct dentry *steering_debugfs;
 	struct dentry *fdb_debugfs;
+	struct mlx5dr_dbg_dump_data *dump_data;
+	atomic_t state;
 };
 
 void mlx5dr_dbg_init_dump(struct mlx5dr_domain *dmn);
-- 
2.43.0


