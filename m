Return-Path: <netdev+bounces-107010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C29187B8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D228928B926
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C9190066;
	Wed, 26 Jun 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IOdMvZa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE44190048
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420229; cv=none; b=c/uqYKS7bjd+SkE3i2KmzbrImBZYQELPCNAl/Nn5h+PvUgVSys/woYC2LgzMQZA4r9Q+iUdKxt2TEi0TbGtmPp2byfPG/beXIq53ZYFJce9OYCTrpGY54hlmkMC33SPV0wCixNvJSkY+/jYrIIcHI1Xij5HZz/pHYQSxiyerMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420229; c=relaxed/simple;
	bh=sJStlnB9fWAEGYpCSoEKaJayVhNaFjOGHDwgVAWaBNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qirwYHnZcffemug41pVhjSzAr6QNNq9bMoRXx5VBK6G/4bAyNAmGeIlbLpF9iiiNfzfNkiICAF5164r9rF1MbRqXU0EbTOmrnDY/vinEyDh5I0FxQVyKn9lduoN+P6SAdZqFV6zWvqOs6CKQ37FR6qluc8gNjKg9k2xkKtrx2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IOdMvZa/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79c0c19ff02so170674885a.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719420227; x=1720025027; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hEYwL9Fupc00iZDfi/Asu3b+s07hnOP4btyY4Rsc18=;
        b=IOdMvZa/qyy225COwVlVJevzXTkp23fHosqDanjJusYjTdh6K3KyE58gh5cwQ4I9eQ
         fI2rsSxxMDOpsKwAZ5qMp21PzWl0SbuKJKYpTdzK1+dZPofWnl0lQFRk9Vt0v4Mvbslx
         ai8OJr70JtLtP1OvB4OQH+EeeFXPO0b1bvjt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420227; x=1720025027;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hEYwL9Fupc00iZDfi/Asu3b+s07hnOP4btyY4Rsc18=;
        b=R1sS31vbjmRj7rb6XlE1Pa4+TfkiPnPKlk797QdwW+cBg/tbFFOXX/REdqF930Iibg
         3hpdGQDrU48tztFsTj0X2O2OLbGIVnp4R09cIpkEvq/A9FqYxLu0i1MRPV6zRXI3bCAJ
         cA6a7nGfDHwuoJ8wcyGV6i9eQBFSC7IktVMVxUNTGKloGV5LERq7xFaCLWIcHCi5Di0g
         WMbRKma1/5EXWA7nRpzC8lkqaNcz3G/VvN621/4PxMD8YJ0tufkSUelIF82eFbULUm9q
         YjM8KczGAEPfEWbhmGqf05jqmPAsRd3y8+1aFfLrA/RJ2ObCNySQcsWSCi04sIoUC4Xj
         MCIw==
X-Gm-Message-State: AOJu0YyYsLox7y+yCVMCdC3Q7KDkU3KEgVjZ9MKsbJu/j/XApzijCpOI
	XDhIoOD9Y/q91yO2yQzlJsdLSwHBiyhIRpc1sATtSQyYtjQ1zZEWnU5G771L+Q==
X-Google-Smtp-Source: AGHT+IE0+SSXYEZT7cNEnooLGTr36Q/WJj60azfBzlTY4qF/arh2Bmf8fCdm+j1mOZ58ng9Z+nBmxA==
X-Received: by 2002:a05:620a:400a:b0:795:f319:e4a5 with SMTP id af79cd13be357-79be6f23dd1mr1310009985a.66.1719420226301;
        Wed, 26 Jun 2024 09:43:46 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d53c42aafsm53570485a.58.2024.06.26.09.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:43:45 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 09/10] bnxt_en: Increase the max total outstanding PTP TX packets to 4
Date: Wed, 26 Jun 2024 09:43:06 -0700
Message-ID: <20240626164307.219568-10-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240626164307.219568-1-michael.chan@broadcom.com>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000df9006061bcdb702"

--000000000000df9006061bcdb702
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Start accepting up to 4 TX TS requests on BCM5750X (P5) chips.
These PTP TX packets will be queued in the ptp->txts_req[] array
waiting for the TX timestamp to complete.  The entries in the
array will be managed by a producer and consumer index.  The
producer index is updated under spinlock since multiple TX rings
can try to send PTP packets at the same time.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 60 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 13 ++--
 4 files changed, 68 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ed2bbdf6b25f..0867861c14bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -457,8 +457,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int length, pad = 0;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	u16 prod, last_frag;
 	struct pci_dev *pdev = bp->pdev;
+	u16 prod, last_frag, txts_prod;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
@@ -526,11 +526,19 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
 				if (vlan_tag_flags)
 					hdr_off += VLAN_HLEN;
-				ptp->txts_req.tx_seqid = seq_id;
-				ptp->txts_req.tx_hdr_off = hdr_off;
 				lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
 				tx_buf->is_ts_pkt = 1;
 				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+				spin_lock_bh(&ptp->ptp_tx_lock);
+				txts_prod = ptp->txts_prod;
+				ptp->txts_prod = NEXT_TXTS(txts_prod);
+				spin_unlock_bh(&ptp->ptp_tx_lock);
+
+				ptp->txts_req[txts_prod].tx_seqid = seq_id;
+				ptp->txts_req[txts_prod].tx_hdr_off = hdr_off;
+				tx_buf->txts_prod = txts_prod;
+
 			} else {
 				atomic_inc(&bp->ptp_cfg->tx_avail);
 			}
@@ -770,7 +778,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 tx_kick_pending:
 	if (BNXT_TX_PTP_IS_SET(lflags)) {
 		atomic64_inc(&bp->ptp_cfg->stats.ts_err);
-		atomic_inc(&bp->ptp_cfg->tx_avail);
+		if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
+			/* set SKB to err so PTP worker will clean up */
+			ptp->txts_req[txts_prod].tx_skb = ERR_PTR(-EIO);
 	}
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
@@ -838,7 +848,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
-				bnxt_get_tx_ts_p5(bp, skb);
+				bnxt_get_tx_ts_p5(bp, skb, tx_buf->txts_prod);
 				skb = NULL;
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 82b05641953f..e46bd11e52b0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -878,7 +878,10 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			action;
 	unsigned short		nr_frags;
-	u16			rx_prod;
+	union {
+		u16			rx_prod;
+		u16			txts_prod;
+	};
 };
 
 struct bnxt_sw_rx_bd {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index bd1e270307ec..9e93dc8b2b57 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -110,7 +110,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
 }
 
 static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
-				   u32 txts_tmo)
+				   u32 txts_tmo, int slot)
 {
 	struct hwrm_port_ts_query_output *resp;
 	struct hwrm_port_ts_query_input *req;
@@ -123,7 +123,7 @@ static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
 	req->flags = cpu_to_le32(flags);
 	if ((flags & PORT_TS_QUERY_REQ_FLAGS_PATH) ==
 	    PORT_TS_QUERY_REQ_FLAGS_PATH_TX) {
-		struct bnxt_ptp_tx_req *txts_req = &bp->ptp_cfg->txts_req;
+		struct bnxt_ptp_tx_req *txts_req = &bp->ptp_cfg->txts_req[slot];
 		u32 tmo_us = txts_tmo * 1000;
 
 		req->enables = cpu_to_le16(BNXT_PTP_QTS_TX_ENABLES);
@@ -683,7 +683,7 @@ static u64 bnxt_cc_read(const struct cyclecounter *cc)
 	return ns;
 }
 
-static int bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
+static int bnxt_stamp_tx_skb(struct bnxt *bp, int slot)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct skb_shared_hwtstamps timestamp;
@@ -693,13 +693,13 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 	u32 tmo = 0;
 	int rc;
 
-	txts_req = &ptp->txts_req;
-	if (!txts_req->txts_pending)
-		txts_req->abs_txts_tmo = now + msecs_to_jiffies(ptp->txts_tmo);
+	txts_req = &ptp->txts_req[slot];
+	/* make sure bnxt_get_tx_ts_p5() has updated abs_txts_tmo */
+	smp_rmb();
 	if (!time_after_eq(now, txts_req->abs_txts_tmo))
 		tmo = jiffies_to_msecs(txts_req->abs_txts_tmo - now);
 	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts,
-				     tmo);
+				     tmo, slot);
 	if (!rc) {
 		memset(&timestamp, 0, sizeof(timestamp));
 		spin_lock_bh(&ptp->ptp_lock);
@@ -709,10 +709,9 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
 	} else {
-		if (!time_after_eq(jiffies, txts_req->abs_txts_tmo)) {
-			txts_req->txts_pending = true;
+		if (!time_after_eq(jiffies, txts_req->abs_txts_tmo))
 			return -EAGAIN;
-		}
+
 		ptp->stats.ts_lost++;
 		netdev_warn_once(bp->dev,
 				 "TS query for TX timer failed rc = %x\n", rc);
@@ -720,8 +719,6 @@ static int bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 
 	dev_kfree_skb_any(txts_req->tx_skb);
 	txts_req->tx_skb = NULL;
-	atomic_inc(&ptp->tx_avail);
-	txts_req->txts_pending = false;
 
 	return 0;
 }
@@ -732,10 +729,24 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 						ptp_info);
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
+	u16 cons = ptp->txts_cons;
+	u8 num_requests;
 	int rc = 0;
 
-	if (ptp->txts_req.tx_skb)
-		rc = bnxt_stamp_tx_skb(bp, ptp->txts_req.tx_skb);
+	num_requests = BNXT_MAX_TX_TS - atomic_read(&ptp->tx_avail);
+	while (num_requests--) {
+		if (IS_ERR(ptp->txts_req[cons].tx_skb))
+			goto next_slot;
+		if (!ptp->txts_req[cons].tx_skb)
+			break;
+		rc = bnxt_stamp_tx_skb(bp, cons);
+		if (rc == -EAGAIN)
+			break;
+next_slot:
+		atomic_inc(&ptp->tx_avail);
+		cons = NEXT_TXTS(cons);
+	}
+	ptp->txts_cons = cons;
 
 	if (!time_after_eq(now, ptp->next_period)) {
 		if (rc == -EAGAIN)
@@ -756,11 +767,16 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	return HZ;
 }
 
-void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb)
+void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	struct bnxt_ptp_tx_req *txts_req;
 
-	ptp->txts_req.tx_skb = skb;
+	txts_req = &ptp->txts_req[prod];
+	txts_req->abs_txts_tmo = jiffies + msecs_to_jiffies(ptp->txts_tmo);
+	/* make sure abs_txts_tmo is written first */
+	smp_wmb();
+	txts_req->tx_skb = skb;
 	ptp_schedule_worker(ptp->ptp_clock, 0);
 }
 
@@ -958,7 +974,7 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 			return rc;
 	} else {
 		rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_CURRENT_TIME,
-					     &ns, 0);
+					     &ns, 0, 0);
 		if (rc)
 			return rc;
 	}
@@ -1000,6 +1016,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 	atomic_set(&ptp->tx_avail, BNXT_MAX_TX_TS);
 	spin_lock_init(&ptp->ptp_lock);
+	spin_lock_init(&ptp->ptp_tx_lock);
 
 	if (BNXT_PTP_USE_RTC(bp)) {
 		bnxt_ptp_timecounter_init(bp, false);
@@ -1049,6 +1066,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 void bnxt_ptp_clear(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	int i;
 
 	if (!ptp)
 		return;
@@ -1060,9 +1078,11 @@ void bnxt_ptp_clear(struct bnxt *bp)
 	kfree(ptp->ptp_info.pin_config);
 	ptp->ptp_info.pin_config = NULL;
 
-	if (ptp->txts_req.tx_skb) {
-		dev_kfree_skb_any(ptp->txts_req.tx_skb);
-		ptp->txts_req.tx_skb = NULL;
+	for (i = 0; i < BNXT_MAX_TX_TS; i++) {
+		if (ptp->txts_req[i].tx_skb) {
+			dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
+			ptp->txts_req[i].tx_skb = NULL;
+		}
 	}
 
 	bnxt_unmap_ptp_regs(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index ee1709cda47e..a1910ce86cbb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -85,11 +85,13 @@ struct bnxt_ptp_stats {
 	atomic64_t	ts_err;
 };
 
+#define BNXT_MAX_TX_TS		4
+#define NEXT_TXTS(idx)		(((idx) + 1) & (BNXT_MAX_TX_TS - 1))
+
 struct bnxt_ptp_tx_req {
 	struct sk_buff		*tx_skb;
 	u16			tx_seqid;
 	u16			tx_hdr_off;
-	u8			txts_pending:1;
 	unsigned long		abs_txts_tmo;
 };
 
@@ -101,6 +103,8 @@ struct bnxt_ptp_cfg {
 	struct bnxt_pps		pps_info;
 	/* serialize timecounter access */
 	spinlock_t		ptp_lock;
+	/* serialize ts tx request queuing */
+	spinlock_t		ptp_tx_lock;
 	u64			current_time;
 	u64			old_time;
 	unsigned long		next_period;
@@ -109,11 +113,10 @@ struct bnxt_ptp_cfg {
 	/* a 23b shift cyclecounter will overflow in ~36 mins.  Check overflow every 18 mins. */
 	#define BNXT_PHC_OVERFLOW_PERIOD	(18 * 60 * HZ)
 
-	struct bnxt_ptp_tx_req	txts_req;
+	struct bnxt_ptp_tx_req	txts_req[BNXT_MAX_TX_TS];
 
 	struct bnxt		*bp;
 	atomic_t		tx_avail;
-#define BNXT_MAX_TX_TS	1
 	u16			rxctl;
 #define BNXT_PTP_MSG_SYNC			(1 << 0)
 #define BNXT_PTP_MSG_DELAY_REQ			(1 << 1)
@@ -136,6 +139,8 @@ struct bnxt_ptp_cfg {
 	u32			refclk_regs[2];
 	u32			refclk_mapped_regs[2];
 	u32			txts_tmo;
+	u16			txts_prod;
+	u16			txts_cons;
 
 	struct bnxt_ptp_stats	stats;
 };
@@ -159,7 +164,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
-void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb);
+void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
 void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 		    struct tx_ts_cmp *tscmp);
-- 
2.30.1


--000000000000df9006061bcdb702
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEsYMLBRbu8MQf2m7lSoI58IPkz7hNr9
hIlXbywCtm03MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NjE2NDM0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA4tgd4n9AJD08a9baQhgVoGzZwSfVbpJto3I2W6zZtkEvBCwgN
SKPAYGjLfSqlzmEgu2SDEM1xotCDuyhLmJodYjj+4wfMLH3CNGCb/4dz75UPmaz8SbYxLrpYPZVv
EDcd9hiKI4IF72xsxVMc1VAOziP5ceQI2OdCaqFWA3ep593Goj4N7m72HgDvNOy05tQ1sqxUa6KJ
6xJQWVTJXSablbg5r1I2xxm3CR8AS8bBh8nnvfB1C5RzeEAU7hcxNpsSGfDups/+37MegxE4k5og
SJVq2AU1nJbEXduhWbiwg5JKemuQhxpX+txY7Ay8vlsx/j92D0W+TRrFGAs3vYxs
--000000000000df9006061bcdb702--

