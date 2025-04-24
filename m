Return-Path: <netdev+bounces-185553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B71A9AE14
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E027B1B65E8A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137427B51E;
	Thu, 24 Apr 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KNYgM9v0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4127BF9B
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499417; cv=none; b=irFnjgwRF367vIEP5SxGZl3+yyUJu/WwoAedJTRuYumYzAu4gq2a5rGJxJmE3zPVC+qnrKnQB433qILK4zcgQpPs+FNiup/1cOzS0AaSsoRBIbm5OjWNd4Q9lkoSkt37HjVIAghhKqfE/T/eo2Dyjx32w7JC/hcRKzOGutbTST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499417; c=relaxed/simple;
	bh=5BTfy8Idhyh2VjCRIiZGY+O8FpzzYRJBlt2Qx7yYD3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ms4gfLwVSgfLS/SakbX36VJh5FZ141+MD6QALbkwg5e1Co7xhTa8HVxx6/UO6y+IWdY2m8TboS72IdrNlgghfbloN5iUCaKLjCR4ZdKHMcMyizBysZKRZtaMAVCpgp7OsIEuvxFQ1zM9bztVOKFbI44On+NRZxvCnN4aJolhaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KNYgM9v0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 53OCujqv028013;
	Thu, 24 Apr 2025 05:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=HlQ+EQjhFs6QLbsrbZ
	mQO2SieqI0k7nwEw12f1VBDt0=; b=KNYgM9v0vcVkH4QGj1WNY1NYusXzoKQbry
	ghFZJIkLE/Sj+99ajtN5vbeZWf+daFbb9IV3cCEs8ViM34ftnqBIFIX5ap5AFSF4
	x1YHJE51Z52BTsw97a7Xund3wh3jd9oj76uEJ9BzMASfLJVtqfEkj4o4TkxboPkY
	KfW4rQBNebTiSZW8qZBs8/KsRQlzoE/2zfhoFeQzty9gSOgUj3UEeJyzqb9RluXz
	zD1ZcxjPGT7q6Y7XE582xKeetJZAJiIYYPlOSRZdw8SRhBb1hGD+v48GaCrSsRun
	h+pFwzP071ybyblPuldsuYc28668wAET5QLUokKMbccKJfAcYWlA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 467k9mgyej-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Apr 2025 05:56:48 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 24 Apr 2025 12:56:01 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub
 Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v4] bnxt_en: improve TX timestamping FIFO configuration
Date: Thu, 24 Apr 2025 05:55:47 -0700
Message-ID: <20250424125547.460632-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cKPgskeN c=1 sm=1 tr=0 ts=680a3510 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=XR8D0OoHHMoA:10 a=Q-fNiiVtAAAA:8 a=VabnemYjAAAA:8 a=VnezELSGKxGoUyyTTqgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: lxKmby8uKhGwaRupVIqLZu3iT3ZdKyct
X-Proofpoint-GUID: lxKmby8uKhGwaRupVIqLZu3iT3ZdKyct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA4NyBTYWx0ZWRfX7q5rC1bgdRPc L2CflvSPQ9y3sCErVmWepjN3dhPDaWJ/Nk+FL/3jKN5vXo/ux8NewLURxOa4c0qRhLZ9i3CC1HG 4UwFGmEWg2cuYH9JIxe7Z3xPafU12pH8uvFMEmfNbMNhEHFn9428w9QxedXLPNX7NGfyxK0CnMY
 5n2hz8E/NCDINx/6DxIgm6T00nV1cCDp2DRG/CxPjsA20zj0cB8UdHxjLHILnMmqdp+nVD4t0Kb Xon8ccNfcuv+g3QG3oXEiKPkGPqjcsY+L/LzM6TsgK/L2LbxoVoYL84nCMZVkJMLPM+qtPEYnvb 427VE/qFlj2BS0JnhDDk7DEPPI62Tpk5XefL7+a/vZdth+88gqzoyTQNskCilmk8/KCPqPOQL63
 BobZffWJfveBkndJqPHsx7uOQdmPsi/aKP0QJBiSjXBtAair8UERyZG+KwRzM5Cn0RFl4Jh1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-22_01,2025-02-21_01

Reconfiguration of netdev may trigger close/open procedure which can
break FIFO status by adjusting the amount of empty slots for TX
timestamps. But it is not really needed because timestamps for the
packets sent over the wire still can be retrieved. On the other side,
during netdev close procedure any skbs waiting for TX timestamps can be
leaked because there is no cleaning procedure called. Free skbs waiting
for TX timestamps when closing netdev.

Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v3 -> v4:
* actually remove leftover unused variable in bnxt_ptp_clear()
(v3 was not committed before preparing unfortunately)
v2 -> v3:
* remove leftover unused variable in bnxt_ptp_clear()
v1 -> v2:
* move clearing of TS skbs to bnxt_free_tx_skbs
* remove spinlock as no TX is possible after bnxt_tx_disable()
* remove extra FIFO clearing in bnxt_ptp_clear()
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c8e3468eee61..2c8e2c19d854 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 
 		bnxt_free_one_tx_ring_skbs(bp, txr, i);
 	}
+
+	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
+		bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
 }
 
 static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
@@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	/* VF-reps may need to be re-opened after the PF is re-opened */
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
-	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
-		WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 2d4e19b96ee7..0669d43472f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
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
+	ptp->tx_avail = BNXT_MAX_TX_TS;
+	while (cons != ptp->txts_prod) {
+		txts_req = &ptp->txts_req[cons];
+		if (!IS_ERR_OR_NULL(txts_req->tx_skb))
+			dev_kfree_skb_any(txts_req->tx_skb);
+		cons = NEXT_TXTS(cons);
+	}
+	ptp->txts_cons = cons;
+	ptp_schedule_worker(ptp->ptp_clock, 0);
+}
+
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
 {
 	spin_lock_bh(&ptp->ptp_tx_lock);
@@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
 void bnxt_ptp_clear(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	int i;
 
 	if (!ptp)
 		return;
@@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
 	kfree(ptp->ptp_info.pin_config);
 	ptp->ptp_info.pin_config = NULL;
 
-	for (i = 0; i < BNXT_MAX_TX_TS; i++) {
-		if (ptp->txts_req[i].tx_skb) {
-			dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
-			ptp->txts_req[i].tx_skb = NULL;
-		}
-	}
-
 	bnxt_unmap_ptp_regs(bp);
 }
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


