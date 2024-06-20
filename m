Return-Path: <netdev+bounces-105176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C490FFC0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AF280F52
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F546426;
	Thu, 20 Jun 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XuEUQZS1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE1628;
	Thu, 20 Jun 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874024; cv=none; b=HuapeEOtjyqd20FRJwnQQNNti6LSHoHHLYMtQlLNmwdfEsXpm5L22IHfTe0pb2AjwTcbSGclPN6S37xC5Hn+ULxDJG/rr5LnYM8D+YjDrJp9DXBYgz1IFq45DhJLI3g4lMUfchYQK29EDnI4aXJfu/vI6oJ94LhwdVrlWnV6fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874024; c=relaxed/simple;
	bh=o42AxAl/vNZPqzgkMrw9bsTEPmYiDoxQ6Vq3ZNujukU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXjVNDbLrQ3PoaCQ2/QGJSpnuSevaY7eHVeDgrQ9+M+FqC5zVSyCVTo087PJhQdBXBtG+1LpiVSpJl6HoHQnq0Q0wJVaUb4ZZifVA40nuz1dfkCi8pJKy7eArMkaoBaN9agbSK/zzOkVeSWQm/FYrT11M44kmR0dwpWUh6DZX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XuEUQZS1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMwecb027314;
	Thu, 20 Jun 2024 02:00:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=VIr+SoI6bECp386JwzPYVQg
	7xyj9NdZfW8/zz0Dd6n8=; b=XuEUQZS16mwUbfrjEm2zoy7KY5w1X7mvqC2lyrX
	pHq5jCv+fQlvDujPqZrW+nIOqmoaKIDoHLrVOf4o1u9xtoqLkBsf+3pUs6kNrA1E
	sjWkQ6R46phFrlzP3nWYYC8MXBU28EVupC4M8eOhbNQmsR3LDVX8vm0szJE+2HD+
	xQVAN9ybbG2OJnwTr1FDqqVIoZl+zQFGoZwxPtNifHe2Mi58ELta5W6DD1NPvfuR
	DlovrPqCFVnCQsrkcYA5/RtcprdF5aMgWuaJDEDGx34H5tcHP9uagxMzexmWCl2R
	N74iND7QLUdBaMphqHvTyZRPtDPLi23V3g3rZ+7hMFJNVvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yutyc42bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 02:00:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Jun 2024 02:00:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Jun 2024 02:00:06 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id BD9383F7090;
	Thu, 20 Jun 2024 02:00:01 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <jacob.e.keller@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>
Subject: [net-next PATCH v4] octeontx2-pf: Add ucast filter count configurability via devlink.
Date: Thu, 20 Jun 2024 14:29:49 +0530
Message-ID: <20240620085949.1328937-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TORe0SMX3sdw6n_6Bp8pUw0uhBOTiVr-
X-Proofpoint-GUID: TORe0SMX3sdw6n_6Bp8pUw0uhBOTiVr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01

The existing method of reserving unicast filter count leads to wasted
MCAM entries if the functionality is not used or fewer entries are used.
Furthermore, the amount of MCAM entries differs amongst Octeon SoCs.
We implemented a means to adjust the UC filter count via devlink,
allowing for better use of MCAM entries across Netdev apps.

commands:

To get the current unicast filter count
 # devlink dev param show pci/0002:02:00.0 name unicast_filter_count

To change/set the unicast filter count
 # devlink dev param  set  pci/0002:02:00.0  name unicast_filter_count
 value 5 cmode runtime

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v4:
    - Addressed review comments given by Jacob Keller
        1. Re-worded documentation content.
        2. Elaborated commit message
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
index 610de99b728a..d33a90dd44bf 100644
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
+     - Set the maximum number of unicast filters that can be programmed for
+       the device. This can be used to achieve better device resource
+       utilization, avoiding over consumption of unused MCAM table entries.
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


