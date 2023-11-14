Return-Path: <netdev+bounces-47567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83087EA763
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A661C209F5
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242C747B;
	Tue, 14 Nov 2023 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f8+F3EUq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302A5688
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:17:10 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450DD4A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3017625a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699921029; x=1700525829; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pl/P+X7phvY9HzWOOc3D1AUGHh6XEWRFI/FtAwBcyqM=;
        b=f8+F3EUq7sH/txvWXEdYxLxzOZ7VWJ0JIp2YNqsJWm8nXm+P/+uAydIjUSQrfivQso
         ZPAGvGowv3e74xarEgbLvkdtIMOSyEnpzk3AOSCBbXWSjQ7okxVVKyLFpVfIVvjC88hu
         BowkbIzZmiseG4AEvFZdjHB0qeKfWB5aQJGoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699921029; x=1700525829;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl/P+X7phvY9HzWOOc3D1AUGHh6XEWRFI/FtAwBcyqM=;
        b=nxIJ1xBHB6QRFLc58KTT0+yn0Czz+xZjAi4Amgg2jbmNmKhuzJb3xteFKxzkROkhQf
         to7NRwGMqxFyB+mOpgNZYyTBHxGQl9H2WnPVABbwtZ4op82PXN+iyJ8doxNqhi6iZ7bp
         ID8TalbxeqSygbL8YEnK90emb2NpAlbJFqoIYQAzstv/dO4apL8+BGtbYqtGtjdg7+8m
         6rJhMHPT4DepcWB7lzc66RfNnvrC1dFNRSuoojUgvwoN6fqbxZF6ejOwTFWhCsnT1A03
         PM8UaqsCukyNUzZp9WzMES/IhWr/RvYsQ6cL+yXmn1diBykmH/X74tL4Lm4Z4urD5QjH
         CTjg==
X-Gm-Message-State: AOJu0Yxa1KlEhgpkLTfmZGyBHi7cs7NxbOzrgg4/7oAC22nKs49w2mbu
	uZmgKX76pj6tdZUe/EuSVylkhQ==
X-Google-Smtp-Source: AGHT+IGUBxSPwmsvIYePR4HiCvobg/PyGCtUWz4PlM2sEfrg45w+SIjizxUSZFHuYSEUdoCFinb33g==
X-Received: by 2002:a17:90b:4a01:b0:280:cd7b:1fa5 with SMTP id kk1-20020a17090b4a0100b00280cd7b1fa5mr5916907pjb.4.1699921028466;
        Mon, 13 Nov 2023 16:17:08 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a680600b0027ffff956bcsm4063478pjj.47.2023.11.13.16.17.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 16:17:07 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v2 12/13] bnxt_en: Use existing MSIX vectors for all mqprio TX rings
Date: Mon, 13 Nov 2023 16:16:20 -0800
Message-Id: <20231114001621.101284-13-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231114001621.101284-1-michael.chan@broadcom.com>
References: <20231114001621.101284-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000019e3b6060a11b52d"

--00000000000019e3b6060a11b52d
Content-Transfer-Encoding: 8bit

We can now fully support sharing the same MSIX for all mqprio TX rings
belonging to the same ethtool channel with the new infrastructure:

1. Allocate the proper entries for cp_ring_arr in struct bnxt_cp_ring_info
to support the additional TX rings.

2. Populate the tx_ring array in struct bnxt_napi for all TX rings
sharing the same NAPI.

3. bnxt_num_tx_to_cp() returns the proper NQ/completion rings to support
the TX rings in the input.

4. Adjust bnxt_get_num_ring_stats() for the reduced number of ring
counters with the new scheme.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 56 ++++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +-
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d0eca7648927..d1af1d2ff800 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3609,7 +3609,10 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 {
 	bool sh = !!(bp->flags & BNXT_FLAG_SHARED_RINGS);
 	int i, j, rc, ulp_base_vec, ulp_msix;
+	int tcs = netdev_get_num_tc(bp->dev);
 
+	if (!tcs)
+		tcs = 1;
 	ulp_msix = bnxt_get_ulp_msix_num(bp);
 	ulp_base_vec = bnxt_get_ulp_msix_base(bp);
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
@@ -3617,6 +3620,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		struct bnxt_cp_ring_info *cpr, *cpr2;
 		struct bnxt_ring_struct *ring;
 		int cp_count = 0, k;
+		int rx = 0, tx = 0;
 
 		if (!bnapi)
 			continue;
@@ -3637,11 +3641,18 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
 			continue;
 
-		if (i < bp->rx_nr_rings)
+		if (i < bp->rx_nr_rings) {
 			cp_count++;
-		if ((sh && i < bp->tx_nr_rings) ||
-		    (!sh && i >= bp->rx_nr_rings))
+			rx = 1;
+		}
+		if (i < bp->tx_nr_rings_xdp) {
 			cp_count++;
+			tx = 1;
+		} else if ((sh && i < bp->tx_nr_rings) ||
+			 (!sh && i >= bp->rx_nr_rings)) {
+			cp_count += tcs;
+			tx = 1;
+		}
 
 		cpr->cp_ring_arr = kcalloc(cp_count, sizeof(*cpr),
 					   GFP_KERNEL);
@@ -3656,14 +3667,19 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 				return rc;
 			cpr2->bnapi = bnapi;
 			cpr2->cp_idx = k;
-			if (!k && i < bp->rx_nr_rings) {
+			if (!k && rx) {
 				bp->rx_ring[i].rx_cpr = cpr2;
 				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_RX;
 			} else {
-				bp->tx_ring[j++].tx_cpr = cpr2;
+				int n, tc = k - rx;
+
+				n = BNXT_TC_TO_RING_BASE(bp, tc) + j;
+				bp->tx_ring[n].tx_cpr = cpr2;
 				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_TX;
 			}
 		}
+		if (tx)
+			j++;
 	}
 	return 0;
 }
@@ -4704,24 +4720,33 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 		else
 			j = bp->rx_nr_rings;
 
-		for (i = 0; i < bp->tx_nr_rings; i++, j++) {
+		for (i = 0; i < bp->tx_nr_rings; i++) {
 			struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
+			struct bnxt_napi *bnapi2;
 
 			if (bp->flags & BNXT_FLAG_CHIP_P5)
 				txr->tx_ring_struct.ring_mem.flags =
 					BNXT_RMEM_RING_PTE_FLAG;
-			else
-				txr->tx_cpr =  &bp->bnapi[i]->cp_ring;
-			txr->bnapi = bp->bnapi[j];
-			bp->bnapi[j]->tx_ring[0] = txr;
 			bp->tx_ring_map[i] = bp->tx_nr_rings_xdp + i;
 			if (i >= bp->tx_nr_rings_xdp) {
+				int k = j + BNXT_RING_TO_TC_OFF(bp, i);
+
+				bnapi2 = bp->bnapi[k];
 				txr->txq_index = i - bp->tx_nr_rings_xdp;
-				bp->bnapi[j]->tx_int = bnxt_tx_int;
+				txr->tx_napi_idx =
+					BNXT_RING_TO_TC(bp, txr->txq_index);
+				bnapi2->tx_ring[txr->tx_napi_idx] = txr;
+				bnapi2->tx_int = bnxt_tx_int;
 			} else {
-				bp->bnapi[j]->flags |= BNXT_NAPI_FLAG_XDP;
-				bp->bnapi[j]->tx_int = bnxt_tx_int_xdp;
+				bnapi2 = bp->bnapi[j];
+				bnapi2->flags |= BNXT_NAPI_FLAG_XDP;
+				bnapi2->tx_ring[0] = txr;
+				bnapi2->tx_int = bnxt_tx_int_xdp;
+				j++;
 			}
+			txr->bnapi = bnapi2;
+			if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+				txr->tx_cpr = &bnapi2->cp_ring;
 		}
 
 		rc = bnxt_alloc_stats(bp);
@@ -9099,7 +9124,7 @@ static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 
 static int __bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_sets, int tx_xdp)
 {
-	return tx;
+	return (tx - tx_xdp) / tx_sets + tx_xdp;
 }
 
 int bnxt_num_tx_to_cp(struct bnxt *bp, int tx)
@@ -13723,7 +13748,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	max_irqs = bnxt_get_max_irq(pdev);
-	dev = alloc_etherdev_mq(sizeof(*bp), max_irqs);
+	dev = alloc_etherdev_mqs(sizeof(*bp), max_irqs * BNXT_MAX_QUEUE,
+				 max_irqs);
 	if (!dev)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 76f2eab52ce7..585044310141 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -528,7 +528,8 @@ static int bnxt_get_num_ring_stats(struct bnxt *bp)
 	     bnxt_get_num_tpa_ring_stats(bp);
 	tx = NUM_RING_TX_HW_STATS;
 	cmn = NUM_RING_CMN_SW_STATS;
-	return rx * bp->rx_nr_rings + tx * bp->tx_nr_rings +
+	return rx * bp->rx_nr_rings +
+	       tx * (bp->tx_nr_rings_xdp + bp->tx_nr_rings_per_tc) +
 	       cmn * bp->cp_nr_rings;
 }
 
-- 
2.30.1


--00000000000019e3b6060a11b52d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOmmwelCKl1qO5iw8ya844T0NbzRadHL
kQ5uTNXIo0N9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEx
NDAwMTcwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCzPxkch1l0x0B0oypECxi7r/2pGMXYxtBk7YV5HAzpvQLlyqPJ
m3qL3r6t7J7JTrnJJbgLna21m+tZD4bCLtMFFIhWGb7VBJqHxLjTWVsASIl2PxY2OAgyHTtovObQ
//YGkDxuTcCOPvzTANLHSWcuLh4HUAs2i/shyeNbD5pdWEXqJ6vLRUaN9o9CvSw0pr8nUbrfXOAA
SQesZRBhopXDe+DgkwlVLTlchK7+4E7qV6NawB6kHhTK2w+Y938dHJrMnH5Z6/aTa2Hm5pu8wRkb
hbN2TL9PedW+pzB6Ei0fm1TAAWuVGH33YPvmStv1KQpwsWc09wyygdaOl+xr+DbG
--00000000000019e3b6060a11b52d--

