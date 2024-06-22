Return-Path: <netdev+bounces-105848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE5913248
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 08:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E671C21789
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 06:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFF42AAE;
	Sat, 22 Jun 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ViU7PpRI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E452913;
	Sat, 22 Jun 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719037066; cv=none; b=cM1rT7kgGcdGYyFUMbqKKgO3i/Y6YSFm4NIXPnAe3ugGlsbpeHzkWAhOllfMDrNJTNjLxHK1Zb04BPq+K+V5r/EWQAvPUIp0K4AEZrGt6n8RiSHlr/GlWPRPB5XmKSYFcAQgq+95LvGA2WMiCGCo5ZipgnoFJxCK2sBNRCm/NgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719037066; c=relaxed/simple;
	bh=R6aB0QB/KPdZ4KXqAUTCSN/RohzvcGk6roLvMZY3Mzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZwjX4gNCtyjlruDBqPO2OwlchNXmJfUhFrYFBxMOkwXCYp1u2CnjAZ0SRNuANs65CtQlgZch9PL0x3iB3rjxRqpztt3TK57lG2IAajcX9iYVorMz+y59jrop8ouMl7x6MfvmfTg5eoc00zjRFOdntzzW7fglQX/NKhgzg54dGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ViU7PpRI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M4wLGt026779;
	Fri, 21 Jun 2024 23:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=fK3EZrZY7j+4dYnQBQans+h
	BP4VS0Of2ctNwGdLtIrU=; b=ViU7PpRIVvyzkMcLM8WGNTTZvcMLsgRk9LL3Maa
	TrIuvQWZAXbzs4leeWO7QqFL0NLQnUB1hHGUbg+Nhtb0eKMjoEI0Y854azA42vd0
	CdDJ/FRu0dx8IFLpKZ22GBk8k9DgPD96rVUPKChZMggaE7wDERZFCJCa77x9x3Oq
	z6ycsbIecFXdtv2QA6AVg7JDkZv4fL5rJnUJYCkxELNh2O359NCIKxKVQtxCvaQs
	3GZ1LdFveR25ZBeABMneW8u1Zqr1MrRI+eeBpk6W0lwRY9xj2VkmwBvH0QJNHwIM
	5mahSIsahH2ZtZ07Zv9+9ZG1gCJ0N5e/ZGxAaLug509QUbA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ywh0ph30e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 23:17:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Jun 2024 23:17:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Jun 2024 23:17:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 7734E3F7040;
	Fri, 21 Jun 2024 23:17:28 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix klockwork issues in AF driver
Date: Sat, 22 Jun 2024 11:47:25 +0530
Message-ID: <20240622061725.3579906-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gc-0M3HJ3Ls2Me7W0Nc0WXOz5JJlNOOD
X-Proofpoint-ORIG-GUID: gc-0M3HJ3Ls2Me7W0Nc0WXOz5JJlNOOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_03,2024-06-21_01,2024-05-17_01

This patch fixes multiple minor klockwork issues in octeontx2 AF driver.
Most of the changes are related to variable initializations and null
checks. These are not the real issues.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c       |  9 ++++++++-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c    |  6 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c       | 11 ++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   |  8 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c   |  1 +
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 27935c54b91b..af42a6d23e53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -465,6 +465,13 @@ u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
 	u64 cfg;
 	int id;
 
+	if (!cgx_dev)
+		return 0;
+
+	lmac = lmac_pdata(lmac_id, cgx_dev);
+	if (!lmac)
+		return 0;
+
 	mac_ops = cgx_dev->mac_ops;
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
@@ -1648,7 +1655,7 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
 static int cgx_lmac_init(struct cgx *cgx)
 {
 	struct lmac *lmac;
-	u64 lmac_list;
+	u64 lmac_list = 0;
 	int i, err;
 
 	/* lmac_list specifies which lmacs are enabled
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index d39d86e694cc..de4482dee86a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -681,7 +681,7 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
 	struct mcs *mcs;
-	int rsrc_id, i;
+	int rsrc_id = -EINVAL, i;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -742,6 +742,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 			rsp->rsrc_cnt++;
 		}
 		break;
+	default:
+		goto exit;
 	}
 
 	rsp->rsrc_type = req->rsrc_type;
@@ -854,7 +856,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
 static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
 {
 	struct mcs *mcs = mcs_get_pdata(0);
-	unsigned long lmac_bmap;
+	unsigned long lmac_bmap = 0;
 	int cgx, lmac, port;
 
 	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index bcc96eed2481..0be5d22d213b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -517,6 +517,7 @@ static int ptp_pps_on(struct ptp *ptp, int on, u64 period)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
+	void __iomem * const *base;
 	struct ptp *ptp;
 	int err;
 
@@ -536,7 +537,15 @@ static int ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	ptp->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	base = pcim_iomap_table(pdev);
+	if (!base)
+		goto error_free;
+
+	ptp->reg_base = base[PCI_PTP_BAR_NO];
+	if (!ptp->reg_base) {
+		err = -ENODEV;
+		goto error_free;
+	}
 
 	pci_set_drvdata(pdev, ptp);
 	if (!first_ptp_block)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..a1a919fcda47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -43,7 +43,7 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	u64 reg, val;
-	int i, eng;
+	int i, eng = 0;
 	u8 grp;
 
 	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 881d704644fb..3056c39046bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -519,12 +519,16 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
 static void rvu_dbg_mcs_init(struct rvu *rvu)
 {
 	struct mcs *mcs;
-	char dname[10];
+	char *dname = NULL;
 	int i;
 
 	if (!rvu->mcs_blk_cnt)
 		return;
 
+	dname = kmalloc_array(rvu->mcs_blk_cnt, sizeof(char), GFP_KERNEL);
+	if (!dname)
+		return;
+
 	rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
 
 	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
@@ -568,6 +572,8 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 		debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
 				    &rvu_dbg_mcs_tx_port_stats_fops);
 	}
+
+	kfree(dname);
 }
 
 #define LMT_MAPTBL_ENTRY_SIZE 16
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..0c59295eaf9d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5375,7 +5375,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
 				 int blkaddr)
 {
 	u8 cpt_idx, cpt_blkaddr;
-	u64 val;
+	u64 val = 0;
 
 	cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
 	if (req->enable) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 97722ce8c4cb..a69438921a8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1765,6 +1765,7 @@ static void npc_load_kpu_profile(struct rvu *rvu)
 				rvu->kpu_prfl_addr = NULL;
 			} else {
 				kfree(rvu->kpu_fwdata);
+				rvu->kpu_fwdata = NULL;
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-- 
2.25.1


