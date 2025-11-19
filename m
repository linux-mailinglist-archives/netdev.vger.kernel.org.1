Return-Path: <netdev+bounces-240151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A3C70CD7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1A4E1735
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBE3730F0;
	Wed, 19 Nov 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SzVPXn2v"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0732D4B61;
	Wed, 19 Nov 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580214; cv=fail; b=ZPZCn5GYLZZXsoMQ79+/SJGdcsPwJNXb574Kbz25dLstJmftkY28K6MdYK64tWS4szK8TY2SK/tB3BgcrhVX+4YeSLbRemcqY56aSzm4lxuglF/2YtZEHvyj9h5z+1NjbSdzYPiOCUtLQSA1l4X46vOqAIbOPwlybhZ2C5URHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580214; c=relaxed/simple;
	bh=ErbGUp7zyegTweIJ0b2BFtZhOaUUdvuCIl6xkgSsgRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M83a8cRtw/e2u9cRFbZKUi4efIJDXuc8pRfr8eMX8gmqltFlFrI/BG9oRggTbDAS45BdqidUhHFJk2242lc5aqj09ZDCZLdCaPRvlrKVzsQslZbGdsgr/uqZXpkIZHXvvMcZAEonXgiosUhY3obAR5QPhQQOWrpkUTA//ZSzx6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SzVPXn2v; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEE0kyak/t0F7EeJy8xDCV32MNc0uGfmGIOoP+ZpKswChlOFsAiLMs5+bBHw5AZsek2pcwbQJb7TrTJZJXJHVxqg4j2HGIrwkNaOrH2u59fMgkcahfDSEqoIdD0fPIfwsjgs1Sfy15gIqsaVQKax3iHBFuacsTYxODT8GWTyoxJW0BdDLUSyuxV7ffG32VM4gDpR4AfL/it8w/ulI2evjrokIWt7q9WSvLdgMSdn0S7JfJnoz3lFGO60nuT7WQuJbmp4Twt4y07p7ycy4LuW9kNkFzv9Wlq0snyKl3tagffqqcaOOZBy8nvQZjR5yHJR1vAkWHjO7BFvQziwWc4qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/8kbT5A2wdQww6l4BYCFoWOZRSu6g/V8HWLyYSFWu8=;
 b=HBatIVlUFVAtd1Xv302jSZeytWxD7/CYD+i0kCD4rel+6H6Ldc1tEfeNVUzGN4spQEhYWVJyY9+K5JJ6IdXqvetdkx0gcjRxR4FWnpvxRgKyH5baxiX2bQ8OnyWgi3sN0ufOkYr+879zbpHs/M0YY4WQU3FPogQCme9y025/CCmrBSyjuhjVQ7h5gBQ7nA3WDk4L9BvZSNcycOl5CiTh5lUzeIhVJmAWEIZPj6tbiRhXDJ0m2wivwVqmZaatVpxLE6z0gE0t1HcmLQ1tQnS6+H+B/lTqDVmJuLKFDN6iuCi/68R7WQe585OjRmxVXo+vslJBGhPlPQ6QLIeEICABHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/8kbT5A2wdQww6l4BYCFoWOZRSu6g/V8HWLyYSFWu8=;
 b=SzVPXn2vcJeIFD1JRbbbppKObhIQC/q3fPQrDqsCTuwMjLUzW6zZM5D/iG2OhjOIGhNXtbE9YrqZ2T8LIykFHnE+RGiLDQn3yVnPrpNG2enR1eyNxmIiuL0krSrxNl3V9HAQ/DSjNDGZd7ozGzmFju9T3bnlqdogPqr2+JdKcYI=
Received: from MN2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:208:239::29)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:24 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::b0) by MN2PR08CA0024.outlook.office365.com
 (2603:10b6:208:239::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:21 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:23:21 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:19 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 22/23] cxl: Add function for obtaining region range
Date: Wed, 19 Nov 2025 19:22:35 +0000
Message-ID: <20251119192236.2527305-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 896c6a08-1abf-4377-5258-08de27a11a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BT8uYvN/UupBzscsrf+YW2YDe6vZ0cGY+OBBUTKwTDNumMUuVE/0LANoaVRN?=
 =?us-ascii?Q?fkmjQCChF5G0YOsuNJ0SqwPSPypx4MgSXAkBCRndY0X0cpFmhekFstYKyu85?=
 =?us-ascii?Q?z57qF8luM6eAHQZcNIMaDve9oO+UhO+DD6VkZG7px+EKbxuC1u4k12u404mX?=
 =?us-ascii?Q?FKd/VYAuBn7IzCgIYt1lm5qo3wQPUav7xpItCSJfe+fcaXd3dUOqLO19IhP8?=
 =?us-ascii?Q?PRbYe/CkzVCu8S6m6KJIKF6LJ2Bru406PQz4JtkliicJHNfKa4gkiXUKfdRB?=
 =?us-ascii?Q?N720Y2Rgq6z4g219XqeizqT45CI1NtH9HkDYL5kU5kU+CaobBkQ4stmAFomy?=
 =?us-ascii?Q?BVIToMrmen46zJ9N2l8JcBpkKGiWPfZ52cghuB94PpnnRClqvpFz/pSuMtob?=
 =?us-ascii?Q?seSDjuV1TJrJ5gdQcgKJdA9OYOuKNqlycmUwGWzu7LvFC/IJDnYFVm1wRRhs?=
 =?us-ascii?Q?m5TjP4WPE5Z7KRQnJk25vBRT1soYArPhXMEQUlqE37kZoMJjaacC4yrlOvOl?=
 =?us-ascii?Q?CPhnQpnPjgRLpFv7xcAZXnDPtYK2Z/KBcBjdyoDYglmktBHKBSGSvGqO+lzv?=
 =?us-ascii?Q?wccvMxbHJNqlBAjbNR4qWf0qvL29Q/EvAO/c0A3vXV0y2sR7skFRz5yTtHVP?=
 =?us-ascii?Q?8OHP7+Eooa+8VovDNnCfLPzrp2vqkFQTXy9M2fcQ1NJ2i7u55F+bxnqp6XZJ?=
 =?us-ascii?Q?wjGkHlvTcUWBapKDn4c0yPUC3IzGosnub8lDedLBtKwyYaN2w+WJ41EA2wF6?=
 =?us-ascii?Q?YvLbK/oYJdmeCQG1Bn6cysLg/TUYoHbwMlvB6Qr17B9sefz2Z3IvznfUm073?=
 =?us-ascii?Q?vvzAM6M9iGpz+kCNJvYln6aFYglV6MSUAdM/nqgh2tMIl3ajesfS6LCS8Ki3?=
 =?us-ascii?Q?E+tpCJ/oIexclwYNJw9JPzVAzVI/uOCBw+50GYE44zVsXv4mph/mSVjD61tI?=
 =?us-ascii?Q?pbhvIrftm4Ddta8LtAE3cnY30Gn8CzGKhonwgTj7xdHXv56U59guOa8BA//d?=
 =?us-ascii?Q?C1EOlB1MPoD+e6/CaRVexdXo1UVtfgM2lwJAor/ZbYjOT8+hACT0ym1MJF96?=
 =?us-ascii?Q?eUWSLNpRjVO02jrsyaNy4wCiYQ35YDfZgIpwqzM1krs6vqEmq+Jl76bNAj23?=
 =?us-ascii?Q?02FmrXJpCFWkKYO+Z7VT7AlXGJXqYoCATAsOVbLTdLZJsTGOx1LD9x9z+mCR?=
 =?us-ascii?Q?md9sHX0arreI2O7pJ1mfZLVHH1rQuA96PoFlE9eVX0IFlFVNt1Ab00johdvu?=
 =?us-ascii?Q?KFIqdxWIx2kIBnND1JzIv2OnO9JSHoJVqIF7cAEk9mi0kTnGFxRc++5BFe00?=
 =?us-ascii?Q?T2CrlhWZ84iK79Xt/9+bHHq5lqK83XSrkt7czN+4lGO8spYP+GT25TiQsyIJ?=
 =?us-ascii?Q?vB0Z8mpOEZaS/sAtQ1VGrIVD4O7XxHd9ijNcgZZCWFIGzeidfELBJTXhof/U?=
 =?us-ascii?Q?Dy6ppUWjARsgAErJzQaOV81mCZNHzMSkw0KS3ocIaGNiIRZMh4X2ATsbjPmC?=
 =?us-ascii?Q?9HimtEn0HMbBFWkoFRX2VOBp8UkfdyYuM/XCagKhX74zFrGVcy0aqUqo8F1A?=
 =?us-ascii?Q?QcuiBmSG23XX1uRIfuc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:21.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c6a08-1abf-4377-5258-08de27a11a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

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
index 4f56d1ad062b..44e82b2eb247 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2757,6 +2757,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index c6fd8fbd36c4..e5d1e5a20e06 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -286,4 +286,6 @@ enum cxl_detach_mode {
 int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


