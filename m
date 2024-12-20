Return-Path: <netdev+bounces-153559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725939F8A49
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF1E163739
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3D139D19;
	Fri, 20 Dec 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY/YrUUn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65F126F0A
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663171; cv=none; b=H0RPN1KIN/O4Y7fVk8VKVxZ7ZoxLiqKf3hadnHTFJlJPua9w4khJnznEFosSPvWGVF+Bvc72udHTnHd6jUNDu5yFAvpk/eLH2uxquX9Xhhpbkae9kFq+BVdFNQXHELl8IRy4fqOYRWEVeg6//ULnkxf+q6ZHgBOP1goMKG/K7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663171; c=relaxed/simple;
	bh=YldcOYcFb4EN/eJo8AWch6xWExV+89F8/A7kv8RF8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9xd2oaf9F2aQaG7ebxyOfjnhcP/B/q2MH3PTkGF6/0dhS+AgZb2L3V3JaggiSdh2Ir3zU8KD2RQhJ9Zn/NOEQ6TFtRrDhdvfjjI/0M8qV/++82xj01nUNGKWogtvjI0gKpdXC4O+1ceJ0Srx5oYa8/lahJpPBAyTINlUQhy2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY/YrUUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5158EC4CEE1;
	Fri, 20 Dec 2024 02:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663171;
	bh=YldcOYcFb4EN/eJo8AWch6xWExV+89F8/A7kv8RF8gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BY/YrUUnGYUhbrQiGgjg04+eDCfdfZU2aIq/oZi5lpAjqtXVIHGYyNo59hOODeHKY
	 YyZauiCxCW2vzTqQrRjX89bUOm3iVhA+Qsp8mVQ8BaVOoMXQAwggbMRVJ/ayqm9+6Z
	 ad2jrYDuggBZOy7auk39GBkfter7VXZjAAGfaIjMAtTOuxBeTdY58bbva7IfFyxC9a
	 o0IqR0HllKd3DwgzuOs/YeYMWnSGP3dXl8RIBiDjBtg1Eo6tsct7+Nb5S4OZq88WAl
	 bfnRwcs9K0GO0Fmk+T8D/x8HcameV0w+Rsi71d8BeSHT1jGtEFs7WN8YVAUdVU8nPR
	 6YokeGObasdiA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/10] eth: fbnic: support ring channel get and set while down
Date: Thu, 19 Dec 2024 18:52:40 -0800
Message-ID: <20241220025241.1522781-10-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial implementation of ethtool channel get and set. Set is only
supported when device is closed, next patch will add code for
live reconfig.

Asymmetric configurations are supported (combined + extra Tx or Rx),
so are configurations with independent IRQs for Rx and Tx.
Having all 3 NAPI types (combined, Tx, Rx) is not supported.

We used to only call fbnic_reset_indir_tbl() during init.
Now that we call it after device had been register must
be careful not to override user config.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 64 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  3 +
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index d1be8fc30404..d2fe97ae6a71 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -304,6 +304,68 @@ fbnic_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	return 0;
 }
 
+static void fbnic_get_channels(struct net_device *netdev,
+			       struct ethtool_channels *ch)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	ch->max_rx = fbd->max_num_queues;
+	ch->max_tx = fbd->max_num_queues;
+	ch->max_combined = min(ch->max_rx, ch->max_tx);
+	ch->max_other =	FBNIC_NON_NAPI_VECTORS;
+
+	if (fbn->num_rx_queues > fbn->num_napi ||
+	    fbn->num_tx_queues > fbn->num_napi)
+		ch->combined_count = min(fbn->num_rx_queues,
+					 fbn->num_tx_queues);
+	else
+		ch->combined_count =
+			fbn->num_rx_queues + fbn->num_tx_queues - fbn->num_napi;
+	ch->rx_count = fbn->num_rx_queues - ch->combined_count;
+	ch->tx_count = fbn->num_tx_queues - ch->combined_count;
+	ch->other_count = FBNIC_NON_NAPI_VECTORS;
+}
+
+static void fbnic_set_queues(struct fbnic_net *fbn, struct ethtool_channels *ch,
+			     unsigned int max_napis)
+{
+	fbn->num_rx_queues = ch->rx_count + ch->combined_count;
+	fbn->num_tx_queues = ch->tx_count + ch->combined_count;
+	fbn->num_napi = min(ch->rx_count + ch->tx_count + ch->combined_count,
+			    max_napis);
+}
+
+static int fbnic_set_channels(struct net_device *netdev,
+			      struct ethtool_channels *ch)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	unsigned int max_napis, standalone;
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
+	standalone = ch->rx_count + ch->tx_count;
+
+	/* Limits for standalone queues:
+	 *  - each queue has it's own NAPI (num_napi >= rx + tx + combined)
+	 *  - combining queues (combined not 0, rx or tx must be 0)
+	 */
+	if ((ch->rx_count && ch->tx_count && ch->combined_count) ||
+	    (standalone && standalone + ch->combined_count > max_napis) ||
+	    ch->rx_count + ch->combined_count > fbd->max_num_queues ||
+	    ch->tx_count + ch->combined_count > fbd->max_num_queues ||
+	    ch->other_count != FBNIC_NON_NAPI_VECTORS)
+		return -EINVAL;
+
+	if (!netif_running(netdev)) {
+		fbnic_set_queues(fbn, ch, max_napis);
+		fbnic_reset_indir_tbl(fbn);
+		return 0;
+	}
+
+	return -EBUSY;
+}
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -417,6 +479,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
 	.get_rxfh		= fbnic_get_rxfh,
 	.set_rxfh		= fbnic_set_rxfh,
+	.get_channels		= fbnic_get_channels,
+	.set_channels		= fbnic_set_channels,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index b99c890ac43f..c25bd300b902 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -13,6 +13,9 @@ void fbnic_reset_indir_tbl(struct fbnic_net *fbn)
 	unsigned int num_rx = fbn->num_rx_queues;
 	unsigned int i;
 
+	if (netif_is_rxfh_configured(fbn->netdev))
+		return;
+
 	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
 		fbn->indir_tbl[0][i] = ethtool_rxfh_indir_default(i, num_rx);
 }
-- 
2.47.1


