Return-Path: <netdev+bounces-77749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88657872D2F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3368D28E494
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4049A179B2;
	Wed,  6 Mar 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0xw0MtZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7831804E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694198; cv=none; b=nZejpf6EQbgave0qGBb/P3553fUcWQojYoQ0LgxR9xENik+7SJ4wc2BDrI3hAvOJNBXe4T2m2DoZmNBcI5oT7/id05E4h32DGx4mqWgo7aWGfnnDtEOui1Y0j+PQUPr+XAj5kLBrvmksE4N5htyyvw88rXURNgtjDWwqsBisL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694198; c=relaxed/simple;
	bh=wyXddwULvcl3/d051VrkRLBX8+Q+gZouGu+RH1Dns4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvXyK5++eEslEXp44k1TbjF/kF+Uu7g86ISCf1h47pwmhmYiT9LY2J7GWhaICkFGxHUKHkRWcq57oOpRl9RgQ5Omv5PJG1NoI2w3lFPrjG+WgE5mo9Xi2caUNd7i8fEVnQ6B2cfX9L1WnU0dR73GuFF1dOtofcrm6VlmR8CC7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0xw0MtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA3C433A6;
	Wed,  6 Mar 2024 03:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694198;
	bh=wyXddwULvcl3/d051VrkRLBX8+Q+gZouGu+RH1Dns4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0xw0MtZcO5AB1wr7DUOK7BqEsZZ2kwWNCUOF4uYTZyiWLm1yGGPNp+QYryFo2pLl
	 9yeKBn1pv3WZrkpOUs7qeRtfdsm/psiYZ4nLndEwiIbTUxpEeGaM8oIKa1aukNmYC7
	 cmvKnO7KfSlVd4N4t2xvNynMnQWyvwY0FiG0EiFPwT5mtjWWfU39P+YvkrFILLPqNN
	 CO1GCZ6pUEcH2zpyHAPXhNP2c2gIk0iSY0mva+ltrKKbY4yimGzrR/jdaOQwtV0yqh
	 IfDAO1klbELgB/SDlzFmJVbESQ4gys5Kce7A2bKTiQBDBKIVZm+ZQ9tFlqQ+ksxk5Q
	 vxBEX02eLLq+A==
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
Subject: [net-next V5 09/15] net/mlx5e: Create EN core HW resources for all secondary devices
Date: Tue,  5 Mar 2024 19:02:52 -0800
Message-ID: <20240306030258.16874-10-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
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
index ef6a342742a2..c6c406c18b54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5995,22 +5995,29 @@ static int _mlx5e_resume(struct auxiliary_device *adev)
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
@@ -6036,15 +6043,20 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
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
2.44.0


