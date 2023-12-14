Return-Path: <netdev+bounces-57180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B3812503
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E9E1C214AC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F6A59;
	Thu, 14 Dec 2023 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iISJOdFF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A115BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FC0C433C9;
	Thu, 14 Dec 2023 02:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519724;
	bh=XJjSNIE8eYywN6Xedqg4WEz9LYb3JsMFeHQHGZSnWQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iISJOdFFfkVoScgpWF+Rh2Tq5hZhUKvHS6xlOGXkL3grPt2PmdXkrPCHt9NdRyB4z
	 Y52QM6N+httKOILJeC7CAVWhvpjHN4gfr4HoA7471gM/F6O7eDoHitY6rIe284Y4zW
	 /JEduDE+TuYxdaMyeBMlgMU3I50mp7QcI7vKktBUd5CX0C+f3//qI1zkSKMw98P4el
	 /ARUhhdMhg77S7ZlFkjJdlovDqYgWiEAjYQ3xujH80Ra6sf0Y7MoqpXpyWI3Af3U+J
	 lp/SDOYxNi9VzZ7vVOOoumZMdsz89CQmFLlk/YPbHHmpUWVX30gvRUM9Cf+8BMEcRz
	 vKAZzF+lsvWgg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 04/11] net/mlx5: fs, Command to control TX flow table root
Date: Wed, 13 Dec 2023 18:08:25 -0800
Message-ID: <20231214020832.50703-5-saeed@kernel.org>
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

Introduce an API to set/unset the TX flow table root for a device.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 20 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 8438ecabff84..1616a6144f7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1158,3 +1158,23 @@ int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mo
 
 	return mlx5_cmd_exec_in(dev, set_l2_table_entry, in);
 }
+
+int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, bool disconnect)
+{
+	u32 out[MLX5_ST_SZ_DW(set_flow_table_root_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(set_flow_table_root_in)] = {};
+
+	if (disconnect && MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(set_flow_table_root_in, in, opcode,
+		 MLX5_CMD_OP_SET_FLOW_TABLE_ROOT);
+	MLX5_SET(set_flow_table_root_in, in, table_type,
+		 FS_FT_NIC_TX);
+	if (disconnect)
+		MLX5_SET(set_flow_table_root_in, in, op_mod, 1);
+	else
+		MLX5_SET(set_flow_table_root_in, in, table_id, ft_id);
+
+	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index f553719a02a0..53e0e5137d3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -123,4 +123,5 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default(enum fs_flow_table_type typ
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_fw_cmds(void);
 
 int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mode);
+int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, bool disconnect);
 #endif
-- 
2.43.0


