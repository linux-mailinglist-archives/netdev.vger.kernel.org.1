Return-Path: <netdev+bounces-127557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4125975B96
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC043282513
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23F71BCA06;
	Wed, 11 Sep 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku3GTcZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE11BCA03
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085892; cv=none; b=Ldt+h57vdPCws+P//KvqyIjdDifevJntsAGqC235HIemcWesiJaoLjE+9Os9tMWHqTQgpU4QCxjuN2O2YYxJQ6wR7WwQV9qIx2f4brGLnjj1H4kZzuAA9GU6U8gzQhOuYk8ZhKx4IONSivw/nlrC/uHXY9NbJUp7TTBnvwiD7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085892; c=relaxed/simple;
	bh=+mKWEhrW3JZFLhDi1U5P+R+9vnoXBFNaKGthBmrityE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHQs5dmzY7J7W7oIzgo+hENQZlNlZZH2+XdfTdXELVvbf21juOLNsodxWB23D6pE5YSRvEaum4pSotg49JKiWbsfLiBEmHNUAtn4xPtCiWeszP7wPlF9lwfqcU3rBtM2f8bNUX6vsv/sgn+Su5iB1tmkcLXjKrIuRZtltK+aJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku3GTcZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C02C4CEC6;
	Wed, 11 Sep 2024 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085892;
	bh=+mKWEhrW3JZFLhDi1U5P+R+9vnoXBFNaKGthBmrityE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ku3GTcZD4J8l1wzyYdVTublECCXjRfoPknp+Wk3005+37WgocC/DkYO0bIwFi5g89
	 hM4vwoYP7g6YSC5Usl1USbXjVkb9+ctF1IXu4Kfm8jWkW1FKhZEPexr6BEcthcqZA1
	 hM0XgaGCeh2uBSxfmztHnaxSJpTqczrTzMTpUj69q8G/saKlOUPFz6j4Rse7+/Hded
	 27IIKCif0hb7ORzHt5q+KR2e5E+6qohaCqgrAN9BNmGQ48caWUNww6fEwGMlwjMCF8
	 c+XpVOQ1fT5Rz2S/hPQAO9+QoS14sMVqLMsU68ijzRWaPyyGiXX6z6ac2EDpAeZIOt
	 cjf6w/IACCE5A==
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
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 13/15] net/mlx5: Add NOT_READY command return status
Date: Wed, 11 Sep 2024 13:17:55 -0700
Message-ID: <20240911201757.1505453-14-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Add a new command status MLX5_CMD_STAT_NOT_READY to handle cases
where the firmware is not ready.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 ++++++-
 include/linux/mlx5/device.h                   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 20768ef2e9d2..9af8ddb4a78f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -754,6 +754,8 @@ static const char *cmd_status_str(u8 status)
 		return "bad resource";
 	case MLX5_CMD_STAT_RES_BUSY:
 		return "resource busy";
+	case MLX5_CMD_STAT_NOT_READY:
+		return "FW not ready";
 	case MLX5_CMD_STAT_LIM_ERR:
 		return "limits exceeded";
 	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:
@@ -787,6 +789,7 @@ static int cmd_status_to_err(u8 status)
 	case MLX5_CMD_STAT_BAD_SYS_STATE_ERR:		return -EIO;
 	case MLX5_CMD_STAT_BAD_RES_ERR:			return -EINVAL;
 	case MLX5_CMD_STAT_RES_BUSY:			return -EBUSY;
+	case MLX5_CMD_STAT_NOT_READY:			return -EAGAIN;
 	case MLX5_CMD_STAT_LIM_ERR:			return -ENOMEM;
 	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:		return -EINVAL;
 	case MLX5_CMD_STAT_IX_ERR:			return -EINVAL;
@@ -815,14 +818,16 @@ EXPORT_SYMBOL(mlx5_cmd_out_err);
 static void cmd_status_print(struct mlx5_core_dev *dev, void *in, void *out)
 {
 	u16 opcode, op_mod;
+	u8 status;
 	u16 uid;
 
 	opcode = in_to_opcode(in);
 	op_mod = MLX5_GET(mbox_in, in, op_mod);
 	uid    = MLX5_GET(mbox_in, in, uid);
+	status = MLX5_GET(mbox_out, out, status);
 
 	if (!uid && opcode != MLX5_CMD_OP_DESTROY_MKEY &&
-	    opcode != MLX5_CMD_OP_CREATE_UCTX)
+	    opcode != MLX5_CMD_OP_CREATE_UCTX && status != MLX5_CMD_STAT_NOT_READY)
 		mlx5_cmd_out_err(dev, opcode, op_mod, out);
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index a94bc9e3af96..d0f7d1f36c5e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1449,6 +1449,7 @@ enum {
 	MLX5_CMD_STAT_BAD_SYS_STATE_ERR		= 0x4,
 	MLX5_CMD_STAT_BAD_RES_ERR		= 0x5,
 	MLX5_CMD_STAT_RES_BUSY			= 0x6,
+	MLX5_CMD_STAT_NOT_READY			= 0x7,
 	MLX5_CMD_STAT_LIM_ERR			= 0x8,
 	MLX5_CMD_STAT_BAD_RES_STATE_ERR		= 0x9,
 	MLX5_CMD_STAT_IX_ERR			= 0xa,
-- 
2.46.0


