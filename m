Return-Path: <netdev+bounces-190423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E73AB6CA3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C0B4A7FFE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED69027A450;
	Wed, 14 May 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v73AViCG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B627C149;
	Wed, 14 May 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229292; cv=fail; b=NsUAANXRVaib/btv2tnZaxcsfKfoQLrI1waOPJpxadjYIjXmJZlNL60Ys4QIz/uQnbOtgNAYtXDNLW+RfCJeyRi/9ix4R9Oq8Cu4M27XXaZKnKpK8bp5qoog8QELSkBgTTGkHCObadrdAuYYiHV+zpZxrT9cFcEbVJsqPlvCEI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229292; c=relaxed/simple;
	bh=gax2IKyj4w9r/sNwkextxq/KkvDDAnzPsTJ9IkG5ahQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuwZ5kOyMvuD0aM+xC5yGWA47eZTfLMNG0BWzWglmAKEMVo5BoVrgYKX4cUtCYXwnQ5iVdcHLBR54JFau/otzrwYhrb3z8p2jXLOJdxBZcEEehC6OhprnTftxAtJEIJaFP4Vu2OpCWuezqvHDpvFGG12Lkk1qyfyI0qKBhOGgts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v73AViCG; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZoHC91Fg+MSqQfVUtc2D6RoaUY3G+IGUcrqr3P48na1oTyE87zXkKVfiR10UDEAk8rWnXRtYC5rmlj3D/ZDkYqkEmakfW3kv8zkt+O4jP1LtbCvvPlTFgTsmvOVV/nXhikV8JPG6dCJK4qF/k2DN7gmfzxAsHIshvec4pRQEdjNMAoiemeAxjbO87mgGpe7uEvjoZfXmB0kPeAXX++vqxEci9LZCXfyaiOnykmOfx9FV3yCcVa1TqzkuzbVEAhKnz7uZzE2m8vhX/RXZ59toj039plmaxrY9Ht40Y9TjGJagaKkgXTa1h56mwip/A/nUXTYu4ssL62+FS/KvXVqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVVMSmu6u+cEgKxG24KKjYVxcn0GEbiTwBuom+OXkg0=;
 b=XV8j9QSZ5Ms7YKp81ShoBB/jvIbLUNWFAxUQQKen2HhIGcEdsUaaE6adFQQXheTHPm0zWZUuKlhcYlwHnOykmtOxtDviM9dVwemnfIevOqtXWEIZN2tHlVeD53CvIVNgVoUCjIj0oEyGS4wNycaRh2TWvNrOZIc10qbZjardT6Oq6hqlPtMFe1cDDc/Mp7Vuskyl48igUz+A5RSeaQDFUq19dRlil5eiMUA5lj2K0gk6lKSALSxxom2BCe0qsWAsCLEWIzRMubtwrWgQA2zkg6It6d4Dj7G6inCBokBqQbFtUMYJldGKMR36hOtXqeU+nxLEVxIMUaGI1icwJcAoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVVMSmu6u+cEgKxG24KKjYVxcn0GEbiTwBuom+OXkg0=;
 b=v73AViCGSczcCmEE+a9JW+xSgUIqsj2ZEdgDzPlWxwZELNlUokgQVSs9WojPZNgp9VS/zLnFvcvPZGQ4xW3iRz7nHdHXEHt5hbcDV8j6tPMP5JRO1qlUGUeh/OxHKbFEDG3RjBdy1Jp+jnYCpeRKQaKxr3fvt9IbAiFN5XwFLS0=
Received: from MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:09 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::bb) by MN2PR08CA0020.outlook.office365.com
 (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 13:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:08 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:07 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 10/22] sfc: create type2 cxl memdev
Date: Wed, 14 May 2025 14:27:31 +0100
Message-ID: <20250514132743.523469-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fe5b01-9c6d-40a6-1ae7-08dd92eb2b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VS3bwn7AGjVE3n9gINeCKtmO2bRFAvNhOb2hFy1Aka0HnBW5VxBBu1lVvrIr?=
 =?us-ascii?Q?iaJE4K+OBcumMN257N4PGoKl3sm6WBSJGkh2/3KPX1mehIT90Ug9/+naVE2B?=
 =?us-ascii?Q?1UjcAZcXledIJKNnTnlN5ALLhtfJ8I0TJfbT7Lgsrx7HgEvwzTuura3BnE3z?=
 =?us-ascii?Q?Mcq9faKzbS999918Wch4zdRx7J1vzipWfKQCLyiRmpCKTUv1xWVUuav9w3P/?=
 =?us-ascii?Q?EuSpSP9+pZckFOijResFVU2AibKzAlDNWrkqX/N82snB/+i/3GCktzMtt5rr?=
 =?us-ascii?Q?BJpKTXpO1i/fNOcRJ5xNRHfesljBADbEH40zJ5OueHHZHaF74PXvXpiUsnDO?=
 =?us-ascii?Q?eSMDbDkz+ZaZwNEwNXtnqi+7mxq2TdgJuuneEQMbRaWhIo+3C7xRH2U2mI4N?=
 =?us-ascii?Q?pfVp9T+pZmI3b6+fzemGOeNXjYPOIynAOHVdb7ReDIFEbZeG0N8YBk3t5EdL?=
 =?us-ascii?Q?D/siwb6s3HYgDKe/jgqno4D8DJAJZ5CtyNZXDsQnwAjIAGGuFW7fyg7ZpHw+?=
 =?us-ascii?Q?qK9FK6lGYBG0oHtZwUkbuYvQSGzH821DqohpI+LbZMRwBhaNHggUZJmmmIbY?=
 =?us-ascii?Q?bShMEtImUuE8dWp/FUP4ZTEtjBVsTypp/Hmouch7yNCaEaIioalkvGoWjXyF?=
 =?us-ascii?Q?fmKgC+J3q1MuZgBgIkbgR9Jrr3iEpySZGWba0NhVW1QPuXMxLT7ZkjlplSar?=
 =?us-ascii?Q?D1VXmTjpGE/yf7Nrtr9MKK6fztxCRBkIia2gF2yiz3JKCusytlesIb/lG0Gv?=
 =?us-ascii?Q?GoP1rt1Cfuzs0LZjk4ZDujZrrJU8EOdRopPuYSdSx5Cbi/z+zJJXVQUke0pt?=
 =?us-ascii?Q?qZsWldSXHPixCT77stLVc1/WTJRgQbT+K9BBEJued3BoZ4w+gs6+2eKP1MyO?=
 =?us-ascii?Q?xAZ78UNXvpwltM4bawhm/xklIyb780DkXyP4cIs0XMDyqp5vKtkUpbilTFFn?=
 =?us-ascii?Q?f8lFNJYl7A4Wr7a1uctH11JUzQaLRcnwGSIJt10qlkU5gVYEpfIkkx23I+ed?=
 =?us-ascii?Q?M2IQzmlTGnaPNoYwvXoEkHNzn1Y67pUMeGznGZo1wHyPRgXN3+aBy6LEqNYC?=
 =?us-ascii?Q?bjWhADmUWqgTSu2YSF9X28G/jlYT+7XrprKK0PgbU6Y0tCxSzzzPxpkpKp8W?=
 =?us-ascii?Q?dFohp+FyaWzW1MbZzWybYoYCIicJd1BwdJR6QxvsAA6tmSwrJjLFPTW6T0Z5?=
 =?us-ascii?Q?lIFE7IQcWn1fbzLI+dpftk6UksgT1kAana62Vqro4PB900bHeHnXOlNZsfSi?=
 =?us-ascii?Q?1vroL2IIfsl4Zv6awNYvuNQAcmYKUSNc33YWIhqQXfZYmybh9zY7I9A2qf+i?=
 =?us-ascii?Q?shVl218tKsGQczI7Gfz/uWJbsSvAg/bdOEx+jUodvt4ANnFeGWrg1mjwc9zL?=
 =?us-ascii?Q?Ye78yytYj+xFUMkiYQ1dBD5a+f6F8NQ1xYGJcrb7OS/G9p5dCm5K6fzLtt7+?=
 =?us-ascii?Q?EkLcy5WRdExeL8/i3Den0GHGg0HP6mEFESzqlXx93aHrcMtaGUsV4xwRtXpY?=
 =?us-ascii?Q?cpF8nhrm+sqCtOI/aeZv+7lDTwA4ExW5YmYg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:09.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe5b01-9c6d-40a6-1ae7-08dd92eb2b0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

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
index aac25d936c4b..53ff97ad07f5 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -77,6 +77,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


