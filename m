Return-Path: <netdev+bounces-71789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8BC855177
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B151F21043
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C312A166;
	Wed, 14 Feb 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5QRyhSy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99A12A15C
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933575; cv=fail; b=hAQL6SxDWJCP4OImeFq+1ZSIqCd8cXcE7ldu4Z0+Nhc88IiyjOiro9pWoScrBCxPUBNXqb70YQ901UAIt51s+HlgVAUvTVRikhX613iKQKLS9zsE/RE9SZHizOzeTDDuFEnisO8Ve+sPhFRHFwdocxkb0qytJClGFElRcHcrza0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933575; c=relaxed/simple;
	bh=Pmn9ltZ6zuZaK+B4AaF8IQ8Lqw2t9Bz8w23qquDmaYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keVkNnwXAWLNSkDwZ1RVHIzlf792/tjA0V3y3WbBO6pYOfVl8niRJPVpv3m7/VR44dUpkWoFr6I48gNuY7GLhvgmlKDrNCDU6Z3ohJhy/7KikcNF9g7rNSHbutvwySc0nZXY6+WryrC85YFP1pr9D5Qg1IMBnyKRVzbzjnPkHOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5QRyhSy; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSwbTp2wLbQzi1hxFKfzVRnAL5fDGA/5aKTvuotMEY3jz4ZGO1Vth00Nk2MW4Y/Kn68wxmA5L93sXst4wQXjz+YqKIy9RMEGXRnoT0VCmPF7Yl/JSNvcJ03HIsyprAqkLCkas6l0RkxruEXDp5IDmIZd5GEfaGUFxVr45LqpfSpLAysSUU28ggavTG/ZtVbDqrFQM5xSpAs4kc1a5HeDRqTgQoGK6G+SkScTxSY/8miYqH8mo/hfE8/dAJBlA8S3lRnoDHl/LXbD9yk5cRJKBJ0qkdPwv3wyZTPYMJbUH/ej74lFOEjW8zuesOpKJp96AXsl15X7bEc8fC7srl1nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYpJNQneOdCzvSiZZ7gIS2G6zShEAlX/Pxs+YmCNKvs=;
 b=VoeLH7Xbv15BIxY+0Qu1YBTzdUqWeNxMunRASh5pXBzzbqmg3rW3brPB8bjxyJYrIsj9wMwuYTW+SrMG4UOjlTCQ7qX96Fuk1uPY/QIOEBHaD0ToFB3YGQUMrqD/9rkBRk3oZYZJ/WNoTB2VEaieYQfb0UQcaCKIsm0rsRwN0Y2OvM1AVR0kl0ECYdbqJORYfvni57U59r8ONLUgfDDaVx0b0Zwtam6EaPEm5qY4IXYRzNGOfwuKAyXgPKK0LuqVA9Nr6pQLBG39dyKPCpA5hsct8Znvd6bhQWu7O6CgPd/H1hqOJmEGzKtbNKB/7s7Y+ZQBr/7zdq+lr6wlU/HZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYpJNQneOdCzvSiZZ7gIS2G6zShEAlX/Pxs+YmCNKvs=;
 b=Q5QRyhSyMdG06G1qzwT5bCjWeZUgHBgc5P9YnfuwWZc3QStzP0kUKSo2s8hFXZW3z4hjfMqbHVWjoHyG8TGPct9n+5/OX8iAZK7Dgev0F+SnAG7cq9JB2TKxKuvkwIQuFO0hjh1+0tNDqLkqWvM/NRvkiUXExQxMNQ+5hy1o+LY=
Received: from BL0PR0102CA0010.prod.exchangelabs.com (2603:10b6:207:18::23) by
 IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 17:59:29 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::5d) by BL0PR0102CA0010.outlook.office365.com
 (2603:10b6:207:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:27 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 3/9] ionic: use dma range APIs
Date: Wed, 14 Feb 2024 09:59:03 -0800
Message-ID: <20240214175909.68802-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: acb5f531-5315-4366-7f91-08dc2d86b08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2AAQTVPVfTC1RPEcm8lFEVZE2sn6U9UcH0v93REI21XILfBGYqLJ4YwUeVmZaSq4Btt+k5EsLwCyzBl0B8x8sWM3BdUmm7/xjCzInVOW1MR8UWpFN/2+wcLvClA0hzY4mARpLrObDREyFT5avNMUkb7mul8bOnOgghrfBYPVjA1QjrMxPRut2oIn3XXJxGZYr5RE0OsIMZtUoELCODNYKFUv1/Xm3kIIg3CzoNKYby8ba10qvpBCKVVSP3oob0J5QQQZtQaIFGIJGJs48o0ZT/vUeygzPL/qNAH0Ec9M34WzNTwNCnyUA0Q2CqiQD6hn7NJh6TzoZGRMl35Zhj0ZUHL9tOIv/SL3ZVZY6VOavcHVvEjxW1x8QaLxdUvMNi/O5F2nIVUrUQWyPcGCuorQU12SZguMhfA7UQ5H31kyDha7xVptwHcqAvjDXEU/9PkGr/ra2ApKG7GO4z98UxdXLSthgsmGPvYjZNwdylg/jlqkTnye5ObTBOWVDb/CBuyLmSLYl69jFBboWprrEIs+MaOFhsSwIHZm2n31fiLV188sUIuvznANKUiWPMDjS7DyU0utso5fmqcGX0s+oC240E9Q81awx3b0CMMNxDahXx0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(8936002)(2906002)(8676002)(44832011)(5660300002)(4326008)(426003)(336012)(83380400001)(2616005)(86362001)(26005)(16526019)(1076003)(82740400003)(36756003)(356005)(81166007)(70206006)(110136005)(70586007)(316002)(6666004)(54906003)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:29.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb5f531-5315-4366-7f91-08dc2d86b08f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385

Convert Rx datapath handling to use the DMA range APIs
in preparation for adding XDP handling.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 00d703c027fb..7f095717595d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -225,9 +225,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		len -= frag_len;
 
-		dma_sync_single_for_cpu(dev,
-					ionic_rx_buf_pa(buf_info),
-					frag_len, DMA_FROM_DEVICE);
+		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
+					      0, frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				buf_info->page, buf_info->page_offset, frag_len,
@@ -276,11 +275,11 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 		return NULL;
 	}
 
-	dma_sync_single_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-				len, DMA_FROM_DEVICE);
+	dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
+				      0, len, DMA_FROM_DEVICE);
 	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
-	dma_sync_single_for_device(dev, ionic_rx_buf_pa(buf_info),
-				   len, DMA_FROM_DEVICE);
+	dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
+					 0, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, q->lif->netdev);
-- 
2.17.1


