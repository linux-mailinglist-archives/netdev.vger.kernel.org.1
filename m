Return-Path: <netdev+bounces-70055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA984D75C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D598FB230D7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06561C2A6;
	Thu,  8 Feb 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PyRwMzno"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D78DDBE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353876; cv=fail; b=ZORNAmRqmtKoXfz0DQbjlbefu0+wfpwye4+fIF1dPFYD8R2VlX2/HB7CbfNFQhqDeMPAceA7hsUjrFgTMVZMvq/hcWtdsarCgXJWO9Pb+oXDlMintJfcA22XJVVxyMmMbfEHuhgn3GZH7QrDaW5xweOCR1F4bBiycaISLtriymI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353876; c=relaxed/simple;
	bh=ocaX0BB8A1+6mcOQTJdFidTGSAn3vr+bBH8Iww7i2BA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3QM445sURTILmSRtz+mNBCov3Cy3zDAJ36zM35GdV+u+gPnezqIREwCk/YftHqTPWRPa51Ctq65ZTTzudtT8wwx2kf3/R4iFk0tSciFyyMAO1FQI2DP6t7QXc3PeTHtVQRziZjGxVcrZh9YAjyr7Q6jx2/gs6BkDi9oz+zMZ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PyRwMzno; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMIGpTxkYUe0TPovHNKo3L8d2G+JQhgTGYyYF6sryYlGYnkmzz56h5GaQw/VdWxuIio8qYOe6O+A/9tNUOvW9AwftZWlwCo3bCiogmM3tDH+/iTcS+tJgyD3RbAqsHPA0bkgcjBEnOcDSjy4WfnnwFeyV11FVPlaCEZzzR4qMsB9FBpQa9a3u4eQww2xVoVsfubo+LZa7SiTAX7qQCxW5w4zh+QXGGy9ixxDSLBzLFJC+t2DcABG37Oqmw+UYYN/T8Dq1vTqrzgnekNHq//bOsPamgjiYNDzOBrLwh/SE/AlGzC0lawVSrCCb4MI9mr0V5CLGFW0HbJSdK/tGFMwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tERrZit5qTr/Otlt6+tO6mnvY7vvISBQFEBW/Ws9Cxo=;
 b=SO1yI5+aEdCNqva5EWujoKZ7cHSgS46chVCu23mZQBlYXrK8DwjnI537zZW/P4Xpb7X0EtkZxB7Bp4EPY5negYKfPU9GsfOBFlfHwkkXJ0ikoys6ioDey7L1IMZkYaC0+AhoscQzHU/7HUT3gxtFYOrbwhCXN/pEBRTxgtjQB0C265IGs4dA/9/IVDNWpmnBrNsOshY2aMuqgqYBvdRCdipggYB9D+vfF8TEjSGt7acgQYtX4TSDBQRrZ6slGtS+I0DRgCXehu5qrQrkSc5uhZ3pzpS4N7U33EYFsMuawIgYL1RhCXi184LzM3KM4OJ+vWInQg5xLM9mLiJagEFpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tERrZit5qTr/Otlt6+tO6mnvY7vvISBQFEBW/Ws9Cxo=;
 b=PyRwMznoTnRM0AVNMynCydQGtZEWoVm1HE+dr96xeDWOlmKNeuhKFIUp13minsv01wy/oqKLMSFANyUaQSUHHYpw7rrLbQuQutDJylwvcvdtmci//68LB8CNx6ULN+pKBQrE6++L5ryggJLO3uuV0syttjafwkVN3qs5S0QQY/o=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 00:57:50 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::4) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:49 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 04/10] ionic: use dma range APIs
Date: Wed, 7 Feb 2024 16:57:19 -0800
Message-ID: <20240208005725.65134-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH0PR12MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 148a7f95-9390-4a9c-c732-08dc2840f947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SeWkPqkKoN9Qfzbb9HFhLc2eHkNv8NVSLNrxS/widafV6TLjJAz4Owz6H62nos12cS+tOjI5ZvN+Iq8qapslfo57uooANDnfU9/eFHRwtzzBgZWj8ze6zAYeA7CFVNs509SF+KSkD2+0LhTdzcJSNALbCI8vehhiDHYQ/tjt0eRrtuNk5nRR4UTi2GUm8ZTc6tXiBEQkq5wO00P9uTEdyr7U6AyoGtJJfaUOfGH68sOljEgojidgttu9hBWat3ubBOXh0a9BLn1FNuFlnjqQCg/lb8cAKo05FvyVUkg1qVDA5uRKXklMYY0Glry37BPqTbK1RhHiKFxsDhzIGE9e5nwBZacRMQJ7SLdVC81XOtHcfVxsrCzFRIVPBirKCsu/CicUdZU+bCx//0T40Zpj3Ryf14WDI/nZamoAHNTqMJPIrVkACTxnFxR67jeE+MJDdsIAsVdpcwz0QMA5FGdx6Hh08vE3Bf+TW/uUeQkDRR74esrKpugSrzvo89kaZt/yEMhCLiofkkJOLWd9FLSV08ARXDpgtTQA9t57OmtXVHvnaAhe1gv5NP9y8AKNMTOEmlaHwwmgi9Mkh5uOWiPfJ8BblmhxR3FuXr7gNPfDkvM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(70206006)(316002)(41300700001)(6666004)(2616005)(16526019)(1076003)(26005)(54906003)(478600001)(70586007)(426003)(336012)(110136005)(83380400001)(44832011)(81166007)(86362001)(36756003)(8936002)(8676002)(356005)(2906002)(82740400003)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:50.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148a7f95-9390-4a9c-c732-08dc2840f947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202

Convert Rx datapath handling to use the DMA range APIs
in preparation for adding XDP handling.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 8659f5a50a6e..65d6fdff3767 100644
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


