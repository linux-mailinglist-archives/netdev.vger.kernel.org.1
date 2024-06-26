Return-Path: <netdev+bounces-107001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98E9187AA
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752491F23E93
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9518FC9F;
	Wed, 26 Jun 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z890qIKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445E18FC8C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420216; cv=none; b=Hw4UqJKjvYtek2ZJmY0nSU9XtcSAprOrjoGJ0jEgTBmqQQXDgYGZe7uscy6RRhbiTE5GfGAETpxrUnsdCiCKxz52WCZGalS7ESQGmGeKph1iCYrh3boPuyDm8klcVEPMrrZdtSm1x+cKmiVYUZnA8Z3JZCqjefIpjdKsUiaC/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420216; c=relaxed/simple;
	bh=VwoVeAnF7sXXn2+QvAd8ZA7yQG5Gg7PBAurFVZvFOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz04Psxy5m4Bzp3M0YSE14dFN6Sik9gcCKpOwej/pH1s67YJEsFA0dTKOJhdKlTKJCF51DBwyKJD3qWMtFwMQ/rFShSkQh/bdQk9O8MJgGNvp1NPoPB8qBYwYMOwKUNSl2Da5umnKYu/HcZpiwnSZERCguTAAxc2d/F6R+Q581Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z890qIKJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-795a4fde8bfso406269685a.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719420214; x=1720025014; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXPJ8Wq+xQjKAbn0W6a+yEhetIHGX5/uROKicxN+ZFw=;
        b=Z890qIKJ73PXcU/RzJ4g0TtqPCnTMGrm4n8COKkZmn7AdMZe1q25G3AW0WvRkzfM1B
         LQpD+cXbn7RzesTKiOVlUE+ws6SpEZhrUUrqBLDPnoF9h9ZeyWua8p+NMNIP88/NazG1
         zWu1M6+j21q4tu2eosX+eQZ6G9UZInWlDEM+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420214; x=1720025014;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXPJ8Wq+xQjKAbn0W6a+yEhetIHGX5/uROKicxN+ZFw=;
        b=royu4Y24+zQKz0GFHDAHV5Y4SJCevfMJRkOTRKYeXRt95ufZK/pZyesWpXsSKffiCm
         WD1nJZvGk22wkuoH+8dL2dUp2hbqxweze8AtyUOncrE31Wkc7LkfoD8Qk90ay6v6Mo4x
         77AJcoDzYH+D1qoj58gFZXCOr51j8E0fboh6yzyzK+yRcPcybZ8GytGtg9jugchgyDOa
         K73yfvwGJ75oHqJ7JOVTkpsAS5RFVp8RiJtWjRJKeraLhbn9rCEUOTWIBTOAT5a8Zy2n
         B/ZB7A+z3rGK/73ZmOpCE3quxFjAw6AUHvqeJuUoBtp8X5JkPTAL9E9FigDDzLcVpbvM
         +AXw==
X-Gm-Message-State: AOJu0YzXzU1g5GhC8o/KArGDBRox4n/Z1hFnz5YPLzJPgadFh0I/Pwyc
	MpyA/3hieeY/Ham0feetpq9eopuJxX7GDR1ZQvGoXAOyc9iUSKNEwCzQHjV8Pw==
X-Google-Smtp-Source: AGHT+IFxvOLaIKgw0VEiESu6jxwSNQWcaTzAqKnSHV6Cbb95+qUW347DckR8RhMG9jADQHW5Ek5csQ==
X-Received: by 2002:a05:620a:25d0:b0:79b:f963:d25 with SMTP id af79cd13be357-79bf9630d29mr874415385a.75.1719420213421;
        Wed, 26 Jun 2024 09:43:33 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d53c42aafsm53570485a.58.2024.06.26.09.43.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:43:32 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 01/10] bnxt_en: Add new TX timestamp completion definitions
Date: Wed, 26 Jun 2024 09:42:58 -0700
Message-ID: <20240626164307.219568-2-michael.chan@broadcom.com>
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
	boundary="00000000000013277f061bcdb7fa"

--00000000000013277f061bcdb7fa
Content-Transfer-Encoding: 8bit

The new BCM5760X chips will generate this new TX timestamp completion
when a TX packet's timestamp has been taken right before transmission.
The driver logic to retreive the timestamp will be added in the next
few patches.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9cf0acfa04e5..d3ad73d4c00a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -181,6 +181,32 @@ struct tx_cmp {
 #define TX_CMP_SQ_CONS_IDX(txcmp)					\
 	(le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
 
+struct tx_ts_cmp {
+	__le32 tx_ts_cmp_flags_type;
+	#define TX_TS_CMP_FLAGS_ERROR				(1 << 6)
+	#define TX_TS_CMP_FLAGS_TS_TYPE				(1 << 7)
+	 #define TX_TS_CMP_FLAGS_TS_TYPE_PM			 (0 << 7)
+	 #define TX_TS_CMP_FLAGS_TS_TYPE_PA			 (1 << 7)
+	#define TX_TS_CMP_FLAGS_TS_FALLBACK			(1 << 8)
+	#define TX_TS_CMP_TS_SUB_NS				(0xf << 12)
+	#define TX_TS_CMP_TS_NS_MID				(0xffff << 16)
+	#define TX_TS_CMP_TS_NS_MID_SFT				16
+	u32 tx_ts_cmp_opaque;
+	__le32 tx_ts_cmp_errors_v;
+	#define TX_TS_CMP_V					(1 << 0)
+	#define TX_TS_CMP_TS_INVALID_ERR			(1 << 10)
+	__le32 tx_ts_cmp_ts_ns_lo;
+};
+
+#define BNXT_GET_TX_TS_48B_NS(tscmp)					\
+	(le32_to_cpu((tscmp)->tx_ts_cmp_ts_ns_lo) |			\
+	 ((u64)(le32_to_cpu((tscmp)->tx_ts_cmp_flags_type) &		\
+	  TX_TS_CMP_TS_NS_MID) << TX_TS_CMP_TS_NS_MID_SFT))
+
+#define BNXT_TX_TS_ERR(tscmp)						\
+	(((tscmp)->tx_ts_cmp_flags_type & cpu_to_le32(TX_TS_CMP_FLAGS_ERROR)) &&\
+	 ((tscmp)->tx_ts_cmp_errors_v & cpu_to_le32(TX_TS_CMP_TS_INVALID_ERR)))
+
 struct rx_cmp {
 	__le32 rx_cmp_len_flags_type;
 	#define RX_CMP_CMP_TYPE					(0x3f << 0)
-- 
2.30.1


--00000000000013277f061bcdb7fa
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBmaYWBfucHNSJ2ybGI6Kpy3Yj4FgSXl
N2ff7uEqTVZ8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NjE2NDMzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBpP7EGD7NWKO9QsTTKjaaeSfGQPBB/OkHsPHVj2/28Fos7PF57
ZrmhspVWLM1lgCyIzeCgGDybxffFQl7OhqAMsQrZtM42BlGCkMcT3QLSZ9b1vqV/JycqzkUseyWo
7frwiT9KtjGzwnr5wPPNyuH2zJcD33qY5Y/8LoLGGW5pwBPTGTvX7VNF6fQs8B1sFmNLFyXq6MGf
NTK9xE1lGV54OsnFgM9SRnRHbZ6aKSTjjj3W6jg/VbGn8yHxO5tR+BQBG61MJ4CnUMvzL8QudZyV
iUkFc5O7jh0oySsqbVkWJ0u6gTTlfW5npeO6lhw1oAaFbxIvCfkeMhsGzzW9KWRw
--00000000000013277f061bcdb7fa--

