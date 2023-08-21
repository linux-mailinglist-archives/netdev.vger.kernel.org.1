Return-Path: <netdev+bounces-29395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD78782FD5
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5A280E2C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A9125A8;
	Mon, 21 Aug 2023 17:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059E11738
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A73C433CA;
	Mon, 21 Aug 2023 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640680;
	bh=4/MIB0upsVuKv9ZpV/ZfvtOckzD83c1l5nZHNp3cpH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpFxbbPzG5sX7MAqlpYmEStza8fIOMg76GH4WmjKcw8s3vWf6x41IMAl52kVr19mL
	 xnhrfONzwMJ66bffCoi4BZEA33H7xZbFiCOWupJrdZNM8tMz+GCW3Y/2Xp8FmegM/3
	 3L6IHQAyUDrWF3ZHJfSdIefA5HvQRozA7wwrFoz1Vx1P8QQojp7Q5RLaCuq93A3KpL
	 EcFRnqYN6b6aW7aFIWCMD0Om9yWWk1KE38x+ybxtWOCShdI9mDicU8puC42fUCiZ0c
	 ez7hYQTyqTYy/DZxt5Qw++fMW1LdX/UBFC5MsL4viiKKkuKuUtEql/Ozh6c4nAGiav
	 SzTeDYAgj6BoQ==
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
Subject: [net-next V2 10/14] net/mlx5: Call mlx5_esw_offloads_rep_load/unload() for uplink port directly
Date: Mon, 21 Aug 2023 10:57:35 -0700
Message-ID: <20230821175739.81188-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

For uplink port, mlx5_esw_offloads_load/unload_rep() are currently
called. There are 2 check inside, which effectively make the
functions a simple wrappers of mlx5_esw_offloads_rep_load/unload()
for uplink port. So avoid one check and indirection and call
mlx5_esw_offloads_rep_load/unload() for uplink port directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 46b8c60ac39a..c0b1b7b66cff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2542,11 +2542,9 @@ int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return 0;
 
-	if (vport_num != MLX5_VPORT_UPLINK) {
-		err = mlx5_esw_offloads_devlink_port_register(esw, vport_num);
-		if (err)
-			return err;
-	}
+	err = mlx5_esw_offloads_devlink_port_register(esw, vport_num);
+	if (err)
+		return err;
 
 	err = mlx5_esw_offloads_rep_load(esw, vport_num);
 	if (err)
@@ -2554,8 +2552,7 @@ int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, u16 vport_num)
 	return err;
 
 load_err:
-	if (vport_num != MLX5_VPORT_UPLINK)
-		mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
+	mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
 	return err;
 }
 
@@ -2566,8 +2563,7 @@ void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, u16 vport_num)
 
 	mlx5_esw_offloads_rep_unload(esw, vport_num);
 
-	if (vport_num != MLX5_VPORT_UPLINK)
-		mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
+	mlx5_esw_offloads_devlink_port_unregister(esw, vport_num);
 }
 
 static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
@@ -3471,7 +3467,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 			vport->info.link_state = MLX5_VPORT_ADMIN_STATE_DOWN;
 
 	/* Uplink vport rep must load first. */
-	err = mlx5_esw_offloads_load_rep(esw, MLX5_VPORT_UPLINK);
+	err = mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK);
 	if (err)
 		goto err_uplink;
 
@@ -3482,7 +3478,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	return 0;
 
 err_vports:
-	mlx5_esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
+	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
 err_uplink:
 	esw_offloads_steering_cleanup(esw);
 err_steering_init:
@@ -3520,7 +3516,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_disable_pf_vf_vports(esw);
-	mlx5_esw_offloads_unload_rep(esw, MLX5_VPORT_UPLINK);
+	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
 	esw_set_passing_vport_metadata(esw, false);
 	esw_offloads_steering_cleanup(esw);
 	mapping_destroy(esw->offloads.reg_c0_obj_pool);
-- 
2.41.0


