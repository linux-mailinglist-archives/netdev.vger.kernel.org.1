Return-Path: <netdev+bounces-81835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC188B554
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1D9B61139
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E184D0F;
	Mon, 25 Mar 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OETRKt2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2184A23
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405785; cv=none; b=RfJvDlsGwthz1EXiEhXnMjA5Wklb3op9RIstT/0BR9xOSzEJ5/oOQZ98RqOunBMFC7CNKMrb4uIxy9vbInYi2tDq3DPVWumBuUQQZnqdni1qIpGgSh25gT4eIAerJAWvhKKEHi30OBifzQYk2YT4de+0rDXNkHjNTjI9Ue8KQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405785; c=relaxed/simple;
	bh=gAKQM+j74CE7mdxFtENPQOizVYYnAoP5B6fOeePMSMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD6w9NhhBCBP3VK06x/Ogllm0vnTMZ9VxUHKc2teSmf4KiGOWe4fhGgBTPeNK+Bss54SsSiEG+tW+CbNe9PPyYk3GwUoyxcR+Nt6t6ObQLTpkWxAvZfmwPjKLoPWf9gjJmkImIeyyqHlKYGvPh8NUSzTkU+pUrMzniW41Q6oOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OETRKt2o; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a51c063f99so1353923eaf.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405782; x=1712010582; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qsgHwEE1+CuKElLExwzaLBfhZg71vh2CJc0n/Llv8k=;
        b=OETRKt2olMAZPyg1atXiaE3XFrinUQ4JVM8O7CSxTwmdNa6OFjnK6TaymZGcK24c82
         sWARjSXKXTPs4rcgxhs2rAgZspaLGSsly+Z17zcGq7Yc3rVL/l06ylFeh4/m/RO84OXf
         wnUkdr3GSp8VmV+N0nkPKRuE8kV9MSI4h1o7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405782; x=1712010582;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qsgHwEE1+CuKElLExwzaLBfhZg71vh2CJc0n/Llv8k=;
        b=gfasrjabE1hcbhYoOSDlJ4G8EvQ4nlaqvUxq/cHWFp0CUrl7K3ssn8uV8t4CHsXR1V
         /gngenEbr0f6Ca6hM6rkmVyc2ElFkS2gJi1gybBgaQFrLfdFp7Ph+a6roQ5jLCli9Vtx
         TkeDth/cwnNX3DZo0W3V2j3Tylqk4vCC3mAY74QeL83m5KXYLHquWiTb6G6l8FYrl96/
         N3Y6pXAQgUpF6vtjquouA04ccmcmEJVJY/vON6VM2aP8Bq4zMPj4MSNpnSS0TjFtow+w
         xjoaqAClR75d4Y1ARnoNMjkcv17b8EEzwNOBt9PFxdoDmOlYmPpWR53cgzNudPHM+UbC
         AMMA==
X-Gm-Message-State: AOJu0YwM35qXiXR4m789oFSRNJojs1hektSXtPdCx4mqC82NcUx9HDPq
	u5U1FKB7Q0aETd1qKuTVuSKIg5iJT50+YAwthECnlCyX9nAU6tRApZ3wwK05wZRktebQiysC2Cw
	=
X-Google-Smtp-Source: AGHT+IFFy2sTVlrxyZTHAxK+Pqf5skWmnIcygKc5OArpQxdXCRuflYFoPlBxAmKGzB1hvZJX/Ylg9g==
X-Received: by 2002:a05:6358:2490:b0:17f:5f17:29a1 with SMTP id m16-20020a056358249000b0017f5f1729a1mr5792297rwc.17.1711405782180;
        Mon, 25 Mar 2024 15:29:42 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:41 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 08/12] bnxt_en: Add a new_rss_ctx parameter to bnxt_rfs_capable()
Date: Mon, 25 Mar 2024 15:28:58 -0700
Message-Id: <20240325222902.220712-9-michael.chan@broadcom.com>
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
	boundary="000000000000c28a6c061483b586"

--000000000000c28a6c061483b586
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Modify bnxt_rfs_capable() to check that there are enough resources
to support aRFS/ntuple filters for a new RSS context requested by
the user.  Existing use cases in the driver will always set the
new parameter to false.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e968684ccb1d..c5f3b97d258d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7360,7 +7360,7 @@ static int bnxt_get_total_vnics(struct bnxt *bp, int rx_rings)
 {
 	if (bp->flags & BNXT_FLAG_RFS) {
 		if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
-			return 2;
+			return 2 + bp->num_rss_ctx;
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 			return rx_rings + 1;
 	}
@@ -12474,7 +12474,7 @@ static bool bnxt_rfs_supported(struct bnxt *bp)
 }
 
 /* If runtime conditions support RFS */
-static bool bnxt_rfs_capable(struct bnxt *bp)
+bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx)
 {
 	struct bnxt_hw_rings hwr = {0};
 	int max_vnics, max_rss_ctxs;
@@ -12488,6 +12488,8 @@ static bool bnxt_rfs_capable(struct bnxt *bp)
 
 	hwr.grp = bp->rx_nr_rings;
 	hwr.vnic = bnxt_get_total_vnics(bp, bp->rx_nr_rings);
+	if (new_rss_ctx)
+		hwr.vnic++;
 	hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	max_vnics = bnxt_get_max_func_vnics(bp);
 	max_rss_ctxs = bnxt_get_max_func_rss_ctxs(bp);
@@ -12525,7 +12527,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	netdev_features_t vlan_features;
 
-	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp))
+	if ((features & NETIF_F_NTUPLE) && !bnxt_rfs_capable(bp, false))
 		features &= ~NETIF_F_NTUPLE;
 
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
@@ -13661,7 +13663,7 @@ static void bnxt_set_dflt_rfs(struct bnxt *bp)
 	bp->flags &= ~BNXT_FLAG_RFS;
 	if (bnxt_rfs_supported(bp)) {
 		dev->hw_features |= NETIF_F_NTUPLE;
-		if (bnxt_rfs_capable(bp)) {
+		if (bnxt_rfs_capable(bp, false)) {
 			bp->flags |= BNXT_FLAG_RFS;
 			dev->features |= NETIF_F_NTUPLE;
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 181758f6892a..d5fbb63a0e0c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2756,6 +2756,7 @@ void bnxt_reenable_sriov(struct bnxt *bp);
 void bnxt_close_nic(struct bnxt *, bool, bool);
 void bnxt_get_ring_err_stats(struct bnxt *bp,
 			     struct bnxt_total_ring_err_stats *stats);
+bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
 void bnxt_fw_exception(struct bnxt *bp);
-- 
2.30.1


--000000000000c28a6c061483b586
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJiGcYVc9F1J4F+yjFlq9SVHH18FZOmi
Anvv+wJzeRMXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjk0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCO0D0ylDPgd88A6XrismMJ8DukQ7Ggwp4eSZ/9NS0ubgoUQiJC
/0fl/tQfYBxhKR7BwyJdFUtYqOtwa9bii/CKn7+4KpLAMtfMlGv4EArO5HBI5bnGE6YOnDT9Ic0L
FFDwzOk0//eloArQAd0KOrvm9d1R1E+7EBdN/uBg78HdrR6G1CIpkJXS/oxqAyuc45dqGD7QVyn4
cch2setZUqsLY1m+mVjzFDWNzwbRsDRS8cCojrE6i04m/YE0V6R4CE287DO5eUID4AfN+oDB+tD+
ZdlmWLEnY4o6Ro+URnpmPp0c9jlpZbwJwjYDr7fNwi0SyxzvsgJ6PLU+/M0uNRtO
--000000000000c28a6c061483b586--

