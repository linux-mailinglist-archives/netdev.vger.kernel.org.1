Return-Path: <netdev+bounces-66304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A055383E59A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35C31C20C9E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533A524B3;
	Fri, 26 Jan 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbU4Zkub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A750A7E
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308617; cv=none; b=ID1lAXUykDxuEdijsmIkcNH22E6fo50bM0EqC3vED/hQAmwBHuSlyXyXG9rD6py0An23hbFnOVYJk7R0DtMCkQzIWD68wtSNl5CZrZz9+kIWFfb5x31b9m2lCrOrJNEqJHBKXtmLKMZI52VUaLwkMF4lcgDpx66sXm90/DhW4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308617; c=relaxed/simple;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAjjonk/k0C6gpCIELfCjtvO040Vbak/dyG4ZppIvZ5XboqJigCQ+n/ngmF6SRbQNvcosujaci1tt48ma7eEv8Fmd78d2fVHomR1W+ddVnd+PAmP3Pfz7IA+k5F2Vo4mCFo8ayZ2UFtRNPJ1kt8EhtQx8sjzH+JjA2zTpbchSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbU4Zkub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3F7C433F1;
	Fri, 26 Jan 2024 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308617;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbU4ZkubgD3PGKrNpL0Er90evRGy2wKInadSfwZUAm5XieG8wFwFFFacL7qj9jaIC
	 46gEOeR9VAam5hJZmf3OI/I39WezYRo3HG1InS0oON6jNYkXzQvZS3q2ox5en1WPaw
	 fOLuadFDC+5u2+yempmulA0Dd+qtLXpDc6D20RskBprfad2w0LThcg4q6yIkLAT9Tr
	 eVmZZYKY10y5wSm7AtIeT1gZd/8e8srj2e91JbuH0d1Rfs0Eai7PHINymH1Tk1v2Gq
	 TGJ/eKG/TR0et1mPxPciRylFoncP4Bf2ifdmsESI/G3GHyGj7mukz6l0ZgpDsIfZGJ
	 +PgXiCwzbYhlA==
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
Subject: [net-next 07/15] net/mlx5: remove fw_fatal reporter dump option for non PF
Date: Fri, 26 Jan 2024 14:36:08 -0800
Message-ID: <20240126223616.98696-8-saeed@kernel.org>
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


