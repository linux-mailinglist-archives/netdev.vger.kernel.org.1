Return-Path: <netdev+bounces-126635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D669721AD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C201F23BBF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126B189B99;
	Mon,  9 Sep 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShNhj/lC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58C18990E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905588; cv=none; b=a4rnTWBvRwSV2OL/lxNhZRNCaPAM6ku8p2sCroa/QMGpkRRgwrSsorDyd2ACb2REs3nxBT2ZoREA2S1l0XiLSziYimjVScAYW+i15Hi9Oou/hKmjileqqTPNnahOy9P1RIVvSvy3TucA2jCphD/En6ojwBa0+L5MOwvmZTQck5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905588; c=relaxed/simple;
	bh=0jMFsZQ3Ae79d2qgoQMiwNk703guRannwRd1WRITumc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK53UjikhD2nDa5m7LPE57uLwI+9mVWb9QJS9wochwCex6OEHLqE6qMbRxg8nQaWwQoRAtArEErA1YqaaJI6jJ+wYMsvQb0OBJXZtIE/v60A1PaDzgFSuvW0Xb9QgGn7L+XqZt4w6cbRDLe6ZdBZfc5cGbYW1FRDVfTczfcyiUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShNhj/lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F057C4CEC5;
	Mon,  9 Sep 2024 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725905588;
	bh=0jMFsZQ3Ae79d2qgoQMiwNk703guRannwRd1WRITumc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShNhj/lCC5Hce0ni3wZRcbViLcAW8HDgxhvZBrCfCkx+fjMxEE+kSZ6rH1tXRDqK9
	 BWUavyxGUp9AkMy69XixXfbgWotWTseKrtX9TNBQZN5xIvbOq5SGYK0KXMzVPiziA9
	 m/2H1tND1Y74WOHn/KGxsUqYXO+7wz9PWRETMy7I72HrHu4FbLPJehhli6sDCP9HVL
	 c2Iw/gmWciM2yonWppolxoQjQoolXPhVE8joyi0YOp2VKD/uQIn7/WVSRBlNoHKxdN
	 +sASv/F0LGWx6r9oYmH47N6rt1gU5qGBRDkil4158SlaDVkfWT9gCXyw6d/9i5UhX2
	 Dx//PftQ1N1Cw==
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
Subject: [net-next V4 09/15] net/mlx5: HWS, added modify header pattern and args handling
Date: Mon,  9 Sep 2024 11:12:42 -0700
Message-ID: <20240909181250.41596-10-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909181250.41596-1-saeed@kernel.org>
References: <20240909181250.41596-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Packet headers/metadta manipulations are split into two parts:
 - Header Modify Pattern: an object that describes which fields
   will be modified and in which way
 - Header Modify Argument: an object that provides the values
   to be used for header modification

Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.c  | 579 ++++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.h  | 101 +++
 2 files changed, 680 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
new file mode 100644
index 000000000000..e084a5cbf81f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include "mlx5hws_internal.h"
+
+enum mlx5hws_arg_chunk_size
+mlx5hws_arg_data_size_to_arg_log_size(u16 data_size)
+{
+	/* Return the roundup of log2(data_size) */
+	if (data_size <= MLX5HWS_ARG_DATA_SIZE)
+		return MLX5HWS_ARG_CHUNK_SIZE_1;
+	if (data_size <= MLX5HWS_ARG_DATA_SIZE * 2)
+		return MLX5HWS_ARG_CHUNK_SIZE_2;
+	if (data_size <= MLX5HWS_ARG_DATA_SIZE * 4)
+		return MLX5HWS_ARG_CHUNK_SIZE_3;
+	if (data_size <= MLX5HWS_ARG_DATA_SIZE * 8)
+		return MLX5HWS_ARG_CHUNK_SIZE_4;
+
+	return MLX5HWS_ARG_CHUNK_SIZE_MAX;
+}
+
+u32 mlx5hws_arg_data_size_to_arg_size(u16 data_size)
+{
+	return BIT(mlx5hws_arg_data_size_to_arg_log_size(data_size));
+}
+
+enum mlx5hws_arg_chunk_size
+mlx5hws_arg_get_arg_log_size(u16 num_of_actions)
+{
+	return mlx5hws_arg_data_size_to_arg_log_size(num_of_actions *
+						    MLX5HWS_MODIFY_ACTION_SIZE);
+}
+
+u32 mlx5hws_arg_get_arg_size(u16 num_of_actions)
+{
+	return BIT(mlx5hws_arg_get_arg_log_size(num_of_actions));
+}
+
+bool mlx5hws_pat_require_reparse(__be64 *actions, u16 num_of_actions)
+{
+	u16 i, field;
+	u8 action_id;
+
+	for (i = 0; i < num_of_actions; i++) {
+		action_id = MLX5_GET(set_action_in, &actions[i], action_type);
+
+		switch (action_id) {
+		case MLX5_MODIFICATION_TYPE_NOP:
+			field = MLX5_MODI_OUT_NONE;
+			break;
+
+		case MLX5_MODIFICATION_TYPE_SET:
+		case MLX5_MODIFICATION_TYPE_ADD:
+			field = MLX5_GET(set_action_in, &actions[i], field);
+			break;
+
+		case MLX5_MODIFICATION_TYPE_COPY:
+		case MLX5_MODIFICATION_TYPE_ADD_FIELD:
+			field = MLX5_GET(copy_action_in, &actions[i], dst_field);
+			break;
+
+		default:
+			/* Insert/Remove/Unknown actions require reparse */
+			return true;
+		}
+
+		/* Below fields can change packet structure require a reparse */
+		if (field == MLX5_MODI_OUT_ETHERTYPE ||
+		    field == MLX5_MODI_OUT_IPV6_NEXT_HDR)
+			return true;
+	}
+
+	return false;
+}
+
+/* Cache and cache element handling */
+int mlx5hws_pat_init_pattern_cache(struct mlx5hws_pattern_cache **cache)
+{
+	struct mlx5hws_pattern_cache *new_cache;
+
+	new_cache = kzalloc(sizeof(*new_cache), GFP_KERNEL);
+	if (!new_cache)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&new_cache->ptrn_list);
+	mutex_init(&new_cache->lock);
+
+	*cache = new_cache;
+
+	return 0;
+}
+
+void mlx5hws_pat_uninit_pattern_cache(struct mlx5hws_pattern_cache *cache)
+{
+	mutex_destroy(&cache->lock);
+	kfree(cache);
+}
+
+static bool mlx5hws_pat_compare_pattern(int cur_num_of_actions,
+					__be64 cur_actions[],
+					int num_of_actions,
+					__be64 actions[])
+{
+	int i;
+
+	if (cur_num_of_actions != num_of_actions)
+		return false;
+
+	for (i = 0; i < num_of_actions; i++) {
+		u8 action_id =
+			MLX5_GET(set_action_in, &actions[i], action_type);
+
+		if (action_id == MLX5_MODIFICATION_TYPE_COPY ||
+		    action_id == MLX5_MODIFICATION_TYPE_ADD_FIELD) {
+			if (actions[i] != cur_actions[i])
+				return false;
+		} else {
+			/* Compare just the control, not the values */
+			if ((__force __be32)actions[i] !=
+			    (__force __be32)cur_actions[i])
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static struct mlx5hws_pattern_cache_item *
+mlx5hws_pat_find_cached_pattern(struct mlx5hws_pattern_cache *cache,
+				u16 num_of_actions,
+				__be64 *actions)
+{
+	struct mlx5hws_pattern_cache_item *cached_pat = NULL;
+
+	list_for_each_entry(cached_pat, &cache->ptrn_list, ptrn_list_node) {
+		if (mlx5hws_pat_compare_pattern(cached_pat->mh_data.num_of_actions,
+						(__be64 *)cached_pat->mh_data.data,
+						num_of_actions,
+						actions))
+			return cached_pat;
+	}
+
+	return NULL;
+}
+
+static struct mlx5hws_pattern_cache_item *
+mlx5hws_pat_get_existing_cached_pattern(struct mlx5hws_pattern_cache *cache,
+					u16 num_of_actions,
+					__be64 *actions)
+{
+	struct mlx5hws_pattern_cache_item *cached_pattern;
+
+	cached_pattern = mlx5hws_pat_find_cached_pattern(cache, num_of_actions, actions);
+	if (cached_pattern) {
+		/* LRU: move it to be first in the list */
+		list_del_init(&cached_pattern->ptrn_list_node);
+		list_add(&cached_pattern->ptrn_list_node, &cache->ptrn_list);
+		cached_pattern->refcount++;
+	}
+
+	return cached_pattern;
+}
+
+static struct mlx5hws_pattern_cache_item *
+mlx5hws_pat_add_pattern_to_cache(struct mlx5hws_pattern_cache *cache,
+				 u32 pattern_id,
+				 u16 num_of_actions,
+				 __be64 *actions)
+{
+	struct mlx5hws_pattern_cache_item *cached_pattern;
+
+	cached_pattern = kzalloc(sizeof(*cached_pattern), GFP_KERNEL);
+	if (!cached_pattern)
+		return NULL;
+
+	cached_pattern->mh_data.num_of_actions = num_of_actions;
+	cached_pattern->mh_data.pattern_id = pattern_id;
+	cached_pattern->mh_data.data =
+		kmemdup(actions, num_of_actions * MLX5HWS_MODIFY_ACTION_SIZE, GFP_KERNEL);
+	if (!cached_pattern->mh_data.data)
+		goto free_cached_obj;
+
+	list_add(&cached_pattern->ptrn_list_node, &cache->ptrn_list);
+	cached_pattern->refcount = 1;
+
+	return cached_pattern;
+
+free_cached_obj:
+	kfree(cached_pattern);
+	return NULL;
+}
+
+static struct mlx5hws_pattern_cache_item *
+mlx5hws_pat_find_cached_pattern_by_id(struct mlx5hws_pattern_cache *cache,
+				      u32 ptrn_id)
+{
+	struct mlx5hws_pattern_cache_item *cached_pattern = NULL;
+
+	list_for_each_entry(cached_pattern, &cache->ptrn_list, ptrn_list_node) {
+		if (cached_pattern->mh_data.pattern_id == ptrn_id)
+			return cached_pattern;
+	}
+
+	return NULL;
+}
+
+static void
+mlx5hws_pat_remove_pattern(struct mlx5hws_pattern_cache_item *cached_pattern)
+{
+	list_del_init(&cached_pattern->ptrn_list_node);
+
+	kfree(cached_pattern->mh_data.data);
+	kfree(cached_pattern);
+}
+
+void mlx5hws_pat_put_pattern(struct mlx5hws_context *ctx, u32 ptrn_id)
+{
+	struct mlx5hws_pattern_cache *cache = ctx->pattern_cache;
+	struct mlx5hws_pattern_cache_item *cached_pattern;
+
+	mutex_lock(&cache->lock);
+	cached_pattern = mlx5hws_pat_find_cached_pattern_by_id(cache, ptrn_id);
+	if (!cached_pattern) {
+		mlx5hws_err(ctx, "Failed to find cached pattern with provided ID\n");
+		pr_warn("HWS: pattern ID %d is not found\n", ptrn_id);
+		goto out;
+	}
+
+	if (--cached_pattern->refcount)
+		goto out;
+
+	mlx5hws_pat_remove_pattern(cached_pattern);
+	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, ptrn_id);
+
+out:
+	mutex_unlock(&cache->lock);
+}
+
+int mlx5hws_pat_get_pattern(struct mlx5hws_context *ctx,
+			    __be64 *pattern, size_t pattern_sz,
+			    u32 *pattern_id)
+{
+	u16 num_of_actions = pattern_sz / MLX5HWS_MODIFY_ACTION_SIZE;
+	struct mlx5hws_pattern_cache_item *cached_pattern;
+	u32 ptrn_id = 0;
+	int ret = 0;
+
+	mutex_lock(&ctx->pattern_cache->lock);
+
+	cached_pattern = mlx5hws_pat_get_existing_cached_pattern(ctx->pattern_cache,
+								 num_of_actions,
+								 pattern);
+	if (cached_pattern) {
+		*pattern_id = cached_pattern->mh_data.pattern_id;
+		goto out_unlock;
+	}
+
+	ret = mlx5hws_cmd_header_modify_pattern_create(ctx->mdev,
+						       pattern_sz,
+						       (u8 *)pattern,
+						       &ptrn_id);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed to create pattern FW object\n");
+		goto out_unlock;
+	}
+
+	cached_pattern = mlx5hws_pat_add_pattern_to_cache(ctx->pattern_cache,
+							  ptrn_id,
+							  num_of_actions,
+							  pattern);
+	if (!cached_pattern) {
+		mlx5hws_err(ctx, "Failed to add pattern to cache\n");
+		ret = -EINVAL;
+		goto clean_pattern;
+	}
+
+	mutex_unlock(&ctx->pattern_cache->lock);
+	*pattern_id = ptrn_id;
+
+	return ret;
+
+clean_pattern:
+	mlx5hws_cmd_header_modify_pattern_destroy(ctx->mdev, *pattern_id);
+out_unlock:
+	mutex_unlock(&ctx->pattern_cache->lock);
+	return ret;
+}
+
+static void
+mlx5d_arg_init_send_attr(struct mlx5hws_send_engine_post_attr *send_attr,
+			 void *comp_data,
+			 u32 arg_idx)
+{
+	send_attr->opcode = MLX5HWS_WQE_OPCODE_TBL_ACCESS;
+	send_attr->opmod = MLX5HWS_WQE_GTA_OPMOD_MOD_ARG;
+	send_attr->len = MLX5HWS_WQE_SZ_GTA_CTRL + MLX5HWS_WQE_SZ_GTA_DATA;
+	send_attr->id = arg_idx;
+	send_attr->user_data = comp_data;
+}
+
+void mlx5hws_arg_decapl3_write(struct mlx5hws_send_engine *queue,
+			       u32 arg_idx,
+			       u8 *arg_data,
+			       u16 num_of_actions)
+{
+	struct mlx5hws_send_engine_post_attr send_attr = {0};
+	struct mlx5hws_wqe_gta_data_seg_arg *wqe_arg = NULL;
+	struct mlx5hws_wqe_gta_ctrl_seg *wqe_ctrl = NULL;
+	struct mlx5hws_send_engine_post_ctrl ctrl;
+	size_t wqe_len;
+
+	mlx5d_arg_init_send_attr(&send_attr, NULL, arg_idx);
+
+	ctrl = mlx5hws_send_engine_post_start(queue);
+	mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_ctrl, &wqe_len);
+	memset(wqe_ctrl, 0, wqe_len);
+	mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_arg, &wqe_len);
+	mlx5hws_action_prepare_decap_l3_data(arg_data, (u8 *)wqe_arg,
+					     num_of_actions);
+	mlx5hws_send_engine_post_end(&ctrl, &send_attr);
+}
+
+void mlx5hws_arg_write(struct mlx5hws_send_engine *queue,
+		       void *comp_data,
+		       u32 arg_idx,
+		       u8 *arg_data,
+		       size_t data_size)
+{
+	struct mlx5hws_send_engine_post_attr send_attr = {0};
+	struct mlx5hws_wqe_gta_data_seg_arg *wqe_arg;
+	struct mlx5hws_send_engine_post_ctrl ctrl;
+	struct mlx5hws_wqe_gta_ctrl_seg *wqe_ctrl;
+	int i, full_iter, leftover;
+	size_t wqe_len;
+
+	mlx5d_arg_init_send_attr(&send_attr, comp_data, arg_idx);
+
+	/* Each WQE can hold 64B of data, it might require multiple iteration */
+	full_iter = data_size / MLX5HWS_ARG_DATA_SIZE;
+	leftover = data_size & (MLX5HWS_ARG_DATA_SIZE - 1);
+
+	for (i = 0; i < full_iter; i++) {
+		ctrl = mlx5hws_send_engine_post_start(queue);
+		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_ctrl, &wqe_len);
+		memset(wqe_ctrl, 0, wqe_len);
+		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_arg, &wqe_len);
+		memcpy(wqe_arg, arg_data, wqe_len);
+		send_attr.id = arg_idx++;
+		mlx5hws_send_engine_post_end(&ctrl, &send_attr);
+
+		/* Move to next argument data */
+		arg_data += MLX5HWS_ARG_DATA_SIZE;
+	}
+
+	if (leftover) {
+		ctrl = mlx5hws_send_engine_post_start(queue);
+		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_ctrl, &wqe_len);
+		memset(wqe_ctrl, 0, wqe_len);
+		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_arg, &wqe_len);
+		memcpy(wqe_arg, arg_data, leftover);
+		send_attr.id = arg_idx;
+		mlx5hws_send_engine_post_end(&ctrl, &send_attr);
+	}
+}
+
+int mlx5hws_arg_write_inline_arg_data(struct mlx5hws_context *ctx,
+				      u32 arg_idx,
+				      u8 *arg_data,
+				      size_t data_size)
+{
+	struct mlx5hws_send_engine *queue;
+	int ret;
+
+	mutex_lock(&ctx->ctrl_lock);
+
+	/* Get the control queue */
+	queue = &ctx->send_queue[ctx->queues - 1];
+
+	mlx5hws_arg_write(queue, arg_data, arg_idx, arg_data, data_size);
+
+	mlx5hws_send_engine_flush_queue(queue);
+
+	/* Poll for completion */
+	ret = mlx5hws_send_queue_action(ctx, ctx->queues - 1,
+					MLX5HWS_SEND_QUEUE_ACTION_DRAIN_SYNC);
+
+	if (ret)
+		mlx5hws_err(ctx, "Failed to drain arg queue\n");
+
+	mutex_unlock(&ctx->ctrl_lock);
+
+	return ret;
+}
+
+bool mlx5hws_arg_is_valid_arg_request_size(struct mlx5hws_context *ctx,
+					   u32 arg_size)
+{
+	if (arg_size < ctx->caps->log_header_modify_argument_granularity ||
+	    arg_size > ctx->caps->log_header_modify_argument_max_alloc) {
+		return false;
+	}
+	return true;
+}
+
+int mlx5hws_arg_create(struct mlx5hws_context *ctx,
+		       u8 *data,
+		       size_t data_sz,
+		       u32 log_bulk_sz,
+		       bool write_data,
+		       u32 *arg_id)
+{
+	u16 single_arg_log_sz;
+	u16 multi_arg_log_sz;
+	int ret;
+	u32 id;
+
+	single_arg_log_sz = mlx5hws_arg_data_size_to_arg_log_size(data_sz);
+	multi_arg_log_sz = single_arg_log_sz + log_bulk_sz;
+
+	if (single_arg_log_sz >= MLX5HWS_ARG_CHUNK_SIZE_MAX) {
+		mlx5hws_err(ctx, "Requested single arg %u not supported\n", single_arg_log_sz);
+		return -EOPNOTSUPP;
+	}
+
+	if (!mlx5hws_arg_is_valid_arg_request_size(ctx, multi_arg_log_sz)) {
+		mlx5hws_err(ctx, "Argument log size %d not supported by FW\n", multi_arg_log_sz);
+		return -EOPNOTSUPP;
+	}
+
+	/* Alloc bulk of args */
+	ret = mlx5hws_cmd_arg_create(ctx->mdev, multi_arg_log_sz, ctx->pd_num, &id);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed allocating arg in order: %d\n", multi_arg_log_sz);
+		return ret;
+	}
+
+	if (write_data) {
+		ret = mlx5hws_arg_write_inline_arg_data(ctx, id,
+							data, data_sz);
+		if (ret) {
+			mlx5hws_err(ctx, "Failed writing arg data\n");
+			mlx5hws_cmd_arg_destroy(ctx->mdev, id);
+			return ret;
+		}
+	}
+
+	*arg_id = id;
+	return ret;
+}
+
+void mlx5hws_arg_destroy(struct mlx5hws_context *ctx, u32 arg_id)
+{
+	mlx5hws_cmd_arg_destroy(ctx->mdev, arg_id);
+}
+
+int mlx5hws_arg_create_modify_header_arg(struct mlx5hws_context *ctx,
+					 __be64 *data,
+					 u8 num_of_actions,
+					 u32 log_bulk_sz,
+					 bool write_data,
+					 u32 *arg_id)
+{
+	size_t data_sz = num_of_actions * MLX5HWS_MODIFY_ACTION_SIZE;
+	int ret;
+
+	ret = mlx5hws_arg_create(ctx,
+				 (u8 *)data,
+				 data_sz,
+				 log_bulk_sz,
+				 write_data,
+				 arg_id);
+	if (ret)
+		mlx5hws_err(ctx, "Failed creating modify header arg\n");
+
+	return ret;
+}
+
+static int
+hws_action_modify_check_field_limitation(u8 action_type, __be64 *pattern)
+{
+	/* Need to check field limitation here, but for now - return OK */
+	return 0;
+}
+
+#define INVALID_FIELD 0xffff
+
+static void
+hws_action_modify_get_target_fields(u8 action_type, __be64 *pattern,
+				    u16 *src_field, u16 *dst_field)
+{
+	switch (action_type) {
+	case MLX5_ACTION_TYPE_SET:
+	case MLX5_ACTION_TYPE_ADD:
+		*src_field = MLX5_GET(set_action_in, pattern, field);
+		*dst_field = INVALID_FIELD;
+		break;
+	case MLX5_ACTION_TYPE_COPY:
+		*src_field = MLX5_GET(copy_action_in, pattern, src_field);
+		*dst_field = MLX5_GET(copy_action_in, pattern, dst_field);
+		break;
+	default:
+		pr_warn("HWS: invalid modify header action type %d\n", action_type);
+	}
+}
+
+bool mlx5hws_pat_verify_actions(struct mlx5hws_context *ctx, __be64 pattern[], size_t sz)
+{
+	size_t i;
+
+	for (i = 0; i < sz / MLX5HWS_MODIFY_ACTION_SIZE; i++) {
+		u8 action_type =
+			MLX5_GET(set_action_in, &pattern[i], action_type);
+		if (action_type >= MLX5_MODIFICATION_TYPE_MAX) {
+			mlx5hws_err(ctx, "Unsupported action id %d\n", action_type);
+			return false;
+		}
+		if (hws_action_modify_check_field_limitation(action_type, &pattern[i])) {
+			mlx5hws_err(ctx, "Unsupported action number %zu\n", i);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions,
+			   size_t max_actions, size_t *new_size,
+			   u32 *nope_location, __be64 *new_pat)
+{
+	u16 prev_src_field = 0, prev_dst_field = 0;
+	u16 src_field, dst_field;
+	u8 action_type;
+	size_t i, j;
+
+	*new_size = num_actions;
+	*nope_location = 0;
+
+	if (num_actions == 1)
+		return;
+
+	for (i = 0, j = 0; i < num_actions; i++, j++) {
+		action_type = MLX5_GET(set_action_in, &pattern[i], action_type);
+
+		hws_action_modify_get_target_fields(action_type, &pattern[i],
+						    &src_field, &dst_field);
+		if (i % 2) {
+			if (action_type == MLX5_ACTION_TYPE_COPY &&
+			    (prev_src_field == src_field ||
+			     prev_dst_field == dst_field)) {
+				/* need Nope */
+				*new_size += 1;
+				*nope_location |= BIT(i);
+				memset(&new_pat[j], 0, MLX5HWS_MODIFY_ACTION_SIZE);
+				MLX5_SET(set_action_in, &new_pat[j],
+					 action_type,
+					 MLX5_MODIFICATION_TYPE_NOP);
+				j++;
+			} else if (prev_src_field == src_field) {
+				/* need Nope*/
+				*new_size += 1;
+				*nope_location |= BIT(i);
+				MLX5_SET(set_action_in, &new_pat[j],
+					 action_type,
+					 MLX5_MODIFICATION_TYPE_NOP);
+				j++;
+			}
+		}
+		memcpy(&new_pat[j], &pattern[i], MLX5HWS_MODIFY_ACTION_SIZE);
+		/* check if no more space */
+		if (j > max_actions) {
+			*new_size = num_actions;
+			*nope_location = 0;
+			return;
+		}
+
+		prev_src_field = src_field;
+		prev_dst_field = dst_field;
+	}
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h
new file mode 100644
index 000000000000..27ca93385b08
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef MLX5HWS_PAT_ARG_H_
+#define MLX5HWS_PAT_ARG_H_
+
+/* Modify-header arg pool */
+enum mlx5hws_arg_chunk_size {
+	MLX5HWS_ARG_CHUNK_SIZE_1,
+	/* Keep MIN updated when changing */
+	MLX5HWS_ARG_CHUNK_SIZE_MIN = MLX5HWS_ARG_CHUNK_SIZE_1,
+	MLX5HWS_ARG_CHUNK_SIZE_2,
+	MLX5HWS_ARG_CHUNK_SIZE_3,
+	MLX5HWS_ARG_CHUNK_SIZE_4,
+	MLX5HWS_ARG_CHUNK_SIZE_MAX,
+};
+
+enum {
+	MLX5HWS_MODIFY_ACTION_SIZE = 8,
+	MLX5HWS_ARG_DATA_SIZE = 64,
+};
+
+struct mlx5hws_pattern_cache {
+	struct mutex lock; /* Protect pattern list */
+	struct list_head ptrn_list;
+};
+
+struct mlx5hws_pattern_cache_item {
+	struct {
+		u32 pattern_id;
+		u8 *data;
+		u16 num_of_actions;
+	} mh_data;
+	u32 refcount;
+	struct list_head ptrn_list_node;
+};
+
+enum mlx5hws_arg_chunk_size
+mlx5hws_arg_get_arg_log_size(u16 num_of_actions);
+
+u32 mlx5hws_arg_get_arg_size(u16 num_of_actions);
+
+enum mlx5hws_arg_chunk_size
+mlx5hws_arg_data_size_to_arg_log_size(u16 data_size);
+
+u32 mlx5hws_arg_data_size_to_arg_size(u16 data_size);
+
+int mlx5hws_pat_init_pattern_cache(struct mlx5hws_pattern_cache **cache);
+
+void mlx5hws_pat_uninit_pattern_cache(struct mlx5hws_pattern_cache *cache);
+
+bool mlx5hws_pat_verify_actions(struct mlx5hws_context *ctx, __be64 pattern[], size_t sz);
+
+int mlx5hws_arg_create(struct mlx5hws_context *ctx,
+		       u8 *data,
+		       size_t data_sz,
+		       u32 log_bulk_sz,
+		       bool write_data,
+		       u32 *arg_id);
+
+void mlx5hws_arg_destroy(struct mlx5hws_context *ctx, u32 arg_id);
+
+int mlx5hws_arg_create_modify_header_arg(struct mlx5hws_context *ctx,
+					 __be64 *data,
+					 u8 num_of_actions,
+					 u32 log_bulk_sz,
+					 bool write_data,
+					 u32 *modify_hdr_arg_id);
+
+int mlx5hws_pat_get_pattern(struct mlx5hws_context *ctx,
+			    __be64 *pattern,
+			    size_t pattern_sz,
+			    u32 *ptrn_id);
+
+void mlx5hws_pat_put_pattern(struct mlx5hws_context *ctx,
+			     u32 ptrn_id);
+
+bool mlx5hws_arg_is_valid_arg_request_size(struct mlx5hws_context *ctx,
+					   u32 arg_size);
+
+bool mlx5hws_pat_require_reparse(__be64 *actions, u16 num_of_actions);
+
+void mlx5hws_arg_write(struct mlx5hws_send_engine *queue,
+		       void *comp_data,
+		       u32 arg_idx,
+		       u8 *arg_data,
+		       size_t data_size);
+
+void mlx5hws_arg_decapl3_write(struct mlx5hws_send_engine *queue,
+			       u32 arg_idx,
+			       u8 *arg_data,
+			       u16 num_of_actions);
+
+int mlx5hws_arg_write_inline_arg_data(struct mlx5hws_context *ctx,
+				      u32 arg_idx,
+				      u8 *arg_data,
+				      size_t data_size);
+
+void mlx5hws_pat_calc_nope(__be64 *pattern, size_t num_actions, size_t max_actions,
+			   size_t *new_size, u32 *nope_location, __be64 *new_pat);
+#endif /* MLX5HWS_PAT_ARG_H_ */
-- 
2.46.0


