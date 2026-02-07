Return-Path: <netdev+bounces-257665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMm1C9OIhmmOOgQAu9opvQ
	(envelope-from <netdev+bounces-257665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA61044EA
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42CD30378AD
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848742153EA;
	Sat,  7 Feb 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJzjC+EI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6119C1FFC48;
	Sat,  7 Feb 2026 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424516; cv=none; b=sk+cWWdS6ugDsMD8VBsIgHxSBxY0sGlNE3Bj+X23af9XhvOnr50Z3ACFccpwcRNnhMZJT8OYC0VSr78ab9BYPSWpQ6Petd07pd5sTv5GMgJEaZgdddWJUgj/NsysTS3OrbCzDIhsxyGPVGz3kI+ShV8k0TJCREa90fSNLdGmfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424516; c=relaxed/simple;
	bh=vqjEwTJ0kd4Z8DCHsPVpUeFzqgsLQubEsf/Kidgojvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoQ2weoYAxuOZNXMLUcTNUlrfkCVkuy4Yhxs/ZT8FDWBNzNCvJO2I3Zi2hMWjgZu58lEnwc2tBNkarrw37j+JU0GhhstJSZe83wIDVwnKM1bK7h7b2Y7qngpEYTGOryj7Ot5KUgi4GcBZ6kM10DAjv0N4Nfq1YuUhdIyiuYAFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJzjC+EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C85C2BC86;
	Sat,  7 Feb 2026 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424516;
	bh=vqjEwTJ0kd4Z8DCHsPVpUeFzqgsLQubEsf/Kidgojvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJzjC+EI3gcj/5Jsu9ZbT5+TVKxafifFhzqzrenEU/TW30jra+Ox/Id3qsIBHJdQQ
	 6IPIW+uEZ9j3/OPBupN7sAoocxHs/I4fZp269sKYQfybpms8bRyHDK33yWxfcI6nTU
	 iOejgymXkvqHHFujEQCgSOKTAYFpVKuVqgAzBAeXc8r9lS5QpJvqEqH2tLACP/SERB
	 zUpEeYZEAOvV32mQdAG0v5ALL6BXoQhBfaKKCKhhVNOUNsoLt9JVUQVRj+P7p4c9Cr
	 H2QzZNTdm9Q07QHoVv4QHuwKznio+hbyCaM34A3Yjq6lu8otWo6xUBfd2Ob8kGpUrW
	 wAe2Nwuzx68PA==
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
Subject: [PATCH net-next v2 1/9] eth: bnxt: gather and report HW-GRO stats
Date: Fri,  6 Feb 2026 16:35:01 -0800
Message-ID: <20260207003509.3927744-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257665-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CDDA61044EA
X-Rspamd-Action: no action

Count and report HW-GRO stats as seen by the kernel.
The device stats for GRO seem to not reflect the reality,
perhaps they count sessions which did not actually result
in any aggregation. Also they count wire packets, so we
have to count super-frames, anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove unnecessary condition for feature check (Michael)
 - move the stats to the end of array to avoid messing up
   ethtool -S output (AI)
v1: https://lore.kernel.org/20260205220541.2992807-2-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  6 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 +++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f036ef60230b..9a41b9e0423c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1126,8 +1126,11 @@ struct bnxt_rx_sw_stats {
 	u64			rx_l4_csum_errors;
 	u64			rx_resets;
 	u64			rx_buf_errors;
+	/* end of ethtool -S stats */
 	u64			rx_oom_discards;
 	u64			rx_netpoll_discards;
+	u64			rx_hw_gro_packets;
+	u64			rx_hw_gro_wire_packets;
 };
 
 struct bnxt_tx_sw_stats {
@@ -1154,6 +1157,9 @@ struct bnxt_total_ring_err_stats {
 	u64			tx_total_resets;
 	u64			tx_total_ring_discards;
 	u64			total_missed_irqs;
+	/* end of ethtool -S stats */
+	u64			rx_total_hw_gro_packets;
+	u64			rx_total_hw_gro_wire_packets;
 };
 
 struct bnxt_stats_mem {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 466e0fc6141f..44c46bac92d9 100644
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
@@ -1814,6 +1815,9 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	if (segs == 1)
 		return skb;
 
+	rx_stats->rx_hw_gro_packets++;
+	rx_stats->rx_hw_gro_wire_packets += segs;
+
 	NAPI_GRO_CB(skb)->count = segs;
 	skb_shinfo(skb)->gso_size =
 		le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);
@@ -1987,7 +1991,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (gro)
-		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb);
+		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb,
+				   &cpr->sw_stats->rx);
 
 	return skb;
 }
@@ -13492,6 +13497,8 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 	stats->rx_total_netpoll_discards += sw_stats->rx.rx_netpoll_discards;
 	stats->rx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->rx_total_hw_gro_packets += sw_stats->rx.rx_hw_gro_packets;
+	stats->rx_total_hw_gro_wire_packets += sw_stats->rx.rx_hw_gro_wire_packets;
 	stats->tx_total_resets += sw_stats->tx.tx_resets;
 	stats->tx_total_ring_discards +=
 		BNXT_GET_RING_STATS64(hw_stats, tx_discard_pkts);
@@ -15931,6 +15938,8 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
 
 	stats->alloc_fail = cpr->sw_stats->rx.rx_oom_discards;
+	stats->hw_gro_packets = cpr->sw_stats->rx.rx_hw_gro_packets;
+	stats->hw_gro_wire_packets = cpr->sw_stats->rx.rx_hw_gro_wire_packets;
 }
 
 static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
@@ -15966,6 +15975,8 @@ static void bnxt_get_base_stats(struct net_device *dev,
 	rx->packets = bp->net_stats_prev.rx_packets;
 	rx->bytes = bp->net_stats_prev.rx_bytes;
 	rx->alloc_fail = bp->ring_err_stats_prev.rx_total_oom_discards;
+	rx->hw_gro_packets = bp->ring_err_stats_prev.rx_total_hw_gro_packets;
+	rx->hw_gro_wire_packets = bp->ring_err_stats_prev.rx_total_hw_gro_wire_packets;
 
 	tx->packets = bp->net_stats_prev.tx_packets;
 	tx->bytes = bp->net_stats_prev.tx_bytes;
-- 
2.53.0


