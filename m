Return-Path: <netdev+bounces-136462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF999A1D75
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AF41C247B4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606081D47A2;
	Thu, 17 Oct 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F6KOLeLW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D61D362B;
	Thu, 17 Oct 2024 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154602; cv=none; b=oQubb+Hn53TBQOr+wQ8zxq5R5x+YZVzijn8bmf8npm4ACkyM9cd676orC8jotffrHUr9vOGYFasW5LsSH3HoN8WqGxpMQo6EwAm1QSzboafu/FpX3IKcBGbEOLSfgqU4sTdBc4YlLFI0V469c1PZC4gJEgpVZBoyq9WSzMY35WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154602; c=relaxed/simple;
	bh=rM0C1yv6Kbrx67TF8jPbaHMPCquKRo9Dls4RO0F4+pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRfjdRxi3zK10/46Z3t7j9hGa1lLX0MOhLypwZjhWx9lKHicoMaPjl0b9E4xefxzHB9OFBsVKA9QfhF5m85il3kq9rtUCSMcc8AYNYf3peS2LC5kP8/4f5C4RYm2Eo74d8+iyYSHaabqI7lMiM9tZL646RCo+HL+Ia2UcMKT+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F6KOLeLW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKOOh7013078;
	Thu, 17 Oct 2024 01:42:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	yBI8rCLhRQf+jJwxBuqfCsHG0us0oUyqjieJNKNb+c=; b=F6KOLeLWhRLLsJkGt
	J1xs+pCQ+aXc16MZ1rhgnAzdNGlzNJ3wWS+1fQV6Xox0eUkfnkrloe+TbkJxqDPk
	V2p6O8sUwVgkFPKrSMg6NxEW6RujIOldEqwtJDkDfFpP8zshZDOIytd/H3RlnDUn
	RaEfxHrVblKRKs3BUsc1DVa/2RhFzh6PMGQHk14Ce9Iy+jbeI13GqP9pubustL+K
	cGXdvebvB2uhgATOqIouAeH8jKQJVxs4CMhnGT72gSf5q3ouSih5a34oFMgfNlgq
	kad07BkmFQi4yRhiCRgOFq5+YjczCNWBeqBUB+2Woqjn+7ihMDJ6QMRW4elSJB8/
	3txiQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42aanf2p47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:42:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Oct 2024 01:42:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 01:42:57 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 602FE3F7040;
	Thu, 17 Oct 2024 01:42:53 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v3 net-next 1/2] octeontx2-af: Refactor few NPC mcam APIs
Date: Thu, 17 Oct 2024 14:12:43 +0530
Message-ID: <20241017084244.1654907-2-lcherian@marvell.com>
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
X-Proofpoint-ORIG-GUID: jgfZmMke9Ufj8_JFROOsjlx-5wGww1cF
X-Proofpoint-GUID: jgfZmMke9Ufj8_JFROOsjlx-5wGww1cF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
for better code reuse, which assumes necessary locks are taken at
higher level.

These low level functions would be used for implementing default rule
counter APIs in the subsequent patch.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v2:

New refactoring patch.

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


