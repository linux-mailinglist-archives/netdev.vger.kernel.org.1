Return-Path: <netdev+bounces-69298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8584A95A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2491293356
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F944C62E;
	Mon,  5 Feb 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G8zPIdZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACA4C3B3
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172357; cv=none; b=Pik155ca2Nf643S085uIxSwqXM6eb438gox3pXBYX9NAHVUGVewfJVp2PTjNTJSvLYgf16QtDPeeNYvNv0koFnCdadM02vLPwXsZdOHzPQQINxVxbzXPKA8zYM3XHgvgm8stqIUWrR5KP1ClaOO4g64xVVRa3QN4WHGJ6wASgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172357; c=relaxed/simple;
	bh=ktVDGR7ONs7scaNDMRGszVRzIOVxcB3ku8G25VeKGCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5kLEXen1CR2U8Uy8YJL3rvbZEgWUnHdo8Ex5cjiArypZYMbYN1uA92NBkcRD/G9toBgt7cgmGBPECP+dvm8OHpWZSSivVF4dZ+jYw42+IoRY1cXYEyjs9+oFi+Yx2pIcjwpxrDB18GCbOPMch72Wav8BtVxB1OlqrkwpuYzJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G8zPIdZL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42aa4a9d984so39678511cf.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172355; x=1707777155; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AoTE08B6eLPYHIh2ussWG9aKTsBgmpFsYPqmnLHNSc=;
        b=G8zPIdZL1+LgCgo3dRYEHQRf9ZOv020dgxMPKDZpTMTrTvlu5UHe7c0+wKSSwvPeaj
         NcNxplnKk/MaLxz1wj5Tq3JZsd1ba1bh6auVtODSA/XWPSDdlHGGfyShYztyrsRhQuUA
         vIDSFjcgrJb3tH8+4+Iyv1S7P/W1C/pGOpqMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172355; x=1707777155;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AoTE08B6eLPYHIh2ussWG9aKTsBgmpFsYPqmnLHNSc=;
        b=ojX8dpDp1tx7WIXOR6f01QrXcliMv3BE5PyHBB2QxcnUwNG573vAxPlGQcaxkbDlWe
         GouTAFOUEddwwT3QT92M6iZLn6zelqZeITE5ukq6JZzvSpfzJFnXnkqre2XBL0LMr1ZL
         42g4W2j4cXtUTkw9dKsR8VDv2S1D1dc48USNe32XGHeGZe3706ObPmyCotc/1ynwaS9y
         2U4mK6TF1AznjhUV9g83G7Mi1BDezUh8p5h726DHQN7SYxn3jYyKjz388UfsBQGgijn0
         Gt0a7h8qdvbRwUnZRFN6CdbBL/zqL95OJ/J7+2Bo3qnOn4WEnQbfAnhWEJNcXaNUGMSs
         OqmA==
X-Gm-Message-State: AOJu0YxSkTlRN2r+jJAc7gWFE469UOU6MLriQGfYPDjGx1e1Ioo8v10X
	2xi7pklMCkw8BdHluzJnPGw1IhVszHKEPJkgse4TebXclzEJ4McMmnDqwgidiA==
X-Google-Smtp-Source: AGHT+IEBOjWuQKsJSs6gddMOTHrr5YPR5ISP64EEMst4E0pZGGLV/N5VI2VOx6n2klKKe2eKp8KYUw==
X-Received: by 2002:ac8:5287:0:b0:42a:b73d:447e with SMTP id s7-20020ac85287000000b0042ab73d447emr501658qtn.15.1707172354450;
        Mon, 05 Feb 2024 14:32:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIAT41ZOOynnSHxJRNi4AKjG0mCCo78Fr/8EPOXKxJuLnskdXjO0Jn2s/sv6PyI94btBE8rIKGdiCNko77JzlhTBAoCe0gSy9Q6BdpmKyMJ1pM9NRAjKVEwlw8T6lk7in7muaZhfbuPZ53kGEO3NWYhZ06ZAtatSOt91oWY5Gy0aYkka6cv4OX1So4AxefhO55y+6LK5KwysIjdAiYM6NB/Go=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:33 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 12/13] bnxt_en: Invalidate user filters when needed
Date: Mon,  5 Feb 2024 14:32:01 -0800
Message-Id: <20240205223202.25341-13-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000caf1c70610aa0959"

--000000000000caf1c70610aa0959
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

The cached user filters slated to be reapplied need to
be cleared if configured MAC changes, RSS key changes,
number of rings changes, or ntuple is disabled.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 14 ++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 27941ade894a..856fda0c4c1a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4871,6 +4871,17 @@ void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
 		list_del_init(&fltr->list);
 }
 
+void bnxt_clear_usr_fltrs(struct bnxt *bp, bool all)
+{
+	struct bnxt_filter_base *usr_fltr, *tmp;
+
+	list_for_each_entry_safe(usr_fltr, tmp, &bp->usr_fltr_list, list) {
+		if (!all && usr_fltr->type == BNXT_FLTR_TYPE_L2)
+			continue;
+		bnxt_del_one_usr_fltr(bp, usr_fltr);
+	}
+}
+
 static void bnxt_del_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr)
 {
 	hlist_del(&fltr->hash);
@@ -12414,6 +12425,8 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 
 	if (features & NETIF_F_NTUPLE)
 		flags |= BNXT_FLAG_RFS;
+	else
+		bnxt_clear_usr_fltrs(bp, true);
 
 	changes = flags ^ bp->flags;
 	if (changes & BNXT_FLAG_TPA) {
@@ -13911,6 +13924,7 @@ static int bnxt_change_mac_addr(struct net_device *dev, void *p)
 		return rc;
 
 	eth_hw_addr_set(dev, addr->sa_data);
+	bnxt_clear_usr_fltrs(bp, true);
 	if (netif_running(dev)) {
 		bnxt_close_nic(bp, false, false);
 		rc = bnxt_open_nic(bp, false, false);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 28091889615b..2b2f051ee085 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2655,6 +2655,7 @@ void bnxt_set_ring_params(struct bnxt *);
 int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
 void bnxt_insert_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
 void bnxt_del_one_usr_fltr(struct bnxt *bp, struct bnxt_filter_base *fltr);
+void bnxt_clear_usr_fltrs(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap,
 			    int bmap_size, bool async_only);
 int bnxt_hwrm_func_drv_unrgtr(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b5382412db3..a0962026a85f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -968,6 +968,7 @@ static int bnxt_set_channels(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	bnxt_clear_usr_fltrs(bp, true);
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
@@ -1769,7 +1770,7 @@ static int bnxt_set_rxfh(struct net_device *dev,
 		if (pad)
 			memset(&bp->rss_indir_tbl[i], 0, pad * sizeof(u16));
 	}
-
+	bnxt_clear_usr_fltrs(bp, false);
 	if (netif_running(bp->dev)) {
 		bnxt_close_nic(bp, false, false);
 		rc = bnxt_open_nic(bp, false, false);
-- 
2.30.1


--000000000000caf1c70610aa0959
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC/VmMfHM8STT7pPMVi/rBDkGoZydX/j
ZzHEEugbpxTmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAGBlVuC0DInDwKEhewIs22PIIwZ8steo5RmPsohVpbx1pxmD1M
kcti2l3Q901gVlPieo/pSgCVaE3qZ/tMJGbykhaZ7kxH92XFUzNxwkOpGsQD5o8xUJARPmbNk+6P
5grb5THfAKew8Csh9rvpZ9LDUz2ldfqA+aSJlQJABkaDzkiG1t9grJ3IrsVPxXACsM33wMGmFi0t
P/6PRIDvszSOFw25+BmAwAnNNN86Tpch4VrLzpYgS9TWTeP1XsSP15lMnFh8Vl1o38B6jrA/QuwX
/ZNHaeZgm6kd2vNdl0zIl9V/wdB8fTA9YAMPMJiFLwd3STQgOcL7unhkoOAG9Nvg
--000000000000caf1c70610aa0959--

