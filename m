Return-Path: <netdev+bounces-107805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360691C69F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82DC1F25750
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09E78B60;
	Fri, 28 Jun 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EdofCHxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB296762D2
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603041; cv=none; b=R30OW1mAeLQIEcP63uBEG/P/Vc8bC2t2/eLKAlcsFKqRdygYS0LenV0DBsNRimfdhw13aCIPR0QgU2canvMFFfXD/Jq86oUscgrv4tMiMwfybb+Y5TvnBkkwhjf7UbbiMzZh9TP+0NrmeruGj6DYDA3N8rf5eMh1/fIEFn2XPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603041; c=relaxed/simple;
	bh=xjv8WqsLurkTApHtAtrISsaD4Iey8mqMNIinFjVRfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXPDuF3TsihSkAy4bMG6u1quWZdpPZkz8Foor2RVGtt+HR/Zylp6OYdGCFRuRx2Z17nlX0UueMqQF3S5sjYaNbdDxNpQfZy+PWdvda9QcLem+WFS8jng8Ro/h7y6hGxONigrP7eNYkZ9O4fmEUreIz5PdU7lpmy9p8o7YooU/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EdofCHxf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71871d5e087so625912a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719603039; x=1720207839; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvTVR9v4L6sSS0ncZ93rbwMU4d0T8t+SocvwTKDypO4=;
        b=EdofCHxf6O10LGhFmcMoSqAQkonI1Oa9lyay/qyMGzQ9iM1ufj7GBDQJfsq5e9wPwK
         knwLHmIr2w35e3FqCr3YRCp2/hbFqirqVsw57uThBmFy0R7VFpMKL0908I3Mn+HLAUug
         F6ysuOFsTB+Y724mGovDJQNQ3t/+Vk6MCFtwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603039; x=1720207839;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvTVR9v4L6sSS0ncZ93rbwMU4d0T8t+SocvwTKDypO4=;
        b=FvrQ7SHSboYvrX6OUuob1MwrrDhMEY6VKcnYGJsI5ZMnWIUf1g+0uQtdI6TLfKvP/I
         WrbC+d60gjgRisuAuvVxju0AnXUdnpq9if7iovPdc90KFcC1DAXuvyyzFMPzoq8CLSqb
         k/DEQiDx+UMdPxqyZ4zpVy4cQtWB45p1KViQZ7PBBx+DHlCuyzIw/r5SiPLaDRB1YHUo
         pKX+/aTzC7hN+DGKBmjNvp0pco5NBUHnXosb7ldj1Z+Cp79epFfb/UU/famkQXxkwG8V
         YSUAtMOX2UQgD/4pZnf3vXea3PzZFKXXgumkkyb4JCbL2djEZTUfYQH2oOHsJIlut5lp
         /Lpw==
X-Gm-Message-State: AOJu0Yw9JFul1Ktj2auz05ppaywhaTc9iTtnABWEs4BwBl4gwXW4Y3q+
	lCBwaX9hAKHlFqAoy8XkEIXUVkWio/ABRBJ8sjQuc0pSVPtEGsg031DIliA3Ow==
X-Google-Smtp-Source: AGHT+IHYEEdqgoHRNa+LKpEcaapA3+wK/RW8jSuY8wdYGIT0IOrLA3Ii0XAjstWhb6l9HmB2kUFqXw==
X-Received: by 2002:a05:6a20:a820:b0:1bd:d5ba:e163 with SMTP id adf61e73a8af0-1bdd5bae1b7mr9536330637.26.1719603038789;
        Fri, 28 Jun 2024 12:30:38 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939cc9b04sm46707a91.0.2024.06.28.12.30.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:30:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/10] bnxt_en: Let bnxt_stamp_tx_skb() return error code
Date: Fri, 28 Jun 2024 12:30:03 -0700
Message-ID: <20240628193006.225906-9-michael.chan@broadcom.com>
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
	boundary="0000000000005307db061bf84807"

--0000000000005307db061bf84807
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Change the function bnxt_stamp_tx_skb() to return 0 for suceess
or -EAGAIN if the timestamp is still pending in firmware.  The
calling PTP aux worker will reschedule based on the return code.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index baf191959b13..bd1e270307ec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -683,7 +683,7 @@ static u64 bnxt_cc_read(const struct cyclecounter *cc)
 	return ns;
 }
 
-static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
+static int bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct skb_shared_hwtstamps timestamp;
@@ -711,7 +711,7 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 	} else {
 		if (!time_after_eq(jiffies, txts_req->abs_txts_tmo)) {
 			txts_req->txts_pending = true;
-			return;
+			return -EAGAIN;
 		}
 		ptp->stats.ts_lost++;
 		netdev_warn_once(bp->dev,
@@ -722,6 +722,8 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 	txts_req->tx_skb = NULL;
 	atomic_inc(&ptp->tx_avail);
 	txts_req->txts_pending = false;
+
+	return 0;
 }
 
 static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
@@ -730,12 +732,16 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 						ptp_info);
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
+	int rc = 0;
 
 	if (ptp->txts_req.tx_skb)
-		bnxt_stamp_tx_skb(bp, ptp->txts_req.tx_skb);
+		rc = bnxt_stamp_tx_skb(bp, ptp->txts_req.tx_skb);
 
-	if (!time_after_eq(now, ptp->next_period))
+	if (!time_after_eq(now, ptp->next_period)) {
+		if (rc == -EAGAIN)
+			return 0;
 		return ptp->next_period - now;
+	}
 
 	bnxt_ptp_get_current_time(bp);
 	ptp->next_period = now + HZ;
@@ -745,7 +751,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 		spin_unlock_bh(&ptp->ptp_lock);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
-	if (ptp->txts_req.txts_pending)
+	if (rc == -EAGAIN)
 		return 0;
 	return HZ;
 }
-- 
2.30.1


--0000000000005307db061bf84807
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMmhT8ONFDqdL8jH7eVJ3xbmWMUkf7bD
EmB0LfxkkVjcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE5MzAzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCYOz8gQOa3ChenRaf9xKmOIy70uFVF8tjpmwnqwQRMM97avZza
Pq6PajiJlgvkFOLMFgK6El6HkIbnpXgQs4J9mBfmfEfAU9sAOMemNGEQS6AunER9vCpfFEn+PWCS
oYKidpLKJYaLsynv1GyRAPOa5tKDuGWqwRhB7/iOJVbjZ1+4jwRjVYScAN6hjQk8dITW66yk4qSs
NpZSa7T929b2xbPp01Pw1Oed81uPhPEqAp4QqXU7V6+/F+uNSTzAUyZbOGEwzMsj0hS9Dp0WqSZ8
nuUT6CVCqBqi1dKMmzIcm5c+9bBhDvapfP46/Gc2ZfSGcOAmw5YaeBcB/36OZRxK
--0000000000005307db061bf84807--

