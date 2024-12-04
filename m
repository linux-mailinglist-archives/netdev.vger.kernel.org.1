Return-Path: <netdev+bounces-148821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4F9E3356
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D68DB23FF1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F8189B80;
	Wed,  4 Dec 2024 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i15BsQWT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24EB18871E;
	Wed,  4 Dec 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291855; cv=none; b=a1wKXC+YCUsTxIM1gg/JBaknB4LQ1r1c51BvwiTHXv0Cd7TLNSwTfOlienqpwjKgprJ6QgugAlUMdu4ZgOz6pAqBk05mh4REZJnx8kZBM3+sJ5M/nbl2taaIcD2P62h8vkut1+YiIJaCloonhkAB5DZ/Cz6qq609FxsbzYTEajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291855; c=relaxed/simple;
	bh=H76ZQKFSXEvBHZ2n4qzasstV61OS5C80MqIYXHI24jM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EG0pU6FStFKhaYLx4ioBod8Nljt6+2zG1Xro+IqLOWGUK7kkYb32A4Ncy1fEPuUR4cXPPYFdEKt7yhc4aGH1Z9ooNPy5LR3AqmjjDHADOzvSnOe1NFPdlAsolvrtQyu50qbPKZAg5/1tebeMLKTccWmqRTzvxnYs+92PZ0NyVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i15BsQWT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B458qbf008976;
	Tue, 3 Dec 2024 21:57:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	2qS9alOdXx4XW9zOan/Qgw808hhHtpgxkElJbWCvK0=; b=i15BsQWT+ZYqWZFdv
	IWluKIMa89iGM1RrSiNb66D36g45cqDhqITP/w6rfnZxl6h/GwPRCvnavzu1wVng
	sbC9/hIUExMUFL/KBLNQQIz3u0QgsrDgptvF3Be+c03w4TRbl1alM/tfHS/fbHhj
	O6kfWfL8s1f2E4Jn5LPqJaPY495xni5BiG8zXsLoYjfUYfvHdOVvDMofq8KYT8l1
	sieET0W5INahtIMgidCCRZDLcg9rFLUAHcWsmEGRy+aPMFWXgVPFsoYQ8YFa+8dL
	YvDXEbB2yHN/nvo9v2lo+CNWDvOquNLLbXh85Gyx9PlCcgI2YU3kKnT1NBmtgPDa
	I2jkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43agp682e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 21:57:12 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 21:57:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 21:57:11 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id B62663F7076;
	Tue,  3 Dec 2024 21:57:06 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <andrew+netdev@lunn.ch>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>
Subject: [net-next PATCH v10 1/8] octeontx2-pf: map skb data as device writeable
Date: Wed, 4 Dec 2024 11:26:52 +0530
Message-ID: <20241204055659.1700459-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204055659.1700459-1-bbhushan2@marvell.com>
References: <20241204055659.1700459-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MIgIS3yHdJOLyKzxInCz2C-e4sFkE1rN
X-Proofpoint-GUID: MIgIS3yHdJOLyKzxInCz2C-e4sFkE1rN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Crypto hardware need write permission for in-place encrypt
or decrypt operation on skb-data to support IPsec crypto
offload. That patch uses skb_unshare to make skb data writeable
for ipsec crypto offload and map skb fragment memory as
device read-write.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v7->v8:
 - spell correction (s/sdk/skb) in description

v6->v7:
 - skb data was mapped as device writeable but it was not ensured
   that skb is writeable. This version calls skb_unshare() to make
   skb data writeable.

 .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 04bc06a80e23..3b0457e52a6a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <net/ip6_checksum.h>
+#include <net/xfrm.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -83,10 +84,17 @@ static unsigned int frag_num(unsigned int i)
 static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 					struct sk_buff *skb, int seg, int *len)
 {
+	enum dma_data_direction dir = DMA_TO_DEVICE;
 	const skb_frag_t *frag;
 	struct page *page;
 	int offset;
 
+	/* Crypto hardware need write permission for ipsec crypto offload */
+	if (unlikely(xfrm_offload(skb))) {
+		dir = DMA_BIDIRECTIONAL;
+		skb = skb_unshare(skb, GFP_ATOMIC);
+	}
+
 	/* First segment is always skb->data */
 	if (!seg) {
 		page = virt_to_page(skb->data);
@@ -98,16 +106,22 @@ static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 		offset = skb_frag_off(frag);
 		*len = skb_frag_size(frag);
 	}
-	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEVICE);
+	return otx2_dma_map_page(pfvf, page, offset, *len, dir);
 }
 
 static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
 {
+	enum dma_data_direction dir = DMA_TO_DEVICE;
+	struct sk_buff *skb = NULL;
 	int seg;
 
+	skb = (struct sk_buff *)sg->skb;
+	if (unlikely(xfrm_offload(skb)))
+		dir = DMA_BIDIRECTIONAL;
+
 	for (seg = 0; seg < sg->num_segs; seg++) {
 		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
-				    sg->size[seg], DMA_TO_DEVICE);
+				    sg->size[seg], dir);
 	}
 	sg->num_segs = 0;
 }
-- 
2.34.1


