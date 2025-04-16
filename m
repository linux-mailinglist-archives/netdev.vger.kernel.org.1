Return-Path: <netdev+bounces-183344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70047A90726
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AA0188F66E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE91EF0A1;
	Wed, 16 Apr 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JzOUhwCL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD41A5B9C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815685; cv=none; b=e8mcYHwNC9X/ZE9r2VfZ0E3DEIkuAZ3rSmQUWTpk/bhbyoYTNKLiv91iWhapOnH9QtCFkRpCP/H1nmAQgRFZYc/Grj8v3sIXinno/vXerFcrMP43cxgfd1kfH5UYvikAeCiT2uDmZnRbHv6/jGWmc44eMzHkehV2LFeo016WdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815685; c=relaxed/simple;
	bh=cWd6IcCN81CfclAQUQHHjlEp3V9ol7bfnOyeCwgyfaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SAEUeQzjSw6Tb1ehUI1hp+jx50lNSvi9QEGrQGEOakltAdGpQeSl7Zt4GoINBVsqaM3iXZ21b6hLU3IelUmOJEd0eIcuEoKaPUG+B5irtPgPlVixZbbzQvMgDvepYfDw87jEXKr506GGv4JgY/7LB6J17tEgU+zXhDvfvD1KgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JzOUhwCL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GCuRst016019;
	Wed, 16 Apr 2025 08:01:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=JOSk4TRIkKYvRIpeBC
	P4f9Y33H9niFs80w6Xer+4F3A=; b=JzOUhwCL+WreRe7PS6hgZDwW5cXTUpm0pZ
	iRXj7v1lUT04CFFbKJEZdzjbWAx3rdpwtLTsTx1jOGzTW9Che9mFJSM4WCR8Gd7c
	UsZ0up7e8K3IUGJTQkwQAjx3t5qyknlXG6ZlLwKVesOvU7sNwVUUley/wTv6uwNu
	0AaJf5Q81ra14lTS4WgThNTrCuSLyvabvTZR4K08Ax4bHZuvzigxzj3ilSifvRt5
	E6jz3aRG73snFKQp8rlMOyKEJgqYkNdMAsIaeTZfTOYxOxH59ZWYdvBrUTFtwxHE
	LMAr0qNU+SU1vXMqm8XBnKFmUfNafnTw7+inYdA0c9ucpgL8KhBA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4623ts3rxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 16 Apr 2025 08:01:14 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 16 Apr 2025 15:01:11 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub
 Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] bnxt_en: improve TX timestamping FIFO configuration
Date: Wed, 16 Apr 2025 08:00:57 -0700
Message-ID: <20250416150057.3904571-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UVAJdFsbeUY-TSI92eWzNsvUREu8bMlx
X-Proofpoint-ORIG-GUID: UVAJdFsbeUY-TSI92eWzNsvUREu8bMlx
X-Authority-Analysis: v=2.4 cv=M+lNKzws c=1 sm=1 tr=0 ts=67ffc63a cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=XR8D0OoHHMoA:10 a=VabnemYjAAAA:8 a=fINLlK_q-lFes1NT6p8A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01

Reconfiguration of netdev may trigger close/open procedure which can
break FIFO status by adjusting the amount of empty slots for TX
timestamps. But it is not really needed because timestamps for the
packets sent over the wire still can be retrieved. On the other side,
during netdev close procedure any skbs waiting for TX timestamps can be
leaked because there is no cleaning procedure called. Free skbs waiting
for TX timestamps when closing netdev.

Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 23 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c8e3468eee61..45d178586316 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3517,6 +3517,8 @@ static void bnxt_free_skbs(struct bnxt *bp)
 {
 	bnxt_free_tx_skbs(bp);
 	bnxt_free_rx_skbs(bp);
+	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
+		bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
 }
 
 static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, int len)
@@ -12797,8 +12799,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	/* VF-reps may need to be re-opened after the PF is re-opened */
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
-	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
-		WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 2d4e19b96ee7..39dc4f1f651a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -794,6 +794,29 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	return HZ;
 }
 
+void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
+{
+	struct bnxt_ptp_tx_req *txts_req;
+	u16 cons = ptp->txts_cons;
+
+	/* make sure ptp aux worker finished with
+	 * possible BNXT_STATE_OPEN set
+	 */
+	ptp_cancel_worker_sync(ptp->ptp_clock);
+
+	spin_lock_bh(&ptp->ptp_tx_lock);
+	ptp->tx_avail = BNXT_MAX_TX_TS;
+	while (cons != ptp->txts_prod) {
+		txts_req = &ptp->txts_req[cons];
+		if (!IS_ERR_OR_NULL(txts_req->tx_skb))
+			dev_kfree_skb_any(txts_req->tx_skb);
+		cons = NEXT_TXTS(cons);
+	}
+	ptp->txts_cons = cons;
+	spin_unlock_bh(&ptp->ptp_tx_lock);
+	ptp_schedule_worker(ptp->ptp_clock, 0);
+}
+
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
 {
 	spin_lock_bh(&ptp->ptp_tx_lock);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a95f05e9c579..0481161d26ef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
+void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
 void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
-- 
2.47.1


