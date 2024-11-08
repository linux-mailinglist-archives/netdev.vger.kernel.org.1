Return-Path: <netdev+bounces-143198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E269C15CF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A051C22DD0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563651CF29E;
	Fri,  8 Nov 2024 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BBDB+clK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF91CEEA3;
	Fri,  8 Nov 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041887; cv=none; b=mV2G/xPaptbfiqSezIyffnZxJXjaY+p632uZi+2Ic8eSUXTYZmm7ADP26OCflgQ6uGT4tkk+XENRrTY1/4wXrmLGbKT36D80WdG8QQZLKm2c3BeKX3gMWddftgYGleRMSnVCAuQP6i+kbzlED0N+q132+aoWpuC5kCwSb4PESTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041887; c=relaxed/simple;
	bh=8dHcggLHXa7B6jDqR6cQQwfiO56OiCZKA3hzoHn2zbY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4up2n0KM7xuoxm6DMRVJSbiCKUbbD/9YOSAZjYP5warsQ6Qq7fM2bAAxE21ck9dra2aG4Rnxo2srFk+RqqSfZrFdCVWA48n4SvdZMuMB7WGl7S8JqdwZyyQ073+SBtOZPCpqpwABKEY1UvLA2t4mLBQ5suSUgHYYcEG87/y/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BBDB+clK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84EBWI027930;
	Thu, 7 Nov 2024 20:57:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	AHeS7meDGJlBu+tvlv7z8wbQH8DO7tGcf8cVeosOWA=; b=BBDB+clKpUSM94LuX
	kyVflY55qNJjdJZ5dUJg3HY47/iI6eiAHJlgf9/Xyi0+3V/Ed2DnG1KQjGOselG+
	h6BCM6bfs1/03ZLvARRLPslYNuPo/jzVvKbiT2FkjcWDEZwnhSfYQAREiRlQbVHS
	FXG77GbpbdQmja8Pb+2q4rM1skcna/kGqiPYxWGPqQnxtJm1cwkULZYMQF1q67Nc
	D2RT6163KF2iQCJ1YlW3yjRQusSsfD5AIkdlafeK9TnvWvBhyueP7G8CRXbrcBaY
	Rtu4uw+RdK06dA7CCxyxFxo/7a66s6DDyRgckRrl5FghaBPdplLOeRYD7I75+Ujg
	8XixA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42sbdq0226-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:53 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 078A63F7044;
	Thu,  7 Nov 2024 20:57:48 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
Date: Fri, 8 Nov 2024 10:27:08 +0530
Message-ID: <20241108045708.1205994-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108045708.1205994-1-bbhushan2@marvell.com>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VlqAUQ2ahtj69j2_tumdx7UfewzUnj28
X-Proofpoint-GUID: VlqAUQ2ahtj69j2_tumdx7UfewzUnj28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
index a6da7e3ee160..9385d9bd58e9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -820,10 +820,10 @@ int cn10k_ipsec_init(struct net_device *netdev)
 		return -ENOMEM;
 	}
 
-	/* Set xfrm device ops
-	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
-	 */
+	/* Set xfrm device ops */
 	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+	netdev->hw_features |= NETIF_F_HW_ESP;
+	netdev->hw_enc_features |= NETIF_F_HW_ESP;
 
 	cn10k_cpt_device_set_unavailable(pf);
 	return 0;
-- 
2.34.1


