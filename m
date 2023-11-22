Return-Path: <netdev+bounces-49883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73517F3B7F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC0B21A3A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11CC14E;
	Wed, 22 Nov 2023 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw7y3y8j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B02C8DE
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC96AC433CA;
	Wed, 22 Nov 2023 01:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617697;
	bh=5nizJjrvNFdd2ZnlknqNEwVFku4gDRAR4+yBshQIVdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qw7y3y8jrsiLqOJoFaanWFNue4En/0bM5mRj3QsjvdwVkxZbaiOFG/aSpGNp7nzsv
	 bXLzsfCgKHHp5ulM9mObM9JDngbhKgcBp27/EYLBI0wCKJQPMZMbJ489pYIiHqB7s8
	 twXg35rMBBvtOdOKy7PLnXkxoMbMB1HiPq/Yzg4JaqdzK/wTSdXtHRvbAZiIFjZs6C
	 t4cXbyAQO4cNQSnrbRtSvNknn53QuFToiiyyrX7iB3zhbv/uU3HeZ1w9oL8e2m2fU1
	 2O8w+DORSMTY3/tuRLp0r8qxg1Oxo1HBYdG6ZG3gI2BKiPWCHPfP3oJ2gDwVb7AOwV
	 KsvJ2EShi0NcQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>
Subject: [net 14/15] net/mlx5e: Check netdev pointer before checking its net ns
Date: Tue, 21 Nov 2023 17:48:03 -0800
Message-ID: <20231122014804.27716-15-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gavin Li <gavinl@nvidia.com>

Previously, when comparing the net namespaces, the case where the netdev
doesn't exist wasn't taken into account, and therefore can cause a crash.
In such a case, the comparing function should return false, as there is no
netdev->net to compare the devlink->net to.

Furthermore, this will result in an attempt to enter switchdev mode
without a netdev to fail, and which is the desired result as there is no
meaning in switchdev mode without a net device.

Fixes: 662404b24a4c ("net/mlx5e: Block entering switchdev mode with ns inconsistency")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Gavi Teitz <gavi@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c        | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 85c2a20e68fa..a77197370d85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3653,14 +3653,18 @@ static int esw_inline_mode_to_devlink(u8 mlx5_mode, u8 *mode)
 
 static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
 {
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct net *devl_net, *netdev_net;
-	struct mlx5_eswitch *esw;
-
-	esw = mlx5_devlink_eswitch_nocheck_get(devlink);
-	netdev_net = dev_net(esw->dev->mlx5e_res.uplink_netdev);
-	devl_net = devlink_net(devlink);
+	bool ret = false;
 
-	return net_eq(devl_net, netdev_net);
+	mutex_lock(&dev->mlx5e_res.uplink_netdev_lock);
+	if (dev->mlx5e_res.uplink_netdev) {
+		netdev_net = dev_net(dev->mlx5e_res.uplink_netdev);
+		devl_net = devlink_net(devlink);
+		ret = net_eq(devl_net, netdev_net);
+	}
+	mutex_unlock(&dev->mlx5e_res.uplink_netdev_lock);
+	return ret;
 }
 
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev)
-- 
2.42.0


