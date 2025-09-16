Return-Path: <netdev+bounces-223694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C94CB5A136
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194AA7B12B8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EA2F5A05;
	Tue, 16 Sep 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Px+G4S9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0025F7BF;
	Tue, 16 Sep 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050217; cv=none; b=eAB/dZQ2hJyNxjztusEK4R+auFj7u5T3c6DlMyRfuVXGy8m/TgJLyvGgD9XyL6S9BdX1p1wJ2VB6cSpY1SKuTA6OoPTxmBCvIAX3wmP2nE1/2hWxz9VoIaPRDKy30dBYqu044eUmSzSrRFScm9TCgz7pay/tkYXxH2wrCiqiSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050217; c=relaxed/simple;
	bh=8w820h2+A5DcdmXVtb8LR7OpT3KgfIE9hmk6od5HnGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsEmls+7rVts6hI5Fi2w9r3z8798dOteziyWHTKgE+rTvWSvmO092yCWhI71TNTf8+h6tIKDsZ/fgeO5N5mkyM7BzPtwtfNsvqe8JWmVwzbWkoo9STY+O0P8+XpXNkVmlm3p5NgVw0MFeahAGDLEZLcF8PHASKBIxLOQB490C4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Px+G4S9Y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050216; x=1789586216;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8w820h2+A5DcdmXVtb8LR7OpT3KgfIE9hmk6od5HnGc=;
  b=Px+G4S9YgwMrhQ9hk/p1pJwJC9okQs8TVBcSXFfVkXf2s70W/ftIfO0f
   XyCAFgZH1ri1LS1meWv/Hv+v+qXx5I09XgqAD9paFsjN8jBcE6LzpnYW/
   YaTsOM7Jn7QZNSxpP63qYzt72kcV+21zYyfhkteyl3haW3aajFHJW9D0y
   Q++eingCHmS+5T0CsZWcIUX++ueRLoCe/z1uWeQn9CTuiVUOtln1M7HFy
   3S3e09BwASpRvRY+5AB7fHGmVMXtE+o8IQ6TrjpCrKEWES1PPd8pnBwua
   Xs+t6RupNQz247U4pmj5LM7CCBnLJWQoxe+tpOd+6/lQxoNruoVgqZXG5
   g==;
X-CSE-ConnectionGUID: cONQoPeQSxqzCynp54PCGQ==
X-CSE-MsgGUID: Y3nNSv+JQAGS7tTJ/KLwnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60037582"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60037582"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:54 -0700
X-CSE-ConnectionGUID: 65PyrnlIQOimABFpBFaTmw==
X-CSE-MsgGUID: tYCEvTpLRp6VyiBRMRTkcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174961760"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Sep 2025 12:14:55 -0700
Subject: [PATCH iwl-next v4 2/5] ice: implement ethtool standard stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-resend-jbrandeb-ice-standard-stats-v4-2-ec198614c738@intel.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=5795;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=KimcwhECfxAIrU3b94+wZ4uOQURhgyuL0OhTIMn7I34=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyT2xcn3plaMMF62vlZTK8jdpq2LzUV3mVUeXG18nchJ
 qfnhhlqHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExEMISR4UZ3iqfkAdZTW/bc
 27O57y3DmzWT4wy3HjvL8uLA/BO8y94wMqxO/35KSTbs/I0DT1OO+R+RehCyqvag5NV1z5bP3TN
 9/mFuAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Add support for MAC/pause/RMON stats. This enables reporting hardware
statistics in a common way via:

ethtool -S eth0 --all-groups
and
ethtool --include-statistics --show-pause eth0

While doing so, add support for one new stat, receive length error
(RLEC), which is extremely unlikely to happen since most L2 frames have
a type/length field specifying a "type", and raw ethernet frames aren't
used much any longer.

NOTE: I didn't implement Ctrl aka control frame stats because the
hardware doesn't seem to implement support.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 78 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 4213a2b9fa9d..1e82f4c40b32 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1069,6 +1069,7 @@ struct ice_hw_port_stats {
 	u64 error_bytes;		/* errbc */
 	u64 mac_local_faults;		/* mlfc */
 	u64 mac_remote_faults;		/* mrfc */
+	u64 rx_len_errors;		/* rlec */
 	u64 link_xon_rx;		/* lxonrxc */
 	u64 link_xoff_rx;		/* lxoffrxc */
 	u64 link_xon_tx;		/* lxontxc */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 95587dd96c71..3d99c4a1e287 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4655,6 +4655,81 @@ static void ice_get_fec_stats(struct net_device *netdev,
 			    pi->lport, err);
 }
 
+static void ice_get_eth_mac_stats(struct net_device *netdev,
+				  struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_hw_port_stats *ps = &pf->stats;
+
+	mac_stats->FramesTransmittedOK = ps->eth.tx_unicast +
+					 ps->eth.tx_multicast +
+					 ps->eth.tx_broadcast;
+	mac_stats->FramesReceivedOK = ps->eth.rx_unicast +
+				      ps->eth.rx_multicast +
+				      ps->eth.rx_broadcast;
+	mac_stats->FrameCheckSequenceErrors = ps->crc_errors;
+	mac_stats->OctetsTransmittedOK = ps->eth.tx_bytes;
+	mac_stats->OctetsReceivedOK = ps->eth.rx_bytes;
+	mac_stats->MulticastFramesXmittedOK = ps->eth.tx_multicast;
+	mac_stats->BroadcastFramesXmittedOK = ps->eth.tx_broadcast;
+	mac_stats->MulticastFramesReceivedOK = ps->eth.rx_multicast;
+	mac_stats->BroadcastFramesReceivedOK = ps->eth.rx_broadcast;
+	mac_stats->InRangeLengthErrors = ps->rx_len_errors;
+	mac_stats->FrameTooLongErrors = ps->rx_oversize;
+}
+
+static void ice_get_pause_stats(struct net_device *netdev,
+				struct ethtool_pause_stats *pause_stats)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_hw_port_stats *ps = &pf->stats;
+
+	pause_stats->tx_pause_frames = ps->link_xon_tx + ps->link_xoff_tx;
+	pause_stats->rx_pause_frames = ps->link_xon_rx + ps->link_xoff_rx;
+}
+
+static const struct ethtool_rmon_hist_range ice_rmon_ranges[] = {
+	{    0,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1522 },
+	{ 1523,  9522 },
+	{}
+};
+
+static void ice_get_rmon_stats(struct net_device *netdev,
+			       struct ethtool_rmon_stats *rmon,
+			       const struct ethtool_rmon_hist_range **ranges)
+{
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_hw_port_stats *ps = &pf->stats;
+
+	rmon->undersize_pkts	= ps->rx_undersize;
+	rmon->oversize_pkts	= ps->rx_oversize;
+	rmon->fragments		= ps->rx_fragments;
+	rmon->jabbers		= ps->rx_jabber;
+
+	rmon->hist[0]		= ps->rx_size_64;
+	rmon->hist[1]		= ps->rx_size_127;
+	rmon->hist[2]		= ps->rx_size_255;
+	rmon->hist[3]		= ps->rx_size_511;
+	rmon->hist[4]		= ps->rx_size_1023;
+	rmon->hist[5]		= ps->rx_size_1522;
+	rmon->hist[6]		= ps->rx_size_big;
+
+	rmon->hist_tx[0]	= ps->tx_size_64;
+	rmon->hist_tx[1]	= ps->tx_size_127;
+	rmon->hist_tx[2]	= ps->tx_size_255;
+	rmon->hist_tx[3]	= ps->tx_size_511;
+	rmon->hist_tx[4]	= ps->tx_size_1023;
+	rmon->hist_tx[5]	= ps->tx_size_1522;
+	rmon->hist_tx[6]	= ps->tx_size_big;
+
+	*ranges = ice_rmon_ranges;
+}
+
 #define ICE_ETHTOOL_PFR (ETH_RESET_IRQ | ETH_RESET_DMA | \
 	ETH_RESET_FILTER | ETH_RESET_OFFLOAD)
 
@@ -4738,6 +4813,9 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
 	.get_fec_stats		= ice_get_fec_stats,
+	.get_eth_mac_stats	= ice_get_eth_mac_stats,
+	.get_pause_stats	= ice_get_pause_stats,
+	.get_rmon_stats		= ice_get_rmon_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 90d544a6a00e..249fd3c050eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7113,6 +7113,9 @@ void ice_update_pf_stats(struct ice_pf *pf)
 			  &prev_ps->mac_remote_faults,
 			  &cur_ps->mac_remote_faults);
 
+	ice_stat_update32(hw, GLPRT_RLEC(port), pf->stat_prev_loaded,
+			  &prev_ps->rx_len_errors, &cur_ps->rx_len_errors);
+
 	ice_stat_update32(hw, GLPRT_RUC(port), pf->stat_prev_loaded,
 			  &prev_ps->rx_undersize, &cur_ps->rx_undersize);
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


