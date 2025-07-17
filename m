Return-Path: <netdev+bounces-207975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A26B092DE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFED4A624B1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556C2FEE02;
	Thu, 17 Jul 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VdtixoaO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707442FD5B0
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772231; cv=none; b=gIUwUrQ3G5gu5EaSAbPpAKBBXnsuaYk9qEE6qadH6+Yb90I3ELMmpKGIXUgkQzJyEgCYEhH/sqNMqc+fzUneyfuIsAHG248hnk9zOwLJ6Y0yr8mxNR5NtY2/VEya4OV88SabHFOFXrC2TH91rNeJEQt/65wTaF9Y+yxyUOjCNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772231; c=relaxed/simple;
	bh=7iTmpEkIucCSGyvx3qB88gP14e5Ca/SnEczrO/VPcSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DarP08Fw4Rz2E2WUp4PHwNf6Ps/c73x0vAWJ+YS1qyw+pZyWWl3dxzYZsaHakmcPX4CsmIGtvTJxA7PoQsMRXg3VWRMQKOd+Enlbv7WhQO+EffNu0Mxb395KSTZMupsIPNdxXvY8kbTLmLe77hv2Dq8fmFaQNAIGv/0mATjfdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VdtixoaO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e6WR015497;
	Thu, 17 Jul 2025 10:10:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FJbVGpIOEX5iecJnRPyji5i/i
	5jqhqNPG2ElIf/+pOI=; b=VdtixoaOo1jqpTMbkRU/AATtSs4IOBR2Ku8j9CdRq
	XOtwl8rGGERLgqNAq82GOmS3ktiLGa0AuHk+M+LRH9P5yoi6DMKrhLL2HsvFchJG
	Ja51ApqIfX3A/CA41czPtSSsCPhvZEn8pT4o5dVllkpyhrmNDNR1aW0X8EgvUUyk
	OM5hnXxZpv1x5wafRRuwpOZDDVi/cu5tEtLuXw/CLAGuLfXjl43qYsryEAAgDnJj
	sKJbD/bOdKGGLTAYnWELwkn/a7oxKZikNz0PVNRJ9rULOvGGh7iWyTJOOlGsXrqv
	wdzbiotXMfsBqlAzHDMpDAw0HxNiRf3LSvvO5Y7Sr4XtQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xxmq0y9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:10:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:10:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:10:21 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 9F1173F7058;
	Thu, 17 Jul 2025 10:10:17 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 11/11] octeontx2-pf: Use new bandwidth profiles in receive queue
Date: Thu, 17 Jul 2025 22:37:43 +0530
Message-ID: <1752772063-6160-12-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=TMpFS0la c=1 sm=1 tr=0 ts=68792e7e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=VbpyGYBai7zdicxOX80A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfXz0MYLiDtpreH SzNz4e3G+QuQJHu8cvtZ3RDmIGJMxnhc5Q4S0IPQxTS6loK/zpwmWJIlsWS5nMqkiKFp5lr5NzM 8z5raVO4lQq86TA0cCboDUJurV2Ll8NfK66bKQNyIuK11F9Q7nF/Y/6V4kzjR1mKLTnbvFXf2zw
 UpZKL1NnD/QC0nFp97wBRks52s6UYQeoo/hjl1C0WRlNgZAyRMaqpzW4SiesdBIN58Ir4DyhX5F NUVd8xyfYbTSt8M2tEkX6JtGPVnMF34jGz2rC3T8VWcxGtWnlmruSClwM391xcCDdSaEACa7VP+ ui3PWaHBjt9iGf1HgsEdOKv7Mn9lnCwvzWase4GmHY303GDTgbPbsAWpg+C80FFADZgx+q4xA1f
 syPwkvIVjuUV6chMnfwLXUboyMZZtadPjNwMLMflz4zy275rAPQ7Z28AmBjbEdOW3CtOC9Kl
X-Proofpoint-ORIG-GUID: YuYiTlhqPIpQOnOA9Q66i2vHnzSIW2_C
X-Proofpoint-GUID: YuYiTlhqPIpQOnOA9Q66i2vHnzSIW2_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

Receive queue points to a bandwidth profile for rate limiting.
Since cn20k has additional bandwidth profiles use them
too while mapping receive queue to bandwidth profile.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index cab157aac251..3e1bf22cba69 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -341,6 +341,12 @@ int cn10k_map_unmap_rq_policer(struct otx2_nic *pfvf, int rq_idx,
 	aq->rq.band_prof_id = policer;
 	aq->rq_mask.band_prof_id = GENMASK(9, 0);
 
+	/* If policer id is greater than 1023 then it implies hardware supports
+	 * more leaf profiles. In that case use band_prof_id_h for 4 MSBs.
+	 */
+	aq->rq.band_prof_id_h = policer >> 10;
+	aq->rq_mask.band_prof_id_h = GENMASK(3, 0);
+
 	/* Fill AQ info */
 	aq->qidx = rq_idx;
 	aq->ctype = NIX_AQ_CTYPE_RQ;
-- 
2.34.1


