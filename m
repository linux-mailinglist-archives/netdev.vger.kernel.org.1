Return-Path: <netdev+bounces-34835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607B7A55E4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4585B281980
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD43328A9;
	Mon, 18 Sep 2023 22:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614771C68B
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:45:17 +0000 (UTC)
X-Greylist: delayed 913 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 15:45:14 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851291
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1695077115; x=1697669115;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=AoNgiqW2GYdLCwa5yhKQBqJzGNFkZjdvxpssRuQqoC4=;
	b=ciQcIVVWcAXgE9Z5f9CPq5iKaLu5vwRJieWtOT9BSPubHSDdGAX3DTeD/yL78v0gLE47J0RC+Lr4iGtmf5s+998hLTQxK1TwYtRMTw2VBC3+iyaRlE5pNPYpS2EQip8aHF+B/LeQiahu7WarTTBF9489YUgiqm4zjR3VFhs/kTs=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDc1Y2E1NTEubmV0ZGV2PXZnZXIua2VybmVsLm9yZw==
Received: from r2.h.in.socketlabs.com (r2.h.in.socketlabs.com [142.0.180.12]) by mxrs4.email-od.com
	with ESMTP(version=Tls12 cipher=Aes256 bits=256); Mon, 18 Sep 2023 18:30:00 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r2.h.in.socketlabs.com
	with ESMTP; Mon, 18 Sep 2023 18:29:59 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
	by nalramli.com (Postfix) with ESMTPS id AF9EF2CE016B;
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
Subject: [net-next RFC v2 2/4] mlx5: Add queue number parameter to mlx5e_safe_switch_params()
Date: Mon, 18 Sep 2023 18:29:53 -0400
Message-Id: <20230918222955.2066-3-dev@nalramli.com>
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

Currently mlx5e_safe_switch_params() does not take a queue number and
assumes a global operation. This allows the function to handle individual
channels. Note that Global operations reset the individual channel
settings.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 18 ++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 42 +++++++++++++------
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  2 +-
 5 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
index 3657839b88f8..ba8eb2b30251 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1063,7 +1063,8 @@ int mlx5e_safe_reopen_channels(struct mlx5e_priv *p=
riv);
 int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 			     struct mlx5e_params *new_params,
 			     mlx5e_fp_preactivate preactivate,
-			     void *context, bool reset);
+			     void *context, bool reset,
+			     int queue);
 int mlx5e_update_tx_netdev_queues(struct mlx5e_priv *priv);
 int mlx5e_num_channels_changed_ctx(struct mlx5e_priv *priv, void *contex=
t);
 void mlx5e_activate_priv_channels(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers=
/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 8705cffc747f..8c0704beb25c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -1159,7 +1159,7 @@ static int mlx5e_set_trust_state(struct mlx5e_priv =
*priv, u8 trust_state)
=20
 	err =3D mlx5e_safe_switch_params(priv, &new_params,
 				       mlx5e_update_trust_state_hw,
-				       &trust_state, reset);
+				       &trust_state, reset, -1);
=20
 	mutex_unlock(&priv->state_lock);
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index dff02434ff45..13e5838ff1ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -389,7 +389,7 @@ int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *pr=
iv,
 	if (err)
 		goto unlock;
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, -=
1);
=20
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -489,7 +489,7 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *pri=
v,
=20
 	/* Switch to new channels, set new parameters and close old ones */
 	err =3D mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_num_channels_changed_ctx, NULL, true);
+				       mlx5e_num_channels_changed_ctx, NULL, true, -1);
=20
 	if (arfs_enabled) {
 		int err2 =3D mlx5e_arfs_enable(priv->fs);
@@ -684,7 +684,7 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *pri=
v,
 		reset =3D false;
 	}
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset, =
-1);
=20
 	mutex_unlock(&priv->state_lock);
 	return err;
@@ -1893,7 +1893,7 @@ static int set_pflag_cqe_based_moder(struct net_dev=
ice *netdev, bool enable,
 	else
 		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
=20
-	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, -1=
);
 }
=20
 static int set_pflag_tx_cqe_based_moder(struct net_device *netdev, bool =
enable)
@@ -1935,10 +1935,10 @@ int mlx5e_modify_rx_cqe_compression_locked(struct=
 mlx5e_priv *priv, bool new_val
 		new_params.ptp_rx =3D new_val;
=20
 	if (new_params.ptp_rx =3D=3D priv->channels.params.ptp_rx)
-		err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+		err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, =
-1);
 	else
 		err =3D mlx5e_safe_switch_params(priv, &new_params, mlx5e_ptp_rx_manag=
e_fs_ctx,
-					       &new_params.ptp_rx, true);
+					       &new_params.ptp_rx, true, -1);
 	if (err)
 		return err;
=20
@@ -1996,7 +1996,7 @@ static int set_pflag_rx_striding_rq(struct net_devi=
ce *netdev, bool enable)
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_STRIDING_RQ, enable);
 	mlx5e_set_rq_type(mdev, &new_params);
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, -=
1);
 	if (err)
 		return err;
=20
@@ -2041,7 +2041,7 @@ static int set_pflag_tx_mpwqe_common(struct net_dev=
ice *netdev, u32 flag, bool e
=20
 	MLX5E_SET_PFLAG(&new_params, flag, enable);
=20
-	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, -1=
);
 }
=20
 static int set_pflag_xdp_tx_mpwqe(struct net_device *netdev, bool enable=
)
@@ -2094,7 +2094,7 @@ static int set_pflag_tx_port_ts(struct net_device *=
netdev, bool enable)
 	 */
=20
 	err =3D mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_num_channels_changed_ctx, NULL, true);
+				       mlx5e_num_channels_changed_ctx, NULL, true, -1);
 	if (!err)
 		priv->tx_ptp_opened =3D true;
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
index a1578219187b..d7325fc4f2c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3055,19 +3055,35 @@ static int mlx5e_switch_priv_channels(struct mlx5=
e_priv *priv,
 int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 			     struct mlx5e_params *params,
 			     mlx5e_fp_preactivate preactivate,
-			     void *context, bool reset)
+			     void *context, bool reset,
+			     int queue)
 {
 	struct mlx5e_channels *new_chs;
 	int err;
+	int i;
+
+	if (queue =3D=3D -1) {
+		for (i =3D 0; i < priv->channels.num; i++)
+			priv->channels.c[i]->params =3D *params;
+	} else {
+		priv->channels.c[queue]->params =3D *params;
+	}
=20
 	reset &=3D test_bit(MLX5E_STATE_OPENED, &priv->state);
-	if (!reset)
-		return mlx5e_switch_priv_params(priv, params, preactivate, context);
+	if (!reset) {
+		if (queue =3D=3D -1)
+			return mlx5e_switch_priv_params(priv, params, preactivate, context);
+		else
+			return 0;
+	}
=20
 	new_chs =3D kzalloc(sizeof(*new_chs), GFP_KERNEL);
 	if (!new_chs)
 		return -ENOMEM;
-	new_chs->params =3D *params;
+	if (queue =3D=3D -1)
+		new_chs->params =3D *params;
+	else
+		new_chs->params =3D priv->channels.params;
=20
 	mlx5e_selq_prepare_params(&priv->selq, &new_chs->params);
=20
@@ -3093,7 +3109,7 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *pri=
v,
=20
 int mlx5e_safe_reopen_channels(struct mlx5e_priv *priv)
 {
-	return mlx5e_safe_switch_params(priv, &priv->channels.params, NULL, NUL=
L, true);
+	return mlx5e_safe_switch_params(priv, &priv->channels.params, NULL, NUL=
L, true, -1);
 }
=20
 void mlx5e_timestamp_init(struct mlx5e_priv *priv)
@@ -3486,7 +3502,7 @@ static int mlx5e_setup_tc_mqprio_dcb(struct mlx5e_p=
riv *priv,
 	mlx5e_params_mqprio_dcb_set(&new_params, tc ? tc : 1);
=20
 	err =3D mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_num_channels_changed_ctx, NULL, true);
+				       mlx5e_num_channels_changed_ctx, NULL, true, -1);
=20
 	if (!err && priv->mqprio_rl) {
 		mlx5e_mqprio_rl_cleanup(priv->mqprio_rl);
@@ -3607,7 +3623,7 @@ static int mlx5e_setup_tc_mqprio_channel(struct mlx=
5e_priv *priv,
 	nch_changed =3D mlx5e_get_dcb_num_tc(&priv->channels.params) > 1;
 	preactivate =3D nch_changed ? mlx5e_num_channels_changed_ctx :
 		mlx5e_update_netdev_queues_ctx;
-	err =3D mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, =
true);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, =
true, -1);
 	if (err) {
 		if (rl) {
 			mlx5e_mqprio_rl_cleanup(rl);
@@ -3849,7 +3865,7 @@ static int set_feature_lro(struct net_device *netde=
v, bool enable)
 	}
=20
 	err =3D mlx5e_safe_switch_params(priv, &new_params,
-				       mlx5e_modify_tirs_packet_merge_ctx, NULL, reset);
+				       mlx5e_modify_tirs_packet_merge_ctx, NULL, reset, -1);
 out:
 	mutex_unlock(&priv->state_lock);
 	return err;
@@ -3877,7 +3893,7 @@ static int set_feature_hw_gro(struct net_device *ne=
tdev, bool enable)
 		goto out;
 	}
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset, =
-1);
 out:
 	mutex_unlock(&priv->state_lock);
 	return err;
@@ -3975,7 +3991,7 @@ static int set_feature_rx_fcs(struct net_device *ne=
tdev, bool enable)
 	new_params =3D chs->params;
 	new_params.scatter_fcs_en =3D enable;
 	err =3D mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_port_t=
s_wrap,
-				       &new_params.scatter_fcs_en, true);
+				       &new_params.scatter_fcs_en, true, -1);
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
@@ -4349,7 +4365,7 @@ int mlx5e_change_mtu(struct net_device *netdev, int=
 new_mtu,
 			reset =3D false;
 	}
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, =
reset);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, =
reset, -1);
=20
 out:
 	netdev->mtu =3D params->sw_mtu;
@@ -4400,7 +4416,7 @@ static int mlx5e_hwstamp_config_ptp_rx(struct mlx5e=
_priv *priv, bool ptp_rx)
 	new_params =3D priv->channels.params;
 	new_params.ptp_rx =3D ptp_rx;
 	return mlx5e_safe_switch_params(priv, &new_params, mlx5e_ptp_rx_manage_=
fs_ctx,
-					&new_params.ptp_rx, true);
+					&new_params.ptp_rx, true, -1);
 }
=20
 int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
@@ -4831,7 +4847,7 @@ static int mlx5e_xdp_set(struct net_device *netdev,=
 struct bpf_prog *prog)
=20
 	old_prog =3D priv->channels.params.xdp_prog;
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset, =
-1);
 	if (err)
 		goto unlock;
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index baa7ef812313..877719c4454a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -522,7 +522,7 @@ static int mlx5i_change_mtu(struct net_device *netdev=
, int new_mtu)
 	new_params =3D priv->channels.params;
 	new_params.sw_mtu =3D new_mtu;
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true, -=
1);
 	if (err)
 		goto out;
=20
--=20
2.35.1


