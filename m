Return-Path: <netdev+bounces-73131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65885B16F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAD8281009
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293E254278;
	Tue, 20 Feb 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr9Ft90n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376E53819
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399792; cv=none; b=U06DPfbkG9Lvf1MuBqXQz5qZUSqpWiaEG/Iw2fg7oIGYiBrOGH/KeEF8u7gJt2sJxu3xnNpGRtFlN6J9LFwg9tiB27sYa8yKaQomo30AEn7i/WvX/PLwoLnqLIeoy+WC65wMFCSZpUmOBvx5T3gka1Vtoer5QUwR+9Il3jDrsd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399792; c=relaxed/simple;
	bh=yhLy9sbURi1lyacWjFmHZjGF3VNx2Htxnj2UHBzwBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnB9JdyMWX8pY40XtHQU3fjggWerHtDKecpUOX59YIZNNoGq6DcfxpehL+Bhxn3LIOFQp7uyLG5+VQNhCuBWpfrI0yvVYmASYy7gB+Iqfy300tEND2MCZLUJHQMctq2LjG3S5ooC5YtYFL+jhUfBp7lApILXlIgpc4gEH1bWAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr9Ft90n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B305EC433C7;
	Tue, 20 Feb 2024 03:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708399791;
	bh=yhLy9sbURi1lyacWjFmHZjGF3VNx2Htxnj2UHBzwBVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jr9Ft90nrq28mChv9K+8bjZTc74ny0+b5zI90wrGTOnqYSGk0jQEm9DWyHZVPM3lk
	 /ei25J6hrLQTKxz+zlEqke3IbmJ/c+Iq+tSI6JrHo2la3qG0X1JicEvgNuIuvasPF1
	 LHjx947lpkel3ykYK9z9DT6gF4c8BgcWvZxCSZrWX+Hf/KEJSNCkVvPhW7WgRzi/jx
	 T86PtbkYE6FaZVszSGkP9rCu6DoY5Vsas5fZ1eljR+uXohzWWo3N8sJfw5m5k/+Snu
	 /Ak6+1oeckYVjKkVxjx2f+uM0Ll7mw7ePZQYmd69zIZdpjIOiSX0v0k2JT/ZELHkhS
	 DkVBPcFWTkj8w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 08/10] net/mlx5e: RSS, Unconfigure RXFH after changing channels number
Date: Mon, 19 Feb 2024 19:29:46 -0800
Message-ID: <20240220032948.35305-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Changing the channels number after configuring the receive
flow hash indirection table may alter the RSS table size.
The previous configuration may no longer be compatible with
the current receive flow hash indirection table.

Whenever the channels number is modified,
unconfigure the receive flow hash indirection table
and revert it to a uniform table.

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..ae459570c9ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -435,6 +435,7 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	struct mlx5e_params *cur_params = &priv->channels.params;
 	unsigned int count = ch->combined_count;
 	struct mlx5e_params new_params;
+	bool rxfh_configured;
 	bool arfs_enabled;
 	int rss_cnt;
 	bool opened;
@@ -492,10 +493,25 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 	if (arfs_enabled)
 		mlx5e_arfs_disable(priv->fs);
 
+	/* Changing the channels number can affect the size of the RXFH indir table.
+	 * Therefore, if the RXFH was previously configured,
+	 * unconfigure it to ensure that the RXFH is reverted to a uniform table.
+	 */
+	rxfh_configured = netif_is_rxfh_configured(priv->netdev);
+	if (rxfh_configured)
+		priv->netdev->priv_flags &= ~IFF_RXFH_CONFIGURED;
+
 	/* Switch to new channels, set new parameters and close old ones */
 	err = mlx5e_safe_switch_params(priv, &new_params,
 				       mlx5e_num_channels_changed_ctx, NULL, true);
-
+	if (rxfh_configured) {
+		/* Revert the RXFH configured */
+		if (err)
+			priv->netdev->priv_flags |= IFF_RXFH_CONFIGURED;
+		else
+			netdev_warn(priv->netdev, "%s: RXFH table entries reverting to default\n",
+				    __func__);
+	}
 	if (arfs_enabled) {
 		int err2 = mlx5e_arfs_enable(priv->fs);
 
-- 
2.43.2


