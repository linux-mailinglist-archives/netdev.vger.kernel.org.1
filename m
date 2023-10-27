Return-Path: <netdev+bounces-44929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555E7DA408
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74401C211E7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1428C41235;
	Fri, 27 Oct 2023 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xvp0xvM9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8963FE4F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:23:41 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C411BE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:39 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778a47bc09aso187926885a.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698449018; x=1699053818; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lL3H9HwN2sv6Qnjfl1jtnueXHA/st1xchVahL9w4xt4=;
        b=Xvp0xvM9HLJkKpscGEKYZ8Fu6QpWaPGU5ihO0pJZUmHvzBHziYunzoKydv/m9FYa1C
         fNh2aY1Y0QSpCogqzeUtw63fzmJIdpvA3D9oIeRU32QHJlNgWdM6ED4o3x5l/ogMIX7m
         jvNQriKC8iNTWcy9NlWBTK2XE8YBegh/3aezA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449018; x=1699053818;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL3H9HwN2sv6Qnjfl1jtnueXHA/st1xchVahL9w4xt4=;
        b=oQw3eAfEe05E6TNvMpS04lgzS0NR03iSmaN/MG3t/z6aCzX0vj8FEBUz1RoXVZv9Np
         d3kHZ0RgtHYvNF7O1Gg9K73eot6WbKGbk0mmdtLrgmrmmxWrJqQXHXnsMA5rKorXHaku
         /1mHSmVWPQG76KQjJt1JJD/KabJ9hAUIRzlxa6sFrq8jzlh0d7STOMRyFZtQgaXYA83j
         tps56xhrtmPzcYqX/rAtagdK+9xBxT7hstm7V5WyOt2d+MzwDzUlwABDQAviycH1KTuY
         0EmWQYQHc4Nbmgb54yVse4w6iQrl+ena3qbEyHv+E7w8SCDlVX4cCkq6d21dwMyXKVyV
         Be8g==
X-Gm-Message-State: AOJu0YwvBFYuaZeVBF9TNq4IJBRVlFDmRtHMU+5TfCKRhQW03BJfGeeK
	uYE6V8SrKHJSWVyVFahoh8Ajew==
X-Google-Smtp-Source: AGHT+IEeryB9cuqKZzDxlGQRBGc5ewI9GqG0ARxzo6oQxbVl2d6US56U3QPZcBwb0aWC4lJttdhpTw==
X-Received: by 2002:a05:620a:288a:b0:77a:da7:23d4 with SMTP id j10-20020a05620a288a00b0077a0da723d4mr4262522qkp.42.1698449018018;
        Fri, 27 Oct 2023 16:23:38 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b007742ad3047asm984169qky.54.2023.10.27.16.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:23:37 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 04/13] bnxt_en: Add completion ring pointer in TX and RX ring structures
Date: Fri, 27 Oct 2023 16:22:43 -0700
Message-Id: <20231027232252.36111-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231027232252.36111-1-michael.chan@broadcom.com>
References: <20231027232252.36111-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d02600608bafa23"

--0000000000006d02600608bafa23
Content-Transfer-Encoding: 8bit

From the TX or RX ring structure, we need to find the corresponding
completion ring during initialization.  On P5 chips, we use the MSIX/napi
entry to locate the completion ring because there is only one RX/TX
ring per MSIX.  To allow multiple TX rings for each MSIX, we need
to add a direct pointer from the TX ring and RX ring structures.
This also simplifies the existing logic.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 ++++++++-----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 585120369935..11a85cb28517 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3584,11 +3584,11 @@ static int bnxt_alloc_cp_sub_ring(struct bnxt *bp,
 static int bnxt_alloc_cp_rings(struct bnxt *bp)
 {
 	bool sh = !!(bp->flags & BNXT_FLAG_SHARED_RINGS);
-	int i, rc, ulp_base_vec, ulp_msix;
+	int i, j, rc, ulp_base_vec, ulp_msix;
 
 	ulp_msix = bnxt_get_ulp_msix_num(bp);
 	ulp_base_vec = bnxt_get_ulp_msix_base(bp);
-	for (i = 0; i < bp->cp_nr_rings; i++) {
+	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr, *cpr2;
 		struct bnxt_ring_struct *ring;
@@ -3626,6 +3626,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			if (rc)
 				return rc;
 			cpr2->bnapi = bnapi;
+			bp->rx_ring[i].rx_cpr = cpr2;
 		}
 		if ((sh && i < bp->tx_nr_rings) ||
 		    (!sh && i >= bp->rx_nr_rings)) {
@@ -3634,6 +3635,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			if (rc)
 				return rc;
 			cpr2->bnapi = bnapi;
+			bp->tx_ring[j++].tx_cpr = cpr2;
 		}
 	}
 	return 0;
@@ -4654,6 +4656,8 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 					BNXT_RMEM_RING_PTE_FLAG;
 				rxr->rx_agg_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
+			} else {
+				rxr->rx_cpr =  &bp->bnapi[i]->cp_ring;
 			}
 			rxr->bnapi = bp->bnapi[i];
 			bp->bnapi[i]->rx_ring = &bp->rx_ring[i];
@@ -4682,6 +4686,8 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 			if (bp->flags & BNXT_FLAG_CHIP_P5)
 				txr->tx_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
+			else
+				txr->tx_cpr =  &bp->bnapi[i]->cp_ring;
 			txr->bnapi = bp->bnapi[j];
 			bp->bnapi[j]->tx_ring = txr;
 			bp->tx_ring_map[i] = bp->tx_nr_rings_xdp + i;
@@ -5242,28 +5248,18 @@ static u16 bnxt_cp_ring_from_grp(struct bnxt *bp, struct bnxt_ring_struct *ring)
 
 static u16 bnxt_cp_ring_for_rx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
-		struct bnxt_napi *bnapi = rxr->bnapi;
-		struct bnxt_cp_ring_info *cpr;
-
-		cpr = &bnapi->cp_ring.cp_ring_arr[BNXT_RX_HDL];
-		return cpr->cp_ring_struct.fw_ring_id;
-	} else {
+	if (bp->flags & BNXT_FLAG_CHIP_P5)
+		return rxr->rx_cpr->cp_ring_struct.fw_ring_id;
+	else
 		return bnxt_cp_ring_from_grp(bp, &rxr->rx_ring_struct);
-	}
 }
 
 static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 {
-	if (bp->flags & BNXT_FLAG_CHIP_P5) {
-		struct bnxt_napi *bnapi = txr->bnapi;
-		struct bnxt_cp_ring_info *cpr;
-
-		cpr = &bnapi->cp_ring.cp_ring_arr[BNXT_TX_HDL];
-		return cpr->cp_ring_struct.fw_ring_id;
-	} else {
+	if (bp->flags & BNXT_FLAG_CHIP_P5)
+		return txr->tx_cpr->cp_ring_struct.fw_ring_id;
+	else
 		return bnxt_cp_ring_from_grp(bp, &txr->tx_ring_struct);
-	}
 }
 
 static int bnxt_alloc_rss_indir_tbl(struct bnxt *bp)
@@ -6022,12 +6018,10 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		u32 map_idx;
 
 		if (bp->flags & BNXT_FLAG_CHIP_P5) {
+			struct bnxt_cp_ring_info *cpr2 = txr->tx_cpr;
 			struct bnxt_napi *bnapi = txr->bnapi;
-			struct bnxt_cp_ring_info *cpr, *cpr2;
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 
-			cpr = &bnapi->cp_ring;
-			cpr2 = &cpr->cp_ring_arr[BNXT_TX_HDL];
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_TX_HDL;
 			map_idx = bnapi->index;
@@ -6062,11 +6056,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 		bp->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
 		if (bp->flags & BNXT_FLAG_CHIP_P5) {
-			struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
+			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
-			struct bnxt_cp_ring_info *cpr2;
 
-			cpr2 = &cpr->cp_ring_arr[BNXT_RX_HDL];
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_RX_HDL;
 			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 429df1cf4a6a..c04089e7ac39 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -806,6 +806,7 @@ struct bnxt_db_info {
 
 struct bnxt_tx_ring_info {
 	struct bnxt_napi	*bnapi;
+	struct bnxt_cp_ring_info	*tx_cpr;
 	u16			tx_prod;
 	u16			tx_cons;
 	u16			tx_hw_cons;
@@ -916,6 +917,7 @@ struct bnxt_tpa_idx_map {
 
 struct bnxt_rx_ring_info {
 	struct bnxt_napi	*bnapi;
+	struct bnxt_cp_ring_info	*rx_cpr;
 	u16			rx_prod;
 	u16			rx_agg_prod;
 	u16			rx_sw_agg_prod;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 675e37700289..18c06158fead 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3941,7 +3941,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5)
-		cpr = &cpr->cp_ring_arr[BNXT_RX_HDL];
+		cpr = rxr->rx_cpr;
 	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
-- 
2.30.1


--0000000000006d02600608bafa23
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMefDsGtfC0cbRREs5BA32SYlaC6gi6f
0gTPjfJc57LJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
NzIzMjMzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBDAGE9NbU9qWi7o6zU2tqmzYB6grbZT3JQtv3KZVxAcDB8PX+L
Hpr7PhbepuQWsl+JTwcM7rVEh7LbVCpakzcur7iTzPb32KaPsYqmQgpVgCpLeibQTdqigSZxRXRc
fn/h6oMABjC18qcJ2YFGF/zc4CfJlc7Lg6P4t8YbxqEMwA9gkY2mhgvceUdKnp0n0lQ6EiGGqvpk
+MNbpHRFQHyFFRQYeqCsJXcBGAefZL3De4d0wk+svUIPYOYUWJCnaE+wQiyrfqxJOJbsWuJDoiAv
CSrPCpx5FZFg8c4aXuRafu7CxKrbr9g08eHmx+HgNiFjjzRLHLccNXsqgHrLViEd
--0000000000006d02600608bafa23--

