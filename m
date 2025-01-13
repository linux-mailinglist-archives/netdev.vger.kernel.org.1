Return-Path: <netdev+bounces-157606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157DA0AF69
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F771886C47
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAE233130;
	Mon, 13 Jan 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U8KivjuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152F231C85
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750419; cv=none; b=SzQNELjz7yT5Rv5hfeWg6Ay/qE7jSQFVyaYr1TkPaZnw0Vg9iz+As3Jd92WzFQ0Jf1yvuUBPekxxJHSitHEnXOiK7Bcm3db5V65ztTInWkk70r3yboBEgJl3mIBTd8LcEuPDaxky5DtvilJF9fttrbtSIfrFBZlFIVh5o/MLZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750419; c=relaxed/simple;
	bh=OW/EhcPAALkMHONpotvVdmf9I2szxk8QJccSlFm+e0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwOvUdRLpYkhmEpMNCqKFKDx3V/LK8GWRujLoqmRwXxER2xn5yz1/5OK8mSjE3pRYQcBMy9BoOY+JrQd/kGpCvYJh6Pz5aJPsY0u/nxDvoNJUgt87t4Q+awsZuhAxn+ZrZif/BI/GIJ4KSrE/GMNsb/kERbJfmq0iC2bEqihQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U8KivjuI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso65446645ad.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750417; x=1737355217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR5XWqzcjY8ThcvEtHL1qDDCuhjPAi88uUlx04yuMF8=;
        b=U8KivjuIkCMTIMWD8FrRy3FTCMeNx/6kloQF9ShNtWmEqWm8kwVUSv2YDGbL4kCO6v
         59MnTwgeVbouo51oKQaji7itQxMRGy+ef5iqmRPZLuRTroUdIC8F8TmFM9lWGJB4vGtA
         Te/pwHlGNUt7B0P8E+eQHW1dK7R8t/johIct0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750417; x=1737355217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR5XWqzcjY8ThcvEtHL1qDDCuhjPAi88uUlx04yuMF8=;
        b=vZ4rwUK5/FDH3gqKlEAi1+Pcl4apvFwXbcpU2otrKlsJxVHHAD00cTq8BXy6giR1mE
         SxW2edf/tkL/SZFSQXTNguKqP1ZH60mKaav2zMjan1CIt9o7hY4ipgPAD783KncrGiKv
         TCK7NtECWw15L7Y2O8hzu4NAEBrqsF2aK+RBNp2X/sAXzkqtvaoqTtarBFLnfdXkVZcS
         Um1oYFc0Vlo2amhT9nBaA64K5crx094i5LU+dVnEuJvQHc1l7FABdBRZw4rsa1Zj544B
         PfNxMF0IBWrOlFLHjeZwGkrdiQEXS/dz+/MFYFgt+hjTM7NbMU8CiNBXv+HRTQcAsk2a
         CtqA==
X-Gm-Message-State: AOJu0YzfkPIf5ZZEauLVdMv0NpjJyZHfmvbEpBZz9ETJ3XhMj+SoBx7m
	FdIkWO/VrhOI7o0RZVax2eTEx56L0beO7Rsv1mZ3vSgCEB37408Rn5GwRi7N3A==
X-Gm-Gg: ASbGncvwT7SXcRFKZ2pTgGlMkzU8pmTjjbv5V7Id06fmHmv93K8CY4e76EMLl0KreWg
	iKvKS0HfFDv2Ez+GaZ0ThMfOXiKhCWlz8ZVsIm7pUxMeY7R+K8dF7APt1eVe6x9+w+H0nVlsio3
	ojVpNXwEPhO3N/zgtoaDoA7umUyyIUi0xEsDATFeFEUflncIjFWUWe46D+FH+Va1zVfZbnYW5lK
	oW8h3hlh6uDo7S4Me16sBYlORP65wLCkmvxJGJ7Jj7iFJkseOFRXWyzRKVwpEOlBTq8dq9SnFFm
	fVYrVM2xhMm981oerdny2ymQwtFVsrMj
X-Google-Smtp-Source: AGHT+IE6YTmjpi6iZTgNPfCubCJBN2Hv9p/lNrM8qetcwJ2IDS1FUW+prG8VnIqGV1cDrtoxn/Jh+g==
X-Received: by 2002:a17:902:f54e:b0:215:8809:b3b7 with SMTP id d9443c01a7336-21a83f36de7mr281085705ad.7.1736750417114;
        Sun, 12 Jan 2025 22:40:17 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:16 -0800 (PST)
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
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 08/10] bnxt_en: Reallocate Rx completion ring for TPH support
Date: Sun, 12 Jan 2025 22:39:25 -0800
Message-ID: <20250113063927.4017173-9-michael.chan@broadcom.com>
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

From: Somnath Kotur <somnath.kotur@broadcom.com>

In order to program the correct Steering Tag during an IRQ affinity
change, we need to free/re-allocate the Rx completion ring during
queue_restart.  Call FW to free the Rx completion ring and clear the
ring entries in queue_stop().  Re-allocate it in queue_start().

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 +++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 30a57bbc407c..fe350d0ba99c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7399,6 +7399,19 @@ static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 }
 
+static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_ring_struct *ring = &cpr->cp_ring_struct;
+	int i, size = ring->ring_mem.page_size;
+
+	cpr->cp_raw_cons = 0;
+	cpr->toggle = 0;
+
+	for (i = 0; i < bp->cp_nr_pages; i++)
+		if (cpr->cp_desc_ring[i])
+			memset(cpr->cp_desc_ring[i], 0, size);
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -15618,10 +15631,15 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 	if (rc)
 		return rc;
-	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
+
+	rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 	if (rc)
 		goto err_free_hwrm_rx_ring;
 
+	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
+	if (rc)
+		goto err_free_hwrm_cp_ring;
+
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
@@ -15645,6 +15663,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
+err_free_hwrm_cp_ring:
+	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 err_free_hwrm_rx_ring:
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	return rc;
@@ -15669,11 +15689,13 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
-	rxr->rx_next_cons = 0;
 	page_pool_disable_direct_recycling(rxr->page_pool);
 	if (bnxt_separate_head_pool())
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
+	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
+	bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
+
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
 
-- 
2.30.1


