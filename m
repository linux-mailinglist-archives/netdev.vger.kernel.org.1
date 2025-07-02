Return-Path: <netdev+bounces-203130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B247AF08F7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102247B10CF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937481D54E9;
	Wed,  2 Jul 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Seu4xuNp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC01D514E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425611; cv=none; b=IfnLESJZlR5h5rEoZXm7Qam+0PQqFB6KSkugNw6e4YxbpffHnG/8yr8/q5a4ViNQDiwT3xclgbfcLJrR5tHGHc4qecF02h7jopJZkqFgSXPGWB6dzJ5XC8VgXI8eNO+t36gWADdfCIkjn4+h3I2Us/GtGVDd+qiU1/MO9Qi28Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425611; c=relaxed/simple;
	bh=05Nm7NHxjsU6ZlJm8PjItJhWe7hkvN/OEfeZpOSWfbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEmmRoNTUE2Mfo4Cv3G5xWwd0pZ2VKf5wrDis/5dhiHjWYdlbMLOXihEkqoB6lcWXD0EAty5woa1kKuEDN+TOQ9M9mH7YHzpP04vXvrYviWdmqLH5jdGamQj34S5Y/Ulj+OE23bklbhTtdXgZBwm8pzelrabbC1eX786rNXpZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Seu4xuNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FEBC4CEF4;
	Wed,  2 Jul 2025 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425611;
	bh=05Nm7NHxjsU6ZlJm8PjItJhWe7hkvN/OEfeZpOSWfbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Seu4xuNp1501huH6GfUwFx147xIjHsDIpyGttolatNPkYuuX8pbs8XomDt99cqDfq
	 cIK5k70xjWB75RE12fxvug2hiyDtoRzJ0tzDIi4Il+N0sisettn0TFeBsX4S8B0tzf
	 6VgJXYttCy28EvxP4ewLNLc2dW0Q9GIQgZo2+P4rDXveAuU/fVLxn3F+NAOnaFP//c
	 5DDUAN0hDRCg934utP360A7KQJwvGcXCE/A/oiI0N2TXY5VN9xik4cTYXEUfQYAW2Q
	 EEgxpZKKRZLlMXwWtQyC+Rh9sqB0/atlhbilX3niwyrU0E1PBc+1DK/dzjp0AVssia
	 HBWvZ7IycfK0A==
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
Subject: [PATCH net-next v2 2/5] eth: ice: drop the dead code related to rss_contexts
Date: Tue,  1 Jul 2025 20:06:03 -0700
Message-ID: <20250702030606.1776293-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702030606.1776293-1-kuba@kernel.org>
References: <20250702030606.1776293-1-kuba@kernel.org>
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


