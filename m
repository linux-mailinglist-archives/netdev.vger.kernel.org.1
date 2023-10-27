Return-Path: <netdev+bounces-44927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10557DA406
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3E1C2116D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574F41222;
	Fri, 27 Oct 2023 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+Flay3Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9ED4120F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:23:38 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC8C2
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-777745f1541so203532685a.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698449016; x=1699053816; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9hRzIhkZNR9BeD5LN+XP5f+diJN2H+76Am4YaGFUy4=;
        b=C+Flay3Zdb5zQQDW71TlymouZCnD5jzLiHUeh5BqX5YpI6Eb65pRuQryVY27HFT+Ul
         VCZ8tl0usTBKrd42SFzvcEZI9hj2US/RL/0wAh3RGg4VSaiHIrsFuj24oq9pyIv4jIwF
         jyXvkOGIQXYiPlrGZSlsYy662I/sQAKkSHLYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449016; x=1699053816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9hRzIhkZNR9BeD5LN+XP5f+diJN2H+76Am4YaGFUy4=;
        b=B+4qbYV7/lw3ibVf0ot0mLpBuaKEAicBYVTSz7UsYPHI7SCCB0iUfzuY8ZmqQCa0cq
         nXciz9n3+dvLLgybc2XVyWE5/gFSoJVzxKgcDHPG5WW8PMwrDW/Ki1XbCFxx6eyp2YLw
         JBeZ6Wqgn9tZIdGsPSUATUje/4qvh8NFUSDyNvaBGRRyFQxtIBr8h2PXtGLx6xC1pEHN
         GW2Mv2txDTLVkROChJPTETwc6a5OX3avjC6QpAFpKuZW3Wm4L6PvPZROVscPYWFx38wL
         FMk9zhbMqgiaM/QmFiPVng8feW4rgdcmMNz3N/RZz97laDWAJkk2lgVpMPVPTah5lIb+
         1Q8w==
X-Gm-Message-State: AOJu0YxgAFvYpBIHcaoF96AYRJiHVfdHRj/GLWThgICvErPbg6F8bWqm
	VyhFnSUeRug0Yq3r+CURbwZNbA==
X-Google-Smtp-Source: AGHT+IGNlfLxDhFuwOR45GIey/swgTWgzVFjnccA7GfF4ozCMTVuHhWXy49psp3opH23ptEc7xSF9Q==
X-Received: by 2002:a05:620a:1a26:b0:76f:1817:942b with SMTP id bk38-20020a05620a1a2600b0076f1817942bmr4282224qkb.28.1698449015247;
        Fri, 27 Oct 2023 16:23:35 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b007742ad3047asm984169qky.54.2023.10.27.16.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:23:34 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 02/13] bnxt_en: Add completion ring pointer in TX and RX ring structures
Date: Fri, 27 Oct 2023 16:22:41 -0700
Message-Id: <20231027232252.36111-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231027232252.36111-1-michael.chan@broadcom.com>
References: <20231027232252.36111-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000044846e0608bafa12"

--00000000000044846e0608bafa12
Content-Transfer-Encoding: 8bit

From the TX or RX ring structure, we need to find the corresponding
completion ring during initialization.  On P5 chips, we use the MSIX/napi
entry to locate the completion ring because there is only one RX/TX
ring per MSIX.  To allow multiple TX rings for each MSIX, we need
to add a direct pointer from the TX ring and RX ring structures.
This also simplifies the existing logic.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 43 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 11 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 12 +++---
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 669ea945d3cd..4dfe0b66c5f7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -331,16 +331,16 @@ static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 }
 
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
-			  int idx)
+			  u16 curr)
 {
 	struct bnxt_napi *bnapi = txr->bnapi;
 
 	if (bnapi->tx_fault)
 		return;
 
-	netdev_err(bp->dev, "Invalid Tx completion (ring:%d tx_pkts:%d cons:%u prod:%u i:%d)",
-		   txr->txq_index, bnapi->tx_pkts,
-		   txr->tx_cons, txr->tx_prod, idx);
+	netdev_err(bp->dev, "Invalid Tx completion (ring:%d tx_hw_cons:%u cons:%u prod:%u curr:%u)",
+		   txr->txq_index, txr->tx_hw_cons,
+		   txr->tx_cons, txr->tx_prod, curr);
 	WARN_ON_ONCE(1);
 	bnapi->tx_fault = 1;
 	bnxt_queue_sp_work(bp, BNXT_RESET_TASK_SP_EVENT);
@@ -691,13 +691,13 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
+	u16 hw_cons = txr->tx_hw_cons;
 	u16 cons = txr->tx_cons;
 	struct pci_dev *pdev = bp->pdev;
-	int nr_pkts = bnapi->tx_pkts;
-	int i;
 	unsigned int tx_bytes = 0;
+	int tx_pkts = 0;
 
-	for (i = 0; i < nr_pkts; i++) {
+	while (cons != hw_cons) {
 		struct bnxt_sw_tx_bd *tx_buf;
 		struct sk_buff *skb;
 		int j, last;
@@ -708,10 +708,11 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		tx_buf->skb = NULL;
 
 		if (unlikely(!skb)) {
-			bnxt_sched_reset_txr(bp, txr, i);
+			bnxt_sched_reset_txr(bp, txr, cons);
 			return;
 		}
 
+		tx_pkts++;
 		tx_bytes += skb->len;
 
 		if (tx_buf->is_push) {
@@ -748,10 +749,10 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		dev_consume_skb_any(skb);
 	}
 
-	bnapi->tx_pkts = 0;
+	bnapi->events &= ~BNXT_TX_CMP_EVENT;
 	WRITE_ONCE(txr->tx_cons, cons);
 
-	__netif_txq_completed_wake(txq, nr_pkts, tx_bytes,
+	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
 				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
 }
@@ -2588,14 +2589,15 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	u32 raw_cons = cpr->cp_raw_cons;
+	struct bnxt_tx_ring_info *txr;
 	u32 cons;
-	int tx_pkts = 0;
 	int rx_pkts = 0;
 	u8 event = 0;
 	struct tx_cmp *txcmp;
 
 	cpr->has_more_work = 0;
 	cpr->had_work_done = 1;
+	txr = bnapi->tx_ring;
 	while (1) {
 		int rc;
 
@@ -2610,9 +2612,15 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		 */
 		dma_rmb();
 		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_TX_L2_CMP) {
-			tx_pkts++;
+			u32 opaque = txcmp->tx_cmp_opaque;
+			u16 tx_freed;
+
+			event |= BNXT_TX_CMP_EVENT;
+			txr->tx_hw_cons = TX_OPAQUE_PROD(bp, opaque);
+			tx_freed = (txr->tx_hw_cons - txr->tx_cons) &
+				   bp->tx_ring_mask;
 			/* return full budget so NAPI will complete. */
-			if (unlikely(tx_pkts >= bp->tx_wake_thresh)) {
+			if (unlikely(tx_freed >= bp->tx_wake_thresh)) {
 				rx_pkts = budget;
 				raw_cons = NEXT_RAW_CMP(raw_cons);
 				if (budget)
@@ -2666,7 +2674,6 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	cpr->cp_raw_cons = raw_cons;
-	bnapi->tx_pkts += tx_pkts;
 	bnapi->events |= event;
 	return rx_pkts;
 }
@@ -2674,7 +2681,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 				  int budget)
 {
-	if (bnapi->tx_pkts && !bnapi->tx_fault)
+	if ((bnapi->events & BNXT_TX_CMP_EVENT) && !bnapi->tx_fault)
 		bnapi->tx_int(bp, bnapi, budget);
 
 	if ((bnapi->events & BNXT_RX_EVENT) && !(bnapi->in_reset)) {
@@ -2687,7 +2694,7 @@ static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 	}
-	bnapi->events = 0;
+	bnapi->events &= BNXT_TX_CMP_EVENT;
 }
 
 static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
@@ -4515,6 +4522,7 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 		if (txr) {
 			txr->tx_prod = 0;
 			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
 		}
 
 		rxr = bnapi->rx_ring;
@@ -4524,6 +4532,7 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 			rxr->rx_sw_agg_prod = 0;
 			rxr->rx_next_cons = 0;
 		}
+		bnapi->events = 0;
 	}
 }
 
@@ -9528,8 +9537,6 @@ static void bnxt_enable_napi(struct bnxt *bp)
 		cpr = &bnapi->cp_ring;
 		bnapi->in_reset = false;
 
-		bnapi->tx_pkts = 0;
-
 		if (bnapi->rx_ring) {
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c7895e7d78d5..cf22aae91f70 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -68,6 +68,12 @@ struct tx_bd {
 #define SET_TX_OPAQUE(bp, idx, bds)					\
 	(((bds) << TX_OPAQUE_BDS_SHIFT) | ((idx) & (bp)->tx_ring_mask))
 
+#define TX_OPAQUE_IDX(opq)	((opq) & TX_OPAQUE_IDX_MASK)
+#define TX_OPAQUE_BDS(opq)	(((opq) & TX_OPAQUE_BDS_MASK) >>	\
+				 TX_OPAQUE_BDS_SHIFT)
+#define TX_OPAQUE_PROD(bp, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
+				 (bp)->tx_ring_mask)
+
 struct tx_bd_ext {
 	__le32 tx_bd_hsize_lflags;
 	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
@@ -709,6 +715,7 @@ struct nqe_cn {
 #define BNXT_AGG_EVENT		2
 #define BNXT_TX_EVENT		4
 #define BNXT_REDIRECT_EVENT	8
+#define BNXT_TX_CMP_EVENT	0x10
 
 struct bnxt_sw_tx_bd {
 	union {
@@ -801,6 +808,7 @@ struct bnxt_tx_ring_info {
 	struct bnxt_napi	*bnapi;
 	u16			tx_prod;
 	u16			tx_cons;
+	u16			tx_hw_cons;
 	u16			txq_index;
 	u8			kick_pending;
 	struct bnxt_db_info	tx_db;
@@ -1027,7 +1035,6 @@ struct bnxt_napi {
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
 					  int budget);
-	int			tx_pkts;
 	u8			events;
 	u8			tx_fault:1;
 
@@ -2367,7 +2374,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
-			  int idx);
+			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
 int bnxt_update_link(struct bnxt *bp, bool chng_link_state);
 int bnxt_hwrm_set_pause(struct bnxt *);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 3e5144aafb0c..23476100fad2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -129,17 +129,17 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
 	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
+	u16 tx_hw_cons = txr->tx_hw_cons;
 	bool rx_doorbell_needed = false;
-	int nr_pkts = bnapi->tx_pkts;
 	struct bnxt_sw_tx_bd *tx_buf;
 	u16 tx_cons = txr->tx_cons;
 	u16 last_tx_cons = tx_cons;
-	int i, j, frags;
+	int j, frags;
 
 	if (!budget)
 		return;
 
-	for (i = 0; i < nr_pkts; i++) {
+	while (tx_cons != tx_hw_cons) {
 		tx_buf = &txr->tx_buf_ring[tx_cons];
 
 		if (tx_buf->action == XDP_REDIRECT) {
@@ -164,13 +164,13 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 				page_pool_recycle_direct(rxr->page_pool, tx_buf->page);
 			}
 		} else {
-			bnxt_sched_reset_txr(bp, txr, i);
+			bnxt_sched_reset_txr(bp, txr, tx_cons);
 			return;
 		}
 		tx_cons = NEXT_TX(tx_cons);
 	}
 
-	bnapi->tx_pkts = 0;
+	bnapi->events &= ~BNXT_TX_CMP_EVENT;
 	WRITE_ONCE(txr->tx_cons, tx_cons);
 	if (rx_doorbell_needed) {
 		tx_buf = &txr->tx_buf_ring[last_tx_cons];
@@ -275,7 +275,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	case XDP_TX:
 		rx_buf = &rxr->rx_buf_ring[cons];
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
-		*event = 0;
+		*event &= BNXT_TX_CMP_EVENT;
 
 		if (unlikely(xdp_buff_has_frags(&xdp))) {
 			struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(&xdp);
-- 
2.30.1


--00000000000044846e0608bafa12
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPHbIF7tkguhzJzdBfU17RbVkHZ0RpIs
DbNO7CePu7gUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
NzIzMjMzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB0zGwy914t68lEpPahYMBgRAqjelahJhyD/c6HvYRzuGCiN/ng
WHgWL7A9anYzzXAV/zhIO67tNN1lWGeeMOnVZFag6mls9mW5NTPLOkzf/ZwVZ/BsNJzbjy+z1OA/
BAeTeiRKGg4ezC93pMDB/IQHD4k4+G7mOmJK35PY9MeO2PT/1EBdIu8aXytqgyNL2czlOsSqcKR/
5FK4Gg3KpeNCfIvei1pbsjbJxUehxEDoHZsxt9h0+EBfGh3HoqGJE7d95xmn8zhIxw0XkvGp4r54
d4yqVUvh0NMV8+coJN4Vt41OdT1JT7pz9+JoD6xEots2YER97EgDuFIWj2Ti34R5
--00000000000044846e0608bafa12--

