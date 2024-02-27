Return-Path: <netdev+bounces-75328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1D869873
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C731C2201B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EE6A033;
	Tue, 27 Feb 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jde2wm91"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0454FB1
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044309; cv=none; b=DId7u5diHzhgSDb1YgvbWy5f2U/H4rMLk1frbssm3U6bKwaZDI2rRIptorAWFEkslmYYCpDzTUrCCDgCmcZbxH5yohPXxPX7xgiA+UsNxf+G7pNL9E+TAugE7eaDvl3CAenemIAibkwwEBFIdOf3T3nby7VMXN01RTS/aTGYKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044309; c=relaxed/simple;
	bh=x22hhBiLB45AUr7ettB8S5dFgc3aNNjrNGCtp8BcbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NX16Co9usgQW6kovFuCPaauD/xubA2D1YtSt9bkq81ldysF2CHayB3aF9Y+jyfw+H32Y7Urr8vebGtEbJzRAfVb4sIJHfIqtUaILqECZ/QSd20Gki3AbFP7N7H0haZQ4MpIMZCwNYHvemz4efBCc55J/hB/RusvCGNZDlFRpZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jde2wm91; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709044307; x=1740580307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x22hhBiLB45AUr7ettB8S5dFgc3aNNjrNGCtp8BcbuY=;
  b=Jde2wm91d81JmTX8iROAzpyCAbJyEOEhIFSC8lN9Shpw7aOtksrIlj4M
   GUEcWlZ4e7mr4KcfA+KbBlk/urkstUVS6vuZUTFlVa/qVPFtDb++ZN/F9
   3TuST3H4Wdx1DeBDGK3ocCDO72hPl4MeZ8gYRKGz9FWKaFOhxCMdPJkx5
   JXhO8fvmseq7e5+Xje6ccLsk215VYnw1PgxFwZChFVBkz3LywiJnwdiM0
   ESXxgWWf+HFiAy14DOWtUJ+/f7g+K5vNpWdtotif8asDBnanUpaP3ZPMD
   UFKAbwaq4uFk0F62MCNBVXT+II6kdON09hagtImTsLsLifH2y7k/ECICG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14534101"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14534101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="38100128"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 27 Feb 2024 06:31:43 -0800
Received: from pkitszel-desk.intel.com (unknown [10.254.152.204])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 40674125BD;
	Tue, 27 Feb 2024 14:31:40 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	lukasz.czapnik@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>,
	Christian Rohmann <christian.rohmann@inovex.de>
Subject: [PATCH iwl-net] ice: fix stats being updated by way too large values
Date: Tue, 27 Feb 2024 15:31:06 +0100
Message-ID: <20240227143124.21015-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify stats accumulation logic to fix the case where we don't take
previous stat value into account, we should always respect it.

Main netdev stats of our PF (Tx/Rx packets/bytes) were reported orders of
magnitude too big during OpenStack reconfiguration events, possibly other
reconfiguration cases too.

The regression was reported to be between 6.1 and 6.2, so I was almost
certain that on of the two "preserve stats over reset" commits were the
culprit. While reading the code, it was found that in some cases we will
increase the stats by arbitrarily large number (thanks to ignoring "-prev"
part of condition, after zeroing it).

Note that this fixes also the case where we were around limits of u64, but
that was not the regression reported.

Full disclosure: I remember suggesting this particular piece of code to
Ben a few years ago, so blame on me.

Fixes: 2fd5e433cd26 ("ice: Accumulate HW and Netdev statistics over reset")
Reported-by: Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>
Link: https://lore.kernel.org/intel-wired-lan/VI1PR02MB439744DEDAA7B59B9A2833FE912EA@VI1PR02MB4397.eurprd02.prod.outlook.com
Reported-by: Christian Rohmann <christian.rohmann@inovex.de>
Link: https://lore.kernel.org/intel-wired-lan/f38a6ca4-af05-48b1-a3e6-17ef2054e525@inovex.de
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd4a9bc0dfdc..a7c7b1b633a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6736,6 +6736,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
+	struct ice_pf *pf = vsi->back;
 	u64 pkts, bytes;
 	int i;
 
@@ -6781,21 +6782,18 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	net_stats = &vsi->net_stats;
 	stats_prev = &vsi->net_stats_prev;
 
-	/* clear prev counters after reset */
-	if (vsi_stats->tx_packets < stats_prev->tx_packets ||
-	    vsi_stats->rx_packets < stats_prev->rx_packets) {
-		stats_prev->tx_packets = 0;
-		stats_prev->tx_bytes = 0;
-		stats_prev->rx_packets = 0;
-		stats_prev->rx_bytes = 0;
+	/* Update netdev counters, but keep in mind that values could start at
+	 * random value after PF reset. And as we increase the reported stat by
+	 * diff of Prev-Cur, we need to be sure that Prev is valid. If it's not,
+	 * let's skip this round.
+	 */
+	if (likely(pf->stat_prev_loaded)) {
+		net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
+		net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
+		net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
+		net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
 	}
 
-	/* update netdev counters */
-	net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
-	net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
-	net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
-	net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
-
 	stats_prev->tx_packets = vsi_stats->tx_packets;
 	stats_prev->tx_bytes = vsi_stats->tx_bytes;
 	stats_prev->rx_packets = vsi_stats->rx_packets;

base-commit: 9b23fceb4158a3636ce4a2bda28ab03dcfa6a26f
-- 
2.43.0


