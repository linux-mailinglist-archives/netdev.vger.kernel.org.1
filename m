Return-Path: <netdev+bounces-22030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8D765B84
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD90F1C215FF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085161DA3A;
	Thu, 27 Jul 2023 18:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64691C9ED
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD04C433BB;
	Thu, 27 Jul 2023 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483174;
	bh=xvgpXhgqpDS0hHe29keZLRjvNaZBMpaJb3az45tOT2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bh29vmWHOpz+fqdKU0yLKMjMSt/8mwA0D9Y14zxEDinGfum9QH6QTwDdeD6kKqO+r
	 RVRt7HxsOpUYsbuu9ojPFqX14DkZUfs14toHhiTeHNqVsdA4v6maU148Pq11H0F7d7
	 UzxvGFzg031oMkVyrmHlWiorBdo0cIw0UNPofQQ/Ru9cHjbX9Y40cdpzu/YBqK2uTN
	 xME6pomsLDoGr2D1t1t4kgfyTI/KDbAEZhALoq6pjmbuYk2pri6R51k1OrCybPnxFQ
	 tALxWQlpZS/lqLkO6B5Pq6PJtQgJyRU8ZodLeKPDMEwl8OtBX9taHfJojFcMffMtv4
	 Yga3Pbqnz6lGA==
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
Subject: [net-next V2 12/15] net/mlx5: Remove pointless devlink_rate checks
Date: Thu, 27 Jul 2023 11:39:11 -0700
Message-ID: <20230727183914.69229-13-saeed@kernel.org>
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


