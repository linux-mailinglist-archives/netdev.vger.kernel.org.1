Return-Path: <netdev+bounces-51208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FDF7F9914
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D7B20A15
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0053BA;
	Mon, 27 Nov 2023 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L+dcO/bv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9790E4;
	Sun, 26 Nov 2023 22:05:52 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR0QDrE014892;
	Sun, 26 Nov 2023 22:05:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=u31IBT9Ogw/i12krm24f2e68EWynIQHq66FbOqTZMEo=;
 b=L+dcO/bvY5ySIoQWcfrnYvG8SQHTyR5wcr8fNT2pHUgLdlUeSNmwJtXDPmwLhpNXDLsj
 zmfUqzPGXuXHHZQmtNGYXl1eLkLL2fwIZfVOgDqSNOQdWvVp3OCd7pfM/XlSNXRi/zjg
 r/lZTuSaRGuGbudDn3KWlu4oQFXCmi1B3biXyQZ2KIdZ0DdVvUrk2AvAB0jgXBbTxK3t
 fL9NXN1eIbXNqzPNggzY56DBOgbniRMf8ZkHDaWTuec+7aWwQ7UOtY1aJ3y8IOpNJr0+
 5Are2Y634lab3pDF13uIY1AzN4enBUzbpiY9VRRG7WlIwQzgUA4Bt51JjWroK0By1/8H BQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ukf5x3s2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 22:05:46 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Nov
 2023 22:05:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 26 Nov 2023 22:05:44 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id DD9F43F7055;
	Sun, 26 Nov 2023 22:05:40 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <naveenm@marvell.com>
Subject: [net PATCH v2] octeontx2-pf: Fix updation of adaptive interrupt coalescing
Date: Mon, 27 Nov 2023 11:35:38 +0530
Message-ID: <20231127060538.3780111-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N2TjlSe4MzvHhydGjJUosqXtlGC1G91C
X-Proofpoint-ORIG-GUID: N2TjlSe4MzvHhydGjJUosqXtlGC1G91C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02

From: Naveen Mamindlapalli <naveenm@marvell.com>

The current adaptive interrupt coalescing code updates only rx
packet stats for dim algorithm. This patch fixes that and also
updates tx packet stats which will be useful when there is
only tx traffic. Also moved configuring hardware adaptive
interrupt setting to driver dim callback.

Fixes: 6e144b47f560 ("octeontx2-pf: Add support for adaptive interrupt coalescing")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
v2 changes:
- Missed adding the fixes tag in v1. Added the same in v2.

 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  9 +++++++++
 .../marvell/octeontx2/nic/otx2_txrx.c         | 20 +++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ba95ac913274..6c0e0e2c235b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1685,6 +1685,14 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 	mutex_unlock(&pf->mbox.lock);
 }
 
+static void otx2_set_irq_coalesce(struct otx2_nic *pfvf)
+{
+	int cint;
+
+	for (cint = 0; cint < pfvf->hw.cint_cnt; cint++)
+		otx2_config_irq_coalescing(pfvf, cint);
+}
+
 static void otx2_dim_work(struct work_struct *w)
 {
 	struct dim_cq_moder cur_moder;
@@ -1700,6 +1708,7 @@ static void otx2_dim_work(struct work_struct *w)
 		CQ_TIMER_THRESH_MAX : cur_moder.usec;
 	pfvf->hw.cq_ecount_wait = (cur_moder.pkts > NAPI_POLL_WEIGHT) ?
 		NAPI_POLL_WEIGHT : cur_moder.pkts;
+	otx2_set_irq_coalesce(pfvf);
 	dim->state = DIM_START_MEASURE;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 6ee15f3c25ed..4d519ea833b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -512,11 +512,18 @@ static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_p
 {
 	struct dim_sample dim_sample;
 	u64 rx_frames, rx_bytes;
+	u64 tx_frames, tx_bytes;
 
 	rx_frames = OTX2_GET_RX_STATS(RX_BCAST) + OTX2_GET_RX_STATS(RX_MCAST) +
 		OTX2_GET_RX_STATS(RX_UCAST);
 	rx_bytes = OTX2_GET_RX_STATS(RX_OCTS);
-	dim_update_sample(pfvf->napi_events, rx_frames, rx_bytes, &dim_sample);
+	tx_bytes = OTX2_GET_TX_STATS(TX_OCTS);
+	tx_frames = OTX2_GET_TX_STATS(TX_UCAST);
+
+	dim_update_sample(pfvf->napi_events,
+			  rx_frames + tx_frames,
+			  rx_bytes + tx_bytes,
+			  &dim_sample);
 	net_dim(&cq_poll->dim, dim_sample);
 }
 
@@ -558,16 +565,9 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 		if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
 			return workdone;
 
-		/* Check for adaptive interrupt coalesce */
-		if (workdone != 0 &&
-		    ((pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED) ==
-		     OTX2_FLAG_ADPTV_INT_COAL_ENABLED)) {
-			/* Adjust irq coalese using net_dim */
+		/* Adjust irq coalese using net_dim */
+		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
 			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
-			/* Update irq coalescing */
-			for (i = 0; i < pfvf->hw.cint_cnt; i++)
-				otx2_config_irq_coalescing(pfvf, i);
-		}
 
 		if (unlikely(!filled_cnt)) {
 			struct refill_work *work;
-- 
2.25.1


