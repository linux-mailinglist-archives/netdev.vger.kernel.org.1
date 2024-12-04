Return-Path: <netdev+bounces-148800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B89E3295
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEF12850ED
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219AD17B50B;
	Wed,  4 Dec 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="g/+9mBsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE52170A23
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285494; cv=none; b=mEdn44/qLHhnl4Av/VS8LJWsypA9zdc28NAWwIX1BSf8Qtsviav/9lNTikQTHl8ZItlYiRA/GxHz+dLeMADGc7IeN5KF8N6/XWDowdDotmxWYOUdD0A5N+WW875KjXXVWlrR/6b/g9+RoQXfrIZzQbim2o4IQNLORpUA6ujYhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285494; c=relaxed/simple;
	bh=GgZWUDxHBc3ka7gUexiSZIQMKSt6mPV2RtPFs98WsdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyamLBV/SF9pCP0OEwixTQJClFONUC35A5fDfm43f+4BLvz0YFTF2bleVY+maCdJkZ5xw3mZNKFQ3JkIxAHhX5faWvOY3DerVUhLtQC6ycsqYaQ4KaRf6PYSTTqddXmS71mz3LHw7s/JqzmdBliSi5lXNo+1v87gaP6PR8e0wS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=g/+9mBsB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215ac560292so23717235ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733285492; x=1733890292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxpxXkYuP68zn9HeaRcspeh35QASG7HuFfCm8y3RNiw=;
        b=g/+9mBsBUZP7xCFYf4YzOqFbjHas1mDxcA+I0b3IdbngZtTT/vI11oo+ndaI/Oq9lz
         EUFGaFDmOdVKgVKWaAFttJdrBtkA1QwPcn5AEoHRbrtTHXxMSmrQobkamXuEfBoS/+cK
         jhnKqMBGifT/RjUOo0FZgljZAhjJ9Y2W5Ykvrrw0tY3I5IcrGInemkMz/lW5A3516cvC
         2q/hupnADhc1VxvQG7+ujWoyNo3OQIGP2IArTeFhmfO4cWLbgimERnCkI0kR2hUNGvOn
         +ggNgrK73IjSS8Neodlw14sHuQXNsJS7qdmuzv5Dhjyuxud7eckgsbGGK6Wf1X5YBEE6
         YlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285492; x=1733890292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxpxXkYuP68zn9HeaRcspeh35QASG7HuFfCm8y3RNiw=;
        b=guE6QSouoJbGxVs+EcSz205AuUJpG4AnjSRAjE8dxrW4IT69tpCt2E0FrZW6rBWhtk
         gFzdZxVYzUw+Cye/ywwUl5na+lyRylIGSn/Upk8iIlLJ5ZYWgNOrTKDS2lxsqv5BlzZ2
         ByWSH1qxKu/OJgx0h9J1CnXHA8TDO8elLQDAMe+vUuMYE0Ib/fmwq8+saGEOlLJJ8ONQ
         Ex92HVg3WEWZY4ux15WXfwApr9zbIxSmhxXayLaPbHxe8JlebWdAMucYr9TIXjb/bUwU
         1ZaBKOGUIuiLJqWTLnLl/gPg7+EidCjjXPCPR64EXCLW2msH9/srvqarenrEYfqvWEBB
         IVuw==
X-Gm-Message-State: AOJu0YzU0z9hBRb8C7Im2EnFnxML7sbILr0AOldQtuFoLVqmXEhREw3q
	fth0eZwPWrc/Hcs4foBaif9ITVIzmD+H8df2XSibafVAP1g+uKCa660YB3Pks4kA54FsqzGDYfJ
	B
X-Gm-Gg: ASbGnctQkxRqL78VZO7xzVWkMPU5kkOtx1fSQVEnZcr8tQQk6bK3WXUx2eb2rotYJsY
	N4LejYrfS+TgHY9l1KRvTGK0c2+QP7npmc2mxVUtHgIMJFrMdX2zouf371Lx/VgBNSEsjIzlLT+
	Q+/w/Td8ZT4gwhc0rlPgV4UNBvdX5/zKB99X+JOPnW6mgBpuyhqFgZJ94fvIF16WPTOtbVmn4pE
	41cEDSzH3Rftom3C/uKTwuLqOLY5G86PA==
X-Google-Smtp-Source: AGHT+IFJl2rqFBQpyTQtHIO86MXbPnU84+zQZyvWGAejcByNdNX9lPX4WE/61lgbAuehW8W7ty2kSg==
X-Received: by 2002:a17:902:cecc:b0:215:a3e3:c86a with SMTP id d9443c01a7336-215bc426617mr78965395ad.0.1733285491925;
        Tue, 03 Dec 2024 20:11:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191b524sm102616135ad.111.2024.12.03.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:11:31 -0800 (PST)
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
Subject: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API implementation
Date: Tue,  3 Dec 2024 20:10:22 -0800
Message-ID: <20241204041022.56512-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204041022.56512-1-dw@davidwei.uk>
References: <20241204041022.56512-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
page pool for header frags, which may be distinct from the existing pool
for the aggregation ring. Prior to this change, frags used in the TPA
ring rx_tpa were allocated from system memory e.g. napi_alloc_frag()
meaning their lifetimes were not associated with a page pool. They can
be returned at any time and so the queue API did not alloc or free
rx_tpa.

But now frags come from a separate head_pool which may be different to
page_pool. Without allocating and freeing rx_tpa, frags allocated from
the old head_pool may be returned to a different new head_pool which
causes a mismatch between the pp hold/release count.

Fix this problem by properly freeing and allocating rx_tpa in the queue
API implementation.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8031ff31f837..6b963086c1d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3710,7 +3710,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (rxr->page_pool != rxr->head_pool)
+		if (bnxt_separate_head_pool())
 			page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
@@ -15388,15 +15388,25 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
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
@@ -15404,9 +15414,11 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 err_rxq_info_unreg:
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
-	clone->page_pool->p.napi = NULL;
 	page_pool_destroy(clone->page_pool);
+	if (bnxt_separate_head_pool())
+		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
+	clone->head_pool = NULL;
 	return rc;
 }
 
@@ -15416,13 +15428,15 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ring_struct *ring;
 
-	bnxt_free_one_rx_ring(bp, rxr);
-	bnxt_free_one_rx_agg_ring(bp, rxr);
+	bnxt_free_one_rx_ring_skbs(bp, rxr);
 
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
+	if (bnxt_separate_head_pool())
+		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
+	rxr->head_pool = NULL;
 
 	ring = &rxr->rx_ring_struct;
 	bnxt_free_ring(bp, &ring->ring_mem);
@@ -15504,7 +15518,10 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->rx_agg_prod = clone->rx_agg_prod;
 	rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
 	rxr->rx_next_cons = clone->rx_next_cons;
+	rxr->rx_tpa = clone->rx_tpa;
+	rxr->rx_tpa_idx_map = clone->rx_tpa_idx_map;
 	rxr->page_pool = clone->page_pool;
+	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
@@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
 	page_pool_disable_direct_recycling(rxr->page_pool);
+	if (bnxt_separate_head_pool())
+		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
-- 
2.43.5


