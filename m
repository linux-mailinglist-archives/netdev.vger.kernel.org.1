Return-Path: <netdev+bounces-127865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC9976E86
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF78B21350
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC172158DD4;
	Thu, 12 Sep 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QB9oXG4A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84A153BD7;
	Thu, 12 Sep 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157711; cv=none; b=OIhFF2810hxVIM4TVImbrU8VUGNvbpUTk171d3ZPefrubiCmGKpgFyRMdZIVko5oQJIYscN8+9Bi+4KszXLsjbkZsN/uknRxnfJTqKNrUuZoOdd7ZQncclRamIp5RrABNtpGjo/o7kauLIyVyOtRLGffb1JnOUeX+7PCJndM94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157711; c=relaxed/simple;
	bh=x5aJAbquW+WGBDQCn8zvk72PQKz5pz7+zUbBrw8sSnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKSJwpX7kn19X6jghwmq+5bWoE5YqzwXjpcmm+oUKdnXpGvpEgpe3Ky0ro+AXCW8qB/DWPmzntF0USMq1kPbB82i0Q0dcIGgb6Stvoqgom3V4gHwXgvhPztjFjquYPueJutR5I46zuy4F1GVaNaPyNiKOYeW3Qydh2I0BiiwM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QB9oXG4A; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCIocX032591;
	Thu, 12 Sep 2024 09:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	BrfVYkRO2x5z5vQLe9JMKmk3cFwq1+MdFCvUT5HSw0=; b=QB9oXG4AeuyB+tyOX
	a307AwxXyx7Wo+9gYpi9nS8iiUTvyileFWz4pG8p7Ujx/fgtKjnx6n7zzScAcPAK
	S+qsKm/clcRkGGFrlkUh/TYj/do94UqRkYKEZ2UE3Op5bRBeu/htiA6OZimvDAoK
	CPLlxhtaxu9UdHnaz/OuAHKHhu59EYxYfrO0ywwi6dr0P/mOFZ11kGZzdERKqXje
	u9Fmy4cWWiyx9Z4/LmjFJ+0wh5kRWynLYTRvTRzd/T8sNO/NWafbbCaG0Ndmd7l0
	CvpGkJRCO1BT/LXtxiQJyf2STS0uQTLkbt6GqZ4A2MPPGoTCt7vX/ZHiIVc4bTTh
	CIleQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8ptye4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:15:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 09:14:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Sep 2024 09:14:59 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 99D2C3F7078;
	Thu, 12 Sep 2024 09:14:56 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [PATCH v2 net-next 1/2] octeontx2-af: Knobs for NPC default rule counters
Date: Thu, 12 Sep 2024 21:44:49 +0530
Message-ID: <20240912161450.164402-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912161450.164402-1-lcherian@marvell.com>
References: <20240912161450.164402-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 59kjHNmb02W9OUnYUgkjtIDYyzX4-3Rt
X-Proofpoint-GUID: 59kjHNmb02W9OUnYUgkjtIDYyzX4-3Rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add devlink knobs to enable/disable counters on NPC
default rule entries.

Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
for better code reuse, which assumes necessary locks are taken at
higher level.

Sample command to enable default rule counters:
devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime

Sample command to read the counter:
cat /sys/kernel/debug/cn10k/npc/mcam_rules

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v1:
Removed wrong mutex_unlock invocations.

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   8 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 134 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  36 ++---
 4 files changed, 171 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 43b1d83686d1..fb4b88e94649 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -526,6 +526,7 @@ struct rvu {
 	struct mutex		alias_lock; /* Serialize bar2 alias access */
 	int			vfs; /* Number of VFs attached to RVU */
 	u16			vf_devid; /* VF devices id */
+	bool			def_rule_cntr_en;
 	int			nix_blkaddr[MAX_NIX_BLKS];
 
 	/* Mbox */
@@ -961,7 +962,11 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
 void rvu_npc_enable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
 void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    int group, int alg_idx, int mcam_index);
-
+void __rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
+					 struct rvu_npc_mcam_rule *rule);
+void __rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
+				    struct rvu_npc_mcam_rule *rule,
+				    struct npc_install_flow_rsp *rsp);
 void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
 				       int blkaddr, int *alloc_cnt,
 				       int *enable_cnt);
@@ -986,6 +991,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 int blkaddr, u16 src, struct mcam_entry *entry,
 			 u8 *intf, u8 *ena);
+int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
 bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
 bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
 u32  rvu_cgx_get_fifolen(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 7498ab429963..9c26e19a860b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1238,6 +1238,7 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
@@ -1358,6 +1359,32 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
 	return 0;
 }
 
+static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	ctx->val.vbool = rvu->def_rule_cntr_en;
+
+	return 0;
+}
+
+static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	int err;
+
+	err = npc_config_cntr_default_entries(rvu, ctx->val.vbool);
+	if (!err)
+		rvu->def_rule_cntr_en = ctx->val.vbool;
+
+	return err;
+}
+
 static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
 				   struct devlink_param_gset_ctx *ctx)
 {
@@ -1444,6 +1471,11 @@ static const struct devlink_param rvu_af_dl_params[] = {
 			     rvu_af_dl_npc_mcam_high_zone_percent_get,
 			     rvu_af_dl_npc_mcam_high_zone_percent_set,
 			     rvu_af_dl_npc_mcam_high_zone_percent_validate),
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
+			     "npc_def_rule_cntr", DEVLINK_PARAM_TYPE_BOOL,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_dl_npc_def_rule_cntr_get,
+			     rvu_af_dl_npc_def_rule_cntr_set, NULL),
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 			     "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 97722ce8c4cb..9e39c3149a4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2691,6 +2691,51 @@ void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx)
 	npc_mcam_set_bit(mcam, entry_idx);
 }
 
+int npc_config_cntr_default_entries(struct rvu *rvu, bool enable)
+{
+	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule;
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return -EINVAL;
+
+	mutex_lock(&mcam->lock);
+	list_for_each_entry(rule, &mcam->mcam_rules, list) {
+		if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entry))
+			continue;
+		if (!rule->default_rule)
+			continue;
+		if (enable && !rule->has_cntr) { /* Alloc and map new counter */
+			__rvu_mcam_add_counter_to_rule(rvu, rule->owner,
+						       rule, &rsp);
+			if (rsp.counter < 0) {
+				dev_err(rvu->dev, "%s: Err to allocate cntr for default rule (err=%d)\n",
+					__func__, rsp.counter);
+				break;
+			}
+			npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
+						    rule->entry, rsp.counter);
+		}
+
+		if (enable && rule->has_cntr) /* Reset counter before use */ {
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_MATCH_STATX(rule->cntr), 0x0);
+			continue;
+		}
+
+		if (!enable && rule->has_cntr) /* Free and unmap counter */ {
+			__rvu_mcam_remove_counter_from_rule(rvu, rule->owner,
+							    rule);
+		}
+	}
+	mutex_unlock(&mcam->lock);
+
+	return 0;
+}
+
 int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
 					  struct npc_mcam_alloc_entry_req *req,
 					  struct npc_mcam_alloc_entry_rsp *rsp)
@@ -2975,9 +3020,9 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 	return rc;
 }
 
-int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
-			struct npc_mcam_alloc_counter_req *req,
-			struct npc_mcam_alloc_counter_rsp *rsp)
+static int __npc_mcam_alloc_counter(struct rvu *rvu,
+				    struct npc_mcam_alloc_counter_req *req,
+				    struct npc_mcam_alloc_counter_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u16 pcifunc = req->hdr.pcifunc;
@@ -2998,11 +3043,9 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
 	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
 		return NPC_MCAM_INVALID_REQ;
 
-	mutex_lock(&mcam->lock);
 
 	/* Check if unused counters are available or not */
 	if (!rvu_rsrc_free_count(&mcam->counters)) {
-		mutex_unlock(&mcam->lock);
 		return NPC_MCAM_ALLOC_FAILED;
 	}
 
@@ -3035,12 +3078,27 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
 		}
 	}
 
-	mutex_unlock(&mcam->lock);
 	return 0;
 }
 
-int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
-		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
+int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
+			struct npc_mcam_alloc_counter_req *req,
+			struct npc_mcam_alloc_counter_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int err;
+
+	mutex_lock(&mcam->lock);
+
+	err = __npc_mcam_alloc_counter(rvu, req, rsp);
+
+	mutex_unlock(&mcam->lock);
+	return err;
+}
+
+static int __npc_mcam_free_counter(struct rvu *rvu,
+				   struct npc_mcam_oper_counter_req *req,
+				   struct msg_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u16 index, entry = 0;
@@ -3050,10 +3108,8 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
-	mutex_lock(&mcam->lock);
 	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
 	if (err) {
-		mutex_unlock(&mcam->lock);
 		return err;
 	}
 
@@ -3077,10 +3133,66 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
 					      index, req->cntr);
 	}
 
-	mutex_unlock(&mcam->lock);
 	return 0;
 }
 
+int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
+		struct npc_mcam_oper_counter_req *req, struct msg_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int err;
+
+	mutex_lock(&mcam->lock);
+
+	err = __npc_mcam_free_counter(rvu, req, rsp);
+
+	mutex_unlock(&mcam->lock);
+
+	return err;
+}
+
+void __rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
+					 struct rvu_npc_mcam_rule *rule)
+{
+	struct npc_mcam_oper_counter_req free_req = { 0 };
+	struct msg_rsp free_rsp;
+
+	if (!rule->has_cntr)
+		return;
+
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.cntr = rule->cntr;
+
+	__npc_mcam_free_counter(rvu, &free_req, &free_rsp);
+	rule->has_cntr = false;
+}
+
+void __rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
+				    struct rvu_npc_mcam_rule *rule,
+				    struct npc_install_flow_rsp *rsp)
+{
+	struct npc_mcam_alloc_counter_req cntr_req = { 0 };
+	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
+	int err;
+
+	cntr_req.hdr.pcifunc = pcifunc;
+	cntr_req.contig = true;
+	cntr_req.count = 1;
+
+	/* we try to allocate a counter to track the stats of this
+	 * rule. If counter could not be allocated then proceed
+	 * without counter because counters are limited than entries.
+	 */
+	err = __npc_mcam_alloc_counter(rvu, &cntr_req, &cntr_rsp);
+	if (!err && cntr_rsp.count) {
+		rule->cntr = cntr_rsp.cntr;
+		rule->has_cntr = true;
+		rsp->counter = rule->cntr;
+	} else {
+		rsp->counter = err;
+	}
+}
+
 int rvu_mbox_handler_npc_mcam_unmap_counter(struct rvu *rvu,
 		struct npc_mcam_unmap_counter_req *req, struct msg_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 150635de2bd5..7a1c18b1486d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1081,44 +1081,26 @@ static void rvu_mcam_add_rule(struct npc_mcam *mcam,
 static void rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
 					      struct rvu_npc_mcam_rule *rule)
 {
-	struct npc_mcam_oper_counter_req free_req = { 0 };
-	struct msg_rsp free_rsp;
+	struct npc_mcam *mcam = &rvu->hw->mcam;
 
-	if (!rule->has_cntr)
-		return;
+	mutex_lock(&mcam->lock);
 
-	free_req.hdr.pcifunc = pcifunc;
-	free_req.cntr = rule->cntr;
+	__rvu_mcam_remove_counter_from_rule(rvu, pcifunc, rule);
 
-	rvu_mbox_handler_npc_mcam_free_counter(rvu, &free_req, &free_rsp);
-	rule->has_cntr = false;
+	mutex_unlock(&mcam->lock);
 }
 
 static void rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
 					 struct rvu_npc_mcam_rule *rule,
 					 struct npc_install_flow_rsp *rsp)
 {
-	struct npc_mcam_alloc_counter_req cntr_req = { 0 };
-	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
-	int err;
+	struct npc_mcam *mcam = &rvu->hw->mcam;
 
-	cntr_req.hdr.pcifunc = pcifunc;
-	cntr_req.contig = true;
-	cntr_req.count = 1;
+	mutex_lock(&mcam->lock);
 
-	/* we try to allocate a counter to track the stats of this
-	 * rule. If counter could not be allocated then proceed
-	 * without counter because counters are limited than entries.
-	 */
-	err = rvu_mbox_handler_npc_mcam_alloc_counter(rvu, &cntr_req,
-						      &cntr_rsp);
-	if (!err && cntr_rsp.count) {
-		rule->cntr = cntr_rsp.cntr;
-		rule->has_cntr = true;
-		rsp->counter = rule->cntr;
-	} else {
-		rsp->counter = err;
-	}
+	__rvu_mcam_add_counter_to_rule(rvu, pcifunc, rule, rsp);
+
+	mutex_unlock(&mcam->lock);
 }
 
 static int npc_mcast_update_action_index(struct rvu *rvu, struct npc_install_flow_req *req,
-- 
2.34.1


