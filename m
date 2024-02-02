Return-Path: <netdev+bounces-68685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94341847963
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D36228240A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256712D74D;
	Fri,  2 Feb 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkNhDtwB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58012D749
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900950; cv=none; b=h8FVfL/KhjatZ+Q+btx9oncveMVF30lyf+t7JksboTdLpSTG2eIEF+3wASZEzvhCZI+v9e5M/Zak8hUJiGOnuP5ZubNR2+KJRSCJhVxOMIhB/+lUvZjO4YOzotegLOhfjoU8KMf02VyLtL/4q4VeiLrAiNeoNhxhUOIlJMxs4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900950; c=relaxed/simple;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwL+cYmw8fj1NuBPPqUDAQYF5qB34Fj7ClBcrB36UUBwJJA7n2xGagm0+K1NJ3lHFWqS6o6skJuiDPMFiyjScRREQoA7Zc4zUALBq3MK36um6rEeZiosQ5vBROLNwcnhtGcBQIQLC3Gh4jdUljNZMD3G1xCanJ9SlOoFgW6t5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkNhDtwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08123C43390;
	Fri,  2 Feb 2024 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900950;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkNhDtwBjtNzVriDffW3I7Xtcw9BG4uDRRNbTqO14XO+GImfQyQ/KH6ktAOv0PPCn
	 ADy0pqdzji6zKF7jSrbI5ADNskcjHOPdpMLfmIOdLfAPIjq4s29syGKFOhHsLIJ4z9
	 /lZ4TxoXkQ6bOqY/gDvm8rYgcO6zYa7mjgIZPyUwX2P1+AblOYyouHcbaeJmiVTUfv
	 pCh3QlPPWLGI907Ty4ov2m5pyoev70371F1BQT/RCwF761DMTP3i3mPbT+jxfb8JQ+
	 li38D4l+DwGzZt/FkymSSxGPc4oiZbDAD7b/UOi5Ybs+P5rWQydY1xgVGds1mAMouD
	 fX0ejQQ2eyeWg==
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
Subject: [net-next V3 09/15] net/mlx5: SF, Stop waiting for FW as teardown was called
Date: Fri,  2 Feb 2024 11:08:48 -0800
Message-ID: <20240202190854.1308089-10-saeed@kernel.org>
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

When PF/VF teardown is called the driver sets the flag
MLX5_BREAK_FW_WAIT to stop waiting for FW loading and initializing. Same
should be applied to SF driver teardown to cut waiting time. On
mlx5_sf_dev_remove() set the flag before draining health WQ as recovery
flow may also wait for FW reloading while it is not relevant anymore.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/sf/dev/driver.c        | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 169c2c68ed5c..bc863e1f062e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -95,24 +95,29 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 static void mlx5_sf_dev_remove(struct auxiliary_device *adev)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
-	struct devlink *devlink = priv_to_devlink(sf_dev->mdev);
+	struct mlx5_core_dev *mdev = sf_dev->mdev;
+	struct devlink *devlink;
 
-	mlx5_drain_health_wq(sf_dev->mdev);
+	devlink = priv_to_devlink(mdev);
+	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
+	mlx5_drain_health_wq(mdev);
 	devlink_unregister(devlink);
-	if (mlx5_dev_is_lightweight(sf_dev->mdev))
-		mlx5_uninit_one_light(sf_dev->mdev);
+	if (mlx5_dev_is_lightweight(mdev))
+		mlx5_uninit_one_light(mdev);
 	else
-		mlx5_uninit_one(sf_dev->mdev);
-	iounmap(sf_dev->mdev->iseg);
-	mlx5_mdev_uninit(sf_dev->mdev);
+		mlx5_uninit_one(mdev);
+	iounmap(mdev->iseg);
+	mlx5_mdev_uninit(mdev);
 	mlx5_devlink_free(devlink);
 }
 
 static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
+	struct mlx5_core_dev *mdev = sf_dev->mdev;
 
-	mlx5_unload_one(sf_dev->mdev, false);
+	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
+	mlx5_unload_one(mdev, false);
 }
 
 static const struct auxiliary_device_id mlx5_sf_dev_id_table[] = {
-- 
2.43.0


