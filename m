Return-Path: <netdev+bounces-202550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46606AEE41F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D8A3A531A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D928ECDA;
	Mon, 30 Jun 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/lC01nH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D404292B2F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299803; cv=none; b=EhdiEl1+uI4u42jRkl+ed2WhLWWGBcAXQznfPxYD5HkedOpZML6ng8PxIqPY9o5dUAXeKuzBfXfy2ysGs2fO7ZYN2FuUK9TWS+4hIatZwXcSlAmV+W0/ii84fN+6wCf3Zonj7uw0GMVObl72Lv8XLs2wBm127ElxG/87kmgSOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299803; c=relaxed/simple;
	bh=05Nm7NHxjsU6ZlJm8PjItJhWe7hkvN/OEfeZpOSWfbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ueif8jTGEpDLXZ7x+hHhbEXSGBg0JGk9keHvnc8+Bjah8uyp5JQIR153/L1YEQRkNQPb+KFZDMPLxXxdUFzEUudVzFVbWBBvH71l3TQbMKaTsO7U60lTO2ZsLmM2nMU/YcX2njqNksM8hfV2zXFYRdNSxaeXNKMUko64g+akfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/lC01nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517DAC4CEF3;
	Mon, 30 Jun 2025 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299802;
	bh=05Nm7NHxjsU6ZlJm8PjItJhWe7hkvN/OEfeZpOSWfbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/lC01nH5t/aTqXZcv1X/Cw6G/yyHtYZTpeRvL73eVOydx7QLzPvR9E7MBgeIBUW7
	 581757xPfs0Zsn8zhubrzlzQ88aC1rSO9R/9yLQPiDhHS9owpfw1gIHZU+mVVOW8DD
	 7zNiTVzYHQRNk269p5vvwYyPgppcSz1ne06usFK6GKZLSherEOofdJsXJv8PmSD6MC
	 twrEz2BWeGKGxe2Gydtn9DyDYWJZ4e3h/BaBodgbv0tvXV+XfwMzGuc5ntMkaOeAvl
	 KpqGtiuza1QtfYtWoUGctr1yhPCwrXiVj1O1ONLy0AAFI42xvpwUmNcNmHgfBUTTx7
	 GZSHsC0gcV+bQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: ice: drop the dead code related to rss_contexts
Date: Mon, 30 Jun 2025 09:09:50 -0700
Message-ID: <20250630160953.1093267-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630160953.1093267-1-kuba@kernel.org>
References: <20250630160953.1093267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ICE appears to have some odd form of rss_context use plumbed
in for .get_rxfh. The .set_rxfh side does not support creating
contexts, however, so this must be dead code. For at least a year
now (since commit 7964e7884643 ("net: ethtool: use the tracking
array for get_rxfh on custom RSS contexts")) we have not been
calling .get_rxfh with a non-zero rss_context. We just get
the info from the RSS XArray under dev->ethtool.

Remove what must be dead code in the driver, clear the support flags.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 28 +++-----------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ea7e8b879b48..e54221fba849 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3591,11 +3591,10 @@ static int
 ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	u32 rss_context = rxfh->rss_context;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	u16 qcount, offset;
-	int err, num_tc, i;
+	int err, i;
 	u8 *lut;
 
 	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
@@ -3603,24 +3602,8 @@ ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 		return -EOPNOTSUPP;
 	}
 
-	if (rss_context && !ice_is_adq_active(pf)) {
-		netdev_err(netdev, "RSS context cannot be non-zero when ADQ is not configured.\n");
-		return -EINVAL;
-	}
-
-	qcount = vsi->mqprio_qopt.qopt.count[rss_context];
-	offset = vsi->mqprio_qopt.qopt.offset[rss_context];
-
-	if (rss_context && ice_is_adq_active(pf)) {
-		num_tc = vsi->mqprio_qopt.qopt.num_tc;
-		if (rss_context >= num_tc) {
-			netdev_err(netdev, "RSS context:%d  > num_tc:%d\n",
-				   rss_context, num_tc);
-			return -EINVAL;
-		}
-		/* Use channel VSI of given TC */
-		vsi = vsi->tc_map_vsi[rss_context];
-	}
+	qcount = vsi->mqprio_qopt.qopt.count[0];
+	offset = vsi->mqprio_qopt.qopt.offset[0];
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 	if (vsi->rss_hfunc == ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ)
@@ -3680,9 +3663,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
-	if (rxfh->rss_context)
-		return -EOPNOTSUPP;
-
 	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
 		/* RSS not supported return error here */
 		netdev_warn(netdev, "RSS is not configured on this VSI!\n");
@@ -4750,12 +4730,10 @@ static int ice_repr_ethtool_reset(struct net_device *dev, u32 *flags)
 }
 
 static const struct ethtool_ops ice_ethtool_ops = {
-	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH,
 	.supported_input_xfrm	= RXH_XFRM_SYM_XOR,
-	.rxfh_per_ctx_key	= true,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
 	.get_fec_stats		= ice_get_fec_stats,
-- 
2.50.0


