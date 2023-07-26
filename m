Return-Path: <netdev+bounces-21634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764176413A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13024281FD6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61C1AA9A;
	Wed, 26 Jul 2023 21:32:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0C1AA73
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85720C43397;
	Wed, 26 Jul 2023 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407135;
	bh=bn0lpWP6MiIclyx0ob2tQdUZEeEdmXm2x4z1le93RFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zw0j7WAzQzopX69xFXDgQ+wrK33igKk1KQCQ8qKTVDSQ3tpG5UrO+vUQKz8YJ6Vaz
	 YjElzbGBcCuUxEaRt9hq6hT+WV1oe0CKq3BSEm09eROHZ7j6Y4oDCAqWO0H9Zr/Mr5
	 QBPSIoXYdYCvoKWMtNbthQvLlFCeQ0YplwvWMGaJ+RV+Eo1WZot3BhkXkwcyedHBFV
	 Cxmu2SJmhGhay8BzpCQ4d14HpFE6EGsACDcjQC9LrC0FptXjS6+TgnnfHSDwkP5yoy
	 OtByn459ynizPXCWYlqiOm8OJr9mOadpM6jsgp6xWbVYCTjxfRwVHf0Gb0GmpqxI+c
	 tNBIVf0tnyKtA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Amir Tzin <amirtz@nvidia.com>,
	Aya Levin <ayal@nvidia.com>
Subject: [net 07/15] net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set
Date: Wed, 26 Jul 2023 14:31:58 -0700
Message-ID: <20230726213206.47022-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Tzin <amirtz@nvidia.com>

Moving to switchdev mode with ntuple offload on causes the kernel to
crash since fs->arfs is freed during nic profile cleanup flow.

Ntuple offload is not supported in switchdev mode and it is already
unset by mlx5 fix feature ndo in switchdev mode. Verify fs->arfs is
valid before disabling it.

trace:
[] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
[] arfs_del_rules+0x44/0x1a0 [mlx5_core]
[] mlx5e_arfs_disable+0xe/0x20 [mlx5_core]
[] mlx5e_handle_feature+0x3d/0xb0 [mlx5_core]
[] ? __rtnl_unlock+0x25/0x50
[] mlx5e_set_features+0xfe/0x160 [mlx5_core]
[] __netdev_update_features+0x278/0xa50
[] ? netdev_run_todo+0x5e/0x2a0
[] netdev_update_features+0x22/0x70
[] ? _cond_resched+0x15/0x30
[] mlx5e_attach_netdev+0x12a/0x1e0 [mlx5_core]
[] mlx5e_netdev_attach_profile+0xa1/0xc0 [mlx5_core]
[] mlx5e_netdev_change_profile+0x77/0xe0 [mlx5_core]
[] mlx5e_vport_rep_load+0x1ed/0x290 [mlx5_core]
[] mlx5_esw_offloads_rep_load+0x88/0xd0 [mlx5_core]
[] esw_offloads_load_rep.part.38+0x31/0x50 [mlx5_core]
[] esw_offloads_enable+0x6c5/0x710 [mlx5_core]
[] mlx5_eswitch_enable_locked+0x1bb/0x290 [mlx5_core]
[] mlx5_devlink_eswitch_mode_set+0x14f/0x320 [mlx5_core]
[] devlink_nl_cmd_eswitch_set_doit+0x94/0x120
[] genl_family_rcv_msg_doit.isra.17+0x113/0x150
[] genl_family_rcv_msg+0xb7/0x170
[] ? devlink_nl_cmd_port_split_doit+0x100/0x100
[] genl_rcv_msg+0x47/0xa0
[] ? genl_family_rcv_msg+0x170/0x170
[] netlink_rcv_skb+0x4c/0x130
[] genl_rcv+0x24/0x40
[] netlink_unicast+0x19a/0x230
[] netlink_sendmsg+0x204/0x3d0
[] sock_sendmsg+0x50/0x60

Fixes: 90b22b9bcd24 ("net/mlx5e: Disable Rx ntuple offload for uplink representor")
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 933a7772a7a3..5aa51d74f8b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -135,6 +135,16 @@ static void arfs_del_rules(struct mlx5e_flow_steering *fs);
 
 int mlx5e_arfs_disable(struct mlx5e_flow_steering *fs)
 {
+	/* Moving to switchdev mode, fs->arfs is freed by mlx5e_nic_profile
+	 * cleanup_rx callback and it is not recreated when
+	 * mlx5e_uplink_rep_profile is loaded as mlx5e_create_flow_steering()
+	 * is not called by the uplink_rep profile init_rx callback. Thus, if
+	 * ntuple is set, moving to switchdev flow will enter this function
+	 * with fs->arfs nullified.
+	 */
+	if (!mlx5e_fs_get_arfs(fs))
+		return 0;
+
 	arfs_del_rules(fs);
 
 	return arfs_disable(fs);
-- 
2.41.0


