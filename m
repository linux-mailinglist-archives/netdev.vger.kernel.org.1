Return-Path: <netdev+bounces-119707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A98956ACD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9D2851E8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE516D31A;
	Mon, 19 Aug 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ImizkGbz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113D16CD24;
	Mon, 19 Aug 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070287; cv=none; b=nutHC7agIGPoVY2Mcs+UAH4mq+ipgkU+LfwuUY1YjVeIMZhvpPKsPhsUWLsFihnjFBKpEpQwyImXEt4hJaQ2VfORoyigFm7Lk8LHSH0p0gpFzliyQP8F6sT/KjJeH4F6pBrPkQx8IvlbeRfqOFVaTNmSRJ/iJgp6Mt6aTEJwmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070287; c=relaxed/simple;
	bh=SS+38bffDWxh3Nhd0+TIE3qx1Jmz9MbK9uexRM0JFrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dtx7Q4ncCcFdfydYMeC59zohyceTrrAHRthss6IMsTBcO19vmCTvlAaKMMc3y22bswXbKnKqUg358xgBk1IyEt/2Ss+rSeQdfyqC3KNerlTihMyQKHpZlmFNWxHI9wAso6igjRssW7vsDOUQa4q5De/LSwWfXNW+owOfoSk+u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ImizkGbz reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCFtk4014182;
	Mon, 19 Aug 2024 05:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	nLgJY3FEqvlHvIZRHMA5c1yjMMidBix7B3mthvdaPY=; b=ImizkGbzeRfujSeUe
	ete+f5mtQVAK+bclDCfmwvo8bdS1K4HbwMoW4ZeUp8fMmjuLgMhueHYOujmdoDgc
	kdRXfYj6mNzq/CmNfGLdtSsIleigaVFZjhVIA6/vqisVrj/cxYGCTediBRF+1aaV
	EzuUv1me6QiLbk6Wp/hAnEXOijiGQNFD5gZzHYHr3NYu7eJDyBePndwMfixATwzX
	JojAGvq/R55S4gxboQDH2hyvUl5HqYEXD139Lx7KrXJaULZOJNXUZLoi40wh7ggx
	855Xhf34S5sfRugaSKD9IMr7BCTIqQPvNWYKBSRg6fNVbnwyLjg2gc8qQU1TTJ0Y
	qvtNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 414406rav7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:24:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 Aug 2024 05:24:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 05:24:36 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 77CAA3F70A9;
	Mon, 19 Aug 2024 05:24:31 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, b@mx0b-0016f401.pphosted.com
Subject: [net-next,v6 8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
Date: Mon, 19 Aug 2024 17:53:48 +0530
Message-ID: <20240819122348.490445-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819122348.490445-1-bbhushan2@marvell.com>
References: <20240819122348.490445-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Eb2C0RGy6iNZpsHNohMscs9-KAvZXs-H
X-Proofpoint-ORIG-GUID: Eb2C0RGy6iNZpsHNohMscs9-KAvZXs-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01

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


