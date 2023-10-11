Return-Path: <netdev+bounces-40099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A37C5B85
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2EF1C209D7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC11CA95;
	Wed, 11 Oct 2023 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4KT1Zfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268B3FF1
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73843C433CA;
	Wed, 11 Oct 2023 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697049932;
	bh=2q/4DaPr/qfw+fQZANMCDJAHL2oEU8maMAGvU21u1Ro=;
	h=From:To:Cc:Subject:Date:From;
	b=O4KT1ZfjuUwNKNJP/9ks5ROdoGJ27GxOksoa+Mbdqi5qaZsNzmku/mshnceJyJPMk
	 +SAY1A5y5OkIeUmDxqGO098JV55DA5dK5qMRqHta71BlhCGGU+AlHmkQAAKPXCrzaF
	 uHiyiEz/x/MeGMtaL5qmNXzLocR0MXbdb2MuLFzQ1JRkITvybS9rShaOHBTl+KKgGC
	 JGsqMRMpLotKPJhTBDMZsxxfiWjrWDzyFNYvgnb5+Jr1mV2WAb97a7dnSpGTC/LVTY
	 WI92JBD6nklBrMSZ11LZcZgB79FSaZ11fdJwb0OSGSneTC1pE6OyHulImKA60XyX9C
	 UmuTL7Rs0eQGQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC PATCH net] net/mlx5: Perform DMA operations cleanup before pci_disable_device()
Date: Wed, 11 Oct 2023 11:45:11 -0700
Message-ID: <20231011184511.19818-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

The cited patch change mlx5 driver so that during probe, DMA
operations were performed before pci_enable_device() and during
teardown, DMA operations were performed after pci_disable_device().
DMA operations require PCI to be enabled. Hence, The above leads to
the following oops in PPC systems[2].

Fix it by performing the DMA operations during probe, after
pci_enable_device() and during teardown, before pci_disable_device().

This also fixes a problem reported by Niklas Schnelle [1]

[1] https://lore.kernel.org/lkml/20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com/

[2]
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: xt_MASQUERADE nf_conntrack_netlink
nfnetlink xfrm_user iptable_nat xt_addrtype xt_conntrack nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 netconsole rpcsec_gss_krb5
auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser ib_umad
rdma_cm ib_ipoib iw_cm libiscsi scsi_transport_iscsi ib_cm ib_uverbs
ib_core mlx5_core(-) ptp pps_core fuse vmx_crypto crc32c_vpmsum [last
unloaded: mlx5_ib]
CPU: 1 PID: 8937 Comm: modprobe Not tainted 6.5.0-rc3_for_upstream_min_debug_2023_07_31_16_02 #1
Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
NIP:  c000000000423388 LR: c0000000001e733c CTR: c0000000001e4720
REGS: c0000000055636d0 TRAP: 0380   Not tainted (6.5.0-rc3_for_upstream_min_debug_2023_07_31_16_02)
MSR:  8000000000009033  CR: 24008884  XER: 20040000
CFAR: c0000000001e7338 IRQMASK: 0
NIP [c000000000423388] __free_pages+0x28/0x160
LR [c0000000001e733c] dma_direct_free+0xac/0x190
Call Trace:
[c000000005563970] [5deadbeef0000100] 0x5deadbeef0000100 (unreliable)
[c0000000055639b0] [c0000000003d46cc] kfree+0x7c/0x150
[c000000005563a40] [c0000000001e47c8] dma_free_attrs+0xa8/0x1a0
[c000000005563aa0] [c008000000d0064c] mlx5_cmd_cleanup+0xa4/0x100 [mlx5_core]
[c000000005563ad0] [c008000000cf629c] mlx5_mdev_uninit+0xf4/0x140 [mlx5_core]
[c000000005563b00] [c008000000cf6448] remove_one+0x160/0x1d0 [mlx5_core]
[c000000005563b40] [c000000000958540] pci_device_remove+0x60/0x110
[c000000005563b80] [c000000000a35e80] device_remove+0x70/0xd0
[c000000005563bb0] [c000000000a37a38] device_release_driver_internal+0x2a8/0x330
[c000000005563c00] [c000000000a37b8c] driver_detach+0x8c/0x160
[c000000005563c40] [c000000000a35350] bus_remove_driver+0x90/0x110
[c000000005563c80] [c000000000a38948] driver_unregister+0x48/0x90
[c000000005563cf0] [c000000000957e38] pci_unregister_driver+0x38/0x150
[c000000005563d40] [c008000000eb6140] mlx5_cleanup+0x38/0x90 [mlx5_core]

Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>
CC: Niklas Schnelle <schnelle@linux.ibm.com>

---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 62 ++++++++-----------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index afb348579577..dd36d9cba62f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -2186,52 +2186,23 @@ static u16 cmdif_rev(struct mlx5_core_dev *dev)

 int mlx5_cmd_init(struct mlx5_core_dev *dev)
 {
-	int size = sizeof(struct mlx5_cmd_prot_block);
-	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
-	u32 cmd_l;
-	int err;
-
-	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
-	if (!cmd->pool)
-		return -ENOMEM;

-	err = alloc_cmd_page(dev, cmd);
-	if (err)
-		goto err_free_pool;
-
-	cmd_l = (u32)(cmd->dma);
-	if (cmd_l & 0xfff) {
-		mlx5_core_err(dev, "invalid command queue address\n");
-		err = -ENOMEM;
-		goto err_cmd_page;
-	}
 	cmd->checksum_disabled = 1;

 	spin_lock_init(&cmd->alloc_lock);
 	spin_lock_init(&cmd->token_lock);

-	create_msg_cache(dev);
-
 	set_wqname(dev);
 	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
 	if (!cmd->wq) {
 		mlx5_core_err(dev, "failed to create command workqueue\n");
-		err = -ENOMEM;
-		goto err_cache;
+		return -ENOMEM;
 	}

 	mlx5_cmdif_debugfs_init(dev);

 	return 0;
-
-err_cache:
-	destroy_msg_cache(dev);
-err_cmd_page:
-	free_cmd_page(dev, cmd);
-err_free_pool:
-	dma_pool_destroy(cmd->pool);
-	return err;
 }

 void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)
@@ -2240,15 +2211,15 @@ void mlx5_cmd_cleanup(struct mlx5_core_dev *dev)

 	mlx5_cmdif_debugfs_cleanup(dev);
 	destroy_workqueue(cmd->wq);
-	destroy_msg_cache(dev);
-	free_cmd_page(dev, cmd);
-	dma_pool_destroy(cmd->pool);
 }

 int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 {
+	int size = sizeof(struct mlx5_cmd_prot_block);
+	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
 	u32 cmd_h, cmd_l;
+	int err;

 	memset(&cmd->vars, 0, sizeof(cmd->vars));
 	cmd->vars.cmdif_rev = cmdif_rev(dev);
@@ -2281,10 +2252,21 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 	sema_init(&cmd->vars.pages_sem, 1);
 	sema_init(&cmd->vars.throttle_sem, DIV_ROUND_UP(cmd->vars.max_reg_cmds, 2));

+	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
+	if (!cmd->pool)
+		return -ENOMEM;
+
+	err = alloc_cmd_page(dev, cmd);
+	if (err)
+		goto err_free_pool;
+
 	cmd_h = (u32)((u64)(cmd->dma) >> 32);
 	cmd_l = (u32)(cmd->dma);
-	if (WARN_ON(cmd_l & 0xfff))
-		return -EINVAL;
+	if (cmd_l & 0xfff) {
+		mlx5_core_err(dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_cmd_page;
+	}

 	iowrite32be(cmd_h, &dev->iseg->cmdq_addr_h);
 	iowrite32be(cmd_l, &dev->iseg->cmdq_addr_l_sz);
@@ -2297,16 +2279,26 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 	cmd->mode = CMD_MODE_POLLING;
 	cmd->allowed_opcode = CMD_ALLOWED_OPCODE_ALL;

+	create_msg_cache(dev);
 	create_debugfs_files(dev);

 	return 0;
+
+err_cmd_page:
+	free_cmd_page(dev, cmd);
+err_free_pool:
+	dma_pool_destroy(cmd->pool);
+	return err;
 }

 void mlx5_cmd_disable(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;

+	destroy_msg_cache(dev);
 	clean_debug_files(dev);
+	free_cmd_page(dev, cmd);
+	dma_pool_destroy(cmd->pool);
 	flush_workqueue(cmd->wq);
 }

--
2.41.0


