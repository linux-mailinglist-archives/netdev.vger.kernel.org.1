Return-Path: <netdev+bounces-122350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A59960C27
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F1B27C05
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171D1C2DC8;
	Tue, 27 Aug 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vlf4FlDM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FF1C6F4E;
	Tue, 27 Aug 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765588; cv=none; b=a5mZqDRQCwRA+TfWUdHPa1cuk/B1imRu2s5QaLr/9ZON3IrfYfMXfoBBMipo/eNyaqRqu+zUEMSbYgcky88IsX1NblE59MAfjQz6J5osuI4SEHQ9Am9SuuRKH9O1tnspWJ2p6og4WTfL2PHjsPBpY40WiCCVffl1SjeN9zvcEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765588; c=relaxed/simple;
	bh=SS+38bffDWxh3Nhd0+TIE3qx1Jmz9MbK9uexRM0JFrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxdlyvTFsJK4pabKOR6xpGwQSomgoTjZI9F88vfFMpnk+V7kdEZsgmPOcFSxbzrt7yMNZGxRX3HGSI4VRqrYwPji+JPxaCgzjIxL8/AIJpviRUKR767Ktm/Nm0q4fSUFUGKWkDw0qx+uj0x6HqkY8WXGoJJ+6TmEYkLe1JqtzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vlf4FlDM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9SQKH008588;
	Tue, 27 Aug 2024 06:32:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	nLgJY3FEqvlHvIZRHMA5c1yjMMidBix7B3mthvdaPY=; b=Vlf4FlDMSYNRdoQdt
	tXRgQ/QS5gBoh3VLPhybrojGpq9k7KE6Yhkka72jR7/VSuqN1mMgloU1FFJM1vHf
	QyhmjvdUlb9v1dWjUs2l5hmmLAukz0GEjpyNeYjpQiaHahxvB7peMbnvr0UtJAkJ
	Lze/y+EuCUalS0oF36yjvP34q0vK6EFQlY0Id5lbZ3SRGuoFfSA2V6eV0otDnTrM
	ybIJvqdg2P9+YKeO+RgypYblE6dphZa7Wqb9WiWIV+32k20nBEYIcw8BIkCFqcAg
	DStgyYWgcudlkgt01ANk5RvzWcUDYUasOusVI0DaZzHm9gB6MTfoQcGDC7sK+nVR
	4k3tg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grrd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:58 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 669A65C68E4;
	Tue, 27 Aug 2024 06:32:53 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
Date: Tue, 27 Aug 2024 19:02:10 +0530
Message-ID: <20240827133210.1418411-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827133210.1418411-1-bbhushan2@marvell.com>
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DegC94_jbK7xURf7BhET-WRfPHxTjeBl
X-Proofpoint-GUID: DegC94_jbK7xURf7BhET-WRfPHxTjeBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Hardware is initialized and netdev transmit flow is
hooked up for outbound ipsec crypto offload, so finally
enable ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3:
 - Moved "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to previous patch
   This fix build error with W=1

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 6506b9893a33..81fb0d5ad42c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -859,10 +859,10 @@ int cn10k_ipsec_init(struct net_device *netdev)
 		return -ENOMEM;
 	}
 
-	/* Set xfrm device ops
-	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
-	 */
+	/* Set xfrm device ops */
 	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+	netdev->hw_features |= NETIF_F_HW_ESP;
+	netdev->hw_enc_features |= NETIF_F_HW_ESP;
 
 	mutex_init(&pf->ipsec.lock);
 	return 0;
-- 
2.34.1


