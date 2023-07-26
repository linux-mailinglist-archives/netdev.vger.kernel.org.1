Return-Path: <netdev+bounces-21642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE230764145
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD2B1C21460
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9081CA07;
	Wed, 26 Jul 2023 21:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486B1C9E8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76178C433C7;
	Wed, 26 Jul 2023 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407143;
	bh=CgUyZmis0VMA367SpiMQDsPWOhu4JbgZWxZQ0YN1Kmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YK4KmrmZvhpPODVal+GOfefT8cHxuBZk9cOLV+Xp9v2+In1ZyJ6Bu3W/r73KqEcuY
	 zPkQlhc5+XYFA44Q0snZtvYaaMwErvf0I/FnMoSOgAG8dIc4Z3wUeEE8FlYrlHognD
	 WeAWkq4MUuMpNd3+oX+s22XzTLleAwUWbwcRX4ZnucQa5VKGjNDDY9mfZjc4vk5wCI
	 3ilvesdQ0IbG2izTL9fwOESv2CJjPOtKF3XxCJC2P2h8jjyodl6GN+Es5hJQwtyFon
	 /PFLjT/0PmHmcWFJocystNjzaWDYPFz3bE/yfkIty0rF2P9XGsDc9ZlT7RIRLEjX3k
	 VcWfTu8KOCbgg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [net 15/15] net/mlx5: Unregister devlink params in case interface is down
Date: Wed, 26 Jul 2023 14:32:06 -0700
Message-ID: <20230726213206.47022-16-saeed@kernel.org>
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

From: Shay Drory <shayd@nvidia.com>

Currently, in case an interface is down, mlx5 driver doesn't
unregister its devlink params, which leads to this WARN[1].
Fix it by unregistering devlink params in that case as well.

[1]
[  295.244769 ] WARNING: CPU: 15 PID: 1 at net/core/devlink.c:9042 devlink_free+0x174/0x1fc
[  295.488379 ] CPU: 15 PID: 1 Comm: shutdown Tainted: G S         OE 5.15.0-1017.19.3.g0677e61-bluefield #g0677e61
[  295.509330 ] Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.2.0.12761 Jun  6 2023
[  295.543096 ] pc : devlink_free+0x174/0x1fc
[  295.551104 ] lr : mlx5_devlink_free+0x18/0x2c [mlx5_core]
[  295.561816 ] sp : ffff80000809b850
[  295.711155 ] Call trace:
[  295.716030 ]  devlink_free+0x174/0x1fc
[  295.723346 ]  mlx5_devlink_free+0x18/0x2c [mlx5_core]
[  295.733351 ]  mlx5_sf_dev_remove+0x98/0xb0 [mlx5_core]
[  295.743534 ]  auxiliary_bus_remove+0x2c/0x50
[  295.751893 ]  __device_release_driver+0x19c/0x280
[  295.761120 ]  device_release_driver+0x34/0x50
[  295.769649 ]  bus_remove_device+0xdc/0x170
[  295.777656 ]  device_del+0x17c/0x3a4
[  295.784620 ]  mlx5_sf_dev_remove+0x28/0xf0 [mlx5_core]
[  295.794800 ]  mlx5_sf_dev_table_destroy+0x98/0x110 [mlx5_core]
[  295.806375 ]  mlx5_unload+0x34/0xd0 [mlx5_core]
[  295.815339 ]  mlx5_unload_one+0x70/0xe4 [mlx5_core]
[  295.824998 ]  shutdown+0xb0/0xd8 [mlx5_core]
[  295.833439 ]  pci_device_shutdown+0x3c/0xa0
[  295.841651 ]  device_shutdown+0x170/0x340
[  295.849486 ]  __do_sys_reboot+0x1f4/0x2a0
[  295.857322 ]  __arm64_sys_reboot+0x2c/0x40
[  295.865329 ]  invoke_syscall+0x78/0x100
[  295.872817 ]  el0_svc_common.constprop.0+0x54/0x184
[  295.882392 ]  do_el0_svc+0x30/0xac
[  295.889008 ]  el0_svc+0x48/0x160
[  295.895278 ]  el0t_64_sync_handler+0xa4/0x130
[  295.903807 ]  el0t_64_sync+0x1a4/0x1a8
[  295.911120 ] ---[ end trace 4f1d2381d00d9dce  ]---

Fixes: fe578cbb2f05 ("net/mlx5: Move devlink registration before mlx5_load")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 88dbea6631d5..f42abc2ea73c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1506,6 +1506,7 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
 		mlx5_core_warn(dev, "%s: interface is down, NOP\n",
 			       __func__);
+		mlx5_devlink_params_unregister(priv_to_devlink(dev));
 		mlx5_cleanup_once(dev);
 		goto out;
 	}
-- 
2.41.0


