Return-Path: <netdev+bounces-183924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95AA92CA8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881F919E82D3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C8209F54;
	Thu, 17 Apr 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NrLO/Zz1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE720FAA4;
	Thu, 17 Apr 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925397; cv=fail; b=dk9WHWMd9FUZeDVXhclnqvg9QekWY/sh3fT/b+GAYUTEkoeqanQpQORK67lNBYB4HgLXMtbfn2pSfDZ2U0Evq+laBFFzqaTPVQ8KiC/zcikhuZWyZTeN8td7Hz+Ezg5KOipZ1M+YdqlhRuwMv3FCTEfyTnfXGSqshye91MlCLbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925397; c=relaxed/simple;
	bh=dDZWoEKfo8atxw31+Z/CqXZDjSXbTnzQF3yZBRPa4uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Clg1vVdhgutmkaL68Q+dJ4zXpKCrsT32nfry49HmtI1oATbvA8UZ8ks4yZBwo//7RnquzvlN7xqCPiSTjjL/WWnr5IVF2wTQFAtyyf8uSSsDLk7XxPrD8eWgkitFfyKH48TlBuNuYwueLVXlo2F5KOA9CBSmQMOXMldvVKgi6As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NrLO/Zz1; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIIklWRi2EbOZQvZlthY22sTyzCIoVmmqe3O1JzfQqbDaNSnTeSK2+UGwI57xUmM2umO6c1DpfJ7H4xTdK8RH1OjDneU2LWlWn5qKp89Dl0jFdi/4PEu0yiwS8WHz6OcFpPAo3cfGF9IqU4ow7WPiRLbk68tIt9lgAAiMoejrQR7Vdwf/7Rz+0cgDZVMtIxTr/hAkOolw1SJbl4erY4m94SfPClROCkRmajdhj98qsZzRxh6eteqUMa6+w0WHwkO5suZFXJ69v1vnknnl4mWPNJHjw42GlcZ4KXN7NuZEQNBRawjBCSMtKj+hh7Nz5VREOd0jDBE0rJEqWd/62yrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tRD1acARPPvv/XFRre46ALnvzaR7/EDOJznD0ZSn10=;
 b=GBTmxflcwV9Noo9QPlXZJ1VOnDUJRYmJwYO8c7ImhKnxgqi9m0NSZP2NZC7X7WicuACJDwwYsRnMaWhEjuLGRl+UxpYShP5KZ4qcyHg28pHx7dsVvpr1rnAybF7GWZcywPFvxaPthFCybATGpFX/d/ZawsmwULSS8yfESzXZd6s6cf6S1zIzC61xi79WUvg5qIPS97oI7TW+zGkMHKQUK6Pbl9+zd5H3XLvKa9i82PaSpBqBBmV1wb0JD4R08Wi1tOVGzqRP25ZyOPJc6HI69oMLkO7cgUewpLhHbZkN7N/PVkSyj2PkdnFs5rqdL5RGWbp0eTz4ja1WKOVhpO7XLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tRD1acARPPvv/XFRre46ALnvzaR7/EDOJznD0ZSn10=;
 b=NrLO/Zz1t1MrwYwBDBNXQpL77LfvXHcoMEo5GyTae6G3tI6Hz13g15uUubOWrDv8qAgVeOFKjfUOuKUXAcwZfrFZafTjHZ8AV7YcQo+Rng0APuELXedsGDekS+SGJRUJWGe8RdaEmthcBYAcd3AvMu8ouZff1oUWB0L3rdijq58=
Received: from PH7P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::29)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:29:51 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::f8) by PH7P223CA0028.outlook.office365.com
 (2603:10b6:510:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:50 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 10/22] sfc: create type2 cxl memdev
Date: Thu, 17 Apr 2025 22:29:13 +0100
Message-ID: <20250417212926.1343268-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: a50a8404-e430-40df-0773-08dd7df6fc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLDlQQsngKtEVIufImbXjfFBvrZfFN8P1oLl1orUlrhNmru2hOMsoxeFCmGY?=
 =?us-ascii?Q?vjWVnO90zrKcHzvNXaKc7JWK6nFE5zhMC1dX9SQHB+E3LRDfYLe1VrCmaRRs?=
 =?us-ascii?Q?tEUcDvCm8Yy9e59PG9Npz1A0AFRsOPnf10dcl8FxJz7kVBDH0MZp1GRGOYZs?=
 =?us-ascii?Q?BO//g0tQhzRb4aT2KvJ/SB+swE7Y8fLcBdctp1i4ZmYhAEQ7zdGIriT64Yjg?=
 =?us-ascii?Q?ABB9jtGpDjG7ow2zLp8h3lSfzqGvOinFEkrPQkEOx2qcOtOE6P7CBvetxAbG?=
 =?us-ascii?Q?kRdeMkSf1/yxgmdxLJT0zjof0W5h99V1+Xz/aVhm9liH2LM1oPXuViWRpsYj?=
 =?us-ascii?Q?Yr8dyMUtpEGKiKhuzOKH7ySN7mkxIQ1BJLtm3cl+qOiv+COuUJzcfYb+VGCT?=
 =?us-ascii?Q?LhiFtef+MI07WFZCbu0sLqrNLT/Er7DGN1FwQe5NbnvNI5ovh7hw9GNlbOeR?=
 =?us-ascii?Q?w6dOxHIw381hUz5bXTtrKTP2iRj7c3s2xEXQO4QaQuFmRPyXTsRIJoLTL6Tw?=
 =?us-ascii?Q?BN/+EmScURltiZzD4559LvTRsl1ebDailUm8pjFBZcnnCGE7BuUFFxq1cf2D?=
 =?us-ascii?Q?Ajr2cmTB0v8uyKH23DU3DMq1b4Y15agXsfglirp6FkK+yWtXbDbRgSySQGBr?=
 =?us-ascii?Q?8eF9XHCfhMh2IsJ+UkE/61SRvr/mZTK8D3VTEQPrP3+hZgxJaHHO7pJlEM/3?=
 =?us-ascii?Q?OI+NaA29+aI7Ss3T2SmESjGQhYGGRnE66YjKBdoT9wR3IWCoS3Tb0rehU8nZ?=
 =?us-ascii?Q?1jC4A4QXnjHlIP28XU+ky1PJZgDn8vLUr0dk26D4y9dbG997ta6ln7Fk9FFv?=
 =?us-ascii?Q?jTTyJ8FOMO6M/zjKVZAw8jcIuqJcfdjwJprY1glPdwWpSCLHAI+ppYN41P7f?=
 =?us-ascii?Q?pmVTggPweAWIxdkgrNjyBR9Ig5T9nFwwfUPtZ9pvM3KuajNVCRSErnc1yPd3?=
 =?us-ascii?Q?oHAy4GbiX2zg3DG8QxBH8GZ3Lj8YHJ9v7lBFymEy1kz5o9jnqrFSEZ4pmEis?=
 =?us-ascii?Q?YET2lUzn5P8a6cmnGxwX03AgeGj/smkNQAwiKVmEILYYV2TuspreNGH8jYlV?=
 =?us-ascii?Q?dkHVjalsf6GNhsAnx04HhPUaJHcOyCIGoF1AEZC+w2H9BNah6rRn/cyYovjO?=
 =?us-ascii?Q?s3AlhJjmLkvpHw6qdbloUMGBBkCuroBjomjD9D6kw1bZMahRJZIvM5xen79N?=
 =?us-ascii?Q?SYkMniVxQ4SkfF1kVYfvFHs9cuW1MAX0zhuAAbgt0Uh0i6aNNl0WUydRJ7r8?=
 =?us-ascii?Q?DElbu1k0Bhx7VlQZ/7DMifoJz/y7UObIoitWNjdkHTZoqtvKjFCmRUNJbuiu?=
 =?us-ascii?Q?9btT51IFiZSCiyZNsqzvPo/6Z/xJrobuAPWCdBybqv8GjJ2Nwl1pPEGQC/ip?=
 =?us-ascii?Q?sNZE6YfURUwffUI3YewJoyNwz93pBU/P/mc6rBJ+NMn2KNt5itK6XlWeWp/5?=
 =?us-ascii?Q?phrOjqUmF7EhdN881Ueuz/UYVhKSKOIfZKKR6rpC/Dh28oxHnOVmaAesjjpL?=
 =?us-ascii?Q?o0IUXx/W+6qTjjqafkGanQCUjXmgXy8E7owF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:50.7967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a50a8404-e430-40df-0773-08dd7df6fc95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index e8bfaf7641e4..04a65dd130a4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -78,6 +78,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (rc)
 		return rc;
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
+
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


