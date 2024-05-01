Return-Path: <netdev+bounces-92859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BE8B9259
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDC81C21410
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610B16C684;
	Wed,  1 May 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+l9BZCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623416ABCE
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605972; cv=none; b=rR+iGphKvpKgYygQXsfdlWSLXQH3RjBVuHTSnSsjE2DijgJSo3U/G1tybW1B1xXqLG1+zmrr3qDwlFxquAc79auY0umHGVQ4d5M4kQTFxNf9NtmF9A4chlHK8QchLOYYCabikWxNTkh+h8d4Ddc/qEIS0XUNDjG4laZJu4Dcsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605972; c=relaxed/simple;
	bh=X9Zc8NXIFIstzXRVqTVsQiZQZAU23Z1+OY0PhoNWBcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5+7FJuPi0x5eYue3xlnoEgx7fuE8T+jyZwh9BQGUL+3U4nME8TdDl7JVGCcWefEiEggN26NrkGSYU5ZX6rXsJ2Mq1qZ5oiA9Lus1ZWCrxoRWZkvESFUSJ5PBScc4eJsY2VNkbTCAabQaqgGwLmviloYhNvilUTGOv/nKf2xo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+l9BZCh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be26af113so54552937b3.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605970; x=1715210770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oG58J/JR5E42dJlgQeWSVgudbHg6jj2MpjFcGUtw42k=;
        b=K+l9BZChT1F7NKI7m1aZAQElEHtbZFxWJTyqhaNLsWtWa9XlW/KPSmUgpcpOc4ISWL
         39V+2f9UkCKFt3+0oV9w2zNFL6l1ptWs/53LjLMWbfEb7aaoMWlrXieIH97VuPrM6NCa
         o5tpYVFB1oH3vm9W6ZBR4OuNTyxKz19nbsHESBZdweGg1KiSB5H2EiKUjF+9mPdXdo2W
         vMD6PXKtfXoD9h1cHsWBhxKysbJsm+WwzvFJVoPyDDfjAe6YIFQE5a3RWFFMY7TsWAB5
         IYyEKEAvTIMQKlbjRllC2tl8b5r/NCBvTvfxXdHIfk6OFGcAG1ccOcV3Rssd+zlmdPli
         6MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605970; x=1715210770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG58J/JR5E42dJlgQeWSVgudbHg6jj2MpjFcGUtw42k=;
        b=cskZbUgwFwCZ/DI+PGUipLWGlTe4nAzYX2D817er+FQIyK1X2LfwRDFaNQ4afubjWW
         c+kP1hCPJHIsT1H10l+HOWlYDox1VCcjUc2AU5GhxqmdbizsU6fRwYa6c/PrS43FOyvq
         tbFtVYdcd/7IAd4EfiiyxETBfiiy8od+Mk3BZFqpT87TmIw4h/JdRllVtO0tnfFqUaOF
         4iKZRb/cs9zU3r8iNlh8iS1Dy3dqwizEnnCEvJ9tjm616EKlZuSY6Pl2Ghp4oVPAirv9
         Le3T0gqxmvKLG4AgSS/EJK9iAzQjpAxdWaMLWemDiwpyI2VlaI35czrp7huK52Qqh8YF
         tGtg==
X-Gm-Message-State: AOJu0Yyw02ELRa68OpFgI+orHuFJ0Lw/UOzpilq8wg1iYkk/ujZcAFR2
	eCtWpLg2YYillmUWXHC5Vrjto5IyGOXie+6JWAPIiUZcuYDHnnFw77XGzWarB+tb7pr2T+5wess
	m9rsjzaSPUTndGdmXS1wtL09gW/JeK1w6sz7JFZQ/MCGr+QhqyIM2UBxYwY2S95sfMaup7PXFId
	WPzBPEJHMc3miYTNzRXMTcMiUtlk02f0NW8PiPinFg1qg=
X-Google-Smtp-Source: AGHT+IHnYRyjDpf0Flv90jnccc4t4xpkRWkZlyG4eE0Qu+j1tCm+MDTmRYeSjygC2wmNpX5t9gJ/nQDk5tCkrw==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a81:49d3:0:b0:61b:ea5c:9cf5 with SMTP id
 w202-20020a8149d3000000b0061bea5c9cf5mr931491ywa.7.1714605970343; Wed, 01 May
 2024 16:26:10 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:47 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-9-shailend@google.com>
Subject: [PATCH net-next v2 08/10] gve: Account for stopped queues when
 reading NIC stats
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

We now account for the fact that the NIC might send us stats for a
subset of queues. Without this change, gve_get_ethtool_stats might make
an invalid access on the priv->stats_report->stats array.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index bd7632eed776..a606670a9a39 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -8,6 +8,7 @@
 #include "gve.h"
 #include "gve_adminq.h"
 #include "gve_dqo.h"
+#include "gve_utils.h"
 
 static void gve_get_drvinfo(struct net_device *netdev,
 			    struct ethtool_drvinfo *info)
@@ -165,6 +166,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
 	int *tx_qid_to_stats_idx;
+	int num_stopped_rxqs = 0;
+	int num_stopped_txqs = 0;
 	struct gve_priv *priv;
 	bool skip_nic_stats;
 	unsigned int start;
@@ -181,12 +184,23 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					    sizeof(int), GFP_KERNEL);
 	if (!rx_qid_to_stats_idx)
 		return;
+	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
+		rx_qid_to_stats_idx[ring] = -1;
+		if (!gve_rx_was_added_to_block(priv, ring))
+			num_stopped_rxqs++;
+	}
 	tx_qid_to_stats_idx = kmalloc_array(num_tx_queues,
 					    sizeof(int), GFP_KERNEL);
 	if (!tx_qid_to_stats_idx) {
 		kfree(rx_qid_to_stats_idx);
 		return;
 	}
+	for (ring = 0; ring < num_tx_queues; ring++) {
+		tx_qid_to_stats_idx[ring] = -1;
+		if (!gve_tx_was_added_to_block(priv, ring))
+			num_stopped_txqs++;
+	}
+
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
@@ -260,7 +274,13 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	/* For rx cross-reporting stats, start from nic rx stats in report */
 	base_stats_idx = GVE_TX_STATS_REPORT_NUM * num_tx_queues +
 		GVE_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues;
-	max_stats_idx = NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
+	/* The boundary between driver stats and NIC stats shifts if there are
+	 * stopped queues.
+	 */
+	base_stats_idx += NIC_RX_STATS_REPORT_NUM * num_stopped_rxqs +
+		NIC_TX_STATS_REPORT_NUM * num_stopped_txqs;
+	max_stats_idx = NIC_RX_STATS_REPORT_NUM *
+		(priv->rx_cfg.num_queues - num_stopped_rxqs) +
 		base_stats_idx;
 	/* Preprocess the stats report for rx, map queue id to start index */
 	skip_nic_stats = false;
@@ -274,6 +294,10 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			skip_nic_stats = true;
 			break;
 		}
+		if (queue_id < 0 || queue_id >= priv->rx_cfg.num_queues) {
+			net_err_ratelimited("Invalid rxq id in NIC stats\n");
+			continue;
+		}
 		rx_qid_to_stats_idx[queue_id] = stats_idx;
 	}
 	/* walk RX rings */
@@ -308,11 +332,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
 			/* stats from NIC */
-			if (skip_nic_stats) {
+			stats_idx = rx_qid_to_stats_idx[ring];
+			if (skip_nic_stats || stats_idx < 0) {
 				/* skip NIC rx stats */
 				i += NIC_RX_STATS_REPORT_NUM;
 			} else {
-				stats_idx = rx_qid_to_stats_idx[ring];
 				for (j = 0; j < NIC_RX_STATS_REPORT_NUM; j++) {
 					u64 value =
 						be64_to_cpu(report_stats[stats_idx + j].value);
@@ -338,7 +362,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 
 	/* For tx cross-reporting stats, start from nic tx stats in report */
 	base_stats_idx = max_stats_idx;
-	max_stats_idx = NIC_TX_STATS_REPORT_NUM * num_tx_queues +
+	max_stats_idx = NIC_TX_STATS_REPORT_NUM *
+		(num_tx_queues - num_stopped_txqs) +
 		max_stats_idx;
 	/* Preprocess the stats report for tx, map queue id to start index */
 	skip_nic_stats = false;
@@ -352,6 +377,10 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			skip_nic_stats = true;
 			break;
 		}
+		if (queue_id < 0 || queue_id >= num_tx_queues) {
+			net_err_ratelimited("Invalid txq id in NIC stats\n");
+			continue;
+		}
 		tx_qid_to_stats_idx[queue_id] = stats_idx;
 	}
 	/* walk TX rings */
@@ -383,11 +412,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = gve_tx_load_event_counter(priv, tx);
 			data[i++] = tx->dma_mapping_error;
 			/* stats from NIC */
-			if (skip_nic_stats) {
+			stats_idx = tx_qid_to_stats_idx[ring];
+			if (skip_nic_stats || stats_idx < 0) {
 				/* skip NIC tx stats */
 				i += NIC_TX_STATS_REPORT_NUM;
 			} else {
-				stats_idx = tx_qid_to_stats_idx[ring];
 				for (j = 0; j < NIC_TX_STATS_REPORT_NUM; j++) {
 					u64 value =
 						be64_to_cpu(report_stats[stats_idx + j].value);
-- 
2.45.0.rc0.197.gbae5840b3b-goog


