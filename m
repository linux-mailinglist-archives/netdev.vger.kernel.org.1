Return-Path: <netdev+bounces-206439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC8B031C8
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA54917BCDB
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87D27F183;
	Sun, 13 Jul 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TXh/+MgE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718827A93A
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420726; cv=none; b=th7us4PwP+foL5kDaw4GfY1S+OVs9TpAaSBQT098iopJgLTrIUAv3bLADdAkcUYhWnDGUFqVVpqsvPp0E58XlnMbeTFF/fYRjtLW4G5cZFz1OO27xvRHiSEYLQXU4Pp/+boOQycVAhsM6ewVV19OLZUUHGtGxhSi0Xe2IE1RckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420726; c=relaxed/simple;
	bh=zxwRtYZjmU9MiGw8Fh8VsgyIkXQeu2vXdRkxC8KgCUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE4er5YhS7SXnPh+j48KoIM1t5zhsp358tLyK7tgTqPjyu5GFwnYerxGH9XqKO1nRjImjXeTDpisTEyzvR9YgtaqRcGwzTD+LGk6wemows+fVBH22h1dVZN6Tfi3EYov1YVxzne9ljKYltLlOlUOgQVj9E+uRSG27LAqYC4wv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TXh/+MgE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DEmgaf015619;
	Sun, 13 Jul 2025 08:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=E/PMIDlE/TZJV3xKKHeaotIbD
	q3SHq/Jki1ULYACoWo=; b=TXh/+MgEGaq+gmSeGIvKLUSjY6DYJwHtEqz+4nY9n
	0SLmq+FrhwKypSPilMi6RC1qd+Tyfu5fY8xFblxrZM03Wg21gin33zFKGLWaQCTK
	7mXsNBV8OujjrRRWis7wvmo5pDB3K01BZsBcv21kPiKoUmXIXRvBCovqVQ9e4Xi8
	msenzTfYvHPHU9G36p1a2DkgC9DNDQm1SOa5ofiDoJ9zuL2OBINYKTf+DI4Axu9c
	SsmI0ebn1TZLfkvA9HFwYhoOUgecN8vt4EuopUDQUplxu/0NreKmrcsJgLYl9KUi
	SiVqBBaWEJ9WrIJkUo1JKzabTI4iMKBe+fn2tJQWkxNeg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47v1dpgvcu-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:31:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:31:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:31:56 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 4AD7D5B6941;
	Sun, 13 Jul 2025 08:31:52 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 08/11] octeontx2-pf: Initialize new NIX SQ context for cn20k
Date: Sun, 13 Jul 2025 21:01:06 +0530
Message-ID: <1752420669-2908-9-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfXxjEuurwTFBoR N/od1AwNQhAtaIlXIWcYY6UcZ/rZJlQuWhqb4Hg9odrAabTG09zDjBScBihn28MfVVXqP2YywUm oNPcZ1Z/UtSFHwk99XY/572wq0G3bML1czK2lwhs8/95bb6InnDlr7K9Lfdo1dTTb6Rf6E/fm8g
 X5UgoWPaXb4yQqPsxJV04VQvYQkKPDY5z8woRgTxy3it238WPsI5Fan2JipNQV7VMjPBGtgOjbX Dhhr58GiW5Cn0RbJeEy3qiexYNQhoammb8J63LRcxSetAd1BvJAuXsiBTT5khN23DlgeuEGsc7/ Kej9cQ4IJ2kxvelAawCutgeBpP15tqTk/5MBeSNVSizrnbISdjsaVoYVsQZUOa0OPpgO0IPXCeZ
 x89VTbdTpjlzkfYQc6CUq0RK1iDhlRvJmLcLuIdSN3La2vGYk8UfKJJf/ryQG3iQAnVZ+tvQ
X-Authority-Analysis: v=2.4 cv=Y8j4sgeN c=1 sm=1 tr=0 ts=6873d16d cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=1SEgG24WuWZCEGuFff0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: kPSqEJ_3nA-Zey62GpFjNOsfEwLxsybv
X-Proofpoint-GUID: kPSqEJ_3nA-Zey62GpFjNOsfEwLxsybv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

cn20k has different NIX context for send queue hence use
the new cn20k mailbox to init SQ context.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index 037548f36940..4f0afa5301b4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -389,11 +389,45 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 	return 0;
 }
 
+static int cn20k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
+{
+	struct nix_cn20k_aq_enq_req *aq;
+	struct otx2_nic *pfvf = dev;
+
+	/* Get memory to put this msg */
+	aq = otx2_mbox_alloc_msg_nix_cn20k_aq_enq(&pfvf->mbox);
+	if (!aq)
+		return -ENOMEM;
+
+	aq->sq.cq = pfvf->hw.rx_queues + qidx;
+	aq->sq.max_sqe_size = NIX_MAXSQESZ_W16; /* 128 byte */
+	aq->sq.cq_ena = 1;
+	aq->sq.ena = 1;
+	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
+	aq->sq.smq_rr_weight = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
+	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
+	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
+	aq->sq.sqb_aura = sqb_aura;
+	aq->sq.sq_int_ena = NIX_SQINT_BITS;
+	aq->sq.qint_idx = 0;
+	/* Due pipelining impact minimum 2000 unused SQ CQE's
+	 * need to maintain to avoid CQ overflow.
+	 */
+	aq->sq.cq_limit = ((SEND_CQ_SKID * 256) / (pfvf->qset.sqe_cnt));
+
+	/* Fill AQ info */
+	aq->qidx = qidx;
+	aq->ctype = NIX_AQ_CTYPE_SQ;
+	aq->op = NIX_AQ_INSTOP_INIT;
+
+	return otx2_sync_mbox_msg(&pfvf->mbox);
+}
+
 static struct dev_hw_ops cn20k_hw_ops = {
 	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
 	.vfaf_mbox_intr_handler = cn20k_vfaf_mbox_intr_handler,
 	.pfvf_mbox_intr_handler = cn20k_pfvf_mbox_intr_handler,
-	.sq_aq_init = cn10k_sq_aq_init,
+	.sq_aq_init = cn20k_sq_aq_init,
 	.sqe_flush = cn10k_sqe_flush,
 	.aura_freeptr = cn10k_aura_freeptr,
 	.refill_pool_ptrs = cn10k_refill_pool_ptrs,
-- 
2.34.1


