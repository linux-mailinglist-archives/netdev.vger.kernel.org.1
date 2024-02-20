Return-Path: <netdev+bounces-73460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D685CBA9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B9F28443F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2015443C;
	Tue, 20 Feb 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GfRkfvb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184715442A
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470227; cv=none; b=pMPoVQYj/TD3KLTibb4rphT/lUtWl1/4kYronBI/Y72jCwyaohEJ6r5pJl25rFu+brLvS4k7VZlXHewsw8GV9iaXRUWNupSHxO+TLeqkxVZkCwKielvFlvo0oAiA87BNqFsj9RWsqkmNRJoZAnu2Twp+0c6EvUro59JHwAzIvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470227; c=relaxed/simple;
	bh=jU1XHuUXWM/iNzExQZnBWc80i85nfaaf2NZZwwjrxmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tqqc0HMYo9E+Rd6v3qBLmc7YwkFvFdkB+ZreKB+80v0R187MDk/ZFMntbFbAkU5cszSOQH1c29lLFmuUZbdCYI9hYNjfJKhN9r6OaADnJ1+8t5kf+AX4RRZPyE248BF7Uk5oLWbZO0OEpdOJO80SFmjlGYu40VkVWr4rrEd2Vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GfRkfvb9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7877dd9cb40so60321785a.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470224; x=1709075024; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi3BEdYqTl4L4cqY0IQjEmZG0FZ9r9qTI05FqkIn8X8=;
        b=GfRkfvb9gab0oMRIUEFjsDKA+rqdahwGNE+VXm8p8I1aa4UAQcYOEw9VSLjj/aZ8Nr
         3qVcdzFXjuGWvTA6w0WBHYI4C1YyHdUJgWvVUDmTWRq+i4P7DpO9XLx2racmmmDlJ5vG
         4HApXLkGQeFidsdrbDTwFLCsi9b7sUgmjOzg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470224; x=1709075024;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi3BEdYqTl4L4cqY0IQjEmZG0FZ9r9qTI05FqkIn8X8=;
        b=r9bjuCk3F32w/ckdjbJpxgrDtxfMplYXB1wo5DbmnHLaiKFuOG0YXxr6XaL3AWEWY1
         6T1ViK5diOTziF2fRYGLYsjN/lhQhlrq8Tdk3qZI6/vkETP6+7hgi7rFVsXmZ0KanDm6
         VUY+gapPUvf+fvjU4RbN258ccrEHETdLnQ8bDn/77rWRMt2Syn/Se5fgBLUyqHEm8U7I
         ILMl541wO6YGE2VnDHhoq322ZsjL67vH4Vu7erYO232DaeELKpjy1i6r4z69nbBrqtVs
         sq+IyXjmubdKCBWDbzfqe6jsENolBluqi1vb/IrnkBhCMYsyyeJ9k68Kd9qSEEYABJmg
         dlgg==
X-Gm-Message-State: AOJu0Yz7dZbqmYccI3sIBC/oqqlK3Fp/Ziutem5Muyvrl6OE3+zH9Ig+
	hcBCugoyFRP1mBt7qC3jnFxWAtgDxMrllZCJmWlYuqpAdopTFf0CwfwXfuE/Ug==
X-Google-Smtp-Source: AGHT+IEoqnLEPMMZfC1Vg9h6+CoIHo9YnaulgqYlv8QeYvah7E3h+tXS4fJMevAjr2BK2eIcLNk71w==
X-Received: by 2002:a05:620a:a42:b0:787:2dfe:2a2e with SMTP id j2-20020a05620a0a4200b007872dfe2a2emr19929509qka.56.1708470224050;
        Tue, 20 Feb 2024 15:03:44 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:43 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 01/10] bnxt_en: Refactor ring reservation functions
Date: Tue, 20 Feb 2024 15:03:08 -0800
Message-Id: <20240220230317.96341-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240220230317.96341-1-michael.chan@broadcom.com>
References: <20240220230317.96341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ddfe520611d8386e"

--000000000000ddfe520611d8386e
Content-Transfer-Encoding: 8bit

The current functions to reserve hardware rings pass in 6 different ring
or resource types as parameters.  Add a structure bnxt_hw_rings to
consolidate all these parameters and pass the structure pointer instead
to these functions.  Add 2 related helper functions also.  This makes
the code cleaner and makes it easier to add new resources to be
reserved.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 253 +++++++++++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   9 +
 2 files changed, 132 insertions(+), 130 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6f415425dc14..4a30eff0791b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7098,8 +7098,7 @@ int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings)
 static bool bnxt_rfs_supported(struct bnxt *bp);
 
 static struct hwrm_func_cfg_input *
-__bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-			     int ring_grps, int cp_rings, int stats, int vnics)
+__bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
@@ -7108,52 +7107,51 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
-	enables |= tx_rings ? FUNC_CFG_REQ_ENABLES_NUM_TX_RINGS : 0;
-	req->num_tx_rings = cpu_to_le16(tx_rings);
+	enables |= hwr->tx ? FUNC_CFG_REQ_ENABLES_NUM_TX_RINGS : 0;
+	req->num_tx_rings = cpu_to_le16(hwr->tx);
 	if (BNXT_NEW_RM(bp)) {
-		enables |= rx_rings ? FUNC_CFG_REQ_ENABLES_NUM_RX_RINGS : 0;
-		enables |= stats ? FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
+		enables |= hwr->rx ? FUNC_CFG_REQ_ENABLES_NUM_RX_RINGS : 0;
+		enables |= hwr->stat ? FUNC_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			enables |= cp_rings ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
-			enables |= tx_rings + ring_grps ?
+			enables |= hwr->cp ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
+			enables |= hwr->tx + hwr->grp ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
-			enables |= rx_rings ?
-				FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
+			enables |= hwr->rx ?
+				   FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 		} else {
-			enables |= cp_rings ?
+			enables |= hwr->cp ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
-			enables |= ring_grps ?
+			enables |= hwr->grp ?
 				   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS |
 				   FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 		}
-		enables |= vnics ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
+		enables |= hwr->vnic ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
 
-		req->num_rx_rings = cpu_to_le16(rx_rings);
+		req->num_rx_rings = cpu_to_le16(hwr->rx);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, ring_grps);
+			u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
 
-			req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
-			req->num_msix = cpu_to_le16(cp_rings);
+			req->num_cmpl_rings = cpu_to_le16(hwr->tx + hwr->grp);
+			req->num_msix = cpu_to_le16(hwr->cp);
 			req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 		} else {
-			req->num_cmpl_rings = cpu_to_le16(cp_rings);
-			req->num_hw_ring_grps = cpu_to_le16(ring_grps);
+			req->num_cmpl_rings = cpu_to_le16(hwr->cp);
+			req->num_hw_ring_grps = cpu_to_le16(hwr->grp);
 			req->num_rsscos_ctxs = cpu_to_le16(1);
 			if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) &&
 			    bnxt_rfs_supported(bp))
 				req->num_rsscos_ctxs =
-					cpu_to_le16(ring_grps + 1);
+					cpu_to_le16(hwr->grp + 1);
 		}
-		req->num_stat_ctxs = cpu_to_le16(stats);
-		req->num_vnics = cpu_to_le16(vnics);
+		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
+		req->num_vnics = cpu_to_le16(hwr->vnic);
 	}
 	req->enables = cpu_to_le32(enables);
 	return req;
 }
 
 static struct hwrm_func_vf_cfg_input *
-__bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-			     int ring_grps, int cp_rings, int stats, int vnics)
+__bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_vf_cfg_input *req;
 	u32 enables = 0;
@@ -7161,51 +7159,48 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	if (hwrm_req_init(bp, req, HWRM_FUNC_VF_CFG))
 		return NULL;
 
-	enables |= tx_rings ? FUNC_VF_CFG_REQ_ENABLES_NUM_TX_RINGS : 0;
-	enables |= rx_rings ? FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS |
-			      FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
-	enables |= stats ? FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
+	enables |= hwr->tx ? FUNC_VF_CFG_REQ_ENABLES_NUM_TX_RINGS : 0;
+	enables |= hwr->rx ? FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS |
+			     FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
+	enables |= hwr->stat ? FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		enables |= tx_rings + ring_grps ?
+		enables |= hwr->tx + hwr->grp ?
 			   FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
 	} else {
-		enables |= cp_rings ?
-			   FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
-		enables |= ring_grps ?
+		enables |= hwr->cp ? FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
+		enables |= hwr->grp ?
 			   FUNC_VF_CFG_REQ_ENABLES_NUM_HW_RING_GRPS : 0;
 	}
-	enables |= vnics ? FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS : 0;
+	enables |= hwr->vnic ? FUNC_VF_CFG_REQ_ENABLES_NUM_VNICS : 0;
 	enables |= FUNC_VF_CFG_REQ_ENABLES_NUM_L2_CTXS;
 
 	req->num_l2_ctxs = cpu_to_le16(BNXT_VF_MAX_L2_CTX);
-	req->num_tx_rings = cpu_to_le16(tx_rings);
-	req->num_rx_rings = cpu_to_le16(rx_rings);
+	req->num_tx_rings = cpu_to_le16(hwr->tx);
+	req->num_rx_rings = cpu_to_le16(hwr->rx);
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, ring_grps);
+		u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
 
-		req->num_cmpl_rings = cpu_to_le16(tx_rings + ring_grps);
+		req->num_cmpl_rings = cpu_to_le16(hwr->tx + hwr->grp);
 		req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 	} else {
-		req->num_cmpl_rings = cpu_to_le16(cp_rings);
-		req->num_hw_ring_grps = cpu_to_le16(ring_grps);
+		req->num_cmpl_rings = cpu_to_le16(hwr->cp);
+		req->num_hw_ring_grps = cpu_to_le16(hwr->grp);
 		req->num_rsscos_ctxs = cpu_to_le16(BNXT_VF_MAX_RSS_CTX);
 	}
-	req->num_stat_ctxs = cpu_to_le16(stats);
-	req->num_vnics = cpu_to_le16(vnics);
+	req->num_stat_ctxs = cpu_to_le16(hwr->stat);
+	req->num_vnics = cpu_to_le16(hwr->vnic);
 
 	req->enables = cpu_to_le32(enables);
 	return req;
 }
 
 static int
-bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-			   int ring_grps, int cp_rings, int stats, int vnics)
+bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
 	int rc;
 
-	req = __bnxt_hwrm_reserve_pf_rings(bp, tx_rings, rx_rings, ring_grps,
-					   cp_rings, stats, vnics);
+	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	if (!req)
 		return -ENOMEM;
 
@@ -7219,25 +7214,23 @@ bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 		return rc;
 
 	if (bp->hwrm_spec_code < 0x10601)
-		bp->hw_resc.resv_tx_rings = tx_rings;
+		bp->hw_resc.resv_tx_rings = hwr->tx;
 
 	return bnxt_hwrm_get_rings(bp);
 }
 
 static int
-bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-			   int ring_grps, int cp_rings, int stats, int vnics)
+bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_vf_cfg_input *req;
 	int rc;
 
 	if (!BNXT_NEW_RM(bp)) {
-		bp->hw_resc.resv_tx_rings = tx_rings;
+		bp->hw_resc.resv_tx_rings = hwr->tx;
 		return 0;
 	}
 
-	req = __bnxt_hwrm_reserve_vf_rings(bp, tx_rings, rx_rings, ring_grps,
-					   cp_rings, stats, vnics);
+	req = __bnxt_hwrm_reserve_vf_rings(bp, hwr);
 	if (!req)
 		return -ENOMEM;
 
@@ -7248,15 +7241,12 @@ bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	return bnxt_hwrm_get_rings(bp);
 }
 
-static int bnxt_hwrm_reserve_rings(struct bnxt *bp, int tx, int rx, int grp,
-				   int cp, int stat, int vnic)
+static int bnxt_hwrm_reserve_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	if (BNXT_PF(bp))
-		return bnxt_hwrm_reserve_pf_rings(bp, tx, rx, grp, cp, stat,
-						  vnic);
+		return bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	else
-		return bnxt_hwrm_reserve_vf_rings(bp, tx, rx, grp, cp, stat,
-						  vnic);
+		return bnxt_hwrm_reserve_vf_rings(bp, hwr);
 }
 
 int bnxt_nq_rings_in_use(struct bnxt *bp)
@@ -7352,47 +7342,60 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 	return false;
 }
 
-static int __bnxt_reserve_rings(struct bnxt *bp)
+static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	int cp = bnxt_nq_rings_in_use(bp);
-	int tx = bp->tx_nr_rings;
-	int rx = bp->rx_nr_rings;
-	int grp, rx_rings, rc;
-	int vnic = 1, stat;
+
+	hwr->tx = hw_resc->resv_tx_rings;
+	if (BNXT_NEW_RM(bp)) {
+		hwr->rx = hw_resc->resv_rx_rings;
+		hwr->cp = hw_resc->resv_irqs;
+		hwr->grp = hw_resc->resv_hw_ring_grps;
+		hwr->vnic = hw_resc->resv_vnics;
+		hwr->stat = hw_resc->resv_stat_ctxs;
+	}
+}
+
+static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
+{
+	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
+	       hwr->stat;
+}
+
+static int __bnxt_reserve_rings(struct bnxt *bp)
+{
+	struct bnxt_hw_rings hwr = {0};
+	int rx_rings, rc;
 	bool sh = false;
 	int tx_cp;
 
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
+	hwr.cp = bnxt_nq_rings_in_use(bp);
+	hwr.tx = bp->tx_nr_rings;
+	hwr.rx = bp->rx_nr_rings;
+	hwr.vnic = 1;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
 	if ((bp->flags & BNXT_FLAG_RFS) &&
 	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
-		vnic = rx + 1;
+		hwr.vnic = hwr.rx + 1;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		rx <<= 1;
-	grp = bp->rx_nr_rings;
-	stat = bnxt_get_func_stat_ctxs(bp);
+		hwr.rx <<= 1;
+	hwr.grp = bp->rx_nr_rings;
+	hwr.stat = bnxt_get_func_stat_ctxs(bp);
 
-	rc = bnxt_hwrm_reserve_rings(bp, tx, rx, grp, cp, stat, vnic);
+	rc = bnxt_hwrm_reserve_rings(bp, &hwr);
 	if (rc)
 		return rc;
 
-	tx = hw_resc->resv_tx_rings;
-	if (BNXT_NEW_RM(bp)) {
-		rx = hw_resc->resv_rx_rings;
-		cp = hw_resc->resv_irqs;
-		grp = hw_resc->resv_hw_ring_grps;
-		vnic = hw_resc->resv_vnics;
-		stat = hw_resc->resv_stat_ctxs;
-	}
+	bnxt_copy_reserved_rings(bp, &hwr);
 
-	rx_rings = rx;
+	rx_rings = hwr.rx;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
-		if (rx >= 2) {
-			rx_rings = rx >> 1;
+		if (hwr.rx >= 2) {
+			rx_rings = hwr.rx >> 1;
 		} else {
 			if (netif_running(bp->dev))
 				return -ENOMEM;
@@ -7404,17 +7407,17 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 			bnxt_set_ring_params(bp);
 		}
 	}
-	rx_rings = min_t(int, rx_rings, grp);
-	cp = min_t(int, cp, bp->cp_nr_rings);
-	if (stat > bnxt_get_ulp_stat_ctxs(bp))
-		stat -= bnxt_get_ulp_stat_ctxs(bp);
-	cp = min_t(int, cp, stat);
-	rc = bnxt_trim_rings(bp, &rx_rings, &tx, cp, sh);
+	rx_rings = min_t(int, rx_rings, hwr.grp);
+	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);
+	if (hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
+		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
+	hwr.cp = min_t(int, hwr.cp, hwr.stat);
+	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		rx = rx_rings << 1;
-	tx_cp = bnxt_num_tx_to_cp(bp, tx);
-	cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
-	bp->tx_nr_rings = tx;
+		hwr.rx = rx_rings << 1;
+	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
+	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
+	bp->tx_nr_rings = hwr.tx;
 
 	/* If we cannot reserve all the RX rings, reset the RSS map only
 	 * if absolutely necessary
@@ -7431,9 +7434,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		}
 	}
 	bp->rx_nr_rings = rx_rings;
-	bp->cp_nr_rings = cp;
+	bp->cp_nr_rings = hwr.cp;
 
-	if (!tx || !rx || !cp || !grp || !vnic || !stat)
+	if (!bnxt_rings_ok(bp, &hwr))
 		return -ENOMEM;
 
 	if (!netif_is_rxfh_configured(bp->dev))
@@ -7442,9 +7445,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-				    int ring_grps, int cp_rings, int stats,
-				    int vnics)
+static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_vf_cfg_input *req;
 	u32 flags;
@@ -7452,8 +7453,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	if (!BNXT_NEW_RM(bp))
 		return 0;
 
-	req = __bnxt_hwrm_reserve_vf_rings(bp, tx_rings, rx_rings, ring_grps,
-					   cp_rings, stats, vnics);
+	req = __bnxt_hwrm_reserve_vf_rings(bp, hwr);
 	flags = FUNC_VF_CFG_REQ_FLAGS_TX_ASSETS_TEST |
 		FUNC_VF_CFG_REQ_FLAGS_RX_ASSETS_TEST |
 		FUNC_VF_CFG_REQ_FLAGS_CMPL_ASSETS_TEST |
@@ -7467,15 +7467,12 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	return hwrm_req_send_silent(bp, req);
 }
 
-static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-				    int ring_grps, int cp_rings, int stats,
-				    int vnics)
+static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
 	u32 flags;
 
-	req = __bnxt_hwrm_reserve_pf_rings(bp, tx_rings, rx_rings, ring_grps,
-					   cp_rings, stats, vnics);
+	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
 	if (BNXT_NEW_RM(bp)) {
 		flags |= FUNC_CFG_REQ_FLAGS_RX_ASSETS_TEST |
@@ -7493,20 +7490,15 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	return hwrm_req_send_silent(bp, req);
 }
 
-static int bnxt_hwrm_check_rings(struct bnxt *bp, int tx_rings, int rx_rings,
-				 int ring_grps, int cp_rings, int stats,
-				 int vnics)
+static int bnxt_hwrm_check_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	if (bp->hwrm_spec_code < 0x10801)
 		return 0;
 
 	if (BNXT_PF(bp))
-		return bnxt_hwrm_check_pf_rings(bp, tx_rings, rx_rings,
-						ring_grps, cp_rings, stats,
-						vnics);
+		return bnxt_hwrm_check_pf_rings(bp, hwr);
 
-	return bnxt_hwrm_check_vf_rings(bp, tx_rings, rx_rings, ring_grps,
-					cp_rings, stats, vnics);
+	return bnxt_hwrm_check_vf_rings(bp, hwr);
 }
 
 static void bnxt_hwrm_coal_params_qcaps(struct bnxt *bp)
@@ -12342,21 +12334,22 @@ static bool bnxt_rfs_supported(struct bnxt *bp)
 /* If runtime conditions support RFS */
 static bool bnxt_rfs_capable(struct bnxt *bp)
 {
-	int vnics, max_vnics, max_rss_ctxs;
+	struct bnxt_hw_rings hwr = {0};
+	int max_vnics, max_rss_ctxs;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return bnxt_rfs_supported(bp);
 	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
 
-	vnics = 1 + bp->rx_nr_rings;
+	hwr.vnic = 1 + bp->rx_nr_rings;
 	max_vnics = bnxt_get_max_func_vnics(bp);
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
 
 	/* RSS contexts not a limiting factor */
 	if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 		max_rss_ctxs = max_vnics;
-	if (vnics > max_vnics || vnics > max_rss_ctxs) {
+	if (hwr.vnic > max_vnics || hwr.vnic > max_rss_ctxs) {
 		if (bp->rx_nr_rings > 1)
 			netdev_warn(bp->dev,
 				    "Not enough resources to support NTUPLE filters, enough resources for up to %d rx rings\n",
@@ -12367,15 +12360,16 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	if (!BNXT_NEW_RM(bp))
 		return true;
 
-	if (vnics == bp->hw_resc.resv_vnics)
+	if (hwr.vnic == bp->hw_resc.resv_vnics)
 		return true;
 
-	bnxt_hwrm_reserve_rings(bp, 0, 0, 0, 0, 0, vnics);
-	if (vnics <= bp->hw_resc.resv_vnics)
+	bnxt_hwrm_reserve_rings(bp, &hwr);
+	if (hwr.vnic <= bp->hw_resc.resv_vnics)
 		return true;
 
 	netdev_warn(bp->dev, "Unable to reserve resources to support NTUPLE filters.\n");
-	bnxt_hwrm_reserve_rings(bp, 0, 0, 0, 0, 0, 1);
+	hwr.vnic = 1;
+	bnxt_hwrm_reserve_rings(bp, &hwr);
 	return false;
 }
 
@@ -13299,9 +13293,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp)
 {
 	int max_rx, max_tx, max_cp, tx_sets = 1, tx_cp;
-	int tx_rings_needed, stats;
+	struct bnxt_hw_rings hwr = {0};
 	int rx_rings = rx;
-	int cp, vnics;
 
 	if (tcs)
 		tx_sets = tcs;
@@ -13314,26 +13307,26 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		rx_rings <<= 1;
 
-	tx_rings_needed = tx * tx_sets + tx_xdp;
-	if (max_tx < tx_rings_needed)
+	hwr.rx = rx_rings;
+	hwr.tx = tx * tx_sets + tx_xdp;
+	if (max_tx < hwr.tx)
 		return -ENOMEM;
 
-	vnics = 1;
+	hwr.vnic = 1;
 	if ((bp->flags & (BNXT_FLAG_RFS | BNXT_FLAG_CHIP_P5_PLUS)) ==
 	    BNXT_FLAG_RFS)
-		vnics += rx;
+		hwr.vnic += rx;
 
-	tx_cp = __bnxt_num_tx_to_cp(bp, tx_rings_needed, tx_sets, tx_xdp);
-	cp = sh ? max_t(int, tx_cp, rx) : tx_cp + rx;
-	if (max_cp < cp)
+	tx_cp = __bnxt_num_tx_to_cp(bp, hwr.tx, tx_sets, tx_xdp);
+	hwr.cp = sh ? max_t(int, tx_cp, rx) : tx_cp + rx;
+	if (max_cp < hwr.cp)
 		return -ENOMEM;
-	stats = cp;
+	hwr.stat = hwr.cp;
 	if (BNXT_NEW_RM(bp)) {
-		cp += bnxt_get_ulp_msix_num(bp);
-		stats += bnxt_get_ulp_stat_ctxs(bp);
+		hwr.cp += bnxt_get_ulp_msix_num(bp);
+		hwr.stat += bnxt_get_ulp_stat_ctxs(bp);
 	}
-	return bnxt_hwrm_check_rings(bp, tx_rings_needed, rx_rings, rx, cp,
-				     stats, vnics);
+	return bnxt_hwrm_check_rings(bp, &hwr);
 }
 
 static void bnxt_unmap_bars(struct bnxt *bp, struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 60bdd0673ec8..bb3b31f8d02f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1254,6 +1254,15 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_RFS_NEW_RSS_FLAG	0x10
 };
 
+struct bnxt_hw_rings {
+	int tx;
+	int rx;
+	int grp;
+	int cp;
+	int stat;
+	int vnic;
+};
+
 struct bnxt_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
-- 
2.30.1


--000000000000ddfe520611d8386e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIB7fi9DCrRyuJpUspn5qxnGwpz6Q/ZIs
HwxJPU1UzrMzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBonbZjm3xMHMNBTyop5pSNu3Rq0+r3pA9yZ3f6ValVapenYept
k11M/19YUGUJMdFmbXUDT5AZDWWx16Oy/e/PgIg1HogwdAcfJCutA04JyYNfq3vDSmEzoOlmGuD8
7KYEKJ6wUgquC40EK2KSFIrBXcjPRYuIsPzfn/lJ7GtsGGoTTjK0eVw3YxQaKvVASzakPEMnvPgF
ei9tbDIALsf1h+jbFqo1fdpBfzvgPCBmVpqCwqbmrBc5HgMWO/PSO9b9Me5SK86YQ+o7TH97bkSu
3LHZOKZDJnSjRrGkb0qNIPwmdgoiGyiK2eGX08Fpa1NoXKPFcPXJQwSvU9htn5av
--000000000000ddfe520611d8386e--

