Return-Path: <netdev+bounces-200685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC048AE6847
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EAE174B3D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456A2D238F;
	Tue, 24 Jun 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u/UwJWBV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB02DCBF9;
	Tue, 24 Jun 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774491; cv=fail; b=GJ80DMy5P/pPZBQY6v+Q7wxMeQBPZy28jjpNQxBIelcrIotnUzD77w2SuErvcL1HlzeleBVbWPWmJOxREOjEyT3EPxC1CjCz4UcsLp0Kyx4515BkVJIH/WoGBvB0AuhQqm7zHSWmDeo+0ROV5esAFSaj+LLTSAadvAdLRPsx440=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774491; c=relaxed/simple;
	bh=mOhyZUI/ozbRKJeilJTBSuagrAO0+DrGV5GY7OsdYvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1x3yoRRjfw6zzNMvkVupVmwc6tIpP2WiIf6uMFE8BRfpFSMA31DxGIyXjzPOGdhbTCetcnwnUEihV5LPpKV00h+/cWonMoww1xySAsLdWW1ALeNoqGmL33YpTCwJxuSqzkhf/qt9PbBBwXXP4CdbtJzPSUqQRe9ATzfCEabOGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u/UwJWBV; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhH4tIy11AqIn8zsywdqM7JX3yVL2TrK02CspqmMl4eKz4BDtgYdp8lIYla+P1gO2DuZ/L8OfPdBEBLCXGnkLt3dMGeOQrzFkOFws+QpJip5L/znEJsQle7yWp1IrhpS3MmeE0QFxvYLKcyVoEOv9uenFWYIfKCtPbFIToKDpc500cZC2cogkuQmu29JEz445MLB0/7/vrtCW7PUR0T4iXhXx6RhAP1dZh6BnDmN4mVuzJ4frIOr693w5DYn21YjtgfjS4RO7GHIGukxR0XZS8SgqViP+ZWaLPACqstleQsyd5dMFczehkOLW1VoSmQv8wuQeGLsSZjb2PqYsKI89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVAJ70sQ8tOM4NgBQDIEQY1OFAXYAEoHFGymN68hEsQ=;
 b=lOk4EaAUdYWcp+0W4ghSz7RFJTWZWSk9i8tsBlGbHkgRiWQWwuzIrhSLadU1cL5cEPibxjlmWBnosaoEEEZS/n7pLl9AqEBl8DHdwLdcOWe2wzYRmwAHRARcFKRq7VLNrM12xfUe67PPiXQ14GK07AaS2gWjRIUMS4nWYEeWpUCUsfZ+c66dZs3+tPGgTEsHaVVLYBZoSkS4qjTRRZdeW4pl3JPNwO90+qDHywb/oW/b84Zj/jPfbAkL9CU/zQzRWluWjlfgtKIT+XmLQ30N7A7dW/9HtyNVi8XJxBi9EdlO/N3elgvVhZTWBh3lkJkirNsAPvKqa9PTi5RM1mFGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVAJ70sQ8tOM4NgBQDIEQY1OFAXYAEoHFGymN68hEsQ=;
 b=u/UwJWBVQ9SNoWVbbP2W9Wo7o4N1x2H7I25AvTg977CimLuAwwakWJ8OXV/bWOifVJuBz2W17uL9+ArBKngbYAYVAVhwWSBaRjSBbEbl1md9BVcEwH7XT9jlQa9vq9wddjc7SZk3Mn6iolQi/aLMie7idMjB2GpYZFI6USJPxCo=
Received: from BYAPR02CA0063.namprd02.prod.outlook.com (2603:10b6:a03:54::40)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 14:14:47 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::39) by BYAPR02CA0063.outlook.office365.com
 (2603:10b6:a03:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:45 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 21/22] cxl: Add function for obtaining region range
Date: Tue, 24 Jun 2025 15:13:54 +0100
Message-ID: <20250624141355.269056-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: ddad2ab4-203b-4db2-4f0d-08ddb32979f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTgaroIrX6vLes9bbWizLQPa4E0ZTyTuylIfgt4/ny2ZBTLsjpV0CEbzCBhw?=
 =?us-ascii?Q?8mhNVgp8vAu2lXh3b9N+SZSU1Hl377PWjT8zk6sj8OoqCxO27ohVL1ZPuPWK?=
 =?us-ascii?Q?vTu9OnPerkps1pYaY47IB7W0NZ+6K6A5J1yjfc57o0SwJhaqPRsNvBOxEu4Q?=
 =?us-ascii?Q?Fxp+KUsJV//y6LI3nrrBJGJXTDMSS/3ImLnOHvpPL84+BZNVVBsG73jCElyI?=
 =?us-ascii?Q?kegftSzV9gn73WSsX/0pDsrl4ERdFCtW7XcBxNlz7XIrVx+mcM3SGM2Zy3XH?=
 =?us-ascii?Q?6ukIJJBmiQi7Pqli5QBhl7sddEFFYuU2++1IMFRkIsSvbr3OZ7JgdNLCxMju?=
 =?us-ascii?Q?ss8iUv4610YBXI1sCADfMwtTB/jXx1WVsR8/EbCL+IMx/CNrGE/6f46itXf4?=
 =?us-ascii?Q?s7vborovvLu7BgAh5h+76I27qYVP9qPH4nZ5KTc5UcaB9P+CxMY9un6AyF8c?=
 =?us-ascii?Q?zHDqZMMn9fMkMel/ryrNZlAyzXIb6l8WIxe9UzhDJAr2j85YaaDVWG9xbVDR?=
 =?us-ascii?Q?EH4b0+qg1FXbE6s2JiUddMxWYi15RYITXqtFYfAF+78ZE95/vAOVBryGbB/q?=
 =?us-ascii?Q?qeMGrX7HuWjvSyCvnR3dpQPWWVR8Tz4oiSskk7ooLzuIlsmXZYfEaOKrBJg2?=
 =?us-ascii?Q?CCsO2i3SInsyLgOvFBZgwY8EoBX2ZM9YnM1YXqS5fjldZLN25fC0cdkZ76UE?=
 =?us-ascii?Q?vJUI6kNOvqfOa7S3JcU/xrebxTQNoeQVgGZ7kswJg5HMlarh7I8w1fyGM3rs?=
 =?us-ascii?Q?yZ2gb3GL4fhxT6+9UhmJwYNIRkdSTppnQ8k8vF5Vezz//dbqy23677MGDwnv?=
 =?us-ascii?Q?KOlg4uF4sT+Qp6Zw5XhBVPl9wMb3MBbYwiJW07yDVltPqS09I0jXmAP9aIX/?=
 =?us-ascii?Q?Yb9Q8p5YT3iF9KcmgWfDrGRUUbgwgLLWE5bCkZeRoEgRce9DcU4WnHRI0thE?=
 =?us-ascii?Q?OVIPfp73EJD+0bSIMWCsLKDjtNdtBq4e1FRp7EPfc5ijFErxqDGBpmVQViz+?=
 =?us-ascii?Q?XB5lWypDCmEGmgZNcOYEhAyQbUCdQMl1NLg1IhHw5AYRGpyxn9+WqOjwEauI?=
 =?us-ascii?Q?yFT2qkS18DBAuiOiDzE55MdtR2xYI4KWadANvayQyTXUImzE6edS4838q4NS?=
 =?us-ascii?Q?5Q8WRJvOckZxxKEiyTyTIAyUgwDPQq6W31QXGrOjiekUA1JNjhk4tHq/cJ9j?=
 =?us-ascii?Q?a+WDNymy4f0HbsEKqm9UamelK1Ymv4kg0anNliB1LZnk6qtRwWfj41qyHxKv?=
 =?us-ascii?Q?goXD627fEW7iLCiTrEPGIAokZgku0S005ZuE/0D3sgYkYCUtGnWfHUeZ5Z9J?=
 =?us-ascii?Q?DXKxyU5gyc2c56ezPN6siBiXZ3QTocX8+UYDGgI5vhv20ZDS/z9io8rqO1pj?=
 =?us-ascii?Q?etoRx9X44Wjn110azZLoALUofObfmSAR2u7nEtJEyFTM9o50lNvWc6rda2Sr?=
 =?us-ascii?Q?cJgAbhuOVFn3NJIiRXPw0fJ9TW65H+o0P/a9VUoGvxwHqicbKNLXURNDU6h4?=
 =?us-ascii?Q?fHgaPWi0LEmm78fpZ608ilDOBDq5fZpS51Un?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:47.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddad2ab4-203b-4db2-4f0d-08ddb32979f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e933e4ebed1c..8c624019bf9b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2721,6 +2721,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 5067f71143ef..5b4786a412b1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -257,4 +257,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     int ways, void (*action)(void *),
 				     void *data);
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


