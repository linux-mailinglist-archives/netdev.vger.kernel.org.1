Return-Path: <netdev+bounces-68683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF1847960
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334691C28EBE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601D12C811;
	Fri,  2 Feb 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBrb1Whb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAB12C80D
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900948; cv=none; b=HDdW9BFtqe115H7yuAf4xmpAwYPH5wsZw0p+gImh3Yex163V1JDajzYq/DHrnI6+rrJjcfmFHvhsa+GblnxyBk10y0bMw9LBLaB8WCPZymTGzLqBo4bLK42xXfSQluDn1+qtAgJszcW6mndw+gaaKA6ltpWI54J9TIIcRB+RbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900948; c=relaxed/simple;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB0iykdjyxN3Y5c4mosAgu6Wjpi771td3KP/ofmFoAcixzPGJbA/Q+8HT4unijKEvhvvmQvvjCwO0GUiBicfZZl5duP1BxozqXlvDBXUpD3GZ3rXQQUfaLKM9NBSMj24iNPxvkPgKpA++QHaMsdLkzXM4vt2OadYp+EmC3CoSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBrb1Whb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61F1C433C7;
	Fri,  2 Feb 2024 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900947;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBrb1WhbSdWqR6MWiuTKAqfCDLE/HePAm5jQPuD5LBvnAjOJqaHcbdeRDJlpKcNWj
	 thCuQvXL9kLpFSLH6Tc6pP7mjE+BhRF3Ds68nDT94oRpvcRBcHW6mGUU8PwTcVjDaw
	 E1AaqcG4pQ6zHPp+aEuTu5gLUZreiyNI/G8GbkEWVSAVOpfmd3HTttfUKCmWddrXol
	 htdP/1zHmsDdt5TusMvC1psz3+5V3MLkZ3RFZAfk4zjEuRKXEWghD4uAozfGtyIWju
	 23TumtT66eogJ48phyhmRQcIUWw+bq2zjVFc+h0tq/Y0AR/eF4QFERQUyD68DBZNTA
	 P/NGNxBBMTn4w==
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
Subject: [net-next V3 07/15] net/mlx5: remove fw_fatal reporter dump option for non PF
Date: Fri,  2 Feb 2024 11:08:46 -0800
Message-ID: <20240202190854.1308089-8-saeed@kernel.org>
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

In case function is not a Physical Function it is not allowed to collect
crdump, so if tried it will fail the fw_fatal health reporter dump
option. Instead of failing on permission, remove the option of fw_fatal
health reporter dump for such function.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 8ff6dc9bc803..721e343388df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -646,12 +646,17 @@ static void mlx5_fw_fatal_reporter_err_work(struct work_struct *work)
 	}
 }
 
-static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
+static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_pf_ops = {
 		.name = "fw_fatal",
 		.recover = mlx5_fw_fatal_reporter_recover,
 		.dump = mlx5_fw_fatal_reporter_dump,
 };
 
+static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
+		.name = "fw_fatal",
+		.recover = mlx5_fw_fatal_reporter_recover,
+};
+
 #define MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD 180000
 #define MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD 60000
 #define MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD 30000
@@ -659,10 +664,12 @@ static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
 
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 {
+	const struct devlink_health_reporter_ops *fw_fatal_ops;
 	struct mlx5_core_health *health = &dev->priv.health;
 	struct devlink *devlink = priv_to_devlink(dev);
 	u64 grace_period;
 
+	fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
 	if (mlx5_core_is_ecpf(dev)) {
 		grace_period = MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD;
 	} else if (mlx5_core_is_pf(dev)) {
@@ -670,6 +677,7 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 	} else {
 		/* VF or SF */
 		grace_period = MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD;
+		fw_fatal_ops = &mlx5_fw_fatal_reporter_ops;
 	}
 
 	health->fw_reporter =
@@ -681,7 +689,7 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 
 	health->fw_fatal_reporter =
 		devl_health_reporter_create(devlink,
-					    &mlx5_fw_fatal_reporter_ops,
+					    fw_fatal_ops,
 					    grace_period,
 					    dev);
 	if (IS_ERR(health->fw_fatal_reporter))
-- 
2.43.0


