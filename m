Return-Path: <netdev+bounces-20576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C10760294
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47022815DB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A50134CE;
	Mon, 24 Jul 2023 22:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDE134A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9842C433C8;
	Mon, 24 Jul 2023 22:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238673;
	bh=js6D8basR/+FklRKy+s0qT9AITikrgrEfgiE77iXS9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrvp+QvTda36iklQzQYPOOa6ZWt6YibqgnreC/ASICU4x04xtXQ/skzfSw2+Kc9yX
	 UcIDdK/7yOTDapBNtWb5hTA5lSPE7NIykXDV/7pAOXRTFPq/uQlEiu56BXupuo7lzF
	 2VzVxA01NkWbiOELNNQ9qUltzCllOFOTWOFQrZ3XFkjdhrBUh8faf418du3bgbuyJ/
	 gE741qLDwsEF5bDObO0aC/vXGIRw0tVnFkiHrRuSjPSZERpNkFRnAfLl5yKy72R5Cm
	 lRoEFuZn8CcDtZz2X7x4zLF349n87fzZIfABQ/ZLMM8oyWCwYwWBhPcN7euGuW4vPa
	 WhgqGc/2rvGVA==
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
Subject: [net-next 05/14] net/mlx5e: E-Switch, Register devcom device with switch id key
Date: Mon, 24 Jul 2023 15:44:17 -0700
Message-ID: <20230724224426.231024-6-saeed@kernel.org>
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

From: Roi Dayan <roid@nvidia.com>

Register devcom devices with switch id instead of guid.
Devcom interface is used to sync between ports in the eswitch,
e.g. Adding miss rules between the ports.
New eswitch devices could have the same guid but a different
switch id so its more correct to group according to switch id
which is the identifier if the ports are on the same eswitch.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c          | 9 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h        | 4 ++--
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 7 ++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 22bc88620653..507825a1abc8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5194,11 +5194,12 @@ void mlx5e_tc_ht_cleanup(struct rhashtable *tc_ht)
 int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 {
 	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
+	struct netdev_phys_item_id ppid;
 	struct mlx5e_rep_priv *rpriv;
 	struct mapping_ctx *mapping;
 	struct mlx5_eswitch *esw;
 	struct mlx5e_priv *priv;
-	u64 mapping_id;
+	u64 mapping_id, key;
 	int err = 0;
 
 	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
@@ -5252,7 +5253,11 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_action_counter;
 	}
 
-	mlx5_esw_offloads_devcom_init(esw);
+	err = dev_get_port_parent_id(priv->netdev, &ppid, false);
+	if (!err) {
+		memcpy(&key, &ppid.id, sizeof(key));
+		mlx5_esw_offloads_devcom_init(esw, key);
+	}
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6d9378b0bce5..9b5a1651b877 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -382,7 +382,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key);
 void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
@@ -818,7 +818,7 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
-static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw) {}
+static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key) {}
 static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw) { return false; }
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 11cce630c1b8..7d100cd4afab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2886,9 +2886,8 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	return err;
 }
 
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
 {
-	u64 guid;
 	int i;
 
 	for (i = 0; i < MLX5_MAX_PORTS; i++)
@@ -2902,12 +2901,10 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw)
 		return;
 
 	xa_init(&esw->paired);
-	guid = mlx5_query_nic_system_image_guid(esw->dev);
-
 	esw->num_peers = 0;
 	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
 						     MLX5_DEVCOM_ESW_OFFLOADS,
-						     guid,
+						     key,
 						     mlx5_esw_offloads_devcom_event,
 						     esw);
 	if (IS_ERR_OR_NULL(esw->devcom))
-- 
2.41.0


