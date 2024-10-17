Return-Path: <netdev+bounces-136463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7C9A1D77
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABED5284D22
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2891D61AC;
	Thu, 17 Oct 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZhE2YfRk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E11D6191;
	Thu, 17 Oct 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154606; cv=none; b=VM6989OpnXzJ5S8Dnt54c+EUitV3M2BzK5UfwNxI5WKYnG+jgdQo9UNDYApZ1lQye6fpK7Zjn9mFTAik5Iy+nFzWv80Z65JE0/ic/cttlRuuK1Og8cIBQcRD5HS9oJ7ee/3LiZWQdfjcAfwj/AyXEiC8fLbLAd8J1IGv9/qH0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154606; c=relaxed/simple;
	bh=2OsSJ9LAAFvDtnkXOIDUpvSUKmdKq1+WHCr0KxZLn2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2Dv8hTA7ppQGM+/xZ4kavY4MnXou6+Qi71BAHqEWtXDErPV1MGRybYTQU0ICZqgkwXtrh93rugHrITjAMT+TzELlEzQt9Zych5/dDCYAFFvmOwN0j0IVwl0HYbn5SHhrtT1p63jZdeo+CwVzB5q2Jeri62dG/Cpm8gM0Inufq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZhE2YfRk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKOPai013083;
	Thu, 17 Oct 2024 01:43:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	+cWXGdDGjfssp7KqM2ge5CH2qMNuaHWniXG50U9EVs=; b=ZhE2YfRkAMnr66DyP
	Hcq4PriDUJnlGJVkBUXGD4T650/Bb6l3pnVrIrI6zXxXkewT+C5frGDNEC07Y7BX
	HYOQFPmvmKXCmSbmtfX0M0/Yk9/8kzL6RVEd22KUx17aLEzOfwVnumjxOnQ6fe4d
	bPTtHMOvuTY1EDOkvfhVMPkailO4jxaFoZstW4ccU9jgZXLYHGHM3oBNQNrLu28n
	9ToYZzJgeCCcRBjC4OuDk42E2NmRVfrANJJDHpVL5LJ77GiJOjvIKSI50Sszwfni
	g1dUnyAOjx56EYDDFha5gAOZr/6Nfs6YciZ1BQke8/EQLa589ql3ixczky0L/5jf
	eXWxg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42aanf2p4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:43:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 01:43:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 01:43:01 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 459223F7040;
	Thu, 17 Oct 2024 01:42:57 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v3 net-next 2/2] octeontx2-af: Knobs for NPC default rule counters
Date: Thu, 17 Oct 2024 14:12:44 +0530
Message-ID: <20241017084244.1654907-3-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017084244.1654907-1-lcherian@marvell.com>
References: <20241017084244.1654907-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xT1B7pYfooinX0eqTBrdwuK2EcveZ38_
X-Proofpoint-GUID: xT1B7pYfooinX0eqTBrdwuK2EcveZ38_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add devlink knobs to enable/disable counters on NPC
default rule entries.

Sample command to enable default rule counters:
devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime

Sample command to read the counter:
cat /sys/kernel/debug/cn10k/npc/mcam_rules

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v2:
Moved out the refactoring into separate patch. 

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


