Return-Path: <netdev+bounces-107800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486CE91C69A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A01B1C23C25
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F6770E2;
	Fri, 28 Jun 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CzokP0O9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD5770F6
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603033; cv=none; b=kIV0hYAGAU2f172RS++kvm+cDwaFW5rOs1ulCQT6GM/WGgHxoWlzoJrv973Z9ih0cwdSsrt/HPLPpyeyRff7U8u97bhQDkhHE9gwSN9F4hsYYkGEtj6pKDXUR1XMcd9Fd++FhDdET7gkkLIpbWG4he2toKGudhk+puZmm+Bn/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603033; c=relaxed/simple;
	bh=N/5Gsur6PTzMHZisiFrWeWGentk+QujSTBMfv/sWYhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLBkpEjn51MuQCdnvIAaDpWsRWNRFDLHx8Jh0AhOoJFVaQe5a9xteeYsBUcJo3GTDt9wtJSxHrNPYoBBJfPzYqwJjHSiD0/aFJh8SoPKn9r1AwjHlSsdfIEx9gXUGEMa2GTPLfWsJ+NivJ13HGnN0SjZSthPHEdeFIfHasMwkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CzokP0O9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c92d00059eso652527a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719603031; x=1720207831; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCMiLBJbI9HaV5+s0ye4QXxe3LciKfqehuLbq0KWIms=;
        b=CzokP0O9AzVuUdDPWBX5sJTKJtGSigb7FPQ5Q8jD07T1EHbX10WV1VwHAlSVd7k4xI
         qxQ0wnrxaqbcok+12l7n5FsaxVMy3bPGtjidvcUP6JadD0DbEczdYjP3MaSyG1t3eFTa
         TO98TgPHlTum55xP/05io24FWTk45E6IEar7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603031; x=1720207831;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCMiLBJbI9HaV5+s0ye4QXxe3LciKfqehuLbq0KWIms=;
        b=SRMLTgLzJEeVk9eDdp3o1+S87oHYy7fX3f+8u0j+ThwXVpW2WsRlx6jXUXBhPN6uF6
         q/S+ALnLypxiseSr40pySBysxSbQn9LVZI3urqqQDMYApxi3DubyH3magWQkm8MlzjgU
         QliCHF5XhbrcvYnos2N3FCfDzTsTqKt0fdX5ToctVM9NTgcBOj6bFw1f+nv6oIK+baJx
         3L0819Kd9oH5AzZCNw0ytx5qJTDi3FZknVBQ21mvbEXWlumOqbabw4zZAEV4timAgGHE
         azUAqgBVMzFiV30kTtOApzUAPKB/cn89lIFy9aDOpXk4KotO23KZsBTsXUnoC2ZDKbzK
         12eA==
X-Gm-Message-State: AOJu0YylSEJKJapU1Si/XMXV7wSHzoL2ZGM1Z9k3eWCI/muoh+wctARC
	e++rkoWYHsJyb8LPs1ltilkFv6tddI4zB5/gUHushviqKzLhbyE+ax3epRt4AQ==
X-Google-Smtp-Source: AGHT+IEtc4bHdFbqfl4KL/IMNHIDHZmTVUBQQIodIJrg4yJvgf/aNU+yAd39CmLhUs7pQrSQSz5MIg==
X-Received: by 2002:a17:90b:1643:b0:2c2:f81f:f97f with SMTP id 98e67ed59e1d1-2c861485fcemr14175137a91.48.1719603030401;
        Fri, 28 Jun 2024 12:30:30 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939cc9b04sm46707a91.0.2024.06.28.12.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:30:29 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next v2 03/10] bnxt_en: Allow some TX packets to be unprocessed in NAPI
Date: Fri, 28 Jun 2024 12:29:58 -0700
Message-ID: <20240628193006.225906-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240628193006.225906-1-michael.chan@broadcom.com>
References: <20240628193006.225906-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d70ec8061bf8473e"

--000000000000d70ec8061bf8473e
Content-Transfer-Encoding: 8bit

The driver's current logic will always free all the TX SKBs up to
txr->tx_hw_cons within NAPI.  In the next patches, we'll be adding
logic to handle TX timestamp completion and we may need to hold
some remaining TX SKBs if we don't have the timestamp completions
yet.

Modify __bnxt_poll_work_done() to clear each event bit separately to
allow bnapi->tx_int() to decide whether to clear BNXT_TX_CMP_EVENT or
not.  bnapi->tx_int() will not clear BNXT_TX_CMP_EVENT if some TX
SKBs are held waiting for TX timestamps.  Note that legacy chips will
never hold any SKBs this way.  The SKB is always deferred to the PTP
worker slow path to retrieve the timestamp from firmware.  On the new
P7 chips, the timestamp is returned by the hardware directly and we
can retrieve it directly from NAPI.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index af064dcc6142..9dbf2967df1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -770,7 +770,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+/* Returns true if some remaining TX packets not processed. */
+static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  int budget)
 {
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
@@ -793,7 +794,7 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 
 		if (unlikely(!skb)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
-			return;
+			return false;
 		}
 
 		tx_pkts++;
@@ -842,18 +843,22 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
 				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
+
+	return false;
 }
 
 static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr;
+	bool more = false;
 	int i;
 
 	bnxt_for_each_napi_tx(i, bnapi, txr) {
 		if (txr->tx_hw_cons != RING_TX(bp, txr->tx_cons))
-			__bnxt_tx_int(bp, txr, budget);
+			more |= __bnxt_tx_int(bp, txr, budget);
 	}
-	bnapi->events &= ~BNXT_TX_CMP_EVENT;
+	if (!more)
+		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -2950,8 +2955,10 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (event & BNXT_REDIRECT_EVENT)
+	if (event & BNXT_REDIRECT_EVENT) {
 		xdp_do_flush();
+		event &= ~BNXT_REDIRECT_EVENT;
+	}
 
 	if (event & BNXT_TX_EVENT) {
 		struct bnxt_tx_ring_info *txr = bnapi->tx_ring[0];
@@ -2961,6 +2968,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		wmb();
 
 		bnxt_db_write_relaxed(bp, &txr->tx_db, prod);
+		event &= ~BNXT_TX_EVENT;
 	}
 
 	cpr->cp_raw_cons = raw_cons;
@@ -2978,13 +2986,14 @@ static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 		struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 
 		bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
+		bnapi->events &= ~BNXT_RX_EVENT;
 	}
 	if (bnapi->events & BNXT_AGG_EVENT) {
 		struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+		bnapi->events &= ~BNXT_AGG_EVENT;
 	}
-	bnapi->events &= BNXT_TX_CMP_EVENT;
 }
 
 static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
-- 
2.30.1


--000000000000d70ec8061bf8473e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP1lEhF6QvrHPjy/TgJwlJcBiscaYTks
lkzPYTkSzo6mMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE5MzAzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA25oR7LvWVGdpfCoqgqA/spYUk+QodrV4nJd50qReSvOtifXAS
5AsL6g2uajqBd1QffkHKP8GuVh+LFAcSSOMldLShUEJg7Mvcy3IjAKhs1YuoZ4b2LcYKCkonSscb
eXvVKC1HnGOhNMZzQepkfjf16g/J3lW8FUOQYBFoTMR3gtYWU7j8Xr7EtQGEC0NkGYLcNXpUiX/W
JoAlHTznRQTYKr1ned9mI8vBZvdQNA+KS4Xp1mMJKMJGWCWsBgQX8NPXSHizYPi/5raQ530wKom1
THKBEv5xMUC2HCQmX4TaZwZX5UNPu6rv0wtp9sO6ZQo2yyuuWUtfj+2IuoS0vvSk
--000000000000d70ec8061bf8473e--

