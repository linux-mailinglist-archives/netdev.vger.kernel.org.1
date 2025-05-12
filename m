Return-Path: <netdev+bounces-189661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC20AB31E8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D303A2D29
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39BC259CBE;
	Mon, 12 May 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Jwd3VFWs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A03259CA4
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039354; cv=none; b=sEUUNuj2ucyt6+QtJRavN4zcD8Q9ryZ0HAykoWoGULakSmuzGTsMdIeQnKfBZvrn4Kxdq1JcM3iUDOO69oVqKaLRTJXf5BtRb7G4Wfk6L7iv0Z6mNHZjQHZ85aoZUcMwqwPSrvC9wJ31yYbmrx34cwn4+Hw2sttBbyUPKUK1JGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039354; c=relaxed/simple;
	bh=Iv0VGxbZ7WZGskXAiEBiw/6txsBcaunK3Zz3dKkqqV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKYBqzBeCn09bC/uiwB13kDCkC1C2wc5lriWtcA7aH99dI6Al0VOinQ89bXlUgO+Qij8XDi3oWl6XPtvKr3Y9p1dkkbqIemthAmIYoWWM4bsEbyqdGxWt1l1302N3t8Z0HAOBokR3zli20RAXSk8zjdUiMjx2QffJ3VY8jzt5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Jwd3VFWs; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7lZV6016825;
	Mon, 12 May 2025 01:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=u7YByL7yLha2dUpcDOXlrVqfV
	Rpv4TLkRNS0Ls9zuPA=; b=Jwd3VFWsXxXE7S/+49fTKVAUevf2Ah004FWCJNxZi
	hzkAFh+qBSSTJglxQYeO8hdOgkaYGJjjASEkyAiEkTGvWSMiVkDdEqa7hqz2YdZG
	KJ2yK9n8cq1ZyQV8/Dvht7Pxpm2HCJ9s4F3j3iu6l/WbRd93/LxBYKv8XnQjkDl/
	+fawtwXq8f2qTTdG24+XWtOy5VvrcLkGiN6wlJ+kV8kZ9SEx5zGFvMI6LD35NUsT
	WEOK2hDsMF0qwSdKzVkW39UttmekxbTBrmMT96ws7Ahze1NZGESJRK0AdxhoWCiH
	r4C3h5P0yptd24L0fhM/Hx6i/Q6ssh2ZHOObm6Xn2+2Mw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46k5rggnna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 01:42:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 01:42:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 01:42:23 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 2531D3F7089;
	Mon, 12 May 2025 01:42:18 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 3/4] octeontx2: Add pcifunc also to mailbox tracepoints
Date: Mon, 12 May 2025 14:11:53 +0530
Message-ID: <1747039315-3372-4-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-GUID: cR8S6VBX4-YoH_bgTLPKmeyNWyWHBTY7
X-Proofpoint-ORIG-GUID: cR8S6VBX4-YoH_bgTLPKmeyNWyWHBTY7
X-Authority-Analysis: v=2.4 cv=XIkwSRhE c=1 sm=1 tr=0 ts=6821b470 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=_bv6PHYV_TvcDR7bTVsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MSBTYWx0ZWRfX0dFztl12PAu0 e+i4FhJzVYxdQFbvoqHtzX5gruE+mSMCz1TCEQpQdS7poQT98dCTCqBDHqJAJh6aP6/bDBFnVkM spo0uazMf1mjhA79uE8Xtholfs7S5yaIvibhPWuS+aMv0X5We0AglYCVzqxJ0+tmkhtwGa8sEGT
 9QdVMmg0tcQFUzzJVboc7U9K0ZjopTAbh99Z4+FABVb9nnY6c9y7N3r3L2Nxq5sPrn3IqjKfBeo WsSU+0jl1HYZw2pkoZnNlrl0kkYtX+L31vK38HWoLiT1jSAuzMwUn/Me5/gP/mId9F+TaJ5+VzO 3G8EX1zQJHuyH/r7H2HnsMwRq5M+HHngvG0y13JIWgFIUZ5S+sAE7E9b7KaXSwmOyuo7EkOT97c
 kJk0YlL4gzoGpDVwOXe8zUCYrS6sUYPLyeTV5nXMLfiv+8gQid6nyOArNuwK4HaDFw4KmZI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01

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
index f3b28c1..721d4a5 100644
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


