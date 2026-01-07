Return-Path: <netdev+bounces-247749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD555CFE173
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCDF307E6D1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D933A70F;
	Wed,  7 Jan 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BXNEfNc3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235E33A037;
	Wed,  7 Jan 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792294; cv=none; b=q19gc2CjBBHU/nfL0ILeT6KOkh4eWRUnbuScHj57WgYGsTSJ+l11xSQLe7OdvzftuPQLa95qcHO8FIvnHGsjrUDXNgeyG6TrBZzaQhN6ZX5YhXmrwijam3wFkoow1bZzaQHQTxWK1+8S+3vBLhKyC6+6NaWoYhgqPiQHEFRcHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792294; c=relaxed/simple;
	bh=hRtC5MBoqQHsbgPBjH4G8vLFpqbWE1IxmbBJ/Uo5A2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALZFga3GJHrK+GaPosigKbkvSQSlK0Epv66dSEfXsoVTCbd2t8UwUiEJm4JxjTF94Pw+snqZ+osRXImGRTMGag4TanK7G2S6gjGQGZQdd9Xk218bbt3TcudA1QOMHv9uTXqGWczam528RVwCkeqQ+blL+utt23S4xdplUL/RtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BXNEfNc3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NSoYw774435;
	Wed, 7 Jan 2026 05:24:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	q8fTvT3DqPKi2DD8lbkDm5hB9YfXxdVP2u5lBAOgls=; b=BXNEfNc3ute+m+6yp
	mW1BVHHMwz9JW8HbTInNNBsCa0JbsAgF3/vSHO/7F5tUMRl0S/71EUFRMBJALhJG
	bnMG3ccfdoMKxGigt9rVRIUjOA1PmxVCpXgUEtDZ47HB2LKo1jXsfATU5s1Nttg/
	nF7jI2a7zJp5mQOwSYqZBm1Ggxp1IQlZX7tIDkA1xvVJ6PfTYn365+4y2/j8tcF2
	cNQ0/MEik86Uuar4HN0Df9/kTVyetp1OctIGAQRUFDuXS7GPKFM4loi2a9mhR7FW
	XBgcKddhVv8PAy67DLFF7RUI6b0NuKlp4wOsbx54vGxCmWAa3zteC5Wq0wDhEpz1
	dUXuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n1btm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:42 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:56 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2402F3F704A;
	Wed,  7 Jan 2026 05:24:38 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 08/10] octeontx2: switch: L3 offload support
Date: Wed, 7 Jan 2026 18:54:06 +0530
Message-ID: <20260107132408.3904352-9-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: X6o-mvZp9fsb9xpjunFZ4lrphS_tAt62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfXzzcR+2AvFY+H
 T/ogNEfXc4SZSRj5yWMfJxMYO82JpB2NbrIKBT7+LbPTpakppmcaoX01pphBv1iNzM27V8vNKo6
 u7ZaVDr05CAl8HUnrwKkJSwSzLJcCR0TMqGtjs4/uEfG8S0dHAh88pjpRNVhwsUFvP/i/3DhoME
 yLZIw4IIQkUkyQX9a322qWCHrMi2gzQRpkmEoPi1BIbs6juloXPfX1P1TPZ5GAsHDEPQaQ1ohfI
 Lbqc9i8pAA0v295a86EP0bHxeFJOHhHK5qW5Ua4USHHGs3YHz1Z5p0fxYjcmV68b615012qa0zh
 qnKcZrFoXmyhAtjUT8Oh8v5vFmzWMITOfpoF3dH+b+QSsAfsUieed9etQ+4ddLrg0hnpuA40Yt1
 M0w2MxBRJ7VsLakKtMjx8ZMDluLoXe72yaOhFu0ZKL6VwtdRKQdTSns1yp6VWfv/2pzPpN8lBqv
 usSkxp8Tnlr6SeLrmcw==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695e5e9a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=tLXh2gpUjKgpRBJMYcwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: X6o-mvZp9fsb9xpjunFZ4lrphS_tAt62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Linux route events are parsed to decide on destination DIP/MASK  to fwd
packets. Switchdev HW flow table is filled with this information.
Once populated, all packet with DIP/MASK will be accelerated.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   2 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 202 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 119 +++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |   3 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  20 ++
 5 files changed, 345 insertions(+), 1 deletion(-)

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
index 2b798d5f0644..dc01d0ff26a7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,213 @@
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
+	for (i = 0; i < l3_entry->cnt; i++, entry++) {
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
+		if (!sw_l3_offl_wq)
+			return -EFAULT;
+
+		l3_offl_work_running = true;
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(1000));
+	}
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index 12ddf8119372..3d6e09ac987d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -4,13 +4,132 @@
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
+	if (!lentry)
+		return -ENOMEM;
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
index f5e00807c0fa..7a0ed52eae95 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -307,6 +307,12 @@ static int sw_nb_fib_event(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	}
 
+	if (sw_fib_add_to_list(pf_dev, entries, cnt)) {
+		kfree(entries);
+		kfree(haddr);
+		return NOTIFY_DONE;
+	}
+
 	if (!hcnt) {
 		kfree(haddr);
 		return NOTIFY_DONE;
@@ -336,6 +342,7 @@ static int sw_nb_fib_event(struct notifier_block *nb,
 			   iter->cmd, iter->dst, iter->dst_len, iter->gw, dev->name);
 	}
 
+	sw_fib_add_to_list(pf_dev, entries, hcnt);
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -390,6 +397,9 @@ static int sw_nb_net_event(struct notifier_block *nb,
 
 		pf = netdev_priv(pf_dev);
 		entry->port_id = pf->pcifunc;
+		if (sw_fib_add_to_list(pf_dev, entry, 1))
+			kfree(entry);
+
 		break;
 	}
 
@@ -469,6 +479,11 @@ static int sw_nb_inetaddr_event(struct notifier_block *nb,
 		break;
 	}
 
+	if (sw_fib_add_to_list(pf_dev, entry, 1)) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
 	netdev_dbg(dev,
 		   "%s:%d pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
 		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
@@ -536,6 +551,11 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
 		break;
 	}
 
+	if (sw_fib_add_to_list(pf_dev, entry, 1)) {
+		kfree(entry);
+		return NOTIFY_DONE;
+	}
+
 	netdev_dbg(dev,
 		   "%s:%d pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
 		   __func__, __LINE__,  entry->dst, entry->mac, dev->name);
-- 
2.43.0


