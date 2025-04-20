Return-Path: <netdev+bounces-184297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EDA9468D
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 05:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2603B8FC7
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 03:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D7132103;
	Sun, 20 Apr 2025 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OuxSpPQM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A949D299;
	Sun, 20 Apr 2025 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745119527; cv=none; b=eTMm911grvczD0FwOJoSQblak3I+mqk3pcrf+zJIkTi6O1KzU3TsOroHjpifhA/HQYL4eb1iZAhgN1LW02nHKnxEoz3Vjb4Lzgz49XpxCWi2vEEJjucgQ9jy40gHW1XohPQYvWWofNGugetTvWcZbD5LmdBQnA74vKQx2SmmBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745119527; c=relaxed/simple;
	bh=4PTMLF+2WYhuj37KXBAWvcLc4lKUp79q57tkZLc0AVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwOkOXcoRwPl043V3LF2F3CER558ZiRJEuOMWJ07huq7veKoybpeTd3o2xweGbyYIcL52wt1xFLJgkqXc+abwtud8XDsEQcrr5Ezu+swVuUDEo8WdlJJCkplKpPqYMvufLGtcXcYZBp7C/NV9echNKFJE9QMP8NEGmv2w5IJGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OuxSpPQM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53K3CbYT011446;
	Sat, 19 Apr 2025 20:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5w3IvGl6OlZmAqeGCF3dB3I
	FoWI+f6VbmMyXYd6YiRw=; b=OuxSpPQMBfHktZfjEjf3qYdDqeKZO44huWFHiK7
	SNE05R/ofBMtpMORzYx/cNNBBTLlYR+k5zWSqxAob9sGPmDiu/vBl7FzmRRtzdXS
	I5jbluOR3DPgEAwLIlBHxP+DR9HWv3/JFN0pmpxUdUrlAqEl9lcTqAkLagTJSzAt
	4ItavtEXrSHGxlOZ5kKLsTlH1xev3NH8z7HmlkB9IvdsFnimByFZ3Zoi/lE8L2Om
	E7HxrBWiZADgO8h2uYj9XPzZ73QZirJwOPP+lC+BS0hcIo8bWSCzzMCXMiR3+8QJ
	wPliSaP6Df5Rql9lceVN5o4JhqYytgCo7ZqcoNC8JJ5FXXQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4629a685yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 20:24:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 20:24:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 20:24:34 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 3AD486267C3;
	Sat, 19 Apr 2025 20:24:28 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        "John Fastabend" <john.fastabend@gmail.com>
Subject: [net-next PATCH] octeontx2-pf: AF_XDP: code clean up
Date: Sun, 20 Apr 2025 08:53:50 +0530
Message-ID: <20250420032350.4047706-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vBTczJX-0XK-wFvID-dMGKb4mbvFOuGA
X-Proofpoint-ORIG-GUID: vBTczJX-0XK-wFvID-dMGKb4mbvFOuGA
X-Authority-Analysis: v=2.4 cv=ZobtK87G c=1 sm=1 tr=0 ts=680468fc cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=qgJZpCoBWuLJu9ZvEgAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_01,2025-04-17_01,2024-11-22_01

The current API, otx2_xdp_sq_append_pkt, verifies the number of available
descriptors before sending packets to the hardware.

However, for AF_XDP, this check is unnecessary because the batch value
is already determined based on the free descriptors.

This patch introduces a new API, "otx2_xsk_sq_append_pkt" to address this.

Remove the logic for releasing the TX buffers, as it is implicitly handled
by xsk_tx_peek_release_desc_batch

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  5 +--
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 42 ++++++++++++++-----
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 1e88422825be..7e3ddb0bee12 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1107,6 +1107,8 @@ int otx2_enable_rxvlan(struct otx2_nic *pf, bool enable);
 int otx2_install_rxvlan_offload_flow(struct otx2_nic *pfvf);
 bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
 			    u64 iova, int len, u16 qidx, u16 flags);
+void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, struct xdp_frame *xdpf,
+			 u64 dma_addr, int len, int *offset, u16 flags);
 u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 				   netdev_features_t features);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 0a6bb346ba45..9593627b35a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1410,9 +1410,8 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
 	}
 }
 
-static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq,
-				struct xdp_frame *xdpf,
-				u64 dma_addr, int len, int *offset, u16 flags)
+void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, struct xdp_frame *xdpf,
+			 u64 dma_addr, int len, int *offset, u16 flags)
 {
 	struct nix_sqe_sg_s *sg = NULL;
 	u64 *iova = NULL;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index ce10caea8511..b328aae23d73 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -11,6 +11,7 @@
 #include <net/xdp.h>
 
 #include "otx2_common.h"
+#include "otx2_struct.h"
 #include "otx2_xsk.h"
 
 int otx2_xsk_pool_alloc_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
@@ -196,11 +197,39 @@ void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *sq, int
 		sq->xsk_pool = xsk_get_pool_from_qid(pfvf->netdev, qidx);
 }
 
+static void otx2_xsk_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
+				   u16 qidx)
+{
+	struct nix_sqe_hdr_s *sqe_hdr;
+	struct otx2_snd_queue *sq;
+	int offset;
+
+	sq = &pfvf->qset.sq[qidx];
+	memset(sq->sqe_base + 8, 0, sq->sqe_size - 8);
+
+	sqe_hdr = (struct nix_sqe_hdr_s *)(sq->sqe_base);
+
+	if (!sqe_hdr->total) {
+		sqe_hdr->aura = sq->aura_id;
+		sqe_hdr->df = 1;
+		sqe_hdr->sq = qidx;
+		sqe_hdr->pnc = 1;
+	}
+	sqe_hdr->total = len;
+	sqe_hdr->sqe_id = sq->head;
+
+	offset = sizeof(*sqe_hdr);
+
+	otx2_xdp_sqe_add_sg(sq, NULL, iova, len, &offset, OTX2_AF_XDP_FRAME);
+	sqe_hdr->sizem1 = (offset / 16) - 1;
+	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
+}
+
 void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
 			  int queue, int budget)
 {
 	struct xdp_desc *xdp_desc = pool->tx_descs;
-	int err, i, work_done = 0, batch;
+	int  i, batch;
 
 	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
 	batch = xsk_tx_peek_release_desc_batch(pool, budget);
@@ -211,15 +240,6 @@ void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
 		dma_addr_t dma_addr;
 
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
-		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
-					     queue, OTX2_AF_XDP_FRAME);
-		if (!err) {
-			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);
-			break;
-		}
-		work_done++;
+		otx2_xsk_sq_append_pkt(pfvf, dma_addr, xdp_desc[i].len, queue);
 	}
-
-	if (work_done)
-		xsk_tx_release(pool);
 }
-- 
2.34.1


