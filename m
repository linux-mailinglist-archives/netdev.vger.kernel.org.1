Return-Path: <netdev+bounces-44356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96657D7A32
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60705281DDA
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8F522B;
	Thu, 26 Oct 2023 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nr8wHXi3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD8199
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:32:50 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5BB136
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:32:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b497c8575aso356349b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698283965; x=1698888765; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbuLumgxaQtACV+Q6vygin7pJRprPD3DXlAF4bInmYA=;
        b=Nr8wHXi38jkjVQNbIEmx+0M5lPRs5pzsoRPsdrqEIJc//vMS6Zspcv9A05ueknhO4x
         VK5nqxdkfHZECznwi74slPz5dUvqD/XiGhF+RANm/G0kvnuQo6c+uS1H5bOLuJLKleyO
         HXiQE2zT4vGlpFSy+wAMKQEzNIaYxi6/eVv8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283965; x=1698888765;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbuLumgxaQtACV+Q6vygin7pJRprPD3DXlAF4bInmYA=;
        b=r8fvMidsGTdrF+fbVnAIeik8HPzGuLEjJjOpano3nfjmhycQJAcQGg3dEv/wEiagxY
         Qc6ScPLsxA2rlxtBhASOpg9pRjtfDZ+f9uL694mjCX+4ezKfOnhU3Kad5/PnoKRZmIvp
         H00deLrQGcYA3+x3dLa0bkFsCbpqRtnmX5HR3MBVa6PdZARMhijeDLP+msYg5DEh0chR
         5Nj9uNMk8iuzQzG5WdEbDTMtwUvcW00lKai32/VC5WX8ad5IsDwec9wH/MIypy2C2OCh
         wb1vetMKN+YJnSdH5kwoQmI4Mwt5H0vnbnNZPJ4+YSm9Fsdl3m5mrMkJJmh4RPSlfUa4
         MRyA==
X-Gm-Message-State: AOJu0Ywk66iJnFcGrgV8cz466K4NWximWANY4Q3p0yrXwuTQ//RaXZL+
	dWJd3VpJ22df3flTmH8co1azNQ==
X-Google-Smtp-Source: AGHT+IHiaYQuEyghYEyjg3TfkXEtfuGaXzKLDVPgDBCeEj0k0NmRtY82R/uDogH5udt6SVJdhtUmJg==
X-Received: by 2002:a05:6a20:3951:b0:16b:79b3:2285 with SMTP id r17-20020a056a20395100b0016b79b32285mr8090410pzg.56.1698283964450;
        Wed, 25 Oct 2023 18:32:44 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b0068620bee456sm10014555pfb.209.2023.10.25.18.32.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 18:32:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next] bnxt_en: Fix 2 stray ethtool -S counters
Date: Wed, 25 Oct 2023 18:32:31 -0700
Message-Id: <20231026013231.53271-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000772bcc0608948cdc"

--000000000000772bcc0608948cdc
Content-Transfer-Encoding: 8bit

The recent firmware interface change has added 2 counters in struct
rx_port_stats_ext. This caused 2 stray ethtool counters to be
displayed.

Since new counters are added from time to time, fix it so that the
ethtool logic will only display up to the maximum known counters.
These 2 counters are not used by production firmware yet.

Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 53442aaabe5e..f3f384773ac0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -535,6 +535,7 @@ static int bnxt_get_num_ring_stats(struct bnxt *bp)
 static int bnxt_get_num_stats(struct bnxt *bp)
 {
 	int num_stats = bnxt_get_num_ring_stats(bp);
+	int len;
 
 	num_stats += BNXT_NUM_RING_ERR_STATS;
 
@@ -542,8 +543,12 @@ static int bnxt_get_num_stats(struct bnxt *bp)
 		num_stats += BNXT_NUM_PORT_STATS;
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
-		num_stats += bp->fw_rx_stats_ext_size +
-			     bp->fw_tx_stats_ext_size;
+		len = min_t(int, bp->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnxt_port_stats_ext_arr));
+		num_stats += len;
+		len = min_t(int, bp->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
+		num_stats += len;
 		if (bp->pri2cos_valid)
 			num_stats += BNXT_NUM_STATS_PRI;
 	}
@@ -653,12 +658,17 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 	if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
 		u64 *rx_port_stats_ext = bp->rx_port_stats_ext.sw_stats;
 		u64 *tx_port_stats_ext = bp->tx_port_stats_ext.sw_stats;
+		u32 len;
 
-		for (i = 0; i < bp->fw_rx_stats_ext_size; i++, j++) {
+		len = min_t(u32, bp->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnxt_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
 			buf[j] = *(rx_port_stats_ext +
 				   bnxt_port_stats_ext_arr[i].offset);
 		}
-		for (i = 0; i < bp->fw_tx_stats_ext_size; i++, j++) {
+		len = min_t(u32, bp->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
 			buf[j] = *(tx_port_stats_ext +
 				   bnxt_tx_port_stats_ext_arr[i].offset);
 		}
@@ -757,11 +767,17 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 			}
 		}
 		if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
-			for (i = 0; i < bp->fw_rx_stats_ext_size; i++) {
+			u32 len;
+
+			len = min_t(u32, bp->fw_rx_stats_ext_size,
+				    ARRAY_SIZE(bnxt_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
 				strcpy(buf, bnxt_port_stats_ext_arr[i].string);
 				buf += ETH_GSTRING_LEN;
 			}
-			for (i = 0; i < bp->fw_tx_stats_ext_size; i++) {
+			len = min_t(u32, bp->fw_tx_stats_ext_size,
+				    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
 				strcpy(buf,
 				       bnxt_tx_port_stats_ext_arr[i].string);
 				buf += ETH_GSTRING_LEN;
-- 
2.30.1


--000000000000772bcc0608948cdc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOVVfGf3qRI2Rvb3xV0jHx4wj0yR2c2K
P4nfZtE/8K+eMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
NjAxMzI0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBwpKyO2JAqo9tBHTiPdnu07sVhyw2z7TockEoQgFaybj4VrE3D
9MciT07B+3Psh2/PlRRi4NYFPLJ7AN/cBwvCsvUxN0e4HQJLJY5rZ9mFef2Ix7ygvyBxPZR9NQy9
Rgxd/wMUNSQ6N3wwLNSxwh0m0kXrSXFwS0Rrs3oT9aEOA/pw7T9oLWUPFC3k4sbaWSAGKc6I6s2v
8hP0XKfgZzXpU/qHQ02Z3Hln0vGUJihYSeS4ktSxH+XWeJTS6U1RmcbnUmoO8lLvxkfdupy35Gj/
eUxX2apfGlXuPGibLAKNxSDOR+fPIy6XRt4H/k9e0MuMpxtETmpTe90KAQlfO4Zb
--000000000000772bcc0608948cdc--

