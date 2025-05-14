Return-Path: <netdev+bounces-190316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D32AB6318
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694BD161368
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371E1FF7B0;
	Wed, 14 May 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iE/yiWrP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43951B0439
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204130; cv=none; b=ZEq3mD4c7tAwROj0nb9G52EjHXv1CS7eIRuZf9vFc9r67DBLo2MMMTGbVabJMlvrt8MeDIVbEO59YsSL5cz6q8zfiuRM8e5D+n8rXVx3rWMd66eQv85BpoUGlWmH8enGLeJU2cPdLEWe64mus9cjHmxp5zA9EaI9GbJkqjRGms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204130; c=relaxed/simple;
	bh=nKm8i174Ry24fTbUQF+lUFRBSStJlnT5EOhqcsTkUR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/o8rpAFbtbWnjE3rjM8iKwByTIsIHzv8gSE0dIn95sm79g6K+FfaYxfISm/pHk1mfuGzf1jI4HNMGFIZQYwV0QLk4uLfjefwtKvPWlrdNfWD1d7RgTwL5ecKJh0iSsyQDwvtLqE640ChWWTpl6FTX3fkVDPXhLaStAoxpBLWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iE/yiWrP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIUiF4005870;
	Tue, 13 May 2025 23:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=guqDUrg5IQEO8B6sebT/4OjDz+q3NVSk3fiUVsYNx+U=; b=iE/
	yiWrPyDXm20KdxLrgkRh3yOwPV+GakVkBkvscd77urEV8/qZ+2PXhvXkQpJ9x2SB
	/VUsavtnFELAuzygFHqA4z3Eq5zAM8ktBQMyHqBs1iEDLXjuESkNunccMXidbyNB
	Lz7T87bx1G4RTNWXdn6zzwfU7g3QGIHccAECH03AaV6BIJHSJQQ4in+Lk7uI0HVn
	Oxe7klHiQVhvx/IYVW1awYs5jRKo1MvKBiYmqQCQXKZfA23hU2/EIQPHDbPHMPJO
	yZo8rWmIwKWmLyVQUt8GOD3fy05oW2RHNeOou9O2c8olFcfF6Od3V9gtNwUlw8ve
	jGaaKz6l2e94ufs8oLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mbe215ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 23:28:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 23:28:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 23:28:36 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 7B97E5B693B;
	Tue, 13 May 2025 23:28:31 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net v2] octeontx2-af: Send Link events one by one
Date: Wed, 14 May 2025 11:58:28 +0530
Message-ID: <1747204108-1326-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b4ctb3JZr2ccjZYF_ahxx2bOUFqZtdFg
X-Authority-Analysis: v=2.4 cv=fbyty1QF c=1 sm=1 tr=0 ts=68243815 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=QHeTzNiMllNnO-1yQAEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: b4ctb3JZr2ccjZYF_ahxx2bOUFqZtdFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA1NSBTYWx0ZWRfX6KGq/KdILGCs +BZdKSi41Dgxuon3unALfooxQJ5y00d+x8QMXG6tWEhB6AUygHqQohTN3B8JbWdu7bcgtcqh5PB Ckn9RAtas7Zl1nDRIt4Y9sJsNG7mKtAifzO/umTikpk6zqouSvg9YNKE1pKmR9oxl/3WgqqBANa
 27yI8iKFwNRANGQPV6KU1HYlLgTCPi4d/1g0AHscAqMecTRg3mWzdjUQLbV4O/xUsiAIe5Uwv0y s/gZGsqzKzbbBQdvAdo+oAYO2Dp1Yb6JBLplMZRvQzJDlNCd5BVfAhlE4YgixRLunpCZXgCAR3Z HmxgPIscjLZcO6xUQS+HqwqhkK0vi2WFB7TCVB18Cnfe0+O4lo7mUt4JT+9CjZsHgcKHu6uXBeU
 2Zl3/hT7OJTkuA4x7fgNB0RMnuV+Z/dd0LMKz58ZjUqCWxymICjg5ccpB/bEUTtXsqOFNWF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01

Send link events one after another otherwise new message
is overwriting the message which is being processed by PF.

Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2:
 No changes. Added subject prefix net.

 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 992fa0b..ebb56eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 
 		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
 
+		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
+
 		mutex_unlock(&rvu->mbox_lock);
 	} while (pfmap);
 }
-- 
2.7.4


