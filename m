Return-Path: <netdev+bounces-207226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42AB064D5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BF35672D9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D22F283FCF;
	Tue, 15 Jul 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aT5JcsKM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0D27BF89
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598987; cv=none; b=lLa8gkp/mDfkpPwTR9FlHyCoPMhqZcqbZJd0eW0nV1UP7Nl9aoHPV/8/WAfuOEH+ufm6lYq2hcwAHOmElHuTjFFZtFdOFOp5vL2AuAdhcpZL68KFLA0uqaNfL0fbCDdp+96B94Ym9KVIfId2BaM4CHFLEQ+kKQlnkCO0XIxKC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598987; c=relaxed/simple;
	bh=zxwRtYZjmU9MiGw8Fh8VsgyIkXQeu2vXdRkxC8KgCUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eehljVaM+0sUuBjo+yucxC1Q+i9NTAdrCLzIJpivCVFX8vAEuwMk8YMTlUu6bvmhdYuxIzY+8vRUJwF2x6KKzMw+tLBFlCITc+rx5g5gZFlSsvVk/chhO9Mdk6lXH0Xp7+O6pqwZXkD4TCsZNlOJ5kVkDXlisNgudMwkATGWIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aT5JcsKM reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBnLQs032046;
	Tue, 15 Jul 2025 10:02:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=E/PMIDlE/TZJV3xKKHeaotIbD
	q3SHq/Jki1ULYACoWo=; b=aT5JcsKMerypFwMNvJpQSVBPMXjZGoUuVrPjggabz
	8P5WSfFj5uwg5U+KEorSDS76edGtWsi5NYYu04Ndo6CGv05U+tNCRjrG1rv9Cd4D
	zyBxjPQQ6umzb4RrcOAVdvXXdMI5MOB8oS/hFbbVE7MXTkrKuMTQVWNaXV+8QdF2
	1AJHCYqAYGr4TvLhpfmKsJk0MfBOXNvSfLjHJPzWrSUVkBMx80aGS3M3Raq/ti1V
	1f1mlOST/NYYi4bPENduUfY5rtt0ixV7LOPQraSk1G7+svyvqMRKav9lRoundjKR
	WJJb53IRv0MR4CMBErisFwtYempCPSG3pcG3tZ7C7rJsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wpevgr39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:56 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 4CE8A5B692E;
	Tue, 15 Jul 2025 10:02:53 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 08/11] octeontx2-pf: Initialize new NIX SQ context for cn20k
Date: Tue, 15 Jul 2025 22:32:01 +0530
Message-ID: <1752598924-32705-9-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: P7bQ75WP7Q905HvhKuujYJC4UGbu516O
X-Proofpoint-ORIG-GUID: P7bQ75WP7Q905HvhKuujYJC4UGbu516O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfXzGzQZBNAZ1PQ q7TnzvU7575NHQ0BK4lZRv+Y2Hxq4I5fsN+zFfi6SBPVyKeMTSGTXLGsIqwkq4QB13/4EmKjp0X iwkUxhV6vFE1CCopOYCtBDC/MZ885L81EnfdQWdVRp+0Qts+kN7qTymMJJK1Sm+Sv4MzY8KXklQ
 g3zt1w0De5JVUIGkE2bv2kKBjekbOIz02dTZwPy4d8p6iP3pHjzH2ZRAKf0LkBQaUsZm2W6rxQ1 Eq+Q9//7wyPMnmYZvLpOUsEvM0uKheIDnsIkaqgey0UfrhxjQ5Q3WscDIQhvNDo8i9ODBiZ3b/b MmrXAdU5DIf0O3vFiie42/IAf2gCy2BkBwAtrM7UdkfT6wHHuTm6Ok2bBOy+IlE8Fx0b/Wc7aiX
 yhsDpYBTmPMfHtre7S/BSi/FT7T0HhASji/ugGf9mK9M0DNq9gtEa0iRruVt3zJo9vFP1lSp
X-Authority-Analysis: v=2.4 cv=Pav/hjhd c=1 sm=1 tr=0 ts=687689c2 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=1SEgG24WuWZCEGuFff0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


