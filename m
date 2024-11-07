Return-Path: <netdev+bounces-142911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7649C0AFC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC401C216EF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FEF216DE7;
	Thu,  7 Nov 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NmndHQab"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C61217668;
	Thu,  7 Nov 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995779; cv=none; b=VzfvQ974tA53v+/NPkx1SS/PNCkCkBdLzAvj2bFx6nI2aLLIkloOvdR7SMyGLUXd1dxWRFgyj0v1sFGuWIwP1bhTKM3fkOfJdKSex7ITh0jDMu48np9GBqBZfpsYAmaldRdrFiNB3tXHsvdcPj4a2EVZu/+Y00ADU5qxF8lA8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995779; c=relaxed/simple;
	bh=FMLJ+sE/PY6yoI09r5D5utptJcORdi3C+iLfvsDyzqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQkkAoqYCAGxSrb/jV0Gr+UgwGYtRLh9UTp4tpP1gzspBAfCRW7O1Namkvz6qtB86t8PUlbQPW9noQokui2ttIxInUfmaIivpjHHMPW/yXg1J8+NO0nKdgg4YOk5W7Jq+w/63PgI1C3JuAW0MG9kFl1X+ysZMG72TwuMHS5B17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NmndHQab; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75b3jV006198;
	Thu, 7 Nov 2024 08:09:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=GZ4dzGkEoPtUXROv9znWYlz6Q
	mKw/bXO9lLRW+v27gU=; b=NmndHQabMOjFWM+HBqXuZyayf4ufh0E0P8558u3r/
	4cJ718MvLNCXvmcnob/qK/85s8LDtfDLCsZlHU/KFTh34iA222MTtr80RLNKq41e
	2AeGzCpfxAV5cu0A73gGRNI9YYRtSd7DiU36X8+5PklWAVCWHgdrb37bX8z3LKCN
	vSwT8dt3o//xdnoGrMY8VmSQHs4zLA9FuPapckN2cGBNR4YlhUj62kQwi0UI33Pa
	XrD10pQ2eHxoqhDO6X29vBWLexj0IHu4tug8vxwt0eTJHx5zuViLoQ14yjoNzloN
	qf/NwnCikVeXSvpB3Tzo6BY+TjXI080JQO495ItUBXz3g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rqj8s7as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:27 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7CBBB3F7050;
	Thu,  7 Nov 2024 08:09:24 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 11/12] octeontx2-pf: Adds TC offload support
Date: Thu, 7 Nov 2024 21:38:38 +0530
Message-ID: <20241107160839.23707-12-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
References: <20241107160839.23707-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: B5X1ucDSSgLbC3_e8GYwL9Qgv0shpVYa
X-Proofpoint-ORIG-GUID: B5X1ucDSSgLbC3_e8GYwL9Qgv0shpVYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Implements tc offload support for rvu representors. 

Usage example:

 - Add tc rule to drop packets with vlan id 3 using port
   representor(Rpf1vf0). 

	# tc filter add dev Rpf1vf0 protocol 802.1Q parent ffff: flower
	   vlan_id 3 vlan_ethtype ipv4 skip_sw action drop

- Redirect packets with vlan id 5 and IPv4 packets to eth1,
  after stripping vlan header.

	# tc filter add dev Rpf1vf0 ingress protocol 802.1Q flower vlan_id 5
	  vlan_ethtype ipv4 skip_sw action vlan pop action mirred ingress
	  redirect dev eth1

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  14 ++-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |   4 +
 .../marvell/octeontx2/nic/otx2_common.h       |   7 ++
 .../marvell/octeontx2/nic/otx2_flows.c        |   5 -
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  25 ++--
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 115 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   1 +
 7 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 150635de2bd5..9d08fd466a43 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1416,6 +1416,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 				      struct npc_install_flow_rsp *rsp)
 {
 	bool from_vf = !!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK);
+	bool from_rep_dev = !!is_rep_dev(rvu, req->hdr.pcifunc);
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	int blkaddr, nixlf, err;
 	struct rvu_pfvf *pfvf;
@@ -1472,14 +1473,19 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	/* AF installing for a PF/VF */
 	if (!req->hdr.pcifunc)
 		target = req->vf;
+
 	/* PF installing for its VF */
-	else if (!from_vf && req->vf) {
+	if (!from_vf && req->vf && !from_rep_dev) {
 		target = (req->hdr.pcifunc & ~RVU_PFVF_FUNC_MASK) | req->vf;
 		pf_set_vfs_mac = req->default_rule &&
 				(req->features & BIT_ULL(NPC_DMAC));
 	}
-	/* msg received from PF/VF */
+
+	/* Representor device installing for a representee */
+	if (from_rep_dev && req->vf)
+		target = req->vf;
 	else
+		/* msg received from PF/VF */
 		target = req->hdr.pcifunc;
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
@@ -1492,8 +1498,10 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	pfvf = rvu_get_pfvf(rvu, target);
 
+	if (from_rep_dev)
+		req->channel = pfvf->rx_chan_base;
 	/* PF installing for its VF */
-	if (req->hdr.pcifunc && !from_vf && req->vf)
+	if (req->hdr.pcifunc && !from_vf && req->vf && !from_rep_dev)
 		set_bit(PF_SET_VF_CFG, &pfvf->flags);
 
 	/* update req destination mac addr */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 97b682291e3f..052ae5923e3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -427,6 +427,10 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+
+	if (!rvu->rep_mode)
+		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index be28a19ec2d4..566848663fea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1142,4 +1142,11 @@ int otx2_get_txq_by_classid(struct otx2_nic *pfvf, u16 classid);
 void otx2_qos_config_txschq(struct otx2_nic *pfvf);
 void otx2_clean_qos_queues(struct otx2_nic *pfvf);
 int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info);
+int otx2_setup_tc_cls_flower(struct otx2_nic *nic,
+			     struct flow_cls_offload *cls_flower);
+
+static inline int mcam_entry_cmp(const void *a, const void *b)
+{
+	return *(u16 *)a - *(u16 *)b;
+}
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 58720a161ee2..47bfd1fb37d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -64,11 +64,6 @@ static int otx2_free_ntuple_mcam_entries(struct otx2_nic *pfvf)
 	return 0;
 }
 
-static int mcam_entry_cmp(const void *a, const void *b)
-{
-	return *(u16 *)a - *(u16 *)b;
-}
-
 int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index e63cc1eb6d89..9a226ca74425 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -443,6 +443,7 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 	struct flow_action_entry *act;
 	struct net_device *target;
 	struct otx2_nic *priv;
+	struct rep_dev *rdev;
 	u32 burst, mark = 0;
 	u8 nr_police = 0;
 	u8 num_intf = 1;
@@ -464,14 +465,18 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 			return 0;
 		case FLOW_ACTION_REDIRECT_INGRESS:
 			target = act->dev;
-			priv = netdev_priv(target);
-			/* npc_install_flow_req doesn't support passing a target pcifunc */
-			if (rvu_get_pf(nic->pcifunc) != rvu_get_pf(priv->pcifunc)) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "can't redirect to other pf/vf");
-				return -EOPNOTSUPP;
+			if (target->dev.parent) {
+				priv = netdev_priv(target);
+				if (rvu_get_pf(nic->pcifunc) != rvu_get_pf(priv->pcifunc)) {
+					NL_SET_ERR_MSG_MOD(extack,
+							   "can't redirect to other pf/vf");
+					return -EOPNOTSUPP;
+				}
+				req->vf = priv->pcifunc & RVU_PFVF_FUNC_MASK;
+			} else {
+				rdev = netdev_priv(target);
+				req->vf = rdev->pcifunc & RVU_PFVF_FUNC_MASK;
 			}
-			req->vf = priv->pcifunc & RVU_PFVF_FUNC_MASK;
 
 			/* if op is already set; avoid overwriting the same */
 			if (!req->op)
@@ -1300,6 +1305,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	req->channel = nic->hw.rx_chan_base;
 	req->entry = flow_cfg->flow_ent[mcam_idx];
 	req->intf = NIX_INTF_RX;
+	req->vf = nic->pcifunc;
 	req->set_cntr = 1;
 	new_node->entry = req->entry;
 
@@ -1400,8 +1406,8 @@ static int otx2_tc_get_flow_stats(struct otx2_nic *nic,
 	return 0;
 }
 
-static int otx2_setup_tc_cls_flower(struct otx2_nic *nic,
-				    struct flow_cls_offload *cls_flower)
+int otx2_setup_tc_cls_flower(struct otx2_nic *nic,
+			     struct flow_cls_offload *cls_flower)
 {
 	switch (cls_flower->command) {
 	case FLOW_CLS_REPLACE:
@@ -1414,6 +1420,7 @@ static int otx2_setup_tc_cls_flower(struct otx2_nic *nic,
 		return -EOPNOTSUPP;
 	}
 }
+EXPORT_SYMBOL(otx2_setup_tc_cls_flower);
 
 static int otx2_tc_ingress_matchall_install(struct otx2_nic *nic,
 					    struct tc_cls_matchall_offload *cls)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 1806d050c143..ae58d0601b45 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/net_tstamp.h>
+#include <linux/sort.h>
 
 #include "otx2_common.h"
 #include "cn10k.h"
@@ -31,6 +32,117 @@ MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 static int rvu_rep_notify_pfvf(struct otx2_nic *priv, u16 event,
 			       struct rep_event *data);
 
+static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
+{
+	struct npc_mcam_alloc_entry_req *req;
+	struct npc_mcam_alloc_entry_rsp *rsp;
+	struct otx2_nic *priv = rep->mdev;
+	int ent, allocated = 0;
+	int count;
+
+	rep->flow_cfg = kcalloc(1, sizeof(struct otx2_flow_config), GFP_KERNEL);
+
+	if (!rep->flow_cfg)
+		return -ENOMEM;
+
+	count = OTX2_DEFAULT_FLOWCOUNT;
+
+	rep->flow_cfg->flow_ent = kcalloc(count, sizeof(u16), GFP_KERNEL);
+	if (!rep->flow_cfg->flow_ent)
+		return -ENOMEM;
+
+	while (allocated < count) {
+		req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&priv->mbox);
+		if (!req)
+			goto exit;
+
+		req->hdr.pcifunc = rep->pcifunc;
+		req->contig = false;
+		req->ref_entry = 0;
+		req->count = (count - allocated) > NPC_MAX_NONCONTIG_ENTRIES ?
+				NPC_MAX_NONCONTIG_ENTRIES : count - allocated;
+
+		if (otx2_sync_mbox_msg(&priv->mbox))
+			goto exit;
+
+		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
+			(&priv->mbox.mbox, 0, &req->hdr);
+
+		for (ent = 0; ent < rsp->count; ent++)
+			rep->flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
+
+		allocated += rsp->count;
+
+		if (rsp->count != req->count)
+			break;
+	}
+exit:
+	/* Multiple MCAM entry alloc requests could result in non-sequential
+	 * MCAM entries in the flow_ent[] array. Sort them in an ascending
+	 * order, otherwise user installed ntuple filter index and MCAM entry
+	 * index will not be in sync.
+	 */
+	if (allocated)
+		sort(&rep->flow_cfg->flow_ent[0], allocated,
+		     sizeof(rep->flow_cfg->flow_ent[0]), mcam_entry_cmp, NULL);
+
+	mutex_unlock(&priv->mbox.lock);
+
+	rep->flow_cfg->max_flows = allocated;
+
+	if (allocated) {
+		rep->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
+		rep->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
+		rep->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
+	}
+
+	INIT_LIST_HEAD(&rep->flow_cfg->flow_list);
+	INIT_LIST_HEAD(&rep->flow_cfg->flow_list_tc);
+	return 0;
+}
+
+static int rvu_rep_setup_tc_cb(enum tc_setup_type type,
+			       void *type_data, void *cb_priv)
+{
+	struct rep_dev *rep = cb_priv;
+	struct otx2_nic *priv = rep->mdev;
+
+	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
+		return -EINVAL;
+
+	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
+		rvu_rep_mcam_flow_init(rep);
+
+	priv->netdev = rep->netdev;
+	priv->flags = rep->flags;
+	priv->pcifunc = rep->pcifunc;
+	priv->flow_cfg = rep->flow_cfg;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return otx2_setup_tc_cls_flower(priv, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static LIST_HEAD(rvu_rep_block_cb_list);
+static int rvu_rep_setup_tc(struct net_device *netdev, enum tc_setup_type type,
+			    void *type_data)
+{
+	struct rvu_rep *rep = netdev_priv(netdev);
+
+	switch (type) {
+	case TC_SETUP_BLOCK:
+		return flow_block_cb_setup_simple(type_data,
+						  &rvu_rep_block_cb_list,
+						  rvu_rep_setup_tc_cb,
+						  rep, rep, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int
 rvu_rep_sp_stats64(const struct net_device *dev,
 		   struct rtnl_link_stats64 *stats)
@@ -367,6 +479,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_change_mtu		= rvu_rep_change_mtu,
 	.ndo_has_offload_stats	= rvu_rep_has_offload_stats,
 	.ndo_get_offload_stats	= rvu_rep_get_offload_stats,
+	.ndo_setup_tc		= rvu_rep_setup_tc,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv,
@@ -512,6 +625,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 		unregister_netdev(rep->netdev);
 		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
+		kfree(rep->flow_cfg);
 	}
 	kfree(priv->reps);
 	rvu_rep_rsrc_free(priv);
@@ -562,6 +676,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 			       NETIF_F_IPV6_CSUM | NETIF_F_RXHASH |
 			       NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6);
 
+		ndev->hw_features |= NETIF_F_HW_TC;
 		ndev->features |= ndev->hw_features;
 		eth_hw_addr_random(ndev);
 		err = rvu_rep_devlink_port_register(rep);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 163913c3b30f..38446b3e4f13 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -35,6 +35,7 @@ struct rep_dev {
 	struct rep_stats stats;
 	struct delayed_work stats_wrk;
 	struct devlink_port dl_port;
+	struct otx2_flow_config	*flow_cfg;
 #define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
 	u64 flags;
 	u16 rep_id;
-- 
2.25.1


