Return-Path: <netdev+bounces-27494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8877C293
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F5D1C20B86
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85F100AD;
	Mon, 14 Aug 2023 21:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3E100A0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F6CC433AB;
	Mon, 14 Aug 2023 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049313;
	bh=dJBGJsm+NMzFsFg6tAofMW0qR6sRbbbI2BqyKCb/fzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcQoGmTopO7r2H6a8YohEy4coehTuEWOjZ4zRL1aa77RlF3bNpLzXkgtm4/9uygxc
	 POZ2HdP0XsDDfImmmLBJTu9SqL+n9rWZAJyHHAJWmKyfFYSum/nJlaxzy8+mtlEYkB
	 NulMfN8aPPEvYUP84sE337ub8cvfA4T4UZ/tdU4bEC/grnLT2Xz+3Rr3UK2+al9cZa
	 fjlE1se72v2ZQ8+85ClIRRT7j2jUGDp6hRzVQajBndUwQbDx8cFC728ZdZo5o3KPwU
	 vsyfkJ5GtRbMNonAC7pl4qKON4cDSMtxZ7SZcFcngyzk1a67+UVybEJ34UliwJ4k0W
	 FuGgvLu1GYRYA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 05/14] net/mlx5: Check with FW that sync reset completed successfully
Date: Mon, 14 Aug 2023 14:41:35 -0700
Message-ID: <20230814214144.159464-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Even if the PF driver had no error on his part of the sync reset flow,
the firmware can see wider picture as it syncs all the PFs in the flow.
So add at end of sync reset flow check with firmware by reading MFRL
register and initialization segment that the flow had no issue from
firmware point of view too.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  3 ++
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 39 ++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |  2 +
 include/linux/mlx5/mlx5_ifc.h                 |  3 +-
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3d82ec890666..af8460bb257b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -212,6 +212,9 @@ static int mlx5_devlink_reload_up(struct devlink *devlink, enum devlink_reload_a
 		/* On fw_activate action, also driver is reloaded and reinit performed */
 		*actions_performed |= BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 		ret = mlx5_load_one_devl_locked(dev, true);
+		if (ret)
+			return ret;
+		ret = mlx5_fw_reset_verify_fw_complete(dev, extack);
 		break;
 	default:
 		/* Unsupported action should not get to this function */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4804990b7f22..e87766f91150 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -127,17 +127,23 @@ static int mlx5_fw_reset_get_reset_state_err(struct mlx5_core_dev *dev,
 	if (mlx5_reg_mfrl_query(dev, NULL, NULL, &reset_state))
 		goto out;
 
+	if (!reset_state)
+		return 0;
+
 	switch (reset_state) {
 	case MLX5_MFRL_REG_RESET_STATE_IN_NEGOTIATION:
 	case MLX5_MFRL_REG_RESET_STATE_RESET_IN_PROGRESS:
-		NL_SET_ERR_MSG_MOD(extack, "Sync reset was already triggered");
+		NL_SET_ERR_MSG_MOD(extack, "Sync reset still in progress");
 		return -EBUSY;
-	case MLX5_MFRL_REG_RESET_STATE_TIMEOUT:
-		NL_SET_ERR_MSG_MOD(extack, "Sync reset got timeout");
+	case MLX5_MFRL_REG_RESET_STATE_NEG_TIMEOUT:
+		NL_SET_ERR_MSG_MOD(extack, "Sync reset negotiation timeout");
 		return -ETIMEDOUT;
 	case MLX5_MFRL_REG_RESET_STATE_NACK:
 		NL_SET_ERR_MSG_MOD(extack, "One of the hosts disabled reset");
 		return -EPERM;
+	case MLX5_MFRL_REG_RESET_STATE_UNLOAD_TIMEOUT:
+		NL_SET_ERR_MSG_MOD(extack, "Sync reset unload timeout");
+		return -ETIMEDOUT;
 	}
 
 out:
@@ -151,7 +157,7 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	u32 out[MLX5_ST_SZ_DW(mfrl_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(mfrl_reg)] = {};
-	int err;
+	int err, rst_res;
 
 	set_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags);
 
@@ -164,13 +170,34 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 		return 0;
 
 	clear_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags);
-	if (err == -EREMOTEIO && MLX5_CAP_MCAM_FEATURE(dev, reset_state))
-		return mlx5_fw_reset_get_reset_state_err(dev, extack);
+	if (err == -EREMOTEIO && MLX5_CAP_MCAM_FEATURE(dev, reset_state)) {
+		rst_res = mlx5_fw_reset_get_reset_state_err(dev, extack);
+		return rst_res ? rst_res : err;
+	}
 
 	NL_SET_ERR_MSG_MOD(extack, "Sync reset command failed");
 	return mlx5_cmd_check(dev, err, in, out);
 }
 
+int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
+				     struct netlink_ext_ack *extack)
+{
+	u8 rst_state;
+	int err;
+
+	err = mlx5_fw_reset_get_reset_state_err(dev, extack);
+	if (err)
+		return err;
+
+	rst_state = mlx5_get_fw_rst_state(dev);
+	if (!rst_state)
+		return 0;
+
+	mlx5_core_err(dev, "Sync reset did not complete, state=%d\n", rst_state);
+	NL_SET_ERR_MSG_MOD(extack, "Sync reset did not complete successfully");
+	return rst_state;
+}
+
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 {
 	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL0, 0, 0, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
index c57465595f7c..ea527d06a85f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -12,6 +12,8 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev);
 
 int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev);
+int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
+				     struct netlink_ext_ack *extack);
 void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev);
 void mlx5_fw_reset_events_stop(struct mlx5_core_dev *dev);
 void mlx5_drain_fw_reset(struct mlx5_core_dev *dev);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 87fd6f9ed82c..9aed7e9b9f29 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10858,8 +10858,9 @@ enum {
 	MLX5_MFRL_REG_RESET_STATE_IDLE = 0,
 	MLX5_MFRL_REG_RESET_STATE_IN_NEGOTIATION = 1,
 	MLX5_MFRL_REG_RESET_STATE_RESET_IN_PROGRESS = 2,
-	MLX5_MFRL_REG_RESET_STATE_TIMEOUT = 3,
+	MLX5_MFRL_REG_RESET_STATE_NEG_TIMEOUT = 3,
 	MLX5_MFRL_REG_RESET_STATE_NACK = 4,
+	MLX5_MFRL_REG_RESET_STATE_UNLOAD_TIMEOUT = 5,
 };
 
 enum {
-- 
2.41.0


