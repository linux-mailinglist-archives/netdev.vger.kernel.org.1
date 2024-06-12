Return-Path: <netdev+bounces-102872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3458390540E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2142842F5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B817DE02;
	Wed, 12 Jun 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jy4V4ERG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03617D8B0;
	Wed, 12 Jun 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200004; cv=none; b=ju1DzUJYgNroQ90Xs7bCCcujzlZFUIF19Dn5c9DWFMeZDOQ12CE2ao1+CQzuL7+4mTIcDvBJG9vkGD5/58esN2cUG8kzIQSQxTMUgzKVg6oxwAgw6h5rk15P/t0OJUrP4H7AdT60RkLG/zAcvUkbk2o9/kqzSSXR7jqLqyqSCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200004; c=relaxed/simple;
	bh=HIsXKak4myaF77luhn0CUtjKAUGTcQ0It6dOSzQBOLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNtAgZ8WXdFzfLwrTetdq6FBArghnOZdsshDNkExN8zFHmldDreRhNsrL0n2cfEt0+HCzTuEXNyxKQMJyAU0ekX7J3N9ZV0r+cMQ+ZdtmnWDr0y0lVi1RlQugqztU+7EGh+2BvcjSCdG1v6PRv2URa+6AaNgC2dFzUzu8/S9bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jy4V4ERG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CAbbLn016777;
	Wed, 12 Jun 2024 06:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	hnHh/JpPAcj1s1x841oMiqX3u4Ui69weo3oOd3w4XM=; b=jy4V4ERGQWq7wKB6y
	SJjWmmQ9NQEHzrH7ayY472g9uLTRP3Leq77J8a8rvu3B4fOfoVbP2kTJ+Gw6Ucnu
	tvVrFEOPh8WIVO3wEfwNRUajVG4+GK9Fb9mEDFi1hWWCjlujxRr1gyxj4BHMnhIv
	hIGuxnce5OWmIb9tGXKRJ5SfaOCyJ4xMgd5xP5alOu/QSUm/IqvJatvfIPxY5BL6
	5/8l69Set3wodlzzA+UgdDqkMDDBG2hni9XsBCbsC99WFGtZ8uird8lECuY7fgl4
	NpnFymnbOPQrIl1AVklRJdQhMGnQhDPVQKoXCuqUq8xwGRoHgku8ju+5R9jIagYD
	hiZDQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0u34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:46:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 06:46:35 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 12 Jun 2024 06:46:30 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v4 1/8] octeontx2-pf: map skb data as device writeable
Date: Wed, 12 Jun 2024 19:16:15 +0530
Message-ID: <20240612134622.2157086-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612134622.2157086-1-bbhushan2@marvell.com>
References: <20240612134622.2157086-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: R1hPvG-bmpCpUiYr9N6vLZ25oiV9l4DV
X-Proofpoint-ORIG-GUID: R1hPvG-bmpCpUiYr9N6vLZ25oiV9l4DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_07,2024-06-12_02,2024-05-17_01

Crypto hardware need write permission when doing inline
in-place encrypt or decrypt operation on skb-data. So map
this memory as device read-write.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index a16e9f244117..847052b57d9b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -98,7 +98,7 @@ static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 		offset = skb_frag_off(frag);
 		*len = skb_frag_size(frag);
 	}
-	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEVICE);
+	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_BIDIRECTIONAL);
 }
 
 static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
@@ -107,7 +107,7 @@ static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
 
 	for (seg = 0; seg < sg->num_segs; seg++) {
 		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
-				    sg->size[seg], DMA_TO_DEVICE);
+				    sg->size[seg], DMA_BIDIRECTIONAL);
 	}
 	sg->num_segs = 0;
 }
-- 
2.34.1


