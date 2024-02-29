Return-Path: <netdev+bounces-76315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D586D36B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB30A1F25CC0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3AB142918;
	Thu, 29 Feb 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5k9hNzE1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD413F43B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235627; cv=fail; b=HP5dleVJ/Ns1EYcITgAox9+6qPXerf9/vJ/AGONzfZLcQiyOntw5FcxmPNjLWMXImzb8hZhuJ/APpBMKYN/vcZ+Af73jMBQ9htn+qfnbSLg2k7WnHzk3RZdLJjhuSbmVZTnKxQ7yNqe4FjKz6JuOONNEjdts4DRU1jVw1/KKWIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235627; c=relaxed/simple;
	bh=FvoBlSB8W6Avy1O7HcKx1gVevq6T2nt1xsAOBmEIs/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5gAnhL/mv0GZTXKe3DJJjaPAE4d1xLNc3TPZlh/Hh5N3d4mugF7NesO5dR3yAvFh8CnL7SiyCRV46bQVvuv3BMVivCIalgSZ83WVJVayEbMWxFzGmSp7TuXE0YauhgwKP8Vy9dEw+G44ykzwg3AL8k/qc8BjgbgyybIj5WMNwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5k9hNzE1; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwN8TV6oX7M+Dxk03ZF3xJeaboWKRKbCT6NfpYXQ+HIixdZDJpS78luqRl5v82AAOjVtLaPiiVekl6mSEmqskRuqRZILBhkCe2MWw3+kt2Y8ke0DJl4DpkvdvPzZ4GqfVqBaXiF1pcHeNK7FoB5vSNRS2H+BnvlK/8bHJpLsQIn3FP3kF7Uk2ZHjCEkNMb6Frw9V/QJa6aLft9UMCfFwEvcmlP5GxE3ggPqWPhQWWnnKPJG8Qf3zx4Cpoqi/5q+c5gQjXH19FkzPwNJxSI0t6t3SLPD6RKOF7WA28YwIp0khWKiBAqKM1SP8zp1zqfXMm75Lkvvv8oGz7XqururpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUDdi9cFbH2h3iOOsvPA9dd3dZ8MCNR1hY7O1igWfHc=;
 b=mBxdqaJpssvUxa4D5ZyFUBfopnpq8M/j4FkILzOUPd36TH4PHBqLVPlWNuK07/scvGbNUu1JvJJPzhq4/kapoZfWc+VR2+Y45ohlT8ZmH43dz0hcS9qrH1Bb9pvm3a9MGoLBGwK5dmAXcY6QAzToUSMdBmdF93OFLSyfG/2Ys7Sj1uQYBKBtvW96yFBuZaJB8CgVeRgXpyWuEIs+MJ5fgwKpPO+/h97qeEnrTsnUsarRQWJMQK4y2NzySnnFZDMHjAcYODG28PBs1cVKgQrzgi7J1RyV7iAbZONIZS1qly5h0jX5GkiCcsGj/zLLZimKfpyrP44xG4W7TqVd5XMhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUDdi9cFbH2h3iOOsvPA9dd3dZ8MCNR1hY7O1igWfHc=;
 b=5k9hNzE1PiFve7zSZxS3wrJAKD6V2GWqPNo/DKg48SBLH+4AU7l86j1rJbvdkTmTuOPMfYEVB7OGTkeRWY+PdOqp15XbjAfmtSR2FVMUn3MkmjaChmxqTk1QAA/CVtD+7fwlINZW/bjIdF2+HF3Zm7BtS2Ynzu9qBQohfbRTZew=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Thu, 29 Feb 2024 19:40:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::7) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:18 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:14 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 08/12] ionic: reduce the use of netdev
Date: Thu, 29 Feb 2024 11:39:31 -0800
Message-ID: <20240229193935.14197-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: ace3a1f7-caf6-4c77-1ba0-08dc395e42a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+xO26hZLMzuJvZYoUG1rNz4h8BGnXV9DFbHQQJoqL7c3WQgWSFu7Drx64bIxelWa0gFGXBpzCjOXNcuT3supD28ZpzyDkKHti+TtGbEiyzo2XYs4vlgw2WhndsecvheNioXR2CQVc/zPfq+VYoteWcnHsz68oFVuJf1FdOGd1HY2mhz7Ts07reDRRQfykwsGYVBirY+ITySde4p2xPJvzfj+ZpV9M+VdjAKj17IGeLPdTHmT/xG5QftUBzKcBT8WvGBIL9Z31jV3Oj/m0b+O1Icq5CuY+uPQi/VdnEDohdO9u1gxhjbvlFJKZEwvQebV0tkECgwzlAA8MfmZeNfbikkr++K0pfk8A0SjxkFoAm13YcZhRZasJ25slCrXpPEq0LHRAQjIpTew10tbkRXXHLrZZbF9aMK8m1goPjWxElheOFsDmoy5j06NU40zk8utiLsSAKFDlIggA4OGpb8llhAXqaz9gs28FBc6U4PMDW7jWnuGGzXR/+tmykS4bcEPi4pU0l+/LQecjlFp2iqxdAXH8Zo1fAHut2rVzWm6jP5N761emHG9q0+MBhk4taLXt3bKU6xmZZOEUxt8NgVF4zdc3dpdQcwI5h5EoOKEs8KiWD3DThPF0HElNesucOvOWKKGDH2mQ5VJvu1NxMtiB/ePS18My325KTTC8oJpEvaznncmJCk2l//JhcyOSrW2wiogtdL/KL3Y1crZ+LPFzJ3XS2FuNuYBe0AHTDzlXnU2LzbNjTsg1opHq3WXjOH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:18.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace3a1f7-caf6-4c77-1ba0-08dc395e42a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

To help make sure we're only accessing things we really need
to access we can cut down on the q->lif->netdev references by
using q->dev which is already in cache.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index f217b9875f1b..ed095696f67a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -123,7 +123,6 @@ static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
 static int ionic_rx_page_alloc(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
-	struct net_device *netdev = q->lif->netdev;
 	struct ionic_rx_stats *stats;
 	struct device *dev;
 	struct page *page;
@@ -133,14 +132,14 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 
 	if (unlikely(!buf_info)) {
 		net_err_ratelimited("%s: %s invalid buf_info in alloc\n",
-				    netdev->name, q->name);
+				    dev_name(dev), q->name);
 		return -EINVAL;
 	}
 
 	page = alloc_pages(IONIC_PAGE_GFP_MASK, 0);
 	if (unlikely(!page)) {
 		net_err_ratelimited("%s: %s page alloc failed\n",
-				    netdev->name, q->name);
+				    dev_name(dev), q->name);
 		stats->alloc_err++;
 		return -ENOMEM;
 	}
@@ -150,7 +149,7 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 	if (unlikely(dma_mapping_error(dev, buf_info->dma_addr))) {
 		__free_pages(page, 0);
 		net_err_ratelimited("%s: %s dma map failed\n",
-				    netdev->name, q->name);
+				    dev_name(dev), q->name);
 		stats->dma_map_err++;
 		return -EIO;
 	}
@@ -164,12 +163,11 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 static void ionic_rx_page_free(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
-	struct net_device *netdev = q->lif->netdev;
 	struct device *dev = q->dev;
 
 	if (unlikely(!buf_info)) {
 		net_err_ratelimited("%s: %s invalid buf_info in free\n",
-				    netdev->name, q->name);
+				    dev_name(dev), q->name);
 		return;
 	}
 
@@ -228,7 +226,7 @@ static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
 	skb = napi_get_frags(&q_to_qcq(q)->napi);
 	if (unlikely(!skb)) {
 		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
-				     netdev->name, q->name);
+				     dev_name(dev), q->name);
 		stats->alloc_err++;
 		return NULL;
 	}
@@ -291,7 +289,7 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 	skb = napi_alloc_skb(&q_to_qcq(q)->napi, len);
 	if (unlikely(!skb)) {
 		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
-				     netdev->name, q->name);
+				     dev_name(dev), q->name);
 		stats->alloc_err++;
 		return NULL;
 	}
@@ -1086,7 +1084,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 	dma_addr = dma_map_single(dev, data, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, dma_addr)) {
 		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
-				     q->lif->netdev->name, q->name);
+				     dev_name(dev), q->name);
 		stats->dma_map_err++;
 		return 0;
 	}
@@ -1104,7 +1102,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 	dma_addr = skb_frag_dma_map(dev, frag, offset, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, dma_addr)) {
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
-				     q->lif->netdev->name, q->name);
+				     dev_name(dev), q->name);
 		stats->dma_map_err++;
 	}
 	return dma_addr;
-- 
2.17.1


