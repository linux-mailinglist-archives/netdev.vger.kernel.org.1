Return-Path: <netdev+bounces-227935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7EBBD984
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAA13AA314
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6204221FC7;
	Mon,  6 Oct 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIkY3+OV"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF62165E2;
	Mon,  6 Oct 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745072; cv=fail; b=K4BO4R1zGZxqNuAUk3GWdHTNiOF/jEDqmghHzYPVVYhFTnAQ3/QAI0eOjfgMoAflp3R8gsxRzuXmiaVpSw6Kw/hu+FxTv/VDp21J/TvrAN5NfUQbIIeX8zwK6LryFwNWh8Yi0WHlR/egpdyBkU2hdIQCl0J635CUrsod33nSqwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745072; c=relaxed/simple;
	bh=1yU6VlC1sfYwUe2EVTlqSjrNohHiD54eO+ScBYfLxdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+BWwJ+3VUAfXW8S36fKFxhZIZWj1wDjVu3YSm8N7Jr8rxaAGk4TF/6xc+4pqpwSCxGLodSASACvsqOW1DJv/ttVgf7pxng+g1/R14uTcE1yGVVLgYcxERqBhyKApwuk6fkJX42l8FLOexpOwLUXMvf8Mub99KRQQH1TKp0KQoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIkY3+OV; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMpn4aGE7tLdugpsnj64sNtIR6Ufsqt8/xk9E+UfPRM7rAV3/ca1pL4E8a+XaUraZON4aBAhbqYje+gyAbcZ1stpqN30wIyUwN4OyI3R3DRH/CMSrQUQHUMfMhhjR8iCAqKuJg7uJgYTGUINCtmDFMc05R1c3e3V0utC3oUSMkkDynx7dMWPJcpfiu0oNMPLIuXaKrPbobAcGu+GqOCBsdNdayWiPzfVARXX6YHYdSgZ4QIQv1kcIQBVZ8vaoi9BXIKLIh1CDMvF9HE6LuSHiH2hiTzFeoYV9lgZSvWUuXunIKf30DbWlBGVIk1PPTGVl3r6Q7kJUnzUtWC3smMwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+m9M+sjTqQNfuzqsd3hQVsMM6Y25ci87Gs/f/TPLfE=;
 b=O6psUqxLIBRYCT6hSbk/J5CscGXJ8s6ZbzmMOvBh2V0kvtlSl10pNPJ4k3gxppoD3U+I8ZILx9PJIDJzmrZ2J7mQpss+RdZcpY6pawJDCbLKI0pbfRwhGqloRDi/1tn5Z6SN+JSqkxXEYhCqCsrMuyqtxVRAnwEhykDX3GdDTSBgOtEg1FcHxAoOpe00klgZTpSKvglAZjvDu66wezWx5UT9ke1j3O2zY4F5bZ424vUhjEL0gwKnD2S32xlQV3bvTZYYIUvYh1XZ1p9qBJSFOWGxEsmdsEHDWvqtvs63+Nswfis33phGKn5lnxMj9PVXZdv35fKYsyNvILjKc2vSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+m9M+sjTqQNfuzqsd3hQVsMM6Y25ci87Gs/f/TPLfE=;
 b=cIkY3+OVl7xXjQPGgsHQunU1yqg+83gO7J4uFvKsFp/eSGeddV8q/ocqqdJMc7LB7vS5rMP1aaiLSWrMBF+fR2ZirdgWQIQhbgSlq3fDqWik2PMtNN91njQQP5gE4YeBgsFgN7cbJy0Irxsgg9UNc/KeHyDRfPjjYZIH4LTUB1c=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:22 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::d) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:29 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:28 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v19 14/22] sfc: get endpoint decoder
Date: Mon, 6 Oct 2025 11:01:22 +0100
Message-ID: <20251006100130.2623388-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 058737d4-eb1a-4afa-69f5-08de04bfb914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ZHW+eLjPzEEj+1Bjx+OSLaUspvRMmqdtR6mjyHA/9NDKDlXxeyQi0Um2b5m?=
 =?us-ascii?Q?qI9fWXGj8Z80y5B9vPogtVCjqWbQjQpPb6YO14OmvUzC8OQEqKkRAPMC7ZwM?=
 =?us-ascii?Q?tyFyPo80wEskfHrspKnmMGqF5Dk5AIo0k4e8Twtexk84Jjr4B3IhOuq/XjSC?=
 =?us-ascii?Q?GkiWV4rqXP6gU0vzq9ygFfBGHwqXTExWg2ik6Tu5nmHtk9/G+DNgY7gdETJW?=
 =?us-ascii?Q?ZYG+u0EUBYCUcMsP08lHRZFjIGTQumqxwooejkzM81+HLvcFFzVBBwW0oZ2U?=
 =?us-ascii?Q?ErZWMYxo9wqo8qo3+r+XlLc8zcyxLnhJFsiU2jVCkyRYXUDh22//mVFCJs6P?=
 =?us-ascii?Q?2b6UZN5P63mqh+2DCzBJX0218ZfUTTfzGebhUMXnMhcvl0cTWEOADW7/sMoR?=
 =?us-ascii?Q?0Hj6hd4iFKr4QJ/A534iWKIA02Uw1RQn/G6LBGyhtoAMW3qmc8X+Tqu6/FGR?=
 =?us-ascii?Q?RMCHv8k1F59VkbOf9HRKC0NSr2AsBIoRmgQH0i8zNrRyMaz1o9kjXYg+EKQj?=
 =?us-ascii?Q?OrEPlgunqz1g0f/dZ50bSA9IaQJt5ELSrUaMo0QPlGTevru4dxgqYwknu76W?=
 =?us-ascii?Q?GiQlW6RiSNY/8QyqLheyaQIhRePiRcYlV3t9cdkWm1RBHgZ00vZoj4FneDe0?=
 =?us-ascii?Q?cWBGOXCUD0MXucidGuheagu6czsI7D5fKXnNq5uZmlaeVwIcNcycnxr1Uykk?=
 =?us-ascii?Q?h5aUgHyCSb3XtyhRFMCvyFfUDr3wHnbtDm3+lk6IR9zWRwpoqoPTtOTb5pXN?=
 =?us-ascii?Q?/8qc43fIc4ci4MAD/TtGY2cNBFtdZPpRg+msC2vU+s8yFvMalGZAG3LvpeyT?=
 =?us-ascii?Q?+32BAwVtuhUxEpjm0mo/XEJv+s+/81bzmndlM9t0431/6r42SVrL87sfotT9?=
 =?us-ascii?Q?gCef5mB/nWczgOWZguzdKrGFZTntOFleAERZJ/jXkkuiXiya4JllDtkmlJcx?=
 =?us-ascii?Q?tAhNPnLILES4jaWoLDfq5nq30j+C4aj9gkJrmGBwFQS+nI+OXcHjCp+5Fd43?=
 =?us-ascii?Q?PdQoUhlcWxW1SsK6XDG4KQ5/gzZK/pUyk2pYAUzDvtwt1GWwxQGv4BSPJzjp?=
 =?us-ascii?Q?VQdVlvIiKFUn+AFcjpZxKtFUKFIBPWS3xY+0NXaPOn2HmPzASqp3RFPpde9o?=
 =?us-ascii?Q?zrt3wwqGWLEjfSLU3QnXXsjgryu5MvM1Wy1Tlo0nQ9rV7tzJcd8uWhK5ipZ/?=
 =?us-ascii?Q?g4s8b9+Ji2jvy8da0pUQgJbgAP0Cqb0wcZlQIOotXrPpQsbq0aDBYdJa8H1d?=
 =?us-ascii?Q?3jKxieCxze7nHHP3LSCIcd8lAbBdjfO8YlWvdHQvhFBU7rIPhI2ueq8n7Z5W?=
 =?us-ascii?Q?v5QKZC6eh/UC70iSGlC+uItDmnTG6Geu97I9zxu2eu8LpbnwYJuZ0h2DsM4L?=
 =?us-ascii?Q?5rrjQ97F9KtJNehayr7GsfacwWtsaHKB+IlML7FnlTPrsUGa4CIo0kLzQfRR?=
 =?us-ascii?Q?S/Q33bzAxV6YUk/CPFd8INjNHhpBN4N8jU4zyJHE7DOMijnxRF0jylvQxO7q?=
 =?us-ascii?Q?/uL6DBhT4JMotLg1833lC/LrTcXG1FZ6O2lq0Wt7nFuIRdbUmYx3Ed3E5i9q?=
 =?us-ascii?Q?RtiwHMu+UjImfyMKUlo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:22.2246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058737d4-eb1a-4afa-69f5-08de04bfb914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d7c34c978434..1a50bb2c0913 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENOSPC;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		cxl_put_root_decoder(cxl->cxlrd);
+		return PTR_ERR(cxl->cxled);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


