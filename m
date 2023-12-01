Return-Path: <netdev+bounces-53123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A98016A2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C2A1C20C50
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA717D2;
	Fri,  1 Dec 2023 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X56gee0X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B46D6C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:39:57 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41eb4210383so15719571cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470396; x=1702075196; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHPm9bMQ0UUeVCFUzW1wmDi9EoVh1TqfRiSExNkr10g=;
        b=X56gee0XNWKQHUQ5TVYP0XK/rpyWEbxcsZjpYcOy+Jaqtbjfot6cztzB0aOwqxOU98
         43Mup/WWN0/LHOIRyPyDOvyAy+++YQbYBuA+HzowRtY0we029FhIxW1oIEgi+GqJK6wV
         Wanu6szDyHv08cyND6V3H6mBBm4HfWLY8+Uhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470396; x=1702075196;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHPm9bMQ0UUeVCFUzW1wmDi9EoVh1TqfRiSExNkr10g=;
        b=Z4/BDSwygxP5DCyjXc6LUl045Q9ZxJG6AsE9/6p/a1G7SQxvEhb5CjVaEgO+Z9/MGP
         cU7gTXB6MieqipdzlndnkNFJASJuFwlzWTexC2LP3dK8nvlgLdKN3L/zZHZ5zSHmav0F
         St8XFQ4k16dvk2vgODtNP281QhBt/Ccmci8l+ji1ozVYCoUHbyGI7T2w+PTx+ClRRKTr
         YDEwPKTapnYjkM3KpCzJMiXffBcDQ3GW9lZSrWGkVS4ezpKeoY+/ItZp6wkNFKq+szvQ
         O54/YO5N4vig36zMvbmd9hgeAyyrR1L+YbYUvZl/Flfv+GFIJjNa0q956224nfM18XkX
         xYtw==
X-Gm-Message-State: AOJu0Yy/zDyeSEHoxxoHVp7aiRIarDzgtbGZ3LKjPEQsPXfOL4/GTLZT
	2C7i7EUz8PGo99AHM2OQFmX4+A==
X-Google-Smtp-Source: AGHT+IFB3MrZ9dk1CQ2UFSeqy+zFmfP84thpzn1kbU6pH7H0UeK49vSdP9/LfekeW/v+QR3CZym5VA==
X-Received: by 2002:a05:622a:1113:b0:424:27c:cff1 with SMTP id e19-20020a05622a111300b00424027ccff1mr356488qty.1.1701470396099;
        Fri, 01 Dec 2023 14:39:56 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:39:55 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 06/15] bnxt_en: Refactor RSS capability fields
Date: Fri,  1 Dec 2023 14:39:15 -0800
Message-Id: <20231201223924.26955-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000093f679060b7a72d1"

--00000000000093f679060b7a72d1
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

Add a new rss_cap field in the per device struct bnxt and move all
the RSS capability fields there.  It will be easier to add new RSS
capabilities for the new P7 chips.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 ++---
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d4da55e01b2c..b38c17a27903 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4268,7 +4268,7 @@ static int bnxt_alloc_vnic_attributes(struct bnxt *bp)
 			goto out;
 		}
 vnic_skip_grps:
-		if ((bp->flags & BNXT_FLAG_NEW_RSS_CAP) &&
+		if ((bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) &&
 		    !(vnic->flags & BNXT_VNIC_RSS_FLAG))
 			continue;
 
@@ -5765,7 +5765,8 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 	int rc;
 
 	bp->hw_ring_stats_size = sizeof(struct ctx_hw_stats);
-	bp->flags &= ~(BNXT_FLAG_NEW_RSS_CAP | BNXT_FLAG_ROCE_MIRROR_CAP);
+	bp->flags &= ~BNXT_FLAG_ROCE_MIRROR_CAP;
+	bp->rss_cap &= ~BNXT_RSS_CAP_NEW_RSS_CAP;
 	if (bp->hwrm_spec_code < 0x10600)
 		return 0;
 
@@ -5780,7 +5781,7 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 		    (flags & VNIC_QCAPS_RESP_FLAGS_RSS_DFLT_CR_CAP))
-			bp->flags |= BNXT_FLAG_NEW_RSS_CAP;
+			bp->rss_cap |= BNXT_RSS_CAP_NEW_RSS_CAP;
 		if (flags &
 		    VNIC_QCAPS_RESP_FLAGS_ROCE_MIRRORING_CAPABLE_VNIC_CAP)
 			bp->flags |= BNXT_FLAG_ROCE_MIRROR_CAP;
@@ -5793,7 +5794,7 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 		     !(bp->fw_cap & BNXT_FW_CAP_EXT_HW_STATS_SUPPORTED)))
 			bp->fw_cap |= BNXT_FW_CAP_VLAN_RX_STRIP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_HASH_TYPE_DELTA_CAP)
-			bp->fw_cap |= BNXT_FW_CAP_RSS_HASH_TYPE_DELTA;
+			bp->rss_cap |= BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA;
 		bp->max_tpa_v2 = le16_to_cpu(resp->max_aggs_supported);
 		if (bp->max_tpa_v2) {
 			if (BNXT_CHIP_P5(bp))
@@ -6456,7 +6457,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 			req->num_cmpl_rings = cpu_to_le16(cp_rings);
 			req->num_hw_ring_grps = cpu_to_le16(ring_grps);
 			req->num_rsscos_ctxs = cpu_to_le16(1);
-			if (!(bp->flags & BNXT_FLAG_NEW_RSS_CAP) &&
+			if (!(bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP) &&
 			    bnxt_rfs_supported(bp))
 				req->num_rsscos_ctxs =
 					cpu_to_le16(ring_grps + 1);
@@ -9133,7 +9134,7 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 
 		vnic = &bp->vnic_info[vnic_id];
 		vnic->flags |= BNXT_VNIC_RFS_FLAG;
-		if (bp->flags & BNXT_FLAG_NEW_RSS_CAP)
+		if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 			vnic->flags |= BNXT_VNIC_RFS_NEW_RSS_FLAG;
 		rc = bnxt_hwrm_vnic_alloc(bp, vnic_id, ring_id, 1);
 		if (rc) {
@@ -9227,7 +9228,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
-	if (bp->fw_cap & BNXT_FW_CAP_RSS_HASH_TYPE_DELTA)
+	if (bp->rss_cap & BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bnxt_hwrm_update_rss_hash_cfg(bp);
 
 	if (bp->flags & BNXT_FLAG_RFS) {
@@ -11555,7 +11556,7 @@ static bool bnxt_rfs_supported(struct bnxt *bp)
 		return false;
 	if (BNXT_PF(bp) && !BNXT_CHIP_TYPE_NITRO_A0(bp))
 		return true;
-	if (bp->flags & BNXT_FLAG_NEW_RSS_CAP)
+	if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 		return true;
 	return false;
 }
@@ -11576,7 +11577,7 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
 
 	/* RSS contexts not a limiting factor */
-	if (bp->flags & BNXT_FLAG_NEW_RSS_CAP)
+	if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 		max_rss_ctxs = max_vnics;
 	if (vnics > max_vnics || vnics > max_rss_ctxs) {
 		if (bp->rx_nr_rings > 1)
@@ -12697,15 +12698,15 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
 
 static void bnxt_set_dflt_rss_hash_type(struct bnxt *bp)
 {
-	bp->flags &= ~BNXT_FLAG_UDP_RSS_CAP;
+	bp->rss_cap &= ~BNXT_RSS_CAP_UDP_RSS_CAP;
 	bp->rss_hash_cfg = VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4 |
 			   VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4 |
 			   VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 |
 			   VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6;
-	if (bp->fw_cap & BNXT_FW_CAP_RSS_HASH_TYPE_DELTA)
+	if (bp->rss_cap & BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bp->rss_hash_delta = bp->rss_hash_cfg;
 	if (BNXT_CHIP_P4_PLUS(bp) && bp->hwrm_spec_code >= 0x10501) {
-		bp->flags |= BNXT_FLAG_UDP_RSS_CAP;
+		bp->rss_cap |= BNXT_RSS_CAP_UDP_RSS_CAP;
 		bp->rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4 |
 				    VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 79b4deb45cfb..d10811f4073b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1900,8 +1900,6 @@ struct bnxt {
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
-	#define BNXT_FLAG_UDP_RSS_CAP	0x800
-	#define BNXT_FLAG_NEW_RSS_CAP	0x2000
 	#define BNXT_FLAG_WOL_CAP	0x4000
 	#define BNXT_FLAG_ROCEV1_CAP	0x8000
 	#define BNXT_FLAG_ROCEV2_CAP	0x10000
@@ -2021,6 +2019,10 @@ struct bnxt {
 	u16			rss_indir_tbl_entries;
 	u32			rss_hash_cfg;
 	u32			rss_hash_delta;
+	u32			rss_cap;
+#define BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA	BIT(0)
+#define BNXT_RSS_CAP_UDP_RSS_CAP		BIT(1)
+#define BNXT_RSS_CAP_NEW_RSS_CAP		BIT(2)
 
 	u16			max_mtu;
 	u8			max_tc;
@@ -2086,7 +2088,6 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2	BIT_ULL(16)
 	#define BNXT_FW_CAP_PCIE_STATS_SUPPORTED	BIT_ULL(17)
 	#define BNXT_FW_CAP_EXT_STATS_SUPPORTED		BIT_ULL(18)
-	#define BNXT_FW_CAP_RSS_HASH_TYPE_DELTA		BIT_ULL(19)
 	#define BNXT_FW_CAP_ERR_RECOVER_RELOAD		BIT_ULL(20)
 	#define BNXT_FW_CAP_HOT_RESET			BIT_ULL(21)
 	#define BNXT_FW_CAP_PTP_RTC			BIT_ULL(22)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 99c8b15bdfbe..14cb0512ee93 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1203,7 +1203,7 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		if (tuple == 4)
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4;
 	} else if (cmd->flow_type == UDP_V4_FLOW) {
-		if (tuple == 4 && !(bp->flags & BNXT_FLAG_UDP_RSS_CAP))
+		if (tuple == 4 && !(bp->rss_cap & BNXT_RSS_CAP_UDP_RSS_CAP))
 			return -EINVAL;
 		rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4;
 		if (tuple == 4)
@@ -1213,7 +1213,7 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		if (tuple == 4)
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6;
 	} else if (cmd->flow_type == UDP_V6_FLOW) {
-		if (tuple == 4 && !(bp->flags & BNXT_FLAG_UDP_RSS_CAP))
+		if (tuple == 4 && !(bp->rss_cap & BNXT_RSS_CAP_UDP_RSS_CAP))
 			return -EINVAL;
 		rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6;
 		if (tuple == 4)
@@ -1253,7 +1253,7 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	if (bp->rss_hash_cfg == rss_hash_cfg)
 		return 0;
 
-	if (bp->fw_cap & BNXT_FW_CAP_RSS_HASH_TYPE_DELTA)
+	if (bp->rss_cap & BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA)
 		bp->rss_hash_delta = bp->rss_hash_cfg ^ rss_hash_cfg;
 	bp->rss_hash_cfg = rss_hash_cfg;
 	if (netif_running(bp->dev)) {
-- 
2.30.1


--00000000000093f679060b7a72d1
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILrJXGyNvPpCM1yrUkLhjK3fe3JhaZG2
+wTpgl/aeRjkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyMzk1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCHqCFlKERTbrOlFfhr44YxkJU4zEvPxDasilpxzTaEPW8TZ8RW
7s8Ebog050UQiOo7vvzoN0zE5REJQw4fjdQBpFE3rPWakow6v9uruNaYaxfmvkCBQl59rKgoS0IV
bmw7yuvsp+yODL06rjUObJ0uu4MfW5dEWaMojfrftHrDj6lBaGJ8XDT0kOlRJF30GeeMya9RnL+8
nFPeYrfbdWjs4XtRLvjOsjAhDEF6jmTxlN0zGOrlsQdAmqDsPfKGKeiyv8hu0tV20CB3kEYEtvJ0
Xlo2KDVsQkpBr1hqrhipGZXRMWDjBRsjree6OVz/Udh8Y6EpGloyOn8hzV2BwM/r
--00000000000093f679060b7a72d1--

