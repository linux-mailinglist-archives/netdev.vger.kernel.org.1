Return-Path: <netdev+bounces-107799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B091C699
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6548B22B93
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6D770EE;
	Fri, 28 Jun 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e2bRQYbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79111770E2
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603030; cv=none; b=k0+wRwHxHGNTCtgNu0r15W7jw3E+17Vtni3F8fHoH6W8uYsOra4xqewxrf+I3Ojg0IXMfQ4JS7tZdX4dsguEoEyFhhsqrAucxT30ArGLpupweOcteEdg7sfJrg65CE1RkB6TYB68sIqCbX5lgq3KKpdwPrizXenPgcDp1WS7NqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603030; c=relaxed/simple;
	bh=Is7sQcGKanawXqCRkF1Nv+C38jPPQrXORgFxDiUuAyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+hTHdwd3rggNyrM9nBnoZun0Otybj7o6IY7+kpJdxtEFZoAorneJ3T4fduzelSVxytgNOZDMUMrpq8M6YYc78C09EDpJoST4x1x4RI+0Fdo6G9WyFO4GpOVTVXGbPjdU2dJBUN7CgSggVx5bDJe8Fk8HlsAEH1B+jgkzpPIA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e2bRQYbj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-711b1512aeaso726097a12.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719603029; x=1720207829; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNbommFMfe7X3MQeE9DXD4HNvqtFSOJ0OF2tgOB0cQM=;
        b=e2bRQYbjKLeF0QokIRnuM+H3Ji5ovupgFmfvXlmy5kCn4Nk2+AJiPCpiAeFfYB4hzJ
         KfF02HvsBMF34cpOcl3nwzWfLCdp50ALoTgcfFLbt0BB/FzteqhlCfEOJh/Xcl+nGx3q
         b3KQ+4bjAM6CGOg15NpuJZF1VtHsTabHcccj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603029; x=1720207829;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNbommFMfe7X3MQeE9DXD4HNvqtFSOJ0OF2tgOB0cQM=;
        b=Yi09zE0Sb/bqa6k9Pp82ei216RvC33YWzLS8DZFAmqSR7kQAVeZuIxFByUBvMIPmt3
         OJciEGa5+mER/uajja4IMVYMecsqaUcSn47v/8lhyozvI5qC6yyL47hi1HOY4pxPflUD
         OQ56WhE/3JFMVqkGvGoZuUSAbZI/uDr54BlYcZKkQXu6OWWCrXIF6yMZ5rjj4lKc6NdQ
         HSbyhv8E0zNPO1X8ulNzNOZzPR465isso8GX/nXhfRkhEy2y/m750izpnQL0t6WRvSOx
         TEGer4KjqOxkK82vzlW/7I4tDE6Uh4u9wiUwUQaUBQEvqwM90Z19+DiutRbtNeDKJ46v
         Wnmg==
X-Gm-Message-State: AOJu0YxpLjdda8wr30X3VGC13pdreOUOsj9f1SubDFkteZdt/AFPm3T+
	U+hiwAHTAGZAtbctrcXVbSs3HDuBF2hp8DvtpBIAHUwfCErudg8hw9PQsR1xbg==
X-Google-Smtp-Source: AGHT+IFPCSFt2mqNH04BXuHDNBsnPSC5XK+D71qQpuZx+hESCWRhPZfWM9aWpo+2YU/SzBCH/bu55A==
X-Received: by 2002:a05:6a20:7b13:b0:1bd:2ba1:983b with SMTP id adf61e73a8af0-1bd2ba198e7mr9402930637.51.1719603028258;
        Fri, 28 Jun 2024 12:30:28 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939cc9b04sm46707a91.0.2024.06.28.12.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:30:27 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/10] bnxt_en: Add is_ts_pkt field to struct bnxt_sw_tx_bd
Date: Fri, 28 Jun 2024 12:29:57 -0700
Message-ID: <20240628193006.225906-3-michael.chan@broadcom.com>
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
	boundary="000000000000b5375f061bf847e7"

--000000000000b5375f061bf847e7
Content-Transfer-Encoding: 8bit

Remove the unused is_gso field and add the is_ts_pkt field to struct
bnxt_sw_tx_bd.  This field will mark the TX BD that has requested
HW TX timestamp.  The field needs to be cleared if the timestamp packet
is later aborted.  This field will be useful when processing the
new TX timestamp completion from the hardware in the next patches.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix the unwind of txr->is_ts_pkt when bnxt_start_xmit() aborts.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1bd0c5973252..af064dcc6142 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -522,6 +522,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				if (vlan_tag_flags)
 					ptp->tx_hdr_off += VLAN_HLEN;
 				lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
+				tx_buf->is_ts_pkt = 1;
 				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			} else {
 				atomic_inc(&bp->ptp_cfg->tx_avail);
@@ -758,6 +759,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_kfree_skb_any(skb);
 tx_kick_pending:
 	if (BNXT_TX_PTP_IS_SET(lflags)) {
+		txr->tx_buf_ring[txr->tx_prod].is_ts_pkt = 0;
 		atomic64_inc(&bp->ptp_cfg->stats.ts_err);
 		atomic_inc(&bp->ptp_cfg->tx_avail);
 	}
@@ -781,6 +783,7 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	while (RING_TX(bp, cons) != hw_cons) {
 		struct bnxt_sw_tx_bd *tx_buf;
 		struct sk_buff *skb;
+		bool is_ts_pkt;
 		int j, last;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
@@ -800,6 +803,8 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			tx_buf->is_push = 0;
 			goto next_tx_int;
 		}
+		is_ts_pkt = tx_buf->is_ts_pkt;
+		tx_buf->is_ts_pkt = 0;
 
 		dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
 				 skb_headlen(skb), DMA_TO_DEVICE);
@@ -814,7 +819,7 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 				skb_frag_size(&skb_shinfo(skb)->frags[j]),
 				DMA_TO_DEVICE);
 		}
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
+		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
 				if (!bnxt_get_tx_ts_p5(bp, skb)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d3ad73d4c00a..00976e8a1e6a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -874,7 +874,7 @@ struct bnxt_sw_tx_bd {
 	DEFINE_DMA_UNMAP_ADDR(mapping);
 	DEFINE_DMA_UNMAP_LEN(len);
 	struct page		*page;
-	u8			is_gso;
+	u8			is_ts_pkt;
 	u8			is_push;
 	u8			action;
 	unsigned short		nr_frags;
-- 
2.30.1


--000000000000b5375f061bf847e7
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFiySmEE9XpPNMtWJQ73tG5RFh4iN0yI
gRpasvDyiqY/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE5MzAyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB6TidLpoC/32hnNPN5eQ08GPz5uOshEJ3BBiLtEOxs5y3VNE7M
MO8CPEJLrvC9dnwONFJ31tnnHWeIo/m1WNarx1HwjDLjoLMlGK3Kb4oxYLMfcIa4MP+x3eEIBRU3
o/UOS10G1Tg0wsUZUj4Ak4ZzXfHnhT67HR1GSrZ7uOy6MEcnt7Ce8aZtYeW8uTbCybCcqoBRua8m
JzsDGHax2EGzPeRtT6ckGP80VULvYvlm+DBXAE1rwnl/L8LI9epOgsBiVTAAEov8SoCABA4KXYPm
/NcW6JvvMYt4fANtEYcTLTSJdmhx6ADTk7lBGXNMXtrN02+Tdbc7qZ2lZGKudRI9
--000000000000b5375f061bf847e7--

