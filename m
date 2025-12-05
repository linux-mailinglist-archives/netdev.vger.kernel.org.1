Return-Path: <netdev+bounces-243787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E7CA7EF4
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF50317F7BC
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A032F763;
	Fri,  5 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYPAvBTE"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9962192EE;
	Fri,  5 Dec 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935600; cv=fail; b=prKFrilEWipLbLgiJlo0F6/X1ZXrBf1fBXyjoTL1YQcc6Ip8pv0/qjo0mi3fKcrMJ+Q4+F+OUz+NjqOUFw8/ghUjI9UvFuGBoRdg9k5NHqu4Sz5jZyla++gjpaXtEev2BG1NC6e1aYBVZSG/oGuDNfCpSUZToiS/YtycZMDZ5DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935600; c=relaxed/simple;
	bh=sDB2g2KJG9u/u4Rl2fX1Ry4Q8D/2IzuNg4m0r76Tdds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzEY90V0COwgCVwJiAd1m5nnwhYJiK0a7A3XCI/mIhzLjALWKSZNZH1YDePSxCcml+HgtIQ9FnhBkurObTS/QfhMT2mKbXzSyM1vdzVtY+y+FMu0dmGd/qFVaPvWIygNHjlRKJAbzmwcVOjDiJNAdFpKjcmAb5qvpv7NJhBnsOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYPAvBTE; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPTnvRt4D+U6Yn1N7miH70SqZJyr5/Woi7Yq44Y0edqSscwuWI8law7JtT9yxDQNfIEAsrA6Og0tTXd6nq8qvOz0a4XbknKz+0TmvxLVQP2S7ACwLDvsB5NqVkTQc+eVjf9Gkya4ZBCTbjLtP6lj/IiB0HyQPjBpuuGUDOycDDQDEl+r8tKerhyZSVeqeDaz0hC00UFVrM/8iRR54iDFPQp4JRwFgwb/CzlSzdX1l3IiO+Lx6KsVO6auMIF06Gf4WIel7wBA0KUW6bVE08s/SZrsia6d185d1kqPzTzWpK+VkUrMlaG9WVZPNNn1imvRlUW/lzmPPPRgLJiX/exV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=mVSTD7YlnqBPWjxnVK48mt2GEO4SDocnMKczrsgZ6kRO86gR+RH8/EBbc6XvZw7FMbfljU5prTLA7uQIlyX6vOZvopO7fWmYzA5pOT8r+Gl73aJJv9KivfKyMf8n7g4ce34R/cAq8V2qd41bFTatRcItMeLNKaxsysWkUSCOuxMfr9490UefxuTzSARp5m/3EDlsNkwX1qa4TERxp8Yxit7Decwpn8hOdhdfwSaBELVRsM1zLYEFYvIrVf1F9o4r4MvwznJTT9jXx5V2//8vEYwEF4TH0yslvumDPEWHVfOQQg6ZFheFXujCa3KL216ipf6A2hKv0iXn8IGYDJQmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJU/9O9uHRjDQqO/C/TT8oEsmiy9fdx965ZnFRQhIRY=;
 b=QYPAvBTEVE7ch30KUgDU0jTPa/QYlC4vWsAy1uRFNIQo6nl0aEqyqXUu8vW1Wf6gO8cgqaz2s+/7o5YYFi8cFKDg8ukq7kRT3lhiAQcfa8WdH1X1Rjama7q2bnXQKHEBgIaT4YdKIXaYIWOKR0D5F5x3JuWJGizcUYraMn6Azgk=
Received: from SJ0PR05CA0123.namprd05.prod.outlook.com (2603:10b6:a03:33d::8)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:13 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::31) by SJ0PR05CA0123.outlook.office365.com
 (2603:10b6:a03:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 11:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:12 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:11 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 10/25] sfc: create type2 cxl memdev
Date: Fri, 5 Dec 2025 11:52:33 +0000
Message-ID: <20251205115248.772945-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8129a695-8f96-4b40-05f4-08de33f4dec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+r6+V9TaYS3OkwGPDVvqxP8ZeJLfd5Oab7fren/auYYfGho96vTwGag3B2k?=
 =?us-ascii?Q?knblOMxRLMnuTN4qi3Xih4pT4sUzs4bbh55Ug9tM5rOAWHsnw4TxoBH9kOq/?=
 =?us-ascii?Q?GSLzYJn0s7r3uWciQaBB2/mPv/TcqORBEckPsqitJic+UqN2eG/pY74ISDpu?=
 =?us-ascii?Q?mOP19Yg3O0MRPE/9xewIijQ2kvkRfAg3FG8dC63ZzKR4dc/ttZN3l1blzC9a?=
 =?us-ascii?Q?r3e9ATsgGUo7IOGti/+RO3bw0kEEFECkqfQ6wbbF4tFbvABncmDLiQElAqDK?=
 =?us-ascii?Q?b1L/21fqBQ5kz0CcoJ73oVRsN1vQ38PvaESYQ4VrnHlnve196e5TilE4gIxx?=
 =?us-ascii?Q?nwhC138Yz9z8zZGsMXI7srFQm4pVG8H6KqyVb2rayF9TzuinKqrUz9gx4jBx?=
 =?us-ascii?Q?FjlQXhtfzTBiiniN6mbafq0fEjxrux5DHpHpK+DnBq59hiNGFrY3M2bINouT?=
 =?us-ascii?Q?B4E5rnTfdisuh2x2mYej2rtPXgvdjmn6WxjyhqCeiNCFBdokxLNaeIMnznWe?=
 =?us-ascii?Q?EEeOnbhz3e/Uqv6c/dV2/q7CLMnRxDpGTFT3/gtGxfUZGGhIfUM5Edr9jWjJ?=
 =?us-ascii?Q?cdXdS/ZLcPs94aSvb+KrKgDtYL3lh7f5SyRnobNO58/inZFJ4ZGtS9T+4OaL?=
 =?us-ascii?Q?4JVmTXRxxNvOAMPHF4nGONXwHukGPb+SPVpLyGDmcMjP831i2rMo4Z6wsTAH?=
 =?us-ascii?Q?EYdAtCTFqy7Nf4++RMfCG9ax72fXQZJICFxDssOTUix/nY5H/Z5ML2AkT9eA?=
 =?us-ascii?Q?W19NNUhqTqLqSV0FgyMC7CfMiPuR68GF3c3/TDl8HaWD1hv1mC36n7GczGi9?=
 =?us-ascii?Q?Nl7uP8Ieqvn5TudGAjGPv1ddxde92LTGV8l7hD59hMbGufVAgolOjetO71u0?=
 =?us-ascii?Q?RNWBtYFxYzZiwKw+ckzGUm47o32ew1qlt12Fa56MuP4tspLzHpZEh1ybkE66?=
 =?us-ascii?Q?4b2+W/vp4m/40cYdpeRmbE59iUKC6X/gmIwD2bNO6lBm0xcsl1gA7jrELFnp?=
 =?us-ascii?Q?u19ZLRsCA15m6melYRAnfPp7Tu8l8fkYbcFEoJRw3Xymt++gKYUO0EE5JXKm?=
 =?us-ascii?Q?R836OHDGBHxBeNsi77IpAUkcQ90bc2PDxuejWlv/UFUG5HPZ9JY1g35bRg07?=
 =?us-ascii?Q?Lf7YPI5tbqLxGLkPkVGBs56Al5hjW6hfg+8dTvI9EimkZ4hNSzZg/V7Ly75h?=
 =?us-ascii?Q?SANQeWclEFzFt+EAFNLUauSiCaKTR4pKQ/mNap0j6fZi8j40Zk0jH4UWhsK1?=
 =?us-ascii?Q?ffu96NlNEPlsELg2n9z4lTGcHOwswJrQGwOgRheGtbp0yLnlgWuNGU/eYKJq?=
 =?us-ascii?Q?hiegFTR4b6c0xP+OjXIzu9Ar/dpocmh7IUIbEFmW3G2MqijLUQBnsFg2ZFpJ?=
 =?us-ascii?Q?EzX2a3zccUsTp+vvS98LdN6r2iAiK2Kz0j+OHjiFRVCQzcoGAoCx1cjg0cRX?=
 =?us-ascii?Q?08pkfc+AkZD1Snr0G35MWYPctJVWaBh8uSE2yms1hUlvtO2ejtyI3KzTMKNK?=
 =?us-ascii?Q?nnH+svexqNH/3fe4gq2HSvkCWia7+A38olb/Wq12o2iDaCZ1RDEMuTH++5MJ?=
 =?us-ascii?Q?EvxNQ4kXIoUK97nMvcY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:13.4601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8129a695-8f96-4b40-05f4-08de33f4dec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 0b10a2e6aceb..f6eda93e67e2 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


