Return-Path: <netdev+bounces-172241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF2A50F20
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC381893197
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDEC266F00;
	Wed,  5 Mar 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbhIJ9Va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A5266EE8
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215155; cv=none; b=sMf4vpnzhbaJO/9fUa4OVFKW5GgwhtvpavW7RtSxMv+UnJ+NSfUK8aZg3QAMObwK8Tw22lE4LruDd2pxx5fJN0dPGmCpmuGadknT8Tf79iDt/MPrIod/ei/wc76HuTX7mz26jdlpqL6XQZRKkiSR2Fr9wHoYULN4oH2SXKkp2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215155; c=relaxed/simple;
	bh=7xfdE6ulWRHzqg2UefNkQLPvSQm33yTlOcS3wYTbyYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BonUe+374/z3GpIV7Rx4L86r6ihknX92xBckPatyiAFwBKcHii7ecftjoM3KJqtItvTfTFFLsl5IJlBT9zEICjabrQROTnJ6Ho7283l6F2qk1UlhlYTr09RhFf8taMF1LsxCBIBs2AefzPatEU9yketd1b4cq1nd9ctDvVRFrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbhIJ9Va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999D9C4CEEE;
	Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215153;
	bh=7xfdE6ulWRHzqg2UefNkQLPvSQm33yTlOcS3wYTbyYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbhIJ9VatxUj2krlfBGA5XKxqbSG38IGbke/8zn1aatG3yTXQ5qhxK4H1ngl0Wws+
	 2rpEGQkcpJekGnUPiIIkt8JVCvPw6GWqbeOLnFrAA6F9z/0mrgf4HpVrH4Cqh3NL2z
	 6ETdnpxg/aUZziFPOzGamu9Mld1mkIS13V+eLDhduC2yLRRsGjvJBAxoXYShMxzZ+4
	 uNHh6kvYSGpEXWt/xm7iq158VimlOqclcfLZwKEQF008KMDwBs0UZII3eH6FlQfo+X
	 TAL1Om8WW2lWdGEorcnpTB/OtzXDbR0aM4rnlT5B/eYCMT9+Iq4Fj0D46MZGJubAcq
	 2U0rtZjwh/QdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 04/10] eth: bnxt: snapshot driver stats
Date: Wed,  5 Mar 2025 14:52:09 -0800
Message-ID: <20250305225215.1567043-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305225215.1567043-1-kuba@kernel.org>
References: <20250305225215.1567043-1-kuba@kernel.org>
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
index 4b85f224c344..854e7ec5390b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13093,6 +13093,12 @@ static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
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
@@ -13101,8 +13107,11 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
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
@@ -13127,8 +13136,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 		stats->tx_dropped += BNXT_GET_RING_STATS64(sw, tx_error_pkts);
 
 		stats->rx_dropped +=
-			cpr->sw_stats->rx.rx_netpoll_discards +
-			cpr->sw_stats->rx.rx_oom_discards;
+			sw_stats.rx.rx_netpoll_discards +
+			sw_stats.rx.rx_oom_discards;
 	}
 }
 
@@ -13195,20 +13204,22 @@ static void bnxt_get_one_ring_drv_stats(struct bnxt *bp,
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


