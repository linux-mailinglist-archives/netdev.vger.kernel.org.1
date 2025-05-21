Return-Path: <netdev+bounces-192242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B01ABF1A2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C567ACEB2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1A239E79;
	Wed, 21 May 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IEdOypyD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE523498F
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823465; cv=none; b=rc2XYlW9zi+0eKFbBWkIpchOT4QktQT42IDcF0EDPvCH6g4N2kemMrr/pEByB5XPg5oE2+VoGDQbpVX7Wz4j0dyceDvulxmPdOLOSbrl+1I6AZ1VtjdNBVt5SZHRZnHkZvYSjCCkN/JTWYrRETw2yHe2e3yYT+S/XfQ5BGKTuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823465; c=relaxed/simple;
	bh=LIrc7qPrLYHg2N8+aqhFKhZyeFP+FFndG9FoEykJLso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hwqCp6ivWIYI+eUSxu91dDVC+zzP9MJONx05jW0IKC5iNR+g+xdzH/iF8yBQ5nlKGDcUBAqF+3iDccMJ5oEaAS2tr42SpxHooIwyIokzN5rBdu+WA1Q8aGtpf0IjxBqwfvARFc2d1ATaQQkIuDOV9irgI8gstuC0xxLgwABGS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IEdOypyD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qgDD013465;
	Wed, 21 May 2025 03:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=r10T2jBRvKwqz/WSaBj6vD4rRrk2OonJTL92GfT4UNU=; b=IEd
	OypyD3m0ZsZBcXGCUjcBHDy6OKbHlwjj1AW3oQYpYZuFP9upOPzNt1fQ5/5b3JkV
	ZLb57fKeifbOrIw54QWqpUPsRL1JoWfn10DlpBdd0OXtQQAnMCPR9Tu/d81nfL+Z
	jvFNMu9oS2sIWRWjSfwL37GcTExbzoA6sYu/ZD9PSVoySCNyMe+eDMXi3wIpo8fr
	nofUWtuL4p93biI+03Tx2jh25EKNkWpjtOpn45rzodj3KtN1j39irqqZzdiEeEju
	L/cCrNQHJfEM6XPXAfjRrlDoeuz0VRypd8iFcFTvoQQSjlAJuU1TEtnP3SonF6or
	rwOf6joiVAZ/wQ7rMpA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3pus0dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 03:30:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 03:30:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 03:30:50 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 924443F70B4;
	Wed, 21 May 2025 03:30:45 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <michal.swiatkowski@linux.intel.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH v3] octeontx2-af: Send Link events one by one
Date: Wed, 21 May 2025 16:00:43 +0530
Message-ID: <1747823443-404-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682dab5b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ba-9XGMmvJ23VOHwC14A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qxhVd4ED9fNFFTlUlAYwaTjhRqhjQxXR
X-Proofpoint-GUID: qxhVd4ED9fNFFTlUlAYwaTjhRqhjQxXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNCBTYWx0ZWRfX2Rq2imX9ye66 58tYub+uHIh3FNF728DGLCxXq1rdSUy0SNY77GPb4Qcwg9nnu1VrbCCqKz7stHRxl7CKh53QJlE Ugsc3uADKzFjnJ605q4rSW8zpmcYF6QwnN26zf7msTGtTicGxYkYX7ktahOswRIG2UG28k3t97P
 r4ZJtDnfrXkPuBMdBbtTKMObAVWQ+tagO2MIpQPxs681sxdMQrmvvTt9CXmXFPH/DLEr2MalLaA V0tMrd7XWUI8m93wsqB3IojjwsdVhJb1BGJ3vArlpC1BWfGjdQllcbzDFk7BLeS6t2adJ1hWcYF lfiHsMTO2WbQQA3uAdjbbCH/FQ58QqXn6FP7uY2J5WDijlMtcbj2q0MTKEFcH+4x3M9i+N/dalv
 Yf75fGPExIzWn0DLo9nnEf5koBRwMV/a0rt8JFnl7WVWxyLpm+Eib4OqZUQ59LhzWcCGtCxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01

Send link events one after another otherwise new message
is overwriting the message which is being processed by PF.

Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3:
 Modifid to wait for response at other places mcs_notify_pfvf
 and rvu_rep_up_notify as suggested by Simon Hormon and Michal Swiatkowski.
v2:
 No changes. Added subject prefix net.

 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c | 2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c    | 2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index 655dd47..0277d22 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -143,6 +143,8 @@ static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
 
 	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
 
+	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
+
 	mutex_unlock(&rvu->mbox_lock);
 
 	return 0;
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 052ae59..32953cc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -60,6 +60,8 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 
 	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
 
+	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
+
 	mutex_unlock(&rvu->mbox_lock);
 	return 0;
 }
-- 
2.7.4


