Return-Path: <netdev+bounces-159026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72BA14237
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5D3A9BC2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF0236EAB;
	Thu, 16 Jan 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EEmnIYKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34532236A79
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055492; cv=none; b=XPkC8pS2ZfpA84j2FWJgCdHV9QN/UfW/tgnJGetBS8oY1uHKzfOiA+MbEkSM/I2gFPP8T4eK/PYeqqOqxfXdMm24XUjZ4FeR00uvlAejZzuSuHLVEBkTrtZ6Dn7YmyaZeQF/l0QLjeBplea/UMofR/FBSxmhuKAYXUx5OUSAMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055492; c=relaxed/simple;
	bh=pggF0QjHZdPDH6LMkNW2uv4JEQQNrFDW9JiMbpybM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOzQPP0mUxKkIwRrzwWQTKJ9xmpASI/est5PXouZ/sHLvdBjuZrxh6Fjwrn5QeEmVou94wwdUt+snP2bXWSz89kw9yywLDBTBW/HlBo7ykubMvqFx0usPSW0fXQtDJLmuJweaGYvek/WPNYSbVEAF7CsZ7soeSn6ZIqNT1pkBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EEmnIYKR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so1844648a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055490; x=1737660290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKeZdsaFLoyR7jV9aMNNeAzQ0dPVC/ZL8LekU9Juq+0=;
        b=EEmnIYKRGo5JFfUYVZ2QGaS0DlicsycWHw4Sx1DcWQ8dskEmsi0YrPjgJURCjIiTOs
         UVXZhjQKNSjMvUDRnSOd59AbNDuC0qPjI94o7yHF7BxbC+lmQV9x9SmfrdX44FDZ6uyL
         IPWlsj8fnMPBhdGsjUJZWmOkExO/2r7wJcYqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055490; x=1737660290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKeZdsaFLoyR7jV9aMNNeAzQ0dPVC/ZL8LekU9Juq+0=;
        b=EAw3+9qmV7rb6TYn5lpexNJ14G83Fc2Th4xwFKnrC5Q1GKlNLDhY/7Vx4WaM9Pponw
         uUBusn/a+fqzrDAxpxrNviBDS49wCOrFHOut4ffOln7+wMICuZRlWvFOC7xQ3nPdC3D7
         Ai7Ah5308D4GnNsz6TSblzKQm3rq4KS1c0aTEAc+/6FZExde5jwVIZv8O1AxaPj/bPai
         hJMlZD5xxkZlUcYfXdzF2zOcSrd5c4GpE3r6Bpq2XA+9N77oTh93wCgd87nPKIsw+izv
         iASNagguLxvVq5xK4hhBUvDRK+mQQLaww2oMKuTP6V7C7XxRACOLJ/K2ObOypE56M3sM
         HSsA==
X-Gm-Message-State: AOJu0YzUiSu2sv1ouaBW5OiL2IGKfWaU8+O57hxTV9c12wQhjs9/q4zc
	tJ8Ehm177EdtlE0CnhMgr8vGUUEq+RafBz7Lr0/Vu4QdkeTup6vr5ugQBpvSIA==
X-Gm-Gg: ASbGncu2qgygPa/48ZeRNuaViaR+8wCVm+0s90SdUj8zhqhUHDBHfJOXKkM6U/e3+UH
	tR9GiXYS166S7bmUMuCeNEhUsJvvN2tkCjhMMiYO9ec/tjGiK1YwBu6Z16JPT/9MbvqdUX3cbeO
	oHc3tp2/naE4zh3vUoeUwxVe5cicmMMl/TLw4vnxhlVVm8E+oMQVa2ElSeTAcZWHBz/uKnbWT5u
	2UQULEQG9wjdOCWJb3W4X5rAzo+K3X8ANzfdNihrpi1AROVjvYTgZjmCvedtZaFlVZXfOTm+sRj
	JnSquehZVptvmld8wBAa8X2q6WcnO4fB
X-Google-Smtp-Source: AGHT+IHSvO9HrgVONbvTwY3PsHH2rvd83tru/vBVcknh9Dyk5GwPMZ4n0LKlXW3naBFjvjRb7M6jqg==
X-Received: by 2002:a17:90a:e18f:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f548ea6493mr48386929a91.4.1737055490544;
        Thu, 16 Jan 2025 11:24:50 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 08/10] bnxt_en: Reallocate RX completion ring for TPH support
Date: Thu, 16 Jan 2025 11:23:41 -0800
Message-ID: <20250116192343.34535-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

In order to program the correct Steering Tag during an IRQ affinity
change, we need to free/re-allocate the RX completion ring during
queue_restart.  Call FW to free the Rx completion ring and clear the
ring entries in queue_stop().  Re-allocate it in queue_start().

While modifying bnxt_queue_start(), remove the unnecessary zeroing of
rxr->rx_next_cons.  It gets overwritten by the clone in
bnxt_queue_start().

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 +++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index da5acb8b0495..53279904cdb5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7404,6 +7404,19 @@ static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
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
@@ -15623,10 +15636,15 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
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
@@ -15650,6 +15668,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
+err_free_hwrm_cp_ring:
+	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 err_free_hwrm_rx_ring:
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	return rc;
@@ -15674,11 +15694,13 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
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


