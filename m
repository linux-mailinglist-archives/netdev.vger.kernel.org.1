Return-Path: <netdev+bounces-73046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C585AAEA
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17BEB24115
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA25448791;
	Mon, 19 Feb 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBi1wreS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F48481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367016; cv=none; b=JJgxNaeaibMv600Pz7wm2vReX77C1Pu9/ZfdcymlRccx0CmiFu13haC5A330eIYfD7V3gtLQuSpt+tamLc+5mtJX5lGExR1DUGFcCWuIoRW+u59XTTermOM5Cb4sGt5cr0yzJIphgQV7aBUlre1cNKp3i3VxFHP2ZSrsnoU3czg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367016; c=relaxed/simple;
	bh=tmbTATcDT0i2NkUxnzvuGXwz8V9zDQ3GeIpMhNYzxjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqtUbW5MEamsdAUPweS6qOLSUvh/e2duW1FU2IOYwilGeWJO+3t2GY8KCXLCf3LUjKXy689EQ8yaSuORqlxg5JxxBGoByCLJaaXeW/afGzJsSWC5wa8omvHbynAd3XT8RQEV1vXPlGZsLkZdGBDDHgah8ApGJeewJ1NlSvGmLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBi1wreS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE98C43390;
	Mon, 19 Feb 2024 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367016;
	bh=tmbTATcDT0i2NkUxnzvuGXwz8V9zDQ3GeIpMhNYzxjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBi1wreSwn0JEh1ulZrfbAL8PrBrPBAm/dXNRnK3X7prqtNx77T5boLEX0zbiX/8J
	 HnEWpl/zE8u4PvLxn+hPnJ+Qze8PL4PzT4FKJpSdBqcS+ahJ/WZIcMS2LRH9QpgodU
	 svUky1ETB5xxHb0CEeeDIwBEZmb01OYH9Gy/ZQhVukKt5gq2IjH13QoWrOjsDQl1Hg
	 1K4N1MG4lYwueQd1dbgujtrFnFRBk/jf9cG7rSMryYBrYV9ZCJZ4YRUI66rPDaFpRN
	 090FFvSf/57GRHsFM0rY5Zn+5fAdTgGUMSHAzjPzoXtVJgI6jnP0+m3q4drV18BwJe
	 rWUPR0QFF1JCQ==
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
	Moshe Shemesh <moshe@nvidia.com>,
	Aya Levin <ayal@nvidia.com>
Subject: [net 05/10] net/mlx5: Check capability for fw_reset
Date: Mon, 19 Feb 2024 10:23:15 -0800
Message-ID: <20240219182320.8914-6-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Functions which can't access MFRL (Management Firmware Reset Level)
register, have no use of fw_reset structures or events. Remove fw_reset
structures allocation and registration for fw reset events notifications
for these functions.

Having the devlink param enable_remote_dev_reset on functions that don't
have this capability is misleading as these functions are not allowed to
influence the reset flow. Hence, this patch removes this parameter for
such functions.

In addition, return not supported on devlink reload action fw_activate
for these functions.

Fixes: 38b9f903f22b ("net/mlx5: Handle sync reset request event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  6 +++++
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 22 +++++++++++++++++--
 include/linux/mlx5/mlx5_ifc.h                 |  4 +++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe..98d4306929f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -157,6 +157,12 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return -EOPNOTSUPP;
 	}
 
+	if (action == DEVLINK_RELOAD_ACTION_FW_ACTIVATE &&
+	    !dev->priv.fw_reset) {
+		NL_SET_ERR_MSG_MOD(extack, "FW activate is unsupported for this function");
+		return -EOPNOTSUPP;
+	}
+
 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
 		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index f27eab6e4929..2911aa34a5be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -703,19 +703,30 @@ void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	MLX5_NB_INIT(&fw_reset->nb, fw_reset_event_notifier, GENERAL_EVENT);
 	mlx5_eq_notifier_register(dev, &fw_reset->nb);
 }
 
 void mlx5_fw_reset_events_stop(struct mlx5_core_dev *dev)
 {
-	mlx5_eq_notifier_unregister(dev, &dev->priv.fw_reset->nb);
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+
+	if (!fw_reset)
+		return;
+
+	mlx5_eq_notifier_unregister(dev, &fw_reset->nb);
 }
 
 void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	set_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS, &fw_reset->reset_flags);
 	cancel_work_sync(&fw_reset->fw_live_patch_work);
 	cancel_work_sync(&fw_reset->reset_request_work);
@@ -733,9 +744,13 @@ static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
 
 int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fw_reset *fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
+	struct mlx5_fw_reset *fw_reset;
 	int err;
 
+	if (!MLX5_CAP_MCAM_REG(dev, mfrl))
+		return 0;
+
+	fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
 	if (!fw_reset)
 		return -ENOMEM;
 	fw_reset->wq = create_singlethread_workqueue("mlx5_fw_reset_events");
@@ -771,6 +786,9 @@ void mlx5_fw_reset_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	devl_params_unregister(priv_to_devlink(dev),
 			       mlx5_fw_reset_devlink_params,
 			       ARRAY_SIZE(mlx5_fw_reset_devlink_params));
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c726f90ab752..b113fffd5e57 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10261,7 +10261,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 
 	u8         regs_63_to_46[0x12];
 	u8         mrtc[0x1];
-	u8         regs_44_to_32[0xd];
+	u8         regs_44_to_41[0x4];
+	u8         mfrl[0x1];
+	u8         regs_39_to_32[0x8];
 
 	u8         regs_31_to_10[0x16];
 	u8         mtmp[0x1];
-- 
2.43.2


