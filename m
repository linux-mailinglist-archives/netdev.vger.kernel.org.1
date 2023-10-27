Return-Path: <netdev+bounces-44928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201167DA407
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CBF1C211EE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FA4122F;
	Fri, 27 Oct 2023 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HINrEm0O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF44121F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 23:23:40 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3631BC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2b1ad7ee6so1486024b6e.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698449017; x=1699053817; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfYEhri7UtAIKQoHpr6k7382LZUgOAJ80u1lQ6MdcDo=;
        b=HINrEm0OzkbGdHhdS6soA0AAPKpiRkUv/97jofwRu1iKxqx1H9eRFuEbTLwbp+747t
         AdaS/2lNRFnRU4koIo0qM+Q2gMUzF+oJX4hY/5VmMqt33rMuQY+VWrmuWUYPrt3ML4Wb
         QjKJ2eIby9r+Uc/qq0jRp7PsCXD/Cf3px1DeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449017; x=1699053817;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfYEhri7UtAIKQoHpr6k7382LZUgOAJ80u1lQ6MdcDo=;
        b=XedqRoScHBVpKqy694K3h7nHD0IEFEkrhZ3Dnt7i4hviHKlvqA+C37tPXIybEyjl42
         SLs0B+L47hV8E4u4v8dp8MOgQ7+2OYqRzvl1He9/Mq24/VrgQq1yL/Puep8oclrFcYRO
         QIs2jkaYEI6Le3ZL+d3XX+LE1jbqnRdcrdcCjVk8d5Raaa5aHXza79VNZu/zicH8+1mX
         OtJnOiJQh3uV8kwoqKMOBiE4gcv+pABQ9KiyDLsONRUgvPpSUqi9CerRyHjyYU+v9hrR
         C3HJqWXLyN+X1z0aQKQG039xYkQ/JYUJ3qZqLy5Uf4kQQ7RbVkwYFQlKhp3n0vYhaYR9
         Svag==
X-Gm-Message-State: AOJu0Yzy6hrHxECa6+BKXhxsF4MxIl1RDO9ijPrjoUcBPolc5UynLNJR
	KHH92ktdBax90xdbPJfZSVzILg==
X-Google-Smtp-Source: AGHT+IGg6naC4zs8NZklPGxkIxNYlEGqPqq8MLJ/n+Hioa3XO/dYFawAX12JceJRN85WIV+UdhoYmg==
X-Received: by 2002:a54:4407:0:b0:3b2:e469:903f with SMTP id k7-20020a544407000000b003b2e469903fmr3930228oiw.15.1698449016643;
        Fri, 27 Oct 2023 16:23:36 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b007742ad3047asm984169qky.54.2023.10.27.16.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:23:36 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 03/13] bnxt_en: Restructure cp_ring_arr in struct bnxt_cp_ring_info
Date: Fri, 27 Oct 2023 16:22:42 -0700
Message-Id: <20231027232252.36111-4-michael.chan@broadcom.com>
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
	boundary="00000000000057ba950608bafae2"

--00000000000057ba950608bafae2
Content-Transfer-Encoding: 8bit

The cp_ring_arr is currently a fixed array of 2 pointers for the
TX and RX completion rings.  These pointers are allocated during
ring initialization.  Currntly, we support up to 2 completion rings
for each MSIX.  In order to support more completion rings, we change
this fixed array to a pointer and allocate the required entries
during ring initialization.  This patch keeps the current scheme of
allocating only 2 entries when needed.  Later patches will expand
and allocate more entries when required.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 134 ++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 3 files changed, 66 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4dfe0b66c5f7..585120369935 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2834,14 +2834,11 @@ static int __bnxt_poll_cqs(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 	int i, work_done = 0;
 
-	for (i = 0; i < 2; i++) {
-		struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[i];
+	for (i = 0; i < cpr->cp_ring_count; i++) {
+		struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[i];
 
-		if (cpr2) {
-			work_done += __bnxt_poll_work(bp, cpr2,
-						      budget - work_done);
-			cpr->has_more_work |= cpr2->has_more_work;
-		}
+		work_done += __bnxt_poll_work(bp, cpr2, budget - work_done);
+		cpr->has_more_work |= cpr2->has_more_work;
 	}
 	return work_done;
 }
@@ -2852,11 +2849,11 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
 	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 	int i;
 
-	for (i = 0; i < 2; i++) {
-		struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[i];
+	for (i = 0; i < cpr->cp_ring_count; i++) {
+		struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[i];
 		struct bnxt_db_info *db;
 
-		if (cpr2 && cpr2->had_work_done) {
+		if (cpr2->had_work_done) {
 			db = &cpr2->cp_db;
 			bnxt_writeq(bp, db->db_key64 | dbr_type |
 				    RING_CMP(cpr2->cp_raw_cons), db->doorbell);
@@ -2915,7 +2912,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 			if (budget && work_done >= budget && idx == BNXT_RX_HDL)
 				break;
 
-			cpr2 = cpr->cp_ring_arr[idx];
+			cpr2 = &cpr->cp_ring_arr[idx];
 			work_done += __bnxt_poll_work(bp, cpr2,
 						      budget - work_done);
 			cpr->has_more_work |= cpr2->has_more_work;
@@ -2930,8 +2927,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
 		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
 	}
 poll_done:
-	cpr_rx = cpr->cp_ring_arr[BNXT_RX_HDL];
-	if (cpr_rx && (bp->flags & BNXT_FLAG_DIM)) {
+	cpr_rx = &cpr->cp_ring_arr[BNXT_RX_HDL];
+	if (cpr_rx->bnapi && (bp->flags & BNXT_FLAG_DIM)) {
 		struct dim_sample dim_sample = {};
 
 		dim_update_sample(cpr->event_ctr,
@@ -3541,36 +3538,33 @@ static void bnxt_free_cp_rings(struct bnxt *bp)
 
 		bnxt_free_ring(bp, &ring->ring_mem);
 
-		for (j = 0; j < 2; j++) {
-			struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[j];
+		if (!cpr->cp_ring_arr)
+			continue;
 
-			if (cpr2) {
-				ring = &cpr2->cp_ring_struct;
-				bnxt_free_ring(bp, &ring->ring_mem);
-				bnxt_free_cp_arrays(cpr2);
-				kfree(cpr2);
-				cpr->cp_ring_arr[j] = NULL;
-			}
+		for (j = 0; j < cpr->cp_ring_count; j++) {
+			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+
+			ring = &cpr2->cp_ring_struct;
+			bnxt_free_ring(bp, &ring->ring_mem);
+			bnxt_free_cp_arrays(cpr2);
 		}
+		kfree(cpr->cp_ring_arr);
+		cpr->cp_ring_arr = NULL;
+		cpr->cp_ring_count = 0;
 	}
 }
 
-static struct bnxt_cp_ring_info *bnxt_alloc_cp_sub_ring(struct bnxt *bp)
+static int bnxt_alloc_cp_sub_ring(struct bnxt *bp,
+				  struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_mem_info *rmem;
 	struct bnxt_ring_struct *ring;
-	struct bnxt_cp_ring_info *cpr;
 	int rc;
 
-	cpr = kzalloc(sizeof(*cpr), GFP_KERNEL);
-	if (!cpr)
-		return NULL;
-
 	rc = bnxt_alloc_cp_arrays(cpr, bp->cp_nr_pages);
 	if (rc) {
 		bnxt_free_cp_arrays(cpr);
-		kfree(cpr);
-		return NULL;
+		return -ENOMEM;
 	}
 	ring = &cpr->cp_ring_struct;
 	rmem = &ring->ring_mem;
@@ -3583,10 +3577,8 @@ static struct bnxt_cp_ring_info *bnxt_alloc_cp_sub_ring(struct bnxt *bp)
 	if (rc) {
 		bnxt_free_ring(bp, rmem);
 		bnxt_free_cp_arrays(cpr);
-		kfree(cpr);
-		cpr = NULL;
 	}
-	return cpr;
+	return rc;
 }
 
 static int bnxt_alloc_cp_rings(struct bnxt *bp)
@@ -3598,7 +3590,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 	ulp_base_vec = bnxt_get_ulp_msix_base(bp);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
-		struct bnxt_cp_ring_info *cpr;
+		struct bnxt_cp_ring_info *cpr, *cpr2;
 		struct bnxt_ring_struct *ring;
 
 		if (!bnapi)
@@ -3620,23 +3612,27 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 		if (!(bp->flags & BNXT_FLAG_CHIP_P5))
 			continue;
 
-		if (i < bp->rx_nr_rings) {
-			struct bnxt_cp_ring_info *cpr2 =
-				bnxt_alloc_cp_sub_ring(bp);
+		cpr->cp_ring_count = 2;
+		cpr->cp_ring_arr = kcalloc(cpr->cp_ring_count, sizeof(*cpr),
+					   GFP_KERNEL);
+		if (!cpr->cp_ring_arr) {
+			cpr->cp_ring_count = 0;
+			return -ENOMEM;
+		}
 
-			cpr->cp_ring_arr[BNXT_RX_HDL] = cpr2;
-			if (!cpr2)
-				return -ENOMEM;
+		if (i < bp->rx_nr_rings) {
+			cpr2 = &cpr->cp_ring_arr[BNXT_RX_HDL];
+			rc = bnxt_alloc_cp_sub_ring(bp, cpr2);
+			if (rc)
+				return rc;
 			cpr2->bnapi = bnapi;
 		}
 		if ((sh && i < bp->tx_nr_rings) ||
 		    (!sh && i >= bp->rx_nr_rings)) {
-			struct bnxt_cp_ring_info *cpr2 =
-				bnxt_alloc_cp_sub_ring(bp);
-
-			cpr->cp_ring_arr[BNXT_TX_HDL] = cpr2;
-			if (!cpr2)
-				return -ENOMEM;
+			cpr2 = &cpr->cp_ring_arr[BNXT_TX_HDL];
+			rc = bnxt_alloc_cp_sub_ring(bp, cpr2);
+			if (rc)
+				return rc;
 			cpr2->bnapi = bnapi;
 		}
 	}
@@ -3822,11 +3818,10 @@ static void bnxt_init_cp_rings(struct bnxt *bp)
 		ring->fw_ring_id = INVALID_HW_RING_ID;
 		cpr->rx_ring_coal.coal_ticks = bp->rx_coal.coal_ticks;
 		cpr->rx_ring_coal.coal_bufs = bp->rx_coal.coal_bufs;
-		for (j = 0; j < 2; j++) {
-			struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[j];
-
-			if (!cpr2)
-				continue;
+		if (!cpr->cp_ring_arr)
+			continue;
+		for (j = 0; j < cpr->cp_ring_count; j++) {
+			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
 
 			ring = &cpr2->cp_ring_struct;
 			ring->fw_ring_id = INVALID_HW_RING_ID;
@@ -5251,7 +5246,7 @@ static u16 bnxt_cp_ring_for_rx(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 		struct bnxt_napi *bnapi = rxr->bnapi;
 		struct bnxt_cp_ring_info *cpr;
 
-		cpr = bnapi->cp_ring.cp_ring_arr[BNXT_RX_HDL];
+		cpr = &bnapi->cp_ring.cp_ring_arr[BNXT_RX_HDL];
 		return cpr->cp_ring_struct.fw_ring_id;
 	} else {
 		return bnxt_cp_ring_from_grp(bp, &rxr->rx_ring_struct);
@@ -5264,7 +5259,7 @@ static u16 bnxt_cp_ring_for_tx(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
 		struct bnxt_napi *bnapi = txr->bnapi;
 		struct bnxt_cp_ring_info *cpr;
 
-		cpr = bnapi->cp_ring.cp_ring_arr[BNXT_TX_HDL];
+		cpr = &bnapi->cp_ring.cp_ring_arr[BNXT_TX_HDL];
 		return cpr->cp_ring_struct.fw_ring_id;
 	} else {
 		return bnxt_cp_ring_from_grp(bp, &txr->tx_ring_struct);
@@ -6032,7 +6027,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 
 			cpr = &bnapi->cp_ring;
-			cpr2 = cpr->cp_ring_arr[BNXT_TX_HDL];
+			cpr2 = &cpr->cp_ring_arr[BNXT_TX_HDL];
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_TX_HDL;
 			map_idx = bnapi->index;
@@ -6071,7 +6066,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
 			struct bnxt_cp_ring_info *cpr2;
 
-			cpr2 = cpr->cp_ring_arr[BNXT_RX_HDL];
+			cpr2 = &cpr->cp_ring_arr[BNXT_RX_HDL];
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_RX_HDL;
 			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
@@ -6218,18 +6213,16 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		struct bnxt_ring_struct *ring;
 		int j;
 
-		for (j = 0; j < 2; j++) {
-			struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[j];
-
-			if (cpr2) {
-				ring = &cpr2->cp_ring_struct;
-				if (ring->fw_ring_id == INVALID_HW_RING_ID)
-					continue;
-				hwrm_ring_free_send_msg(bp, ring,
-					RING_FREE_REQ_RING_TYPE_L2_CMPL,
-					INVALID_HW_RING_ID);
-				ring->fw_ring_id = INVALID_HW_RING_ID;
-			}
+		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
+			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+
+			ring = &cpr2->cp_ring_struct;
+			if (ring->fw_ring_id == INVALID_HW_RING_ID)
+				continue;
+			hwrm_ring_free_send_msg(bp, ring,
+						RING_FREE_REQ_RING_TYPE_L2_CMPL,
+						INVALID_HW_RING_ID);
+			ring->fw_ring_id = INVALID_HW_RING_ID;
 		}
 		ring = &cpr->cp_ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
@@ -12005,12 +11998,11 @@ static void bnxt_chk_missed_irq(struct bnxt *bp)
 			continue;
 
 		cpr = &bnapi->cp_ring;
-		for (j = 0; j < 2; j++) {
-			struct bnxt_cp_ring_info *cpr2 = cpr->cp_ring_arr[j];
+		for (j = 0; j < cpr->cp_ring_count; j++) {
+			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
 			u32 val[2];
 
-			if (!cpr2 || cpr2->has_more_work ||
-			    !bnxt_has_work(bp, cpr2))
+			if (cpr2->has_more_work || !bnxt_has_work(bp, cpr2))
 				continue;
 
 			if (cpr2->cp_raw_cons != cpr2->last_cp_raw_cons) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index cf22aae91f70..429df1cf4a6a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1019,7 +1019,8 @@ struct bnxt_cp_ring_info {
 
 	struct bnxt_ring_struct	cp_ring_struct;
 
-	struct bnxt_cp_ring_info *cp_ring_arr[2];
+	int			cp_ring_count;
+	struct bnxt_cp_ring_info *cp_ring_arr;
 #define BNXT_RX_HDL	0
 #define BNXT_TX_HDL	1
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f3f384773ac0..675e37700289 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3941,7 +3941,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5)
-		cpr = cpr->cp_ring_arr[BNXT_RX_HDL];
+		cpr = &cpr->cp_ring_arr[BNXT_RX_HDL];
 	pkt_size = min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
-- 
2.30.1


--00000000000057ba950608bafae2
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJRj5SQhqk2Mg1+/QVBWuT2TS6nsCWo2
6GwpImctwh8fMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
NzIzMjMzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC1oOp0ZQOVNhPpy8dzsGXtxNzICaqRlvafXy5CoSOjv/jmH4Mi
G938EcWKdFKAwzW4iRGNRfg+MCnyW32jeZaLE466vCMEV3tXuPsYH13/EUtqsF21V4PIxNhtN6C4
fMy+oQ2XvGsH8rB2SMdk/S8ndqYewVK2Ple/ScIzoFUsZlDB2EYS5vIctXIDJyuIlRTzlzDCA7Uy
IWnGT+SVoVpz0f7B4lnJqTIYOfa9WaMs8OlHbePU7VUCuKnX9yjhwX0JPwiKOU1iSc1kEGiKuYUQ
y7qiCV6nIxJSE/SA2Fmi6Q8Fk20Kd5LeKZb+dU1j97xOC4pX6y17JocW/MoQaH8v
--00000000000057ba950608bafae2--

