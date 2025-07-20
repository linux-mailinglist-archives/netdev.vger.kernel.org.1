Return-Path: <netdev+bounces-208444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF5B0B6FC
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6867A178D76
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BF22154B;
	Sun, 20 Jul 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eIJLEhkf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AC1FF7D7;
	Sun, 20 Jul 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029430; cv=none; b=cRejTSDyUmuWqrqavoa0oiP8npt+8sfC9UGOg4bt1MRSEXkT1EEbPNUJqIFdi0EuP7Nw51ItHD4BA8lPgHYpFtHPiuggDk12qfy6GdfY2f8CjWo+yH8PVMKhgTg2opRFBICR+n85jirn2NQe3qKQKYlyNP78JGxyTA091SAaogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029430; c=relaxed/simple;
	bh=TjPGihYbAeBm689axezDdpax0N5QejcMk/aYP+B4mKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfbLET4eO4I70p+G1yHjfQRE1Xcienw2I1dgUM6otkZjYAdHXwCcnhFvB62DAI2llqZnXbIeWhBFRjaKnIYQYoLuhbxDKMN80XZ0l09oGn6x95RX+AoXh9v7A2aWTf+vsiocPnsNzdQqYZWDMpn9ZnsvxfNUInFXzQQWMtiGtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eIJLEhkf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGCPR8017109;
	Sun, 20 Jul 2025 09:37:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	1806yHtlhvYI2gx7RwpSHJoB95T1AI0ONc/4MlwW+c=; b=eIJLEhkfvjLY2+sJN
	ryQERFESu5uA4fCC602uX2AqY+ZH4HYz8T+WUJBrTRKfc1ouGSiS1VtSJMIa/aIy
	Q7COF7r0anTjoFK+dVhDcyRD6IOez+86vCsaJylWrgqASywwOGB3CvJNL0oAKBcU
	0I/cvo2bUyOgQJMY3KWEn6NJvjF7HhDp6027zN4j/aRDvO8+hPRw24arBIqCQH1t
	Bq03Lq9LaW5HFugjQoL8xSwbVP0AHGUu0kZoDE90b//ggaqk/6nUcCwM4tEbzvGA
	Ecdgsu1Obc4BzMbuPgHUa6AgPr918d+hBHv7xQ/GzN2oDcV5yLwl5pNCS0xmLzSX
	8dtaQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 480ymbg8pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 09:37:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Jul 2025 09:36:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Jul 2025 09:36:59 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id AE4203F7057;
	Sun, 20 Jul 2025 09:36:54 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 3/4] Octeontx2-af: RPM: Update DMA mask
Date: Sun, 20 Jul 2025 22:06:37 +0530
Message-ID: <20250720163638.1560323-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250720163638.1560323-1-hkelam@marvell.com>
References: <20250720163638.1560323-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VtgjA/2n c=1 sm=1 tr=0 ts=687d1b2c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=AlfTBIRjfgRtOOZVpHQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zESiucV5_27wXmfcs6PE331uDFq4RBa5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE2MCBTYWx0ZWRfX8ZxsaVOMm5P0 YUTr1o7Z8kPwMWkIbkiijXk3Bkg6tSW8uK5bdTZ6k8QmA97xEPTNVmH9fuQI4XUOt860NdVO1t+ Cecz95BQ4jfRtDgAZwJ/tSuvKIxcRgs9gpDClTsHpFkrtaF2XRsJssbq8d6wbiQi7yQ3TC9PcvL
 4q3mhU7Xqx1PcnqhTfmyCf17VTI28uUV4fPZTMYBihGBnoFjxU6Tdw5Vd3KgNypCrSUQjRTzNCS wEzOBirBduBxvAvxIpG2Uu5DrSZozx39R8V4mfjtHLP98mvL4uWv/JwBuiK+vnbyopKC/zbDJVs QxYk30buFZ0dTrFok+lhGdejO7gjwS3d1HlSbQ8Qh0QtF/tcJcK2htShYLUJaP2up1drqpdSD2E
 lmxGgW/Yo2M5hSUV/iTyr4s4R2mCswa6RoYF1LDj4bYRAp2G+75Doi5axxhxyaWEMy9cmOGk
X-Proofpoint-GUID: zESiucV5_27wXmfcs6PE331uDFq4RBa5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

CGX/RPM driver supports 48 bits of DMA addressing. Update
the DMA mask accordingly.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


