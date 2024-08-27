Return-Path: <netdev+bounces-122344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C0960C15
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0826D1C22375
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7E1C1725;
	Tue, 27 Aug 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="apg+w+qB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020561C2DCD;
	Tue, 27 Aug 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765558; cv=none; b=CSqk18wbrjYikcp2uaEtvZdoo4Du6QRTdvnoNPPCNm8eUODoKCUBYFbgGa1N+6Gwv7fVpzUMNFmQL738iRgO/x+pwoEOZAtSpqk7cITlKknZx/Pl6YkH5mruLNaPkjzyyuoWrTo8ftpvA6+93VRYEer5KFIAjxTiE3CDEIIuryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765558; c=relaxed/simple;
	bh=HxEavz/5iVF3t+hFWc1HymZNB7cnJoTL1bljY0bOzoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwx91A4KF3XchoHT7K/LxLVX0c5HGSQryvBhssumc7mbK1AL8AIKJkqXdn2MFdOApSOZ35VMBXYQsSHtR8NXFBsyrJS2NiNxUI895evgcRaHiU0s1Um/tbitkbQUqLIP8lkNwdMDhttoYH2FnF3ios1gQjCCGGy4jR2wNrZYghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=apg+w+qB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9SQ9O008596;
	Tue, 27 Aug 2024 06:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	DY+vpRFZi5BQ6mQDq0WUDNhbYi/TwNHQLQhfo5UHcw=; b=apg+w+qB9Ly9ISz0C
	hJhOpdIjRdb/Rp+rFnstJmBGgLde5OL8FlAsGtmV7Bt4Khx3nA2SmFfnQ0mIpxmS
	7fhsucEI5OuwVZlayd+k5wh+PCLDPmQKqnOUIjTVf7GiYDWVCFadRpa7IHy9HdS5
	Xru3HFACkfvrinAya1Eejz/THnFU9bCtYBnrOD+s4SM/rkUfiv9js2V9ZwRAAl1+
	B04dXGaK/3rG3gXtNxUC2hwwvSQEQltLk2Kl5+vwhFHcDG1pUOSvJ3xSAOWT5l94
	sv1bbDvxjgw1IgpSahIUq9XG/ugCorgPeuWYqVhrjzxI+hw0l8o8QtpWqSXYHaxd
	PYwTg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grraa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:27 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id EDA255C68E5;
	Tue, 27 Aug 2024 06:32:22 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 2/8] octeontx2-pf: Move skb fragment map/unmap to common code
Date: Tue, 27 Aug 2024 19:02:04 +0530
Message-ID: <20240827133210.1418411-3-bbhushan2@marvell.com>
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
X-Proofpoint-ORIG-GUID: n3pdzPyoXrWUcJHfTljhxiddGnnJKDu3
X-Proofpoint-GUID: n3pdzPyoXrWUcJHfTljhxiddGnnJKDu3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Move skb fragment map/unmap function to common file
so as to reuse same for outbound IPsec crypto offload

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 46 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  3 ++
 .../marvell/octeontx2/nic/otx2_txrx.c         | 46 -------------------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..3f97f2c8ce3d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -10,6 +10,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/tso.h>
 #include <linux/bitfield.h>
+#include <net/xfrm.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -1911,3 +1912,48 @@ EXPORT_SYMBOL(otx2_mbox_up_handler_ ## _fn_name);
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
 #undef M
+
+dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
+				 struct sk_buff *skb, int seg, int *len)
+{
+	enum dma_data_direction dir = DMA_TO_DEVICE;
+	const skb_frag_t *frag;
+	struct page *page;
+	int offset;
+
+	/* Crypto hardware need write permission for ipsec crypto offload */
+	if (unlikely(xfrm_offload(skb))) {
+		dir = DMA_BIDIRECTIONAL;
+		skb = skb_unshare(skb, GFP_ATOMIC);
+	}
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
+	return otx2_dma_map_page(pfvf, page, offset, *len, dir);
+}
+
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
+{
+	enum dma_data_direction dir = DMA_TO_DEVICE;
+	struct sk_buff *skb = NULL;
+	int seg;
+
+	skb = (struct sk_buff *)sg->skb;
+	if (unlikely(xfrm_offload(skb)))
+		dir = DMA_BIDIRECTIONAL;
+
+	for (seg = 0; seg < sg->num_segs; seg++) {
+		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
+				    sg->size[seg], dir);
+	}
+	sg->num_segs = 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index f27a3456ae64..a791a046f1c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1127,4 +1127,7 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 int otx2_get_txq_by_classid(struct otx2_nic *pfvf, u16 classid);
 void otx2_qos_config_txschq(struct otx2_nic *pfvf);
 void otx2_clean_qos_queues(struct otx2_nic *pfvf);
+dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
+				 struct sk_buff *skb, int seg, int *len);
+void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 6ed27d900426..f76c95027871 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -11,7 +11,6 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <net/ip6_checksum.h>
-#include <net/xfrm.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -81,51 +80,6 @@ static unsigned int frag_num(unsigned int i)
 #endif
 }
 
-static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
-					struct sk_buff *skb, int seg, int *len)
-{
-	enum dma_data_direction dir = DMA_TO_DEVICE;
-	const skb_frag_t *frag;
-	struct page *page;
-	int offset;
-
-	/* Crypto hardware need write permission for ipsec crypto offload */
-	if (unlikely(xfrm_offload(skb))) {
-		dir = DMA_BIDIRECTIONAL;
-		skb = skb_unshare(skb, GFP_ATOMIC);
-	}
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
-	return otx2_dma_map_page(pfvf, page, offset, *len, dir);
-}
-
-static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
-{
-	enum dma_data_direction dir = DMA_TO_DEVICE;
-	struct sk_buff *skb = NULL;
-	int seg;
-
-	skb = (struct sk_buff *)sg->skb;
-	if (unlikely(xfrm_offload(skb)))
-		dir = DMA_BIDIRECTIONAL;
-
-	for (seg = 0; seg < sg->num_segs; seg++) {
-		otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
-				    sg->size[seg], dir);
-	}
-	sg->num_segs = 0;
-}
-
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
 				 struct nix_cqe_tx_s *cqe)
-- 
2.34.1


