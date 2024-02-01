Return-Path: <netdev+bounces-67853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A0845200
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9328D101
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9772015A483;
	Thu,  1 Feb 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poba8O3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AE158D6B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772741; cv=none; b=st1/QOgTy2fIeA8fxUqFt1KT9Sc2FgmumeHwJh9TdZ62yYeYbofH2Pr3KLGCI+Y+8rSk1T9o8XhR++J3BSNSl6g3Sh4SbrnDKdp8Q25zXw6wJJvU841HOpO40ORVr9cjNaOLTjE9Ity++cA/60PgDdFXrcHfRKvla8PUy9u9Emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772741; c=relaxed/simple;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTTwyVglfY4al5YPXI2givhMgAT3AymJTx4Dpt+VWAK1+BmhlWnzCyJ5cQTjxCPIyisUSVPv2PyyGD/+zyCvzeyETT2UrZaNGTcjeRPJeeDb9UfltMyKrr/Hx+K9GfR6D4w1/yWs7lg5uE2ehYXVXYmwsj1x9PwRfg7tYhx6wG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poba8O3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F95C43390;
	Thu,  1 Feb 2024 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772741;
	bh=eGO20c2MBp9WOX9gO5VZZZVo8Uu/ynWYNp9n6EiDWwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poba8O3HvLKXnK0MQMZQ2Byc13IRl0A4L3iM5lUvRcJ3Si86+1Ux/R/JtfwQjRn46
	 /NsC3DX77+me1DkA29gj/PB4fzUg3wOpDu8OI39NL24r8wTeS9a0V4zCJZ7Dl0O8cX
	 ujTADDl10t5vxAucmvjZenJbHYnuI8XtuKfGuxf7vBHUpn0XzUvkQgiFXdvmyE6FSh
	 ttrEQgBUyriExujEb/OA6nCZhuJ3yA4PuSU9Ymk5QptVghEzoYsrY2b3W3H5C7eB2w
	 YKuwmQdcGw8BgSVkpPar7ffbVNQs1e+E1TzpZuJshn8dhEwIQ/im2qRi3O4Yss0Wz+
	 g3OnDaLwxtaAw==
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
Subject: [net-next V2 07/15] net/mlx5: remove fw_fatal reporter dump option for non PF
Date: Wed, 31 Jan 2024 23:31:50 -0800
Message-ID: <20240201073158.22103-8-saeed@kernel.org>
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


