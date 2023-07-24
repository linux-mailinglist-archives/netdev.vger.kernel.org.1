Return-Path: <netdev+bounces-20579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E733176029A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AF01C20C53
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E512B61;
	Mon, 24 Jul 2023 22:44:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7F13AD2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0644C433CA;
	Mon, 24 Jul 2023 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238676;
	bh=m1eGtlzLj+SqrcRGGkXepPdy0sK09BPr8adU1RLvvu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdHrmHLkmLHIjW85Whu8z9MukpdxEmwQ7nmTwq3TbGrk9DpuFm0584wpSDHFe0e/E
	 czFtbiwS2CCNj3TXZersYGhgI6fZyQ9R3DrUnHJRH2pqI19upMbYvvsPdyzkaLzbge
	 lWjT0PU/gmgeetCm0JBYGm1gTwobwzrJ2FBH82hQSVCawT4bfjTeWrh5UBAIuWUlKF
	 pdtRRr9QIIOXtd8Etmh6AWA4QGdIMlnQNvBmUhuwUxF4tm4Vhi89875YGLdBY90bpX
	 1PF3G/wgRxJs6EDAYAzkjLUKNSmw67/jtZumVkpC9/IdwX1RmihQr06E2aJ1Y7cbX9
	 rG03J5YdMx8Mg==
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
Subject: [net-next 07/14] net/mlx5: Re-organize mlx5_cmd struct
Date: Mon, 24 Jul 2023 15:44:19 -0700
Message-ID: <20230724224426.231024-8-saeed@kernel.org>
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

Downstream patch will split mlx5_cmd_init() to probe and reload
routines. As a preparation, organize mlx5_cmd struct so that any
field that will be used in the reload routine are grouped at new
nested struct.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 94 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  4 +-
 include/linux/mlx5/driver.h                   | 21 +++--
 3 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index d532883b42d7..f175af528fe0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -162,18 +162,18 @@ static int cmd_alloc_index(struct mlx5_cmd *cmd)
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
-	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
-	if (ret < cmd->max_reg_cmds)
-		clear_bit(ret, &cmd->bitmask);
+	ret = find_first_bit(&cmd->vars.bitmask, cmd->vars.max_reg_cmds);
+	if (ret < cmd->vars.max_reg_cmds)
+		clear_bit(ret, &cmd->vars.bitmask);
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
-	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
+	return ret < cmd->vars.max_reg_cmds ? ret : -ENOMEM;
 }
 
 static void cmd_free_index(struct mlx5_cmd *cmd, int idx)
 {
 	lockdep_assert_held(&cmd->alloc_lock);
-	set_bit(idx, &cmd->bitmask);
+	set_bit(idx, &cmd->vars.bitmask);
 }
 
 static void cmd_ent_get(struct mlx5_cmd_work_ent *ent)
@@ -192,7 +192,7 @@ static void cmd_ent_put(struct mlx5_cmd_work_ent *ent)
 
 	if (ent->idx >= 0) {
 		cmd_free_index(cmd, ent->idx);
-		up(ent->page_queue ? &cmd->pages_sem : &cmd->sem);
+		up(ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem);
 	}
 
 	cmd_free_ent(ent);
@@ -202,7 +202,7 @@ static void cmd_ent_put(struct mlx5_cmd_work_ent *ent)
 
 static struct mlx5_cmd_layout *get_inst(struct mlx5_cmd *cmd, int idx)
 {
-	return cmd->cmd_buf + (idx << cmd->log_stride);
+	return cmd->cmd_buf + (idx << cmd->vars.log_stride);
 }
 
 static int mlx5_calc_cmd_blocks(struct mlx5_cmd_msg *msg)
@@ -974,7 +974,7 @@ static void cmd_work_handler(struct work_struct *work)
 	cb_timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
 
 	complete(&ent->handling);
-	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
+	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
 	down(sem);
 	if (!ent->page_queue) {
 		alloc_ret = cmd_alloc_index(cmd);
@@ -994,9 +994,9 @@ static void cmd_work_handler(struct work_struct *work)
 		}
 		ent->idx = alloc_ret;
 	} else {
-		ent->idx = cmd->max_reg_cmds;
+		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
-		clear_bit(ent->idx, &cmd->bitmask);
+		clear_bit(ent->idx, &cmd->vars.bitmask);
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
@@ -1572,15 +1572,15 @@ void mlx5_cmd_allowed_opcode(struct mlx5_core_dev *dev, u16 opcode)
 	struct mlx5_cmd *cmd = &dev->cmd;
 	int i;
 
-	for (i = 0; i < cmd->max_reg_cmds; i++)
-		down(&cmd->sem);
-	down(&cmd->pages_sem);
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++)
+		down(&cmd->vars.sem);
+	down(&cmd->vars.pages_sem);
 
 	cmd->allowed_opcode = opcode;
 
-	up(&cmd->pages_sem);
-	for (i = 0; i < cmd->max_reg_cmds; i++)
-		up(&cmd->sem);
+	up(&cmd->vars.pages_sem);
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++)
+		up(&cmd->vars.sem);
 }
 
 static void mlx5_cmd_change_mod(struct mlx5_core_dev *dev, int mode)
@@ -1588,15 +1588,15 @@ static void mlx5_cmd_change_mod(struct mlx5_core_dev *dev, int mode)
 	struct mlx5_cmd *cmd = &dev->cmd;
 	int i;
 
-	for (i = 0; i < cmd->max_reg_cmds; i++)
-		down(&cmd->sem);
-	down(&cmd->pages_sem);
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++)
+		down(&cmd->vars.sem);
+	down(&cmd->vars.pages_sem);
 
 	cmd->mode = mode;
 
-	up(&cmd->pages_sem);
-	for (i = 0; i < cmd->max_reg_cmds; i++)
-		up(&cmd->sem);
+	up(&cmd->vars.pages_sem);
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++)
+		up(&cmd->vars.sem);
 }
 
 static int cmd_comp_notifier(struct notifier_block *nb,
@@ -1655,7 +1655,7 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 
 	/* there can be at most 32 command queues */
 	vector = vec & 0xffffffff;
-	for (i = 0; i < (1 << cmd->log_sz); i++) {
+	for (i = 0; i < (1 << cmd->vars.log_sz); i++) {
 		if (test_bit(i, &vector)) {
 			ent = cmd->ent_arr[i];
 
@@ -1744,7 +1744,7 @@ static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 	/* wait for pending handlers to complete */
 	mlx5_eq_synchronize_cmd_irq(dev);
 	spin_lock_irqsave(&dev->cmd.alloc_lock, flags);
-	vector = ~dev->cmd.bitmask & ((1ul << (1 << dev->cmd.log_sz)) - 1);
+	vector = ~dev->cmd.vars.bitmask & ((1ul << (1 << dev->cmd.vars.log_sz)) - 1);
 	if (!vector)
 		goto no_trig;
 
@@ -1753,14 +1753,14 @@ static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 	 * to guarantee pending commands will not get freed in the meanwhile.
 	 * For that reason, it also has to be done inside the alloc_lock.
 	 */
-	for_each_set_bit(i, &bitmask, (1 << cmd->log_sz))
+	for_each_set_bit(i, &bitmask, (1 << cmd->vars.log_sz))
 		cmd_ent_get(cmd->ent_arr[i]);
 	vector |= MLX5_TRIGGERED_CMD_COMP;
 	spin_unlock_irqrestore(&dev->cmd.alloc_lock, flags);
 
 	mlx5_core_dbg(dev, "vector 0x%llx\n", vector);
 	mlx5_cmd_comp_handler(dev, vector, true);
-	for_each_set_bit(i, &bitmask, (1 << cmd->log_sz))
+	for_each_set_bit(i, &bitmask, (1 << cmd->vars.log_sz))
 		cmd_ent_put(cmd->ent_arr[i]);
 	return;
 
@@ -1773,22 +1773,22 @@ void mlx5_cmd_flush(struct mlx5_core_dev *dev)
 	struct mlx5_cmd *cmd = &dev->cmd;
 	int i;
 
-	for (i = 0; i < cmd->max_reg_cmds; i++) {
-		while (down_trylock(&cmd->sem)) {
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++) {
+		while (down_trylock(&cmd->vars.sem)) {
 			mlx5_cmd_trigger_completions(dev);
 			cond_resched();
 		}
 	}
 
-	while (down_trylock(&cmd->pages_sem)) {
+	while (down_trylock(&cmd->vars.pages_sem)) {
 		mlx5_cmd_trigger_completions(dev);
 		cond_resched();
 	}
 
 	/* Unlock cmdif */
-	up(&cmd->pages_sem);
-	for (i = 0; i < cmd->max_reg_cmds; i++)
-		up(&cmd->sem);
+	up(&cmd->vars.pages_sem);
+	for (i = 0; i < cmd->vars.max_reg_cmds; i++)
+		up(&cmd->vars.sem);
 }
 
 static struct mlx5_cmd_msg *alloc_msg(struct mlx5_core_dev *dev, int in_size,
@@ -1858,7 +1858,7 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 		/* atomic context may not sleep */
 		if (callback)
 			return -EINVAL;
-		down(&dev->cmd.throttle_sem);
+		down(&dev->cmd.vars.throttle_sem);
 	}
 
 	pages_queue = is_manage_pages(in);
@@ -1903,7 +1903,7 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 	free_msg(dev, inb);
 out_up:
 	if (throttle_op)
-		up(&dev->cmd.throttle_sem);
+		up(&dev->cmd.vars.throttle_sem);
 	return err;
 }
 
@@ -2213,16 +2213,16 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 		goto err_free_pool;
 
 	cmd_l = ioread32be(&dev->iseg->cmdq_addr_l_sz) & 0xff;
-	cmd->log_sz = cmd_l >> 4 & 0xf;
-	cmd->log_stride = cmd_l & 0xf;
-	if (1 << cmd->log_sz > MLX5_MAX_COMMANDS) {
+	cmd->vars.log_sz = cmd_l >> 4 & 0xf;
+	cmd->vars.log_stride = cmd_l & 0xf;
+	if (1 << cmd->vars.log_sz > MLX5_MAX_COMMANDS) {
 		mlx5_core_err(dev, "firmware reports too many outstanding commands %d\n",
-			      1 << cmd->log_sz);
+			      1 << cmd->vars.log_sz);
 		err = -EINVAL;
 		goto err_free_page;
 	}
 
-	if (cmd->log_sz + cmd->log_stride > MLX5_ADAPTER_PAGE_SHIFT) {
+	if (cmd->vars.log_sz + cmd->vars.log_stride > MLX5_ADAPTER_PAGE_SHIFT) {
 		mlx5_core_err(dev, "command queue size overflow\n");
 		err = -EINVAL;
 		goto err_free_page;
@@ -2230,13 +2230,13 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 
 	cmd->state = MLX5_CMDIF_STATE_DOWN;
 	cmd->checksum_disabled = 1;
-	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
-	cmd->bitmask = (1UL << cmd->max_reg_cmds) - 1;
+	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
+	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
 
-	cmd->cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
-	if (cmd->cmdif_rev > CMD_IF_REV) {
+	cmd->vars.cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
+	if (cmd->vars.cmdif_rev > CMD_IF_REV) {
 		mlx5_core_err(dev, "driver does not support command interface version. driver %d, firmware %d\n",
-			      CMD_IF_REV, cmd->cmdif_rev);
+			      CMD_IF_REV, cmd->vars.cmdif_rev);
 		err = -EOPNOTSUPP;
 		goto err_free_page;
 	}
@@ -2246,9 +2246,9 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
 		spin_lock_init(&cmd->stats[i].lock);
 
-	sema_init(&cmd->sem, cmd->max_reg_cmds);
-	sema_init(&cmd->pages_sem, 1);
-	sema_init(&cmd->throttle_sem, DIV_ROUND_UP(cmd->max_reg_cmds, 2));
+	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
+	sema_init(&cmd->vars.pages_sem, 1);
+	sema_init(&cmd->vars.throttle_sem, DIV_ROUND_UP(cmd->vars.max_reg_cmds, 2));
 
 	cmd_h = (u32)((u64)(cmd->dma) >> 32);
 	cmd_l = (u32)(cmd->dma);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 2138f28a2931..9a826fb3ca38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -176,8 +176,8 @@ static ssize_t slots_read(struct file *filp, char __user *buf, size_t count,
 	int ret;
 
 	cmd = filp->private_data;
-	weight = bitmap_weight(&cmd->bitmask, cmd->max_reg_cmds);
-	field = cmd->max_reg_cmds - weight;
+	weight = bitmap_weight(&cmd->vars.bitmask, cmd->vars.max_reg_cmds);
+	field = cmd->vars.max_reg_cmds - weight;
 	ret = snprintf(tbuf, sizeof(tbuf), "%d\n", field);
 	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 23c0ed57479a..b0fd66ed96f8 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -288,18 +288,23 @@ struct mlx5_cmd_stats {
 struct mlx5_cmd {
 	struct mlx5_nb    nb;
 
+	/* members which needs to be queried or reinitialized each reload */
+	struct {
+		u16		cmdif_rev;
+		u8		log_sz;
+		u8		log_stride;
+		int		max_reg_cmds;
+		unsigned long	bitmask;
+		struct semaphore sem;
+		struct semaphore pages_sem;
+		struct semaphore throttle_sem;
+	} vars;
 	enum mlx5_cmdif_state	state;
 	void	       *cmd_alloc_buf;
 	dma_addr_t	alloc_dma;
 	int		alloc_size;
 	void	       *cmd_buf;
 	dma_addr_t	dma;
-	u16		cmdif_rev;
-	u8		log_sz;
-	u8		log_stride;
-	int		max_reg_cmds;
-	int		events;
-	u32 __iomem    *vector;
 
 	/* protect command queue allocations
 	 */
@@ -309,12 +314,8 @@ struct mlx5_cmd {
 	 */
 	spinlock_t	token_lock;
 	u8		token;
-	unsigned long	bitmask;
 	char		wq_name[MLX5_CMD_WQ_MAX_NAME];
 	struct workqueue_struct *wq;
-	struct semaphore sem;
-	struct semaphore pages_sem;
-	struct semaphore throttle_sem;
 	int	mode;
 	u16     allowed_opcode;
 	struct mlx5_cmd_work_ent *ent_arr[MLX5_MAX_COMMANDS];
-- 
2.41.0


