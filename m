Return-Path: <netdev+bounces-247582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25382CFBE34
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD7E306644C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6B256C6D;
	Wed,  7 Jan 2026 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iCDOGz9t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466A264609;
	Wed,  7 Jan 2026 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757187; cv=none; b=j1/uWqRg2oKaBVm0KWnS8uNph7pIBe8TMpxREcdvN2DNV2Orhst2TYruFnW5sWg4Kf9Ax34tuJd18fbzMUeixsxjcjIQJHAGZm1im3/2B93+2Im+0yCYBc5XM8tKXqQ0p3TUbtlNoFYOhaF6YVaHHRR3EA2ne5EHBlxjenpqQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757187; c=relaxed/simple;
	bh=8C/810TzmijtvhgwMG2hzzPuuyc47eZKyEMXYOvDhF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhzQ6btTg2K+5VSJfvzJBaTeTdvYqBg7lsqpF/Dv8DNVbGi9gPil1ZBJ1g1cllagJ9eq9E/dvTa/mg9Fy8YMNRhNSW8I6pDOI7mRui1aKRgSjssc4yNEUr2UMl/sARk7iAMUb/tk/APdV7o0H3Hx0Q2CeKhW+rYP/vIX9jJ3HMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iCDOGz9t; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NqSCS3768606;
	Tue, 6 Jan 2026 19:39:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	VCSAN/43XQu1jiFJQT63O3iuGYZIa9UpKRqetPKjM4=; b=iCDOGz9t5beB6PEEg
	BUs6wQzYCkU5/5Eb0JaBPL2B+WM1G19z/HTlylPsEh7swzElcNKHRg3KpbKEEVxM
	6NgXD/kHosoB09RktX789mhBVkTS68JL8kgb6lWp3NzxhxsE+5ztxqlXY64w+xlB
	Rgydqe8IxfaTZJ8xbGJYsxSLBdl3POF+u4qR07Kkpyhl35htmT3JcI1MhZq6oFGo
	InY5pNc518W6i8mUJgBoSjBU+9pdAb2+8DBEiVLduG36K57ZGNRaFrpyX4gJf4v3
	mLkoFImVwUzrBAQbLYj1K+UTyaUdiTnBum1Lx/Nh1ViW8ujheOULMGxhU1I4rQHN
	IK2Xw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bhces8br2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 19:39:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 19:39:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 19:39:48 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 82ED53F704F;
	Tue,  6 Jan 2026 19:39:31 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v2 11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Wed, 7 Jan 2026 09:08:42 +0530
Message-ID: <20260107033844.437026-12-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107033844.437026-1-rkannoth@marvell.com>
References: <20260107033844.437026-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FokIPmrq c=1 sm=1 tr=0 ts=695dd577 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=KaEl-UT5FusyG8Xfe_EA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ryRRAhU9-XlsPYyjPmgaR9NBKodpjqwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNyBTYWx0ZWRfXyAZ68Iicew9W
 iWP2EJo1xPecHlmoesMtsy6Bds36Wf76sh7i0b24rGzTRvNTlB7X/BvXjyad6Jm64MiUz3XzhrA
 mEAum4g6aTp/bLaLntF4lXz1AIP+J794dHUPF5HdyCDm/NPUTIj1cqu4x0HZhoC8FGG1CdV6gZA
 UIdI61lciU55Kr4H7b5cFuaz50Z0wxuiVi3TtSJoMpJBryp37bYC3Ksx/O630euFVXiwhz+1Y2G
 ngf/lbaK4x+vX3XSSs2E+iwwCnTD6aMh236BOFf/nZizbQQa4RfJPMK+4uC+ZqEB96+8V0hc7Jy
 QjCd0NDuDIMmAWkRbPqNGxHHwYSFppMJz3gYnJ5xxWUN47DHJI+/8iXgxqxtxEn1zp0AKzoHuDI
 PoDu4YO8EmBqXWd/klZaskokaE901R34PiAeccTaArCzJr9tfzhvHqkoUmZTqWRl3TuBjdzWp3j
 ECNSpNf+8WykyZlUHxA==
X-Proofpoint-ORIG-GUID: ryRRAhU9-XlsPYyjPmgaR9NBKodpjqwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

Unlike previous silicons, MCAM entries required for TC rules in CN20K
are allocated dynamically. The key size can also be dynamic, i.e., X2 or
X4. Based on the size of the TC rule match criteria, the AF driver
allocates an X2 or X4 rule. This patch implements the required changes
for CN20K TC by requesting an MCAM entry from the AF driver on the fly
when the user installs a rule. Based on the TC rule priority added or
deleted by the user, the PF driver shifts MCAM entries accordingly. If
there is a mix of X2 and X4 rules and the user tries to install a rule
in the middle of existing rules, the PF driver detects this and rejects
the rule since X2 and X4 rules cannot be shifted in hardware.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  12 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 265 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  13 +
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +++
 .../marvell/octeontx2/nic/otx2_flows.c        |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  77 ++---
 7 files changed, 367 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 49ffc6827276..6f26f7393709 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1874,6 +1874,11 @@ struct npc_install_flow_req {
 	u8 hw_prio;
 	u8  req_kw_type; /* Key type to be written */
 	u8 alloc_entry;	/* only for cn20k */
+/* For now use any priority, once AF driver is changed to
+ * allocate least priority entry instead of mid zone then make
+ * NPC_MCAM_LEAST_PRIO as 3
+ */
+#define NPC_MCAM_LEAST_PRIO	NPC_MCAM_ANY_PRIO
 	u16 ref_prio;
 	u16 ref_entry;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 7dfd1345b4b6..4b47c1ae8031 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1744,8 +1744,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support ucast flow\n",
 				 __func__);
-			rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
-							    allocated, req->entry);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
@@ -1753,8 +1755,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 			dev_warn(rvu->dev,
 				 "%s: mkex profile does not support bcast/mcast flow",
 				 __func__);
-			rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
-							    allocated, req->entry);
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
 			return NPC_FLOW_NOT_SUPPORTED;
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a60f8cf53feb..cd2c9a95ee22 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -251,6 +251,271 @@ static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
 #endif
 }
 
+static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
+				    struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *tmp;
+	int index = 0;
+
+	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
+		if (tmp == node)
+			return index;
+
+		index++;
+	}
+
+	return 0;
+}
+
+static int cn20k_tc_free_mcam_entry(struct otx2_nic *nic, u16 entry)
+{
+	struct npc_mcam_free_entry_req *req;
+	int err;
+
+	mutex_lock(&nic->mbox.lock);
+	req = otx2_mbox_alloc_msg_npc_mcam_free_entry(&nic->mbox);
+	if (!req) {
+		mutex_unlock(&nic->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->entry = entry;
+	/* Send message to AF to free MCAM entries */
+	err = otx2_sync_mbox_msg(&nic->mbox);
+	if (err) {
+		mutex_unlock(&nic->mbox.lock);
+		return err;
+	}
+
+	mutex_unlock(&nic->mbox.lock);
+
+	return 0;
+}
+
+static bool cn20k_tc_check_entry_shiftable(struct otx2_nic *nic,
+					   struct otx2_flow_config *flow_cfg,
+					   struct otx2_tc_flow *node, int index,
+					   bool error)
+{
+	struct otx2_tc_flow *first, *tmp, *n;
+	u32 prio = 0;
+	int i = 0;
+	u8 type;
+
+	first = list_first_entry(&flow_cfg->flow_list_tc, struct otx2_tc_flow,
+				 list);
+	type = first->kw_type;
+
+	/* Check all the nodes from start to given index (including index) has
+	 * same type i.e, either X2 or X4
+	 */
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (i > index)
+			break;
+
+		if (type != tmp->kw_type) {
+			/* List has both X2 and X4 entries so entries cannot be
+			 * shifted to save MCAM space.
+			 */
+			if (error)
+				dev_err(nic->dev, "Rule %d cannot be shifted to %d\n",
+					tmp->prio, prio);
+			return false;
+		}
+
+		type = tmp->kw_type;
+		prio = tmp->prio;
+		i++;
+	}
+
+	return true;
+}
+
+void cn20k_tc_update_mcam_table_del_req(struct otx2_nic *nic,
+					struct otx2_flow_config *flow_cfg,
+					struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *first, *tmp, *n;
+	int i = 0, index;
+	u16 cntr_val = 0;
+	u16 entry;
+
+	index = cn20k_tc_get_entry_index(flow_cfg, node);
+	first = list_first_entry(&flow_cfg->flow_list_tc, struct otx2_tc_flow,
+				 list);
+	entry = first->entry;
+
+	/* If entries cannot be shifted then delete given entry
+	 * and free it to AF too.
+	 */
+	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
+					    index, false)) {
+		list_del(&node->list);
+		entry = node->entry;
+		goto free_mcam_entry;
+	}
+
+	/* Find and delete the entry from the list and re-install
+	 * all the entries from beginning to the index of the
+	 * deleted entry to higher mcam indexes.
+	 */
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (node == tmp) {
+			list_del(&tmp->list);
+			break;
+		}
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		tmp->entry = (list_next_entry(tmp, list))->entry;
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+	}
+
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (i == index)
+			break;
+
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		i++;
+	}
+
+free_mcam_entry:
+	if (cn20k_tc_free_mcam_entry(nic, entry))
+		netdev_err(nic->netdev, "Freeing entry %d to AF failed\n",
+			   first->entry);
+}
+
+int cn20k_tc_update_mcam_table_add_req(struct otx2_nic *nic,
+				       struct otx2_flow_config *flow_cfg,
+				       struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *tmp;
+	u16 cntr_val = 0;
+	int list_idx, i;
+	int entry, prev;
+
+	/* Find the index of the entry(list_idx) whose priority
+	 * is greater than the new entry and re-install all
+	 * the entries from beginning to list_idx to higher
+	 * mcam indexes.
+	 */
+	list_idx = otx2_tc_add_to_flow_list(flow_cfg, node);
+	entry = node->entry;
+	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
+					    list_idx, true)) {
+		/* Due to mix of X2 and X4, entries cannot be shifted.
+		 * In this case free the entry allocated for this rule.
+		 */
+		if (cn20k_tc_free_mcam_entry(nic, entry))
+			netdev_err(nic->netdev,
+				   "Freeing entry %d to AF failed\n", entry);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < list_idx; i++) {
+		tmp = otx2_tc_get_entry_by_index(flow_cfg, i);
+		if (!tmp)
+			return -ENOMEM;
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		prev = tmp->entry;
+		tmp->entry = entry;
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		entry = prev;
+	}
+
+	return entry;
+}
+
+#define MAX_TC_HW_PRIORITY		125
+#define MAX_TC_VF_PRIORITY		126
+#define MAX_TC_PF_PRIORITY		127
+
+static int __cn20k_tc_alloc_entry(struct otx2_nic *nic,
+				  struct npc_install_flow_req *flow_req,
+				  u16 *entry, u8 *type,
+				  u32 tc_priority, bool hw_priority)
+{
+	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
+	struct npc_install_flow_req *req;
+	struct npc_install_flow_rsp *rsp;
+	struct otx2_tc_flow *tmp;
+	int ret = 0;
+
+	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
+	if (!req)
+		return -ENOMEM;
+
+	memcpy(&flow_req->hdr, &req->hdr, sizeof(struct mbox_msghdr));
+	memcpy(req, flow_req, sizeof(struct npc_install_flow_req));
+	req->alloc_entry = 1;
+
+	/* Allocate very least priority for first rule */
+	if (hw_priority || list_empty(&flow_cfg->flow_list_tc)) {
+		req->ref_prio = NPC_MCAM_LEAST_PRIO;
+	} else {
+		req->ref_prio = NPC_MCAM_HIGHER_PRIO;
+		tmp = list_first_entry(&flow_cfg->flow_list_tc,
+				       struct otx2_tc_flow, list);
+		req->ref_entry = tmp->entry;
+	}
+
+	ret = otx2_sync_mbox_msg(&nic->mbox);
+	if (ret)
+		return ret;
+
+	rsp = (struct npc_install_flow_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+							       0, &req->hdr);
+	if (IS_ERR(rsp))
+		return -EFAULT;
+
+	if (entry)
+		*entry = rsp->entry;
+	if (type)
+		*type = rsp->kw_type;
+
+	return ret;
+}
+
+int cn20k_tc_alloc_entry(struct otx2_nic *nic,
+			 struct flow_cls_offload *tc_flow_cmd,
+			 struct otx2_tc_flow *new_node,
+			 struct npc_install_flow_req *flow_req)
+{
+	bool hw_priority = false;
+	u16 entry_from_af;
+	u8 entry_type;
+	int ret;
+
+	if (is_otx2_vf(nic->pcifunc))
+		flow_req->hw_prio = MAX_TC_VF_PRIORITY;
+	else
+		flow_req->hw_prio = MAX_TC_PF_PRIORITY;
+
+	if (new_node->prio <= MAX_TC_HW_PRIORITY) {
+		flow_req->hw_prio = new_node->prio;
+		hw_priority = true;
+	}
+
+	mutex_lock(&nic->mbox.lock);
+
+	ret = __cn20k_tc_alloc_entry(nic, flow_req, &entry_from_af, &entry_type,
+				     new_node->prio, hw_priority);
+	if (ret) {
+		mutex_unlock(&nic->mbox.lock);
+		return ret;
+	}
+
+	new_node->kw_type = entry_type;
+	new_node->entry = entry_from_af;
+
+	mutex_unlock(&nic->mbox.lock);
+
+	return 0;
+}
+
 static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 			      int pool_id, int numptrs)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
index 832adaf8c57f..3cc57886627d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
@@ -10,8 +10,21 @@
 
 #include "otx2_common.h"
 
+struct otx2_flow_config;
+struct otx2_tc_flow;
+
 void cn20k_init(struct otx2_nic *pfvf);
 int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
 void cn20k_disable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
 void cn20k_enable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
+void cn20k_tc_update_mcam_table_del_req(struct otx2_nic *nic,
+					struct otx2_flow_config *flow_cfg,
+					struct otx2_tc_flow *node);
+int cn20k_tc_update_mcam_table_add_req(struct otx2_nic *nic,
+				       struct otx2_flow_config *flow_cfg,
+				       struct otx2_tc_flow *node);
+int cn20k_tc_alloc_entry(struct otx2_nic *nic,
+			 struct flow_cls_offload *tc_flow_cmd,
+			 struct otx2_tc_flow *new_node,
+			 struct npc_install_flow_req *dummy);
 #endif /* CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e616a727a3a9..3cb86e584acb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -366,6 +366,31 @@ struct otx2_flow_config {
 	u16			ntuple_cnt;
 };
 
+struct otx2_tc_flow_stats {
+	u64 bytes;
+	u64 pkts;
+	u64 used;
+};
+
+struct otx2_tc_flow {
+	struct list_head		list;
+	unsigned long			cookie;
+	struct rcu_head			rcu;
+	struct otx2_tc_flow_stats	stats;
+	spinlock_t			lock; /* lock for stats */
+	u16				rq;
+	u16				entry;
+	u16				leaf_profile;
+	bool				is_act_police;
+	u32				prio;
+	struct npc_install_flow_req	req;
+	u64				rate;
+	u32				burst;
+	u32				mcast_grp_idx;
+	bool				is_pps;
+	u8				kw_type; /* X2/X4 */
+};
+
 struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u8 chan_offset,
 			      u16 sqb_aura);
@@ -1221,4 +1246,14 @@ void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
+int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
+			     u16 *cntr_val);
+int otx2_add_mcam_flow_entry(struct otx2_nic *nic,
+			     struct npc_install_flow_req *req);
+int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
+			     struct otx2_tc_flow *node);
+
+struct otx2_tc_flow *
+otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
+			   int index);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 41621734d55e..3a3088a66469 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -1187,7 +1187,8 @@ static int otx2_add_flow_msg(struct otx2_nic *pfvf, struct otx2_flow *flow)
 		}
 
 		if (!is_x2) {
-			err = otx2_prepare_flow_request(&flow->flow_spec, &treq);
+			err = otx2_prepare_flow_request(&flow->flow_spec,
+							&treq);
 			if (err)
 				return err;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 26a08d2cfbb1..866d9451f5d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -31,30 +31,6 @@
 
 #define MCAST_INVALID_GRP		(-1U)
 
-struct otx2_tc_flow_stats {
-	u64 bytes;
-	u64 pkts;
-	u64 used;
-};
-
-struct otx2_tc_flow {
-	struct list_head		list;
-	unsigned long			cookie;
-	struct rcu_head			rcu;
-	struct otx2_tc_flow_stats	stats;
-	spinlock_t			lock; /* lock for stats */
-	u16				rq;
-	u16				entry;
-	u16				leaf_profile;
-	bool				is_act_police;
-	u32				prio;
-	struct npc_install_flow_req	req;
-	u32				mcast_grp_idx;
-	u64				rate;
-	u32				burst;
-	bool				is_pps;
-};
-
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
 {
@@ -971,8 +947,9 @@ static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf)
 	}
 }
 
-static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
-							unsigned long cookie)
+static struct otx2_tc_flow *
+otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
+			    unsigned long cookie)
 {
 	struct otx2_tc_flow *tmp;
 
@@ -984,8 +961,8 @@ static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config
 	return NULL;
 }
 
-static struct otx2_tc_flow *otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
-						       int index)
+struct otx2_tc_flow *
+otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg, int index)
 {
 	struct otx2_tc_flow *tmp;
 	int i = 0;
@@ -1014,8 +991,8 @@ static void otx2_tc_del_from_flow_list(struct otx2_flow_config *flow_cfg,
 	}
 }
 
-static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
-				    struct otx2_tc_flow *node)
+int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
+			     struct otx2_tc_flow *node)
 {
 	struct list_head *pos, *n;
 	struct otx2_tc_flow *tmp;
@@ -1038,7 +1015,8 @@ static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
 	return index;
 }
 
-static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flow_req *req)
+int otx2_add_mcam_flow_entry(struct otx2_nic *nic,
+			     struct npc_install_flow_req *req)
 {
 	struct npc_install_flow_req *tmp_req;
 	int err;
@@ -1064,7 +1042,7 @@ static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flo
 	return 0;
 }
 
-static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
+int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
 {
 	struct npc_delete_flow_rsp *rsp;
 	struct npc_delete_flow_req *req;
@@ -1114,6 +1092,11 @@ static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
 	int i = 0, index = 0;
 	u16 cntr_val = 0;
 
+	if (is_cn20k(nic->pdev)) {
+		cn20k_tc_update_mcam_table_del_req(nic, flow_cfg, node);
+		return 0;
+	}
+
 	/* Find and delete the entry from the list and re-install
 	 * all the entries from beginning to the index of the
 	 * deleted entry to higher mcam indexes.
@@ -1153,6 +1136,9 @@ static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
 	int list_idx, i;
 	u16 cntr_val = 0;
 
+	if (is_cn20k(nic->pdev))
+		return cn20k_tc_update_mcam_table_add_req(nic, flow_cfg, node);
+
 	/* Find the index of the entry(list_idx) whose priority
 	 * is greater than the new entry and re-install all
 	 * the entries from beginning to list_idx to higher
@@ -1172,7 +1158,7 @@ static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
 		mcam_idx++;
 	}
 
-	return mcam_idx;
+	return flow_cfg->flow_ent[mcam_idx];
 }
 
 static int otx2_tc_update_mcam_table(struct otx2_nic *nic,
@@ -1238,7 +1224,6 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		mutex_unlock(&nic->mbox.lock);
 	}
 
-
 free_mcam_flow:
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
@@ -1254,7 +1239,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
 	struct otx2_tc_flow *new_node, *old_node;
 	struct npc_install_flow_req *req, dummy;
-	int rc, err, mcam_idx;
+	int rc, err, entry;
 
 	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
@@ -1264,7 +1249,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 		return -EINVAL;
 	}
 
-	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
+	if (!is_cn20k(nic->pdev) && flow_cfg->nr_flows == flow_cfg->max_flows) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Free MCAM entry not available to add the flow");
 		return -ENOMEM;
@@ -1292,7 +1277,23 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	if (old_node)
 		otx2_tc_del_flow(nic, tc_flow_cmd);
 
-	mcam_idx = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
+	if (is_cn20k(nic->pdev)) {
+		rc = cn20k_tc_alloc_entry(nic, tc_flow_cmd, new_node, &dummy);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MCAM rule allocation failed");
+			kfree_rcu(new_node, rcu);
+			return rc;
+		}
+	}
+
+	entry = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
+	if (entry < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Adding rule failed");
+		rc = entry;
+		goto free_leaf;
+	}
+
 	mutex_lock(&nic->mbox.lock);
 	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
 	if (!req) {
@@ -1304,7 +1305,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
 	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
 	req->channel = nic->hw.rx_chan_base;
-	req->entry = flow_cfg->flow_ent[mcam_idx];
+	req->entry = (u16)entry;
 	req->intf = NIX_INTF_RX;
 	req->vf = nic->pcifunc;
 	req->set_cntr = 1;
-- 
2.43.0


