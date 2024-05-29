Return-Path: <netdev+bounces-99088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9B8D3B05
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C6B27C1E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821171386A7;
	Wed, 29 May 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EQioPecm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B612E6D;
	Wed, 29 May 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996613; cv=none; b=Px3mZGY0l5/CZUQ/rlgN3SZlFTTbP0khSFRHhZmBuqIcssj7Lib3Lm3rdFnDXOTbEpGLFiethU+o6EORsamqJMMMg1vTyG+Um42gAeD91HJvBvshDGp8YmNmQkLzCEChoSZ8ymWvkbMpAG4MLyPZa8nbF9qiAuNwnvWorJqAaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996613; c=relaxed/simple;
	bh=fFeFeTx4/whvByelW2t6NQHLEkQwMkDj9Zr3e58ZgAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aodj7ey5WUtef6PZwS2+DtfNO0N58uKHg/lHpGozfcq2kWrp5Xvq+VVWFZWgQbwbNnmcsFhp1IXvJ3AQY9BN9srvh5rD1XqNloe9UFJbxnSPSIkqAM0XIj7O9R+1vieLb0ooHGCtrGmeUG03nJhfSlpAf05gDXrq9zSzKHj0mFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EQioPecm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T61ORF007699;
	Wed, 29 May 2024 08:29:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=drVg0/vAG/dCOXINnqroxWPrHKOYYFCNDsNDCM+Q4vI=; b=EQi
	oPecmHx11eKMs9yKRMwciKd0uCK5NOcrnWEKzU3Q2GRlAyKAHM3fAV0ht0wUybGu
	nOwORcxaBA3W3GIb3PzfbyIzTUCGF/5LtsT0+CJI8hfgY9w755PfGye0FffZ7bHO
	8C20mQz5CuJGabsdyGna9E6ER6S230MUWCu+vCmZTeGyKRxGRrHSozFOeoHbXCn/
	J74hr4W7m10xfwH9qlW/PA/P2kc5KVVJhY4REvf9199r0FOUKbHRlLzc0BxmD6j5
	fshZeApDaZGFH6YLexjd2KddLXBW9FwLQU/Uk/V3BKapL6jadtSNt+PSMf+IJxOf
	M6TbkBjf+Kfv9LEysoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ydxqq1tbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 08:29:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 08:29:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 08:29:50 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 089463F7051;
	Wed, 29 May 2024 08:29:46 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: [net PATCH] octeontx2-af: Always allocate PF entries from low prioriy zone
Date: Wed, 29 May 2024 20:59:44 +0530
Message-ID: <1716996584-14470-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: rbCyzZKdTZmtsqTFA7pVRBs5Flp211po
X-Proofpoint-ORIG-GUID: rbCyzZKdTZmtsqTFA7pVRBs5Flp211po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_11,2024-05-28_01,2024-05-17_01

PF mcam entries has to be at low priority always so that VF
can install longest prefix match rules at higher priority.
This was taken care currently but when priority allocation
wrt reference entry is requested then entries are allocated
from mid-zone instead of low priority zone. Fix this and
always allocate entries from low priority zone for PFs.

Fixes: 7df5b4b260dd ("octeontx2-af: Allocate low priority entries for PF")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index e8b73b9d75e3..97722ce8c4cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2519,7 +2519,17 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	 * - when available free entries are less.
 	 * Lower priority ones out of avaialble free entries are always
 	 * chosen when 'high vs low' question arises.
+	 *
+	 * For a VF base MCAM match rule is set by its PF. And all the
+	 * further MCAM rules installed by VF on its own are
+	 * concatenated with the base rule set by its PF. Hence PF entries
+	 * should be at lower priority compared to VF entries. Otherwise
+	 * base rule is hit always and rules installed by VF will be of
+	 * no use. Hence if the request is from PF then allocate low
+	 * priority entries.
 	 */
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
+		goto lprio_alloc;
 
 	/* Get the search range for priority allocation request */
 	if (req->priority) {
@@ -2528,17 +2538,6 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		goto alloc;
 	}
 
-	/* For a VF base MCAM match rule is set by its PF. And all the
-	 * further MCAM rules installed by VF on its own are
-	 * concatenated with the base rule set by its PF. Hence PF entries
-	 * should be at lower priority compared to VF entries. Otherwise
-	 * base rule is hit always and rules installed by VF will be of
-	 * no use. Hence if the request is from PF and NOT a priority
-	 * allocation request then allocate low priority entries.
-	 */
-	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
-		goto lprio_alloc;
-
 	/* Find out the search range for non-priority allocation request
 	 *
 	 * Get MCAM free entry count in middle zone.
@@ -2568,6 +2567,18 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		reverse = true;
 		start = 0;
 		end = mcam->bmap_entries;
+		/* Ensure PF requests are always at bottom and if PF requests
+		 * for higher/lower priority entry wrt reference entry then
+		 * honour that criteria and start search for entries from bottom
+		 * and not in mid zone.
+		 */
+		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
+		    req->priority == NPC_MCAM_HIGHER_PRIO)
+			end = req->ref_entry;
+
+		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
+		    req->priority == NPC_MCAM_LOWER_PRIO)
+			start = req->ref_entry;
 	}
 
 alloc:
-- 
2.17.1


