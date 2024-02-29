Return-Path: <netdev+bounces-76307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6D86D363
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66479B2332B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3713F442;
	Thu, 29 Feb 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rDtVsBm1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AD134411
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235616; cv=fail; b=W0Fg0jtvISmcVNMUfg1xHqzKQGZpyV5SFy6nPU4wTxqvHXZ2WshWnVcO82GOpWdVLi6WBKd1qvV9WN3Sm631iIm2KGK4bNV4ROrk22ivuO2bXWBP3YoH+q3d+OMK8XTTGIm7wj/8Pdijv4XENman1HVstBsUX+xQVh8g30j9WBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235616; c=relaxed/simple;
	bh=6NkNmhGl3GqKkUtGp4+ioGzWavxeu1jWfD+r8cLaBPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D43kkGrYbqhNwqzxHe8EP5wG99nsTrmMkOe8D+gYq0Ef2pclYm13VyztmOeJ3CwGxZ7cOa/GlcJ3zP8l5x9tx4zb9qsx9Lv282tViXizvGr/nj+S8uVsdmUwLl/YQ4OBujDvGO+Vp6M/b6NnK89lStc0ewSNbY8AgKIxZLa/7RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rDtVsBm1; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmGzoknBifLfHOSnokTYpHLXjb34HVVMw8YmFRIagzsIABpxSPLkW2EIe3fxmcaDHCBb/7rRMujFHBR9pEQGUNmHaiLKJiPwp70ypmMOQBpFI+b0PJM0yPbO6giKSmvcX30oReSthZgLd/yeoc1qttl5+uIKNOThcCA6NUTvbysB6htyOVdHWRAgLy6bhKicScIq1M8+Y05m+dcyrPToHl7yMn9tMyWFoYw6zfhzSPilfE0tfqIDn/Gvh33IMgApOoijUiZsQK4Z159wkLPA2GIZigIAzuwXGwRs+du+tmtb2fQQjg6yrchwXAFiBC182F4EFtR70On4D4k5vzLV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGVTiDm1bOdo1z7x/+epg1MLEXs271pPzrc8UecoXeo=;
 b=oOGiC5YgmX+R4s6ufKGCMyTuv7gTBPVe7q5o3Au6b4c6QWfKfJkkjlYfqzBvPokCEKE2XU0k0T3EdhfH/FHdL4BZ7bZ2ZrMGzuR65RLuysEQhbKp0+WsRtju3lN/Kk0scbxUpKkaWoY2tx5EBseDqJ+MGycGWW6HBUm58+3UMNn4MMvwFi7COQo6v6yOEOMSKvjclTi+zVMD+B2CPzbnoUYVJVabYUWz2duXjQTTQSUanOwDR3OUQq9suUDeAJl8fbHf+WUY26i8zLHWDL9a4kyHgfdkU/gpjBkjrkHIc4K6+UEDynHJOiW9Wi22QVCTSmXUZu1Qnw5mxpY3mOLO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGVTiDm1bOdo1z7x/+epg1MLEXs271pPzrc8UecoXeo=;
 b=rDtVsBm1EI6hzbXjjt0j20vBIxuKX3lrUYiHqf5EUEoZeIbajxCT0uuURyB8dwVoP0nVW7Ekld0WVq8wnk3ANQ8qF+7qruZa8+SQ6fCtMa9VTSGjoff4xs9hAR0viUyj+qCF+bzACaXvPsnrpGfMNiRqoHooiMiZIQPveVapTfE=
Received: from BLAPR03CA0159.namprd03.prod.outlook.com (2603:10b6:208:32f::34)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:40:13 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::c5) by BLAPR03CA0159.outlook.office365.com
 (2603:10b6:208:32f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.30 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:10 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 04/12] ionic: Make use napi_consume_skb
Date: Thu, 29 Feb 2024 11:39:27 -0800
Message-ID: <20240229193935.14197-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: cab565bd-c249-4ebe-b590-08dc395e3f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L6jAOlQ3akGJ8wVXfSGQBYu1+36SNMncZGnuGlNEGnQ0cY/crLB/W/aoME1NUr4avPvkqxXsby56xV5ow69B2wt3jdXJDJcfc3cQsYjRLyUxLU1Q6zYwbhmPAVUfRnF5q2iUI4sF4kGauZJ/2M9Y/Yw/QHIR/1ONQAj3dgoULlA1Lli1iahQO1Z4wNaDOtTeCPNYDWdG0b0zjcdaNXYa+F0jXuvvuvYgCjuSJnb6u/umIXM8xGIsn7WuPOKSUF5MStHXMV7crUwIxMVdZpgUl8dUYFjGq+0m3K/fg3SycbL2LFSkmIt7Mx50q1FOmeydXEYKAXlEuQ4kAr5wEimOjXv+TfvN8IRd7c58SNTKaXxJaydB4D4aSuy/yCgEIHosfLsxJPThbly5+dnlUeioJLyW9NjNmsmg65ts5V3wNQLlvXEL58wjVVMi6hghXyuP8bKkjRdjq8fIFf1rGzUU58n8iMKuKap5btAPeTqKfhNc5OFfoOGJQFDEqcXLoIzdkQefNXriTOvgu3HCA9WlpXjeNzdLsh1yJzDZeoMOt4t6Os35fX7yb23DdI1c7z0IMaOYrPiVV6Gq/fZU2VA2L7gnSids169cS+MDMGjxlz1QMdJarxelhb2ND4mNQmVfuL8R3ZFPANKrTpedL9fkfkDj0xEO3V8PBBx6aPc9sfbKguulgR3/qmGrH7DjgIrRk/omJ55G2mIoF4m6eZLo+xaE96PknonOwRCordjzBRs8DFmd2ualBV3P4U9kgI35
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:12.9270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab565bd-c249-4ebe-b590-08dc395e3f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

From: Brett Creeley <brett.creeley@amd.com>

Make use of napi_consume_skb so that skb recycling
can happen by way of the napi_skb_cache.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2837f2cc0151..3da4fd322690 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1232,7 +1232,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	desc_info->bytes = skb->len;
 	stats->clean++;
 
-	dev_consume_skb_any(skb);
+	napi_consume_skb(skb, 1);
 }
 
 static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
-- 
2.17.1


