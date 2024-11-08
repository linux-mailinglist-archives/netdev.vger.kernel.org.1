Return-Path: <netdev+bounces-143192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E749C15C3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E71C22477
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DD51C460C;
	Fri,  8 Nov 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EN+ORXgM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DE2BB15;
	Fri,  8 Nov 2024 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041864; cv=none; b=C5iRLwMsxpJmrnjNgTYpgp1Q/vvaD5jSGh2H8ODmQrP0HwYhX5ag7zdCKdBZvnBc5hMF+E9798Q2+EW/qsl95Hq3pog2a295Dd8dnYxOJTHWbRUSKJjIApu1yqJ1dh4eF2ZMotBINBDMhfJpWRo0sGbry940hXevk4jzNWnlwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041864; c=relaxed/simple;
	bh=CgmbEOe7b3AX51Ivgp4ZdWo3olrU9H+EIj0YlBsUSU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC0m00TZGhhbp/049NE+l7Or0f4QhSNYUqrMjRWI1O1KLu1GlyelC8myGyBU4UDYHFIINqYuzTwaSNaNdXuigvMnQoCaGrkyIwIJETCQjRYAF0Y06cE6UjOG5N7qx0KUBE4yeDOLfDCHoj2/s9/q4bHHTWhtXh06qUMegm7cwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EN+ORXgM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81ghcm019269;
	Thu, 7 Nov 2024 20:57:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	BfLRKB3KPRWp1lnPfPGqpUnZQVYA37jDoWl/5xc9xI=; b=EN+ORXgML/xSm6Uui
	e6Zk7wT+/bpWSMYCrhcmoazvAlk6ccx5F5Dnmk9GbnxKiQbvgRq6Px2BgzhEY28R
	+JuN5y2w4U7/Jtu/T5ZhKJt1QMzUL4n5vMkOTQnJycmo/xbpVIHt0B2zyCRRkBpn
	Prd6vZEw0rkozFIPhPgtM5Z5LAtsd3pCyUojJ6g/F3ovQ/7FTqhS+unbk5sY/JIn
	lGmoUF7H19gM5BLwJVzNHEpENI9XAuA4v8js+HtghaU7ZCecM2wtdVAn8qglps5S
	CAt0iDzSFEjEIELx19WUQpSYHGF2ab9KwGBwboe46Pfr4ES4zesBGXtBt3FRx4Kr
	OoCjQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42s97hra0y-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:34 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:20 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 140973F7044;
	Thu,  7 Nov 2024 20:57:15 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 1/8] octeontx2-pf: map skb data as device writeable
Date: Fri, 8 Nov 2024 10:27:01 +0530
Message-ID: <20241108045708.1205994-2-bbhushan2@marvell.com>
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
X-Proofpoint-ORIG-GUID: zO1bbcXRAN6dJwOsACZKvH4v8J4GV4IN
X-Proofpoint-GUID: zO1bbcXRAN6dJwOsACZKvH4v8J4GV4IN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
index 7aaf32e9aa95..49b6b091ba41 100644
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


