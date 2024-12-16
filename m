Return-Path: <netdev+bounces-152301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583349F3593
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDBD16482A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D729207E10;
	Mon, 16 Dec 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tleEHy0P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223A207DFE;
	Mon, 16 Dec 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365493; cv=fail; b=ZlFpf0VvrSsbkKaES3QIA14MDyB82QLtRB7n2a2f/OQXvo/sMnXlhFX6Nxob2++t8rg9yuOVYibjuWuqjnUmJbezcU4AY0ZZawO0SpFpzjuyyLG83dDqYP/HHD2HBw7KywYs2RG+dSgwtvekxw/W4oM92zAttvE/qBi9bXTFj2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365493; c=relaxed/simple;
	bh=O2ot5QHhSmyqAZ0ixEYJ39PNw5Xpt8WyFA6wxvet99A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceZJbvd0q382NODlfdQNxjM/L38xuJJZtQ0NLtbdx8PhukdQKvSy43xBPvgmv9z62AFBmOCy6JYUGGRLpwSNSpEtXldhCJSjKOmMtwhmrZZ8l7bmfW+rKxWnSSBJ2hwQr5LITgWhPiSvylFxo6xY04/OW8weEcHXPu1OUpyzoNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tleEHy0P; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOMAKj0CHpb1CR/CA85E37rNdd1UarFPX9tHyG8ZR18EuS/jA2q2AbU6v4OtwraB14krg4sNrnmGBBu06Kjb8wqU8uHw2ZxMkDdHIo/ZxNTszNWWc578MdM6c9GXw8piDJ7XBbvIAi0QgpVtoCnC+b1bJfeS5p+eOTiSHRwKaOaQjuvSvY4ZI9V9s1FyU/WFmPKTsC/YlozaqfZCNfsKu4o9HNnTQ4CW1m9e1fVwotJVubADtQOCG6cqwTsD0sFMzKqrMzE1VS89+haybiC6F7VU28y1HUsaCupke/l6goKWtiTbRS0LxmGxRA23LeBnkWje2toa+ZxgzYDhL5Xq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JCi2EsQsPaGsYJ/Y/qiah9v3cITzNxvFE+03OVxaXo=;
 b=o3F6gwlM2sg2ELjh3TED8aPQfTyo3mj2z3/DEsqLhrJZAQ47RumFAXCPkfpLrTrceKearhZLvRUR3TjzjPXGptZ7aFH7WmXKa6CXb2kCVkIiceKJ6D5JfVXGLethrVRmZAGU73l5vWjf127C7IsVc2A/DSroeweXWm5AOG81vC254w17YW533VNCG+29Fh7qNMptKuU8JrEsIwUUU2CXKcXpNFw0LnCCuTX/8CrRjBnBJR9axIoVfkyu9C615f3NjiVHudvcbY01o8MZuXIfpYDI2/6jPs/JzkvKAbwDNfpFWqbIPAzeFO0LukDm0Bw6x/jZQyXO4GMrojwyEkJ3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JCi2EsQsPaGsYJ/Y/qiah9v3cITzNxvFE+03OVxaXo=;
 b=tleEHy0PnvLLgX6XP9LBw3X1bPx++VJjGYFASz4fYFXXBGQH56VSusySm7mgfxpzO11dHZuV1bsEJqQ8slRl6g3PbKoM+7y7VOxuH0T9/8Zd2Uqj1jO7kgMZxZUztZHMjgBBHj/CaZqjezpCgEIhmS3Zs2tW1oUEphbSG5KK2mA=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 16:11:28 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1a) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Mon,
 16 Dec 2024 16:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:26 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:25 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 24/27] sfc: create cxl region
Date: Mon, 16 Dec 2024 16:10:39 +0000
Message-ID: <20241216161042.42108-25-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 02547e49-37dc-4974-77bb-08dd1dec4beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6YGkTO9hak/ksx62MRvLBNbVZ9gaanT46CNptx7Fxvb66k/aq/aGUB93+i7?=
 =?us-ascii?Q?CR6C42UX4jV1lI0JGCyRByl40JbMaOb+bUEkYpoeQ/KepFo7R9uKAbwLtsuD?=
 =?us-ascii?Q?LeBEeCRnWD2jxfpdXfq30vBRnS3CfraE/XH3EKwufGWciU780VPc6VxdmU+2?=
 =?us-ascii?Q?o9FOu6CaZg3/LHfz5mTpdlBwITGLPSt9eMOT0iNoGt99n+VvR1i9wiFB2UYK?=
 =?us-ascii?Q?R4bzGN+E6/2fgFnLKSSxU18ca3Iw1pP1kDRTruZAexXxBPp6RhMXAp2gZYru?=
 =?us-ascii?Q?PjD5ARRAFXgjqJd6cFMBQcn2jAh1tyHT8ZqoxJzcsqiH60Yq0tY+9DjaS4ZB?=
 =?us-ascii?Q?mWKibnEcryV8dYhW+56PXIo6y/tr1CBbIUqBpKg3cB4We4D1bvfyuk97zb4s?=
 =?us-ascii?Q?U1PPbZxU89svoiBZJLsdsrdYeAztwVll5GJIcrt96xF0bfZ6AMu2BFcdPjBO?=
 =?us-ascii?Q?wLTa8zdUh3mkascydP2JHwqj/eBvYFHJJl+8OSqZ6xhbnc4Nh7SQJ0TRNsae?=
 =?us-ascii?Q?Bh1VJc1tjRtqNLnYG1uRvmlDs/29/1jjyqKcVoXbZU5joy/vokENUf000WnH?=
 =?us-ascii?Q?mm21AAOX/XLYJUZfYFp9lKKPELPOaDmEAbn+1tF6PPD1PsVFB78V/W3e68X5?=
 =?us-ascii?Q?+UDaPumrLbBAG47fpmWC9PqnLhmHryrS76pq6JNOXJBrBJsbDJjyt72O+zAD?=
 =?us-ascii?Q?/yuYG/5A9zN6iOQciFoNNQlcHxu+Yv/dyyrSeB5hzDvu8trBJw+fTEjiz7Wq?=
 =?us-ascii?Q?w8Ozxgbt41xcHPoNA2c5rOO6aZmu66hEwotiWZyOFT3El+HIHGmwPc4i24Ls?=
 =?us-ascii?Q?8FyAmA1+cJUFalFrLqSzffRq2Fqchi4SdGvCgW/I2gIAD1NiR11dwOpH/U/9?=
 =?us-ascii?Q?mNl6o21rWuS6DFbSUhZtDLBnc6pTHeFjZDq7rRUY3999l1jKgJnCWQLei1Um?=
 =?us-ascii?Q?PztnGjfToyNP1aTPN/PU8HM84NOzS1ZkxHLsrbj+A9GHlYwfikNFh8+6frOM?=
 =?us-ascii?Q?/rNh+Iorcdh4phnF6B7w1jwb2wd7bwAMYQYXyXM4u6iwq0EsO6rpEcf72Qqr?=
 =?us-ascii?Q?I/mW8jkV09nu9D1m5BkOT47MWAAIlxGt+TjU7Z6rYfY5MM+kHRvXkYVHDZL0?=
 =?us-ascii?Q?8nlZ2oixbVLAV9hZrl3RCZBUe1rMSGi/rG/b/m48F4hj3zjSEYvjdXicLCOA?=
 =?us-ascii?Q?kICXJuOhA5Zno6ln0QfkIOTNl6VNAoy59SWTXq6T7R0GPFsqUx0L6vi/ErL3?=
 =?us-ascii?Q?wmSlJxQbb0zWk0R3n2x2CwEvOVmqnaH9+U9WzoGZQ7lx0fOzUWdE6UEHIeE7?=
 =?us-ascii?Q?sTSB/Duj115S898q8nrBugDNqT/7OdZdHetD1ykKUFUpSMlsFyhEiKgJHDO3?=
 =?us-ascii?Q?YwDN1GCsRxcQpn4sXc6+61ifDGHSoLEckeMViBOy/XFTsXbdghJY7qLy/YOM?=
 =?us-ascii?Q?RxBjBD496gLHuIEhRGX2wJ4dJgTyxJMcgNCI6hO+NqlxQIXwNAQ4jodk1Mx2?=
 =?us-ascii?Q?tXoQQGG/V/2+BEqv5nKNMYehfRRh4DI85fIi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:27.8126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02547e49-37dc-4974-77bb-08dd1dec4beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range specifying no DAX device should be created.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 724bca59b4d4..7367ba28a40f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -129,10 +129,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, true);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 err_memdev:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err_resource_set:
@@ -145,6 +154,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
-- 
2.17.1


