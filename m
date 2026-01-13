Return-Path: <netdev+bounces-249399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B4D17FB7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E2A4304486F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E738F92E;
	Tue, 13 Jan 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kdWGfqMy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139738B9BC;
	Tue, 13 Jan 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299467; cv=none; b=JmDVf+QTTMlUJhi3lI/Z4HmX/KORkTDiLQ3FnEZeC3w/+P6nA8AlceUb9r4uqFDb3cO9CKWdG8fxyxR+hJpfwuyOnPqlhvddna4XBPtO8LuoXYx3sDizxGCShaMAs7vMgyaaLVV7waxd9X9iA9ei0rbwB2qkdybcP3SeWMhlTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299467; c=relaxed/simple;
	bh=593DTofvXviFmuZLrTw7IXR50QKflXoixVBzuhfRRvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQ1ivCCHJDa3i1oMi8NTZ8j7A6kpyqRUSlMaveMZnruJKwOE27DSpYv9I2tJG20xdwhtGKoEuxqigbQAVrO29wAfRoE5V35JtbpqFPMwZaq/irxJRO2JESOGdOLcawQSrhvjDlyGGayEGu3lCUmwBBAMbCf68SmkAexrAehfFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kdWGfqMy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q96d3356474;
	Tue, 13 Jan 2026 02:17:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	ANV5zVDra6e9+3f5htu6jkJ9H/r3Hq7lfr8dni5QLI=; b=kdWGfqMytwTXJ5qBQ
	kZ/jNr+tUk7lq7rCwdo/mYKKVC29SpOEvwSdowR55hl5XC73nge6sqcYsJwapVec
	5ozVTfXEVuLivPNcay8zt5RbyXhYyWCSFedMIlaaTQyZUP0kFTpjgA0qcBSXeJVW
	pY85XLtadUdwfkMP9uqPPU1BvZplkxYZCghajTNfDj0d2G5QGw0FqC/tXvsmU2vK
	X/gqrq0s7yse9+XIcKwpZPoB1MgckZLKcIhbERk/P2ZjPJwuekISqhFe671gfJLJ
	YUx/UC1nxaSLDGIG54lWuGEmT5uHIoFy9KzOCrYRp5m/dXBMMghGDxnmnQF53T/h
	JnFHw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8t4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:17:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:17:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:17:49 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 58E733F7096;
	Tue, 13 Jan 2026 02:17:31 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v4 09/13] octeontx2-af: npc: cn20k: virtual index support
Date: Tue, 13 Jan 2026 15:46:54 +0530
Message-ID: <20260113101658.4144610-10-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: aD1PfS0_8lyxAaM920An36fvAw07RRTc
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=69661bbe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=fjqsRaPkeSi4bENy-HUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aD1PfS0_8lyxAaM920An36fvAw07RRTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NyBTYWx0ZWRfX90vI9wpwovpR
 vEFO270DvoB5Bc8Tx7PlhOurn+ldXCsHdIk7Tk+rIPvDfUHi6zCuyfCWsQm965lGiUjq0fWIcqB
 B/2THkPovAzQ8hVxDJYPogrk2F7ojtjAkWOGrw09ClVTUqWNWvf8qME/REzHiDd6xzyjNKJ+QK+
 xV3P7MLQ/ipIE6ga5rq+t+3wMFmqfKKi06YYx87SKs4gkeTOQ0QgaMofwLBHKhBFtrhqzFS3SEo
 xg/BaFvKC32Bh+vUX2joSKvao0Y2/N/aazZWyBG1RVy0mmWiG8ihVHSjntVAzXYaTT4Pdhnehdq
 FCp/rKzYJdPCDGHiXeT2rV8KOrI/GqGVclk9mNKqExuCZEvj6rnlsAqse+LnVx0fcrvllOdccOr
 XtACI907VvaC6XwvINU7rxSJjmT9zoM1Hr24+PBzqHs7N2ZGk9SEhCZV4FildcWta45yTnUnqcp
 8Xn1PWWjhK40gdxcl9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

This patch adds support for virtual MCAM index allocation and
improves CN20K MCAM defragmentation handling. A new field is
introduced in the non-ref, non-contiguous MCAM allocation mailbox
request to indicate that virtual indexes should be returned instead
of physical ones. Virtual indexes allow the hardware to move mapped
MCAM entries internally, enabling defragmentation and preventing
scattered allocations across subbanks. The patch also enhances
defragmentation by treating non-ref, non-contiguous allocations as
ideal candidates for packing sparsely used regions, which can free
up subbanks for potential x2 or x4 configuration. All such
allocations are tracked and always returned as virtual indexes so
they remain stable even when entries are moved during defrag.
During defragmentation, MCAM entries may shift between subbanks,
but their virtual indexes remain unchanged. Additionally, this
update fixes an issue where entry statistics were not being
restored correctly after defragmentation.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 779 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  30 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +
 .../marvell/octeontx2/af/rvu_devlink.c        |  81 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  22 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   2 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   6 +
 7 files changed, 902 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index d549e75b2cb0..334b80ebec69 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -215,6 +215,204 @@ struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void)
 	return &npc_mkex_extr_default;
 }
 
+static u16 npc_idx2vidx(u16 idx)
+{
+	unsigned long index;
+	void *map;
+	u16 vidx;
+	int val;
+
+	vidx = idx;
+	index = idx;
+
+	map = xa_load(&npc_priv.xa_idx2vidx_map, index);
+	if (!map)
+		goto done;
+
+	val = xa_to_value(map);
+	if (val == -1)
+		goto done;
+
+	vidx = val;
+
+done:
+	return vidx;
+}
+
+static bool npc_is_vidx(u16 vidx)
+{
+	return vidx >= npc_priv.bank_depth * 2;
+}
+
+static u16 npc_vidx2idx(u16 vidx)
+{
+	unsigned long index;
+	void *map;
+	int val;
+	u16 idx;
+
+	idx = vidx;
+	index = vidx;
+
+	map = xa_load(&npc_priv.xa_vidx2idx_map, index);
+	if (!map)
+		goto done;
+
+	val = xa_to_value(map);
+	if (val == -1)
+		goto done;
+
+	idx = val;
+
+done:
+	return idx;
+}
+
+u16 npc_cn20k_vidx2idx(u16 idx)
+{
+	if (!npc_priv.init_done)
+		return idx;
+
+	if (!npc_is_vidx(idx))
+		return idx;
+
+	return npc_vidx2idx(idx);
+}
+
+u16 npc_cn20k_idx2vidx(u16 idx)
+{
+	if (!npc_priv.init_done)
+		return idx;
+
+	if (npc_is_vidx(idx))
+		return idx;
+
+	return npc_idx2vidx(idx);
+}
+
+static int npc_vidx_maps_del_entry(struct rvu *rvu, u16 vidx, u16 *old_midx)
+{
+	u16 mcam_idx;
+	void *map;
+
+	if (!npc_is_vidx(vidx)) {
+		dev_err(rvu->dev,
+			"%s: vidx(%u) does not map to proper mcam idx\n",
+			__func__, vidx);
+		return -ESRCH;
+	}
+
+	mcam_idx = npc_vidx2idx(vidx);
+
+	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s: vidx(%u) does not map to proper mcam idx\n",
+			__func__, vidx);
+		return -ESRCH;
+	}
+
+	map = xa_erase(&npc_priv.xa_idx2vidx_map, mcam_idx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s: mcam idx(%u) is not valid\n",
+			__func__, vidx);
+		return -ESRCH;
+	}
+
+	if (old_midx)
+		*old_midx = mcam_idx;
+
+	return 0;
+}
+
+static int npc_vidx_maps_modify(struct rvu *rvu, u16 vidx, u16 new_midx)
+{
+	u16 old_midx;
+	void *map;
+	int rc;
+
+	if (!npc_is_vidx(vidx)) {
+		dev_err(rvu->dev,
+			"%s: vidx(%u) does not map to proper mcam idx\n",
+			__func__, vidx);
+		return -ESRCH;
+	}
+
+	map = xa_erase(&npc_priv.xa_vidx2idx_map, vidx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s: vidx(%u) could not be deleted from vidx2idx map\n",
+			__func__, vidx);
+		return -ESRCH;
+	}
+
+	old_midx = xa_to_value(map);
+
+	rc = xa_insert(&npc_priv.xa_vidx2idx_map, vidx,
+		       xa_mk_value(new_midx), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s: vidx(%u) cannot be added to vidx2idx map\n",
+			__func__, vidx);
+		return rc;
+	}
+
+	map = xa_erase(&npc_priv.xa_idx2vidx_map, old_midx);
+	if (!map) {
+		dev_err(rvu->dev,
+			"%s: old_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
+			__func__, old_midx, vidx);
+		return -ESRCH;
+	}
+
+	rc = xa_insert(&npc_priv.xa_idx2vidx_map, new_midx,
+		       xa_mk_value(vidx), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s: new_midx(%u, vidx(%u)) cannot be added to idx2vidx map\n",
+			__func__, new_midx, vidx);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int npc_vidx_maps_add_entry(struct rvu *rvu, u16 mcam_idx, int pcifunc,
+				   u16 *vidx)
+{
+	int rc, max, min;
+	u32 id;
+
+	/* Virtual index start from maximum mcam index + 1 */
+	max = npc_priv.bank_depth * 2 * 2 - 1;
+	min = npc_priv.bank_depth * 2;
+
+	rc = xa_alloc(&npc_priv.xa_vidx2idx_map, &id,
+		      xa_mk_value(mcam_idx),
+		      XA_LIMIT(min, max), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s: Failed to add to vidx2idx map (%u)\n",
+			__func__, mcam_idx);
+		return rc;
+	}
+
+	rc = xa_insert(&npc_priv.xa_idx2vidx_map, mcam_idx,
+		       xa_mk_value(id), GFP_KERNEL);
+	if (rc) {
+		dev_err(rvu->dev,
+			"%s: Failed to add to idx2vidx map (%u)\n",
+			__func__, mcam_idx);
+		return rc;
+	}
+
+	if (vidx)
+		*vidx = id;
+
+	return 0;
+}
+
 static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpm, int entry)
@@ -1040,6 +1238,8 @@ int rvu_mbox_handler_npc_cn20k_mcam_write_entry(struct rvu *rvu,
 	int blkaddr, rc;
 	u8 nix_intf;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -1081,6 +1281,8 @@ int rvu_mbox_handler_npc_cn20k_mcam_read_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -1121,6 +1323,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	entry_req.ref_prio = req->ref_prio;
 	entry_req.ref_entry = req->ref_entry;
 	entry_req.count = 1;
+	entry_req.virt = req->virt;
 
 	rc = rvu_mbox_handler_npc_mcam_alloc_entry(rvu,
 						   &entry_req, &entry_rsp);
@@ -1130,7 +1333,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 	if (!entry_rsp.count)
 		return NPC_MCAM_ALLOC_FAILED;
 
-	entry = entry_rsp.entry;
+	entry = npc_cn20k_vidx2idx(entry_rsp.entry);
 	mutex_lock(&mcam->lock);
 
 	if (is_npc_intf_tx(req->intf))
@@ -1144,7 +1347,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 
 	mutex_unlock(&mcam->lock);
 
-	rsp->entry = entry;
+	rsp->entry = entry_rsp.entry;
 	return 0;
 }
 
@@ -1368,8 +1571,8 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
 
 	/* mcam_idx should be less than (2 * bank depth) */
 	if (mcam_idx >= npc_priv.bank_depth * 2) {
-		dev_err(rvu->dev, "%s:%d bad params\n",
-			__func__, __LINE__);
+		dev_err(rvu->dev, "%s: bad params\n",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -1383,8 +1586,8 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type)
 	 * number of subbanks available
 	 */
 	if (sb_id >= npc_priv.num_subbanks) {
-		dev_err(rvu->dev, "%s:%d invalid subbank %d\n",
-			__func__, __LINE__, sb_id);
+		dev_err(rvu->dev, "%s: invalid subbank %d\n",
+			__func__, sb_id);
 		return -EINVAL;
 	}
 
@@ -2215,24 +2418,56 @@ static int npc_idx_free(struct rvu *rvu, u16 *mcam_idx, int count,
 			bool maps_del)
 {
 	struct npc_subbank *sb;
-	int idx, i;
+	u16 vidx, midx;
+	int sb_off, i;
 	bool ret;
 	int rc;
 
 	for (i = 0; i < count; i++) {
-		rc =  npc_mcam_idx_2_subbank_idx(rvu, mcam_idx[i],
-						 &sb, &idx);
-		if (rc)
+		if (npc_is_vidx(mcam_idx[i])) {
+			vidx = mcam_idx[i];
+			midx = npc_vidx2idx(vidx);
+		} else {
+			midx = mcam_idx[i];
+			vidx = npc_idx2vidx(midx);
+		}
+
+		if (midx >= npc_priv.bank_depth * npc_priv.num_banks) {
+			dev_err(rvu->dev,
+				"%s: Invalid mcam_idx=%u cannot be deleted\n",
+				__func__, mcam_idx[i]);
+			return -EINVAL;
+		}
+
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: Failed to find subbank info for vidx=%u\n",
+				__func__, vidx);
 			return rc;
+		}
 
-		ret = npc_subbank_free(rvu, sb, idx);
-		if (ret)
+		ret = npc_subbank_free(rvu, sb, sb_off);
+		if (ret) {
+			dev_err(rvu->dev,
+				"%s: Failed to find subbank info for vidx=%u\n",
+				__func__, vidx);
 			return -EINVAL;
+		}
 
 		if (!maps_del)
 			continue;
 
-		rc = npc_del_from_pf_maps(rvu, mcam_idx[i]);
+		rc = npc_del_from_pf_maps(rvu, midx);
+		if (rc)
+			return rc;
+
+		/* If there is no vidx mapping; continue */
+		if (vidx == midx)
+			continue;
+
+		rc = npc_vidx_maps_del_entry(rvu, vidx, NULL);
 		if (rc)
 			return rc;
 	}
@@ -2748,10 +2983,12 @@ int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count)
 
 int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    int prio, u16 *mcam_idx, int ref, int limit,
-			    bool contig, int count)
+			    bool contig, int count, bool virt)
 {
+	bool defrag_candidate = false;
 	int i, eidx, rc, bd;
 	bool ref_valid;
+	u16 vidx;
 
 	bd = npc_priv.bank_depth;
 
@@ -2769,6 +3006,7 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 	}
 
 	ref_valid = !!(limit || ref);
+	defrag_candidate = !ref_valid && !contig && virt;
 	if (!ref_valid) {
 		if (contig && count > npc_priv.subbank_depth)
 			goto try_noref_multi_subbank;
@@ -2837,6 +3075,16 @@ int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 		rc = npc_add_to_pf_maps(rvu, mcam_idx[i], pcifunc);
 		if (rc)
 			return rc;
+
+		if (!defrag_candidate)
+			continue;
+
+		rc = npc_vidx_maps_add_entry(rvu, mcam_idx[i], pcifunc, &vidx);
+		if (rc)
+			return rc;
+
+		/* Return vidx to caller */
+		mcam_idx[i] = vidx;
 	}
 
 	return 0;
@@ -3107,6 +3355,502 @@ static int npc_pcifunc_map_create(struct rvu *rvu)
 	return cnt;
 }
 
+struct npc_defrag_node {
+	u8 idx;
+	u8 key_type;
+	bool valid;
+	bool refs;
+	u16 free_cnt;
+	u16 vidx_cnt;
+	u16 *vidx;
+	struct list_head list;
+};
+
+static bool npc_defrag_skip_restricted_sb(int sb_id)
+{
+	int i;
+
+	if (!restrict_valid)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(npc_subbank_restricted_idxs); i++)
+		if (sb_id == npc_subbank_restricted_idxs[i])
+			return true;
+	return false;
+}
+
+/* Find subbank with minimum number of virtual indexes */
+static struct npc_defrag_node *npc_subbank_min_vidx(struct list_head *lh)
+{
+	struct npc_defrag_node *node, *tnode = NULL;
+	int min = INT_MAX;
+
+	list_for_each_entry(node, lh, list) {
+		if (!node->valid)
+			continue;
+
+		/* if subbank has ref allocated mcam indexes, that subbank
+		 * is not a good candidate to move out indexes.
+		 */
+		if (node->refs)
+			continue;
+
+		if (min > node->vidx_cnt) {
+			min = node->vidx_cnt;
+			tnode = node;
+		}
+	}
+
+	return tnode;
+}
+
+/* Find subbank with maximum number of free spaces */
+static struct npc_defrag_node *npc_subbank_max_free(struct list_head *lh)
+{
+	struct npc_defrag_node *node, *tnode = NULL;
+	int max = INT_MIN;
+
+	list_for_each_entry(node, lh, list) {
+		if (!node->valid)
+			continue;
+
+		if (max < node->free_cnt) {
+			max = node->free_cnt;
+			tnode = node;
+		}
+	}
+
+	return tnode;
+}
+
+static int npc_defrag_alloc_free_slots(struct rvu *rvu,
+				       struct npc_defrag_node *f,
+				       int cnt, u16 *save)
+{
+	int alloc_cnt1, alloc_cnt2;
+	struct npc_subbank *sb;
+	int rc, sb_off, i;
+	bool deleted;
+
+	sb = &npc_priv.sb[f->idx];
+
+	alloc_cnt1 = 0;
+	alloc_cnt2 = 0;
+
+	rc = __npc_subbank_alloc(rvu, sb,
+				 NPC_MCAM_KEY_X2, sb->b0b,
+				 sb->b0t,
+				 NPC_MCAM_LOWER_PRIO,
+				 false, cnt, save, cnt, true,
+				 &alloc_cnt1);
+	if (alloc_cnt1 < cnt) {
+		rc = __npc_subbank_alloc(rvu, sb,
+					 NPC_MCAM_KEY_X2, sb->b1b,
+					 sb->b1t,
+					 NPC_MCAM_LOWER_PRIO,
+					 false, cnt - alloc_cnt1,
+					 save + alloc_cnt1,
+					 cnt - alloc_cnt1,
+					 true, &alloc_cnt2);
+	}
+
+	if (alloc_cnt1 + alloc_cnt2 != cnt) {
+		dev_err(rvu->dev,
+			"%s: Failed to alloc cnt=%u alloc_cnt1=%u alloc_cnt2=%u\n",
+			__func__, cnt, alloc_cnt1, alloc_cnt2);
+		goto fail_free_alloc;
+	}
+	return 0;
+
+fail_free_alloc:
+	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: Error to find subbank for mcam idx=%u\n",
+				__func__, save[i]);
+			break;
+		}
+
+		deleted = __npc_subbank_free(rvu, sb, sb_off);
+		if (!deleted) {
+			dev_err(rvu->dev,
+				"%s: Error to free mcam idx=%u\n",
+				__func__, save[i]);
+			break;
+		}
+	}
+
+	return rc;
+}
+
+static int npc_defrag_add_2_show_list(struct rvu *rvu, u16 old_midx,
+				      u16 new_midx, u16 vidx)
+{
+	struct npc_defrag_show_node *node;
+
+	node = kcalloc(1, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->old_midx = old_midx;
+	node->new_midx = new_midx;
+	node->vidx = vidx;
+	INIT_LIST_HEAD(&node->list);
+
+	mutex_lock(&npc_priv.lock);
+	list_add_tail(&node->list, &npc_priv.defrag_lh);
+	mutex_unlock(&npc_priv.lock);
+
+	return 0;
+}
+
+static
+int npc_defrag_move_vdx_to_free(struct rvu *rvu,
+				struct npc_defrag_node *f,
+				struct npc_defrag_node *v,
+				int cnt, u16 *save)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	int i, vidx_cnt, rc, sb_off;
+	u16 new_midx, old_midx, vidx;
+	struct npc_subbank *sb;
+	bool deleted;
+	u16 pcifunc;
+	int blkaddr;
+	void *map;
+	u8 bank;
+	u16 midx;
+	u64 stats;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+
+	vidx_cnt = v->vidx_cnt;
+	for (i = 0; i < cnt; i++) {
+		vidx = v->vidx[vidx_cnt - i - 1];
+		old_midx = npc_vidx2idx(vidx);
+		new_midx = save[cnt - i - 1];
+
+		dev_dbg(rvu->dev,
+			"%s: Moving %u ---> %u  (vidx=%u)\n",
+			__func__,
+			old_midx, new_midx, vidx);
+
+		rc = npc_defrag_add_2_show_list(rvu, old_midx, new_midx, vidx);
+		if (rc)
+			dev_err(rvu->dev,
+				"%s: Error happened to add to show list vidx=%u\n",
+				__func__, vidx);
+
+		/* Modify vidx to point to new mcam idx */
+		rc = npc_vidx_maps_modify(rvu, vidx, new_midx);
+		if (rc)
+			return rc;
+
+		midx = old_midx % mcam->banksize;
+		bank = old_midx / mcam->banksize;
+		stats = rvu_read64(rvu, blkaddr,
+				   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx,
+								      bank));
+
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false);
+		npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx);
+		npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true);
+
+		midx = new_midx % mcam->banksize;
+		bank = new_midx / mcam->banksize;
+		rvu_write64(rvu, blkaddr,
+			    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx, bank),
+			    stats);
+
+		/* Free the old mcam idx */
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, old_midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: Unable to calculate subbank off for mcamidx=%u\n",
+				__func__, old_midx);
+			return rc;
+		}
+
+		deleted = __npc_subbank_free(rvu, sb, sb_off);
+		if (!deleted) {
+			dev_err(rvu->dev,
+				"%s:  Failed to free mcamidx=%u sb=%u sb_off=%u\n",
+				__func__, old_midx, sb->idx, sb_off);
+			return -EFAULT;
+		}
+
+		/* save pcifunc */
+		map = xa_load(&npc_priv.xa_idx2pf_map, old_midx);
+		pcifunc = xa_to_value(map);
+
+		/* delete from pf maps */
+		rc =  npc_del_from_pf_maps(rvu, old_midx);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:  Failed to delete pf maps for mcamidx=%u\n",
+				__func__, old_midx);
+			return rc;
+		}
+
+		/* add new mcam_idx to pf map */
+		rc = npc_add_to_pf_maps(rvu, new_midx, pcifunc);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s:  Failed to add pf maps for mcamidx=%u\n",
+				__func__, new_midx);
+			return rc;
+		}
+
+		/* Remove from mcam maps */
+		mcam->entry2pfvf_map[old_midx] = NPC_MCAM_INVALID_MAP;
+		mcam->entry2cntr_map[old_midx] = NPC_MCAM_INVALID_MAP;
+		npc_mcam_clear_bit(mcam, old_midx);
+
+		mcam->entry2pfvf_map[new_midx] = pcifunc;
+		mcam->entry2cntr_map[new_midx] = pcifunc;
+		npc_mcam_set_bit(mcam, new_midx);
+
+		/* Mark as invalid */
+		v->vidx[vidx_cnt - i - 1] = -1;
+		save[cnt - i - 1] = -1;
+
+		f->free_cnt--;
+		v->vidx_cnt--;
+	}
+
+	return 0;
+}
+
+static int npc_defrag_process(struct rvu *rvu, struct list_head *lh)
+{
+	struct npc_defrag_node *v = NULL;
+	struct npc_defrag_node *f = NULL;
+	int rc = 0, cnt;
+	u16 *save;
+
+	while (1) {
+		/* Find subbank with minimum vidx */
+		if (!v) {
+			v = npc_subbank_min_vidx(lh);
+			if (!v)
+				break;
+		}
+
+		/* Find subbank with maximum free slots */
+		if (!f) {
+			f = npc_subbank_max_free(lh);
+			if (!f)
+				break;
+		}
+
+		if (!v->vidx_cnt) {
+			list_del_init(&v->list);
+			v = NULL;
+			continue;
+		}
+
+		if (!f->free_cnt) {
+			list_del_init(&f->list);
+			f = NULL;
+			continue;
+		}
+
+		/* If both subbanks are same, choose vidx and
+		 * search for free list again
+		 */
+		if (f == v) {
+			list_del_init(&f->list);
+			f = NULL;
+			continue;
+		}
+
+		/* Calculate minimum free slots needs to be allocated */
+		cnt = f->free_cnt > v->vidx_cnt ? v->vidx_cnt :
+			f->free_cnt;
+
+		dev_dbg(rvu->dev,
+			"%s: cnt=%u free_cnt=%u(sb=%u) vidx_cnt=%u(sb=%u)\n",
+			__func__, cnt, f->free_cnt, f->idx,
+			v->vidx_cnt, v->idx);
+
+		/* Allocate an array to store newly allocated
+		 * free slots (mcam indexes)
+		 */
+		save = kcalloc(cnt, sizeof(*save), GFP_KERNEL);
+		if (!save) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		/* Alloc free slots for existing vidx */
+		rc = npc_defrag_alloc_free_slots(rvu, f, cnt, save);
+		if (rc) {
+			kfree(save);
+			goto err;
+		}
+
+		/* Move vidx to free slots; update pf_map and vidx maps,
+		 * and free existing vidx mcam slots
+		 */
+		rc = npc_defrag_move_vdx_to_free(rvu, f, v, cnt, save);
+		if (rc) {
+			kfree(save);
+			goto err;
+		}
+
+		kfree(save);
+
+		if (!f->free_cnt) {
+			list_del_init(&f->list);
+			f = NULL;
+		}
+
+		if (!v->vidx_cnt) {
+			list_del_init(&v->list);
+			v = NULL;
+		}
+	}
+
+err:
+	/* TODO: how to go back to old state ? */
+	return rc;
+}
+
+static void npc_defrag_list_clear(void)
+{
+	struct npc_defrag_show_node *node, *next;
+
+	mutex_lock(&npc_priv.lock);
+	list_for_each_entry_safe(node, next, &npc_priv.defrag_lh, list) {
+		list_del_init(&node->list);
+		kfree(node);
+	}
+
+	mutex_unlock(&npc_priv.lock);
+}
+
+/* Only non-ref non-contigous mcam indexes
+ * are picked for defrag process
+ */
+int npc_cn20k_defrag(struct rvu *rvu)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct npc_defrag_node *node, *tnode;
+	struct list_head x4lh, x2lh, *lh;
+	int rc = 0, i, sb_off, tot;
+	struct npc_subbank *sb;
+	unsigned long index;
+	void *map;
+	u16 midx;
+
+	/* Free previous show list */
+	npc_defrag_list_clear();
+
+	INIT_LIST_HEAD(&x4lh);
+	INIT_LIST_HEAD(&x2lh);
+
+	node = kcalloc(npc_priv.num_subbanks, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	/* Lock mcam */
+	mutex_lock(&mcam->lock);
+	npc_lock_all_subbank();
+
+	/* Fill in node with subbank properties */
+	for (i = 0; i < npc_priv.num_subbanks; i++) {
+		sb = &npc_priv.sb[i];
+
+		node[i].idx = i;
+		node[i].key_type = sb->key_type;
+		node[i].free_cnt = sb->free_cnt;
+		node[i].vidx = kcalloc(npc_priv.subbank_depth * 2,
+				       sizeof(*node[i].vidx),
+				       GFP_KERNEL);
+		if (!node[i].vidx) {
+			rc = -ENOMEM;
+			goto free_vidx;
+		}
+
+		/* If subbank is empty, dont include it in defrag
+		 * process
+		 */
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE) {
+			node[i].valid = false;
+			continue;
+		}
+
+		if (npc_defrag_skip_restricted_sb(i)) {
+			node[i].valid = false;
+			continue;
+		}
+
+		node[i].valid = true;
+		INIT_LIST_HEAD(&node[i].list);
+
+		/* Add node to x2 or x4 list */
+		lh = sb->key_type == NPC_MCAM_KEY_X2 ? &x2lh : &x4lh;
+		list_add_tail(&node[i].list, lh);
+	}
+
+	/* Filling vidx[] array with all vidx in that subbank */
+	xa_for_each_start(&npc_priv.xa_vidx2idx_map, index, map,
+			  npc_priv.bank_depth * 2) {
+		midx = xa_to_value(map);
+		rc =  npc_mcam_idx_2_subbank_idx(rvu, midx,
+						 &sb, &sb_off);
+		if (rc) {
+			dev_err(rvu->dev,
+				"%s: Error to get mcam_idx for vidx=%lu\n",
+				__func__, index);
+			goto free_vidx;
+		}
+
+		tnode = &node[sb->idx];
+		tnode->vidx[tnode->vidx_cnt] = index;
+		tnode->vidx_cnt++;
+	}
+
+	/* Mark all subbank which has ref allocation */
+	for (i = 0; i < npc_priv.num_subbanks; i++) {
+		tnode = &node[i];
+
+		if (!tnode->valid)
+			continue;
+
+		tot = (tnode->key_type == NPC_MCAM_KEY_X2) ?
+			npc_priv.subbank_depth * 2 : npc_priv.subbank_depth;
+
+		if (node[i].vidx_cnt != tot - tnode->free_cnt)
+			tnode->refs = true;
+	}
+
+	rc =  npc_defrag_process(rvu, &x2lh);
+	if (rc)
+		goto free_vidx;
+
+	rc =  npc_defrag_process(rvu, &x4lh);
+	if (rc)
+		goto free_vidx;
+
+free_vidx:
+	npc_unlock_all_subbank();
+	mutex_unlock(&mcam->lock);
+	for (i = 0; i < npc_priv.num_subbanks; i++)
+		kfree(node[i].vidx);
+	kfree(node);
+	return rc;
+}
+
+int rvu_mbox_handler_npc_defrag(struct rvu *rvu, struct msg_req *req,
+				struct msg_rsp *rsp)
+{
+	return npc_cn20k_defrag(rvu);
+}
+
 int npc_cn20k_dft_rules_idx_get(struct rvu *rvu, u16 pcifunc, u16 *bcast,
 				u16 *mcast, u16 *promisc, u16 *ucast)
 {
@@ -3508,6 +4252,8 @@ static int npc_priv_init(struct rvu *rvu)
 	xa_init_flags(&npc_priv.xa_idx2pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf_map, XA_FLAGS_ALLOC);
 	xa_init_flags(&npc_priv.xa_pf2dfl_rmap, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_idx2vidx_map, XA_FLAGS_ALLOC);
+	xa_init_flags(&npc_priv.xa_vidx2idx_map, XA_FLAGS_ALLOC);
 
 	if (npc_create_srch_order(num_subbanks)) {
 		kfree(npc_priv.sb);
@@ -3534,6 +4280,9 @@ static int npc_priv_init(struct rvu *rvu)
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_init_flags(&npc_priv.xa_pf2idx_map[i], XA_FLAGS_ALLOC);
 
+	INIT_LIST_HEAD(&npc_priv.defrag_lh);
+	mutex_init(&npc_priv.lock);
+
 	return 0;
 }
 
@@ -3546,6 +4295,8 @@ void npc_cn20k_deinit(struct rvu *rvu)
 	xa_destroy(&npc_priv.xa_idx2pf_map);
 	xa_destroy(&npc_priv.xa_pf_map);
 	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
+	xa_destroy(&npc_priv.xa_idx2vidx_map);
+	xa_destroy(&npc_priv.xa_vidx2idx_map);
 
 	for (i = 0; i < npc_priv.pf_cnt; i++)
 		xa_destroy(&npc_priv.xa_pf2idx_map[i]);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index 60b9837dbbd8..7b9475c90306 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -147,6 +147,23 @@ struct npc_subbank {
 	u8 key_type;
 };
 
+/**
+ * struct npc_defrag_show_node - Defragmentation show node
+ * @old_midx:	Old mcam index.
+ * @new_midx:	New mcam index.
+ * @vidx:	Virtual index
+ * @list:	Linked list of these nodes
+ *
+ * This structure holds information on last defragmentation
+ * executed on mcam resource.
+ */
+struct npc_defrag_show_node {
+	u16 old_midx;
+	u16 new_midx;
+	u16 vidx;
+	struct list_head list;
+};
+
 /**
  * struct npc_priv_t - NPC private structure.
  * @bank_depth:		Total entries in each bank.
@@ -163,6 +180,10 @@ struct npc_subbank {
  * @pf_cnt:		Number of PFs.A
  * @init_done:		Indicates MCAM initialization is done.
  * @xa_pf2dfl_rmap:	PF to default rule index map.
+ * @xa_idx2vidx_map:	Mcam index to virtual index map.
+ * @xa_vidx2idx_map:	virtual index to mcam index map.
+ * @defrag_lh:		Defrag list head.
+ * @lock:		Lock for defrag list
  *
  * This structure is populated during probing time by reading
  * HW csr registers.
@@ -180,6 +201,10 @@ struct npc_priv_t {
 	struct xarray xa_idx2pf_map;
 	struct xarray xa_pf_map;
 	struct xarray xa_pf2dfl_rmap;
+	struct xarray xa_idx2vidx_map;
+	struct xarray xa_vidx2idx_map;
+	struct list_head defrag_lh;
+	struct mutex lock;
 	int pf_cnt;
 	bool init_done;
 };
@@ -276,7 +301,7 @@ void npc_cn20k_subbank_calc_free(struct rvu *rvu, int *x2_free,
 
 int npc_cn20k_ref_idx_alloc(struct rvu *rvu, int pcifunc, int key_type,
 			    int prio, u16 *mcam_idx, int ref, int limit,
-			    bool contig, int count);
+			    bool contig, int count, bool virt);
 int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
@@ -311,5 +336,8 @@ void npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
 void npc_cn20k_clear_mcam_entry(struct rvu *rvu, int blkaddr,
 				int bank, int index);
 int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
+u16 npc_cn20k_vidx2idx(u16 index);
+u16 npc_cn20k_idx2vidx(u16 idx);
+int npc_cn20k_defrag(struct rvu *rvu);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index e004271124df..1638bf4e15fd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -298,6 +298,9 @@ M(NPC_CN20K_MCAM_READ_ENTRY,	0x6019, npc_cn20k_mcam_read_entry,	\
 				  npc_cn20k_mcam_read_entry_rsp)	\
 M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,       \
 				   msg_req, npc_cn20k_mcam_read_base_rule_rsp) \
+M(NPC_MCAM_DEFRAG,	     0x601b,	npc_defrag,			\
+					msg_req,			\
+					msg_rsp)			\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1554,6 +1557,7 @@ struct npc_mcam_alloc_entry_req {
 	u16 ref_entry;
 	u16 count;    /* Number of entries requested */
 	u8 kw_type; /* entry key type, valid for cn20k */
+	u8 virt;    /* Request virtual index */
 };
 
 struct npc_mcam_alloc_entry_rsp {
@@ -1689,6 +1693,7 @@ struct npc_cn20k_mcam_alloc_and_write_entry_req {
 	u8  intf;	 /* Rx or Tx interface */
 	u8  enable_entry;/* Enable this MCAM entry ? */
 	u8  hw_prio;	 /* hardware priority, valid for cn20k */
+	u8  virt;	 /* Allocate virtual index */
 	u16 reserved[4]; /* reserved for future use */
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 0f9953eaf1b0..cc83d4fc5724 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -11,6 +11,7 @@
 #include "rvu_reg.h"
 #include "rvu_struct.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/npc.h"
 
 #define DRV_NAME "octeontx2-af"
 
@@ -1256,9 +1257,66 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_DEF_RULE_CNTR_ENABLE,
+	RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
 	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
+static int rvu_af_npc_defrag_feature_get(struct devlink *devlink, u32 id,
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	bool enabled;
+
+	enabled = is_cn20k(rvu->pdev);
+
+	snprintf(ctx->val.vstr, sizeof(ctx->val.vstr), "%s",
+		 enabled ? "enabled" : "disabled");
+
+	return 0;
+}
+
+static int rvu_af_npc_defrag(struct devlink *devlink, u32 id,
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	npc_cn20k_defrag(rvu);
+
+	return 0;
+}
+
+static int rvu_af_npc_defrag_feature_validate(struct devlink *devlink, u32 id,
+					      union devlink_param_value val,
+					      struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	u64 enable;
+
+	if (kstrtoull(val.vstr, 10, &enable)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only 1 value is supported");
+		return -EINVAL;
+	}
+
+	if (enable != 1) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only initiating defrag is supported");
+		return -EINVAL;
+	}
+
+	if (is_cn20k(rvu->pdev))
+		return 0;
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "Can defrag NPC only in cn20k silicon");
+	return -EFAULT;
+}
+
 static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
 					struct devlink_param_gset_ctx *ctx,
 					struct netlink_ext_ack *extack)
@@ -1561,6 +1619,15 @@ static const struct devlink_ops rvu_devlink_ops = {
 	.eswitch_mode_set = rvu_devlink_eswitch_mode_set,
 };
 
+static const struct devlink_param rvu_af_dl_param_defrag[] = {
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NPC_DEFRAG,
+			     "npc_defrag", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_npc_defrag_feature_get,
+			     rvu_af_npc_defrag,
+			     rvu_af_npc_defrag_feature_validate),
+};
+
 int rvu_register_dl(struct rvu *rvu)
 {
 	struct rvu_devlink *rvu_dl;
@@ -1593,6 +1660,17 @@ int rvu_register_dl(struct rvu *rvu)
 		goto err_dl_health;
 	}
 
+	if (is_cn20k(rvu->pdev)) {
+		err = devlink_params_register(dl, rvu_af_dl_param_defrag,
+					      ARRAY_SIZE(rvu_af_dl_param_defrag));
+		if (err) {
+			dev_err(rvu->dev,
+				"devlink defrag params register failed with error %d",
+				err);
+			goto err_dl_exact_match;
+		}
+	}
+
 	/* Register exact match devlink only for CN10K-B */
 	if (!rvu_npc_exact_has_match_table(rvu))
 		goto done;
@@ -1601,7 +1679,8 @@ int rvu_register_dl(struct rvu *rvu)
 				      ARRAY_SIZE(rvu_af_dl_param_exact_match));
 	if (err) {
 		dev_err(rvu->dev,
-			"devlink exact match params register failed with error %d", err);
+			"devlink exact match params register failed with error %d",
+			err);
 		goto err_dl_exact_match;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index fa4d7b132ddf..2fb3e8e38de7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2457,7 +2457,7 @@ static void npc_unmap_mcam_entry_and_cntr(struct rvu *rvu,
  * reverse bitmap too. Should be called with
  * 'mcam->lock' held.
  */
-static void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
+void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
 {
 	u16 entry, rentry;
 
@@ -2473,7 +2473,7 @@ static void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index)
  * reverse bitmap too. Should be called with
  * 'mcam->lock' held.
  */
-static void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
+void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index)
 {
 	u16 entry, rentry;
 
@@ -2694,7 +2694,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	ret = npc_cn20k_ref_idx_alloc(rvu, pcifunc, req->kw_type,
 				      req->ref_prio, rsp->entry_list,
 				      req->ref_entry, limit,
-				      req->contig, req->count);
+				      req->contig, req->count, !!req->virt);
 
 	if (ret) {
 		rsp->count = 0;
@@ -2714,7 +2714,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	mutex_lock(&mcam->lock);
 	/* Mark the allocated entries as used and set nixlf mapping */
 	for (entry = 0; entry < rsp->count; entry++) {
-		index = rsp->entry_list[entry];
+		index = npc_cn20k_vidx2idx(rsp->entry_list[entry]);
 		npc_mcam_set_bit(mcam, index);
 		mcam->entry2pfvf_map[index] = pcifunc;
 		mcam->entry2cntr_map[index] = NPC_MCAM_INVALID_MAP;
@@ -3026,6 +3026,8 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 	int blkaddr, rc = 0;
 	u16 cntr;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3156,6 +3158,8 @@ int rvu_mbox_handler_npc_mcam_ena_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3179,6 +3183,8 @@ int rvu_mbox_handler_npc_mcam_dis_entry(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, rc;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
@@ -3213,8 +3219,8 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 
 	mutex_lock(&mcam->lock);
 	for (index = 0; index < req->shift_count; index++) {
-		old_entry = req->curr_entry[index];
-		new_entry = req->new_entry[index];
+		old_entry = npc_cn20k_vidx2idx(req->curr_entry[index]);
+		new_entry = npc_cn20k_vidx2idx(req->new_entry[index]);
 
 		/* Check if both old and new entries are valid and
 		 * does belong to this PFFUNC or not.
@@ -3256,7 +3262,7 @@ int rvu_mbox_handler_npc_mcam_shift_entry(struct rvu *rvu,
 	/* If shift has failed then report the failed index */
 	if (index != req->shift_count) {
 		rc = NPC_MCAM_PERM_DENIED;
-		rsp->failed_entry_idx = index;
+		rsp->failed_entry_idx = npc_cn20k_idx2vidx(index);
 	}
 
 	mutex_unlock(&mcam->lock);
@@ -3839,6 +3845,8 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	if (blkaddr < 0)
 		return NPC_MCAM_INVALID_REQ;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	index = req->entry & (mcam->banksize - 1);
 	bank = npc_get_bank(mcam, req->entry);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
index 346e6ada158e..83c5e32e2afc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
@@ -16,4 +16,6 @@ void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
 int npc_fwdb_prfl_img_map(struct rvu *rvu, void __iomem **prfl_img_addr,
 			  u64 *size);
 
+void npc_mcam_clear_bit(struct npc_mcam *mcam, u16 index);
+void npc_mcam_set_bit(struct npc_mcam *mcam, u16 index);
 #endif /* RVU_NPC_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c7871adf248d..963d12ecd328 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1654,6 +1654,8 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	bool enable = true;
 	u16 target;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
 		dev_err(rvu->dev, "%s: NPC block not implemented\n", __func__);
@@ -1807,6 +1809,10 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 	struct list_head del_list;
 	int blkaddr;
 
+	req->entry = npc_cn20k_vidx2idx(req->entry);
+	req->start = npc_cn20k_vidx2idx(req->start);
+	req->end = npc_cn20k_vidx2idx(req->end);
+
 	INIT_LIST_HEAD(&del_list);
 
 	mutex_lock(&mcam->lock);
-- 
2.43.0


