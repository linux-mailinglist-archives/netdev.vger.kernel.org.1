Return-Path: <netdev+bounces-189665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AFAB31EE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D166616AAB4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC425A2A9;
	Mon, 12 May 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RgWxfhFH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7C259CA3
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039365; cv=none; b=Dvw4/eEdK4JBKnCjU/XwuamEBMkSfqXrfmbtnmNj+hVAEDqbV4tdFRbmt7sAlkcY5SIyZ47BpwS08cy2KUxJWNFT16CA0eKAUwlZ/yldcwLIZ2iWH9j+c2wOqQVseyNCVCZuUXO9yHmx7uW4IDtdKlfrIRWXgcMFYntFeu/Y3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039365; c=relaxed/simple;
	bh=zgLFNhepJ/zAEc0kw9sxwGi6mXMXZmjgXGdyCnsymlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzZFA0Jrm2dczh2W7Z9ftrHrWEhlkxj93rKVNoEuvem0zbxAZ4ejd6BKIdErFAUNnGURiFNDmDadYnv+hLG/SFYSnOl/Gxtscte76pZSZGIfKqBz0L9ojqhVGXy3XIVopdXWH6as6oX/BsO8MlEyTvypq7SczuJDMIcZUJ1vqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RgWxfhFH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7lZV7016825;
	Mon, 12 May 2025 01:42:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=AgKUrhFzrlhFAd+syT4l7XAw7
	QTXL4uoNR5VMNm16yY=; b=RgWxfhFHhfkW/XxkNrGSYwLDrMrVTWNuf8T/dKYka
	2QFXQXtL/Bz4XvBak7G7PJRTshHlgIkgK6HCdMZN5FWrErHUaKKMHsnHE6I4mwlM
	/lrLg2znkRKq4u/G0dBR16Z9QVG0b3NYaV+tvjVMKnAW3QlnkIxttTMbh5MdhkxN
	z6Z+yLi1ur8nuPHOkP7qWheOCqqlhSRAlzksXD4pVmx3NUld5Qgwk1CA0krS1lYO
	QnMFX533XR1gFCySM/6lEF3CDfpwRVJBBUEePQS6LV6de2jR6efq+1FOSPqh9sPC
	wf3OXmEfsp5PksdGxOfUrb+Du7AyOAsthXx+wBJtOKZ1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46k5rggnnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 01:42:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 01:42:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 01:42:34 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 8320B3F7089;
	Mon, 12 May 2025 01:42:29 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 4/4] octeontx2: Add new tracepoint otx2_msg_status
Date: Mon, 12 May 2025 14:11:55 +0530
Message-ID: <1747039315-3372-6-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: R2X4JilURvFuVBRWvFMoJf_dxbKs1kkx
X-Proofpoint-ORIG-GUID: R2X4JilURvFuVBRWvFMoJf_dxbKs1kkx
X-Authority-Analysis: v=2.4 cv=XIkwSRhE c=1 sm=1 tr=0 ts=6821b47b cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=0fIk3bRXYT3cIrd2uZ4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MSBTYWx0ZWRfXwXX3PHmeX5h0 BI3w+3syDLjmXe+/4U+ezZjhhkGY6ZnDWLzN0SVwjv8tmQN9eBd7giXf4XHEej56qazA6yafiaW 5LOqT73NILIfEjkmxE5Gc+N4ANqeJ8jA2IA83MKP+G/O4R0iszW57gMX9dPXvMav3HWWkkhFF2o
 o7o70cTiUSbwrWA8/Z1tVpw64b/VJtpQRU3oFDq740I5GvQCEa86wCrV8EAqr3pAfREGxeyVyyA WQ65XfC/ubtyX+Q/BGSu5B7YTjXSwaPfb0BXoC607TfS7ShFKcV9YOi9w8hI9rSs5f1GOMX7ut7 YZWNobORFKzs+1vwsjVwn4tW1KuEve4mTFu73yeVZvNGFUK+a7xM/49l1Tz+UsrcjpdeSv5RGK8
 7p91PqCz4wVkrgf9b553QBP8vA2tZpTryVFItWxxd9sE6T0qAap2IgzHPnyJsIR7JOk3Vvvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01

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
index 721d4a5..e7c2160 100644
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
+	    TP_fast_assign(__assign_str(dev, pci_name(pdev))
+			   __assign_str(str, msg)
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


