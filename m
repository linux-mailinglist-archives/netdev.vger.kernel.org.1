Return-Path: <netdev+bounces-209375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72CB0F68F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B017E245
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03F2FD588;
	Wed, 23 Jul 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0o1qluT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D92FEE07
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282870; cv=none; b=bHCAAxXdgJD6Q6G8+mG06wOn8TGeMEIhtvIfM2cwHt5PzjNvb/BOOc7FwLof4zyQ2VG3GWKdQX5gBc5tH2ISgGbJJXSp+pS+nHBE3BuBWSLAtO+LD2PW8mukZH6w4d3RROPnY06NzlkearQ7vsq5JiopBZscfsqbZuJcAllvwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282870; c=relaxed/simple;
	bh=mDVZZNUPZ2onKztOB/NI+ORUy1tS/U40UZ61OVQkeZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itJKwsk47DDdYSw9uS5vz+FDLPRvDG7DPbwsDplkmx3ZH4HaViEkJYaQn5CH70zWT2OVuyKcYuBlripSRp5QkRcNTC9Wan7Xum5jkcvh1C/hO7xGLQVLLYKRLBo5v+k6cztKJQ2XCRrGmJSr+8hvR7PUl/qfMMfME4AZ5ornap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0o1qluT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so52850115e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282817; x=1753887617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWbmwGQnL2I+3ZuZqxG4DarVc6Rva1TxMgMPKMSMnN8=;
        b=a0o1qluTYBJdmIYr4Q9tmd1Glz73vjUWoohkXfu8KURbq+InB3dMO01b8TU2Frn+y8
         ZGUeThyLWpOL6wS3VBGoh6e+g2Td4YoJWkS2Ms9Yi/rKls+m0n+egfkIobeAL0OpJXpQ
         6IDYDDXcAsBFZ4YSr/GfwxYVijW2au+CslTso4IxDq8inB4z3Thf86WFQsFp60SctEqC
         5Cu3TxeakPvOQ0FSPQ0zlLDmKSERMGf9epR8ixv8bbVIEc2tx4jCCEMvX97dTJa214e1
         mVJ3nStIAp8av3hbzWBbkUA3riFM2xIgnQaLFJ7BddkuaJrEBuywmbGQg+Lt+6i5WL5h
         K7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282817; x=1753887617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWbmwGQnL2I+3ZuZqxG4DarVc6Rva1TxMgMPKMSMnN8=;
        b=rsV1OhV8darK8rWl5uR5m4nr3g2I2YJJBRMAQN7hOTkiGRE98a5vOtx8DCNQ31CmrF
         BHGdWVJPmeXczhHmjOO3y2dq4V4KnoIO7lJEWcfM0eaZNHbODRnDlQLhTMGKRUDmRpo1
         /ibYpCz9Mm40RHJrdhXP88oyxtHTrMjtteRamsuJGiEHpS8udoyDnIULm8C/ZKIzR4Q6
         Rw/eKuDn+AJ8od/Yw/Qr/60oxhsgf+j0XekuAdAako0ygW0AuPNO1vlhtX1ibZ+MR05g
         ZFg16AiMd7JTGNQQ3Ln5Jj+mlWCO3k2JWw7Gevt2VaLmXYgAnzfmiGM3h5IP7pWFYju6
         Pltg==
X-Gm-Message-State: AOJu0Yz0zHNHYV3PP+MDCbWnxrb2gZZF7v62vEPoBfuZHhrzSmiOEbG2
	4BGqKqoV+9uM6T7oUL/U2M+EiMzHLL9Rg1Hf8GK+8qvGZ4GwsVHNBS0ZeGyx9ale
X-Gm-Gg: ASbGnctKKxHKehUolyfrHjLa8FeJxhfMJf6SjCi8jji6d9W4IqoK+v4CZqRrhj5cbiz
	fVj1AkKS/y0BVZPwyk5fJg/fZExv5ud/8aUszeSn/+NDqTdcB5xzszYXfwjY7sn9pwsURfVvLCy
	qsv5g+Pb5YSvs2+BQ6f1h9jtpYqAwINcm8whOOheSNiftEzOgUviBXCk/RPno2U4MG92CO0AbMO
	3AEcqer66Vg2FHnyOH4fWYUbPQY7g8GygmVvlc6k68qyOgE7bzOExuInwzEhsPhJ4zjkzyJmo5L
	23by5qF+f340D3EswAWlN6ZPNb0Bw+IFuB8mYEcS4p3qGLE8YU00Q3aMMUxmKY9fhDF7oniyqbi
	So98Qk8vUda5OSRjF1mPt
X-Google-Smtp-Source: AGHT+IEhSqTFFmB//lSz5YB7rl8SM25Ob5PE3Iuhq7lRZkbQ1bpwo4mbUj12K1dAD626URxwYeOghw==
X-Received: by 2002:a05:600c:8b10:b0:456:1121:3ad8 with SMTP id 5b1f17b1804b1-45868c9d357mr38008655e9.10.1753282816489;
        Wed, 23 Jul 2025 08:00:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487fdsm16555442f8f.48.2025.07.23.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:16 -0700 (PDT)
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
Subject: [PATCH net-next 7/9] eth: fbnic: Add support for XDP_TX action
Date: Wed, 23 Jul 2025 07:59:24 -0700
Message-ID: <20250723145926.4120434-8-mohsin.bashr@gmail.com>
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

Add support for XDP_TX action and cleaning the associated work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 85 +++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 993c0da42f2f..a1656c66a512 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -19,6 +19,7 @@
 enum {
 	FBNIC_XDP_PASS = 0,
 	FBNIC_XDP_CONSUME,
+	FBNIC_XDP_TX,
 	FBNIC_XDP_LEN_ERR,
 };
 
@@ -1024,6 +1025,80 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 	return skb;
 }
 
+static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
+			 struct fbnic_pkt_buff *pkt)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+	int size, offset, nsegs = 1, data_len = 0;
+	unsigned int tail = ring->tail;
+	struct skb_shared_info *shinfo;
+	skb_frag_t *frag = NULL;
+	struct page *page;
+	dma_addr_t dma;
+	__le64 *twd;
+
+	if (unlikely(xdp_buff_has_frags(&pkt->buff))) {
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nsegs += shinfo->nr_frags;
+		data_len = shinfo->xdp_frags_size;
+		frag = &shinfo->frags[0];
+	}
+
+	if (fbnic_desc_unused(ring) < nsegs)
+		return -FBNIC_XDP_CONSUME;
+
+	page = virt_to_page(pkt->buff.data_hard_start);
+	offset = offset_in_page(pkt->buff.data);
+	dma = page_pool_get_dma_addr(page);
+
+	size = pkt->buff.data_end - pkt->buff.data;
+
+	while (nsegs--) {
+		dma_sync_single_range_for_device(nv->dev, dma, offset, size,
+						 DMA_BIDIRECTIONAL);
+		dma += offset;
+
+		ring->tx_buf[tail] = page;
+
+		twd = &ring->desc[tail];
+		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
+				   FIELD_PREP(FBNIC_TWD_LEN_MASK, size) |
+				   FIELD_PREP(FBNIC_TWD_TYPE_MASK,
+					      FBNIC_TWD_TYPE_AL));
+
+		tail++;
+		tail &= ring->size_mask;
+
+		if (!data_len)
+			break;
+
+		offset = skb_frag_off(frag);
+		page = skb_frag_page(frag);
+		dma = page_pool_get_dma_addr(page);
+
+		size = skb_frag_size(frag);
+		data_len -= size;
+		frag++;
+	}
+
+	*twd |= FBNIC_TWD_TYPE(LAST_AL);
+
+	ring->tail = tail;
+
+	return -FBNIC_XDP_TX;
+}
+
+static void fbnic_pkt_commit_tail(struct fbnic_napi_vector *nv,
+				  unsigned int pkt_tail)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+
+	writel(pkt_tail, ring->doorbell);
+}
+
 static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 				     struct fbnic_pkt_buff *pkt)
 {
@@ -1043,6 +1118,8 @@ static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 	case XDP_PASS:
 xdp_pass:
 		return fbnic_build_skb(nv, pkt);
+	case XDP_TX:
+		return ERR_PTR(fbnic_pkt_tx(nv, pkt));
 	default:
 		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
 		fallthrough;
@@ -1107,10 +1184,10 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			   struct fbnic_q_triad *qt, int budget)
 {
 	unsigned int packets = 0, bytes = 0, dropped = 0, alloc_failed = 0;
+	s32 head0 = -1, head1 = -1, pkt_tail = -1;
 	u64 csum_complete = 0, csum_none = 0;
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
-	s32 head0 = -1, head1 = -1;
 	__le64 *raw_rcd, done;
 	u32 head = rcq->head;
 
@@ -1166,6 +1243,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				bytes += skb->len;
 
 				napi_gro_receive(&nv->napi, skb);
+			} else if (PTR_ERR(skb) == -FBNIC_XDP_TX) {
+				pkt_tail = nv->qt[0].sub1.tail;
+				bytes += xdp_get_buff_len(&pkt->buff);
 			} else {
 				if (!skb) {
 					alloc_failed++;
@@ -1201,6 +1281,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	rcq->stats.rx.csum_none += csum_none;
 	u64_stats_update_end(&rcq->stats.syncp);
 
+	if (pkt_tail >= 0)
+		fbnic_pkt_commit_tail(nv, pkt_tail);
+
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
 		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
-- 
2.47.1


