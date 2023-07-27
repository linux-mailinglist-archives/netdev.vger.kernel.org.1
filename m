Return-Path: <netdev+bounces-22019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C7765B74
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3F61C216FE
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696418049;
	Thu, 27 Jul 2023 18:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B11803B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F11DC433C7;
	Thu, 27 Jul 2023 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483164;
	bh=h9QOIcIwTfAQK1rWsP8LHo1GgO2t1UxNzNg8AfxG1QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slcHyZH748EG+giZbbF7C2xrlqzBIZp+T/16yN3GCNgGLTPzITD3OhgCnW1Ysgcex
	 1ng0xs985zjvHODKQB5pQxWf3gCpOYjWXUfaix1YNQTFHPZN6XZ1UxZ3ayIq56I6RS
	 vGi8a5e23POlUSVRza8ZPXAwFdTAdiowui1xQGrIJbcEbEyX1WfQfwgD9SVt/n+e85
	 RA6AzEqEAuJ0E9ZYCiEtnosIFItfg8rWbV338IkrGn90airZcdYQxsef1dh3HPbqou
	 gTzMeanOC0JB6+xlZ25ARueDrR+LvH1kpdKGN0HVrRon3+QE5sAJlACpwOwrzS8Edq
	 VH0dFw4EHO56w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net-next V2 01/15] net/mlx5: Use shared code for checking lag is supported
Date: Thu, 27 Jul 2023 11:39:00 -0700
Message-ID: <20230727183914.69229-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

Move shared function to check lag is supported to lag header file.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c     |  6 ++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 10 ----------
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h | 12 ++++++++++--
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index edb06fb9bbc5..7909f378dc93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -36,6 +36,7 @@
 #include <linux/mlx5/vport.h>
 #include "mlx5_core.h"
 #include "devlink.h"
+#include "lag/lag.h"
 
 /* intf dev list mutex */
 static DEFINE_MUTEX(mlx5_intf_mutex);
@@ -587,10 +588,7 @@ static int next_phys_dev_lag(struct device *dev, const void *data)
 	if (!mdev)
 		return 0;
 
-	if (!MLX5_CAP_GEN(mdev, vport_group_manager) ||
-	    !MLX5_CAP_GEN(mdev, lag_master) ||
-	    (MLX5_CAP_GEN(mdev, num_lag_ports) > MLX5_MAX_PORTS ||
-	     MLX5_CAP_GEN(mdev, num_lag_ports) <= 1))
+	if (!mlx5_lag_is_supported(mdev))
 		return 0;
 
 	return _next_phys_dev(mdev, data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f0a074b2fcdf..900a18883f28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1268,16 +1268,6 @@ void mlx5_lag_remove_mdev(struct mlx5_core_dev *dev)
 	mlx5_ldev_put(ldev);
 }
 
-bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
-{
-	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
-	    !MLX5_CAP_GEN(dev, lag_master) ||
-	    MLX5_CAP_GEN(dev, num_lag_ports) < 2 ||
-	    MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS)
-		return false;
-	return true;
-}
-
 void mlx5_lag_add_mdev(struct mlx5_core_dev *dev)
 {
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index a061b1873e27..481e92f39fe6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -74,8 +74,6 @@ struct mlx5_lag {
 	struct lag_mpesw	  lag_mpesw;
 };
 
-bool mlx5_lag_is_supported(struct mlx5_core_dev *dev);
-
 static inline struct mlx5_lag *
 mlx5_lag_dev(struct mlx5_core_dev *dev)
 {
@@ -115,4 +113,14 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev);
 int mlx5_deactivate_lag(struct mlx5_lag *ldev);
 void mlx5_lag_add_devices(struct mlx5_lag *ldev);
 
+static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
+{
+	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
+	    !MLX5_CAP_GEN(dev, lag_master) ||
+	    MLX5_CAP_GEN(dev, num_lag_ports) < 2 ||
+	    MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS)
+		return false;
+	return true;
+}
+
 #endif /* __MLX5_LAG_H__ */
-- 
2.41.0


