Return-Path: <netdev+bounces-83938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25817894ED3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BB31F23D90
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CB58AA6;
	Tue,  2 Apr 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d/pl3mct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC558AB9
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050551; cv=none; b=VGUh2p/87O/C2gUGuLvGso6MsspqBSnbxO0qf0EIx08bhKKAkEiRYaKPOhppHJjyYIqkhnSsjict2xTQnAx3G44aXlWHCF7VzeEh1F/8jzWKHbFDp++I2zSGKJMlFdSOD07EMF8sj0QOQGT318/n8gZqWbRlBN60iVWZtb0qmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050551; c=relaxed/simple;
	bh=N/sYrwapmrmInS9tBNB27kGc2iS++nzGFjEjIued6b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/q6BPlCmRXEP7Ea8ndMpyW2QGaSiFua9AGKOht0iKa/cQHNqxnrlorjYAEDQPfDdTsHN3AO+JLkgoeTHsZbggIa9o7QZ6wxI2XRph8GWhUSw1KkkBiKNvRmcADLbtDh2QmQXSrGcKaGxODLOJuRXtrMi3cJyB0CCeuRkT8iNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d/pl3mct; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-229661f57cbso2801467fac.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712050549; x=1712655349; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wFzPL40NYLbr4GrhKDkYjKKyZJscJaCz4A7/2Ca8n4=;
        b=d/pl3mct9j+NMxN28dFk3pOSc6r/jO8oE13uzA45cr4HcvbMAqpBScXfn5TZ1T+1fU
         DCx2BrU+eV5VLtiAlktvfx6EWXr3VNX1mzbjcgmjdaz+Qpyi6+nO13p/9H0FZbh1U9ZU
         ucTwt5uNHz1u4oXyKdS1NG/OerSBDWVoV6m00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050549; x=1712655349;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wFzPL40NYLbr4GrhKDkYjKKyZJscJaCz4A7/2Ca8n4=;
        b=JOPi3GqysdMyzDFdQv5xf0PYg3js1P5z18YnHJt3NdyhfzKByK4SFgml7s/uC8GU4Y
         fbFC/yAdsInvff2L+bF3d8GxI3vRzwD+ohya0JqFnldToCUE2m34ibqjtEZ5zk7niMd8
         uMsahOpMewZUUXGY549c6W2jVDoNPBMX2y6hTizTiq2vpvdWS9gXkPPL8ImOfTlyQEVu
         ai9wStdo6XxV4+V0Rosk/29u70faqMX/3/RvRO2ts9eDm7FE8Fcmd/oYqI9qoVe260pg
         Zc2tpoVEExaXKxC/X7K4QjyKLhMXX1qQj8EAINJyDE3cX/xnJ8sMsaHa/ISK/gmTv71+
         atkA==
X-Forwarded-Encrypted: i=1; AJvYcCVuBc18DVxbCQ5O6WiVT4QqsN+WY/FfbLeCG64+IYdAyVCkXuyoXlqriroL7O8P966bxlcOJP2dxHpZD7k1oydt+fRXcoAE
X-Gm-Message-State: AOJu0YxTih+70xPhE9rm+G0RlA4KSkWCO3BKLgL1ay4aZoq+xPvHZHOI
	mgi2Tq/fCFqdYQR7b8w/iOAOxzyiCU11+YNdUvaCr57Ze1QMx1uSM8gTwg6oag==
X-Google-Smtp-Source: AGHT+IFS/R7+nYw0lUrVfKti/30+geSLy5s3UFkGqFasYBeZ4XPftT8SAak2ZjgvdKgrlt7IftpZCw==
X-Received: by 2002:a05:6870:64a5:b0:229:f022:ef83 with SMTP id cz37-20020a05687064a500b00229f022ef83mr12770502oab.43.1712050548589;
        Tue, 02 Apr 2024 02:35:48 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19-20020a62e113000000b006e5a3db5875sm9702087pfh.13.2024.04.02.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:35:48 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 4/7] bnxt_en: Change bnxt_rx_xdp function prototype
Date: Tue,  2 Apr 2024 02:37:50 -0700
Message-Id: <20240402093753.331120-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
References: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d1bcf4061519d4de"

--000000000000d1bcf4061519d4de
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Change bnxt_rx_xdp() to take a pointer to xdp instead of stack
variable.
This is in prepartion for the XDP metadata patch change where
the BPF program can change the value of the xdp.meta_data.

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 28 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9fca1dee6486..5e54b7cacc45 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2104,7 +2104,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4079538bc310..6b904b4f4d34 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -222,7 +222,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
  * false   - packet should be passed to the stack.
  */
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
-		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
+		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(rxr->xdp_prog);
@@ -244,9 +244,9 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 
 	txr = rxr->bnapi->tx_ring[0];
 	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
-	orig_data = xdp.data;
+	orig_data = xdp->data;
 
-	act = bpf_prog_run_xdp(xdp_prog, &xdp);
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	tx_avail = bnxt_tx_avail(bp, txr);
 	/* If the tx ring is not full, we must not update the rx producer yet
@@ -255,10 +255,10 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	if (tx_avail != bp->tx_ring_size)
 		*event &= ~BNXT_RX_EVENT;
 
-	*len = xdp.data_end - xdp.data;
-	if (orig_data != xdp.data) {
-		offset = xdp.data - xdp.data_hard_start;
-		*data_ptr = xdp.data_hard_start + offset;
+	*len = xdp->data_end - xdp->data;
+	if (orig_data != xdp->data) {
+		offset = xdp->data - xdp->data_hard_start;
+		*data_ptr = xdp->data_hard_start + offset;
 	}
 
 	switch (act) {
@@ -270,8 +270,8 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
 		*event &= BNXT_TX_CMP_EVENT;
 
-		if (unlikely(xdp_buff_has_frags(&xdp))) {
-			struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(&xdp);
+		if (unlikely(xdp_buff_has_frags(xdp))) {
+			struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
 			tx_needed += sinfo->nr_frags;
 			*event = BNXT_AGG_EVENT;
@@ -279,7 +279,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 
 		if (tx_avail < tx_needed) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
-			bnxt_xdp_buff_frags_free(rxr, &xdp);
+			bnxt_xdp_buff_frags_free(rxr, xdp);
 			bnxt_reuse_rx_data(rxr, cons, page);
 			return true;
 		}
@@ -289,7 +289,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 
 		*event |= BNXT_TX_EVENT;
 		__bnxt_xmit_xdp(bp, txr, mapping + offset, *len,
-				NEXT_RX(rxr->rx_prod), &xdp);
+				NEXT_RX(rxr->rx_prod), xdp);
 		bnxt_reuse_rx_data(rxr, cons, page);
 		return true;
 	case XDP_REDIRECT:
@@ -306,12 +306,12 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		/* if we are unable to allocate a new buffer, abort and reuse */
 		if (bnxt_alloc_rx_data(bp, rxr, rxr->rx_prod, GFP_ATOMIC)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
-			bnxt_xdp_buff_frags_free(rxr, &xdp);
+			bnxt_xdp_buff_frags_free(rxr, xdp);
 			bnxt_reuse_rx_data(rxr, cons, page);
 			return true;
 		}
 
-		if (xdp_do_redirect(bp->dev, &xdp, xdp_prog)) {
+		if (xdp_do_redirect(bp->dev, xdp, xdp_prog)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
 			page_pool_recycle_direct(rxr->page_pool, page);
 			return true;
@@ -326,7 +326,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		trace_xdp_exception(bp->dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
-		bnxt_xdp_buff_frags_free(rxr, &xdp);
+		bnxt_xdp_buff_frags_free(rxr, xdp);
 		bnxt_reuse_rx_data(rxr, cons, page);
 		break;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 5e412c5655ba..0122782400b8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -18,7 +18,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct xdp_buff *xdp);
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
-		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
+		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
 int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp);
 int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
-- 
2.39.1


--000000000000d1bcf4061519d4de
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBy8d55GI8FtDju4hVVvJ8j40S0Bl61D
85iEUj+kv8iAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
MjA5MzU0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBUE8GbiLoeL5p1m9ro/LeQxDxAkuaubGbO1WdVRWRcXeATRqpT
EqIJK0qzapHYuqj+ahArWezWPr+eCD2IJMuDuUQX8e5/713rnGeBraUET+Na9YUQRXSqZDz3TUoz
vID3WiNiEhVZSW/A33t1DEDuq15IEW9KRID/QPOPFEW8sQmM3Sj+xvLHCKpGQh7JtS67IDkX0S/Z
/AcdPUY1x5ztVARGi1E7dHlrAtK6sOPNUwOm/07YnZEAy46OgAQuln40ZcKY82i9WBhRHQ8wuRoI
+qqUDggxIeyLqH1PCR1M4LUp8x3dHYbuZ+eEFMzAhn5HgEXy2qbeoVGZoCy+Jg1N
--000000000000d1bcf4061519d4de--

