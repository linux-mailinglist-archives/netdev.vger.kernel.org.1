Return-Path: <netdev+bounces-102887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A903A9054F4
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F851F20C9A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7AD17E44B;
	Wed, 12 Jun 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hsvF9rnV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAE17DE06;
	Wed, 12 Jun 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201897; cv=none; b=XuGuNiM4yCqaZXMbofo5uW+m1QcfVrXFY8vk4ncA/FD9OV98hjzXMmD9WI6DhVdvtYa8L9QDEEBToJTWHaWzUfgjHQhxoo20kBgNA1qVGwMXfzyYVuojTY4og9lIlpWVse1FxDfkN9DYnnm5FETTu5+vVDpCXyIv38yt2O6Oxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201897; c=relaxed/simple;
	bh=wsIumHOKrOr91cTTd2W9ekQqAPpPzILM6EQZJq+b4MA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+6dcl4HtIMTZ4Ll0pSwfrDUKN0AvcTMvRNHUrb+6UHll6qtNbthXw4bKZjb/WAwZBxSTLA/BZUVQtXWzj2GCNlf58iM8nxImMAwPoGFfJ6Vrl3rSIKeJS3bdhw2AiZ0tk3BIsogCh6tVMEuXBD4bcZLJpCHEBDcKwq8WNDt43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hsvF9rnV; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C95Ms3027429;
	Wed, 12 Jun 2024 07:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=AtazX0aw/VJORBJtc3rt0b67eSpt6jX+aQOXi9Tjfd4=; b=hsv
	F9rnVIk83JM8VgChgX+Vo4/vS1yBb6aMaXqVkGizRAfHQVNU9bdax3DItjmU2TM6
	lCHbGbpd1Radj6sOgv45P5b0PXXG8oxwkkybGTCaqDzdNil9diofcL6w16rEyQgp
	Mv2IWctm4bXqWBqHaemLQwDzppHlKvKlvkWzQtDB4Z4dCGCcHf1O1tRDLV7C4hym
	n37832q6x1j4+d8DxcapOR3FtDBi+VNCzw2Fgt3tVEKAYeeluxnM44WZqApui5gX
	DMwzrpJmDPlXjexsRyQB3bXPS0J6ujntKyzVugscn2z5DLjP/52SLis9yZlNjyzq
	2TWYFVlMa7F2QRqC/yg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0yec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 07:18:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 07:18:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 07:18:04 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 2F6FE3F7044;
	Wed, 12 Jun 2024 07:18:00 -0700 (PDT)
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
Subject: [net-next PATCH v2] octeontx2: Improve mailbox tracepoints for debugging
Date: Wed, 12 Jun 2024 19:47:57 +0530
Message-ID: <1718201878-28775-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: fDhQd4rCvqu9BZRPMiZYutdBOh2fMH_D
X-Proofpoint-ORIG-GUID: fDhQd4rCvqu9BZRPMiZYutdBOh2fMH_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01

The tracepoints present currently wrt mailbox do not
provide enough information to debug mailbox activity.
For a VF to send a message to AF, VF sends message to PF
and PF forwards it to AF. This involves stages of
PF receiving interrupt from VF, forwarding to AF, AF
processing and sending response back to PF, PF sending back
the response to VF. This patch adds pcifunc which represents
PF and VF device to the tracepoints otx2_msg_alloc,
otx2_msg_send, otx2_msg_process so that it is easier
to correlate which device allocated the message, which
device forwarded it and which device processed that message.
Also add message id in otx2_msg_send tracepoint and new
tracepoint otx2_msg_status to display the status at each
stage.

Below is the trace log when a VF sends a message to AF with
this patch in place:

ifconfig-523 [001] ....   146.134718: otx2_msg_alloc: [0002:05:00.1]
	msg:(NIX_RSS_FLOWKEY_CFG) size:28 pcifunc:0x1001

ifconfig-523 [001] ...1   146.134719: otx2_msg_send: [0002:05:00.1]
	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001

  <idle>-0 [000] d.h1   146.134722: otx2_msg_interrupt: [0002:05:00.0]
	mbox interrupt VF(s) to PF (0x1)

kworker/u49:2-238 [002] ....   146.134723: otx2_msg_status: [0002:05:00.0]
	PF-VF down queue handler(forwarding) num_msgs:1

kworker/u49:2-238 [002] ...1   146.134724: otx2_msg_send: [0002:05:00.0]
	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001

  <idle>-0 [000] d.h1   146.134726: otx2_msg_interrupt: [0002:01:00.0]
	mbox interrupt PF(s) to AF (0x10)

kworker/u49:1-184 [000] ....   146.134739: otx2_msg_process: [0002:01:00.0]
	msg:(NIX_RSS_FLOWKEY_CFG) error:0 pcifunc:0x1001

kworker/u49:1-184 [000] ...1   146.134740: otx2_msg_send: [0002:01:00.0]
	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001

  <idle>-0 [000] dNh2   146.134742: otx2_msg_interrupt: [0002:05:00.0]
	mbox interrupt DOWN reply from AF to PF (0x1)

  <idle>-0 [000] dNh2   146.134742: otx2_msg_status: [0002:05:00.0]
	PF-AF down work queued(interrupt) num_msgs:1

kworker/u49:1-184 [000] ....   146.134743: otx2_msg_status: [0002:05:00.0]
	PF-AF down queue handler(response) num_msgs:1

  <idle>-0 [000] d.h1   146.135730: otx2_msg_interrupt: [0002:05:00.1]
	mbox interrupt DOWN reply from PF to VF (0x1)

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2:
 Fixed build error


 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   | 17 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.c  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  | 62 +++++++++++++++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 21 +++++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  2 +-
 8 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 1e5aa53..7d21905 100644
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
@@ -219,6 +218,7 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_hdr *tx_hdr, *rx_hdr;
 	void *hw_mbase = mdev->hwbase;
+	struct mbox_msghdr *msg;
 	u64 intr_val;
 
 	tx_hdr = hw_mbase + mbox->tx_start;
@@ -251,7 +251,10 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	tx_hdr->num_msgs = mdev->num_msgs;
 	rx_hdr->num_msgs = 0;
 
-	trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size);
+	msg = (struct mbox_msghdr *)(hw_mbase + mbox->tx_start + msgs_offset);
+
+	trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size,
+			    msg->id, msg->pcifunc);
 
 	spin_unlock(&mdev->mbox_lock);
 
@@ -445,6 +448,14 @@ const char *otx2_mbox_id2name(u16 id)
 #define M(_name, _id, _1, _2, _3) case _id: return # _name;
 	MBOX_MESSAGES
 #undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CGX_MESSAGES
+#undef M
+
+#define M(_name, _id, _1, _2, _3) case _id: return # _name;
+	MBOX_UP_CPT_MESSAGES
+#undef M
 	default:
 		return "INVALID ID";
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251..a5e4888 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2106,7 +2106,7 @@ static int rvu_process_mbox_msg(struct otx2_mbox *mbox, int devid,
 		if (rsp && err)						\
 			rsp->hdr.rc = err;				\
 									\
-		trace_otx2_msg_process(mbox->pdev, _id, err);		\
+		trace_otx2_msg_process(mbox->pdev, _id, err, req->pcifunc); \
 		return rsp ? err : -ENOMEM;				\
 	}
 MBOX_MESSAGES
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 266ecbc..a335404 100644
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
index 5704520f..e7c2160 100644
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
@@ -81,18 +90,47 @@ TRACE_EVENT(otx2_msg_interrupt,
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
+	    ),
+	    TP_printk("[%s] msg:(%s) error:%d pcifunc:0x%x\n", __get_str(dev),
+		      otx2_mbox_id2name(__entry->id),
+		      __entry->err, __entry->pcifunc)
+);
+
+TRACE_EVENT(otx2_msg_wait_rsp,
+	    TP_PROTO(const struct pci_dev *pdev),
+	    TP_ARGS(pdev),
+	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
+	    ),
+	    TP_fast_assign(__assign_str(dev, pci_name(pdev))
+	    ),
+	    TP_printk("[%s] timed out while waiting for response\n",
+		      __get_str(dev))
+);
+
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
 	    ),
-	    TP_printk("[%s] msg:(%s) error:%d\n", __get_str(dev),
-		      otx2_mbox_id2name(__entry->id), __entry->err)
+	    TP_printk("[%s] %s num_msgs:%d\n", __get_str(dev),
+		      __get_str(str), __entry->num_msgs)
 );
 
 #endif /* __RVU_TRACE_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 24fbbef..f441103 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -847,6 +847,7 @@ static struct _req_type __maybe_unused					\
 *otx2_mbox_alloc_msg_ ## _fn_name(struct mbox *mbox)                    \
 {									\
 	struct _req_type *req;						\
+	u16 pcifunc = mbox->pfvf->pcifunc;				\
 									\
 	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
 		&mbox->mbox, 0, sizeof(struct _req_type),		\
@@ -855,7 +856,8 @@ static struct _req_type __maybe_unused					\
 		return NULL;						\
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
 	req->hdr.id = _id;						\
-	trace_otx2_msg_alloc(mbox->mbox.pdev, _id, sizeof(*req));	\
+	req->hdr.pcifunc = pcifunc;					\
+	trace_otx2_msg_alloc(mbox->mbox.pdev, _id, sizeof(*req), pcifunc); \
 	return req;							\
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f5bce3e..77156f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -463,6 +463,9 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 
 	offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-VF down queue handler(forwarding)",
+			      vf_mbox->num_msgs);
+
 	for (id = 0; id < vf_mbox->num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
 					     offset);
@@ -471,7 +474,7 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 			goto inval_msg;
 
 		/* Set VF's number in each of the msg */
-		msg->pcifunc &= RVU_PFVF_FUNC_MASK;
+		msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
 		msg->pcifunc |= (vf_idx + 1) & RVU_PFVF_FUNC_MASK;
 		offset = msg->next_msgoff;
 	}
@@ -501,6 +504,9 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 
 	offset = mbox->rx_start + ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-VF up queue handler(response)",
+			      vf_mbox->up_num_msgs);
+
 	for (id = 0; id < vf_mbox->up_num_msgs; id++) {
 		msg = mdev->mbase + offset;
 
@@ -816,6 +822,9 @@ static void otx2_pfaf_mbox_handler(struct work_struct *work)
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 	pf = af_mbox->pfvf;
 
+	trace_otx2_msg_status(pf->pdev, "PF-AF down queue handler(response)",
+			      num_msgs);
+
 	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 		otx2_process_pfaf_mbox_msg(pf, msg);
@@ -938,6 +947,9 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 
+	trace_otx2_msg_status(pf->pdev, "PF-AF up queue handler(notification)",
+			      num_msgs);
+
 	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 
@@ -987,6 +999,9 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 		trace_otx2_msg_interrupt(pf->pdev, "UP message from AF to PF",
 					 BIT_ULL(0));
+
+		trace_otx2_msg_status(pf->pdev, "PF-AF up work queued(interrupt)",
+				      hdr->num_msgs);
 	}
 
 	if (mbox_data & MBOX_DOWN_MSG) {
@@ -1003,6 +1018,9 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 		trace_otx2_msg_interrupt(pf->pdev, "DOWN reply from AF to PF",
 					 BIT_ULL(0));
+
+		trace_otx2_msg_status(pf->pdev, "PF-AF down work queued(interrupt)",
+				      hdr->num_msgs);
 	}
 
 	return IRQ_HANDLED;
@@ -3170,6 +3188,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	req = (struct cgx_link_info_msg *)msghdr;
 	req->hdr.id = MBOX_MSG_CGX_LINK_EVENT;
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = pf->pcifunc;
 	memcpy(&req->link_info, &pf->linfo, sizeof(req->link_info));
 
 	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 99fcc56..cb94dce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -134,7 +134,7 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 
 		rsp->hdr.id = MBOX_MSG_CGX_LINK_EVENT;
 		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
-		rsp->hdr.pcifunc = 0;
+		rsp->hdr.pcifunc = req->pcifunc;
 		rsp->hdr.rc = 0;
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
-- 
2.7.4


