Return-Path: <netdev+bounces-102641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF690411A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC7E282FA9
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D543D971;
	Tue, 11 Jun 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NzF7hYFF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789C3B2A2;
	Tue, 11 Jun 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122960; cv=none; b=cV41PpW7y+K5/CpLoaox66JoMm8rNec66jhgldIsNxwot6DbGPhhwPvvbpwFKRS4sqSBHfvkUvnMNFYbfc2nocaxW+qHJa0qQzvd2NsGUk89el33fpRrUyAdZx01SbzdsuPxWq8oVWISpf3OZHthpqanm76zICRfdAXmGs7Gyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122960; c=relaxed/simple;
	bh=BYxugKrD2AWuV/8kwaLMDYZYYZbUJbdF3RJcQ97KkUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0nBgfoixKrbs73R07E5P8dnTRAUYnFydkKbAr4jNC3JTG6hp4ua1jwRkQ1jYn7vw1/XjhS2eYBf+JXDVKS8ihnVwb5TKMTai12eAwii/N69Jfz2u8xZ9z2hA0wUuGBF6/GmKrUkxAfDrNuCMPVQ5FVqcAfoSQtaXem1CABvwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NzF7hYFF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BGJRin021185;
	Tue, 11 Jun 2024 09:22:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=iCWdnwlZFS5J8V+WmbQthHV9n
	emvLXQPxJQx3IhaBEw=; b=NzF7hYFFyR3nwyy81Gt66QXLo8PwINQm0W6TqpFSu
	zfQO9JYb3t4yIIdV5NI6eVvzXL20JU9YCiUFL45daxRZbVZBrRI3RCbFyMsN5/CO
	W2SlLw35CGewJJRpKP5QIqBE5UDZggm6zms2X7MbzHb7T2PMe2qPiwKIWjHeoPf3
	cPcjqIzOqnsIpBhdB52+DeP+2VbND7OVUj/yBZ/zJGyZQ9pMdOBfG3ZzkgVxXh+S
	YFf/WCUfTO0ix5n2AN+5S5qYKiASD9w3tIHhg9NQ2hVeuZdp+ufXP5R4qZj48MhT
	NLoFeAPyzzUPvtcfVChH/R1yb4WgWXwq0VW2/50UjudRA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ypmq0hcsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:22:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Jun 2024 09:22:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Jun 2024 09:22:21 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 666393F7059;
	Tue, 11 Jun 2024 09:22:18 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v5 01/10] octeontx2-pf: Refactoring RVU driver
Date: Tue, 11 Jun 2024 21:52:04 +0530
Message-ID: <20240611162213.22213-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240611162213.22213-1-gakula@marvell.com>
References: <20240611162213.22213-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: UlRfAW7RurNzlarHgS0x-b7OsOFAokKJ
X-Proofpoint-ORIG-GUID: UlRfAW7RurNzlarHgS0x-b7OsOFAokKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01

Refactoring and export list of shared functions such that
they can be used by both RVU NIC and representor driver.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   9 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 --
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  43 ++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/af/rvu_struct.h         |  26 ++
 .../marvell/octeontx2/af/rvu_switch.c         |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  43 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 240 +++++++++++-------
 .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
 17 files changed, 258 insertions(+), 177 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 2436c1ff9ba4..46fbc8f2dce8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -155,9 +155,11 @@ enum nix_scheduler {
 /* Min/Max packet sizes, excluding FCS */
 #define	NIC_HW_MIN_FRS			40
 #define	NIC_HW_MAX_FRS			9212
+#define SDP_HW_MIN_FRS			16
 #define	SDP_HW_MAX_FRS			65535
 #define CN10K_LMAC_LINK_MAX_FRS		16380 /* 16k - FCS */
 #define CN10K_LBK_LINK_MAX_FRS		65535 /* 64k */
+#define SDP_LINK_CREDIT			0x320202
 
 /* NIX RX action operation*/
 #define NIX_RX_ACTIONOP_DROP		(0x0ull)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6fe2622..e6d7d6e862c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -78,6 +78,7 @@ struct otx2_mbox {
 struct mbox_hdr {
 	u64 msg_size;	/* Total msgs size embedded */
 	u16  num_msgs;   /* No of msgs embedded */
+	u16 sig;
 };
 
 /* Header which precedes every msg and is also part of it */
@@ -1562,6 +1563,7 @@ struct flow_msg {
 	u8 icmp_type;
 	u8 icmp_code;
 	__be16 tcp_flags;
+	u16 sq_id;
 };
 
 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index d883157393ea..a6533a9b8aa1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -245,6 +245,7 @@ enum key_fields {
 	NPC_VLAN_TAG2,
 	/* inner vlan tci for double tagged frame */
 	NPC_VLAN_TAG3,
+	NPC_SQ_ID,
 	/* other header fields programmed to extract but not of our interest */
 	NPC_UNKNOWN,
 	NPC_KEY_FIELDS_MAX,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251f92d4..ef6be6291057 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2151,6 +2151,14 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
 
+	if (req_hdr->sig) {
+		msg = mdev->mbase + offset;
+		writeq(0x1, rvu->pfreg_base +
+			((BLKADDR_NIX0 << 20) |
+			  NIX_LF_CINTX_INT_W1S(rvu_get_pf(msg->pcifunc))));
+		usleep_range(1000, 2000);
+		goto done;
+	}
 	for (id = 0; id < mw->mbox_wrk[devid].num_msgs; id++) {
 		msg = mdev->mbase + offset;
 
@@ -2184,6 +2192,7 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 				 err, otx2_mbox_id2name(msg->id),
 				 msg->id, devid);
 	}
+done:
 	mw->mbox_wrk[devid].num_msgs = 0;
 
 	if (poll)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 3063a84a45ef..30efa5607c58 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1016,6 +1016,7 @@ int rvu_ndc_fix_locked_cacheline(struct rvu *rvu, int blkaddr);
 void rvu_switch_enable(struct rvu *rvu);
 void rvu_switch_disable(struct rvu *rvu);
 void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc);
+void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool ena);
 
 int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
 			   u64 pkind, u8 var_len_off, u8 var_len_off_mask,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 4a4ef5bd9e0b..e661f83b188b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -45,33 +45,6 @@ enum {
 	CGX_STAT18,
 };
 
-/* NIX TX stats */
-enum nix_stat_lf_tx {
-	TX_UCAST	= 0x0,
-	TX_BCAST	= 0x1,
-	TX_MCAST	= 0x2,
-	TX_DROP		= 0x3,
-	TX_OCTS		= 0x4,
-	TX_STATS_ENUM_LAST,
-};
-
-/* NIX RX stats */
-enum nix_stat_lf_rx {
-	RX_OCTS		= 0x0,
-	RX_UCAST	= 0x1,
-	RX_BCAST	= 0x2,
-	RX_MCAST	= 0x3,
-	RX_DROP		= 0x4,
-	RX_DROP_OCTS	= 0x5,
-	RX_FCS		= 0x6,
-	RX_ERR		= 0x7,
-	RX_DRP_BCAST	= 0x8,
-	RX_DRP_MCAST	= 0x9,
-	RX_DRP_L3BCAST	= 0xa,
-	RX_DRP_L3MCAST	= 0xb,
-	RX_STATS_ENUM_LAST,
-};
-
 static char *cgx_rx_stats_fields[] = {
 	[CGX_STAT0]	= "Received packets",
 	[CGX_STAT1]	= "Octets of received packets",
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..b94ff8c75ffc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -289,6 +289,23 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
 		dev_err(rvu->dev, "SYNC2: NIX RX software sync failed\n");
 }
 
+static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	int pf = rvu_get_pf(pcifunc);
+	u8 cgx_id = 0, lmac_id = 0;
+
+	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
+		return hw->cgx_links;
+	} else if (is_pf_cgxmapped(rvu, pf)) {
+		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+		return (cgx_id * hw->lmac_per_cgx) + lmac_id;
+	}
+
+	/* SDP link */
+	return hw->cgx_links + hw->lbk_links;
+}
+
 static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 			    int lvl, u16 pcifunc, u16 schq)
 {
@@ -584,6 +601,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
 		return 0;
 
+	if (is_sdp_pfvf(pcifunc))
+		type = NIX_INTF_TYPE_SDP;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
 	if (err)
@@ -1984,23 +2004,6 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
 	rvu_write64(rvu, blkaddr, reg, 0x0);
 }
 
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
-{
-	struct rvu_hwinfo *hw = rvu->hw;
-	int pf = rvu_get_pf(pcifunc);
-	u8 cgx_id = 0, lmac_id = 0;
-
-	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
-		return hw->cgx_links;
-	} else if (is_pf_cgxmapped(rvu, pf)) {
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-		return (cgx_id * hw->lmac_per_cgx) + lmac_id;
-	}
-
-	/* SDP link */
-	return hw->cgx_links + hw->lbk_links;
-}
-
 static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
 				 int link, int *start, int *end)
 {
@@ -2949,6 +2952,7 @@ static int nix_tx_vtag_alloc(struct rvu *rvu, int blkaddr,
 	mutex_unlock(&vlan->rsrc_lock);
 
 	regval = size ? vtag : vtag << 32;
+	regval |= (vtag & ~GENMASK_ULL(47, 0)) << 48;
 
 	rvu_write64(rvu, blkaddr,
 		    NIX_AF_TX_VTAG_DEFX_DATA(index), regval);
@@ -4619,6 +4623,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 	rvu_get_lbk_link_max_frs(rvu, &lbk_max_frs);
 	rvu_get_lmac_link_max_frs(rvu, &lmac_max_frs);
 
+	rvu_write64(rvu, blkaddr, NIX_AF_SDP_LINK_CREDIT, SDP_LINK_CREDIT);
 	/* Set default min/max packet lengths allowed on NIX Rx links.
 	 *
 	 * With HW reset minlen value of 60byte, HW will treat ARP pkts
@@ -4630,14 +4635,14 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 				((u64)lmac_max_frs << 16) | NIC_HW_MIN_FRS);
 	}
 
-	for (link = hw->cgx_links; link < hw->lbk_links; link++) {
+	for (link = hw->cgx_links; link < hw->cgx_links + hw->lbk_links; link++) {
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link),
 			    ((u64)lbk_max_frs << 16) | NIC_HW_MIN_FRS);
 	}
 	if (hw->sdp_links) {
 		link = hw->cgx_links + hw->lbk_links;
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link),
-			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
+			    SDP_HW_MAX_FRS << 16 | SDP_HW_MIN_FRS);
 	}
 
 	/* Get MCS external bypass status for CN10K-B */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 150635de2bd5..9fa06ec21ad1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -555,6 +555,7 @@ do {									       \
 	NPC_SCAN_HDR(NPC_SMAC, NPC_LID_LA, la_ltype, la_start + 6, 6);
 	/* PF_FUNC is 2 bytes at 0th byte of NPC_LT_LA_IH_NIX_ETHER */
 	NPC_SCAN_HDR(NPC_PF_FUNC, NPC_LID_LA, NPC_LT_LA_IH_NIX_ETHER, 0, 2);
+	NPC_SCAN_HDR(NPC_SQ_ID, NPC_LID_LA, NPC_LT_LA_IH_NIX_ETHER, 2, 3);
 }
 
 static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
@@ -1225,6 +1226,10 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	npc_update_entry(rvu, NPC_PF_FUNC, entry, (__force u16)htons(target),
 			 0, mask, 0, NIX_INTF_TX);
 
+	npc_update_entry(rvu, NPC_SQ_ID, entry,
+			 (__force u16)htons(req->packet.sq_id),
+			 0, req->mask.sq_id, 0, NIX_INTF_TX);
+
 	*(u64 *)&action = 0x00;
 	action.op = req->op;
 	action.index = req->index;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 5ec92654e7ad..95c332a1fc70 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -431,6 +431,7 @@
 #define NIX_AF_MDQX_IN_MD_COUNT(a)	(0x14e0 | (a) << 16)
 #define NIX_AF_SMQX_STATUS(a)		(0x730 | (a) << 16)
 #define NIX_AF_MDQX_OUT_MD_COUNT(a)	(0xdb0 | (a) << 16)
+#define NIX_LF_CINTX_INT_W1S(a)		(0xd30 | (a) << 12)
 
 #define NIX_PRIV_AF_INT_CFG		(0x8000000)
 #define NIX_PRIV_LFX_CFG		(0x8000010)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 5ef406c7e8a4..ee54f1694ea6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -825,4 +825,30 @@ enum nix_tx_vtag_op {
 #define VTAG_STRIP	BIT_ULL(4)
 #define VTAG_CAPTURE	BIT_ULL(5)
 
+/* NIX TX stats */
+enum nix_stat_lf_tx {
+	TX_UCAST	= 0x0,
+	TX_BCAST	= 0x1,
+	TX_MCAST	= 0x2,
+	TX_DROP		= 0x3,
+	TX_OCTS		= 0x4,
+	TX_STATS_ENUM_LAST,
+};
+
+/* NIX RX stats */
+enum nix_stat_lf_rx {
+	RX_OCTS		= 0x0,
+	RX_UCAST	= 0x1,
+	RX_BCAST	= 0x2,
+	RX_MCAST	= 0x3,
+	RX_DROP		= 0x4,
+	RX_DROP_OCTS	= 0x5,
+	RX_FCS		= 0x6,
+	RX_ERR		= 0x7,
+	RX_DRP_BCAST	= 0x8,
+	RX_DRP_MCAST	= 0x9,
+	RX_DRP_L3BCAST	= 0xa,
+	RX_DRP_L3MCAST	= 0xb,
+	RX_STATS_ENUM_LAST,
+};
 #endif /* RVU_STRUCT_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index 854045ed3b06..ceb81eebf65e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -8,7 +8,7 @@
 #include <linux/bitfield.h>
 #include "rvu.h"
 
-static void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
+void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct nix_hw *nix_hw;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a85ac039d779..4b53af087cb4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -227,7 +227,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 	u16 maxlen;
 	int err;
 
-	maxlen = otx2_get_max_mtu(pfvf) + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
+	maxlen = pfvf->hw.max_mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
 
 	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_nix_set_hw_frs(&pfvf->mbox);
@@ -236,7 +236,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 		return -ENOMEM;
 	}
 
-	req->maxlen = pfvf->netdev->mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
+	req->maxlen = mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
 
 	/* Use max receive length supported by hardware for loopback devices */
 	if (is_otx2_lbkvf(pfvf->pdev))
@@ -246,6 +246,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_hw_set_mtu);
 
 int otx2_config_pause_frm(struct otx2_nic *pfvf)
 {
@@ -1782,6 +1783,7 @@ void otx2_free_cints(struct otx2_nic *pfvf, int n)
 		free_irq(vector, &qset->napi[qidx]);
 	}
 }
+EXPORT_SYMBOL(otx2_free_cints);
 
 void otx2_set_cints_affinity(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 24fbbef265a6..3072648f478c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -120,33 +120,6 @@ enum otx2_errcodes_re {
 	ERRCODE_IL4_CSUM = 0x22,
 };
 
-/* NIX TX stats */
-enum nix_stat_lf_tx {
-	TX_UCAST	= 0x0,
-	TX_BCAST	= 0x1,
-	TX_MCAST	= 0x2,
-	TX_DROP		= 0x3,
-	TX_OCTS		= 0x4,
-	TX_STATS_ENUM_LAST,
-};
-
-/* NIX RX stats */
-enum nix_stat_lf_rx {
-	RX_OCTS		= 0x0,
-	RX_UCAST	= 0x1,
-	RX_BCAST	= 0x2,
-	RX_MCAST	= 0x3,
-	RX_DROP		= 0x4,
-	RX_DROP_OCTS	= 0x5,
-	RX_FCS		= 0x6,
-	RX_ERR		= 0x7,
-	RX_DRP_BCAST	= 0x8,
-	RX_DRP_MCAST	= 0x9,
-	RX_DRP_L3BCAST	= 0xa,
-	RX_DRP_L3MCAST	= 0xb,
-	RX_STATS_ENUM_LAST,
-};
-
 struct otx2_dev_stats {
 	u64 rx_bytes;
 	u64 rx_frames;
@@ -228,6 +201,7 @@ struct otx2_hw {
 	u16			txschq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16			matchall_ipolicer;
 	u32			dwrr_mtu;
+	u32			max_mtu;
 	u8			smq_link_type;
 
 	/* HW settings, coalescing etc */
@@ -999,6 +973,21 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 		   int pool_id, int numptrs);
 
+int otx2_init_hw_resources(struct otx2_nic *pfvf);
+void otx2_free_hw_resources(struct otx2_nic *pf);
+int otx2_wq_init(struct otx2_nic *pf);
+int otx2_check_pf_usable(struct otx2_nic *pf);
+int otx2_pfaf_mbox_init(struct otx2_nic *pf);
+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af);
+int otx2_realloc_msix_vectors(struct otx2_nic *pf);
+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf);
+void otx2_disable_mbox_intr(struct otx2_nic *pf);
+void otx2_free_queue_mem(struct otx2_qset *qset);
+int otx2_alloc_queue_mem(struct otx2_nic *pf);
+void otx2_disable_napi(struct otx2_nic *pf);
+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
+int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
+
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
 int otx2_set_flowkey_cfg(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f5bce3e326cc..9d16019cfaab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1008,7 +1008,7 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 	return IRQ_HANDLED;
 }
 
-static void otx2_disable_mbox_intr(struct otx2_nic *pf)
+void otx2_disable_mbox_intr(struct otx2_nic *pf)
 {
 	int vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
 
@@ -1016,8 +1016,9 @@ static void otx2_disable_mbox_intr(struct otx2_nic *pf)
 	otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
 	free_irq(vector, pf);
 }
+EXPORT_SYMBOL(otx2_disable_mbox_intr);
 
-static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 {
 	struct otx2_hw *hw = &pf->hw;
 	struct msg_req *req;
@@ -1060,8 +1061,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_register_mbox_intr);
 
-static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 
@@ -1076,8 +1078,9 @@ static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 	otx2_mbox_destroy(&mbox->mbox);
 	otx2_mbox_destroy(&mbox->mbox_up);
 }
+EXPORT_SYMBOL(otx2_pfaf_mbox_destroy);
 
-static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
+int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 	void __iomem *hwbase;
@@ -1124,6 +1127,7 @@ static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 	otx2_pfaf_mbox_destroy(pf);
 	return err;
 }
+EXPORT_SYMBOL(otx2_pfaf_mbox_init);
 
 static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
 {
@@ -1379,7 +1383,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 {
 	struct otx2_cq_poll *cq_poll = (struct otx2_cq_poll *)cq_irq;
 	struct otx2_nic *pf = (struct otx2_nic *)cq_poll->dev;
@@ -1398,20 +1402,25 @@ static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(otx2_cq_intr_handler);
 
-static void otx2_disable_napi(struct otx2_nic *pf)
+void otx2_disable_napi(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
 	struct otx2_cq_poll *cq_poll;
+	struct work_struct *work;
 	int qidx;
 
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
-		cancel_work_sync(&cq_poll->dim.work);
+		work = &cq_poll->dim.work;
+		if (work->func)
+			cancel_work_sync(&cq_poll->dim.work);
 		napi_disable(&cq_poll->napi);
 		netif_napi_del(&cq_poll->napi);
 	}
 }
+EXPORT_SYMBOL(otx2_disable_napi);
 
 static void otx2_free_cq_res(struct otx2_nic *pf)
 {
@@ -1477,7 +1486,7 @@ static int otx2_get_rbuf_size(struct otx2_nic *pf, int mtu)
 	return ALIGN(rbuf_size, 2048);
 }
 
-static int otx2_init_hw_resources(struct otx2_nic *pf)
+int otx2_init_hw_resources(struct otx2_nic *pf)
 {
 	struct nix_lf_free_req *free_req;
 	struct mbox *mbox = &pf->mbox;
@@ -1601,8 +1610,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_init_hw_resources);
 
-static void otx2_free_hw_resources(struct otx2_nic *pf)
+void otx2_free_hw_resources(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
 	struct nix_lf_free_req *free_req;
@@ -1688,6 +1698,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	}
 	mutex_unlock(&mbox->lock);
 }
+EXPORT_SYMBOL(otx2_free_hw_resources);
 
 static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
 {
@@ -1770,15 +1781,23 @@ static void otx2_dim_work(struct work_struct *w)
 	dim->state = DIM_START_MEASURE;
 }
 
-int otx2_open(struct net_device *netdev)
+void otx2_free_queue_mem(struct otx2_qset *qset)
+{
+	kfree(qset->sq);
+	qset->sq = NULL;
+	kfree(qset->cq);
+	qset->cq = NULL;
+	kfree(qset->rq);
+	qset->rq = NULL;
+	kfree(qset->napi);
+}
+EXPORT_SYMBOL(otx2_free_queue_mem);
+int otx2_alloc_queue_mem(struct otx2_nic *pf)
 {
-	struct otx2_nic *pf = netdev_priv(netdev);
-	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
-	int err = 0, qidx, vec;
-	char *irq_name;
+	struct otx2_cq_poll *cq_poll;
+	int err = -ENOMEM;
 
-	netif_carrier_off(netdev);
 
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
@@ -1791,14 +1810,13 @@ int otx2_open(struct net_device *netdev)
 
 	qset->napi = kcalloc(pf->hw.cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
 	if (!qset->napi)
-		return -ENOMEM;
+		return err;
 
 	/* CQ size of RQ */
 	qset->rqe_cnt = qset->rqe_cnt ? qset->rqe_cnt : Q_COUNT(Q_SIZE_256);
 	/* CQ size of SQ */
 	qset->sqe_cnt = qset->sqe_cnt ? qset->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 
-	err = -ENOMEM;
 	qset->cq = kcalloc(pf->qset.cq_cnt,
 			   sizeof(struct otx2_cq_queue), GFP_KERNEL);
 	if (!qset->cq)
@@ -1814,6 +1832,28 @@ int otx2_open(struct net_device *netdev)
 	if (!qset->rq)
 		goto err_free_mem;
 
+	return 0;
+
+err_free_mem:
+	otx2_free_queue_mem(qset);
+	return err;
+}
+EXPORT_SYMBOL(otx2_alloc_queue_mem);
+
+int otx2_open(struct net_device *netdev)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &pf->qset;
+	int err = 0, qidx, vec;
+	char *irq_name;
+
+	netif_carrier_off(netdev);
+
+	err = otx2_alloc_queue_mem(pf);
+	if (err)
+		return err;
+
 	err = otx2_init_hw_resources(pf);
 	if (err)
 		goto err_free_mem;
@@ -1979,10 +2019,7 @@ int otx2_open(struct net_device *netdev)
 	otx2_disable_napi(pf);
 	otx2_free_hw_resources(pf);
 err_free_mem:
-	kfree(qset->sq);
-	kfree(qset->cq);
-	kfree(qset->rq);
-	kfree(qset->napi);
+	otx2_free_queue_mem(qset);
 	return err;
 }
 EXPORT_SYMBOL(otx2_open);
@@ -2047,11 +2084,8 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
+	otx2_free_queue_mem(qset);
 
-	kfree(qset->sq);
-	kfree(qset->cq);
-	kfree(qset->rq);
-	kfree(qset->napi);
 	/* Do not clear RQ/SQ ringsize settings */
 	memset_startat(qset, 0, sqe_cnt);
 	return 0;
@@ -2081,7 +2115,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &pf->qset.sq[sq_idx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(pf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
@@ -2786,7 +2820,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
 };
 
-static int otx2_wq_init(struct otx2_nic *pf)
+int otx2_wq_init(struct otx2_nic *pf)
 {
 	pf->otx2_wq = create_singlethread_workqueue("otx2_wq");
 	if (!pf->otx2_wq)
@@ -2797,7 +2831,7 @@ static int otx2_wq_init(struct otx2_nic *pf)
 	return 0;
 }
 
-static int otx2_check_pf_usable(struct otx2_nic *nic)
+int otx2_check_pf_usable(struct otx2_nic *nic)
 {
 	u64 rev;
 
@@ -2814,8 +2848,9 @@ static int otx2_check_pf_usable(struct otx2_nic *nic)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(otx2_check_pf_usable);
 
-static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
+int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 {
 	struct otx2_hw *hw = &pf->hw;
 	int num_vec, err;
@@ -2837,6 +2872,7 @@ static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 
 	return otx2_register_mbox_intr(pf, false);
 }
+EXPORT_SYMBOL(otx2_realloc_msix_vectors);
 
 static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 {
@@ -2872,6 +2908,88 @@ static void otx2_sriov_vfcfg_cleanup(struct otx2_nic *pf)
 	}
 }
 
+int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
+{
+	struct device *dev = &pdev->dev;
+	struct otx2_hw *hw = &pf->hw;
+	int num_vec, err;
+
+	num_vec = pci_msix_vec_count(pdev);
+	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
+					  GFP_KERNEL);
+	if (!hw->irq_name)
+		return -ENOMEM;
+
+	hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
+					 sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!hw->affinity_mask)
+		return -ENOMEM;
+
+	/* Map CSRs */
+	pf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
+	if (!pf->reg_base) {
+		dev_err(dev, "Unable to map physical function CSRs, aborting\n");
+		return -ENOMEM;
+	}
+
+	err = otx2_check_pf_usable(pf);
+	if (err)
+		return err;
+
+	err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
+				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
+			__func__, num_vec);
+		return err;
+	}
+
+	otx2_setup_dev_hw_settings(pf);
+
+	/* Init PF <=> AF mailbox stuff */
+	err = otx2_pfaf_mbox_init(pf);
+	if (err)
+		goto err_free_irq_vectors;
+
+	/* Register mailbox interrupt */
+	err = otx2_register_mbox_intr(pf, true);
+	if (err)
+		goto err_mbox_destroy;
+
+	/* Request AF to attach NPA and NIX LFs to this PF.
+	 * NIX and NPA LFs are needed for this PF to function as a NIC.
+	 */
+	err = otx2_attach_npa_nix(pf);
+	if (err)
+		goto err_disable_mbox_intr;
+
+	err = otx2_realloc_msix_vectors(pf);
+	if (err)
+		goto err_detach_rsrc;
+
+	err = cn10k_lmtst_init(pf);
+	if (err)
+		goto err_detach_rsrc;
+
+	return 0;
+
+err_detach_rsrc:
+	if (pf->hw.lmt_info)
+		free_percpu(pf->hw.lmt_info);
+	if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
+		qmem_free(pf->dev, pf->dync_lmt);
+	otx2_detach_resources(&pf->mbox);
+err_disable_mbox_intr:
+	otx2_disable_mbox_intr(pf);
+err_mbox_destroy:
+	otx2_pfaf_mbox_destroy(pf);
+err_free_irq_vectors:
+	pci_free_irq_vectors(hw->pdev);
+
+	return err;
+}
+EXPORT_SYMBOL(otx2_init_rsrc);
+
 static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -2879,7 +2997,6 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct net_device *netdev;
 	struct otx2_nic *pf;
 	struct otx2_hw *hw;
-	int num_vec;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -2930,71 +3047,14 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Use CQE of 128 byte descriptor size by default */
 	hw->xqe_size = 128;
 
-	num_vec = pci_msix_vec_count(pdev);
-	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
-					  GFP_KERNEL);
-	if (!hw->irq_name) {
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
-					 sizeof(cpumask_var_t), GFP_KERNEL);
-	if (!hw->affinity_mask) {
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	/* Map CSRs */
-	pf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
-	if (!pf->reg_base) {
-		dev_err(dev, "Unable to map physical function CSRs, aborting\n");
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	err = otx2_check_pf_usable(pf);
+	err = otx2_init_rsrc(pdev, pf);
 	if (err)
 		goto err_free_netdev;
 
-	err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
-				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
-	if (err < 0) {
-		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
-			__func__, num_vec);
-		goto err_free_netdev;
-	}
-
-	otx2_setup_dev_hw_settings(pf);
-
-	/* Init PF <=> AF mailbox stuff */
-	err = otx2_pfaf_mbox_init(pf);
-	if (err)
-		goto err_free_irq_vectors;
-
-	/* Register mailbox interrupt */
-	err = otx2_register_mbox_intr(pf, true);
-	if (err)
-		goto err_mbox_destroy;
-
-	/* Request AF to attach NPA and NIX LFs to this PF.
-	 * NIX and NPA LFs are needed for this PF to function as a NIC.
-	 */
-	err = otx2_attach_npa_nix(pf);
-	if (err)
-		goto err_disable_mbox_intr;
-
-	err = otx2_realloc_msix_vectors(pf);
-	if (err)
-		goto err_detach_rsrc;
-
 	err = otx2_set_real_num_queues(netdev, hw->tx_queues, hw->rx_queues);
 	if (err)
 		goto err_detach_rsrc;
 
-	err = cn10k_lmtst_init(pf);
-	if (err)
-		goto err_detach_rsrc;
 
 	/* Assign default mac address */
 	otx2_get_mac_from_af(netdev);
@@ -3058,6 +3118,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
+	hw->max_mtu = netdev->max_mtu;
 
 	/* reset CGX/RPM MAC stats */
 	otx2_reset_mac_stats(pf);
@@ -3118,11 +3179,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
 		qmem_free(pf->dev, pf->dync_lmt);
 	otx2_detach_resources(&pf->mbox);
-err_disable_mbox_intr:
 	otx2_disable_mbox_intr(pf);
-err_mbox_destroy:
 	otx2_pfaf_mbox_destroy(pf);
-err_free_irq_vectors:
 	pci_free_irq_vectors(hw->pdev);
 err_free_netdev:
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index a16e9f244117..aad467aa94a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -131,6 +131,7 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 }
 
 static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
+				 struct net_device *ndev,
 				 struct otx2_cq_queue *cq,
 				 struct otx2_snd_queue *sq,
 				 struct nix_cqe_tx_s *cqe,
@@ -145,7 +146,7 @@ static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
 
 	if (unlikely(snd_comp->status) && netif_msg_tx_err(pfvf))
 		net_err_ratelimited("%s: TX%d: Error in send CQ status:%x\n",
-				    pfvf->netdev->name, cq->cint_idx,
+				    ndev->name, cq->cint_idx,
 				    snd_comp->status);
 
 	sg = &sq->sg[snd_comp->sqe_id];
@@ -453,6 +454,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 	int tx_pkts = 0, tx_bytes = 0, qidx;
 	struct otx2_snd_queue *sq;
 	struct nix_cqe_tx_s *cqe;
+	struct net_device *ndev;
 	int processed_cqe = 0;
 
 	if (cq->pend_cqe >= budget)
@@ -464,6 +466,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 process_cqe:
 	qidx = cq->cq_idx - pfvf->hw.rx_queues;
 	sq = &pfvf->qset.sq[qidx];
+	ndev = pfvf->netdev;
 
 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
 		cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
@@ -478,7 +481,8 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		if (cq->cq_type == CQ_XDP)
 			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe);
 		else
-			otx2_snd_pkt_handler(pfvf, cq, &pfvf->qset.sq[qidx],
+			otx2_snd_pkt_handler(pfvf, ndev, cq,
+					     &pfvf->qset.sq[qidx],
 					     cqe, budget, &tx_pkts, &tx_bytes);
 
 		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
@@ -505,7 +509,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		/* Check if queue was stopped earlier due to ring full */
 		smp_mb();
 		if (netif_tx_queue_stopped(txq) &&
-		    netif_carrier_ok(pfvf->netdev))
+		    netif_carrier_ok(ndev))
 			netif_tx_wake_queue(txq);
 	}
 	return 0;
@@ -594,6 +598,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 	return workdone;
 }
+EXPORT_SYMBOL(otx2_napi_handler);
 
 void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		    int size, int qidx)
@@ -1141,13 +1146,13 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
 	}
 }
 
-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
+			struct otx2_snd_queue *sq,
 			struct sk_buff *skb, u16 qidx)
 {
-	struct netdev_queue *txq = netdev_get_tx_queue(netdev, qidx);
-	struct otx2_nic *pfvf = netdev_priv(netdev);
 	int offset, num_segs, free_desc;
 	struct nix_sqe_hdr_s *sqe_hdr;
+	struct otx2_nic *pfvf = dev;
 
 	/* Check if there is enough room between producer
 	 * and consumer index.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 3f1d2655ff77..e1db5f961877 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -167,7 +167,8 @@ static inline u64 otx2_iova_to_phys(void *iommu_domain, dma_addr_t dma_addr)
 }
 
 int otx2_napi_handler(struct napi_struct *napi, int budget);
-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
+			struct otx2_snd_queue *sq,
 			struct sk_buff *skb, u16 qidx);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		     int size, int qidx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 99fcc5661674..0486fca8b573 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -395,7 +395,7 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
@@ -500,7 +500,7 @@ static const struct net_device_ops otx2vf_netdev_ops = {
 	.ndo_setup_tc = otx2_setup_tc,
 };
 
-static int otx2_wq_init(struct otx2_nic *vf)
+static int otx2_vf_wq_init(struct otx2_nic *vf)
 {
 	vf->otx2_wq = create_singlethread_workqueue("otx2vf_wq");
 	if (!vf->otx2_wq)
@@ -671,6 +671,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(vf);
+	hw->max_mtu = netdev->max_mtu;
 
 	/* To distinguish, for LBK VFs set netdev name explicitly */
 	if (is_otx2_lbkvf(vf->pdev)) {
@@ -688,7 +689,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_ptp_destroy;
 	}
 
-	err = otx2_wq_init(vf);
+	err = otx2_vf_wq_init(vf);
 	if (err)
 		goto err_unreg_netdev;
 
-- 
2.25.1


