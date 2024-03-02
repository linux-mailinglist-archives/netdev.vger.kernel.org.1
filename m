Return-Path: <netdev+bounces-76792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5186EF09
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789F6285E96
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA4F514;
	Sat,  2 Mar 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaIR+7wP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F2748F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363431; cv=none; b=drGZM8wrtfEcJHs+tz3//a6IVP/YG2zSg12v9Is4pOu1x3djjH/2HiRre0AjXPvK5uUtGbwIYgpA7SOYHEKXyiUA+3eyP6yuDbQoSTMeusiT+ElEKpEI4HCVTCJZ2C3+gOH5cN31y6cJr0iIJm+7wZCzVYZvJj6R07/7h2TQ4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363431; c=relaxed/simple;
	bh=hoLds3QC8f9sRNnKiSb8DW9tQdQjcXCfMTOmC45MsYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhpllcO5InLFqZ5690RspSXmi7C/IXltGwFTm5IB0vEFXcKVwT2UzWubfxy14BJNGq6QRyz7wRaidDhvAsUDf6RZL2esf1LYpzoisg+WUoVs8S3pArJSeLI2RTyFYPmi5UTimnc0VG+jkYuFlOCtygX1ssG5sRkSoLxWJE2329s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaIR+7wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AADC433C7;
	Sat,  2 Mar 2024 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363430;
	bh=hoLds3QC8f9sRNnKiSb8DW9tQdQjcXCfMTOmC45MsYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaIR+7wPOggeV3r2sVCHo7HtERYualCnt7L5U2itXCGFMNBMrrExDIdJnbESNJBs9
	 sHHmmqT4VnwSkhbwVpb4YbS+GUtK7FWKzxprbVYeKy4CwsVkLYlwpDGaBo1nmW/Gy8
	 2xoxZE2LHBghyPJ/LV3D6lc5WrPawo3vRCg3cOyOwZXSQrJJJJd59Ipfd5PRRxMTRc
	 uL0+kI+Df3ky69W56QKYszlsv1KtV7S4q7/RGoBzZkjD4i3IcIs07rE0EV1K4HVJ0F
	 ewwF50SUfI9GuiYc6pTaA36UWKAID8HEfXtBD5RPp+1HIuad3Rub3cszTfh6AeXnml
	 CL1d0kAFtc/Iw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Elliott@web.codeaurora.org, Robert <elliott@hpe.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net V2 6/9] net/mlx5e: Change the warning when ignore_flow_level is not supported
Date: Fri,  1 Mar 2024 23:10:25 -0800
Message-ID: <20240302071028.63879-1-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Downgrade the print from mlx5_core_warn() to mlx5_core_dbg(), as it
is just a statement of fact that firmware doesn't support ignore flow
level.

And change the wording to "firmware flow level support is missing", to
make it more accurate.

Fixes: ae2ee3be99a8 ("net/mlx5: CT: Remove warning of ignore_flow_level support for VFs")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Suggested-by: Elliott, Robert (Servers) <elliott@hpe.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 86bf007fd05b..b500cc2c9689 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -37,7 +37,7 @@ mlx5e_tc_post_act_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 
 	if (!MLX5_CAP_FLOWTABLE_TYPE(priv->mdev, ignore_flow_level, table_type)) {
 		if (priv->mdev->coredev_type == MLX5_COREDEV_PF)
-			mlx5_core_warn(priv->mdev, "firmware level support is missing\n");
+			mlx5_core_dbg(priv->mdev, "firmware flow level support is missing\n");
 		err = -EOPNOTSUPP;
 		goto err_check;
 	}
-- 
2.44.0


