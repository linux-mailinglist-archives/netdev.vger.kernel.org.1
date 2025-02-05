Return-Path: <netdev+bounces-163059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF9A294AF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF8E18871FB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180021DD9AC;
	Wed,  5 Feb 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xhJt1e/j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD641DC9BB;
	Wed,  5 Feb 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768839; cv=fail; b=kFjr2olwKOnx2UlYmDaftD6RoUpsbH1Xpvsjoz9b505MYN3IjP1CRoJp2ECqr7eQsqOyR4xdBaKVHrftfHJ9nfaVKfYV9/IMFo2zcP4mgmmzmNczNBUdZXr6Pdq8SSolR8zi0h/6lV5+Zr2m5GhoATImWdX3Fo2AO634UNyjGLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768839; c=relaxed/simple;
	bh=fsr6DEG+/U/OOvUAMOA+/Pe59bpFELxP6RjgiiJIwEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAdLhTNjCCzAgSGQH5Wanj7q5KOITKw2q6aefY8ljhU5nKBq8OKZS89RzkkBsvvOnR/r4U2ufi+efKQkE3kU4Q5/E9e7Qdn+NsTy+69luujfSfGCG1633MNIA9UHzT35WS9cokl6JScJCWplIGiqJBy94yma2qnCpcGWHSwwc64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xhJt1e/j; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt+xiSi9b/njh+zTTbnasqf4kAlvTcx3EcZrn317slUZq1CHwjBEpWSgiHQxEZpBjfbXXsubHJE/NB+OQN7ATPTFyzHk6fUzqowhYgRv9mZ11S9EGZ2Rk4X8wH5rmc6h/9ghsDZ+K/3mmqS0dlrsB7RvF1xnpm8/6nWU73TXPb2mU2n5VqDBFJgjcsyVP11PR3BOX4ObR0Yn2om7nMGjdb4u30ejhGPFwCNx7il2aM9ZigLMT5Blv62Z/TLuFOqf6hoVS3JqQ4Y5R1Jpikv2l0ckeZ4F6fWgsjKbx80g6VH1lBbJscPsvHMYpB6G57qhKDyX3IW4pa/dedxB+5fFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Den7OXATGKBRzzEuKORn974UFXlBxUMPRpeFLv0D0yE=;
 b=UNgtHelqpH/SRCaBjKz/Q8gGUwGGa+e9+dcZPZw8qzF0nBxBfiQcYQ52lmYXMgYfMZwWUcqkicPYZvciR+CObCE+G0QNOzNJZkUxFWRNMgfd576yvEkrnd9wEYSimgqI0/+/wem2Wf3OIeIUTJcjB2WlHsv7+feErMBfSUC21r/bPub7z8MeI7dhjJJcS/s+n5dbTWqDyw6hBwhY3COFr1D6zO2+S5ACxlkX+n5QC9+Eg0vOGcCjXngCGmjl7vWUKDzIQM/hcMsO21RcLtM90NneXmfpwVmiz0kczGEjTCianYHFCY7rRJd0FsJwaGVGVXavTrJiw2fMzRpuyQObSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Den7OXATGKBRzzEuKORn974UFXlBxUMPRpeFLv0D0yE=;
 b=xhJt1e/jeDjkoHFvxMCsW2F6vn0kOaknvLmi4p6e5wU/9sstlSloQ7Ozbk2d61b0NatsOTqHQh38IStuCD0QsS5U+Lka6cUXjrgSwzGbZuxcT/mvEJ3A4KnEtT+ssfy4C0mzHXBCF6DeKobgQ4C3CNDMtb15mcbEDv+U/EKAG1Q=
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:33 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::53) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:31 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:30 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 24/26] cxl: add function for obtaining region range
Date: Wed, 5 Feb 2025 15:19:48 +0000
Message-ID: <20250205151950.25268-25-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e08ab4-1cb4-4ece-4e78-08dd45f8a18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xyIV4s94dI/IHePc6mRVLuB8aZy4bNER+KdbBF47Awmf6TePJoer6UA6N0k3?=
 =?us-ascii?Q?4cUPD5Rgr+MWvx3o1PW0JHf4iU6dhBK/sa/HlbZMjs3SDW+fJohggfEg4D80?=
 =?us-ascii?Q?pmXhpTd5cTaU2Mb7TTCIOLaJgkq2MAZzOT57qJniy9jdkHqhcqBLt36GI419?=
 =?us-ascii?Q?RukHfCYRSP6Ad3GNlm/B2e+Si2NRkgTGBw8WpEDDT1uFqikDXGg7iRclDcYV?=
 =?us-ascii?Q?OvREHLjeamD7WzXalN2BGs/bDI8H+tXOVoEAGx8JKuljzZRY8eOwQLhuk/Xl?=
 =?us-ascii?Q?BKvw5vK+mzaeSnLmidf9LLKXR1hMLzqrsEOj4iC0iptTuy9V2fmVP7u1xZXO?=
 =?us-ascii?Q?XxNv3/ABloX4g/Pxb6Qk8T0iBkH+0CL9QToCS99qmOoqpVSuKHXjFZvkWVWC?=
 =?us-ascii?Q?acBU64774slWUGc5b8hOfvkKZNS2+3n/k23OT3AI90OfVnRWldop3tOyPlYJ?=
 =?us-ascii?Q?qv2gw/dZcyw0oJ4Uu4OeiswUAgJyI3+FWn63EaHUlax/WU2rSUJ3uZeVs40k?=
 =?us-ascii?Q?EQI0K9z/olzBv0iFv6KMoW2lPB3s+YOfIUzPcJQKevDxPtPwpmAbVSXq9B0r?=
 =?us-ascii?Q?ZcwFk5LJa69/8hffQivhjAqeIBDyFBL1V6rJCsAX+fdU+nIcUjMNt7I90MOb?=
 =?us-ascii?Q?hl/bfWi6fF3p3hDbKm10ORZeqrCaTZ5cmM8dd+lwgLWTEINLle6PiaykDCpL?=
 =?us-ascii?Q?fX//V5Ac/7+jfW846s9p/dFDzdOWxIdXQgZ3iONF11q2xmKM8UHbIQobWn/B?=
 =?us-ascii?Q?WqapvCWP+yEAC87fCR1y/9HcFfK0x1b+a6RIkfMi3lMow0fdbIBZygccI4ea?=
 =?us-ascii?Q?QoYfS33hvse4xPeLgpPbBOHnyhG/SyL5t2xTucT7tueUV1ZiNMSlIAlUUe7B?=
 =?us-ascii?Q?KszGuLZxrqp4aveG4kb9LBRq7kGN20MmPmvyJDpvL/DSeytA8Y3TyCS+AsGN?=
 =?us-ascii?Q?qbriFWhJpewl+VPPpMn+Xqvi8M5PvSlldYuFrtivrkFL3ZN338qimPAtJd2X?=
 =?us-ascii?Q?vwuFFseoNZqVU9+A2BDW0blSoJJZyXTbZiLYLOqqQjlsB0J/QwfatlXzjA0q?=
 =?us-ascii?Q?FnMG/ftW3aZxHbE/b/QpVZ7QcL8a5P40D7+eAr+/V/bI5JDlTSLDJ6ly86Gb?=
 =?us-ascii?Q?wdsRX69qTzACAm8r2AydbV3VwuUV//oKXQ8oQeoQcqytjVnSHKyHOxBxzm2h?=
 =?us-ascii?Q?6/pK4vVj4fdRC/+tvGQyruvqAusp1HVfxPu2yjHpdj2BI3OgNYXSpiGQvJ0X?=
 =?us-ascii?Q?E1h/N2y6CKpeCWHd4wcqNxRhIugwt0oAGB+xM6BHKjeqJY9rTQcHv3NN818v?=
 =?us-ascii?Q?5bdte9c0oo/GPlFam53qPDTISG8IEz3C+hO/w5kYYIMiZS5paU9UckjuwyY2?=
 =?us-ascii?Q?yX7Uj3DRFVa3qo6aMlPZKz/pY9xVnwDwPz0yg0UjeDBL8g4XrauzQZbop2tE?=
 =?us-ascii?Q?oajUIDoyVmt/X9sZ5nMIaJ+1RadmG2HtR2byoJHlsV/miQ87Io1PG/TZCvUB?=
 =?us-ascii?Q?1jlKG6O/j20fKTA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:31.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e08ab4-1cb4-4ece-4e78-08dd45f8a18d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/cxl/cxl.h         |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 742c03e983d5..608160d3a308 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2702,6 +2702,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index 4f7aaffa04b1..dd2c828431aa 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -893,6 +893,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6a0625476f24..317dc8cddfcd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -99,4 +99,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.17.1


