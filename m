Return-Path: <netdev+bounces-191730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39605ABCF00
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CD21B65DC5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0F25B676;
	Tue, 20 May 2025 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KZQ4LcS3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6E1DB124;
	Tue, 20 May 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721418; cv=none; b=lyZFrWZtZJZOO4q+kmKRStO7lhoRYiRLg/1/ADWGaWjbTzDdNFN9cdYksF4nCWUXPSqcGBkzQkmuFZKObWT541Q3722EW3FhufUTng44ehm8SVwzGILm86mJMVT3JEzNrtvNK3cDtE83Kpk0Up9FoqG/o53bHkinneyaR9YAiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721418; c=relaxed/simple;
	bh=5F3dDItauTYHudAvONgsRxNKYrhpGJJLwRjmNywRbRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbZKFh/U8IctfM6f7Y+plw7vwVYdu+269Wn01zQoRwgQKvTYxUbOkr+aRzxTKn30h+VTmRtgpJHn1UdV8axs7ZUrOaUQ0PHA858L04U5ous6d4GAVoxBfdtr4tFGEXZao4f6XG2YfmSiZC47zBycgPgKuAiyDu6fsLgG+W1anQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KZQ4LcS3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JM4oa5011988;
	Mon, 19 May 2025 23:10:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Do35XLd5RGV6NCIHo8nqtBU
	tOevhNsdBsCJJFl+4BOg=; b=KZQ4LcS31OBP6iJR2pAlxRCauBKKCnn6JZjXBkn
	gkAx0Tjc6elcObYTgZXzFuFqiZcqDo264dJeHaRmVSpL5JyFTmnVq+sFmKV7AnmQ
	yQkHcqoLdyKw88jv9ZopCD+CzmL7dNuVdw9tWKr3k8sXckRHkGryPM0tIBALeLPl
	BTuj7HfOHPUHprlKHNROLk9OA6mH8u4X8VspPThir8lgRIVAK8Is1YOeiix58lRx
	MNCr1J4Autf0jxBaVc2LkPjNqsJywcXyAqjiTGpQga7VMtIwoBdrtf+vyB7xvW9L
	XVyzccDZ8W8HNNewnRBVMbIjpFP1Muwh/+t56a3zvnzgrwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46rd3u0qby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 23:10:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 23:10:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 23:10:02 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id A3C3C3F7061;
	Mon, 19 May 2025 23:09:57 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net-next] octeontx2-af: NPC: Clear Unicast rule on nixlf detach
Date: Tue, 20 May 2025 11:39:52 +0530
Message-ID: <20250520060952.1080092-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: K8YM7B7X9Q_vVpFn4_q2aX_z-Y4FFD7K
X-Proofpoint-ORIG-GUID: K8YM7B7X9Q_vVpFn4_q2aX_z-Y4FFD7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA0OSBTYWx0ZWRfX37V6lxgYlwKM yBgb0BoN3qh/d6x+juJUEqe30t95hOSaL3dWdMbm1OULrWY6cv9iJR1TXkCo/cMJzpnkaf1h1bb KbVWboCoTeLHBvdz5h507R/fTd9uWZSzLk4HG5d6IgCGcEK4uNG6EVkR+i0XuSGb4ZaoDpfEydU
 ljiAlSTyFEPS7zVOvEYJyQFfqrIfolO52OKsxa0M9A8qKBY7Dh3vvvIypRMG+l9o6+IjTwo7bTe TY3Z/yBwUGMSRbBgotBaHFoRutVY02SRQKWFhV932JxJelhGJpkbatUAcQuRxxhglLHXTHcZ/IS TtAQEmH22eEvzHOgAZrzQky72ap77EfQvncmsAK6dtXCvphr0rIxCX+7AUuhCGuO+izxjmPvp3y
 kE4PBrV12DzZ+HHQQeuTWoTKO+ti6HgGHalXbBTzb2tlFNhQzGuPoMJcxMfw6BwbM/Nha+cn
X-Authority-Analysis: v=2.4 cv=f7NIBPyM c=1 sm=1 tr=0 ts=682c1cbb cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=WfLIaZI_07ispqDUzUwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01

The AF driver assigns reserved MCAM entries (for unicast, broadcast,
etc.) based on the NIXLF number. When a NIXLF is detached, these entries
are disabled.

For example,

         PF           NIXLF
        --------------------
         PF0             0
         SDP-VF0         1

If the user unbinds both PF0 and SDP-VF0 interfaces and then binds them in
reverse order

         PF            NIXLF
        ---------------------
         SDP-VF0         0
         PF0             1

In this scenario, the PF0 unicast entry is getting corrupted because
the MCAM entry contains stale data (SDP-VF0 ucast data)

This patch resolves the issue by clearing the unicast MCAM entry during
NIXLF detach

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  6 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 40 +++++++++++++++++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 511eb5b2a2d4..19a5f0da4c7f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1393,8 +1393,6 @@ static void rvu_detach_block(struct rvu *rvu, int pcifunc, int blktype)
 	if (blkaddr < 0)
 		return;
 
-	if (blktype == BLKTYPE_NIX)
-		rvu_nix_reset_mac(pfvf, pcifunc);
 
 	block = &hw->block[blkaddr];
 
@@ -1407,6 +1405,10 @@ static void rvu_detach_block(struct rvu *rvu, int pcifunc, int blktype)
 		if (lf < 0) /* This should never happen */
 			continue;
 
+		if (blktype == BLKTYPE_NIX) {
+			rvu_nix_reset_mac(pfvf, pcifunc);
+			rvu_npc_clear_ucast_entry(rvu, pcifunc, lf);
+		}
 		/* Disable the LF */
 		rvu_write64(rvu, blkaddr, block->lfcfg_reg |
 			    (lf << block->lfshift), 0x00ULL);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 147d7f5c1fcc..48f66292ad5c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -994,6 +994,8 @@ void rvu_npc_get_mcam_entry_alloc_info(struct rvu *rvu, u16 pcifunc,
 void rvu_npc_get_mcam_counter_alloc_info(struct rvu *rvu, u16 pcifunc,
 					 int blkaddr, int *alloc_cnt,
 					 int *enable_cnt);
+void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf);
+
 bool is_npc_intf_tx(u8 intf);
 bool is_npc_intf_rx(u8 intf);
 bool is_npc_interface_valid(struct rvu *rvu, u8 intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 6296a3cdabbb..da15bb451178 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1107,6 +1107,7 @@ void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
 static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 				       int nixlf, bool enable)
 {
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int index, blkaddr;
 
@@ -1115,9 +1116,12 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
 		return;
 
 	/* Ucast MCAM match entry of this PF/VF */
-	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
-					 nixlf, NIXLF_UCAST_ENTRY);
-	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
+	if (npc_is_feature_supported(rvu, BIT_ULL(NPC_DMAC),
+				     pfvf->nix_rx_intf)) {
+		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
+						 nixlf, NIXLF_UCAST_ENTRY);
+		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
+	}
 
 	/* Nothing to do for VFs, on platforms where pkt replication
 	 * is not supported
@@ -3570,3 +3574,33 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 
 	return 0;
 }
+
+void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_npc_mcam_rule *rule;
+	int ucast_idx, blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return;
+
+	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
+					     nixlf, NIXLF_UCAST_ENTRY);
+
+	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
+
+	npc_set_mcam_action(rvu, mcam, blkaddr, ucast_idx, 0);
+
+	npc_clear_mcam_entry(rvu, mcam, blkaddr, ucast_idx);
+
+	mutex_lock(&mcam->lock);
+	list_for_each_entry(rule, &mcam->mcam_rules, list) {
+		if (rule->entry == ucast_idx) {
+			list_del(&rule->list);
+			kfree(rule);
+			break;
+		}
+	}
+	mutex_unlock(&mcam->lock);
+}
-- 
2.34.1


