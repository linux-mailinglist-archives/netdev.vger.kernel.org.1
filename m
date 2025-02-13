Return-Path: <netdev+bounces-165756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAEA33476
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B31663D4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54C139566;
	Thu, 13 Feb 2025 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MpUYoqhd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0A14831C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409221; cv=none; b=bmvXI5822LlrIf6OPmnq3nsTEXmsQApPztT50p5hVxqnW88m1YZprhI62wI2WJUNWCJ38NYf+lTwd2SQqcMDFnDT6GKvqzitrIhUno+utEM1af2EJ/X/4JJKJpwFUNyXVlblZFSFuiEQGoV6EQ+VYNlunwOYSdUOZOTcQHhP+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409221; c=relaxed/simple;
	bh=hpi06z8m58JGcyJPDP4kwpNgO2LiYOdW9xnp7xS7QfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXBM8R20yFmHzpiourQB1C8z6/7D20UA5/YA8VNLISp+rx17vWvrQZrVqFXuzOArh6UO0OJ1qQ2gElCFPOlcITCPy8maT1ViyfJG9isGPE1rH/kWIkktRNnTW1lXq48hgu1OxNUJliBvrMfQ7XAIw5qVKQxm692Ic9LcqW3mlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MpUYoqhd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-726819aa651so156140a34.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409218; x=1740014018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMZaiXwf/CDrdAxd9HUemEUI3z0hjO8BGgDx5GB81as=;
        b=MpUYoqhd1mPHPzqSwFyexyGox6a75/q2TO42GFgoEIjU6wIIFC/EMLkk2WSJv1F6hU
         sJ+a4XWZSNh8vwwb56krQkS3fcrDa6Vxu8z7KFdZ6rdA5/YwPpp8Lpyp9brRnIy2AQ3J
         Mk2bIVtImOHA3ostrg0ml5zUSN3pPSRNkdt+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409218; x=1740014018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMZaiXwf/CDrdAxd9HUemEUI3z0hjO8BGgDx5GB81as=;
        b=cX8DwY7fv0/Zs2PN48KSu68m4UUSXADUrDkMRu2waaMAN2PqBSwV1FNTbIX2K21qPO
         ngEjTugvyLHq1IA3pvDqFA/Pc4Dec22kwTcY+3fCapRaRhWu6bXo5rr28NivPddX2IRf
         wDKzocOTbTl74iK1dIEPVoXuqSZnIgKfKWO/aURLE8iCVBtua7F8MEQdhCm9Sbq5Oaeg
         uFbHVJRY4P+B2mugaIFtZx/O/vYHN06Z30eaPwlK+gTeD/tQo/lHLWMwa3upuVUzpJof
         D1K+4F5KvT2tUqLC4+40aSsKIrHO+cjW7Oesh9V2FirY3T2u4dSgqa5TuWM7LoIIbG60
         MX5g==
X-Gm-Message-State: AOJu0YxhEMxD2oGm8gS7XH3Qs9apckl7yMmihV72c7BOkhjcJZCrsiLy
	AXfuuNbQszU+eLDbqZNJDmL3N0VEgs0/e9WEKtp5BpViuYMqxTHbe86l/zj3Ug==
X-Gm-Gg: ASbGnct2964UvfuWeylhUGEMh0U4mdI75YZhHeGzTiXhZ6zeerZd4bev3DqtG0hyER3
	SfJVBjwU22iNbm6yC9jcnFgBl9XiQfBpmPF3WLcjElEMwBFWtJdOSaqlq9UjP1cuTdrgYZFYEA9
	O4IiOmNf88NobAlLlA+ztp8Nfwaes0Gm8ll0WoIOXd12DtyLzORZrbCeHBXseNNbGLdu6OLuoEw
	2Ni4dK9Y39b+i+WBDXKOk+pcRGJU42x6ckPqfO+9ie+pX0qUDFSUJKqilEyu3IWkgc9Qrj3c86e
	6VskB7Pn0DvgrIR8pCP7HofA4HayBGCo1EQj4Fh6SARhlK9RX4eXcTsC2V3AKrlTdOA=
X-Google-Smtp-Source: AGHT+IGbt0wrTSzAw3Ps/iywBOo476FnZCfBwYcrEOaZF5dNtIZfSqdCM/7akXOTE+XQY+WamPOIbQ==
X-Received: by 2002:a05:6830:6f84:b0:726:ef21:ef33 with SMTP id 46e09a7af769-726f1c36eb3mr4014913a34.4.1739409218413;
        Wed, 12 Feb 2025 17:13:38 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:37 -0800 (PST)
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
Subject: [PATCH net-next v5 08/11] bnxt_en: Reallocate RX completion ring for TPH support
Date: Wed, 12 Feb 2025 17:12:36 -0800
Message-ID: <20250213011240.1640031-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
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
bnxt_queue_start().  Remove the rx_reset counter increment since
restart is not reset.  Add comment to clarify that the ring
allocations in queue_start should never fail.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: David Wei <dw@davidwei.uk>

v5:
Remove reset counter increment.
Add comment to clarify ring alloc should always succeed in this codepath.

v3: Only free/allocate the RX cmpl ring when TPH is enabled.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 38 +++++++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c6cf575af53f..04980718c287 100644
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
@@ -15623,7 +15636,6 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
-	struct bnxt_cp_ring_info *cpr;
 	struct bnxt_vnic_info *vnic;
 	int i, rc;
 
@@ -15642,20 +15654,27 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
+	/* All rings have been reserved and previously allocated.
+	 * Reallocating with the same parameters should never fail.
+	 */
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
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
-	cpr = &rxr->bnapi->cp_ring;
-	cpr->sw_stats->rx.rx_resets++;
-
 	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
 		vnic = &bp->vnic_info[i];
 
@@ -15672,6 +15691,9 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 
 	return 0;
 
+err_free_hwrm_cp_ring:
+	if (bp->tph_mode)
+		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
 err_free_hwrm_rx_ring:
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	return rc;
@@ -15696,11 +15718,15 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
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


