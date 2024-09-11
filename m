Return-Path: <netdev+bounces-127425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696097558A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA730285BEC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7601A3043;
	Wed, 11 Sep 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XASmBJNI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860419F11A;
	Wed, 11 Sep 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065227; cv=none; b=IqM+0OV3XGJ1FPCBdjGHv7Qt9u/ZWsbWu82F4tS0G3ZKkHda+RaWRdAUtl9YA1BcYBM1px7/LqLUZGcnzPG1Irc2Ez8wRFi3x9PEIKz2IWhiSEJYEUeAKEy46eGI7eRHNjirI8AQXaSRZkC8jIMpv4wOCkutcDIaGmgnQcTTL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065227; c=relaxed/simple;
	bh=cTq59fKknZo6/3zJq/ZND3TnlYCF5u7hEwQ1lBeaz/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5dpw3rtsXoafhiazk/DrXURwV5PCqibRh9bxiG18VRvCjhJV+DF++C57fh8tahBcQZkLdDmLlFTqXjRDc2JLheB2IYTqmoEwQ2i69FZ/xpl7pNSnxeQbfdyPy6MDuDR/e2r6mj2OOWA5rA7oq1cqFHDRvl/AyG5wol3l/O8ptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XASmBJNI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BBquwr017464;
	Wed, 11 Sep 2024 07:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	MaFMsB3rP+eExC6zKaD1XI91+5WTcvC0HwdkmVfPsQ=; b=XASmBJNIpfzmX7XKk
	9XjNWyClpLHjSqQdmwNIEDQ9qMO848NFxdaRrhKwW3KPBI+j3NBZljAFYjx4xmXg
	vUvSrjO+K0v63B7NDpqLObCuGHAMVqw1gauTSpqcK7LTYhzMKqFmBolnAgNZB9b8
	D6cSssW5CxOwPSZJSeCsDjrEMa4T8G53EI2u6wNG9Kbm5siH4N3R+3zt64uWrHv2
	P0G44S+CFYlgbcYX3xzj6jV/41dcWJ3aTqB5e17DwpoiGrER6gTyPKXMHY1ZH5fD
	Q4srPsW43+tC8gnyzLvO+Fw5iiZsiIJyENZiVV25ehfac0bI3lPZwWu0t1XWOW8v
	kXANA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41k17vjxsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:33:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 07:33:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 07:33:32 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 0F8163F7041;
	Wed, 11 Sep 2024 07:33:28 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [PATCH net-next 2/2] octeontx2-af: debugfs: Add Channel info to RPM map
Date: Wed, 11 Sep 2024 20:03:03 +0530
Message-ID: <20240911143303.160124-3-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911143303.160124-1-lcherian@marvell.com>
References: <20240911143303.160124-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CIHb6iJ3Uy0aIUFDd5T9YIQuDhlV0uPm
X-Proofpoint-ORIG-GUID: CIHb6iJ3Uy0aIUFDd5T9YIQuDhlV0uPm
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


