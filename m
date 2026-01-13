Return-Path: <netdev+bounces-249395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25BD17FB4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1345303440E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA638E5D3;
	Tue, 13 Jan 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a4rJ/iWW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBE38BF62;
	Tue, 13 Jan 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299455; cv=none; b=J2yByIeevDFE+Hty168szhZh04GilPfJjGJCe+QhKIWzu3vZVkL6hY0tHTgJI2z63WlTVoRepBSwVVhqXcALX/IkWHo9xFcNhBlhU2gz65Vb8x13BVjeVy4FyzLBXxRALuDLHK2sqpINvCxG5KvbGnpjPDYi7t5EYThEPXM5U6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299455; c=relaxed/simple;
	bh=PThfwHh2n3yqMCHxF0uZ+uORsqZOaYCwQKcexwXZ9mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/ypbM3YKs5RaiI6j5nIWLoN5oDWHCXcyOzz+xTZu6opLN+ov8k7gcUDiP8JjI8hBrbPscN8BnecktHio7uegIFONTM/1dgcxPswwStsreBvT4uNbyfH1jxHTpANQaCrTqRD4r4FC8zJufHATdsJ7KhYqYsDewTTkqd/ErCcuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a4rJ/iWW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q5qH2460532;
	Tue, 13 Jan 2026 02:17:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	+/36ajFzVKNJVT0EYtUeLZRXAIwSfkGVyljzdMdyTU=; b=a4rJ/iWWHB8berQbs
	Y+uyW5wFHD8G60ViUXeyAgWfpXClV2IdN/cRwsoaLxBX7xcha3l+zB79eEdffp8c
	jYx4qGvM/c3b4Ar8Z6swuE4/6YvKN8r2fzUltZo9LcFpA7pk3PEa7OQHBnghYKEz
	6aNLiegbJIUYUpNDf6n/ijRwv5xgz9DkZhK9UDS0wQefk7QMioyD1OVlAyVQQ7PK
	/z9y1LV2xBAng6vSMsl377Qhj7dtDE12flxz9z8L/S7jq9FSndnVh+5rq4wYT35f
	814x4qFxJWiEc1EzXkKKLPxeGZH3QJfo6HHuT0MZ1xRT3XworpZWmSd+OadsY/fz
	O7a5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bmvfkbcwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:17:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:17:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:17:17 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8E7CC3F7096;
	Tue, 13 Jan 2026 02:17:14 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v4 04/13] ocetontx2-af: npc: cn20k: MKEX profile support
Date: Tue, 13 Jan 2026 15:46:49 +0530
Message-ID: <20260113101658.4144610-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113101658.4144610-1-rkannoth@marvell.com>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NyBTYWx0ZWRfX/P1cvRyy60AJ
 qhxRISzMdlJOlF1WZTeqsYdoDnQkWNXqA51BlXicUc3EuDTMLm4kFpK7NsqUWnVZISLNlxWOCBr
 /r8KOnjI7c0qAGNT99CEFNuyGvv56dwqKdHEolLcgfXlTML0snlmoy0ATaqeCF1M6V/MK59U63m
 nzv0sDZNr1bVnnTFd1i73aXKxGjCpuJUpeHn034mh6fTfFStd2BSHDkR8bR0v0reJwvJCZiR1jt
 VjIi/5XZq9GTj7MgnNyzvnNtWOfu7L8F3xDfPC58AAcz8RcQmlvo2TgInKr4Q8E9I3xgr++3goZ
 aSGZog3FdXVeERX61njAmJOrKsLjRDIZgwcKsExV5OCjZtPHpKLxz8xicSLMs9DbrqTGlGiLKrU
 pmkQgjwTyEtb48bGltMKB2lockIpEbVTC/fdiM0w7z/ly8n6ScItfzUkjEL2qA2RgD7Erx2ab7u
 D6P4YfXy7hZY14qVwLQ==
X-Proofpoint-GUID: N3S9J4Pa60-aQZZeD4Iq3oAQ_K43g3A5
X-Proofpoint-ORIG-GUID: N3S9J4Pa60-aQZZeD4Iq3oAQ_K43g3A5
X-Authority-Analysis: v=2.4 cv=AZe83nXG c=1 sm=1 tr=0 ts=69661bae cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=4IwJlRh9AewB62vroAYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

In new silicon variant cn20k, a new parser profile is introduced. Instead
of having two layer-data information per key field type, a new key
extractor concept is introduced. As part of this change now a maximum of
24 extractor can be configured per packet parsing profile. For example,
LA type(ether) can have 24 unique parsing key, LC type(ip), LD
type(tcp/udp) also can have unique 24 parsing key associated.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 352 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h | 102 +++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  60 ++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  17 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../marvell/octeontx2/af/npc_profile.h        |  12 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  73 +++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   2 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 229 ++++++++++--
 .../marvell/octeontx2/af/rvu_npc_hash.c       |  15 +
 11 files changed, 799 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 0717fd66e8a1..c3f41f4ea99c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -29,19 +29,21 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
 		     ((key_ofs) & 0x3F))
 
+static const char cn20k_def_pfl_name[] = "default";
+
 static struct npc_mcam_kex_extr npc_mkex_extr_default = {
-	.mkex_sign = MKEX_SIGN,
+	.mkex_sign = MKEX_CN20K_SIGN,
 	.name = "default",
 	.kpu_version = NPC_KPU_PROFILE_VER,
 	.keyx_cfg = {
 		/* nibble: LA..LE (ltype only) + Error code + Channel */
 		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) |
 			NPC_PARSE_NIBBLE_INTF_RX |
-				 NPC_PARSE_NIBBLE_ERRCODE,
+				 NPC_CN20K_PARSE_NIBBLE_ERRCODE,
 
 		/* nibble: LA..LE (ltype only) */
 		[NIX_INTF_TX] = ((u64)NPC_MCAM_KEY_X2 << 32) |
-			NPC_PARSE_NIBBLE_INTF_TX,
+			NPC_CN20K_PARSE_NIBBLE_INTF_TX,
 	},
 	.intf_extr_lid = {
 	/* Default RX MCAM KEX profile */
@@ -297,9 +299,9 @@ npc_enable_kpm_entry(struct rvu *rvu, int blkaddr, int kpm, int num_entries)
 	u64 entry_mask;
 
 	entry_mask = npc_enable_mask(num_entries);
-	/* Disable first KPU_MAX_CST_ENT entries for built-in profile */
+	/* Disable first KPU_CN20K_MAX_CST_ENT entries for built-in profile */
 	if (!rvu->kpu.custom)
-		entry_mask |= GENMASK_ULL(KPU_MAX_CST_ENT - 1, 0);
+		entry_mask |= GENMASK_ULL(KPU_CN20K_MAX_CST_ENT - 1, 0);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_KPMX_ENTRY_DISX(kpm, 0), entry_mask);
 	if (num_entries <= 64) {
@@ -420,6 +422,290 @@ struct npc_priv_t *npc_priv_get(void)
 	return &npc_priv;
 }
 
+static void npc_program_mkex_rx(struct rvu *rvu, int blkaddr,
+				struct npc_mcam_kex_extr *mkex_extr,
+				u8 intf)
+{
+	u8 num_extr = rvu->hw->npc_kex_extr;
+	int extr, lt;
+	u64 val;
+
+	if (is_npc_intf_tx(intf))
+		return;
+
+	rvu_write64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf),
+		    mkex_extr->keyx_cfg[NIX_INTF_RX]);
+
+	/* Program EXTRACTOR */
+	for (extr = 0; extr < num_extr; extr++)
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_INTFX_EXTRACTORX_CFG(intf, extr),
+			    mkex_extr->intf_extr_lid[intf][extr]);
+
+	/* Program EXTRACTOR_LTYPE */
+	for (extr = 0; extr < num_extr; extr++) {
+		for (lt = 0; lt < NPC_MAX_LT; lt++) {
+			val = mkex_extr->intf_extr_lt[intf][extr][lt];
+			CN20K_SET_EXTR_LT(intf, extr, lt, val);
+		}
+	}
+}
+
+static void npc_program_mkex_tx(struct rvu *rvu, int blkaddr,
+				struct npc_mcam_kex_extr *mkex_extr,
+				u8 intf)
+{
+	u8 num_extr = rvu->hw->npc_kex_extr;
+	int extr, lt;
+	u64 val;
+
+	if (is_npc_intf_rx(intf))
+		return;
+
+	rvu_write64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf),
+		    mkex_extr->keyx_cfg[NIX_INTF_TX]);
+
+	/* Program EXTRACTOR */
+	for (extr = 0; extr < num_extr; extr++)
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_INTFX_EXTRACTORX_CFG(intf, extr),
+			    mkex_extr->intf_extr_lid[intf][extr]);
+
+	/* Program EXTRACTOR_LTYPE */
+	for (extr = 0; extr < num_extr; extr++) {
+		for (lt = 0; lt < NPC_MAX_LT; lt++) {
+			val = mkex_extr->intf_extr_lt[intf][extr][lt];
+			CN20K_SET_EXTR_LT(intf, extr, lt, val);
+		}
+	}
+}
+
+static void npc_program_mkex_profile(struct rvu *rvu, int blkaddr,
+				     struct npc_mcam_kex_extr *mkex_extr)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	u8 intf;
+
+	for (intf = 0; intf < hw->npc_intfs; intf++) {
+		npc_program_mkex_rx(rvu, blkaddr, mkex_extr, intf);
+		npc_program_mkex_tx(rvu, blkaddr, mkex_extr, intf);
+	}
+
+	/* Programme mkex hash profile */
+	npc_program_mkex_hash(rvu, blkaddr);
+}
+
+void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
+				 const char *mkex_profile)
+{
+	struct npc_mcam_kex_extr *mcam_kex_extr;
+	struct device *dev = &rvu->pdev->dev;
+	void __iomem *mkex_prfl_addr = NULL;
+	u64 prfl_sz;
+	int ret;
+
+	/* If user not selected mkex profile */
+	if (rvu->kpu_fwdata_sz ||
+	    !strncmp(mkex_profile, cn20k_def_pfl_name, MKEX_NAME_LEN))
+		goto program_mkex_extr;
+
+	/* Setting up the mapping for mkex profile image */
+	ret = npc_fwdb_prfl_img_map(rvu, &mkex_prfl_addr, &prfl_sz);
+	if (ret < 0)
+		goto program_mkex_extr;
+
+	mcam_kex_extr = (struct npc_mcam_kex_extr __force *)mkex_prfl_addr;
+
+	while (((s64)prfl_sz > 0) &&
+	       (mcam_kex_extr->mkex_sign != MKEX_END_SIGN)) {
+		/* Compare with mkex mod_param name string */
+		if (mcam_kex_extr->mkex_sign == MKEX_CN20K_SIGN &&
+		    !strncmp(mcam_kex_extr->name, mkex_profile,
+			     MKEX_NAME_LEN)) {
+			rvu->kpu.mcam_kex_prfl.mkex_extr = mcam_kex_extr;
+			goto program_mkex_extr;
+		}
+
+		mcam_kex_extr++;
+		prfl_sz -= sizeof(struct npc_mcam_kex_extr);
+	}
+	dev_warn(dev, "Failed to load requested profile: %s\n", mkex_profile);
+
+program_mkex_extr:
+	dev_info(rvu->dev, "Using %s mkex profile\n",
+		 rvu->kpu.mcam_kex_prfl.mkex_extr->name);
+	/* Program selected mkex profile */
+	npc_program_mkex_profile(rvu, blkaddr,
+				 rvu->kpu.mcam_kex_prfl.mkex_extr);
+	if (mkex_prfl_addr)
+		iounmap(mkex_prfl_addr);
+}
+
+static u8 npc_map2cn20k_flag(u8 flag)
+{
+	switch (flag) {
+	case NPC_F_LC_U_IP_FRAG:
+		return NPC_CN20K_F_LC_L_IP_FRAG;
+
+	case NPC_F_LC_U_IP6_FRAG:
+		return NPC_CN20K_F_LC_L_IP6_FRAG;
+
+	case NPC_F_LC_L_6TO4:
+		return NPC_CN20K_F_LC_L_6TO4;
+
+	case NPC_F_LC_L_MPLS_IN_IP:
+		return NPC_CN20K_F_LC_U_MPLS_IN_IP;
+
+	case NPC_F_LC_L_IP6_TUN_IP6:
+		return NPC_CN20K_F_LC_U_IP6_TUN_IP6;
+
+	case NPC_F_LC_L_IP6_MPLS_IN_IP:
+		return NPC_CN20K_F_LC_U_IP6_MPLS_IN_IP;
+
+	default:
+		break;
+	}
+
+	return -1;
+}
+
+void
+npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
+					struct npc_kpu_profile_adapter *pfl)
+{
+	struct npc_kpu_profile_action *action;
+	int entries, ltype;
+	u8 flags;
+
+	for (int i = 0; i < pfl->kpus; i++) {
+		action = pfl->kpu[i].action;
+		entries = pfl->kpu[i].action_entries;
+
+		for (int j = 0; j < entries; j++) {
+			if (action[j].lid != NPC_LID_LC)
+				continue;
+
+			ltype = action[j].ltype;
+
+			if (ltype != NPC_LT_LC_IP &&
+			    ltype != NPC_LT_LC_IP6 &&
+			    ltype != NPC_LT_LC_IP_OPT &&
+			    ltype != NPC_LT_LC_IP6_EXT)
+				continue;
+
+			flags = action[j].flags;
+
+			switch (flags) {
+			case NPC_F_LC_U_IP_FRAG:
+			case NPC_F_LC_U_IP6_FRAG:
+			case NPC_F_LC_L_6TO4:
+			case NPC_F_LC_L_MPLS_IN_IP:
+			case NPC_F_LC_L_IP6_TUN_IP6:
+			case NPC_F_LC_L_IP6_MPLS_IN_IP:
+				action[j].flags = npc_map2cn20k_flag(flags);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+}
+
+int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
+			       struct npc_kpu_profile_adapter *profile)
+{
+	struct npc_cn20k_kpu_profile_fwdata *fw = rvu->kpu_fwdata;
+	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_cam *cam;
+	struct npc_kpu_fwdata *fw_kpu;
+	size_t hdr_sz, offset = 0;
+	u16 kpu, entry;
+	int entries;
+
+	hdr_sz = sizeof(struct npc_cn20k_kpu_profile_fwdata);
+
+	if (rvu->kpu_fwdata_sz < hdr_sz) {
+		dev_warn(rvu->dev, "Invalid KPU profile size\n");
+		return -EINVAL;
+	}
+
+	if (le64_to_cpu(fw->signature) != KPU_SIGN) {
+		dev_warn(rvu->dev, "Invalid KPU profile signature %llx\n",
+			 fw->signature);
+		return -EINVAL;
+	}
+
+	/* Verify if the using known profile structure */
+	if (NPC_KPU_VER_MAJ(profile->version) >
+	    NPC_KPU_VER_MAJ(NPC_KPU_PROFILE_VER)) {
+		dev_warn(rvu->dev, "Not supported Major version: %d > %d\n",
+			 NPC_KPU_VER_MAJ(profile->version),
+			 NPC_KPU_VER_MAJ(NPC_KPU_PROFILE_VER));
+		return -EINVAL;
+	}
+
+	/* Verify if profile is aligned with the required kernel changes */
+	if (NPC_KPU_VER_MIN(profile->version) <
+	    NPC_KPU_VER_MIN(NPC_KPU_PROFILE_VER)) {
+		dev_warn(rvu->dev,
+			 "Invalid KPU profile version: %d.%d.%d expected version <= %d.%d.%d\n",
+			 NPC_KPU_VER_MAJ(profile->version),
+			 NPC_KPU_VER_MIN(profile->version),
+			 NPC_KPU_VER_PATCH(profile->version),
+			 NPC_KPU_VER_MAJ(NPC_KPU_PROFILE_VER),
+			 NPC_KPU_VER_MIN(NPC_KPU_PROFILE_VER),
+			 NPC_KPU_VER_PATCH(NPC_KPU_PROFILE_VER));
+		return -EINVAL;
+	}
+
+	/* Verify if profile fits the HW */
+	if (fw->kpus > profile->kpus) {
+		dev_warn(rvu->dev, "Not enough KPUs: %d > %ld\n", fw->kpus,
+			 profile->kpus);
+		return -EINVAL;
+	}
+
+	profile->mcam_kex_prfl.mkex_extr = &fw->mkex;
+	if (profile->mcam_kex_prfl.mkex_extr->mkex_sign != MKEX_CN20K_SIGN) {
+		dev_warn(rvu->dev, "Invalid MKEX profile signature:%llx\n",
+			 profile->mcam_kex_prfl.mkex_extr->mkex_sign);
+		return -EINVAL;
+	}
+
+	profile->custom = 1;
+	profile->name = fw->name;
+	profile->version = le64_to_cpu(fw->version);
+	profile->lt_def = &fw->lt_def;
+
+	for (kpu = 0; kpu < fw->kpus; kpu++) {
+		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
+		if (fw_kpu->entries > KPU_CN20K_MAX_CST_ENT)
+			dev_warn(rvu->dev,
+				 "Too many custom entries on KPU%d: %d > %d\n",
+				 kpu, fw_kpu->entries, KPU_CN20K_MAX_CST_ENT);
+		entries = min(fw_kpu->entries, KPU_CN20K_MAX_CST_ENT);
+		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
+		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
+		action = (struct npc_kpu_profile_action *)(fw->data + offset);
+		offset += fw_kpu->entries * sizeof(*action);
+		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
+			dev_warn(rvu->dev,
+				 "Profile size mismatch on KPU%i parsing.\n",
+				 kpu + 1);
+			return -EINVAL;
+		}
+
+		npc_cn20k_update_action_entries_n_flags(rvu, profile);
+
+		for (entry = 0; entry < entries; entry++) {
+			profile->kpu[kpu].cam[entry] = cam[entry];
+			profile->kpu[kpu].action[entry] = action[entry];
+		}
+	}
+
+	return 0;
+}
+
 static int npc_subbank_idx_2_mcam_idx(struct rvu *rvu, struct npc_subbank *sb,
 				      u16 sub_off, u16 *mcam_idx)
 {
@@ -1911,6 +2197,38 @@ rvu_mbox_handler_npc_cn20k_get_fcnt(struct rvu *rvu,
 	return 0;
 }
 
+int
+rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
+				       struct msg_req *req,
+				       struct npc_cn20k_get_kex_cfg_rsp *rsp)
+{
+	int extr, lt;
+
+	rsp->rx_keyx_cfg = CN20K_GET_KEX_CFG(NIX_INTF_RX);
+	rsp->tx_keyx_cfg = CN20K_GET_KEX_CFG(NIX_INTF_TX);
+
+	/* Get EXTRACTOR LID */
+	for (extr = 0; extr < NPC_MAX_EXTRACTOR; extr++) {
+		rsp->intf_extr_lid[NIX_INTF_RX][extr] =
+			CN20K_GET_EXTR_LID(NIX_INTF_RX, extr);
+		rsp->intf_extr_lid[NIX_INTF_TX][extr] =
+			CN20K_GET_EXTR_LID(NIX_INTF_TX, extr);
+	}
+
+	/* Get EXTRACTOR LTYPE */
+	for (extr = 0; extr < NPC_MAX_EXTRACTOR; extr++) {
+		for (lt = 0; lt < NPC_MAX_LT; lt++) {
+			rsp->intf_extr_lt[NIX_INTF_RX][extr][lt] =
+				CN20K_GET_EXTR_LT(NIX_INTF_RX, extr, lt);
+			rsp->intf_extr_lt[NIX_INTF_TX][extr][lt] =
+				CN20K_GET_EXTR_LT(NIX_INTF_TX, extr, lt);
+		}
+	}
+
+	memcpy(rsp->mkex_pfl_name, rvu->mkex_pfl_name, MKEX_NAME_LEN);
+	return 0;
+}
+
 static void npc_lock_all_subbank(void)
 {
 	int i;
@@ -2201,6 +2519,23 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	kfree(subbank_srch_order);
 }
 
+static int npc_setup_mcam_section(struct rvu *rvu, int key_type)
+{
+	int blkaddr, sec;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0) {
+		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
+		return -ENODEV;
+	}
+
+	for (sec = 0; sec < npc_priv.num_subbanks; sec++)
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_MCAM_SECTIONX_CFG_EXT(sec), key_type);
+
+	return 0;
+}
+
 int npc_cn20k_init(struct rvu *rvu)
 {
 	int err;
@@ -2212,6 +2547,13 @@ int npc_cn20k_init(struct rvu *rvu)
 		return err;
 	}
 
+	err = npc_setup_mcam_section(rvu, NPC_MCAM_KEY_X2);
+	if (err) {
+		dev_err(rvu->dev, "%s: mcam section configuration failure\n",
+			__func__);
+		return err;
+	}
+
 	npc_priv.init_done = true;
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 635c9294dbcc..b0cb0dfd567a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -8,10 +8,77 @@
 #ifndef NPC_CN20K_H
 #define NPC_CN20K_H
 
+#define MKEX_CN20K_SIGN	0x19bbfdbd160
+
 #define MAX_NUM_BANKS 2
 #define MAX_NUM_SUB_BANKS 32
 #define MAX_SUBBANK_DEPTH 256
 
+/* strtoull of "mkexprof" with base:36 */
+#define MKEX_END_SIGN  0xdeadbeef
+
+#define NPC_CN20K_BYTESM GENMASK_ULL(18, 16)
+#define NPC_CN20K_PARSE_NIBBLE GENMASK_ULL(22, 0)
+#define NPC_CN20K_TOTAL_NIBBLE 23
+
+#define CN20K_SET_EXTR_LT(intf, extr, ltype, cfg)	\
+	rvu_write64(rvu, BLKADDR_NPC,	\
+		    NPC_AF_INTFX_EXTRACTORX_LTX_CFG(intf, extr, ltype), cfg)
+
+#define CN20K_GET_KEX_CFG(intf)	\
+	rvu_read64(rvu, BLKADDR_NPC, NPC_AF_INTFX_KEX_CFG(intf))
+
+#define CN20K_GET_EXTR_LID(intf, extr)	\
+	rvu_read64(rvu, BLKADDR_NPC,	\
+		   NPC_AF_INTFX_EXTRACTORX_CFG(intf, extr))
+
+#define CN20K_SET_EXTR_LT(intf, extr, ltype, cfg)	\
+	rvu_write64(rvu, BLKADDR_NPC,	\
+		    NPC_AF_INTFX_EXTRACTORX_LTX_CFG(intf, extr, ltype), cfg)
+
+#define CN20K_GET_EXTR_LT(intf, extr, ltype)	\
+	rvu_read64(rvu, BLKADDR_NPC,	\
+		   NPC_AF_INTFX_EXTRACTORX_LTX_CFG(intf, extr, ltype))
+
+/* NPC_PARSE_KEX_S nibble definitions for each field */
+#define NPC_CN20K_PARSE_NIBBLE_CHAN GENMASK_ULL(2, 0)
+#define NPC_CN20K_PARSE_NIBBLE_ERRLEV BIT_ULL(3)
+#define NPC_CN20K_PARSE_NIBBLE_ERRCODE GENMASK_ULL(5, 4)
+#define NPC_CN20K_PARSE_NIBBLE_L2L3_BCAST BIT_ULL(6)
+#define NPC_CN20K_PARSE_NIBBLE_LA_FLAGS BIT_ULL(7)
+#define NPC_CN20K_PARSE_NIBBLE_LA_LTYPE BIT_ULL(8)
+#define NPC_CN20K_PARSE_NIBBLE_LB_FLAGS BIT_ULL(9)
+#define NPC_CN20K_PARSE_NIBBLE_LB_LTYPE BIT_ULL(10)
+#define NPC_CN20K_PARSE_NIBBLE_LC_FLAGS BIT_ULL(11)
+#define NPC_CN20K_PARSE_NIBBLE_LC_LTYPE BIT_ULL(12)
+#define NPC_CN20K_PARSE_NIBBLE_LD_FLAGS BIT_ULL(13)
+#define NPC_CN20K_PARSE_NIBBLE_LD_LTYPE BIT_ULL(14)
+#define NPC_CN20K_PARSE_NIBBLE_LE_FLAGS BIT_ULL(15)
+#define NPC_CN20K_PARSE_NIBBLE_LE_LTYPE BIT_ULL(16)
+#define NPC_CN20K_PARSE_NIBBLE_LF_FLAGS BIT_ULL(17)
+#define NPC_CN20K_PARSE_NIBBLE_LF_LTYPE BIT_ULL(18)
+#define NPC_CN20K_PARSE_NIBBLE_LG_FLAGS BIT_ULL(19)
+#define NPC_CN20K_PARSE_NIBBLE_LG_LTYPE BIT_ULL(20)
+#define NPC_CN20K_PARSE_NIBBLE_LH_FLAGS BIT_ULL(21)
+#define NPC_CN20K_PARSE_NIBBLE_LH_LTYPE BIT_ULL(22)
+
+/* Rx parse key extract nibble enable */
+#define NPC_CN20K_PARSE_NIBBLE_INTF_RX  (NPC_CN20K_PARSE_NIBBLE_CHAN | \
+					 NPC_CN20K_PARSE_NIBBLE_L2L3_BCAST | \
+					 NPC_CN20K_PARSE_NIBBLE_LA_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LB_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LC_FLAGS | \
+					 NPC_CN20K_PARSE_NIBBLE_LC_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LD_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LE_LTYPE)
+
+/* Tx parse key extract nibble enable */
+#define NPC_CN20K_PARSE_NIBBLE_INTF_TX	(NPC_CN20K_PARSE_NIBBLE_LA_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LB_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LC_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LD_LTYPE | \
+					 NPC_CN20K_PARSE_NIBBLE_LE_LTYPE)
+
 /**
  * enum npc_subbank_flag - NPC subbank status
  *
@@ -147,6 +214,34 @@ struct npc_mcam_kex_extr {
 	u64 intf_extr_lt[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
 } __packed;
 
+struct npc_cn20k_kpu_profile_fwdata {
+#define KPU_SIGN	0x00666f727075706b
+#define KPU_NAME_LEN	32
+	/* Maximum number of custom KPU entries supported by
+	 * the built-in profile.
+	 */
+#define KPU_CN20K_MAX_CST_ENT	6
+	/* KPU Profle Header */
+	__le64	signature; /* "kpuprof\0" (8 bytes/ASCII characters) */
+	u8	name[KPU_NAME_LEN]; /* KPU Profile name */
+	__le64	version; /* KPU profile version */
+	u8	kpus;
+	u8	reserved[7];
+
+	/* Default MKEX profile to be used with this KPU profile. May be
+	 * overridden with mkex_profile module parameter.
+	 * Format is same as for the MKEX profile to streamline processing.
+	 */
+	struct npc_mcam_kex_extr	mkex;
+	/* LTYPE values for specific HW offloaded protocols. */
+	struct npc_lt_def_cfg		lt_def;
+	/* Dynamically sized data:
+	 *  Custom KPU CAM and ACTION configuration entries.
+	 * struct npc_kpu_fwdata kpu[kpus];
+	 */
+	u8	data[];
+} __packed;
+
 struct rvu;
 
 struct npc_priv_t *npc_priv_get(void);
@@ -164,5 +259,12 @@ int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
 void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr);
 struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void);
+void npc_cn20k_load_mkex_profile(struct rvu *rvu, int blkaddr,
+				 const char *mkex_profile);
+int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
+			       struct npc_kpu_profile_adapter *profile);
 
+void
+npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
+					struct npc_kpu_profile_adapter *pfl);
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 073d4b815681..bf50d999528b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -80,18 +80,60 @@
 #define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 /* NPC registers */
 #define NPC_AF_INTFX_EXTRACTORX_CFG(a, b) \
-	(0x908000ull | (a) << 10 | (b) << 3)
+	(0x20c000ull | (a) << 16 | (b) << 8)
 #define NPC_AF_INTFX_EXTRACTORX_LTX_CFG(a, b, c) \
-	(0x900000ull | (a) << 13 | (b) << 8  | (c) << 3)
+	(0x204000ull | (a) << 16 | (b) << 8  | (c) << 3)
 #define NPC_AF_KPMX_ENTRYX_CAMX(a, b, c) \
-	(0x100000ull | (a) << 14 | (b) << 6 | (c) << 3)
+	(0x20000ull | (a) << 12 | (b) << 3 | (c) << 16)
 #define NPC_AF_KPMX_ENTRYX_ACTION0(a, b) \
-	(0x100020ull | (a) << 14 | (b) << 6)
+	(0x40000ull | (a) << 12 | (b) << 3)
 #define NPC_AF_KPMX_ENTRYX_ACTION1(a, b) \
-	(0x100028ull | (a) << 14 | (b) << 6)
-#define NPC_AF_KPMX_ENTRY_DISX(a, b)	(0x180000ull | (a) << 6 | (b) << 3)
-#define NPC_AF_KPM_PASS2_CFG	0x580
-#define NPC_AF_KPMX_PASS2_OFFSET(a)	(0x190000ull | (a) << 3)
-#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a)	(0xC000000ull | (a) << 3)
+	(0x50000ull | (a) << 12 | (b) << 3)
+#define NPC_AF_KPMX_ENTRY_DISX(a, b)	(0x60000ull | (a) << 12 | (b) << 3)
+#define NPC_AF_KPM_PASS2_CFG	0x10210
+#define NPC_AF_KPMX_PASS2_OFFSET(a)	(0x60040ull | (a) << 12)
+#define NPC_AF_MCAM_SECTIONX_CFG_EXT(a)	(0xf000000ull | (a) << 3)
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_INTF_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0x8000000ull | (a) << 4 | (b) << 20 | (c) << 3);	\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0x9000000ull | (a) << 4 | (b) << 20 | (c) << 3);	\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0x9400000ull | (a) << 4 | (b) << 20 | (c) << 3);	\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0x9800000ull | (a) << 4 | (b) << 20 | (c) << 3);	\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0x9c00000ull | (a) << 4 | (b) << 20 | (c) << 3);	\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_CFG_EXT(a, b) ({		\
+	u64 offset;						\
+	offset = (0xa000000ull | (a) << 4 | (b) << 20);		\
+	offset; })
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(a, b, c) ({		\
+	u64 offset;							\
+	offset = (0xc000000ull | (a) << 4 | (b) << 20 | (c) << 22);	\
+	offset; })
+
+#define NPC_AF_INTFX_MISS_ACTX(a, b)	(0xf003000 | (a) << 6 | (b) << 4)
+
+#define NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(a, b) ({		\
+	u64 offset;						\
+	offset = (0xb000000ull | (a) << 4 | (b) << 20);		\
+	offset; })
 
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 1c4b36832788..a393bf884fd6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -285,6 +285,8 @@ M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_rsp)              \
 M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6015, npc_cn20k_get_fcnt,		\
 				 msg_req, npc_cn20k_get_fcnt_rsp)	\
+M(NPC_CN20K_GET_KEX_CFG, 0x6016, npc_cn20k_get_kex_cfg,			\
+				   msg_req, npc_cn20k_get_kex_cfg_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1559,7 +1561,7 @@ struct npc_mcam_free_entry_req {
 };
 
 struct mcam_entry {
-#define NPC_MAX_KWS_IN_KEY	7 /* Number of keywords in max keywidth */
+#define NPC_MAX_KWS_IN_KEY	8 /* Number of keywords in max keywidth */
 	u64	kw[NPC_MAX_KWS_IN_KEY];
 	u64	kw_mask[NPC_MAX_KWS_IN_KEY];
 	u64	action;
@@ -1663,6 +1665,19 @@ struct npc_get_kex_cfg_rsp {
 	u8 mkex_pfl_name[MKEX_NAME_LEN];
 };
 
+struct npc_cn20k_get_kex_cfg_rsp {
+	struct mbox_msghdr hdr;
+	u64 rx_keyx_cfg;   /* NPC_AF_INTF(0)_KEX_CFG */
+	u64 tx_keyx_cfg;   /* NPC_AF_INTF(1)_KEX_CFG */
+#define NPC_MAX_EXTRACTOR 24
+	/* MKEX Extractor data */
+	u64 intf_extr_lid[NPC_MAX_INTF][NPC_MAX_EXTRACTOR];
+	/* KEX configuration per extractor */
+	u64 intf_extr_lt[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
+#define MKEX_NAME_LEN 128
+	u8 mkex_pfl_name[MKEX_NAME_LEN];
+};
+
 struct ptp_get_cap_rsp {
 	struct mbox_msghdr hdr;
 #define        PTP_CAP_HW_ATOMIC_UPDATE BIT_ULL(0)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 6c3aca6f278d..cb05ec69e0b3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -429,6 +429,7 @@ struct nix_rx_action {
 
 /* NPC_AF_INTFX_KEX_CFG field masks */
 #define NPC_PARSE_NIBBLE		GENMASK_ULL(30, 0)
+#define NPC_TOTAL_NIBBLE		31
 
 /* NPC_PARSE_KEX_S nibble definitions for each field */
 #define NPC_PARSE_NIBBLE_CHAN		GENMASK_ULL(2, 0)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index 561b01fcdbde..db74f7fdf028 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -321,6 +321,18 @@ enum npc_kpu_lb_lflag {
 	NPC_F_LB_L_FDSA,
 };
 
+enum npc_cn20k_kpu_lc_uflag {
+	NPC_CN20K_F_LC_U_MPLS_IN_IP = 0x20,
+	NPC_CN20K_F_LC_U_IP6_TUN_IP6 = 0x40,
+	NPC_CN20K_F_LC_U_IP6_MPLS_IN_IP = 0x80,
+};
+
+enum npc_cn20k_kpu_lc_lflag {
+	NPC_CN20K_F_LC_L_IP_FRAG = 2,
+	NPC_CN20K_F_LC_L_IP6_FRAG,
+	NPC_CN20K_F_LC_L_6TO4,
+};
+
 enum npc_kpu_lc_uflag {
 	NPC_F_LC_U_UNK_PROTO = 0x10,
 	NPC_F_LC_U_IP_FRAG = 0x20,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 14ca28ab493a..dd930aa05582 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -554,7 +554,11 @@ struct npc_kpu_profile_adapter {
 	const struct npc_lt_def_cfg	*lt_def;
 	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
 	const struct npc_kpu_profile	*kpu; /* array[kpus] */
-	struct npc_mcam_kex		*mkex;
+	union npc_mcam_key_prfl {
+		struct npc_mcam_kex		*mkex;
+					/* used for cn9k and cn10k */
+		struct npc_mcam_kex_extr	*mkex_extr; /* used for cn20k */
+	} mcam_kex_prfl;
 	struct npc_mcam_kex_hash	*mkex_hash;
 	bool				custom;
 	size_t				pkinds;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 133ae6421de7..8361d0aa4b6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1337,8 +1337,8 @@ static void npc_program_mkex_profile(struct rvu *rvu, int blkaddr,
 	npc_program_mkex_hash(rvu, blkaddr);
 }
 
-static int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
-				 u64 *size)
+int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
+			  u64 *size)
 {
 	u64 prfl_addr, prfl_sz;
 
@@ -1394,7 +1394,7 @@ static void npc_load_mkex_profile(struct rvu *rvu, int blkaddr,
 			 */
 			if (!is_rvu_96xx_B0(rvu) ||
 			    mcam_kex->keyx_cfg[NIX_INTF_RX] == mcam_kex->keyx_cfg[NIX_INTF_TX])
-				rvu->kpu.mkex = mcam_kex;
+				rvu->kpu.mcam_kex_prfl.mkex = mcam_kex;
 			goto program_mkex;
 		}
 
@@ -1404,9 +1404,10 @@ static void npc_load_mkex_profile(struct rvu *rvu, int blkaddr,
 	dev_warn(dev, "Failed to load requested profile: %s\n", mkex_profile);
 
 program_mkex:
-	dev_info(rvu->dev, "Using %s mkex profile\n", rvu->kpu.mkex->name);
+	dev_info(rvu->dev, "Using %s mkex profile\n",
+		 rvu->kpu.mcam_kex_prfl.mkex->name);
 	/* Program selected mkex profile */
-	npc_program_mkex_profile(rvu, blkaddr, rvu->kpu.mkex);
+	npc_program_mkex_profile(rvu, blkaddr, rvu->kpu.mcam_kex_prfl.mkex);
 	if (mkex_prfl_addr)
 		iounmap(mkex_prfl_addr);
 }
@@ -1525,7 +1526,8 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
 	rvu_write64(rvu, blkaddr, NPC_AF_KPUX_CFG(kpu), 0x01);
 }
 
-static int npc_prepare_default_kpu(struct npc_kpu_profile_adapter *profile)
+static void npc_prepare_default_kpu(struct rvu *rvu,
+				    struct npc_kpu_profile_adapter *profile)
 {
 	profile->custom = 0;
 	profile->name = def_pfl_name;
@@ -1535,23 +1537,38 @@ static int npc_prepare_default_kpu(struct npc_kpu_profile_adapter *profile)
 	profile->kpu = npc_kpu_profiles;
 	profile->kpus = ARRAY_SIZE(npc_kpu_profiles);
 	profile->lt_def = &npc_lt_defaults;
-	profile->mkex = &npc_mkex_default;
 	profile->mkex_hash = &npc_mkex_hash_default;
 
-	return 0;
+	if (!is_cn20k(rvu->pdev)) {
+		profile->mcam_kex_prfl.mkex = &npc_mkex_default;
+		return;
+	}
+
+	profile->mcam_kex_prfl.mkex_extr = npc_mkex_extr_default_get();
+	ikpu_action_entries[NPC_RX_CPT_HDR_PKIND].offset = 6;
+	ikpu_action_entries[NPC_RX_CPT_HDR_PKIND].mask = 0xe0;
+	ikpu_action_entries[NPC_RX_CPT_HDR_PKIND].shift = 0x5;
+	ikpu_action_entries[NPC_RX_CPT_HDR_PKIND].right = 0x1;
+
+	npc_cn20k_update_action_entries_n_flags(rvu, profile);
 }
 
 static int npc_apply_custom_kpu(struct rvu *rvu,
 				struct npc_kpu_profile_adapter *profile)
 {
 	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
-	struct npc_kpu_profile_fwdata *fw = rvu->kpu_fwdata;
 	struct npc_kpu_profile_action *action;
+	struct npc_kpu_profile_fwdata *fw;
 	struct npc_kpu_profile_cam *cam;
 	struct npc_kpu_fwdata *fw_kpu;
 	int entries;
 	u16 kpu, entry;
 
+	if (is_cn20k(rvu->pdev))
+		return npc_cn20k_apply_custom_kpu(rvu, profile);
+
+	fw = rvu->kpu_fwdata;
+
 	if (rvu->kpu_fwdata_sz < hdr_sz) {
 		dev_warn(rvu->dev, "Invalid KPU profile size\n");
 		return -EINVAL;
@@ -1592,7 +1609,7 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
 	profile->custom = 1;
 	profile->name = fw->name;
 	profile->version = le64_to_cpu(fw->version);
-	profile->mkex = &fw->mkex;
+	profile->mcam_kex_prfl.mkex = &fw->mkex;
 	profile->lt_def = &fw->lt_def;
 
 	for (kpu = 0; kpu < fw->kpus; kpu++) {
@@ -1717,7 +1734,7 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	if (!strncmp(kpu_profile, def_pfl_name, KPU_NAME_LEN))
 		goto revert_to_default;
 	/* First prepare default KPU, then we'll customize top entries. */
-	npc_prepare_default_kpu(profile);
+	npc_prepare_default_kpu(rvu, profile);
 
 	/* Order of preceedence for load loading NPC profile (high to low)
 	 * Firmware binary in filesystem.
@@ -1780,7 +1797,7 @@ void npc_load_kpu_profile(struct rvu *rvu)
 	return;
 
 revert_to_default:
-	npc_prepare_default_kpu(profile);
+	npc_prepare_default_kpu(rvu, profile);
 }
 
 static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
@@ -2029,12 +2046,21 @@ static void rvu_npc_hw_init(struct rvu *rvu, int blkaddr)
 
 static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 {
-	struct npc_mcam_kex *mkex = rvu->kpu.mkex;
+	struct npc_mcam_kex_extr *mkex_extr = rvu->kpu.mcam_kex_prfl.mkex_extr;
+	struct npc_mcam_kex *mkex = rvu->kpu.mcam_kex_prfl.mkex;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u64 nibble_ena, rx_kex, tx_kex;
+	u64 *keyx_cfg;
 	u8 intf;
 
+	if (is_cn20k(rvu->pdev)) {
+		keyx_cfg = mkex_extr->keyx_cfg;
+		goto skip_miss_cntr;
+	}
+
+	keyx_cfg = mkex->keyx_cfg;
+
 	/* Reserve last counter for MCAM RX miss action which is set to
 	 * drop packet. This way we will know how many pkts didn't match
 	 * any MCAM entry.
@@ -2042,15 +2068,17 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 	mcam->counters.max--;
 	mcam->rx_miss_act_cntr = mcam->counters.max;
 
-	rx_kex = mkex->keyx_cfg[NIX_INTF_RX];
-	tx_kex = mkex->keyx_cfg[NIX_INTF_TX];
+skip_miss_cntr:
+	rx_kex = keyx_cfg[NIX_INTF_RX];
+	tx_kex = keyx_cfg[NIX_INTF_TX];
+
 	nibble_ena = FIELD_GET(NPC_PARSE_NIBBLE, rx_kex);
 
 	nibble_ena = rvu_npc_get_tx_nibble_cfg(rvu, nibble_ena);
 	if (nibble_ena) {
 		tx_kex &= ~NPC_PARSE_NIBBLE;
 		tx_kex |= FIELD_PREP(NPC_PARSE_NIBBLE, nibble_ena);
-		mkex->keyx_cfg[NIX_INTF_TX] = tx_kex;
+		keyx_cfg[NIX_INTF_TX] = tx_kex;
 	}
 
 	/* Configure RX interfaces */
@@ -2062,6 +2090,9 @@ static void rvu_npc_setup_interfaces(struct rvu *rvu, int blkaddr)
 		rvu_write64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf),
 			    rx_kex);
 
+		if (is_cn20k(rvu->pdev))
+			continue;
+
 		/* If MCAM lookup doesn't result in a match, drop the received
 		 * packet. And map this action to a counter to count dropped
 		 * packets.
@@ -2167,7 +2198,10 @@ int rvu_npc_init(struct rvu *rvu)
 
 	npc_config_secret_key(rvu, blkaddr);
 	/* Configure MKEX profile */
-	npc_load_mkex_profile(rvu, blkaddr, rvu->mkex_pfl_name);
+	if (is_cn20k(rvu->pdev))
+		npc_cn20k_load_mkex_profile(rvu, blkaddr, rvu->mkex_pfl_name);
+	else
+		npc_load_mkex_profile(rvu, blkaddr, rvu->mkex_pfl_name);
 
 	err = npc_mcam_rsrcs_init(rvu, blkaddr);
 	if (err)
@@ -2177,7 +2211,10 @@ int rvu_npc_init(struct rvu *rvu)
 	if (err) {
 		dev_err(rvu->dev,
 			"Incorrect mkex profile loaded using default mkex\n");
-		npc_load_mkex_profile(rvu, blkaddr, def_pfl_name);
+		if (is_cn20k(rvu->pdev))
+			npc_cn20k_load_mkex_profile(rvu, blkaddr, def_pfl_name);
+		else
+			npc_load_mkex_profile(rvu, blkaddr, def_pfl_name);
 	}
 
 	if (is_cn20k(rvu->pdev))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
index 80c63618ec47..346e6ada158e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -13,5 +13,7 @@ void npc_load_kpu_profile(struct rvu *rvu);
 void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
 			  const struct npc_kpu_profile_action *kpuaction,
 			  int kpu, int entry, bool pkind);
+int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
+			  u64 *size);
 
 #endif /* RVU_NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index b56395ac5a74..4817708d0af7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -12,6 +12,8 @@
 #include "npc.h"
 #include "rvu_npc_fs.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/reg.h"
+#include "cn20k/npc.h"
 
 static const char * const npc_flow_names[] = {
 	[NPC_DMAC]	= "dmac",
@@ -81,19 +83,26 @@ const char *npc_get_field_name(u8 hdr)
 /* Compute keyword masks and figure out the number of keywords a field
  * spans in the key.
  */
-static void npc_set_kw_masks(struct npc_mcam *mcam, u8 type,
+static void npc_set_kw_masks(struct rvu *rvu, struct npc_mcam *mcam, u8 type,
 			     u8 nr_bits, int start_kwi, int offset, u8 intf)
 {
 	struct npc_key_field *field = &mcam->rx_key_fields[type];
 	u8 bits_in_kw;
 	int max_kwi;
 
-	if (mcam->banks_per_entry == 1)
-		max_kwi = 1; /* NPC_MCAM_KEY_X1 */
-	else if (mcam->banks_per_entry == 2)
-		max_kwi = 3; /* NPC_MCAM_KEY_X2 */
-	else
-		max_kwi = 6; /* NPC_MCAM_KEY_X4 */
+	if (is_cn20k(rvu->pdev)) {
+		if (mcam->banks_per_entry == 1)
+			max_kwi = 3; /* NPC_MCAM_KEY_X2 */
+		else
+			max_kwi = 7; /* NPC_MCAM_KEY_X4 */
+	} else {
+		if (mcam->banks_per_entry == 1)
+			max_kwi = 1; /* NPC_MCAM_KEY_X1 */
+		else if (mcam->banks_per_entry == 2)
+			max_kwi = 3; /* NPC_MCAM_KEY_X2 */
+		else
+			max_kwi = 6; /* NPC_MCAM_KEY_X4 */
+	}
 
 	if (is_npc_intf_tx(intf))
 		field = &mcam->tx_key_fields[type];
@@ -155,7 +164,8 @@ static bool npc_is_same(struct npc_key_field *input,
 		     sizeof(struct npc_layer_mdata)) == 0;
 }
 
-static void npc_set_layer_mdata(struct npc_mcam *mcam, enum key_fields type,
+static void npc_set_layer_mdata(struct rvu *rvu,
+				struct npc_mcam *mcam, enum key_fields type,
 				u64 cfg, u8 lid, u8 lt, u8 intf)
 {
 	struct npc_key_field *input = &mcam->rx_key_fields[type];
@@ -165,13 +175,17 @@ static void npc_set_layer_mdata(struct npc_mcam *mcam, enum key_fields type,
 
 	input->layer_mdata.hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
 	input->layer_mdata.key = FIELD_GET(NPC_KEY_OFFSET, cfg);
-	input->layer_mdata.len = FIELD_GET(NPC_BYTESM, cfg) + 1;
+	if (is_cn20k(rvu->pdev))
+		input->layer_mdata.len = FIELD_GET(NPC_CN20K_BYTESM, cfg) + 1;
+	else
+		input->layer_mdata.len = FIELD_GET(NPC_BYTESM, cfg) + 1;
 	input->layer_mdata.ltype = lt;
 	input->layer_mdata.lid = lid;
 }
 
 static bool npc_check_overlap_fields(struct npc_key_field *input1,
-				     struct npc_key_field *input2)
+				     struct npc_key_field *input2,
+				     int max_kw)
 {
 	int kwi;
 
@@ -182,7 +196,7 @@ static bool npc_check_overlap_fields(struct npc_key_field *input1,
 	    input1->layer_mdata.ltype != input2->layer_mdata.ltype)
 		return false;
 
-	for (kwi = 0; kwi < NPC_MAX_KWS_IN_KEY; kwi++) {
+	for (kwi = 0; kwi < max_kw; kwi++) {
 		if (input1->kw_mask[kwi] & input2->kw_mask[kwi])
 			return true;
 	}
@@ -202,6 +216,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 	struct npc_key_field *dummy, *input;
 	int start_kwi, offset;
 	u8 nr_bits, lid, lt, ld;
+	int extr, kws;
 	u64 cfg;
 
 	dummy = &mcam->rx_key_fields[NPC_UNKNOWN];
@@ -212,6 +227,10 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 		input = &mcam->tx_key_fields[type];
 	}
 
+	if (is_cn20k(rvu->pdev))
+		goto skip_cn10k_config;
+
+	kws = NPC_MAX_KWS_IN_KEY - 1;
 	for (lid = start_lid; lid < NPC_MAX_LID; lid++) {
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++) {
@@ -221,8 +240,8 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 				if (!FIELD_GET(NPC_LDATA_EN, cfg))
 					continue;
 				memset(dummy, 0, sizeof(struct npc_key_field));
-				npc_set_layer_mdata(mcam, NPC_UNKNOWN, cfg,
-						    lid, lt, intf);
+				npc_set_layer_mdata(rvu, mcam, NPC_UNKNOWN,
+						    cfg, lid, lt, intf);
 				/* exclude input */
 				if (npc_is_same(input, dummy))
 					continue;
@@ -230,16 +249,50 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 				offset = (dummy->layer_mdata.key * 8) % 64;
 				nr_bits = dummy->layer_mdata.len * 8;
 				/* form KW masks */
-				npc_set_kw_masks(mcam, NPC_UNKNOWN, nr_bits,
-						 start_kwi, offset, intf);
+				npc_set_kw_masks(rvu, mcam, NPC_UNKNOWN,
+						 nr_bits, start_kwi,
+						 offset, intf);
 				/* check any input field bits falls in any
 				 * other field bits.
 				 */
-				if (npc_check_overlap_fields(dummy, input))
+				if (npc_check_overlap_fields(dummy, input,
+							     kws))
 					return true;
 			}
 		}
 	}
+	return false;
+
+skip_cn10k_config:
+	for (extr = 0 ; extr < rvu->hw->npc_kex_extr; extr++) {
+		lid = CN20K_GET_EXTR_LID(intf, extr);
+		if (lid < start_lid)
+			continue;
+		for (lt = 0; lt < NPC_MAX_LT; lt++) {
+			cfg = CN20K_GET_EXTR_LT(intf, extr, lt);
+			if (!FIELD_GET(NPC_LDATA_EN, cfg))
+				continue;
+
+			memset(dummy, 0, sizeof(struct npc_key_field));
+			npc_set_layer_mdata(rvu, mcam, NPC_UNKNOWN, cfg,
+					    lid, lt, intf);
+			/* exclude input */
+			if (npc_is_same(input, dummy))
+				continue;
+			start_kwi = dummy->layer_mdata.key / 8;
+			offset = (dummy->layer_mdata.key * 8) % 64;
+			nr_bits = dummy->layer_mdata.len * 8;
+			/* form KW masks */
+			npc_set_kw_masks(rvu, mcam, NPC_UNKNOWN, nr_bits,
+					 start_kwi, offset, intf);
+			/* check any input field bits falls in any other
+			 * field bits
+			 */
+			if (npc_check_overlap_fields(dummy, input,
+						     NPC_MAX_KWS_IN_KEY))
+				return true;
+		}
+	}
 
 	return false;
 }
@@ -253,7 +306,8 @@ static bool npc_check_field(struct rvu *rvu, int blkaddr, enum key_fields type,
 	return true;
 }
 
-static void npc_scan_exact_result(struct npc_mcam *mcam, u8 bit_number,
+static void npc_scan_exact_result(struct rvu *rvu,
+				  struct npc_mcam *mcam, u8 bit_number,
 				  u8 key_nibble, u8 intf)
 {
 	u8 offset = (key_nibble * 4) % 64; /* offset within key word */
@@ -269,10 +323,63 @@ static void npc_scan_exact_result(struct npc_mcam *mcam, u8 bit_number,
 	default:
 		return;
 	}
-	npc_set_kw_masks(mcam, type, nr_bits, kwi, offset, intf);
+	npc_set_kw_masks(rvu, mcam, type, nr_bits, kwi, offset, intf);
+}
+
+static void npc_cn20k_scan_parse_result(struct rvu *rvu, struct npc_mcam *mcam,
+					u8 bit_number, u8 key_nibble, u8 intf)
+{
+	u8 offset = (key_nibble * 4) % 64; /* offset within key word */
+	u8 kwi = (key_nibble * 4) / 64; /* which word in key */
+	u8 nr_bits = 4; /* bits in a nibble */
+	u8 type;
+
+	switch (bit_number) {
+	case 0 ... 2:
+		type = NPC_CHAN;
+		break;
+	case 3:
+		type = NPC_ERRLEV;
+		break;
+	case 4 ... 5:
+		type = NPC_ERRCODE;
+		break;
+	case 6:
+		type = NPC_LXMB;
+		break;
+	case 8:
+		type = NPC_LA;
+		break;
+	case 10:
+		type = NPC_LB;
+		break;
+	case 12:
+		type = NPC_LC;
+		break;
+	case 14:
+		type = NPC_LD;
+		break;
+	case 16:
+		type = NPC_LE;
+		break;
+	case 18:
+		type = NPC_LF;
+		break;
+	case 20:
+		type = NPC_LG;
+		break;
+	case 22:
+		type = NPC_LH;
+		break;
+	default:
+		return;
+	}
+
+	npc_set_kw_masks(rvu, mcam, type, nr_bits, kwi, offset, intf);
 }
 
-static void npc_scan_parse_result(struct npc_mcam *mcam, u8 bit_number,
+static void npc_scan_parse_result(struct rvu *rvu,
+				  struct npc_mcam *mcam, u8 bit_number,
 				  u8 key_nibble, u8 intf)
 {
 	u8 offset = (key_nibble * 4) % 64; /* offset within key word */
@@ -280,6 +387,12 @@ static void npc_scan_parse_result(struct npc_mcam *mcam, u8 bit_number,
 	u8 nr_bits = 4; /* bits in a nibble */
 	u8 type;
 
+	if (is_cn20k(rvu->pdev)) {
+		npc_cn20k_scan_parse_result(rvu, mcam, bit_number,
+					    key_nibble, intf);
+		return;
+	}
+
 	switch (bit_number) {
 	case 0 ... 2:
 		type = NPC_CHAN;
@@ -322,7 +435,7 @@ static void npc_scan_parse_result(struct npc_mcam *mcam, u8 bit_number,
 		return;
 	}
 
-	npc_set_kw_masks(mcam, type, nr_bits, kwi, offset, intf);
+	npc_set_kw_masks(rvu, mcam, type, nr_bits, kwi, offset, intf);
 }
 
 static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
@@ -343,8 +456,13 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	/* Inner VLAN TCI for double tagged frames */
 	struct npc_key_field *vlan_tag3;
 	u64 *features;
+	int i, max_kw;
 	u8 start_lid;
-	int i;
+
+	if (is_cn20k(rvu->pdev))
+		max_kw = NPC_MAX_KWS_IN_KEY;
+	else
+		max_kw = NPC_MAX_KWS_IN_KEY - 1;
 
 	key_fields = mcam->rx_key_fields;
 	features = &mcam->rx_features;
@@ -382,7 +500,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 
 	/* if key profile programmed extracts Ethertype from multiple layers */
 	if (etype_ether->nr_kws && etype_tag1->nr_kws) {
-		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+		for (i = 0; i < max_kw; i++) {
 			if (etype_ether->kw_mask[i] != etype_tag1->kw_mask[i]) {
 				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and tagged pkts.\n");
 				goto vlan_tci;
@@ -391,7 +509,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 		key_fields[NPC_ETYPE] = *etype_tag1;
 	}
 	if (etype_ether->nr_kws && etype_tag2->nr_kws) {
-		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+		for (i = 0; i < max_kw; i++) {
 			if (etype_ether->kw_mask[i] != etype_tag2->kw_mask[i]) {
 				dev_err(rvu->dev, "mkex: Etype pos is different for untagged and double tagged pkts.\n");
 				goto vlan_tci;
@@ -400,7 +518,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 		key_fields[NPC_ETYPE] = *etype_tag2;
 	}
 	if (etype_tag1->nr_kws && etype_tag2->nr_kws) {
-		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+		for (i = 0; i < max_kw; i++) {
 			if (etype_tag1->kw_mask[i] != etype_tag2->kw_mask[i]) {
 				dev_err(rvu->dev, "mkex: Etype pos is different for tagged and double tagged pkts.\n");
 				goto vlan_tci;
@@ -431,7 +549,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 
 	/* if key profile extracts outer vlan tci from multiple layers */
 	if (vlan_tag1->nr_kws && vlan_tag2->nr_kws) {
-		for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+		for (i = 0; i < max_kw; i++) {
 			if (vlan_tag1->kw_mask[i] != vlan_tag2->kw_mask[i]) {
 				dev_err(rvu->dev, "mkex: Out vlan tci pos is different for tagged and double tagged pkts.\n");
 				goto done;
@@ -466,7 +584,11 @@ static void npc_scan_ldata(struct rvu *rvu, int blkaddr, u8 lid,
 	/* starting KW index and starting bit position */
 	int start_kwi, offset;
 
-	nr_bytes = FIELD_GET(NPC_BYTESM, cfg) + 1;
+	if (is_cn20k(rvu->pdev))
+		nr_bytes = FIELD_GET(NPC_CN20K_BYTESM, cfg) + 1;
+	else
+		nr_bytes = FIELD_GET(NPC_BYTESM, cfg) + 1;
+
 	hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
 	key = FIELD_GET(NPC_KEY_OFFSET, cfg);
 
@@ -489,11 +611,12 @@ do {									       \
 		if ((hstart) >= hdr &&					       \
 		    ((hstart) + (hlen)) <= (hdr + nr_bytes)) {	               \
 			bit_offset = (hdr + nr_bytes - (hstart) - (hlen)) * 8; \
-			npc_set_layer_mdata(mcam, (name), cfg, lid, lt, intf); \
+			npc_set_layer_mdata(rvu, mcam, (name), cfg, lid, lt,   \
+									intf); \
 			offset += bit_offset;				       \
 			start_kwi += offset / 64;			       \
 			offset %= 64;					       \
-			npc_set_kw_masks(mcam, (name), (hlen) * 8,	       \
+			npc_set_kw_masks(rvu, mcam, (name), (hlen) * 8,	       \
 					 start_kwi, offset, intf);	       \
 		}							       \
 	}								       \
@@ -636,6 +759,7 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	u8 lid, lt, ld, bitnr;
 	u64 cfg, masked_cfg;
 	u8 key_nibble = 0;
+	int extr;
 
 	/* Scan and note how parse result is going to be in key.
 	 * A bit set in PARSE_NIBBLE_ENA corresponds to a nibble from
@@ -643,10 +767,22 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	 * will be concatenated in key.
 	 */
 	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(intf));
-	masked_cfg = cfg & NPC_PARSE_NIBBLE;
-	for_each_set_bit(bitnr, (unsigned long *)&masked_cfg, 31) {
-		npc_scan_parse_result(mcam, bitnr, key_nibble, intf);
-		key_nibble++;
+	if (is_cn20k(rvu->pdev)) {
+		masked_cfg = cfg & NPC_CN20K_PARSE_NIBBLE;
+		for_each_set_bit(bitnr, (unsigned long *)&masked_cfg,
+				 NPC_CN20K_TOTAL_NIBBLE) {
+			npc_scan_parse_result(rvu, mcam, bitnr,
+					      key_nibble, intf);
+			key_nibble++;
+		}
+	} else {
+		masked_cfg = cfg & NPC_PARSE_NIBBLE;
+		for_each_set_bit(bitnr, (unsigned long *)&masked_cfg,
+				 NPC_TOTAL_NIBBLE) {
+			npc_scan_parse_result(rvu, mcam, bitnr,
+					      key_nibble, intf);
+			key_nibble++;
+		}
 	}
 
 	/* Ignore exact match bits for mcam entries except the first rule
@@ -656,10 +792,13 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	masked_cfg = cfg & NPC_EXACT_NIBBLE;
 	bitnr = NPC_EXACT_NIBBLE_START;
 	for_each_set_bit_from(bitnr, (unsigned long *)&masked_cfg, NPC_EXACT_NIBBLE_END + 1) {
-		npc_scan_exact_result(mcam, bitnr, key_nibble, intf);
+		npc_scan_exact_result(rvu, mcam, bitnr, key_nibble, intf);
 		key_nibble++;
 	}
 
+	if (is_cn20k(rvu->pdev))
+		goto skip_cn10k_config;
+
 	/* Scan and note how layer data is going to be in key */
 	for (lid = 0; lid < NPC_MAX_LID; lid++) {
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
@@ -676,6 +815,19 @@ static int npc_scan_kex(struct rvu *rvu, int blkaddr, u8 intf)
 	}
 
 	return 0;
+
+skip_cn10k_config:
+	for (extr = 0 ; extr < rvu->hw->npc_kex_extr; extr++) {
+		lid = CN20K_GET_EXTR_LID(intf, extr);
+		for (lt = 0; lt < NPC_MAX_LT; lt++) {
+			cfg = CN20K_GET_EXTR_LT(intf, extr, lt);
+			if (!FIELD_GET(NPC_LDATA_EN, cfg))
+				continue;
+			npc_scan_ldata(rvu, blkaddr, lid, lt, cfg,
+				       intf);
+		}
+	}
+	return 0;
 }
 
 static int npc_scan_verify_kex(struct rvu *rvu, int blkaddr)
@@ -758,8 +910,8 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	struct mcam_entry dummy = { {0} };
 	struct npc_key_field *field;
 	u64 kw1, kw2, kw3;
+	int i, max_kw;
 	u8 shift;
-	int i;
 
 	field = &mcam->rx_key_fields[type];
 	if (is_npc_intf_tx(intf))
@@ -768,7 +920,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	if (!field->nr_kws)
 		return;
 
-	for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+	if (is_cn20k(rvu->pdev))
+		max_kw = NPC_MAX_KWS_IN_KEY;
+	else
+		max_kw = NPC_MAX_KWS_IN_KEY - 1;
+
+	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
 			continue;
 		/* place key value in kw[x] */
@@ -820,7 +977,7 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	/* dummy is ready with values and masks for given key
 	 * field now clear and update input entry with those
 	 */
-	for (i = 0; i < NPC_MAX_KWS_IN_KEY; i++) {
+	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
 			continue;
 		entry->kw[i] &= ~field->kw_mask[i];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 999f6d93c7fe..5ae046c93a82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -125,6 +125,9 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
 	int lid, lt, ld, hash_cnt = 0;
 
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	if (is_npc_intf_tx(intf))
 		return;
 
@@ -165,6 +168,9 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 	struct npc_mcam_kex_hash *mkex_hash = rvu->kpu.mkex_hash;
 	int lid, lt, ld, hash_cnt = 0;
 
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	if (is_npc_intf_rx(intf))
 		return;
 
@@ -224,6 +230,9 @@ void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 	struct rvu_hwinfo *hw = rvu->hw;
 	u64 cfg;
 
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	/* Check if hardware supports hash extraction */
 	if (!hwcap->npc_hash_extract)
 		return;
@@ -288,6 +297,9 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	u32 field_hash;
 	u8 hash_idx;
 
+	if (is_cn20k(rvu->pdev))
+		return;
+
 	if (!rvu->hw->cap.npc_hash_extract) {
 		dev_dbg(rvu->dev, "%s: Field hash extract feature is not supported\n", __func__);
 		return;
@@ -1874,6 +1886,9 @@ int rvu_npc_exact_init(struct rvu *rvu)
 	u64 cfg;
 	bool rc;
 
+	if (is_cn20k(rvu->pdev))
+		return 0;
+
 	/* Read NPC_AF_CONST3 and check for have exact
 	 * match functionality is present
 	 */
-- 
2.43.0


