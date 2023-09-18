Return-Path: <netdev+bounces-34837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6C7A55E6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EE6281B46
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0228DD1;
	Mon, 18 Sep 2023 22:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B528DA6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:45:31 +0000 (UTC)
X-Greylist: delayed 922 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 15:45:24 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA6FC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1695077125; x=1697669125;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=0YsRXYBbuXnhWf+zWYyFmbZFXhPUlkNKfNdLVRBgGwg=;
	b=ISzPjkgBoy61tS3jKcSTyNVSyEETesdicnwVVVUGd6tolIZ4dYYfK6ziAGrC9nxDiI9Jrvq2p9oI5WilpDiVq+KajzGFoe8SxZH3HkBDkS2/xjebowhfJtHx7UL8yyFE9Sj+d2nZdtTU98o3GHdyhVbSJcxISlg9YXrN6hO215Q=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDc1Y2E1NzkubmV0ZGV2PXZnZXIua2VybmVsLm9yZw==
Received: from r1.h.in.socketlabs.com (r1.h.in.socketlabs.com [142.0.180.11]) by mxrs4.email-od.com
	with ESMTP(version=Tls12 cipher=Aes256 bits=256); Mon, 18 Sep 2023 18:30:00 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r1.h.in.socketlabs.com
	with ESMTP; Mon, 18 Sep 2023 18:29:59 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
	by nalramli.com (Postfix) with ESMTPS id C51312CE016C;
	Mon, 18 Sep 2023 18:29:58 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: netdev@vger.kernel.org,
	saeedm@nvidia.com,
	saeed@kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	tariqt@nvidia.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org
Cc: jdamato@fastly.com,
	sbhogavilli@fastly.com,
	nalramli@fastly.com,
	"Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC v2 3/4] mlx5: Implement mlx5e_ethtool_{get,set}_per_queue_coalesce() to support per-queue operations
Date: Mon, 18 Sep 2023 18:29:54 -0400
Message-Id: <20230918222955.2066-4-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230918222955.2066-1-dev@nalramli.com>
References: <ZOemz1HLp95aGXXQ@x130>
 <20230918222955.2066-1-dev@nalramli.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
	RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
	RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implment two new methods, mlx5e_ethtool_get_per_queue_coalesce() and
mlx5e_ethtool_set_per_queue_coalesce() and update global coalescing
request handlers to call into them for an extra level of indirection to
allow support for per-queue operations.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 152 +++++++++++++-----
 1 file changed, 112 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 13e5838ff1ee..daa0aa833a42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -513,33 +513,55 @@ static int mlx5e_set_channels(struct net_device *de=
v,
 	return mlx5e_ethtool_set_channels(priv, ch);
 }
=20
-int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
+static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv,
+						int queue,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
+	struct mlx5e_params *params;
=20
 	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
 		return -EOPNOTSUPP;
=20
-	rx_moder =3D &priv->channels.params.rx_cq_moderation;
+	if (queue !=3D -1 && queue >=3D priv->channels.num) {
+		netdev_err(priv->netdev, "%s: Invalid queue ID [%d]",
+			   __func__, queue);
+		return -EINVAL;
+	}
+
+	if (queue =3D=3D -1)
+		params =3D &priv->channels.params;
+	else
+		params =3D &priv->channels.c[queue]->params;
+
+	rx_moder =3D &params->rx_cq_moderation;
 	coal->rx_coalesce_usecs		=3D rx_moder->usec;
 	coal->rx_max_coalesced_frames	=3D rx_moder->pkts;
-	coal->use_adaptive_rx_coalesce	=3D priv->channels.params.rx_dim_enabled=
;
+	coal->use_adaptive_rx_coalesce	=3D params->rx_dim_enabled;
=20
-	tx_moder =3D &priv->channels.params.tx_cq_moderation;
+	tx_moder =3D &params->tx_cq_moderation;
 	coal->tx_coalesce_usecs		=3D tx_moder->usec;
 	coal->tx_max_coalesced_frames	=3D tx_moder->pkts;
-	coal->use_adaptive_tx_coalesce	=3D priv->channels.params.tx_dim_enabled=
;
+	coal->use_adaptive_tx_coalesce	=3D params->tx_dim_enabled;
=20
-	kernel_coal->use_cqe_mode_rx =3D
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODER=
);
-	kernel_coal->use_cqe_mode_tx =3D
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODER=
);
+	if (kernel_coal) {
+		kernel_coal->use_cqe_mode_rx =3D
+			MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODE=
R);
+		kernel_coal->use_cqe_mode_tx =3D
+			MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODE=
R);
+	}
=20
 	return 0;
 }
=20
+int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal)
+{
+	return mlx5e_ethtool_get_per_queue_coalesce(priv, -1, coal, kernel_coal=
);
+}
+
 static int mlx5e_get_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *coal,
 			      struct kernel_ethtool_coalesce *kernel_coal,
@@ -554,32 +576,55 @@ static int mlx5e_get_coalesce(struct net_device *ne=
tdev,
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
=20
 static void
-mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct etht=
ool_coalesce *coal)
+mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv,
+				    int queue,
+				    struct ethtool_coalesce *coal)
 {
 	struct mlx5_core_dev *mdev =3D priv->mdev;
 	int tc;
 	int i;
=20
-	for (i =3D 0; i < priv->channels.num; ++i) {
-		struct mlx5e_channel *c =3D priv->channels.c[i];
+	if (queue =3D=3D -1) {
+		for (i =3D 0; i < priv->channels.num; ++i) {
+			struct mlx5e_channel *c =3D priv->channels.c[i];
+
+			for (tc =3D 0; tc < c->num_tc; tc++) {
+				mlx5_core_modify_cq_moderation(mdev,
+							       &c->sq[tc].cq.mcq,
+							       coal->tx_coalesce_usecs,
+							       coal->tx_max_coalesced_frames);
+			}
+		}
+	} else {
+		struct mlx5e_channel *c =3D priv->channels.c[queue];
=20
 		for (tc =3D 0; tc < c->num_tc; tc++) {
 			mlx5_core_modify_cq_moderation(mdev,
-						&c->sq[tc].cq.mcq,
-						coal->tx_coalesce_usecs,
-						coal->tx_max_coalesced_frames);
+						       &c->sq[tc].cq.mcq,
+						       coal->tx_coalesce_usecs,
+						       coal->tx_max_coalesced_frames);
 		}
 	}
 }
=20
 static void
-mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct etht=
ool_coalesce *coal)
+mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv,
+				    int queue,
+				    struct ethtool_coalesce *coal)
 {
 	struct mlx5_core_dev *mdev =3D priv->mdev;
 	int i;
=20
-	for (i =3D 0; i < priv->channels.num; ++i) {
-		struct mlx5e_channel *c =3D priv->channels.c[i];
+	if (queue =3D=3D -1) {
+		for (i =3D 0; i < priv->channels.num; ++i) {
+			struct mlx5e_channel *c =3D priv->channels.c[i];
+
+			mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
+						       coal->rx_coalesce_usecs,
+						       coal->rx_max_coalesced_frames);
+		}
+	} else {
+		struct mlx5e_channel *c =3D priv->channels.c[queue];
=20
 		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
 					       coal->rx_coalesce_usecs,
@@ -596,15 +641,17 @@ static int cqe_mode_to_period_mode(bool val)
 	return val ? MLX5_CQ_PERIOD_MODE_START_FROM_CQE : MLX5_CQ_PERIOD_MODE_S=
TART_FROM_EQE;
 }
=20
-int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
+static int mlx5e_ethtool_set_per_queue_coalesce(struct mlx5e_priv *priv,
+						int queue,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
 			       struct netlink_ext_ack *extack)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev =3D priv->mdev;
-	struct mlx5e_params new_params;
-	bool reset_rx, reset_tx;
+	bool reset_rx =3D false, reset_tx =3D false;
+	struct mlx5e_params new_params =3D {0};
+	struct mlx5e_params *old_params;
 	bool reset =3D true;
 	u8 cq_period_mode;
 	int err =3D 0;
@@ -626,14 +673,29 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 		return -ERANGE;
 	}
=20
-	if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
-	    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
-		NL_SET_ERR_MSG_MOD(extack, "cqe_mode_rx/tx is not supported on this de=
vice");
-		return -EOPNOTSUPP;
+	if (kernel_coal) {
+		if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
+		    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "cqe_mode_rx/tx is not supported on this device");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (queue !=3D -1 && queue >=3D priv->channels.num) {
+		netdev_err(priv->netdev, "%s: Invalid queue ID [%d]",
+			   __func__, queue);
+		return -EINVAL;
 	}
=20
 	mutex_lock(&priv->state_lock);
-	new_params =3D priv->channels.params;
+
+	if (queue =3D=3D -1)
+		old_params =3D &priv->channels.params;
+	else
+		old_params =3D &priv->channels.c[queue]->params;
+
+	new_params =3D *old_params;
=20
 	rx_moder          =3D &new_params.rx_cq_moderation;
 	rx_moder->usec    =3D coal->rx_coalesce_usecs;
@@ -645,19 +707,21 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 	tx_moder->pkts    =3D coal->tx_max_coalesced_frames;
 	new_params.tx_dim_enabled =3D !!coal->use_adaptive_tx_coalesce;
=20
-	reset_rx =3D !!coal->use_adaptive_rx_coalesce !=3D priv->channels.param=
s.rx_dim_enabled;
-	reset_tx =3D !!coal->use_adaptive_tx_coalesce !=3D priv->channels.param=
s.tx_dim_enabled;
+	reset_rx =3D !!coal->use_adaptive_rx_coalesce !=3D old_params->rx_dim_e=
nabled;
+	reset_tx =3D !!coal->use_adaptive_tx_coalesce !=3D old_params->tx_dim_e=
nabled;
=20
-	cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_rx=
);
-	if (cq_period_mode !=3D rx_moder->cq_period_mode) {
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-		reset_rx =3D true;
-	}
+	if (kernel_coal) {
+		cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_r=
x);
+		if (cq_period_mode !=3D rx_moder->cq_period_mode) {
+			mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
+			reset_rx =3D true;
+		}
=20
-	cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_tx=
);
-	if (cq_period_mode !=3D tx_moder->cq_period_mode) {
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
-		reset_tx =3D true;
+		cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_t=
x);
+		if (cq_period_mode !=3D tx_moder->cq_period_mode) {
+			mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
+			reset_tx =3D true;
+		}
 	}
=20
 	if (reset_rx) {
@@ -678,18 +742,26 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 	 */
 	if (!reset_rx && !reset_tx && test_bit(MLX5E_STATE_OPENED, &priv->state=
)) {
 		if (!coal->use_adaptive_rx_coalesce)
-			mlx5e_set_priv_channels_rx_coalesce(priv, coal);
+			mlx5e_set_priv_channels_rx_coalesce(priv, queue, coal);
 		if (!coal->use_adaptive_tx_coalesce)
-			mlx5e_set_priv_channels_tx_coalesce(priv, coal);
+			mlx5e_set_priv_channels_tx_coalesce(priv, queue, coal);
 		reset =3D false;
 	}
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset, =
-1);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset, =
queue);
=20
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
=20
+int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	return mlx5e_ethtool_set_per_queue_coalesce(priv, -1, coal, kernel_coal=
, extack);
+}
+
 static int mlx5e_set_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *coal,
 			      struct kernel_ethtool_coalesce *kernel_coal,
--=20
2.35.1


