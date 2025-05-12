Return-Path: <netdev+bounces-189833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C66AB3D43
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C743B4AE2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B62512F1;
	Mon, 12 May 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpjCmINH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20129290D;
	Mon, 12 May 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066305; cv=fail; b=gmsZUyzaFg2jXwUOp9vFBI1yv0adS8HqZF/JCHDS581eSj3/wdXraDSACBLn12ybanofrAosrQhRTDms6zrlJej4mlGcL/3O/XP/mSUqPDD3p27cFd/kvCavCxsTV3qfpEVISjhLVFiNDjXdIP5uqz2BhFQNMbIcz9U56OX2HD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066305; c=relaxed/simple;
	bh=xltatIUx260dyAz/cyqSrf8HlJlzBoQQ8zaBC/vCs7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3ZlWiY3MV4KRa1qelCJWde7MFsaV6Ce2LcABtMJq0+4G+FuOs0iw7wTNlLNLVykVOCifUoDcbFYHEKdzb/1x6x3H40VLPjEYo29YRk0OCK7YyzuwPJpq94uXJigzX9M/h1LXHhr9BhNSQWBJ1niJuwMy95FkTzHWNLz4gja5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpjCmINH; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eog1/j5zKNUPWOtTddmPufZn1zZS3cf4gSm35sHrBxGnHtJc+xwITaR4XaNMLQCKXCj4bdY337a7XTxgR4rUJnNhw38qvHPc7iUSQxuyFPFVRsbsXJfzC0xh7H+jIOW/Oexpw5gAn37ZPVuaf/fhwj5Dj7XXY9Ch4PvSCcvIQTG0vY0snbYEpOFwa+FGePPfJUaqwIlwEsyfVTVc8XWQj1BHMG4qqchdEvFtHOy74fstyGsnSzlHSFjU5ZSh1vxnG4uz94hF68g16h3YD59ZjUIXWzHP6ZqqZWN+MUxaJsQhmnQ0WGROAzgCDc/jghQw1Thlq1mRFeGXXJ4n0XAyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlSPAvLvsXnpipyJVRcUnOuomjPQebJ6gec6ppKdUMI=;
 b=q0kYb0SgVeAjAfsaK4YhlWLDFFda0vdmigUeCUstxf62yoFzzYJciuMdxxwy+3TmGVFbVlc8f8hu5iHdR1ITM65hlWQx36j4SSJeY9lha2UuB2HUo9BQbUGIVocTZTQgf/uuQsvalM4KbClYHkCtKM6ZvwTMVrmLOKEEAJiju2I1jLGNZELqBaGnotF37uavXjAlasdGhFKmUZ1Zqu/8Xty09zJP7fw185JzG0BAa9+HTxFnxbiMZPqHBCqXxcKjRdcSif6CuuYdS6pJf7fSJwVQAsmWKb0A6Ie8x47IPpSZNr99ajp0WMh49b+qGOSFd6UY0eyorI/iMNs9cnwHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlSPAvLvsXnpipyJVRcUnOuomjPQebJ6gec6ppKdUMI=;
 b=KpjCmINHAw9i3kvqs5qsaFn+OBVfXFe4r7Hb2hAgACFQN5TEyAKjCBFMyG49Q3CeE2hiUxtfARmAC+oqd1kSvTlRSd1ZElUMoK1zWQKdbmvpvYVp5VJTs8wqZSuYikdTAI8OHTMxOGqkJgn3ld1YQxME4UdfKe91sejd2HcjMXg=
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 12 May
 2025 16:11:39 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::e8) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 16:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:38 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 21/22] cxl: Add function for obtaining region range
Date: Mon, 12 May 2025 17:10:54 +0100
Message-ID: <20250512161055.4100442-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 035d4742-db31-481c-d9eb-08dd916fad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PoBdMhfVFBPcK8eyt6DeqXwwo+dzEuSn5X2/d9ZQEn18bgruncdoiREhoDW?=
 =?us-ascii?Q?6We1N5cA1v0qCvQ7q26cRyihQBycToKIBwHm1EAg0STOxXRYtuaen0xLCAMD?=
 =?us-ascii?Q?z56oVK4XQhuq4TVUs+UFpBtVCSmk0GjGsRZovREkP7/mOjac6PrNQ8kAyY9M?=
 =?us-ascii?Q?xTkO9KHoTzDlejYLNzzTbKliLyNwwCAA7VEP0+2Cy5NCz4UG0cFGF7iE9JEI?=
 =?us-ascii?Q?jZdFnszdZFmRgxUl8ORVurSmg+97z4ynXApOHo0aPvurODjCTzkPLrDo5K6C?=
 =?us-ascii?Q?DGUB8XATZrJiXxUBt6TGfxl2/ndRXxfIve9m1ZnXMvwYn1NCl53FODgCdoQK?=
 =?us-ascii?Q?n/X3s9IDunGfqRhS0GfgtwajnKVi7pGWVD9xooEmmXMxFla9Nzd+hhsU2nE6?=
 =?us-ascii?Q?F85IzHDz+dmUaSaLfP2i0VU9Mzp0MkhsQbt/Mhvr4tUa2wLp86ahOgzR4O7l?=
 =?us-ascii?Q?ZypdjLODG7HBSsXhAsXKy8QIGGxLra2VpicBb1Er4rfhAftAw32QO4nFQjBT?=
 =?us-ascii?Q?IV+9DMdzHXdlDXDU8OuqwQa1S/6Ye7SrgQRGlb+KS+nG72RXyQOUprAYRSyV?=
 =?us-ascii?Q?jDpfbokt2h/qqetwv3UO/zctCVKjNKNA6hrVMquYRhlKkC0T/9ifakpmanSj?=
 =?us-ascii?Q?4qEygGZfhRu0qJJ7q82n+K2hmdugoluee+bbrAYRZaUQ2ZCxHaRSxR0VSkbZ?=
 =?us-ascii?Q?jfMMWj2+hFMrSIitNVbB9HpuEO5n2lC6w3/ZI8/w72XWG/sb3qvJM5L/1VHq?=
 =?us-ascii?Q?AnBxgewMkIR5w3w9V0CUHvKGYWfXYHTHLU90JP6aT5dAdeU9sncJ1lwxLLB/?=
 =?us-ascii?Q?/dSNHXiJH+Tk7VJUO3BpFRpln6awyaOw97UmY1CZ4wDEnXtTE8vhfQ9kmEM8?=
 =?us-ascii?Q?4SCZNjDLJtCHZ9ZDnepK79wOP6BF/SvNrJ16QSWAEieixmNZzNqcdx0Z7KKn?=
 =?us-ascii?Q?ko2nje0yol72WZQ6yr9TbVOnWhH3lQ1Jvh7s/x5upabxdhiuUbAfmg668u9i?=
 =?us-ascii?Q?WPy+SCTMjF3NhZxSriEYsgf31vbj8qGUjix/qp1GK5ZDPMZOQ1vhc0BKWSZ4?=
 =?us-ascii?Q?uEKHOUYRLrT114OV4uMMhV3uZsW6RV2zVTT8pTvBsECXuspy9P3ycDtHUmna?=
 =?us-ascii?Q?d4KPcqz0jMPnNbPX1jVn6N8MENa1To3Uh2X3sJh87535ZjvRbwCvXMl87Dx7?=
 =?us-ascii?Q?aOCZhuhVfqXi11e2472YU2a0JT4GR4ZlKM320wt0Z6eptRaAK1VnfAfa6aOU?=
 =?us-ascii?Q?+/efbuZqTScx0NPRWhHau7cUih02q+HiwGMGs0AxLDe81xlnHpQ8up+wvfO3?=
 =?us-ascii?Q?l+VJMLkxCK/jDR6f00qwIce8myrO3mcNOy8/xKA++jOcxfo27jw0eRc9qIrr?=
 =?us-ascii?Q?vZI+oNovohetgIkbT98qH9+0eHnHynTp7QVxknFvfi3Iy3kbsfyiH8AVt1Yz?=
 =?us-ascii?Q?4kxAJgUPsKZQabE5RDtX5oL/HWK7T5u295AIsbu059WFCjcaaGpWQWQRHoaY?=
 =?us-ascii?Q?cNfgfd+vs3YnQ5pa0ovNkR3urhVtZOwHu0Pm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:39.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035d4742-db31-481c-d9eb-08dd916fad4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

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
index c9d21d95ed19..64ec643c2e5a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2745,6 +2745,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index c93b2f37a4fd..55442f84bd55 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -287,4 +287,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


