Return-Path: <netdev+bounces-95995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3E8C3F57
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F451F21BA7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4914B95F;
	Mon, 13 May 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fzWqm1OO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887E14B06E;
	Mon, 13 May 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597711; cv=none; b=YeGZxygQhL6Rdt9xOUUOVSPObyn0IBVAc5rqviVaQsI9gBLlD8yJ0gfv66REmx/m48+gpih3noHwr91gp8vhOVb42pbl5PVWuU3+iKkkk2LnsOYXoXTdo2NVgNlKk/4ELOHBpdDNYnr3826iuOXpHnWYZpEAUauhUqPAaSEKok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597711; c=relaxed/simple;
	bh=HIsXKak4myaF77luhn0CUtjKAUGTcQ0It6dOSzQBOLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKeFNT4f5ZzmcP3NjM98VJU9DqhZonp/tn8+kz/O+fs/Y3mVjsglZh4SsLVJG0FXfFEPgfNaf1hX6n9/3UyGNb/8XpsjtNd9K8zZ8rMq/JCXYDrM0KBrDPvrCqC/2R4qRiAgZk+LAkBRKMYlo7n1SFzzN6kEhjb4FFYlFuGZzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fzWqm1OO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9fi2E014208;
	Mon, 13 May 2024 03:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=BhnHh/JpPAcj1s1x841oMiqX3u4Ui69weo3oOd3w4XM=; b=fzW
	qm1OOlE2WWIBq8m3G+DdhmEKHtJkkkAEfJvD7G7pPMAH+erVGG4ScU4HLSxOtFoc
	PKvxGus+qlMfbnoMtJGN1Vo86AhiMVVrH8W4y+iPn38aUuGt6DeK54PQCih/Uz6r
	JOcbY3AidE0BYxNylj155BOycGVw94XIyTBBJuNPxWRqsk5KUbkv5w4dZDmZc683
	504r5k0pp5ezQi/iqgn12THpvG/GCbbXO/At37DzwzaPrD1lrxL+VkXc1L8O4udD
	1hylQS3MCWSZ03VFMHn0mEUowLVbuVQOT4t2VEjpKQEqwARtG/N2iOWg9FE7FVHJ
	Fypldl+uDPePASTAV1A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g5gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:55:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 May 2024 03:54:59 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 13 May 2024 03:54:54 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [net-next,v2 1/8] octeontx2-pf: map skb data as device writeable
Date: Mon, 13 May 2024 16:24:39 +0530
Message-ID: <20240513105446.297451-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513105446.297451-1-bbhushan2@marvell.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l9N_sv-mOFJ5drKP5IW-1-rS52IGbWL4
X-Proofpoint-GUID: l9N_sv-mOFJ5drKP5IW-1-rS52IGbWL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02

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


