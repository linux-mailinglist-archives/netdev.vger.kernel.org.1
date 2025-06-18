Return-Path: <netdev+bounces-199094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20FFADEE9A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE1167AE6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DC2EA734;
	Wed, 18 Jun 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LynolH9u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044E1DE4E5
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255059; cv=none; b=nxCv1z/4i/0gg2jTGkFMRFKkvgbLRFFwZd7UI8Nr9lwMsysxw6gOkXsmk8JQXzbaXd+630DqOQVQCONMsltALVCLzvGeBwhVt990ba6rswTt0AMmc0Sk50APZh+Dwkkjy/CBQ1p+ikR1lIflgHll60w1xeFARubr8rfsuAh0klo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255059; c=relaxed/simple;
	bh=aUMGU24e/U816ucsvaMp7F9X6fMCmk6K78hrDWDCXVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzJ+BfaVJzZrYQURNFv1lgz1A/vYZtNpfi99B2/GpeiCjvMZAi5xQoChrL7xBLTTnlAoXdVeI+d+FE4hlX4neBUIVxR1BSZmIUuXcS7nfesEEUFv6UFEJ7OcLFmJcYL0sGDu+1Hj5z1lust8iRWEHB14sPZu0otoV5Lx/swe2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LynolH9u; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICO4FV006306;
	Wed, 18 Jun 2025 06:57:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=yDojCNv0VHMRPiwcpyXmwLGuuPCUOzV0KLV+alCkFRw=; b=Lyn
	olH9uxTTiweNTc0V4bjsuqg/1X54S+kK51t2Ih9576t4Nlf549+DiO1Mft1X/2aD
	EQbiCL9EhlxNqmF2Ca4+Bee7YTC+AmJoAueL5Ku0j9Fl/8Q8eQGKabpAOUc6hXW+
	JSN9tPmDCUwARvPmJeDyapQAV816cwZKWq1mXSTT5WyWnDIzzvX9GIlKDF5j5uy7
	FsrDwuM/AmSYnom2lOtNsHO56nxQ7peOH8RvnkxJvoqOvAFoLsu9JHOP1t0mKi+n
	YCLx7NB9WwMRD148FUXfuuOBbGoC80WP4rn7za3HiwlMJxUOBXBZPJ5529YYjApk
	NgcEFL1CWktb4L05Aag==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bwdg06af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 06:57:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 06:57:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 06:57:23 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 7C5263F7044;
	Wed, 18 Jun 2025 06:57:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <saikrishnag@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Fix rvu_mbox_init return path
Date: Wed, 18 Jun 2025 19:27:16 +0530
Message-ID: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ga0XnRXL c=1 sm=1 tr=0 ts=6852c5c5 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=lZJwEDgMoJHJxu8PrKUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: VhdLIQe0RssSehPe9fBP4BJIUIonQlqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDExNyBTYWx0ZWRfXwPRmQfWkV7nv JAK2+MM2LpKPEN0JQ9cPnSAbTRm6f1pNIID8WFa2DpXQ4LdCjX5GMwoZhijIe+00p2onvcGFX+O FsyNpswVFumkNyw7O6sdnqn0gUZD0WFm1fqvaCZSY5WfHsJ/XQ23VlkFn7uWBKaYZP/xPwbQdPj
 /ZGQUU7j5SxLBbpaVd6TactgxO9gZQcmCUzaEuJ1o5acpwpSXnoq+Fxe/FNuZecHgCDoA9hgKo8 Tbr0U9zKEk/tdRJ5wYsS+Bm/FP7F43GPI1+VkUnvMHutO7WE2QIbEb+mi6h0UKjZGCKkZEiOVKk mCoDnomTnCL6HhOOHRBsaxoyGLt+QD8YGdbC9CTuQWNf9SOYA0Nf+JgNWYKCg9F8srl4LovP0Vw
 mD96jJpnFxvdOsssWMXP6GxhPtZITghtfONGfc6/t36Jh6BvuaZSwdTrtxQdj4Vk/bBjXmBD
X-Proofpoint-ORIG-GUID: VhdLIQe0RssSehPe9fBP4BJIUIonQlqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01

rvu_mbox_init function makes use of error path for
freeing memory which are local to the function in
both success and failure conditions. This is unusual hence
fix it by returning zero on success. With new cn20k code this
is freeing valid memory in success case also.

Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index bfee71f4..7e538ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2573,7 +2573,11 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-	goto free_regions;
+
+	kfree(mbox_regions);
+	bitmap_free(pf_bmap);
+
+	return 0;
 
 exit:
 	destroy_workqueue(mw->mbox_wq);
-- 
2.7.4


