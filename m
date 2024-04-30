Return-Path: <netdev+bounces-92644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D878F8B82F2
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7267F2834AC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D501C2314;
	Tue, 30 Apr 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+ZcGwZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A401C230A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518889; cv=none; b=rMKxBxY6yW+/JARoGssAGGj9/ekbYxx31Ja5znjlyzI8uDEb7w99CAm7pg1mqQZovZERCVL8r/UdAVq7zXMPn31iRXhbDaNWVA7+shyXZZXvByn54O+0Xa03WvwlNuSdBFC1djo3ft2flM0KspSeN6q+ucUQ8dff6Wjt1v21dMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518889; c=relaxed/simple;
	bh=X9Zc8NXIFIstzXRVqTVsQiZQZAU23Z1+OY0PhoNWBcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tf/b0MGxr2IsCZvghNH9C3pKWm25jTiwLGuTLIpDqza/dvt4T/8wBXK2UHhTEaYWNU5Iq1JLcLTJcUbDAv80h4gfHA8pKJ4q3WAeLqJwsl9ymIrb1NnLxCzPALQCoSXJPEZlEbi04KHdYQxOQGjv9J6bIUFZ17BnazHq2RVKA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+ZcGwZ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso13017733276.3
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518887; x=1715123687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oG58J/JR5E42dJlgQeWSVgudbHg6jj2MpjFcGUtw42k=;
        b=z+ZcGwZ+kxdBVfscC80ssF1z+TBAW0AWuOx8YKIuftICuTibdHi+EsQ7FePg7LkbDo
         n9ekhMtaaGaGb+xYvc1zQnGaL+ceeGRkHzzWKgbLg4HnI/SDwtsh+1VB5yzvHiTBgJJN
         fu7iyMGGe8WCDSFRXeZW+HnnUuto/Ms8WsXUeRoz51sFYcZ3kl4E0E03acdDL2TBTbXq
         ax00/bVtWe/XwNQ2b95vTS2J0ft/CkV9Y4c6qBgl3Hm2M60Ax4eEkjm8Vdm53GBcxzDc
         a9okm9s2ZtdpKrbfwHUel5XmEEBMRQvE2oCYbzMu+NHoYkrMjDm1ARU6kMydEU1BZHSz
         pLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518887; x=1715123687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG58J/JR5E42dJlgQeWSVgudbHg6jj2MpjFcGUtw42k=;
        b=fAToe5nEmvLN+vzsGKumxGtxKa6h4x4ZUOdDvg5CwiBeomGEsb5TdCQM/wYIGYNbIw
         4N4UAljsnsUDFU2XzVm/Px78wTl2s0EYYtXzjGb9MUR7CBZmCh2IRsDyP58qSDq4l2pK
         yOcRmIpSx9FvnvwyBz0419N/R21GXcGNbKWZZsGcC/5TfkvY0ebVdwyYUaQcGVPrvIeg
         jCkjCrQ9050T1t2Ul+YrV+eoR8Ot4obG1j8Lw+YogEnJzafq6embO++2tY6/00K2p/+4
         3a9gf50GTrbggXFbIo3YDrcpmzEqVeQHle64mKfY6ZL3wunkEPpmSJ6xQcUFA61SCVD8
         fE9A==
X-Gm-Message-State: AOJu0Yx/dLDXJCESBR7h7Hwwb52uSTATq+AlMBOCUNUS6ksM8mBoNzFf
	GxXh/HvlomIEv7PVZsUQpmGDzd3oSN+v94WN+2fFI1VamemERMelcShAKNAbCgDpvm6Wn+Baeub
	guPcgaN8q/i0XHhgJnHD2+rmlHtiLkSIOeHTMWDL/ZItk7ZSG7OoWNRjTy6ddrRPFs6BlfobBiJ
	zIqOrUc+CcFTEt+tEe3ZsLIjRMHaDPo5swxC3LQn+jqo0=
X-Google-Smtp-Source: AGHT+IHvBijwzx8AgGC/MW/jWvFA5wterxT9UV6CQebNmAzqY3F9+ao0ucNGTgMi/lcnjLRfHST6s4VQAAhJ/w==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:b512:0:b0:de4:7be7:1c2d with SMTP id
 p18-20020a25b512000000b00de47be71c2dmr283787ybj.11.1714518886711; Tue, 30 Apr
 2024 16:14:46 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:17 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-9-shailend@google.com>
Subject: [PATCH net-next 08/10] gve: Account for stopped queues when reading
 NIC stats
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
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


