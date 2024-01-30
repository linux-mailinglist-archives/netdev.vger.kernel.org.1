Return-Path: <netdev+bounces-66929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685784184C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D329CB223ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF9F364A4;
	Tue, 30 Jan 2024 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVZ9MhxA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAE36132
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578270; cv=fail; b=V9nx/SDZAkZigMEKzt3dEPZlnJX+Tuk5DftwQKtDcGBlpvwh9+Z7c7ubUy5jasYD9p+88S04epf5o1CK1b6hqQJ5h/ikFFU0+tagODYL4jDToQrgyIbXr+/VKQ9mlpE7BCELkkYQzPWP/4NLe9l2Jj5hGi25OcEAQcvOelPd0Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578270; c=relaxed/simple;
	bh=0wIeKF9Dt1bKwFHXNxtRsnn73s3kJFATJ5BrI5qA6D8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq/twHb2iFNFt1V9lCVTJsv/CjMJz/ClSduAQDg6AtcpXuCC/nBSP4N7XCmL2hA5Cwj5ZLhJJzvEoXvbojBFKt0Oc/mjNHsTu9soirDHSZWyLNf3D68lfo3M3wEv4mhYd7LTeZTrwuBecIpN6Zhp7FQVyhHYAjKhb/3BTZi4JG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVZ9MhxA; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+x60dxWj4IdlysnFTx8MpNiy0pIilycHHy2lVBKI+ehGhSN6y2MEXBQzmCeSxlJmoXfeONRniWS9RnzFhWSzpufFO2FPxr/LUyZGMFVWZ4A/vIGR1SjyGjzhwWJ5+daUgt0zPyBnlowDvs3AnErK09YFGcCl3mG9h5KKdfOb3FmB927QVXU9czK5vKYolzjd82qVKS6Uu46KbAoAho+88k/po9H1yIwi9cBcoYgt8jqAdfD2drVIxUaX726z+gyvztnO6OQoLbaLy4jQ2dIaSEPhfDfEQJUIzJIApuI76mGOAeaBIbw3cCMmhjui1n6Mv/7DQJ2dW7PFkP0+Raz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB6sc+32yCgiNi4g2j9bFkm4E2q3QAPB3kdRX/SP8G0=;
 b=k0U9DPsg6kKLD+px/1/SP3ijXczCi9X4bprDraCto2KDOYJmza1Zc7UyUaWwqoX0OyF7Nv3FaSIHl5DWfF4UqY0zRNCGkQj1Hr26koexrgu1HzwGpsXFG8pV8LeDklxtgR0l4RUvpJyZB94BjYGct1ntZWa0yDvz6KDLfdvOUvFYUZsKWxwHzS5r2NMPeg9SMBBydVv+BuJSTF4TqpkgcUFGIQ7L+QRM6KAsUT9D+QC5+V6nyBnA5bTjxVm4QRfp/XiSwKPQcuw22UvSAuZOjU/SuHP+UQYGR8/glYPgyIvFYosf5C87/3ScAVZTeQfRC92/k3teffFRtmWuyZZR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB6sc+32yCgiNi4g2j9bFkm4E2q3QAPB3kdRX/SP8G0=;
 b=jVZ9MhxAguBFW4L4MRDfjXDHrPqq652ejglc8ZcnBOQdsNyEsw12hgSFWMZu0pU/wfKe2p5AkMq2Zlw5Xaf5Z+QYb2/Q/xw6IHfETh18aVOuOkKQKpXl00qIielrlcodk2BKhxlggihT9WP937P0zgQZcXBjRRl3MxOCDqkI8Ys=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:31:05 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ba) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:05 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:03 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/9] ionic: use dma range APIs
Date: Mon, 29 Jan 2024 17:30:36 -0800
Message-ID: <20240130013042.11586-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 03084e8f-b521-4aaa-177b-08dc21332098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IiU3BobwZwNdUcTMbFIBO9EZpXcjCLe6MYKpaS0NZxkOCIOP9nvqIR9FokwsRw3xj+tHXCBcBYxdxqyYdeKjz5UXHumMkJJin3hYX3oAohgDtFOyTQ0N1JmwOQR9Zx0lkxuvV479RXWso0Qyd0X66lmiuDoY2t++gNHSqlBql9onSHxyk2oA17wztgvkoUWv14dbkJ3212Q8wZKz8Lkp3qaxdVde1NpHcmQqobfuc8hJqD6zCsONtsyeLHQvRuRpRN7SbUnk4K+zTCHnvhMCXsCKBWq67dQCA0BgQMKRv4FyHv/TEqbTu0H2HM8N/UNwhzPuTdyqiaJuWoMWNDgrkF/wPn1/sVouYsLiywN/MuY7PVFeuu3+egW3Z890ppGYvhzZxtwQyYNxKI8sAHx7dWQwOYV0hJh0klv0DPi3akH6GlJpItt46HsVtdxeZnomOB2YXYUC4lvWqpArN3OOMS09JD+C0O5aM/IChhLvwyYSCMB8rFOEtFBLTfqzfLyF/V2sRvGC01Z8F2iCu+tLJanZ5/kb5fZCr6hw2z4jOxJTNZAr24bAIDzjCqzR5NJyZOddyU9I1rU431kC2SBhM58X0MmEyqyXoGOU1S1VcVVHeg56UyY8GyzLSYXUmyY7Cs8L+y6oMVBibOXQes3hs4WnaGY3qOXOlS/Zuh+wgThvRQ+PmwcdcbcGsracJOdfE71mP/9xyZmFFKkA4ub1lb4RXLKOGzNE+vOPD6Qjur/ISpdtMSI2d7BpGP1xwGbJ+SSNoOUAHBnKKLGiHluYrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(6666004)(478600001)(86362001)(54906003)(2616005)(5660300002)(2906002)(44832011)(70206006)(8936002)(4326008)(110136005)(16526019)(8676002)(70586007)(1076003)(316002)(36860700001)(47076005)(83380400001)(26005)(336012)(426003)(356005)(82740400003)(36756003)(40460700003)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:05.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03084e8f-b521-4aaa-177b-08dc21332098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

Convert Rx datapath handling to use the DMA range APIs
in preparation for adding XDP handling.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 19a7a8a8e1b3..aee38979a9d7 100644
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


