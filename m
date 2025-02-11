Return-Path: <netdev+bounces-165245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB7A313D3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3421880741
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217D250C1A;
	Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqk+fJkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA36222582
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297643; cv=none; b=adiTFKTU5Lj59dQtVqcM7u9elbnA4vb+qAd0ZeRuK4NBUJSC3tPrsvQeLVB5pRjhIaTGJoS4l6rOdxdSDRf5PSV5cGJuysvF32Wv1zxiW8fS01aYSU3KF9yvig/aq72wdJuA9+1uMdjoZ+2j9z2vaUinacAOjm8PHkDZX7w3ByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297643; c=relaxed/simple;
	bh=+LfqGBkBgwLHkTAWzM829hfTkprgQnOTnCwIX7x9X+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+t4zTRN6R9/hfoAhlkRABHt3YtmjEvckmPxN4trDGbmMaUNJAvf+dwyKnS5VAAS5TkrSuaI/kMz/vjx9G9DxpEZ7WdUauosEVPMNqSBNf/whqgpqoe730d0UQZeW23rtaNPZQlXqiIqxEh25IpyT2G/Rh8xkurlsqrTPwVxt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqk+fJkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460A2C4CEE6;
	Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297643;
	bh=+LfqGBkBgwLHkTAWzM829hfTkprgQnOTnCwIX7x9X+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqk+fJkvb2MnFrNFGv9dqS0wjYOA10LrYzfA4cX3d9gdjrPM5KS9yRwLAMLOr5NQt
	 r6F3id8eJzXXdvZ+1CDD1pwz4eRfxQL9BCbB/BtShqeaa3BlP89UNHr0CjY9wzAgkg
	 bRnlTmmVwxHHNaM+tOcoU2/lM2e/twx3ke38gDghRKoh4jSpBHMQ8ONnzxIwW7rosf
	 CjiS5PlvqMmAidmrKPJvDI8n/eAKfhECVPYj5Qj5G/l+CPYUlOspOBrlYtxLoMJSXz
	 KYYn4/xgbfI9EpMqps/5L0uaha0rwqXeMg8A8yrBZwWwJoH8rIvQl/eVTELNO+d0MK
	 3MuxT3z0K+yrA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] eth: fbnic: report software Tx queue stats
Date: Tue, 11 Feb 2025 10:13:55 -0800
Message-ID: <20250211181356.580800-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211181356.580800-1-kuba@kernel.org>
References: <20250211181356.580800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gather and report software Tx queue stats - checksum stats
and queue stop / start.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 10 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 23 +++++++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 3fe4d1b6baad..57ae95a6cbfa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -59,8 +59,11 @@ struct fbnic_queue_stats {
 	u64 dropped;
 	union {
 		struct {
+			u64 csum_partial;
 			u64 ts_packets;
 			u64 ts_lost;
+			u64 stop;
+			u64 wake;
 		} twq;
 		struct {
 			u64 alloc_failed;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index ceb6d1de9bcf..b12672d1607e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -517,6 +517,7 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_ring *txr = fbn->tx[idx];
 	struct fbnic_queue_stats *stats;
+	u64 stop, wake, csum;
 	unsigned int start;
 	u64 bytes, packets;
 
@@ -528,10 +529,16 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 		start = u64_stats_fetch_begin(&stats->syncp);
 		bytes = stats->bytes;
 		packets = stats->packets;
+		csum = stats->twq.csum_partial;
+		stop = stats->twq.stop;
+		wake = stats->twq.wake;
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
+	tx->needs_csum = csum;
+	tx->stop = stop;
+	tx->wake = wake;
 }
 
 static void fbnic_get_base_stats(struct net_device *dev,
@@ -542,6 +549,9 @@ static void fbnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = fbn->tx_stats.bytes;
 	tx->packets = fbn->tx_stats.packets;
+	tx->needs_csum = fbn->tx_stats.twq.csum_partial;
+	tx->stop = fbn->tx_stats.twq.stop;
+	tx->wake = fbn->tx_stats.twq.wake;
 
 	rx->bytes = fbn->rx_stats.bytes;
 	rx->packets = fbn->rx_stats.packets;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 66ba36fd3c08..24d2b528b66c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -113,6 +113,11 @@ static int fbnic_maybe_stop_tx(const struct net_device *dev,
 
 	res = netif_txq_maybe_stop(txq, fbnic_desc_unused(ring), size,
 				   FBNIC_TX_DESC_WAKEUP);
+	if (!res) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.twq.stop++;
+		u64_stats_update_end(&ring->stats.syncp);
+	}
 
 	return !res;
 }
@@ -191,6 +196,9 @@ fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 					skb->csum_offset / 2));
 
 	*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_CSO);
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.twq.csum_partial++;
+	u64_stats_update_end(&ring->stats.syncp);
 
 	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_L2_HLEN_MASK, l2len / 2) |
 			     FIELD_PREP(FBNIC_TWD_L3_IHLEN_MASK, i3len / 2));
@@ -460,9 +468,13 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	ring->stats.packets += total_packets;
 	u64_stats_update_end(&ring->stats.syncp);
 
-	netif_txq_completed_wake(txq, total_packets, total_bytes,
-				 fbnic_desc_unused(ring),
-				 FBNIC_TX_DESC_WAKEUP);
+	if (!netif_txq_completed_wake(txq, total_packets, total_bytes,
+				      fbnic_desc_unused(ring),
+				      FBNIC_TX_DESC_WAKEUP)) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.twq.wake++;
+		u64_stats_update_end(&ring->stats.syncp);
+	}
 }
 
 static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
@@ -1092,10 +1104,13 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	fbn->tx_stats.bytes += stats->bytes;
 	fbn->tx_stats.packets += stats->packets;
 	fbn->tx_stats.dropped += stats->dropped;
+	fbn->tx_stats.twq.csum_partial += stats->twq.csum_partial;
 	fbn->tx_stats.twq.ts_lost += stats->twq.ts_lost;
 	fbn->tx_stats.twq.ts_packets += stats->twq.ts_packets;
+	fbn->tx_stats.twq.stop += stats->twq.stop;
+	fbn->tx_stats.twq.wake += stats->twq.wake;
 	/* Remember to add new stats here */
-	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 2);
+	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 5);
 }
 
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
-- 
2.48.1


