Return-Path: <netdev+bounces-247289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BECF672E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B0C3119CE7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C5258CE5;
	Tue,  6 Jan 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f4XF2thW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383323E23C;
	Tue,  6 Jan 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665747; cv=none; b=oZw/xcYg0KugyjO90ZUP+Llgd+zXe3PUO2TUNYkqiz8mt2P/lo3tTVpgHou2gOChHcikwLUCUxzJ8KeXMKge6RdNj5vJABNuuxRFc3C6u0+WuSg87Ox5aMCInP7J6sl2mWo91kXoUMNlhYlOsnG4aJd6t9xSvTTOZoSGEGgZZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665747; c=relaxed/simple;
	bh=/O8eRm/ccvirbwSqQuLLQMC+v0tbiPmJHEwIzRIZ+jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqXCS2+J60fesulI62xyc8VJ0Ml2l2D6uVg0ZEKjyhhdeT04Xv8LT6aX3NXO0FNQwULtXeBycRJV89YLd7oIJxF9zHtoU8atHbwhBSNWUhWyzLz+nJLtHk/7F5jlcJAhg/KYTer/GLmiqH/7yfExFDa3sCCQQjkepcgVMhj2K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f4XF2thW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6061ip7T128579;
	Mon, 5 Jan 2026 18:15:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
	UeK9vcJZbg4vvIfH/vVdGpTRn3GzLM/VVmZiYdNZWM=; b=f4XF2thWSchkNkJ9Y
	/QOADIV6loQ5MnZ9Jy4K9cID7y7IplPsxn9/Y/TeMzcdQ2kld6w40fdrGwFVpxjy
	Nd0h+jGTwLKckNLIHkQr5SILycG1m6raNGuPkY2KiLNWmMBjEXa0WA9CIXKmIqHo
	CrybJRJ8yt2pBglrF0KlQ18r+iI6OQylNtlLic67vud9cG6XI8Nch+wbgjXmVSni
	c49yYhttB1Pf9BvQS02Rb0dOcwx6P3gNSXmpJJzb04OMZW6HaCdTi6BUSQLUPTq+
	q20oA1b0VSQI0Fx6zvh6JoBQfKeXmX9qtm/dscj7SZwF7MYrcmoazZyzu5lm5Dma
	/5Z3A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bg9crhvxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 18:15:36 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 18:15:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 18:15:50 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D68743F70C6;
	Mon,  5 Jan 2026 18:15:33 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next 08/10] octeontx2: switch: L3 offload support
Date: Tue, 6 Jan 2026 07:44:45 +0530
Message-ID: <20260106021447.2359108-9-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfXx87Sak1USqOi
 qjN0wtpJ4BlF/vrGAIrrXSHDbTs0QMcNdrq4yXjYgl39mVCodo2Gy7v/IQZSva2NsqiPPP10hMA
 oCItFDv6lSmELunGbAQ8BDKjmfyldCBhBPW9AOAjuPmb1C14kiGWoVcoRl/OJhO+BPVRvwHsgS+
 OF7JGRhOn77zi2zNgGQe8inT3sDVQZVY45SIhlRC1ZIfwV5iERv7MpipFLDyMmRnXiCKEAk4Db5
 cHvg5vDOH6xE9VuzADQGZJDuvFv0JeK1U7tzd0XgahZOifIvtKh5lbRPg7S9KuhgmHdfjWVdimh
 KVPAw0L9HmAspu3rKGIXVE+5vYQ31Otq0M9r3amBUOiwzXa0y2WEY2DRCIwOpxJC1T69fumW2U1
 qt9NfeUtFKymZvQdcEVTCQB7nwrgLWhmn7m+4Ndy2Gc53oTewQOa8hLvDJdOEdMP3oS1LqKNr2+
 DmLiZVEtdYUNbIEeDKA==
X-Proofpoint-ORIG-GUID: 5xEe9nGzIkmpVTHorXo9W3NoQ3rDQfEA
X-Authority-Analysis: v=2.4 cv=aLr9aL9m c=1 sm=1 tr=0 ts=695c7049 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=tTGoQvCruEYILLHsEjQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5xEe9nGzIkmpVTHorXo9W3NoQ3rDQfEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

Linux route events are parsed to decide on destination DIP/MASK  to fwd
packets. Switchdev HW flow table is filled with this information.
Once populated, all packet with DIP/MASK will be accelerated.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   2 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 201 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 117 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |   3 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   7 +
 5 files changed, 329 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index b66f9c2eb981..fe91b0a6baf5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -6,9 +6,9 @@
  */
 
 #include "rvu.h"
-#include "rvu_sw.h"
 #include "rvu_sw_l2.h"
 #include "rvu_sw_fl.h"
+#include "rvu_sw.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..0daad60ca949 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,212 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l3.h"
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
+static struct workqueue_struct *sw_l3_offl_wq;
+
+struct l3_entry {
+	struct list_head list;
+	struct rvu *rvu;
+	u32 port_id;
+	int cnt;
+	struct fib_entry entry[];
+};
+
+static DEFINE_MUTEX(l3_offl_llock);
+static LIST_HEAD(l3_offl_lh);
+static bool l3_offl_work_running;
+
+static struct workqueue_struct *sw_l3_offl_wq;
+static void sw_l3_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(l3_offl_work, sw_l3_offl_work_handler);
+
+static void sw_l3_offl_dump(struct l3_entry *l3_entry)
+{
+	struct fib_entry *entry = l3_entry->entry;
+	int i;
+
+	for (i = 0; i < l3_entry->cnt; i++) {
+		pr_debug("%s:%d cmd=%llu port_id=%#x  dst=%#x dst_len=%d gw=%#x\n",
+			 __func__, __LINE__,  entry->cmd, entry->port_id, entry->dst,
+			 entry->dst_len, entry->gw);
+	}
+}
+
+static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
+{
+	struct af2swdev_notify_req *req;
+	struct fib_entry *entry, *dst;
+	struct l3_entry *l3_entry;
+	struct rvu *rvu;
+	int swdev_pf;
+	int sz, cnt;
+	int tot_cnt = 0;
+
+	l3_entry = list_first_entry_or_null(lh, struct l3_entry, list);
+	if (!l3_entry)
+		return 0;
+
+	rvu = l3_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	dst = &req->entry[0];
+	while ((l3_entry =
+		list_first_entry_or_null(lh,
+					 struct l3_entry, list)) != NULL) {
+		entry = l3_entry->entry;
+		cnt = l3_entry->cnt;
+		sz = sizeof(*entry) * cnt;
+
+		memcpy(dst, entry, sz);
+		tot_cnt += cnt;
+		dst += cnt;
+
+		sw_l3_offl_dump(l3_entry);
+
+		list_del_init(&l3_entry->list);
+		kfree(l3_entry);
+	}
+	req->flags = FIB_CMD;
+	req->cnt = tot_cnt;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static atomic64_t req_cnt;
+static atomic64_t ack_cnt;
+static atomic64_t req_processed;
+static LIST_HEAD(l3_local_lh);
+static int lcnt;
+
+static void sw_l3_offl_work_handler(struct work_struct *work)
+{
+	struct l3_entry *l3_entry;
+	struct list_head l3lh;
+	u64 req, ack, proc;
+
+	INIT_LIST_HEAD(&l3lh);
+
+	mutex_lock(&l3_offl_llock);
+	while (1) {
+		l3_entry = list_first_entry_or_null(&l3_offl_lh, struct l3_entry, list);
+
+		if (!l3_entry)
+			break;
+
+		if (lcnt + l3_entry->cnt > 16) {
+			req = atomic64_read(&req_cnt);
+			atomic64_set(&ack_cnt, req);
+			atomic64_set(&req_processed, req);
+			mutex_unlock(&l3_offl_llock);
+			goto process;
+		}
+
+		lcnt += l3_entry->cnt;
+
+		atomic64_inc(&req_cnt);
+		list_del_init(&l3_entry->list);
+		list_add_tail(&l3_entry->list, &l3_local_lh);
+	}
+	mutex_unlock(&l3_offl_llock);
+
+	req = atomic64_read(&req_cnt);
+	ack = atomic64_read(&ack_cnt);
+
+	if (req > ack) {
+		atomic64_set(&ack_cnt, req);
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(100));
+		return;
+	}
+
+	proc = atomic64_read(&req_processed);
+	if (req == proc) {
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(1000));
+		return;
+	}
+
+	atomic64_set(&req_processed, req);
+
+process:
+	lcnt = 0;
+
+	mutex_lock(&l3_offl_llock);
+	list_splice_init(&l3_local_lh, &l3lh);
+	mutex_unlock(&l3_offl_llock);
+
+	rvu_sw_l3_offl_rule_push(&l3lh);
+
+	queue_delayed_work(sw_l3_offl_wq, &l3_offl_work, msecs_to_jiffies(100));
+}
 
 int rvu_mbox_handler_fib_notify(struct rvu *rvu,
 				struct fib_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l3_entry *l3_entry;
+	int sz;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
+
+	sz = req->cnt * sizeof(struct fib_entry);
+
+	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
+	if (!l3_entry)
+		return -ENOMEM;
+
+	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	l3_entry->rvu = rvu;
+	l3_entry->cnt = req->cnt;
+	INIT_LIST_HEAD(&l3_entry->list);
+	memcpy(l3_entry->entry, req->entry, sz);
+
+	mutex_lock(&l3_offl_llock);
+	list_add_tail(&l3_entry->list, &l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (!l3_offl_work_running) {
+		sw_l3_offl_wq = alloc_workqueue("sw_af_fib_wq", 0, 0);
+		l3_offl_work_running = true;
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(1000));
+	}
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index 12ddf8119372..662b0daf31d5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -4,13 +4,130 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
 #include "sw_fib.h"
 
+static DEFINE_SPINLOCK(sw_fib_llock);
+static LIST_HEAD(sw_fib_lh);
+
+static struct workqueue_struct *sw_fib_wq;
+static void sw_fib_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sw_fib_work, sw_fib_work_handler);
+
+struct sw_fib_list_entry {
+	struct list_head lh;
+	struct otx2_nic *pf;
+	int cnt;
+	struct fib_entry *entry;
+};
+
+static void sw_fib_dump(struct fib_entry *entry, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++, entry++) {
+		pr_debug("%s:%d cmd=%s gw_valid=%d mac_valid=%d dst=%#x len=%d gw=%#x mac=%pM nud_state=%#x\n",
+			 __func__, __LINE__,
+			 sw_nb_get_cmd2str(entry->cmd),
+			 entry->gw_valid, entry->mac_valid, entry->dst, entry->dst_len,
+			 entry->gw, entry->mac, entry->nud_state);
+	}
+}
+
+static int sw_fib_notify(struct otx2_nic *pf,
+			 int cnt,
+			 struct fib_entry *entry)
+{
+	struct fib_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fib_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->cnt = cnt;
+	memcpy(req->entry, entry, sizeof(*entry) * cnt);
+	sw_fib_dump(req->entry, cnt);
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fib_work_handler(struct work_struct *work)
+{
+	struct sw_fib_list_entry *lentry;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		sw_fib_notify(lentry->pf, lentry->cnt, lentry->entry);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
+
+	spin_lock(&sw_fib_llock);
+	if (!list_empty(&sw_fib_lh))
+		queue_delayed_work(sw_fib_wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	spin_unlock(&sw_fib_llock);
+}
+
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fib_list_entry *lentry;
+
+	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
+
+	lentry->pf = pf;
+	lentry->cnt = cnt;
+	lentry->entry = entry;
+	INIT_LIST_HEAD(&lentry->lh);
+
+	spin_lock(&sw_fib_llock);
+	list_add_tail(&lentry->lh, &sw_fib_lh);
+	queue_delayed_work(sw_fib_wq, &sw_fib_work,
+			   msecs_to_jiffies(10));
+	spin_unlock(&sw_fib_llock);
+
+	return 0;
+}
+
 int sw_fib_init(void)
 {
+	sw_fib_wq = alloc_workqueue("sw_pf_fib_wq", 0, 0);
+	if (!sw_fib_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fib_deinit(void)
 {
+	cancel_delayed_work_sync(&sw_fib_work);
+	destroy_workqueue(sw_fib_wq);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
index a51d15c2b80e..50c4fbca81e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -7,6 +7,9 @@
 #ifndef SW_FIB_H_
 #define SW_FIB_H_
 
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt);
+
 void sw_fib_deinit(void);
 int sw_fib_init(void);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index b295940ab8c7..5da643b3cec3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -301,6 +301,8 @@ static int sw_nb_fib_event(struct notifier_block *nb,
 
 	pr_debug("pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
 
+	sw_fib_add_to_list(pf_dev, entries, cnt);
+
 	if (!hcnt)
 		return NOTIFY_DONE;
 
@@ -327,6 +329,7 @@ static int sw_nb_fib_event(struct notifier_block *nb,
 			 iter->cmd, iter->dst, iter->dst_len, iter->gw, dev->name);
 	}
 
+	sw_fib_add_to_list(pf_dev, entries, hcnt);
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -378,6 +381,7 @@ static int sw_nb_net_event(struct notifier_block *nb,
 
 		pf = netdev_priv(pf_dev);
 		entry->port_id = pf->pcifunc;
+		sw_fib_add_to_list(pf_dev, entry, 1);
 		break;
 	}
 
@@ -461,6 +465,7 @@ static int sw_nb_inetaddr_event(struct notifier_block *nb,
 	pr_debug("%s:%d pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
 		 __func__, __LINE__,  entry->dst, entry->mac, dev->name);
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
@@ -524,6 +529,8 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
 		break;
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	pr_debug("%s:%d pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
 		 __func__, __LINE__,  entry->dst, entry->mac, dev->name);
 
-- 
2.43.0


