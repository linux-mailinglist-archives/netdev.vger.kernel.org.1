Return-Path: <netdev+bounces-190126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B03AB5403
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F531B45573
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D628D8EF;
	Tue, 13 May 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JTcx/5gT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF528DEE1
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136447; cv=none; b=BgkWNV0k7i6Qtsw+nK23Q7eX0zPVGZmjBf+fsaniU6ujGjVpwIS4PVY4Wgy6Zzk+yEZcxUfLKgpFl/yt5aemLVDM4unVTxpwslc6s+xzvvN+lXZFInwvP2W5SMtavrqqFovVF9vocc3sEMz9vfeNnL4559XeFWzxzYsBOpcZ2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136447; c=relaxed/simple;
	bh=IK+mPxUa38Bl7xbI8AhcaJHssVz9uSuV+BIS7BSqTjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXRrOG2nRS0ziJUUbJCzbCFWl5x/e5o2aYiv0tEDu+nT3uUxI33Wbe18ii2yuPGMmxwYooJ7DMZISc0MU7TylloJdCnTECE/MSpmns4/EROzTlqYjjdn1zSCYe9woDO5mNGsfW52sBTZZQ5HriW64LZrrBmZLeIT+LZplFKw3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JTcx/5gT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8Rcu2023563;
	Tue, 13 May 2025 04:40:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RyB+VXvAZDY7O9hWvemMh2SvA
	OynwmN6wss9ySfDiN8=; b=JTcx/5gTInC4q7c5uXGbZm6NTTzehZyCEm8XSgaEK
	+Qm6OL2JySd9AowQt+aIq4WXM83C/L2hWQTtbKBk+W/ZZ/CGEO1q5yuswN8NUvTa
	f62uCArD+ffLikNvjxyBLzGhJhkUDX6RycoFb2Dv8KudE570BkAp687lrs9ZBY6p
	q6TCo1DBcP7Aju4Omfem/Z89XaGcX0GlvDKweqf0Rx+SUmxg+OqZyIYVmpFM+JUH
	oAftzumpKSrfOijzcJKuaReW4viGzQBi1ma/JMQB3dOK3c4zqBdwR452ehIM7dvM
	LCdGtHuSeX9pLb+Lr5UrafV79vgcApgkPH7XTtFXGKSAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46m2kb8awb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 04:40:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 04:40:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 04:40:36 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 8F5B93F709D;
	Tue, 13 May 2025 04:40:31 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 3/4] octeontx2: Add pcifunc also to mailbox tracepoints
Date: Tue, 13 May 2025 17:10:07 +0530
Message-ID: <1747136408-30685-4-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMSBTYWx0ZWRfX8cppOoSzjX4W NBYyxEOvMr+nkCJyhztD05BFDDFyYj+6gw8E+8HoJsr1hYO6XifOKChZ+YWIwQMLQMHt8nxeckL fCXeq8wtT1Q2t18Czn9XndHWslky88zpZ/nUP2e37Fx9LZi2eSuMxbO/8UqzDPWKdPvGq9H0TGe
 mCbKimrydZasHIR9bpRNF/dNDR2Yn7eWzIEaZimXwafGom21FvycIkPTPu1EUxuZmMxJ9Ue0MI8 pLZ0cuFtBUE9tpWqRFkUpr3zobWrowOXHzm54Nm7jfggkD2IKBmhTfxNEHMnA2RGFpVGvrGne6P ciPN40OQzCwQwFD1W2gqQyf2xRWnz0XboKsG2x8uA5tJsdKzSkqF9hbcBVOOSIp92F1din6V1OB
 gnmx6sOupMkAyZzmlBqvPaDH9+atqjbKpOjQ7GPRHawuqxWHQNX1FvTJY0esrM1D50ktXLac
X-Authority-Analysis: v=2.4 cv=RvXFLDmK c=1 sm=1 tr=0 ts=68232fb5 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=_bv6PHYV_TvcDR7bTVsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: o3ete7ve1VMN8t5eJnb8jt3py00A0Uld
X-Proofpoint-ORIG-GUID: o3ete7ve1VMN8t5eJnb8jt3py00A0Uld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01

This patch adds pcifunc which represents PF and VF device to the
tracepoints otx2_msg_alloc, otx2_msg_send, otx2_msg_process so that
it is easier to correlate which device allocated the message, which
device forwarded it and which device processed that message.
Also add message id in otx2_msg_send tracepoint to check which
message is sent at any point of time from a device.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  6 +++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  | 36 ++++++++++++++--------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 ++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  2 +-
 7 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 5c457e4..7d21905 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -218,6 +218,7 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_hdr *tx_hdr, *rx_hdr;
 	void *hw_mbase = mdev->hwbase;
+	struct mbox_msghdr *msg;
 	u64 intr_val;
 
 	tx_hdr = hw_mbase + mbox->tx_start;
@@ -250,7 +251,10 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	tx_hdr->num_msgs = mdev->num_msgs;
 	rx_hdr->num_msgs = 0;
 
-	trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size);
+	msg = (struct mbox_msghdr *)(hw_mbase + mbox->tx_start + msgs_offset);
+
+	trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size,
+			    msg->id, msg->pcifunc);
 
 	spin_unlock(&mdev->mbox_lock);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 6575c42..511eb5b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2173,7 +2173,7 @@ static int rvu_process_mbox_msg(struct otx2_mbox *mbox, int devid,
 		if (rsp && err)						\
 			rsp->hdr.rc = err;				\
 									\
-		trace_otx2_msg_process(mbox->pdev, _id, err);		\
+		trace_otx2_msg_process(mbox->pdev, _id, err, req->pcifunc); \
 		return rsp ? err : -ENOMEM;				\
 	}
 MBOX_MESSAGES
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 992fa0b..38db06b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -34,7 +34,7 @@ static struct _req_type __maybe_unused					\
 		return NULL;						\
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
 	req->hdr.id = _id;						\
-	trace_otx2_msg_alloc(rvu->pdev, _id, sizeof(*req));		\
+	trace_otx2_msg_alloc(rvu->pdev, _id, sizeof(*req), 0);		\
 	return req;							\
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 6b5a14d..abbdb03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -18,33 +18,42 @@
 #include "mbox.h"
 
 TRACE_EVENT(otx2_msg_alloc,
-	    TP_PROTO(const struct pci_dev *pdev, u16 id, u64 size),
-	    TP_ARGS(pdev, id, size),
+	    TP_PROTO(const struct pci_dev *pdev, u16 id, u64 size, u16 pcifunc),
+	    TP_ARGS(pdev, id, size, pcifunc),
 	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
 			     __field(u16, id)
 			     __field(u64, size)
+			     __field(u16, pcifunc)
 	    ),
 	    TP_fast_assign(__assign_str(dev);
 			   __entry->id = id;
 			   __entry->size = size;
+			   __entry->pcifunc = pcifunc;
 	    ),
-	    TP_printk("[%s] msg:(%s) size:%lld\n", __get_str(dev),
-		      otx2_mbox_id2name(__entry->id), __entry->size)
+	    TP_printk("[%s] msg:(%s) size:%lld pcifunc:0x%x\n", __get_str(dev),
+		      otx2_mbox_id2name(__entry->id), __entry->size,
+		      __entry->pcifunc)
 );
 
 TRACE_EVENT(otx2_msg_send,
-	    TP_PROTO(const struct pci_dev *pdev, u16 num_msgs, u64 msg_size),
-	    TP_ARGS(pdev, num_msgs, msg_size),
+	    TP_PROTO(const struct pci_dev *pdev, u16 num_msgs, u64 msg_size,
+		     u16 id, u16 pcifunc),
+	    TP_ARGS(pdev, num_msgs, msg_size, id, pcifunc),
 	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
 			     __field(u16, num_msgs)
 			     __field(u64, msg_size)
+			     __field(u16, id)
+			     __field(u16, pcifunc)
 	    ),
 	    TP_fast_assign(__assign_str(dev);
 			   __entry->num_msgs = num_msgs;
 			   __entry->msg_size = msg_size;
+			   __entry->id = id;
+			   __entry->pcifunc = pcifunc;
 	    ),
-	    TP_printk("[%s] sent %d msg(s) of size:%lld\n", __get_str(dev),
-		      __entry->num_msgs, __entry->msg_size)
+	    TP_printk("[%s] sent %d msg(s) of size:%lld msg:(%s) pcifunc:0x%x\n",
+		      __get_str(dev), __entry->num_msgs, __entry->msg_size,
+		      otx2_mbox_id2name(__entry->id), __entry->pcifunc)
 );
 
 TRACE_EVENT(otx2_msg_check,
@@ -81,18 +90,21 @@ TRACE_EVENT(otx2_msg_interrupt,
 );
 
 TRACE_EVENT(otx2_msg_process,
-	    TP_PROTO(const struct pci_dev *pdev, u16 id, int err),
-	    TP_ARGS(pdev, id, err),
+	    TP_PROTO(const struct pci_dev *pdev, u16 id, int err, u16 pcifunc),
+	    TP_ARGS(pdev, id, err, pcifunc),
 	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
 			     __field(u16, id)
 			     __field(int, err)
+			     __field(u16, pcifunc)
 	    ),
 	    TP_fast_assign(__assign_str(dev);
 			   __entry->id = id;
 			   __entry->err = err;
+			   __entry->pcifunc = pcifunc;
 	    ),
-	    TP_printk("[%s] msg:(%s) error:%d\n", __get_str(dev),
-		      otx2_mbox_id2name(__entry->id), __entry->err)
+	    TP_printk("[%s] msg:(%s) error:%d pcifunc:0x%x\n", __get_str(dev),
+		      otx2_mbox_id2name(__entry->id),
+		      __entry->err, __entry->pcifunc)
 );
 
 TRACE_EVENT(otx2_msg_wait_rsp,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 7e3ddb0..d188936 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -871,6 +871,7 @@ static struct _req_type __maybe_unused					\
 *otx2_mbox_alloc_msg_ ## _fn_name(struct mbox *mbox)                    \
 {									\
 	struct _req_type *req;						\
+	u16 pcifunc = mbox->pfvf->pcifunc;				\
 									\
 	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
 		&mbox->mbox, 0, sizeof(struct _req_type),		\
@@ -879,7 +880,8 @@ static struct _req_type __maybe_unused					\
 		return NULL;						\
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
 	req->hdr.id = _id;						\
-	trace_otx2_msg_alloc(mbox->mbox.pdev, _id, sizeof(*req));	\
+	req->hdr.pcifunc = pcifunc;					\
+	trace_otx2_msg_alloc(mbox->mbox.pdev, _id, sizeof(*req), pcifunc); \
 	return req;							\
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 0aee8e3..1bbc17b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -473,7 +473,7 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 			goto inval_msg;
 
 		/* Set VF's number in each of the msg */
-		msg->pcifunc &= RVU_PFVF_FUNC_MASK;
+		msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
 		msg->pcifunc |= (vf_idx + 1) & RVU_PFVF_FUNC_MASK;
 		offset = msg->next_msgoff;
 	}
@@ -3285,6 +3285,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	req = (struct cgx_link_info_msg *)msghdr;
 	req->hdr.id = MBOX_MSG_CGX_LINK_EVENT;
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = pf->pcifunc;
 	memcpy(&req->link_info, &pf->linfo, sizeof(req->link_info));
 
 	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index fb4da81..ba4ae6d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -136,7 +136,7 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 
 		rsp->hdr.id = MBOX_MSG_CGX_LINK_EVENT;
 		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
-		rsp->hdr.pcifunc = 0;
+		rsp->hdr.pcifunc = req->pcifunc;
 		rsp->hdr.rc = 0;
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
-- 
2.7.4


