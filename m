Return-Path: <netdev+bounces-53783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F208049E0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDD9B20CB4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9315481;
	Tue,  5 Dec 2023 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAqkHUBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FCCA5C
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F246C433C7;
	Tue,  5 Dec 2023 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756829;
	bh=x0XOfwHuMqJMoTBUsQ6adS5YWxXcRUjmlTZ7HQKB7ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAqkHUBoaeHLcrNUg1onf5zHvWodTb/mHjHEDSUqc39IUn+AjFv91/PXAthGUjlGB
	 STI8E7b+/r+oMDGnAQzpdqz21kCAJTdlF/OtvbxyivtCiJVcVYcIkfotFZVl6IIXuK
	 HJkP4AXiY6vhJEG7pFqIbAGNirBwOp8qonkShhsIFBVxvxjYiwKJbQHpSNdEyNIXKd
	 O0+3z/l8+tSYVlDZuV5jWAElFJmjBbzMR1ZZTmBBE20kaXHKckKDmNtlObtYVqsUoZ
	 EH364DK4anX8VpBKdt9Dq6lGfLamrWUN+lHpOZKJwpyIfedXPTAViQyV3fzIc708xq
	 usiVWu3yVK8zQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net V2 10/14] net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
Date: Mon,  4 Dec 2023 22:13:23 -0800
Message-ID: <20231205061327.44638-11-saeed@kernel.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

Due to the cited patch, devlink health commands take devlink lock and
this may result in deadlock for mlx5e_tx_reporter as it takes local
state_lock before calling devlink health report and on the other hand
devlink health commands such as diagnose for same reporter take local
state_lock after taking devlink lock (see kernel log below).

To fix it, remove local state_lock from mlx5e_tx_timeout_work() before
calling devlink_health_report() and take care to cancel the work before
any call to close channels, which may free the SQs that should be
handled by the work. Before cancel_work_sync(), use current_work() to
check we are not calling it from within the work, as
mlx5e_tx_timeout_work() itself may close the channels and reopen as part
of recovery flow.

While removing state_lock from mlx5e_tx_timeout_work() keep rtnl_lock to
ensure no change in netdev->real_num_tx_queues, but use rtnl_trylock()
and a flag to avoid deadlock by calling cancel_work_sync() before
closing the channels while holding rtnl_lock too.

Kernel log:
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc3_for_upstream_debug_2022_08_30_13_10 #1 Not tainted
------------------------------------------------------
kworker/u16:2/65 is trying to acquire lock:
ffff888122f6c2f8 (&devlink->lock_key#2){+.+.}-{3:3}, at: devlink_health_report+0x2f1/0x7e0

but task is already holding lock:
ffff888121d20be0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_tx_timeout_work+0x70/0x280 [mlx5_core]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&priv->state_lock){+.+.}-{3:3}:
       __mutex_lock+0x12c/0x14b0
       mlx5e_rx_reporter_diagnose+0x71/0x700 [mlx5_core]
       devlink_nl_cmd_health_reporter_diagnose_doit+0x212/0xa50
       genl_family_rcv_msg_doit+0x1e9/0x2f0
       genl_rcv_msg+0x2e9/0x530
       netlink_rcv_skb+0x11d/0x340
       genl_rcv+0x24/0x40
       netlink_unicast+0x438/0x710
       netlink_sendmsg+0x788/0xc40
       sock_sendmsg+0xb0/0xe0
       __sys_sendto+0x1c1/0x290
       __x64_sys_sendto+0xdd/0x1b0
       do_syscall_64+0x3d/0x90
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #0 (&devlink->lock_key#2){+.+.}-{3:3}:
       __lock_acquire+0x2c8a/0x6200
       lock_acquire+0x1c1/0x550
       __mutex_lock+0x12c/0x14b0
       devlink_health_report+0x2f1/0x7e0
       mlx5e_health_report+0xc9/0xd7 [mlx5_core]
       mlx5e_reporter_tx_timeout+0x2ab/0x3d0 [mlx5_core]
       mlx5e_tx_timeout_work+0x1c1/0x280 [mlx5_core]
       process_one_work+0x7c2/0x1340
       worker_thread+0x59d/0xec0
       kthread+0x28f/0x330
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&priv->state_lock);
                               lock(&devlink->lock_key#2);
                               lock(&priv->state_lock);
  lock(&devlink->lock_key#2);

 *** DEADLOCK ***

4 locks held by kworker/u16:2/65:
 #0: ffff88811a55b138 ((wq_completion)mlx5e#2){+.+.}-{0:0}, at: process_one_work+0x6e2/0x1340
 #1: ffff888101de7db8 ((work_completion)(&priv->tx_timeout_work)){+.+.}-{0:0}, at: process_one_work+0x70f/0x1340
 #2: ffffffff84ce8328 (rtnl_mutex){+.+.}-{3:3}, at: mlx5e_tx_timeout_work+0x53/0x280 [mlx5_core]
 #3: ffff888121d20be0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_tx_timeout_work+0x70/0x280 [mlx5_core]

stack backtrace:
CPU: 1 PID: 65 Comm: kworker/u16:2 Not tainted 6.0.0-rc3_for_upstream_debug_2022_08_30_13_10 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5e mlx5e_tx_timeout_work [mlx5_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x7d
 check_noncircular+0x278/0x300
 ? print_circular_bug+0x460/0x460
 ? find_held_lock+0x2d/0x110
 ? __stack_depot_save+0x24c/0x520
 ? alloc_chain_hlocks+0x228/0x700
 __lock_acquire+0x2c8a/0x6200
 ? register_lock_class+0x1860/0x1860
 ? kasan_save_stack+0x1e/0x40
 ? kasan_set_free_info+0x20/0x30
 ? ____kasan_slab_free+0x11d/0x1b0
 ? kfree+0x1ba/0x520
 ? devlink_health_do_dump.part.0+0x171/0x3a0
 ? devlink_health_report+0x3d5/0x7e0
 lock_acquire+0x1c1/0x550
 ? devlink_health_report+0x2f1/0x7e0
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? find_held_lock+0x2d/0x110
 __mutex_lock+0x12c/0x14b0
 ? devlink_health_report+0x2f1/0x7e0
 ? devlink_health_report+0x2f1/0x7e0
 ? mutex_lock_io_nested+0x1320/0x1320
 ? trace_hardirqs_on+0x2d/0x100
 ? bit_wait_io_timeout+0x170/0x170
 ? devlink_health_do_dump.part.0+0x171/0x3a0
 ? kfree+0x1ba/0x520
 ? devlink_health_do_dump.part.0+0x171/0x3a0
 devlink_health_report+0x2f1/0x7e0
 mlx5e_health_report+0xc9/0xd7 [mlx5_core]
 mlx5e_reporter_tx_timeout+0x2ab/0x3d0 [mlx5_core]
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? mlx5e_reporter_tx_err_cqe+0x1b0/0x1b0 [mlx5_core]
 ? mlx5e_tx_reporter_timeout_dump+0x70/0x70 [mlx5_core]
 ? mlx5e_tx_reporter_dump_sq+0x320/0x320 [mlx5_core]
 ? mlx5e_tx_timeout_work+0x70/0x280 [mlx5_core]
 ? mutex_lock_io_nested+0x1320/0x1320
 ? process_one_work+0x70f/0x1340
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? lock_downgrade+0x6e0/0x6e0
 mlx5e_tx_timeout_work+0x1c1/0x280 [mlx5_core]
 process_one_work+0x7c2/0x1340
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? pwq_dec_nr_in_flight+0x230/0x230
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x59d/0xec0
 ? process_one_work+0x1340/0x1340
 kthread+0x28f/0x330
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: c90005b5f75c ("devlink: Hold the instance lock in health callbacks")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b2a5da9739d2..729a11b5fb25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -826,6 +826,7 @@ enum {
 	MLX5E_STATE_DESTROYING,
 	MLX5E_STATE_XDP_TX_ENABLED,
 	MLX5E_STATE_XDP_ACTIVE,
+	MLX5E_STATE_CHANNELS_ACTIVE,
 };
 
 struct mlx5e_modify_sq_param {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea58c6917433..0c87ddb8a7a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2731,6 +2731,7 @@ void mlx5e_close_channels(struct mlx5e_channels *chs)
 {
 	int i;
 
+	ASSERT_RTNL();
 	if (chs->ptp) {
 		mlx5e_ptp_close(chs->ptp);
 		chs->ptp = NULL;
@@ -3012,17 +3013,29 @@ void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
 	if (mlx5e_is_vport_rep(priv))
 		mlx5e_rep_activate_channels(priv);
 
+	set_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state);
+
 	mlx5e_wait_channels_min_rx_wqes(&priv->channels);
 
 	if (priv->rx_res)
 		mlx5e_rx_res_channels_activate(priv->rx_res, &priv->channels);
 }
 
+static void mlx5e_cancel_tx_timeout_work(struct mlx5e_priv *priv)
+{
+	WARN_ON_ONCE(test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state));
+	if (current_work() != &priv->tx_timeout_work)
+		cancel_work_sync(&priv->tx_timeout_work);
+}
+
 void mlx5e_deactivate_priv_channels(struct mlx5e_priv *priv)
 {
 	if (priv->rx_res)
 		mlx5e_rx_res_channels_deactivate(priv->rx_res);
 
+	clear_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state);
+	mlx5e_cancel_tx_timeout_work(priv);
+
 	if (mlx5e_is_vport_rep(priv))
 		mlx5e_rep_deactivate_channels(priv);
 
@@ -4801,8 +4814,17 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 	struct net_device *netdev = priv->netdev;
 	int i;
 
-	rtnl_lock();
-	mutex_lock(&priv->state_lock);
+	/* Take rtnl_lock to ensure no change in netdev->real_num_tx_queues
+	 * through this flow. However, channel closing flows have to wait for
+	 * this work to finish while holding rtnl lock too. So either get the
+	 * lock or find that channels are being closed for other reason and
+	 * this work is not relevant anymore.
+	 */
+	while (!rtnl_trylock()) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
+			return;
+		msleep(20);
+	}
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		goto unlock;
@@ -4821,7 +4843,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 	}
 
 unlock:
-	mutex_unlock(&priv->state_lock);
 	rtnl_unlock();
 }
 
-- 
2.43.0


