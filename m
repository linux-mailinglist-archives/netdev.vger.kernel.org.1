Return-Path: <netdev+bounces-76791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E214C86EF08
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C408F1C21438
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12839134C9;
	Sat,  2 Mar 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBwHwxgW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF8134B9
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363015; cv=none; b=ToWA38arz0as5SDFhRQRk8rYer3SpiBNyFJAgFRy8hu53nsjNJfmLr1WXPxZ3BXcAQOpRC/Uc82PB1Y1HZYYntcTmhdq4CDNkm6QzApoz+ZBIBlLNb6WvA91eDIzqcqpyQYqPUIgMlT7TKDIixaThM+qBU0s52VoAAOzp5NNDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363015; c=relaxed/simple;
	bh=4tjgh12z3BfQQcKFpRvP3NGXj5OkkYbsFNpq5oWOerQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2B+rdQ2h/Nem7KxFEky0sdt5HFZ1sQwwrlidMh4zFXu6aj9MkJGbzRiol4LZNEqvfyzRgzUyjnqEeHUaEI1W7UpGXymUq/nEj99qqqX2n7Yx5xeA39rFjSnegNTVEvM+Ta38/bZlAJZQVNo6NwoFKODCiPTCf1wotf1ITVQFqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBwHwxgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B6C433F1;
	Sat,  2 Mar 2024 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363014;
	bh=4tjgh12z3BfQQcKFpRvP3NGXj5OkkYbsFNpq5oWOerQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBwHwxgWyNJ4lDcQR1wCzdyq1kWwD7HhOBLHwwkjO/dHOEQIHp9C/5trFR4ztCvmy
	 QlJWk3ZXa+tRpifZxENSeWVUfoKNsnmDiscHjvQOUbVJ/+2dnrUsF8PdVEHxcf/Duh
	 PCT5luZ68PvkVNsDpWUzz9VjS2b8Yi2CgyydS+WOvGkMFUhth1akPy6Hk3CLDZWrbZ
	 XyDjSbkK1yDIlT7ZWjKplO4PXAZAPEqntCcOuDPA/wwPs7dqr1PEV7YjCQtyQhCGG0
	 SFEgvQPvH61x9o4+d/ZO6GgTVok2uXejuCvzBkJhGCvOYhFGZqaWQnJe75fl47ZiqE
	 I/6p9bt+y3reQ==
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
Subject: [net V2 5/9] net/mlx5: Check capability for fw_reset
Date: Fri,  1 Mar 2024 23:03:14 -0800
Message-ID: <20240302070318.62997-6-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
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
index 3fd6310b6da6..486b7492050c 100644
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
2.44.0


