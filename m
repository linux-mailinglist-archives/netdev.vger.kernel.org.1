Return-Path: <netdev+bounces-124392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B811969300
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112022846C0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743301CEADB;
	Tue,  3 Sep 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WTfkn1z0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBF1CE710;
	Tue,  3 Sep 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725339612; cv=none; b=l/viz2Ky4s2tliVdVjr7NGhUTGXJO0u7L8/3LdRL37DGDYawkvV3M4ZHxMVUH2nUmq3r2vOC5NfyQY+XPfXnNbfZYHc26ajciWha9PQtRjGtW8Z3ZdeLZU4IAOE9BrJMN6yQbgJH5BCB+fcgKV0XOhS+/fNN8vpOilc+PB/xeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725339612; c=relaxed/simple;
	bh=F8pyndzud3sEurWY47Lo7RtiejQ5CNIu9sShmwRs/8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXwbcY7Tf8LvyuZiE7l8vgn7Ly6tvayLT2NO1c6Qf430ZoPiMI/5FeV+QkZjuzpjsSTJcInDOo/IEdDn9onCqakmDxBMDffaNJQ033H+VMzg5Ym4g3pFily4Lc/O0imTrvYTOC0bx4y5ouU8QBiMo/wdjBCLR7DyvkY3ZYSC2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WTfkn1z0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482LudTN016608;
	Mon, 2 Sep 2024 21:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
	ydIAmKfsZwIlHTuhls7yF+TjOBENT1qOqnBKxHube4=; b=WTfkn1z0hUJkrAiBE
	xSBo4k1VGudTmuT3bdvT/cQTVUBFQYmhTOQdHXwq3mVXAExZWb15ujwlzmFBSx5d
	NF2AJ93VLl35aMuorTQ1nYe1IdWRWY9+K5N2VcYnGolQyd6CybHKOuZDak5+FHzg
	kR6wvQGqh2Ak8J+qVTsPEOqH9inDMk+YeOocnlJRYsRczOQG4fdsNEQ3QrBbAw/9
	ipGcjCYL7VMl9Z8Jh32Y3LvvVepkFO5H/SSWkNkDTcr8FCA74U5bV7owSBGDFncI
	uaLwVCphTL2l9h3P2PAou9tRfgQ31q1R9gVnk+O029IOsIRcJUsPEs6O7cvs9EB5
	kXrJA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41dbv1t92t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 21:59:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Sep 2024 21:59:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Sep 2024 21:59:49 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id E9F8A3F70DB;
	Mon,  2 Sep 2024 21:59:44 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v8 1/8] octeontx2-pf: map skb data as device writeable
Date: Tue, 3 Sep 2024 10:29:30 +0530
Message-ID: <20240903045937.1759543-2-bbhushan2@marvell.com>
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
X-Proofpoint-GUID: JWKlT_D7k52vOnlCHXhCQWrWJ24oopqJ
X-Proofpoint-ORIG-GUID: JWKlT_D7k52vOnlCHXhCQWrWJ24oopqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01

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


