Return-Path: <netdev+bounces-107004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D69187B1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38E728B8A3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044618F2FA;
	Wed, 26 Jun 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HOrGf/Jb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3118FDB5
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420221; cv=none; b=Mn0BZ/BW9KVnRYef0ZV/HBp8vmQBJgISMrihww4fcptsYZC8Z1sbkXNqfPYUuCVWgQTv/c6tKJ0OWlBZMrKkUJmwc8DzJ00BK5LkhuGzDEVPppmkJPCM+ZYo4nDWcV/H7BVqVxR9SkPaxw/OqJi0LYtDJvl77hIJZPF8I6v4Luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420221; c=relaxed/simple;
	bh=1t2j5hK0pUMDtphH6AYcomX8hzyzcOJHxryjBbsM528=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsDEfYe9avBzhCj3h3I3vhEXCEBzFc/6b82ZzEniVtrHrBMXiKkWJpA0e289cCNP2gzjp7l6ubRIz/VxArEGjqO+V9kcdqJg1dpRR6xog0mEr2V6MHvf+cdLDkTW9zIR4g2iuZPTbdhpjz64jlhGOaoXEMkQJ2EmHPEzJN32x50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HOrGf/Jb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c11e92afaso85094085a.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719420219; x=1720025019; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHEkQmE7U/zo+3YVTvYlXuTc+1/hnKEzMuy07tZ4EHM=;
        b=HOrGf/JbZt9WJlTnzxEph5R5Hkf3IEEOoohTMCgqAOsDK0FnpDxv2Kpz1Abz/Qrc9s
         H2LY4GDwlZ3KiXXW4yg37CymDyMlbRrvXC1ruzW3W9UAHtXdkTq18AwQ5Dffyv7LL45k
         zeL7quxiNUXRyS0HG0XrjzbJgL6S9kTg6BFKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420219; x=1720025019;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHEkQmE7U/zo+3YVTvYlXuTc+1/hnKEzMuy07tZ4EHM=;
        b=PB5+PZNtapYvwUB7Ehh1SrO7gZV8hTmUJtjgdX5UTLVWbv8Td3y7qp350DYm1k32jt
         8+SohqdKgb1GToJPXRRe0JCXV8ooJfG7ej+Zu7eXBpqFxJ9pO+MhXVTk64Efi2q55mok
         1YiQINh/eQ6EU+B+BSW/BmRUGXdosC4fovKCOSzL2V3MXdWs/REJ0ZJ6nFzPxexon3Dj
         YjCIqQBBUQ7aLLfH7S0MK7b7slAqK5iLcC62SBO5T2mQHwgHOMn2mIHiMoDuaYXcfBgQ
         +ae3DR/D9G5QLBc8H5YJNUFpGJ39VxTNc30h7IqaA1r/yXGrXGVjpd1qO7yDMpo3i/hZ
         zf4Q==
X-Gm-Message-State: AOJu0YzGX1CYAkfv0JBCzKJU3TQFf7YpQAxcAxQUnW6ciHgdfdPcEmDX
	iCgpYtbyOXTcXp7WjXpFvA3mgUfsgHCKgFivr6yLoL75WCMrxOhPhbNYNZK9uJJyX+cOY6NVdlg
	=
X-Google-Smtp-Source: AGHT+IG+fURLQxjaZPbGd0K9wnTBOfIB69jlqMOneYNSwDAasILInAGGLdRHoVmurFB0vOPsvt4C1Q==
X-Received: by 2002:a05:620a:170c:b0:797:8ee4:46a1 with SMTP id af79cd13be357-79be6cdc68amr1113652585a.10.1719420218221;
        Wed, 26 Jun 2024 09:43:38 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d53c42aafsm53570485a.58.2024.06.26.09.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:43:37 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 04/10] bnxt_en: Add TX timestamp completion logic
Date: Wed, 26 Jun 2024 09:43:01 -0700
Message-ID: <20240626164307.219568-5-michael.chan@broadcom.com>
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
	boundary="000000000000610e55061bcdb756"

--000000000000610e55061bcdb756
Content-Transfer-Encoding: 8bit

The new BCM5760X chips will return the timestamp of TX packets in a
new completion.  Add logic in __bnxt_poll_work() to handle this
completion type to retrieve the timestamp.  This feature eliminates
the limit on the number of in-flight PTP TX packets.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 39 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 32 +++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  2 +
 4 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 784787a09dba..e16f50d822c8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -456,6 +456,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dma_addr_t mapping;
 	unsigned int length, pad = 0;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	u16 prod, last_frag;
 	struct pci_dev *pdev = bp->pdev;
 	struct bnxt_tx_ring_info *txr;
@@ -509,10 +510,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
 	}
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-
-		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb)) {
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && ptp &&
+	    ptp->tx_tstamp_en) {
+		if (bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP) {
+			lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
+			tx_buf->is_ts_pkt = 1;
+		} else if (!skb_is_gso(skb)) {
 			if (atomic_dec_if_positive(&ptp->tx_avail) < 0) {
 				atomic64_inc(&ptp->stats.ts_err);
 				goto tx_no_ts;
@@ -782,6 +785,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
 	int tx_pkts = 0;
+	bool rc = false;
 
 	while (RING_TX(bp, cons) != hw_cons) {
 		struct bnxt_sw_tx_bd *tx_buf;
@@ -790,24 +794,29 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		int j, last;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-		cons = NEXT_TX(cons);
 		skb = tx_buf->skb;
-		tx_buf->skb = NULL;
 
 		if (unlikely(!skb)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
-			return false;
+			return rc;
+		}
+
+		is_ts_pkt = tx_buf->is_ts_pkt;
+		if (is_ts_pkt && (bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP)) {
+			rc = true;
+			break;
 		}
 
+		cons = NEXT_TX(cons);
 		tx_pkts++;
 		tx_bytes += skb->len;
+		tx_buf->skb = NULL;
+		tx_buf->is_ts_pkt = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
 			goto next_tx_int;
 		}
-		is_ts_pkt = tx_buf->is_ts_pkt;
-		tx_buf->is_ts_pkt = 0;
 
 		dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
 				 skb_headlen(skb), DMA_TO_DEVICE);
@@ -846,7 +855,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 				   bnxt_tx_avail(bp, txr), bp->tx_wake_thresh,
 				   READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING);
 
-	return false;
+	return rc;
 }
 
 static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
@@ -2926,6 +2935,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					cpr->has_more_work = 1;
 				break;
 			}
+		} else if (cmp_type == CMP_TYPE_TX_L2_PKT_TS_CMP) {
+			bnxt_tx_ts_cmp(bp, bnapi, (struct tx_ts_cmp *)txcmp);
 		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
 			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
 			if (likely(budget))
@@ -6804,6 +6815,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 	switch (ring_type) {
 	case HWRM_RING_ALLOC_TX: {
 		struct bnxt_tx_ring_info *txr;
+		u16 flags = 0;
 
 		txr = container_of(ring, struct bnxt_tx_ring_info,
 				   tx_ring_struct);
@@ -6817,6 +6829,9 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 		if (bp->flags & BNXT_FLAG_TX_COAL_CMPL)
 			req->cmpl_coal_cnt =
 				RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64;
+		if ((bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP) && bp->ptp_cfg)
+			flags |= RING_ALLOC_REQ_FLAGS_TX_PKT_TS_CMPL_ENABLE;
+		req->flags = cpu_to_le16(flags);
 		break;
 	}
 	case HWRM_RING_ALLOC_RX:
@@ -9111,6 +9126,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_RX_ALL_PKT_TS;
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_UDP_GSO_SUPPORTED)
 		bp->flags |= BNXT_FLAG_UDP_GSO_CAP;
+	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_TX_PKT_TS_CMPL_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_TX_TS_CMP;
 
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
@@ -12152,7 +12169,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	/* VF-reps may need to be re-opened after the PF is re-opened */
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
-	if (bp->ptp_cfg)
+	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
 		atomic_set(&bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 00976e8a1e6a..12d6d17936a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2410,6 +2410,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V2	BIT_ULL(16)
 	#define BNXT_FW_CAP_PCIE_STATS_SUPPORTED	BIT_ULL(17)
 	#define BNXT_FW_CAP_EXT_STATS_SUPPORTED		BIT_ULL(18)
+	#define BNXT_FW_CAP_TX_TS_CMP			BIT_ULL(19)
 	#define BNXT_FW_CAP_ERR_RECOVER_RELOAD		BIT_ULL(20)
 	#define BNXT_FW_CAP_HOT_RESET			BIT_ULL(21)
 	#define BNXT_FW_CAP_PTP_RTC			BIT_ULL(22)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a14d46b9bfdf..0ca7bc75616b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -768,6 +768,38 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
 	return 0;
 }
 
+void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
+		    struct tx_ts_cmp *tscmp)
+{
+	struct skb_shared_hwtstamps timestamp = {};
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+	u32 opaque = tscmp->tx_ts_cmp_opaque;
+	struct bnxt_tx_ring_info *txr;
+	struct bnxt_sw_tx_bd *tx_buf;
+	u64 ts, ns;
+	u16 cons;
+
+	txr = bnapi->tx_ring[TX_OPAQUE_RING(opaque)];
+	ts = BNXT_GET_TX_TS_48B_NS(tscmp);
+	cons = TX_OPAQUE_IDX(opaque);
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
+	if (tx_buf->is_ts_pkt) {
+		if (BNXT_TX_TS_ERR(tscmp)) {
+			netdev_err(bp->dev,
+				   "timestamp completion error 0x%x 0x%x\n",
+				   le32_to_cpu(tscmp->tx_ts_cmp_flags_type),
+				   le32_to_cpu(tscmp->tx_ts_cmp_errors_v));
+		} else {
+			spin_lock_bh(&ptp->ptp_lock);
+			ns = timecounter_cyc2time(&ptp->tc, ts);
+			spin_unlock_bh(&ptp->ptp_lock);
+			timestamp.hwtstamp = ns_to_ktime(ns);
+			skb_tstamp_tx(tx_buf->skb, &timestamp);
+		}
+		tx_buf->is_ts_pkt = 0;
+	}
+}
+
 static const struct ptp_clock_info bnxt_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "bnxt clock",
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 8c30b428a428..d38c3500827f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -156,6 +156,8 @@ int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
 int bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb);
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
+void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
+		    struct tx_ts_cmp *tscmp);
 void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns);
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg);
 int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg);
-- 
2.30.1


--000000000000610e55061bcdb756
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP8OF250tad/QjPmB9AvbSwHh8kulE27
Cn+ckbKXTv/hMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NjE2NDMzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCJbCCd5ffZlMl9ZnD6J5bBEUsHcbQWdcruNPWWY4BTrR1Xzqug
fJCqK4GZxGbtkMojK9/BGMWKnpbW34HK/CLVeZIEmE9lOLYdaW2ipVQebpNgNKq2tlHcTuHl8nvF
nMvveDH9cfdyXJyRbTUap3q0Lt2k04p621Jv4syfJAVBLT6RQtOa9WJmlsR1qqifXG53nbrnEfRN
i3SAPTmjZZafOYsgtsD/49IxD12+gi0USGy8Yfa2A8xU1IOUwOCPHhIobkGb6CT0xsvsNV6jiMwe
XJvlBvQ1ekQB8/NIgmCirIQzbVk9PMIgDNKmaGm5RR92yv8c1BGb/nuqGBd1Fasi
--000000000000610e55061bcdb756--

