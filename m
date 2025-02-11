Return-Path: <netdev+bounces-165244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBBA313D1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379181880692
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A541E5702;
	Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajxfE/uB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EF1E47CC
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297643; cv=none; b=HV/tZI2OqFjtUv5eiVLexJBnOkFcD1U4EjOe9tG77l3wcFVC16raWoL5qj24cnO6KPzgRiLTmToFA0fdhgsnBcQXx0zdTjJIVSGlJAhxRTzFaf8vT+LGUjIEvpW2DKW+vKrpk5s5FWPRMhfT4ptGyNEOahTBOWhOpgDBmCdHfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297643; c=relaxed/simple;
	bh=UroB3/N9b/uz6aGncgzlcsa3qo9CyT8CNaclAO1kWjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwWbHFN9wPNqclV5WV0PiTZTKeZFN7UkTqVp3zSCNinBu/8rp5dZOCGnYJ9Iaesq82gZW9Jv+Tq39jGaFv3gMUUAG6Q8HA36zfCRlQGfn6SrEhqglpoQGqR48pH3dHClzshAGdtKk7ar3O61C0i2huS14EUsyqLJ7Who15Ccv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajxfE/uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60EFC4CEEA;
	Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297643;
	bh=UroB3/N9b/uz6aGncgzlcsa3qo9CyT8CNaclAO1kWjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajxfE/uBIGzXnictqo7v9KaYCSG0C/PIEKzdGEFspJKRw31X3LDBloTUS+HXuBLAj
	 hdSpUfig/i4jTsBzYUdJxCL06617ClduYeMUxFdrvk2gwDTOF9COa6Af4Jd2wkwbVc
	 qoU+7U8xv0rLcQ69mNziqLYziX+QfIpKmWO8AYPr2JrMgWrM8DdwfRaZFDycxwZTwG
	 pRtqncv4swcsV3mr9IdErdg7l2coZyh+/40INUEyN5fCrWpgN0TOgwTp+Lqv3TrZ8B
	 nGFXwy2eMOG5mPueGmb0vZ5q+TGxY/8nS4hHQj2mJ5537HkrpjKVfq15IoApKcGpOX
	 ORUGCn2o/+VfQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] eth: fbnic: report software Rx queue stats
Date: Tue, 11 Feb 2025 10:13:54 -0800
Message-ID: <20250211181356.580800-4-kuba@kernel.org>
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

Gather and report software Rx queue stats - checksum stats
and allocation failures.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  5 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 12 +++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 43 +++++++++++++++----
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index d6ae8462584f..3fe4d1b6baad 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -62,6 +62,11 @@ struct fbnic_queue_stats {
 			u64 ts_packets;
 			u64 ts_lost;
 		} twq;
+		struct {
+			u64 alloc_failed;
+			u64 csum_complete;
+			u64 csum_none;
+		} rx;
 	};
 	struct u64_stats_sync syncp;
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 14e7a8384bce..ceb6d1de9bcf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -487,8 +487,9 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_ring *rxr = fbn->rx[idx];
 	struct fbnic_queue_stats *stats;
+	u64 bytes, packets, alloc_fail;
+	u64 csum_complete, csum_none;
 	unsigned int start;
-	u64 bytes, packets;
 
 	if (!rxr)
 		return;
@@ -498,10 +499,16 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 		start = u64_stats_fetch_begin(&stats->syncp);
 		bytes = stats->bytes;
 		packets = stats->packets;
+		alloc_fail = stats->rx.alloc_failed;
+		csum_complete = stats->rx.csum_complete;
+		csum_none = stats->rx.csum_none;
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	rx->bytes = bytes;
 	rx->packets = packets;
+	rx->alloc_fail = alloc_fail;
+	rx->csum_complete = csum_complete;
+	rx->csum_none = csum_none;
 }
 
 static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
@@ -538,6 +545,9 @@ static void fbnic_get_base_stats(struct net_device *dev,
 
 	rx->bytes = fbn->rx_stats.bytes;
 	rx->packets = fbn->rx_stats.packets;
+	rx->alloc_fail = fbn->rx_stats.rx.alloc_failed;
+	rx->csum_complete = fbn->rx_stats.rx.csum_complete;
+	rx->csum_none = fbn->rx_stats.rx.csum_none;
 }
 
 static const struct netdev_stat_ops fbnic_stat_ops = {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b60dd1c9918e..66ba36fd3c08 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -198,12 +198,15 @@ fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 }
 
 static void
-fbnic_rx_csum(u64 rcd, struct sk_buff *skb, struct fbnic_ring *rcq)
+fbnic_rx_csum(u64 rcd, struct sk_buff *skb, struct fbnic_ring *rcq,
+	      u64 *csum_cmpl, u64 *csum_none)
 {
 	skb_checksum_none_assert(skb);
 
-	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM)))
+	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
+		(*csum_none)++;
 		return;
+	}
 
 	if (FIELD_GET(FBNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd)) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -212,6 +215,7 @@ fbnic_rx_csum(u64 rcd, struct sk_buff *skb, struct fbnic_ring *rcq)
 
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = (__force __wsum)csum;
+		(*csum_cmpl)++;
 	}
 }
 
@@ -661,8 +665,13 @@ static void fbnic_fill_bdq(struct fbnic_napi_vector *nv, struct fbnic_ring *bdq)
 		struct page *page;
 
 		page = page_pool_dev_alloc_pages(nv->page_pool);
-		if (!page)
+		if (!page) {
+			u64_stats_update_begin(&bdq->stats.syncp);
+			bdq->stats.rx.alloc_failed++;
+			u64_stats_update_end(&bdq->stats.syncp);
+
 			break;
+		}
 
 		fbnic_page_pool_init(bdq, i, page);
 		fbnic_bd_prep(bdq, i, page);
@@ -875,12 +884,13 @@ static void fbnic_rx_tstamp(struct fbnic_napi_vector *nv, u64 rcd,
 
 static void fbnic_populate_skb_fields(struct fbnic_napi_vector *nv,
 				      u64 rcd, struct sk_buff *skb,
-				      struct fbnic_q_triad *qt)
+				      struct fbnic_q_triad *qt,
+				      u64 *csum_cmpl, u64 *csum_none)
 {
 	struct net_device *netdev = nv->napi.dev;
 	struct fbnic_ring *rcq = &qt->cmpl;
 
-	fbnic_rx_csum(rcd, skb, rcq);
+	fbnic_rx_csum(rcd, skb, rcq, csum_cmpl, csum_none);
 
 	if (netdev->features & NETIF_F_RXHASH)
 		skb_set_hash(skb,
@@ -898,7 +908,8 @@ static bool fbnic_rcd_metadata_err(u64 rcd)
 static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
-	unsigned int packets = 0, bytes = 0, dropped = 0;
+	unsigned int packets = 0, bytes = 0, dropped = 0, alloc_failed = 0;
+	u64 csum_complete = 0, csum_none = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	s32 head0 = -1, head1 = -1;
@@ -947,14 +958,22 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 			/* Populate skb and invalidate XDP */
 			if (!IS_ERR_OR_NULL(skb)) {
-				fbnic_populate_skb_fields(nv, rcd, skb, qt);
+				fbnic_populate_skb_fields(nv, rcd, skb, qt,
+							  &csum_complete,
+							  &csum_none);
 
 				packets++;
 				bytes += skb->len;
 
 				napi_gro_receive(&nv->napi, skb);
 			} else {
-				dropped++;
+				if (!skb) {
+					alloc_failed++;
+					dropped++;
+				} else {
+					dropped++;
+				}
+
 				fbnic_put_pkt_buff(nv, pkt, 1);
 			}
 
@@ -977,6 +996,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	/* Re-add ethernet header length (removed in fbnic_build_skb) */
 	rcq->stats.bytes += ETH_HLEN * packets;
 	rcq->stats.dropped += dropped;
+	rcq->stats.rx.alloc_failed += alloc_failed;
+	rcq->stats.rx.csum_complete += csum_complete;
+	rcq->stats.rx.csum_none += csum_none;
 	u64_stats_update_end(&rcq->stats.syncp);
 
 	/* Unmap and free processed buffers */
@@ -1054,6 +1076,11 @@ void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
 	fbn->rx_stats.bytes += stats->bytes;
 	fbn->rx_stats.packets += stats->packets;
 	fbn->rx_stats.dropped += stats->dropped;
+	fbn->rx_stats.rx.alloc_failed += stats->rx.alloc_failed;
+	fbn->rx_stats.rx.csum_complete += stats->rx.csum_complete;
+	fbn->rx_stats.rx.csum_none += stats->rx.csum_none;
+	/* Remember to add new stats here */
+	BUILD_BUG_ON(sizeof(fbn->tx_stats.rx) / 8 != 3);
 }
 
 void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
-- 
2.48.1


