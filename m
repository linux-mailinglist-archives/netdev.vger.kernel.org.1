Return-Path: <netdev+bounces-69329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4284AB38
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2199E1C2314C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94071367;
	Tue,  6 Feb 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO07u59Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610A53A6
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180940; cv=none; b=rFtYKQ8ac6mksCoPmakr8OffkczTfdvP7eZgJOTqN+fmCEexFHnH5Eam1UYrRQ7ITYcz/ALe7ioXR35K+7U6NA2gKcs6+fFbRz8P0WzoCA/MC0nq8hwzM2SuQEW29IP7Bxa00afTdd/DhpvQCTIFdpx8SfJC0LPlGw+QP6reZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180940; c=relaxed/simple;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojh0tv6VtIWW+XwIilIamnEKzFKe6EKfOXRudojI4IVkJPqtjs2tAECSr8y8fqi63rc5EBEBEwJC9Pd2G4gnm1kAx/ZlHRZinoJl9kt9i2XX5obp/J7bm5jjLCzCDg4kLFywtXdNo+c6Be7xEUPc95smH1oQsm1ouN8JRWzSJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO07u59Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AFFC43390;
	Tue,  6 Feb 2024 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180940;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IO07u59Z3/p3SULhYPVKU0UxS4LG32DVEBH/5fDq45IPNpO3hLyKjFmHD2/7WLxWQ
	 HEWcoqmMP7dDJiw+HfqdK2+zM80Gzul6dT8jd4Mm1BZtzUM6nxJ2Bf2aT86tyafd7j
	 nnCeKv6iQHu6ffbroVAio6EcgsR79K9SmiB0qlLMERIK4/zu6PaVuudIROD2pTwIRj
	 wVAl6FN63quhK3Sf7JlWnw9SGpIzO36fG8f8iuIYskXLBQOpwf96/Bhx0fwtoxf7Rn
	 oS0zfqD89teGTNQXIXdLK44yp2gIxXqygSmfhBg0bFc9Nf6ZTMcZW6u/uXs9LWMLnZ
	 L+rrC19oreAPQ==
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
Subject: [net-next V4 08/15] net/mlx5: remove fw reporter dump option for non PF
Date: Mon,  5 Feb 2024 16:55:20 -0800
Message-ID: <20240206005527.1353368-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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


