Return-Path: <netdev+bounces-20586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973C7602A9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04806280E4D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F56154A0;
	Mon, 24 Jul 2023 22:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5215484
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE2DC4339A;
	Mon, 24 Jul 2023 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238683;
	bh=xvgpXhgqpDS0hHe29keZLRjvNaZBMpaJb3az45tOT2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnBK3KK96Tqkoq3QsfWGCYrvN7T3tFcHDwiKzEurQgF/k8x2iCumQLV7Aj6gT1WLg
	 c9ysCdX1q6QWsC+ts5cpu/CH/kFAO5T/Fu/1VdlxFRxmz3ruu1wO0wfyvAdRsZZNO2
	 a1biIUUf7u1EBhqSHIsKsXXsM0LgYwABBUymrqRR0wURqtDjgWpZ+ZctBfPYQMrqQ3
	 x8zvUmL3eKu9cHmvb84GdtX5esUoJKzJfUDCAoQzKOJ9MYWAjNXVE9b+Wd/C5NLiCo
	 KgfQdu8Z+JoMNl2dlmpUmEK+403+16jj1eltIVhcNcyBqiF9Q4V2MAyCe3CN1/PR2I
	 HhqqDmbsxAkiQ==
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
Subject: [net-next 14/14] net/mlx5: Remove pointless devlink_rate checks
Date: Mon, 24 Jul 2023 15:44:26 -0700
Message-ID: <20230724224426.231024-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724224426.231024-1-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

It is guaranteed that the devlink rate leaf is created during init paths.
No need to check during cleanup. Remove the checks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c   | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index af779c700278..433541ac36a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -132,10 +132,8 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, u16 vpo
 	if (IS_ERR(vport))
 		return;
 
-	if (vport->dl_port->devlink_rate) {
-		mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
-		devl_rate_leaf_destroy(vport->dl_port);
-	}
+	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
+	devl_rate_leaf_destroy(vport->dl_port);
 
 	devl_port_unregister(vport->dl_port);
 	mlx5_esw_dl_port_free(vport->dl_port);
@@ -211,10 +209,8 @@ void mlx5_esw_devlink_sf_port_unregister(struct mlx5_eswitch *esw, u16 vport_num
 	if (IS_ERR(vport))
 		return;
 
-	if (vport->dl_port->devlink_rate) {
-		mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
-		devl_rate_leaf_destroy(vport->dl_port);
-	}
+	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
+	devl_rate_leaf_destroy(vport->dl_port);
 
 	devl_port_unregister(vport->dl_port);
 	vport->dl_port = NULL;
-- 
2.41.0


