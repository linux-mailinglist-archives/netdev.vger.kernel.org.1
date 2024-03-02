Return-Path: <netdev+bounces-76787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299C86EF04
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C057B228C4
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF1111BB;
	Sat,  2 Mar 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB2dx1ln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2111C88
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363009; cv=none; b=EXSCEiOk+XpsohrMiBq2L5v8UjTS1/sMw4i3IyAt+zvFQxmR/A+b8R97GPdLWYNDZ7jdGyhry1aLdEVLCYbomhhcmGVMeWFkFEhwLKjDaAVd/Msf9iLOqQYiMXi158Bs09kqWyB+qo07p5y7kEg6s77/eihgLtQnXEng4LM3BKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363009; c=relaxed/simple;
	bh=QitwpCziBi0rtsdag0DWierUMBOna7KEGs9RTjNZGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snmu8Rmglpov0zeHoUkt/6P4cF0xnOytfzrf3QWVnp7VyZy0vlTkEi05Lq0jh9iM60fesrNTyDyOzkLu80NXIoa7mYq0WT1PgPIc0VEa1f4zi4DWUcA59JKLWNN1fN0kFRf1p1U5zorTNwIrtoRMaEXnheSOXAY6GnUS6CXOwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB2dx1ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69184C43390;
	Sat,  2 Mar 2024 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363008;
	bh=QitwpCziBi0rtsdag0DWierUMBOna7KEGs9RTjNZGeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB2dx1ln13aw7h7HW1m/1Yq9OHaT7L0Oni/SbcENc4jD2rLmBP6Dcll0El1nyxk+v
	 kYJHJZxwX2LUp9LVirP6eVAHQiPEZ6NSWOOVGJlaitfEFEc2KWsfgu0rSLu8/pqTQ3
	 XwsknzRDQ9xgmMlwLbua/fyX9Qx0s24sjtcswOoAUB/0UtQRbknZUZODz1/YKeXHK7
	 Kw4PoLNtjopFGZqwfVkJTxU9GNzDJrGP60/dxwzvdrEwsn7kQCGuvp3gwfiD3PgLUs
	 cqY6iryRBBRuamnObxUKTQczNpQ1bJyDEKdXtWufKR39cfltDx0oP8G//OjNfaeWqb
	 i5gfed+NeQF2Q==
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
Subject: [net V2 1/9] Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"
Date: Fri,  1 Mar 2024 23:03:10 -0800
Message-ID: <20240302070318.62997-2-saeed@kernel.org>
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
2.44.0


