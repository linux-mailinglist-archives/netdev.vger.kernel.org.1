Return-Path: <netdev+bounces-22023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB7765B7C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DB61C216CD
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E8198A7;
	Thu, 27 Jul 2023 18:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0A198A4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711D6C433CD;
	Thu, 27 Jul 2023 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483168;
	bh=s2U4wH3J1BEwd3118cI/GAlqlModOsh0C6qShVkcmyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRZ0zFr4lPNpLAJSXdPwta6aQ6UoE1rXQ8KJ7srN3Q1IqT9Hex6l0TQKIt+f1gYgR
	 zWxETVhMy1EcoWVV6bLoTjuthGiWbBFBCKK8GL9TvLvY1wSHqmy3kzius/jstj/NAm
	 sbClxnM2TaskGR4BNo51RTDpVgXMEOSQM6kcS24hBKSsKKThAwpcPoI9QeJUJXWgkf
	 FoVf4rFAVD+mWOYy1V/tr7B+Z0WLhzlq0lPMe6nNt8uzsOjDuQnOdNNqap+eeNaipD
	 IZ5IuRlotjpBTyY6OhEgFfeLoXJ+5NQHPTvqKZBcupT9eKwZJp4bCCm2FT7dSUD7kD
	 5Q6bv3Zpk6Ryw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next V2 06/15] net/mlx5: Remove redundant cmdif revision check
Date: Thu, 27 Jul 2023 11:39:05 -0700
Message-ID: <20230727183914.69229-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

mlx5 is checking the cmdif revision twice, for no reason.
Remove the latter check.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index f175af528fe0..9ced943ebd0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -2191,16 +2191,15 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	int align = roundup_pow_of_two(size);
 	struct mlx5_cmd *cmd = &dev->cmd;
 	u32 cmd_h, cmd_l;
-	u16 cmd_if_rev;
 	int err;
 	int i;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd_if_rev = cmdif_rev(dev);
-	if (cmd_if_rev != CMD_IF_REV) {
+	cmd->vars.cmdif_rev = cmdif_rev(dev);
+	if (cmd->vars.cmdif_rev != CMD_IF_REV) {
 		mlx5_core_err(dev,
 			      "Driver cmdif rev(%d) differs from firmware's(%d)\n",
-			      CMD_IF_REV, cmd_if_rev);
+			      CMD_IF_REV, cmd->vars.cmdif_rev);
 		return -EINVAL;
 	}
 
@@ -2233,14 +2232,6 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
 	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
 
-	cmd->vars.cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
-	if (cmd->vars.cmdif_rev > CMD_IF_REV) {
-		mlx5_core_err(dev, "driver does not support command interface version. driver %d, firmware %d\n",
-			      CMD_IF_REV, cmd->vars.cmdif_rev);
-		err = -EOPNOTSUPP;
-		goto err_free_page;
-	}
-
 	spin_lock_init(&cmd->alloc_lock);
 	spin_lock_init(&cmd->token_lock);
 	for (i = 0; i < MLX5_CMD_OP_MAX; i++)
-- 
2.41.0


