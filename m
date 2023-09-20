Return-Path: <netdev+bounces-35133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1B7A72FF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154EF2819F5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F9EEBB;
	Wed, 20 Sep 2023 06:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA0D312
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A3BC433B8;
	Wed, 20 Sep 2023 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191773;
	bh=NUzQPZmUn05uhEhKit7421WnEOnmH6bNUKX3oHb+GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLQTu96y0RpqbzGEnwQbNBipowrcBpGbRMP2cHQJJkZ3YDUH7jumpboJq/VA28djU
	 A9xW4l65mwlI1IM2xelv9Y8+MG/R1hKrzWad4f167GBWBLSQHqPAuUWHYtKYXUTaKm
	 PuK3P7kCigbzNM6LPyl6wg6ygshjJRsmQe3bWyjxLPLOPV3e8jtyU2QnuUjD3u+uO+
	 NRgUE8wmkJTQ4ryItl9GnopZRoRyKX7Tnta44nWu3iLzaSxdAWBfHcOiNCmn5Jtrzk
	 GTxqsqx7Fwf7QtklvpK1IhdlhoUldWkkWqWgHHW+4RNvu4phxQUqwDmz1p0lZBvV71
	 mTm9U0CsH7beA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 15/15] net/mlx5: Enable 4 ports multiport E-switch
Date: Tue, 19 Sep 2023 23:35:52 -0700
Message-ID: <20230920063552.296978-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920063552.296978-1-saeed@kernel.org>
References: <20230920063552.296978-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

enable_mpesw() assumed only 2 ports are available, fix this by removing
that assumption and looping through the existing lag ports to enable multi-port
E-switch for cards with more than 2 ports.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 4bf15391525c..0857eebf4f07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -65,12 +65,12 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
-#define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 2
+#define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 4
 static int enable_mpesw(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_core_dev *dev1 = ldev->pf[MLX5_LAG_P2].dev;
 	int err;
+	int i;
 
 	if (ldev->mode != MLX5_LAG_MODE_NONE)
 		return -EINVAL;
@@ -98,11 +98,11 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
-	err = mlx5_eswitch_reload_reps(dev0->priv.eswitch);
-	if (!err)
-		err = mlx5_eswitch_reload_reps(dev1->priv.eswitch);
-	if (err)
-		goto err_rescan_drivers;
+	for (i = 0; i < ldev->ports; i++) {
+		err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		if (err)
+			goto err_rescan_drivers;
+	}
 
 	return 0;
 
@@ -112,8 +112,8 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	mlx5_deactivate_lag(ldev);
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
-	mlx5_eswitch_reload_reps(dev0->priv.eswitch);
-	mlx5_eswitch_reload_reps(dev1->priv.eswitch);
+	for (i = 0; i < ldev->ports; i++)
+		mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
-- 
2.41.0


