Return-Path: <netdev+bounces-78180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6F8743F2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AAE1C20DA8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC201CD04;
	Wed,  6 Mar 2024 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Smq1oCjg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD701D543
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767833; cv=fail; b=ICwd6bgTFAszwlPzVHGtUiRucVPoD3ftK18S2tVKQ3R0kewFA6fLCv3i9U2B0qgb9FhbkjBKtZ2W+rWo26U4qUkQse2PjlmxGBVGBsjalgiqhq3jUVnwOpeV/BZ9l9W9mm51i0crXaGdCWB3rHe1GR9eyraJ0sIWDdvOcDaei/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767833; c=relaxed/simple;
	bh=B6TBvEJ13ZXY1YTMvmPb9apAMpg92tT5V9IiYlJc4pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WML+24QZyHOCQGGC6Bg0who6Po72KVCGnHDTkQkakIElsbZt+nLuR8ci80QU9XlbTGaa7Ea+aQwk4B7LvNLgZOF2ZvQBlTPj8D5LBuI7A8o7Fp35pvDWZgHaZ5WGl8aQhnu2JvVmCNOWQVdj7vhbb1FxHV6MWFm0V/cI9Vhy4iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Smq1oCjg; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEhdFfvvc04uYfhKtz9+bMjR9uvlt0dtP6PWdcca4tus9nt2M1TF6b3itLZUI/rzByGv01rRnveIwYR1G2jvDBZwmQUm1pigq9WV1lDniCHtbVsfbhCnBPlIa+beBnEcdapWHk7UNOnlU8eloCBn2IETFZc2BDDIE4QllPZVKMbi+JhwXxd/tWNy9HTshN7tprj/piDRKUZd6GW2OVrC/3RHoiJmmmwcsn8qUEUjCVNl0HmHKhFQ6cCEypt2fAFEbWToMSvLyYOyQFP+LImBVd+iBqibc2g1fyzPnomwXTe+MVkFxioU7iHy0gxy0eVS3pT7V8H+1ZRShQjZK2MhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlvBCeWXgZK32f4dNM1PHxZHUqakOVnMUzzrnrv7fzo=;
 b=RNEjm70nedi6BLVGUw0X6lMLsqxET7rcd6gHqEGI9xvUUp0xNvdVyMJFZfJX59Cv+mzllHBdl55nYLVBTD2nfjdTxmu5Wi/W1VTvOQY6aqb5f6ttZxibG/Mog4gc0P01tSmJKz6+GHF+X56UrbN7V3nUggxoGiQcFypGW8/uz/ZZrHskGseOYQdHPTPtqvXnQSV1MX0XEbQASOxxdYHo9Dl9fFpDf2BMVoKxBJffkwaqK+ChdULAArRGjbqwjwWg/Nobq1FH2ZQ2D4x+rM6DuOad72AWtn7Bwb4xAXB8Vz+lIEArEI8dc70shhfPL21ENKtmYd7ECE9J8Gfq1CfDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlvBCeWXgZK32f4dNM1PHxZHUqakOVnMUzzrnrv7fzo=;
 b=Smq1oCjgJmRxhFXzPFeZRLoxezhe1DwjNZdGfaz7n2IvCTXnft7oRVBCGWYF1vYwYWv5+k1F2k0xFv7OPTH19xSFD59iDoDfJ2y9dHtbAqEexoobIK+uPqEokHfHdS6sJQQADu4GWRaLUIIaTvbBEj4ZspSfBiD2jvI9hbPE83A=
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:29 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::eb) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:27 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 13/14] ionic: better dma-map error handling
Date: Wed, 6 Mar 2024 15:29:58 -0800
Message-ID: <20240306232959.17316-14-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbd67a0-5387-4e59-6e9f-08dc3e356887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U+bEp+VGLCVA1YcViY1IoD505AwamxFCqeo6rKIQEGjhGx+3kFg+XA/PZ5RzapK8D9LCo0y+PxyDzK2UOy3Fliv7L3uYP+1Q4PowqGZG2Lfdzy5WoqiVi6HL813UXjNqrBRdupWnEc7aTXhesXpa/I8PgZkHoT1684WM/yfmpPUrCqrC40UTYswkwlw9UDq1BXDbRqJdqvwzsb9PLa/Kc3+pTLWu933BkMt+ymez6/V9hY+cZnrSBHBzpyjmXnYJznlXRl0JYWrBC+CFB4B0tWnvnuIh1oERtrhXQhU2h5K6xsHcniqDF15e3JCaFkFNIKQTH1n1u0IhfFWyDyOSLmUblEA5Zf4RCYQ7c7VmGoViV1xYQ5FeZtyTOvJQcxpcnqjBEW0ecy0Mn/VxDRwWL3ZB87kk5EMNpgEIjaQhEQ8T4TwXmp96hrll1G0ExqA06fnvdCKr+mstL12YH35JtRjsrKuNdxxazB5pM5lQMkuMndAXY2N6dA4q9R7+qKm4vjRzFpRPqEBAksS87jSOR65v5yAZaOI5sbS/ZZUFKr7uUFmXp0rDIV8XcQqnh5dfV/O8vEKqKcCPqb/OD3uL0iJIl7QEfTW/RPARe7Fafq+43b3W0wkRC9UnaSPeD6j11zAhTBsIZevtXAbmDzDGDnCBAzA9WaIVVXVYm6waG59c+Bn24zdlBV2cyquRjR1bztUfrRhnVyN+lC9GBiyD/ujB8LDe9d9ItBUfX7xPTG9AIv2OA/mbN+idzQLdIWmA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:28.6880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbd67a0-5387-4e59-6e9f-08dc3e356887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409

Fix up a couple of small dma_addr handling issues
  - don't double-count dma-map-err stat in ionic_tx_map_skb()
    or ionic_xdp_post_frame()
  - return 0 on error from both ionic_tx_map_single() and
    ionic_tx_map_frag() and check for !dma_addr in ionic_tx_map_skb()
    and ionic_xdp_post_frame()
  - be sure to unmap buf_info[0] in ionic_tx_map_skb() error path
  - don't assign rx buf->dma_addr until error checked in ionic_rx_page_alloc()
  - remove unnecessary dma_addr_t casts

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 3bb3534b3d25..d2c930225c50 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -129,6 +129,7 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
 	struct ionic_rx_stats *stats;
+	dma_addr_t dma_addr;
 	struct device *dev;
 	struct page *page;
 
@@ -143,9 +144,9 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 		return -ENOMEM;
 	}
 
-	buf_info->dma_addr = dma_map_page(dev, page, 0,
-					  IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(dev, buf_info->dma_addr))) {
+	dma_addr = dma_map_page(dev, page, 0,
+				IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(dev, dma_addr))) {
 		__free_pages(page, 0);
 		net_err_ratelimited("%s: %s dma map failed\n",
 				    dev_name(dev), q->name);
@@ -153,6 +154,7 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 		return -EIO;
 	}
 
+	buf_info->dma_addr = dma_addr;
 	buf_info->page = page;
 	buf_info->page_offset = 0;
 
@@ -371,10 +373,8 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	stats = q_to_tx_stats(q);
 
 	dma_addr = ionic_tx_map_single(q, frame->data, len);
-	if (dma_mapping_error(q->dev, dma_addr)) {
-		stats->dma_map_err++;
+	if (!dma_addr)
 		return -EIO;
-	}
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = len;
 	buf_info->page = page;
@@ -397,8 +397,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 		elem = ionic_tx_sg_elems(q);
 		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
 			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-			if (dma_mapping_error(q->dev, dma_addr)) {
-				stats->dma_map_err++;
+			if (!dma_addr) {
 				ionic_tx_desc_unmap_bufs(q, desc_info);
 				return -EIO;
 			}
@@ -1092,6 +1091,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
 				     dev_name(dev), q->name);
 		stats->dma_map_err++;
+		return 0;
 	}
 	return dma_addr;
 }
@@ -1100,7 +1100,6 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 			    struct ionic_tx_desc_info *desc_info)
 {
 	struct ionic_buf_info *buf_info = desc_info->bufs;
-	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct device *dev = q->dev;
 	dma_addr_t dma_addr;
 	unsigned int nfrags;
@@ -1108,10 +1107,8 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	int frag_idx;
 
 	dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
-	if (dma_mapping_error(dev, dma_addr)) {
-		stats->dma_map_err++;
+	if (!dma_addr)
 		return -EIO;
-	}
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = skb_headlen(skb);
 	buf_info++;
@@ -1120,10 +1117,8 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	nfrags = skb_shinfo(skb)->nr_frags;
 	for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
 		dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-		if (dma_mapping_error(dev, dma_addr)) {
-			stats->dma_map_err++;
+		if (!dma_addr)
 			goto dma_fail;
-		}
 		buf_info->dma_addr = dma_addr;
 		buf_info->len = skb_frag_size(frag);
 		buf_info++;
@@ -1141,7 +1136,8 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 		dma_unmap_page(dev, buf_info->dma_addr,
 			       buf_info->len, DMA_TO_DEVICE);
 	}
-	dma_unmap_single(dev, buf_info->dma_addr, buf_info->len, DMA_TO_DEVICE);
+	dma_unmap_single(dev, desc_info->bufs[0].dma_addr,
+			 desc_info->bufs[0].len, DMA_TO_DEVICE);
 	return -EIO;
 }
 
@@ -1155,11 +1151,11 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 	if (!desc_info->nbufs)
 		return;
 
-	dma_unmap_single(dev, (dma_addr_t)buf_info->dma_addr,
+	dma_unmap_single(dev, buf_info->dma_addr,
 			 buf_info->len, DMA_TO_DEVICE);
 	buf_info++;
 	for (i = 1; i < desc_info->nbufs; i++, buf_info++)
-		dma_unmap_page(dev, (dma_addr_t)buf_info->dma_addr,
+		dma_unmap_page(dev, buf_info->dma_addr,
 			       buf_info->len, DMA_TO_DEVICE);
 
 	desc_info->nbufs = 0;
-- 
2.17.1


