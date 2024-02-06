Return-Path: <netdev+bounces-69330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C084AB3A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33C21F23DD0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD073817;
	Tue,  6 Feb 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLESaVmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CB6AA0
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180941; cv=none; b=jjfcIjgtpLskimV/JBfMtBs5J3eOIM+MW9DGHK4JX8c3SJ1VPSt3e3uRJUF86jj8VzzC0OsOffvOLREWtjhnpDXl9nNSOMX4ek41LBKpmZNSqZ81Wc0FGEAI5d5eFoHDVyYq96YC0fgGrnDbWIonPKxr10fGhN2UOVqZbqAxe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180941; c=relaxed/simple;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2y9l2Is7Ju7nx3HltlbLajtW3UK+VdMO4Qi5/2D5PiIeZSq+81/WrDoPpYqPkovtpigBDxliDBezR9lErtp2fVnaTBCBBF0YviQ0GdZcItMAz0yTZzbSrkJ+uCx6kBWwq9fvm+50mJQy7MZu3wFpOmZJ9Fa8p90w8/fTTHerXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLESaVmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E01C43390;
	Tue,  6 Feb 2024 00:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180941;
	bh=6G3rLaio//bwVROcPEZtoatiQXH7RJSuVehvjzcAqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLESaVmcbODKVZeJaXNspVfN3gWpM42k3jAigehSjBHGs68ySCb+X4QEV1LqpGsLR
	 4v6nVKfDzmQJJ+1mbCMYRVIqJ9KUCZIwXRjTx48qEQdlA5zpunwv8ySMaiUSK/W4Dj
	 VcbGDoIGN9CTBcr1kb25Nadh6mTMB4ySpAVSaEBd8jx0h0nV0Q3fgoTbCN5fe1B52j
	 5RRcPD/AZyYVQdCZCRs4gAN/4R1n9nokZqJ7tx4UFouWX4iEPQOXEw234dB42YVRLu
	 bQVrj92AMvZYbM090EUtd3BnfYPLKFRN7ZWsQdDGBr7p+ekLuprAxht3BMjdPn4rNz
	 KQK3rSi+UMCVg==
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
Subject: [net-next V4 09/15] net/mlx5: SF, Stop waiting for FW as teardown was called
Date: Mon,  5 Feb 2024 16:55:21 -0800
Message-ID: <20240206005527.1353368-10-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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


