Return-Path: <netdev+bounces-183822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB1A9222C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84A9188B37F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC835253333;
	Thu, 17 Apr 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Blzb06EL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39A366
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905731; cv=none; b=n3XIs9IhPZEb1hDJzuDotsPB8Ndw0NhXeYUMOy0lZwkcON5oVlzC3iCJSo+JCNbPvj4d2FEuajKoatftHINWxr3rIxo71IUbwG5kicGtFM8Uw62m6fyKaaFJeRtFZt4VFnN5DrMWJSs/dcttA3lwhFxbT/80SEH1Y29zIedLQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905731; c=relaxed/simple;
	bh=t77lIryN6SUZZvY5NnTRhzGhFZY3QpPT1cCY5xSktbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdgyFQGfZ8cF015vlypKJtepwvp1H1M4OGBf9NyoixuHwWsKLa84mpTvrqR88BN4Q4Iy5VJZ0hu9ScamKvS9b2jSYzcYe7LM8QcM94sAKYTBryvXMXcqTkquC1kaFW4o8n/kkA5TuVlnVCLDFavYqX4OVaBHcgHDc0C3iM8Fypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Blzb06EL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HEd16G016291;
	Thu, 17 Apr 2025 09:01:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=jTPj6tDpaNIARARd/3
	DkwKodD60HsjXo1a6Kb43IxfY=; b=Blzb06ELw6ly0DW0m1miS3iPA2vN5rwyv+
	QGSaaiq1f51uM4cO7wqvI1h+p2zY+5lrqU0w7Kf4ZCWPmkM6H8JFyAfSKpJvDYsI
	08v3/MlanYfg/44xaL/GppMIQF0FmtHA2czRiP2iKiQrkumvNkD25dcLvBdie99I
	3TwhkSgjg2wQaLhEcRn8iBjN6XBcqzHVeCerncW7+eL8vYrYGDASpk0bju/Ipg5d
	YDryFg+wO8pz1V9BEouHFfgG9hIZRO+yUsDMH/G8lY9WdzJWjBZG27rl2TnJ5nTi
	c/CG4Ndd7AyjZ8zHIQracRJwxOGwshJy+H1Y5t0Mf85uKMvPvmVA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 462vsvbe1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 17 Apr 2025 09:01:56 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 17 Apr 2025 16:01:52 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v2] bnxt_en: improve TX timestamping FIFO configuration
Date: Thu, 17 Apr 2025 09:01:41 -0700
Message-ID: <20250417160141.4091537-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EHNJy9QcIs7_O91WZfSuro6EqdY-tGml
X-Proofpoint-GUID: EHNJy9QcIs7_O91WZfSuro6EqdY-tGml
X-Authority-Analysis: v=2.4 cv=cqmbk04i c=1 sm=1 tr=0 ts=680125f4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=XR8D0OoHHMoA:10 a=VabnemYjAAAA:8 a=VnezELSGKxGoUyyTTqgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01

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
v1 -> v2:
* move clearing of TS skbs to bnxt_free_tx_skbs
* remove spinlock as no TX is possible after bnxt_tx_disable()
* remove extra FIFO clearing in bnxt_ptp_clear()
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 28 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
 3 files changed, 25 insertions(+), 9 deletions(-)

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
index 2d4e19b96ee7..197893220070 100644
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
@@ -1117,12 +1138,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
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


