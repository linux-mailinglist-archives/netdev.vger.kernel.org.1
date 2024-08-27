Return-Path: <netdev+bounces-122349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E2960C25
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68AD1C22BEA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9E1C689B;
	Tue, 27 Aug 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ffYA5e18"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DC1C6893;
	Tue, 27 Aug 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765583; cv=none; b=FGsHg9EJBrTRtXmTIAbwc45SJuuu3B/xs95/OWq59w/66iTmDdwe1GxJp4RkxPzYmreKXnxFoPDfLJ6bRTO8VzJNBHrBpC0uFipQmJr7jT+AdCd9HUG66mWJJZ3VEMbJRHMOVsf6T/y4FDy/HzKGKySGJbMqAjPyyzmzphERo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765583; c=relaxed/simple;
	bh=wpaPQyLTMcILsZfXzCjWYbrxiBtNPXW80UUroHbluMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um934USWRlzcOX1CM9XR3SByG+5Wyph/VKUxV8jNurjwBwS18J1harYwQWEAOVsgpHb4X25R+mli7eur2xARJhxr8HcPdjOp2rQnLIxFImhGem65M9Zj7n+OaKUB/Ja9htHqQnxAesULyqpeGUXPQmfHtCdHhRmowbmV7iNFtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ffYA5e18; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9S4dg008303;
	Tue, 27 Aug 2024 06:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	YnLsZQRc4bC8NOacrHdfgP4/MqV+/LHzMccjNv3st8=; b=ffYA5e18C15MaBqnn
	tjaswu4D7wC1pi6Clnh48/e2HW8suZlU8wVa3g2J/oviv1clElI1SK3OtD0/HrQU
	LuiYC99IzI9FDrr59k5e7nFQ7UonFGmBIN1Efcy96dyJM90W9rbnicnMZLptHvvC
	iDGZcDp+2F+Q+fUkT6kvf0ky64H2eaTrmKCUMbSJJZmdSsTWDDkdGaILBiZpgI1m
	9E7Itvaf2uDz9eei/cj0JuEIhrHUZIMNurwS5zvNLSHv6ZtITs1YqjPWXh7PKxPI
	u64oyTqyTr0jjMxBiYm1D7nb1uSVcTjPJkQFemmqdpWhDP2l12C13KRJF3CC/UGe
	xxvNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grrcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:52 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 4D0735C68E4;
	Tue, 27 Aug 2024 06:32:48 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 7/8] cn10k-ipsec: Allow ipsec crypto offload for skb with SA
Date: Tue, 27 Aug 2024 19:02:09 +0530
Message-ID: <20240827133210.1418411-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827133210.1418411-1-bbhushan2@marvell.com>
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MZd1H6DFg1-iLQMFrOnxfj39gT1SjeMK
X-Proofpoint-GUID: MZd1H6DFg1-iLQMFrOnxfj39gT1SjeMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Allow to use hardware offload for outbound ipsec crypto
mode if security association (SA) is set for a given skb.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 41c200ee940b..6506b9893a33 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -777,9 +777,24 @@ static void cn10k_ipsec_del_state(struct xfrm_state *x)
 	mutex_unlock(&pf->ipsec.lock);
 }
 
+static bool cn10k_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
+{
+	if (x->props.family == AF_INET) {
+		/* Offload with IPv4 options is not supported yet */
+		if (ip_hdr(skb)->ihl > 5)
+			return false;
+	} else {
+		/* Offload with IPv6 extension headers is not support yet */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+	}
+	return true;
+}
+
 static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_add	= cn10k_ipsec_add_state,
 	.xdo_dev_state_delete	= cn10k_ipsec_del_state,
+	.xdo_dev_offload_ok	= cn10k_ipsec_offload_ok,
 };
 
 static void cn10k_ipsec_sa_wq_handler(struct work_struct *work)
-- 
2.34.1


