Return-Path: <netdev+bounces-66305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363183E59B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865A91C23ECC
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33850A9C;
	Fri, 26 Jan 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3dqDElp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B854BE3
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308619; cv=none; b=Gm90Z469+sNFxbhZZNnFhyJ0p4Z4QuotM+dQkGpuz/BHo15I/GYYUzeqldlw8zbFamJdvwN+eYDxH1IjpF08+Ig/u1JTwG1UhXkrKUj4ABxNp1DbI4sLTdBoXeLJ+SsxLGY6Q4yr9FGwFXm219p/qofqxjNksX8tWuE6N9qUqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308619; c=relaxed/simple;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz+IS6N6qiBGhclf9DppPapy6VxI7gWEUR2PRwF8Hl8F2EZnVAlOpWMPGGpHNmyN1CCB6LF3VOIPhiUqIcafuqykB3UQ79FZvRGZJarV395th/oGhMiv/lQIKYTPeDKJwPhkJChcaUt3PjfqgVu5j96ZUSSNGHy4ag5IQb1gQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3dqDElp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B099AC43390;
	Fri, 26 Jan 2024 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308618;
	bh=tJ0z98HCrsNG7SNSA0d/1Zfmz/iBx99+ymhi3CD6Md4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3dqDElplgnW9RWkWIs1MYryRvmFQ5+axbLnh0msQnOCQCxb/0EoFlFz6TDzwPBmC
	 h8VE6aY8oPhUcEqbsrmC9Ugg/D/eo3kspY/P5ojKNAKptJ3zYP+7vl7VXjtdJW2Y4E
	 Eh5OE0QAFLKAOWC81dx0yrlqsTvbYCJvfM8nZ2p6UhyZZBefQVDcDSBXfbOnNiiBhO
	 vEqcZWAbyKwCq7oHNmy2DkFwrWDaxpCrckwvkDWQPYjZKEpNXLtkuHTtDqRTDQzr/3
	 Ydo6v7RPIuutZ9W40leNoMf+llNv2vIWjn1mveFpbxwqynRyTZMTQN2vopWU6Qh8Jn
	 k+/MV53PczaCg==
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
Subject: [net-next 08/15] net/mlx5: remove fw reporter dump option for non PF
Date: Fri, 26 Jan 2024 14:36:09 -0800
Message-ID: <20240126223616.98696-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223616.98696-1-saeed@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
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


