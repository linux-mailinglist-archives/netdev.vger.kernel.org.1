Return-Path: <netdev+bounces-20582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529117602A1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D324281666
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB21426C;
	Mon, 24 Jul 2023 22:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE514A96
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05802C433AD;
	Mon, 24 Jul 2023 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238679;
	bh=LvQH1Z4utbWxxTvvjU//9s6n3YBmLONsnPiSkvF1mHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELaVd6FxI5Z+h6/v3DthcFBQ5rnzcEM86yf2fPz1cp4LiAu1scmC59FWiIdSyBrab
	 wYdUnI4evdWf1lIaG4WlS8aFNyPCvgpLk36G6F4okLa1ONN/q7wHS53gzSDuj5KsHM
	 MtOUjV4HlUZ60ooWAHivOO4e7QBOfdBrAV6SchNvw8084aLuydSvFNOOJqsy953wj0
	 3qNP4iXgrjUqDQbmbuySWX6BQneUjuspgg3k/BckFpi5Wr3Y/bUIoeA0bcMp5n9wDu
	 yblh8UZbW1UTJ8k+8FIzrsRxrm08siW5RJqtkrNH8A1Ug35EO7v4sb/OnsUf39HsGL
	 31cAJ1YV3TUeQ==
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
Subject: [net-next 10/14] net/mlx5: Allocate command stats with xarray
Date: Mon, 24 Jul 2023 15:44:22 -0700
Message-ID: <20230724224426.231024-11-saeed@kernel.org>
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

Command stats is an array with more than 2K entries, which amounts to
~180KB. This is way more than actually needed, as only ~190 entries
are being used.

Therefore, replace the array with xarray.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 15 +++++-----
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 30 ++++++++++++++++++-
 include/linux/mlx5/driver.h                   |  2 +-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 45edd5a110c8..afb348579577 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1225,8 +1225,8 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 		goto out_free;
 
 	ds = ent->ts2 - ent->ts1;
-	if (ent->op < MLX5_CMD_OP_MAX) {
-		stats = &cmd->stats[ent->op];
+	stats = xa_load(&cmd->stats, ent->op);
+	if (stats) {
 		spin_lock_irq(&stats->lock);
 		stats->sum += ds;
 		++stats->n;
@@ -1695,8 +1695,8 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 
 			if (ent->callback) {
 				ds = ent->ts2 - ent->ts1;
-				if (ent->op < MLX5_CMD_OP_MAX) {
-					stats = &cmd->stats[ent->op];
+				stats = xa_load(&cmd->stats, ent->op);
+				if (stats) {
 					spin_lock_irqsave(&stats->lock, flags);
 					stats->sum += ds;
 					++stats->n;
@@ -1923,7 +1923,9 @@ static void cmd_status_log(struct mlx5_core_dev *dev, u16 opcode, u8 status,
 	if (!err || !(strcmp(namep, "unknown command opcode")))
 		return;
 
-	stats = &dev->cmd.stats[opcode];
+	stats = xa_load(&dev->cmd.stats, opcode);
+	if (!stats)
+		return;
 	spin_lock_irq(&stats->lock);
 	stats->failed++;
 	if (err < 0)
@@ -2189,7 +2191,6 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	struct mlx5_cmd *cmd = &dev->cmd;
 	u32 cmd_l;
 	int err;
-	int i;
 
 	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
 	if (!cmd->pool)
@@ -2209,8 +2210,6 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 
 	spin_lock_init(&cmd->alloc_lock);
 	spin_lock_init(&cmd->token_lock);
-	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
-		spin_lock_init(&cmd->stats[i].lock);
 
 	create_msg_cache(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 9a826fb3ca38..09652dc89115 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -188,6 +188,24 @@ static const struct file_operations slots_fops = {
 	.read	= slots_read,
 };
 
+static struct mlx5_cmd_stats *
+mlx5_cmdif_alloc_stats(struct xarray *stats_xa, int opcode)
+{
+	struct mlx5_cmd_stats *stats = kzalloc(sizeof(*stats), GFP_KERNEL);
+	int err;
+
+	if (!stats)
+		return NULL;
+
+	err = xa_insert(stats_xa, opcode, stats, GFP_KERNEL);
+	if (err) {
+		kfree(stats);
+		return NULL;
+	}
+	spin_lock_init(&stats->lock);
+	return stats;
+}
+
 void mlx5_cmdif_debugfs_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd_stats *stats;
@@ -200,10 +218,14 @@ void mlx5_cmdif_debugfs_init(struct mlx5_core_dev *dev)
 
 	debugfs_create_file("slots_inuse", 0400, *cmd, &dev->cmd, &slots_fops);
 
+	xa_init(&dev->cmd.stats);
+
 	for (i = 0; i < MLX5_CMD_OP_MAX; i++) {
-		stats = &dev->cmd.stats[i];
 		namep = mlx5_command_str(i);
 		if (strcmp(namep, "unknown command opcode")) {
+			stats = mlx5_cmdif_alloc_stats(&dev->cmd.stats, i);
+			if (!stats)
+				continue;
 			stats->root = debugfs_create_dir(namep, *cmd);
 
 			debugfs_create_file("average", 0400, stats->root, stats,
@@ -224,7 +246,13 @@ void mlx5_cmdif_debugfs_init(struct mlx5_core_dev *dev)
 
 void mlx5_cmdif_debugfs_cleanup(struct mlx5_core_dev *dev)
 {
+	struct mlx5_cmd_stats *stats;
+	unsigned long i;
+
 	debugfs_remove_recursive(dev->priv.dbg.cmdif_debugfs);
+	xa_for_each(&dev->cmd.stats, i, stats)
+		kfree(stats);
+	xa_destroy(&dev->cmd.stats);
 }
 
 void mlx5_cq_debugfs_init(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b0fd66ed96f8..4e34bdd0f633 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -323,7 +323,7 @@ struct mlx5_cmd {
 	struct mlx5_cmd_debug dbg;
 	struct cmd_msg_cache cache[MLX5_NUM_COMMAND_CACHES];
 	int checksum_disabled;
-	struct mlx5_cmd_stats stats[MLX5_CMD_OP_MAX];
+	struct xarray stats;
 };
 
 struct mlx5_cmd_mailbox {
-- 
2.41.0


