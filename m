Return-Path: <netdev+bounces-69299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13884A95B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CF81F29E48
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B63A1DE;
	Mon,  5 Feb 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E1D5DCID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371391866
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172361; cv=none; b=q34izqheeX6rRG5B8ijYqJX7qtKxUDJzXU1zrBc+PBA9wDHdL3/vbDaN0f3Ji/va02IDjVjK4y0d6aKHhU64paurWZk3n3xCCwwTUaRHCWIh/RYyYeHD0j+voLSjFbroFs5lGx11hxd+A9TT2gyzSVsTXD0oJETBUbRHRR4hL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172361; c=relaxed/simple;
	bh=VQk9XRSsmHh6nkdCOC0iOzREAkSsEYCRAyrqNvbWZ3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdrA8vVw4OlL0igtoFOKYXeV5BSxo7uVCr6X4hyb7Cjx50c9wEtLfpbaPpKZHs4uGW5O7kijdwnDgbBj72fkDuAKrwTluIX+gODxjrKzYhR5ij28ciEWWjEJdOMTqdphq3s0KDErK+eDAjvKlj1ROhgZvv0SPzT+eUSgoVyRr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E1D5DCID; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-20503dc09adso3350719fac.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172356; x=1707777156; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLxIQhQ5iKlKsfQeuMKkhQswIjZSvYbF7Gza5GZXivo=;
        b=E1D5DCIDp63pT2RgfY4mHS+ik47OUT0TNlTpoTZ7TB9er9Fe8pVmfeJ+SddWfam8g+
         e6gEAy5Dp6qkIk5fqjUFXLiSTIHzwxa/CnIgz0xrism1LfRBz3WRatTuKMjD98p0F+t7
         f92QM0rbcuVwZRL8/UJvxk9o3yZB9eepg7ijc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172356; x=1707777156;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLxIQhQ5iKlKsfQeuMKkhQswIjZSvYbF7Gza5GZXivo=;
        b=GrpXzXaVOKKFeirWQYFBuJ8Fn2zXCKeDgMEK9mwCq99mMn/5/zBbW9/G9eNuXFD1g1
         ewGPssb8/lDC5/pTSynSvqyrBKGY1OkbsYrDRLVkAP21K6ORuD0R0cUFXCNoVbeAXWaL
         8xeWzUJs5vORXFB/C+leCSvukKxFaZX0jsDGomCZQUgTM9+nuwTTUztZgHjimD5g0Zvb
         FE1nIezQlPxr4TFnyCTAAv3787/CrGfZvgBsRzv8zlrPBzOihbzXIIE6y6/rjb1sadx0
         uw59FfOUh7u2aMuwNeL6RxpPaS8dK0eXlyc92NYx6tWHivl21Q+LGU9oZoKXG92RSdK6
         CB7Q==
X-Gm-Message-State: AOJu0Yy8u4e5z3obL5WfHlCa8VN5mciiY6vI7RNXF7detqbe5qYaeY1K
	JRqTsZDTQolG3xZkUzkRKG50VCTRauhoGg7l4edo0D0vXugGRkuOwupxkI5aew==
X-Google-Smtp-Source: AGHT+IGfu+hHRI+KiQ7mhYBhkqxOulopSo4N/hMcaWyxGgJr8Np8gpNLhaFCrIgW61xlmK2NZWhnYQ==
X-Received: by 2002:a05:6870:171a:b0:219:3db5:b540 with SMTP id h26-20020a056870171a00b002193db5b540mr574067oae.41.1707172356132;
        Mon, 05 Feb 2024 14:32:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWBGMHARt7CfrY5TPsW5YOuLDK+iwtLxo21I3SaHY3VfGrpiYuT25WoaSEe5C4JyzNKaD6qwxrkWuS5V2kpI/pIlLG7vXEFbPEb6dSjpClVObFpAMV0ZY4fnmBJzA2be6e66E5W6pQvnYOr9iX7FoL+LhhYKNh3nd3cB3UBg+l/ER9xU5YZO1iNbd2kQlhTSDWZ0Vv98+GTNFik3mPXyMIykKhmVHxbLIQ3uAOEOxU7koP5QYGJc4z7rGW+i3Ct
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:35 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 13/13] bnxt_en: Add RSS support for IPSEC headers
Date: Mon,  5 Feb 2024 14:32:02 -0800
Message-Id: <20240205223202.25341-14-michael.chan@broadcom.com>
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
	boundary="000000000000e234e10610aa097e"

--000000000000e234e10610aa097e
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

IPSec uses two distinct protocols, Authentication Header (AH) and
Encapsulating Security Payload (ESP).
Add support to configure RSS based on AH and ESP headers.
This functionality will be enabled based on the capabilities
indicated by the firmware in HWRM_VNIC_QCAPS.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 15 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 34 +++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 856fda0c4c1a..0c471ddad747 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6099,10 +6099,13 @@ static void
 __bnxt_hwrm_vnic_set_rss(struct bnxt *bp, struct hwrm_vnic_rss_cfg_input *req,
 			 struct bnxt_vnic_info *vnic)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		bnxt_fill_hw_rss_tbl_p5(bp, vnic);
-	else
+		if (bp->flags & BNXT_FLAG_CHIP_P7)
+			req->flags |= VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT;
+	} else {
 		bnxt_fill_hw_rss_tbl(bp, vnic);
+	}
 
 	if (bp->rss_hash_delta) {
 		req->hash_type = cpu_to_le32(bp->rss_hash_delta);
@@ -6465,6 +6468,14 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 		}
 		if (flags & VNIC_QCAPS_RESP_FLAGS_HW_TUNNEL_TPA_CAP)
 			bp->fw_cap |= BNXT_FW_CAP_VNIC_TUNNEL_TPA;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV4_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_AH_V4_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_AH_SPI_IPV6_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_AH_V6_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV4_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_ESP_V4_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_ESP_V6_RSS_CAP;
 	}
 	hwrm_req_drop(bp, req);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2b2f051ee085..60bdd0673ec8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2221,6 +2221,10 @@ struct bnxt {
 #define BNXT_RSS_CAP_UDP_RSS_CAP		BIT(1)
 #define BNXT_RSS_CAP_NEW_RSS_CAP		BIT(2)
 #define BNXT_RSS_CAP_RSS_TCAM			BIT(3)
+#define BNXT_RSS_CAP_AH_V4_RSS_CAP		BIT(4)
+#define BNXT_RSS_CAP_AH_V6_RSS_CAP		BIT(5)
+#define BNXT_RSS_CAP_ESP_V4_RSS_CAP		BIT(6)
+#define BNXT_RSS_CAP_ESP_V6_RSS_CAP		BIT(7)
 
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index a0962026a85f..f3ec5b96a5d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1533,8 +1533,14 @@ static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			cmd->data |= RXH_IP_SRC | RXH_IP_DST |
 				     RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		fallthrough;
-	case SCTP_V4_FLOW:
 	case AH_ESP_V4_FLOW:
+		if (bp->rss_hash_cfg &
+		    (VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 |
+		     VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4))
+			cmd->data |= RXH_IP_SRC | RXH_IP_DST |
+				     RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case SCTP_V4_FLOW:
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
 	case IPV4_FLOW:
@@ -1552,8 +1558,14 @@ static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			cmd->data |= RXH_IP_SRC | RXH_IP_DST |
 				     RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		fallthrough;
-	case SCTP_V6_FLOW:
 	case AH_ESP_V6_FLOW:
+		if (bp->rss_hash_cfg &
+		    (VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV6 |
+		     VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV6))
+			cmd->data |= RXH_IP_SRC | RXH_IP_DST |
+				     RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case SCTP_V6_FLOW:
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
 	case IPV6_FLOW:
@@ -1600,6 +1612,24 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6;
 		if (tuple == 4)
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6;
+	} else if (cmd->flow_type == AH_ESP_V4_FLOW) {
+		if (tuple == 4 && (!(bp->rss_cap & BNXT_RSS_CAP_AH_V4_RSS_CAP) ||
+				   !(bp->rss_cap & BNXT_RSS_CAP_ESP_V4_RSS_CAP)))
+			return -EINVAL;
+		rss_hash_cfg &= ~(VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 |
+				  VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4);
+		if (tuple == 4)
+			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV4 |
+					VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV4;
+	} else if (cmd->flow_type == AH_ESP_V6_FLOW) {
+		if (tuple == 4 && (!(bp->rss_cap & BNXT_RSS_CAP_AH_V6_RSS_CAP) ||
+				   !(bp->rss_cap & BNXT_RSS_CAP_ESP_V6_RSS_CAP)))
+			return -EINVAL;
+		rss_hash_cfg &= ~(VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV6 |
+				  VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV6);
+		if (tuple == 4)
+			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_AH_SPI_IPV6 |
+					VNIC_RSS_CFG_REQ_HASH_TYPE_ESP_SPI_IPV6;
 	} else if (tuple == 4) {
 		return -EINVAL;
 	}
-- 
2.30.1


--000000000000e234e10610aa097e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAjkVgv4/Wm3iZ0o017PJ0DY5VjVxqG9
3dnKRx9xUIiiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQClzyqcJdMa+l4dxRBZW0N8rANNB8UAzYU3Ik7JFrKXnFkrZbI9
+8VfGrCDqRWY7Li0lnFaqYunNBDtzht/W9ilqkY2LhNJMuyNbJwB5qVP7E9E1w9Nk3DtdcFXfCtq
gFDU2scg1+D01jQCUh7dYCHXJJx1VGRCnvZy1hYZ1REu16aL2cKTMkX/n7NcLDAsgA+6kC/6qL8K
O16XSnCZL3n9gq2B9NRwq222aQh7FWLFdVPTduv3vNz2iVCpAll+JMnVFvJOdJNImyq9L1CZ8tTu
zzOlOWGbCOP+jhuzl20+D8A9Pb6WF/Gh3Rgdmlqe5tGWBSnurNJnGIU1P9oVP3Yu
--000000000000e234e10610aa097e--

