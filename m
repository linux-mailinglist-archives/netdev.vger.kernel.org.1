Return-Path: <netdev+bounces-248348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7BD073D4
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F55E305480D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0D29B764;
	Fri,  9 Jan 2026 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lCjtIROw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297328DF2D;
	Fri,  9 Jan 2026 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937747; cv=none; b=llvh5JA274K+93PcllNoudS6Mes0+2wcnxGg9Oay4me6sPH+VM2DDkmdwKpjKS1Q6b5VChSq1Mh378OO+0pyUa4E775zYWyO5ZQKJXd+seXhWplkICT/cgFciljW9Jy/4F+2U8z+YmYV3LrgRNWBJX6zazyHaWwUKo0ANkJYL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937747; c=relaxed/simple;
	bh=TQMKqp1zGAK3/9q4h5lhNncCtcqO1V88DYOXK6/Bi/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWuLwqkxqd66z9Fc+cxqlH3Dna/VT3V0nSCtxBlyxKQmEgSW/SbCArYDtYM7nIDnJzrIW+xnF741Pu3MIwyQbpybY1o0XiJ+vJZwGxnIDp1pNhOO0u8uOY0Z/03kffxImdXFBYoLYeGA4VWjIvbrwITNubcdlzkpqSoEKDLcqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lCjtIROw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608Etkpt2094216;
	Thu, 8 Jan 2026 21:48:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	7+wDbHv1fmXdG6NzcLkIrPId7/0/+jDIyc9Ax6A9bY=; b=lCjtIROwqUM7p7a1n
	aCgTBejp0T87UWz60JbYkRqat4BmOpoXZQlINIXHCGChTjnPwMLAy6I9D0DdcMDb
	wY/8IFO9c72veA2I+3VZEq/qqOpo+GlazXNzjYit8eaTfAf30PNH3ujKxqDm95gZ
	RdhKR7hE+QPCJMV+BbEbBKFZeJlhD4evCc1zmndw7ssppNexFDQ/ju8MJNnqBqhj
	kczFkmJMxoVGeTFQIyeerIhdvGhnXqcwh4QhXJ0zx+IATMyFJ1WiAcFozwstJSP8
	sse7MekJADj3RcUcKe1ar8rUJbfnz9doOPz+5OLyjI/5frH4rKP0c1HRH8ch4hYm
	TMU9A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bj181bgda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:48:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:49:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:49:09 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3B7D35B692B;
	Thu,  8 Jan 2026 21:48:50 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 05/13] octeontx2-af: npc: cn20k: Allocate default MCAM indexes
Date: Fri, 9 Jan 2026 11:18:20 +0530
Message-ID: <20260109054828.1822307-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109054828.1822307-1-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX6GfwyKfAsTbR
 xDipK/dyf5RYFtZhsxx0Wd60041Aj938tmv36RKk65LVMluxfxyEDFZ+q8rexBLFY7F2hZaFqpk
 chc82UJetzxVZ1Tg7WyFTd50eOFaXIu8LF2RPZtZZ31iBBvqGNNl7EEiBQobzR+79LC+PSLre8j
 WJYfxEf90aURYEvpDhXfvfy8W4p1GPekFehwcNvW0u/TRXjWC2obvJ7SjFdWKjVG4ghYmmgoJHL
 06eqi2aCrG/eHnk10+/YyiLEJbQXQGqFozPN/B5KQMFUcwQ9bdX39S30aTsZsB3rL1vnRwix4fj
 9+lsbLX7tXCaHD/D3eQgoSbmTmuwrdi7RNIYo+5Tb3/Ls4PDqBxZLvG76LTsGKHRCPHmYb3zFol
 QfhnLIZi5VqULBW2v9+cMsJYHfyQ31ZwqV2XMSK4pZRdFlFGIqsxbFDyWoBRYLJ36tGpMA9xw0M
 eefUjD5Bl1RdqEE6R7g==
X-Authority-Analysis: v=2.4 cv=Vdf6/Vp9 c=1 sm=1 tr=0 ts=696096c7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=njG_chu-v0deECxusFoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: gEfFk2AJm52TieiuQAZf02B6vCmv-M9c
X-Proofpoint-ORIG-GUID: gEfFk2AJm52TieiuQAZf02B6vCmv-M9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

Reserving MCAM entries in the AF driver for installing default MCAM
entries is not an efficient allocation method, as it results in
significant wastage of entries. This patch allocates MCAM indexes for
promiscuous, multicast, broadcast, and unicast traffic in descending
order of indexes (from lower to higher priority) when the NIX LF is
attached to the PF/VF.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 361 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  28 ++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  36 +-
 .../marvell/octeontx2/nic/otx2_flows.c        |   2 +-
 7 files changed, 433 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 88d7f65d246c..cc5a2fde02b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -25,10 +25,28 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+static const char *npc_dft_rule_name[NPC_DFT_RULE_MAX_ID] = {
+	[NPC_DFT_RULE_PROMISC_ID] = "Promisc",
+	[NPC_DFT_RULE_MCAST_ID] = "Mcast",
+	[NPC_DFT_RULE_BCAST_ID] = "Bcast",
+	[NPC_DFT_RULE_UCAST_ID] = "Ucast",
+};
+
 #define KEX_EXTR_CFG(bytesm1, hdr_ofs, ena, key_ofs)		\
 		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
 		     ((key_ofs) & 0x3F))
 
+#define NPC_DFT_RULE_ID_MK(pcifunc, id) \
+	((pcifunc) | FIELD_PREP(GENMASK_ULL(31, 16), id))
+
+#define NPC_DFT_RULE_ID_2_PCIFUNC(rid) \
+	FIELD_GET(GENMASK_ULL(15, 0), rid)
+
+#define NPC_DFT_RULE_ID_2_ID(rid) \
+	FIELD_GET(GENMASK_ULL(31, 16), rid)
+
+#define NPC_DFT_RULE_PRIO 127
+
 static const char cn20k_def_pfl_name[] = "default";
 
 static struct npc_mcam_kex_extr npc_mkex_extr_default = {
@@ -2176,9 +2194,10 @@ rvu_mbox_handler_npc_cn20k_get_free_count(struct rvu *rvu,
 	return 0;
 }
 
-int rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
-					   struct msg_req *req,
-					   struct npc_cn20k_get_kex_cfg_rsp *rsp)
+int
+rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
+				       struct msg_req *req,
+				       struct npc_cn20k_get_kex_cfg_rsp *rsp)
 {
 	int extr, lt;
 
@@ -2396,6 +2415,340 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 	return cnt;
 }
 
+int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
+				u16 *mcast, u16 *promisc, u16 *ucast)
+{
+	u16 *ptr[4] = {promisc, mcast, bcast, ucast};
+	unsigned long idx;
+	bool set = false;
+	void *val;
+	int i, j;
+
+	if (!npc_priv.init_done)
+		return 0;
+
+	if (is_lbk_vf(rvu, pcifunc)) {
+		if (!ptr[0])
+			return -ENOMEM;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s:%d Failed to find %s index for pcifunc=%#x\n",
+				 __func__, __LINE__,
+				 npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				 pcifunc);
+
+			*ptr[0] = USHRT_MAX;
+			return -ESRCH;
+		}
+
+		*ptr[0] = xa_to_value(val);
+		return 0;
+	}
+
+	if (is_vf(pcifunc)) {
+		if (!ptr[3])
+			return -ENOMEM;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s:%d Failed to find %s index for pcifunc=%#x\n",
+				 __func__, __LINE__,
+				 npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				 pcifunc);
+
+			*ptr[3] = USHRT_MAX;
+			return -ESRCH;
+		}
+
+		*ptr[3] = xa_to_value(val);
+		return 0;
+	}
+
+	for (i = NPC_DFT_RULE_START_ID, j = 0; i < NPC_DFT_RULE_MAX_ID; i++,
+	     j++) {
+		if (!ptr[j])
+			continue;
+
+		idx = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		val = xa_load(&npc_priv.xa_pf2dfl_rmap, idx);
+		if (!val) {
+			pr_debug("%s:%d Failed to find %s index for pcifunc=%#x\n",
+				 __func__, __LINE__,
+				 npc_dft_rule_name[i], pcifunc);
+
+			*ptr[j] = USHRT_MAX;
+			continue;
+		}
+
+		*ptr[j] = xa_to_value(val);
+		set = true;
+	}
+
+	return  set ? 0 : -ESRCH;
+}
+
+static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
+{
+	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
+		is_lbk_vf(rvu, pcifunc);
+}
+
+void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
+{
+	struct npc_mcam_free_entry_req free_req = { 0 };
+	unsigned long index;
+	struct msg_rsp rsp;
+	u16 ptr[4];
+	int rc, i;
+	void *map;
+
+	if (!npc_priv.init_done)
+		return;
+
+	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
+		dev_dbg(rvu->dev,
+			"%s:%d dft rule allocation is only for cgx mapped device, pcifunc=%#x\n",
+			__func__, __LINE__, pcifunc);
+		return;
+	}
+
+	rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0], &ptr[1],
+					 &ptr[2], &ptr[3]);
+	if (rc)
+		return;
+
+	/* LBK */
+	if (is_lbk_vf(rvu, pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s:%d Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__, __LINE__,
+				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				pcifunc);
+
+		goto free_rules;
+	}
+
+	/* VF */
+	if (is_vf(pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s:%d Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__, __LINE__,
+				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				pcifunc);
+
+		goto free_rules;
+	}
+
+	/* PF */
+	for (i = NPC_DFT_RULE_START_ID; i < NPC_DFT_RULE_MAX_ID; i++)  {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		map = xa_erase(&npc_priv.xa_pf2dfl_rmap, index);
+		if (!map)
+			dev_dbg(rvu->dev,
+				"%s:%d Err from delete %s mcam idx from xarray (pcifunc=%#x\n",
+				__func__, __LINE__, npc_dft_rule_name[i],
+				pcifunc);
+	}
+
+free_rules:
+
+	free_req.hdr.pcifunc = pcifunc;
+	free_req.all = 1;
+	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
+	if (rc)
+		dev_err(rvu->dev,
+			"%s:%d Error deleting default entries (pcifunc=%#x\n",
+			__func__, __LINE__, pcifunc);
+}
+
+int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc)
+{
+	u16 mcam_idx[4] = { 0 }, pf_ucast, pf_pcifunc;
+	struct npc_mcam_alloc_entry_req req = { 0 };
+	struct npc_mcam_alloc_entry_rsp rsp = { 0 };
+	int ret, eidx, i, k, pf, cnt;
+	struct rvu_pfvf *pfvf;
+	unsigned long index;
+	u16 b, m, p, u;
+
+	if (!npc_priv.init_done)
+		return 0;
+
+	if (!npc_is_cgx_or_lbk(rvu, pcifunc)) {
+		dev_dbg(rvu->dev,
+			"%s:%d dft rule allocation is only for cgx mapped device, pcifunc=%#x\n",
+			__func__, __LINE__, pcifunc);
+		return 0;
+	}
+
+	/* Check if default rules are already alloced for this pcifunc */
+	ret =  npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &b, &m, &p, &u);
+	if (!ret) {
+		dev_err(rvu->dev,
+			"%s:%d default rules are already installed (pcifunc=%#x)\n",
+			__func__, __LINE__, pcifunc);
+		dev_err(rvu->dev,
+			"%s:%d bcast(%u) mcast(%u) promisc(%u) ucast(%u)\n",
+			__func__, __LINE__, b, m, p, u);
+		return 0;
+	}
+
+	/* Set ref index as lowest priority index */
+	eidx = 2 * npc_priv.bank_depth - 1;
+
+	/* Install only UCAST for VF */
+	cnt = is_vf(pcifunc) ? 1 : ARRAY_SIZE(mcam_idx);
+
+	/* For VF pcifunc, allocate default mcam indexes by taking
+	 * ref as PF's ucast index.
+	 */
+	if (is_vf(pcifunc)) {
+		pf = rvu_get_pf(rvu->pdev, pcifunc);
+		pf_pcifunc = pf << RVU_CN20K_PFVF_PF_SHIFT;
+
+		/* Get PF's ucast entry index */
+		ret = npc_cn20k_dft_rules_idx_get(rvu, pf_pcifunc, NULL,
+						  NULL, NULL, &pf_ucast);
+
+		/* There is no PF rules installed; and VF installation comes
+		 * first. PF may come later.
+		 * TODO: Install PF rules before installing VF rules.
+		 */
+
+		/* Set PF's ucast as ref entry */
+		if (!ret)
+			eidx = pf_ucast;
+	}
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	pfvf->hw_prio = NPC_DFT_RULE_PRIO;
+
+	req.contig = false;
+	req.ref_prio = NPC_MCAM_HIGHER_PRIO;
+	req.ref_entry = eidx;
+	req.kw_type = NPC_MCAM_KEY_X2;
+	req.count = cnt;
+	req.hdr.pcifunc = pcifunc;
+
+	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
+
+	/* successfully allocated index */
+	if (!ret) {
+		/* Copy indexes to local array */
+		for (i = 0; i < cnt; i++)
+			mcam_idx[i] = rsp.entry_list[i];
+
+		goto chk_sanity;
+	}
+
+	/* If there is no slots available and request is for PF,
+	 * return error.
+	 */
+	if (!is_vf(pcifunc)) {
+		dev_err(rvu->dev,
+			"%s:%d Default index allocation failed for pcifunc=%#x\n",
+			__func__, __LINE__, pcifunc);
+		return ret;
+	}
+
+	/* We could not find an index with higher priority index for VF.
+	 * Find rule with lower priority index and set hardware priority
+	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
+	 */
+	req.contig = false;
+	req.kw_type = NPC_MCAM_KEY_X2;
+	req.count = cnt;
+	req.hdr.pcifunc = pcifunc;
+	req.ref_prio = NPC_MCAM_LOWER_PRIO;
+	req.ref_entry = eidx + 1;
+	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);
+	if (ret) {
+		dev_err(rvu->dev,
+			"%s:%d Default index allocation failed for pcifunc=%#x\n",
+			__func__, __LINE__, pcifunc);
+		return ret;
+	}
+
+	/* Copy indexes to local array */
+	for (i = 0; i < cnt; i++)
+		mcam_idx[i] = rsp.entry_list[i];
+
+	pfvf->hw_prio = NPC_DFT_RULE_PRIO - 1;
+
+chk_sanity:
+	dev_dbg(rvu->dev,
+		"%s:%d Default index for pcifunc=%#x, bcast=%u mcast=%u promise=%u ucast=%u cnt=%u\n",
+		__func__, __LINE__, pcifunc, mcam_idx[0], mcam_idx[1],
+		mcam_idx[2], mcam_idx[3], cnt);
+
+	/* LBK */
+	if (is_lbk_vf(rvu, pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_PROMISC_ID);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s:%d Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__, __LINE__,
+				npc_dft_rule_name[NPC_DFT_RULE_PROMISC_ID],
+				pcifunc);
+			ret = -EFAULT;
+			goto err;
+		}
+
+		goto done;
+	}
+
+	/* VF */
+	if (is_vf(pcifunc)) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, NPC_DFT_RULE_UCAST_ID);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[0]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s:%d Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__, __LINE__,
+				npc_dft_rule_name[NPC_DFT_RULE_UCAST_ID],
+				pcifunc);
+			ret = -EFAULT;
+			goto err;
+		}
+
+		goto done;
+	}
+
+	/* PF */
+	for (i = NPC_DFT_RULE_START_ID, k = 0; i < NPC_DFT_RULE_MAX_ID &&
+	     k < cnt; i++, k++) {
+		index = NPC_DFT_RULE_ID_MK(pcifunc, i);
+		ret = xa_insert(&npc_priv.xa_pf2dfl_rmap, index,
+				xa_mk_value(mcam_idx[k]), GFP_KERNEL);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s:%d Err to insert %s mcam idx to xarray pcifunc=%#x\n",
+				__func__, __LINE__, npc_dft_rule_name[i],
+				pcifunc);
+			ret = -EFAULT;
+			goto err;
+		}
+	}
+
+done:
+	return 0;
+err:
+	/* TODO: handle errors */
+	return ret;
+}
+
 static int npc_priv_init(struct rvu *rvu)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
@@ -2446,6 +2799,7 @@ static int npc_priv_init(struct rvu *rvu)
 	xa_init_flags(&npc_priv.xa_sb_free, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
 
 	if (npc_create_srch_order(num_subbanks)) {
 		kfree(npc_priv.sb);
@@ -2483,6 +2837,7 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	xa_destroy(&npc_priv.xa_sb_free);
 	xa_destroy(&npc_priv.xa_idx2pf_map);
 	xa_destroy(&npc_priv.xa_pf_map);
+	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
 
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 461fb10e25a6..f3fca233ef57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -95,6 +95,26 @@ enum npc_subbank_flag {
 	NPC_SUBBANK_FLAG_USED = BIT(1), /* At least one slot allocated */
 };
 
+/**
+ * enum npc_dft_rule_id - Default rule type
+ *
+ * Mcam default rule type.
+ *
+ * @NPC_DFT_RULE_START_ID: Not used
+ * @NPC_DFT_RULE_PROMISC_ID:  promiscuous rule
+ * @NPC_DFT_RULE_MCAST_ID:  promiscuous rule
+ * @NPC_DFT_RULE_BCAST_ID:  broadcast rule
+ * @NPC_DFT_RULE_UCAST_ID:  unicast rule
+ */
+enum npc_dft_rule_id {
+	NPC_DFT_RULE_START_ID = 1,
+	NPC_DFT_RULE_PROMISC_ID = NPC_DFT_RULE_START_ID,
+	NPC_DFT_RULE_MCAST_ID,
+	NPC_DFT_RULE_BCAST_ID,
+	NPC_DFT_RULE_UCAST_ID,
+	NPC_DFT_RULE_MAX_ID,
+};
+
 /**
  * struct npc_subbank - Subbank fields.
  * @b0b:	Subbanks bottom index for bank0
@@ -140,6 +160,7 @@ struct npc_subbank {
  * @xa_pf_map:		Pcifunc to index map.
  * @pf_cnt:		Number of PFs.A
  * @init_don:		Indicates MCAM initialization is done.
+ * @xa_pf2dfl_rmap:	PF to default rule index map.
  *
  * This structure is populated during probing time by reading
  * HW csr registers.
@@ -156,6 +177,7 @@ struct npc_priv_t {
 	struct xarray *xa_pf2idx_map;	/* Each PF to map its mcam idxes */
 	struct xarray xa_idx2pf_map;	/* Mcam idxes to pf map. */
 	struct xarray xa_pf_map;	/* pcifunc to index map. */
+	struct xarray xa_pf2dfl_rmap;	/* pcifunc to default rule index */
 	int pf_cnt;
 	bool init_done;
 };
@@ -262,4 +284,10 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu, struct npc_kpu_profile_adapter *
 void
 npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
 					struct npc_kpu_profile_adapter *profile);
+
+int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u16 pcifunc);
+void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc);
+
+int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
+				u16 *mcast, u16 *promisc, u16 *ucast);
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2b413c99a841..49c9ee15c74f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1539,9 +1539,10 @@ struct npc_mcam_alloc_entry_req {
 #define NPC_MCAM_ANY_PRIO		0
 #define NPC_MCAM_LOWER_PRIO		1
 #define NPC_MCAM_HIGHER_PRIO		2
-	u8  priority; /* Lower or higher w.r.t ref_entry */
+	u8  ref_prio; /* Lower or higher w.r.t ref_entry */
 	u16 ref_entry;
 	u16 count;    /* Number of entries requested */
+	u8 kw_type; /* entry key type, valid for cn20k */
 };
 
 struct npc_mcam_alloc_entry_rsp {
@@ -1634,10 +1635,12 @@ struct npc_mcam_alloc_and_write_entry_req {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry_data;
 	u16 ref_entry;
-	u8  priority;    /* Lower or higher w.r.t ref_entry */
+	u8  ref_prio;    /* Lower or higher w.r.t ref_entry */
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  alloc_cntr;  /* Allocate counter and map ? */
+	/* hardware priority, supported for cn20k */
+	u8 hw_prio;
 };
 
 struct npc_mcam_alloc_and_write_entry_rsp {
@@ -1790,6 +1793,7 @@ struct npc_install_flow_req {
 	u8  vtag1_op;
 	/* old counter value */
 	u16 cntr_val;
+	u8 hw_prio;
 };
 
 struct npc_install_flow_rsp {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 2d78e08f985f..df02caedc020 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -22,6 +22,7 @@
 #include "rvu_npc_hash.h"
 #include "cn20k/reg.h"
 #include "cn20k/api.h"
+#include "cn20k/npc.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -1396,7 +1397,6 @@ static void rvu_detach_block(struct rvu *rvu, int pcifunc, int blktype)
 	if (blkaddr < 0)
 		return;
 
-
 	block = &hw->block[blkaddr];
 
 	num_lfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
@@ -1467,6 +1467,13 @@ static int rvu_detach_rsrcs(struct rvu *rvu, struct rsrc_detach *detach,
 			else if ((blkid == BLKADDR_CPT1) && !detach->cptlfs)
 				continue;
 		}
+
+		if (detach_all ||
+		    (detach && (blkid == BLKADDR_NIX0 ||
+				blkid == BLKADDR_NIX1) &&
+		     detach->nixlf))
+			npc_cn20k_dft_rules_free(rvu, pcifunc);
+
 		rvu_detach_block(rvu, pcifunc, block->type);
 	}
 
@@ -1738,8 +1745,14 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 	if (attach->npalf)
 		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
 
-	if (attach->nixlf)
+	if (attach->nixlf) {
 		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
+		if (is_cn20k(rvu->pdev)) {
+			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
+			if (err)
+				goto exit;
+		}
+	}
 
 	if (attach->sso) {
 		/* RVU func doesn't know which exact LF or slot is attached
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index dd930aa05582..d2a0f6821cf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -308,6 +308,7 @@ struct rvu_pfvf {
 	u64     lmt_map_ent_w1; /* Preseving the word1 of lmtst map table entry*/
 	unsigned long flags;
 	struct  sdp_node_info *sdp_info;
+	u8	hw_prio;   /* Hw priority of default rules */
 };
 
 enum rvu_pfvf_flags {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 8361d0aa4b6f..246f3568a795 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -653,6 +653,9 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	req.match_id = action.match_id;
 	req.flow_key_alg = action.flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -741,6 +744,9 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	req.match_id = action.match_id;
 	req.flow_key_alg = flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -821,6 +827,9 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 	req.hdr.pcifunc = 0; /* AF is requester */
 	req.vf = pcifunc;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -909,6 +918,9 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	req.match_id = action.match_id;
 	req.flow_key_alg = flow_key_alg;
 
+	if (is_cn20k(rvu->pdev))
+		req.hw_prio = pfvf->hw_prio;
+
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
 
@@ -2484,7 +2496,7 @@ npc_get_mcam_search_range_priority(struct npc_mcam *mcam,
 {
 	u16 fcnt;
 
-	if (req->priority == NPC_MCAM_HIGHER_PRIO)
+	if (req->ref_prio == NPC_MCAM_HIGHER_PRIO)
 		goto hprio;
 
 	/* For a low priority entry allocation
@@ -2584,7 +2596,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		goto lprio_alloc;
 
 	/* Get the search range for priority allocation request */
-	if (req->priority) {
+	if (req->ref_prio) {
 		npc_get_mcam_search_range_priority(mcam, req,
 						   &start, &end, &reverse);
 		goto alloc;
@@ -2625,11 +2637,11 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 		 * and not in mid zone.
 		 */
 		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
-		    req->priority == NPC_MCAM_HIGHER_PRIO)
+		    req->ref_prio == NPC_MCAM_HIGHER_PRIO)
 			end = req->ref_entry;
 
 		if (!(pcifunc & RVU_PFVF_FUNC_MASK) &&
-		    req->priority == NPC_MCAM_LOWER_PRIO)
+		    req->ref_prio == NPC_MCAM_LOWER_PRIO)
 			start = req->ref_entry;
 	}
 
@@ -2678,7 +2690,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	/* If allocating requested no of entries is unsucessful,
 	 * expand the search range to full bitmap length and retry.
 	 */
-	if (!req->priority && (rsp->count < req->count) &&
+	if (!req->ref_prio && rsp->count < req->count &&
 	    ((end - start) != mcam->bmap_entries)) {
 		reverse = true;
 		start = 0;
@@ -2689,14 +2701,14 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	/* For priority entry allocation requests, if allocation is
 	 * failed then expand search to max possible range and retry.
 	 */
-	if (req->priority && rsp->count < req->count) {
-		if (req->priority == NPC_MCAM_LOWER_PRIO &&
+	if (req->ref_prio && rsp->count < req->count) {
+		if (req->ref_prio == NPC_MCAM_LOWER_PRIO &&
 		    (start != (req->ref_entry + 1))) {
 			start = req->ref_entry + 1;
 			end = mcam->bmap_entries;
 			reverse = false;
 			goto alloc;
-		} else if ((req->priority == NPC_MCAM_HIGHER_PRIO) &&
+		} else if ((req->ref_prio == NPC_MCAM_HIGHER_PRIO) &&
 			   ((end - start) != req->ref_entry)) {
 			start = 0;
 			end = req->ref_entry;
@@ -2810,9 +2822,9 @@ int rvu_mbox_handler_npc_mcam_alloc_entry(struct rvu *rvu,
 	/* ref_entry can't be '0' if requested priority is high.
 	 * Can't be last entry if requested priority is low.
 	 */
-	if ((!req->ref_entry && req->priority == NPC_MCAM_HIGHER_PRIO) ||
-	    ((req->ref_entry == mcam->bmap_entries) &&
-	     req->priority == NPC_MCAM_LOWER_PRIO))
+	if ((!req->ref_entry && req->ref_prio == NPC_MCAM_HIGHER_PRIO) ||
+	    (req->ref_entry == mcam->bmap_entries &&
+	     req->ref_prio == NPC_MCAM_LOWER_PRIO))
 		return NPC_MCAM_INVALID_REQ;
 
 	/* Since list of allocated indices needs to be sent to requester,
@@ -3358,7 +3370,7 @@ int rvu_mbox_handler_npc_mcam_alloc_and_write_entry(struct rvu *rvu,
 	/* Try to allocate a MCAM entry */
 	entry_req.hdr.pcifunc = req->hdr.pcifunc;
 	entry_req.contig = true;
-	entry_req.priority = req->priority;
+	entry_req.ref_prio = req->ref_prio;
 	entry_req.ref_entry = req->ref_entry;
 	entry_req.count = 1;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 64c6d9162ef6..052d989f2d9a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -104,7 +104,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		 * will be on top of PF.
 		 */
 		if (!is_otx2_vf(pfvf->pcifunc)) {
-			req->priority = NPC_MCAM_HIGHER_PRIO;
+			req->ref_prio = NPC_MCAM_HIGHER_PRIO;
 			req->ref_entry = flow_cfg->def_ent[0];
 		}
 
-- 
2.43.0


