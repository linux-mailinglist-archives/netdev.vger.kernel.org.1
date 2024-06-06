Return-Path: <netdev+bounces-101576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716A8FF7C9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EA1C24CF4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2513E034;
	Thu,  6 Jun 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpVGfhyN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347A13D8BE;
	Thu,  6 Jun 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714036; cv=none; b=cQQHKusYCp/EzTkALP5fqfaEyPar8DINMQcJOn3U0YxHN76lV+lMbxzAiiiwy/926kLJsVg4N28eO5S8Z6pSMzt3+vJ8oWJmotF1MWyOECYYeYUKIdpJai3I+kpxd1uRvkQOj418ILPx5KCsz2Yur4T1CGXZ/JzM16I/+mwotrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714036; c=relaxed/simple;
	bh=svAUTzKkGC+kHc/rLGAMIv+fBkOndfX3PQZ5NKI7qpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOPBehQgMwoUnmlcKJ6txmxnC8zkBDLaDTb9WP9N0iawU8APDSC0Qh9fIrp0j8VSTSuDpWAmVECrmaQt5c1y92IE1QdKfEzGSD0y6j9HUaklZICXKB8ileVynmGnp/D2IE+SQT8d4NO8jqpH2mWEDBNnALqFMkXhBF1jV4XZ7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpVGfhyN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717714034; x=1749250034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svAUTzKkGC+kHc/rLGAMIv+fBkOndfX3PQZ5NKI7qpU=;
  b=XpVGfhyNDVL4nIsX9sorIFKeIjEWYXeTAOw48h+pckqeTFJA8WUG2cQJ
   cAkW7d2vTfNCnd3XSMVWXXhujlR5JkyXLVtQis58nq57uKT3MytNfffZq
   VNGm2bBPuVroPqFrqWOKa5MqgnwBbnCjyXBu5S3LLMk4LAS35L6anJDQ1
   ACGp7gVIXmWF0p+3Uy/JSUsbo2/Q8KYzZVGMCQ043FfIe5B5WUhMW8Oyg
   GtYVq8M/C/7K46rwjP+wdr3UW7WnAbsOEWsq0XGPnvb4INhhC1npC5gtc
   j45Uwn5tYS55a2gOk7IiAs9N2lyt3O/1Y1GFN5eabTk4kC+Le/0TedWSA
   g==;
X-CSE-ConnectionGUID: H0Xg2XgIToW3FM2emSF8MA==
X-CSE-MsgGUID: U7/RQ3gkR1ugQFGLanMpLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14224006"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14224006"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
X-CSE-ConnectionGUID: 6JcK29OMTbGGHw21LXkmhQ==
X-CSE-MsgGUID: l9QUanyGT4uGKSYYm2uiHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38243837"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:47:11 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iwl-next v2 2/5] ice: implement ethtool standard stats
Date: Thu,  6 Jun 2024 15:46:56 -0700
Message-ID: <20240606224701.359706-3-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606224701.359706-1-jesse.brandeburg@intel.com>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Example output:

Standard stats for ens785f1np1:
eth-mac-FramesTransmittedOK: 296
eth-mac-FramesReceivedOK: 339
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-OctetsTransmittedOK: 70410
eth-mac-OctetsReceivedOK: 51414
eth-mac-MulticastFramesXmittedOK: 124
eth-mac-BroadcastFramesXmittedOK: 1
eth-mac-MulticastFramesReceivedOK: 164
eth-mac-BroadcastFramesReceivedOK: 3
eth-mac-InRangeLengthErrors: 0
eth-mac-FrameTooLongErrors: 0
rmon-etherStatsUndersizePkts: 0
rmon-etherStatsOversizePkts: 0
rmon-etherStatsFragments: 0
rmon-etherStatsJabbers: 0
rx-rmon-etherStatsPkts64Octets: 31
rx-rmon-etherStatsPkts65to127Octets: 265
rx-rmon-etherStatsPkts128to255Octets: 26
rx-rmon-etherStatsPkts256to511Octets: 7
rx-rmon-etherStatsPkts512to1023Octets: 1
rx-rmon-etherStatsPkts1024to1522Octets: 6
rx-rmon-etherStatsPkts1523to9522Octets: 3
tx-rmon-etherStatsPkts64Octets: 25
tx-rmon-etherStatsPkts65to127Octets: 255
tx-rmon-etherStatsPkts128to255Octets: 1
tx-rmon-etherStatsPkts256to511Octets: 2
tx-rmon-etherStatsPkts512to1023Octets: 1
tx-rmon-etherStatsPkts1024to1522Octets: 1
tx-rmon-etherStatsPkts1523to9522Octets: 11
and
Pause parameters for ens785f0np0:
Autonegotiate:  on
RX:             off
TX:             off
RX negotiated: off
TX negotiated: off
Statistics:
  tx_pause_frames: 0
  rx_pause_frames: 0
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 78 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 62c8205fceba..6f0a857f55c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4282,6 +4282,81 @@ ice_get_module_eeprom(struct net_device *netdev,
 	return 0;
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
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4329,6 +4404,9 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_fecparam		= ice_set_fecparam,
 	.get_module_info	= ice_get_module_info,
 	.get_module_eeprom	= ice_get_module_eeprom,
+	.get_eth_mac_stats	= ice_get_eth_mac_stats,
+	.get_pause_stats	= ice_get_pause_stats,
+	.get_rmon_stats		= ice_get_rmon_stats,
 };
 
 static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..4db3a6056f41 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7034,6 +7034,9 @@ void ice_update_pf_stats(struct ice_pf *pf)
 			  &prev_ps->mac_remote_faults,
 			  &cur_ps->mac_remote_faults);
 
+	ice_stat_update32(hw, GLPRT_RLEC(port), pf->stat_prev_loaded,
+			  &prev_ps->rx_len_errors, &cur_ps->rx_len_errors);
+
 	ice_stat_update32(hw, GLPRT_RUC(port), pf->stat_prev_loaded,
 			  &prev_ps->rx_undersize, &cur_ps->rx_undersize);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f0796a93f428..b156d01196e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1007,6 +1007,7 @@ struct ice_hw_port_stats {
 	u64 error_bytes;		/* errbc */
 	u64 mac_local_faults;		/* mlfc */
 	u64 mac_remote_faults;		/* mrfc */
+	u64 rx_len_errors;		/* rlec */
 	u64 link_xon_rx;		/* lxonrxc */
 	u64 link_xoff_rx;		/* lxoffrxc */
 	u64 link_xon_tx;		/* lxontxc */
-- 
2.43.0


