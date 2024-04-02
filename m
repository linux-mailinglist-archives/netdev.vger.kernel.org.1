Return-Path: <netdev+bounces-83937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED66B894ECF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C13B24531
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC558AC0;
	Tue,  2 Apr 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RVLOkDGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651258AAC
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050544; cv=none; b=HrDKCKNFmH8ka5b0hhomlEtNpKTTXyo966nwxc3oXZK4Ocq6CATl+fgdxbfdz4FZqgL+G93uXHCJmvyxCCD8nwAe1PwG7O+LJ0X2Tq5nd2jfzMHK7BWmIulB+/Lejazwew5vfpu6v6Sq8l9gnzji+nfdiqdMsH8eA5gddkL3kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050544; c=relaxed/simple;
	bh=rpMwjBvsulNLSdj7VTFpSmssyr2QEGqZUpUB2lcxPgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCbb+ij5vk3bBC2n5qlrnQO9im93QxlJlfD5ebnHfPtnDMWBeIfQSnbYXbdxoo9c5MCOvRjBi2q1/S+730cxgGC5EQPQy9sksjnmut5n7OkY/UA2d6KWre0mOmxq0Wlf0MiH5NqsbsrGOTPhpyM4Mow5HclBrqenv/evKxQADIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RVLOkDGS; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c3f16f9c81so2327346b6e.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712050542; x=1712655342; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku0mrkb12wJLxrj5c2WKpVbSR0MFXMV9Y6xNWDL8Rkw=;
        b=RVLOkDGSqT0dZcU4xTQcv3MAkDzca4rMh9zs83us+EVwhVqQVaJft5byPgZXDBxPFR
         0dQE1eZQis4KVZ7BC9E3omXk37ERcuOrrXB/HjcsgbruiZGWKzwyU6DCBFXWI+RTArcF
         vlILZvDqaPBvfuuWdascJbH8yNvBgMzp4n5pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050542; x=1712655342;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku0mrkb12wJLxrj5c2WKpVbSR0MFXMV9Y6xNWDL8Rkw=;
        b=uGMEYuDi0rFwP+ngBHhRFDIoFs6jxl3V4ylfGyxEpArTsgkZ2JpbPEPWbid9Hn2Lym
         pDqKgdh4Bcw85qO/T6n2elqch6Jju/BKAmyO0VmO8v2ifWif7OkcMVzhpQ+v7ALAmrbV
         4rIgsWNUvI983Gmc4T39aRpcqAVrjH15v9jwLHTPVierc9ZrZELNrsBJTfWQ9M51vIf0
         +9qdWTnjJVxOSo2quka5fKZ52njEG9ldFiu/4/qQg4civUm7++up54paUtDkItG7n6Wk
         g0iJHp15GuTPzh/rgEq4WxuOaOv3ZYtlhcPRD5ObUBVEbb3TDCanUPiyqg6PNBVucO4l
         3C7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOBX0rouIVN8fls63E/Ay1xQfFReQ8pMCPX4c8ldro/3084ItL4O3DaadN8yTI8lcdUivUHa/D4QO8WuTNjYdV0lw/iEmP
X-Gm-Message-State: AOJu0YzIWqhNOTMt5A9dKn3MmXm+7f8UuuZp+72Va2Tq/KZaRuvHYxp2
	18FGDWfhpwuJEZ80iE5W0IfVkjd3TKM6iVUXMfg6BM8mZomimBIdqJHuMmThrA==
X-Google-Smtp-Source: AGHT+IFiuVpILg70wiGv8r5X+NsgBtJqToTHENs2I2VW8W6CRKF96LwGx1hZPS/FZeLDbIA+S3xWYw==
X-Received: by 2002:a05:6870:2393:b0:22d:f9e1:dbce with SMTP id e19-20020a056870239300b0022df9e1dbcemr12266085oap.6.1712050541740;
        Tue, 02 Apr 2024 02:35:41 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19-20020a62e113000000b006e5a3db5875sm9702087pfh.13.2024.04.02.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:35:41 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 3/7] bnxt_en: Allocate page pool per numa node
Date: Tue,  2 Apr 2024 02:37:49 -0700
Message-Id: <20240402093753.331120-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
References: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000069c34c061519d4c9"

--00000000000069c34c061519d4c9
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Driver's Page Pool allocation code looks at the node local
to the PCIe device to determine where to allocate memory.
In scenarios where the core count per NUMA node is low (< default rings)
it makes sense to exhaust page pool allocations on
Node 0 first and then moving on to allocating page pools
for the remaining rings from Node 1.

With this patch, and the following configuration on the NIC
$ ethtool -L ens1f0np0 combined 16
(core count/node = 12, first 12 rings on node#0, last 4 rings node#1)
and traffic redirected to a ring on node#1 , we see a performance
improvement of ~20%

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 44b9332c147e..9fca1dee6486 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3559,14 +3559,15 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 }
 
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
-				   struct bnxt_rx_ring_info *rxr)
+				   struct bnxt_rx_ring_info *rxr,
+				   int numa_node)
 {
 	struct page_pool_params pp = { 0 };
 
 	pp.pool_size = bp->rx_agg_ring_size;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size;
-	pp.nid = dev_to_node(&bp->pdev->dev);
+	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
@@ -3586,7 +3587,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 
 static int bnxt_alloc_rx_rings(struct bnxt *bp)
 {
-	int i, rc = 0, agg_rings = 0;
+	int numa_node = dev_to_node(&bp->pdev->dev);
+	int i, rc = 0, agg_rings = 0, cpu;
 
 	if (!bp->rx_ring)
 		return -ENOMEM;
@@ -3597,10 +3599,15 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
 		struct bnxt_ring_struct *ring;
+		int cpu_node;
 
 		ring = &rxr->rx_ring_struct;
 
-		rc = bnxt_alloc_rx_page_pool(bp, rxr);
+		cpu = cpumask_local_spread(i, numa_node);
+		cpu_node = cpu_to_node(cpu);
+		netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%d] on numa_node: %d\n",
+			   i, cpu_node);
+		rc = bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
 		if (rc)
 			return rc;
 
-- 
2.39.1


--00000000000069c34c061519d4c9
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
XzCCBUwwggQ0oAMCAQICDBX9eQgKNWxyfhI1kzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE3NDZaFw0yNTA5MTAwODE3NDZaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDFBhdmFuIENoZWJiaTEoMCYGCSqGSIb3DQEJ
ARYZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAK3X+BRR67FR5+Spki/E25HnHoYhm/cC6VA6qHwC3QqBNhCT13zsi1FLLERdKXPRrtVBM6d0
mfg/0rQJJ8Ez4C3CcKiO1XHcmESeW6lBKxOo83ZwWhVhyhNbGSwcrytDCKUVYBwwxR3PAyXtIlWn
kDqifgqn3R9r2vJM7ckge8dtVPS0j9t3CNfDBjGw1DhK91fnoH1s7tLdj3vx9ZnKTmSl7F1psK2P
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEID4o2CzmSIOitATcZlDWMdG3BEs6OZsE
RUzK7WYqOrKHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
MjA5MzU0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAkXp16DO8jior69NrOhPi2jVnmStKAJCdCt+72ju3chZFFajBO
6ifTS8u/Y4ZBW/vm2rnq5bPpNs9sELgGpmQhVmzfFmPZ/rwTjzYXYNqaLdDr857LwH1Wo8FWWAAR
mIkQjMPuR6MeJ/4VAp32abBYqdOjiw/s0FukslkuFr/HLriXosV5tSIzN82e3GCnJAwfV75P6lwu
NwAv511cJF26sw6xVvUa4ZkB1c0CO/OdYhgF8bUnWfAh8GXN472Xp7BbTrFbybPcJagF/MM+iEUv
DdUMVG3CalNdts5/C6h3489NdH8ZSRO14OHV9udbRBHTL21TK9CRHKDWF6o6d/15
--00000000000069c34c061519d4c9--

