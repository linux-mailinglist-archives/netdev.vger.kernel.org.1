Return-Path: <netdev+bounces-127866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D49976E88
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90292B2225A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8914C5AF;
	Thu, 12 Sep 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bIU+7y45"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEC149C50;
	Thu, 12 Sep 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157724; cv=none; b=fsMvtovYa+9Gi1CHADn9Y2VHlydxP2pODZXA1bdZL5zsPs9n2QwQRT+0f+FWNUVoEzXcjlJarrJC/WAGbivXKAaWTTYHGbCfbZqMg7OdMIqTuB1BTKpUKmnFLc3V+3HYIWCKqGaaotnTl4KKJ5QmnHrkbMZIEw5ZsI7pcRBFi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157724; c=relaxed/simple;
	bh=6DixLDMe79fRUKZY2/B+7LSqGAnFPKKPILEqIZ6FtCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryGbB0pr7b2LAFiu0AjiZSF1h/PCXOmAcWMZkOnEWiWJntZ0IXd6v8F+s/r0CtSXEDPgo84lp7y71PgayCcMg/fOV0XZDkpcNsIav2zcoqblx8GAo0B7JkpgdpMMBsMs2jNNBQ+FRMnzamI4YiRCnUDjYIIl0h/ezqcJtHQvn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bIU+7y45; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCIopp029838;
	Thu, 12 Sep 2024 09:15:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	3bgQqdr8mYs+jODxqTmrfuLs8FRU/YqAfIspUafpbU=; b=bIU+7y45L4eAtldHL
	MebT6BeB2rL5poAgZp34VNiJpZ29AoUof1nsxEh/k+nVP/okoaq8p2amvJxs+IMa
	KZHuO2Wqx9BLMU08jIdWmR4VB8X3/ABOFHZosMoFtuysWt2v7d0oj9Z+KKC+ipD6
	RcyIyFFfrMFbuJJsjdD0GiQtMpW86o1JHt/cZTng2hze9EQx6DA2j5GSslmqX3N9
	FxzvCROmjEpPObEBIQrSpwJuJmwUPs5lipt/d3C7Z3Rl8DvyukfS5NDc//kT5Je8
	Nu5MaKdRaXcSLjjSw+vpb1O6A1wxGrF1e6A8hgzu+uskQWpgjnUWhqyyWAh+4lOK
	oIRqQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41k17vrwep-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:15:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 09:15:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Sep 2024 09:15:03 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 361DD3F7078;
	Thu, 12 Sep 2024 09:14:59 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [PATCH v2 net-next 2/2] octeontx2-af: debugfs: Add Channel info to RPM map
Date: Thu, 12 Sep 2024 21:44:50 +0530
Message-ID: <20240912161450.164402-3-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912161450.164402-1-lcherian@marvell.com>
References: <20240912161450.164402-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NRzrfN6q-UDagD1sGYHqCqQm53kOxnif
X-Proofpoint-ORIG-GUID: NRzrfN6q-UDagD1sGYHqCqQm53kOxnif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Display channel info in the RPM map debugfs output.

With this, cat /sys/kernel/debug/cn10k/rvu_pf_rpm_map
would display channel number for each device in addition to
the existing data.

Sample output:
PCI dev         RVU PF Func     NIX block       rpm     LMAC    CHAN
0002:02:00.0    0x400           NIX0            rpm0    LMAC0   256

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v1:
No changes

 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 4a4ef5bd9e0b..87ba77e5026a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -838,10 +838,10 @@ RVU_DEBUG_FOPS(rsrc_status, rsrc_attach_status, NULL);
 
 static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 {
+	char cgx[10], lmac[10], chan[10];
 	struct rvu *rvu = filp->private;
 	struct pci_dev *pdev = NULL;
 	struct mac_ops *mac_ops;
-	char cgx[10], lmac[10];
 	struct rvu_pfvf *pfvf;
 	int pf, domain, blkid;
 	u8 cgx_id, lmac_id;
@@ -852,7 +852,7 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 	/* There can be no CGX devices at all */
 	if (!mac_ops)
 		return 0;
-	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\n",
+	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
 		   mac_ops->name);
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
@@ -876,8 +876,11 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 				    &lmac_id);
 		sprintf(cgx, "%s%d", mac_ops->name, cgx_id);
 		sprintf(lmac, "LMAC%d", lmac_id);
-		seq_printf(filp, "%s\t0x%x\t\tNIX%d\t\t%s\t%s\n",
-			   dev_name(&pdev->dev), pcifunc, blkid, cgx, lmac);
+		sprintf(chan, "%d",
+			rvu_nix_chan_cgx(rvu, cgx_id, lmac_id, 0));
+		seq_printf(filp, "%s\t0x%x\t\tNIX%d\t\t%s\t%s\t%s\n",
+			   dev_name(&pdev->dev), pcifunc, blkid, cgx, lmac,
+			   chan);
 
 		pci_dev_put(pdev);
 	}
-- 
2.34.1


