Return-Path: <netdev+bounces-247748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C727BCFDFE8
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE8730D5366
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4F339869;
	Wed,  7 Jan 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WxUdYe9M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12253396F4;
	Wed,  7 Jan 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792289; cv=none; b=D+RcvlT0JS65uE/dTNhGRDZmcHLL5rS3K+fTIC+Q4J2X+BCQhmfZx3updR5nBEfYcU3mfZ4W3T2ljpPha49l6eIW+n7ASSnlzjoHGpTEzxYOzV3QhcCeBV5dE9zxD3JugNHEY/Aorq4+bhLPfOLjEe3tSKfbXdnbueh10l2r2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792289; c=relaxed/simple;
	bh=1JxG82oeKPH6jaiQTDVuZCKl4WzKZP0Q8BE4vkoZEV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltHNtPyGkH8lQeaLbCPGpxk91nn+ozArnjF/QtwMhKYJwxakq0Rdtlnphv1SbvnvqqQkCkm11tXEr1SIUQfq+J3JoLc9xyBpr5ZMguCkOFFl5E6vdGRXJ0dlu2VjhXAt2cJG5R6u1SDYfIifJ4aSzDTEcFfrOt7DeNL9XghZb8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WxUdYe9M; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6078OvRl851944;
	Wed, 7 Jan 2026 05:24:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	IksUraBp0GmhaM/JHhl1TWgqEhuCJ+6RbyIKZgcAXA=; b=WxUdYe9MsmRN2mXsT
	t+GmPGRW0ZC+PDutbckZOY0FUbriDCDqtTbDCMVZU1/ZsqpWfQMgYgYnAQ8xnQcg
	UjGeBvU9vUJTmhjJDVYMeIjHGP/1zLrCx5fwLPoYijZk5nQyDyTBycxRaOuZDSA3
	tsxK3ApgFFpxlOzcRDHhKS25ous/qoOa6U2fDPOW+rwgVvurk/iucazdwpHnowuW
	VdVQaafAXt0xla/Kb4XUBARCSC730TLpw9uM4mN6f0LlQDgyAuTW2f1WUYYio1sz
	S4uGkNOQNbLOKPbv/fC0oGGdSh55LtfixMnI7xAaEW9ela5XgDCQDfjVdEBk5wrN
	nltkg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc34hc1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:53 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id ECD773F704A;
	Wed,  7 Jan 2026 05:24:35 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 07/10] octeontx2: switch: L2 offload support
Date: Wed, 7 Jan 2026 18:54:05 +0530
Message-ID: <20260107132408.3904352-8-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107132408.3904352-1-rkannoth@marvell.com>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PJICOPqC c=1 sm=1 tr=0 ts=695e5e97 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=zjSZ3cS-AAAA:8
 a=cAmSjuAziB4ZO2rpmfEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZdzWmiyDu4ucoLeQK2uw:22
X-Proofpoint-GUID: 8MOMrMq9H2tyElDjVZpLAh--kczdWyib
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfXwICtkCVZCHlF
 Ww1y7fDwhTm8ZKPIV9JqOUCFPNRjIFNQqJVPjNwbSpG8Uvn39kd/rcCmicnvFCHX0L2Qp/q1qKV
 OYKKgJp8UJfEd4QO0WiFZcq7VNDfba/FPfp1FuppI9xWFM52B7/cMcm7A9htFhHnFErXQreBNXc
 aCHpQzJzLKajgG4KBd4viLY2kpjyEAMh2/RqiOJr/4hIjSuj0LA7YjYbOkCpC1yRkEdB7XYzD5i
 kZmKV0qt8MsxQJSMuGEWtI/LFaNL5+L13MePNx0excqTeXGoBVVLHF/lx4VrrpRxwwo1haCVb+J
 x+7hbUC/4HrxsELKET+HDkfpG6esNtuMGErlXevsxnljmWwtF1o3l+Um3MAQ2c9nk+dtnr5TCKH
 TG2q3x7t4hDjdkghX5QZEAojMNA3FrMKasWpCzvUHrLf5YXuNOL0N+QZQUtJY8ZQj8tS7qrXxXO
 k3Xg0Nyn19e97dr5ZhA==
X-Proofpoint-ORIG-GUID: 8MOMrMq9H2tyElDjVZpLAh--kczdWyib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Linux bridge fdb events are parsed to decide on DMAC to fwd
packets. Switchdev HW flow table is filled with this information.
Once populated, all packet with DMAC will be accelerated.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   1 +
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  18 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 270 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  17 ++
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 127 ++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |   5 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   5 +-
 8 files changed, 441 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 6b61742a61b1..95decbc5fc0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2460,6 +2460,7 @@ static void __rvu_mbox_up_handler(struct rvu_work *mwork, int type)
 
 		switch (msg->id) {
 		case MBOX_MSG_CGX_LINK_EVENT:
+		case MBOX_MSG_AF2PF_FDB_REFRESH:
 			break;
 		default:
 			if (msg->rc)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 533ee8725e38..b66f9c2eb981 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -7,6 +7,8 @@
 
 #include "rvu.h"
 #include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+#include "rvu_sw_fl.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
@@ -16,7 +18,7 @@ u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);
 
 	port_id = FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
-		  FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+		FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
 
 	return port_id;
 }
@@ -25,5 +27,17 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
 				     struct msg_rsp *rsp)
 {
-	return 0;
+	int rc = 0;
+
+	switch (req->msg_type) {
+	case SWDEV2AF_MSG_TYPE_FW_STATUS:
+		rc = rvu_sw_l2_init_offl_wq(rvu, req->pcifunc, req->fw_up);
+		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
+		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
+		break;
+	}
+
+	return rc;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
index 5f805bfa81ed..edd976b934f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -4,11 +4,281 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+
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
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
+#undef M
+
+struct l2_entry {
+	struct list_head list;
+	u64 flags;
+	u32 port_id;
+	u8  mac[ETH_ALEN];
+};
+
+static DEFINE_MUTEX(l2_offl_list_lock);
+static LIST_HEAD(l2_offl_lh);
+
+static DEFINE_MUTEX(fdb_refresh_list_lock);
+static LIST_HEAD(fdb_refresh_lh);
+
+struct rvu_sw_l2_work {
+	struct rvu *rvu;
+	struct work_struct work;
+};
+
+static struct rvu_sw_l2_work l2_offl_work;
+static struct workqueue_struct *rvu_sw_l2_offl_wq;
+
+static struct rvu_sw_l2_work fdb_refresh_work;
+static struct workqueue_struct *fdb_refresh_wq;
+
+static void rvu_sw_l2_offl_cancel_add_if_del_reqs_exist(u8 *mac)
+{
+	struct l2_entry *entry, *tmp;
+
+	mutex_lock(&l2_offl_list_lock);
+	list_for_each_entry_safe(entry, tmp, &l2_offl_lh, list) {
+		if (!ether_addr_equal(mac, entry->mac))
+			continue;
+
+		if (!(entry->flags & FDB_DEL))
+			continue;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+		break;
+	}
+	mutex_unlock(&l2_offl_list_lock);
+}
+
+static int rvu_sw_l2_offl_rule_push(struct rvu *rvu, struct l2_entry *l2_entry)
+{
+	struct af2swdev_notify_req *req;
+	int swdev_pf;
+
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	ether_addr_copy(req->mac, l2_entry->mac);
+	req->flags = l2_entry->flags;
+	req->port_id = l2_entry->port_id;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static int rvu_sw_l2_fdb_refresh(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct af2pf_fdb_refresh_req *req;
+	int pf, vidx;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+
+	if (pf) {
+		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+
+		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+	} else {
+		vidx = pcifunc - 1;
+
+		req = (struct af2pf_fdb_refresh_req *)
+			otx2_mbox_alloc_msg_rsp(&rvu->afvf_wq_info.mbox_up, vidx,
+						sizeof(*req), sizeof(struct msg_rsp));
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+		req->hdr.sig = OTX2_MBOX_REQ_SIG;
+		req->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+
+		otx2_mbox_wait_for_zero(&rvu->afvf_wq_info.mbox_up, vidx);
+		otx2_mbox_msg_send_up(&rvu->afvf_wq_info.mbox_up, vidx);
+	}
+
+	mutex_unlock(&rvu->mbox_lock);
+
+	return 0;
+}
+
+static void rvu_sw_l2_fdb_refresh_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *fdb_work;
+	struct l2_entry *l2_entry;
+
+	fdb_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (1) {
+		mutex_lock(&fdb_refresh_list_lock);
+		l2_entry = list_first_entry_or_null(&fdb_refresh_lh,
+						    struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&fdb_refresh_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		mutex_unlock(&fdb_refresh_list_lock);
+
+		rvu_sw_l2_fdb_refresh(fdb_work->rvu, l2_entry->port_id, l2_entry->mac);
+		kfree(l2_entry);
+	}
+}
+
+static void rvu_sw_l2_offl_rule_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *offl_work;
+	struct l2_entry *l2_entry;
+	int budget = 16;
+	bool add_fdb;
+
+	offl_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (budget--) {
+		mutex_lock(&l2_offl_list_lock);
+		l2_entry = list_first_entry_or_null(&l2_offl_lh, struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&l2_offl_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		mutex_unlock(&l2_offl_list_lock);
+
+		add_fdb = !!(l2_entry->flags & FDB_ADD);
+
+		if (add_fdb)
+			rvu_sw_l2_offl_cancel_add_if_del_reqs_exist(l2_entry->mac);
+
+		rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry);
+		kfree(l2_entry);
+	}
+
+	if (!list_empty(&l2_offl_lh))
+		queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+}
+
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
+{
+	struct rvu_switch *rswitch;
+
+	rswitch = &rvu->rswitch;
+
+	if (fw_up) {
+		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+		rswitch->pcifunc = pcifunc;
+
+		l2_offl_work.rvu = rvu;
+		INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
+		rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
+		if (!rvu_sw_l2_offl_wq) {
+			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
+			return -ENOMEM;
+		}
+
+		fdb_refresh_work.rvu = rvu;
+		INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
+		fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresg_wq", 0, 0);
+		if (!rvu_sw_l2_offl_wq) {
+			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
+			return -ENOMEM;
+		}
+
+		return 0;
+	}
+
+	rswitch->flags &= ~RVU_SWITCH_FLAG_FW_READY;
+	rswitch->pcifunc = -1;
+	flush_work(&l2_offl_work.work);
+	return 0;
+}
+
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct l2_entry *l2_entry;
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = pcifunc;
+	ether_addr_copy(l2_entry->mac, mac);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	list_add_tail(&l2_entry->list, &fdb_refresh_lh);
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	queue_work(fdb_refresh_wq, &fdb_refresh_work.work);
+	return 0;
+}
 
 int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
 				struct fdb_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l2_entry *l2_entry;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	ether_addr_copy(l2_entry->mac, req->mac);
+	l2_entry->flags = req->flags;
+	l2_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+
+	mutex_lock(&l2_offl_list_lock);
+	list_add_tail(&l2_entry->list, &l2_offl_lh);
+	mutex_unlock(&l2_offl_list_lock);
+
+	queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
index ff28612150c9..56786768880e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -8,4 +8,6 @@
 #ifndef RVU_SW_L2_H
 #define RVU_SW_L2_H
 
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up);
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index f4fdbfba8667..4642a1dd7ccb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -15,6 +15,7 @@
 #include "otx2_ptp.h"
 #include "cn10k.h"
 #include "cn10k_ipsec.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_nicvf"
 #define DRV_STRING	"Marvell RVU NIC Virtual Function Driver"
@@ -141,6 +142,22 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
 		return err;
+
+	case MBOX_MSG_AF2PF_FDB_REFRESH:
+		rsp = (struct msg_rsp *)otx2_mbox_alloc_msg(&vf->mbox.mbox_up, 0,
+							    sizeof(struct msg_rsp));
+		if (!rsp)
+			return -ENOMEM;
+
+		rsp->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+		rsp->hdr.pcifunc = req->pcifunc;
+		rsp->hdr.rc = 0;
+		err = otx2_mbox_up_handler_af2pf_fdb_refresh(vf,
+							     (struct af2pf_fdb_refresh_req *)req,
+							     rsp);
+		return err;
+
 	default:
 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
 		return -ENODEV;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
index 6842c8d91ffc..71aec9628eb2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -4,13 +4,140 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
 #include "sw_fdb.h"
 
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	return 0;
+}
+
+#else
+
+static DEFINE_SPINLOCK(sw_fdb_llock);
+static LIST_HEAD(sw_fdb_lh);
+
+struct sw_fdb_list_entry {
+	struct list_head list;
+	u64 flags;
+	struct otx2_nic *pf;
+	u8  mac[ETH_ALEN];
+	bool add_fdb;
+};
+
+static struct workqueue_struct *sw_fdb_wq;
+static struct work_struct sw_fdb_work;
+
+static int sw_fdb_add_or_del(struct otx2_nic *pf,
+			     const unsigned char *addr,
+			     bool add_fdb)
+{
+	struct fdb_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fdb_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ether_addr_copy(req->mac, addr);
+	req->flags = add_fdb ? FDB_ADD : FDB_DEL;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fdb_wq_handler(struct work_struct *work)
+{
+	struct sw_fdb_list_entry *entry;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fdb_add_or_del(entry->pf, entry->mac, entry->add_fdb);
+		kfree(entry);
+	}
+
+	spin_lock(&sw_fdb_llock);
+	if (!list_empty(&sw_fdb_lh))
+		queue_work(sw_fdb_wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
+}
+
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fdb_list_entry *entry;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	ether_addr_copy(entry->mac, mac);
+	entry->add_fdb = add_fdb;
+	entry->pf = pf;
+
+	spin_lock(&sw_fdb_llock);
+	list_add_tail(&entry->list, &sw_fdb_lh);
+	queue_work(sw_fdb_wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
+
+	return 0;
+}
+
 int sw_fdb_init(void)
 {
+	INIT_WORK(&sw_fdb_work, sw_fdb_wq_handler);
+	sw_fdb_wq = alloc_workqueue("sw_fdb_wq", 0, 0);
+	if (!sw_fdb_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fdb_deinit(void)
 {
+	cancel_work_sync(&sw_fdb_work);
+	destroy_workqueue(sw_fdb_wq);
+}
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	struct switchdev_notifier_fdb_info item = {0};
+
+	item.addr = req->mac;
+	item.info.dev = pf->netdev;
+	call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+				 item.info.dev, &item.info, NULL);
+
+	return 0;
 }
+#endif
+EXPORT_SYMBOL(otx2_mbox_up_handler_af2pf_fdb_refresh);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
index d4314d6d3ee4..f8705083418c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -7,7 +7,12 @@
 #ifndef SW_FDB_H_
 #define SW_FDB_H_
 
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb);
 void sw_fdb_deinit(void);
 int sw_fdb_init(void);
 
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
 #endif // SW_FDB_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index ce565fe7035c..f5e00807c0fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -21,6 +21,7 @@
 #include "sw_fdb.h"
 #include "sw_fib.h"
 #include "sw_fl.h"
+#include "sw_nb.h"
 
 static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
 	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
@@ -59,7 +60,6 @@ static int sw_nb_check_slaves(struct net_device *dev,
 			      struct netdev_nested_priv *priv)
 {
 	int *cnt;
-
 	if (!priv->flags)
 		return 0;
 
@@ -115,11 +115,13 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
+		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, true);
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
+		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, false);
 		break;
 
 	default:
@@ -313,7 +315,6 @@ static int sw_nb_fib_event(struct notifier_block *nb,
 	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
 	if (!entries)
 		return NOTIFY_DONE;
-
 	iter = entries;
 
 	for (i = 0; i < hcnt; i++, iter++) {
-- 
2.43.0


