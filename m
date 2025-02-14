Return-Path: <netdev+bounces-166569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7388A3677F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991F816CE73
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018C158870;
	Fri, 14 Feb 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLWZ4b5I"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B531D8E07
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568437; cv=none; b=p3iMF/Jcfjf0YvP1zI7cs/84VM0tMDi5uoFBsseMtISaGG93fmHWROjVl3EIszTaXl+tPbz9LFK3uwlSrkjuPCUFbU12+MsGZKE4bNEQ3KFJbJ1CNr+FMAB2gQWhElkOY3UkfrriWxi4wZkp0n2hNqYEcD4JHM+PyjzOzmTmMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568437; c=relaxed/simple;
	bh=hCzyfzUROt4a9mkKV0lKDC394459bcSKy8q3FqL8Sdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kjr4pJO6zJBN23WB0l8kUuNBQ+f0y/hVVO1Dmg5B+/M6rAoKXLtb5x+Rpmd/Kj7RvrqyCiR3HMHwe09WjIt5kW3SrV6H2px1u8UW5K4/4Rppg0VQcD0uievJXp66lIlps8+LB2+A7Hn/aeobe7nVSpLi6azg/PTRJIJ+jC+Hx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLWZ4b5I; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739568433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgusWkP0+qXEvqupBIggvyxEHsHYn2aCO8MEKD61Ll0=;
	b=jLWZ4b5IgGpxIr02EJIYz214CpKqE7E7aW1ydQIC9JwzUOIjmKglR/xeellRJl1cxjegOH
	svsGYM6euCNDrgw7qnwsgVjI2dlpIHSpwiDfD8U83HXhYF/FD0idcUK2I8+AHgWDCG/q5v
	aCAzbFu428b1RNGR4OjW1QZ7v9+Mq4A=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 2/2] net: cadence: macb: Report standard stats
Date: Fri, 14 Feb 2025 16:27:03 -0500
Message-Id: <20250214212703.2618652-3-sean.anderson@linux.dev>
In-Reply-To: <20250214212703.2618652-1-sean.anderson@linux.dev>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Report standard statistics using the dedicated callbacks instead of
get_ethtool_stats.

OCTTX is split over two registers. Accumulating these registers
separately in gem_stats just means we need to combine them again later.
Instead, combine these stats before saving them, like is done for
ethtool_stats.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb.h      |   6 +-
 drivers/net/ethernet/cadence/macb_main.c | 160 ++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index b4aa2b165bf3..f69b2b7c8802 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -975,8 +975,7 @@ struct macb_stats {
 };
 
 struct gem_stats {
-	u64	tx_octets_31_0;
-	u64	tx_octets_47_32;
+	u64	tx_octets;
 	u64	tx_frames;
 	u64	tx_broadcast_frames;
 	u64	tx_multicast_frames;
@@ -995,8 +994,7 @@ struct gem_stats {
 	u64	tx_late_collisions;
 	u64	tx_deferred_frames;
 	u64	tx_carrier_sense_errors;
-	u64	rx_octets_31_0;
-	u64	rx_octets_47_32;
+	u64	rx_octets;
 	u64	rx_frames;
 	u64	rx_broadcast_frames;
 	u64	rx_multicast_frames;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 86f0d705e354..4878c14121fb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3071,7 +3071,7 @@ static void gem_update_stats(struct macb *bp)
 	unsigned int i, q, idx;
 	unsigned long *stat;
 
-	u64 *p = &bp->hw_stats.gem.tx_octets_31_0;
+	u64 *p = &bp->hw_stats.gem.tx_octets;
 
 	for (i = 0; i < GEM_STATS_LEN; ++i, ++p) {
 		u32 offset = gem_statistics[i].offset;
@@ -3084,7 +3084,7 @@ static void gem_update_stats(struct macb *bp)
 			/* Add GEM_OCTTXH, GEM_OCTRXH */
 			val = bp->macb_reg_readl(bp, offset + 4);
 			bp->ethtool_stats[i] += ((u64)val) << 32;
-			*(++p) += val;
+			*(p++) += ((u64)val) << 32;
 		}
 	}
 
@@ -3226,6 +3226,154 @@ static void macb_get_stats(struct net_device *dev,
 	/* Don't know about heartbeat or window errors... */
 }
 
+static void macb_get_pause_stats(struct net_device *dev,
+				 struct ethtool_pause_stats *pause_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct macb_stats *hwstat = &bp->hw_stats.macb;
+
+	macb_update_stats(bp);
+	pause_stats->tx_pause_frames = hwstat->tx_pause_frames;
+	pause_stats->rx_pause_frames = hwstat->rx_pause_frames;
+}
+
+static void gem_get_pause_stats(struct net_device *dev,
+				struct ethtool_pause_stats *pause_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct gem_stats *hwstat = &bp->hw_stats.gem;
+
+	gem_update_stats(bp);
+	pause_stats->tx_pause_frames = hwstat->tx_pause_frames;
+	pause_stats->rx_pause_frames = hwstat->rx_pause_frames;
+}
+
+static void macb_get_eth_mac_stats(struct net_device *dev,
+				   struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct macb_stats *hwstat = &bp->hw_stats.macb;
+
+	macb_update_stats(bp);
+	mac_stats->FramesTransmittedOK = hwstat->tx_ok;
+	mac_stats->SingleCollisionFrames = hwstat->tx_single_cols;
+	mac_stats->MultipleCollisionFrames = hwstat->tx_multiple_cols;
+	mac_stats->FramesReceivedOK = hwstat->rx_ok;
+	mac_stats->FrameCheckSequenceErrors = hwstat->rx_fcs_errors;
+	mac_stats->AlignmentErrors = hwstat->rx_align_errors;
+	mac_stats->FramesWithDeferredXmissions = hwstat->tx_deferred;
+	mac_stats->LateCollisions = hwstat->tx_late_cols;
+	mac_stats->FramesAbortedDueToXSColls = hwstat->tx_excessive_cols;
+	mac_stats->FramesLostDueToIntMACXmitError = hwstat->tx_underruns;
+	mac_stats->CarrierSenseErrors = hwstat->tx_carrier_errors;
+	mac_stats->FramesLostDueToIntMACRcvError = hwstat->rx_overruns;
+	mac_stats->InRangeLengthErrors = hwstat->rx_length_mismatch;
+	mac_stats->FrameTooLongErrors = hwstat->rx_oversize_pkts;
+}
+
+static void gem_get_eth_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct gem_stats *hwstat = &bp->hw_stats.gem;
+
+	gem_update_stats(bp);
+	mac_stats->FramesTransmittedOK = hwstat->tx_frames;
+	mac_stats->SingleCollisionFrames = hwstat->tx_single_collision_frames;
+	mac_stats->MultipleCollisionFrames =
+		hwstat->tx_multiple_collision_frames;
+	mac_stats->FramesReceivedOK = hwstat->rx_frames;
+	mac_stats->FrameCheckSequenceErrors =
+		hwstat->rx_frame_check_sequence_errors;
+	mac_stats->AlignmentErrors = hwstat->rx_alignment_errors;
+	mac_stats->OctetsTransmittedOK = hwstat->tx_octets;
+	mac_stats->FramesWithDeferredXmissions = hwstat->tx_deferred_frames;
+	mac_stats->LateCollisions = hwstat->tx_late_collisions;
+	mac_stats->FramesAbortedDueToXSColls = hwstat->tx_excessive_collisions;
+	mac_stats->FramesLostDueToIntMACXmitError = hwstat->tx_underrun;
+	mac_stats->CarrierSenseErrors = hwstat->tx_carrier_sense_errors;
+	mac_stats->OctetsReceivedOK = hwstat->rx_octets;
+	mac_stats->MulticastFramesXmittedOK = hwstat->tx_multicast_frames;
+	mac_stats->BroadcastFramesXmittedOK = hwstat->tx_broadcast_frames;
+	mac_stats->MulticastFramesReceivedOK = hwstat->rx_multicast_frames;
+	mac_stats->BroadcastFramesReceivedOK = hwstat->rx_broadcast_frames;
+	mac_stats->InRangeLengthErrors = hwstat->rx_length_field_frame_errors;
+	mac_stats->FrameTooLongErrors = hwstat->rx_oversize_frames;
+}
+
+/* TODO: Report SQE test errors when added to phy_stats */
+static void macb_get_eth_phy_stats(struct net_device *dev,
+				   struct ethtool_eth_phy_stats *phy_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct macb_stats *hwstat = &bp->hw_stats.macb;
+
+	macb_update_stats(bp);
+	phy_stats->SymbolErrorDuringCarrier = hwstat->rx_symbol_errors;
+}
+
+static void gem_get_eth_phy_stats(struct net_device *dev,
+				  struct ethtool_eth_phy_stats *phy_stats)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct gem_stats *hwstat = &bp->hw_stats.gem;
+
+	gem_update_stats(bp);
+	phy_stats->SymbolErrorDuringCarrier = hwstat->rx_symbol_errors;
+}
+
+static void macb_get_rmon_stats(struct net_device *dev,
+				struct ethtool_rmon_stats *rmon_stats,
+				const struct ethtool_rmon_hist_range **ranges)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct macb_stats *hwstat = &bp->hw_stats.macb;
+
+	macb_update_stats(bp);
+	rmon_stats->undersize_pkts = hwstat->rx_undersize_pkts;
+	rmon_stats->oversize_pkts = hwstat->rx_oversize_pkts;
+	rmon_stats->jabbers = hwstat->rx_jabbers;
+}
+
+static const struct ethtool_rmon_hist_range gem_rmon_ranges[] = {
+	{   64,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1518 },
+	{ 1519, 16384 },
+	{ },
+};
+
+static void gem_get_rmon_stats(struct net_device *dev,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct gem_stats *hwstat = &bp->hw_stats.gem;
+
+	gem_update_stats(bp);
+	rmon_stats->undersize_pkts = hwstat->rx_undersized_frames;
+	rmon_stats->oversize_pkts = hwstat->rx_oversize_frames;
+	rmon_stats->jabbers = hwstat->rx_jabbers;
+	rmon_stats->hist[0] = hwstat->rx_64_byte_frames;
+	rmon_stats->hist[1] = hwstat->rx_65_127_byte_frames;
+	rmon_stats->hist[2] = hwstat->rx_128_255_byte_frames;
+	rmon_stats->hist[3] = hwstat->rx_256_511_byte_frames;
+	rmon_stats->hist[4] = hwstat->rx_512_1023_byte_frames;
+	rmon_stats->hist[5] = hwstat->rx_1024_1518_byte_frames;
+	rmon_stats->hist[6] = hwstat->rx_greater_than_1518_byte_frames;
+	rmon_stats->hist_tx[0] = hwstat->tx_64_byte_frames;
+	rmon_stats->hist_tx[1] = hwstat->tx_65_127_byte_frames;
+	rmon_stats->hist_tx[2] = hwstat->tx_128_255_byte_frames;
+	rmon_stats->hist_tx[3] = hwstat->tx_256_511_byte_frames;
+	rmon_stats->hist_tx[4] = hwstat->tx_512_1023_byte_frames;
+	rmon_stats->hist_tx[5] = hwstat->tx_1024_1518_byte_frames;
+	rmon_stats->hist_tx[6] = hwstat->tx_greater_than_1518_byte_frames;
+	*ranges = gem_rmon_ranges;
+}
+
 static int macb_get_regs_len(struct net_device *netdev)
 {
 	return MACB_GREGS_NBR * sizeof(u32);
@@ -3752,6 +3900,10 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.get_regs		= macb_get_regs,
 	.get_link		= ethtool_op_get_link,
 	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_pause_stats	= macb_get_pause_stats,
+	.get_eth_mac_stats	= macb_get_eth_mac_stats,
+	.get_eth_phy_stats	= macb_get_eth_phy_stats,
+	.get_rmon_stats		= macb_get_rmon_stats,
 	.get_wol		= macb_get_wol,
 	.set_wol		= macb_set_wol,
 	.get_link_ksettings     = macb_get_link_ksettings,
@@ -3770,6 +3922,10 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_ethtool_stats	= gem_get_ethtool_stats,
 	.get_strings		= gem_get_ethtool_strings,
 	.get_sset_count		= gem_get_sset_count,
+	.get_pause_stats	= gem_get_pause_stats,
+	.get_eth_mac_stats	= gem_get_eth_mac_stats,
+	.get_eth_phy_stats	= gem_get_eth_phy_stats,
+	.get_rmon_stats		= gem_get_rmon_stats,
 	.get_link_ksettings     = macb_get_link_ksettings,
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
-- 
2.35.1.1320.gc452695387.dirty


