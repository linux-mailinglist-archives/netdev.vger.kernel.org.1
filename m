Return-Path: <netdev+bounces-92898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D778B93FF
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9573D1C217ED
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F822626;
	Thu,  2 May 2024 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="icSe6gwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCF224D7
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625666; cv=none; b=Fa3M3kMk8HmqOZt722m0hPVNtsymIhvBaeb1FtHmi4Vv8Lt3PEYbjQD8y3FVHTJZyKovmz1mphIk2om/CyaIeYYttRqfqTSvZY5PSfq4UgJCucXsJ+lbxZR+pNaw4wwKVQVvFMrYzNhDwBjUzh8lflaWnUkBK629e6J1lBLqY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625666; c=relaxed/simple;
	bh=S/1yZF1TI+dwRZfaETByTwmVELoDx+n/rqzs9Rcapms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD1fRt/a5/56GSrGy5PGQnkkfq5mow8TrxgxMkICC3sjrX67DvhPwaUC6GSo73AJ78YBBPQ0TJZaJU7hvrBwGM/R/9j9QVArgqbeUJGbCzUy+y18a/NERqzrE9tqz6dB4QdrFOziaVGoM4lH8s2Kn6WA7I9eaXP0d5vlA0LDAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=icSe6gwQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecd9a81966so2968495ad.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625664; x=1715230464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGXdpI60jd3JHXKmbQ4WSfHFellxb6CxbrnH7cNwkdY=;
        b=icSe6gwQ3SJy1GvhB2VX8wvU/dJJnBCRkdmzARcyk/8bdgOWPqpnh+8B/MG9bAzDQn
         lRSm9yg8Svc2dvtcy+SBUtr4kSIonDevv7enBWWuWgcU0+m/ut/+sGCPTCTWfWJ+5BzG
         97makQITL//JiVhRvOuzETTdHOKAEQfnq1xpCtgz1GnVtJhsh7VCwxWO7JszwmgiSxmK
         pOS0heOza8aUKBwciSJhTV9fBrmbQvn5bI6G4p0SdCqCpD1ThNi/ka4nHlAdB1UKO0eo
         YJW0O1+VYiQqiwQdgh+i0hCDUElAoL3NNASH16viPhtZ5Ll91VzG8GyQKSm7TkHVWM9R
         hNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625664; x=1715230464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGXdpI60jd3JHXKmbQ4WSfHFellxb6CxbrnH7cNwkdY=;
        b=PRxpJa+eM6FI6YWNyJJzxW75im++gXzQu/FAPGm9MdYFqfJ7lo4luNZ4CHc3jKlKJA
         2Ct0p6yPaPTaFxBRwsUklF2TKPAs3eEI1N3uH8xc7ntZzTq8xqr+YuDgZxjMG6m9ng1R
         RLrDYgF63peETMk5iy3LhGFORXMiABigr99CJWDlTtrz4qLkHEeJbSk5GiET6/HOk1BD
         yRIUv0uFB8WzYjLUttYGn3E48i6XhAFlhK+VIZB0F1lQGfvB0cCzcsnye/pkUUI+g6pj
         tkpfI1ahKhph1FInKGaOqBzmtH/BRf0LWc38o+yflBwgf6nj6JCf+MIvTOoxcKmi7sXe
         6/7Q==
X-Gm-Message-State: AOJu0YyGBzRSLZWR3pqVhpYiol8l9ZaTejIeUcQqSdQeGQ9Zt7XUKm4d
	SHpp805mVrvllBjwAHijd7q5VLDgZ8fWeaaN5hZl3xkykKoBJI6oOkr0IgKfXlEbDeLyG/lBn1W
	O
X-Google-Smtp-Source: AGHT+IHrFDiYM14G+XgK11d/REEkHO0+n0A7BRJgiMa7hnGzkXf9KGF6StfCQRn2P0N8OPZFkAHCbQ==
X-Received: by 2002:a17:902:f950:b0:1e4:7bf1:521 with SMTP id kx16-20020a170902f95000b001e47bf10521mr1957773plb.19.1714625664008;
        Wed, 01 May 2024 21:54:24 -0700 (PDT)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170902fb4400b001e8d180766dsm237844plb.278.2024.05.01.21.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:23 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next v2 8/9] bnxt: alloc rx ring mem first before reset
Date: Wed,  1 May 2024 21:54:09 -0700
Message-ID: <20240502045410.3524155-9-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502045410.3524155-1-dw@davidwei.uk>
References: <20240502045410.3524155-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement allocating rx ring mem in bnxt_queue_mem_alloc(). This is done
by duplicating the existing rx ring entirely, then allocating new memory
into this clone as most functions take rx ring as an argument.

I've identified the following memory that gets allocated:

* rx_desc_ring
  * separate allocation per hw page
* rx_buf_ring
* rx_agg_desc_ring
* rx_agg_ring
* rx_agg_bmap
* rx_tpa
* rx_tpa_idx_map

So, zero the ring heads, alloc the rings, then call
bnxt_alloc_one_rx_ring() to fills in the descriptors.

It's interesting that struct bnxt_ring_mem_info points to addresses of
stack allocated arrays within struct bnxt_rx_ring_info, instead of the
heap allocated queue memory. __bnxt_init_rx_ring_struct() is first
called to reconfigure these ptrs for the clone.

The hardware is only aware of the pg_tbl, which we do not touch. In the
coming patches after an rx ring has been quiesced, we'll swap the bits
that are dynamically allocated then update the dma mappings in pg_tbl.
Then the hardware is none the wiser!

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 21c1a7cb70ab..d848b9ceabf0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14934,13 +14934,89 @@ static void bnxt_init_rx_ring_rxbd_pages(struct bnxt *bp, struct bnxt_rx_ring_in
 
 static void *bnxt_queue_mem_alloc(struct net_device *dev, int idx)
 {
+	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
+	int rc;
+
+	rxr = &bp->rx_ring[idx];
+	clone = kmemdup(rxr, sizeof(*rxr), GFP_KERNEL);
+	if (!clone)
+		return ERR_PTR(-ENOMEM);
+
+	clone->rx_prod = 0;
+	clone->rx_agg_prod = 0;
+	clone->rx_sw_agg_prod = 0;
+	clone->rx_next_cons = 0;
+
+	__bnxt_init_rx_ring_struct(bp, clone);
+
+	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
+	if (rc)
+		goto err_free_clone;
+
+	rc = bnxt_alloc_rx_ring_struct(bp, &clone->rx_ring_struct);
+	if (rc)
+		goto err_free_page_pool;
 
-	return &bp->rx_ring[idx];
+	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
+		rc = bnxt_alloc_rx_ring_struct(bp, &clone->rx_agg_ring_struct);
+		if (rc)
+			goto err_free_rx_ring;
+
+		rc = bnxt_alloc_rx_agg_bmap(bp, clone);
+		if (rc)
+			goto err_free_rx_agg_ring;
+	}
+
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = __bnxt_alloc_one_tpa_info(bp, clone);
+		if (rc)
+			goto err_free_rx_agg_bmap;
+	}
+
+	bnxt_init_rx_ring_rxbd_pages(bp, clone);
+	bnxt_alloc_one_rx_ring(bp, clone);
+
+	rxr->rplc = clone;
+
+	return clone;
+
+err_free_rx_agg_bmap:
+	kfree(clone->rx_agg_bmap);
+err_free_rx_agg_ring:
+	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
+err_free_rx_ring:
+	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
+err_free_page_pool:
+	page_pool_destroy(clone->page_pool);
+	rxr->page_pool = NULL;
+err_free_clone:
+	kfree(clone);
+
+	return ERR_PTR(rc);
 }
 
 static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 {
+	struct bnxt_rx_ring_info *rxr = qmem;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_ring_struct *ring;
+
+	bnxt_free_tpa_info(bp, rxr);
+
+	page_pool_destroy(rxr->page_pool);
+	rxr->page_pool = NULL;
+
+	kfree(rxr->rx_agg_bmap);
+	rxr->rx_agg_bmap = NULL;
+
+	ring = &rxr->rx_ring_struct;
+	bnxt_free_ring(bp, &ring->ring_mem);
+
+	ring = &rxr->rx_agg_ring_struct;
+	bnxt_free_ring(bp, &ring->ring_mem);
+
+	kfree(rxr);
 }
 
 static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ad57ef051798..ce2aa48911bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1076,6 +1076,8 @@ struct bnxt_rx_ring_info {
 	struct bnxt_ring_struct	rx_agg_ring_struct;
 	struct xdp_rxq_info	xdp_rxq;
 	struct page_pool	*page_pool;
+
+	struct bnxt_rx_ring_info	*rplc;
 };
 
 struct bnxt_rx_sw_stats {
-- 
2.43.0


