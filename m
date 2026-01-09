Return-Path: <netdev+bounces-248450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF3D0895C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137CD307CB28
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1B33B6CC;
	Fri,  9 Jan 2026 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NkCS0Ppx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2633AD9D;
	Fri,  9 Jan 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954706; cv=none; b=lttcZQ/IuP0Ogusf+goO8pMV3TOJBtSQfcjLMa8hUI+CSyvzsSHs7bXkr6wBjTkb8lwYn19dxPttuVcyPUVEcKCGTgFTiAccX5tn8QE8KwPFpD6f4fc1E/kVaCW0K/nHV1ke6K66FMWgWvWco/OT8S2ysdfBF63AU1tI9Deqp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954706; c=relaxed/simple;
	bh=MeOsaiOgaJ7llG6zhyBycOt5bALIZxtpbATHjBGU8aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHYuswZ+u8iLJx9Sf/HdiinrxO+TTrOu+AZzcZDh3rsznQ88bgf7J7W/wqA11x54OrTw7e+++7IO6nzcsMeRk2MSk1AHpGzLqFuiKSNCB94rGRLimYlR/0cgEAFcJ7uwWnlYeCRuTM0//pxU9NC1qjtNSkNSTugmZMFbmHMb4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NkCS0Ppx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6092oer22938076;
	Fri, 9 Jan 2026 02:31:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	L1KxUgzGDP8y4RXjiXMM8xOtX1TIqHpiot3Mpa55Gk=; b=NkCS0Ppx3JWxKZ09x
	UrMJrYGeQnZ2/fMTm+hTeezT/3oQag8yS7JFVcTnqqT88f11z+yn7xC236Nc7C36
	PBHQv9gLfeVO4q/Y1IZmA1SIWjo+eeTNe5/pfVln8+CLDa9YEdsYD1nb2EQk88S6
	I6bw16kGcffEcu5yG0mQkbCRkJiBWRnDOUQdo3E/agxAekZ+TiWtT7tSnvfvGx7v
	u9ctZD6QB5qePrgiRwwiYMy8DFmR3OcuP9GsZxbT6eHojtGPG4Y9ZqmySyFLwFoi
	mtimBWgp0MnwZeL8Jz56auFXVlMSsR7Ov44ziVzG1x77GKFJKPD8r6khFU8/17J9
	thqnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2vmvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:35 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7DABD3F7089;
	Fri,  9 Jan 2026 02:31:32 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 05/10] octeontx2-af: switch: Enable Switch hw port for all channels
Date: Fri, 9 Jan 2026 16:00:30 +0530
Message-ID: <20260109103035.2972893-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4v9iy7unIIbP1p9ZEnxfYyARXIWqW-bo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfX3cBoSrdOyOJl
 oRrjmaQFWPFZ+i4PpZONiE18SVLAtPO33MSkaAbFvEs0F6tCSItd/WqZJBkyjX0NBCyChg1YdjJ
 hdNygMaDawtGorn0OX0QR1rlqcaogd0NNFXnWIUFu7zrcesxy172dGOFokOiGU6ysWBIbq0uAep
 xOctmzPTZHd7kK7MhAw0DHfaWt8kSJ99dz8KGkVyYNNMK+abRcX2FRKGQggqQAMn4Z6KBw3NaoB
 I7OP3ShqBt2RlWwlEjBIy9Mc+7MUyNmxU9XF3lwTXc+DFfuMpcsVRZ/iEdl4uWptJqscLEBAtGF
 U5kOb1rln+hVT/ddcmQWAjU8FCt6vMHy8GB7/4Ssf7uXm4lyLIdZxuBaTjO6ZOq7wSuiWoUa13C
 Eg0w7taGaXuIKJ7GSRWcm6taIYeVUDvu5RzgW72f4aU7+Tt0QfBAM+LoLUifLtyTE2PgiHc9y9O
 GatEiY+VqguGwBipOXA==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=6960d908 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=0Cqobd3ug1408HmlttkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4v9iy7unIIbP1p9ZEnxfYyARXIWqW-bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

Switch HW should be able to fwd packets to any link based
on flow rules. Set txlink enable for all channels.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 50 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  2 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |  2 +
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 24703c27a352..00bacbc22052 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1122,6 +1122,8 @@ struct nix_txsch_alloc_req {
 	/* Scheduler queue count request at each level */
 	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
 	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
+#define NIX_TXSCH_ALLOC_FLAG_PAN BIT_ULL(0)
+	u64 flags;
 };
 
 struct nix_txsch_alloc_rsp {
@@ -1140,6 +1142,7 @@ struct nix_txsch_alloc_rsp {
 struct nix_txsch_free_req {
 	struct mbox_msghdr hdr;
 #define TXSCHQ_FREE_ALL BIT_ULL(0)
+#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
 	u16 flags;
 	/* Scheduler queue level to be freed */
 	u16 schq_lvl;
@@ -1958,6 +1961,7 @@ struct npc_install_flow_req {
 	u16 entry;
 	u16 channel;
 	u16 chan_mask;
+	u8 set_chanmask;
 	u8 intf;
 	u8 set_cntr; /* If counter is available set counter for this entry ? */
 	u8 default_rule;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index e2cc33ad2b2c..9d9d59affd68 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1586,7 +1586,7 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (err)
 		goto free_mem;
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long) * 16, GFP_KERNEL);
 	if (!pfvf->sq_bmap)
 		goto free_mem;
 
@@ -2106,11 +2106,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	if (!req_schq)
 		return 0;
 
-	link = nix_get_tx_link(rvu, pcifunc);
+	if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+		link = hw->cgx_links + hw->lbk_links + 1;
+	else
+		link = nix_get_tx_link(rvu, pcifunc);
 
 	/* For traffic aggregating scheduler level, one queue is enough */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
-		if (req_schq != 1)
+		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
 			return NIX_AF_ERR_TLX_ALLOC_FAIL;
 		return 0;
 	}
@@ -2147,11 +2150,41 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = rsp->hdr.pcifunc;
 	int idx, schq;
+	bool alloc;
 
 	/* For traffic aggregating levels, queue alloc is based
 	 * on transmit link to which PF_FUNC is mapped to.
 	 */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		if (start != end) {
+			idx = 0;
+			alloc = false;
+			for (schq = start; schq <= end; schq++, idx++) {
+				if (test_bit(schq, txsch->schq.bmap))
+					continue;
+
+				set_bit(schq, txsch->schq.bmap);
+
+				/* A single TL queue is allocated each time */
+				if (rsp->schq_contig[lvl]) {
+					alloc = true;
+					rsp->schq_contig_list[lvl][idx] = schq;
+					continue;
+				}
+
+				if (rsp->schq[lvl]) {
+					alloc = true;
+					rsp->schq_list[lvl][idx] = schq;
+					continue;
+				}
+			}
+
+			if (!alloc)
+				dev_err(rvu->dev,
+					"Could not allocate schq at lvl=%u start=%u end=%u\n",
+					lvl, start, end);
+			return;
+		}
 		/* A single TL queue is allocated */
 		if (rsp->schq_contig[lvl]) {
 			rsp->schq_contig[lvl] = 1;
@@ -2268,11 +2301,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 		rsp->schq[lvl] = req->schq[lvl];
 		rsp->schq_contig[lvl] = req->schq_contig[lvl];
 
-		link = nix_get_tx_link(rvu, pcifunc);
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+			link = hw->cgx_links + hw->lbk_links + 1;
+		else
+			link = nix_get_tx_link(rvu, pcifunc);
 
 		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
 			start = link;
-			end = link;
+			end = link + !!(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN);
 		} else if (hw->cap.nix_fixed_txschq_mapping) {
 			nix_get_txschq_range(rvu, pcifunc, link, &start, &end);
 		} else {
@@ -2637,7 +2673,9 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	schq = req->schq;
 	txsch = &nix_hw->txsch[lvl];
 
-	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
+	if ((lvl >= hw->cap.nix_tx_aggr_lvl &&
+	     !(req->flags & TXSCHQ_FREE_PAN_TL1)) ||
+	    schq >= txsch->schq.max)
 		return 0;
 
 	pfvf_map = txsch->pfvf_map;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 3d6f780635a5..925b0b02279e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1469,7 +1469,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	}
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
-	if (!is_pffunc_af(req->hdr.pcifunc))
+	if (!req->set_chanmask && !is_pffunc_af(req->hdr.pcifunc))
 		req->chan_mask = 0xFFF;
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index acf259d72008..73a98b94426b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -78,6 +78,8 @@ struct otx2_rcv_queue {
 struct sg_list {
 	u16	num_segs;
 	u16	flags;
+	u16	cq_idx;
+	u16	len;
 	u64	skb;
 	u64	size[OTX2_MAX_FRAGS_IN_SQE];
 	u64	dma_addr[OTX2_MAX_FRAGS_IN_SQE];
-- 
2.43.0


