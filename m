Return-Path: <netdev+bounces-216004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D560B315FC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2D21D02C53
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519552F90CE;
	Fri, 22 Aug 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WbQm/sZe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C4258EC2;
	Fri, 22 Aug 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860323; cv=none; b=QGZOxPOqfsWhjctawtd6WJzBlZoqSxD+k/uuuWyhbLugC11IA8+hEN4AvK3ic+OTAVsDXTm5zh0cbdbjza0FeBbjKppdp26mBQLU4hesSciKCo5Q10kO3VDygiV88ih8iA7EJbPlO9UT+Hs7eZs+aeYa5YEbfQDxKCjuIpNUAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860323; c=relaxed/simple;
	bh=O0JnXqEEImi8sn1roD3/rHbEpArDLGXrTJ+2Oc3+u0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BW2SnAr5DJhf9nTJkduC2B0YZaXBCb8xkD4X7+Qg3IGJ7ze/2iBD7aw0XGgCyf9wSTX/7R2FUB7HQPjK8PMYslQI1eeDLW7yJ34iSKCsFnh2SzIFlUeODkJ5PuzREO81xD7+SkzjcYnDjYrByqvDhQLTTxt+YiMR/gBjRZTqgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WbQm/sZe; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LNU0mF014244;
	Fri, 22 Aug 2025 03:58:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=0nymJqrIc02cPx9kfYRuZKZ
	6xMF8PEWYJ0Fb4/lOEMA=; b=WbQm/sZelBwBzyh6g93+XPVrwRA9AHRxeQk7yxt
	NeViv9JdpyUtbGBR7rYSPEsiP5+p3uPICOWymozWhSu5VsKwTHLhNsP5sGpEiFfi
	rz8Hq8ONs21yjOLVE9pYF1+NiQjsMZG1+0xli3y4YC+DAjyE5Viju86gPBh7HxpE
	27OrXf0AxEME9PKEDeJRhYc7SN43v1vysbDFonTvQQQCr/RDCUH8q3KQVwozMhcr
	JEteNwt9UX9634mbIOg+2BBZhPJOPUpVlK1D8YN4IloXsv5CHfmWfRXJD87lswbI
	yGKqi69YsF3opAtSXk30StUbgphdOc9td18a0OmuC4gWB2w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48pd629540-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 03:58:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 22 Aug 2025 03:58:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 22 Aug 2025 03:58:22 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 056C03F70CE;
	Fri, 22 Aug 2025 03:58:14 -0700 (PDT)
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
Subject: [net Patch] Octeontx2-af: Fix NIX X2P calibration failures
Date: Fri, 22 Aug 2025 16:28:05 +0530
Message-ID: <20250822105805.2236528-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4BRydFj1vT1xqcVhEz63IpiTIDLOuZr-
X-Authority-Analysis: v=2.4 cv=FYpuBJ+6 c=1 sm=1 tr=0 ts=68a84d4c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=_86yT0qS0cJFdN9aZyUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDEwMyBTYWx0ZWRfXywcRO5RzcRqw z9Z++Nyi1gGwHm9Pnq2eTsRrLfxSaWd5Eb80il088soOlDV92GncMba6sQyNlGU9Bc5Wy91olKu VNsFnYfQAbHyFEgsbOa4GH53prTCaOI8YY3ID8iFRxT6QTbpoCdvz24L1RGwulTRUTQtwDUbAyt
 eR7Dx7GR+OCzedqCOz4v7hEXY6KL45CMnYMv2+YZ8apVCgIrq3KuBHKAfPbZLYX0epWLkF8R2vr gbNa/GI9BzK2Ha3gVwkU6r5glKz11Q82D1r9AAImSn9637nnJV2tOY10LszPCo2s4EXCL2K7zJp ozE7aZR1bc2qcZSN3868ZDtzH4uxP/o+VbizxPrxzi1Ujti+IugKFozVMXIqtSDTICv76IlNF/Z
 Y6+EV54ex7dGXtcCCpql/9ygwMKZ9WbUdOYX4R1VE90mhhOvEIR+MvDBHcimOseTvfugWGpd
X-Proofpoint-GUID: 4BRydFj1vT1xqcVhEz63IpiTIDLOuZr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01

Before configuring the NIX block, the AF driver initiates the
"NIX block X2P bus calibration" and verifies that NIX interfaces
such as CGX and LBK are active and functioning correctly.

On few silicon variants(CNF10KA and CNF10KB), X2P calibration failures
have been observed on some CGX blocks that are not mapped to the NIX block.

Since both NIX-mapped and non-NIX-mapped CGX blocks share the same
VENDOR,DEVICE,SUBSYS_DEVID, it's not possible to skip probe based on
these parameters.

This patch introuduces "is_cgx_mapped_to_nix" API to detect and skip
probe of non NIX mapped CGX blocks.

Fixes: aba53d5dbcea ("octeontx2-af: NIX block admin queue init")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c |  7 +++++++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 4ff19a04b23e..0c46ba8a5adc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1978,6 +1978,13 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_release_regions;
 	}
 
+	if (!is_cn20k(pdev) &&
+	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
+		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
+			   cgx->cgx_id);
+		goto err_release_regions;
+	}
+
 	cgx->lmac_count = cgx->mac_ops->get_nr_lmacs(cgx);
 	if (!cgx->lmac_count) {
 		dev_notice(dev, "CGX %d LMAC count is zero, skipping probe\n", cgx->cgx_id);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7ee1fdeb5295..18c7bb39dbc7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -783,6 +783,20 @@ static inline bool is_cn10kb(struct rvu *rvu)
 	return false;
 }
 
+static inline bool is_cgx_mapped_to_nix(unsigned short id, u8 cgx_id)
+{
+	/* On CNF10KA and CNF10KB silicons only two CGX blocks are connected
+	 * to NIX.
+	 */
+	if (id == PCI_SUBSYS_DEVID_CNF10K_A || id == PCI_SUBSYS_DEVID_CNF10K_B)
+		return cgx_id <= 1;
+
+	return !(cgx_id && !(id == PCI_SUBSYS_DEVID_96XX ||
+			     id == PCI_SUBSYS_DEVID_98XX ||
+			     id == PCI_SUBSYS_DEVID_CN10K_A ||
+			     id == PCI_SUBSYS_DEVID_CN10K_B));
+}
+
 static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)
 {
 	u64 npc_const3;
-- 
2.34.1


