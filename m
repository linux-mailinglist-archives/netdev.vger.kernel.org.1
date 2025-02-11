Return-Path: <netdev+bounces-165243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DAA313D0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D401D7A3474
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6901E47C9;
	Tue, 11 Feb 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZejL14ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096871E47AE
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297643; cv=none; b=ryahHxm5LXC7fNIcVc8uu+tFI58wrHkOk5wly7Xh3UYRM2lcykCAImzuaqfYJYNb7s3V2C3qrb9L/GhzjoBa0XP6UjTDmzQCt+wtsbSchS874eIA78Vx+1a8yM/4ovcyK2zl5O4IJP3ywGKyhNaIyoEvrhElDg3gWS+v/YWN37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297643; c=relaxed/simple;
	bh=qCWrBrnoIq0DABjL3DtB9fhpu2usvA2j4sIYRr502hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7Od+ZGNjA/+VoFdXw0RegDMkcrmIM3zgqoufTHCOaB6aJ96y5YZsh8Aeo0/fx0Rj0JiosgCg58a4/PdRrCHnzb0MO7TXCCGwaO2E7chDOhcRIAJpQtYRJE2rRTC3FZpMiTNd18QXRz5eu/imk/bRez1w3hmeBJdFuSjPPADIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZejL14ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319DEC4CEE9;
	Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297642;
	bh=qCWrBrnoIq0DABjL3DtB9fhpu2usvA2j4sIYRr502hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZejL14ds6m0f5sK1LNQKARCVn5fb1m21/4deYyZTg4SSWevuryBx4GwcIu6xBeDOk
	 /F/XkASyX/jZWM5hpiboDI4AMDjHI+S3zjljCcteHmuZMXyPK+x/pRRAlF0Wgunalm
	 JlWZil/h3c7tNdU71lJf0dl0Fe610YoUuUarGG/Bc3r+eBBGF43umB8EBwP3cn0VOw
	 JyY5zLOJi12mfw5atRLeORJ6+X9ALFaaWc/ob9B5jOQcg2jLul9xtAQigONPhKBcWl
	 PlIPNbXsuzllRrbK/jmry7jdGGu/kxlba3LnmP8MJBm6Ou3XdKDP0TWHyJwJnKckCm
	 FwI1LBbGNq76Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: fbnic: wrap tx queue stats in a struct
Date: Tue, 11 Feb 2025 10:13:53 -0800
Message-ID: <20250211181356.580800-3-kuba@kernel.org>
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

The queue stats struct is used for Rx and Tx queues. Wrap
the Tx stats in a struct and a union, so that we can reuse
the same space for Rx stats on Rx queues.

This also makes it easy to add an assert to the stat handling
code to catch new stats not being aggregated on shutdown.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h    |  8 ++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |  8 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    | 10 ++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index c2a94f31f71b..d6ae8462584f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -57,8 +57,12 @@ struct fbnic_queue_stats {
 	u64 packets;
 	u64 bytes;
 	u64 dropped;
-	u64 ts_packets;
-	u64 ts_lost;
+	union {
+		struct {
+			u64 ts_packets;
+			u64 ts_lost;
+		} twq;
+	};
 	struct u64_stats_sync syncp;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 9503c36620c6..fb7139a1da46 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1224,14 +1224,14 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
 	unsigned int start;
 	int i;
 
-	ts_stats->pkts = fbn->tx_stats.ts_packets;
-	ts_stats->lost = fbn->tx_stats.ts_lost;
+	ts_stats->pkts = fbn->tx_stats.twq.ts_packets;
+	ts_stats->lost = fbn->tx_stats.twq.ts_lost;
 	for (i = 0; i < fbn->num_tx_queues; i++) {
 		ring = fbn->tx[i];
 		do {
 			start = u64_stats_fetch_begin(&ring->stats.syncp);
-			ts_packets = ring->stats.ts_packets;
-			ts_lost = ring->stats.ts_lost;
+			ts_packets = ring->stats.twq.ts_packets;
+			ts_lost = ring->stats.twq.ts_lost;
 		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
 		ts_stats->pkts += ts_packets;
 		ts_stats->lost += ts_lost;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index d4d7027df9a0..b60dd1c9918e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -444,7 +444,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	if (unlikely(discard)) {
 		u64_stats_update_begin(&ring->stats.syncp);
 		ring->stats.dropped += total_packets;
-		ring->stats.ts_lost += ts_lost;
+		ring->stats.twq.ts_lost += ts_lost;
 		u64_stats_update_end(&ring->stats.syncp);
 
 		netdev_tx_completed_queue(txq, total_packets, total_bytes);
@@ -507,7 +507,7 @@ static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 
 	skb_tstamp_tx(skb, &hwtstamp);
 	u64_stats_update_begin(&ring->stats.syncp);
-	ring->stats.ts_packets++;
+	ring->stats.twq.ts_packets++;
 	u64_stats_update_end(&ring->stats.syncp);
 }
 
@@ -1065,8 +1065,10 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	fbn->tx_stats.bytes += stats->bytes;
 	fbn->tx_stats.packets += stats->packets;
 	fbn->tx_stats.dropped += stats->dropped;
-	fbn->tx_stats.ts_lost += stats->ts_lost;
-	fbn->tx_stats.ts_packets += stats->ts_packets;
+	fbn->tx_stats.twq.ts_lost += stats->twq.ts_lost;
+	fbn->tx_stats.twq.ts_packets += stats->twq.ts_packets;
+	/* Remember to add new stats here */
+	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 2);
 }
 
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
-- 
2.48.1


