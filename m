Return-Path: <netdev+bounces-257317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH1XAa4UhWkh8QMAu9opvQ
	(envelope-from <netdev+bounces-257317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59905F7F2D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AB6301A39A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE32335064;
	Thu,  5 Feb 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjADsYwo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAAA334C2F;
	Thu,  5 Feb 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329242; cv=none; b=IVlez1ujX0InWEG36+RT4U9SP3yzukHU3zdmy9yeyW4ISlbl1tg6/gAcyEVyw8lxbivaVfRhIao9ccVErWUl4UgqglO5rToFNOSdKpPzyU3JSyiFZ9OYKC/V66ElLl3wJJKddSvNq0JdA/OWKdMTgO3zlHbi0e2/mL8QYAL8+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329242; c=relaxed/simple;
	bh=CyFcFN6XHiw91VE7qdNHv8eoY4AFH5v6FLhjLgjYOSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Apo8eOpX8J52Hvhm1wj6eHCP/0Tgg7vMk/y71lmxmW50cd8NcDIsSJgC13T+DKGc0RxHuC7gQtzfbvErlqCylkQbIkrMFUk/oaDnxuuMXWpx48inoqt88B8pZR2DCpC7YXXH0FMTj7hmMUgO49rkmJAH2s6TfiEB7y5PNSf1FhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjADsYwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690BBC19421;
	Thu,  5 Feb 2026 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329242;
	bh=CyFcFN6XHiw91VE7qdNHv8eoY4AFH5v6FLhjLgjYOSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjADsYwoBAyjUVRHI132AwiDy6Jb/2ls+k9QCSxGriTtS++c+ThfohEivwZRQ7kIz
	 lkKxCG5K7pVkhQaCAB26XI/hydCntB1QLseP4ym7oKg6LO2Hrjyua85nL4u3U6FgGx
	 uezvL5Sv+iwiqKutgrvc55M4ykxK2o9aH6BV13pdrFYG22UK70ZZF9p9C0jVfTBySm
	 7hEq4gSJb397Iqbg9ZOm80AYIWrPFK8tC8Jww+WO7z9XWEe8KTfgjmHTuJq1rfIzSg
	 tpnumlbDfBzJUGa+xy+OigwTi1+s1Pdk+mQmqYrOqveh5yoDTXEHIP4AC3SK6jRxx1
	 jJZEjf50c1Pmg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/9] eth: bnxt: gather and report HW-GRO stats
Date: Thu,  5 Feb 2026 14:05:33 -0800
Message-ID: <20260205220541.2992807-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205220541.2992807-1-kuba@kernel.org>
References: <20260205220541.2992807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257317-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59905F7F2D
X-Rspamd-Action: no action

Count and report HW-GRO stats as seen by the kernel.
The device stats for GRO seem to not reflect the reality,
perhaps they count sessions which did not actually result
in any aggregation. Also they count wire packets, so we
have to count super-frames, anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f036ef60230b..b2efdbdd1356 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1128,6 +1128,8 @@ struct bnxt_rx_sw_stats {
 	u64			rx_buf_errors;
 	u64			rx_oom_discards;
 	u64			rx_netpoll_discards;
+	u64			rx_hw_gro_packets;
+	u64			rx_hw_gro_wire_packets;
 };
 
 struct bnxt_tx_sw_stats {
@@ -1151,6 +1153,8 @@ struct bnxt_total_ring_err_stats {
 	u64			rx_total_oom_discards;
 	u64			rx_total_netpoll_discards;
 	u64			rx_total_ring_discards;
+	u64			rx_total_hw_gro_packets;
+	u64			rx_total_hw_gro_wire_packets;
 	u64			tx_total_resets;
 	u64			tx_total_ring_discards;
 	u64			total_missed_irqs;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 466e0fc6141f..4a4145f138f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1804,7 +1804,8 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 					   struct bnxt_tpa_info *tpa_info,
 					   struct rx_tpa_end_cmp *tpa_end,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
-					   struct sk_buff *skb)
+					   struct sk_buff *skb,
+					   struct bnxt_rx_sw_stats *rx_stats)
 {
 #ifdef CONFIG_INET
 	int payload_off;
@@ -1814,6 +1815,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	if (segs == 1)
 		return skb;
 
+	if (bp->dev->features & NETIF_F_GRO_HW) {
+		rx_stats->rx_hw_gro_packets++;
+		rx_stats->rx_hw_gro_wire_packets += segs;
+	}
+
 	NAPI_GRO_CB(skb)->count = segs;
 	skb_shinfo(skb)->gso_size =
 		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
@@ -1987,7 +1993,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (gro)
-		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb);
+		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb,
+				   &cpr->sw_stats->rx);
 
 	return skb;
 }
@@ -13492,6 +13499,8 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 	stats->rx_total_netpoll_discards += sw_stats->rx.rx_netpoll_discards;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->rx_total_hw_gro_packets += sw_stats->rx.rx_hw_gro_packets;
+	stats->rx_total_hw_gro_wire_packets += sw_stats->rx.rx_hw_gro_wire_packets;
 	stats->tx_total_resets += sw_stats->tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
@@ -15931,6 +15940,8 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
 
 	stats->alloc_fail = cpr->sw_stats->rx.rx_oom_discards;
+	stats->hw_gro_packets = cpr->sw_stats->rx.rx_hw_gro_packets;
+	stats->hw_gro_wire_packets = cpr->sw_stats->rx.rx_hw_gro_wire_packets;
 }
 
 static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
@@ -15966,6 +15977,8 @@ static void bnxt_get_base_stats(struct net_device *dev,
 	rx->packets = bp->net_stats_prev.rx_packets;
 	rx->bytes = bp->net_stats_prev.rx_bytes;
 	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
+	rx->hw_gro_packets = bp->ring_err_stats_prev.rx_total_hw_gro_packets;
+	rx->hw_gro_wire_packets = bp->ring_err_stats_prev.rx_total_hw_gro_wire_packets;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
 	tx->bytes = bp->net_stats_prev.tx_bytes;
-- 
2.53.0


