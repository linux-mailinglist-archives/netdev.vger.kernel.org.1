Return-Path: <netdev+bounces-73462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81385CBAB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F742844A9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0648154425;
	Tue, 20 Feb 2024 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VOQ+uxc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7D154451
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470230; cv=none; b=X1o8oKG55Fg2OTlN5pqS+qLn2InQUu5/lNoTOaEfxxoZVga2Q61F4JJnyAIwzJ27cosieHUOH9/Drf7dBMxrAm2K/TCZRG5eNE8tpiHrD73Rrs6QRi+i9oe6FFHFsn5zAVGLJlyFIObS+ITEXy1tZonovc/g5AT2656h0ReDyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470230; c=relaxed/simple;
	bh=83jvQWLr+RIzQzUjbF9p3mmiEuFqDFxbmXC1E8gBMgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfpCXhvNgrC2jg9KrxJVRH0+qsRkFqTOrxuzA3UqGgc8JBhiNRBZNTpqqN3F9xZXr6X1TJ9khyB9YICKzXzDMj5b1eoEU//OsyN0jm+3iYlpykqR4FpJiPYi8JOw6G365ZX2Frwlf2wNwXv6wzvXc2AD2DqBH2SRq+kc+uHYoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VOQ+uxc2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e169c4b64so6724061cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470228; x=1709075028; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WyRf9jwWeNC4faVJoWo4gm1KHgOsq4tQdgKAuC8NY4=;
        b=VOQ+uxc2MB5vMTCLK3QuBlWdylFqCWt1PVKV7Vv8Flqh5BTo4W4Wl6mc9UPvwcMMwG
         DQifVM8txhXdLjivpBUZ9a0VJlU6DfcQXan4mLromN2O4Gd5m5fOcI1FyEkFe27gtwCS
         ZDSo+vMMCzoPbgabWlb5o3s0HkMoa7/EZtfBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470228; x=1709075028;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WyRf9jwWeNC4faVJoWo4gm1KHgOsq4tQdgKAuC8NY4=;
        b=cOp5+tLIw8hmGW6rsoP3XbVF9WMHRkgYCIAMxMrzsVHpVE4bvelXUYMbP7VNPEvH0i
         B52LMwIMff9s0+rGMhPGr5iIwc80nReG4oQkbalE1u2zsCxuhLqq+R2V866wkbi6K7V1
         077VzgHQjEMQCRFDf6SbRKqzYGCCG/QQc01pXEkJE485U8w/p5jcMM6lG18WGlWyWE/V
         8UGgCxemyn0lObL535hwgtyBmCy7cEpjhNWdTYijJagpBj1EVs+pmZVSiVP81s7pVTk+
         MhgrsiLneSVEc2QfRedsyoL19jSSPLrg8MygO68AZbYyWybUE6cOVZhCA5BzCcgKCQkx
         sRwA==
X-Gm-Message-State: AOJu0YxPY543GVqFKGA0YOu9D6AwMaVcb46ljwrK10VCmFeUA6j+2W/V
	cRUFm1pq+VOyGZzd4pyHmJFZqGb9Ikj5SusYaHHITMWJkXKcW+I5bjH/2gRTeQ==
X-Google-Smtp-Source: AGHT+IF7DPXArz27uW7t+esUEY0te8CWn5t6Xus0dru/ItRdjbSiWdicPGEd99ZCfUNyAT9QnUJ8YQ==
X-Received: by 2002:a05:622a:4ce:b0:42c:2d67:b7d6 with SMTP id q14-20020a05622a04ce00b0042c2d67b7d6mr21660215qtx.66.1708470227525;
        Tue, 20 Feb 2024 15:03:47 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:46 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 03/10] bnxt_en: Improve RSS context reservation infrastructure
Date: Tue, 20 Feb 2024 15:03:10 -0800
Message-Id: <20240220230317.96341-4-michael.chan@broadcom.com>
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
	boundary="0000000000000e88ff0611d83904"

--0000000000000e88ff0611d83904
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add RSS context fields to struct bnxt_hw_rings and struct bnxt_hw_resc.
With these, we can now specific the exact number of RSS contexts to
reserve and store the reserved value.  The original code relies on
other resources to infer the number of RSS contexts to reserve and the
reserved value is not stored.  This improved infrastructure will make
the RSS context accounting more complete and is needed by later
patches.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 ++++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 +
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4f3d2b1c9989..e6fad2a8b817 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7043,6 +7043,7 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		hw_resc->resv_hw_ring_grps =
 			le32_to_cpu(resp->alloc_hw_ring_grps);
 		hw_resc->resv_vnics = le16_to_cpu(resp->alloc_vnics);
+		hw_resc->resv_rsscos_ctxs = le16_to_cpu(resp->alloc_rsscos_ctx);
 		cp = le16_to_cpu(resp->alloc_cmpl_rings);
 		stats = le16_to_cpu(resp->alloc_stat_ctx);
 		hw_resc->resv_irqs = cp;
@@ -7116,32 +7117,23 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 			enables |= hwr->cp ? FUNC_CFG_REQ_ENABLES_NUM_MSIX : 0;
 			enables |= hwr->cp_p5 ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
-			enables |= hwr->rx ?
-				   FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 		} else {
 			enables |= hwr->cp ?
 				   FUNC_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
 			enables |= hwr->grp ?
-				   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS |
-				   FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
+				   FUNC_CFG_REQ_ENABLES_NUM_HW_RING_GRPS : 0;
 		}
 		enables |= hwr->vnic ? FUNC_CFG_REQ_ENABLES_NUM_VNICS : 0;
-
+		enables |= hwr->rss_ctx ? FUNC_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS :
+					  0;
 		req->num_rx_rings = cpu_to_le16(hwr->rx);
+		req->num_rsscos_ctxs = cpu_to_le16(hwr->rss_ctx);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
-
 			req->num_cmpl_rings = cpu_to_le16(hwr->cp_p5);
 			req->num_msix = cpu_to_le16(hwr->cp);
-			req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 		} else {
 			req->num_cmpl_rings = cpu_to_le16(hwr->cp);
 			req->num_hw_ring_grps = cpu_to_le16(hwr->grp);
-			req->num_rsscos_ctxs = cpu_to_le16(1);
-			if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) &&
-			    bnxt_rfs_supported(bp))
-				req->num_rsscos_ctxs =
-					cpu_to_le16(hwr->grp + 1);
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
@@ -7163,6 +7155,7 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	enables |= hwr->rx ? FUNC_VF_CFG_REQ_ENABLES_NUM_RX_RINGS |
 			     FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 	enables |= hwr->stat ? FUNC_VF_CFG_REQ_ENABLES_NUM_STAT_CTXS : 0;
+	enables |= hwr->rss_ctx ? FUNC_VF_CFG_REQ_ENABLES_NUM_RSSCOS_CTXS : 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		enables |= hwr->cp_p5 ?
 			   FUNC_VF_CFG_REQ_ENABLES_NUM_CMPL_RINGS : 0;
@@ -7177,15 +7170,12 @@ __bnxt_hwrm_reserve_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	req->num_l2_ctxs = cpu_to_le16(BNXT_VF_MAX_L2_CTX);
 	req->num_tx_rings = cpu_to_le16(hwr->tx);
 	req->num_rx_rings = cpu_to_le16(hwr->rx);
+	req->num_rsscos_ctxs = cpu_to_le16(hwr->rss_ctx);
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		u16 rss_ctx = bnxt_get_nr_rss_ctxs(bp, hwr->grp);
-
 		req->num_cmpl_rings = cpu_to_le16(hwr->cp_p5);
-		req->num_rsscos_ctxs = cpu_to_le16(rss_ctx);
 	} else {
 		req->num_cmpl_rings = cpu_to_le16(hwr->cp);
 		req->num_hw_ring_grps = cpu_to_le16(hwr->grp);
-		req->num_rsscos_ctxs = cpu_to_le16(BNXT_VF_MAX_RSS_CTX);
 	}
 	req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 	req->num_vnics = cpu_to_le16(hwr->vnic);
@@ -7289,6 +7279,20 @@ static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
 	return cp + ulp_stat;
 }
 
+static int bnxt_get_total_rss_ctxs(struct bnxt *bp, struct bnxt_hw_rings *hwr)
+{
+	if (!hwr->grp)
+		return 0;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		return bnxt_get_nr_rss_ctxs(bp, hwr->grp);
+
+	if (BNXT_VF(bp))
+		return BNXT_VF_MAX_RSS_CTX;
+	if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) && bnxt_rfs_supported(bp))
+		return hwr->grp + 1;
+	return 1;
+}
+
 /* Check if a default RSS map needs to be setup.  This function is only
  * used on older firmware that does not require reserving RX rings.
  */
@@ -7355,6 +7359,7 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		hwr->grp = hw_resc->resv_hw_ring_grps;
 		hwr->vnic = hw_resc->resv_vnics;
 		hwr->stat = hw_resc->resv_stat_ctxs;
+		hwr->rss_ctx = hw_resc->resv_rsscos_ctxs;
 	}
 }
 
@@ -7387,6 +7392,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx <<= 1;
 	hwr.grp = bp->rx_nr_rings;
+	hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	hwr.stat = bnxt_get_func_stat_ctxs(bp);
 
 	rc = bnxt_hwrm_reserve_rings(bp, &hwr);
@@ -11210,6 +11216,7 @@ static void bnxt_clear_reservations(struct bnxt *bp, bool fw_reset)
 	hw_resc->resv_rx_rings = 0;
 	hw_resc->resv_hw_ring_grps = 0;
 	hw_resc->resv_vnics = 0;
+	hw_resc->resv_rsscos_ctxs = 0;
 	if (!fw_reset) {
 		bp->tx_nr_rings = 0;
 		bp->rx_nr_rings = 0;
@@ -12340,6 +12347,7 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	struct bnxt_hw_rings hwr = {0};
 	int max_vnics, max_rss_ctxs;
 
+	hwr.rss_ctx = 1;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return bnxt_rfs_supported(bp);
 	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
@@ -12349,10 +12357,10 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	max_vnics = bnxt_get_max_func_vnics(bp);
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
 
-	/* RSS contexts not a limiting factor */
-	if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
-		max_rss_ctxs = max_vnics;
-	if (hwr.vnic > max_vnics || hwr.vnic > max_rss_ctxs) {
+	if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP))
+		hwr.rss_ctx = hwr.vnic;
+
+	if (hwr.vnic > max_vnics || hwr.rss_ctx > max_rss_ctxs) {
 		if (bp->rx_nr_rings > 1)
 			netdev_warn(bp->dev,
 				    "Not enough resources to support NTUPLE filters, enough resources for up to %d rx rings\n",
@@ -12363,15 +12371,18 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	if (!BNXT_NEW_RM(bp))
 		return true;
 
-	if (hwr.vnic == bp->hw_resc.resv_vnics)
+	if (hwr.vnic == bp->hw_resc.resv_vnics &&
+	    hwr.rss_ctx <= bp->hw_resc.resv_rsscos_ctxs)
 		return true;
 
 	bnxt_hwrm_reserve_rings(bp, &hwr);
-	if (hwr.vnic <= bp->hw_resc.resv_vnics)
+	if (hwr.vnic <= bp->hw_resc.resv_vnics &&
+	    hwr.rss_ctx <= bp->hw_resc.resv_rsscos_ctxs)
 		return true;
 
 	netdev_warn(bp->dev, "Unable to reserve resources to support NTUPLE filters.\n");
 	hwr.vnic = 1;
+	hwr.rss_ctx = 0;
 	bnxt_hwrm_reserve_rings(bp, &hwr);
 	return false;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 681a579afcc2..4ff090981809 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1262,11 +1262,13 @@ struct bnxt_hw_rings {
 	int cp_p5;
 	int stat;
 	int vnic;
+	int rss_ctx;
 };
 
 struct bnxt_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
+	u16	resv_rsscos_ctxs;
 	u16	min_cp_rings;
 	u16	max_cp_rings;
 	u16	resv_cp_rings;
-- 
2.30.1


--0000000000000e88ff0611d83904
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDb7AKR6RIsjfuX+aeGUG8mr0KEPwser
pV+o8wjN8lEqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA9ab+EuOxQpnA2dO2IKPCgNnMSy1NvUh70yvcnH2O0/qaTclwO
9QWIaeSjBrDwT/+SxdvjupAmWddP5erRfBzdg6YVo5vxumP0k1oAC/LCzuRKmijlAFhYrOJaoREF
59cnaroTEYdbPJvsO/Wb5TfSHC87/EKe8Ky0+34Rk31bP0O+H2HVHRiq+8L4cK+Grsv9C5+R0ZTg
rrOKvVEYRw6RM4e8xm40YInuhbdfKKuaAGeyQNIse3oxHkQ8F1o8euZzBjyIYAFoGKtR4uk1y3Xu
SlOX0DXuAXf8hsxlFPsfy+Gu2XZIXNcrpISb82kfaYxCsDXRPiIFjkXXIGpgbHYO
--0000000000000e88ff0611d83904--

