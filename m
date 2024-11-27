Return-Path: <netdev+bounces-147662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF179DAF47
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B7C28203B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54A204093;
	Wed, 27 Nov 2024 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BqKrdTXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19997204080
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732747145; cv=none; b=K5P+bA3SjWR4bEuZd1sDPhx7fTQwHV5BjBAv7Swa+EGoLamlk4E97nh7pMimEMQTjRx8rqHug/3eXdGx3LFfLMkR692SMxj9CFar+BNbMPkszoPwrfjg3BFF8/Gp0Dj0R078moPr5oapvwJLdru9KqVTroTSbZFgDM5x2+kDXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732747145; c=relaxed/simple;
	bh=mrnLoACOxAEHLwzGhCohiE1xaF4bYxsstg5UAJYIih4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oavXYs3nWssdSqArfXttAP83/JlS3tlREcgQ71AuXHsr1Mx6N9lSvMAYZ23Jdkfc4JlYzmU46risKy2NslgDv0xCC/rLPRFNqneHBfjGakR+mRtjiv4MwNr1/rWVyUJb8GXbmOKG+qLfpf0lC7yeBtTvldE8W2TJ0JklHZtyT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BqKrdTXh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so1783125ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732747143; x=1733351943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7f8m1SooXX5YCEkbC6UVe7KeF8jC2NXt6Q2ZooeG/0=;
        b=BqKrdTXhZgsBjJXSTKnHrRtNcQr5vF/wLqKb07bPRGFmzW84Ibt7bRkk4B/nR8Kq3+
         gLOSNtrYHnAtm1FJAr7DIPnZJnhxF8RBOkjJRNIQd/nWT442Rq8NAEJHRcO8yV7zPH9x
         byeGVZZPGZriKe371wqA54gUzHhZaZRcKCwDcZ6TYGu9aFIpPrreXwkhua89AYOx0BzP
         64UAAxkRR8wOt4MIqgo13XJ69Bq5SF+IDjCwaFv+0F99vbXRVeB/7tE6hsQaM8hLtGqa
         f6Gmy7CDEAxmi2in3usDpkmDwJStQnxNdOCy03fKcK5x0FS+eWScKKDa0GHUpfDvImcp
         yvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732747143; x=1733351943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7f8m1SooXX5YCEkbC6UVe7KeF8jC2NXt6Q2ZooeG/0=;
        b=HoeBihl/OC2KmVOzac74NTgCNRjmP8xTLTwm8vh6SMIgv8/YwXjEAc7arCWECmqARR
         4CpoxSTBjb3gfYa2bXAxOGrWLYWDrtw89XCIJikT2diIfF8HDTG1SsMYRvUwtelv9K2s
         CzaR3SO6gWb6azxkGV7vBvFFXy8fdKaJCcGhvo4lzZa+ybTIF1MNUrDdvi8j/BJ7wlFE
         t3D0JzmTM8ExlK6C3rPLRCUzpQ3/XVXhwqrEQnnjXIPjbJiANE4neF0RqFceXzIm3Itm
         TDoo9rnSvyfZ1WmMd5gg4N5hCbKNuUciHJVb0wfawenDw33/zFQJLK2rdfO20MYUoPMO
         bW8g==
X-Gm-Message-State: AOJu0YyQgFVkEFomx2i9TXZ6GxuRW6XvUgwGISF2u+NOZ5QaOQhs0xuR
	dQhDFQwPbhHj5pgrGcXX/khOg3rCS3XQYMXfi0UVcgjDAe/rijlpmJmwAjAH2Kt1V4rA+sQZukq
	M
X-Gm-Gg: ASbGncuSIpDRQ9B+qaBNUaN2POewdSOklIaYjYCuXL0MwNYpYGSc8PZhJDJ46PsnZQA
	kYrvT0kClo7zWTm9J7nN4HWu8bB5fuCQZczAedwMO053wZPUi3T5y0EmFF4MFTTc1f6AgMWvYiU
	czdyuVlWhY+arwmUj1Ut2Mhk0JKa4YChsgJ6RISxGjVuQP1Amp4tt6qFFYDxSZQ7Ku4h/Fg3RpA
	1oKz9U5WzZQuawFvXd3qtRQTST4WHhpI88=
X-Google-Smtp-Source: AGHT+IFfEmnalpCocnyaXZW/7Mwpz/nOpEfts7zG85BN51p0aA3bBBOJ2vhwHBTQn5UcJ4NYzCf48w==
X-Received: by 2002:a17:902:f54e:b0:211:6b21:5a88 with SMTP id d9443c01a7336-21501099d5dmr46559845ad.20.1732747143410;
        Wed, 27 Nov 2024 14:39:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:18::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c53a7sm604605ad.257.2024.11.27.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:39:02 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API implementation
Date: Wed, 27 Nov 2024 14:38:55 -0800
Message-ID: <20241127223855.3496785-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127223855.3496785-1-dw@davidwei.uk>
References: <20241127223855.3496785-1-dw@davidwei.uk>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9b079bce1423..08c7d3049562 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15382,15 +15382,25 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
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
@@ -15398,9 +15408,11 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
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
 
@@ -15410,13 +15422,15 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
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
@@ -15498,7 +15512,10 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->rx_agg_prod = clone->rx_agg_prod;
 	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
 	rxr->rx_next_cons = clone->rx_next_cons;
+	rxr->rx_tpa = clone->rx_tpa;
+	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
 	rxr->page_pool = clone->page_pool;
+	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
@@ -15557,6 +15574,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
 	page_pool_disable_direct_recycling(rxr->page_pool);
+	if (rxr->page_pool != rxr->head_pool)
+		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.43.5


