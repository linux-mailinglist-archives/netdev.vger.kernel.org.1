Return-Path: <netdev+bounces-135623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA899E907
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E232825B4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F911EBFFF;
	Tue, 15 Oct 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YGfkevLU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E51EBA1D;
	Tue, 15 Oct 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994267; cv=none; b=tLzHEsQmsG8opV/TOUu8aWWyA+mrP/HOFq8R+gDNWZfi/rlskpehH9+NX/9eLrfnSOOcvs9YCeyUbR8YNZgvg/QPlxLx7qlv3G6FtqlDkYNuxVgUddWqAc/2n+LyW2/yfaj50znzcM212aIxyGEJ1/SypakIff1M1TAWATqpSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994267; c=relaxed/simple;
	bh=FKVp5vpBUXs9dMLCpXHIOv/MvMRafV2gDUGkTmgmweg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/uTBdyu+RDfr0cZ3Rf4O+zm+xqOZ+qrSKPU4EFfNI5ElSbUp/ZCH6h8yUF+sgg23Ek3KQdO3wZKne2gFczyeLsCMu5qgB7/38q0NXOSN6RSpoaGZ+l+ScOmI2CMnALlGBm6uK6y1aZYnn6+piNrE3ZZgHZY/58Bk3eYJ+Sr/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YGfkevLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1ftQP028798;
	Tue, 15 Oct 2024 12:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bwIoDeKVLLzKk1wPRI1PME
	LTefSmd2FDqLO7WTxs3DI=; b=YGfkevLUWSCZV4/1CK7XbVqjilZ/XC0UmbmeR4
	juNpHItwBsDRt1krB4UOZtDQlKyvctr5u8SWLgPXHPRtkNGX9HthwRvV4gkZqGXI
	PTUSmerb1GmhcmreTklePu6PcPjNb9saV9UbYss7A9odI9I3wZu8iyRj7Q3sSAJd
	pzv7Nzikmxwuctt+N0zHdXT/630aMGaWyJnwhZF2TvsHGUxooptVAoWXktp7aFt1
	GXkD3FVnGipXVYWUvmem4+RTHb83LVyy6DKkifxD0vF481vEnbkyT0qfPznOZe+Y
	HTFfVEzgZdbiHxrEKhSrBx9xCKV46WEzoOo4685HNCI2hZHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429exw1cn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:10:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FCAavT023123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:10:36 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 05:10:28 -0700
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: <quic_jsuraj@quicinc.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>
CC: <kernel@quicinc.com>
Subject: [PATCH v3] net: stmmac: allocate separate page for buffer
Date: Tue, 15 Oct 2024 17:40:09 +0530
Message-ID: <20241015121009.3903121-1-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3vdKVCVOlCHuMO-n908EqOjoPoO9Pl0T
X-Proofpoint-GUID: 3vdKVCVOlCHuMO-n908EqOjoPoO9Pl0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150083

Currently for TSO page is mapped with dma_map_single()
and then resulting dma address is referenced (and offset)
by multiple descriptors until the whole region is
programmed into the descriptors.
This makes it possible for stmmac_tx_clean() to dma_unmap()
the first of the already processed descriptors, while the
rest are still being processed by the DMA engine. This leads
to an iommu fault due to the DMA engine using unmapped memory
as seen below:

arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
iova=0xfc401000, fsynr=0x60003, cbfrsynra=0x121, cb=38

Descriptor content:
     TDES0       TDES1   TDES2   TDES3
317: 0xfc400800  0x0     0x36    0xa02c0b68
318: 0xfc400836  0x0     0xb68   0x90000000

As we can see above descriptor 317 holding a page address
and 318 holding the buffer address by adding offset to page
address. Now if 317 descritor is cleaned as part of tx_clean()
then we will get SMMU fault if 318 descriptor is getting accessed.

To fix this, let's map each descriptor's memory reference individually.
This way there's no risk of unmapping a region that's still being
referenced by the DMA engine in a later descriptor.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
---

Changes since v3:
- Update stmmac_tso_allocator based on DMA mask.
- Update return statement in documentation.
- removed duplicate code.
- fixed Reverse xmas tree order issue.

Changes since v2:
- Update commit text with more details.
- fixed Reverse xmas tree order issue.


Changes since v1:
- Fixed function description 
- Fixed handling of return value.
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 68 +++++++++++++------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 83b654b7a9fd..e81461ac3424 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4136,18 +4136,23 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 /**
  *  stmmac_tso_allocator - close entry point of the driver
  *  @priv: driver private structure
- *  @des: buffer start address
+ *  @addr: Contains either skb frag address or skb->data address
  *  @total_len: total length to fill in descriptors
  *  @last_segment: condition for the last descriptor
  *  @queue: TX queue index
+ * @is_skb_frag: condition to check whether skb data is part of fragment or not
  *  Description:
  *  This function fills descriptor and request new descriptors according to
  *  buffer length to fill
+ *  Return value:
+ *  0 on success else -ERRNO on fail
  */
-static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
-				 int total_len, bool last_segment, u32 queue)
+static int stmmac_tso_allocator(struct stmmac_priv *priv, void *addr,
+				int total_len, bool last_segment, u32 queue, bool is_skb_frag)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	unsigned char *data = addr;
+	unsigned int offset = 0;
 	struct dma_desc *desc;
 	u32 buff_size;
 	int tmp_len;
@@ -4161,20 +4166,42 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 						priv->dma_conf.dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 
+		buff_size = tmp_len >= TSO_MAX_BUFF_SIZE ?
+					TSO_MAX_BUFF_SIZE : tmp_len;
+
 		if (tx_q->tbs & STMMAC_TBS_AVAIL)
 			desc = &tx_q->dma_entx[tx_q->cur_tx].basic;
 		else
 			desc = &tx_q->dma_tx[tx_q->cur_tx];
 
-		curr_addr = des + (total_len - tmp_len);
+		offset = total_len - tmp_len;
+		if (!is_skb_frag) {
+			curr_addr = dma_map_single(priv->device, data + offset, buff_size,
+						   DMA_TO_DEVICE);
+
+			if (dma_mapping_error(priv->device, curr_addr))
+				return -ENOMEM;
+
+			tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
+		} else {
+			curr_addr = skb_frag_dma_map(priv->device, addr, offset,
+						     buff_size,
+						     DMA_TO_DEVICE);
+
+			if (dma_mapping_error(priv->device, curr_addr))
+				return -ENOMEM;
+
+			tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
+		}
+		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = curr_addr;
+		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = buff_size;
+		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+
 		if (priv->dma_cap.addr64 <= 32)
 			desc->des0 = cpu_to_le32(curr_addr);
 		else
 			stmmac_set_desc_addr(priv, desc, curr_addr);
 
-		buff_size = tmp_len >= TSO_MAX_BUFF_SIZE ?
-			    TSO_MAX_BUFF_SIZE : tmp_len;
-
 		stmmac_prepare_tso_tx_desc(priv, desc, 0, buff_size,
 				0, 1,
 				(last_segment) && (tmp_len <= TSO_MAX_BUFF_SIZE),
@@ -4182,6 +4209,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 
 		tmp_len -= TSO_MAX_BUFF_SIZE;
 	}
+	return 0;
 }
 
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
@@ -4351,25 +4379,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		pay_len = 0;
 	}
 
-	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
+	if (priv->dma_cap.addr64 <= 32) {
+		if (stmmac_tso_allocator(priv, skb->data,
+					 tmp_pay_len, nfrags == 0, queue, false))
+			goto dma_map_err;
+	} else {
+		if (stmmac_tso_allocator(priv, (skb->data + proto_hdr_len),
+					 tmp_pay_len, nfrags == 0, queue, false))
+			goto dma_map_err;
+	}
 
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
-		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		des = skb_frag_dma_map(priv->device, frag, 0,
-				       skb_frag_size(frag),
-				       DMA_TO_DEVICE);
-		if (dma_mapping_error(priv->device, des))
+		if (stmmac_tso_allocator(priv, frag, skb_frag_size(frag),
+					 (i == nfrags - 1), queue, true))
 			goto dma_map_err;
-
-		stmmac_tso_allocator(priv, des, skb_frag_size(frag),
-				     (i == nfrags - 1), queue);
-
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
-		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
 	}
 
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].last_segment = true;
-- 
2.25.1


