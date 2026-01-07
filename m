Return-Path: <netdev+bounces-247577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF23CFBE13
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F67B30E82F4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988026B973;
	Wed,  7 Jan 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ERYafT0g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3226560D;
	Wed,  7 Jan 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757171; cv=none; b=m8U4xSlIqhrAX1RfST0NqxyTxtIYHce668KWTGUDIjf/Oqj+3prGcVqQI7p2hkaqCrz4NzTLv7pI4XQP+XAxpfnMjHCo/9kFYRfmmFpgwxFwHHtT540b/MwpPYeN8JLhCLQ8q97EYvZRsx35PkU2mTFOWZZSdt1yXMaPYwVUIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757171; c=relaxed/simple;
	bh=KAOznG3a5OgvS63LYugiBkB/bZU9jlMSeEHp6jMlNa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWC/45rw0BtV3qm1u14cWVXHizPMThHo3gDVfux9fMJJq/qrUNlXKGrt4TZ2pTG51wiKr9MkQUxAKT8ylNiT4nZ5MRQHxQwI96pVI5Rae+e2I8r1Cm8Pt/Nh9YlxFo+Ua+CAWeYC4xpx+FfJ2aTMIn8RXNjxiUdbEDUE5YeboYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ERYafT0g; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6070x4NM2795652;
	Tue, 6 Jan 2026 19:39:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	AoTspAz6YeOHma1R3/21oANAAzUA5zBUmK16hf8Gyo=; b=ERYafT0giAKfKsbwx
	18VJrHFTrnYMATy8isUtvF9zXkkf0ED92tXj9Vvzr3mEU/ORA9GisQn+AXTtQ+0j
	7VheDxZCLaJYwwF4+EerodmFxIs4ZOPiqc9Kus48QN4dV/+xHB7KhASmuGAKfjoP
	9q7vZ95QfHcs1AZE+UynLNRyxaCiaiDkwvO/5PR/Ja+PQpr6UWMMwA0mOMOaQKdj
	0bqjqktTI2QU7t9OmNXmbFFbu4O8FTtAoNxYkfFazJem37UevX+P/YAsl3uus7LT
	2m69HaJ0U3Q7PatDO878rGjualYZEtmxlFXdimOnYLtOO/yd2Qa0i12kP5Uk9F0b
	tFGAg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fv204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 19:39:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 19:39:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 19:39:17 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 87D023F704F;
	Tue,  6 Jan 2026 19:39:14 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v2 06/13] octeontx2-af: npc: cn20k: Use common APIs
Date: Wed, 7 Jan 2026 09:08:37 +0530
Message-ID: <20260107033844.437026-7-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107033844.437026-1-rkannoth@marvell.com>
References: <20260107033844.437026-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695dd566 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=YiITfu5hDICovFRBzmQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNyBTYWx0ZWRfXy1ihiGv10R74
 SHOQ763ZOJzp0o67Y/sx6cVD2HFQ238AG2NsB0XFSxoqQI86rje9I4CdGxW6xCWilnyuwizitw3
 xQdXpMZv3niDX92BqPQG4EFubOufDdT2PYrYJfgp/C9/WtVGbVVqI5YkI6mumwWIckraTPcW/qy
 5mtZQk+MCUaZI5EZcyteOpV+6yj5aDgWgB2N2iskyDkm6fiYGd1Zc8/FcYJCFZQs4ozfHsLdg9U
 fAmQ0DMIO0HV2eWEbR8RBt6qWNvTU+sShKhUY4DTDN8sLehdSY7GQ3N4iqaufCHD065N9ZYhLyj
 vpXtNW5w12RVZwMoyRMvYJMOka95esDoBb2DSJUoDySDvi1uYPJgc4L94/4P5xUIN3wylMdrx+u
 XDAOrBmK/qppaimVXkMQffRwONWg+fzANc884vGsbLmqWF8e8a9knU6A4TZ78QSohNdLH3wRHBk
 tUtOGyfJGzBre4L05Xw==
X-Proofpoint-GUID: WXpZwPxWXNBrdtQ-dkB2YchULfXPBj91
X-Proofpoint-ORIG-GUID: WXpZwPxWXNBrdtQ-dkB2YchULfXPBj91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

In cn20k silicon, the register definitions and the algorithms used to
read, write, copy, and enable MCAM entries have changed. This patch
updates the common APIs to support both cn20k and previous silicon
variants.

Additionally, cn20k introduces a new algorithm for MCAM index management.
The common APIs are updated to invoke the cn20k-specific index management
routines for allocating, freeing, and retrieving default MCAM entries.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 473 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  15 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   1 -
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 290 ++++++++---
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  11 +-
 7 files changed, 725 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 4a9cbe0cb2d5..638fb2027ea9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -447,7 +447,8 @@ static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
 
 	/* Program EXTRACTOR */
 	for (extr = 0; extr < num_extr; extr++)
-		rvu_write64(rvu, blkaddr, NPC_AF_INTFX_EXTRACTORX_CFG(intf, extr),
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_INTFX_EXTRACTORX_CFG(intf, extr),
 			    mkex_extr->intf_extr_lid[intf][extr]);
 
 	/* Program EXTRACTOR_LTYPE */
@@ -518,10 +519,12 @@ void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
 
 	mcam_kex_extr = (struct npc_mcam_kex_extr __force *)mkex_prfl_addr;
 
-	while (((s64)prfl_sz > 0) && (mcam_kex_extr->mkex_sign != MKEX_END_SIGN)) {
+	while (((s64)prfl_sz > 0) && (mcam_kex_extr->mkex_sign !=
+				      MKEX_END_SIGN)) {
 		/* Compare with mkex mod_param name string */
 		if (mcam_kex_extr->mkex_sign == MKEX_CN20K_SIGN &&
-		    !strncmp(mcam_kex_extr->name, mkex_profile, MKEX_NAME_LEN)) {
+		    !strncmp(mcam_kex_extr->name, mkex_profile,
+			     MKEX_NAME_LEN)) {
 			rvu->kpu.mcam_kex_prfl.mkex_extr = mcam_kex_extr;
 			goto program_mkex_extr;
 		}
@@ -532,13 +535,433 @@ void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
 	dev_warn(dev, "Failed to load requested profile: %s\n", mkex_profile);
 
 program_mkex_extr:
-	dev_info(rvu->dev, "Using %s mkex profile\n", rvu->kpu.mcam_kex_prfl.mkex_extr->name);
+	dev_info(rvu->dev, "Using %s mkex profile\n",
+		 rvu->kpu.mcam_kex_prfl.mkex_extr->name);
 	/* Program selected mkex profile */
-	npc_program_mkex_profile(rvu, blkaddr, rvu->kpu.mcam_kex_prfl.mkex_extr);
+	npc_program_mkex_profile(rvu, blkaddr,
+				 rvu->kpu.mcam_kex_prfl.mkex_extr);
 	if (mkex_prfl_addr)
 		iounmap(mkex_prfl_addr);
 }
 
+void
+npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
+			    int index, bool enable)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int mcam_idx = index % mcam->banksize;
+	int bank = index / mcam->banksize;
+	u64 cfg, hw_prio;
+	u8 kw_type;
+
+	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank));
+		hw_prio = cfg & GENMASK_ULL(14, 8);
+		cfg = enable ? 1 : 0;
+		cfg |= hw_prio;
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    cfg);
+		return;
+	}
+
+	/* For NPC_CN20K_MCAM_KEY_X4 keys, both the banks
+	 * need to be programmed with the same value.
+	 */
+	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank));
+		hw_prio = cfg & GENMASK_ULL(14, 8);
+		cfg = enable ? 1 : 0;
+		cfg |= hw_prio;
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    cfg);
+	}
+}
+
+void
+npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr, int bank, int index)
+{
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 1),
+		    0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 0),
+		    0);
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 1), 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 0), 0);
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 1), 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 0), 0);
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 1), 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 0), 0);
+
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1), 0);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0), 0);
+}
+
+static void npc_cn20k_get_keyword(struct mcam_entry *entry, int idx,
+				  u64 *cam0, u64 *cam1)
+{
+	u64 kw_mask;
+
+	/* The two banks of every MCAM entry are used as a single double-wide entry that
+	 * is compared with the search key as follows:
+	 *
+	 * NPC_AF_MCAME()_BANK(0)_CAM(0..1)_W0_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW0]
+	 * NPC_AF_MCAME()_BANK(0)_CAM(0..1)_W1_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW1]
+	 * NPC_AF_MCAME()_BANK(0)_CAM(0..1)_W2_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW2]
+	 * NPC_AF_MCAME()_BANK(0)_CAM(0..1)_W3_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW3]
+	 * NPC_AF_MCAME()_BANK(1)_CAM(0..1)_W0_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW4]
+	 * NPC_AF_MCAME()_BANK(1)_CAM(0..1)_W1_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW5]
+	 * NPC_AF_MCAME()_BANK(1)_CAM(0..1)_W2_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW6]
+	 * NPC_AF_MCAME()_BANK(1)_CAM(0..1)_W3_EXT[MD] corresponds to NPC_MCAM_KEY_X4_S[KW7]
+	 */
+	*cam1 = entry->kw[idx];
+	kw_mask = entry->kw_mask[idx];
+	*cam1 &= kw_mask;
+	*cam0 = ~*cam1 & kw_mask;
+}
+
+static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
+				   int blkaddr, int index, u8 intf,
+				   struct mcam_entry *entry,
+				   int bank, u8 kw_type, int kw)
+{
+	u64 intf_ext = 0, intf_ext_mask = 0;
+	u8 tx_intf_mask = ~intf & 0x3;
+	u8 tx_intf = intf, kex_type;
+	u8 kw_type_mask = ~kw_type;
+	u64 cam0, cam1, kex_cfg;
+
+	if (is_npc_intf_tx(intf)) {
+		/* Last bit must be set and rest don't care
+		 * for TX interfaces
+		 */
+		tx_intf_mask = 0x1;
+		tx_intf = intf & tx_intf_mask;
+		tx_intf_mask = ~tx_intf & tx_intf_mask;
+	}
+
+	kex_cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf));
+	kex_type = (kex_cfg & GENMASK_ULL(34, 32)) >> 32;
+	/*-------------------------------------------------------------------------------------|
+	 *	Kex type    |  mcam entry   |  cam1	   |	cam 0	|| <----- output ----> |
+	 *	in profile  |  len	    | (key type)   | (key type)	|| len	  |   type     |
+	 *-------------------------------------------------------------------------------------|
+	 *	X2	    |  256 (X2)	    |  001b	   |	110b	|| X2	  |    X2      |
+	 *-------------------------------------------------------------------------------------|
+	 *	X4	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
+	 *-------------------------------------------------------------------------------------|
+	 *	X4	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
+	 *-------------------------------------------------------------------------------------|
+	 *    DYNAMIC	    |  256 (X2)	    |  000b	   |	000b	|| X2	  |  DYNAMIC   |
+	 *-------------------------------------------------------------------------------------|
+	 *    DYNAMIC	    |  512 (X4)	    |  010b	   |	101b	|| X4	  |    X4      |
+	 *-------------------------------------------------------------------------------------|
+	 */
+	if ((kex_type == NPC_MCAM_KEY_DYN || kex_type == NPC_MCAM_KEY_X4) &&
+	    kw_type == NPC_MCAM_KEY_X2) {
+		kw_type = 0;
+		kw_type_mask = 0;
+	}
+
+	intf_ext = ((u64)kw_type << 16) | tx_intf;
+	intf_ext_mask = (((u64)kw_type_mask  << 16) & GENMASK_ULL(18, 16)) |
+		tx_intf_mask;
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 1),
+		    intf_ext);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 0),
+		    intf_ext_mask);
+
+	/* Set the match key */
+	npc_cn20k_get_keyword(entry, kw, &cam0, &cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 1),
+		    cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 0),
+		    cam0);
+
+	npc_cn20k_get_keyword(entry, kw + 1, &cam0, &cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 1),
+		    cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 0),
+		    cam0);
+
+	npc_cn20k_get_keyword(entry, kw + 2, &cam0, &cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 1),
+		    cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 0),
+		    cam0);
+
+	npc_cn20k_get_keyword(entry, kw + 3, &cam0, &cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1),
+		    cam1);
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0),
+		    cam0);
+}
+
+static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
+				   int blkaddr, int index, u8 intf,
+				   struct mcam_entry *entry, u8 kw_type)
+{
+	int kw = 0, bank;
+
+	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4)
+		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
+				       index, intf,
+				       entry, bank, kw_type, kw);
+}
+
+static void
+npc_cn20k_set_mcam_bank_cfg(struct rvu *rvu, int blkaddr, int mcam_idx,
+			    int bank, u8 kw_type, bool enable, u8 hw_prio)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u64 bank_cfg;
+
+	bank_cfg = (u64)hw_prio << 8;
+	if (enable)
+		bank_cfg |= 0x1;
+
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    bank_cfg);
+		return;
+	}
+
+	/* For NPC_MCAM_KEY_X4 keys, both the banks
+	 * need to be programmed with the same value.
+	 */
+	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(mcam_idx, bank),
+			    bank_cfg);
+	}
+}
+
+void
+npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index, u8 intf,
+			    struct mcam_entry *entry, bool enable, u8 hw_prio)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int mcam_idx = index % mcam->banksize;
+	int bank = index / mcam->banksize;
+	int kw = 0;
+	u8 kw_type;
+
+	/* Disable before mcam entry update */
+	npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
+
+	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+	/* CAM1 takes the comparison value and
+	 * CAM0 specifies match for a bit in key being '0' or '1' or 'dontcare'.
+	 * CAM1<n> = 0 & CAM0<n> = 1 => match if key<n> = 0
+	 * CAM1<n> = 1 & CAM0<n> = 0 => match if key<n> = 1
+	 * CAM1<n> = 0 & CAM0<n> = 0 => always match i.e dontcare.
+	 */
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		/* Clear mcam entry to avoid writes being suppressed by NPC */
+		npc_cn20k_clear_mcam_entry(rvu, blkaddr, bank, mcam_idx);
+		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
+				       mcam_idx, intf, entry,
+				       bank, kw_type, kw);
+		/* Set 'action' */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx, bank, 0),
+			    entry->action);
+
+		/* Set TAG 'action' */
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx, bank, 1),
+			    entry->vtag_action);
+	} else {
+		/* Clear mcam entry to avoid writes being suppressed by NPC */
+		npc_cn20k_clear_mcam_entry(rvu, blkaddr, 0, mcam_idx);
+		npc_cn20k_clear_mcam_entry(rvu, blkaddr, 1, mcam_idx);
+
+		npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
+				       mcam_idx, intf, entry, kw_type);
+		for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+			/* Set 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx, bank, 0),
+				    entry->action);
+
+			/* Set TAG 'action' */
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx, bank, 1),
+				    entry->vtag_action);
+		}
+	}
+
+	/* TODO: */
+	/* PF installing VF rule */
+	npc_cn20k_set_mcam_bank_cfg(rvu, blkaddr, mcam_idx, bank,
+				    kw_type, enable, hw_prio);
+}
+
+void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u8 src_kwtype, dest_kwtype;
+	u64 cfg, sreg, dreg;
+	int dbank, sbank;
+	int bank, i;
+
+	dbank = npc_get_bank(mcam, dest);
+	sbank = npc_get_bank(mcam, src);
+	npc_mcam_idx_2_key_type(rvu, src, &src_kwtype);
+	npc_mcam_idx_2_key_type(rvu, dest, &dest_kwtype);
+	if (src_kwtype != dest_kwtype)
+		return;
+
+	src &= (mcam->banksize - 1);
+	dest &= (mcam->banksize - 1);
+
+	/* Copy INTF's, W0's, W1's, W2's, W3s CAM0 and CAM1 configuration */
+	for (bank = 0; bank < mcam->banks_per_entry; bank++) {
+		sreg = NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(src, sbank + bank, 0);
+		dreg = NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(dest, dbank + bank, 0);
+		for (i = 0; i < 10; i++) {
+			cfg = rvu_read64(rvu, blkaddr, sreg + (i * 8));
+			rvu_write64(rvu, blkaddr, dreg + (i * 8), cfg);
+		}
+
+		/* Copy action */
+		for (i = 0; i < 3; i++) {
+			cfg = rvu_read64(rvu, blkaddr,
+					 NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(src,
+									       sbank + bank,
+									       i));
+			rvu_write64(rvu, blkaddr,
+				    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(dest,
+									  dbank + bank,
+									  i), cfg);
+		}
+
+		/* Copy bank configuration */
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(src, sbank + bank));
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(dest, dbank + bank), cfg);
+		if (src_kwtype == NPC_MCAM_KEY_X2)
+			break;
+	}
+}
+
+static void npc_cn20k_fill_entryword(struct mcam_entry *entry, int idx,
+				     u64 cam0, u64 cam1)
+{
+	entry->kw[idx] = cam1;
+	entry->kw_mask[idx] = cam1 ^ cam0;
+}
+
+void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
+			       struct mcam_entry *entry, u8 *intf, u8 *ena,
+			       u8 *hw_prio)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int kw = 0, bank;
+	u64 cam0, cam1, bank_cfg;
+	u8 kw_type;
+
+	npc_mcam_idx_2_key_type(rvu, index, &kw_type);
+
+	bank = npc_get_bank(mcam, index);
+	index &= (mcam->banksize - 1);
+	*intf = rvu_read64(rvu, blkaddr,
+			   NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(index, bank, 1)) & 3;
+	bank_cfg = rvu_read64(rvu, blkaddr,
+			      NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(index, bank));
+	*ena = bank_cfg & 0x1;
+	*hw_prio = (bank_cfg & GENMASK_ULL(14, 8)) >> 8;
+	if (kw_type == NPC_MCAM_KEY_X2) {
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 1, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 2, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
+		goto read_action;
+	}
+
+	for (bank = 0; bank < mcam->banks_per_entry; bank++, kw = kw + 4) {
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 1, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 2, cam0, cam1);
+
+		cam1 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1));
+		cam0 = rvu_read64(rvu, blkaddr,
+				  NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0));
+		npc_cn20k_fill_entryword(entry, kw + 3, cam0, cam1);
+	}
+
+read_action:
+	/* 'action' is set to same value for both bank '0' and '1'.
+	 * Hence, reading bank '0' should be enough.
+	 */
+	entry->action = rvu_read64(rvu, blkaddr,
+				   NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 0));
+	entry->vtag_action = rvu_read64(rvu, blkaddr,
+					NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, 0, 1));
+}
+
 static u8 npc_map2cn20k_flag(u8 flag)
 {
 	switch (flag) {
@@ -609,13 +1032,15 @@ npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
 	}
 }
 
-int npc_cn20k_apply_custom_kpu(struct rvu *rvu, struct npc_kpu_profile_adapter *profile)
+int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
+			       struct npc_kpu_profile_adapter *profile)
 {
-	size_t hdr_sz = sizeof(struct npc_cn20k_kpu_profile_fwdata), offset = 0;
+	size_t hdr_sz = sizeof(struct npc_cn20k_kpu_profile_fwdata);
 	struct npc_cn20k_kpu_profile_fwdata *fw = rvu->kpu_fwdata;
 	struct npc_kpu_profile_action *action;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
+	size_t offset = 0;
 	u16 kpu, entry;
 	int entries;
 
@@ -701,6 +1126,40 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu, struct npc_kpu_profile_adapter *
 	return 0;
 }
 
+int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
+{
+	struct npc_subbank *sb;
+	int bank_off, sb_id;
+
+	/* mcam_idx should be less than (2 * bank depth) */
+	if (mcam_idx >= npc_priv.bank_depth * 2) {
+		dev_err(rvu->dev, "%s:%d bad params\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/* find mcam offset per bank */
+	bank_off = mcam_idx & (npc_priv.bank_depth - 1);
+
+	/* Find subbank id */
+	sb_id = bank_off / npc_priv.subbank_depth;
+
+	/* Check if subbank id is more than maximum
+	 * number of subbanks available
+	 */
+	if (sb_id >= npc_priv.num_subbanks) {
+		dev_err(rvu->dev, "%s:%d invalid subbank %d\n",
+			__func__, __LINE__, sb_id);
+		return -EINVAL;
+	}
+
+	sb = &npc_priv.sb[sb_id];
+
+	*key_type = sb->key_type;
+
+	return 0;
+}
+
 static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 				      u16 sub_off, u16 *mcam_idx)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 1df5e8c79a32..ef014e226e03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -230,4 +230,19 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc);
 
 int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast);
+
+void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
+				 u8 intf, struct mcam_entry *entry,
+				 bool enable, u8 hw_prio);
+void npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
+				 int index, bool enable);
+void npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr,
+			       u16 src, u16 dest);
+void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
+			       struct mcam_entry *entry, u8 *intf, u8 *ena,
+			       u8 *hw_prio);
+void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
+				int bank, int index);
+int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
+
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 49c9ee15c74f..24df1b67bde3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1577,6 +1577,8 @@ struct npc_mcam_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  set_cntr;    /* Set counter for this entry ? */
+	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u64 reserved;	 /* reserved for future use */
 };
 
 /* Enable/Disable a given entry */
@@ -1824,6 +1826,7 @@ struct npc_mcam_read_entry_rsp {
 	struct mcam_entry entry_data;
 	u8 intf;
 	u8 enable;
+	u8 hw_prio; /* valid for cn20k */
 };
 
 /* Available entries to use */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index d2a0f6821cf9..a53bb5c924ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1124,8 +1124,8 @@ int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause
 void rvu_mac_reset(struct rvu *rvu, u16 pcifunc);
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac);
 void cgx_start_linkup(struct rvu *rvu);
-int npc_get_nixlf_mcam_index(struct npc_mcam *mcam, u16 pcifunc, int nixlf,
-			     int type);
+int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
+			     u16 pcifunc, int nixlf, int type);
 bool is_mcam_entry_enabled(struct rvu *rvu, struct npc_mcam *mcam, int blkaddr,
 			   int index);
 int rvu_npc_init(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 2f485a930edd..810707d0e1f2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5283,7 +5283,6 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	/* Disable the interface if it is in any multicast list */
 	nix_mcast_update_mce_entry(rvu, pcifunc, 0);
 
-
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 246f3568a795..ea0368b32b01 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -18,6 +18,7 @@
 #include "rvu_npc_hash.h"
 #include "cn20k/npc.h"
 #include "rvu_npc.h"
+#include "cn20k/reg.h"
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -151,10 +152,33 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
 {
 	struct rvu_hwinfo *hw = container_of(mcam, struct rvu_hwinfo, mcam);
 	struct rvu *rvu = hw->rvu;
-	int pf = rvu_get_pf(rvu->pdev, pcifunc);
+	u16 bcast, mcast, promisc, ucast;
 	int index;
+	int rc;
+	int pf;
+
+	if (is_cn20k(rvu->pdev)) {
+		rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
+						 &promisc, &ucast);
+		if (rc)
+			return -EFAULT;
+
+		switch (type) {
+		case NIXLF_BCAST_ENTRY:
+			return bcast;
+		case NIXLF_ALLMULTI_ENTRY:
+			return mcast;
+		case NIXLF_PROMISC_ENTRY:
+			return promisc;
+		case NIXLF_UCAST_ENTRY:
+			return ucast;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	/* Check if this is for a PF */
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
 	if (pf && !(pcifunc & RVU_PFVF_FUNC_MASK)) {
 		/* Reserved entries exclude PF0 */
 		pf--;
@@ -175,7 +199,12 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
 
 int npc_get_bank(struct npc_mcam *mcam, int index)
 {
+	struct rvu_hwinfo *hw = container_of(mcam, struct rvu_hwinfo, mcam);
 	int bank = index / mcam->banksize;
+	struct rvu *rvu = hw->rvu;
+
+	if (is_cn20k(rvu->pdev))
+		return bank;
 
 	/* 0,1 & 2,3 banks are combined for this keysize */
 	if (mcam->keysize == NPC_MCAM_KEY_X2)
@@ -191,7 +220,13 @@ bool is_mcam_entry_enabled(struct rvu *rvu, struct npc_mcam *mcam,
 	u64 cfg;
 
 	index &= (mcam->banksize - 1);
-	cfg = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_CFG(index, bank));
+	if (is_cn20k(rvu->pdev))
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(index, bank));
+	else
+		cfg = rvu_read64(rvu, blkaddr,
+				 NPC_AF_MCAMEX_BANKX_CFG(index, bank));
+
 	return (cfg & 1);
 }
 
@@ -201,6 +236,13 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
+	if (is_cn20k(rvu->pdev)) {
+		if (index < 0 || index >= mcam->banksize * mcam->banks)
+			return;
+
+		return npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable);
+	}
+
 	index &= (mcam->banksize - 1);
 	for (; bank < (actbank + mcam->banks_per_entry); bank++) {
 		rvu_write64(rvu, blkaddr,
@@ -369,6 +411,7 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 					int blkaddr, u16 pf_func)
 {
 	int bank, nixlf, index;
+	u64 reg;
 
 	/* get ucast entry rule entry index */
 	if (nix_get_nixlf(rvu, pf_func, &nixlf, NULL)) {
@@ -383,8 +426,12 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
-	return rvu_read64(rvu, blkaddr,
-			  NPC_AF_MCAMEX_BANKX_ACTION(index, bank));
+	if (is_cn20k(rvu->pdev))
+		reg = NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0);
+	else
+		reg = NPC_AF_MCAMEX_BANKX_ACTION(index, bank);
+
+	return rvu_read64(rvu, blkaddr, reg);
 }
 
 static void npc_fixup_vf_rule(struct rvu *rvu, struct npc_mcam *mcam,
@@ -549,6 +596,9 @@ static void npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	u64 cfg, sreg, dreg;
 	int bank, i;
 
+	if (is_cn20k(rvu->pdev))
+		return npc_cn20k_copy_mcam_entry(rvu, blkaddr, src, dest);
+
 	src &= (mcam->banksize - 1);
 	dest &= (mcam->banksize - 1);
 
@@ -585,20 +635,31 @@ u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 			int blkaddr, int index)
 {
 	int bank = npc_get_bank(mcam, index);
+	u64 reg;
 
 	index &= (mcam->banksize - 1);
-	return rvu_read64(rvu, blkaddr,
-			  NPC_AF_MCAMEX_BANKX_ACTION(index, bank));
+
+	if (is_cn20k(rvu->pdev))
+		reg = NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0);
+	else
+		reg = NPC_AF_MCAMEX_BANKX_ACTION(index, bank);
+	return rvu_read64(rvu, blkaddr, reg);
 }
 
 void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 			 int blkaddr, int index, u64 cfg)
 {
 	int bank = npc_get_bank(mcam, index);
+	u64 reg;
 
 	index &= (mcam->banksize - 1);
-	return rvu_write64(rvu, blkaddr,
-			   NPC_AF_MCAMEX_BANKX_ACTION(index, bank), cfg);
+
+	if (is_cn20k(rvu->pdev))
+		reg = NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0);
+	else
+		reg = NPC_AF_MCAMEX_BANKX_ACTION(index, bank);
+
+	return rvu_write64(rvu, blkaddr, reg, cfg);
 }
 
 void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
@@ -973,10 +1034,17 @@ static void npc_update_vf_flow_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			/* disable before mcam entry update */
 			npc_enable_mcam_entry(rvu, mcam, blkaddr, actindex,
 					      false);
+
 			/* update 'action' */
-			rvu_write64(rvu, blkaddr,
-				    NPC_AF_MCAMEX_BANKX_ACTION(entry, bank),
-				    rx_action);
+			if (is_cn20k(rvu->pdev))
+				rvu_write64(rvu, blkaddr,
+					    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(entry, bank, 0),
+					    rx_action);
+			else
+				rvu_write64(rvu, blkaddr,
+					    NPC_AF_MCAMEX_BANKX_ACTION(entry, bank),
+					    rx_action);
+
 			if (enable)
 				npc_enable_mcam_entry(rvu, mcam, blkaddr,
 						      actindex, true);
@@ -993,6 +1061,7 @@ static void npc_update_rx_action_with_alg_idx(struct rvu *rvu, struct nix_rx_act
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int bank, op_rss;
+	u64 reg;
 
 	if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, mcam_index))
 		return;
@@ -1002,15 +1071,19 @@ static void npc_update_rx_action_with_alg_idx(struct rvu *rvu, struct nix_rx_act
 	bank = npc_get_bank(mcam, mcam_index);
 	mcam_index &= (mcam->banksize - 1);
 
+	if (is_cn20k(rvu->pdev))
+		reg = NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_index,
+							    bank, 0);
+	else
+		reg = NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank);
+
 	/* If Rx action is MCAST update only RSS algorithm index */
 	if (!op_rss) {
-		*(u64 *)&action = rvu_read64(rvu, blkaddr,
-				NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank));
+		*(u64 *)&action = rvu_read64(rvu, blkaddr, reg);
 
 		action.flow_key_alg = alg_idx;
 	}
-	rvu_write64(rvu, blkaddr,
-		    NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank), *(u64 *)&action);
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action);
 }
 
 void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
@@ -1020,6 +1093,7 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	struct nix_rx_action action;
 	int blkaddr, index, bank;
 	struct rvu_pfvf *pfvf;
+	u64 reg;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
@@ -1042,8 +1116,12 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	bank = npc_get_bank(mcam, index);
 	index &= (mcam->banksize - 1);
 
-	*(u64 *)&action = rvu_read64(rvu, blkaddr,
-				     NPC_AF_MCAMEX_BANKX_ACTION(index, bank));
+	if (is_cn20k(rvu->pdev))
+		reg = NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(index, bank, 0);
+	else
+		reg = NPC_AF_MCAMEX_BANKX_ACTION(index, bank);
+
+	*(u64 *)&action = rvu_read64(rvu, blkaddr, reg);
 	/* Ignore if no action was set earlier */
 	if (!*(u64 *)&action)
 		return;
@@ -1053,9 +1131,7 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	action.index = group;
 	action.flow_key_alg = alg_idx;
 
-	rvu_write64(rvu, blkaddr,
-		    NPC_AF_MCAMEX_BANKX_ACTION(index, bank), *(u64 *)&action);
-
+	rvu_write64(rvu, blkaddr, reg, *(u64 *)&action);
 	/* update the VF flow rule action with the VF default entry action */
 	if (mcam_index < 0)
 		npc_update_vf_flow_entry(rvu, mcam, blkaddr, pcifunc,
@@ -1870,46 +1946,56 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	int cntr;
 	u64 cfg;
 
-	/* Actual number of MCAM entries vary by entry size */
 	cfg = (rvu_read64(rvu, blkaddr,
 			  NPC_AF_INTFX_KEX_CFG(0)) >> 32) & 0x07;
-	mcam->total_entries = (mcam->banks / BIT_ULL(cfg)) * mcam->banksize;
 	mcam->keysize = cfg;
 
 	/* Number of banks combined per MCAM entry */
 	if (is_cn20k(rvu->pdev)) {
+		/* In cn20k, x2 entries is allowed for x4 profile.
+		 * set total_entries as 8192 * 2 and key size as x2.
+		 */
+		mcam->total_entries = mcam->banks * mcam->banksize;
 		if (cfg == NPC_MCAM_KEY_X2)
 			mcam->banks_per_entry = 1;
 		else
 			mcam->banks_per_entry = 2;
+
+		rsvd = 0;
 	} else {
+		mcam->total_entries = (mcam->banks / BIT_ULL(cfg)) *
+						mcam->banksize;
+
 		if (cfg == NPC_MCAM_KEY_X4)
 			mcam->banks_per_entry = 4;
 		else if (cfg == NPC_MCAM_KEY_X2)
 			mcam->banks_per_entry = 2;
 		else
 			mcam->banks_per_entry = 1;
-	}
 
-	/* Reserve one MCAM entry for each of the NIX LF to
-	 * guarantee space to install default matching DMAC rule.
-	 * Also reserve 2 MCAM entries for each PF for default
-	 * channel based matching or 'bcast & promisc' matching to
-	 * support BCAST and PROMISC modes of operation for PFs.
-	 * PF0 is excluded.
-	 */
-	rsvd = (nixlf_count * RSVD_MCAM_ENTRIES_PER_NIXLF) +
-		((rvu->hw->total_pfs - 1) * RSVD_MCAM_ENTRIES_PER_PF);
-	if (mcam->total_entries <= rsvd) {
-		dev_warn(rvu->dev,
-			 "Insufficient NPC MCAM size %d for pkt I/O, exiting\n",
-			 mcam->total_entries);
-		return -ENOMEM;
+		/* Reserve one MCAM entry for each of the NIX LF to
+		 * guarantee space to install default matching DMAC rule.
+		 * Also reserve 2 MCAM entries for each PF for default
+		 * channel based matching or 'bcast & promisc' matching to
+		 * support BCAST and PROMISC modes of operation for PFs.
+		 * PF0 is excluded.
+		 */
+		rsvd = (nixlf_count * RSVD_MCAM_ENTRIES_PER_NIXLF) +
+			((rvu->hw->total_pfs - 1) * RSVD_MCAM_ENTRIES_PER_PF);
+		if (mcam->total_entries <= rsvd) {
+			dev_warn(rvu->dev,
+				 "Insufficient NPC MCAM size %d for pkt I/O, exiting\n",
+				 mcam->total_entries);
+			return -ENOMEM;
+		}
 	}
 
 	mcam->bmap_entries = mcam->total_entries - rsvd;
-	mcam->nixlf_offset = mcam->bmap_entries;
-	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
+	/* cn20k does not need offsets to alloc mcam entries */
+	if (!is_cn20k(rvu->pdev)) {
+		mcam->nixlf_offset = mcam->bmap_entries;
+		mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
+	}
 
 	/* Allocate bitmaps for managing MCAM entries */
 	mcam->bmap = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
@@ -1933,13 +2019,15 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	 * allocations and another 1/8th at the top for high priority
 	 * allocations.
 	 */
-	mcam->lprio_count = mcam->bmap_entries / 8;
-	if (mcam->lprio_count > BITS_PER_LONG)
-		mcam->lprio_count = round_down(mcam->lprio_count,
-					       BITS_PER_LONG);
-	mcam->lprio_start = mcam->bmap_entries - mcam->lprio_count;
-	mcam->hprio_count = mcam->lprio_count;
-	mcam->hprio_end = mcam->hprio_count;
+	if (!is_cn20k(rvu->pdev)) {
+		mcam->lprio_count = mcam->bmap_entries / 8;
+		if (mcam->lprio_count > BITS_PER_LONG)
+			mcam->lprio_count = round_down(mcam->lprio_count,
+						       BITS_PER_LONG);
+		mcam->lprio_start = mcam->bmap_entries - mcam->lprio_count;
+		mcam->hprio_count = mcam->lprio_count;
+		mcam->hprio_end = mcam->hprio_count;
+	}
 
 	/* Allocate bitmap for managing MCAM counters and memory
 	 * for saving counter to RVU PFFUNC allocation mapping.
@@ -2063,15 +2151,13 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u64 nibble_ena, rx_kex, tx_kex;
-	u64 *keyx_cfg;
+	u64 *keyx_cfg, reg;
 	u8 intf;
 
-	if (is_cn20k(rvu->pdev)) {
+	if (is_cn20k(rvu->pdev))
 		keyx_cfg = mkex_extr->keyx_cfg;
-		goto skip_miss_cntr;
-	}
-
-	keyx_cfg = mkex->keyx_cfg;
+	else
+		keyx_cfg = mkex->keyx_cfg;
 
 	/* Reserve last counter for MCAM RX miss action which is set to
 	 * drop packet. This way we will know how many pkts didn't match
@@ -2080,7 +2166,6 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 	mcam->counters.max--;
 	mcam->rx_miss_act_cntr = mcam->counters.max;
 
-skip_miss_cntr:
 	rx_kex = keyx_cfg[NIX_INTF_RX];
 	tx_kex = keyx_cfg[NIX_INTF_TX];
 
@@ -2103,14 +2188,18 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 			    rx_kex);
 
 		if (is_cn20k(rvu->pdev))
-			continue;
+			reg = NPC_AF_INTFX_MISS_ACTX(intf, 0);
+		else
+			reg = NPC_AF_INTFX_MISS_ACT(intf);
 
 		/* If MCAM lookup doesn't result in a match, drop the received
 		 * packet. And map this action to a counter to count dropped
 		 * packets.
 		 */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_INTFX_MISS_ACT(intf), NIX_RX_ACTIONOP_DROP);
+		rvu_write64(rvu, blkaddr, reg, NIX_RX_ACTIONOP_DROP);
+
+		if (is_cn20k(rvu->pdev))
+			continue;
 
 		/* NPC_AF_INTFX_MISS_STAT_ACT[14:12] - counter[11:9]
 		 * NPC_AF_INTFX_MISS_STAT_ACT[8:0] - counter[8:0]
@@ -2130,12 +2219,15 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 		rvu_write64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf),
 			    tx_kex);
 
+		if (is_cn20k(rvu->pdev))
+			reg = NPC_AF_INTFX_MISS_ACTX(intf, 0);
+		else
+			reg = NPC_AF_INTFX_MISS_ACT(intf);
+
 		/* Set TX miss action to UCAST_DEFAULT i.e
 		 * transmit the packet on NIX LF SQ's default channel.
 		 */
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_INTFX_MISS_ACT(intf),
-			    NIX_TX_ACTIONOP_UCAST_DEFAULT);
+		rvu_write64(rvu, blkaddr, reg, NIX_TX_ACTIONOP_UCAST_DEFAULT);
 	}
 }
 
@@ -2333,6 +2425,10 @@ static void npc_map_mcam_entry_and_cntr(struct rvu *rvu, struct npc_mcam *mcam,
 	/* Set mapping and increment counter's refcnt */
 	mcam->entry2cntr_map[entry] = cntr;
 	mcam->cntr_refcnt[cntr]++;
+
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	/* Enable stats */
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank),
@@ -2390,6 +2486,7 @@ static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 				      int blkaddr, u16 pcifunc)
 {
 	u16 index, cntr;
+	int rc;
 
 	/* Scan all MCAM entries and free the ones mapped to 'pcifunc' */
 	for (index = 0; index < mcam->bmap_entries; index++) {
@@ -2407,6 +2504,13 @@ static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 							      blkaddr, index,
 							      cntr);
 			mcam->entry2target_pffunc[index] = 0x0;
+			if (is_cn20k(rvu->pdev)) {
+				rc = npc_cn20k_idx_free(rvu, &index, 1);
+				if (rc)
+					dev_err(rvu->dev,
+						"Failed to free mcam idx=%u pcifunc=%#x\n",
+						index, pcifunc);
+			}
 		}
 	}
 }
@@ -2553,14 +2657,74 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 				  struct npc_mcam_alloc_entry_req *req,
 				  struct npc_mcam_alloc_entry_rsp *rsp)
 {
+	struct rvu_hwinfo *hw = container_of(mcam, struct rvu_hwinfo, mcam);
 	u16 entry_list[NPC_MAX_NONCONTIG_ENTRIES];
 	u16 fcnt, hp_fcnt, lp_fcnt;
+	struct rvu *rvu = hw->rvu;
 	u16 start, end, index;
 	int entry, next_start;
 	bool reverse = false;
 	unsigned long *bmap;
+	int ret, limit = 0;
 	u16 max_contig;
 
+	if (!is_cn20k(rvu->pdev))
+		goto not_cn20k;
+
+	/* The below table is being followed during allocation,
+	 *
+	 * 1. ref_entry == 0 && prio == HIGH && count == 1  ==> user wants to allocate 0th index
+	 * 2. ref_entry == 0 && prio == HIGH && count > 1   ==> Invalid request
+	 * 3. ref_entry == 0 && prio == LOW && count >= 1   ==> limit = 0
+	 * 4. ref_entry != 0 && prio == HIGH && count >= 1  ==> limit = 0
+	 * 5. ref_entry != 0 && prio == LOW && count >=1    ==> limit = Max (X2: 2*8192, X4: 8192)
+	 */
+	if (req->ref_entry && req->ref_prio == NPC_MCAM_LOWER_PRIO) {
+		if (req->kw_type == NPC_MCAM_KEY_X2)
+			limit = 2 * mcam->bmap_entries;
+		else
+			limit = mcam->bmap_entries;
+	}
+
+	ret = npc_cn20k_ref_idx_alloc(rvu, pcifunc, req->kw_type,
+				      req->ref_prio, rsp->entry_list,
+				      req->ref_entry, limit,
+				      req->contig, req->count);
+
+	if (ret) {
+		rsp->count = 0;
+		return NPC_MCAM_ALLOC_FAILED;
+	}
+
+	rsp->count = req->count;
+	if (req->contig)
+		rsp->entry = rsp->entry_list[0];
+
+	/* cn20k, entries allocation algorithm is different.
+	 * This common API updates some bitmap on usage etc, which
+	 * will be used by other functions. So update those for
+	 * cn20k as well.
+	 */
+
+	mutex_lock(&mcam->lock);
+	/* Mark the allocated entries as used and set nixlf mapping */
+	for (entry = 0; entry < rsp->count; entry++) {
+		index = rsp->entry_list[entry];
+		npc_mcam_set_bit(mcam, index);
+		mcam->entry2pfvf_map[index] = pcifunc;
+		mcam->entry2cntr_map[index] = NPC_MCAM_INVALID_MAP;
+	}
+
+	/* cn20k, free count is provided thru different mbox message.
+	 * one counter to indicate free x2 slots and free x4 slots
+	 * does not provide any useful information to the user.
+	 */
+	rsp->free_count = -1;
+	mutex_unlock(&mcam->lock);
+
+	return 0;
+
+not_cn20k:
 	mutex_lock(&mcam->lock);
 
 	/* Check if there are any free entries */
@@ -2881,6 +3045,14 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 		npc_unmap_mcam_entry_and_cntr(rvu, mcam, blkaddr,
 					      req->entry, cntr);
 
+	if (is_cn20k(rvu->pdev)) {
+		rc = npc_cn20k_idx_free(rvu, &req->entry, 1);
+		if (rc)
+			dev_err(rvu->dev,
+				"Failed to free index=%u\n",
+				req->entry);
+	}
+
 	goto exit;
 
 free_all:
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index fef6be2de284..a0c294203eee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1757,14 +1757,19 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 	struct npc_mcam_write_entry_req write_req = { 0 };
 	struct mcam_entry *entry = &write_req.entry_data;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u8 intf, enable, hw_prio;
 	struct msg_rsp rsp;
-	u8 intf, enable;
 	int err;
 
 	ether_addr_copy(rule->packet.dmac, pfvf->mac_addr);
 
-	npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
-			    entry, &intf,  &enable);
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
+					  entry, &intf,
+					  &enable, &hw_prio);
+	else
+		npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
+				    entry, &intf, &enable);
 
 	npc_update_entry(rvu, NPC_DMAC, entry,
 			 ether_addr_to_u64(pfvf->mac_addr), 0,
-- 
2.43.0


