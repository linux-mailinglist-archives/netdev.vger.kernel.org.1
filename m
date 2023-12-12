Return-Path: <netdev+bounces-56170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F158280E084
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998E71F21BEF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9EE5CBD;
	Tue, 12 Dec 2023 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H3elgDAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA72B3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:52:02 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4254223c150so37232761cf.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702342321; x=1702947121; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dd/pNLH0aZ4KKkS06SKGs/okNQiZTfx+tNh61rLozpI=;
        b=H3elgDATKtNi/6tXm60nHEwKva31RL44+4kW7ox9/P1VM3+00sCoCHgmbgyZDePlVf
         sURJ4tRTfCGr4gJcSzDm3yV4O9V+UhUlbjJNgGzrTIcAWGP2fP6g6Ijr0myT4PEBCa32
         TYm+IGQ14r/6R/bRRVbx08DrNmkbpRpQ3YxFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342321; x=1702947121;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dd/pNLH0aZ4KKkS06SKGs/okNQiZTfx+tNh61rLozpI=;
        b=D4be9yd4hRDBgpOYEjC+EFui4E/FPgN3Qs82IgdANkvogRGX7nQPlqjnewul831AIg
         al1tokfWatjVh0Ztxxcc7vR9AONeKBPRdXUIUzzRgRJSpYB5rp4NoWjdoZgbXUvdpMCC
         3V6+7A0T/dJbmcdfwl9VcRLcBjxkb2nxaqw+kKT7Yjb7g+p2WtIIuiEFgJ13BQbqTd2K
         TnRHntABfpb0qLA66FkTHmrotYmz76UFOk0fA9qduTVCn2YZ0NtZ+XQSaV4P9S4zmiw7
         cdtGqdVIabMEVh6VP6Vc6TljGb7VBl28qEq/VN+HsGCfFTAjTKsbwCnMfO7t2aX7JjgE
         yOaQ==
X-Gm-Message-State: AOJu0YwRKlPEDw/PSOFNQjt1nFT6NBQib04e8ez8I7f3EUO/h3Z51pMU
	Bf6tiKQJLypS3kJ5RNC0PvGleQ==
X-Google-Smtp-Source: AGHT+IGzO81o/G4pqxO+8y1SYU2OvZcsu3MwtpOShvjmistG8G//kV1NeZH6KSgglcFvmobntJCoSA==
X-Received: by 2002:ac8:7e88:0:b0:425:4043:50e1 with SMTP id w8-20020ac87e88000000b00425404350e1mr8025266qtj.112.1702342321100;
        Mon, 11 Dec 2023 16:52:01 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b00423ea1b31b3sm3619664qtt.66.2023.12.11.16.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2023 16:52:00 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 12/13] bnxt_en: Skip nic close/open when configuring tstamp filters
Date: Mon, 11 Dec 2023 16:51:21 -0800
Message-Id: <20231212005122.2401-13-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231212005122.2401-1-michael.chan@broadcom.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b176f060c45758c"

--0000000000005b176f060c45758c
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

We don't have to close and open the nic to make sure we have
valid rx timestamps. Once we have the timestamp filter applied to
the HW and the timestamp_fld_format bit is cleared in the rx
completion and the timestamp is non-zero, we can be sure that rx
timestamp is valid data.

Skip close/open when we set any timestamp filter.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 +++++++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  2 +-
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a1ec39b46518..3d1c36d384c2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -319,15 +319,17 @@ static int bnxt_ptp_cfg_event(struct bnxt *bp, u8 event)
 	return hwrm_req_send(bp, req);
 }
 
-void bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp)
+int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct hwrm_port_mac_cfg_input *req;
+	int rc;
 
 	if (!ptp || !ptp->tstamp_filters)
-		return;
+		return -EIO;
 
-	if (hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG))
+	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG);
+	if (rc)
 		goto out;
 
 	if (!(bp->fw_cap & BNXT_FW_CAP_RX_ALL_PKT_TS) && (ptp->tstamp_filters &
@@ -342,15 +344,17 @@ void bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp)
 	req->enables = cpu_to_le32(PORT_MAC_CFG_REQ_ENABLES_RX_TS_CAPTURE_PTP_MSG_TYPE);
 	req->rx_ts_capture_ptp_msg_type = cpu_to_le16(ptp->rxctl);
 
-	if (!hwrm_req_send(bp, req)) {
+	rc = hwrm_req_send(bp, req);
+	if (!rc) {
 		bp->ptp_all_rx_tstamp = !!(ptp->tstamp_filters &
 					   PORT_MAC_CFG_REQ_FLAGS_ALL_RX_TS_CAPTURE_ENABLE);
-		return;
+		return 0;
 	}
 	ptp->tstamp_filters = 0;
 out:
 	bp->ptp_all_rx_tstamp = 0;
 	netdev_warn(bp->dev, "Failed to configure HW packet timestamp filters\n");
+	return rc;
 }
 
 void bnxt_ptp_reapply_pps(struct bnxt *bp)
@@ -494,7 +498,6 @@ static int bnxt_hwrm_ptp_cfg(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	u32 flags = 0;
-	int rc = 0;
 
 	switch (ptp->rx_filter) {
 	case HWTSTAMP_FILTER_ALL:
@@ -519,19 +522,7 @@ static int bnxt_hwrm_ptp_cfg(struct bnxt *bp)
 
 	ptp->tstamp_filters = flags;
 
-	if (netif_running(bp->dev)) {
-		if (ptp->rx_filter == HWTSTAMP_FILTER_ALL) {
-			rc = bnxt_close_nic(bp, false, false);
-			if (!rc)
-				rc = bnxt_open_nic(bp, false, false);
-		} else {
-			bnxt_ptp_cfg_tstamp_filters(bp);
-		}
-		if (!rc && !ptp->tstamp_filters)
-			rc = -EIO;
-	}
-
-	return rc;
+	return bnxt_ptp_cfg_tstamp_filters(bp);
 }
 
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 34162e07a119..fce8dc39a7d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -137,7 +137,7 @@ do {						\
 int bnxt_ptp_parse(struct sk_buff *skb, u16 *seq_id, u16 *hdr_off);
 void bnxt_ptp_update_current_time(struct bnxt *bp);
 void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2);
-void bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
+int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
-- 
2.30.1


--0000000000005b176f060c45758c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIILlZg1u3AFJTLhQhCqmbRzck0cuKorO
KlycwdvM9sZ6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIx
MjAwNTIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA2QwfvEPI1Nrc/+xXLVPYDXtbCZLm8NyAfHc+ZNviK5TpEUYUP
rxbIUwQZTMB3bkLkDjgL+9+bd9tiys1/zW/ET2pWbpWlIZtFDGq9oFXGVMbrozqb5Lw5zCalYWCa
b9OK+cL8Ajz35LPF2KxMY0fu+Cu+FrtpgbU32xS8rIE5VITDpVHOi2/XlCz72qshaq/CLXQlY5Og
HFh33Sa4eBzFmhGXhwRWB/z4AKJ19F9suljxJH2pH5ym0cLO2u2j1ZG+c/ZMaFD814GXi5NVkkVD
6W1tqWpNn2415wHcucHW5oRPAQnlXk0BrdamaKBnahhOOSqm9A27gNjy/f8HTYee
--0000000000005b176f060c45758c--

