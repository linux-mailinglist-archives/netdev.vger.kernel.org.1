Return-Path: <netdev+bounces-122343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CF960C13
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E559CB253D6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36A1BFE1E;
	Tue, 27 Aug 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VN4AGrw3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03F1B3F33;
	Tue, 27 Aug 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765555; cv=none; b=fzVsCF+sOi6qc6pnyk/ev8C+Amt3BNg0ReRQ/lW+U1DvTysVpmxGbZOisNvJcHcsgfsZK5v/bKO5JJJ5XZn718PGONJseAyKdC2BOjhu9QrZjH3ZZXFnnqYnfbcDElYSG1T3LCddxQq4KQkkirZRmj60Zin28Zcgd69XjzIh6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765555; c=relaxed/simple;
	bh=f8W79yoavSNTAMOaf8JSxKHyav9W6PaRRA9mWiB/dLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSWVj5qifDS4AsymCzubgbwt7KCfc9T5Azy30sxel2esbZwqAxwURhl1Axy7IzJXZxGqDrWgr0BL7D/IOmprRhklBxZI6oeyoikQjAIwHbFGLQCEt5UMfKGXaLzY7ix/N9+O4Bg1IHs90Tzw8wGlAfaa1YzNfnRU3GjRDm2aNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VN4AGrw3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9SQ9N008596;
	Tue, 27 Aug 2024 06:32:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	XoNSeWppwzw9KItgX3Zn5zzgIwBmLQIeCIDLsGNF+8=; b=VN4AGrw3GL6S9/OW6
	F5CxFsfCtTLkrDkviTfoeKYziHpJVhb3Peu8qA7CcYbcBuZCckSAteydDGiLK7IZ
	aQw2kcCTc4DKujGOomLBs25nPOdcS4tVq5RTnzscCQl0OUuBk5SxTwcpzeQQCEfk
	YzFf804pql6yASo2iyOxYLO/6HzV8aNK2A1x2qzQfOT9R1yZipg84uboxzW/Dqd2
	GTtaUZ3kVA4lTLOoDd8UyxcphQSTN5sQR1mm95kGOOVUlijZMZ8F32MSLiOW0dfS
	YVqFANnMxYM0FBCLSVxwnBFDwommYpE70EYhC4phWfJ23mSkvP+ppvKuG58lcpNB
	7A6dA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grra0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:22 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id DC2845C68E4;
	Tue, 27 Aug 2024 06:32:17 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 1/8] octeontx2-pf: map skb data as device writeable
Date: Tue, 27 Aug 2024 19:02:03 +0530
Message-ID: <20240827133210.1418411-2-bbhushan2@marvell.com>
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
X-Proofpoint-ORIG-GUID: Lx3JEX5dMbSwIKBngIT6DBgLS3uE3EhJ
X-Proofpoint-GUID: Lx3JEX5dMbSwIKBngIT6DBgLS3uE3EhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Crypto hardware need write permission for in-place encrypt
or decrypt operation on skb-data to support IPsec crypto
offload. That patch uses skb_unshare to make sdk data writeable
for ipsec crypto offload and map skb fragment memory as
device read-write.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v6->v7:
 - skb data was mapped as device writeable but it was not ensured
   that skb is writeable. This version calls skb_unshare() to make
   skb data writeable.

 .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3eb85949677a..6ed27d900426 100644
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


