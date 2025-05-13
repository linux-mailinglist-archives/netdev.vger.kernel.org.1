Return-Path: <netdev+bounces-190127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F8AB5404
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742E54A3F88
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47328DB4C;
	Tue, 13 May 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZmIrwBCl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D528DB40
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136451; cv=none; b=XcpLG3mVa0VxNh27TgLZtMfjsX0QhRwxevenOg3JnNMvh2sRMLkVgUQScPhFbd5AdIr7SOmeqtellSGNVBtwmda9nhHbmvm6nlwtqpUoLKOQ5oS6Ifgt6fRNrSz5DqnUeQQIvheEwYnIw0o6qwVrR5fZdhOYxhIp/I0kSZSwTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136451; c=relaxed/simple;
	bh=G8rfjvvnTydX2+XRs6vzFfFmeqlz8HqGP7FvVVC6haQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSfn9zmDuKvitIIt0kqtYCP7h4glV3gRKAb+g+EC8I62xzx5diJQbEXVaZEY/3sUeWjS0O6NL8z9kqwYyM8sNuW/0arrYujiNo6Gio2oOAhXkUWadQcr+XpaEyQN3RQzSUL7UBQLocweVHOvu0RdP5c1ksw97vU91I3FEM7ljsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZmIrwBCl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAG8vN011668;
	Tue, 13 May 2025 04:40:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=2xAceSwDzxcfRqZya9M0XaGqL
	SypKRFZColpry8Qok0=; b=ZmIrwBClktHu2eMQTJ2gp/S/7EFz8I5UywFdh9UB0
	1+y02dvBawxu59sHcubPnmGOGBptZbHcsHENQno8a+B9dkQqrcwweT2Bq8Wr2wpO
	0YazVP39O4o54SzpR82wSMPCWyoi20uu+bbKXdLvZ/lPffK8E4b1SkNYi78Q9alZ
	B7g5EVuIh+mKSWHPOEILAQ7PT63C4W6CDxuBrQ9m3Z+aO1LrOHN5kLjDpXbKPnJk
	xnoAk8/Z8htEL++0SczncbjwRGWl+SFTvcBAyGfgP63Ul/qaUGD04EnpOYGz+2TK
	rWTDsC3N+gl8T7QgMwSSWf2S7DKGKiT3oEXz2b5F9/hPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46m46104q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 04:40:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 04:40:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 04:40:41 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 99D233F709D;
	Tue, 13 May 2025 04:40:36 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 4/4] octeontx2: Add new tracepoint otx2_msg_status
Date: Tue, 13 May 2025 17:10:08 +0530
Message-ID: <1747136408-30685-5-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMSBTYWx0ZWRfXxF3JK3eV6egp 5UlNO6w7C+euIZ6kXb4fVWmbpTBaLGNH4N7WWBEWLNn4FPOcL76jXO5wDzdxvxpiRCgWY2ZTExp BAayd70bHWNOY4U8ZCv9xBlpUcX4a92N4pb7G0AK06Se3Y7kOx2CEXztvAL6aodDhF/KuMBiCxo
 4tzbjOMS0PppVGr7ik0E+L39i/6QS1vza2Okp9yUlmwfETc0vz/knul5fNRnn0MXA9SSc/B7qEZ Sggr142x7qtiCY9LyB8pEBHVJbqUBzhV6bAzQDBT+7PyBY9iqu5upVklTwVJBOKRawW5+8m9SiP vHGzlhnRHz/SunMqw+0VgVEE93ocs/8NyZBvL/42yVr58KHlhQU3K2jcNtZzjWtc9iB3ak3Gibr
 xYXTDyq9+zodEny6h5RpArcu0ehRRdoi4kNaNHm0pAAFRajJ0qh75F8PG1Yt8UTEpMDX7BtY
X-Authority-Analysis: v=2.4 cv=f+dIBPyM c=1 sm=1 tr=0 ts=68232fb9 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=0fIk3bRXYT3cIrd2uZ4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: arbtV32i23Yk0THQprrV6UjRorwCnnKQ
X-Proofpoint-GUID: arbtV32i23Yk0THQprrV6UjRorwCnnKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01

Apart from netdev interface Octeontx2 PF does the following:
1. Sends its own requests to AF and receives responses from AF.
2. Receives async messages from AF.
3. Forwards VF requests to AF, sends respective responses from AF to VFs.
4. Sends async messages to VFs.
This patch adds new tracepoint otx2_msg_status to display the status
of PF wrt mailbox handling.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h | 15 +++++++++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c  | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
index 775fd4c..5f69380 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
@@ -11,3 +11,4 @@
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_alloc);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_interrupt);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_process);
+EXPORT_TRACEPOINT_SYMBOL(otx2_msg_status);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index abbdb03..db02b4d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -118,6 +118,21 @@ TRACE_EVENT(otx2_msg_wait_rsp,
 		      __get_str(dev))
 );
 
+TRACE_EVENT(otx2_msg_status,
+	    TP_PROTO(const struct pci_dev *pdev, const char *msg, u16 num_msgs),
+	    TP_ARGS(pdev, msg, num_msgs),
+	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
+			     __string(str, msg)
+			     __field(u16, num_msgs)
+	    ),
+	    TP_fast_assign(__assign_str(dev);
+			   __assign_str(str);
+			   __entry->num_msgs = num_msgs;
+	    ),
+	    TP_printk("[%s] %s num_msgs:%d\n", __get_str(dev),
+		      __get_str(str), __entry->num_msgs)
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 1bbc17b..d79b4b3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -465,6 +465,9 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 
 	offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-VF down queue handler(forwarding)",
+			      vf_mbox->num_msgs);
+
 	for (id = 0; id < vf_mbox->num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
 					     offset);
@@ -503,6 +506,9 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 
 	offset = mbox->rx_start + ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-VF up queue handler(response)",
+			      vf_mbox->up_num_msgs);
+
 	for (id = 0; id < vf_mbox->up_num_msgs; id++) {
 		msg = mdev->mbase + offset;
 
@@ -819,6 +825,9 @@ static void otx2_pfaf_mbox_handler(struct work_struct *work)
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 	pf = af_mbox->pfvf;
 
+	trace_otx2_msg_status(pf->pdev, "PF-AF down queue handler(response)",
+			      num_msgs);
+
 	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 		otx2_process_pfaf_mbox_msg(pf, msg);
@@ -974,6 +983,9 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-AF up queue handler(notification)",
+			      num_msgs);
+
 	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 
@@ -1023,6 +1035,9 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 		trace_otx2_msg_interrupt(pf->pdev, "UP message from AF to PF",
 					 BIT_ULL(0));
+
+		trace_otx2_msg_status(pf->pdev, "PF-AF up work queued(interrupt)",
+				      hdr->num_msgs);
 	}
 
 	if (mbox_data & MBOX_DOWN_MSG) {
@@ -1039,6 +1054,9 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 		trace_otx2_msg_interrupt(pf->pdev, "DOWN reply from AF to PF",
 					 BIT_ULL(0));
+
+		trace_otx2_msg_status(pf->pdev, "PF-AF down work queued(interrupt)",
+				      hdr->num_msgs);
 	}
 
 	return IRQ_HANDLED;
-- 
2.7.4


