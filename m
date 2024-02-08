Return-Path: <netdev+bounces-70085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F384D936
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA01C23ADC
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4C2E83C;
	Thu,  8 Feb 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toHnNujr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0F3172D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364457; cv=none; b=i2Nqqi7s3Qb1LKR7dWwfRh6z7BvwYPVuHxPj7xQfoxVLeuvGz7P5wNQmIqVcDvxZRbOVoIVujRrSAhteooGWB7u1JK7QhH7i+RB0Ija8cEVSIDsnHuI6n0vv4tHg8yHHJ8xCZjs+75nr0/6OgVmx8Elus54ffCmJUPZUarQsOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364457; c=relaxed/simple;
	bh=54XDbstzlruaOzyTOHLh/wiImj+xZ+oWNWJm8jPeQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzuSYXYCc+zKBjpgq/m3RLYeJUPPEcjJe4Hn2YZbRhOiiF0x3qWUt0wQUU2w0R2VXIbYjRpBSFlVaecFp7gZ6ldnYxEZ6whb9n6Na1TXNNxoJxXqeTyp7veYwmOxWWj6PVg9sqoW+MrK+EL0TGOcVif4AgmJ91BoMmW49sOq18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toHnNujr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71887C433C7;
	Thu,  8 Feb 2024 03:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364456;
	bh=54XDbstzlruaOzyTOHLh/wiImj+xZ+oWNWJm8jPeQb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toHnNujr7D7jmHOZ1bSy+ahWfWfFRo29qO91LPWSMEYN4GbTwZyi75r+S/QMrihhm
	 u59xIPwtFEd5mIPN161c2fwrMDHyarObMGPfza+t3eEnRNH+9/jW0ybuOtZZAEdNAd
	 XIjpoS8aTg3E3qPv/1xloWhw1jbcSufHloDk5A3QhzG2WXOBoe2BfboiP1CWVo1KJq
	 0SxVjoAO54TR+uqSO+uQVIKyzdCRi+VwYvGobH9hWgCt6IEudAJ13DWv1QommJjlqe
	 Cd148bD/bL3k15XHGVOfiZMzbpr+DtRCOwdQxRavfRRkIQMwAh7iKZh/Q7IuZvHZJg
	 t3ctOkL2utmHQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 08/15] net/mlx5e: Create single netdev per SD group
Date: Wed,  7 Feb 2024 19:53:45 -0800
Message-ID: <20240208035352.387423-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Integrate the SD library calls into the auxiliary_driver ops in
preparation for creating a single netdev for the multiple devices
belonging to the same SD group.

SD is still disabled at this stage. It is enabled by a downstream patch
when all needed parts are implemented.

The netdev is created only when the SD group, with all its participants,
are ready. It is later destroyed if any of the participating devices
drops.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 69 +++++++++++++++++--
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c8e8f512803e..2c47c9076aa6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -70,6 +70,7 @@
 #include "qos.h"
 #include "en/trap.h"
 #include "lib/devcom.h"
+#include "lib/sd.h"
 
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode)
@@ -5980,7 +5981,7 @@ void mlx5e_destroy_netdev(struct mlx5e_priv *priv)
 	free_netdev(netdev);
 }
 
-static int mlx5e_resume(struct auxiliary_device *adev)
+static int _mlx5e_resume(struct auxiliary_device *adev)
 {
 	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
@@ -6005,6 +6006,23 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 	return 0;
 }
 
+static int mlx5e_resume(struct auxiliary_device *adev)
+{
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err;
+
+	err = mlx5_sd_init(mdev);
+	if (err)
+		return err;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		return _mlx5e_resume(actual_adev);
+	return 0;
+}
+
 static int _mlx5e_suspend(struct auxiliary_device *adev)
 {
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
@@ -6025,7 +6043,17 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
 
 static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 {
-	return _mlx5e_suspend(adev);
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err = 0;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		err = _mlx5e_suspend(actual_adev);
+
+	mlx5_sd_cleanup(mdev);
+	return err;
 }
 
 static int _mlx5e_probe(struct auxiliary_device *adev)
@@ -6071,9 +6099,9 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 		goto err_destroy_netdev;
 	}
 
-	err = mlx5e_resume(adev);
+	err = _mlx5e_resume(adev);
 	if (err) {
-		mlx5_core_err(mdev, "mlx5e_resume failed, %d\n", err);
+		mlx5_core_err(mdev, "_mlx5e_resume failed, %d\n", err);
 		goto err_profile_cleanup;
 	}
 
@@ -6104,15 +6132,29 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 static int mlx5e_probe(struct auxiliary_device *adev,
 		       const struct auxiliary_device_id *id)
 {
-	return _mlx5e_probe(adev);
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+	int err;
+
+	err = mlx5_sd_init(mdev);
+	if (err)
+		return err;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		return _mlx5e_probe(actual_adev);
+	return 0;
 }
 
-static void mlx5e_remove(struct auxiliary_device *adev)
+static void _mlx5e_remove(struct auxiliary_device *adev)
 {
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
+	struct mlx5_core_dev *mdev = edev->mdev;
 
-	mlx5_core_uplink_netdev_set(priv->mdev, NULL);
+	mlx5_core_uplink_netdev_set(mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	_mlx5e_suspend(adev);
@@ -6122,6 +6164,19 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_destroy_devlink(mlx5e_dev);
 }
 
+static void mlx5e_remove(struct auxiliary_device *adev)
+{
+	struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = edev->mdev;
+	struct auxiliary_device *actual_adev;
+
+	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
+	if (actual_adev)
+		_mlx5e_remove(actual_adev);
+
+	mlx5_sd_cleanup(mdev);
+}
+
 static const struct auxiliary_device_id mlx5e_id_table[] = {
 	{ .name = MLX5_ADEV_NAME ".eth", },
 	{},
-- 
2.43.0


