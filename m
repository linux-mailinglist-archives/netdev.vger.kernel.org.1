Return-Path: <netdev+bounces-150358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F479E9EA2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6411B167305
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C781A3031;
	Mon,  9 Dec 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIRgB1il"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71819CD1E;
	Mon,  9 Dec 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770522; cv=fail; b=OAQJlCZvDMLCC7XS3l+DO9JZxLkDF2cwoothKn8PK9/ODpOCDWkRig/xhYiuj2o9rmL1nBngTtezFD3m4sVldwV2KIPZMCVfvgK1mtTmzbSPvQjAwAYr/jfz/cQM61dNGedVBlmbzgx4QDVlLK6bWdxWnLc5LrxRiaeqY7O+I1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770522; c=relaxed/simple;
	bh=vAWOQofJ6CNCf0QuyGQt+baFEyB3MNP3lnfuyM8bAzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST74E+Rrs2TBMYrOfayPyR9DhL0srNPqTP3mQk885BIB0YoaW8mVFuYief2SN39veLCsK1/yO0MxH9RdgTD98MRouLTlNUbnuyIB35MvHrflir1C3uX/MLb98d+oHoYRPlGgMPGCwmB8c2ayzOJ67RBED3K3bfHvpwym8ldNvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIRgB1il; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgwtpwsMX9MGE7xghcGXL8SNWENKNrhQoxL/QZGZTX5xtaiOG8g689QsZZb/JfUFrhTrPYjR6D11VAbf4iKj2CrlZe51J0etI5TrIXNbbN635+1jAQI4sNKebPM+62tPTzrGxSp8JviM3AeWbYvdnfFVWlQuhzOMFySkXNDR46SJzUPVJ3P2jpv5I459a7iThWEbE8/aGeZO2NNtW0CI1mixenexm5BL4jhLMmjf4v7UbUJ1Ll8p4udJ/4fVZc26zuysMN+RbE0HA6sdZjScb+NRDYRH9YALduDqTsX6KHVeVLuTOsUqEMf+jedMSsSWPDdXGIJUUFBqOYjvf7ivfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PRmLV8XTb5yzldJjz85RYqcpk1vGTkDCRVKXcUelUc=;
 b=ZtzyIBSmkXZAAjmp3ySY20pV0lik3h6dU//RNHdNmcTlF475GjgcigBJRfiHGaVUMzdOVXrWw0v5i5xQ/N+5/QxjDmtESqo57+t73pf/oojm5VWhuEJPyLBQ3ImNlhW+QVdl0ubrim8wKXB51i26N4TGRwmz4/bHfTMH2W6dIAhXuAAoM5hralnD0r9AijArJ2goxyCtBspv/eF3Ij4U7o1ve9DmKO20yas9GTaFIoCQh9hGrSMw62xqwG/G/sDTxtkcIcAYb38+FWxZSXJyO+gmBzDcr6iwJPb6ZX5VGcWQv7QgnlaYEyJFxNmEbyycjsW3JHuebmXCmg7wSzGGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PRmLV8XTb5yzldJjz85RYqcpk1vGTkDCRVKXcUelUc=;
 b=fIRgB1ilPS3BV6l+u8AH6jgVRzPceWpXt4OBqpFxowasBk6s51ukm0AKr66vK2aLc7N3/PqAwQgLccKUG8+BY0J8NGb5odq2k5eCGFH1HFq9p+xkB+Dt5fhHeW7tM8vpi8AruSxRWbDCjOGllYmYYfum/pHbuXv39Z0TJXc2K6o=
Received: from BN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:e4::8)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:55:17 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::d1) by BN0PR02CA0003.outlook.office365.com
 (2603:10b6:408:e4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:16 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:15 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 26/28] cxl: add function for obtaining region range
Date: Mon, 9 Dec 2024 18:54:27 +0000
Message-ID: <20241209185429.54054-27-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ac35b0-4921-45e6-c086-08dd188305bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlZpXUMedP62dBhG9kVbAfm3SVtnNuicKEvEam84qKdmpYv0UMwpOd0GtA0K?=
 =?us-ascii?Q?MfQdX4VfZC5FQlZk4DRLpE+0mDiVFpLVQmDMWXjuQowyqrG9/3jUHL9VDUpa?=
 =?us-ascii?Q?4FbSn+HJCPIYxdw+9SwxYRJbCUQRWHVDRekashVSzSfRs+jyu8jXWr2gxJzc?=
 =?us-ascii?Q?QG5ffqTLqQxWkN0VWiEq0SdZOUNJ3st/6PPngddV7lwLbDG5SH2WoSO9R7mp?=
 =?us-ascii?Q?djUrxZDWQfClUfMtAJWPC3EYLGcwWElnZOXhlX6wihxpMDKKK4/t1B++tDO/?=
 =?us-ascii?Q?A+V8/vHL3A96vIP9AX9qeiIzcPe0EIqMqACJHVNEjt9aODwd1I8Ovc3EzqI5?=
 =?us-ascii?Q?JU7CIMYK4crusBYV+iaFSp3F/pO9frRzVjYUagIFvCdYBfhGOnL8e0h1sWeQ?=
 =?us-ascii?Q?3jF5u20DLBaJ0A32RxnyX2hES7a6XlLxOvQzSn/6KLQkb2xeEHICP2iE9XZI?=
 =?us-ascii?Q?vw1S07UEGxbUWKQFte7X6BelPLoWINLWQ1iu/HIVMxttue5SgR+0TawoZ7/k?=
 =?us-ascii?Q?X14mvtiA8BbJJ4rZybZbeV5obQa2Hdiiii9VPOWY/JUtO3DNJy2XubxQs1Gs?=
 =?us-ascii?Q?69B/WE22dEkQ2q/HqxqC8ANbZ4DrDyC3R1HF81i5qgOg3BiZekU4i4QOZ49K?=
 =?us-ascii?Q?UAgFkd2etwn3aGRhwiKoMQup7rWGGdvPsybv7pqyZlQFc8wkMeoEe9n4J1lZ?=
 =?us-ascii?Q?VJyFLn/PuWBvq/v0xjQBTYd+6QEfLm1XeP3KG+4OdftzbQCofPY+GyX0LvqV?=
 =?us-ascii?Q?/4Bk7eK5QQLw2yfWTgv/KhwBoNjMGwkRLs8BP1p9HnzMcYdznlt16R56IFzx?=
 =?us-ascii?Q?muQdIvCiH7yvNEkzE+dobsSTk0TL99/Lq78dRRMebOB/jTrJSS/Y5X7Z2nY5?=
 =?us-ascii?Q?1kkFwqT5mx5rNsL84bRfSDL86/vGQJZPYHXbj4WfByWW2OM1e1sduheernZt?=
 =?us-ascii?Q?wmCbMgC8Pa7IUlIP6DGah/6ABq/rYII0lLFxp+2G8UQYdn5K/vmv18Q1vIdA?=
 =?us-ascii?Q?UsIidBeh2A/p8c1peR1/8/gVCPD+FSLVlIWnFu6v1dgCaxKE+rt9Q2Mkf/NW?=
 =?us-ascii?Q?pLVj4cUBsilknwL+QsFLegndhugt7gztu3t1RUjbs/YmkkHXLlLnaylYTCSk?=
 =?us-ascii?Q?EGQA0foK6s0P+MQPn6baiYL5LCFNi6aas8p/2BMeAE/fS54Lnz3rwUFhWE3Y?=
 =?us-ascii?Q?BKxnXDWb2PPH+EoztUzsBoWtakvRwedPplBhoDGMIyDHTmkpIvbpGaun8nqN?=
 =?us-ascii?Q?azY7TJyFEDidZYbCarE4qFo+h1qo7eaiAlNc8rAnCCy+FOkHIajbVWj1uvfa?=
 =?us-ascii?Q?lbEzrB1Dg6AyF7lw9OR/Ie/MJmF67Wc5SqjxnT4g9N4kY3CjAIxMZ99k20nC?=
 =?us-ascii?Q?RcOEjCzu/Xff83cRSHSY2+n4uKcT7ygbEiW0x2i8bQ6v9hVh4JuSZ628CRQY?=
 =?us-ascii?Q?tKwwMVg9ZDylKAY/2YaPz3xMps4YuqvYejiR0wUsL5IKLrkR4qDOnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:17.1891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ac35b0-4921-45e6-c086-08dd188305bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/cxl/cxl.h         |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b39086356d74..910037546a06 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2676,6 +2676,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cc9e3d859fa6..32d2bd0520d4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 14be26358f9c..0ed9e32f25dd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.17.1


