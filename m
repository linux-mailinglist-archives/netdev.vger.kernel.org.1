Return-Path: <netdev+bounces-69287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4B84A94F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651AA1F2910C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6381866;
	Mon,  5 Feb 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aUS+kUkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BE1EB5E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172338; cv=none; b=t15u9NZvJiT8WT3oVhV9xJ6Iva3a1lWVgXQV561D/Jfc3BmzwRItp/YJmu5kvlLAp2k9oUV9uIJyRO8X2pzPvjhHeh5U+2t2ZfdAjzXBvJJjiCPj3XywzhKdwA877JCTQPV0oJ4ObI5D3ZxGnKZwYFgZaE/kKraqbS22JABD2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172338; c=relaxed/simple;
	bh=JnigXIaq1Nfvh4Ijo15SxBEBkM4aS7QQvC4NaLbIhkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhnO2Pk4O3TPaOl4qR7IjVXL7HRfNtTiHHTTRBSNyiFslWes2d/MMB6ZjRos+d4Xl2VdAyP6gT13Rz7pkaXO9Y5Sqsc5kkS9riE2KMIOcdkXihjYmhx9Oj+O3jCXGgko4BQLmgj4zKtqApWUfbxPazermY23V6Z1gpc69igji5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aUS+kUkc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a8a3973c5so32566191cf.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172336; x=1707777136; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BhzPHAywNtM9wPFrPzWI7VapCg5UhyEDdeAiFdihN8=;
        b=aUS+kUkcH213r7kuKYoltVIAtWn0mtsDtLypxgfwPaHUxAO1tEId+VSeH8t6s7zxP/
         dM+rlH+ESyLnk5fLkGVc0joPkiN+/+b/TB/ByWd32+bpNRZvKFCPfi9k6+DgjjfIHY5T
         V9BSS/Ph/GSuQssN9JkY71IOSaXi6/UfqvQQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172336; x=1707777136;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BhzPHAywNtM9wPFrPzWI7VapCg5UhyEDdeAiFdihN8=;
        b=vVVp6Eb6FpaUOVPaeNHL8OuVUi03IdzipLPEzmKB82uBjaBoStzZiPmxSsKmPZNKe4
         e5oad18VWf02MIV6kUlO4MqcF0O6FRVlbs0syDHArFah52vZ6xdTkekpSP75U15drtLw
         Mm2q7tXWTE34sMm8ZZlp7TMfrvsaCE1DbtL/EI6xhHFdZSgKcTYGXOf00XOuI8PVe/ur
         I3ozRqpqyQO+WiwomKLycPQwZ/HxO6TbYdWG8dSsZqWW6UHzQFxbEC+GgMsp2KGnCeCG
         oAUGW/tDLGVy46aopXgUItGnalqucshJcHmjOUIjq6n2MtLatVAWxl2OW6SoSHHBDmTe
         V6+A==
X-Gm-Message-State: AOJu0YwHTpsnoo0ILiuTJaY+VN2QO9llhVZvxtSa8NRkuTffJSHWaDng
	FK5QCzQGJGksCr5hrh31y2aNDF5ZjfPMn1AL38orQdtAgyrVc0GmJcC3pTSzBQ==
X-Google-Smtp-Source: AGHT+IGTRepGstnLrGnP19SGnABNvnJsPo9t/26toj8rLluL7wzpu4wxkKzGCt/+quUozJMqeqs3Gw==
X-Received: by 2002:a05:622a:16:b0:42a:a9e1:7384 with SMTP id x22-20020a05622a001600b0042aa9e17384mr682792qtw.50.1707172335842;
        Mon, 05 Feb 2024 14:32:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmAfR3ucv5tsqW2OBk3vP7EZglscUzT1d92w+i38jnQ7TAtkMNob9bu+RC764IU/+f0HWfDs/MKp7Pwdg1ekN+Qe3PYFYMZ6LUD5lZ/9i6oMGrNRAOot/9FuA63apLbKYtvPFz7H6wBIB1fweznicHmVGMMn5QvVHisSjp31u9y3YILhxc9kDv50DSxZTk/Bp+00t/vw5pMIG29gFrMsNNpL0=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:15 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 01/13] bnxt_en: Use firmware provided maximum filter counts.
Date: Mon,  5 Feb 2024 14:31:50 -0800
Message-Id: <20240205223202.25341-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000acad190610aa08a1"

--000000000000acad190610aa08a1
Content-Transfer-Encoding: 8bit

While individual filter structures are allocated as needed, there is an
array to keep track of the software filter IDs that we allocate ahead
of time.  Rather than relying on a fixed maximum filter count to
allocate this array, get the maximum from the firmware when available.

Move these filter related maximum counts queried from the firmware to the
bnxt_hw_resc struct.  If the firmware is not providing these maximum
counts, fall back to the hard-coded constant.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 13 +++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +--
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fde32b32fa81..91ecf514b924 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4840,7 +4840,7 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 		INIT_HLIST_HEAD(&bp->ntp_fltr_hash_tbl[i]);
 
 	bp->ntp_fltr_count = 0;
-	bp->ntp_fltr_bmap = bitmap_zalloc(BNXT_MAX_FLTR, GFP_KERNEL);
+	bp->ntp_fltr_bmap = bitmap_zalloc(bp->max_fltr, GFP_KERNEL);
 
 	if (!bp->ntp_fltr_bmap)
 		rc = -ENOMEM;
@@ -5480,7 +5480,7 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 		int bit_id;
 
 		bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap,
-						 BNXT_MAX_FLTR, 0);
+						 bp->max_fltr, 0);
 		if (bit_id < 0)
 			return -ENOMEM;
 		fltr->base.sw_id = (u16)bit_id;
@@ -8709,6 +8709,13 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	hw_resc->max_vnics = le16_to_cpu(resp->max_vnics);
 	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
 
+	hw_resc->max_encap_records = le32_to_cpu(resp->max_encap_records);
+	hw_resc->max_decap_records = le32_to_cpu(resp->max_decap_records);
+	hw_resc->max_tx_em_flows = le32_to_cpu(resp->max_tx_em_flows);
+	hw_resc->max_tx_wm_flows = le32_to_cpu(resp->max_tx_wm_flows);
+	hw_resc->max_rx_em_flows = le32_to_cpu(resp->max_rx_em_flows);
+	hw_resc->max_rx_wm_flows = le32_to_cpu(resp->max_rx_wm_flows);
+
 	if (BNXT_PF(bp)) {
 		struct bnxt_pf_info *pf = &bp->pf;
 
@@ -8717,12 +8724,6 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		memcpy(pf->mac_addr, resp->mac_address, ETH_ALEN);
 		pf->first_vf_id = le16_to_cpu(resp->first_vf_id);
 		pf->max_vfs = le16_to_cpu(resp->max_vfs);
-		pf->max_encap_records = le32_to_cpu(resp->max_encap_records);
-		pf->max_decap_records = le32_to_cpu(resp->max_decap_records);
-		pf->max_tx_em_flows = le32_to_cpu(resp->max_tx_em_flows);
-		pf->max_tx_wm_flows = le32_to_cpu(resp->max_tx_wm_flows);
-		pf->max_rx_em_flows = le32_to_cpu(resp->max_rx_em_flows);
-		pf->max_rx_wm_flows = le32_to_cpu(resp->max_rx_wm_flows);
 		bp->flags &= ~BNXT_FLAG_WOL_CAP;
 		if (flags & FUNC_QCAPS_RESP_FLAGS_WOL_MAGICPKT_SUPPORTED)
 			bp->flags |= BNXT_FLAG_WOL_CAP;
@@ -13899,7 +13900,7 @@ int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
 	int bit_id;
 
 	spin_lock_bh(&bp->ntp_fltr_lock);
-	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, BNXT_MAX_FLTR, 0);
+	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, bp->max_fltr, 0);
 	if (bit_id < 0) {
 		spin_unlock_bh(&bp->ntp_fltr_lock);
 		return -ENOMEM;
@@ -14669,6 +14670,7 @@ void bnxt_print_device_info(struct bnxt *bp)
 
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct bnxt_hw_resc *hw_resc;
 	struct net_device *dev;
 	struct bnxt *bp;
 	int rc, max_irqs;
@@ -14827,6 +14829,12 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_pci_clean;
 
+	hw_resc = &bp->hw_resc;
+	bp->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
+		       BNXT_L2_FLTR_MAX_FLTR;
+	/* Older firmware may not report these filters properly */
+	if (bp->max_fltr < BNXT_MAX_FLTR)
+		bp->max_fltr = BNXT_MAX_FLTR;
 	bnxt_init_l2_fltr_tbl(bp);
 	bnxt_set_rx_skb_mode(bp, false);
 	bnxt_set_tpa_flags(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b2cb3e77559d..4bd1cf01d99e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1281,6 +1281,12 @@ struct bnxt_hw_resc {
 	u16	max_nqs;
 	u16	max_irqs;
 	u16	resv_irqs;
+	u32	max_encap_records;
+	u32	max_decap_records;
+	u32	max_tx_em_flows;
+	u32	max_tx_wm_flows;
+	u32	max_rx_em_flows;
+	u32	max_rx_wm_flows;
 };
 
 #if defined(CONFIG_BNXT_SRIOV)
@@ -1315,12 +1321,6 @@ struct bnxt_pf_info {
 	u16	active_vfs;
 	u16	registered_vfs;
 	u16	max_vfs;
-	u32	max_encap_records;
-	u32	max_decap_records;
-	u32	max_tx_em_flows;
-	u32	max_tx_wm_flows;
-	u32	max_rx_em_flows;
-	u32	max_rx_wm_flows;
 	unsigned long	*vf_event_bmap;
 	u16	hwrm_cmd_req_pages;
 	u8	vf_resv_strategy;
@@ -2428,6 +2428,7 @@ struct bnxt {
 
 	unsigned long		*ntp_fltr_bmap;
 	int			ntp_fltr_count;
+	int			max_fltr;
 
 #define BNXT_L2_FLTR_MAX_FLTR	1024
 #define BNXT_L2_FLTR_HASH_SIZE	32
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 481b835a7703..1c8610386404 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1077,7 +1077,7 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	struct flow_keys *fkeys;
 	int rc = -EINVAL;
 
-	if (fs->location >= BNXT_NTP_FLTR_MAX_FLTR)
+	if (fs->location >= bp->max_fltr)
 		return rc;
 
 	rcu_read_lock();
@@ -1521,7 +1521,7 @@ static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = bp->ntp_fltr_count;
-		cmd->data = BNXT_NTP_FLTR_MAX_FLTR | RX_CLS_LOC_SPECIAL;
+		cmd->data = bp->max_fltr | RX_CLS_LOC_SPECIAL;
 		break;
 
 	case ETHTOOL_GRXCLSRLALL:
-- 
2.30.1


--000000000000acad190610aa08a1
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBOC1cEwuquO9Hib60EbNmAGxQkc8L0g
sqX/OVbLrUuaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAZlKYcQHLevXvOkZ6tIIzKHSR4RArYRpx0R4NwWndCYwGrB2L2
TlFMe+zolT46/c7loYGuwlwWc0Jy1Y647DimMWjr88r+d26QVj19YwIy80S3GOpL/uWaYtP6nvMW
Tx/7Igs/ZlOEB5ZoibdJqIEqZA6+89pUD9BQXpWTGoDHin+UiOAtBLwEnsJJvUBJAT5TDkPprE69
EmSilX/cVWG7AAUT7bTKh1wHJidizhPunl/pYe0P9iD98h2zbCrLEdLahxdKPHp5OmILN/HhJEOU
n6CnADRLuTohk3f5tkZIbsxOFOFNcQrmCiAZU9zNSue2B/EW/6SO1RYw32FRXMC9
--000000000000acad190610aa08a1--

