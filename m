Return-Path: <netdev+bounces-57179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E92812501
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DF1C20F78
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D87EE;
	Thu, 14 Dec 2023 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNz0mw3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8C1368
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBFCC433C8;
	Thu, 14 Dec 2023 02:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519723;
	bh=+he7gf5G/c4V4cllVzvbk9dzMR6riS0rWjbDgx9C9Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNz0mw3QBcqpGKw83FURJfyjeBNdxp1dsIuAR8Z36PQueRcsWFsEEGVJm+oCkg7Nc
	 +EbrtnHnZaOALMrQWu4y+2oqXCWGS0FEpHBeP2tWoRNJmUkKDJnSZsFhfACWYXYutp
	 KbEtu0LYQVSFIzUbrD0840b+fAvmvY0wUXUEBOL5QjvK48CnZYUPzKJhtC3HLSXdba
	 4v8G/FrVYw3Ze2ANb0ajb07Yqxl9pZe19j/2cex/g+6q2448CIqwzKbcWJE9Xb9ldL
	 xiDFM4Q9K+6rw0nYeG93prBDHwfRnQZG9tZzxz1BAZs1pvBdUxaJnh6A+ZV9FwXFEV
	 uEVPRa4PQBMmw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 03/11] net/mlx5: fs, Command to control L2TABLE entry silent mode
Date: Wed, 13 Dec 2023 18:08:24 -0800
Message-ID: <20231214020832.50703-4-saeed@kernel.org>
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

Introduce an API to set/unset the L2TABLE entry silent mode for a
device. If silent, no north/south traffic is allowed, the device won't
be able to communicate with the port directly to send/receive traffic by
its own.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index a4b925331661..8438ecabff84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1144,3 +1144,17 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default(enum fs_flow_table_type typ
 		return mlx5_fs_cmd_get_stub_cmds();
 	}
 }
+
+int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mode)
+{
+	u32 in[MLX5_ST_SZ_DW(set_l2_table_entry_in)] = {};
+
+	if (silent_mode && !MLX5_CAP_GEN(dev, silent_mode))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(set_l2_table_entry_in, in, opcode, MLX5_CMD_OP_SET_L2_TABLE_ENTRY);
+	MLX5_SET(set_l2_table_entry_in, in, silent_mode_valid, 1);
+	MLX5_SET(set_l2_table_entry_in, in, silent_mode, silent_mode);
+
+	return mlx5_cmd_exec_in(dev, set_l2_table_entry, in);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index 7790ae5531e1..f553719a02a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -122,4 +122,5 @@ int mlx5_cmd_fc_bulk_query(struct mlx5_core_dev *dev, u32 base_id, int bulk_len,
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default(enum fs_flow_table_type type);
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_fw_cmds(void);
 
+int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mode);
 #endif
-- 
2.43.0


