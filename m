Return-Path: <netdev+bounces-81831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20488B41C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C2E1F67AF3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D88287C;
	Mon, 25 Mar 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pg4ZUYG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338E839ED
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405779; cv=none; b=MZcQ969/7w9LVXuyI5i9U1qMcUkmOpCHCyACqyPYFc76I6WNASwqjlkKwNyjCSF3qutbIiZQ1y9B8o2/TNE56VZhnea20PuIsNKUGqNJj3P9f1nDQP5CjpNY/7UAGt4w3c+DbtM+aoPBoMV/cPbMi4w0XTiMKZO4wTYRDi5EWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405779; c=relaxed/simple;
	bh=ZxSq0fzId4CL+0Taz5iY88J52A5MWiAR09j9ngQhfDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxxHyzghXTD2slYXvCoPqG/bY/ZIgztMiEk3G+2pqNbu3XXk46a3aaAemLpqZzsIkYEuM1jIuGEv6JF4BgzVan3UHgmYtyfHEliXOzNOwVXsb6Ly8cGoKX5VDIaAK5Xemm1Caz05eKAWnYFbblvC6ktHQE97HCHYJD1YgXIPPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pg4ZUYG4; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3d7e7402dso79597b6e.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405776; x=1712010576; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxDLUXce1vxEVms97uDESMfw01pOql+4v3emFpnJOQA=;
        b=Pg4ZUYG4bUzECjeAI+RJc8OreqtRI7z3lk/Uxx98mI0nRnEc0SRNfahh8/oAdnJa9B
         9FW9IU7FlAx04gDbdEQp5GmwvFz4GwBd7LOV/loa/Rm0F5d22pTr1w+4Yvp6+8+24szZ
         aihbRbd+qln/UQJhptYWSenMwZWKaAKDHFrcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405776; x=1712010576;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxDLUXce1vxEVms97uDESMfw01pOql+4v3emFpnJOQA=;
        b=KV9s1tOdRj+YStv/UC56lAQRqu6/ArXULTbHQApuWteZo8wn/EnoeoRdmJNdusuWia
         8fAn5Zij9Px4FcuwBm5f51SsahsPCnAP5Q4QYdQkbJ7r45Z2Ozy/MLyOVE688C/vK+n4
         y7EebvCbKYYlxBUiHjTHqLoRR3vMi/2SnWdqL857mwi7nn8N0ptw0kkL9GqCRjovEhYs
         OGOE4O0U8TBwIKaYv/7IF3yUIGMPIlFNrW6ErDWc9gmB7EmiTVZNfRMfn5zKMtlMfwZK
         m5Y1Ujoy3kZHZXWtN4ucaUpUozkbc6x3Lsesd+zpKws3Dvj8giLCFHINm5GyNrfnRZW6
         WjLw==
X-Gm-Message-State: AOJu0YzBaSrufk3nabhMnjXW4rEZuowohKugV+/E+fZdCHuCHymd60/V
	tSp5TAVrRpvGFgcDxGYqrc77adCd3yYA4Uudyc/E7afTuHx/9pFMOm8HQUwcRg==
X-Google-Smtp-Source: AGHT+IE0W1YimfA/lr97Lsrv7PRzxmphUy39b/mz8CtIyBs+3vIIlidkvGfzPcwwJqokzPe90NGipA==
X-Received: by 2002:a05:6358:9387:b0:17d:221e:d126 with SMTP id h7-20020a056358938700b0017d221ed126mr9555826rwb.23.1711405775890;
        Mon, 25 Mar 2024 15:29:35 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:34 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 04/12] bnxt_en: Refactor VNIC alloc and cfg functions
Date: Mon, 25 Mar 2024 15:28:54 -0700
Message-Id: <20240325222902.220712-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000060dcf9061483b515"

--00000000000060dcf9061483b515
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

The current VNIC structures are stored in an array bp->vnic_info[].
The index of the array (vnic_id) is passed to all the functions that
need to reference the VNIC.

This patch changes the scheme to pass the VNIC pointer instead of the
vnic index.  Subsequent patches will create additional VNICs that
will not be stored in the bp->vnic_info[] array.  Using the VNIC
pointer will work for all the VNICs.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 140 +++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   2 +-
 3 files changed, 75 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dd2c5033af02..3f5d7c81a281 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4241,6 +4241,7 @@ static void bnxt_init_vnics(struct bnxt *bp)
 		int j;
 
 		vnic->fw_vnic_id = INVALID_HW_RING_ID;
+		vnic->vnic_id = i;
 		for (j = 0; j < BNXT_MAX_CTX_PER_VNIC; j++)
 			vnic->fw_rss_cos_lb_ctx[j] = INVALID_HW_RING_ID;
 
@@ -5938,9 +5939,9 @@ static void bnxt_hwrm_vnic_update_tunl_tpa(struct bnxt *bp,
 	req->tnl_tpa_en_bitmap = cpu_to_le32(tunl_tpa_bmap);
 }
 
-static int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, u16 vnic_id, u32 tpa_flags)
+static int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				  u32 tpa_flags)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	u16 max_aggs = VNIC_TPA_CFG_REQ_MAX_AGGS_MAX;
 	struct hwrm_vnic_tpa_cfg_input *req;
 	int rc;
@@ -6154,9 +6155,9 @@ __bnxt_hwrm_vnic_set_rss(struct bnxt *bp, struct hwrm_vnic_rss_cfg_input *req,
 	req->hash_key_tbl_addr = cpu_to_le64(vnic->rss_hash_key_dma_addr);
 }
 
-static int bnxt_hwrm_vnic_set_rss(struct bnxt *bp, u16 vnic_id, bool set_rss)
+static int bnxt_hwrm_vnic_set_rss(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+				  bool set_rss)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_rss_cfg_input *req;
 	int rc;
 
@@ -6174,9 +6175,9 @@ static int bnxt_hwrm_vnic_set_rss(struct bnxt *bp, u16 vnic_id, bool set_rss)
 	return hwrm_req_send(bp, req);
 }
 
-static int bnxt_hwrm_vnic_set_rss_p5(struct bnxt *bp, u16 vnic_id, bool set_rss)
+static int bnxt_hwrm_vnic_set_rss_p5(struct bnxt *bp,
+				     struct bnxt_vnic_info *vnic, bool set_rss)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_rss_cfg_input *req;
 	dma_addr_t ring_tbl_map;
 	u32 i, nr_ctxs;
@@ -6229,9 +6230,8 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 	hwrm_req_drop(bp, req);
 }
 
-static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, u16 vnic_id)
+static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_plcmodes_cfg_input *req;
 	int rc;
 
@@ -6256,7 +6256,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, u16 vnic_id)
 	return hwrm_req_send(bp, req);
 }
 
-static void bnxt_hwrm_vnic_ctx_free_one(struct bnxt *bp, u16 vnic_id,
+static void bnxt_hwrm_vnic_ctx_free_one(struct bnxt *bp,
+					struct bnxt_vnic_info *vnic,
 					u16 ctx_idx)
 {
 	struct hwrm_vnic_rss_cos_lb_ctx_free_input *req;
@@ -6265,10 +6266,10 @@ static void bnxt_hwrm_vnic_ctx_free_one(struct bnxt *bp, u16 vnic_id,
 		return;
 
 	req->rss_cos_lb_ctx_id =
-		cpu_to_le16(bp->vnic_info[vnic_id].fw_rss_cos_lb_ctx[ctx_idx]);
+		cpu_to_le16(vnic->fw_rss_cos_lb_ctx[ctx_idx]);
 
 	hwrm_req_send(bp, req);
-	bp->vnic_info[vnic_id].fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
+	vnic->fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
 }
 
 static void bnxt_hwrm_vnic_ctx_free(struct bnxt *bp)
@@ -6280,13 +6281,14 @@ static void bnxt_hwrm_vnic_ctx_free(struct bnxt *bp)
 
 		for (j = 0; j < BNXT_MAX_CTX_PER_VNIC; j++) {
 			if (vnic->fw_rss_cos_lb_ctx[j] != INVALID_HW_RING_ID)
-				bnxt_hwrm_vnic_ctx_free_one(bp, i, j);
+				bnxt_hwrm_vnic_ctx_free_one(bp, vnic, j);
 		}
 	}
 	bp->rsscos_nr_ctxs = 0;
 }
 
-static int bnxt_hwrm_vnic_ctx_alloc(struct bnxt *bp, u16 vnic_id, u16 ctx_idx)
+static int bnxt_hwrm_vnic_ctx_alloc(struct bnxt *bp,
+				    struct bnxt_vnic_info *vnic, u16 ctx_idx)
 {
 	struct hwrm_vnic_rss_cos_lb_ctx_alloc_output *resp;
 	struct hwrm_vnic_rss_cos_lb_ctx_alloc_input *req;
@@ -6299,7 +6301,7 @@ static int bnxt_hwrm_vnic_ctx_alloc(struct bnxt *bp, u16 vnic_id, u16 ctx_idx)
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
 	if (!rc)
-		bp->vnic_info[vnic_id].fw_rss_cos_lb_ctx[ctx_idx] =
+		vnic->fw_rss_cos_lb_ctx[ctx_idx] =
 			le16_to_cpu(resp->rss_cos_lb_ctx_id);
 	hwrm_req_drop(bp, req);
 
@@ -6313,10 +6315,9 @@ static u32 bnxt_get_roce_vnic_mode(struct bnxt *bp)
 	return VNIC_CFG_REQ_FLAGS_ROCE_DUAL_VNIC_MODE;
 }
 
-int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
+int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	struct bnxt_vnic_info *vnic0 = &bp->vnic_info[BNXT_VNIC_DEFAULT];
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_cfg_input *req;
 	unsigned int ring = 0, grp_idx;
 	u16 def_vlan = 0;
@@ -6364,8 +6365,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
 	if (vnic->flags & BNXT_VNIC_RSS_FLAG)
 		ring = 0;
 	else if (vnic->flags & BNXT_VNIC_RFS_FLAG)
-		ring = vnic_id - 1;
-	else if ((vnic_id == 1) && BNXT_CHIP_TYPE_NITRO_A0(bp))
+		ring = vnic->vnic_id - 1;
+	else if ((vnic->vnic_id == 1) && BNXT_CHIP_TYPE_NITRO_A0(bp))
 		ring = bp->rx_nr_rings - 1;
 
 	grp_idx = bp->rx_ring[ring].bnapi->index;
@@ -6381,25 +6382,25 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id)
 #endif
 	if ((bp->flags & BNXT_FLAG_STRIP_VLAN) || def_vlan)
 		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE);
-	if (!vnic_id && bnxt_ulp_registered(bp->edev))
+	if (vnic->vnic_id == BNXT_VNIC_DEFAULT && bnxt_ulp_registered(bp->edev))
 		req->flags |= cpu_to_le32(bnxt_get_roce_vnic_mode(bp));
 
 	return hwrm_req_send(bp, req);
 }
 
-static void bnxt_hwrm_vnic_free_one(struct bnxt *bp, u16 vnic_id)
+static void bnxt_hwrm_vnic_free_one(struct bnxt *bp,
+				    struct bnxt_vnic_info *vnic)
 {
-	if (bp->vnic_info[vnic_id].fw_vnic_id != INVALID_HW_RING_ID) {
+	if (vnic->fw_vnic_id != INVALID_HW_RING_ID) {
 		struct hwrm_vnic_free_input *req;
 
 		if (hwrm_req_init(bp, req, HWRM_VNIC_FREE))
 			return;
 
-		req->vnic_id =
-			cpu_to_le32(bp->vnic_info[vnic_id].fw_vnic_id);
+		req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 
 		hwrm_req_send(bp, req);
-		bp->vnic_info[vnic_id].fw_vnic_id = INVALID_HW_RING_ID;
+		vnic->fw_vnic_id = INVALID_HW_RING_ID;
 	}
 }
 
@@ -6408,15 +6409,14 @@ static void bnxt_hwrm_vnic_free(struct bnxt *bp)
 	u16 i;
 
 	for (i = 0; i < bp->nr_vnics; i++)
-		bnxt_hwrm_vnic_free_one(bp, i);
+		bnxt_hwrm_vnic_free_one(bp, &bp->vnic_info[i]);
 }
 
-static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, u16 vnic_id,
+static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 				unsigned int start_rx_ring_idx,
 				unsigned int nr_rings)
 {
 	unsigned int i, j, grp_idx, end_idx = start_rx_ring_idx + nr_rings;
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	struct hwrm_vnic_alloc_output *resp;
 	struct hwrm_vnic_alloc_input *req;
 	int rc;
@@ -6442,7 +6442,7 @@ static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, u16 vnic_id,
 vnic_no_ring_grps:
 	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++)
 		vnic->fw_rss_cos_lb_ctx[i] = INVALID_HW_RING_ID;
-	if (vnic_id == BNXT_VNIC_DEFAULT)
+	if (vnic->vnic_id == BNXT_VNIC_DEFAULT)
 		req->flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_DEFAULT);
 
 	resp = hwrm_req_hold(bp, req);
@@ -9676,7 +9676,7 @@ static int bnxt_set_tpa(struct bnxt *bp, bool set_tpa)
 	else if (BNXT_NO_FW_ACCESS(bp))
 		return 0;
 	for (i = 0; i < bp->nr_vnics; i++) {
-		rc = bnxt_hwrm_vnic_set_tpa(bp, i, tpa_flags);
+		rc = bnxt_hwrm_vnic_set_tpa(bp, &bp->vnic_info[i], tpa_flags);
 		if (rc) {
 			netdev_err(bp->dev, "hwrm vnic set tpa failure rc for vnic %d: %x\n",
 				   i, rc);
@@ -9691,7 +9691,7 @@ static void bnxt_hwrm_clear_vnic_rss(struct bnxt *bp)
 	int i;
 
 	for (i = 0; i < bp->nr_vnics; i++)
-		bnxt_hwrm_vnic_set_rss(bp, i, false);
+		bnxt_hwrm_vnic_set_rss(bp, &bp->vnic_info[i], false);
 }
 
 static void bnxt_clear_vnic(struct bnxt *bp)
@@ -9769,28 +9769,27 @@ static int bnxt_hwrm_set_cache_line_size(struct bnxt *bp, int size)
 	return hwrm_req_send(bp, req);
 }
 
-static int __bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
+static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[vnic_id];
 	int rc;
 
 	if (vnic->flags & BNXT_VNIC_RFS_NEW_RSS_FLAG)
 		goto skip_rss_ctx;
 
 	/* allocate context for vnic */
-	rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic_id, 0);
+	rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic, 0);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic %d alloc failure rc: %x\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 		goto vnic_setup_err;
 	}
 	bp->rsscos_nr_ctxs++;
 
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-		rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic_id, 1);
+		rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic, 1);
 		if (rc) {
 			netdev_err(bp->dev, "hwrm vnic %d cos ctx alloc failure rc: %x\n",
-				   vnic_id, rc);
+				   vnic->vnic_id, rc);
 			goto vnic_setup_err;
 		}
 		bp->rsscos_nr_ctxs++;
@@ -9798,26 +9797,26 @@ static int __bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
 
 skip_rss_ctx:
 	/* configure default vnic, ring grp */
-	rc = bnxt_hwrm_vnic_cfg(bp, vnic_id);
+	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic %d cfg failure rc: %x\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 		goto vnic_setup_err;
 	}
 
 	/* Enable RSS hashing on vnic */
-	rc = bnxt_hwrm_vnic_set_rss(bp, vnic_id, true);
+	rc = bnxt_hwrm_vnic_set_rss(bp, vnic, true);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %x\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 		goto vnic_setup_err;
 	}
 
 	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
-		rc = bnxt_hwrm_vnic_set_hds(bp, vnic_id);
+		rc = bnxt_hwrm_vnic_set_hds(bp, vnic);
 		if (rc) {
 			netdev_err(bp->dev, "hwrm vnic %d set hds failure rc: %x\n",
-				   vnic_id, rc);
+				   vnic->vnic_id, rc);
 		}
 	}
 
@@ -9825,33 +9824,33 @@ static int __bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
 	return rc;
 }
 
-int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, u16 vnic_id)
+int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	int rc;
 
-	rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic_id, true);
+	rc = bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic %d set rss failure rc: %d\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 		return rc;
 	}
-	rc = bnxt_hwrm_vnic_cfg(bp, vnic_id);
+	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
 	if (rc)
 		netdev_err(bp->dev, "hwrm vnic %d cfg failure rc: %x\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 	return rc;
 }
 
-static int __bnxt_setup_vnic_p5(struct bnxt *bp, u16 vnic_id)
+static int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	int rc, i, nr_ctxs;
 
 	nr_ctxs = bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings);
 	for (i = 0; i < nr_ctxs; i++) {
-		rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic_id, i);
+		rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic, i);
 		if (rc) {
 			netdev_err(bp->dev, "hwrm vnic %d ctx %d alloc failure rc: %x\n",
-				   vnic_id, i, rc);
+				   vnic->vnic_id, i, rc);
 			break;
 		}
 		bp->rsscos_nr_ctxs++;
@@ -9859,55 +9858,57 @@ static int __bnxt_setup_vnic_p5(struct bnxt *bp, u16 vnic_id)
 	if (i < nr_ctxs)
 		return -ENOMEM;
 
-	rc = bnxt_hwrm_vnic_rss_cfg_p5(bp, vnic_id);
+	rc = bnxt_hwrm_vnic_rss_cfg_p5(bp, vnic);
 	if (rc)
 		return rc;
 
 	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
-		rc = bnxt_hwrm_vnic_set_hds(bp, vnic_id);
+		rc = bnxt_hwrm_vnic_set_hds(bp, vnic);
 		if (rc) {
 			netdev_err(bp->dev, "hwrm vnic %d set hds failure rc: %x\n",
-				   vnic_id, rc);
+				   vnic->vnic_id, rc);
 		}
 	}
 	return rc;
 }
 
-static int bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
+static int bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		return __bnxt_setup_vnic_p5(bp, vnic_id);
+		return __bnxt_setup_vnic_p5(bp, vnic);
 	else
-		return __bnxt_setup_vnic(bp, vnic_id);
+		return __bnxt_setup_vnic(bp, vnic);
 }
 
-static int bnxt_alloc_and_setup_vnic(struct bnxt *bp, u16 vnic_id,
+static int bnxt_alloc_and_setup_vnic(struct bnxt *bp,
+				     struct bnxt_vnic_info *vnic,
 				     u16 start_rx_ring_idx, int rx_rings)
 {
 	int rc;
 
-	rc = bnxt_hwrm_vnic_alloc(bp, vnic_id, start_rx_ring_idx, rx_rings);
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic, start_rx_ring_idx, rx_rings);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic %d alloc failure rc: %x\n",
-			   vnic_id, rc);
+			   vnic->vnic_id, rc);
 		return rc;
 	}
-	return bnxt_setup_vnic(bp, vnic_id);
+	return bnxt_setup_vnic(bp, vnic);
 }
 
 static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 {
+	struct bnxt_vnic_info *vnic;
 	int i, rc = 0;
 
-	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
-		return bnxt_alloc_and_setup_vnic(bp, BNXT_VNIC_NTUPLE, 0,
-						 bp->rx_nr_rings);
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp)) {
+		vnic = &bp->vnic_info[BNXT_VNIC_NTUPLE];
+		return bnxt_alloc_and_setup_vnic(bp, vnic, 0, bp->rx_nr_rings);
+	}
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return 0;
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-		struct bnxt_vnic_info *vnic;
 		u16 vnic_id = i + 1;
 		u16 ring_id = i;
 
@@ -9918,7 +9919,7 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 		vnic->flags |= BNXT_VNIC_RFS_FLAG;
 		if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 			vnic->flags |= BNXT_VNIC_RFS_NEW_RSS_FLAG;
-		if (bnxt_alloc_and_setup_vnic(bp, vnic_id, ring_id, 1))
+		if (bnxt_alloc_and_setup_vnic(bp, &bp->vnic_info[vnic_id], ring_id, 1))
 			break;
 	}
 	return rc;
@@ -9936,16 +9937,17 @@ static bool bnxt_promisc_ok(struct bnxt *bp)
 
 static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 {
+	struct bnxt_vnic_info *vnic = &bp->vnic_info[1];
 	unsigned int rc = 0;
 
-	rc = bnxt_hwrm_vnic_alloc(bp, 1, bp->rx_nr_rings - 1, 1);
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic, bp->rx_nr_rings - 1, 1);
 	if (rc) {
 		netdev_err(bp->dev, "Cannot allocate special vnic for NS2 A0: %x\n",
 			   rc);
 		return rc;
 	}
 
-	rc = bnxt_hwrm_vnic_cfg(bp, 1);
+	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
 	if (rc) {
 		netdev_err(bp->dev, "Cannot allocate special vnic for NS2 A0: %x\n",
 			   rc);
@@ -9988,7 +9990,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		rx_nr_rings--;
 
 	/* default vnic 0 */
-	rc = bnxt_hwrm_vnic_alloc(bp, BNXT_VNIC_DEFAULT, 0, rx_nr_rings);
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, rx_nr_rings);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic alloc failure rc: %x\n", rc);
 		goto err_out;
@@ -9997,7 +9999,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	if (BNXT_VF(bp))
 		bnxt_hwrm_func_qcfg(bp);
 
-	rc = bnxt_setup_vnic(bp, BNXT_VNIC_DEFAULT);
+	rc = bnxt_setup_vnic(bp, vnic);
 	if (rc)
 		goto err_out;
 	if (bp->rss_cap & BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fbb53308cb81..81460a96c0dd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1256,6 +1256,7 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_UCAST_FLAG	8
 #define BNXT_VNIC_RFS_NEW_RSS_FLAG	0x10
 #define BNXT_VNIC_NTUPLE_FLAG		0x20
+	u32		vnic_id;
 };
 
 struct bnxt_hw_rings {
@@ -2695,7 +2696,7 @@ int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 				      struct bnxt_ntuple_filter *fltr);
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
-int bnxt_hwrm_vnic_cfg(struct bnxt *bp, u16 vnic_id);
+int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
@@ -2721,7 +2722,7 @@ int bnxt_hwrm_free_wol_fltr(struct bnxt *bp);
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
-int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, u16 vnic_id);
+int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 93f9bd55020f..86dcd2c76587 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -71,7 +71,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	rcu_assign_pointer(ulp->ulp_ops, ulp_ops);
 
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
-		bnxt_hwrm_vnic_cfg(bp, 0);
+		bnxt_hwrm_vnic_cfg(bp, &bp->vnic_info[BNXT_VNIC_DEFAULT]);
 
 	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
-- 
2.30.1


--00000000000060dcf9061483b515
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHrT81uxqkMSgdUIUbZJFyRciHZVlAHY
XLwg55Y13X1NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjkzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB460h3mW3gIHkVaO8woApuzidHg3pN3jIEY8G0vEOx+qhXlvrQ
Y0eSaPODobGqFv0V0Qoqq3aJ/1uCP3txdIE52dY8Gi75YISMfPuN/mr/1QV0IL+5u0/ihWgz7kXI
PPjeUse6QF8xerrPT0ucr+tyRH94BqKSb/16DZCxuQsPV30qBboPn1DVhaH5euNdZGF+aAR6BlBo
/mmSwzUeUGPGatMBglewWpu/YQX3SkG9YTYxrAsBqqPnF63VXP3cmXGh6NM6+mST/dcrlAsxNCwg
bASWF5GwdenfUPH6DARmSDBlhGVNDLOdO1lCdG/U66j+COdSC1aBFePsgi0DAv3u
--00000000000060dcf9061483b515--

