Return-Path: <netdev+bounces-207229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EDB064D8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4431AA5E3E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C509281513;
	Tue, 15 Jul 2025 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="b2QUpikJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43C327F16C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599000; cv=none; b=JFyIjj9d0GoUvHmKCmmkeJzCCmciR9ukl2Snuigjfi4Ab4ReOyS0mPZHUFbj4A2AlT/q0/wOZ3d5qmazpNPBzPRuoFpKanpLEv+Kcp9nurE3BKK0c4Z4Ow5am0Mw2dtJW67s40kiBEPLYubYWX2whdARBujtDCkUzgFIiitj3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599000; c=relaxed/simple;
	bh=7iTmpEkIucCSGyvx3qB88gP14e5Ca/SnEczrO/VPcSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxRWJvw50ZldL9H5eygSZ0d01DFVcbIbMKHYv6ZrhVPUZC+D6eGNwoGdrnalJWm9wFKUspKtx6pf5la0oc4e3/2cE0XVhtGRK4oOCudLpGoVartinofBvBYKtbRO0t3HI8bUIXNHzS2QVzP7hNWPiCxk5FA2El3Prd7zKNwangk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=b2QUpikJ reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEk765000654;
	Tue, 15 Jul 2025 10:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=FJbVGpIOEX5iecJnRPyji5i/i
	5jqhqNPG2ElIf/+pOI=; b=b2QUpikJcg0QgsqaU+zbvIctSkhOcDc32uRJOlk3d
	F2RagssYzQzHb6xhZNc2n58J9rvnK0mi7O9J8sYuXcEO0nZKaMx/evDG1b8EUTYU
	3ZH6J9VlOk6fCMDklxeVqgJWhiJPG9SINiBbiO92VYNo4765l/0FHQnYvHlfD4Oc
	30p1dCaOmU3ayjpANgBLo99g1HiaJxWrUTz6yMuserJcY6YT+JtIFKDzjHvI/9AQ
	9OTCX1OruXTHOy4/9XHSRlC1sQNMXhGy3Ms40eFcaqlxZTEreB4CUJTy1WNbjyAh
	V5a8VuHZ2GZhkIK9F9M8Iw1y2KLT+jzGEaoRPVYQXzoAA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wbm52bdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:03:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:03:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:03:11 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 786A65B692E;
	Tue, 15 Jul 2025 10:03:07 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 11/11] octeontx2-pf: Use new bandwidth profiles in receive queue
Date: Tue, 15 Jul 2025 22:32:04 +0530
Message-ID: <1752598924-32705-12-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=687689d0 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=VbpyGYBai7zdicxOX80A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dGsz0XnQCYgUPgFUZKQ8_ZvNqL3bF8Ro
X-Proofpoint-ORIG-GUID: dGsz0XnQCYgUPgFUZKQ8_ZvNqL3bF8Ro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX5ZEKH0e4bC+l njDRn2gyK1My2jFzi+ENpVG8bZu+cAzisjcd9ITh9lO3T1nlD22Slg/zkiiArOW3KrRiwldgMbj RSorgSVCtnkN2fkvwJRe/jVexjZXeqygZ55kJtQeR4jPA0DHLKdFQJJtbS2hZiOHXY7VjCyL/CR
 JTbC7hlf5hAN6TBH4MKblo1epf7tprJpbTCdCq/XrjTLyJdVIxj/DaiTfpwCv0//S6K6kWHej3t EF3xzmYKbAX43d7/hYbd2T67vmDG05iZRjZGYykwQ4KyDlCvkTGKg38GtVln72fVrgZaBw7Qk7/ djOKnS2T9KMb6Zwkcu9k851kAZg/ZEMiUvEmiYHnufPz2f+hjT7KPxURvF5XQbaSiAEZw1INHLX
 e3AK9EuJ0Qe3AzzFQifzydSD9HuDT2qvjqvZkVqD0bRGqDiKpJgNSzizv2ccopptUkMiC/MW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


