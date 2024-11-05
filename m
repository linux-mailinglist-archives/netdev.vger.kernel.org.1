Return-Path: <netdev+bounces-141981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1BE9BCD26
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C259A282AE5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094D1D63EE;
	Tue,  5 Nov 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DtcX32OP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6C1D5CD7;
	Tue,  5 Nov 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811412; cv=none; b=urQYP7hwRtbLEXqp5MepptmiP6XtfX6yL0gExN86OxvUx0T1KsEjJKTUfYs++uWBRseSDQ+PJHt5/dCfeZ2C1DSe/xFev8GSkRYlU5lJu8+A+wfo7/zm6G0IUZOJW2kTvUjf6LJ2AjXSS8mvQ3iPPmHsph3dh16e7krenNXXFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811412; c=relaxed/simple;
	bh=uCM2jKl+4bGeArHF5ZeEs+n8w+Vz8U6laQvPmq4ta6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neZnYXvCk9PM7tJcvPZ/k16dMXIbHAjyKmUSriYyG/FNzn4zLsqbJ63D3WxgGMYDzn+LESvVRV3G+eoYjPOjeiHX1er3cAlt6NHHcC6eKASMaSm5qa9e3KZMrGyKkO5otFBJ1LHvJyZ3+S8ZHq8YYZtq9hgf1sflUhIZtTp6LFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DtcX32OP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A57UTAS023561;
	Tue, 5 Nov 2024 04:56:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	+PgKw4aYODkyzCjzk1zvPcRCD3aNxPTGIUQfUHrdKY=; b=DtcX32OPweYgBB/eD
	H5R0ZR4kSO/LqUNSvqXAan2fDm6EGIHfWhiZKPx4L+n64nbcjzZp5xRPznUhltnl
	dE4eEzHo3q5Gw7gtDltMzPD9QqZK1kQGrqdd376MTVKIE0jthUgF9yd811c6YC8q
	12pMZkyqvHKY7dBd6ji/5rzcOshNVoOV94yGbYaXe5v1Y842m9jYerd4FPdTXY4K
	JFMYmfs8Qg7xgQbVFf7LJs/6jKDEfGh5IHycULLHmuzz7gcrpHco5xm0l5EV6jFi
	tkHhUHr8D+hV5GRigBCCZOp4zG2u/2h/D7kwBMj8S/j3N65GAQ/fULLOUNWwHORk
	Z0ndQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42qf1e8kcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 04:56:32 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 5 Nov 2024 04:56:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 04:56:32 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 474795C68E3;
	Tue,  5 Nov 2024 04:56:28 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>,
        Simon Horman
	<horms@kernel.org>
Subject: [PATCH v5 net-next 1/3] octeontx2-af: Refactor few NPC mcam APIs
Date: Tue, 5 Nov 2024 18:26:18 +0530
Message-ID: <20241105125620.2114301-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105125620.2114301-1-lcherian@marvell.com>
References: <20241105125620.2114301-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UADgHH6YheXbStJvpWTHbCXiV9UvaXUM
X-Proofpoint-ORIG-GUID: UADgHH6YheXbStJvpWTHbCXiV9UvaXUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
for better code reuse, which assumes necessary locks are taken at
higher level.

These low level functions would be used for implementing default rule
counter APIs in the subsequent patch.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog from v4:
No changes here.

 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  6 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 89 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 36 ++------
 3 files changed, 92 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 5016ba82e142..d92a5f47a476 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -960,7 +960,11 @@ void rvu_npc_disable_default_entries(struct rvu *rvu, u16 pcifunc, int nixlf);
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 97722ce8c4cb..c4ef1e83cc46 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2975,9 +2975,9 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
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
@@ -2998,11 +2998,9 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
 	if (!req->contig && req->count > NPC_MAX_NONCONTIG_COUNTERS)
 		return NPC_MCAM_INVALID_REQ;
 
-	mutex_lock(&mcam->lock);
 
 	/* Check if unused counters are available or not */
 	if (!rvu_rsrc_free_count(&mcam->counters)) {
-		mutex_unlock(&mcam->lock);
 		return NPC_MCAM_ALLOC_FAILED;
 	}
 
@@ -3035,12 +3033,27 @@ int rvu_mbox_handler_npc_mcam_alloc_counter(struct rvu *rvu,
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
@@ -3050,10 +3063,8 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
-	mutex_lock(&mcam->lock);
 	err = npc_mcam_verify_counter(mcam, req->hdr.pcifunc, req->cntr);
 	if (err) {
-		mutex_unlock(&mcam->lock);
 		return err;
 	}
 
@@ -3077,10 +3088,66 @@ int rvu_mbox_handler_npc_mcam_free_counter(struct rvu *rvu,
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


