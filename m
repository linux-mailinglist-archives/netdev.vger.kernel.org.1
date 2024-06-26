Return-Path: <netdev+bounces-107008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0889187B5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872871F24269
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE3190047;
	Wed, 26 Jun 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gtfwDIKz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619A18FDCF
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420227; cv=none; b=kSt5/8bSsYQy95Wy3/g0/yZnMoG1t6RJ8zW0w9f9yQ8nACuad4XxuTC22Ca5GsCtOiMeRTnEt30te6Ss2t1meYOXI2naayVi7icMI9bkoSyz/T0NmpCJh9DXxvAOuWMsF5Z/7ysWL1qUU3qe5Y0jsswAKimtnVEO4w4i9V5PVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420227; c=relaxed/simple;
	bh=T+6CFfWRYFa8uJvryOyD05vwqYzv5B++kfE6kXjp58k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/BxcKBM+JoKtuVBI2URBogHY30Dh6GzT/G3LnrFFwhi9+Tlo2suuKXkbR/mCjqSdoH9qmsOffW6ab70uGJBN379D61vsu+4yVaPeHXnw4ceNaLK+y3pJ487PHU/VT9YFSGfDLNpwci59vBITYu+m1FGD101AfJ2MDDp1ZOvBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gtfwDIKz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c05313ec8so137393985a.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719420225; x=1720025025; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onr20j6DLjsl7PydSZyHaOF9uCE8J6kvDxx3ihAZjM=;
        b=gtfwDIKzDhetyHWGyAzaY9RPzwOA1+LNOHp9jTU+cyb8i654ol7yANagl9Bsi3M6Oc
         fwqWq3IOXpbETB6V+3tYpmR6zFDix6pVEdh5wTOLer7KMfmoxFLJD/LnKFnQUk8l8v6A
         +a86S2TBSiFpW8Z5FrYADch8Vq+nqxYCAaKrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420225; x=1720025025;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onr20j6DLjsl7PydSZyHaOF9uCE8J6kvDxx3ihAZjM=;
        b=Zefd6Kx72u+KFCF00OKZBiLydWcB0Sk1MU7gk+EHqQWf56omeO3CXcJ0O1l1MxsZ1q
         RyRSJmB67TT5w64/JIiCIwKk8EHc1Vn4Prk1LTLO7zJeJEftF6euh9mt6Ju7WZO2kurS
         FdjhASzYSKTPU67G5MZcAvfoGf4NNWpvscw2CiOwxgn31G0Df2c6fQ/yOyYG07KQLNAK
         oEAsoF2CQe9NUFNlssNKf03ijg44lwrgOReQXGl0vkTo11EG1gaRuJwDx6TzaAv5McQ5
         HtYQP0mNiTc+h9UpJJTAGFiZg+Dc6LftXURLrJaSs2b6vXV+0/cogG9MoYuBc5fZvAAD
         4XbA==
X-Gm-Message-State: AOJu0YyK73yf9+z0CRZoR2HfAn+Ui2Wl7zx56CHITkK/CBh+1njHdPk8
	H2gjhyxdjoeRB0hrLiZGXhYAkRWhW7tVdSqZKpHRf0VGWlvrGQVEUvsu5dvI/X/sMFGazrDPK7I
	=
X-Google-Smtp-Source: AGHT+IFTa5APjcViZnk55jjLe/Zt9Ne6itwXSib0m1UbgitndDXB1u/4+RLN7sMdxBnKSWJHJnjVBg==
X-Received: by 2002:a05:620a:240f:b0:795:5115:5ae3 with SMTP id af79cd13be357-79be47b7035mr1245339685a.50.1719420224734;
        Wed, 26 Jun 2024 09:43:44 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d53c42aafsm53570485a.58.2024.06.26.09.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:43:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 08/10] bnxt_en: Let bnxt_stamp_tx_skb() return error code
Date: Wed, 26 Jun 2024 09:43:05 -0700
Message-ID: <20240626164307.219568-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240626164307.219568-1-michael.chan@broadcom.com>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c40c05061bcdb731"

--000000000000c40c05061bcdb731
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


--000000000000c40c05061bcdb731
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
NjE2NDM0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQANqM871QiSsA5Kvkm+mhDNzqkruao1RL8nrODOlP7iKW96PSH8
13YPfQFM4Nnv2SZ7pjBR9x6ZReB32JO9vs3TstzVrufJHu35ZfuDru1bEx1ZoTmGCxcB3i+J7Yi+
oJ+wfiTF8eoJe/vNzKf2Pfj7IGqMtlRPvzxhU76zvxoXh2yALD4fPMllgX6LKw3RDLpvfQSuEUV2
qlAtb0ksd0lRmm7oP15WzTQU2j0ceOrnhh/0DZOPFsWFfNHWj3E6/OaLsPyAZat9sqbi5SstCLrw
MuuRso1x5G/EVN9ocONwhdwU21TSDVINcowt7/8TrMlOK2amE/0KD6y9nmfEKD3A
--000000000000c40c05061bcdb731--

