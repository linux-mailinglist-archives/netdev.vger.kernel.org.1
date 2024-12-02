Return-Path: <netdev+bounces-148176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D69E0A94
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7216FB674F0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA121DE8BE;
	Mon,  2 Dec 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="py0fB3f/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFEF1DE4EB;
	Mon,  2 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159591; cv=fail; b=pVQ6FzEtDto4QtyYGrz7FMnRywv8/tbq4iUsTvFZe99QCYk4YyhHs6zu2YQG9qum+VTSfNL8oJIoEOIMAiXRqWZrpIVfgcaTgWHipHOON+qj/ZLfMllvlJv5uB0Tg5vmOcQRQ9YbOZauKMnI0Fz10CqGqkEYJ09M66mGRmQTtfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159591; c=relaxed/simple;
	bh=F8rZKRT6yt/m3jsDk9g5WPXx19cQZCkeQNb8nQiqWvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWmYKOED28l/7Wo/LHHsA3iQeZaBTFyfL5zHGaxL7zq20XmZu3x8tPmK3qMqXBUFb6cfkwPRnHWokIxELIUewN0jytmLmlsj/8g0FZIJCDqRDbeN+nghUbRb0tptz4rG8gqJnnGABvNPLBpems3rMcF2zJBDMAE1FdVFOrCTXzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=py0fB3f/; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+7H1f5aPB84Ih3o+BMTI8JPSPNdcyxwRV3Lwr80dJksRpmPH0EHjEIDiVDwkR/5dllEtlqXEuQt1fxrT0is2SGyqR2oXdaKtSbrqcBFBp4gph1Uyc68SVgkkmnf3Y/xRAHwmCtPM1rL9t65h0NHRmg2xZ2kT7oapMK4Ndlj0GL7KnmcO5cqcWLDwqpyY024o0SrAKmqvAqVaIGQk5Xbq6duGtbONab4JrHO9SheCrzoc2Ey/vZJ4thW+j6rLNfB/57nFSZzZmoQdUZe5vZKCjPQdPrKd+hfZqo/6GmgAO+bfmyY3ToEJSa4ME9fWhvqiwebbWTFrxkBnahu8Vf7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQgPe3iBSBaaZ+IYlc3RlYRFt431ORCtuZdC3Tvx9HM=;
 b=PWykmKVpXYaFrEHBJaxzvDDz3t3TW4X25uXJWqUV5p9g9CQSSwwO0RGeRX7oyt2dkMT6gyLaA6e/8vOSvHcpkUjp1dzCkwaOSmGSfy+YDgIo3Nh5U63tyVUoTgALC64w4KwGbpJ3mTYD3o+hIrRRultNMg3eyHRHsU4Eh9BwFZWxhbI3zmrDArN+WD6ouHRWZkVDonGQODKCZNSaWeSh7QXyWgVUNYDkb8FTbhdGrjKEPSknHWvN8zSxrsSrLbX7OqXSVXJZdEXcIzXPkBRjXZoxwFPe0GNlu3yRdAbEU9eekPq53FpIsM8O095utnr0MLsHb1iHP8Qt+r7N3t73GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQgPe3iBSBaaZ+IYlc3RlYRFt431ORCtuZdC3Tvx9HM=;
 b=py0fB3f/ezBh/sYYaHHeElEdN1qyr0zs4/0kZpJp8hP90aZjarwWeppT3xSL2MmKmS5YE8ZwMWHerN9t2ske6BaXRM4+WY4OiwYXquSaMxEjPYnUAMEPA25eKx/DOhiFX5zGTX8wzLKykODLF9ZNIVJ7ZdGsrmbaUTPDNmo2H3k=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:01 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::d0) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:53 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:52 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 14/28] sfc: create type2 cxl memdev
Date: Mon, 2 Dec 2024 17:12:08 +0000
Message-ID: <20241202171222.62595-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5109cc8e-a271-4de6-0817-08dd12f4932e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0msbfOT3YTCE2fjdm/qx5Vm30ywBFV5KsBmaynr2m4sfhQZNHri3xUpn1ZCX?=
 =?us-ascii?Q?HkH2KRvNCQXnME030gNmGcVHpbRecr4JbwbFnBT/NI3pqUykUnJ1PRrNp3/8?=
 =?us-ascii?Q?UymQPtdjzAoUzLM29k4QSV/PjPnu3fb0CEikVmPqlyxk/McsFupZmGMThX2N?=
 =?us-ascii?Q?EhZ2gbpAaojxCxsDas99I5ENPUiIAFTYhAPM2K5t7W+W2PsgCkz8BpuFjiBk?=
 =?us-ascii?Q?2jLfps4wdxLSRM3SFPCsDo5HIGrDrGaicnQ+04uewRHE2iBxkGv0AfniCZlE?=
 =?us-ascii?Q?YnR9u7p/iAU/ObPelFFs9XaXGAVM+cDeJ19FhUDR/53jpM0IMgilh4kmkX1l?=
 =?us-ascii?Q?l4xZaBooubW/7ZWneVAY+povfoCwUDpJ3l+QDgkH6sYm2K7w82uiYYI1RXfp?=
 =?us-ascii?Q?PGnXuKLN5patFImgt3ofXuZvyj2ah5f5JDMjr9Hj1MpGXApb+xiAtXk8a6zt?=
 =?us-ascii?Q?pLxxLd5zg+om/PxhlOVeq09g3K77G4Wrp157gq02f4QANe9dmYQUfrGmJPzT?=
 =?us-ascii?Q?p3cWmcMOJTso/6zUydFyZHs4YqPX1qbGY9+zTD50of3E/3czdvwJNiC9wJTo?=
 =?us-ascii?Q?EddVqAKdDmLvCr5TuwpWMM2gxANV/qT6EbgurgpHAF1xoKipJgyjb4UKblFz?=
 =?us-ascii?Q?SZUvQpARKdEPGUeT7O6t4S5GzA2ZuOeXeiF5EGY4of0YXDPJK9cmHR18KW9W?=
 =?us-ascii?Q?AkkC4TrfAZEGTH2Tr7uuxx8ku8Icy5rpZ2Bgt18IyTsYJjAJpTXyA8svtEAt?=
 =?us-ascii?Q?CBHvE/9pOG8PEe4+kB+d/0i8eiXFKMxJyV8fUSSmLN7SXWIK8OEgKezaVDMH?=
 =?us-ascii?Q?SWCWyqAIrVs7MwMINg6DwVja+lfoOoGlBAmcG39N9OL57WUqzxF9Qc4euktO?=
 =?us-ascii?Q?FyAuWctbeAXAJoa2nDtP0MM7kxtm2JeRB5WHX6Q2jwAhSvzaRIufE7vI7ePp?=
 =?us-ascii?Q?Wh6hh8k39ZigcSbYt0w5WI+7EJHcNtVKroGZl1lCT177hgIYbA+lZygKLX0i?=
 =?us-ascii?Q?lDvkwFejq9xuWjz9cOJWSE00y3q3kGDbHZcQ/c/gUsITV1w8DkfLq6Q9UBCP?=
 =?us-ascii?Q?GYdhxIMscJx4LVXAycCZHWi9Sahfg5MDvvNY4j7ZIqoilqxwXGMwEZKjHUuY?=
 =?us-ascii?Q?iWhEtUYOnQiohLy1dOzDyCw/gNhLECWb5WPMhFNODRuZFPys5FASsgxdmf4/?=
 =?us-ascii?Q?xMGgs0yMY8Puh794NqGEQcMJjUJLE/pbIE16EF/8pAo4+vqlZEwjUtx3/PBA?=
 =?us-ascii?Q?Fnnc7b5cbu2s1bfevzC1v23HMGR6/JdPB7Y1CLKLiNq2TXw9M2ssqOka1r/Y?=
 =?us-ascii?Q?qVlJxf/DXiJQ4Ebl35McIJnwRlC0RxmYtg6iBt0EbBvfQixvbZxcPyLeIpMb?=
 =?us-ascii?Q?yJcLr51ZDPeGfz2AScnRBiA3IAzBZOcnf0RCYUzAjfHV2rdMH9UIKwWC0KlM?=
 =?us-ascii?Q?dmW1byC7CFGvBBw0Hi23t4tWv95ScsSAGfFLNgfXQBXqhU+loRp2qA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:00.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5109cc8e-a271-4de6-0817-08dd12f4932e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index aa65f227c80d..d03fa9f9c421 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -95,10 +95,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err3:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
 	kfree(cxl->cxlds);
 err1:
-- 
2.17.1


