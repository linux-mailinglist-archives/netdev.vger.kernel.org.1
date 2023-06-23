Return-Path: <netdev+bounces-13530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2273BEE1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA541C212C2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C611C82;
	Fri, 23 Jun 2023 19:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C710966
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D8C433A9;
	Fri, 23 Jun 2023 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548562;
	bh=c0iYPlMcBNlCmWjQXap5TVdOiYxdgWpllsfylHLZpRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZJstPejAC0xAjpfk6OpSNQelptZBSI2JnkkSlu2dm9w+VX6YJ1fGFvf4uFL2kLKs
	 CgvGmCtFKeF0wGjUhaNqL5TbgWoY/4OkWPOFPWKRod2jnBh9GIzZtGJq+l9f2txmzX
	 vtv1GOb8Dfi3I/xl9xKVtGBfiYIknOjLI5db0kIWlXn5xI+S3Y8dajz9TYeo6a8iVB
	 Hm1ynlwIb849IIDcp58jUQpsL6EPF9/pfp0+v7/ApbtANyDAlIctr+oSdNzKovSwzk
	 2nMgj90tFYzhLMslyuJdU7VNjiz5iawu5ioDw83LW47S9l0XBN7zXd9FYnoCTtU0Ee
	 3ZNqd/A7b1nJg==
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
Subject: [net-next V2 08/15] net/mlx5e: E-Switch, Use xarray for devcom paired device index
Date: Fri, 23 Jun 2023 12:29:00 -0700
Message-ID: <20230623192907.39033-9-saeed@kernel.org>
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

From: Roi Dayan <roid@nvidia.com>

To allow devcom events on E-Switch that is not a vport group manager,
use vhca id as an index instead of device index which might be shared
between several E-Switches. for example SF and its PF.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 30 +++++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 7064609f4998..ae0dc8a3060d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -353,7 +353,7 @@ struct mlx5_eswitch {
 		u32             large_group_num;
 	}  params;
 	struct blocking_notifier_head n_head;
-	bool paired[MLX5_MAX_PORTS];
+	struct xarray paired;
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ed986d1c9e90..6f3b7d5eb6a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2807,15 +2807,21 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	struct mlx5_eswitch *esw = my_data;
 	struct mlx5_devcom *devcom = esw->dev->priv.devcom;
 	struct mlx5_eswitch *peer_esw = event_data;
+	u16 esw_i, peer_esw_i;
+	bool esw_paired;
 	int err;
 
+	peer_esw_i = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
+	esw_i = MLX5_CAP_GEN(esw->dev, vhca_id);
+	esw_paired = !!xa_load(&esw->paired, peer_esw_i);
+
 	switch (event) {
 	case ESW_OFFLOADS_DEVCOM_PAIR:
 		if (mlx5_eswitch_vport_match_metadata_enabled(esw) !=
 		    mlx5_eswitch_vport_match_metadata_enabled(peer_esw))
 			break;
 
-		if (esw->paired[mlx5_get_dev_index(peer_esw->dev)])
+		if (esw_paired)
 			break;
 
 		err = mlx5_esw_offloads_set_ns_peer(esw, peer_esw, true);
@@ -2829,23 +2835,29 @@ static int mlx5_esw_offloads_devcom_event(int event,
 		if (err)
 			goto err_pair;
 
-		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = true;
-		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = true;
+		err = xa_insert(&esw->paired, peer_esw_i, peer_esw, GFP_KERNEL);
+		if (err)
+			goto err_xa;
+
+		err = xa_insert(&peer_esw->paired, esw_i, esw, GFP_KERNEL);
+		if (err)
+			goto err_peer_xa;
+
 		esw->num_peers++;
 		peer_esw->num_peers++;
 		mlx5_devcom_comp_set_ready(devcom, MLX5_DEVCOM_ESW_OFFLOADS, true);
 		break;
 
 	case ESW_OFFLOADS_DEVCOM_UNPAIR:
-		if (!esw->paired[mlx5_get_dev_index(peer_esw->dev)])
+		if (!esw_paired)
 			break;
 
 		peer_esw->num_peers--;
 		esw->num_peers--;
 		if (!esw->num_peers && !peer_esw->num_peers)
 			mlx5_devcom_comp_set_ready(devcom, MLX5_DEVCOM_ESW_OFFLOADS, false);
-		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = false;
-		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = false;
+		xa_erase(&peer_esw->paired, esw_i);
+		xa_erase(&esw->paired, peer_esw_i);
 		mlx5_esw_offloads_unpair(peer_esw, esw);
 		mlx5_esw_offloads_unpair(esw, peer_esw);
 		mlx5_esw_offloads_set_ns_peer(esw, peer_esw, false);
@@ -2854,6 +2866,10 @@ static int mlx5_esw_offloads_devcom_event(int event,
 
 	return 0;
 
+err_peer_xa:
+	xa_erase(&esw->paired, peer_esw_i);
+err_xa:
+	mlx5_esw_offloads_unpair(peer_esw, esw);
 err_pair:
 	mlx5_esw_offloads_unpair(esw, peer_esw);
 err_peer:
@@ -2879,6 +2895,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 	if (!mlx5_lag_is_supported(esw->dev))
 		return;
 
+	xa_init(&esw->paired);
 	mlx5_devcom_register_component(devcom,
 				       MLX5_DEVCOM_ESW_OFFLOADS,
 				       mlx5_esw_offloads_devcom_event,
@@ -2906,6 +2923,7 @@ void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 			       ESW_OFFLOADS_DEVCOM_UNPAIR, esw);
 
 	mlx5_devcom_unregister_component(devcom, MLX5_DEVCOM_ESW_OFFLOADS);
+	xa_destroy(&esw->paired);
 }
 
 bool mlx5_esw_vport_match_metadata_supported(const struct mlx5_eswitch *esw)
-- 
2.41.0


