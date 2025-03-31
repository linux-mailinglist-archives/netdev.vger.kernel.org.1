Return-Path: <netdev+bounces-178319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7C0A768D1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99167A2353
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12921E08A;
	Mon, 31 Mar 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ijcegWpn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2237.outbound.protection.outlook.com [52.100.165.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90C21E0A8;
	Mon, 31 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.165.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432394; cv=fail; b=hJU3lG7UlazMcgAGHcD48zgi1w6qWrK2Z/weA+wupIzDY7cbAt5KazB7HZE7/byyE07+VfdepLjs7lj50z5wf5YWGMTZeivQn/7Bm6YVSfFnL/LLwsdlDVVkEnOAMokm4cLDnXHOfrfG8aT7V2IpV3VNCEArE7MPteMuJx782qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432394; c=relaxed/simple;
	bh=rvWowOxPD6SYEqHDQs5Hj9Jen1ADCEwqW4JcIF3O1ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6uKpC9QDu8Pr2UcKclT6ulQXX6cKskoVYRyaoyyqhayE2v3/ehqS62cSd7+6tHPnNDUL04L0uEqSUR/iGdckqSJYDKtbfy9eNyK88YrNQ+xscCHFWe3FpgEJF0BkFZJ45B8WtM6E259CF5BWr20PGbYJxQRKjknHYeY7AvQBGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ijcegWpn; arc=fail smtp.client-ip=52.100.165.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdeuhXCZiRIax24INn1ooHlnDtnxgNUhesjjA7SYnXVdLYJgPvEu/gxcnQgSmF6vNqtjQLkjBk+3ME5kGy9lpe3v4LdWzOCzzTEtj4+dtWJ1K0jdNDIIYy0r/hhwl/ck4GB1x+TdneVDDHUT1cuhUxPP10nIZeeESgwgOC3bWoYHsdwZN76hkq0wIqlDBgY0ib0+uEaEyu3pKS3Q+QY7VWPHAiZ+e3Tmq4uJ1LiLMMBah9MpWDlknf8uogrFRTjcT/zMOio2Z8lAJIHNBlaVIybTv0UZBYt6/78U9yDzbSWOIzpeuoPS+JdR1JuAZgAeXfLcqnNh5W4AXjjDBeKmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCjLiCC6i0gfeNN4CmRwfaugYp6kDGRHAf9KTMBsUvs=;
 b=wUZGVR1FKv2z48F9tftkBYhbJlOF6h82KlFdysxibde4oL+sLUAw/QYHFBq38/PWE3Ij2QMAPrdN0uat41YZVVVPvq8e/WOyOgnhZxn+C8FdqVqoFDi4Q2giXKUuAQA1JEG2lEshO79h86nN+3PRDC9URFgGcEvgdJDn88oRoBzhchzUBFTNnV7L1OWsj3/2Q/XwUue9WLdhkIbP3RfZXPz0DwaDSfuBqL6Vnblkmk6xgiWwZZu1lDQoV4+j3baKf/cFbgVEwjgBNaDxmHCaSMN//nX0N0VDOyevGNEoU3fEE30iUo8Xgkcp753DsLD84xuZviLcNpIiez2zqIJXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCjLiCC6i0gfeNN4CmRwfaugYp6kDGRHAf9KTMBsUvs=;
 b=ijcegWpnGJ1wa/UaVgwlHM+sPIpGQAf+cFcodpLsQ+b0CDMk+Z0NbrnBXp6O+Qha1xjHw5rWrm3ZpWWoOcIO8ImAgNbWTj5CNBeajWzOjIntZITVKVUg/7fNSmyfhZ5qoVX4Grc+eeiXaeKA+kLGzpwVWFQ8pM9YExQYLPBEn8U=
Received: from CH2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:610::39) by
 MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:29 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::75) by CH2PR05CA0026.outlook.office365.com
 (2603:10b6:610::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.20 via Frontend Transport; Mon,
 31 Mar 2025 14:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:28 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 12/23] sfc: obtain root decoder with enough HPA free space
Date: Mon, 31 Mar 2025 15:45:44 +0100
Message-ID: <20250331144555.1947819-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f17cbc9-d7fe-4bec-012b-08dd7062d1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|376014|36860700013|82310400026|7416014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZ6+TGUs4q6xrBWJgmi7nADahHGxbyoNyX4Aq5I/WFYtdB85gV2UC9iorFPw?=
 =?us-ascii?Q?NABfTM3sULOzgU3Bhwpp0ORBM7OJom18fK65ATmPlvtRAa8rTAr3+rb/nsov?=
 =?us-ascii?Q?vdjKlhlRjU2GjSVlS0MU6wc795HgZgzuTp/3cv8tTkfrF9CAxmj0Hoy9nzfy?=
 =?us-ascii?Q?WwjuNiqm+jRtvbLg3Qdin6Wt9igN/IFtFCMrZyFt+fXQqqGjtJBtJlv4quc0?=
 =?us-ascii?Q?2NVJg5VpXkkHCOWQC5BfFCpj+NsRoWG2442bA9fNahFuhacC6TnKFGYIuL8r?=
 =?us-ascii?Q?MG1kGwEccZVlD8mbQ9zlrREpSnIvntyksQp+f42Lz4aKzvJACk5I7nYPPQ98?=
 =?us-ascii?Q?qFKXpaT2jcG/HMn2OHdJqz8EaCKuC8tfdcty9/cxqPQz0P+ybaM5l4c6M++L?=
 =?us-ascii?Q?ziR9REXLeP389HHCT1VFUC0mfZtPPfYYgmg6drWL7Z850d2DvbVOjqBzU1AN?=
 =?us-ascii?Q?ixEF1SUIq0THvutmLM8Hdub/4eAEPAZwfAFs9ncUKtsvm+uUZIQYyR9LzK84?=
 =?us-ascii?Q?WagH9dlqkPlhU+uOWGRtbQ5oQurWGeM80D8326oV2CqRrLiEz5DhH5UY7EIF?=
 =?us-ascii?Q?YuYWLyglHMlwM2OKwQdP+vYmZzfsUnkV4E6JoRpYqFYTCw5YuTrU8zF4/p9n?=
 =?us-ascii?Q?0agSu1608QD6g+3qvZBlBtneXalv4zjVPWEvltUwogvI6S3rUEKQ4j9x7CnX?=
 =?us-ascii?Q?YjxxUiHYqHg/xVCd6c6RGBNyaxyLBuoCsWFRXOydRYUUTaL9Y2UP7IDn7TDt?=
 =?us-ascii?Q?QozFHM7mLe1fNZ10sUzfuG4eJdJi5VPzur5r9r384frJWVRJ6NvmJg1JMQuq?=
 =?us-ascii?Q?pDQKZB08gw8R4mMUzK5nqWHqSWNwwt1lrc7hSw6eP+BAjuYBtPL2e3VwjKjY?=
 =?us-ascii?Q?SJdsDZ1UorSoG7DgP8tb91iaFCRnY3p3ZNW5rwTKgHqGPbPd6HSaOB4BF17t?=
 =?us-ascii?Q?n/+ygVEtGaxjuML9A9gNNpQdjdsnTeliysVzcVdgEJtbCraOUgz1LPc7HxPB?=
 =?us-ascii?Q?Shu3V9GSMQqqoATuJzE7yGdyNezSnWXj//IKv2XcBuc9BD098fqdm0fs2+7L?=
 =?us-ascii?Q?NdlIq7ukhqADjzLajPytiQfTICbxgJGVCZr8PXzv0wP34RXiJv5ncdJU25d6?=
 =?us-ascii?Q?FgPYkXVsuKGJrKTQhAWnbvX5RJEaNkV76tzYdbo/c3DNKn4CMztcDw1EBH5g?=
 =?us-ascii?Q?isPJoLeu2rkbqlVqI+I7pcIGWb4THuKFERG2GRJhg6UMxg0HUbrRRv8sHlp0?=
 =?us-ascii?Q?BWlmVBUQv+E1dfGgNJCex0GxtnD2pSBrPQ5bbiYmhI64T2qwbfAmKF7vdyzS?=
 =?us-ascii?Q?lVIJ5BodIoB4s0WiycV/x80gHGmpwR+hosOCsDnx0ETfEccsUi8wnzyCDjK7?=
 =?us-ascii?Q?ogokllcskwuh6Deq2Sm8KY/2WoBavr6Ij16KS7LsD7I7N2g5vbRYy2IlLCK3?=
 =?us-ascii?Q?hfxzUmw9q1qVPAJdKDvGhhaeBZ//yZcdf3KTvyhJGs+9Y1n/HiicpcskZ3WO?=
 =?us-ascii?Q?fNlnrMxNt9QsZ4kPl7HtayVpehzfOboXBYMG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(376014)(36860700013)(82310400026)(7416014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:28.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f17cbc9-d7fe-4bec-012b-08dd7062d1fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Make sfc cxl build dependent on CXL region.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c5fb71e601e7..7a23d6d6d85f 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -68,6 +68,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 5a08a2306784..4395435af576 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -24,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -89,6 +90,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return rc;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		return rc;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		cxl_put_root_decoder(cxl->cxlrd);
+		return rc;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -96,6 +115,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


