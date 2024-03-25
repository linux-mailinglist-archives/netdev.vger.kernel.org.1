Return-Path: <netdev+bounces-81829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07C88B66A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F57B45484
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB048811EB;
	Mon, 25 Mar 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aio1HItd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D87580C
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405774; cv=none; b=WWb8QB009dIvg3623p68ddRhfKHNkyM++KCxrkebM0n1zqLsM/HYTkPVia1cMy/p53/0mcnJZVorBVTTnI25VYU1wSIUtGdC3Jy4En2WQDVrF6vb2HhBxW06bUpBf9/D5w1I8lBBcVVJpHEVJ1ciYWhiZ9pKvU6DdVDwPCA2zF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405774; c=relaxed/simple;
	bh=IEpA8sPkPYWAB8xIHxpQfvCStlvidqO2RW+cWWXyy2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fA9o1Ca1RyPZtl6Am/Xn5/e7peatrEniwIu5LDN4ab6fOoyQdRTHS9kU379+vlAZdnpH6kaCsOfiEOdqp/McXIK7/sWZKVXieK7mVRXZmT3SOxd6GP2xPGTMm5hYOkuHCs3h9P5+venUc5DLwWorojuMtM6WpSEETnPqn+gf5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aio1HItd; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3d404225dso528584b6e.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405772; x=1712010572; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1/tjJqf/C2b7fpImX+PSq/s/ChFJvkkZvTJOsTW0Nc=;
        b=aio1HItdKP80TsF+13fm66q/9kr53SpfQD0/Jh+RRRJo2MPJAirN3dtkPRA4AW5JMP
         ygGTBDLl4LOcA0PI4ahszAGdY3YjCArfXtgI9Rql7Zs+fnIjnyJICW5QYiYVa+Zk4i4I
         hg72+Kxi0xKLWpChd0oxa8AnaszJrUocxLYlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405772; x=1712010572;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1/tjJqf/C2b7fpImX+PSq/s/ChFJvkkZvTJOsTW0Nc=;
        b=vgCUVrl43hfKuZq3OyBcuKb4oBwVkRd5eO0BaepGRAwgggLoKK2feGtZnc7BTA5jZm
         +5hcgpX3XFdPgp8kETBzut0QyL99o0247sV1tkvicrztTeMR7RzQc2TBYwsELQZV+H3S
         gpwTaqqVdHbUFjZ7uPqv4P7bS+P9ICgMAuauNMWZeo/kXNTcCDRqgvi6/LxdrpS2A1kM
         9zcJlnB661qR+lFz4iHp3lppDQMFQf45TZ63dpSJdX1u5yLpCT9UFzkk62QMdBw+F5Mx
         racrRb2iKbEVkSEwsPkKhroHVx9JLPAgU9GglQFApPCGS20dDtovAKsuW0x40BkBvjWS
         xoDQ==
X-Gm-Message-State: AOJu0Yzb50ma/+dUADIK6FzbphvmM+Bo4OFdLfaISoaJ8uqM2twFpYMw
	pzcJCnyIkujZvHmr1jmXay5SLwCVjlBB202YfGamR4srMwjOdir9kiCF/qzIpyi2dqJnRhpKQPQ
	=
X-Google-Smtp-Source: AGHT+IFclQaB4JbmcWZA1pwoHPj8p0B3Hs6GSwsu2X8Acy74tNRzGZT8oTTQwaj+3DDaHo42/U+/Uw==
X-Received: by 2002:a05:6808:f10:b0:3c3:d31c:fb29 with SMTP id m16-20020a0568080f1000b003c3d31cfb29mr2871107oiw.4.1711405771990;
        Mon, 25 Mar 2024 15:29:31 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:30 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 02/12] bnxt_en: Retry PTP TX timestamp from FW for 1 second
Date: Mon, 25 Mar 2024 15:28:52 -0700
Message-Id: <20240325222902.220712-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000249719061483b5f2"

--000000000000249719061483b5f2
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Use a new default 1 second timeout value instead of the existing
1 msec value.  The driver will keep track of the remaining time
before timeout and will pass this value to bnxt_hwrm_port_ts_query().
The firmware supports timeout values up to 65535 usecs.  If the
timeout value passed to bnxt_hwrm_port_ts_query() is less than the
FW max value, we will use that value to precisely control the
specified timeout.  If it is larger than the FW max value, we will
use the FW max value and any additional retry to reach the desired
timeout will be done in the context of bnxt_ptp_ts_aux_eork().

Link: https://lore.kernel.org/netdev/20240229070202.107488-2-michael.chan@broadcom.com/
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Don't use the devlink parameter.
    Pass the timeout parameter to bnxt_hwrm_port_ts_query() to precisely
    control the timeout.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 16 +++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index dbfd1b36774c..345aac4484ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -678,11 +678,17 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct skb_shared_hwtstamps timestamp;
+	unsigned long now = jiffies;
 	u64 ts = 0, ns = 0;
+	u32 tmo = 0;
 	int rc;
 
+	if (!ptp->txts_pending)
+		ptp->abs_txts_tmo = now + msecs_to_jiffies(ptp->txts_tmo);
+	if (!time_after_eq(now, ptp->abs_txts_tmo))
+		tmo = jiffies_to_msecs(ptp->abs_txts_tmo - now);
 	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts,
-				     0);
+				     tmo);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
 		spin_lock_bh(&ptp->ptp_lock);
@@ -691,6 +697,10 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(ptp->tx_skb, &timestamp);
 	} else {
+		if (!time_after_eq(jiffies, ptp->abs_txts_tmo)) {
+			ptp->txts_pending = true;
+			return;
+		}
 		netdev_warn_once(bp->dev,
 				 "TS query for TX timer failed rc = %x\n", rc);
 	}
@@ -698,6 +708,7 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 	dev_kfree_skb_any(ptp->tx_skb);
 	ptp->tx_skb = NULL;
 	atomic_inc(&ptp->tx_avail);
+	ptp->txts_pending = false;
 }
 
 static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
@@ -721,6 +732,8 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 		spin_unlock_bh(&ptp->ptp_lock);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
+	if (ptp->txts_pending)
+		return 0;
 	return HZ;
 }
 
@@ -973,6 +986,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 		spin_unlock_bh(&ptp->ptp_lock);
 		ptp_schedule_worker(ptp->ptp_clock, 0);
 	}
+	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
 	return 0;
 
 out:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 04886d5f22ad..6a2bba3f9e2d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -22,6 +22,7 @@
 #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
 #define BNXT_HI_TIMER_MASK	0xffff00000000UL
 
+#define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
 #define BNXT_PTP_QTS_TIMEOUT	1000
 #define BNXT_PTP_QTS_MAX_TMO_US	65535
 #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
@@ -116,11 +117,14 @@ struct bnxt_ptp_cfg {
 					 BNXT_PTP_MSG_PDELAY_REQ |	\
 					 BNXT_PTP_MSG_PDELAY_RESP)
 	u8			tx_tstamp_en:1;
+	u8			txts_pending:1;
 	int			rx_filter;
 	u32			tstamp_filters;
 
 	u32			refclk_regs[2];
 	u32			refclk_mapped_regs[2];
+	u32			txts_tmo;
+	unsigned long		abs_txts_tmo;
 };
 
 #if BITS_PER_LONG == 32
-- 
2.30.1


--000000000000249719061483b5f2
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJzKuDr30mXvCSO52kamIautkfQDK1vF
vmrtXEGiZjj5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjkzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCFMGxEUorSapN8pIix9k0jpgcAgk0iXyCQHHo56qv+i2EqFCBr
PGE2CRRLYa/0lvLtpkWhAi4KZP9wxpCU+JoBdPCnmVR3lFe03aGYXCSUILt/f04SU5FA2WCbYhRZ
20rLGOk0PnxRLRintQsY+2GhZRuXLULzmeW+2GgfabfFn0VUy6spaFPattv1Sd8RRKNHiTrkNwNg
oGE4CssHw3KvhyzdTZoKMAuMT7DNjMzDHohbZPKRpxDajHYc9+s5AlF5JQQ0fBqxyaYQvj7wuESg
tMgdr3rGXUwnJ80gSb7VKmSNy6V8r6hlam5EtCUhU52yFb5o4uBRr5m+LQTelmqz
--000000000000249719061483b5f2--

