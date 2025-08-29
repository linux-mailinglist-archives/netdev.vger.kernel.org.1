Return-Path: <netdev+bounces-218078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38923B3B065
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8953D1C83F73
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71478215F7D;
	Fri, 29 Aug 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpxnvPvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97A2147F9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430597; cv=none; b=dAKPAqPO35oebHgJIbKR3SvmLncPAYuL+8PonZZNO4RJShHHVr4bmrgYxmwiD2jmKf/5pdZyhkTrdk0QfcSzzUvmVg5UQnz2wtpyWj/iaiOIgYEdSuNudsMVTKLu3712M8L1RQrWtber67Vj87LwlFuZdpM+TQm5cAPJ2bIbyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430597; c=relaxed/simple;
	bh=uScYteY3Zpk5HiegczHeMM6HS/wy8g6Ky340cF/mfpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed6Mp8z2SA9XG1g7D7LXjdUpgvaL68tR/cWPd7OOPV5Yy21LHlWqPdLVbS/7HZnDnG0KTas5cnlECdbt6DsoOER3gwmrE1h+AAwvFt1HBQAtdooEP6OfFsHkDskGcBZmWbRPxoD2jc2LIUP6LsSVZgYgs5X6VssrrAhleMdTOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpxnvPvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F234C4CEED;
	Fri, 29 Aug 2025 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430597;
	bh=uScYteY3Zpk5HiegczHeMM6HS/wy8g6Ky340cF/mfpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpxnvPvtRRrRF8u6K0H6F+iEFOB4tnENGOBctGyyLPjLq4lBRT5zKZi/DNuqO40lJ
	 pEZoAX6R9PHzt6223fmgTdBJIQNtCIPESy1+qpig01URtND9Js6X2mIfmHySTXXfM+
	 MX/4kBostylXUHzP6HyHwVC02Vbs1lyPvudwWwd71dypRHHF/rD2B++3BDVliwT069
	 LaQ6J5CEQzfxQRjActU+tBFNSznHdeUweQ8Gbcxg4Fzwe9JlsDac3zJG41IGW2Exuz
	 JMhTrrP2DEEPBWTQTXDsKo5FW8PmbwZrx2HIOU+eXxDKt117N7ykOlVUNio/BOCTRT
	 gYmiEai1OlpNA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/14] eth: fbnic: split fbnic_flush()
Date: Thu, 28 Aug 2025 18:22:57 -0700
Message-ID: <20250829012304.4146195-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out handling a single nv from fbnic_flush() to make
it reusable for queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 87 ++++++++++----------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7d6bf35acfd4..8384e73b4492 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2297,52 +2297,55 @@ int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
 	return err;
 }
 
+static void fbnic_nv_flush(struct fbnic_napi_vector *nv)
+{
+	int j, t;
+
+	/* Flush any processed Tx Queue Triads and drop the rest */
+	for (t = 0; t < nv->txt_count; t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+		struct netdev_queue *tx_queue;
+
+		/* Clean the work queues of unprocessed work */
+		fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+		fbnic_clean_twq1(nv, false, &qt->sub1, true,
+				 qt->sub1.tail);
+
+		/* Reset completion queue descriptor ring */
+		memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+		/* Nothing else to do if Tx queue is disabled */
+		if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
+			continue;
+
+		/* Reset BQL associated with Tx queue */
+		tx_queue = netdev_get_tx_queue(nv->napi.dev,
+					       qt->sub0.q_idx);
+		netdev_tx_reset_queue(tx_queue);
+	}
+
+	/* Flush any processed Rx Queue Triads and drop the rest */
+	for (j = 0; j < nv->rxt_count; j++, t++) {
+		struct fbnic_q_triad *qt = &nv->qt[t];
+
+		/* Clean the work queues of unprocessed work */
+		fbnic_clean_bdq(&qt->sub0, qt->sub0.tail, 0);
+		fbnic_clean_bdq(&qt->sub1, qt->sub1.tail, 0);
+
+		/* Reset completion queue descriptor ring */
+		memset(qt->cmpl.desc, 0, qt->cmpl.size);
+
+		fbnic_put_pkt_buff(qt, qt->cmpl.pkt, 0);
+		memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
+	}
+}
+
 void fbnic_flush(struct fbnic_net *fbn)
 {
 	int i;
 
-	for (i = 0; i < fbn->num_napi; i++) {
-		struct fbnic_napi_vector *nv = fbn->napi[i];
-		int j, t;
-
-		/* Flush any processed Tx Queue Triads and drop the rest */
-		for (t = 0; t < nv->txt_count; t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-			struct netdev_queue *tx_queue;
-
-			/* Clean the work queues of unprocessed work */
-			fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
-			fbnic_clean_twq1(nv, false, &qt->sub1, true,
-					 qt->sub1.tail);
-
-			/* Reset completion queue descriptor ring */
-			memset(qt->cmpl.desc, 0, qt->cmpl.size);
-
-			/* Nothing else to do if Tx queue is disabled */
-			if (qt->sub0.flags & FBNIC_RING_F_DISABLED)
-				continue;
-
-			/* Reset BQL associated with Tx queue */
-			tx_queue = netdev_get_tx_queue(nv->napi.dev,
-						       qt->sub0.q_idx);
-			netdev_tx_reset_queue(tx_queue);
-		}
-
-		/* Flush any processed Rx Queue Triads and drop the rest */
-		for (j = 0; j < nv->rxt_count; j++, t++) {
-			struct fbnic_q_triad *qt = &nv->qt[t];
-
-			/* Clean the work queues of unprocessed work */
-			fbnic_clean_bdq(&qt->sub0, qt->sub0.tail, 0);
-			fbnic_clean_bdq(&qt->sub1, qt->sub1.tail, 0);
-
-			/* Reset completion queue descriptor ring */
-			memset(qt->cmpl.desc, 0, qt->cmpl.size);
-
-			fbnic_put_pkt_buff(qt, qt->cmpl.pkt, 0);
-			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
-		}
-	}
+	for (i = 0; i < fbn->num_napi; i++)
+		fbnic_nv_flush(fbn->napi[i]);
 }
 
 void fbnic_fill(struct fbnic_net *fbn)
-- 
2.51.0


