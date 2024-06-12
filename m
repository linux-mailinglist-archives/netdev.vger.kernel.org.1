Return-Path: <netdev+bounces-102873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FF905413
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A34287180
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0B17D377;
	Wed, 12 Jun 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X1j3yiTt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFC17C7D5;
	Wed, 12 Jun 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200012; cv=none; b=HLeE0RgeS24Yjfh/DFcWkE7jZKi45v4IaQKDFom9qOuJzJ86tHQ/N7JJrRKkIrdgP7X9dKtGWe74yDxivE5AYhcM0O2FWgr7ibjk8Np2grV/UqojRkvyoDBKpKmCBV/1S6yc1nyfc1FsY/QBdBNS86AXIWMisi4oRWpCqElktNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200012; c=relaxed/simple;
	bh=ZEjE5gSDkEnEEHSk+YaLYsjF06BS6AizX0EEg8MHbos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxJxtro7x4zLerS989/aPDSuY8fJmmOzjEhj6IUB0mP2JQLXJQ2IeOgwQNDuHt3Omqbcb6ucDd4c0PLbCHjbmm5RA8PX7ZaproSq1w+N2ahNlmdem7d0w0wnKJa8PfSLTpNKP/kdwFKZMjyjrLMSLcJG1IPpsYmjKlHG4V1jgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X1j3yiTt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CAbbLo016777;
	Wed, 12 Jun 2024 06:46:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
	3ThqkvFOjh8sW3y6L5JjcHLygVz7+TBKbfwXf77C6w=; b=X1j3yiTt1R/3y5PXN
	p+Lunfuxg0+4o/wmW6cft+n8Q4SBor7ef+4LRsdOplo0Egz+eyD0tqpwQ2Zkpcim
	hoyXP9ly6X3DVExbXdKW8GzUnRBbnzpSvShdB8TIFYDSitkkLrp2lPRn0QCuKM4Z
	cSgt7C2fHHrjxseZAHSYHRWzwfzNW+PCQ0VZGCmntfpnvbNB1aI+xDLT3odmY50Z
	Nn632R8haIw1yogfvx2M/dXFKgCCo7tKlmlW3skJXqSSDCxoL+0PadE6QFa2vBOF
	BV80QenfESFOL1wSjD8jx9uyClWN50hb5IXOjcGSNh1xB6s9YnqOSETfmld9BZPi
	qGwyA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0u3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:46:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 06:46:41 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 12 Jun 2024 06:46:36 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v4 2/8] octeontx2-pf: Move skb fragment map/unmap to common code
Date: Wed, 12 Jun 2024 19:16:16 +0530
Message-ID: <20240612134622.2157086-3-bbhushan2@marvell.com>
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
X-Proofpoint-GUID: -vk48ungvmuJty0FXOsI3m2wm1blRUP-
X-Proofpoint-ORIG-GUID: -vk48ungvmuJty0FXOsI3m2wm1blRUP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_07,2024-06-12_02,2024-05-17_01

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


