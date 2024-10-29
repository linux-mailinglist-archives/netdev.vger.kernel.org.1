Return-Path: <netdev+bounces-139785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA289B416A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0441F22CA8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9557F200C8B;
	Tue, 29 Oct 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DDbBz/eE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19199200BB9;
	Tue, 29 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174288; cv=none; b=tSDkSCAe6qtVSnH5V9Q3ul+Rt8cesjQYw0dPIeDEtL++B7AyKkuuWZuW5Ok5hJzGYOyA5TUNMVUPdqV/oA890Kr93u0gBuKVNGK+tf75xHjRJQr8jVlUZHbt5a+nnu+qZBLcu+1EP5CF0gXjALozRVTD/49UbCc21T9ah6B9DnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174288; c=relaxed/simple;
	bh=KQaAXLazaBTSRyCewbienphQ9u+caovm/CiV0S/UdPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjYLlYL0v389ilQBZNgXCEYOxI+/epO/m8YiQ1Qfp5I4M5m01EbQNmUGemsQjEmCCBVlsRmAe94E82RLmazD6KHC0lLjdZFN/9Q/0cJR+2Pj/rpv/xVQKZOnSf1wflyjZ0ReZ1Q4COBB5RUeYC6E58XekHbp/GEdUeMX3aj7J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DDbBz/eE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T3QoVj020797;
	Mon, 28 Oct 2024 20:57:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	TRsaO8u8nr9tQhOMRlxa0ZMu5A+IGmEI0vR43w4/hg=; b=DDbBz/eEHSna2LKq5
	NMpsl8qVqgfRmx4M96gRYrkBEv8vSVFYAPWmOoH1IAed6vx/904nxcoNrMZ2IyEG
	48pbp7H9wXklAbvCF7oEIJjUKwQJqt3KIzadzTMbbS56L19rGW4z3jlp//lEmUOt
	pANooVxn1TX9Cw1SWpravA3MrP/GQODo59nk8x/TiId/4zYq7SbTZN7PgIJ7NCil
	PAmsMRwBPrcjJjBVq1Di8nMP930MNptAjvHGorpyfvExSrtsP/enc2mHuann9LRe
	xFLjMujjiNgjYkH+uAhLORJt8wsBNL+Y0uTHglGxKa2yNAGakCgvCuguvn/mrVTh
	huuuA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42jqtcg2fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 20:57:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Oct 2024 20:57:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Oct 2024 20:57:58 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 124313F704D;
	Mon, 28 Oct 2024 20:57:53 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>,
        "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v4 net-next 1/3] octeontx2-af: Refactor few NPC mcam APIs
Date: Tue, 29 Oct 2024 09:27:37 +0530
Message-ID: <20241029035739.1981839-2-lcherian@marvell.com>
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
X-Proofpoint-ORIG-GUID: dSpHtYi6XwTYl0ttuvx_8xUe7BBi7tG2
X-Proofpoint-GUID: dSpHtYi6XwTYl0ttuvx_8xUe7BBi7tG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
for better code reuse, which assumes necessary locks are taken at
higher level.

These low level functions would be used for implementing default rule
counter APIs in the subsequent patch.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog from v3:
Added Reviewed-by tag.

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


