Return-Path: <netdev+bounces-20581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D476029E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A34280E85
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713713AF2;
	Mon, 24 Jul 2023 22:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315814270
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04787C433BC;
	Mon, 24 Jul 2023 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238678;
	bh=O7IQiVfsnlS7zDWsrz7b95HAA+73zoCLrBJFTA4HQfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4TEyvDxaxKuJoVZpfpZsiqca/64jq++MppeS70DGdLGLTe+VNXAk1NjwcV89sx2r
	 MDWWMPN2ddsd1VyRweX+m9P/iVP1I9lTMww5WQhwn1Gz6h+jiRzcbtIvvmrd8qRig+
	 BLhrpg7Knwg57wXGEewUZEO3g5yaanbfch2jwu4pY62ZAdCzJ5Qb4UrFmQb70v6xmu
	 VR1suJ2g4iZg2N4w9Wdi99j/9Vnm6iAe40k1Qj7wXY60SFSGu2IP9rLkvPEcCg9Xpb
	 nLnjQDQQ9vMqHpT+c08oXHI/VK458O9flN+3ojFFNL5ck1NAlGUnQ6K7NMQ3wrd3xo
	 zq6mZ0dtsGZbA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 09/14] net/mlx5: split mlx5_cmd_init() to probe and reload routines
Date: Mon, 24 Jul 2023 15:44:21 -0700
Message-ID: <20230724224426.231024-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724224426.231024-1-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

There is no need to destroy and allocate cmd SW structs during reload,
this is time consuming for no reason.
Hence, split mlx5_cmd_init() to probe and reload routines.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 121 ++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  15 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 3 files changed, 82 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 9ced943ebd0d..45edd5a110c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1548,7 +1548,6 @@ static void clean_debug_files(struct mlx5_core_dev *dev)
 	if (!mlx5_debugfs_root)
 		return;
 
-	mlx5_cmdif_debugfs_cleanup(dev);
 	debugfs_remove_recursive(dbg->dbg_root);
 }
 
@@ -1563,8 +1562,6 @@ static void create_debugfs_files(struct mlx5_core_dev *dev)
 	debugfs_create_file("out_len", 0600, dbg->dbg_root, dev, &olfops);
 	debugfs_create_u8("status", 0600, dbg->dbg_root, &dbg->status);
 	debugfs_create_file("run", 0200, dbg->dbg_root, dev, &fops);
-
-	mlx5_cmdif_debugfs_init(dev);
 }
 
 void mlx5_cmd_allowed_opcode(struct mlx5_core_dev *dev, u16 opcode)
@@ -2190,19 +2187,10 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	int size = sizeof(struct mlx5_cmd_prot_block);
 	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
-	u32 cmd_h, cmd_l;
+	u32 cmd_l;
 	int err;
 	int i;
 
-	memset(cmd, 0, sizeof(*cmd));
-	cmd->vars.cmdif_rev = cmdif_rev(dev);
-	if (cmd->vars.cmdif_rev != CMD_IF_REV) {
-		mlx5_core_err(dev,
-			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
-			      CMD_IF_REV, cmd->vars.cmdif_rev);
-		return -EINVAL;
-	}
-
 	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
 	if (!cmd->pool)
 		return -ENOMEM;
@@ -2211,43 +2199,93 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_free_pool;
 
+	cmd_l = (u32)(cmd->dma);
+	if (cmd_l & 0xfff) {
+		mlx5_core_err(dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_cmd_page;
+	}
+	cmd->checksum_disabled = 1;
+
+	spin_lock_init(&cmd->alloc_lock);
+	spin_lock_init(&cmd->token_lock);
+	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
+		spin_lock_init(&cmd->stats[i].lock);
+
+	create_msg_cache(dev);
+
+	set_wqname(dev);
+	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
+	if (!cmd->wq) {
+		mlx5_core_err(dev, "failed to create command workqueue\n");
+		err = -ENOMEM;
+		goto err_cache;
+	}
+
+	mlx5_cmdif_debugfs_init(dev);
+
+	return 0;
+
+err_cache:
+	destroy_msg_cache(dev);
+err_cmd_page:
+	free_cmd_page(dev, cmd);
+err_free_pool:
+	dma_pool_destroy(cmd->pool);
+	return err;
+}
+
+void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
+{
+	struct mlx5_cmd *cmd = &dev->cmd;
+
+	mlx5_cmdif_debugfs_cleanup(dev);
+	destroy_workqueue(cmd->wq);
+	destroy_msg_cache(dev);
+	free_cmd_page(dev, cmd);
+	dma_pool_destroy(cmd->pool);
+}
+
+int mlx5_cmd_enable(struct mlx5_core_dev *dev)
+{
+	struct mlx5_cmd *cmd = &dev->cmd;
+	u32 cmd_h, cmd_l;
+
+	memset(&cmd->vars, 0, sizeof(cmd->vars));
+	cmd->vars.cmdif_rev = cmdif_rev(dev);
+	if (cmd->vars.cmdif_rev != CMD_IF_REV) {
+		mlx5_core_err(dev,
+			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
+			      CMD_IF_REV, cmd->vars.cmdif_rev);
+		return -EINVAL;
+	}
+
 	cmd_l = ioread32be(&dev->iseg->cmdq_addr_l_sz) & 0xff;
 	cmd->vars.log_sz = cmd_l >> 4 & 0xf;
 	cmd->vars.log_stride = cmd_l & 0xf;
 	if (1 << cmd->vars.log_sz > MLX5_MAX_COMMANDS) {
 		mlx5_core_err(dev, "firmware reports too many outstanding commands %d\n",
 			      1 << cmd->vars.log_sz);
-		err = -EINVAL;
-		goto err_free_page;
+		return -EINVAL;
 	}
 
 	if (cmd->vars.log_sz + cmd->vars.log_stride > MLX5_ADAPTER_PAGE_SHIFT) {
 		mlx5_core_err(dev, "command queue size overflow\n");
-		err = -EINVAL;
-		goto err_free_page;
+		return -EINVAL;
 	}
 
 	cmd->state = MLX5_CMDIF_STATE_DOWN;
-	cmd->checksum_disabled = 1;
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
 	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
 
-	spin_lock_init(&cmd->alloc_lock);
-	spin_lock_init(&cmd->token_lock);
-	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
-		spin_lock_init(&cmd->stats[i].lock);
-
 	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
 	sema_init(&cmd->vars.pages_sem, 1);
 	sema_init(&cmd->vars.throttle_sem, DIV_ROUND_UP(cmd->vars.max_reg_cmds, 2));
 
 	cmd_h = (u32)((u64)(cmd->dma) >> 32);
 	cmd_l = (u32)(cmd->dma);
-	if (cmd_l & 0xfff) {
-		mlx5_core_err(dev, "invalid command queue address\n");
-		err = -ENOMEM;
-		goto err_free_page;
-	}
+	if (WARN_ON(cmd_l & 0xfff))
+		return -EINVAL;
 
 	iowrite32be(cmd_h, &dev->iseg->cmdq_addr_h);
 	iowrite32be(cmd_l, &dev->iseg->cmdq_addr_l_sz);
@@ -2260,40 +2298,17 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	cmd->mode = CMD_MODE_POLLING;
 	cmd->allowed_opcode = CMD_ALLOWED_OPCODE_ALL;
 
-	create_msg_cache(dev);
-
-	set_wqname(dev);
-	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
-	if (!cmd->wq) {
-		mlx5_core_err(dev, "failed to create command workqueue\n");
-		err = -ENOMEM;
-		goto err_cache;
-	}
-
 	create_debugfs_files(dev);
 
 	return 0;
-
-err_cache:
-	destroy_msg_cache(dev);
-
-err_free_page:
-	free_cmd_page(dev, cmd);
-
-err_free_pool:
-	dma_pool_destroy(cmd->pool);
-	return err;
 }
 
-void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
+void mlx5_cmd_disable(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;
 
 	clean_debug_files(dev);
-	destroy_workqueue(cmd->wq);
-	destroy_msg_cache(dev);
-	free_cmd_page(dev, cmd);
-	dma_pool_destroy(cmd->pool);
+	flush_workqueue(cmd->wq);
 }
 
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5ffa8effe61a..36bc5c40630f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1142,7 +1142,7 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 		return err;
 	}
 
-	err = mlx5_cmd_init(dev);
+	err = mlx5_cmd_enable(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed initializing command interface, aborting\n");
 		return err;
@@ -1196,7 +1196,7 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 	mlx5_stop_health_poll(dev, boot);
 err_cmd_cleanup:
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
+	mlx5_cmd_disable(dev);
 
 	return err;
 }
@@ -1207,7 +1207,7 @@ static void mlx5_function_disable(struct mlx5_core_dev *dev, bool boot)
 	mlx5_core_disable_hca(dev, 0);
 	mlx5_stop_health_poll(dev, boot);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
-	mlx5_cmd_cleanup(dev);
+	mlx5_cmd_disable(dev);
 }
 
 static int mlx5_function_open(struct mlx5_core_dev *dev)
@@ -1796,6 +1796,12 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	debugfs_create_file("vhca_id", 0400, priv->dbg.dbg_root, dev, &vhca_id_fops);
 	INIT_LIST_HEAD(&priv->traps);
 
+	err = mlx5_cmd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "Failed initializing cmdif SW structs, aborting\n");
+		goto err_cmd_init;
+	}
+
 	err = mlx5_tout_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed initializing timeouts, aborting\n");
@@ -1841,6 +1847,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 err_health_init:
 	mlx5_tout_cleanup(dev);
 err_timeout_init:
+	mlx5_cmd_cleanup(dev);
+err_cmd_init:
 	debugfs_remove(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
@@ -1863,6 +1871,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	mlx5_pagealloc_cleanup(dev);
 	mlx5_health_cleanup(dev);
 	mlx5_tout_cleanup(dev);
+	mlx5_cmd_cleanup(dev);
 	debugfs_remove_recursive(dev->priv.dbg.dbg_root);
 	mutex_destroy(&priv->pgdir_mutex);
 	mutex_destroy(&priv->alloc_mutex);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 6cebc8417282..d54afb07d972 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -179,6 +179,8 @@ int mlx5_query_board_id(struct mlx5_core_dev *dev);
 int mlx5_query_module_num(struct mlx5_core_dev *dev, int *module_num);
 int mlx5_cmd_init(struct mlx5_core_dev *dev);
 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev);
+int mlx5_cmd_enable(struct mlx5_core_dev *dev);
+void mlx5_cmd_disable(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
 			enum mlx5_cmdif_state cmdif_state);
 int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id);
-- 
2.41.0


