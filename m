Return-Path: <netdev+bounces-248358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C67D07428
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 06:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F9C8309EA23
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43406318EE9;
	Fri,  9 Jan 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DEmG8s1p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F932949E0;
	Fri,  9 Jan 2026 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937769; cv=none; b=mbcq+5VCpuiPxBY9UHTjSKJL9u9QNganzxUVbZuS3lec3CccY3Pri9SrtS+6Lia8mvteDf+Y8GURo38RwVHXxbyTVk681sAE1fmsucHYvI84hXrtEB70XoM7ZRJYMXNC4MuvvKCpkFaeKAbB1BdiayJLAj0fsV0mGErpL0SUIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937769; c=relaxed/simple;
	bh=sKztKRhMhvbVTffegc4LsUm0Z9R3qNI8w1ad/N3Zzhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpPaJ9aGPNZF0VOF0HPdmjD37gHyw78UVZldF+bM2S1Ri+dwWEiFXE0wLbILqPkQJkNiiETStzC1dGJTWq/ubBYtesg9v/hyUJw36ycojEPW929dIA0Sk7R/f2eBjzwWg7oxRpSOm5Fm0q5Tln6z98zR9alpF2a6FmazuY5UroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DEmG8s1p; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608NTbCZ833409;
	Thu, 8 Jan 2026 21:49:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	bqTgootxIJMDlXq+3uRpjpgMK0kI5kgpuscht8Kk7g=; b=DEmG8s1pEkegqMcSI
	bdJWhulBDWs/oDAsUq8hQzCKH8Ht2F8twslGF77dxcFb+9PmphZNCKgNHyM73pUn
	6dgqW2G+vGsoVa8TWUUnPhwJlKx1uR89jPZTdzm/LN6eE1r/MlcfVadsd9zbnUzP
	smPhxMR0+ABBD5CPI1VxEOExK8QUXkiBMYeeZQKX2xvljBFO6sy9F0R57dNjTyVZ
	s4nPt1CGZKrBdJeNqPxjy1Oo8UQm25EOJZ4udmaoRBYYHxrononF/lRx6qrnUmRV
	S/lloJmHdnvMsc9nkXCjEpr1DdJB26GRO2wVz5/cr8ugCEX6gUFobK4udjwdt9YQ
	2WgfQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bjp9r8jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 21:49:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 21:49:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 21:49:17 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 89B6F3F7061;
	Thu,  8 Jan 2026 21:49:14 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 12/13] octeontx2-af: npc: cn20k: add debugfs support
Date: Fri, 9 Jan 2026 11:18:27 +0530
Message-ID: <20260109054828.1822307-13-rkannoth@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=e58LiKp/ c=1 sm=1 tr=0 ts=696096de cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=KJFtI6hBAxspoFtN7EMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: GAN_AnwQoX83cgL0unPz6Pqg0Qk3PiYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX5uGJLCGa3sQ0
 vEUkPDrSpBxCAeNWdz5yzuPN0DXRweK636m6fKRxM7ADpbAqVlj1M8hMqtz6r2+1KeVriXA7OuV
 i7Ajny8VvYQQxBPh5dYIWbyZayzikO07pLdEu7whFPLbfWmPOolPsplQVhc2RncwKBE+MoI7I3L
 0tOr63mlLzuZGlKr3khRjlwXZvztVsbo+QRc1A5tH3feWPhaLQ2o/CJTzGQWE510w0jYVqeJDdM
 +CLTO1zNS0Px8ciIcJfNvzARObD1ZMaIY3RL5kIUDAnKhEqVnbMdbV8WSs7coKkC74jJrWuVtmP
 fDorxfuO2G5Nn9+iZahYpLWcEY3+WKEvyhvUL1R5CZGbn344y9MFdFOTmFLJG8EewNued1lGDKZ
 f6MCGKWcKgr27oZLq1ioLkrGmWe3IW8wy12fzWJJ63J1zyyfUfSNn4RSPwulfbaaX+/4FZRpX87
 MvFMuqTgxudTZCabgPg==
X-Proofpoint-GUID: GAN_AnwQoX83cgL0unPz6Pqg0Qk3PiYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01

CN20K silicon divides the NPC MCAM into banks and subbanks, with each
subbank configurable for x2 or x4 key widths. This patch adds debugfs
entries to expose subbank usage details and their configured key type.

A debugfs entry is also added to display the default MCAM indexes
allocated for each pcifunc.

Additionally, debugfs support is introduced to show the mapping between
virtual indexes and real MCAM indexes, and vice versa.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 255 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  37 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   1 +
 3 files changed, 283 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
index 9360886c88e2..4c71325e7e13 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
@@ -15,6 +15,233 @@
 #include "debugfs.h"
 #include "cn20k/npc.h"
 
+static int npc_mcam_layout_show(struct seq_file *s, void *unused)
+{
+	int i, j, sbd, idx0, idx1, vidx0, vidx1;
+	struct npc_priv_t *npc_priv;
+	char buf0[32], buf1[32];
+	struct npc_subbank *sb;
+	unsigned int bw0, bw1;
+	bool v0, v1;
+	int pf1, pf2;
+	bool e0, e1;
+	void *map;
+
+	npc_priv = s->private;
+
+	sbd = npc_priv->subbank_depth;
+
+	for (i = npc_priv->num_subbanks - 1; i >= 0; i--) {
+		sb = &npc_priv->sb[i];
+		mutex_lock(&sb->lock);
+
+		if (sb->flags & NPC_SUBBANK_FLAG_FREE)
+			goto next;
+
+		bw0 = bitmap_weight(sb->b0map, npc_priv->subbank_depth);
+		if (sb->key_type == NPC_MCAM_KEY_X4) {
+			seq_printf(s, "\n\nsubbank:%u, x4, free=%u, used=%u\n",
+				   sb->idx, sb->free_cnt, bw0);
+
+			for (j = sbd - 1; j >= 0; j--) {
+				if (!test_bit(j, sb->b0map))
+					continue;
+
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				if (map) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0), "v:%u", vidx0);
+				}
+
+				seq_printf(s, "\t%u(%#x) %s\n", idx0, pf1,
+					   map ? buf0 : " ");
+			}
+			goto next;
+		}
+
+		bw1 = bitmap_weight(sb->b1map, npc_priv->subbank_depth);
+		seq_printf(s, "\n\nsubbank:%u, x2, free=%u, used=%u\n",
+			   sb->idx, sb->free_cnt, bw0 + bw1);
+		seq_printf(s, "bank1(%u)\t\tbank0(%u)\n", bw1, bw0);
+
+		for (j = sbd - 1; j >= 0; j--) {
+			e0 = test_bit(j, sb->b0map);
+			e1 = test_bit(j, sb->b1map);
+
+			if (!e1 && !e0)
+				continue;
+
+			if (e1 && e0) {
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				v0 = !!map;
+				if (v0) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0), "v:%05u", vidx0);
+				}
+
+				idx1 = sb->b1b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx1);
+				pf2 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx1);
+				v1 = !!map;
+				if (v1) {
+					vidx1 = xa_to_value(map);
+					snprintf(buf1, sizeof(buf1), "v:%05u", vidx1);
+				}
+
+				seq_printf(s, "%05u(%#x) %s\t\t%05u(%#x) %s\n",
+					   idx1, pf2, v1 ? buf1 : "       ",
+					   idx0, pf1, v0 ? buf0 : "       ");
+
+				continue;
+			}
+
+			if (e0) {
+				idx0 = sb->b0b + j;
+				map = xa_load(&npc_priv->xa_idx2pf_map, idx0);
+				pf1 = xa_to_value(map);
+
+				map = xa_load(&npc_priv->xa_idx2vidx_map, idx0);
+				if (map) {
+					vidx0 = xa_to_value(map);
+					snprintf(buf0, sizeof(buf0), "v:%05u", vidx0);
+				}
+
+				seq_printf(s, "\t\t   \t\t%05u(%#x) %s\n", idx0, pf1,
+					   map ? buf0 : " ");
+				continue;
+			}
+
+			idx1 = sb->b1b + j;
+			map = xa_load(&npc_priv->xa_idx2pf_map, idx1);
+			pf1 = xa_to_value(map);
+			map = xa_load(&npc_priv->xa_idx2vidx_map, idx1);
+			if (map) {
+				vidx1 = xa_to_value(map);
+				snprintf(buf1, sizeof(buf1), "v:%05u", vidx1);
+			}
+
+			seq_printf(s, "%05u(%#x) %s\n", idx1, pf1,
+				   map ? buf1 : " ");
+		}
+next:
+		mutex_unlock(&sb->lock);
+	}
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_layout);
+
+static int npc_mcam_default_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index;
+	u16 ptr[4], pcifunc;
+	struct rvu *rvu;
+	int rc, i;
+	void *map;
+
+	npc_priv = npc_priv_get();
+	rvu = s->private;
+
+	seq_puts(s, "\npcifunc\tBcast\tmcast\tpromisc\tucast\n");
+
+	xa_for_each(&npc_priv->xa_pf_map, index, map) {
+		pcifunc = index;
+
+		for (i = 0; i < ARRAY_SIZE(ptr); i++)
+			ptr[i] = USHRT_MAX;
+
+		rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &ptr[0],
+						 &ptr[1], &ptr[2], &ptr[3]);
+		if (rc)
+			continue;
+
+		seq_printf(s, "%#x\t", pcifunc);
+		for (i = 0; i < ARRAY_SIZE(ptr); i++) {
+			if (ptr[i] != USHRT_MAX)
+				seq_printf(s, "%u\t", ptr[i]);
+			else
+				seq_puts(s, "\t");
+		}
+		seq_puts(s, "\n");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_mcam_default);
+
+static int npc_vidx2idx_map_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index, start;
+	struct xarray *xa;
+	void *map;
+
+	npc_priv = s->private;
+	start = npc_priv->bank_depth * 2;
+	xa = &npc_priv->xa_vidx2idx_map;
+
+	seq_puts(s, "\nvidx\tmcam_idx\n");
+
+	xa_for_each_start(xa, index, map, start)
+		seq_printf(s, "%lu\t%lu\n", index, xa_to_value(map));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_vidx2idx_map);
+
+static int npc_idx2vidx_map_show(struct seq_file *s, void *unused)
+{
+	struct npc_priv_t *npc_priv;
+	unsigned long index;
+	struct xarray *xa;
+	void *map;
+
+	npc_priv = s->private;
+	xa = &npc_priv->xa_idx2vidx_map;
+
+	seq_puts(s, "\nmidx\tvidx\n");
+
+	xa_for_each(xa, index, map)
+		seq_printf(s, "%lu\t%lu\n", index, xa_to_value(map));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(npc_idx2vidx_map);
+
+static int npc_defrag_show(struct seq_file *s, void *unused)
+{
+	struct npc_defrag_show_node *node;
+	struct npc_priv_t *npc_priv;
+	u16 sbd, bdm;
+
+	npc_priv = s->private;
+	bdm = npc_priv->bank_depth - 1;
+	sbd = npc_priv->subbank_depth;
+
+	seq_puts(s, "\nold(sb)   ->    new(sb)\t\tvidx\n");
+
+	mutex_lock(&npc_priv->lock);
+	list_for_each_entry(node, &npc_priv->defrag_lh, list)
+		seq_printf(s, "%u(%u)\t%u(%u)\t%u\n", node->old_midx,
+			   (node->old_midx & bdm) / sbd,
+			   node->new_midx,
+			   (node->new_midx & bdm) / sbd,
+			   node->vidx);
+	mutex_unlock(&npc_priv->lock);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(npc_defrag);
+
 static void npc_subbank_srch_order_dbgfs_usage(struct rvu *rvu)
 {
 	dev_err(rvu->dev,
@@ -185,6 +412,7 @@ static const struct file_operations npc_subbank_srch_order_ops = {
 
 int npc_cn20k_debugfs_init(struct rvu *rvu)
 {
+	struct npc_priv_t *npc_priv = npc_priv_get();
 	struct dentry *npc_dentry;
 
 	npc_dentry = debugfs_create_file("subbank_srch_order", 0644,
@@ -193,6 +421,33 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
 	if (!npc_dentry)
 		return -EFAULT;
 
+	npc_dentry = debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
+					 npc_priv, &npc_mcam_layout_fops);
+
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("mcam_default", 0444, rvu->rvu_dbg.npc,
+					 rvu, &npc_mcam_default_fops);
+
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc, npc_priv,
+					 &npc_vidx2idx_map_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("idx2vidx", 0444, rvu->rvu_dbg.npc, npc_priv,
+					 &npc_idx2vidx_map_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
+	npc_dentry = debugfs_create_file("defrag", 0444, rvu->rvu_dbg.npc, npc_priv,
+					 &npc_defrag_fops);
+	if (!npc_dentry)
+		return -EFAULT;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 407f360feaf5..5b62550f73d0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -23,6 +23,7 @@
 
 #include "cn20k/reg.h"
 #include "cn20k/debugfs.h"
+#include "cn20k/npc.h"
 
 #define DEBUGFS_DIR_NAME "octeontx2"
 
@@ -3197,7 +3198,9 @@ static void rvu_print_npc_mcam_info(struct seq_file *s,
 static int rvu_dbg_npc_mcam_info_display(struct seq_file *filp, void *unsued)
 {
 	struct rvu *rvu = filp->private;
+	int x4_free, x2_free, sb_free;
 	int pf, vf, numvfs, blkaddr;
+	struct npc_priv_t *npc_priv;
 	struct npc_mcam *mcam;
 	u16 pcifunc, counters;
 	u64 cfg;
@@ -3211,16 +3214,30 @@ static int rvu_dbg_npc_mcam_info_display(struct seq_file *filp, void *unsued)
 
 	seq_puts(filp, "\nNPC MCAM info:\n");
 	/* MCAM keywidth on receive and transmit sides */
-	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
-	cfg = (cfg >> 32) & 0x07;
-	seq_printf(filp, "\t\t RX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
-		   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
-		   "224bits" : "448bits"));
-	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_TX));
-	cfg = (cfg >> 32) & 0x07;
-	seq_printf(filp, "\t\t TX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
-		   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
-		   "224bits" : "448bits"));
+	if (is_cn20k(rvu->pdev)) {
+		npc_priv = npc_priv_get();
+		seq_printf(filp, "\t\t RX keywidth \t: %s\n",
+			   (npc_priv->kw == NPC_MCAM_KEY_X1) ?
+			   "256bits" : "512bits");
+
+		npc_cn20k_subbank_calc_free(rvu, &x2_free, &x4_free, &sb_free);
+		seq_printf(filp, "\t\t free x4 slots\t: %d\n", x4_free);
+
+		seq_printf(filp, "\t\t free x2 slots\t: %d\n", x2_free);
+
+		seq_printf(filp, "\t\t free subbanks\t: %d\n", sb_free);
+	} else {
+		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
+		cfg = (cfg >> 32) & 0x07;
+		seq_printf(filp, "\t\t RX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
+			   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
+					"224bits" : "448bits"));
+		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_TX));
+		cfg = (cfg >> 32) & 0x07;
+		seq_printf(filp, "\t\t TX keywidth \t: %s\n", (cfg == NPC_MCAM_KEY_X1) ?
+			   "112bits" : ((cfg == NPC_MCAM_KEY_X2) ?
+					"224bits" : "448bits"));
+	}
 
 	mutex_lock(&mcam->lock);
 	/* MCAM entries */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 4b47c1ae8031..5300b7faefbf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1577,6 +1577,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 
 	rule->chan &= rule->chan_mask;
 	rule->lxmb = dummy.lxmb;
+	rule->hw_prio = req->hw_prio;
 	if (is_npc_intf_tx(req->intf))
 		rule->intf = pfvf->nix_tx_intf;
 	else
-- 
2.43.0


