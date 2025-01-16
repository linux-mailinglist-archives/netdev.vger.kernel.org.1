Return-Path: <netdev+bounces-159071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BDA1444A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0025716BB3D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664A243864;
	Thu, 16 Jan 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKdJPnhD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82038243861
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064560; cv=none; b=cgb1b4OHlS53vYGsG8je3EtnvOS99/y2SQnc0igyB5nbQjHrML52on46swmOCu0+AXahagAJcVlvr7Mwmo75eFN8hdxRrR2bRXb2f8Huw8nTcZB+zcF+J66VSx6Tu+vXRSvzBkaCQwI++6CGAu9eVZqpl/6+yJT/CFokumW1AqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064560; c=relaxed/simple;
	bh=5EbEcp2FZ+JVu3cf+ci5oG4EMKcdkO5xHtXX6DAx/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJqPxjKID+GEoC7JDUl+eV2HA37edW465IatyDlvRpnEizwUb/BpJ8X+JPBasflTOwJ/LJae5i7CVqIjOkSHEX/85GKC3fuRshmYkFWqDecV6F1PeVly6CHaaektAz5Z2PnxcohKARr4Znw2DmtW3yWnavVBErWjmw42YubhjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKdJPnhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE533C4CED6;
	Thu, 16 Jan 2025 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064560;
	bh=5EbEcp2FZ+JVu3cf+ci5oG4EMKcdkO5xHtXX6DAx/FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKdJPnhDOv09YYb02lgXjFrS0OatUMnAd3wPXldarHiLC6SHiQvl6oXmT1KMtAmmU
	 wJP64r4RjuqAHCCCJHzvo6DZuMGmddSJnjJi7xAKEx+RtzKvbImDAGXGayxr5E7ex8
	 RnnwsAIvfw0x8HqNeiSZzwX6Bga1ZZEdCdn2d9e4tFR0hAv1hY2cf5GmQHsX+FGUol
	 6olPD14RzRmIFJcOvemfz0+cngsWjGkX95fCBMPxVtmi51B5MMGylU0GlFZOAhcq4N
	 Elnf3YlBxbgMix9fkXRRwPcN56C1H+7GCcfgK+itiqfhBDIBeKfzoLaAP0dW7J1V/A
	 8Y17NeSoZPMbw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Thu, 16 Jan 2025 13:55:28 -0800
Message-ID: <20250116215530.158886-11-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
and create the new channel resources, similar to
mlx5e_safe_switch_params, but here we do it for a single channel using
existing params, sort of a clone channel.
To swap the old channel with the new one, we deactivate and close the
old channel then replace it with the new one, since the swap procedure
doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 340ed7d3feac..1e03f2afe625 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5489,6 +5489,101 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
 	.get_base_stats      = mlx5e_get_base_stats,
 };
 
+struct mlx5_qmgmt_data {
+	struct mlx5e_channel *c;
+	struct mlx5e_channel_param cparam;
+};
+
+static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq, int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channels *chs = &priv->channels;
+	struct mlx5e_params params = chs->params;
+	struct mlx5_core_dev *mdev;
+	int err;
+
+	ASSERT_RTNL();
+	mutex_lock(&priv->state_lock);
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (queue_index >= chs->num) {
+		err = -ERANGE;
+		goto unlock;
+	}
+
+	if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
+	    chs->params.ptp_rx   ||
+	    chs->params.xdp_prog ||
+	    priv->htb) {
+		netdev_err(priv->netdev,
+			   "Cloning channels with Port/rx PTP, XDP or HTB is not supported\n");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
+	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
+	if (err) {
+		return err;
+		goto unlock;
+	}
+
+	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
+unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
+{
+	struct mlx5_qmgmt_data *data = (struct mlx5_qmgmt_data *)mem;
+
+	/* not supposed to happen since mlx5e_queue_start never fails
+	 * but this is how this should be implemented just in case
+	 */
+	if (data->c)
+		mlx5e_close_channel(data->c);
+}
+
+static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
+{
+	/* mlx5e_queue_start does not fail, we stop the old queue there */
+	return 0;
+}
+
+static int mlx5e_queue_start(struct net_device *dev, void *newq, int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channel *old;
+
+	mutex_lock(&priv->state_lock);
+
+	/* stop and close the old */
+	old = priv->channels.c[queue_index];
+	mlx5e_deactivate_priv_channels(priv);
+	/* close old before activating new, to avoid napi conflict */
+	mlx5e_close_channel(old);
+
+	/* start the new */
+	priv->channels.c[queue_index] = new->c;
+	mlx5e_activate_priv_channels(priv);
+	mutex_unlock(&priv->state_lock);
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
+	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
+	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
+	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
+	.ndo_queue_start	=	mlx5e_queue_start,
+	.ndo_queue_stop		=	mlx5e_queue_stop,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5499,6 +5594,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 
-- 
2.48.0


