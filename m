Return-Path: <netdev+bounces-40468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8C7C7762
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9501C210F7
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121693C69F;
	Thu, 12 Oct 2023 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD+ZJwx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571B3C693
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAD4C433C7;
	Thu, 12 Oct 2023 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140390;
	bh=XEdUF4MvARylaYh5io+PWEuSwVkPCzttZi1Bq/CfRdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pD+ZJwx6UPs4heGBeBicBssn/3HFIKdrURZt61aZn4dRi0WC7WbpAs6hURYCcUXL0
	 SaKbDtx6Cb1KatjPbl4svlWL9bYE4ilJLm548I+W3gkBC2OwCT5Id8qgX+L3nsD5hS
	 RH7CSp0NAw7fn97QFNFmIJE7+qyIbaF8jYhD5vsIk3wlXWu1fepzrlhrZfJV0jEAE0
	 CBbxf9vhW6voEeif7jYoRAX/bYFoRbMdUe3I/ftSZOSb+1jziZzgK6YoMKyfuJFu6U
	 BDj5aE3Zsu5EUqk+PCuvJQlQf9ppTjAoA0ZB7INEhVb9ulzqHn0p7XrJsBwpW3MGtm
	 IdTlQATz78ZSw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net 02/10] net/mlx5: E-switch, register event handler before arming the event
Date: Thu, 12 Oct 2023 12:51:19 -0700
Message-ID: <20231012195127.129585-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012195127.129585-1-saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Currently, mlx5 is registering event handler for vport context change
event some time after arming the event. this can lead to missing an
event, which will result in wrong rules in the FDB.
Hence, register the event handler before arming the event.

This solution is valid since FW is sending vport context change event
only on vports which SW armed, and SW arming the vport when enabling
it, which is done after the FDB has been created.

Fixes: 6933a9379559 ("net/mlx5: E-Switch, Use async events chain")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c   | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index d4cde6555063..8d0b915a3121 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1038,11 +1038,8 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(err);
 }
 
-static void mlx5_eswitch_event_handlers_register(struct mlx5_eswitch *esw)
+static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 {
-	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
-	mlx5_eq_notifier_register(esw->dev, &esw->nb);
-
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		MLX5_NB_INIT(&esw->esw_funcs.nb, mlx5_esw_funcs_changed_handler,
 			     ESW_FUNCTIONS_CHANGED);
@@ -1050,13 +1047,11 @@ static void mlx5_eswitch_event_handlers_register(struct mlx5_eswitch *esw)
 	}
 }
 
-static void mlx5_eswitch_event_handlers_unregister(struct mlx5_eswitch *esw)
+static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
 
-	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
-
 	flush_workqueue(esw->work_queue);
 }
 
@@ -1483,6 +1478,9 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	mlx5_eswitch_update_num_of_vfs(esw, num_vfs);
 
+	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
+	mlx5_eq_notifier_register(esw->dev, &esw->nb);
+
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -1495,7 +1493,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
-	mlx5_eswitch_event_handlers_register(esw);
+	mlx5_eswitch_event_handler_register(esw);
 
 	esw_info(esw->dev, "Enable: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
@@ -1622,7 +1620,8 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 	 */
 	mlx5_esw_mode_change_notify(esw, MLX5_ESWITCH_LEGACY);
 
-	mlx5_eswitch_event_handlers_unregister(esw);
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
+	mlx5_eswitch_event_handler_unregister(esw);
 
 	esw_info(esw->dev, "Disable: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
-- 
2.41.0


