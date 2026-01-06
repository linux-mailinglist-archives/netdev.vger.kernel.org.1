Return-Path: <netdev+bounces-247291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A4CF670C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3282F3047D8A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F027AC5C;
	Tue,  6 Jan 2026 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Fbjx3QwT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0BB2566D3;
	Tue,  6 Jan 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665753; cv=none; b=Kj7tAnjR+RWAScNFuwvsq4MaMnAt0SehSG9qCHnP2Ai3NEt5IfMcgwKVLvb8/LzMFIFP9PoP4DeHlOomZifMgLS/Yg9hBl3Q+BI6WsZq99IkftfUz2kgtRP2LBXCRfxDpH3WfM/MdY+QJp6tV46pTONq0vKqOKsmE0LUF7LPpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665753; c=relaxed/simple;
	bh=+c3GqZSWsd+zGf4GAE9uc7Q0L8b+ww84vXYrWWQdBKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPf41/QVmwkHlXyJXMmW3rbvMxB0QFaW19QH43IJdspNTqLqhsFpc2aQfxRADxUzhwxirQtxpw3sgYxrT15Ls+/2cm+xWuvpoOg+bp2HbeAAk7dcrANYhWsoqPir5Vl6FM3SasBsxcfzv0T+o+BKgaOpyduXleaQkJAeFHnjp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fbjx3QwT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605HFNHW2644729;
	Mon, 5 Jan 2026 18:15:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	76Uo7p8fLjH4gD/1gYIKC1LlX4XTWRBBBUmcghfHwU=; b=Fbjx3QwTn1/69Ulsw
	tzhQcc+L0jor/Wic4ccTI2Ws2V1x3yP9z6IkdFzKwxEYnRh8mNUOKtg/KCAyKqLn
	YWp53GSUdkd2LLbTHWJhvOvwj3Zjd/YYDAvQlDhjOyhe2dVqOrwD5eGEu0UNqhJ/
	PzyCIUHc6oQ6/ykwOF8He63JZq0ZAASAjXfSeXj4t9WNjZ7i1660hbipgS0UgGPE
	QFcjIW0CTmmO8tq18oNppv5qXsaFKW9WfXfv4v3dA12lHyfwRwzPLNU7OSRB3T4Y
	JkuhE+ovWaFm+AOjc015DhiI+K50gU8FF7mBIvl30wRm5bD1Sli6gbshVy+zC6Mi
	K7PBQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bfr8bk802-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 18:15:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 18:15:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 18:15:39 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 082A93F70C6;
	Mon,  5 Jan 2026 18:15:36 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next 09/10] octeontx2: switch: Flow offload support
Date: Tue, 6 Jan 2026 07:44:46 +0530
Message-ID: <20260106021447.2359108-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106021447.2359108-1-rkannoth@marvell.com>
References: <20260106021447.2359108-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MLgKUVgq3jG8k6ijLe5xmlURfyAA3TcM
X-Proofpoint-GUID: MLgKUVgq3jG8k6ijLe5xmlURfyAA3TcM
X-Authority-Analysis: v=2.4 cv=P/I3RyAu c=1 sm=1 tr=0 ts=695c704d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=Z7sHsl9PSiaRs34vivkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX37Qj7J76IPUM
 MMV6hhojvkB9S/PqujJtzzyCrBVaiVlyM8kJQgZjHl2wC00nhVhLtD2voLiSAlehJ423crZIh/w
 LcUb2BuJoiwqQmggs8Vxumgv3ZFEk2XYtwxvPKXJLaL4ZJqIlR9TZVAgY0sWEdNU0ga5LJXzTRF
 hI6LWQOWhhkPlWA+gC5jQQ8h7w+AG22TVrUB9eRJmub5Q0eQr6KFALw+O4C2nJ4StlQK0/xVR+o
 sVdqABnLBvQ3fMdYLKTnHG7ni7lEATw457Odp+KJS3pjNkVxOMVJGMwjgoo7Sb6QBeSaH0/7XXQ
 rtszRYDEp3SSv8EIJmVDtv6EpwY9yUdUaNrrWKBvl8tIcF8gIBSuXHr96WTrhalfO6RrGAL2vGI
 lF3WHDT0+HLltklcvllX+tW+QCOSk9bCoLJvGV1uaDbpE0jWsN6kvCKuxZ0Hu3DKCpjr4NiqiPX
 1MYLOFKNxfpoVis5aEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

OVS/NFT pushed HW acceleration rules to pf driver thru .ndo_tc().
Switchdev HW flow table is filled with this information.
Once populated, flow will be accelerated.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   4 +
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 273 +++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  17 +-
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 516 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |   2 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   1 -
 7 files changed, 813 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe91b0a6baf5..10aed0ca5934 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -37,6 +37,10 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
 		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
 		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FL:
+		rc = rvu_sw_fl_stats_sync2db(rvu, req->fl, req->cnt);
+		break;
 	}
 
 	return rc;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
index 1f8b82a84a5d..ab03f6596899 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -4,12 +4,258 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_fl.h"
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
+#undef M
+
+static struct workqueue_struct *sw_fl_offl_wq;
+
+struct fl_entry {
+	struct list_head list;
+	struct rvu *rvu;
+	u32 port_id;
+	unsigned long cookie;
+	struct fl_tuple tuple;
+	u64 flags;
+	u64 features;
+};
+
+static DEFINE_MUTEX(fl_offl_llock);
+static LIST_HEAD(fl_offl_lh);
+static bool fl_offl_work_running;
+
+static struct workqueue_struct *sw_fl_offl_wq;
+static void sw_fl_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(fl_offl_work, sw_fl_offl_work_handler);
+
+struct sw_fl_stats_node {
+	struct list_head list;
+	unsigned long cookie;
+	u16 mcam_idx[2];
+	u64 opkts, npkts;
+	bool uni_di;
+};
+
+static LIST_HEAD(sw_fl_stats_lh);
+static DEFINE_MUTEX(sw_fl_stats_lock);
+
+static int
+rvu_sw_fl_stats_sync2db_one_entry(unsigned long cookie, u8 disabled,
+				  u16 mcam_idx[2], bool uni_di, u64 pkts)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != cookie)
+			continue;
+
+		if (disabled) {
+			list_del_init(&snode->list);
+			mutex_unlock(&sw_fl_stats_lock);
+			kfree(snode);
+			return 0;
+		}
+
+		if (snode->uni_di != uni_di) {
+			snode->uni_di = uni_di;
+			snode->mcam_idx[1] = mcam_idx[1];
+		}
+
+		if (snode->opkts == pkts) {
+			mutex_unlock(&sw_fl_stats_lock);
+			return 0;
+		}
+
+		snode->npkts = pkts;
+		mutex_unlock(&sw_fl_stats_lock);
+		return 0;
+	}
+	mutex_unlock(&sw_fl_stats_lock);
+
+	snode = kcalloc(1, sizeof(*snode), GFP_KERNEL);
+	if (!snode)
+		return -ENOMEM;
+
+	snode->cookie = cookie;
+	snode->mcam_idx[0] = mcam_idx[0];
+	if (!uni_di)
+		snode->mcam_idx[1] = mcam_idx[1];
+
+	snode->npkts = pkts;
+	snode->uni_di = uni_di;
+	INIT_LIST_HEAD(&snode->list);
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_add_tail(&snode->list, &sw_fl_stats_lh);
+	mutex_unlock(&sw_fl_stats_lock);
+
+	return 0;
+}
+
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt)
+{
+	struct npc_mcam_get_mul_stats_req *req = NULL;
+	struct npc_mcam_get_mul_stats_rsp *rsp = NULL;
+	int tot = 0;
+	u16 i2idx_map[256];
+	int rc = 0;
+	u64 pkts;
+	int idx;
+
+	for (int i = 0; i < cnt; i++) {
+		tot++;
+		if (fl[i].uni_di)
+			continue;
+
+		tot++;
+	}
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	rsp = kcalloc(1, sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	req->cnt = tot;
+	idx = 0;
+	for (int i = 0; i < tot; idx++) {
+		i2idx_map[i] = idx;
+		req->entry[i++] = fl[idx].mcam_idx[0];
+		if (fl[idx].uni_di)
+			continue;
+
+		i2idx_map[i] = idx;
+		req->entry[i++] = fl[idx].mcam_idx[1];
+	}
+
+	if (rvu_mbox_handler_npc_mcam_mul_stats(rvu, req, rsp)) {
+		dev_err(rvu->dev, "Error to get multiple stats\n");
+		rc = -EFAULT;
+		goto fail;
+	}
+
+	for (int i = 0; i < tot;) {
+		idx = i2idx_map[i];
+		pkts =  rsp->stat[i++];
+
+		if (!fl[idx].uni_di)
+			pkts += rsp->stat[i++];
+
+		rc |= rvu_sw_fl_stats_sync2db_one_entry(fl[idx].cookie, fl[idx].dis,
+							fl[idx].mcam_idx,
+							fl[idx].uni_di, pkts);
+	}
+
+fail:
+	kfree(req);
+	kfree(rsp);
+	return rc;
+}
+
+static void sw_fl_offl_dump(struct fl_entry *fl_entry)
+{
+	struct fl_tuple *tuple = &fl_entry->tuple;
+
+	pr_debug("%pI4 to %pI4\n", &tuple->ip4src, &tuple->ip4dst);
+}
+
+static int rvu_sw_fl_offl_rule_push(struct fl_entry *fl_entry)
+{
+	struct af2swdev_notify_req *req;
+	struct rvu *rvu;
+	int swdev_pf;
+
+	rvu = fl_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	req->tuple = fl_entry->tuple;
+	req->flags = fl_entry->flags;
+	req->cookie = fl_entry->cookie;
+	req->features = fl_entry->features;
+
+	sw_fl_offl_dump(fl_entry);
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static void sw_fl_offl_work_handler(struct work_struct *work)
+{
+	struct fl_entry *fl_entry;
+
+	mutex_lock(&fl_offl_llock);
+	fl_entry = list_first_entry_or_null(&fl_offl_lh, struct fl_entry, list);
+	if (!fl_entry) {
+		mutex_unlock(&fl_offl_llock);
+		return;
+	}
+
+	list_del_init(&fl_entry->list);
+	mutex_unlock(&fl_offl_llock);
+
+	rvu_sw_fl_offl_rule_push(fl_entry);
+	kfree(fl_entry);
+
+	mutex_lock(&fl_offl_llock);
+	if (!list_empty(&fl_offl_lh))
+		queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies(10));
+	mutex_unlock(&fl_offl_llock);
+}
 
 int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
 				  struct fl_get_stats_req *req,
 				  struct fl_get_stats_rsp *rsp)
 {
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != req->cookie)
+			continue;
+
+		rsp->pkts_diff = snode->npkts - snode->opkts;
+		snode->opkts = snode->npkts;
+		break;
+	}
+	mutex_unlock(&sw_fl_stats_lock);
 	return 0;
 }
 
@@ -17,5 +263,32 @@ int rvu_mbox_handler_fl_notify(struct rvu *rvu,
 			       struct fl_notify_req *req,
 			       struct msg_rsp *rsp)
 {
+	struct fl_entry *fl_entry;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
+
+	fl_entry = kcalloc(1, sizeof(*fl_entry), GFP_KERNEL);
+	if (!fl_entry)
+		return -ENOMEM;
+
+	fl_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	fl_entry->rvu = rvu;
+	INIT_LIST_HEAD(&fl_entry->list);
+	fl_entry->tuple = req->tuple;
+	fl_entry->cookie = req->cookie;
+	fl_entry->flags = req->flags;
+	fl_entry->features = req->features;
+
+	mutex_lock(&fl_offl_llock);
+	list_add_tail(&fl_entry->list, &fl_offl_lh);
+	mutex_unlock(&fl_offl_llock);
+
+	if (!fl_offl_work_running) {
+		sw_fl_offl_wq = alloc_workqueue("sw_af_fl_wq", 0, 0);
+		fl_offl_work_running = true;
+	}
+	queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies(10));
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
index cf3e5b884f77..aa375413bc14 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -8,4 +8,6 @@
 #ifndef RVU_SW_FL_H
 #define RVU_SW_FL_H
 
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 26a08d2cfbb1..716764d74e6a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -20,6 +20,7 @@
 #include "cn10k.h"
 #include "otx2_common.h"
 #include "qos.h"
+#include "switch/sw_fl.h"
 
 #define CN10K_MAX_BURST_MANTISSA	0x7FFFULL
 #define CN10K_MAX_BURST_SIZE		8453888ULL
@@ -1238,7 +1239,6 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		mutex_unlock(&nic->mbox.lock);
 	}
 
-
 free_mcam_flow:
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
@@ -1595,11 +1595,26 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data)
 {
+	struct otx2_nic *nic = netdev_priv(netdev);
+
 	switch (type) {
 	case TC_SETUP_BLOCK:
+		if (netif_is_ovs_port(netdev)) {
+			return flow_block_cb_setup_simple(type_data,
+							  &otx2_block_cb_list,
+							  sw_fl_setup_ft_block_ingress_cb,
+							  nic, nic, true);
+		}
+
 		return otx2_setup_tc_block(netdev, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+
+	case TC_SETUP_FT:
+		return flow_block_cb_setup_simple(type_data,
+						  &otx2_block_cb_list,
+						  sw_fl_setup_ft_block_ingress_cb,
+						  nic, nic, true);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
index 36a2359a0a48..ba3850c9d5cd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -4,13 +4,529 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/nexthop.h>
+#include <net/netfilter/nf_flow_table.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
 #include "sw_fl.h"
 
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	return -EOPNOTSUPP;
+}
+
+#else
+
+static DEFINE_SPINLOCK(sw_fl_lock);
+static LIST_HEAD(sw_fl_lh);
+
+struct sw_fl_list_entry {
+	struct list_head list;
+	u64 flags;
+	unsigned long cookie;
+	struct otx2_nic *pf;
+	struct fl_tuple tuple;
+};
+
+static struct workqueue_struct *sw_fl_wq;
+static struct work_struct sw_fl_work;
+
+static int sw_fl_msg_send(struct otx2_nic *pf,
+			  struct fl_tuple *tuple,
+			  u64 flags,
+			  unsigned long cookie)
+{
+	struct fl_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fl_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->tuple = *tuple;
+	req->flags = flags;
+	req->cookie = cookie;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fl_wq_handler(struct work_struct *work)
+{
+	struct sw_fl_list_entry *entry;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fl_lock);
+	list_splice_init(&sw_fl_lh, &tlist);
+	spin_unlock(&sw_fl_lock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fl_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fl_msg_send(entry->pf, &entry->tuple,
+			       entry->flags, entry->cookie);
+		kfree(entry);
+	}
+
+	spin_lock(&sw_fl_lock);
+	if (!list_empty(&sw_fl_lh))
+		queue_work(sw_fl_wq, &sw_fl_work);
+	spin_unlock(&sw_fl_lock);
+}
+
+static int
+sw_fl_add_to_list(struct otx2_nic *pf, struct fl_tuple *tuple,
+		  unsigned long cookie, bool add_fl)
+{
+	struct sw_fl_list_entry *entry;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->pf = pf;
+	entry->flags = add_fl ? FL_ADD : FL_DEL;
+	if (add_fl)
+		entry->tuple = *tuple;
+	entry->cookie = cookie;
+	entry->tuple.uni_di = netif_is_ovs_port(pf->netdev);
+
+	spin_lock(&sw_fl_lock);
+	list_add_tail(&entry->list, &sw_fl_lh);
+	queue_work(sw_fl_wq, &sw_fl_work);
+	spin_unlock(&sw_fl_lock);
+
+	return 0;
+}
+
+static int sw_fl_parse_actions(struct otx2_nic *nic,
+			       struct flow_action *flow_action,
+			       struct flow_cls_offload *f,
+			       struct fl_tuple *tuple, u64 *op)
+{
+	struct flow_action_entry *act;
+	struct otx2_nic *out_nic;
+	int err;
+	int used = 0;
+	int i;
+
+	if (!flow_action_has_entries(flow_action))
+		return -EINVAL;
+
+	flow_action_for_each(i, act, flow_action) {
+		WARN_ON(used >= MANGLE_ARR_SZ);
+
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+			tuple->in_pf = nic->pcifunc;
+			out_nic = netdev_priv(act->dev);
+			tuple->xmit_pf = out_nic->pcifunc;
+			*op |= BIT_ULL(FLOW_ACTION_REDIRECT);
+			break;
+
+		case FLOW_ACTION_CT:
+			err = nf_flow_table_offload_add_cb(act->ct.flow_table,
+							   sw_fl_setup_ft_block_ingress_cb,
+							   nic);
+			if (err != -EEXIST && err) {
+				pr_err("%s:%d Error to offload flow, err=%d\n",
+				       __func__, __LINE__, err);
+				break;
+			}
+
+			*op |= BIT_ULL(FLOW_ACTION_CT);
+			break;
+
+		case FLOW_ACTION_MANGLE:
+			tuple->mangle[used].type = act->mangle.htype;
+			tuple->mangle[used].val = act->mangle.val;
+			tuple->mangle[used].mask = act->mangle.mask;
+			tuple->mangle[used].offset = act->mangle.offset;
+			tuple->mangle_map[act->mangle.htype] |= BIT(used);
+			used++;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	tuple->mangle_cnt = used;
+
+	if (!*op) {
+		pr_debug("%s:%d Op is not valid\n", __func__, __LINE__);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int sw_fl_get_route(struct fib_result *res, __be32 addr)
+{
+	struct flowi4 fl4;
+
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.daddr = addr;
+	return fib_lookup(&init_net, &fl4, res, 0);
+}
+
+static int sw_fl_get_pcifunc(__be32 dst, u16 *pcifunc, struct fl_tuple *ftuple, bool is_in_dev)
+{
+	struct fib_nh_common *fib_nhc;
+	struct net_device *dev, *br;
+	struct otx2_nic *nic;
+	struct fib_result res;
+	struct list_head *lh;
+	int err;
+
+	rcu_read_lock();
+
+	err = sw_fl_get_route(&res, dst);
+	if (err) {
+		pr_err("%s:%d Failed to find route to dst %pI4\n",
+		       __func__, __LINE__, &dst);
+		goto done;
+	}
+
+	if (res.fi->fib_type != RTN_UNICAST) {
+		pr_err("%s:%d Not unicast  route to dst %pi4\n",
+		       __func__, __LINE__, &dst);
+		err = -EFAULT;
+		goto done;
+	}
+
+	fib_nhc = fib_info_nhc(res.fi, 0);
+	if (!fib_nhc) {
+		err = -EINVAL;
+		pr_err("%s:%d Could not get fib_nhc for %pI4\n",
+		       __func__, __LINE__, &dst);
+		goto done;
+	}
+
+	if (unlikely(netif_is_bridge_master(fib_nhc->nhc_dev))) {
+		br = fib_nhc->nhc_dev;
+
+		if (is_in_dev)
+			ftuple->is_indev_br = 1;
+		else
+			ftuple->is_xdev_br = 1;
+
+		lh = &br->adj_list.lower;
+		if (list_empty(lh)) {
+			pr_err("%s:%d Unable to find any slave device\n",
+			       __func__, __LINE__);
+			err = -EINVAL;
+			goto done;
+		}
+		dev = netdev_next_lower_dev_rcu(br, &lh);
+
+	} else {
+		dev = fib_nhc->nhc_dev;
+	}
+
+	if (!sw_nb_is_valid_dev(dev)) {
+		pr_err("%s:%d flow acceleration support is only for cavium devices\n",
+		       __func__, __LINE__);
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
+	nic = netdev_priv(dev);
+	*pcifunc = nic->pcifunc;
+
+done:
+	rcu_read_unlock();
+	return err;
+}
+
+static int sw_fl_parse_flow(struct otx2_nic *nic, struct flow_cls_offload *f,
+			    struct fl_tuple *tuple, u64 *features)
+{
+	struct flow_dissector *dissector;
+	struct flow_rule *rule;
+	u8 ip_proto = 0;
+
+	*features = 0;
+
+	rule = flow_cls_offload_flow_rule(f);
+	dissector = rule->match.dissector;
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		/* All EtherTypes can be matched, no hw limitation */
+
+		if (match.mask->n_proto) {
+			tuple->eth_type = match.key->n_proto;
+			tuple->m_eth_type = match.mask->n_proto;
+			*features |= BIT_ULL(NPC_ETYPE);
+		}
+
+		if (match.mask->ip_proto &&
+		    (match.key->ip_proto != IPPROTO_TCP &&
+		     match.key->ip_proto != IPPROTO_UDP)) {
+			netdev_dbg(nic->netdev,
+				   "ip_proto=%u not supported\n",
+				   match.key->ip_proto);
+		}
+
+		if (match.mask->ip_proto)
+			ip_proto = match.key->ip_proto;
+
+		if (ip_proto == IPPROTO_UDP) {
+			*features |= BIT_ULL(NPC_IPPROTO_UDP);
+		} else if (ip_proto == IPPROTO_TCP) {
+			*features |= BIT_ULL(NPC_IPPROTO_TCP);
+		} else {
+			netdev_dbg(nic->netdev,
+				   "ip_proto=%u not supported\n",
+				   match.key->ip_proto);
+		}
+
+		tuple->proto = ip_proto;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		if (!is_zero_ether_addr(match.key->dst) &&
+		    is_unicast_ether_addr(match.key->dst)) {
+			ether_addr_copy(tuple->dmac,
+					match.key->dst);
+
+			ether_addr_copy(tuple->m_dmac,
+					match.mask->dst);
+
+			*features |= BIT_ULL(NPC_DMAC);
+		}
+
+		if (!is_zero_ether_addr(match.key->src) &&
+		    is_unicast_ether_addr(match.key->src)) {
+			ether_addr_copy(tuple->smac,
+					match.key->src);
+			ether_addr_copy(tuple->m_smac,
+					match.mask->src);
+			*features |= BIT_ULL(NPC_SMAC);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		if (match.key->dst) {
+			tuple->ip4dst = match.key->dst;
+			tuple->m_ip4dst = match.mask->dst;
+			*features |= BIT_ULL(NPC_DIP_IPV4);
+		}
+
+		if (match.key->src) {
+			tuple->ip4src = match.key->src;
+			tuple->m_ip4src = match.mask->src;
+			*features |= BIT_ULL(NPC_SIP_IPV4);
+		}
+	}
+
+	if (!(*features & BIT_ULL(NPC_DMAC))) {
+		if (!tuple->ip4src || !tuple->ip4dst) {
+			pr_err("%s:%d Invalid src=%pI4 and dst=%pI4 addresses\n",
+			       __func__, __LINE__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+
+		if ((tuple->ip4src & tuple->m_ip4src) == (tuple->ip4dst & tuple->m_ip4dst)) {
+			pr_err("%s:%d Masked values are same; Invalid src=%pI4 and dst=%pI4 addresses\n",
+			       __func__, __LINE__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		flow_rule_match_ports(rule, &match);
+
+		if (ip_proto == IPPROTO_UDP) {
+			if (match.key->dst)
+				*features |= BIT_ULL(NPC_DPORT_UDP);
+
+			if (match.key->src)
+				*features |= BIT_ULL(NPC_SPORT_UDP);
+		} else if (ip_proto == IPPROTO_TCP) {
+			if (match.key->dst)
+				*features |= BIT_ULL(NPC_DPORT_TCP);
+
+			if (match.key->src)
+				*features |= BIT_ULL(NPC_SPORT_TCP);
+		}
+
+		if (match.mask->src) {
+			tuple->sport = match.key->src;
+			tuple->m_sport = match.mask->src;
+		}
+
+		if (match.mask->dst) {
+			tuple->dport = match.key->dst;
+			tuple->m_dport = match.mask->dst;
+		}
+	}
+
+	if (!(*features & (BIT_ULL(NPC_DMAC) |
+			   BIT_ULL(NPC_SMAC) |
+			   BIT_ULL(NPC_DIP_IPV4) |
+			   BIT_ULL(NPC_SIP_IPV4) |
+			   BIT_ULL(NPC_DPORT_UDP) |
+			   BIT_ULL(NPC_SPORT_UDP) |
+			   BIT_ULL(NPC_DPORT_TCP) |
+			   BIT_ULL(NPC_SPORT_TCP)))) {
+		return -EINVAL;
+	}
+
+	tuple->features = *features;
+
+	return 0;
+}
+
+static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct fl_tuple tuple = { 0 };
+	struct flow_rule *rule;
+	u64 features = 0;
+	u64 op = 0;
+	int rc;
+
+	rule = flow_cls_offload_flow_rule(f);
+
+	rc = sw_fl_parse_actions(nic, &rule->action, f, &tuple, &op);
+	if (rc)
+		return rc;
+
+	if (op & BIT_ULL(FLOW_ACTION_CT))
+		return 0;
+
+	rc  = sw_fl_parse_flow(nic, f, &tuple, &features);
+	if (rc)
+		return -EFAULT;
+
+	if (!netif_is_ovs_port(nic->netdev)) {
+		rc = sw_fl_get_pcifunc(tuple.ip4src, &tuple.in_pf, &tuple, true);
+		if (rc)
+			return rc;
+
+		rc = sw_fl_get_pcifunc(tuple.ip4dst, &tuple.xmit_pf, &tuple, false);
+		if (rc)
+			return rc;
+	}
+
+	sw_fl_add_to_list(nic, &tuple, f->cookie, true);
+	return 0;
+}
+
+static int sw_fl_del(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	sw_fl_add_to_list(nic, NULL, f->cookie, false);
+	return 0;
+}
+
+static int sw_fl_stats(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct fl_get_stats_req *req;
+	struct fl_get_stats_rsp *rsp;
+	u64 pkts_diff;
+	int rc = 0;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_fl_get_stats(&nic->mbox);
+	if (!req) {
+		pr_err("%s:%d Error happened while mcam alloc req\n", __func__, __LINE__);
+		rc = -ENOMEM;
+		goto fail;
+	}
+	req->cookie = f->cookie;
+
+	if (otx2_sync_mbox_msg(&nic->mbox))
+		goto fail;
+
+	rsp = (struct fl_get_stats_rsp *)otx2_mbox_get_rsp
+		(&nic->mbox.mbox, 0, &req->hdr);
+	pkts_diff = rsp->pkts_diff;
+	mutex_unlock(&nic->mbox.lock);
+
+	if (pkts_diff) {
+		flow_stats_update(&f->stats, 0x0, pkts_diff,
+				  0x0, jiffies,
+				  FLOW_ACTION_HW_STATS_IMMEDIATE);
+	}
+	return 0;
+fail:
+	mutex_unlock(&nic->mbox.lock);
+	return rc;
+}
+
+static bool init_done;
+
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	struct flow_cls_offload *cls = type_data;
+	struct otx2_nic *nic = cb_priv;
+
+	if (!init_done)
+		return 0;
+
+	switch (cls->command) {
+	case FLOW_CLS_REPLACE:
+		return sw_fl_add(nic, cls);
+	case FLOW_CLS_DESTROY:
+		return sw_fl_del(nic, cls);
+	case FLOW_CLS_STATS:
+		return sw_fl_stats(nic, cls);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int sw_fl_init(void)
 {
+	INIT_WORK(&sw_fl_work, sw_fl_wq_handler);
+	sw_fl_wq = alloc_workqueue("sw_fl_wq", 0, 0);
+	if (!sw_fl_wq)
+		return -ENOMEM;
+
+	init_done = true;
 	return 0;
 }
 
 void sw_fl_deinit(void)
 {
+	cancel_work_sync(&sw_fl_work);
+	destroy_workqueue(sw_fl_wq);
 }
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
index cd018d770a8a..8dd816eb17d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -9,5 +9,7 @@
 
 void sw_fl_deinit(void);
 int sw_fl_init(void);
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv);
 
 #endif // SW_FL_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 5da643b3cec3..f4b6aa9f404e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -21,7 +21,6 @@
 #include "sw_fdb.h"
 #include "sw_fib.h"
 #include "sw_fl.h"
-#include "sw_nb.h"
 
 static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
 	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
-- 
2.43.0


