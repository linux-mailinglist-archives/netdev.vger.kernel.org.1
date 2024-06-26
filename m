Return-Path: <netdev+bounces-107011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0E9187B9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C31C21086
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BFC18FC8B;
	Wed, 26 Jun 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kr7hBLq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3119005C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420231; cv=none; b=MLbr9wDW1ZUjLaH5VGz0YywHWktjIr05xEu20tGFZ4DhdtvKGIfDbutsFyMCHpNdrUvl254gHHHc0MoVT6/phVeCyzYF4RCXFmRuR1vj4PfI70aU8mIGx8l6RX7Uj6d4bJQD7fpegwJcyPhUkq6qVEfnoSlLyY3Egrs411NQ+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420231; c=relaxed/simple;
	bh=TYZihhcJLI9Jc2q8IoZj+IrpCL17UkK/hF5iG/wr9iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzvyu5qAbR/Ibq+tqMeuOczlR1F0BZfw95I282wkvAmR9QyFJtmES9v4BAAm50T4SKctkkncs6uExNWm6GtZsdnd/bvBBMUkLokQ+cvmdVjtC1XoDnjHBy6vbdbdO/p13FM8rWNd7jPF01C6It0kk/SfV/KQjkUGKNtKm01Sbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kr7hBLq5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c03dbddb8so213240485a.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719420229; x=1720025029; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJTGUEIo8u1qOej4wyadsnCa5VyT8DqBoHdj7C7oF7k=;
        b=Kr7hBLq5+Pqd0tYiRZXhX5foM/yxbFTOZHcFktZBhXJykwAhm7BvMTn04AR2wxOtBc
         eAtsd7jJOihyx57rjHu4/9lvNX+wDEMTWAbpcuJbQSgOzK11oar0iWnC5rSHyzGgDkMk
         Re0/1UM2dUEfeKAINFkMuUGno3LaLFWK7nGvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420229; x=1720025029;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJTGUEIo8u1qOej4wyadsnCa5VyT8DqBoHdj7C7oF7k=;
        b=HaCuU2KmHfsPabXG22fBr1dkg5EQySWjYQcahRgeber2z1hZ2PYV2gHIwd50gxCfxQ
         3UFru/maT2Ox8zEbOoJbxHaXsyKvQxFhnP/9INR83DWElKDUnYGz1DiedTO1pe8r/Jq6
         FJ6eZ9YGvq0QAIw0Gkj3a56Wmq8i88vfoVNFlG89PcKtGHKEZhJ+y4hfAGDL8zrF4ceA
         v1/W5rbNCP2LwZuH7CH3FzHTFvPIohfyzo8EqeACR6Em6U21aMEt+SqwIGU8S4AEYY3/
         rb2HWGOe/2we3pmR9PO4eNmCM1w8zgg6DKBH9fW4jRxl0GaI40gL8DFw6Kv2OPV6mMBb
         3RQQ==
X-Gm-Message-State: AOJu0YzGf7xfYrS85SNks8Hk4wqAKgWWpn2griZLNwGQ4ErzcXNMLTy0
	B7lldtTQPTfgi8w5jLhFOC59ajubt124A7PBSvXgd2PU8nOr1GUkSeth+qnu2A==
X-Google-Smtp-Source: AGHT+IEd6IAO41h/+sp57VuozyNBm8RrPqtxSFFSmOrj63uAC5pMB9pmrrey7JKDqvlpJQ1DUQ3FOw==
X-Received: by 2002:a05:620a:2951:b0:79d:5a77:aea8 with SMTP id af79cd13be357-79d5a77b290mr3419785a.1.1719420228554;
        Wed, 26 Jun 2024 09:43:48 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d53c42aafsm53570485a.58.2024.06.26.09.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:43:47 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 10/10] bnxt_en: Remove atomic operations on ptp->tx_avail
Date: Wed, 26 Jun 2024 09:43:07 -0700
Message-ID: <20240626164307.219568-11-michael.chan@broadcom.com>
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
	boundary="000000000000fad34c061bcdb7a4"

--000000000000fad34c061bcdb7a4
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Now that we require the spinlock to protect ptp->txts_prod, change
ptp->tx_avail to non-atomic and protect it under the same spinlock.
Add a new helper function bnxt_ptp_get_txts_prod() to decrement
ptp->tx_avail under spinlock and return the producer.

Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 20 +++-------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 10 +++++++-
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0867861c14bd..33ba1964168b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -518,34 +518,20 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		} else if (!skb_is_gso(skb)) {
 			u16 seq_id, hdr_off;
 
-			if (atomic_dec_if_positive(&ptp->tx_avail) < 0) {
-				atomic64_inc(&ptp->stats.ts_err);
-				goto tx_no_ts;
-			}
-
-			if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
+			if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off) &&
+			    !bnxt_ptp_get_txts_prod(ptp, &txts_prod)) {
 				if (vlan_tag_flags)
 					hdr_off += VLAN_HLEN;
 				lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
 				tx_buf->is_ts_pkt = 1;
 				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-				spin_lock_bh(&ptp->ptp_tx_lock);
-				txts_prod = ptp->txts_prod;
-				ptp->txts_prod = NEXT_TXTS(txts_prod);
-				spin_unlock_bh(&ptp->ptp_tx_lock);
-
 				ptp->txts_req[txts_prod].tx_seqid = seq_id;
 				ptp->txts_req[txts_prod].tx_hdr_off = hdr_off;
 				tx_buf->txts_prod = txts_prod;
-
-			} else {
-				atomic_inc(&bp->ptp_cfg->tx_avail);
 			}
 		}
 	}
-
-tx_no_ts:
 	if (unlikely(skb->no_fcs))
 		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
 
@@ -12184,7 +12170,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
 	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
-		atomic_set(&bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
+		WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 9e93dc8b2b57..37d42423459c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -730,10 +730,10 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	unsigned long now = jiffies;
 	struct bnxt *bp = ptp->bp;
 	u16 cons = ptp->txts_cons;
-	u8 num_requests;
+	u32 num_requests;
 	int rc = 0;
 
-	num_requests = BNXT_MAX_TX_TS - atomic_read(&ptp->tx_avail);
+	num_requests = BNXT_MAX_TX_TS - READ_ONCE(ptp->tx_avail);
 	while (num_requests--) {
 		if (IS_ERR(ptp->txts_req[cons].tx_skb))
 			goto next_slot;
@@ -743,7 +743,7 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 		if (rc == -EAGAIN)
 			break;
 next_slot:
-		atomic_inc(&ptp->tx_avail);
+		BNXT_PTP_INC_TX_AVAIL(ptp);
 		cons = NEXT_TXTS(cons);
 	}
 	ptp->txts_cons = cons;
@@ -767,6 +767,21 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	return HZ;
 }
 
+int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
+{
+	spin_lock_bh(&ptp->ptp_tx_lock);
+	if (ptp->tx_avail) {
+		*prod = ptp->txts_prod;
+		ptp->txts_prod = NEXT_TXTS(*prod);
+		ptp->tx_avail--;
+		spin_unlock_bh(&ptp->ptp_tx_lock);
+		return 0;
+	}
+	spin_unlock_bh(&ptp->ptp_tx_lock);
+	atomic64_inc(&ptp->stats.ts_err);
+	return -ENOSPC;
+}
+
 void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -1014,7 +1029,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 	bnxt_ptp_free(bp);
 
-	atomic_set(&ptp->tx_avail, BNXT_MAX_TX_TS);
+	WRITE_ONCE(ptp->tx_avail, BNXT_MAX_TX_TS);
 	spin_lock_init(&ptp->ptp_lock);
 	spin_lock_init(&ptp->ptp_tx_lock);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a1910ce86cbb..a9a2f9a18c9c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -116,7 +116,7 @@ struct bnxt_ptp_cfg {
 	struct bnxt_ptp_tx_req	txts_req[BNXT_MAX_TX_TS];
 
 	struct bnxt		*bp;
-	atomic_t		tx_avail;
+	u32			tx_avail;
 	u16			rxctl;
 #define BNXT_PTP_MSG_SYNC			(1 << 0)
 #define BNXT_PTP_MSG_DELAY_REQ			(1 << 1)
@@ -157,6 +157,13 @@ do {						\
 	((dst) = READ_ONCE(src))
 #endif
 
+#define BNXT_PTP_INC_TX_AVAIL(ptp)		\
+do {						\
+	spin_lock_bh(&(ptp)->ptp_tx_lock);	\
+	(ptp)->tx_avail++;			\
+	spin_unlock_bh(&(ptp)->ptp_tx_lock);	\
+} while (0)
+
 int bnxt_ptp_parse(struct sk_buff *skb, u16 *seq_id, u16 *hdr_off);
 void bnxt_ptp_update_current_time(struct bnxt *bp);
 void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2);
@@ -164,6 +171,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
+int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
 void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
 void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
-- 
2.30.1


--000000000000fad34c061bcdb7a4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF7I+zeqrA43z72cp4gT6Izi9UQMHaLD
XppjIUlxDY8VMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NjE2NDM0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAqqC0JEusDi96G795OMbBYpWRarRDRh7ULSV1+Zas8J70mpSoK
Z08JfwteNIJykg98O2B36PHjA4/frM15oSXRHusDHzl3nvmcXBd3xvE8BG3UAN7EtEtu4ZEs4FOr
jpUmFZdlM+myfhCuio9hTpFU6nAuB7HOpXHy5F/6vkBwcVwvY7i/1QBxQ8Rsa3FAbrVI7WyyNvry
NcgX6yz4xkohTlNV2G9QU+8Udylku34S7pqr/4ON/jfceWIKQiLTuOH2H+GP4odJ6gLU67nKG3UL
rm4KTTIcrS1CBjm8yMIuN6u47JrqcoXvSlWlg4JgRT4BUrO+efPIejPIdbSj7Y16
--000000000000fad34c061bcdb7a4--

