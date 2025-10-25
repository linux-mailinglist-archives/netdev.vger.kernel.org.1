Return-Path: <netdev+bounces-232803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D3C08F30
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9F74E653A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294E2F532F;
	Sat, 25 Oct 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BYIfDHuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64B1E1C1A
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388438; cv=none; b=AlSVQKl+RY1XX7ylAnStgbtBIC6HQWKkG5+HIHk61fxCRUny7MDtzZ+7OP9BoivdXbWotVh21p1vzhtwSk1CrBhNBOKC/hTt3YHY3z0hTCihsZTuFTEnK6thLVGYVDmUdfRBfbOJLlQDIZVCH5VPvkDInTX3ywCgKDBenCCCjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388438; c=relaxed/simple;
	bh=iu6rVu22xHHlcxyAgbZgXGjRjlw7wD82V3oek6jlRXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qt0zm0fR2/Y+iAKfFRfHKUFrarpyf+4FX60SPfxxGd8OfnRTD233KUJt2FjlHVDgMIlx4ozc2B5omqNpaul0YmvwiMFPDts50ZTG0KLHrBVYd4obMrUFFdvg45LHldANXQKUezR9sPed2BsCkY2nR0cC3OfpD5kAePQNIprcTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BYIfDHuJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P9QI4c670930;
	Sat, 25 Oct 2025 03:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=KsmIA0F7fAJoe39lNsLUGPy0c
	KfVTv0ysENymq9NJ9U=; b=BYIfDHuJSnxLhtP+6Kiy9GnXzxDyYmk8WUWQmARct
	KgJfNvMxTMYqQubrfx8Inn9jiwV66AhOpOc3eTsr+LFLVbJGTPrHOEQDl3lnac+D
	0iOliWkBg3cQ+kNu0bOYx8oxrhZqHB42FndN89PEIhY2Cnv9MmAzK1qB7QthuAI9
	ZJi3/ZwzPiouE/nOap/mBj2hum5L6FSPeshx1lR7w53hdQc0zKFHmDxDDzu4o4wP
	8mSX/lzkDvTcWPoaQY94bJmNsyd4xdouAlNWaBPpP9BijItiOl8Q/w4b5rOuhv4R
	DqIveonSb4UF05mbGiYcdMts9DCa7ydOW9Oi3Zf/uIu3A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0uwh02v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:59 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 2CE715B6921;
	Sat, 25 Oct 2025 03:33:44 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 08/11] octeontx2-pf: Initialize new NIX SQ context for cn20k
Date: Sat, 25 Oct 2025 16:02:44 +0530
Message-ID: <1761388367-16579-9-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6vWAuYi c=1 sm=1 tr=0 ts=68fca78e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=OxDJ2-l6M9DZQLLjUcoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Ur4HYDF3SzcLMd6rfeGo5Pjd2g8HGXw7
X-Proofpoint-GUID: Ur4HYDF3SzcLMd6rfeGo5Pjd2g8HGXw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX3RG3KOBLbc54
 14wACfCK83s66Rfjt29J93OAlo6sIc2pjlyvRWNvsO7i9/BFn3JhGZcCMFXdpW91VIqCaR/NOhC
 pgwb5wii2oUOJCyQw/rHMLb8yCMNa4NW6HIGX/Uh6jyqAj4xKvZLOn/SVULFE4t2MTMVNlA6lvs
 RxKY2b1pjlDxpSW0UuVlisrWLKGSxon0AUvvQpBaqMjEAdbGkRk5ds7UJdXHW6+NObx8PiG7jb3
 nwjyMJk5R4ThwuFNZOdU3N4FSBGU0S6v7GDXZcZF5a9myzujl9PTymQSj6JetFSQIBQSa9d4BUW
 j18a9PgF3qO+g9EhhVpAK38ankt/thibf7be2sbP1bYEJUzbUZJpqJbaBDdYVvF+SbSTgLV0/eK
 UjdUlkC2UIf60VTG41fe+gTxjgQVAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

cn20k has different NIX context for send queue hence use
the new cn20k mailbox to init SQ context.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index 6063025824ec..a60f8cf53feb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -397,11 +397,45 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
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
+	aq->sq.cq_limit = (SEND_CQ_SKID * 256) / (pfvf->qset.sqe_cnt);
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
2.48.1


