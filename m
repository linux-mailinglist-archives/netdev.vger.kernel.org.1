Return-Path: <netdev+bounces-207542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BCB07B5F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0117CA404A7
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A92F5C5D;
	Wed, 16 Jul 2025 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gz94X+w9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72382F5C50;
	Wed, 16 Jul 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684149; cv=none; b=TY2Ezcb+Qe17t+a4BSxBdsiUmMzXXXN2eVRuBAaT/BptnxNRI4XFXFj+cs1iPxuUv20+i3CDwylSy+xLi8mDRTScMklNJgL/K9PMZs1Ix/mKpdEXeiA0TF8Y0Mui9g4GPxQehFyRNakBsAOTRcJwmOcO9Vh3D8/l1Wgavqum8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684149; c=relaxed/simple;
	bh=nJBBmzhgmaFEmPiDmeDGcyAh0NYNabSWFLJk3sq3dzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7UFpQqXRFx7FvL1h+mzfUvZjFN4m3uMaysgF32XJzxA2YXixzLWFXb4N5NOD3iPlfUf3YKD6zTahVkNSuKLtlRpn6Rzd7DfF2Dqvk9h3VOKPUTj/1pI0bVnujL168tJAVJZAA7kyVv4Q3y2egyXUgXIrb/Hr2HDOH21b8Sgcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gz94X+w9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCEv7j025373;
	Wed, 16 Jul 2025 09:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	tkVd5jbDFn044f7Un5zc0H2eijmxQDpKl27CaJJHjk=; b=gz94X+w9TyMT5uHus
	XDTV53KsvXqMMkiqVumDqi8dgibtN0fNJd5LaZFoUsvD0wA97jnpYWyn3UIHAX5e
	avmavlSv0ib3QRXrMuawj6BFF7N9qfNhIsueYHFy0gw6Mc9KLeYsX8ArzSVE9UJK
	Il+HWzhxvrOz8eZOvvc69eTVSD665YtVLZ9073pCem4dJVialuuZknGvJWxWODRS
	GXNtlKhkhYS8AKTVJZj5XfXbGjeLhADc7dlRhX95XN1A25RtdsyhKyEHbMHbb1tB
	txHqQrHn6KUdKmvxu2giIowSbzjIS/CBv5eYkqUzoNuYsWzIiGXuQS2etVGq/F3x
	oPhag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47x0qjjpnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:42:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Jul 2025 09:42:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Jul 2025 09:42:18 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id C51BE5B694D;
	Wed, 16 Jul 2025 09:42:14 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 3/4] Octeontx2-af: RPM: Update DMA mask
Date: Wed, 16 Jul 2025 22:11:57 +0530
Message-ID: <20250716164158.1537269-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716164158.1537269-1-hkelam@marvell.com>
References: <20250716164158.1537269-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MCBTYWx0ZWRfXzEXYwdYlJRsF B9trL3dQ49fnthu2IVlaOcqUgDHlE8SQcnBd7Foy7JpbTnprlGo7xLCrMoKc8xZuRjRkIRkpuKB M4gnD401gFbQxCTirhwmXO7fLN8EWLeczMOedGbUJKNdGsbvBzd4f/YyDToHWf+QF6N0fq21HSD
 Sl2FihRSfTv8SHylATJMFa0rgv2CIk0MmnCMpaMkcnfT+0WmQMdWY0kM5ACPQjCe6zw0PYH9zwS 64dOTDaTrvY5dRWBzCLx/gk8GSphRtapeWPh5Z9lOTvxtupq/sc13ztqIbUEQ0adc0DsuyA0Gi0 MmQ2gub5RjzrUszdyy19NHooPHqPKmXepFFUmJ+0Ffjs2/FOCNnXdFG1Fw1nM/zhHJjHGPAsjQC
 xWM0N/5ARYdWk7YsFmzsLkBU9TyDb8zwGdmpiFPwyju9mppUX73jT2VVasjtJu+Hui6CZ/wc
X-Proofpoint-GUID: y0zNXElfxwoWMUCmIXtI532QSNIBXoAS
X-Proofpoint-ORIG-GUID: y0zNXElfxwoWMUCmIXtI532QSNIBXoAS
X-Authority-Analysis: v=2.4 cv=beBrUPPB c=1 sm=1 tr=0 ts=6877d66c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=AlfTBIRjfgRtOOZVpHQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

CGX/RPM driver supports 48 bits of DMA addressing. Update
the DMA mask accordingly.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index cd6c5229d0ed..ab5838865c3f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1964,6 +1964,12 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_disable_device;
 	}
 
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "DMA mask config failed, abort\n");
+		goto err_release_regions;
+	}
+
 	/* MAP configuration registers */
 	cgx->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
 	if (!cgx->reg_base) {
-- 
2.34.1


