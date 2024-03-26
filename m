Return-Path: <netdev+bounces-82124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4C88C595
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A9B25650
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862213C8F2;
	Tue, 26 Mar 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZICLlkJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482813C666
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464424; cv=none; b=BB21N5SDXtBc4rBoKEQ80O9AdWhqsQz5Agr+9Otbx5jbDGkqyFkYY76YSVNY9jW3V5Bxc4IaUYPrsE74LHkuS101E4+xpJXl1wrJz6Cze13WA9eIolAx8QPa9kWLxcZ0PUDFAw5CSZwzFLBtk+ckzz5LfsgIFa7h3TvmDfmjNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464424; c=relaxed/simple;
	bh=oblu9EvmQTQpj1KFzD7wrNRmOXsl3wbhZkrpxMtHhDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHRlydmjP8es2YjVhATQHMgZHZKsACt/Uye8OqAHizipsHlQ1acVznh4wdW5e+9BlsR26e0vIwZ1kTFIRMz18tNP7ll6JHotanJzym1v5E6KILaQ0/RhMBH+Xztw3xl8T62JfXmHkPvG5RECqGvMjAifL5KYxFxaq/Bm5DtWl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZICLlkJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A6CC433F1;
	Tue, 26 Mar 2024 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464423;
	bh=oblu9EvmQTQpj1KFzD7wrNRmOXsl3wbhZkrpxMtHhDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZICLlkJ8P0VGyESitSCOGlLFMVaYGjBJcaI6/yBf3wRuxDkOBJXszH2wduJqC0J7B
	 MMLuxdUwPfOcpk8DVGzmJsVak2VOXnCz1QL7dKH2VbHuzUPCFg6L4GJtiGpWEZbu0c
	 LFjTNYeS1ouxP07I6XlbXJEqsTPMMdZZMAtAy3FGPdHT4LSwLtEjjZ2BKyouRtI34v
	 HbuIqRG0eSCFRoFqChQLJ7f8iWTC4Zuf/b1ezo0Q4+08KAVlpLiOKBPJ/AG7z7h57r
	 O1fJKpeNyBrLRDDNyauRdUqN7GU+T67L5PrruH3bt+Abno3xh+sApIWXvIFnLmj9LY
	 EM1PNwkV02uOQ==
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
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 07/10] net/mlx5e: Fix mlx5e_priv_init() cleanup flow
Date: Tue, 26 Mar 2024 07:46:43 -0700
Message-ID: <20240326144646.2078893-8-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

When mlx5e_priv_init() fails, the cleanup flow calls mlx5e_selq_cleanup which
calls mlx5e_selq_apply() that assures that the `priv->state_lock` is held using
lockdep_is_held().

Acquire the state_lock in mlx5e_selq_cleanup().

Kernel log:
=============================
WARNING: suspicious RCU usage
6.8.0-rc3_net_next_841a9b5 #1 Not tainted
-----------------------------
drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:124 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by systemd-modules/293:
 #0: ffffffffa05067b0 (devices_rwsem){++++}-{3:3}, at: ib_register_client+0x109/0x1b0 [ib_core]
 #1: ffff8881096c65c0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x104/0x1c0 [ib_core]

stack backtrace:
CPU: 4 PID: 293 Comm: systemd-modules Not tainted 6.8.0-rc3_net_next_841a9b5 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x8a/0xa0
 lockdep_rcu_suspicious+0x154/0x1a0
 mlx5e_selq_apply+0x94/0xa0 [mlx5_core]
 mlx5e_selq_cleanup+0x3a/0x60 [mlx5_core]
 mlx5e_priv_init+0x2be/0x2f0 [mlx5_core]
 mlx5_rdma_setup_rn+0x7c/0x1a0 [mlx5_core]
 rdma_init_netdev+0x4e/0x80 [ib_core]
 ? mlx5_rdma_netdev_free+0x70/0x70 [mlx5_core]
 ipoib_intf_init+0x64/0x550 [ib_ipoib]
 ipoib_intf_alloc+0x4e/0xc0 [ib_ipoib]
 ipoib_add_one+0xb0/0x360 [ib_ipoib]
 add_client_context+0x112/0x1c0 [ib_core]
 ib_register_client+0x166/0x1b0 [ib_core]
 ? 0xffffffffa0573000
 ipoib_init_module+0xeb/0x1a0 [ib_ipoib]
 do_one_initcall+0x61/0x250
 do_init_module+0x8a/0x270
 init_module_from_file+0x8b/0xd0
 idempotent_init_module+0x17d/0x230
 __x64_sys_finit_module+0x61/0xb0
 do_syscall_64+0x71/0x140
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
 </TASK>

Fixes: 8bf30be75069 ("net/mlx5e: Introduce select queue parameters")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
index f675b1926340..f66bbc846464 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
@@ -57,6 +57,7 @@ int mlx5e_selq_init(struct mlx5e_selq *selq, struct mutex *state_lock)
 
 void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 {
+	mutex_lock(selq->state_lock);
 	WARN_ON_ONCE(selq->is_prepared);
 
 	kvfree(selq->standby);
@@ -67,6 +68,7 @@ void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 
 	kvfree(selq->standby);
 	selq->standby = NULL;
+	mutex_unlock(selq->state_lock);
 }
 
 void mlx5e_selq_prepare_params(struct mlx5e_selq *selq, struct mlx5e_params *params)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 91848eae4565..b375ef268671 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5726,9 +5726,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	kfree(priv->tx_rates);
 	kfree(priv->txq2sq);
 	destroy_workqueue(priv->wq);
-	mutex_lock(&priv->state_lock);
 	mlx5e_selq_cleanup(&priv->selq);
-	mutex_unlock(&priv->state_lock);
 	free_cpumask_var(priv->scratchpad.cpumask);
 
 	for (i = 0; i < priv->htb_max_qos_sqs; i++)
-- 
2.44.0


