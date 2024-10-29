Return-Path: <netdev+bounces-139786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492AB9B416D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0781F22F2A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE320100D;
	Tue, 29 Oct 2024 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dIyk/Vr3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC2200CB6;
	Tue, 29 Oct 2024 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174292; cv=none; b=q2ehX9VNLXicPThmPj5PIqu2n+Y4VF+uPzuIzJ9xjqVrB26M3x/1bpNIFcbRisO/7CxaPvbyKd/a0RavrC3s2eC8IVsjTvvF2rOe37IiLgyFB/8HSxz/egGTtkYAc1mSldL1A7e+LLgYZ1vNl9n148paJM9Tk2jR5QHBt8V+xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174292; c=relaxed/simple;
	bh=C5LDk1/+vJE76Y2p6FVY3qu4lKh4jkaZn6bJVMwO4vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfRWjjtDtPXrzYcrcR1JFTJeu873+vg4w7C7IioKL41NP7r4SH7/ym4sAi5ZAwySm/rddwz4BgP6rnGktRQEkl4qG6WsZ52qCCadPPM5KBF9osgfu6EXZVv8gu9UGCgnk6O9JqclvzBfSrSItySRXKBgEDTnt/OqEHoh0SFLimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dIyk/Vr3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T3RoBd022013;
	Mon, 28 Oct 2024 20:58:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	SJISprJl/otmxTFP3ot0RiGqvnCXQgEtRDqi7k32S8=; b=dIyk/Vr3FrjSlISVE
	UcW60N65r0ClA+Q9yetbbqDR3dBjs/DamudWf2LlMLlduJnNGWwcsmvQDWCZZXzW
	3OsLnOp920+dDowsB6ZUk/ySDHHYIo3ZZqT62EweTPGF2CBXrifjpTzBZ8Ewo2Po
	8GvBJpPvJgmeXZIhvfyBQm7Tha0IwFAAg1CGd2Z0upq4Cs734K3Jo+o9Y1HbEcIh
	6ttSqgw5Lqay6QwhIqGah0GClqFotgyPFGbaaOoFuVYGlk1IM3Y3A8Tqx25uZOJh
	vdfumeiVhHGY226THnUL9YGiTZe6kW8u/wYrasoWUKsm7BY0MWF5ad1z8l+jnHVD
	nM3wA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42jqtcg2g6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 20:58:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 20:58:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 20:58:02 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id D20773F704D;
	Mon, 28 Oct 2024 20:57:58 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v4 net-next 2/3] octeontx2-af: Knobs for NPC default rule counters
Date: Tue, 29 Oct 2024 09:27:38 +0530
Message-ID: <20241029035739.1981839-3-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029035739.1981839-1-lcherian@marvell.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZbqU_RWzePeygnFiPWe5O-WLIok4K-e1
X-Proofpoint-GUID: ZbqU_RWzePeygnFiPWe5O-WLIok4K-e1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add devlink knobs to enable/disable counters on NPC
default rule entries.

Sample command to enable default rule counters:
devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime

Sample command to read the counter:
cat /sys/kernel/debug/cn10k/npc/mcam_rules

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v3:
No changes.

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 45 +++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index d92a5f47a476..e8c6a6fe9bd5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -525,6 +525,7 @@ struct rvu {
 	struct mutex		alias_lock; /* Serialize bar2 alias access */
 	int			vfs; /* Number of VFs attached to RVU */
 	u16			vf_devid; /* VF devices id */
+	bool			def_rule_cntr_en;
 	int			nix_blkaddr[MAX_NIX_BLKS];
 
 	/* Mbox */
@@ -989,6 +990,7 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
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
index c4ef1e83cc46..9e39c3149a4f 100644
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
-- 
2.34.1


