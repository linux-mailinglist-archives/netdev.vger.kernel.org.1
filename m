Return-Path: <netdev+bounces-190124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F768AB5400
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E364A3D70
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342328DB4C;
	Tue, 13 May 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FZN+pj2D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1423C4E9
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136440; cv=none; b=k2FRQ74UWq6xYvA6T15kcgNE/OYDq5fDQWrbOGfHvB4gdrtKaaxKmsbOlkA5mBrBIxUxfGJ8R113BVFxF5wYATBbsS/xtrU6QMTTMGaYSgqGuGwnHWpzCf61X1zw5ysBlVkpOxDYtZtqkGeQyeXepfYZCPnI+JBTt2VtzuLxZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136440; c=relaxed/simple;
	bh=uhwyziSxSvbCXM5CvuYIktuiXr+1+Dv8ev8ym/JiXEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQGEQVVKMEsxb519ddRvjscXRj6OYDaYPfyu5tIxvIzUt6ut4duxF2MIFkFdHpluhgFNBgCNZmA+4E/MX3Wu8q/pJOot3v9t2a4LGE1+Z7Wnk1m0wBScvg08xlMD9R/1DbDTpDsEI1/qIbUBmWmCvKNso6InCS0di9/hrpElE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FZN+pj2D; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8Rnib023613;
	Tue, 13 May 2025 04:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=8Cu4W/rRzfen0N6P/RC6r20jD
	VKyCkNaGmubctVf0rQ=; b=FZN+pj2DSTbqoPA69wJOgQyqwkOjZo6YqiYIRP5qe
	aHYq43V5mmCUYiV4v2TEYALgMOTLROFEPfS9U++jEEvtv4jL8zXrKpL9vmtRpVZp
	8zkuQMyOJ2IdhQk6XMe1xKqg9tWFhc8hztjH07ziUXSsh0qrzBP9qXF4yX+INXZQ
	/K7tjqd+3uskYkxD6zicg0hVvT+BINQ5r46aaRdEYAVjlIw4gqqsbqTf1CMAWnlv
	X1+kKN8Vsi7+MgqCptwUi1B8XfyKe/10V4P1B68b8Skr+QjAOBr0KNOnfvXeVWMt
	i9vHMpJ3QsIEHVEZMUgTqiaFarue8xGVGGUAEjDLME2Eg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46m2kb8aw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 04:40:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 04:40:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 04:40:25 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 6F0F83F7060;
	Tue, 13 May 2025 04:40:21 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 1/4] octeontx2-af: convert dev_dbg to tracepoint in mbox
Date: Tue, 13 May 2025 17:10:05 +0530
Message-ID: <1747136408-30685-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
References: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMSBTYWx0ZWRfX6gOeqFYZx8lz AxDCepv3dLFNRfybtVoT5+t8px86TYZTIrpPOj7in2lht3XuTHMCi3buL1aq1BbpkQisNYLyEM0 BvaxqREXmbHw/+I9u++sq4agR64t/uPOxHL+8wgx5i905Mp/STIZZCid70s9lUwyED7EJlrx6ji
 1Rn0NK5ILc27Nnw17VUHykjiGkiaTCT8cLEGUWsOjT7v2UyFh9x5dDBykaDNunNp/OtNz6GPCf9 FuEeN5DCyMR85qlO2CxtrUru+7qkOclcOY+B37EXcuq3BZmzDdZftaiNYO/VzM2TkJrLClWeyAU RngysoRXJLyZZqsBrlTdiFe+1gPFidJnoIdLh/gJNdWnttUcAzZ60Obom/b6IhmXqC8xL+xuDeJ
 4gM+3+6w905uG15Sls/tzN+M/sCk3W0tdLSBGtusKSL9nsQtB9ozbYGdrPWAPvGPiYnJO89s
X-Authority-Analysis: v=2.4 cv=RvXFLDmK c=1 sm=1 tr=0 ts=68232fab cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=nvB0ett4rcpRluyxjm8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IzZKHeDH5NYySaW62hLgCEpvLP06dvsp
X-Proofpoint-ORIG-GUID: IzZKHeDH5NYySaW62hLgCEpvLP06dvsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01

Use tracepoint instead of dev_dbg since the entire
mailbox code uses tracepoints for debugging.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c      |  3 +--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 1e5aa53..5547d20 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -188,14 +188,13 @@ int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(MBOX_RSP_TIMEOUT);
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
-	struct device *sender = &mbox->pdev->dev;
 
 	while (!time_after(jiffies, timeout)) {
 		if (mdev->num_msgs == mdev->msgs_acked)
 			return 0;
 		usleep_range(800, 1000);
 	}
-	dev_dbg(sender, "timed out while waiting for rsp\n");
+	trace_otx2_msg_wait_rsp(mbox->pdev);
 	return -EIO;
 }
 EXPORT_SYMBOL(otx2_mbox_wait_for_rsp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 5704520f..6b5a14d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -95,6 +95,17 @@ TRACE_EVENT(otx2_msg_process,
 		      otx2_mbox_id2name(__entry->id), __entry->err)
 );
 
+TRACE_EVENT(otx2_msg_wait_rsp,
+	    TP_PROTO(const struct pci_dev *pdev),
+	    TP_ARGS(pdev),
+	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
+	    ),
+	    TP_fast_assign(__assign_str(dev)
+	    ),
+	    TP_printk("[%s] timed out while waiting for response\n",
+		      __get_str(dev))
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.7.4


