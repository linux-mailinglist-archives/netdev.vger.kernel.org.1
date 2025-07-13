Return-Path: <netdev+bounces-206442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C933B031CA
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F041A17BD16
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD65281358;
	Sun, 13 Jul 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FFY/nWTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C2277CB3
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420739; cv=none; b=Ir+zH8oiesRXx2H6qTLrJkVJqBsMVR96JBjD4lYFzXiw2ioU+0Q1USiaQLDLqpow995wwTB26cU/u++IAD3ubELxVgy2tlb0rjtT297H6FLyY0jQCjSK4+zXvEl8MIUuVmvy/q9+a7EbR3pM2VI+AryTWD4CuLfTfOMNa6z3MCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420739; c=relaxed/simple;
	bh=7iTmpEkIucCSGyvx3qB88gP14e5Ca/SnEczrO/VPcSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyHqk5mY8tNfyJZdaLO56RgHTIgloO9Oa+mldsFhlNEUUbDTfgjn/XCMkBscejDj9m0iS/LaTNiVzaup6egAHKr9OlgBNdVnjzHOBu0KiEH9IO2eXgh+T3cvdmF66YbdiVUEoOYwB4PBlxKhE3FggkdvBuoppsdbWJImD5WbPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FFY/nWTJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DFPYcm026682;
	Sun, 13 Jul 2025 08:32:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FJbVGpIOEX5iecJnRPyji5i/i
	5jqhqNPG2ElIf/+pOI=; b=FFY/nWTJLTiNmUB+MU9a9Eqd1hObmDgChRocT3NY4
	Gsuutv6pqQmDDMAq7UU5oQ1Pb/KA91WcbwjCeK/jMZ2g5AY4X/iTfDQe6NPT+hZp
	Ozws6Hhh+G7PiltDhmdMKWLBsRSzhPf+uZgwzN9+wtC19INEMVjvAo6AuSQWUtaB
	norjSDyI/n3uaNGxT/9zAqctw9ImQ/ju14hnvdpZDuo+QxRxmVr7NwkxVrgBtLds
	ru2Hee+3I/sptSjrEIaqeXaJWi1fp/me8oQW+xw80dkCACUlTTjxcm38TUWaHd7d
	Nsxoxfq0cmLhHQxmQKcMVZZGj2URemx0GuYvbDwLm3ebA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47vbyd86j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:32:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:32:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:32:09 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 229CC5B6941;
	Sun, 13 Jul 2025 08:32:05 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 11/11] octeontx2-pf: Use new bandwidth profiles in receive queue
Date: Sun, 13 Jul 2025 21:01:09 +0530
Message-ID: <1752420669-2908-12-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfX3NEPMXCHAggx gkvPUh+aiM92gpuWsKNL14FoNRbh5LyOhAgUli6sqm/ajbAH6NHs70r9lajI03J3JRLd1bjs5JQ TnumCX6+TRngMxAL2Ff7aKhMbuXJssQ90p/pRxX08ql0mhbYWOG8PsGYSvm2lS2ObYo/LT5XWFo
 BdbRprcCF8JOvgxKxDExXwKwcYd8rO75L1L9vl/Aloew0oLCfOZTKc2lrGtBpw6Bx5KOgzbVU0G QT3ZUK/p/h3aTQRvxPIoL027jJ4UruB0/MDLxMbBON7J/iJWlt7qcA7sFWsbisYnmSGLb08vQKM Eqc+oKOW6liDkHwYZ+/hJik48TwPfrhEASKmroMuTuDxw1CVJ2T1z/nZ1fPMA7uqOYNZ/zNiFTI
 1Kdzg+Ug3BBJ9JZ2fuONy4w6POsjPDYqI+Yjrymda+K70Z7blIseKolasOf0B+PH0qIG39iC
X-Proofpoint-GUID: XPNGDk5GQG3YjYpiHNT7elpa4wwzNtf8
X-Proofpoint-ORIG-GUID: XPNGDk5GQG3YjYpiHNT7elpa4wwzNtf8
X-Authority-Analysis: v=2.4 cv=C+TpyRP+ c=1 sm=1 tr=0 ts=6873d17b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=VbpyGYBai7zdicxOX80A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

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


