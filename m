Return-Path: <netdev+bounces-44934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A947DA40D
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318BB28285D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073884121A;
	Fri, 27 Oct 2023 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RnVbREtv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8B4176F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:23:48 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495561B1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2e4107f47so1702253b6e.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698449025; x=1699053825; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AneZ1vbRMYPvJB5eS7skmer8b8Q6/J0mI4s+fARtnYY=;
        b=RnVbREtv8x2JxTMVyzHMn9pzkJPYTXr5Th2SgDYlrj4QzdoDxx5LrSOcZyZRTEAAxg
         J/+ib1MSEPUXfimpMVUoz8s9IYKsgFs8vtK1mpPN7vlPuXf8I/PCOND3+u2vvj1l5FUG
         Bph0b9584ebsnBVJgaltg7dugLa4Hh+1T+XpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449025; x=1699053825;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AneZ1vbRMYPvJB5eS7skmer8b8Q6/J0mI4s+fARtnYY=;
        b=hvQhARKCXBDUibb4CbV2xlqfAP/PECOmB6b6VDzWMEp4ztY9V/Iap9EHJKE0HttsyS
         9zH2YAF0aIY3cs5rmHY9RhV9GVq2xu5CayVMiml9/N8sxXTNXVcjyehWyHVxyvjmVY10
         txt7rA8wAaq5vGOmytXSnW2x+sc8ZlZ8e0XUhq1ATb/L7vPKeOjzzQtRBaT67mMxeefD
         kPYFQG4lN3KtW9Qs07w6MqiuDQyPoN2aDVjlBiWkqDv0OrKvO+yk4QlrTS5rLNv5zcs4
         QfZs5vfAFIAjWuTN/gvT8SEoZV/J3oowABcGondohWe0pL6MdPET7ZzyUcvnK4EGHpGZ
         ulug==
X-Gm-Message-State: AOJu0YwHx2/rpToViNgYdr3vzblRrlTCylff3nd8Y1mjn2zPOhW0e086
	hnNN0prnBUm3lcv54WF7UsRvCA==
X-Google-Smtp-Source: AGHT+IGiraFXIXzsxad8RIoa1qTyamF6Elo/JrORIdBOYduKHapBHS9fWxkcWDasdHrawZM3TqOUpA==
X-Received: by 2002:a05:6808:2a68:b0:3b2:e624:43a0 with SMTP id fu8-20020a0568082a6800b003b2e62443a0mr3914649oib.15.1698449025111;
        Fri, 27 Oct 2023 16:23:45 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b007742ad3047asm984169qky.54.2023.10.27.16.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:23:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 09/13] bnxt_en: Support up to 8 TX rings per MSIX
Date: Fri, 27 Oct 2023 16:22:48 -0700
Message-Id: <20231027232252.36111-10-michael.chan@broadcom.com>
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
	boundary="000000000000da69c70608bafac7"

--000000000000da69c70608bafac7
Content-Transfer-Encoding: 8bit

For each mqprio TC, we allocate a set of TX rings to map to the new
hardware CoS queue.  Expand the tx_ring pointer in struct bnxt_napi
to an array of 8 to support up to 8 TX rings, one for each TC.
Only array entry 0 is used at this time.  The rest of the array
entries will be used in later patches.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 78 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 12 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +-
 3 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c84a72b666aa..6002b834e898 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -758,9 +758,13 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 
 static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
-	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
+	struct bnxt_tx_ring_info *txr;
+	int i;
 
-	__bnxt_tx_int(bp, txr, budget);
+	bnxt_for_each_napi_tx(i, bnapi, txr) {
+		if (txr->tx_hw_cons != txr->tx_cons)
+			__bnxt_tx_int(bp, txr, budget);
+	}
 	bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
@@ -2596,7 +2600,6 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	u32 raw_cons = cpr->cp_raw_cons;
-	struct bnxt_tx_ring_info *txr;
 	u32 cons;
 	int rx_pkts = 0;
 	u8 event = 0;
@@ -2604,7 +2607,6 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	cpr->has_more_work = 0;
 	cpr->had_work_done = 1;
-	txr = bnapi->tx_ring;
 	while (1) {
 		int rc;
 
@@ -2620,8 +2622,10 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		dma_rmb();
 		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_TX_L2_CMP) {
 			u32 opaque = txcmp->tx_cmp_opaque;
+			struct bnxt_tx_ring_info *txr;
 			u16 tx_freed;
 
+			txr = bnapi->tx_ring[TX_OPAQUE_RING(opaque)];
 			event |= BNXT_TX_CMP_EVENT;
 			txr->tx_hw_cons = TX_OPAQUE_PROD(bp, opaque);
 			tx_freed = (txr->tx_hw_cons - txr->tx_cons) &
@@ -2671,7 +2675,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		xdp_do_flush();
 
 	if (event & BNXT_TX_EVENT) {
-		struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
+		struct bnxt_tx_ring_info *txr = bnapi->tx_ring[0];
 		u16 prod = txr->tx_prod;
 
 		/* Sync BD data before updating doorbell */
@@ -3657,7 +3661,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 
 static void bnxt_init_ring_struct(struct bnxt *bp)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
@@ -3702,18 +3706,16 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		rmem->vmem = (void **)&rxr->rx_agg_ring;
 
 skip_rx:
-		txr = bnapi->tx_ring;
-		if (!txr)
-			continue;
-
-		ring = &txr->tx_ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bp->tx_nr_pages;
-		rmem->page_size = HW_RXBD_RING_SIZE;
-		rmem->pg_arr = (void **)txr->tx_desc_ring;
-		rmem->dma_arr = txr->tx_desc_mapping;
-		rmem->vmem_size = SW_TXBD_RING_SIZE * bp->tx_nr_pages;
-		rmem->vmem = (void **)&txr->tx_buf_ring;
+		bnxt_for_each_napi_tx(j, bnapi, txr) {
+			ring = &txr->tx_ring_struct;
+			rmem = &ring->ring_mem;
+			rmem->nr_pages = bp->tx_nr_pages;
+			rmem->page_size = HW_TXBD_RING_SIZE;
+			rmem->pg_arr = (void **)txr->tx_desc_ring;
+			rmem->dma_arr = txr->tx_desc_mapping;
+			rmem->vmem_size = SW_TXBD_RING_SIZE * bp->tx_nr_pages;
+			rmem->vmem = (void **)&txr->tx_buf_ring;
+		}
 	}
 }
 
@@ -4512,7 +4514,7 @@ static int bnxt_alloc_stats(struct bnxt *bp)
 
 static void bnxt_clear_ring_indices(struct bnxt *bp)
 {
-	int i;
+	int i, j;
 
 	if (!bp->bnapi)
 		return;
@@ -4529,8 +4531,7 @@ static void bnxt_clear_ring_indices(struct bnxt *bp)
 		cpr = &bnapi->cp_ring;
 		cpr->cp_raw_cons = 0;
 
-		txr = bnapi->tx_ring;
-		if (txr) {
+		bnxt_for_each_napi_tx(j, bnapi, txr) {
 			txr->tx_prod = 0;
 			txr->tx_cons = 0;
 			txr->tx_hw_cons = 0;
@@ -4703,7 +4704,7 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 			else
 				txr->tx_cpr =  &bp->bnapi[i]->cp_ring;
 			txr->bnapi = bp->bnapi[j];
-			bp->bnapi[j]->tx_ring = txr;
+			bp->bnapi[j]->tx_ring[0] = txr;
 			bp->tx_ring_map[i] = bp->tx_nr_rings_xdp + i;
 			if (i >= bp->tx_nr_rings_xdp) {
 				txr->txq_index = i - bp->tx_nr_rings_xdp;
@@ -6910,10 +6911,21 @@ static int
 bnxt_hwrm_set_tx_coal(struct bnxt *bp, struct bnxt_napi *bnapi,
 		      struct hwrm_ring_cmpl_ring_cfg_aggint_params_input *req)
 {
-	u16 ring_id = bnxt_cp_ring_for_tx(bp, bnapi->tx_ring);
+	struct bnxt_tx_ring_info *txr;
+	int i, rc;
 
-	req->ring_id = cpu_to_le16(ring_id);
-	return hwrm_req_send(bp, req);
+	bnxt_for_each_napi_tx(i, bnapi, txr) {
+		u16 ring_id;
+
+		ring_id = bnxt_cp_ring_for_tx(bp, txr);
+		req->ring_id = cpu_to_le16(ring_id);
+		rc = hwrm_req_send(bp, req);
+		if (rc)
+			return rc;
+		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
+			return 0;
+	}
+	return 0;
 }
 
 int bnxt_hwrm_set_coal(struct bnxt *bp)
@@ -6950,7 +6962,7 @@ int bnxt_hwrm_set_coal(struct bnxt *bp)
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
 			continue;
 
-		if (bnapi->rx_ring && bnapi->tx_ring) {
+		if (bnapi->rx_ring && bnapi->tx_ring[0]) {
 			rc = bnxt_hwrm_set_tx_coal(bp, bnapi, req_tx);
 			if (rc)
 				break;
@@ -11575,15 +11587,13 @@ static int bnxt_dbg_hwrm_ring_info_get(struct bnxt *bp, u8 ring_type,
 
 static void bnxt_dump_tx_sw_state(struct bnxt_napi *bnapi)
 {
-	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
-	int i = bnapi->index;
-
-	if (!txr)
-		return;
+	struct bnxt_tx_ring_info *txr;
+	int i = bnapi->index, j;
 
-	netdev_info(bnapi->bp->dev, "[%d]: tx{fw_ring: %d prod: %x cons: %x}\n",
-		    i, txr->tx_ring_struct.fw_ring_id, txr->tx_prod,
-		    txr->tx_cons);
+	bnxt_for_each_napi_tx(j, bnapi, txr)
+		netdev_info(bnapi->bp->dev, "[%d.%d]: tx{fw_ring: %d prod: %x cons: %x}\n",
+			    i, j, txr->tx_ring_struct.fw_ring_id, txr->tx_prod,
+			    txr->tx_cons);
 }
 
 static void bnxt_dump_rx_sw_state(struct bnxt_napi *bnapi)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 430538844178..2028233c0561 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1046,6 +1046,14 @@ struct bnxt_cp_ring_info {
 	struct bnxt_cp_ring_info *cp_ring_arr;
 };
 
+#define BNXT_MAX_QUEUE		8
+#define BNXT_MAX_TXR_PER_NAPI	BNXT_MAX_QUEUE
+
+#define bnxt_for_each_napi_tx(iter, bnapi, txr)		\
+	for (iter = 0, txr = (bnapi)->tx_ring[0]; txr;	\
+	     txr = (iter < BNXT_MAX_TXR_PER_NAPI - 1) ?	\
+	     (bnapi)->tx_ring[++iter] : NULL)
+
 struct bnxt_napi {
 	struct napi_struct	napi;
 	struct bnxt		*bp;
@@ -1053,7 +1061,7 @@ struct bnxt_napi {
 	int			index;
 	struct bnxt_cp_ring_info	cp_ring;
 	struct bnxt_rx_ring_info	*rx_ring;
-	struct bnxt_tx_ring_info	*tx_ring;
+	struct bnxt_tx_ring_info	*tx_ring[BNXT_MAX_TXR_PER_NAPI];
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
 					  int budget);
@@ -1391,8 +1399,6 @@ struct bnxt_link_info {
 	(PORT_PHY_CFG_REQ_FLAGS_FEC_CLAUSE74_DISABLE |		\
 	 BNXT_FEC_RS_OFF(link_info))
 
-#define BNXT_MAX_QUEUE	8
-
 struct bnxt_queue_info {
 	u8	queue_id;
 	u8	queue_profile;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 3515a12a6fea..52b75108e130 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -127,7 +127,7 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 {
-	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
+	struct bnxt_tx_ring_info *txr = bnapi->tx_ring[0];
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
 	u16 tx_hw_cons = txr->tx_hw_cons;
 	bool rx_doorbell_needed = false;
@@ -249,7 +249,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	pdev = bp->pdev;
 	offset = bp->rx_offset;
 
-	txr = rxr->bnapi->tx_ring;
+	txr = rxr->bnapi->tx_ring[0];
 	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
 	orig_data = xdp.data;
 
-- 
2.30.1


--000000000000da69c70608bafac7
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDJ0rto17BQCp9BBH337h6T8AYgCY9/p
qbGUz3/n4xfNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
NzIzMjM0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQADUW8b2pXVSNqnG31O4tncOvf9y4MVusptx8mmHg2sbnLWODl+
roI++EnKyg1TFf/ywyZ7o5tqNBNCX5F4BTkUZRqwJZv5WGRQQS/mF1RXEX7871tO6esCiVs0mY59
eBppLRn5/OpkRJc/CffkLTyR2DWVQtbMs863iUOPJ5/T099xves1KZ3EvhWpbL6+UYYZRglVWpkc
9YG2sJcEvz5NyZzJRzKEtmp4bUBVFwPeolY5+vZAkfBgFWmIlHeZVU5yzEjGKx227EThP+vnyWy+
FTzmeFAvW8pRtyiDrirmB0wu8lhKTrNZDnuUua8aFOn2kj/NpgR8w9fHfsxhWbBw
--000000000000da69c70608bafac7--

