Return-Path: <netdev+bounces-115790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6F947C6A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35A81F23434
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B5770FE;
	Mon,  5 Aug 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="by99mqLC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3354D8D0;
	Mon,  5 Aug 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866589; cv=none; b=A2nubH4rb0TOaL0+N5Hnpm5rJi6mrKEkQZjc0y3Nb1vCxNLmOfJQoUVi1spvS/wIJxjI/M5RTLO9aky7MJlqpfwC38e3OYr81++tDcAMOEe14CyBlw1nCdFgyLFNpbYK6VdPoOlNgduPnF7z2sT2bIrxo2SLsMjIe7h38tPmDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866589; c=relaxed/simple;
	bh=ujMoy7f4FTOKPzXtqMbp/N5BRd/myduRH9h39/rmXPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+JXnsWEXMX4agqTO1b6Jm2U6oriTfCZO6Ur7D0yNavEev9qXSdVwS+TO3k2dnO6BVHTC1AchWM5J+6PVdywX9w3qdzWHE22XUE5uN0PCsF8gHncH61W+vyLSKUWCcJsN7Sisp1wNPpiQCIg172nZoNCsfxedc5sB8VjZ5oJ91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=by99mqLC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BVVwP021791;
	Mon, 5 Aug 2024 06:42:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wmHE378utIuCj6ovyywQezxEK
	1DaxHbOF40Lxysj9Vg=; b=by99mqLC3F4FJ6ELbqVLkQnhVOIYTsA7y2XwKtYEf
	y3vRwzcKvghMNVNo3z/UZwNqFNK1aorFJF7bAA0lPp2kc8pLim9AhnoPK9TKMU82
	ItEkk6j0t997v+YNHDqBjDQn++mcQuhl2Ou1ZrJdzM3/ymTp2A4V0RwzeTY6oT6m
	1DxPgvtdLnPLPEnSB/WMkvwmG7VcXvNAe15+2ol6jLU31bOWcXB6IC6pNMHwJqOI
	20CzoINfTRli53wjXkx2Epf41b/mi6O2v+aBeztXZRF+bfT5sqo/5juu94vONEf9
	wRECtJwxG0+zR45mtd/0T89GcnokLjjWUn99cnNOpxeQA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40twxd0ck5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 5 Aug 2024 06:42:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 06:42:25 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0D4A45B6EB3;
	Mon,  5 Aug 2024 06:18:42 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v10 07/11] octeontx2-pf: Add support to sync link state between representor and VFs
Date: Mon, 5 Aug 2024 18:48:11 +0530
Message-ID: <20240805131815.7588-8-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: PEXvev_o_l3y4EO20gl7_4e-4ywq0mrl
X-Proofpoint-ORIG-GUID: PEXvev_o_l3y4EO20gl7_4e-4ywq0mrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01

Implements the below requirement mentioned
in the representors documentation.

"
The representee's link state is controlled through the
representor. Setting the representor administratively UP
or DOWN should cause carrier ON or OFF at the representee.
"

This patch enables
- Reflecting the link state of representor based on the VF state and
 link state of VF based on representor.
- On VF interface up/down a notification is sent via mbox to representor
  to update the link state.
  eg: ip link set eth0 up/down  will disable carrier on/off
       of the corresponding representor(r0p1) interface.
- On representor interface up/down will cause the link state update of VF.
  eg: ip link set r0p1 up/down  will disable carrier on/off
       of the corresponding representee(eth0) interface.

Signed-off-by: Harman Kalra <hkalra@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  11 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 127 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  30 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  76 +++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   3 +
 8 files changed, 280 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cd52f414b1c4..a66816d373bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -147,6 +147,7 @@ M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
 M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
+M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -384,12 +385,16 @@ M(CPT_INST_LMTST,	0xD00, cpt_inst_lmtst, cpt_inst_lmtst_req, msg_rsp)
 #define MBOX_UP_MCS_MESSAGES						\
 M(MCS_INTR_NOTIFY,	0xE00, mcs_intr_notify, mcs_intr_info, msg_rsp)
 
+#define MBOX_UP_REP_MESSAGES						\
+M(REP_EVENT_UP_NOTIFY,	0xEF0, rep_event_up_notify, rep_event, msg_rsp) \
+
 enum {
 #define M(_name, _id, _1, _2, _3) MBOX_MSG_ ## _name = _id,
 MBOX_MESSAGES
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_CPT_MESSAGES
 MBOX_UP_MCS_MESSAGES
+MBOX_UP_REP_MESSAGES
 #undef M
 };
 
@@ -1573,6 +1578,26 @@ struct esw_cfg_req {
 	u64 rsvd;
 };
 
+struct rep_evt_data {
+	u8 port_state;
+	u8 vf_state;
+	u16 rx_mode;
+	u16 rx_flags;
+	u16 mtu;
+	u64 rsvd[5];
+};
+
+struct rep_event {
+	struct mbox_msghdr hdr;
+	u16 pcifunc;
+#define RVU_EVENT_PORT_STATE		BIT_ULL(0)
+#define RVU_EVENT_PFVF_STATE		BIT_ULL(1)
+#define RVU_EVENT_MTU_CHANGE		BIT_ULL(2)
+#define RVU_EVENT_RX_MODE_CHANGE	BIT_ULL(3)
+	u16 event;
+	struct rep_evt_data evt_data;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 776dd92910f0..f65ece839d88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -513,6 +513,11 @@ struct rvu_switch {
 	u16 start_entry;
 };
 
+struct rep_evtq_ent {
+	struct list_head node;
+	struct rep_event event;
+};
+
 struct rvu {
 	void __iomem		*afreg_base;
 	void __iomem		*pfreg_base;
@@ -598,6 +603,11 @@ struct rvu {
 	int			rep_cnt;
 	u16			*rep2pfvf_map;
 	u8			rep_mode;
+	struct			work_struct rep_evt_work;
+	struct			workqueue_struct *rep_evt_wq;
+	struct list_head	rep_evtq_head;
+	/* Representor event lock */
+	spinlock_t		rep_evtq_lock;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -1046,4 +1056,5 @@ void rvu_mcs_exit(struct rvu *rvu);
 int rvu_rep_pf_init(struct rvu *rvu);
 int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
+int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index cdec650f0eb0..720ebf0b36cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -380,6 +380,9 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
 		rvu_npc_set_pkind(rvu, pkind, pfvf);
 
+		if (rvu->rep_mode)
+			rvu_rep_notify_pfvf_state(rvu, pcifunc, true);
+
 		break;
 	case NIX_INTF_TYPE_LBK:
 		vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
@@ -516,6 +519,9 @@ static void nix_interface_deinit(struct rvu *rvu, u16 pcifunc, u8 nixlf)
 
 	/* Disable DMAC filters used */
 	rvu_cgx_disable_dmac_entries(rvu, pcifunc);
+
+	if (rvu->rep_mode)
+		rvu_rep_notify_pfvf_state(rvu, pcifunc, false);
 }
 
 #define NIX_BPIDS_PER_LMAC	8
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 6bc867dea42e..404700cdfcdd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -13,6 +13,124 @@
 #include "rvu.h"
 #include "rvu_reg.h"
 
+#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
+static struct _req_type __maybe_unused					\
+*otx2_mbox_alloc_msg_ ## _fn_name(struct rvu *rvu, int devid)		\
+{									\
+	struct _req_type *req;						\
+									\
+	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
+		&rvu->afpf_wq_info.mbox_up, devid, sizeof(struct _req_type), \
+		sizeof(struct _rsp_type));				\
+	if (!req)							\
+		return NULL;						\
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
+	req->hdr.id = _id;						\
+	return req;							\
+}
+
+MBOX_UP_REP_MESSAGES
+#undef M
+
+static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
+{
+	struct rep_event *msg;
+	int pf;
+
+	pf = rvu_get_pf(event->pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
+	if (!msg) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	msg->hdr.pcifunc = event->pcifunc;
+	msg->event = event->event;
+
+	memcpy(&msg->evt_data, &event->evt_data, sizeof(struct rep_evt_data));
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static void rvu_rep_wq_handler(struct work_struct *work)
+{
+	struct rvu *rvu = container_of(work, struct rvu, rep_evt_work);
+	struct rep_evtq_ent *qentry;
+	struct rep_event *event;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&rvu->rep_evtq_lock, flags);
+		qentry = list_first_entry_or_null(&rvu->rep_evtq_head,
+						  struct rep_evtq_ent,
+						  node);
+		if (qentry)
+			list_del(&qentry->node);
+
+		spin_unlock_irqrestore(&rvu->rep_evtq_lock, flags);
+		if (!qentry)
+			break; /* nothing more to process */
+
+		event = &qentry->event;
+
+		rvu_rep_up_notify(rvu, event);
+		kfree(qentry);
+	} while (1);
+}
+
+int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
+				      struct msg_rsp *rsp)
+{
+	struct rep_evtq_ent *qentry;
+
+	qentry = kmalloc(sizeof(*qentry), GFP_ATOMIC);
+	if (!qentry)
+		return -ENOMEM;
+
+	qentry->event = *req;
+	spin_lock(&rvu->rep_evtq_lock);
+	list_add_tail(&qentry->node, &rvu->rep_evtq_head);
+	spin_unlock(&rvu->rep_evtq_lock);
+	queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);
+	return 0;
+}
+
+int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
+{
+	struct rep_event *req;
+	int pf;
+
+	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))
+		return 0;
+
+	pf = rvu_get_pf(rvu->rep_pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	req->hdr.pcifunc = rvu->rep_pcifunc;
+	req->event |= RVU_EVENT_PFVF_STATE;
+	req->pcifunc = pcifunc;
+	req->evt_data.vf_state = enable;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
 #define RVU_LF_RX_STATS(reg) \
 		rvu_read64(rvu, blkaddr, NIX_AF_LFX_RX_STATX(nixlf, reg))
 
@@ -247,6 +365,15 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 			}
 		}
 	}
+
+	/* Initialize the wq for handling REP events */
+	INIT_LIST_HEAD(&rvu->rep_evtq_head);
+	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
+	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", 0, 0);
+	if (!rvu->rep_evt_wq) {
+		dev_err(rvu->dev, "REP workqueue allocation failed\n");
+		return -ENOMEM;
+	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index d297138c356e..bddec8b35ef7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -441,6 +441,7 @@ struct otx2_nic {
 #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
 #define OTX2_FLAG_TC_MARK_ENABLED		BIT_ULL(17)
 #define OTX2_FLAG_REP_MODE_ENABLED		 BIT_ULL(18)
+#define OTX2_FLAG_PORT_UP			BIT_ULL(19)
 	u64			flags;
 	u64			*cq_op_addr;
 
@@ -1126,4 +1127,5 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 int otx2_get_txq_by_classid(struct otx2_nic *pfvf, u16 classid);
 void otx2_qos_config_txschq(struct otx2_nic *pfvf);
 void otx2_clean_qos_queues(struct otx2_nic *pfvf);
+int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index fb7f8d3dae78..cdd1f1321318 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -519,6 +519,7 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 
 		switch (msg->id) {
 		case MBOX_MSG_CGX_LINK_EVENT:
+		case MBOX_MSG_REP_EVENT_UP_NOTIFY:
 			break;
 		default:
 			if (msg->rc)
@@ -832,6 +833,9 @@ static void otx2_handle_link_event(struct otx2_nic *pf)
 	struct cgx_link_user_info *linfo = &pf->linfo;
 	struct net_device *netdev = pf->netdev;
 
+	if (pf->flags & OTX2_FLAG_PORT_UP)
+		return;
+
 	pr_info("%s NIC Link is %s %d Mbps %s duplex\n", netdev->name,
 		linfo->link_up ? "UP" : "DOWN", linfo->speed,
 		linfo->full_duplex ? "Full" : "Half");
@@ -844,6 +848,30 @@ static void otx2_handle_link_event(struct otx2_nic *pf)
 	}
 }
 
+static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
+						    struct rep_event *info,
+						    struct msg_rsp *rsp)
+{
+	struct net_device *netdev = pf->netdev;
+
+	if (info->event == RVU_EVENT_PORT_STATE) {
+		if (info->evt_data.port_state) {
+			pf->flags |= OTX2_FLAG_PORT_UP;
+			netif_carrier_on(netdev);
+			netif_tx_start_all_queues(netdev);
+		} else {
+			pf->flags &= ~OTX2_FLAG_PORT_UP;
+			netif_tx_stop_all_queues(netdev);
+			netif_carrier_off(netdev);
+		}
+		return 0;
+	}
+#ifdef CONFIG_RVU_ESWITCH
+	rvu_event_up_notify(pf, info);
+#endif
+	return 0;
+}
+
 int otx2_mbox_up_handler_mcs_intr_notify(struct otx2_nic *pf,
 					 struct mcs_intr_info *event,
 					 struct msg_rsp *rsp)
@@ -913,6 +941,7 @@ static int otx2_process_mbox_msg_up(struct otx2_nic *pf,
 	}
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
+MBOX_UP_REP_MESSAGES
 #undef M
 		break;
 	default:
@@ -1975,6 +2004,7 @@ int otx2_open(struct net_device *netdev)
 	}
 
 	pf->flags &= ~OTX2_FLAG_INTF_DOWN;
+	pf->flags &= ~OTX2_FLAG_PORT_UP;
 	/* 'intf_down' may be checked on any cpu */
 	smp_wmb();
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index d4e90b13db71..aedcff57d96f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,57 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_get_repid(struct otx2_nic *priv, u16 pcifunc)
+{
+	int rep_id;
+
+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++)
+		if (priv->rep_pf_map[rep_id] == pcifunc)
+			return rep_id;
+	return -EINVAL;
+}
+
+static int rvu_rep_notify_pfvf(struct otx2_nic *priv, u16 event,
+			       struct rep_event *data)
+{
+	struct rep_event *req;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_rep_event_notify(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return -ENOMEM;
+	}
+	req->event = event;
+	req->pcifunc = data->pcifunc;
+
+	memcpy(&req->evt_data, &data->evt_data, sizeof(struct rep_evt_data));
+	otx2_sync_mbox_msg(&priv->mbox);
+	mutex_unlock(&priv->mbox.lock);
+	return 0;
+}
+
+static void rvu_rep_state_evt_handler(struct otx2_nic *priv,
+				      struct rep_event *info)
+{
+	struct rep_dev *rep;
+	int rep_id;
+
+	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
+	rep = priv->reps[rep_id];
+	if (info->evt_data.vf_state)
+		rep->flags |= RVU_REP_VF_INITIALIZED;
+	else
+		rep->flags &= ~RVU_REP_VF_INITIALIZED;
+}
+
+int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info)
+{
+	if (info->event & RVU_EVENT_PFVF_STATE)
+		rvu_rep_state_evt_handler(pf, info);
+	return 0;
+}
+
 static void rvu_rep_get_stats(struct work_struct *work)
 {
 	struct delayed_work *del_work = to_delayed_work(work);
@@ -78,6 +129,9 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 {
 	struct rep_dev *rep = netdev_priv(dev);
 
+	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+		return;
+
 	stats->rx_packets = rep->stats.rx_frames;
 	stats->rx_bytes = rep->stats.rx_bytes;
 	stats->rx_dropped = rep->stats.rx_drops;
@@ -132,16 +186,38 @@ static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static int rvu_rep_open(struct net_device *dev)
 {
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *priv = rep->mdev;
+	struct rep_event evt = {0};
+
+	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+		return 0;
+
 	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
+
+	evt.event = RVU_EVENT_PORT_STATE;
+	evt.evt_data.port_state = 1;
+	evt.pcifunc = rep->pcifunc;
+	rvu_rep_notify_pfvf(priv, RVU_EVENT_PORT_STATE, &evt);
 	return 0;
 }
 
 static int rvu_rep_stop(struct net_device *dev)
 {
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *priv = rep->mdev;
+	struct rep_event evt = {0};
+
+	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+		return 0;
+
 	netif_carrier_off(dev);
 	netif_tx_disable(dev);
 
+	evt.event = RVU_EVENT_PORT_STATE;
+	evt.pcifunc = rep->pcifunc;
+	rvu_rep_notify_pfvf(priv, RVU_EVENT_PORT_STATE, &evt);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 5d39bf636655..0cefa482f83c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -36,6 +36,8 @@ struct rep_dev {
 	struct delayed_work stats_wrk;
 	u16 rep_id;
 	u16 pcifunc;
+#define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
+	u8 flags;
 };
 
 static inline bool otx2_rep_dev(struct pci_dev *pdev)
@@ -45,4 +47,5 @@ static inline bool otx2_rep_dev(struct pci_dev *pdev)
 
 int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack);
 void rvu_rep_destroy(struct otx2_nic *priv);
+int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info);
 #endif /* REP_H */
-- 
2.25.1


