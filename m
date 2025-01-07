Return-Path: <netdev+bounces-155796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4ABA03CDC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927A61885287
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC01EBFFF;
	Tue,  7 Jan 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y3p+lyq2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5F1EF08D;
	Tue,  7 Jan 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246844; cv=none; b=d82ohJH9GUwD2KSJ6sBYuVn4VF7xcqPLxgUgp43Dk9NetoyIiz/YjEve1DCwZoL7h1V23qNhKzMGhqhNX9Rm+Fu+bUOWPfADdaPBrQJpQ1Uryswoq9rtQQPOxRdUcZXNTf3ZIhCSQnuhZ8V2ujIbpdEkEqYo7aMn/CQw7uuAmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246844; c=relaxed/simple;
	bh=oo/x4SPdWnBfTz9Yr+u0S7K/IIZkwMTrIfkNBV4iTbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itAAVst1aafpKGm4aclZqFSJYLOQEHe9/wfLIujfga71oPqI+jRe0L6vSVN/q3CIcOLeE+QIPIBGojC8a7E5O6k4F92fNLzFyIT41PkYa5TwHgKLNUvxpnWlJbN1C8pVrIH//kRE5CWtEiXIEIO26astu5vOq1LXWj5nBEXEJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y3p+lyq2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507ALkxQ022348;
	Tue, 7 Jan 2025 02:47:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
	hfEQ3fA9mlchsD2FH/JgXKTdsyBTAFInUeWJXY2M6I=; b=Y3p+lyq2Kym9e9uwZ
	cQ61y4Naxf37gZr95q8+dsRFumsA0pEEc9rYZP8hNosj5tF7U0AmJ6rmqlJnp7R5
	FJLo73DLdjiiHePI8D10HAYHuw89VZmGYRANlD9wJK1OCVNaKOCEVBVgybBFLx/3
	0E1S4SXjA8lVA8qUvi5fvcBjnXqb60dPA2awm27KNSFmb0lINkvSAqQyMoNoL4lR
	/BEUg9TORsTuNDrj2+iI+DE3Hs3junlhMa7gwEDWd3EhI8ME+79H6O8lLVlhCzKd
	DC8f9hnzXcCU0+jNIYGMI+UyYljerRG6P1hrznrWIlHqAWTE+SX5ubNEHR/4sWLi
	1/N2g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4412etg1an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:47:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 Jan 2025 02:47:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 02:47:04 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 82F8E3F704E;
	Tue,  7 Jan 2025 02:47:00 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 5/6] octeontx2-pf: Prepare for AF_XDP transmit
Date: Tue, 7 Jan 2025 16:16:27 +0530
Message-ID: <20250107104628.2035267-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250107104628.2035267-1-sumang@marvell.com>
References: <20250107104628.2035267-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aFywg9LBOn6N3fyvUFWI05Y6-3yydXHG
X-Proofpoint-GUID: aFywg9LBOn6N3fyvUFWI05Y6-3yydXHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Hariprasad Kelam <hkelam@marvell.com>

Implement necessary APIs required for AF_XDP transmit.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index dc68d2aa0a0e..24faf9dc41e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1186,4 +1186,5 @@ static inline int mcam_entry_cmp(const void *a, const void *b)
 dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index c8b11d45debf..80769c8ffb9a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -22,6 +22,12 @@
 #include "cn10k.h"
 
 #define CQE_ADDR(CQ, idx) ((CQ)->cqe_base + ((CQ)->cqe_size * (idx)))
+#define READ_FREE_SQE(SQ, free_sqe)						   \
+	do {							                   \
+		typeof(SQ) _SQ = (SQ);						   \
+		free_sqe = (((_SQ)->cons_head - (_SQ)->head - 1 + (_SQ)->sqe_cnt)  \
+			   & ((_SQ)->sqe_cnt - 1));                                \
+	} while (0)
 #define PTP_PORT	        0x13F
 /* PTPv2 header Original Timestamp starts at byte offset 34 and
  * contains 6 byte seconds field and 4 byte nano seconds field.
@@ -1163,7 +1169,7 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	/* Check if there is enough room between producer
 	 * and consumer index.
 	 */
-	free_desc = (sq->cons_head - sq->head - 1 + sq->sqe_cnt) & (sq->sqe_cnt - 1);
+	READ_FREE_SQE(sq, free_desc);
 	if (free_desc < sq->sqe_thresh)
 		return false;
 
@@ -1400,6 +1406,21 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 	sq->sg[sq->head].flags = flags;
 }
 
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx)
+{
+	struct otx2_snd_queue *sq;
+	int free_sqe;
+
+	sq = &pfvf->qset.sq[qidx];
+	READ_FREE_SQE(sq, free_sqe);
+	if (free_sqe < sq->sqe_thresh) {
+		netdev_warn(pfvf->netdev, "No free sqe for Send queue%d\n", qidx);
+		return 0;
+	}
+
+	return free_sqe - sq->sqe_thresh;
+}
+
 bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
 			    u16 qidx, u16 flags)
 {
@@ -1408,7 +1429,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
 	int offset, free_sqe;
 
 	sq = &pfvf->qset.sq[qidx];
-	free_sqe = (sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb;
+	READ_FREE_SQE(sq, free_sqe);
 	if (free_sqe < sq->sqe_thresh)
 		return false;
 
-- 
2.25.1


