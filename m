Return-Path: <netdev+bounces-207972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA72B092E0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E9F7BEA39
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6212FE378;
	Thu, 17 Jul 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="b/PBGfjL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F272FE31C
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772223; cv=none; b=aQsuKQ/uIRMw7vhUbtNwH5ml292kBxOdhjKPzve8QscozPw1Mqu128k9ncZ1Oj5YqtQhm6zVdwYWIHZog0RpVWv4uA+H5hym+hJZieLzSBSYH2dKFyyQ7PPvDKX9PUT7hQiI5j3idxBe8RwR+886WK5Efu4qcPaqIdahnvNe3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772223; c=relaxed/simple;
	bh=zxwRtYZjmU9MiGw8Fh8VsgyIkXQeu2vXdRkxC8KgCUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opjTaNgAXmoQQkIljmrCL+3zHW+GBsE+XMOTvWqT/IkLJqbCjzUIQNCq08+1HJBZSw/saRDYt0KH4SFAu6RPtuzsDy5vWBeRdcneYuhmWQkKQLaSBqcVuZapBCxrc68yESbLIdsnqsFBhYqoUEByuBXJLkeJ79n8EemU5hHzoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=b/PBGfjL; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e6ws019619;
	Thu, 17 Jul 2025 10:10:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=E/PMIDlE/TZJV3xKKHeaotIbD
	q3SHq/Jki1ULYACoWo=; b=b/PBGfjLUqCDrw+3izayjhwcXiES0//e028kkrISp
	3ff6J44OSG1J0pBcmQZoWXQfKs+duRR7rT04c4aSJH6zOuInmSQZrjp9kj3W8SHM
	LgUk6vbWxsBEf9iMVann9WLGkfcr+iUFoWeYELAFStQeZUyHvRmUuoPFvIXnVKOB
	Dz2zcth6x3n6+WpR8kNa+SJ0aRIZ1lC6f6sBOE8iCyAIIznKSWW00b2s0uVwQQVt
	hiQShAtx+DwP1toH1df8n4QK4ylidUYEeiLZ/NZ6CZIrR+B1yzifflo4tdAlKKYM
	m+uMIECsjlw6nXVV4LVpYMnERdok6KJDPEn8ZUcZ11qYw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96tu-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:10:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:10:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:10:08 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id DD0C13F7044;
	Thu, 17 Jul 2025 10:10:03 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 08/11] octeontx2-pf: Initialize new NIX SQ context for cn20k
Date: Thu, 17 Jul 2025 22:37:40 +0530
Message-ID: <1752772063-6160-9-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e74 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=1SEgG24WuWZCEGuFff0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QRuaB7Ph14p5_dHw7dQJ3magKhbswzag
X-Proofpoint-ORIG-GUID: QRuaB7Ph14p5_dHw7dQJ3magKhbswzag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX9wZ24Qz0f1Dj scMu0cOuWldeRjA3o2EybhPJthqWQ4yWyM0TIAooDJmAqSs/Cijgvgv2n86WSd2j0spCPqmwPXc vcui2WhXUYXqNNs7Y3T/4xLfpGRrKoUH8WFnVQMdi4K1sPSAh/P2QU1lSZaQ4OvowiQytZVGmfs
 Z1SHQH8Ke3hHrCvm5UqD5SKDGZMHP0c772sA6DaIVh0gdrx3s8iLvpPGOM5iqN6wt8YM5cKA7xN GP4JoAbkpGZlg0KIvvaeNW0XeVzC8UwMVSFUBsraIdkHWFDqsK1lCJPVJiw9cdCexE3Zts4eeHB vX76ZriKD+Hza/eDNwM2Wq1mW14IJixpzop9iAofxSOpLG9U01bxHpUGT2tdtirc/2SObdfKBix
 HmknqO6FdY6ExJzQQBrP6YQW93ETcDId4s+pUEUs6K80S6PfpoOC1xHFgruQ7tJxdxjy0M/p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

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


