Return-Path: <netdev+bounces-166568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892EA36780
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA52D3AE654
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773A1DB548;
	Fri, 14 Feb 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WTPuNtqt"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75893158870
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568435; cv=none; b=cBL+XAGWJLv8WzjYxQ1iA53a/aAgX/GsoyiaDrmitNDSSKj13SsTsrhfoMpt5yG9Sqa7UIclgJFWaYHb0tIyYbEhxH6qFmSmJ9x4viE3T5XjqMOn/S/mX7I33xjWk06rvECdUW1GMNxFs2P7ULJ1b9SuS6s9FE4EQle0Vqt93sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568435; c=relaxed/simple;
	bh=rPRNaVxBaPYWuZr6tdQuppzRL4OSoxO+uL2qcDFAF3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFXCFHD2wmdPpJYs9NL8zmtY7of10rZy7sF0j9UlX/fNN0o3GR4DtwsE3AHr0bfN9aBJQrARx+9uRQ7t7uJEz7TDCyFRrbrj7hoDOjQ4yyqUZ9D9CM2WanhNriESUkKHNU6C0wk/n7CFTi3bCK/hzuXwD2emuOEO+IaO8kl3s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WTPuNtqt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739568431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyd2iepNjyNFaxGpEG+1YRTZxev9qIZluSyTxS3vQlc=;
	b=WTPuNtqtUPTUS15X59nKe1Yihi/M5sgPI0KGnMma4NZndyCYh7FRG1+GBFEmHV8fJmaYcO
	dPfdaLtBo/X+SbPxht+avBu2ZKMUqTB1CVHcQW8CH9QftBSN1N3lOFRvvbjADMJUNmxAJ3
	Wsdyr/dqqT3OYdz0FZZsJUCVth7nAlQ=
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
Subject: [PATCH net-next 1/2] net: cadence: macb: Convert to get_stats64
Date: Fri, 14 Feb 2025 16:27:02 -0500
Message-Id: <20250214212703.2618652-2-sean.anderson@linux.dev>
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

Convert the existing get_stats implementation to get_stats64. Since we
now report 64-bit values, increase the counters to 64-bits as well.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb.h      | 132 +++++++++++------------
 drivers/net/ethernet/cadence/macb_main.c |  34 +++---
 2 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5740c98d8c9f..b4aa2b165bf3 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -951,75 +951,75 @@ struct macb_tx_skb {
  * device stats by a periodic timer.
  */
 struct macb_stats {
-	u32	rx_pause_frames;
-	u32	tx_ok;
-	u32	tx_single_cols;
-	u32	tx_multiple_cols;
-	u32	rx_ok;
-	u32	rx_fcs_errors;
-	u32	rx_align_errors;
-	u32	tx_deferred;
-	u32	tx_late_cols;
-	u32	tx_excessive_cols;
-	u32	tx_underruns;
-	u32	tx_carrier_errors;
-	u32	rx_resource_errors;
-	u32	rx_overruns;
-	u32	rx_symbol_errors;
-	u32	rx_oversize_pkts;
-	u32	rx_jabbers;
-	u32	rx_undersize_pkts;
-	u32	sqe_test_errors;
-	u32	rx_length_mismatch;
-	u32	tx_pause_frames;
+	u64	rx_pause_frames;
+	u64	tx_ok;
+	u64	tx_single_cols;
+	u64	tx_multiple_cols;
+	u64	rx_ok;
+	u64	rx_fcs_errors;
+	u64	rx_align_errors;
+	u64	tx_deferred;
+	u64	tx_late_cols;
+	u64	tx_excessive_cols;
+	u64	tx_underruns;
+	u64	tx_carrier_errors;
+	u64	rx_resource_errors;
+	u64	rx_overruns;
+	u64	rx_symbol_errors;
+	u64	rx_oversize_pkts;
+	u64	rx_jabbers;
+	u64	rx_undersize_pkts;
+	u64	sqe_test_errors;
+	u64	rx_length_mismatch;
+	u64	tx_pause_frames;
 };
 
 struct gem_stats {
-	u32	tx_octets_31_0;
-	u32	tx_octets_47_32;
-	u32	tx_frames;
-	u32	tx_broadcast_frames;
-	u32	tx_multicast_frames;
-	u32	tx_pause_frames;
-	u32	tx_64_byte_frames;
-	u32	tx_65_127_byte_frames;
-	u32	tx_128_255_byte_frames;
-	u32	tx_256_511_byte_frames;
-	u32	tx_512_1023_byte_frames;
-	u32	tx_1024_1518_byte_frames;
-	u32	tx_greater_than_1518_byte_frames;
-	u32	tx_underrun;
-	u32	tx_single_collision_frames;
-	u32	tx_multiple_collision_frames;
-	u32	tx_excessive_collisions;
-	u32	tx_late_collisions;
-	u32	tx_deferred_frames;
-	u32	tx_carrier_sense_errors;
-	u32	rx_octets_31_0;
-	u32	rx_octets_47_32;
-	u32	rx_frames;
-	u32	rx_broadcast_frames;
-	u32	rx_multicast_frames;
-	u32	rx_pause_frames;
-	u32	rx_64_byte_frames;
-	u32	rx_65_127_byte_frames;
-	u32	rx_128_255_byte_frames;
-	u32	rx_256_511_byte_frames;
-	u32	rx_512_1023_byte_frames;
-	u32	rx_1024_1518_byte_frames;
-	u32	rx_greater_than_1518_byte_frames;
-	u32	rx_undersized_frames;
-	u32	rx_oversize_frames;
-	u32	rx_jabbers;
-	u32	rx_frame_check_sequence_errors;
-	u32	rx_length_field_frame_errors;
-	u32	rx_symbol_errors;
-	u32	rx_alignment_errors;
-	u32	rx_resource_errors;
-	u32	rx_overruns;
-	u32	rx_ip_header_checksum_errors;
-	u32	rx_tcp_checksum_errors;
-	u32	rx_udp_checksum_errors;
+	u64	tx_octets_31_0;
+	u64	tx_octets_47_32;
+	u64	tx_frames;
+	u64	tx_broadcast_frames;
+	u64	tx_multicast_frames;
+	u64	tx_pause_frames;
+	u64	tx_64_byte_frames;
+	u64	tx_65_127_byte_frames;
+	u64	tx_128_255_byte_frames;
+	u64	tx_256_511_byte_frames;
+	u64	tx_512_1023_byte_frames;
+	u64	tx_1024_1518_byte_frames;
+	u64	tx_greater_than_1518_byte_frames;
+	u64	tx_underrun;
+	u64	tx_single_collision_frames;
+	u64	tx_multiple_collision_frames;
+	u64	tx_excessive_collisions;
+	u64	tx_late_collisions;
+	u64	tx_deferred_frames;
+	u64	tx_carrier_sense_errors;
+	u64	rx_octets_31_0;
+	u64	rx_octets_47_32;
+	u64	rx_frames;
+	u64	rx_broadcast_frames;
+	u64	rx_multicast_frames;
+	u64	rx_pause_frames;
+	u64	rx_64_byte_frames;
+	u64	rx_65_127_byte_frames;
+	u64	rx_128_255_byte_frames;
+	u64	rx_256_511_byte_frames;
+	u64	rx_512_1023_byte_frames;
+	u64	rx_1024_1518_byte_frames;
+	u64	rx_greater_than_1518_byte_frames;
+	u64	rx_undersized_frames;
+	u64	rx_oversize_frames;
+	u64	rx_jabbers;
+	u64	rx_frame_check_sequence_errors;
+	u64	rx_length_field_frame_errors;
+	u64	rx_symbol_errors;
+	u64	rx_alignment_errors;
+	u64	rx_resource_errors;
+	u64	rx_overruns;
+	u64	rx_ip_header_checksum_errors;
+	u64	rx_tcp_checksum_errors;
+	u64	rx_udp_checksum_errors;
 };
 
 /* Describes the name and offset of an individual statistic register, as
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 48496209fb16..86f0d705e354 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -990,8 +990,8 @@ static int macb_mii_init(struct macb *bp)
 
 static void macb_update_stats(struct macb *bp)
 {
-	u32 *p = &bp->hw_stats.macb.rx_pause_frames;
-	u32 *end = &bp->hw_stats.macb.tx_pause_frames + 1;
+	u64 *p = &bp->hw_stats.macb.rx_pause_frames;
+	u64 *end = &bp->hw_stats.macb.tx_pause_frames + 1;
 	int offset = MACB_PFR;
 
 	WARN_ON((unsigned long)(end - p - 1) != (MACB_TPF - MACB_PFR) / 4);
@@ -3071,7 +3071,7 @@ static void gem_update_stats(struct macb *bp)
 	unsigned int i, q, idx;
 	unsigned long *stat;
 
-	u32 *p = &bp->hw_stats.gem.tx_octets_31_0;
+	u64 *p = &bp->hw_stats.gem.tx_octets_31_0;
 
 	for (i = 0; i < GEM_STATS_LEN; ++i, ++p) {
 		u32 offset = gem_statistics[i].offset;
@@ -3094,15 +3094,12 @@ static void gem_update_stats(struct macb *bp)
 			bp->ethtool_stats[idx++] = *stat;
 }
 
-static struct net_device_stats *gem_get_stats(struct macb *bp)
+static void gem_get_stats(struct macb *bp, struct rtnl_link_stats64 *nstat)
 {
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
-	struct net_device_stats *nstat = &bp->dev->stats;
 
-	if (!netif_running(bp->dev))
-		return nstat;
-
-	gem_update_stats(bp);
+	if (netif_running(bp->dev))
+		gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
 			    hwstat->rx_alignment_errors +
@@ -3131,8 +3128,6 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
-
-	return nstat;
 }
 
 static void gem_get_ethtool_stats(struct net_device *dev,
@@ -3183,14 +3178,17 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 	}
 }
 
-static struct net_device_stats *macb_get_stats(struct net_device *dev)
+static void macb_get_stats(struct net_device *dev,
+			   struct rtnl_link_stats64 *nstat)
 {
 	struct macb *bp = netdev_priv(dev);
-	struct net_device_stats *nstat = &bp->dev->stats;
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
-	if (macb_is_gem(bp))
-		return gem_get_stats(bp);
+	netdev_stats_to_stats64(nstat, &bp->dev->stats);
+	if (macb_is_gem(bp)) {
+		gem_get_stats(bp, nstat);
+		return;
+	}
 
 	/* read stats from hardware */
 	macb_update_stats(bp);
@@ -3226,8 +3224,6 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
-
-	return nstat;
 }
 
 static int macb_get_regs_len(struct net_device *netdev)
@@ -3910,7 +3906,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_stop		= macb_close,
 	.ndo_start_xmit		= macb_start_xmit,
 	.ndo_set_rx_mode	= macb_set_rx_mode,
-	.ndo_get_stats		= macb_get_stats,
+	.ndo_get_stats64	= macb_get_stats,
 	.ndo_eth_ioctl		= macb_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= macb_change_mtu,
@@ -4571,7 +4567,7 @@ static const struct net_device_ops at91ether_netdev_ops = {
 	.ndo_open		= at91ether_open,
 	.ndo_stop		= at91ether_close,
 	.ndo_start_xmit		= at91ether_start_xmit,
-	.ndo_get_stats		= macb_get_stats,
+	.ndo_get_stats64	= macb_get_stats,
 	.ndo_set_rx_mode	= macb_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_eth_ioctl		= macb_ioctl,
-- 
2.35.1.1320.gc452695387.dirty


