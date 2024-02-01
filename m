Return-Path: <netdev+bounces-67855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F6845203
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB38B1C241E0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45612158D75;
	Thu,  1 Feb 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egbquufm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E7158D6F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772744; cv=none; b=imfljbMUJxwscMi7v+eGgyrierbO7QG6gS0Ki5GEnRnOCytA3WqH+JIacmAqQxPvKtPgtojwJizKa4pNFVfVtAXDh8SFGBTvFZQGsNKX4bN0bTWhvtJz8Kh9ZwQyen766PjqRt0wp7UxpP6onrRfdDEHw6Rg/JUQs9mDxyujLeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772744; c=relaxed/simple;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSM5dB6de1ba+IhDfQTuAGOMfxY2Bz9ZAf+8LDinXvUPIhzy/DUgqiSUqirN6Zk6ig3elo1mPGvK2l79qONNA90Oe8/681hYx6sdV/jjxMqLLXlttvkiaHhXme/04SicEXkRhv97TFVybPTtz8sXAwKcu/FUUtvnXoCzmHbqJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egbquufm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5358C43601;
	Thu,  1 Feb 2024 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772744;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Egbquufm6Dh5LNFbUlD10FPwavm2GWAWxSi4gS+16D8Pcbyl8Y8yzSbOXqJkS4I9v
	 KMFYQ7/jxg0fB5s2bobkzs/0pxlPLLo62cR131dlPU5TclI3+sXr0kzHijjLoSpaSO
	 KuVB2z+I4SqSfYIMUnMzO9gvqyBWz9tHTXRAkpAfu6+clyl7YMMITCd7Nttc5GsL15
	 zj1xMy/HPTE3F5+YjAnMwI8InQusahWtgGObB2lFDTxB537Xlhe7n6my+AzlwtNmrQ
	 xIKAFiC02m63RkSfmRBG4bOucdxVpqx23NYbbUYjYHDS63ruOaKsqUcMPcvz2PtDrW
	 pLLVbv7XFOPdQ==
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
Subject: [net-next V2 09/15] net/mlx5: SF, Stop waiting for FW as teardown was called
Date: Wed, 31 Jan 2024 23:31:52 -0800
Message-ID: <20240201073158.22103-10-saeed@kernel.org>
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


