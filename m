Return-Path: <netdev+bounces-73468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FE85CBB6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1E284411
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCD154C01;
	Tue, 20 Feb 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D6DrFmsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D9154450
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470241; cv=none; b=divEy3tWJ8YOEh3Huw44mZqiTAf8guQ+Gci+gymFgiOn2YIC1Z43PT7a0M1vHzpSR8RPaMRdXUQmHY+1SD5XjuNwAoUxUxXugf0Pqmltbc+btA1KcsJLFaBDvI075P0QTkGVSx3dHpE9FwBenbfIlUxIFIoddKUWWC5/pJne7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470241; c=relaxed/simple;
	bh=rnRaspjwsZYkIuP4b/2+e6LfEjItukpD9dRDnNHpBSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDvmufrDHZhI20G0mfHB+ihIVTjMR5hp5FNWV0boFseEg9Pa2W9PTQuLMM6FmCGmYZOrqAxbm2MOAxV0nu6bAhVFXqH7a72wYcmmLvpsLkzZRIEXyCZ4lzlflYNUoIrWFBgA+ieyKchzh5WCXnsWgMHm6U8ZWYLsGjxcfExZ/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D6DrFmsm; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78725b62cf2so288201985a.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708470239; x=1709075039; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tu2Sh+oQmIUNQ6wfNuhr/+Jpj/gb3sRj4QnX45nYQAY=;
        b=D6DrFmsmeAHE76wPGXH0+j4qGfYkEToGaFfKcqxzaa/YzohOK+wvL76DiFBS63zPQm
         gPMj1a749yllZA8nb4y2NmenLExGtoTBqU/EdB6zTbv+y7Ap9xg2fiMtGEFDU0DO158z
         xjCvBb/BV+3MVwf3+CWf2MW6x9hY9Gy4uWC8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470239; x=1709075039;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tu2Sh+oQmIUNQ6wfNuhr/+Jpj/gb3sRj4QnX45nYQAY=;
        b=qteMzJxN8rJhfvu/In/r6CW5lh2UV4nENdDYAltD1BsSZzmws4CZD73q9MY2S2X3QT
         9msA5dB9MJ1wwuwpjjcaqqlAfR2/CJSFSHIf/gkNV8ZVGwhNhA/n8NgsKRi0ZgKNZMsu
         HXt3RrK6EtsKagmKjLTMZ7dXT4dAHq8nNGcYJZnc+P7hV6+GW/moFKLO4elFdIN55ZNs
         rlqAaICzLFEIgJmOpoWwBwZwb1EXOTUikyqW3Rbp3fgj8uYtD1vMKrNOt5oH2jA3OphN
         2TCnMdBJP2geKz7pQcnXOYGgCHMCPM6kWYdqcpF7J8SClAmeBGfgsFk3FIApzxkU3a7y
         Hfow==
X-Gm-Message-State: AOJu0YzH2h3q0DSnY+OO9oXjU4WwbWGHM3Mj1zsqu9pvVlk10SK7w+fh
	OvlC7XS9yn1NlzspEhbwlBhXltXvEBEGoaoiFKXOkR7gYFVSVNleM64dnngeDg==
X-Google-Smtp-Source: AGHT+IHBXdUeh9C4JDCfiJymVVLChw6GMkMmQSnw5mrEhngoqtVCEOJSGKmffFttZfLkFSkfqzP30A==
X-Received: by 2002:a05:620a:4046:b0:787:1f70:5a9f with SMTP id i6-20020a05620a404600b007871f705a9fmr20420457qko.71.1708470237096;
        Tue, 20 Feb 2024 15:03:57 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b00785d7dda9easm3797966qkm.28.2024.02.20.15.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:03:56 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 09/10] bnxt_en: Create and setup the additional VNIC for adding ntuple filters
Date: Tue, 20 Feb 2024 15:03:16 -0800
Message-Id: <20240220230317.96341-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240220230317.96341-1-michael.chan@broadcom.com>
References: <20240220230317.96341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b5f7a00611d8398a"

--000000000000b5f7a00611d8398a
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Allocate and setup the additional VNIC for ntuple filters if this
new method is supported by the firmware.  Even though this VNIC is
only used for ntuple filters with direct ring destinations, we still
setup the RSS hash to be identical to the default VNIC so that each
RX packet will have the correct hash in the RX completion.  This
VNIC is always at VNIC index BNXT_VNIC_NTUPLE.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 +++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0ca9dd397622..b8ef6c2ba40c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5135,6 +5135,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 
 	vnic0->flags |= BNXT_VNIC_RSS_FLAG | BNXT_VNIC_MCAST_FLAG |
 			BNXT_VNIC_UCAST_FLAG;
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp) && (bp->flags & BNXT_FLAG_RFS))
+		bp->vnic_info[BNXT_VNIC_NTUPLE].flags |=
+			BNXT_VNIC_RSS_FLAG | BNXT_VNIC_NTUPLE_FLAG;
+
 	rc = bnxt_alloc_vnic_attributes(bp);
 	if (rc)
 		goto alloc_mem_err;
@@ -6090,7 +6094,10 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 	for (i = 0; i < tbl_size; i++) {
 		u16 ring_id, j;
 
-		j = bp->rss_indir_tbl[i];
+		if (vnic->flags & BNXT_VNIC_NTUPLE_FLAG)
+			j = ethtool_rxfh_indir_default(i, bp->rx_nr_rings);
+		else
+			j = bp->rss_indir_tbl[i];
 		rxr = &bp->rx_ring[j];
 
 		ring_id = rxr->rx_ring_struct.fw_ring_id;
@@ -9844,10 +9851,28 @@ static int bnxt_setup_vnic(struct bnxt *bp, u16 vnic_id)
 		return __bnxt_setup_vnic(bp, vnic_id);
 }
 
+static int bnxt_alloc_and_setup_vnic(struct bnxt *bp, u16 vnic_id,
+				     u16 start_rx_ring_idx, int rx_rings)
+{
+	int rc;
+
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic_id, start_rx_ring_idx, rx_rings);
+	if (rc) {
+		netdev_err(bp->dev, "hwrm vnic %d alloc failure rc: %x\n",
+			   vnic_id, rc);
+		return rc;
+	}
+	return bnxt_setup_vnic(bp, vnic_id);
+}
+
 static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 {
 	int i, rc = 0;
 
+	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
+		return bnxt_alloc_and_setup_vnic(bp, BNXT_VNIC_NTUPLE, 0,
+						 bp->rx_nr_rings);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return 0;
 
@@ -9863,14 +9888,7 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 		vnic->flags |= BNXT_VNIC_RFS_FLAG;
 		if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 			vnic->flags |= BNXT_VNIC_RFS_NEW_RSS_FLAG;
-		rc = bnxt_hwrm_vnic_alloc(bp, vnic_id, ring_id, 1);
-		if (rc) {
-			netdev_err(bp->dev, "hwrm vnic %d alloc failure rc: %x\n",
-				   vnic_id, rc);
-			break;
-		}
-		rc = bnxt_setup_vnic(bp, vnic_id);
-		if (rc)
+		if (bnxt_alloc_and_setup_vnic(bp, vnic_id, ring_id, 1))
 			break;
 	}
 	return rc;
@@ -12467,12 +12485,12 @@ static int bnxt_reinit_features(struct bnxt *bp, bool irq_re_init,
 
 static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 {
+	bool update_tpa = false, update_ntuple = false;
 	struct bnxt *bp = netdev_priv(dev);
 	u32 flags = bp->flags;
 	u32 changes;
 	int rc = 0;
 	bool re_init = false;
-	bool update_tpa = false;
 
 	flags &= ~BNXT_FLAG_ALL_CONFIG_FEATS;
 	if (features & NETIF_F_GRO_HW)
@@ -12503,6 +12521,9 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 	if (changes & ~BNXT_FLAG_TPA)
 		re_init = true;
 
+	if (changes & BNXT_FLAG_RFS)
+		update_ntuple = true;
+
 	if (flags != bp->flags) {
 		u32 old_flags = bp->flags;
 
@@ -12513,6 +12534,9 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 			return rc;
 		}
 
+		if (update_ntuple)
+			return bnxt_reinit_features(bp, true, false, flags, update_tpa);
+
 		if (re_init)
 			return bnxt_reinit_features(bp, false, false, flags, update_tpa);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e9158407b181..dd849e715c9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1214,6 +1214,7 @@ struct bnxt_ring_grp_info {
 };
 
 #define BNXT_VNIC_DEFAULT	0
+#define BNXT_VNIC_NTUPLE	1
 
 struct bnxt_vnic_info {
 	u16		fw_vnic_id; /* returned by Chimp during alloc */
@@ -1254,6 +1255,7 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_MCAST_FLAG	4
 #define BNXT_VNIC_UCAST_FLAG	8
 #define BNXT_VNIC_RFS_NEW_RSS_FLAG	0x10
+#define BNXT_VNIC_NTUPLE_FLAG		0x20
 };
 
 struct bnxt_hw_rings {
-- 
2.30.1


--000000000000b5f7a00611d8398a
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDzd/QW6gVq8NSvMI/JXz/EZF0say7+T
zXjCEoz+R21DMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
MDIzMDM1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBRD4bshgsu8+vpaidtd4p8Xv6taEL6q0pDjUaNiS9wKlLmXDTl
8NxW7tqoVvj8zPzSp4uJai7WkEsmUrEbM/6u26p/FkVSY5PkNRBhF7vOqkCqFwI6c0Kevl9zPCyE
PuVVe7ZeHevyj3aEseqCI+9AN9wF18PRM5VX9IgxxaRkQoZyiJJ3L5clcbo1k6sp+fY0gT504ub+
H81Us6t7JHelXWQ4MH2hcya2zXGg1aYNi5djN1skV3jLfe4aMvNGy5opEsHISrcE92+y2qBGk3ph
I5yuEEBJHMvat3zHo57EADEA5+e6Y/KBhuEZV40+hWh5uiMb63muAQDD2X0HjnKx
--000000000000b5f7a00611d8398a--

