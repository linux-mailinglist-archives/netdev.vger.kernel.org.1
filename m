Return-Path: <netdev+bounces-12909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7E7396FA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118CC281815
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1FB567C;
	Thu, 22 Jun 2023 05:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25B567D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434FC433C8;
	Thu, 22 Jun 2023 05:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412871;
	bh=rOnoccgD64VoV7oKhVjIkotxlbpbo6XLh8qrQfWSQI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fumWcITCccNbs6MCv2/X8nPEhiDfRnKypTmkJAv6YXplzt4EPbfl8jArA/GmtLfwc
	 EXOUtkabkS6ZPhiOwVf7Plu11t50w47sUwOvM8kwbjWs70VdZiCR8Rys6ou2aSv/8v
	 kipQuPgGVwLJQLHn2Z5hHAX0Y5nBuJYLcD4/glqdqgsOctLZVQYjeU7RgUvSNzQXAq
	 yRZ2LbI499IIbUepoKzwrOsqmVVk+J9cFMO0lZL8fqtpA7Pq0zqKbvgwAujYwIzmra
	 hwwYZrTixGUD7WS9CMY/ujsvihpuI4/HXi0nRMfqjQq1ZpBT0aJfiorxwkaYvlZ6xg
	 1M3NseN15G7Xw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 05/15] net/mlx5: Lag, Remove duplicate code checking lag is supported
Date: Wed, 21 Jun 2023 22:47:25 -0700
Message-ID: <20230622054735.46790-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

Remove duplicate function for checking if device has lag support.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c         |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 15 +++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h | 10 +---------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index fdf482f6fb34..9056b0b014f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2868,7 +2868,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 	if (!MLX5_CAP_ESW(esw->dev, merged_eswitch))
 		return;
 
-	if (!mlx5_is_lag_supported(esw->dev))
+	if (!mlx5_lag_is_supported(esw->dev))
 		return;
 
 	mlx5_devcom_register_component(devcom,
@@ -2890,7 +2890,7 @@ void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 	if (!MLX5_CAP_ESW(esw->dev, merged_eswitch))
 		return;
 
-	if (!mlx5_is_lag_supported(esw->dev))
+	if (!mlx5_lag_is_supported(esw->dev))
 		return;
 
 	mlx5_devcom_send_event(devcom, MLX5_DEVCOM_ESW_OFFLOADS,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ffd7e17b8ebe..f0a074b2fcdf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1268,14 +1268,21 @@ void mlx5_lag_remove_mdev(struct mlx5_core_dev *dev)
 	mlx5_ldev_put(ldev);
 }
 
+bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
+{
+	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
+	    !MLX5_CAP_GEN(dev, lag_master) ||
+	    MLX5_CAP_GEN(dev, num_lag_ports) < 2 ||
+	    MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS)
+		return false;
+	return true;
+}
+
 void mlx5_lag_add_mdev(struct mlx5_core_dev *dev)
 {
 	int err;
 
-	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
-	    !MLX5_CAP_GEN(dev, lag_master) ||
-	    (MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS ||
-	     MLX5_CAP_GEN(dev, num_lag_ports) <= 1))
+	if (!mlx5_lag_is_supported(dev))
 		return;
 
 recheck:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index d7e7fa2348a5..a061b1873e27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -74,15 +74,7 @@ struct mlx5_lag {
 	struct lag_mpesw	  lag_mpesw;
 };
 
-static inline bool mlx5_is_lag_supported(struct mlx5_core_dev *dev)
-{
-	if (!MLX5_CAP_GEN(dev, vport_group_manager) ||
-	    !MLX5_CAP_GEN(dev, lag_master) ||
-	    MLX5_CAP_GEN(dev, num_lag_ports) < 2 ||
-	    MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_MAX_PORTS)
-		return false;
-	return true;
-}
+bool mlx5_lag_is_supported(struct mlx5_core_dev *dev);
 
 static inline struct mlx5_lag *
 mlx5_lag_dev(struct mlx5_core_dev *dev)
-- 
2.41.0


