Return-Path: <netdev+bounces-95859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6338C3B09
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFB71C20EFA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A65146A80;
	Mon, 13 May 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CON8wSm/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B893146590;
	Mon, 13 May 2024 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579216; cv=none; b=mO22mPVtFwQTYyoZ9929RIowp5HgUU2KS2QcespG/AVJJxI2hhcf3JQBzHGW3pDSEgBVjbhI0kWJSd+jvmUWQvXHryPjHJgAm8G3IYGaOCnh4FXhoH5LnYYM1h5spgBaN3oVRKuGPgCtEn323oqUP06Cck+FC0FZ4hM47xH2V0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579216; c=relaxed/simple;
	bh=HIsXKak4myaF77luhn0CUtjKAUGTcQ0It6dOSzQBOLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ily5vC4/7Wox8so7nzQz0Jkwg7ycEjbShmDn0WnUIWrRggTyPC5oxJPEFCVcjU700Bf0Vog8ej52TmXTaKnnOzDbkI5CR634LF4+He8NfXp/AT07eL+mTQsNbFOOSA8VuHm8am+JrdeNIkiOsYoRSa3neR+UhmpewjtXohaLpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CON8wSm/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CNUTC3015860;
	Sun, 12 May 2024 22:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=BhnHh/JpPAcj1s1x841oMiqX3u4Ui69weo3oOd3w4XM=; b=CON
	8wSm/EL6KqjFAMaYYNkNlm7F8LmeNBVrtmgKTDNhF9fqcuzuvn/W6mfzj+lg1GCG
	6EOuI12GWXXMBtFm+0R/l5gay5mnK4rQjoyid+nOpKeTBMdFfTX7/HMwYC00r05C
	r07ygHJvXkcYQBBhF+A9QGQ3HTavYjMFDT6oXIw4y+Is04fp4fZIVMn194hqqUZc
	lEvkpvvnBQMpCaOUnQ1Ka+KmjB6ok/k66d+yY96xUjY4izT4WNW/KC+PCQZh3Wgt
	cL+oKUlcWKBZKBt/QRT9OP3kdgTcuUFOm9mWUlv9AFymKOz1NuFLK3G1o9wQ/iup
	far7dazv8uSiPObMBWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jb8m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:46:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:46:33 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Sun, 12 May 2024 22:46:30 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 1/8] octeontx2-pf: map skb data as device writeable
Date: Mon, 13 May 2024 11:16:16 +0530
Message-ID: <20240513054623.270366-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513054623.270366-1-bbhushan2@marvell.com>
References: <20240513054623.270366-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gukg6yjsi3OygnMs1UeA-LxyfFqYkKwq
X-Proofpoint-ORIG-GUID: Gukg6yjsi3OygnMs1UeA-LxyfFqYkKwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

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


