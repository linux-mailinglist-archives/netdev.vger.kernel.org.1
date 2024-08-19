Return-Path: <netdev+bounces-119702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A6956ABC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FD51F211E7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC716B752;
	Mon, 19 Aug 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kK2bnGJK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693216A940;
	Mon, 19 Aug 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070262; cv=none; b=i8lvQz16sPuShxPGW8Gvg159GCz9kMeGjHhfKpsuqMXdFhgVXgUEJCiR7XsPl+rQYhRtTLSPp4PHG9P+0O+SlRFZ/zFe9J9XVv+3S+nW3t5HxUa6qwbiqCwP2UHv5jhCdxq7CEVR+r6RS9lCS4uM99XetTcpTSgJOJx2Pce7aVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070262; c=relaxed/simple;
	bh=XwLelCWVXjNMtIHhbkmagrLOUd6MrXj3aRbHhUocg5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HICH9U8umKVCTMM88aJ8RMmpgywU0P8tBNcxziTQSV+vD2xv7SOss4j97WPxg/CtYUdhTA/FkE1vA/+o49b/bhhgIPW09Kd0BWtYsH+ecB+PgtRUWJM9shPgdnmK1hcQWhIU3PRm80kjGB+5m16ifiUENMD8w0NrDYB0b9A8o3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kK2bnGJK reason="signature verification failed"; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J9QxWf004260;
	Mon, 19 Aug 2024 05:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	i7RE3dvSV0miGipBubQOLlpWZ4xgQPHV0NShe6zCHw=; b=kK2bnGJKA4qj954Nc
	TnLz9E2GfGvvfm9yladst5vqrLeG6Nbw8oknlurQPd0DhxM2sTrSCPkdLbI6ZYdW
	v91NPgDoa0zVH2+ZcuXMWgMdd+hNcaGU6M8fRp7kvpiQ/IPtKu9dVIfiL9ckPm5b
	YbWcOhL7aLDz94LLNuUKyMc1oJ8UDbMBcNEo9Kw+J85pYyrhq2IZ2+LxfBVIR0Li
	WJqn8LbUSe8YgY0bcy15LbEKIpnkDvAlwWpvEeRfDzEh/kF1y52dD3ideNMr7PCF
	IkX6ogPmhW4x96QDBFABNeQZ+PhbyLdtnGAyCW+lpfUKfYJY8KvqU0z9yQrYTqRD
	eFTRQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4143e80fy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:24:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 Aug 2024 05:24:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 05:24:00 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 256C43F70A9;
	Mon, 19 Aug 2024 05:23:55 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, b@mx0a-0016f401.pphosted.com
Subject: [net-next,v6 1/8] octeontx2-pf: map skb data as device writeable
Date: Mon, 19 Aug 2024 17:53:41 +0530
Message-ID: <20240819122348.490445-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819122348.490445-1-bbhushan2@marvell.com>
References: <20240819122348.490445-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lv1bIxtqZCdliwwdKzePs1SXQ-BT8Fi7
X-Proofpoint-GUID: lv1bIxtqZCdliwwdKzePs1SXQ-BT8Fi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01

Crypto hardware need write permission for in-place encrypt
or decrypt operation on skb-data to support IPsec crypto
offload. So map this memory as device read-write.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3eb85949677a..ce1a7db745c5 100644
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


