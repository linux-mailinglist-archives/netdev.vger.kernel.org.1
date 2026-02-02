Return-Path: <netdev+bounces-255996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC11Oyr+gGk6DgMAu9opvQ
	(envelope-from <netdev+bounces-255996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0C8D09AE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C112305DA76
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABD3093D2;
	Mon,  2 Feb 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA2/qTmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1C3090CC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061179; cv=none; b=tUEMCcptgpGkzQQX+zn3I/uebZaRf3jFQMfFX7s+BPsmZoh8f/e+uwGesJHsOea4uOXJRbk41mbZxyQseGl3xbXTE2fiAeumGxxr8v6eP9t7UYMQvaUWkhyPX7wSHWC88TbvB/cKKEqOVxjN/dZaKxSjKVSSfd30X0pR4vEQ27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061179; c=relaxed/simple;
	bh=Kj/aQaeo40aHx4bU8TOzNUGtrh5jbNnKO61YTbpPSwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iA5S2UXaSQAUC5MbdhYlqPmlXSrcsjyxIHFZH/VrQ/X2YcQguQnwgjTRLFOj0Cgc1QoT0Xnk6apm/34TcKVnAeEMGn6/8xtq1kqTXikijAgn5n6WQDgcaYTPizc7mMDJZZeqDZEpXTKOPpKS/uGjFZrBj5nJoDfRXGintJ6Fpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA2/qTmU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0bae9acd4so34873985ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061177; x=1770665977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ5kxBUBFp+SLAVCVX+2wUd953i/3Otxj9GkhrTs9Bw=;
        b=XA2/qTmU7nVWYiQxyV4J2XHl2Wxg0YQZsAdtyi47PssOYpvK1M/MRb0jkl3VKI+Pcq
         IQlep8JEX+C6Sb7P5EuEx+O1ABeEIp2SAG+BZtb25EySku2SJDdUyJlwRj6OKnV2ir0+
         JFJPZFA0OfyRxxOqNkpt2bu3Q/tHA5QqCDpqlnjPYQ5/5kBbc5UK6cSQR4mfQQu4OYLM
         K0Pl94DDsqFs3C1+AdAsZavQqYCHpNqkla0vyqSZdH3nPyzmhNZM1Uwx6mT+Ii0tqFi1
         bX0rjyPQfQsUgyxAEvWWV/1HMfvBQ2JXx35DQIZyspX1diOx8GlzC8QFn2peQyVwF3nA
         gxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061177; x=1770665977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ5kxBUBFp+SLAVCVX+2wUd953i/3Otxj9GkhrTs9Bw=;
        b=GVFTxJkcUxtyjps7sy84TDFf23WHkzcNdaw7k+mwtYfmvnhmGWicjQEIRtZdK9kc/e
         DFEM+QineL0QnyyfVTB2wBgCwBCRoxRiJHO33JkWcgaPgeEKeQK6lWTcQ1guUXi1eeBK
         HvgwGZy8OisXFOyi6a4cWD43eZpiLlQ8A782Cm2DmzSUvEzGncD9Ix3cHBp6w08bp11R
         49zAdLXalDZknnnMBTfJ0lPq/iOxhtF9cpoGK5AMd0a4C9fGH5Jr1fBw+ThEqmLt+77o
         D6zecl4prKgjfqqwQ3nOL46U/NOXoUVzN5HyGquEHnhd+k8ZI9KrR8ph0HEJfB/oXdjr
         KLxw==
X-Gm-Message-State: AOJu0Yw9q+iRbXghEBe31I3+6YvP7/Zh3dlR05yPyeNHW3J/ff370Co3
	c9/eOxuxCb/kUlu4kRYf1I10SIFkjHETLVEI5kWlBeWk5I9Kc9wIgzmjOC5C79hTJciLK8qcyEr
	P/SJvOynppUx0rqGcG9Sdo9h3cw3PusGUvFwK31Pter7Ncl5XN05HPoyHDhbJlC9XlzO+jkNPmN
	G2rhd6IeyCcfDjkiJ3RNIW5L1MMMb9LfCt67FivOwObDXWqWYNr4rzVaHtBK7XkUI=
X-Received: from plqu4.prod.google.com ([2002:a17:902:a604:b0:2a7:cf29:aee1])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef43:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a8d990aaebmr132572965ad.32.1770061176414;
 Mon, 02 Feb 2026 11:39:36 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:24 +0000
In-Reply-To: <20260202193925.3106272-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202193925.3106272-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-2-hramamurthy@google.com>
Subject: [PATCH net 1/2] gve: Fix stats report corruption on queue count change
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Debarghya Kundu <debarghyak@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,vger.kernel.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C0C8D09AE
X-Rspamd-Action: no action

From: Debarghya Kundu <debarghyak@google.com>

The driver and the NIC share a region in memory for stats reporting.
The NIC calculates its offset into this region based on the total size
of the stats region and the size of the NIC's stats.

When the number of queues is changed, the driver's stats region is
resized. If the queue count is increased, the NIC can write past
the end of the allocated stats region, causing memory corruption.
If the queue count is decreased, there is a gap between the driver
and NIC stats, leading to incorrect stats reporting.

This change fixes the issue by allocating stats region with maximum
size, and the offset calculation for NIC stats is changed to match
with the calculation of the NIC.

Cc: stable@vger.kernel.org
Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 54 +++++++++++++++++++++++++---------------
 drivers/net/ethernet/google/gve/gve_main.c    |  4 +--
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 52500ae8..f7864ae7 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -156,7 +156,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
 		tx_dropped;
-	int stats_idx, base_stats_idx, max_stats_idx;
+	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
+	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
 	int *tx_qid_to_stats_idx;
@@ -265,20 +266,38 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->stats_report_trigger_cnt;
 	i = GVE_MAIN_STATS_LEN;
 
-	/* For rx cross-reporting stats, start from nic rx stats in report */
-	base_stats_idx = GVE_TX_STATS_REPORT_NUM * num_tx_queues +
-		GVE_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues;
-	/* The boundary between driver stats and NIC stats shifts if there are
-	 * stopped queues.
-	 */
-	base_stats_idx += NIC_RX_STATS_REPORT_NUM * num_stopped_rxqs +
-		NIC_TX_STATS_REPORT_NUM * num_stopped_txqs;
-	max_stats_idx = NIC_RX_STATS_REPORT_NUM *
-		(priv->rx_cfg.num_queues - num_stopped_rxqs) +
-		base_stats_idx;
+	rx_base_stats_idx = 0;
+	max_rx_stats_idx = 0;
+	max_tx_stats_idx = 0;
+	stats_region_len = priv->stats_report_len -
+				sizeof(struct gve_stats_report);
+	nic_stats_len = (NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
+		NIC_TX_STATS_REPORT_NUM * num_tx_queues) * sizeof(struct stats);
+	if (unlikely((stats_region_len -
+				nic_stats_len) % sizeof(struct stats))) {
+		net_err_ratelimited("Starting index of NIC stats should be multiple of stats size");
+	} else {
+		/* For rx cross-reporting stats,
+		 * start from nic rx stats in report
+		 */
+		rx_base_stats_idx = (stats_region_len - nic_stats_len) /
+							sizeof(struct stats);
+		/* The boundary between driver stats and NIC stats
+		 * shifts if there are stopped queues
+		 */
+		rx_base_stats_idx += NIC_RX_STATS_REPORT_NUM *
+			num_stopped_rxqs + NIC_TX_STATS_REPORT_NUM *
+			num_stopped_txqs;
+		max_rx_stats_idx = NIC_RX_STATS_REPORT_NUM *
+			(priv->rx_cfg.num_queues - num_stopped_rxqs) +
+			rx_base_stats_idx;
+		max_tx_stats_idx = NIC_TX_STATS_REPORT_NUM *
+			(num_tx_queues - num_stopped_txqs) +
+			max_rx_stats_idx;
+	}
 	/* Preprocess the stats report for rx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	for (stats_idx = rx_base_stats_idx; stats_idx < max_rx_stats_idx;
 		stats_idx += NIC_RX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
@@ -354,14 +373,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
 	}
 
-	/* For tx cross-reporting stats, start from nic tx stats in report */
-	base_stats_idx = max_stats_idx;
-	max_stats_idx = NIC_TX_STATS_REPORT_NUM *
-		(num_tx_queues - num_stopped_txqs) +
-		max_stats_idx;
-	/* Preprocess the stats report for tx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	/* NIC TX stats start right after NIC RX stats */
+	for (stats_idx = max_rx_stats_idx; stats_idx < max_tx_stats_idx;
 		stats_idx += NIC_TX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a7a088a7..5a747603 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -283,9 +283,9 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	int tx_stats_num, rx_stats_num;
 
 	tx_stats_num = (GVE_TX_STATS_REPORT_NUM + NIC_TX_STATS_REPORT_NUM) *
-		       gve_num_tx_queues(priv);
+				priv->tx_cfg.max_queues;
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
-		       priv->rx_cfg.num_queues;
+				priv->rx_cfg.max_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
 					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
-- 
2.53.0.rc1.225.gd81095ad13-goog


