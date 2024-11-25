Return-Path: <netdev+bounces-147161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB089D7AC9
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 05:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE73281D9F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 04:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696E13A26D;
	Mon, 25 Nov 2024 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="R/efRj3I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5484A2B
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508683; cv=none; b=oktJ6puhCgaVoOZtxS4r9jQGZWgc46j7aYujNwttypnRoPZ5InRgqztAuT/n2yzUd7C8UwFJAL5XMY/m71ot1ZiXRcPIs9ue6YEeyOoCHmdJUExXlLNPmEOElczqkp0GRichfTJKaFuwWyvX2oM1xt11yYpYeK/kyElr6kQIZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508683; c=relaxed/simple;
	bh=OXLnmwuWl+Cm7g2P3RutT8Ix3kF72EDVRgjT8SxtvHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8cFbW4gCKbW0PIoTnEkM3+vbPs+fKOeGakHRlQdeQiNuh1T5yW33VikJ+FdOQj+OQizzYSV2ISxQlN48uQjsDeAfXe6hlx/gnMTIUPQ1IfLiYvD40mdegxO2zXCqocuaMfrA7sjKWbhLQWfTfLKRdfoxp/FosRTKvNvzYAGcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=R/efRj3I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2127d4140bbso35768895ad.1
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 20:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732508681; x=1733113481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR4pgyxC786CAUfE+ow9DeaMoR/lh2L56YzlXX5yIXE=;
        b=R/efRj3IIouzqN7kxXCFEXx+fx01aX32AMLatVJgneiLfrp7PCdBtrnks7VO+Ym4jW
         U3pxZvVriI1AAAh23EkWnc0pwYarhOP5ZnUtl+MwrRp8LB7ilZveOUUMN+notDRn8WRh
         sLleyjbxDey6mKpegIwEOYR+GD+FoMT8RY4g+DZe2/rNhMKaSanzKa95ppfDNH5eFTUv
         SI4SBZTp0eZNbjxHO7ohT2FDZQw8j5nlV4hcz8TWHRYN8sgCEP90/gVA4dGwwJ1Vab5a
         AStVAhCq0Kf2b18MaqD3MSvrVfgYFtV7tDvmkfLFLRKKdHKNqNYfbEEmzSsfpjN8OVG4
         qjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732508681; x=1733113481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR4pgyxC786CAUfE+ow9DeaMoR/lh2L56YzlXX5yIXE=;
        b=bZ3WBbjyDw+u2gde4D9JMKTbMfip8wtkbh55F0rN7E+fXQb7gK3MQAG0ZY2Ck7ejRE
         ZXhqj9mHVo44TFqEowZDN3v4dmuyN70dbgEnJu1TaA2k7ccS8q+fmVrdpMrzwXU3HnWV
         H8i5eFoNwRq4OTSaI37ZRWDsMxNmJ+n3FCnsGX4q5gH64j8MjAFb8RrfmOhRXdncH/Gu
         qCuyOor3xmm5+LMSRagSi9Pq3GgSwSWlu4QfAl3dnxwWtSZ6Fd478tdaHoqUXsm1zEW0
         nBI5S7fgTYpcqvgq02RaZsLiG0nbJ2TxaHFt80RUrMFdnShcxn6PT6ZC1oDd6rp1aN/Z
         hMzA==
X-Gm-Message-State: AOJu0YwViwZL99S+sADQWkSWeo76UMJd+P6e5Pg6WR6iGn624TuKriG3
	t7BNXvzYkC4EpArqVRl92IFJC6xnRA5EhxenUoqR7uQxgBKHPIqCPLkuwmsjaAg3mwVxB5XGebE
	R
X-Gm-Gg: ASbGncsDMZAT2DDmtL+u2Afh4QzwWaYVhjNNAVxd9P5P5JxsghdSr8bHZ2067GDBLk/
	hlHGTkm4ZuSVDQ/UfSfdyE9WXVIgli1geAaRwX21Dz85zxigcYyXV1VU9yKoyMfen6esU7zquXN
	PDWN8u6nt2X0eQobryK/3E3qN7Gei+139Z6OJMmEIE7JrwlqvtGYzjEiBaYirBym9FDGYOlMX9L
	vgFgdxh5KNy7xWwEe5w2GJhrRUoANB1yTE=
X-Google-Smtp-Source: AGHT+IGB9o7kiKSRq5Z7Zg7bkpjgd4p9elOAst2dg9n2P5I4I372EN0kwsiNx8+C0WIBL8CecQ/mrg==
X-Received: by 2002:a17:903:41d1:b0:212:5035:5b8d with SMTP id d9443c01a7336-2129f233686mr156782675ad.18.1732508681165;
        Sun, 24 Nov 2024 20:24:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:22::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba2691sm54969315ad.68.2024.11.24.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 20:24:40 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v1 3/3] bnxt_en: handle tpa_info in queue API implementation
Date: Sun, 24 Nov 2024 20:24:12 -0800
Message-ID: <20241125042412.2865764-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125042412.2865764-1-dw@davidwei.uk>
References: <20241125042412.2865764-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
page pool for header frags, which may be distinct from the existing pool
for the aggregation ring. Add support for this head_pool in the queue
API.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 294d21cdaeb7..e4b7ff9f6dfa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15378,15 +15378,25 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 			goto err_free_rx_agg_ring;
 	}
 
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = bnxt_alloc_one_tpa_info(bp, clone);
+		if (rc)
+			goto err_free_tpa_info;
+	}
+
 	bnxt_init_one_rx_ring_rxbd(bp, clone);
 	bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
 
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
+	if (bp->flags & BNXT_FLAG_TPA)
+		bnxt_alloc_one_tpa_info_data(bp, clone);
 
 	return 0;
 
+err_free_tpa_info:
+	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
 err_free_rx_ring:
@@ -15394,9 +15404,11 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 err_rxq_info_unreg:
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
-	clone->page_pool->p.napi = NULL;
 	page_pool_destroy(clone->page_pool);
+	if (clone->page_pool != clone->head_pool)
+		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
+	clone->head_pool = NULL;
 	return rc;
 }
 
@@ -15406,13 +15418,15 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ring_struct *ring;
 
-	bnxt_free_one_rx_ring(bp, rxr);
-	bnxt_free_one_rx_agg_ring(bp, rxr);
+	bnxt_free_one_rx_ring_skbs(bp, rxr);
 
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
+	if (rxr->page_pool != rxr->head_pool)
+		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
+	rxr->head_pool = NULL;
 
 	ring = &rxr->rx_ring_struct;
 	bnxt_free_ring(bp, &ring->ring_mem);
@@ -15494,7 +15508,10 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->rx_agg_prod = clone->rx_agg_prod;
 	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
 	rxr->rx_next_cons = clone->rx_next_cons;
+	rxr->rx_tpa = clone->rx_tpa;
+	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
 	rxr->page_pool = clone->page_pool;
+	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
@@ -15545,7 +15562,6 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
-	page_pool_disable_direct_recycling(rxr->page_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.43.5


