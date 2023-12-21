Return-Path: <netdev+bounces-59393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE93F81ABF1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF051F23191
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D015B7;
	Thu, 21 Dec 2023 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRIhZCne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB37481
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD006C433C7;
	Thu, 21 Dec 2023 00:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120260;
	bh=54XDbstzlruaOzyTOHLh/wiImj+xZ+oWNWJm8jPeQb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRIhZCnewlR6ZQoUfHc3QTwpoaSKPTZTrOdGjrIv1WJN7+qnxM6UVc2YTwmDThU5Y
	 OZWx206HmkpqqnNcTGe3DBx3jq16QCVak+ELb8H5iZvcI8rtmDlbPbv+bozcNRkk7V
	 rRguA/PprAhDy6mqk3bxCaXahzgncBFge2+/WO+o4XVvzrbhHQVK+kx+7bKyd7toKr
	 4TWPIMBuqJ1BjH/xfiE4ea0/c+LCmS0n8Q5wEqXErw0TrYvW+15oDp0Dx8ylzklw7u
	 nQE1jBdteCcYmeNrQFb2M4NhLuk/jfNEoO2hf9QpRs/f0C67GOhutrpxILPES3MqbO
	 2bSkJat5v1mPQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 08/15] net/mlx5e: Create single netdev per SD group
Date: Wed, 20 Dec 2023 16:57:14 -0800
Message-ID: <20231221005721.186607-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221005721.186607-1-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
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


