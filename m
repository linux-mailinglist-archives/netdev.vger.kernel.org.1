Return-Path: <netdev+bounces-103104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE39064D4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8A0B21364
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398437F7FF;
	Thu, 13 Jun 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kAQfI4NB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADA629E4;
	Thu, 13 Jun 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263256; cv=none; b=PU/VIBC/EF8xbHRjEvbkQsU9UhQIrCMiTWSdeqMkcYHs+7EtxSZLiY1LgZ3JJXcV7aOazSEOZVe9BE+hQ2L8zHLpu8cz3IUODjcYjxgUtmhaLSpw+FXq0YZIeD8/bmzvGGwixJDE2PIwI0A0c4EuL+AjVPBducZlndcbcl27P8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263256; c=relaxed/simple;
	bh=yMFA6rjub/hVmmdL32HESANHPl3UzVuSCHp503jaW8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8rlVEXWDvxtKqjHQsD0m8/UMEsSB/Lm+3502xozYSTy1fNOkKYquuy9GrnJrklrJYSwfsL2DA0byDjaSpHkPDXq6RAtOhgR8MmOVILaH5+gDRbhLa0JJmdlnb34sMiyaXQdjtMRRksda8c1+hhv4cHIMttkMH7tnt37L5SeCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kAQfI4NB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D0AtJp019196;
	Thu, 13 Jun 2024 00:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	Y4LL8PBTONkB0gFvC8uI7FhIhgsmlOifoX2nDKQZmw=; b=kAQfI4NBdPxVyzC32
	jDrfZUCHmKyjCS3zLS59Kvb4d46qJKMHjJ5oLosHpMdi7THJvrBTxZVeMiXuFCia
	lSs26r4yRXTtTN+sx99CeYpo81i0jhmDGr06wEMy1hNqJtcINVpLKMDS3Q4y7aow
	pinl+/Rno0AioZksDx5BBqEJ8f+pesa04Ch3ARuZIlGqDYalYqZf/Q1Vm8fnWnbK
	uUQDdSdGUaua+94N8RxKygWddmhwI5wMIw+xfH+L2CcHnqRGhSCsTKYg2kl6p4qN
	EfTduLwfT0TdvWPymRRXp7V68WZrEHSNxMt6rlPHWcww38DBv/Q7VwB8a26b0WWw
	EKR+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8syw4mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:20:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 00:20:38 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 13 Jun 2024 00:20:34 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v5 8/8] cn10k-ipsec: Enable outbound inline ipsec offload
Date: Thu, 13 Jun 2024 12:49:55 +0530
Message-ID: <20240613071955.2280099-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613071955.2280099-1-bbhushan2@marvell.com>
References: <20240613071955.2280099-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0ZJLxJqYWpHo_j2EzkyKLWCK3pEVTQif
X-Proofpoint-ORIG-GUID: 0ZJLxJqYWpHo_j2EzkyKLWCK3pEVTQif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01

Hardware is initialized and netdev transmit flow is
hooked up for outbound inline ipsec, so finally enable
ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3: 
 - Moved "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to previous patch
   This fix build error with W=1

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 0db769199303..0cf411974eb2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -837,10 +837,10 @@ int cn10k_ipsec_init(struct net_device *netdev)
 	memset(pf->ipsec.outb_sa->base, 0, sa_size * CN10K_IPSEC_OUTB_MAX_SA);
 	bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
 
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


