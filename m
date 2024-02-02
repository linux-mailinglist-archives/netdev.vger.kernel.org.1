Return-Path: <netdev+bounces-68684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C81847961
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBE91F27CA2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F712C81F;
	Fri,  2 Feb 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERewPegd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458412C80D
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900949; cv=none; b=tz1dknWsG/x5OWtu72WdrumXq98By8pdJ6Q1Gi1kH3w1nOGwZQ0DI94f+gqWNLe0UMUwzFJquZXSxQ/1nr2PTDs6bUWegC+JUcEZMI+lvm6wwugO08ot5wRyHJAVPY3NvD2cnrTfUAr+7no6PvRLd4dfAobK2M0c1w8tC4edZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900949; c=relaxed/simple;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtuHpMxhaWTBmQoqqdI6VgXaDAlIkTn7UjwwPCTQ8G0RvAbKWKfpmbcmOVzA/qu/OGltFVPLjV+GUnHeJUeSYPEYxLJ+rq7kX9QVMvrqpxK52VI4LZftqQMzLZrLOezeT1BgjdTtIpPakOPuCkQk1GCEFom+Bp2hRvm3kY1afBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERewPegd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0A0C433F1;
	Fri,  2 Feb 2024 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900949;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERewPegd5qzfR0ySj3ckz+xCwGBmKWEdMW3kJgP0nHWScvKZVMNVAXEOOWr50U/FD
	 uydn+KeBd1mUs8CfYxkeFU7XmM/bZeTOXN60KuVwk61d/tCkTF9E88MrJQKSjoXPvQ
	 6IlA4rzZUm8b46DIzvIblGeIvYxABIDayeNmqRlSFyroCxvap5kCPHcdPM77qLKhs+
	 SNdMTSCucY7GCD/UYzeTcK7zZhxRwrjPm5/1sKQNRWUIR0wOb3Z4DX71NYc5YWXle7
	 biVmjuNBEXhRybMbkEpueLho5ph5bu5jXLNpZtCIQPapChJ/DfIGTx84kd9xe0z06T
	 W5SX3wtlU8r/A==
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
Subject: [net-next V3 08/15] net/mlx5: remove fw reporter dump option for non PF
Date: Fri,  2 Feb 2024 11:08:47 -0800
Message-ID: <20240202190854.1308089-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

In case function is not a Physical Function it is not allowed to get FW
core dump, so if tried it will fail the fw health reporter dump option.
Instead of failing, remove the option of fw_fatal health reporter dump
for such function.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 721e343388df..5c2ac2d9dbd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -555,12 +555,17 @@ static void mlx5_fw_reporter_err_work(struct work_struct *work)
 				      &fw_reporter_ctx);
 }
 
-static const struct devlink_health_reporter_ops mlx5_fw_reporter_ops = {
+static const struct devlink_health_reporter_ops mlx5_fw_reporter_pf_ops = {
 		.name = "fw",
 		.diagnose = mlx5_fw_reporter_diagnose,
 		.dump = mlx5_fw_reporter_dump,
 };
 
+static const struct devlink_health_reporter_ops mlx5_fw_reporter_ops = {
+		.name = "fw",
+		.diagnose = mlx5_fw_reporter_diagnose,
+};
+
 static int
 mlx5_fw_fatal_reporter_recover(struct devlink_health_reporter *reporter,
 			       void *priv_ctx,
@@ -666,10 +671,12 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 {
 	const struct devlink_health_reporter_ops *fw_fatal_ops;
 	struct mlx5_core_health *health = &dev->priv.health;
+	const struct devlink_health_reporter_ops *fw_ops;
 	struct devlink *devlink = priv_to_devlink(dev);
 	u64 grace_period;
 
 	fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
+	fw_ops = &mlx5_fw_reporter_pf_ops;
 	if (mlx5_core_is_ecpf(dev)) {
 		grace_period = MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD;
 	} else if (mlx5_core_is_pf(dev)) {
@@ -678,11 +685,11 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 		/* VF or SF */
 		grace_period = MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD;
 		fw_fatal_ops = &mlx5_fw_fatal_reporter_ops;
+		fw_ops = &mlx5_fw_reporter_ops;
 	}
 
 	health->fw_reporter =
-		devl_health_reporter_create(devlink, &mlx5_fw_reporter_ops,
-					    0, dev);
+		devl_health_reporter_create(devlink, fw_ops, 0, dev);
 	if (IS_ERR(health->fw_reporter))
 		mlx5_core_warn(dev, "Failed to create fw reporter, err = %ld\n",
 			       PTR_ERR(health->fw_reporter));
-- 
2.43.0


