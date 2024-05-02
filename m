Return-Path: <netdev+bounces-92899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4638B9400
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66D21F23571
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD622F1C;
	Thu,  2 May 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="O30DF8JQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE7225D6
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625667; cv=none; b=EJwjEnXpWJqiQoDET8NRcpPwh4weVf78Wkpk4GriAkB9iLplLRkQKUZ9gR0q+NbDSPbpMQb2K4XgKmDT0IjCniIxEJ+SiOxA+P5egPAanqq2v883mEi0NEPUjo63Lq4MU4VpLhQHCv10CDjTCRF23rl2zpGjPhFDSFEK/u9pAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625667; c=relaxed/simple;
	bh=3ZH+1bvU4Ejw/DcxJIqAYAKts80FqvGAFvHgraw+zvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEulGpGBdLONhRTXjELgfwvIlKssfr0UcDVkoQPxHXWlRdiUIjKIs2TzM+6b6Vv9Lk+uG/sRPZfuZl0gLg4VeWKLSNN8KOLxCgdJm7l0vVlitHabks+sor8KwdmRHZ8EjOWxS+umCMw/jBFYqXoiAqT3Fonx0SbtGJK4FlALv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=O30DF8JQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecff927a45so282905ad.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625665; x=1715230465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk6i6LPlwsXNVuX1b+f4RX3mSLS5KKbdRNMKlofqpos=;
        b=O30DF8JQC7f9m0rqvCo8L7vfLQ20VIzBCh87n81RTsyGJphMG2E+75xa0mfFOI2fdS
         1wf8JY494hpeS0oP1DcYqguDHbp6ZKK5zuxODMQ+zxMrvFXO9G3yFEg4avlsPxsxrsBB
         qtz4gTNpi6Qi9dsykXjld4KJG+A1EhsWqH0gOYrPY1VrnBHXSA8CEYVEoPgY2IdKcBL6
         SS7XCnf0laCt+p1/MTqLycE1Zq9xJ1iIpc/Q2i3bBLN1Uvda7VxXI/IRowiL3FeCP2C9
         uzujE0NaJ0JMVz09hFf+TwSZ/aMjSNeS2ItK60BXOxrSHixxgCdlkSYZaIyVHOxJC/EY
         pORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625665; x=1715230465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk6i6LPlwsXNVuX1b+f4RX3mSLS5KKbdRNMKlofqpos=;
        b=fn3xBElU4EtEIulUVG+y7aAjRYTFKM+MW7Q/BAOOWleYCmirba5Oa86NXrCD1JMyp2
         JY9yyKKJCest5Ka8cOvybHt0n/JhipGarx3UnFqMJSrO74Z7/3DNUhcc2l5iYMXwWlgX
         BtadAz8c08iVZ70U2IdwxqwGS8W4K1WBo9HVs562dQ+3G3wpnTiPyX8Bbm6vfmLEHlqH
         sN+R5CiyQOglGpcQzHv/yQZBY0a9rkbMsx8p+JPKsvvwtzNI8tATuw/Yje7cjdYlkBQW
         yt+5BukxUIJ9e3w1I+L/CXTLJFcqiJ6hkAZfYBkNFp42/6Be/q8vay6ZsoYrikL7UQcd
         Pe0A==
X-Gm-Message-State: AOJu0YyAtsZ7AMdwL626niKnNfBtkmLYbFoDWimWXYN6v/yf2MOXvI9r
	2Bsfd0UYiIuS7LaGxCFHTRQbID6QPOqw8i4O2n4v9zPjq15mmltafAGiY8ry9OVH3S6qGFd0rsO
	7
X-Google-Smtp-Source: AGHT+IEELsdkM3ZmqnIAyGj8Gt3RcV+MdiYXWYmIhP3o4u+cglEz8i5uuTLB8JY2oGA7OyGRBLxK4A==
X-Received: by 2002:a17:902:e5d2:b0:1e5:1867:d9fa with SMTP id u18-20020a170902e5d200b001e51867d9famr5810955plf.44.1714625664918;
        Wed, 01 May 2024 21:54:24 -0700 (PDT)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id lf14-20020a170902fb4e00b001e556734814sm242297plb.134.2024.05.01.21.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:24 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 9/9] bnxt: swap rx ring mem during queue_stop()
Date: Wed,  1 May 2024 21:54:10 -0700
Message-ID: <20240502045410.3524155-10-dw@davidwei.uk>
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

After stopping an rx ring in bnxt_queue_stop(), swap the preallocated
ring memory into the existing rx ring that the hardware is aware of. As
discussed in the last patch, the hardware ring is associated with the
address of static arrays in struct bnxt_rx_ring_info. For example:

struct bnxt_rx_ring_info              struct bnxt_ring_mem_info

struct rx_bd *rx_desc_ring[MAX]   <-> void **pg_arr
struct bnxt_sw_rx_bd *rx_buf_ring <-> void **vmem

The pg_tbl that is registered w/ the hardware via HWRM contains an array
of dma mappings to the pg_arr above. We can't touch this association
during reset, so can't simply swap the ring and its clone directly.

Instead, swap the ring memory only then update the pg_tbl. Functionally
it should be the same as the existing bnxt_rx_ring_reset(), except the
allocations happen before resetting the ring using a clone struct
bnxt_rx_ring_info.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 54 +++++++++++++++++------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d848b9ceabf0..4dd4aa0911b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15024,8 +15024,6 @@ static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
 	struct bnxt_rx_ring_info *rxr = qmem;
 	struct bnxt *bp = netdev_priv(dev);
 
-	bnxt_alloc_one_rx_ring(bp, rxr);
-
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
@@ -15038,26 +15036,56 @@ static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
 
 static int bnxt_queue_stop(struct net_device *dev, int idx, void **out_qmem)
 {
+	struct bnxt_rx_ring_info *orig, *rplc;
 	struct bnxt *bp = netdev_priv(dev);
-	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_ring_mem_info *rmem;
 	struct bnxt_cp_ring_info *cpr;
-	int rc;
+	int i, rc;
 
 	rc = bnxt_hwrm_rx_ring_reset(bp, idx);
 	if (rc)
 		return rc;
 
-	rxr = &bp->rx_ring[idx];
-	bnxt_free_one_rx_ring_skbs(bp, rxr);
-	rxr->rx_prod = 0;
-	rxr->rx_agg_prod = 0;
-	rxr->rx_sw_agg_prod = 0;
-	rxr->rx_next_cons = 0;
-
-	cpr = &rxr->bnapi->cp_ring;
+	/* HW ring is registered w/ the original bnxt_rx_ring_info so we cannot
+	 * do a direct swap between orig and rplc. Instead, swap the
+	 * dynamically allocated queue memory and then update pg_tbl.
+	 */
+	orig = &bp->rx_ring[idx];
+	rplc = orig->rplc;
+
+	swap(orig->rx_prod, rplc->rx_prod);
+	swap(orig->rx_agg_prod, rplc->rx_agg_prod);
+	swap(orig->rx_sw_agg_prod, rplc->rx_sw_agg_prod);
+	swap(orig->rx_next_cons, rplc->rx_next_cons);
+
+	for (i = 0; i < MAX_RX_PAGES; i++) {
+		swap(orig->rx_desc_ring[i], rplc->rx_desc_ring[i]);
+		swap(orig->rx_desc_mapping[i], rplc->rx_desc_mapping[i]);
+
+		swap(orig->rx_agg_desc_ring[i], rplc->rx_agg_desc_ring[i]);
+		swap(orig->rx_agg_desc_mapping[i], rplc->rx_agg_desc_mapping[i]);
+	}
+	swap(orig->rx_buf_ring, rplc->rx_buf_ring);
+	swap(orig->rx_agg_ring, rplc->rx_agg_ring);
+	swap(orig->rx_agg_bmap, rplc->rx_agg_bmap);
+	swap(orig->rx_agg_bmap_size, rplc->rx_agg_bmap_size);
+	swap(orig->rx_tpa, rplc->rx_tpa);
+	swap(orig->rx_tpa_idx_map, rplc->rx_tpa_idx_map);
+	swap(orig->page_pool, rplc->page_pool);
+
+	rmem = &orig->rx_ring_struct.ring_mem;
+	for (i = 0; i < rmem->nr_pages; i++)
+		rmem->pg_tbl[i] = cpu_to_le64(rmem->dma_arr[i]);
+
+	rmem = &rplc->rx_ring_struct.ring_mem;
+	for (i = 0; i < rmem->nr_pages; i++)
+		rmem->pg_tbl[i] = cpu_to_le64(rmem->dma_arr[i]);
+
+	cpr = &orig->bnapi->cp_ring;
 	cpr->sw_stats.rx.rx_resets++;
 
-	*out_qmem = rxr;
+	*out_qmem = rplc;
+	orig->rplc = NULL;
 
 	return 0;
 }
-- 
2.43.0


