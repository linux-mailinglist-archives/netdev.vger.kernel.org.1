Return-Path: <netdev+bounces-73042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF9785AAE6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F5282B6C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39651482D8;
	Mon, 19 Feb 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpN5tbsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16443481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367010; cv=none; b=I79ZfmLY1RPOS9qXkW2BG/Qd5Xusnucb5Gk3ABycO0POC7cXdc/Aolm8l395JV7m2Kqank2a/7Tpl4rZa1QkKoFYfpB8n7mJw8CsEYgOG5xHvaIQ0os97DvLGX57GseW40WZ+iKEK9A2FJl4UMS5roB5uKtnP4rXg672tVSvhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367010; c=relaxed/simple;
	bh=I/m+hRWubgJHuRnOQRHARHrNdhPJb97QzdgjnXP0gEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li5tGBf3DP6pPOsEMxGhG1YK+j6OmoHJDH5fRR2VUYDH6iQJMPGEsxT8LXFuihagDz5CZTVX/R+4Onnp5E7KK3EBFBeQ4vtRC6VPVrtoxQkKaI0W+j+7BG4JXxd7n/Vs1dY5ZfxzZAF5A7c1Q+uKtR0ezD+lVg7HLNMPdGm21fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpN5tbsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C714C43394;
	Mon, 19 Feb 2024 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367009;
	bh=I/m+hRWubgJHuRnOQRHARHrNdhPJb97QzdgjnXP0gEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpN5tbsm0S0sOX/roEDhoxIgSskp/IUu9+Fx9nK98oZFgEMmFI53sivQWELWQpHQq
	 a7L2Ow1YW5kCvLqVrPgfXRxfrC6TaMD+4kqLqkNMZh5Qxlu4oJjS7k4jvBFAP65+Il
	 Yt9GdLVWN3O4bHNivQspEB8PLIAUfTDk5SUo//OZtAGO1tdBJ8cCDepGMuuOb9IsbH
	 IEVbKE8NkvLvfOkYpQ6WjEJsHBEcU1plA+gFQRYlySlVENUtcrrtCHsgytz22yD32k
	 zomVzxGXxo2GSRA8L9ZRMmzkB1VMFTX1tW/8QYwPlXSugk6lWefXyTP/42HDjUN+zI
	 w28OcOIGTUxxA==
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
	Gavin Li <gavinl@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [net 01/10] Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"
Date: Mon, 19 Feb 2024 10:23:11 -0800
Message-ID: <20240219182320.8914-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gavin Li <gavinl@nvidia.com>

This reverts commit 662404b24a4c4d839839ed25e3097571f5938b9b.
The revert is required due to the suspicion it is not good for anything
and cause crash.

Fixes: 662404b24a4c ("net/mlx5e: Block entering switchdev mode with ns inconsistency")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98e..14b3bd3c5e2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3658,22 +3658,6 @@ static int esw_inline_mode_to_devlink(u8 mlx5_mode, u8 *mode)
 	return 0;
 }
 
-static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
-{
-	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	struct net *devl_net, *netdev_net;
-	bool ret = false;
-
-	mutex_lock(&dev->mlx5e_res.uplink_netdev_lock);
-	if (dev->mlx5e_res.uplink_netdev) {
-		netdev_net = dev_net(dev->mlx5e_res.uplink_netdev);
-		devl_net = devlink_net(devlink);
-		ret = net_eq(devl_net, netdev_net);
-	}
-	mutex_unlock(&dev->mlx5e_res.uplink_netdev_lock);
-	return ret;
-}
-
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
@@ -3718,13 +3702,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
-	    !esw_offloads_devlink_ns_eq_netdev_ns(devlink)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
-		return -EPERM;
-	}
-
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
-- 
2.43.2


