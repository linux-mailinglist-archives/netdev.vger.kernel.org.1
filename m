Return-Path: <netdev+bounces-13519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098BB73BEC9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ABA281D03
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D510947;
	Fri, 23 Jun 2023 19:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB64101F5
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86BFC433C9;
	Fri, 23 Jun 2023 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548555;
	bh=xhDHSDbjlKMsWK2KnWbFnQ8wZZ48VsGkNTXf+pLJmm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PD/zD1WsqiSEgQ5bnWRsRhShHJ9/CmkUFJeVdjM5jVFz0AzI7EJU9uTvbw7Z80/QB
	 VAZm/cK/mREBCj6Glay5UEwVu1L7Pp0qpQ1Pnu0hjHozj8PVjeDq3u2op1oe6KAFwu
	 FQ3rICeyFB0xHPSyO694xt0EbXyOw2ab2E4vTNUB40SCaxP4wmBPgV8fPcqq+D60a4
	 Tk0LMpBeyUdIi+1QQNkaqk1OZERN3y/1NsWcuHdq+PX3wJF0HO4ENhz1lIYNVk77r6
	 sTqUsiR9LZoEYOni+M1H+bne8WJb/z1BXFfWaJ2dg+9PGmrnDoMjFB6om2Wkpz2tnG
	 shXxl2O2MXm+A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Automatic Verification <verifier@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next V2 01/15] net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
Date: Fri, 23 Jun 2023 12:28:53 -0700
Message-ID: <20230623192907.39033-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

mlx5_eswitch_cleanup() is using esw right after freeing it for
releasing devlink_param.
Fix it by releasing the devlink_param before freeing the esw, and
adjust the create function accordingly.

Fixes: 3f90840305e2 ("net/mlx5: Move esw multiport devlink param to eswitch code")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Automatic Verification <verifier@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c  | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 5aaedbf71783..b4e465856127 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1751,16 +1751,14 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (!MLX5_VPORT_MANAGER(dev) && !MLX5_ESWITCH_MANAGER(dev))
 		return 0;
 
+	esw = kzalloc(sizeof(*esw), GFP_KERNEL);
+	if (!esw)
+		return -ENOMEM;
+
 	err = devl_params_register(priv_to_devlink(dev), mlx5_eswitch_params,
 				   ARRAY_SIZE(mlx5_eswitch_params));
 	if (err)
-		return err;
-
-	esw = kzalloc(sizeof(*esw), GFP_KERNEL);
-	if (!esw) {
-		err = -ENOMEM;
-		goto unregister_param;
-	}
+		goto free_esw;
 
 	esw->dev = dev;
 	esw->manager_vport = mlx5_eswitch_manager_vport(dev);
@@ -1821,10 +1819,10 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (esw->work_queue)
 		destroy_workqueue(esw->work_queue);
 	debugfs_remove_recursive(esw->debugfs_root);
-	kfree(esw);
-unregister_param:
 	devl_params_unregister(priv_to_devlink(dev), mlx5_eswitch_params,
 			       ARRAY_SIZE(mlx5_eswitch_params));
+free_esw:
+	kfree(esw);
 	return err;
 }
 
@@ -1848,9 +1846,9 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 	esw_offloads_cleanup(esw);
 	mlx5_esw_vports_cleanup(esw);
 	debugfs_remove_recursive(esw->debugfs_root);
-	kfree(esw);
 	devl_params_unregister(priv_to_devlink(esw->dev), mlx5_eswitch_params,
 			       ARRAY_SIZE(mlx5_eswitch_params));
+	kfree(esw);
 }
 
 /* Vport Administration */
-- 
2.41.0


