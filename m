Return-Path: <netdev+bounces-92896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB68B93FD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA02B21E2B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F321A04;
	Thu,  2 May 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FBebrXrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128620DD2
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625664; cv=none; b=Yf+Q5BShNPAgIfi4qRpqQulXP2QLAUwCFEbGAlW3xspdWNUgQHq6Fe2JtR8GHmTmosUSodb2na1Xit2aTkCgv7knzskVDGqUCSScpDhZ0GzkghcL6yEKgWat/09s7xEzTXGtxoR9Ra/nDxEHFibekadJUNaCtLWIg38WP47JbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625664; c=relaxed/simple;
	bh=oDHaNd5AziFDac6uLmqQVbFbY+RtD94LtAULAsjEU+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THIyfuW0w2dstrPabCGU9Yl6lImS9Qc3x2brqmBVEmwJEkawKkhRJ3/Pq2dN3TEDZnOvGmxe7bLvgT/qAVmj9HjJ2fWkc8iz/KoqCjr2j/b7T0OBASheiBugapD4ydm3oD+pFXTQBylavkDLy++YbWtDpH5qld+Sax5+So5u4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FBebrXrn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so7024556b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625662; x=1715230462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXMMmEd8a24CLHsrwT2GRQHruMFZl07cdN6A9cDx06E=;
        b=FBebrXrnSh14XwahL41mHiHeczzbZbLc/Kpd/0RzK1XipCRHmafw7gFprIjlbue+dV
         jQL2uWPq+Ic/4fbd2ZTvvAplVhlpVHZiHBi6ZMNGohynrjjuuxGzUWaFAbs6pA4yrjCG
         n4fYMWJd4x41gueU1ayAAXtH3xLTdnnXjnXbeh0yW9jMMoGi5Sqo10R+dIbkeVVHWBsE
         ecOJ5SUGjWq1EECYCHsfu3eyXbgePlCgbfg1vc3gu2TwqBiI/Cdw81gdw04NT3QEYoZA
         Keg5kOBF/6x49OM3m+O6Ng+A4narKQQb6GrwLoXKmpRd9cA1WjPbZieFxX/IM+a7Q77x
         Ds1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625662; x=1715230462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXMMmEd8a24CLHsrwT2GRQHruMFZl07cdN6A9cDx06E=;
        b=HTaPkgvSXbFErQ8QR5W8YhWTBT3eNfCiuDnHbcmZ1K4d/wUJjJT58chwKBTsnhEBXe
         Q0m4Nnr4CHpwJ1nLoqFUd3VY5cwtvgZWZg6ZwY0Iv9fIy/P7dpHC9a9qjpzjs5jx53nc
         NP2DGPJ3oFBavHKdh7bHA51GVvWXHWWc9Ei2IwRjOWp6t6ENUyDLobzQmn5oI1vIVQL+
         CjLgugRwZzGicFBp09E5nhaS+mmXEKxzOM/MIz/sn4a8qCgoYg+sjGueCgT8tR2Cpnaq
         Gr648NK7Lr7aSDLj6hkENmeq3Zmzx3GqL+7inx8IS5Amfrq+obyAfsh9kp11AnzU+wLG
         kZbg==
X-Gm-Message-State: AOJu0YzXwp0OD0UGbDVEKxPZ66+m1bNrHh8kILcrmAtCP2iO3eT/W3b1
	NjME+epOv88xBproqMIuY8+P9QtXfva7C3Py3OpOgRqXIxLV4F0vtcb5R4Pr+bhYl2iihu63bYP
	r
X-Google-Smtp-Source: AGHT+IFlnXKVDgwn3h0Bd3lCrRslrqGeOtQb0Lct/5wKDoKZviSWE3n9QcbSokVvpdAhUUfm+qjaMA==
X-Received: by 2002:a05:6a20:9150:b0:1a9:c843:6f37 with SMTP id x16-20020a056a20915000b001a9c8436f37mr5455756pzc.19.1714625662196;
        Wed, 01 May 2024 21:54:22 -0700 (PDT)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902e29200b001e99fdbc515sm253476plc.3.2024.05.01.21.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:21 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 6/9] bnxt: add __bnxt_init_rx_ring_struct() helper
Date: Wed,  1 May 2024 21:54:07 -0700
Message-ID: <20240502045410.3524155-7-dw@davidwei.uk>
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

Move the initialisation of rx ring and rx agg ring structs into a helper
function.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 +++++++++++++----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bda49e7f6c3d..b0a8d14b7319 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3997,6 +3997,31 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 	return 0;
 }
 
+static void __bnxt_init_rx_ring_struct(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_mem_info *rmem;
+	struct bnxt_ring_struct *ring;
+
+	ring = &rxr->rx_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bp->rx_nr_pages;
+	rmem->page_size = HW_RXBD_RING_SIZE;
+	rmem->pg_arr = (void **)rxr->rx_desc_ring;
+	rmem->dma_arr = rxr->rx_desc_mapping;
+	rmem->vmem_size = SW_RXBD_RING_SIZE * bp->rx_nr_pages;
+	rmem->vmem = (void **)&rxr->rx_buf_ring;
+
+	ring = &rxr->rx_agg_ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bp->rx_agg_nr_pages;
+	rmem->page_size = HW_RXBD_RING_SIZE;
+	rmem->pg_arr = (void **)rxr->rx_agg_desc_ring;
+	rmem->dma_arr = rxr->rx_agg_desc_mapping;
+	rmem->vmem_size = SW_RXBD_AGG_RING_SIZE * bp->rx_agg_nr_pages;
+	rmem->vmem = (void **)&rxr->rx_agg_ring;
+}
+
 static void bnxt_init_ring_struct(struct bnxt *bp)
 {
 	int i, j;
@@ -4024,24 +4049,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		rxr = bnapi->rx_ring;
 		if (!rxr)
 			goto skip_rx;
-
-		ring = &rxr->rx_ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bp->rx_nr_pages;
-		rmem->page_size = HW_RXBD_RING_SIZE;
-		rmem->pg_arr = (void **)rxr->rx_desc_ring;
-		rmem->dma_arr = rxr->rx_desc_mapping;
-		rmem->vmem_size = SW_RXBD_RING_SIZE * bp->rx_nr_pages;
-		rmem->vmem = (void **)&rxr->rx_buf_ring;
-
-		ring = &rxr->rx_agg_ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bp->rx_agg_nr_pages;
-		rmem->page_size = HW_RXBD_RING_SIZE;
-		rmem->pg_arr = (void **)rxr->rx_agg_desc_ring;
-		rmem->dma_arr = rxr->rx_agg_desc_mapping;
-		rmem->vmem_size = SW_RXBD_AGG_RING_SIZE * bp->rx_agg_nr_pages;
-		rmem->vmem = (void **)&rxr->rx_agg_ring;
+		__bnxt_init_rx_ring_struct(bp, rxr);
 
 skip_rx:
 		bnxt_for_each_napi_tx(j, bnapi, txr) {
-- 
2.43.0


