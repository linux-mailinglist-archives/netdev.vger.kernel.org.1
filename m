Return-Path: <netdev+bounces-59394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DAD81ABF2
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E01F22D17
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2821843;
	Thu, 21 Dec 2023 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW/vogio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715557484
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2368AC433C7;
	Thu, 21 Dec 2023 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120262;
	bh=gdaMdGQEJCu4Xd6PrV+dN2V36u0p4zM4fRxfVDBbQ/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qW/vogioQQGhEf9BKP5/PQQiM4xVsskA9NBTSRfsrSw/iCLvSb6JQ1xndcTKnJLjY
	 6GJ0ly+/sWYwcpBZsdHdLI0P4XiGVFSVxfE6H8fnCUgSdDT+7aDYVgfYy+Epu2p0Gc
	 YEe/AUReRx/osYoyDAg3Og3PbjMhJLEES2k2xWSYQMP7Ttn+/BCp//0Z0zSkAZNmUP
	 Ht0ySz+/fuzzeqe25gkzuoG6KztRq7vYCPcjmttaQ8CHwPLlVnJs+amc+J965OgzGW
	 pZXzPviq1J+gUsRbL0fJucOuny2kDNbCWlmjQN2tYWAFS3A/Vcb/z+WoIz677xIFpW
	 2J29uHxg7t6zg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 09/15] net/mlx5e: Create EN core HW resources for all secondary devices
Date: Wed, 20 Dec 2023 16:57:15 -0800
Message-ID: <20231221005721.186607-10-saeed@kernel.org>
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

Traffic queues will be created on all devices, including the
secondaries. Create the needed core layer resources for them as well.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 +++++++++++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55c6ace0acd5..6c143088e247 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -60,6 +60,7 @@
 #include "lib/clock.h"
 #include "en/rx_res.h"
 #include "en/selq.h"
+#include "lib/sd.h"
 
 extern const struct net_device_ops mlx5e_netdev_ops;
 struct page_pool;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2c47c9076aa6..90a02fd3357a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5988,22 +5988,29 @@ static int _mlx5e_resume(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = edev->mdev;
-	int err;
+	struct mlx5_core_dev *pos, *to;
+	int err, i;
 
 	if (netif_device_present(netdev))
 		return 0;
 
-	err = mlx5e_create_mdev_resources(mdev, true);
-	if (err)
-		return err;
+	mlx5_sd_for_each_dev(i, mdev, pos) {
+		err = mlx5e_create_mdev_resources(pos, true);
+		if (err)
+			goto err_destroy_mdev_res;
+	}
 
 	err = mlx5e_attach_netdev(priv);
-	if (err) {
-		mlx5e_destroy_mdev_resources(mdev);
-		return err;
-	}
+	if (err)
+		goto err_destroy_mdev_res;
 
 	return 0;
+
+err_destroy_mdev_res:
+	to = pos;
+	mlx5_sd_for_each_dev_to(i, mdev, to, pos)
+		mlx5e_destroy_mdev_resources(pos);
+	return err;
 }
 
 static int mlx5e_resume(struct auxiliary_device *adev)
@@ -6029,15 +6036,20 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
+	struct mlx5_core_dev *pos;
+	int i;
 
 	if (!netif_device_present(netdev)) {
 		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
-			mlx5e_destroy_mdev_resources(mdev);
+			mlx5_sd_for_each_dev(i, mdev, pos)
+				mlx5e_destroy_mdev_resources(pos);
 		return -ENODEV;
 	}
 
 	mlx5e_detach_netdev(priv);
-	mlx5e_destroy_mdev_resources(mdev);
+	mlx5_sd_for_each_dev(i, mdev, pos)
+		mlx5e_destroy_mdev_resources(pos);
+
 	return 0;
 }
 
-- 
2.43.0


