Return-Path: <netdev+bounces-209378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF3FB0F690
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B7A54208D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC312FEE21;
	Wed, 23 Jul 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKWk8+Bu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428030112D
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282874; cv=none; b=TSSoa5GyC0p5i/B6Ba0QssZLrzzSasL0r6LaZqRYkigUoh75rtYjV6epkfN3zt8jbsK3scLDq+egEc/+KcV1qrWY9k1Box6B/QHYCYhH/k8Cq8sJSF+b7hzMWVCNsN+ECyXFSZuzY2+2UykLVzjMI3/ARsdjWUgEviKcyq/3qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282874; c=relaxed/simple;
	bh=hMoCdpB0QvY8auQmGCejVon6A8l0SmzwU4sDLTgBotg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohaxxsc52P6CjQHrNUiLukL42Kr35uIm3TuBusUNeHIsKZRrYxXkxNr9p/cAEm7I2OCAWFRXH8zP7FjG7MFxRAoAdlov63bQylRELxN6+tUJcgiGX1RheFUF5fiTXX4QYzrRHm6DyfI5yo1NHxgwHBRhglemtIFSrB9ICqPGcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKWk8+Bu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454f428038eso58987235e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282816; x=1753887616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H87x1yI2D9he9f/zASq5nMr3VZ9GjQ/jUgoxFLC8hKk=;
        b=WKWk8+BulkVI4uJM1Yt8MUCN1A5yrpHy3RdR1A4KpLver8y4UHKdeFOmNqBlOwcn2Z
         bVK2IFh3Kmv+3wrcpfhqmOK5kX/FxxhXzag4TfCl395u39iWtKBzKiTZSzb6wZ35RMYb
         d9oVRwO0nAK57+64BjTQvnowd2j+UKSh9+H6W9zCE6vYXwsEvn7OYZ3nPdHbF4NqPWak
         B9/cgzfxCeNTglM8A+j6/Nn3ZwEoXw5MN6tbtM5+WM+8aIZ9xHHiwTBBjBEg4iDLsjo1
         lbws0sjf6TGB7uR2DdFHHdbHtsDK13bVJ4EsK7+JrYKvcfsIjgClQ6vqtkTYPbVFsfor
         iKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282816; x=1753887616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H87x1yI2D9he9f/zASq5nMr3VZ9GjQ/jUgoxFLC8hKk=;
        b=W/9HlbXdmx4AS7U8N688hRgyLzwigDxAvvKb3FpS1RyBhuaqOpyTMNJ6lSPV9m2dvg
         SsNoS//lhhFYdU40tqpiTMJylc+l/JyRxheeioNPF4h49tdOEid8evZ8GW3FPuZBXI32
         F1HJxbijvtlu/uxxdPxDjVgtVTLY6RiQ7RUZYm9CQiCZPT65FXZri1cdQpMrXFpsB0t5
         SPW4UsZKGWS/L1kXe0rPwltwEbJ31cdQuitqptvkiPG0MoaKPYnJqqADcacus2WsZMdq
         QUmVIMYxVO7rmJOTbWBXffyhdL7YNOpvvm27gwpRwODDgcmdhJwP4S8lFN9VAdv8FNiF
         ALRw==
X-Gm-Message-State: AOJu0YwKO3n0q6t+nKtuJND3vrp0bYhXpOysip750D5Siapt+41o8hAq
	iZPPstsJSgd8mgC8k/+uirUs00bhNHC/ukHtWpxNdU4xshG+wTT58uA4ZCVq/7cC
X-Gm-Gg: ASbGncskrL7A6PtLI2H2oILjF/5fXJEpXEBZ7ryAvwfi+3HifU2uGoKN1d8ZdBSBcE0
	yWyWAALgdAunmd+X6wIkapkbeM1zObKOisOJ10P0/grV3sLDjuA/2hCzgfcsiTDC1V/0vX7bSNK
	JG5ptpTXzwgmK3PmNVpNIasHjSoPZhZEFIvco1ZrLsllYhwC30EeS8PbGK9BcQbhVT+c1aiLF1D
	hRhqejO2a4Ak82mBpOqLt9KJ7Ert58Zr4VdpOqrDCICflMLo6xS+07wzkTy2Ncy0sZo/YAhG35Q
	a4XCyWppw0rJf0rTDJ15NLbCuWhiuKsEsA2JSHYsD+cazzzbAd7K/ovGUcxq0r0Rz2gxcrWKQG1
	1pfeZz/WU/0HYE5/pmtol
X-Google-Smtp-Source: AGHT+IHiFNVhfXPX4fTMIvJcyVVZ3Rosv8fAg5YuK/Yel1BbXQQvjfQG+aAhjR789FaneHB1egqoLQ==
X-Received: by 2002:a05:600c:1e29:b0:456:1752:2b43 with SMTP id 5b1f17b1804b1-45868cfb59bmr25245025e9.21.1753282814204;
        Wed, 23 Jul 2025 08:00:14 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691993d3sm25881255e9.10.2025.07.23.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:13 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 6/9] eth: fbnic: Add support for XDP queues
Date: Wed, 23 Jul 2025 07:59:23 -0700
Message-ID: <20250723145926.4120434-7-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for allocating XDP_TX queues and configuring ring support.
FBNIC has been designed with XDP support in mind. Each Tx queue has 2
submission queues and one completion queue, with the expectation that
one of the submission queues will be used by the stack, and the other
by XDP. XDP queues are populated by XDP_TX and start from index 128
in the TX queue array.
The support for XDP_TX is added in the next patch.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 144 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   7 +
 3 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index bfa79ea910d8..0a6347f28210 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -20,7 +20,7 @@
 struct fbnic_net {
 	struct bpf_prog *xdp_prog;
 
-	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
+	struct fbnic_ring *tx[FBNIC_MAX_TXQS + FBNIC_MAX_XDPQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
 
 	struct fbnic_napi_vector *napi[FBNIC_MAX_NAPI_VECTORS];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 486c14e83ad5..993c0da42f2f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -615,6 +615,42 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	}
 }
 
+static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
+			     struct fbnic_ring *ring, bool discard,
+			     unsigned int hw_head)
+{
+	u64 total_bytes = 0, total_packets = 0;
+	unsigned int head = ring->head;
+
+	while (hw_head != head) {
+		struct page *page;
+		u64 twd;
+
+		if (unlikely(!(ring->desc[head] & FBNIC_TWD_TYPE(AL))))
+			goto next_desc;
+
+		twd = le64_to_cpu(ring->desc[head]);
+		page = ring->tx_buf[head];
+
+		/* TYPE_AL is 2, TYPE_LAST_AL is 3. So this trick gives
+		 * us one increment per packet, with no branches.
+		 */
+		total_packets += FIELD_GET(FBNIC_TWD_TYPE_MASK, twd) -
+				 FBNIC_TWD_TYPE_AL;
+		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
+
+		page_pool_put_page(nv->page_pool, page, -1, pp_allow_direct);
+next_desc:
+		head++;
+		head &= ring->size_mask;
+	}
+
+	if (!total_bytes)
+		return;
+
+	ring->head = head;
+}
+
 static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 			    struct fbnic_ring *ring,
 			    u64 tcd, int *ts_head, int *head0)
@@ -698,12 +734,21 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 }
 
 static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
-			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0)
+			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0,
+			    s32 head1)
 {
 	if (head0 >= 0)
 		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
 	else if (ts_head >= 0)
 		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, ts_head);
+
+	if (head1 >= 0) {
+		qt->cmpl.deferred_head = -1;
+		if (napi_budget)
+			fbnic_clean_twq1(nv, true, &qt->sub1, false, head1);
+		else
+			qt->cmpl.deferred_head = head1;
+	}
 }
 
 static void
@@ -711,6 +756,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 		int napi_budget)
 {
 	struct fbnic_ring *cmpl = &qt->cmpl;
+	s32 head1 = cmpl->deferred_head;
 	s32 head0 = -1, ts_head = -1;
 	__le64 *raw_tcd, done;
 	u32 head = cmpl->head;
@@ -728,7 +774,10 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 
 		switch (FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd)) {
 		case FBNIC_TCD_TYPE_0:
-			if (!(tcd & FBNIC_TCD_TWQ1))
+			if (tcd & FBNIC_TCD_TWQ1)
+				head1 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD1_MASK,
+						  tcd);
+			else
 				head0 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK,
 						  tcd);
 			/* Currently all err status bits are related to
@@ -761,7 +810,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 	}
 
 	/* Unmap and free processed buffers */
-	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0);
+	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0, head1);
 }
 
 static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
@@ -1266,6 +1315,17 @@ static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
 	fbn->tx[txr->q_idx] = NULL;
 }
 
+static void fbnic_remove_xdp_ring(struct fbnic_net *fbn,
+				  struct fbnic_ring *xdpr)
+{
+	if (!(xdpr->flags & FBNIC_RING_F_STATS))
+		return;
+
+	/* Remove pointer to the Tx ring */
+	WARN_ON(fbn->tx[xdpr->q_idx] && fbn->tx[xdpr->q_idx] != xdpr);
+	fbn->tx[xdpr->q_idx] = NULL;
+}
+
 static void fbnic_remove_rx_ring(struct fbnic_net *fbn,
 				 struct fbnic_ring *rxr)
 {
@@ -1287,6 +1347,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 
 	for (i = 0; i < nv->txt_count; i++) {
 		fbnic_remove_tx_ring(fbn, &nv->qt[i].sub0);
+		fbnic_remove_xdp_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_tx_ring(fbn, &nv->qt[i].cmpl);
 	}
 
@@ -1361,6 +1422,7 @@ static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 	ring->doorbell = doorbell;
 	ring->q_idx = q_idx;
 	ring->flags = flags;
+	ring->deferred_head = -1;
 }
 
 static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
@@ -1370,11 +1432,18 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 {
 	int txt_count = txq_count, rxt_count = rxq_count;
 	u32 __iomem *uc_addr = fbd->uc_addr0;
+	int xdp_count = 0, qt_count, err;
 	struct fbnic_napi_vector *nv;
 	struct fbnic_q_triad *qt;
-	int qt_count, err;
 	u32 __iomem *db;
 
+	/* We need to reserve at least one Tx Queue Triad for an XDP ring */
+	if (rxq_count) {
+		xdp_count = 1;
+		if (!txt_count)
+			txt_count = 1;
+	}
+
 	qt_count = txt_count + rxq_count;
 	if (!qt_count)
 		return -EINVAL;
@@ -1423,12 +1492,13 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	qt = nv->qt;
 
 	while (txt_count) {
+		u8 flags = FBNIC_RING_F_CTX | FBNIC_RING_F_STATS;
+
 		/* Configure Tx queue */
 		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TWQ0_TAIL];
 
 		/* Assign Tx queue to netdev if applicable */
 		if (txq_count > 0) {
-			u8 flags = FBNIC_RING_F_CTX | FBNIC_RING_F_STATS;
 
 			fbnic_ring_init(&qt->sub0, db, txq_idx, flags);
 			fbn->tx[txq_idx] = &qt->sub0;
@@ -1438,6 +1508,28 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 					FBNIC_RING_F_DISABLED);
 		}
 
+		/* Configure XDP queue */
+		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TWQ1_TAIL];
+
+		/* Assign XDP queue to netdev if applicable
+		 *
+		 * The setup for this is in itself a bit different.
+		 * 1. We only need one XDP Tx queue per NAPI vector.
+		 * 2. We associate it to the first Rx queue index.
+		 * 3. The hardware side is associated based on the Tx Queue.
+		 * 4. The netdev queue is offset by FBNIC_MAX_TXQs.
+		 */
+		if (xdp_count > 0) {
+			unsigned int xdp_idx = FBNIC_MAX_TXQS + rxq_idx;
+
+			fbnic_ring_init(&qt->sub1, db, xdp_idx, flags);
+			fbn->tx[xdp_idx] = &qt->sub1;
+			xdp_count--;
+		} else {
+			fbnic_ring_init(&qt->sub1, db, 0,
+					FBNIC_RING_F_DISABLED);
+		}
+
 		/* Configure Tx completion queue */
 		db = &uc_addr[FBNIC_QUEUE(txq_idx) + FBNIC_QUEUE_TCQ_HEAD];
 		fbnic_ring_init(&qt->cmpl, db, 0, 0);
@@ -1493,6 +1585,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		qt--;
 
 		fbnic_remove_tx_ring(fbn, &qt->sub0);
+		fbnic_remove_xdp_ring(fbn, &qt->sub1);
 		fbnic_remove_tx_ring(fbn, &qt->cmpl);
 
 		txt_count++;
@@ -1727,6 +1820,10 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	if (err)
 		return err;
 
+	err = fbnic_alloc_tx_ring_resources(fbn, &qt->sub1);
+	if (err)
+		goto free_sub0;
+
 	err = fbnic_alloc_tx_ring_resources(fbn, &qt->cmpl);
 	if (err)
 		goto free_sub1;
@@ -1734,6 +1831,8 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	return 0;
 
 free_sub1:
+	fbnic_free_ring_resources(dev, &qt->sub1);
+free_sub0:
 	fbnic_free_ring_resources(dev, &qt->sub0);
 	return err;
 }
@@ -1921,6 +2020,15 @@ static void fbnic_disable_twq0(struct fbnic_ring *txr)
 	fbnic_ring_wr32(txr, FBNIC_QUEUE_TWQ0_CTL, twq_ctl);
 }
 
+static void fbnic_disable_twq1(struct fbnic_ring *txr)
+{
+	u32 twq_ctl = fbnic_ring_rd32(txr, FBNIC_QUEUE_TWQ1_CTL);
+
+	twq_ctl &= ~FBNIC_QUEUE_TWQ_CTL_ENABLE;
+
+	fbnic_ring_wr32(txr, FBNIC_QUEUE_TWQ1_CTL, twq_ctl);
+}
+
 static void fbnic_disable_tcq(struct fbnic_ring *txr)
 {
 	fbnic_ring_wr32(txr, FBNIC_QUEUE_TCQ_CTL, 0);
@@ -1966,6 +2074,7 @@ void fbnic_disable(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_disable_twq0(&qt->sub0);
+			fbnic_disable_twq1(&qt->sub1);
 			fbnic_disable_tcq(&qt->cmpl);
 		}
 
@@ -2080,6 +2189,8 @@ void fbnic_flush(struct fbnic_net *fbn)
 
 			/* Clean the work queues of unprocessed work */
 			fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+			fbnic_clean_twq1(nv, false, &qt->sub1, true,
+					 qt->sub1.tail);
 
 			/* Reset completion queue descriptor ring */
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
@@ -2154,6 +2265,28 @@ static void fbnic_enable_twq0(struct fbnic_ring *twq)
 	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ0_CTL, FBNIC_QUEUE_TWQ_CTL_ENABLE);
 }
 
+static void fbnic_enable_twq1(struct fbnic_ring *twq)
+{
+	u32 log_size = fls(twq->size_mask);
+
+	if (!twq->size_mask)
+		return;
+
+	/* Reset head/tail */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_CTL, FBNIC_QUEUE_TWQ_CTL_RESET);
+	twq->tail = 0;
+	twq->head = 0;
+
+	/* Store descriptor ring address and size */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_BAL, lower_32_bits(twq->dma));
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_BAH, upper_32_bits(twq->dma));
+
+	/* Write lower 4 bits of log size as 64K ring size is 0 */
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_SIZE, log_size & 0xf);
+
+	fbnic_ring_wr32(twq, FBNIC_QUEUE_TWQ1_CTL, FBNIC_QUEUE_TWQ_CTL_ENABLE);
+}
+
 static void fbnic_enable_tcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *tcq)
 {
@@ -2330,6 +2463,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[t];
 
 			fbnic_enable_twq0(&qt->sub0);
+			fbnic_enable_twq1(&qt->sub1);
 			fbnic_enable_tcq(nv, &qt->cmpl);
 		}
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 0fefd1f00196..b31b450c10fd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -35,6 +35,7 @@ struct fbnic_net;
 
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
+#define FBNIC_MAX_XDPQS			128u
 
 /* These apply to TWQs, TCQ, RCQ */
 #define FBNIC_QUEUE_SIZE_MIN		16u
@@ -120,6 +121,12 @@ struct fbnic_ring {
 
 	u32 head, tail;			/* Head/Tail of ring */
 
+	/* Deferred_head is used to cache the head for TWQ1 if an attempt
+	 * is made to clean TWQ1 with zero napi_budget. We do not use it for
+	 * any other ring.
+	 */
+	s32 deferred_head;
+
 	struct fbnic_queue_stats stats;
 
 	/* Slow path fields follow */
-- 
2.47.1


