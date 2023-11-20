Return-Path: <netdev+bounces-49456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302367F2198
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2811F2641B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84003C094;
	Mon, 20 Nov 2023 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mf4+LSNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428CC95
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:51 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1efad296d42so2890695fac.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523890; x=1701128690; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqe3q3gcaeVni3mDguaIglphkpCu9D8s2XuHLUz6sFg=;
        b=Mf4+LSNmlNP59eWxiESMgkOoSjX1yx1ndvLSUEkAwbn5/t6nf4/PXS04qOVqzEM9Mu
         T5EJjYx5WixhWN4Ipm+qElpvZx2L7M905CpNBpQ3ZobZm1u7LGzPatZHUEPld/cNk2Ph
         dvSAQ5v4rzNFyOt3GUim3ku2TFLPXl/ueqtzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523890; x=1701128690;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqe3q3gcaeVni3mDguaIglphkpCu9D8s2XuHLUz6sFg=;
        b=tFTBOVPb48UqXrCNBdbLCls3+qQMEOOcjQ53vXr2HwIneUha2yakJR4rROLlWkNlyz
         Rlxv+f9nlfFGeAS4Pkf95ff0Qgsor9b7XZeSJ+TFgbBhEeZ4pbR/ghsTa1omA5BuJ2zQ
         oL3R4rYhGB8IJzSpVRvKFJDCTL2PdIzOIKAeqtvYx5dcjReAuewEKARguUWDVkM7yo/Q
         n/j4eLYOGvODq16EwnY9STp7LmsGka5y4djcZM1XIKHWKa5M+2mebBB6tsVJaUnAc6WO
         z+226J44RJw5PODGA0LHaW5OijmKwG7jM0yG+v2EjOmZzDAX+uQCwjWD4CidAQoFCbbJ
         9e0g==
X-Gm-Message-State: AOJu0YxMsH+waRId+pUy8xq59XviDTNy+2nGNCUE6/sbekccPp6ftLUc
	EtYNGCQUdR46HkQnPGt2FwFtKA==
X-Google-Smtp-Source: AGHT+IGo6nh6yfyFPAP9g/kIrMkwkKs2Jv/aD0K4uVSqnkqywcGfLGkpINs+9dn31eBg2APULsMD6Q==
X-Received: by 2002:a05:6870:3893:b0:1f9:5c71:a684 with SMTP id y19-20020a056870389300b001f95c71a684mr2431706oan.42.1700523890398;
        Mon, 20 Nov 2023 15:44:50 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 10/13] bnxt_en: Modify TX ring indexing logic.
Date: Mon, 20 Nov 2023 15:44:02 -0800
Message-Id: <20231120234405.194542-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231120234405.194542-1-michael.chan@broadcom.com>
References: <20231120234405.194542-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000071993b060a9e1263"

--00000000000071993b060a9e1263
Content-Transfer-Encoding: 8bit

Change the TX ring logic so that the index increments unbounded and
mask it only when needed.

Modify the existing macros so that the index is not masked.  Add a
new macro RING_TX() to mask it only when needed to get the index of
txr->tx_buf_ring[].

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 14 ++++++------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 48c443d52344..c83450564765 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -432,9 +432,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
 
-	txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
-	tx_buf = &txr->tx_buf_ring[prod];
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 	tx_buf->skb = skb;
 	tx_buf->nr_frags = last_frag;
 
@@ -522,7 +522,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 2);
 		prod = NEXT_TX(prod);
 		tx_push->tx_bd_opaque = txbd->tx_bd_opaque;
-		txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 		memcpy(txbd, tx_push1, sizeof(*txbd));
 		prod = NEXT_TX(prod);
 		tx_push->doorbell =
@@ -569,7 +569,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	prod = NEXT_TX(prod);
 	txbd1 = (struct tx_bd_ext *)
-		&txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
 	txbd1->tx_bd_hsize_lflags = lflags;
 	if (skb_is_gso(skb)) {
@@ -610,7 +610,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		prod = NEXT_TX(prod);
-		txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
 		len = skb_frag_size(frag);
 		mapping = skb_frag_dma_map(&pdev->dev, frag, 0, len,
@@ -619,7 +619,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
 			goto tx_dma_error;
 
-		tx_buf = &txr->tx_buf_ring[prod];
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		dma_unmap_addr_set(tx_buf, mapping, mapping);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
@@ -668,7 +668,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* start back at beginning and unmap skb */
 	prod = txr->tx_prod;
-	tx_buf = &txr->tx_buf_ring[prod];
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 	dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
 			 skb_headlen(skb), DMA_TO_DEVICE);
 	prod = NEXT_TX(prod);
@@ -676,7 +676,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* unmap remaining mapped pages */
 	for (i = 0; i < last_frag; i++) {
 		prod = NEXT_TX(prod);
-		tx_buf = &txr->tx_buf_ring[prod];
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
 			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
 			       DMA_TO_DEVICE);
@@ -702,12 +702,12 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 cons = txr->tx_cons;
 	int tx_pkts = 0;
 
-	while (cons != hw_cons) {
+	while (RING_TX(bp, cons) != hw_cons) {
 		struct bnxt_sw_tx_bd *tx_buf;
 		struct sk_buff *skb;
 		int j, last;
 
-		tx_buf = &txr->tx_buf_ring[cons];
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
 		cons = NEXT_TX(cons);
 		skb = tx_buf->skb;
 		tx_buf->skb = NULL;
@@ -731,7 +731,7 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 
 		for (j = 0; j < last; j++) {
 			cons = NEXT_TX(cons);
-			tx_buf = &txr->tx_buf_ring[cons];
+			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
 			dma_unmap_page(
 				&pdev->dev,
 				dma_unmap_addr(tx_buf, mapping),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7d79a2c8d3c3..1b04510f677b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -689,7 +689,7 @@ struct nqe_cn {
 #define RX_RING(x)	(((x) & ~(RX_DESC_CNT - 1)) >> (BNXT_PAGE_SHIFT - 4))
 #define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
 
-#define TX_RING(x)	(((x) & ~(TX_DESC_CNT - 1)) >> (BNXT_PAGE_SHIFT - 4))
+#define TX_RING(bp, x)	(((x) & (bp)->tx_ring_mask) >> (BNXT_PAGE_SHIFT - 4))
 #define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
 
 #define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNXT_PAGE_SHIFT - 4))
@@ -720,7 +720,8 @@ struct nqe_cn {
 
 #define NEXT_RX_AGG(idx)	(((idx) + 1) & bp->rx_agg_ring_mask)
 
-#define NEXT_TX(idx)		(((idx) + 1) & bp->tx_ring_mask)
+#define RING_TX(bp, idx)	((idx) & (bp)->tx_ring_mask)
+#define NEXT_TX(idx)		((idx) + 1)
 
 #define ADV_RAW_CMP(idx, n)	((idx) + (n))
 #define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9d428eb3fdb9..4791f6a14e55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -42,12 +42,12 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 
 	/* fill up the first buffer */
 	prod = txr->tx_prod;
-	tx_buf = &txr->tx_buf_ring[prod];
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 	tx_buf->nr_frags = num_frags;
 	if (xdp)
 		tx_buf->page = virt_to_head_page(xdp->data);
 
-	txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 	flags = (len << TX_BD_LEN_SHIFT) |
 		((num_frags + 1) << TX_BD_FLAGS_BD_CNT_SHIFT) |
 		bnxt_lhint_arr[len >> 9];
@@ -67,10 +67,10 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 		WRITE_ONCE(txr->tx_prod, prod);
 
 		/* first fill up the first buffer */
-		frag_tx_buf = &txr->tx_buf_ring[prod];
+		frag_tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		frag_tx_buf->page = skb_frag_page(frag);
 
-		txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
 		frag_len = skb_frag_size(frag);
 		frag_mapping = skb_frag_dma_map(&pdev->dev, frag, 0,
@@ -139,8 +139,8 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 	if (!budget)
 		return;
 
-	while (tx_cons != tx_hw_cons) {
-		tx_buf = &txr->tx_buf_ring[tx_cons];
+	while (RING_TX(bp, tx_cons) != tx_hw_cons) {
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, tx_cons)];
 
 		if (tx_buf->action == XDP_REDIRECT) {
 			struct pci_dev *pdev = bp->pdev;
@@ -160,7 +160,7 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 			frags = tx_buf->nr_frags;
 			for (j = 0; j < frags; j++) {
 				tx_cons = NEXT_TX(tx_cons);
-				tx_buf = &txr->tx_buf_ring[tx_cons];
+				tx_buf = &txr->tx_buf_ring[RING_TX(bp, tx_cons)];
 				page_pool_recycle_direct(rxr->page_pool, tx_buf->page);
 			}
 		} else {
-- 
2.30.1


--00000000000071993b060a9e1263
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKSvKY1/7J4gNeVzWSyW4c4DSY6DLo71
ILPTwN8ipjZiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQ1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAUGYVMMQ8J01fZg7bX7o3YNo5XUoHAOBzhO5s3l46vAp2z285o
iNhhiBxXpBT/ECc9wmZJQNuaCZy1AP4ntaQ2J0ZqIhtoRdE1ymLXFXfiD6mxUvSBL6nuXZnbmIUH
zt3he8DP0hPhEt09bhk7J423hCe36Sgo21Xp8KJ3nwv8jR9yYgnovzgEnIiu9a7CjNBDv4OIMBaC
5KgUjX30nGvBq69ZqELbqdoBATodaGDCgRg5qf+NA8Eis6A1zGISKkSFlt3/q1nTbA1Zhg43HjDD
PQD5l8fcjtpDux9PdG1qSEd/qEz8LtJhHoDZ8rFbvumn0lvwaKVBlBJ8KGHC8E9m
--00000000000071993b060a9e1263--

