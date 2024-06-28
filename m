Return-Path: <netdev+bounces-107803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9191C69D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B521C23727
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF774055;
	Fri, 28 Jun 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N71QAi6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424377F0B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603038; cv=none; b=eAMQzATf0TBqMjc6GN5pK+bTliD86int8FLrh5tPGxuc5pce4NxgfmBzMtdYFWdlA5X9su0tyOR7OsRBsS/I0hJrNmH2vHDBu40ekYayWUA0yqmetl8LOGbvDEzFh/1NnpA8KjyVSJW2RWWdqf/fdOJU+BFdhUCiR6QgvHsOgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603038; c=relaxed/simple;
	bh=phWq9+E8b/rBPTtpUEUTpkKODuNyAVwAsDEgrTt/9DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu7RibiGfMwnCi4f095qxtVP8My4PgUB3gqutwsK050s0C4WA3ztKTlZRrazlkuhKsp1fge+iWWuQOTVxOLEnevI5ASaa3QNBxJz0qQ2PlJ/M+ol/7Kj14eZAdUqfi5gKCgWWrXHi9c2r9Q0hZ4IjysdbEPYmHMF/zHdphtirII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N71QAi6/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c7dff0f4e4so751004a91.2
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719603036; x=1720207836; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSoxhhNw4sseVVSmxw8RUhhBGIv6U49DIQOjLo1vmmk=;
        b=N71QAi6/zG1xHbLGpdH+8HodrVCASvd/z5BHLWWOlTD6/tJrGBWY7XMjlkw8blfsbX
         mtWr/3xee5XVHSbpmG8Z2GWFjFModJoBcRpb8K2NGrTAGy379fScgiS5Bn5kGpOqtCsO
         g7VV/RlNoh1Gt4pzVcIIMvtW6eVvtPSuhIEXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603036; x=1720207836;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSoxhhNw4sseVVSmxw8RUhhBGIv6U49DIQOjLo1vmmk=;
        b=Rv0IjkRmU783MMslVgAyj1yhE/irYVCqBJt9l/oKJcmq4N985SOPrQZKb7CtNHH+ql
         0EGwz/fzuIY0wFyEYukCuu1PcVypt00YIjrGq3ia2JK8rYSNFF5i5JtQw/MoeYM9XsKk
         Uk1xpBQkGr/krilnAGis6osFMUFqUdutRZzls1MXEUIWtXfgxmMEcG1E+e13wNs2wFVX
         IvCuPq//i9yATgK7gOsiGmsiCeBWVKTFllnRiEy/gTPqMwUvNPFomFey6fm77LYtSCov
         jXYGqBtqJ9/EfSmG9EVupha3eNc3SqN9yuwv16OpdI3BWALC7G7rn8og04j7xei4IFSB
         2lpQ==
X-Gm-Message-State: AOJu0YzcV8avL8NS7MusOvPnfhJQm116FjZP31YR61Jye4eGqsc/m/vM
	Ed8P/v800VhbmaP2LaTXNE/uSq1F9nex1zw8B5sdQxrfzdEZxOEni3OBYUQeqg==
X-Google-Smtp-Source: AGHT+IGCpNmoVLxioPgSc9AhtsV/N/YOC7jYUTIqou8GbnZ6j6foNaI7SXmAZChjUJk5XUo9mzb4Ww==
X-Received: by 2002:a17:90a:6881:b0:2c2:cfd1:768b with SMTP id 98e67ed59e1d1-2c8612a229fmr14267913a91.12.1719603035514;
        Fri, 28 Jun 2024 12:30:35 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c939cc9b04sm46707a91.0.2024.06.28.12.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:30:35 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/10] bnxt_en: Refactor all PTP TX timestamp fields into a struct
Date: Fri, 28 Jun 2024 12:30:01 -0700
Message-ID: <20240628193006.225906-7-michael.chan@broadcom.com>
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
	boundary="00000000000021d79b061bf8483b"

--00000000000021d79b061bf8483b
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

On the older 5750X (P5) chips, we currently support only 1 TX PTP
packet in-flight waiting for the timestamp.  Refactor the
datastructures to prepare to support up to 4 TX PTP packets.

Combine all fields required for PTP TX timestamp query into one
structure.  An array of this structure will be added in follow-on
patches to support multiple outstanding TX timestamps.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 10 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 43 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 15 ++++---
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f900bbbb7498..a9741faa960c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -517,14 +517,18 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			tx_buf->is_ts_pkt = 1;
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 		} else if (!skb_is_gso(skb)) {
+			u16 seq_id, hdr_off;
+
 			if (atomic_dec_if_positive(&ptp->tx_avail) < 0) {
 				atomic64_inc(&ptp->stats.ts_err);
 				goto tx_no_ts;
 			}
-			if (!bnxt_ptp_parse(skb, &ptp->tx_seqid,
-					    &ptp->tx_hdr_off)) {
+
+			if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
 				if (vlan_tag_flags)
-					ptp->tx_hdr_off += VLAN_HLEN;
+					hdr_off += VLAN_HLEN;
+				ptp->txts_req.tx_seqid = seq_id;
+				ptp->txts_req.tx_hdr_off = hdr_off;
 				lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
 				tx_buf->is_ts_pkt = 1;
 				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a3795ef8887d..8431cd0ed9e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -123,11 +123,12 @@ static int bnxt_hwrm_port_ts_query(struct bnxt *bp, u32 flags, u64 *ts,
 	req->flags = cpu_to_le32(flags);
 	if ((flags & PORT_TS_QUERY_REQ_FLAGS_PATH) ==
 	    PORT_TS_QUERY_REQ_FLAGS_PATH_TX) {
+		struct bnxt_ptp_tx_req *txts_req = &bp->ptp_cfg->txts_req;
 		u32 tmo_us = txts_tmo * 1000;
 
 		req->enables = cpu_to_le16(BNXT_PTP_QTS_TX_ENABLES);
-		req->ptp_seq_id = cpu_to_le32(bp->ptp_cfg->tx_seqid);
-		req->ptp_hdr_offset = cpu_to_le16(bp->ptp_cfg->tx_hdr_off);
+		req->ptp_seq_id = cpu_to_le32(txts_req->tx_seqid);
+		req->ptp_hdr_offset = cpu_to_le16(txts_req->tx_hdr_off);
 		if (!tmo_us)
 			tmo_us = BNXT_PTP_QTS_TIMEOUT;
 		tmo_us = min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);
@@ -686,15 +687,17 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct skb_shared_hwtstamps timestamp;
+	struct bnxt_ptp_tx_req *txts_req;
 	unsigned long now = jiffies;
 	u64 ts = 0, ns = 0;
 	u32 tmo = 0;
 	int rc;
 
-	if (!ptp->txts_pending)
-		ptp->abs_txts_tmo = now + msecs_to_jiffies(ptp->txts_tmo);
-	if (!time_after_eq(now, ptp->abs_txts_tmo))
-		tmo = jiffies_to_msecs(ptp->abs_txts_tmo - now);
+	txts_req = &ptp->txts_req;
+	if (!txts_req->txts_pending)
+		txts_req->abs_txts_tmo = now + msecs_to_jiffies(ptp->txts_tmo);
+	if (!time_after_eq(now, txts_req->abs_txts_tmo))
+		tmo = jiffies_to_msecs(txts_req->abs_txts_tmo - now);
 	rc = bnxt_hwrm_port_ts_query(bp, PORT_TS_QUERY_REQ_FLAGS_PATH_TX, &ts,
 				     tmo);
 	if (!rc) {
@@ -703,11 +706,11 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		ns = timecounter_cyc2time(&ptp->tc, ts);
 		spin_unlock_bh(&ptp->ptp_lock);
 		timestamp.hwtstamp = ns_to_ktime(ns);
-		skb_tstamp_tx(ptp->tx_skb, &timestamp);
+		skb_tstamp_tx(txts_req->tx_skb, &timestamp);
 		ptp->stats.ts_pkts++;
 	} else {
-		if (!time_after_eq(jiffies, ptp->abs_txts_tmo)) {
-			ptp->txts_pending = true;
+		if (!time_after_eq(jiffies, txts_req->abs_txts_tmo)) {
+			txts_req->txts_pending = true;
 			return;
 		}
 		ptp->stats.ts_lost++;
@@ -715,10 +718,10 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 				 "TS query for TX timer failed rc = %x\n", rc);
 	}
 
-	dev_kfree_skb_any(ptp->tx_skb);
-	ptp->tx_skb = NULL;
+	dev_kfree_skb_any(txts_req->tx_skb);
+	txts_req->tx_skb = NULL;
 	atomic_inc(&ptp->tx_avail);
-	ptp->txts_pending = false;
+	txts_req->txts_pending = false;
 }
 
 static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
@@ -728,8 +731,8 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
 
-	if (ptp->tx_skb)
-		bnxt_stamp_tx_skb(bp, ptp->tx_skb);
+	if (ptp->txts_req.tx_skb)
+		bnxt_stamp_tx_skb(bp, ptp->txts_req.tx_skb);
 
 	if (!time_after_eq(now, ptp->next_period))
 		return ptp->next_period - now;
@@ -742,7 +745,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 		spin_unlock_bh(&ptp->ptp_lock);
 		ptp->next_overflow_check = now + BNXT_PHC_OVERFLOW_PERIOD;
 	}
-	if (ptp->txts_pending)
+	if (ptp->txts_req.txts_pending)
 		return 0;
 	return HZ;
 }
@@ -751,11 +754,11 @@ int bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
-	if (ptp->tx_skb) {
+	if (ptp->txts_req.tx_skb) {
 		netdev_err(bp->dev, "deferring skb:one SKB is still outstanding\n");
 		return -EBUSY;
 	}
-	ptp->tx_skb = skb;
+	ptp->txts_req.tx_skb = skb;
 	ptp_schedule_worker(ptp->ptp_clock, 0);
 	return 0;
 }
@@ -1056,9 +1059,9 @@ void bnxt_ptp_clear(struct bnxt *bp)
 	kfree(ptp->ptp_info.pin_config);
 	ptp->ptp_info.pin_config = NULL;
 
-	if (ptp->tx_skb) {
-		dev_kfree_skb_any(ptp->tx_skb);
-		ptp->tx_skb = NULL;
+	if (ptp->txts_req.tx_skb) {
+		dev_kfree_skb_any(ptp->txts_req.tx_skb);
+		ptp->txts_req.tx_skb = NULL;
 	}
 
 	bnxt_unmap_ptp_regs(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index d38c3500827f..90f1418211e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -85,6 +85,14 @@ struct bnxt_ptp_stats {
 	atomic64_t	ts_err;
 };
 
+struct bnxt_ptp_tx_req {
+	struct sk_buff		*tx_skb;
+	u16			tx_seqid;
+	u16			tx_hdr_off;
+	u8			txts_pending:1;
+	unsigned long		abs_txts_tmo;
+};
+
 struct bnxt_ptp_cfg {
 	struct ptp_clock_info	ptp_info;
 	struct ptp_clock	*ptp_clock;
@@ -93,7 +101,6 @@ struct bnxt_ptp_cfg {
 	struct bnxt_pps		pps_info;
 	/* serialize timecounter access */
 	spinlock_t		ptp_lock;
-	struct sk_buff		*tx_skb;
 	u64			current_time;
 	u64			old_time;
 	unsigned long		next_period;
@@ -102,8 +109,8 @@ struct bnxt_ptp_cfg {
 	/* a 23b shift cyclecounter will overflow in ~36 mins.  Check overflow every 18 mins. */
 	#define BNXT_PHC_OVERFLOW_PERIOD	(18 * 60 * HZ)
 
-	u16			tx_seqid;
-	u16			tx_hdr_off;
+	struct bnxt_ptp_tx_req	txts_req;
+
 	struct bnxt		*bp;
 	atomic_t		tx_avail;
 #define BNXT_MAX_TX_TS	1
@@ -123,14 +130,12 @@ struct bnxt_ptp_cfg {
 					 BNXT_PTP_MSG_PDELAY_REQ |	\
 					 BNXT_PTP_MSG_PDELAY_RESP)
 	u8			tx_tstamp_en:1;
-	u8			txts_pending:1;
 	int			rx_filter;
 	u32			tstamp_filters;
 
 	u32			refclk_regs[2];
 	u32			refclk_mapped_regs[2];
 	u32			txts_tmo;
-	unsigned long		abs_txts_tmo;
 
 	struct bnxt_ptp_stats	stats;
 };
-- 
2.30.1


--00000000000021d79b061bf8483b
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIV6Pz+KSPXA/wWrhm95EHAayGE2BNXV
joCyN/S/pzfgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE5MzAzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCGdBlMGufuxLrsuXooXPo3AuHw0o5iSXeERezGyzDwfXdzONfP
s5omFZUZeJIIMrNACIurZOXBENjkMv6T6n5oQH3sXtx6RljTfs2/PNMcSXQJet27I36txswQO6O/
Rj/Cb7T5op4LcqxV3MO9QfcpiBbRLQj43uOfoxNi01t8p1mu+XUbWMhNQdnaDvFX/rx8Zo/yJ+x2
QTgE2D4VPa1UKW6MRNBzGKluy2SvKFB7SabC0uhuAgCtewuO2UKUGsmeygBxSKfgsO4x1RpXr5PF
OP5iyvgYQjc9b92yBum1mQDGtMFk3Razw8t19XvmXXkyCJYEewAHBewgnO3TO05l
--00000000000021d79b061bf8483b--

