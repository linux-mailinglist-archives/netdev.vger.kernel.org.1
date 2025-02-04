Return-Path: <netdev+bounces-162326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D665A268DF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BC93A433D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B913BC0E;
	Tue,  4 Feb 2025 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N2lHj2VN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE2141987
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630034; cv=none; b=fJ7F7TadOFsJ47pLfCNlrj3+mNzJJ3j6jaoxY5EFU4whU2KAHyx1ZZIer2LP4MHKeQApdtOaw+vMU9DLKJeJlVS0tgcT0+J+TZnm7nyQv9QUzTbOuX8Ci43B6sFKKz41+vHbqCQ1gavS58dBC6uHNLYgXjZ5/uPVAC7h9KKDDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630034; c=relaxed/simple;
	bh=EpuCctjzBSciDrFe52O3lPGBzWjnjoM4W/fdHOk0Aa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM7Ao220tL0e7ybAw0zIkD7JnxjhOX9SJNbdc/e7r0hPgpX5AvaD08cKB87D+YbkPLIPb90ZZLDrR4IQN29OwLsYZ53+4XJj8yjlaY4dm2A+aMgxlxiGOTxkLleQ+ITyQS6/Q4LdeiteUrhD6C/xaXLTd67adnkP0Xg5LuOt0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N2lHj2VN; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb3c143727so2920632b6e.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630031; x=1739234831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNPfZawrRXyiOt5qI69T4hmSv+IOSGPy8yQ4YGx4xag=;
        b=N2lHj2VNbhXdhBTj22X1ufvNDxCki8uvzPcDWhsyN2b/2SdRgVmMywafZrcpVllUhi
         DxILwbOkkG7FI3SvAkCYHUuNTMcTuPI9rSU0VsF9HERFlBgMB/mDuirceUBPLgiwhu0A
         75a3BG9wgSMhVUJbt13gjR5R25TzMW+5LKKVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630031; x=1739234831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNPfZawrRXyiOt5qI69T4hmSv+IOSGPy8yQ4YGx4xag=;
        b=LofvorjZRVGXR0t0qx12SbzAVGOwGelcz3n0S0WNwHWaVnrTVyw2v+MH1cj+qNzg/X
         QbjZ5xy7v4r9vZEoTWnPNehbtupR7E5ISTxFWnXfXA+XBWirwRePjlCoPWXdllyLNtBM
         aSh86W7B7ijQsBrbnKagnpr0QMkOvhoGQkRne/rq2kT0P6wg3M7kNy3So2wZxvqakmgb
         /BPif4KdhWb2QRqv6U+ELiRNYyllzh9KKh2USMBtSX56JA7ZM6ibOU0cOsBbt0aVjKrX
         bNboEIKoaJQxoCrPnrp9KQMhyJmH/z8KDZKYejT9UhU6dezM1DJvVI9WwLuPIi//pbe6
         AqtQ==
X-Gm-Message-State: AOJu0Yw/KxYli0jOISL/uO7u6r1Sr3aM8sj7Led1H6Q5pzLq4iaENF83
	S29BDe8Kyr9CuJatvCY3TSd83s2vkP0k4YXtn3zF60Pzx6D0M8S979lQjGGvsg==
X-Gm-Gg: ASbGnct6KC0bL9rPaGZcd7RmvSu2FfICU6VB6Q6n58BLfxdIpJDhL8lxEjwH4TK5dLs
	qOnfQKSvxoU/H6qGRk2OwC3ejs0XJzmb80l29b9x6tCRh8+arMf4gjUE7TCbYMub7B+Ama6HWAk
	dxs4yekAqsjhTz2Q/QiPQ4bdt8NIJiseRrapwGutX7jQicCHA1i6kNK6dXIMh5WNCZmPVcYwQWo
	zNve/89mA6MW8ByGPMrjo36bsSUcQO28qjRfAiVmrPEfEa1GmTOAyt55iX248FxeHhhLqgophkZ
	fl83VTKt2hu2cYLfXNfDH5D3k1c9nur9IidPKMkLSzc9WoXNOcLnOF8tkEGIEhbVrXY=
X-Google-Smtp-Source: AGHT+IH/PJ35ggpc8xJsFNsDboGOMt+GauICQtJqkqkTa6OT+KrVKWAQj8E00S9ugOQXAX7tVxNIfw==
X-Received: by 2002:a05:6870:6f13:b0:297:554:c660 with SMTP id 586e51a60fabf-2b3e7545fd6mr893692fac.9.1738630031410;
        Mon, 03 Feb 2025 16:47:11 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:11 -0800 (PST)
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
	horms@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 08/10] bnxt_en: Reallocate RX completion ring for TPH support
Date: Mon,  3 Feb 2025 16:46:07 -0800
Message-ID: <20250204004609.1107078-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
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
queue_restart.  If TPH is enabled, call FW to free the Rx completion
ring and clear the ring entries in queue_stop().  Re-allocate it in
queue_start() if TPH is enabled.  Note that TPH mode is not enabled
in this patch and will be enabled later in the patch series.

While modifying bnxt_queue_start(), remove the unnecessary zeroing of
rxr->rx_next_cons.  It gets overwritten by the clone in
bnxt_queue_start().

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v3: Only free/allocate the RX cmpl ring when TPH is enabled.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c6cf575af53f..019a8433b0d6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7426,6 +7426,19 @@ static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
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
@@ -15645,9 +15658,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 	if (rc)
 		return rc;
+
+	if (bp->tph_mode) {
+		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
+		if (rc)
+			goto err_free_hwrm_rx_ring;
+	}
+
 	rc = bnxt_hwrm_rx_agg_ring_alloc(bp, rxr);
 	if (rc)
-		goto err_free_hwrm_rx_ring;
+		goto err_free_hwrm_cp_ring;
 
 	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
@@ -15672,6 +15692,9 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
+err_free_hwrm_cp_ring:
+	if (bp->tph_mode)
+		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 err_free_hwrm_rx_ring:
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	return rc;
@@ -15696,11 +15719,15 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
-	rxr->rx_next_cons = 0;
 	page_pool_disable_direct_recycling(rxr->page_pool);
 	if (bnxt_separate_head_pool())
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
+	if (bp->tph_mode) {
+		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
+		bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
+	}
+
 	memcpy(qmem, rxr, sizeof(*rxr));
 	bnxt_init_rx_ring_struct(bp, qmem);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index db0be469a3db..4e20878e7714 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2410,6 +2410,8 @@ struct bnxt {
 	u8			max_q;
 	u8			num_tc;
 
+	u8			tph_mode;
+
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
 
-- 
2.30.1


