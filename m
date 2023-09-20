Return-Path: <netdev+bounces-35119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61317A72D9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9C281631
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B985252;
	Wed, 20 Sep 2023 06:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E265245
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33B8C433CD;
	Wed, 20 Sep 2023 06:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191759;
	bh=9ARnDZRP9AUyU5H6IoANuR91u5yR9WEuuO5J8EgCXHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQOGyaVi5Hk2XDXJ/WEcDQoFDfdhoTxd4lkL3j6/xqaopWlhgW3O36DyRBUVqBTYP
	 iztQn+/+fE4TEbe+DPLy2KoWgrb/fxbRwiBtpxsifHILMQCDvRi/02qyZhdSF39HMJ
	 XV90HY980HDAutA0RVrE7cFegnPBfIBrdSnSE8bbBgLR0U/dhe7u7HCqnecVCfQqE2
	 gRPtzNLXY5YY/82xVjVt3TzNyUBx7x5dgHQ1oi3FA1K03WGONX2aukybIFgDmwORXy
	 UoUBlQIPEYMjV0Uq619ExlZVlzV7dzqDbsOr6Tp/iWM53wPiNrAvBs9NxMSeDHu9YS
	 U1TrWi4wTPapQ==
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
Subject: [net-next 01/15] net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()
Date: Tue, 19 Sep 2023 23:35:38 -0700
Message-ID: <20230920063552.296978-2-saeed@kernel.org>
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

Before every call of mlx5_sf_dealloc(), there is a call to
mlx5_sf_id_erase(). So move it to the beginning of mlx5_sf_dealloc().
Also remove redundant mlx5_sf_id_erase() call from mlx5_sf_free()
as it is called only from mlx5_sf_dealloc().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 964a5b1876f3..519033d70e05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -112,7 +112,6 @@ mlx5_sf_alloc(struct mlx5_sf_table *table, struct mlx5_eswitch *esw,
 
 static void mlx5_sf_free(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
-	mlx5_sf_id_erase(table, sf);
 	mlx5_sf_hw_table_sf_free(table->dev, sf->controller, sf->id);
 	trace_mlx5_sf_free(table->dev, sf->port_index, sf->controller, sf->hw_fn_id);
 	kfree(sf);
@@ -362,6 +361,8 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
+	mlx5_sf_id_erase(table, sf);
+
 	if (sf->hw_state == MLX5_VHCA_STATE_ALLOCATED) {
 		mlx5_sf_free(table, sf);
 	} else if (mlx5_sf_is_active(sf)) {
@@ -402,7 +403,6 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 	}
 
 	mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
-	mlx5_sf_id_erase(table, sf);
 
 	mutex_lock(&table->sf_state_lock);
 	mlx5_sf_dealloc(table, sf);
@@ -474,7 +474,6 @@ static void mlx5_sf_deactivate_all(struct mlx5_sf_table *table)
 	 */
 	xa_for_each(&table->port_indices, index, sf) {
 		mlx5_eswitch_unload_sf_vport(esw, sf->hw_fn_id);
-		mlx5_sf_id_erase(table, sf);
 		mlx5_sf_dealloc(table, sf);
 	}
 }
-- 
2.41.0


