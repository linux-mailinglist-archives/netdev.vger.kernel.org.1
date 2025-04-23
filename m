Return-Path: <netdev+bounces-185081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A432A9879A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9284E3ADF82
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041F26A083;
	Wed, 23 Apr 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mtN9lRsz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55B265CAD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404466; cv=none; b=koh/OaGckuZPPQHPFCtdSugGUx8e0U3M4bh4XOlHUQKb0c4yy+e6sqKddYLsVhllvNcuU3yQZSRtq0SYfj9EJysbsntBYXJon17IP3sdQaKoah4qd0kBXsFNCYuQ8W7Vxo23NfnN6N41nNG+kBqSs49utlOst8x0frXF3crgcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404466; c=relaxed/simple;
	bh=N8pLXeLSKUbQv+RLdJoyPCm4XGvIk8H/cpO7vr3KiJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLB3Sb0OFCNTNg3dwRI0TQ0qYGOSn9+wHN2NehgfQI65rxTerpL/m9vc9ZtDiHuwnqzwxjA4PJ+z2jsy4gt9rOotNJVH9GV75shVoDypH4/+MqfCM5KKM5/fOmIT8g3FDK//N6XMAdFlwmgA5VqRoJhkoM1eXlMZp0HucdLCe38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mtN9lRsz; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8JZpg027996;
	Wed, 23 Apr 2025 03:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Y1h2a5Y0VX7xJecS61
	xQcviM422ZdZOCwBhZL6mIRqw=; b=mtN9lRszvvmfRcMQZpucot7oMUfPHt8oF7
	nFk7D0FHQDs7VjXs5P6bgjiXrMPZvkLCb2fkX965EDZtqlsv0NeCaPuCWLJHxKQf
	w1uLWQhk+w7D5UAxcXcWSoJf1D/mwBCPqZiegQJoj6vajXYl8tpEdY9USNhdYjnm
	58sF62m6UOm3eSq5KU1izu8EgM7Z5CRRjbImEhgMl0tNIO44t30A8cu9QtUPbJSw
	FsYpftGKyg0+GKshyikdBGtA1Kx2HVqW+JXc7olc9gzAd2Cd4EOHSutmlxRPUI7E
	C5UR6XtOteWVrQM3o8A5acGrQznDeKIg2whTYdaot+nv9Ot85BHA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 466qd4jd1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Apr 2025 03:34:12 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 23 Apr 2025 10:34:10 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub
 Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3] bnxt_en: improve TX timestamping FIFO configuration
Date: Wed, 23 Apr 2025 03:33:51 -0700
Message-ID: <20250423103351.868959-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AIvSZTdw c=1 sm=1 tr=0 ts=6808c224 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=XR8D0OoHHMoA:10 a=Q-fNiiVtAAAA:8 a=VabnemYjAAAA:8 a=VnezELSGKxGoUyyTTqgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: W3BhOPJQJ0vavVh7eRS2AmcwoCQWMV_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA3MiBTYWx0ZWRfXwN/shmNIwbQq WlXiramw5/gGWidE4vAAPtzawryLbwpZC8hesLovK7qBJql/gF99GqgedY3uaTUVuA2zQ5ZNCc9 vXyLgkoUGvFVM3NAk1ua7bHS3sz6X4VcINXvHcMyZ3Jp7HIFKQCnvHBuqa92eMPazUBQyEfmIY8
 /8loVEBlTN6l3l+KCr+Elw7Zb62+cgVGSIS9uXSd+//ChV9zwMTyNyHbupF8hxmZDrfgBHKNvv5 bdYu/D8Xr3EafnhcByuLrHLwlbsvJ0uzQW7htuehikMkh5/39uP9epONay+GGU0d1nVZsM4GeQd e7HwTwAKiltX5IUFZleALa03XlENWnCnjmiydAPATSAjhnHaC65kY67mEomv++f/28iBkJuC9sr
 LPBZRsLYYZE3t58AKAKwU4Fk78cUZWxm0J6yiqRbLSJUGk13tuCG00EYoBq4RTqtngiydq7P
X-Proofpoint-ORIG-GUID: W3BhOPJQJ0vavVh7eRS2AmcwoCQWMV_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01

Reconfiguration of netdev may trigger close/open procedure which can
break FIFO status by adjusting the amount of empty slots for TX
timestamps. But it is not really needed because timestamps for the
packets sent over the wire still can be retrieved. On the other side,
during netdev close procedure any skbs waiting for TX timestamps can be
leaked because there is no cleaning procedure called. Free skbs waiting
for TX timestamps when closing netdev.

Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP TX packets to 4")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v2 -> v3:
* remove leftover unused variable in bnxt_ptp_clear()
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


