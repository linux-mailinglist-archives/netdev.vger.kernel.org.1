Return-Path: <netdev+bounces-248272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1972D06528
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 505CD3073789
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811B3385A6;
	Thu,  8 Jan 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm2gl/p3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9753338598
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907629; cv=none; b=RYetBPodEY/tye/LIeKtHj4Ui9DmUhTCzn4suvCPYxMWUDQkKlMlskTsvBN6389OuXO21SynBSjr9MJGrh0XgARelaKzHPPKnd6fH7lQyAwpjvxiyOV8cjlm467wfiSXQ+I8qiC376siA6s8hqKm8vVtUztpIIJ9c7OMJ5Q0NPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907629; c=relaxed/simple;
	bh=ZYkiL7oh5oOKHYsQ0T8OqBJ7F7EiYH6SKhKX4yq536Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c717mwjZ6p8cUTKMhNUotBKB0D1LPdOrrzea9MhsAMAT9Ne/PeeglDpksZZHlPf4A1HRnKFYrGu5OseTQCDWfbJNBIi+RxntltsnIAcGizFEB4yMu+lAO+jLLEOjBxYJ1ou04CdqesUDV7NB6EvvF3FUQ2UdN+v0DMnM6VKZO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm2gl/p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF0DC116C6;
	Thu,  8 Jan 2026 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767907628;
	bh=ZYkiL7oh5oOKHYsQ0T8OqBJ7F7EiYH6SKhKX4yq536Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hm2gl/p3hREqB56MW+Krb8CXCdp/SY8PWxBp2o6VW/RHpXTSwc54krFuMBsmi7o/0
	 tbjEVPEGnJdjbkPHGLDb7wS3LldZvnOPoUcL57wCFAEEpzGEU6WffuoHobiYXmDjZ1
	 BfgnoS2MacnqxekiYN69lJVvLtRubCtnUu6gIAnVcrQtOZErgnLjaYqTpsK0r+ccWc
	 yO8FKu+E/7MDBlIrABxwg0g+6K9BuGl4owA2JX3kfbI5NjVnLd+WAnX6FgujB4M5x+
	 senemMWhxd7vwPx4yc1dlHmHcnONsl+hYouqwW6ff0cdKy4mKjKxRjm8NqPofSWeSg
	 eHxcpt+FePA/g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 2/4] net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
Date: Thu,  8 Jan 2026 13:26:55 -0800
Message-ID: <20260108212657.25090-3-saeed@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108212657.25090-1-saeed@kernel.org>
References: <20260108212657.25090-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5e_priv is an unstable structure that can be memset(0) if profile
attaching fails, mlx5e_priv in mlx5e_dev devlink private is used to
reference the netdev and mdev associated with that struct. Instead,
store netdev directly into mlx5e_dev and get mdev from the containing
mlx5_adev aux device structure.

This fixes a kernel oops in mlx5e_remove when switchdev mode fails due
to change profile failure.

$ devlink dev eswitch set pci/0000:00:03.0 mode switchdev
Error: mlx5_core: Failed setting eswitch to offloads.
dmesg:
workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
mlx5_core 0012:03:00.1: mlx5e_netdev_init_profile:6214:(pid 37199): mlx5e_priv_init failed, err=-12
mlx5_core 0012:03:00.1 gpu3rdma1: mlx5e_netdev_change_profile: new profile init failed, -12
workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
mlx5_core 0012:03:00.1: mlx5e_netdev_init_profile:6214:(pid 37199): mlx5e_priv_init failed, err=-12
mlx5_core 0012:03:00.1 gpu3rdma1: mlx5e_netdev_change_profile: failed to rollback to orig profile, -12

$ devlink dev reload pci/0000:00:03.0 ==> oops

BUG: kernel NULL pointer dereference, address: 0000000000000520
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 3 UID: 0 PID: 521 Comm: devlink Not tainted 6.18.0-rc5+ #117 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:mlx5e_remove+0x68/0x130
RSP: 0018:ffffc900034838f0 EFLAGS: 00010246
RAX: ffff88810283c380 RBX: ffff888101874400 RCX: ffffffff826ffc45
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888102d789c0 R08: ffff8881007137f0 R09: ffff888100264e10
R10: ffffc90003483898 R11: ffffc900034838a0 R12: ffff888100d261a0
R13: ffff888100d261a0 R14: ffff8881018749a0 R15: ffff888101874400
FS:  00007f8565fea740(0000) GS:ffff88856a759000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000520 CR3: 000000010b11a004 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 device_release_driver_internal+0x19c/0x200
 bus_remove_device+0xc6/0x130
 device_del+0x160/0x3d0
 ? devl_param_driverinit_value_get+0x2d/0x90
 mlx5_detach_device+0x89/0xe0
 mlx5_unload_one_devl_locked+0x3a/0x70
 mlx5_devlink_reload_down+0xc8/0x220
 devlink_reload+0x7d/0x260
 devlink_nl_reload_doit+0x45b/0x5a0
 genl_family_rcv_msg_doit+0xe8/0x140

Fixes: ee75f1fc44dd ("net/mlx5e: Create separate devlink instance for ethernet auxiliary device")
Fixes: c4d7eb57687f ("net/mxl5e: Add change profile method")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 20 ++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index f42256768700..be52c30c2ad6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -962,7 +962,7 @@ struct mlx5e_priv {
 };
 
 struct mlx5e_dev {
-	struct mlx5e_priv *priv;
+	struct net_device *netdev;
 	struct devlink_port dl_port;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e50525b771bc..9f8d95f8915e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6655,8 +6655,8 @@ static int _mlx5e_resume(struct auxiliary_device *adev)
 {
 	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
-	struct mlx5e_priv *priv = mlx5e_dev->priv;
-	struct net_device *netdev = priv->netdev;
+	struct mlx5e_priv *priv = netdev_priv(mlx5e_dev->netdev);
+	struct net_device *netdev = mlx5e_dev->netdev;
 	struct mlx5_core_dev *mdev = edev->mdev;
 	struct mlx5_core_dev *pos, *to;
 	int err, i;
@@ -6702,10 +6702,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 
 static int _mlx5e_suspend(struct auxiliary_device *adev, bool pre_netdev_reg)
 {
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
-	struct mlx5e_priv *priv = mlx5e_dev->priv;
-	struct net_device *netdev = priv->netdev;
-	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5e_priv *priv = netdev_priv(mlx5e_dev->netdev);
+	struct net_device *netdev = mlx5e_dev->netdev;
+	struct mlx5_core_dev *mdev = edev->mdev;
 	struct mlx5_core_dev *pos;
 	int i;
 
@@ -6766,11 +6767,11 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 		goto err_devlink_port_unregister;
 	}
 	SET_NETDEV_DEVLINK_PORT(netdev, &mlx5e_dev->dl_port);
+	mlx5e_dev->netdev = netdev;
 
 	mlx5e_build_nic_netdev(netdev);
 
 	priv = netdev_priv(netdev);
-	mlx5e_dev->priv = priv;
 
 	priv->profile = profile;
 	priv->ppriv = NULL;
@@ -6833,7 +6834,8 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 {
 	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
-	struct mlx5e_priv *priv = mlx5e_dev->priv;
+	struct net_device *netdev = mlx5e_dev->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = edev->mdev;
 
 	mlx5_core_uplink_netdev_set(mdev, NULL);
@@ -6842,8 +6844,8 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	 * if it's from legacy mode. If from switchdev mode, it
 	 * is already unregistered before changing to NIC profile.
 	 */
-	if (priv->netdev->reg_state == NETREG_REGISTERED) {
-		unregister_netdev(priv->netdev);
+	if (netdev->reg_state == NETREG_REGISTERED) {
+		unregister_netdev(netdev);
 		_mlx5e_suspend(adev, false);
 	} else {
 		struct mlx5_core_dev *pos;
-- 
2.52.0


