Return-Path: <netdev+bounces-99347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D28D4967
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2881C21AEC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D316D333;
	Thu, 30 May 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QLHSLCh4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F3150996;
	Thu, 30 May 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064156; cv=none; b=tyb7Nk9ZumjJJZ+lwxgcF5pT4W8QXxuZMX3WQHu97KDpmYb3ap2qklotqqmTOaULdFxQ2ogNM55/hCjD2ORQ3ijsz0CVQZIJlIHOwsXQ8ZwRfxRVcBVwRLRKXn6K6hG5PxfQ8YqdVMQkWBvE2HZHTZMg7o4eLozR7hMnZCBIRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064156; c=relaxed/simple;
	bh=YH2XkaoEdJ+AHqkW8rxPrO1JMcXQk5JQ/vteSohx728=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5SKdo0ai1FLaEZ/LUa1TWB/hp/mstLAsKf/gltP2Y7xHFf/OoTfSrQE/J40g9qagh8G+oULd37QiKee07SZG75q7f+AgMG1QaDCzj0Zy7q6bt7G8+vckGUTliBmod6HccPbIt+fljvmSqM9vQp6paCi0P5SI2JOF/j1rcFqCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QLHSLCh4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U9a1LZ025821;
	Thu, 30 May 2024 03:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=zS3puPiYhkGRjwXr6REOZk0
	0sFlvLYNXz+LxCZZ5KJ4=; b=QLHSLCh4aUPCrAP4lgxG6PEGCV80oz6Yo3zXnz9
	Gf9tqEsTlqmBFsoH7bvSQCFZhOjMZIwLf9F2cxh7ecVd6kdqYI9pi3oJ1zeGa15V
	Urg5F0FuotluecQNflyLsQiqjGz7gedCjs+owOCLS2sxITU4OT3Kk6bqVFrVqXBM
	3FVLKfqjPza7pDGfhVNeYL0Nq1xVGO4qYQ9rhksLM0v5wwFnIsFOz/HN7YSQZ8qJ
	7OciQyade330vw4T8+Zofr3JrVWmNUOMhzJNdzNpPyaqDGXdYyY5UIEu9me71dYr
	oMEIDIJ4kUhNuhvYFUmfpglhtCJKlNwvlCmV5vU9JDV2wvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn19tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 03:15:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 30 May 2024 03:15:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 30 May 2024 03:15:32 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 2D7B53F70B6;
	Thu, 30 May 2024 03:15:28 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v3] octeontx2-pf: Add ucast filter count configurability via devlink.
Date: Thu, 30 May 2024 15:45:15 +0530
Message-ID: <20240530101515.201635-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sIcIhZHaVv-7j9wzkKfkx8-Cx00GaYsi
X-Proofpoint-GUID: sIcIhZHaVv-7j9wzkKfkx8-Cx00GaYsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01

Added a devlink param to set/modify unicast filter count. Currently
it's hardcoded with a macro.

commands:

To get the current unicast filter count
 # devlink dev param show pci/0002:02:00.0 name unicast_filter_count

To change/set the unicast filter count
 # devlink dev param  set  pci/0002:02:00.0  name unicast_filter_count
 value 5 cmode runtime

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
v3:
    - Addressed review comments given by Jakub Kicinski
        1. Documented unicast_filter_count devlink param
        2. Minor change to match upstream code base
v2:
    - Addressed review comments given by Simon Horman
	1. Updated the commit message with example commads
        2. Modified/optimized conditions

 .../networking/devlink/octeontx2.rst          | 16 +++++
 .../marvell/octeontx2/nic/otx2_common.h       |  7 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      | 64 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_flows.c        | 20 +++---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 5 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/devlink/octeontx2.rst b/Documentation/networking/devlink/octeontx2.rst
index 610de99b728a..5910289b4d4e 100644
--- a/Documentation/networking/devlink/octeontx2.rst
+++ b/Documentation/networking/devlink/octeontx2.rst
@@ -40,3 +40,19 @@ The ``octeontx2 AF`` driver implements the following driver-specific parameters.
      - runtime
      - Use to set the quantum which hardware uses for scheduling among transmit queues.
        Hardware uses weighted DWRR algorithm to schedule among all transmit queues.
+
+The ``octeontx2 PF`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``unicast_filter_count``
+     - u8
+     - runtime
+     - Used to Set/modify unicast filter count, which helps in better utilization of
+       resources against possible wastage(un-used) with current scheme of hardcoded
+       unicast count.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 24fbbef265a6..f27a3456ae64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -346,12 +346,9 @@ struct otx2_flow_config {
 	u16			*def_ent;
 	u16			nr_flows;
 #define OTX2_DEFAULT_FLOWCOUNT		16
-#define OTX2_MAX_UNICAST_FLOWS		8
+#define OTX2_DEFAULT_UNICAST_FLOWS	4
 #define OTX2_MAX_VLAN_FLOWS		1
 #define OTX2_MAX_TC_FLOWS	OTX2_DEFAULT_FLOWCOUNT
-#define OTX2_MCAM_COUNT		(OTX2_DEFAULT_FLOWCOUNT + \
-				 OTX2_MAX_UNICAST_FLOWS + \
-				 OTX2_MAX_VLAN_FLOWS)
 	u16			unicast_offset;
 	u16			rx_vlan_offset;
 	u16			vf_vlan_offset;
@@ -365,6 +362,7 @@ struct otx2_flow_config {
 	u16                     max_flows;
 	refcount_t		mark_flows;
 	struct list_head	flow_list_tc;
+	u8			ucast_flt_cnt;
 	bool			ntuple;
 };
 
@@ -1067,6 +1065,7 @@ int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 int otx2_smq_flush(struct otx2_nic *pfvf, int smq);
 void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
 		    u64 iova, int size);
+int otx2_mcam_entry_init(struct otx2_nic *pfvf);
 
 /* tc support */
 int otx2_init_tc(struct otx2_nic *nic);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 99ddf31269d9..79cd8f1777d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -64,9 +64,68 @@ static int otx2_dl_mcam_count_get(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int otx2_dl_ucast_flt_cnt_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	int err;
+
+	pfvf->flow_cfg->ucast_flt_cnt = ctx->val.vu8;
+
+	otx2_mcam_flow_del(pfvf);
+	err = otx2_mcam_entry_init(pfvf);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	ctx->val.vu8 = pfvf->flow_cfg ? pfvf->flow_cfg->ucast_flt_cnt : 0;
+
+	return 0;
+}
+
+static int otx2_dl_ucast_flt_cnt_validate(struct devlink *devlink, u32 id,
+					  union devlink_param_value val,
+					  struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	/* Check for UNICAST filter support*/
+	if (!(pfvf->flags & OTX2_FLAG_UCAST_FLTR_SUPPORT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unicast filter not enabled");
+		return -EINVAL;
+	}
+
+	if (!pfvf->flow_cfg) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "pfvf->flow_cfg not initialized");
+		return -EINVAL;
+	}
+
+	if (pfvf->flow_cfg->nr_flows) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot modify count when there are active rules");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 enum otx2_dl_param_id {
 	OTX2_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_DEVLINK_PARAM_ID_MCAM_COUNT,
+	OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
 };
 
 static const struct devlink_param otx2_dl_params[] = {
@@ -75,6 +134,11 @@ static const struct devlink_param otx2_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     otx2_dl_mcam_count_get, otx2_dl_mcam_count_set,
 			     otx2_dl_mcam_count_validate),
+	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_UCAST_FLT_CNT,
+			     "unicast_filter_count", DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_dl_ucast_flt_cnt_get, otx2_dl_ucast_flt_cnt_set,
+			     otx2_dl_ucast_flt_cnt_validate),
 };
 
 static const struct devlink_ops otx2_devlink_ops = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index bc5819237ed7..98c31a16c70b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -12,8 +12,6 @@
 
 #define OTX2_DEFAULT_ACTION	0x1
 
-static int otx2_mcam_entry_init(struct otx2_nic *pfvf);
-
 struct otx2_flow {
 	struct ethtool_rx_flow_spec flow_spec;
 	struct list_head list;
@@ -161,7 +159,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 }
 EXPORT_SYMBOL(otx2_alloc_mcam_entries);
 
-static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
+int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 {
 	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
 	struct npc_get_field_status_req *freq;
@@ -172,7 +170,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	int ent, count;
 
 	vf_vlan_max_flows = pfvf->total_vfs * OTX2_PER_VF_VLAN_FLOWS;
-	count = OTX2_MAX_UNICAST_FLOWS +
+	count = flow_cfg->ucast_flt_cnt +
 			OTX2_MAX_VLAN_FLOWS + vf_vlan_max_flows;
 
 	flow_cfg->def_ent = devm_kmalloc_array(pfvf->dev, count,
@@ -214,7 +212,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	flow_cfg->vf_vlan_offset = 0;
 	flow_cfg->unicast_offset = vf_vlan_max_flows;
 	flow_cfg->rx_vlan_offset = flow_cfg->unicast_offset +
-					OTX2_MAX_UNICAST_FLOWS;
+					flow_cfg->ucast_flt_cnt;
 	pfvf->flags |= OTX2_FLAG_UCAST_FLTR_SUPPORT;
 
 	/* Check if NPC_DMAC field is supported
@@ -255,6 +253,7 @@ static int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	refcount_set(&flow_cfg->mark_flows, 1);
 	return 0;
 }
+EXPORT_SYMBOL(otx2_mcam_entry_init);
 
 /* TODO : revisit on size */
 #define OTX2_DMAC_FLTR_BITMAP_SZ (4 * 2048 + 32)
@@ -302,6 +301,8 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list);
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
 
+	pf->flow_cfg->ucast_flt_cnt = OTX2_DEFAULT_UNICAST_FLOWS;
+
 	/* Allocate bare minimum number of MCAM entries needed for
 	 * unicast and ntuple filters.
 	 */
@@ -314,7 +315,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 		return 0;
 
 	pf->mac_table = devm_kzalloc(pf->dev, sizeof(struct otx2_mac_table)
-					* OTX2_MAX_UNICAST_FLOWS, GFP_KERNEL);
+					* pf->flow_cfg->ucast_flt_cnt, GFP_KERNEL);
 	if (!pf->mac_table)
 		return -ENOMEM;
 
@@ -356,7 +357,7 @@ static int otx2_do_add_macfilter(struct otx2_nic *pf, const u8 *mac)
 		return -ENOMEM;
 
 	/* dont have free mcam entries or uc list is greater than alloted */
-	if (netdev_uc_count(pf->netdev) > OTX2_MAX_UNICAST_FLOWS)
+	if (netdev_uc_count(pf->netdev) > pf->flow_cfg->ucast_flt_cnt)
 		return -ENOMEM;
 
 	mutex_lock(&pf->mbox.lock);
@@ -367,7 +368,7 @@ static int otx2_do_add_macfilter(struct otx2_nic *pf, const u8 *mac)
 	}
 
 	/* unicast offset starts with 32 0..31 for ntuple */
-	for (i = 0; i <  OTX2_MAX_UNICAST_FLOWS; i++) {
+	for (i = 0; i <  pf->flow_cfg->ucast_flt_cnt; i++) {
 		if (pf->mac_table[i].inuse)
 			continue;
 		ether_addr_copy(pf->mac_table[i].addr, mac);
@@ -410,7 +411,7 @@ static bool otx2_get_mcamentry_for_mac(struct otx2_nic *pf, const u8 *mac,
 {
 	int i;
 
-	for (i = 0; i < OTX2_MAX_UNICAST_FLOWS; i++) {
+	for (i = 0; i < pf->flow_cfg->ucast_flt_cnt; i++) {
 		if (!pf->mac_table[i].inuse)
 			continue;
 
@@ -1394,6 +1395,7 @@ int otx2_destroy_mcam_flows(struct otx2_nic *pfvf)
 	}
 
 	pfvf->flags &= ~OTX2_FLAG_MCAM_ENTRIES_ALLOC;
+	flow_cfg->max_flows = 0;
 	mutex_unlock(&pfvf->mbox.lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f5bce3e326cc..ff05ea20409a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1714,7 +1714,7 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 		return;
 
 	if ((netdev->flags & IFF_PROMISC) ||
-	    (netdev_uc_count(netdev) > OTX2_MAX_UNICAST_FLOWS)) {
+	    (netdev_uc_count(netdev) > pf->flow_cfg->ucast_flt_cnt)) {
 		promisc = true;
 	}
 
-- 
2.25.1


