Return-Path: <netdev+bounces-35124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC837A72E4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EB81C20934
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696598830;
	Wed, 20 Sep 2023 06:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F638829
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B34C433C7;
	Wed, 20 Sep 2023 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191764;
	bh=CFAZHzZlvqK29fZgZPM3jTFFiD8PtosX4Hn5rBBtQtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKO0HbL0sVd9+vUjXiYnxNghzqKz640643dzmWDAue6y7KJx2YRMXCyzXYx6GyejT
	 cbW4n2DFa52TeTwpGEWir30sUB0HuQkc9Q6rEaJWA5riF/mp3ARG1WsILSGvVnQtnK
	 0GtCfn9XM0adkvHWrVXZWTOHfi4s2dyB8dW+m00rvTNXrAL+fmEv3Wpm7rs6+MB4aQ
	 yaFBLEkp/Aq5ub5bzGPaWN1g/kvcPNHjoNVGpBq+yJFeaXxPdfxDuQxdLs48yVmIMA
	 1xrAzv25VIDsm0+/YExMpBXkbtmfbirHupP5+B/7VOm6Ep415iolTThjSjzyHDqgY7
	 AD8K8QPqvdcYg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 06/15] net/mlx5: Push common deletion code into mlx5_sf_del()
Date: Tue, 19 Sep 2023 23:35:43 -0700
Message-ID: <20230920063552.296978-7-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

Don't call the same functions for SF deletion on multiple places.
Instead, introduce a helper mlx5_sf_del() and move the code there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 454185ef04f3..c8a043b2a8e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -364,13 +364,20 @@ static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 	mutex_unlock(&table->sf_state_lock);
 }
 
+static void mlx5_sf_del(struct mlx5_sf_table *table, struct mlx5_sf *sf)
+{
+	struct mlx5_eswitch *esw = table->dev->priv.eswitch;
+
+	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
+	mlx5_sf_dealloc(table, sf);
+}
+
 int mlx5_devlink_sf_port_del(struct devlink *devlink,
 			     struct devlink_port *dl_port,
 			     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
-	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_sf_table *table;
 
 	table = mlx5_sf_table_try_get(dev);
@@ -380,8 +387,7 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
-	mlx5_sf_dealloc(table, sf);
+	mlx5_sf_del(table, sf);
 	mlx5_sf_table_put(table);
 	return 0;
 }
@@ -439,17 +445,14 @@ static void mlx5_sf_table_enable(struct mlx5_sf_table *table)
 
 static void mlx5_sf_del_all(struct mlx5_sf_table *table)
 {
-	struct mlx5_eswitch *esw = table->dev->priv.eswitch;
 	unsigned long index;
 	struct mlx5_sf *sf;
 
 	/* At this point, no new user commands can start and no vhca event can
 	 * arrive. It is safe to destroy all user created SFs.
 	 */
-	xa_for_each(&table->function_ids, index, sf) {
-		mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
-		mlx5_sf_dealloc(table, sf);
-	}
+	xa_for_each(&table->function_ids, index, sf)
+		mlx5_sf_del(table, sf);
 }
 
 static void mlx5_sf_table_disable(struct mlx5_sf_table *table)
-- 
2.41.0


