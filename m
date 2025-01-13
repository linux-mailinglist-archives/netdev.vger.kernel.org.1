Return-Path: <netdev+bounces-157600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B650A0AF63
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E447F3A3905
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DB231CA3;
	Mon, 13 Jan 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KF6DYAd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A133231A4A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750411; cv=none; b=eSq8zLGnKa9/IYTZWsTyLjlKgNBHBvn/cZrozHc3zI3gYUZTIIiXKpAAjeAZ7qGbZ2NiCHHUVlUpKpuokixT1k4tFQ9GQcny/IAKl/BnirAzS6HFtfkIKqy5TV+bXt9ggcbcBGeVyKwx2Y9Be8f7+XK8+ovuzgwBtwZA5jKChhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750411; c=relaxed/simple;
	bh=Dea4pR4cXk5qEykXZBDAOpCwQbiXY+FuOOAR5KVZaAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgEi5vLo7K4I47bA0MX7LpcNR+bxxt7zbq8hQ2eMA+/Wsx+1xDylsfxshBPD5cleESXgL4px8u/eiKwXg83t8z9lLIXDFOc0Yi/f41GjTXn4cSmeVLsT17Pufl2XUhhqjglGpyIHq7oesZrLPfn4z0zZaQJzVmpQ5ar65qvyNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KF6DYAd9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso65444735ad.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750409; x=1737355209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb9UUNYI4XDM0CINWyjo9QkwgzJgOZdvnwHvpE3CNYo=;
        b=KF6DYAd97faH/ir3HLRPkUoYa4CsdUVs5mLVU6BfU0N/ZKfvP9VNBxOEZIH+GruR75
         UIEnwRAja8nV4OZUaN4siMDmWQ6ZcCHtmVg0BYQ5RXkt/FW0AKgM8lxtlFeVqNhTQMNS
         ysdsCzIYx53ZN6TnWLUX2tuKgxvRkHh3xXYas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750409; x=1737355209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb9UUNYI4XDM0CINWyjo9QkwgzJgOZdvnwHvpE3CNYo=;
        b=fy07dwr4/KKxx1/er8DGwpOvDVW8dosPzFvB9OEjemeMoZ/or34rZRgpv5KCnkXulU
         8UzD6nxT+rFMBCWL3NRk+DQP43+Nz4CvURcKocGA9wS+Anb7NnlsFpWf3+4z2GQjuih4
         x3Oc8uxUwndNcTB6ZuM4TS+oFnFFl7oAa41VfAM7MZ1Dlc6CcwOkDWffi6Qld5B3rKqQ
         Sa7ymOrw2YlAoPlXAwIQGQqCrYXlsnfIbPIqfUa/jQQMHAAhDgteeEL1tXi5lfnIieJz
         ujUNkh89bbREg8kxUvzgz1FpkOt8lpkX8CugfIszKwawSO3tB2prwIRHNExcIU20E1RG
         6VMQ==
X-Gm-Message-State: AOJu0YwMb9dzfMCywGRaTo6affAX53zny/cpH3nzVXXRoI9GyXbSPEbw
	vv2ibJjaz04E7j/gR04wdip6nY1zWQNJZfIE+Yu52THndQrxuD+FpJS/BV0SGQ==
X-Gm-Gg: ASbGncvyeKmskORvS9bxhOlFnFW1Elr5a+lFPKyClxsma5+me1cG/joVk9xgZtWqBhW
	TE9h58w9O2NAzlZK7OW4Svhu5PqCWjbwjJAXqeV6iv3Hu3QU1s3ST4M8R6xQXxR9DVlMI6a7LYl
	8ttVaHEdDq5YhGetrkYQTEcA1rS2k27FK5VjoioAAEi1v9Xuf1CaOBZ96ENZ/+XD3WcRvk8QEYj
	8h/CTrqi1DBuyp699x1u91XFy1ukhk6Omlt7C42rQi/bsFMvmuy5PmnVoyS1eQIR8iq1R6j0AMa
	4VLJ5IggKhEbxUq+Cz+MO5PtPtsLS+gM
X-Google-Smtp-Source: AGHT+IEKDv32Lcu4FcodgUY3SJqGI/Vo8bgnCCXkggot/VSstFC5he5DHZULs/dSni5olplKBRPN3w==
X-Received: by 2002:a17:902:ea09:b0:216:2a36:5b2e with SMTP id d9443c01a7336-21a83f76879mr287978995ad.32.1736750409652;
        Sun, 12 Jan 2025 22:40:09 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:09 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 02/10] bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
Date: Sun, 12 Jan 2025 22:39:19 -0800
Message-ID: <20250113063927.4017173-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250113063927.4017173-1-michael.chan@broadcom.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bnxt_hwrm_cp_ring_alloc_p5() function to handle allocating
one completion ring on P5_PLUS chips.  This simplifies the existing code
and will be useful later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 +++++++++++------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8527788bed91..d364a707664b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7172,6 +7172,25 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
+				      struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	u32 type = HWRM_RING_ALLOC_CMPL;
+	struct bnxt_ring_struct *ring;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	ring = &cpr->cp_ring_struct;
+	ring->handle = BNXT_SET_NQ_HDL(cpr);
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	if (rc)
+		return rc;
+	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
+	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
+	return 0;
+}
+
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 {
 	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
@@ -7215,19 +7234,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		u32 map_idx;
 
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			struct bnxt_cp_ring_info *cpr2 = txr->tx_cpr;
-			struct bnxt_napi *bnapi = txr->bnapi;
-			u32 type2 = HWRM_RING_ALLOC_CMPL;
-
-			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_SET_NQ_HDL(cpr2);
-			map_idx = bnapi->index;
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
 			if (rc)
 				goto err_out;
-			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
-				    ring->fw_ring_id);
-			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
 		}
 		ring = &txr->tx_ring_struct;
 		map_idx = i;
@@ -7247,20 +7256,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		if (!agg_rings)
 			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
-			struct bnxt_napi *bnapi = rxr->bnapi;
-			u32 type2 = HWRM_RING_ALLOC_CMPL;
-			struct bnxt_ring_struct *ring;
-			u32 map_idx = bnapi->index;
-
-			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_SET_NQ_HDL(cpr2);
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 			if (rc)
 				goto err_out;
-			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
-				    ring->fw_ring_id);
-			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
 		}
 	}
 
-- 
2.30.1


