Return-Path: <netdev+bounces-67854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C3845202
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F369E28CF0F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971A15959F;
	Thu,  1 Feb 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2HM/eQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE9158D70
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772742; cv=none; b=kipHvBp6d1UwIBjT3bnEb3H24byKIhBC/dRuM3FaprSVc+K+SzxJl+rvDNq2rTE7GoxlGKp8d5e4XIxQfXnbpwsiokDJN34p2y710Ptf8S0NsoAxOOLHH6oAyY2khOqz3cUX5lqGCEiw7LWHosHw5CpsR7w9zpiYLWiBIIWyob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772742; c=relaxed/simple;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNHU4dJQh9YZCDKHViqwVhgPtsKWdPEn5Svta6saaEXkjE8/qw+6ozZSeUDBj8mcKpfZYRDaF2Y568gOkNdBBNtAEg4FL3W+3bzMFc1sIsdn/ixLFZ2oxSZaf46/Ob2tPO2m3mDCpzk48XiySZWvEojtJ5856QAodtI8BANo+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2HM/eQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4985AC433C7;
	Thu,  1 Feb 2024 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772742;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2HM/eQbuSG1htRNqH/1VonUxs29/So9yWVRpIiTC9rWnoJX1sOnv6SBKV2+w+xI/
	 cbXlc3CHKLpW+STOXGUKzzU5/1ryOF8iAPUyGPlMPEu6eT7vSH1t8DBy/BBHALaWM1
	 9NcOdXxfUET8hNjkyPqC5llR3mfulFmVz8dtavwsl0PBiJ2TKEW0MnrYutlKD9bs9W
	 DyqmTmkFyG/LgXajQ2fFAmHLVt6kZ4ovvHs8qIrbaFoaQaxLxRKn2f8e7bvBQSaYuP
	 +WjhwWjx1q1B8v3nM8QxdWgG38VJ9hZp1tp2Fs7vNRaDwpd2DaGM/YKq0nt6qSPxcn
	 spaDYfIWqtAcA==
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
Subject: [net-next V2 08/15] net/mlx5: remove fw reporter dump option for non PF
Date: Wed, 31 Jan 2024 23:31:51 -0800
Message-ID: <20240201073158.22103-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
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


