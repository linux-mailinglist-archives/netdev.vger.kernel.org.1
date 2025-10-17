Return-Path: <netdev+bounces-230321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1CBE6939
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19F54FB1A1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30854314A8F;
	Fri, 17 Oct 2025 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InkV/QTY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE0312838;
	Fri, 17 Oct 2025 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681464; cv=none; b=a5evBY3DnVQKM0yqAqVNfKSR40wTrjNVqcj4bdtS1j2sx6yagrqVp0nKLsJpHFiBu66sdGxDdmJFhjKEb+zq7XKLD2v1EcesZB6tucmiMg3ROVHbkTlDJkee/4PrHgTTPxEwBVkeCM9Eh3NJHgPuFfJaEyjRi8GVzNZpSRVDwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681464; c=relaxed/simple;
	bh=LiNjAvEUfwKqlelMoWP87m05arWgFoqi+Up7J3CDK4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKQOzdb3+1hMOw6CmMRQ6OuM4mUS04Gr65WpEcjmQJ7BGKuzKMm5Mta9QbbNQALgJFF8cukSGPMpXq/ZwFDn/QlJxOvaHUbutPGvF9PL0bFFEpHc/LiRvJS9QinbfOSwkIbW4jGJio/og0iAzogHVJxm9tNA/ZdgCJEhGDVGDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InkV/QTY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681461; x=1792217461;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LiNjAvEUfwKqlelMoWP87m05arWgFoqi+Up7J3CDK4c=;
  b=InkV/QTY9CCOEcSZ+ohv3ssswcHMfVetAMQqF5iW4o5ojXP2DOozpAIi
   fbpIHz925lrrCChhB6ohF6bG1XbxW/znsBiJmFK39OBhGsjZm2CVy+gch
   ZtlmiW8G6rwjxitZQjo36BBo34jYBv8PU2+Lu/8cZcOtNVIZlSPVyz9fY
   PP8w6VyRtyOwwtp9ULH4koAcoy8nfjRJRYvckfcMvI5u6YCgBTUUY6OWW
   9f+41TabJzUzGzQHllNclRCu0rdHdj1OrTjs+CUSMBkrxkaICIZ4WT/3i
   KKfGYu5BzS1EFhLVCzQU36VcrnkpCr+beOMU3URdJGNDniNkO8KTpwe4s
   A==;
X-CSE-ConnectionGUID: 8mvIlgSIQhqO305a0GA+tA==
X-CSE-MsgGUID: gukn+1ZASTmbW58OUr/hyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50453989"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50453989"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:54 -0700
X-CSE-ConnectionGUID: Kcc/g+vdTh28UB7e1VysnQ==
X-CSE-MsgGUID: W9M1AAzBQRmSjybdomZGrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059505"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:38 -0700
Subject: [PATCH net-next v2 09/14] ice: implement ethtool standard stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-9-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=5906;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=OrcedSEU691fMnjIymWsfS+Vv0QwuQSkuaeedWKY8Ac=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyPd19IX2l5cdK+NSTtWPWznAb2HBGdGTyeuSVXYkNF0
 1J1W2Z2lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJEPWxj+h7xyvbzndFoN02aP
 yF36LGf2zivatdDh3nyPpNRVze/XsDD8rzvBppS2abnh1IdqmkzFUYnrNY+u/3Y5fO1TYaMdvCq
 RLAA=
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
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 78 ++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b0a1b67071c5..6a2ec8389a8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1063,6 +1063,7 @@ struct ice_hw_port_stats {
 	u64 error_bytes;		/* errbc */
 	u64 mac_local_faults;		/* mlfc */
 	u64 mac_remote_faults;		/* mrfc */
+	u64 rx_len_errors;		/* rlec */
 	u64 link_xon_rx;		/* lxonrxc */
 	u64 link_xoff_rx;		/* lxoffrxc */
 	u64 link_xon_tx;		/* lxontxc */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dc131779d426..d1ec7e6f12bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4661,6 +4661,81 @@ static void ice_get_fec_stats(struct net_device *netdev,
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
 
@@ -4744,6 +4819,9 @@ static const struct ethtool_ops ice_ethtool_ops = {
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
index 86f5859e88ef..3d5615caf6d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7138,6 +7138,9 @@ void ice_update_pf_stats(struct ice_pf *pf)
 			  &prev_ps->mac_remote_faults,
 			  &cur_ps->mac_remote_faults);
 
+	ice_stat_update32(hw, GLPRT_RLEC(port), pf->stat_prev_loaded,
+			  &prev_ps->rx_len_errors, &cur_ps->rx_len_errors);
+
 	ice_stat_update32(hw, GLPRT_RUC(port), pf->stat_prev_loaded,
 			  &prev_ps->rx_undersize, &cur_ps->rx_undersize);
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


