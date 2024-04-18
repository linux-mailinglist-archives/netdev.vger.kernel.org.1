Return-Path: <netdev+bounces-89405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E88AA38B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352C51C20F77
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F01C65EB;
	Thu, 18 Apr 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXRtoc+y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1D1C65E2
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469953; cv=none; b=AsyUWCqHGZvqzpgywcPaeOX8JawI3w0p1ok5s7/KmPNc6rSPbt96uQa/OHrMRP7i/BahwAIoWZYD+zya5eekd2P8mjXsmuJTuYlPnmtSoWyBde4IXUuenQXDcYrFpk52JAgDesVqwNMXenzlngjPH3TQUs5fty2s65WppC3vgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469953; c=relaxed/simple;
	bh=iVtaO+JCOkLmAStEigUQ6mklcRztbcS4p/hKfGvUJfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MuJP9r8vRmZachQOL/hw92LCTHkJZy8wmB06kWwpgHyz6Gm75VFUKgeC2Iz4PgQ2PtsnWVWlxQgrkTAd+G2adbavPz5oEyNOnr3nFNCgHwm/2mGwqbh/iUcHo40hw4jlzSbDvnDy2/fd57DO86ytCx7jipq8oX49ttdVanPKcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXRtoc+y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso2512535276.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469950; x=1714074750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3R/SsFbpJPup9xdm1UCPCSdiOwdSkTPUhjZ3dGPZ3k=;
        b=QXRtoc+yZfiuT+ndAlWeBzqfY01Jpkt3JGGPD6XmsDsrW3vKPL2DBScQ6+8JqdsLpR
         XjnxzCV8ARU0SaP+RG4safIBjhwlwAFVi8n6AS/73sRkj7XsNzRlpglDd4MbQXnTogrm
         JguSQab7/yBFR9YRsaTglHE3Yat7KWogY7NPoas4X3z+Jvzgs6hwG2gMxfNhvivHrLbT
         q02C64CxduFeT/i7qSqQztD3cLxWFPJ+cK2yLcrQ9e+BGbfEKodgcAoEfSHOvzcy64/z
         jEmYNne1WrnNYglEyo7WNrT0jW2GhPD9MmjMDCjDIR6IZnb1V4CEnMc51FMmoamHYodo
         Ot7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469950; x=1714074750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3R/SsFbpJPup9xdm1UCPCSdiOwdSkTPUhjZ3dGPZ3k=;
        b=EG2UqZD0GmV0pw4IafQXrYL4V3A/YHTlGrFrkmwnXKeElfBTcCpnL5dVIKDwkeurgH
         hUorXsk2d0SAmXm5DskP87+PLdGcaYYcAgemjLmSwgf9Rn4kcYokYusufU5bGdBw6jNq
         qixZVkuWnBUXtithR0kxf2kKN9OIYg/m6kU7J1u9U/da3UbHkvxDA4ucbI8f08P3bjqJ
         zxl+VVeG/4gVCyqN2nuC4ayr3fTxgmFkrSezpFEnm0JePdM+vgU6ybaIj6MkLbBrl7q0
         4wpplbNA/CCPVlJRMC5yf1TmW6r2c/MiYqNQn6Qpeb6sZlMcwXpEIFa91cJmVkapI5CQ
         MnyA==
X-Gm-Message-State: AOJu0YxGEXnh2p2WyhnSXAcP1KRdIs+a9bhMQKrv/ZcOXaftg0d0+mxH
	RAAuWpcW2XL1lQiA2JLQVmIqQjSficjHuChjg5aVrF/41zUq5ozsmd9S7RfGvCkeyETPW2OuJRi
	RvSDTdVymwDMzpVnWdmwnRWcZl1Pk6MXLIOIQeR8tNSsFHcAfzV0IznmooFVuK1a1ox2aVLPFUE
	OviE+0XJgfOiYER8v5PmMwmDHN5a0rth/Byp9m5YzU6aI=
X-Google-Smtp-Source: AGHT+IGLFLVdaqdoVa8ScYzUF/mbxSwIUZeqcm5ZrKmUjlD0KpBa/WzS7qgHH5Q7BavDe7HMBnmIbMtATGPWkg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:2988:b0:de4:7037:69a2 with SMTP
 id ew8-20020a056902298800b00de4703769a2mr152649ybb.5.1713469949973; Thu, 18
 Apr 2024 12:52:29 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:58 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-9-shailend@google.com>
Subject: [RFC PATCH net-next 8/9] gve: Account for stopped queues when reading
 NIC stats
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

We now account for the fact that the NIC might send us stats for a
subset of queues. Without this change, gve_get_ethtool_stats might make
an invalid access on the priv->stats_report->stats array.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 299206d15c73..2a451aba8328 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -181,12 +181,17 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					    sizeof(int), GFP_KERNEL);
 	if (!rx_qid_to_stats_idx)
 		return;
+	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++)
+		rx_qid_to_stats_idx[ring] = -1;
 	tx_qid_to_stats_idx = kmalloc_array(num_tx_queues,
 					    sizeof(int), GFP_KERNEL);
 	if (!tx_qid_to_stats_idx) {
 		kfree(rx_qid_to_stats_idx);
 		return;
 	}
+	for (ring = 0; ring < num_tx_queues; ring++)
+		tx_qid_to_stats_idx[ring] = -1;
+
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
@@ -308,11 +313,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
 			/* stats from NIC */
-			if (skip_nic_stats) {
+			stats_idx = rx_qid_to_stats_idx[ring];
+			if (skip_nic_stats || stats_idx == -1) {
 				/* skip NIC rx stats */
 				i += NIC_RX_STATS_REPORT_NUM;
 			} else {
-				stats_idx = rx_qid_to_stats_idx[ring];
 				for (j = 0; j < NIC_RX_STATS_REPORT_NUM; j++) {
 					u64 value =
 						be64_to_cpu(report_stats[stats_idx + j].value);
@@ -383,11 +388,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = gve_tx_load_event_counter(priv, tx);
 			data[i++] = tx->dma_mapping_error;
 			/* stats from NIC */
-			if (skip_nic_stats) {
+			stats_idx = tx_qid_to_stats_idx[ring];
+			if (skip_nic_stats || stats_idx == -1) {
 				/* skip NIC tx stats */
 				i += NIC_TX_STATS_REPORT_NUM;
 			} else {
-				stats_idx = tx_qid_to_stats_idx[ring];
 				for (j = 0; j < NIC_TX_STATS_REPORT_NUM; j++) {
 					u64 value =
 						be64_to_cpu(report_stats[stats_idx + j].value);
-- 
2.44.0.769.g3c40516874-goog


