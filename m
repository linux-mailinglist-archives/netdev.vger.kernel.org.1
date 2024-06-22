Return-Path: <netdev+bounces-105850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E2913269
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D37B21C78
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820B14B965;
	Sat, 22 Jun 2024 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lGD9ocsg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563A8BFD;
	Sat, 22 Jun 2024 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719038700; cv=none; b=FJp6n+gJHJPN3xnRfLv/c2lRj91of3flkOinbTmMsrIWPdx1dHX8fD0lero1hKQUyl3xtdUdpgBIK9Xhn6kA/SuG9WdQDeAkshfBERMh9dCvZmZLS2QaF76f9sNXG3f7+4wi2WBOOwXffObZJBSNvB46nRpq4RYFbsDzxX6NBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719038700; c=relaxed/simple;
	bh=SFChX3GTwkwBVUpYdO1Ksg8dix0lX5QntXiRx4WtliU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEu4Oom5V9dO/xVel1kAacwQBlj8os+y5djmZGvZd5BQjVXV4j8U0nS0d6k8eue5CvZcAicH2CNStqx74mfv7NAlcgwvHaxLoWiR1zslCqIYLjqdabwQCE+rhg2vOuRSXSny3l7VIblIWLuFd4Odc+0BvN1NV85AS6HslTfwx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lGD9ocsg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M6hN6V026151;
	Fri, 21 Jun 2024 23:44:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=H36+9mtcn7BgRXSx/MLaYd2
	UCHM/mMFc4cP5kfF2A9U=; b=lGD9ocsg1JTp1skzeaipST+3tE37ekUgBMNuiCs
	wFqp6b5j4kGzX6vSq81EJyvNClMGF2qAKEK3xrOneBlY7Rv52v6260X8XctPISe5
	NliOTdpn8keNAjsvfNbWkNASxDshccnohK4qk3pomE1FFavv+VQLyOzcki8UixIE
	cKUKY3Rqy9VqAIVZ/jBh97qjyWsyE1u/nKdd9cYHSYdJAytKXpyUAvl+BtrY4t8m
	UngBAMO/LZibQSddvVLDGWVNko/MpP8LJ5f/jh5VunCbvYYADiorno8H8Y/VmlpI
	s17hOC7TbNN8KEBB72jtSPbAwqTWXHzt9jSvWcgDFCttdew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ywh0ph43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 23:44:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Jun 2024 23:44:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Jun 2024 23:44:44 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 02D653F7097;
	Fri, 21 Jun 2024 23:44:39 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Ratheesh Kannoth <rkannoth@marvell.com>, Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver
Date: Sat, 22 Jun 2024 12:14:37 +0530
Message-ID: <20240622064437.2919946-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ssUuIVpFg99Ytz50vYPmZ5ih4l3gyqMG
X-Proofpoint-ORIG-GUID: ssUuIVpFg99Ytz50vYPmZ5ih4l3gyqMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_04,2024-06-21_01,2024-05-17_01

From: Ratheesh Kannoth <rkannoth@marvell.com>

Fix unintended sign extension and klockwork issues. These are not real
issue but for sanity checks.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 10 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h | 55 ++++++++++---------
 .../marvell/octeontx2/nic/otx2_txrx.c         |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  3 +-
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a85ac039d779..87d5776e3b88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -648,14 +648,14 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL4) {
 		parent = schq_list[NIX_TXSCH_LVL_TL3][prio];
 		req->reg[0] = NIX_AF_TL4X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL4X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
 	} else if (lvl == NIX_TXSCH_LVL_TL3) {
 		parent = schq_list[NIX_TXSCH_LVL_TL2][prio];
 		req->reg[0] = NIX_AF_TL3X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL3X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
@@ -670,11 +670,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL2) {
 		parent = schq_list[NIX_TXSCH_LVL_TL1][prio];
 		req->reg[0] = NIX_AF_TL2X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
-		req->regval[1] = TXSCH_TL1_DFLT_RR_PRIO << 24 | dwrr_val;
+		req->regval[1] = (u64)hw->txschq_aggr_lvl_rr_prio << 24 | dwrr_val;
 
 		if (lvl == hw->txschq_link_cfg_lvl) {
 			req->num_regs++;
@@ -698,7 +698,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
-		req->regval[1] = (TXSCH_TL1_DFLT_RR_PRIO << 1);
+		req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 1;
 
 		req->num_regs++;
 		req->reg[2] = NIX_AF_TL1X_CIR(schq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 45a32e4b49d1..e3aee6e36215 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -139,33 +139,34 @@
 #define	NIX_LF_CINTX_ENA_W1C(a)		(NIX_LFBASE | 0xD50 | (a) << 12)
 
 /* NIX AF transmit scheduler registers */
-#define NIX_AF_SMQX_CFG(a)		(0x700 | (a) << 16)
-#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (a) << 16)
-#define NIX_AF_TL1X_CIR(a)		(0xC20 | (a) << 16)
-#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (a) << 16)
-#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (a) << 16)
-#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (a) << 16)
-#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (a) << 16)
-#define NIX_AF_TL2X_CIR(a)              (0xE20 | (a) << 16)
-#define NIX_AF_TL2X_PIR(a)              (0xE30 | (a) << 16)
-#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (a) << 16)
-#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (a) << 16)
-#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (a) << 16)
-#define NIX_AF_TL3X_CIR(a)		(0x1020 | (a) << 16)
-#define NIX_AF_TL3X_PIR(a)		(0x1030 | (a) << 16)
-#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (a) << 16)
-#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (a) << 16)
-#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (a) << 16)
-#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (a) << 16)
-#define NIX_AF_TL4X_CIR(a)		(0x1220 | (a) << 16)
-#define NIX_AF_TL4X_PIR(a)		(0x1230 | (a) << 16)
-#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (a) << 16)
-#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (a) << 16)
-#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (a) << 16)
-#define NIX_AF_MDQX_CIR(a)		(0x1420 | (a) << 16)
-#define NIX_AF_MDQX_PIR(a)		(0x1430 | (a) << 16)
-#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (a) << 16)
-#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (a) << 16 | (b) << 3)
+#define NIX_AF_SMQX_CFG(a)		(0x700 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SDP_LINK_CFG(a)	(0xB10 | (u64)(a) << 16)
+#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (u64)(a) << 16)
+#define NIX_AF_TL1X_CIR(a)		(0xC20 | (u64)(a) << 16)
+#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (u64)(a) << 16)
+#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (u64)(a) << 16)
+#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_CIR(a)		(0xE20 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PIR(a)		(0xE30 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (u64)(a) << 16)
+#define NIX_AF_TL3X_CIR(a)		(0x1020 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PIR(a)		(0x1030 | (u64)(a) << 16)
+#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (u64)(a) << 16)
+#define NIX_AF_TL4X_CIR(a)		(0x1220 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PIR(a)		(0x1230 | (u64)(a) << 16)
+#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (u64)(a) << 16)
+#define NIX_AF_MDQX_CIR(a)		(0x1420 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PIR(a)		(0x1430 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (u64)(a) << 16)
+#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (u64)(a) << 16 | (b) << 3)
 
 /* LMT LF registers */
 #define LMT_LFBASE			BIT_ULL(RVU_FUNC_BLKADDR_SHIFT)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 929b4eac25d9..3eb85949677a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -513,7 +513,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_poll *cq_poll)
 {
-	struct dim_sample dim_sample;
+	struct dim_sample dim_sample = { 0 };
 	u64 rx_frames, rx_bytes;
 	u64 tx_frames, tx_bytes;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index edac008099c0..0f844c14485a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -153,7 +153,6 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		num_regs++;
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
-
 	} else if (level == NIX_TXSCH_LVL_TL4) {
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL3) {
@@ -176,7 +175,7 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		/* check if node is root */
 		if (node->qid == OTX2_QOS_QID_INNER && !node->parent) {
 			cfg->reg[num_regs] = NIX_AF_TL2X_SCHEDULE(node->schq);
-			cfg->regval[num_regs] =  TXSCH_TL1_DFLT_RR_PRIO << 24 |
+			cfg->regval[num_regs] =  (u64)hw->txschq_aggr_lvl_rr_prio << 24 |
 						 mtu_to_dwrr_weight(pfvf,
 								    pfvf->tx_max_pktlen);
 			num_regs++;
-- 
2.25.1


