Return-Path: <netdev+bounces-92894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE88B93FB
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C241C217F0
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA7208D7;
	Thu,  2 May 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BbEB2JOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08C1F95E
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625662; cv=none; b=WiC/0v88WMnooxq/Jl9fXotIuCiwxZIz5i1X8jL1yXYeZYd16E76xsZORjyK72zemFUIx6p0pUpGUxCGSvQ3awQ/bfNfYdiA/V3qisr1NDgmCRm6Dj+3ON4xFNKk7hrupboa80yVK4S64NhUmwr4c24dUCnRlb+Wx+eKMMD2DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625662; c=relaxed/simple;
	bh=suisxc1RtAB4hm7382CkzuinVaWy4Upjpyn+tyuukDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCy2en3fzmdYfP69cEtjOz+VBULsLG08s8u16vHhoHmmsMwjq8CAGl1SSsy+r6D9FX7r1MKrqYRNpL6dUIamQkqUfC2euTB42ud9jvkZqU2gX238ppvbVV9tTsue65MsaE/KqB8Lz/fl3otESUsvbwN9uiJVU41C6KIFDJ3voFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BbEB2JOG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso6898106b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 21:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714625660; x=1715230460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbEkwCacQh5bYWcqD2XE9ClJ1unjel5HXLhJbkE5ieU=;
        b=BbEB2JOGWPq0c0NkGgKgVTHuQ1SBHIipX2koOXH6aPceKuthhZNG98TxM80IQ8lIlS
         fHZbmlLf2vtJtIgXqp+fjB5cMO00XjxGxZsgCPhzrJG4Bgttqie3+5WdOCTdSEr8LSxy
         2Z87EG/kDnpHuDAWTyL/DbBtf9DPKbcSpiWiV9flArxFgqW+2kP8AbDj1JUi6gonfca8
         TTY3MAdkVE68Uz7xdmcNwP33dMwIcJyprXZwUSBhS4zIW77gQ7NmTyM98rLy0yfhFvgc
         wYUM7EkrEv88hXSKwAAlEnxap2qs31oiOFVxPMsV0fYa/C+hUUX/9N/s7svngBwuJEbR
         Ivjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625660; x=1715230460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbEkwCacQh5bYWcqD2XE9ClJ1unjel5HXLhJbkE5ieU=;
        b=fcL/iKc0SVN2kLeKUp2DFeImn5XxCUD9ltuBFW9l3/MqjAK58tSSqXF4kJOsM5bwLv
         ++aCYXx63yn5E/kOoED7dd+1CDYB8wmDFpNzauHKFUjiXjj0hiXZhEnuVB4OmUl/aXol
         Q6bQrHTfdFxQtPDdjNHgXxrpvJVAFiJSOBXjz/EWl6U2O0QUDIoiUYh/uHtw5uEsevzx
         HTyaUSZNt3jZDjtkH3Nyq/Lzl7LTUjabDxmmJvYxYMQQ9tUVxDHQICoHHHMKQIYiizNM
         07z9xTEYgI7NPL3h291DLPfZbUbcK/RBn5JxeWB8P6Di50KqKSizRJWUGIO5UONPJrRx
         pR6Q==
X-Gm-Message-State: AOJu0Yw7eH8AlZ+VvLQ+HdnWeCxQNwDX8ENatnO1S2ndAp9kToWggmY5
	YtkkvEBNtDToto7e2LkHoXPTQUQLaJRg3trh85VYrS9ED9JGaj5fXqMVIjQ9AarU6bVoxkYIFzn
	l
X-Google-Smtp-Source: AGHT+IHV6c9y1O7oo6L+70KpzjKtc7PSx2yLx6mRf58gYHFSJlu0e3IirI36S42BgFoyBYt67mF4rQ==
X-Received: by 2002:a05:6a20:f3aa:b0:1af:667c:38cc with SMTP id qr42-20020a056a20f3aa00b001af667c38ccmr4690960pzb.5.1714625660221;
        Wed, 01 May 2024 21:54:20 -0700 (PDT)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001ec80ed863asm244526plb.152.2024.05.01.21.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:20 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 4/9] bnxt: refactor bnxt_{alloc,free}_one_rx_ring()
Date: Wed,  1 May 2024 21:54:05 -0700
Message-ID: <20240502045410.3524155-5-dw@davidwei.uk>
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

Refactor bnxt_free_one_rx_ring_skbs() and bnxt_alloc_one_rx_ring() to
take the rx ring directly as a parameter instead of an index. This makes
the functions usable with an rx ring that is allocated outside of
bp->rx_ring.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 788c87271eb1..7b20303f3b7d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3307,9 +3307,8 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 	}
 }
 
-static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
+static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
 	struct pci_dev *pdev = bp->pdev;
 	struct bnxt_tpa_idx_map *map;
 	int i, max_idx, max_agg_idx;
@@ -3389,7 +3388,7 @@ static void bnxt_free_rx_skbs(struct bnxt *bp)
 		return;
 
 	for (i = 0; i < bp->rx_nr_rings; i++)
-		bnxt_free_one_rx_ring_skbs(bp, i);
+		bnxt_free_one_rx_ring_skbs(bp, &bp->rx_ring[i]);
 }
 
 static void bnxt_free_skbs(struct bnxt *bp)
@@ -4051,9 +4050,8 @@ static void bnxt_init_rxbd_pages(struct bnxt_ring_struct *ring, u32 type)
 	}
 }
 
-static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
+static int bnxt_alloc_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
 	struct net_device *dev = bp->dev;
 	u32 prod;
 	int i;
@@ -4062,7 +4060,7 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	for (i = 0; i < bp->rx_ring_size; i++) {
 		if (bnxt_alloc_rx_data(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(dev, "init'ed rx ring %d with %d/%d skbs only\n",
-				    ring_nr, i, bp->rx_ring_size);
+				    rxr->bnapi->index, i, bp->rx_ring_size);
 			break;
 		}
 		prod = NEXT_RX(prod);
@@ -4076,7 +4074,7 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
 		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(dev, "init'ed rx ring %d with %d/%d pages only\n",
-				    ring_nr, i, bp->rx_ring_size);
+				    rxr->bnapi->index, i, bp->rx_ring_size);
 			break;
 		}
 		prod = NEXT_RX_AGG(prod);
@@ -4135,7 +4133,7 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 		bnxt_init_rxbd_pages(ring, type);
 	}
 
-	return bnxt_alloc_one_rx_ring(bp, ring_nr);
+	return bnxt_alloc_one_rx_ring(bp, rxr);
 }
 
 static void bnxt_init_cp_rings(struct bnxt *bp)
@@ -13238,13 +13236,13 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 			bnxt_reset_task(bp, true);
 			break;
 		}
-		bnxt_free_one_rx_ring_skbs(bp, i);
+		bnxt_free_one_rx_ring_skbs(bp, rxr);
 		rxr->rx_prod = 0;
 		rxr->rx_agg_prod = 0;
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		bnxt_alloc_one_rx_ring(bp, rxr);
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats.rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
@@ -14826,7 +14824,7 @@ static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
 	struct bnxt_rx_ring_info *rxr = qmem;
 	struct bnxt *bp = netdev_priv(dev);
 
-	bnxt_alloc_one_rx_ring(bp, idx);
+	bnxt_alloc_one_rx_ring(bp, rxr);
 
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
@@ -14849,8 +14847,8 @@ static int bnxt_queue_stop(struct net_device *dev, int idx, void **out_qmem)
 	if (rc)
 		return rc;
 
-	bnxt_free_one_rx_ring_skbs(bp, idx);
 	rxr = &bp->rx_ring[idx];
+	bnxt_free_one_rx_ring_skbs(bp, rxr);
 	rxr->rx_prod = 0;
 	rxr->rx_agg_prod = 0;
 	rxr->rx_sw_agg_prod = 0;
-- 
2.43.0


