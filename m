Return-Path: <netdev+bounces-103101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537E9064CF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E11C225D3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D75B5D3;
	Thu, 13 Jun 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AsIjR0W0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67257CB9;
	Thu, 13 Jun 2024 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263254; cv=none; b=GZA6Rdzel4hkkCbwchIdBeVgxAPMGVPo2pqtiBtdYOe95eu3G2iL/iohJZzfx7nO1KVJVlJha3mjck3QhoSbr6VZfEr0aEnSAcEvqxPL/gzJfL1/FHbajstneMqrWZk5iau2X1UDLLZD+hrj19Csewkzo7v1qVgfESMukZTJVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263254; c=relaxed/simple;
	bh=ZEjE5gSDkEnEEHSk+YaLYsjF06BS6AizX0EEg8MHbos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouRAqSIufXMuskBmE1e3z88lZa5wmEaF9g75Gbbtyd6Etr7XVZlmuQHEQvBxjzi3/5vc1yNk/aspHjJflK3c2ELBNQJ2FQH0ouEZZwPoMMejcJtS6MsTJNkodHURo9rDIjk9ygL+UwBo3wan6FCS8XhfZZQah1UXhb/4+LFmdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AsIjR0W0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D0Anok019119;
	Thu, 13 Jun 2024 00:20:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
	3ThqkvFOjh8sW3y6L5JjcHLygVz7+TBKbfwXf77C6w=; b=AsIjR0W0aTSQKmsg1
	iJeO16C/ZQQNAsiJfpaf0et7lFEA7UGsST3AUiduHcWpSmAi5A9whJWbGjMNjNRz
	if2quBGHjpk5G3hq56GTTF40ef5w/rh/P7PWLXagutgFBxGfUtYJGjSUADJ+2INu
	t0KzgxsZ4rqZ8tiq7VdlrxvYaDbdkOxgrbZQ960VMnC/VIndYVh6Gcg4dBtEISri
	v+qClQ6vhxFi1BINQez2mMLLm7X1ZLjY97dLObn4zpF4couEpzzFWgI3ShHtNQgh
	XHGniDT3kX4RKLgoK77KvcqOsvG+0YIft13J1pe5Z0QSQQjbWl973XW2zcK0W4Ef
	RvL+Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8syw4kf-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:20:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 00:20:10 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 13 Jun 2024 00:20:06 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v5 2/8] octeontx2-pf: Move skb fragment map/unmap to common code
Date: Thu, 13 Jun 2024 12:49:49 +0530
Message-ID: <20240613071955.2280099-3-bbhushan2@marvell.com>
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
X-Proofpoint-GUID: pjQll2_QmLmyktQaEHJw0X35AI7qrvMr
X-Proofpoint-ORIG-GUID: pjQll2_QmLmyktQaEHJw0X35AI7qrvMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01

Move skb fragment map/unmap function to common file
so as to re-use same for inline ipsec transmit

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 32 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  3 ++
 .../marvell/octeontx2/nic/otx2_txrx.c         | 32 -------------------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a85ac039d779..7ec99c8d610c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1911,3 +1911,35 @@ EXPORT_SYMBOL(otx2_mbox_up_handler_ ## _fn_name);
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
 #undef M
+
+dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
+				 struct sk_buff *skb, int seg, int *len)
+{
+	const skb_frag_t *frag;
+	struct page *page;
+	int offset;
+
+	/* First segment is always skb->data */
+	if (!seg) {
+		page = virt_to_page(skb->data);
+		offset = offset_in_page(skb->data);
+		*len = skb_headlen(skb);
+	} else {
+		frag = &skb_shinfo(skb)->frags[seg - 1];
+		page = skb_frag_page(frag);
+		offset = skb_frag_off(frag);
+		*len = skb_frag_size(frag);
+	}
+	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_BIDIRECTIONAL);
+}
+
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
+{
+	int seg;
+
+	for (seg = 0; seg < sg->num_segs; seg++) {
+		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
+				    sg->size[seg], DMA_BIDIRECTIONAL);
+	}
+	sg->num_segs = 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 24fbbef265a6..99b480e21e1c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1128,4 +1128,7 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 int otx2_get_txq_by_classid(struct otx2_nic *pfvf, u16 classid);
 void otx2_qos_config_txschq(struct otx2_nic *pfvf);
 void otx2_clean_qos_queues(struct otx2_nic *pfvf);
+dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
+				 struct sk_buff *skb, int seg, int *len);
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 847052b57d9b..f368eac28fdd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -80,38 +80,6 @@ static unsigned int frag_num(unsigned int i)
 #endif
 }
 
-static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
-					struct sk_buff *skb, int seg, int *len)
-{
-	const skb_frag_t *frag;
-	struct page *page;
-	int offset;
-
-	/* First segment is always skb->data */
-	if (!seg) {
-		page = virt_to_page(skb->data);
-		offset = offset_in_page(skb->data);
-		*len = skb_headlen(skb);
-	} else {
-		frag = &skb_shinfo(skb)->frags[seg - 1];
-		page = skb_frag_page(frag);
-		offset = skb_frag_off(frag);
-		*len = skb_frag_size(frag);
-	}
-	return otx2_dma_map_page(pfvf, page, offset, *len, DMA_BIDIRECTIONAL);
-}
-
-static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
-{
-	int seg;
-
-	for (seg = 0; seg < sg->num_segs; seg++) {
-		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
-				    sg->size[seg], DMA_BIDIRECTIONAL);
-	}
-	sg->num_segs = 0;
-}
-
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
 				 struct nix_cqe_tx_s *cqe)
-- 
2.34.1


