Return-Path: <netdev+bounces-124398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36396930C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5482F1F2523F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9331D1F45;
	Tue,  3 Sep 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BbJKYyCC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE961D1742;
	Tue,  3 Sep 2024 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339636; cv=none; b=cqahcCGPOJx4B2jyO3ZW9XnbXkmXqltLWdP0SgPezn6qU43wKLiWiCzwH4bTHBCqemLS0ZJmXQpePumtBqkP4JdQQq3kCn/07Jys1TqhKmWJPCe5C8FAHp0D4qOB65cN36n4OJGhdPlykSrvd53v89n21nX6lMKFmcD8HhG0MhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339636; c=relaxed/simple;
	bh=SS+38bffDWxh3Nhd0+TIE3qx1Jmz9MbK9uexRM0JFrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBSk1GSLQ8dKmJUWmSZPwYVZZXY5v73mHul+eKPhuEXDxS0O3FRqKz4huZyfR5ub/9L0WCJxVpol9j33eEmabeoSNOQoG0UYtWg0kibhglYr+ecMfPmYCtViVUqR6c7suB0W9h62GvJIR0H03gmlDVDkBlG5QU6Egj1BW1zNXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BbJKYyCC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482LudTS016608;
	Mon, 2 Sep 2024 22:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	nLgJY3FEqvlHvIZRHMA5c1yjMMidBix7B3mthvdaPY=; b=BbJKYyCC3clSQUnIn
	C9HNNDCuYywV9qZ/M2Eu0B+vYnnR8BYU/7hAnHWsgq3qhVNpYTZ8+SMXSz11sfS9
	XSRLxtTu6dv/fFjmq/hyckLvezwlfPxd5OUrXBMeHgbbvPfzMYLL8VXJ9qtzTRSP
	/Y0axx9aictayE0D4m/7/XL+28GPk/40QQU1HiHM3gLsYEO+PTHmkSP8932G5YIl
	1VIHglu7vglacLG7++Y+/kSLN7diaJzBgD7wviQbrre6EpQG6un4H06pze7E0MPV
	kyOeSKqVdKDbDsi7kKntKhAqIvP7S36iPUfa5gNYoc6kA9vAz54ZjEBkqV6+dSc2
	MrG5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41dbv1t95t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 22:00:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Sep 2024 22:00:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Sep 2024 22:00:24 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 29F1C3F70E0;
	Mon,  2 Sep 2024 22:00:19 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v8 8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
Date: Tue, 3 Sep 2024 10:29:37 +0530
Message-ID: <20240903045937.1759543-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903045937.1759543-1-bbhushan2@marvell.com>
References: <20240903045937.1759543-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tDy414uu-aChtzaX3YA2R8MuBfCcfn0I
X-Proofpoint-ORIG-GUID: tDy414uu-aChtzaX3YA2R8MuBfCcfn0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01

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


