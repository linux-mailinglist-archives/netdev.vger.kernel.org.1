Return-Path: <netdev+bounces-164373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFBA2D8A1
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FE01888A06
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536991F3BB7;
	Sat,  8 Feb 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SWyqSlc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CD1F3BB4
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046618; cv=none; b=MX4fJ5C2EQs1joG8Vqo7HW0hvQir1b3s0ZrGX66oUfu1Y0A7h2VBIn9D0Po1FQ6il4lg8V2keBI0r00IjzcZydyUtu8mId3zuHsp4skwcny0kNSgVx72u3gstucXhyTbGO6l1XnqRrqSefMakN/YnvDqt2EKipeFAKW0b0+Mfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046618; c=relaxed/simple;
	bh=EpuCctjzBSciDrFe52O3lPGBzWjnjoM4W/fdHOk0Aa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9Cm3qyFRRljZpYI7uxDM+I41bGy/eEGdjQ0/ggci7iriba6QsF0zUImjM6gk69RCw2khmLE/RmN1OORpSh0bxaRF5NHYoD6wo+Ba8gRD1S3Rmd0PsQ94QNAkZ+p5iD4QcGnaKjw7WH24oSFIogaaU9rJsYjU3Imtk5wnF9hAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SWyqSlc5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e1e051e50so840385a34.0
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046615; x=1739651415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNPfZawrRXyiOt5qI69T4hmSv+IOSGPy8yQ4YGx4xag=;
        b=SWyqSlc5cVOmtxTQ9Z0hM4wQeaC19GFvBU7XlHCQNn6KpeqXCLXLt/DHilvayTeZ9h
         LS5E1FUpoVZuLhBl3b+YA2gEtttk1RiipgJ0I2RgnpT8pmnHj8Xcbm35fqbrFLp5+lWq
         oNMioXHtXZP8Gf/Q/BTNbKKPgKZeOPZOQoQDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046615; x=1739651415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNPfZawrRXyiOt5qI69T4hmSv+IOSGPy8yQ4YGx4xag=;
        b=L4MW76d9DQdlgxde07AccvFzlq0r/qh4T9JvZWDGWZ/wz6t1mlvkxvMmAC09/V24do
         +RBQJquj+lhEz0JQZkFzOFs/NQrako8sad2ycFDT3uGvM9mO8jqn7FFb/9OtwwdJWtCs
         ohSfCLcoQ0FJGpz4/NRN4UZ5hSUvGuhS1WxF5bzVv7BFOXo7L9obIz1QcAsNN7y8+JAk
         K2MjnELrdhewGo0Si7z2SdxAUQMfkFXqTPOXL6DVEH4DKJ7AgtWlRdQy+lrEOB0vUwkZ
         G/8T67GXnPYWvCoMFfwmPNArKTROT9S0n1kH/zckKBWZ00vgseHILOEHJoRlp/icusfD
         R9/A==
X-Gm-Message-State: AOJu0YyvfQOnmq58z7UY7UY9U+mBADHxy2IBl90J9Bq0kMQWbeyfeZI8
	72HikEwChhQB7FRC4Glfe1qK3BtUYkDEcdu5z91dmPRqvrb5LCaaCOcxDKy7/Q==
X-Gm-Gg: ASbGncu4Hs3ibrA1tacYAC1qWde94KdM/rHuSpNhZCg+ourUIkLXG0/exCwvJ5gpa/G
	l2tFESlH4y3xB2oYwKj8dki6EOsAcmyDNB7chglVdHObcZs+raCX8l0yuhX919pUbSaGh4H/2C+
	OuxaEkT7zB0tbhxI5z0NElmeDbWAAH2tkgg5UIH9ZWpAtu9PJ/q8aZZ13fwgv2q56Y2WrwUPezP
	VU8OByoDn+XdZ695Iq5Sz1H6BlPq0MivO6OrPwkpTj8hQNfCLaKnxTv0g/38LSff+xHVE9ux4yQ
	PdIo8u98KHw1Ka8AJrZKrToStjFebPrDQgb4vqYj7PCqqNYJf4k2+RRV2edZIX3rjac=
X-Google-Smtp-Source: AGHT+IFOakMSiQcDjuHWyRiPnV+qinyb2OWw3uxwo3kGZg0CRHCjD2YHRHyJ7UZTFs1ILS7RkGh7Sw==
X-Received: by 2002:a05:6830:d82:b0:71d:eee3:fd1c with SMTP id 46e09a7af769-726b86802c7mr5571211a34.0.1739046614696;
        Sat, 08 Feb 2025 12:30:14 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:13 -0800 (PST)
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
Subject: [PATCH net-next v4 08/10] bnxt_en: Reallocate RX completion ring for TPH support
Date: Sat,  8 Feb 2025 12:29:14 -0800
Message-ID: <20250208202916.1391614-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
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


