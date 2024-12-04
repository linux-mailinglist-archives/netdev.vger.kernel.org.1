Return-Path: <netdev+bounces-148799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B139E3294
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CEB1689F9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B91714B3;
	Wed,  4 Dec 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="rOV3EPc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DD3D0D5
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285492; cv=none; b=VaA1osUuzHat4K9nVIfFT/MOOr1+XvilLGfUnNnayYsTqh+f6ivcFdG4EeazY3terzGWeWxICSTOZ8jPBsq+hbNobaYiP2cKkQPPhBBynpOJlJ3oEPt1mSPba9a+WAuIoSRgt9jrwD+e42bdmMw01dvx0KwEdfRe4tspSRUmfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285492; c=relaxed/simple;
	bh=wHfRIGafdMbxzqo1PucG/+dfyoNtkHSql/2Bw0YLqms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC6uedTsGz6PohgbvzdIZP6I8ZtNI+MHJP7ijv+W8IhhHszbBKi0kYjor7WArcgyb+SdyDTgwRl9M0RYoeenytwLF1eDrrcP6ZQpq7b5b6liAuw9Fg52tEtdn+rrqj8jBoa86Y7Cmh6K9wt7C2e9K0sp0Hj5cksm2Eqjl3+lN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=rOV3EPc0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215a7e487bfso21352705ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 20:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733285490; x=1733890290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izeeg5A6gwCroF6AHx4Toe4Oa8aOZbfAIvcvgyo/zLQ=;
        b=rOV3EPc0aLtVGm8cCpbaqW7K4CiDs5hD83YE1EGINIhplXboYEpaz2cf36z9CpmCwV
         Jrhif0Jk1JwBU+0A9+5t+lnYVfG/POj3i/QCyyCHZhdqUmPO5MnUDJIixG6IfY2oDgGT
         tdWMRPie/Jut3RTZJEFRQJxnadQraGHjjcxX9zjWVLGMC3149LXd7RUEC1Ka+nKTWyFc
         qy4rRpLmtoTWk0XZt3gDb/gTAEeY/Xg/B7WMrEQgcM4l+RrIqIqfxMMMbvtmNtK2Vu7t
         RWtIOZg3vwOi2tDXk7oC48JNuWnI3N+42ChPfnT4bWZwiLUNV9u5RdoWWm7IJw5PLr9F
         IM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285490; x=1733890290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Izeeg5A6gwCroF6AHx4Toe4Oa8aOZbfAIvcvgyo/zLQ=;
        b=UKkOR2UhdlAb7noLViGXXKBMUlAt3nShYi2Up3s6xiC9pDnOq3hIOd97F/AMl+Hhyh
         qbPuk/M+z8hXBV0lN3nYBW4RUhykCI7UdOn2tdUcHwybeZz9EtJcy//861tTiYgyOajm
         2B0ywHgKAL5PA+D+vPA4yM12qd6fIPpVRaTt02z16XDWOnA87CUwe9rSnJqp5MzS5REL
         7v5ILP0CAnLUBixiakSiEFf4iYIRJMcXgTSUHR5EuhGjYg6/8LJf+GjFL7pGfgyUwA61
         YDux+bBBIHFRY0dHuxRZFoh5MJh2jFEEJh1+HUU56SSxiOwDqVcYETo2EsfWFAavH6af
         q3iA==
X-Gm-Message-State: AOJu0Ywi1h2US57MQFpApMTRJ1O2NFPbN6Bd+ozzml52F2QlrIHOCppg
	XLn+USiSDQ1r9S8Z8DB2BV4D8UT/GsSjxyaADLx4w0kzxKvEmcPsILk5RsA+EsfXFuSuFkkw3Py
	B
X-Gm-Gg: ASbGncvORIxTvJ5BjmktadEVRG4/SnLfxQFYMgJINg426bMNnmfzHjUCbeudOFxoKEp
	9yhmYu6BNlIqJUYoQQsxajvxQTQExQ1NSThmes12oEni4pSn2Bzb2TI68TsbZ+xFoK54Df+uv9B
	FeyQEw7TpzEOJlHhyltnJiwyz1mjKWy9Zaf11FQ58G/0Ocz1wcIGdfBNjZKA8DS02bYCLAXrkFG
	58RTlmzLwO67PlDXYoLqR5/Ltc6/DhUcg==
X-Google-Smtp-Source: AGHT+IH/tnfQMtvfU5P3dMXfK/k4hipWOYv4IL9wJsXT/xucZCFUqPwSeyezYbHIMG4Xey7VRhEW8A==
X-Received: by 2002:a17:903:2341:b0:215:810f:84db with SMTP id d9443c01a7336-215bd1242b5mr82049625ad.33.1733285490543;
        Tue, 03 Dec 2024 20:11:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548cb8ea6sm81053855ad.50.2024.12.03.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:11:30 -0800 (PST)
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
Subject: [PATCH net v3 2/3] bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap()
Date: Tue,  3 Dec 2024 20:10:21 -0800
Message-ID: <20241204041022.56512-3-dw@davidwei.uk>
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

Refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bmap() for
allocating rx_agg_bmap.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++-------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b85f22a4d1c3..8031ff31f837 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3764,6 +3764,19 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	return PTR_ERR(pool);
 }
 
+static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	u16 mem_size;
+
+	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
+	mem_size = rxr->rx_agg_bmap_size / 8;
+	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
+	if (!rxr->rx_agg_bmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int bnxt_alloc_rx_rings(struct bnxt *bp)
 {
 	int numa_node = dev_to_node(&bp->pdev->dev);
@@ -3808,19 +3821,15 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 
 		ring->grp_idx = i;
 		if (agg_rings) {
-			u16 mem_size;
-
 			ring = &rxr->rx_agg_ring_struct;
 			rc = bnxt_alloc_ring(bp, &ring->ring_mem);
 			if (rc)
 				return rc;
 
 			ring->grp_idx = i;
-			rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-			mem_size = rxr->rx_agg_bmap_size / 8;
-			rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-			if (!rxr->rx_agg_bmap)
-				return -ENOMEM;
+			rc = bnxt_alloc_rx_agg_bmap(bp, rxr);
+			if (rc)
+				return rc;
 		}
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
@@ -15331,19 +15340,6 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_alloc_rx_agg_bmap(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
-{
-	u16 mem_size;
-
-	rxr->rx_agg_bmap_size = bp->rx_agg_ring_mask + 1;
-	mem_size = rxr->rx_agg_bmap_size / 8;
-	rxr->rx_agg_bmap = kzalloc(mem_size, GFP_KERNEL);
-	if (!rxr->rx_agg_bmap)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
-- 
2.43.5


