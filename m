Return-Path: <netdev+bounces-70712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFF850154
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E9BB20D4A
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6C1C14;
	Sat, 10 Feb 2024 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeiwe2Mc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002128F5A
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526137; cv=fail; b=Umm3AhNFSBF8H6odWIgcwCBJx7/R4tUzDQ7cM+zsWv1gFcHIkd2ExwoLSB7Demx0XllrO4NTY5QIlJIJgMT06dT4jSlx64wFxW9Om1ekQEDOycvhCurIltb4oGAhBEq+kFo20RgkyonhKtrnmPM9IsY1OZEHo3niVzkv1BWY+5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526137; c=relaxed/simple;
	bh=is5SApTjOjWbIesn1PDIlldTn05/x6Eimzbwb/B0txg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5EYpGF5GCGi1Qq1z0LBybvXrUnawjpVkpYPG7nzvIhVobbXeEhCUJ7XMDWSR2yCy1absRmDeDlHnuXrYG4WPBTy73e69K2NvMwp3lJ/9cdiHAzlhBRH8oS3Zyq6rTXxxVSTywsGlY2lhjRHo/Hi+j8HbNVZ2GN3g+J53HWRGlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeiwe2Mc; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhD1Upab+MHEIa+J/fsdbkFKp17wEWwhKFCH5P1gF1nywYIM0C+ssXfmpH+bDVoI4MvbLK3n9Vjn7nZ5qaD4z5xYWNfuBGDYv1H9YKQJwbTHOZ1Av+/XGQnODBzV3X+KrZTaqIkDM0E+u+MPisjDC8uAOv5D6lXQuW9TU/eJ0VkaQ2h7uPKt0JH3RNlsTpn9uB/GvjHSnuVV0MTGYxeFfgTXSDezkrr2X63o4j77uhvtYBNWnoe20/Tc1sv30Vo1PCHUv5cSgA1odysMvvfbFTw0SYK2WkOgQXNgMVamX/Ci6pqi1lGYw6o8A6H2Nt3RKG454nu1pWE1R68rEWd2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf/60fAik8xXgccAlci4YD5vdo0ptJU1oBFBXL4micE=;
 b=glo4tMa2YAep8crIchfmI5KknvxAA1PUU8afEC3H4bv41/wO2isd/C2GhVeAa9l7GMR9jiozeFLvCwtr2w7abp1/teUZzpumPHTrAtbOgk6X/+2pjMqA6MR0KINt0Se70WdLZmgYPGiIZPbDZ1i72tVN7YB/rqwTT9OE0NPcrJoh+GrW6OG+IiDXwuseujQP5SXfHJqoLKH+qTXyJNNMKVw7yY9LvqK6LQ8UcdhbnimlYfnBpr973rLH4PiasH/OUQvLRXwPcuBExfF9SIVEip7oCrLU14Vl3I+sfUcbyTGOggap1aB7MD6q3IwmxIG0U5ehsoyUqLnptIDHBFUiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf/60fAik8xXgccAlci4YD5vdo0ptJU1oBFBXL4micE=;
 b=xeiwe2McCeCuMJH2KSevwMJ5nfOFNhz3EbobTOY0qKleIYD2STeGbdLIZwhF1rgbEyMKQe7wMBl//4J7EbkzyXofMVe3Y75AkrErFdTkB8sNsPW2fHi7KpClNG2bevELdy7wS6YK7c2EYKP5VUfzBAyEQ0DBMiVu2ncEAQHnRf0=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sat, 10 Feb
 2024 00:48:46 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::74) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sat, 10 Feb 2024 00:48:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:44 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 3/9] ionic: use dma range APIs
Date: Fri, 9 Feb 2024 16:48:21 -0800
Message-ID: <20240210004827.53814-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2bcaf5-862c-4bb0-f5ee-08dc29d20940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mmvtkg7KpBcSFa/ThMkXPJOU2Hqn/sqJXioI95jEIkL1KGkEoiDnA4yWV1noKLm8AfuCIhvUTxxvK66Ybkop5ssi55ldPk4sVf6CXew6iAIIzN8IawHmF+6lBbMXQP6HCHGRVyqIqQHdbXyomL3XO9kv00jMiTYmM7GNCbCXk17wLuGQZphX4iaSI039J6nsInsl2RuW+ijgbwzRvYMIVMCiEUznzWTeuMTeoGvr7ISr+TzAbLBHsNmQ1fPXeXTj6+7qBMGSrf/AO/YrM713xWcJn5HkpLJ1xlg4rdRGyozYP5c7wL3KG3VokrM+EwKYaTjoY4zyvPouC5iecCRDMfVij08gZf4YWqXwX8NFGOvBJOjiheURUfYoLtCpWdLMiIuF6Y+zSMhN2CodeYJxPU0XcPxFgSGf844n2SGU1Th9g+u4nJ5urXomPmEU6jCPJsgMA16iSZqS1pLJ1IS+5Ni6tm5tu1PtfJaYlkZKNj4s5ouxwJoLZAFk3Z3zzCqIUqoyydw+yGD5DKHVh9AEJE2BvJNZEVQbosA5vFgsW2tbPbz9jaJjtwHiMYENojmMSi+boISLjpA28jBtF4D8NgpzDoiVcz+SJKOZYLQS4Fo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(26005)(16526019)(82740400003)(356005)(1076003)(41300700001)(2616005)(336012)(8676002)(2906002)(426003)(5660300002)(4326008)(6666004)(316002)(44832011)(81166007)(83380400001)(110136005)(478600001)(86362001)(70586007)(54906003)(70206006)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:45.3797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2bcaf5-862c-4bb0-f5ee-08dc29d20940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

Convert Rx datapath handling to use the DMA range APIs
in preparation for adding XDP handling.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
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


