Return-Path: <netdev+bounces-169999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00374A46D17
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B708A3ABCC3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DAC25A34D;
	Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1/+3Ck4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4E25A331
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604220; cv=none; b=meu6CvQfl1LGzBQ8CStJLiiQ6eN02DSbjQZFwr2pt71Fve9idO8UM2WSRGqUxZYGt19D9E7K/tBs4PJMumfW1TScZl3WuZ3Uosmc0Bd7Q35sS2eNMXKuBWTddH8zQx5AIBqTEQhqRzpa+zHXcvHfvKaEmvyKJstULAmOKe8jR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604220; c=relaxed/simple;
	bh=KBmlE1UxZP2DAKyFyT3OiT4SmOQkq2/0xaWU+XxYiIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9xPUBdRf0AVRyh2jXmZRCJPTIhu2DZkN8nKQLp02QJ326vVsMflJjWy4PAmR8HOLq5WZ4ZGeu8hYKbOGsQdmKo7yv9dYN8O3FZLKH0Pyovv3wS468nvzKiEtLFRRjWxFonpNYicBpMNwzwDWRTiT548npithw9a6rT598lHGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1/+3Ck4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2979C4CED6;
	Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604220;
	bh=KBmlE1UxZP2DAKyFyT3OiT4SmOQkq2/0xaWU+XxYiIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1/+3Ck4T5sq+lV7ZukruXMTaN/r9BPgsV/DQ18e87KbpE8+sL0invOE4IFL2Gno0
	 0thtAjYu9K4Qo4eEhET54Lti/VGuGh/zHi7mhUPp1A1oqLas3+MaKqpNM2mIYfm99x
	 HWfZg1ZsInJscMhk4eognvm6Ygh2MjfXEV/B3o7rLYNCi+EtvcqMixJTrU6jYvFYbN
	 coBJPgxTuwsXgTO1gTRlUJK31kQSK0cxe0msO2iAPE5up7YOcjI+fzLvzBNYqVqCQx
	 OBtS2NYFhOBFCvyQWteNuW7SLE1YMEjKozMfVkC4jrOL/MpsOCwC1UrCrJS12Z9w4x
	 y+ghsvKtbuHEA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/9] eth: bnxt: snapshot driver stats
Date: Wed, 26 Feb 2025 13:09:58 -0800
Message-ID: <20250226211003.2790916-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211003.2790916-1-kuba@kernel.org>
References: <20250226211003.2790916-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsequent commits will add datapath stats which need u64_stats
protection. Make current readers work on a snapshot, so it's
easier to extend this code without much duplication.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 29515d6c6cdd..32a2fbc6615b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13092,6 +13092,12 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	return -EOPNOTSUPP;
 }
 
+static void bnxt_drv_stat_snapshot(const struct bnxt_sw_stats *sw_stats,
+				   struct bnxt_sw_stats *snapshot)
+{
+	memcpy(snapshot, sw_stats, sizeof(*snapshot));
+}
+
 static void bnxt_get_ring_stats(struct bnxt *bp,
 				struct rtnl_link_stats64 *stats)
 {
@@ -13100,8 +13106,11 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
+		struct bnxt_sw_stats sw_stats;
 		u64 *sw = cpr->stats.sw_stats;
 
+		bnxt_drv_stat_snapshot(cpr->sw_stats, &sw_stats);
+
 		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_ucast_pkts);
 		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_mcast_pkts);
 		stats->rx_packets += BNXT_GET_RING_STATS64(sw, rx_bcast_pkts);
@@ -13126,8 +13135,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 		stats->tx_dropped += BNXT_GET_RING_STATS64(sw, tx_error_pkts);
 
 		stats->rx_dropped +=
-			cpr->sw_stats->rx.rx_netpoll_discards +
-			cpr->sw_stats->rx.rx_oom_discards;
+			sw_stats.rx.rx_netpoll_discards +
+			sw_stats.rx.rx_oom_discards;
 	}
 }
 
@@ -13194,20 +13203,22 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
 					struct bnxt_total_ring_drv_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
-	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
 	u64 *hw_stats = cpr->stats.sw_stats;
+	struct bnxt_sw_stats sw_stats;
 
-	stats->rx_total_l4_csum_errors += sw_stats->rx.rx_l4_csum_errors;
-	stats->rx_total_resets += sw_stats->rx.rx_resets;
-	stats->rx_total_buf_errors += sw_stats->rx.rx_buf_errors;
-	stats->rx_total_oom_discards += sw_stats->rx.rx_oom_discards;
-	stats->rx_total_netpoll_discards += sw_stats->rx.rx_netpoll_discards;
+	bnxt_drv_stat_snapshot(cpr->sw_stats, &sw_stats);
+
+	stats->rx_total_l4_csum_errors += sw_stats.rx.rx_l4_csum_errors;
+	stats->rx_total_resets += sw_stats.rx.rx_resets;
+	stats->rx_total_buf_errors += sw_stats.rx.rx_buf_errors;
+	stats->rx_total_oom_discards += sw_stats.rx.rx_oom_discards;
+	stats->rx_total_netpoll_discards += sw_stats.rx.rx_netpoll_discards;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
-	stats->tx_total_resets += sw_stats->tx.tx_resets;
+	stats->tx_total_resets += sw_stats.tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
-	stats->total_missed_irqs += sw_stats->cmn.missed_irqs;
+	stats->total_missed_irqs += sw_stats.cmn.missed_irqs;
 }
 
 void bnxt_get_ring_drv_stats(struct bnxt *bp,
-- 
2.48.1


