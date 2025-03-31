Return-Path: <netdev+bounces-178326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D1A76923
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78BE3AF51C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98034221572;
	Mon, 31 Mar 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PeOCycMh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215F221547;
	Mon, 31 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432401; cv=fail; b=LMe3G+LXwgbcA2lenq4q9Yff/yK3muw5nHs8OGrhjVsZzNGY+Tg+byv5hS/yXU6XAH/gSwjHDCv/jaI8sVaE3U01Dna85Hoef9EN9CC2GX9eu7cv7hIwDie0NMIuQKQtoaHt4FMJgA6vICPIDJg0dbxURJ5cbAQfGkMws63x/4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432401; c=relaxed/simple;
	bh=UiqEptwZI8ywmNzDkXahNoz3Z5a1D5h5Gd3rsFWjX9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBah1ScKS8/Ww4h/kqzRpEMpvXPdlj1cFBtuma4vTm8ryRSBGyNR2H3CK7mHSwEG58NqOT5H7+2u4sW8Lf/6Ew699TZ1LfHIyBiY2ixwuiwEfed/m4DzjWE8TnZx+ruX9rfqtWZJuI0A1t37NbiMRaK4az0OWJP1oKnfzttWRS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PeOCycMh; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv/sQgx1OhTQ9wH6F03r0z+hNrS4mA2aTovRac4Yp99A1xtjTWfdYML/B15z7al+0m+rY/nRzcnsqkSZ2Cbn3lnqpFS8J9vf3+5v/fLTkB+sOit3gj1jU81S9ufApeLA5U1LfGjKuYoE8tDwVGRZEP1ls0QCMh3cJ0Kc2mwsani5WJJbc7cPPmce5bZDWNs6l5DnTroy+4M7Hu4Au2u0NbUQboXcgrWnvumDlZiVQKuqcrn261pw2xcac0c+0FipTcZ6SvbiutePUXIfrf7ynFlkdNLByJ2BYVZFS0ABQkE4NWJmaYjQ+T5J43w31uYKLOkEfK7EVwC4/br/ZxzQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMbKEjgBdkQq0rrCJ3F5dq0LULCVwcBwrdWj1kPqBa8=;
 b=JwkbMoCYUvHH92eFN1k81UyGJRjBW/BN+YkQG0Z7bznSy550Spcy0RoL7BzkMCU0OH5pmsy6dWrPBGd5gRsB9k0xyZfxrayKzAe0muQyFA2x0CALK2WoTEsXu5H9jUA/E6JOF8I3eh73Dti+MqJU9YHr9OG6afgqqZcNgGO9uU6JNeCUDNvHDLj4Ea/qR9mKXaQfD1TAczEC08nlXVMDuQ0Rqr7g6M0J3MJPSih0xJv8516bBviP83HVku2UnvpBem9ECMILn+0cWHywc3cZa4FmNKlE5bEvIOorg7/5mFKMxUzA0r6tlDlvoSUej+b0kLxzw8tCMNqXKiR8zTG9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMbKEjgBdkQq0rrCJ3F5dq0LULCVwcBwrdWj1kPqBa8=;
 b=PeOCycMh9JQ99OwMAyehPea4hg6GO/5fx0vu12yoSwEdu/Bgeq7KCagDoXDtDLKDm8QZVvoPbC0AJhaVjqmc3r6kL0ZKbQjhRXsUSopRMu5J3ws1lcFUhSuMLh3clGZaJlakkT40LcpzjBjd1ZCDJKb7qDX8Ydx9sE8uy0/PLkw=
Received: from PH8P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::7)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:34 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::9d) by PH8P221CA0022.outlook.office365.com
 (2603:10b6:510:2d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.36 via Frontend Transport; Mon,
 31 Mar 2025 14:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:32 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:31 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 15/23] cxl: make region type based on endpoint type
Date: Mon, 31 Mar 2025 15:45:47 +0100
Message-ID: <20250331144555.1947819-16-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec7021c-e059-431b-21f6-08dd7062d49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTL4mLGUA4ckOf/koAdMb2xqlHSKitS+5qgAeD3RpsJSkL/n1FThed6Z+lug?=
 =?us-ascii?Q?P+JWvhVXdmqVyhGBfWyAADhgoOHVvDxAtCJ0rGdJ1URalgeeWsxBb0kYGhcC?=
 =?us-ascii?Q?1hjNh1CpPOZ/ARVxPrcnFOcEg0deZSn18ABwzjyqDChFE/3ZDA56HVH/RMnR?=
 =?us-ascii?Q?ycwKULhSI7o2mM567LBuSX5/SJ/6TmLcYAIvG0v5WP4DsQrE6aJwAdI+LpLK?=
 =?us-ascii?Q?+ov8CRUdZ93FAm4AlwlsFu3Pw7VmUdZNxhK3/vU5KnJezh34lv9at4U6O9So?=
 =?us-ascii?Q?RcH2c6/yr4sFEO5y7aZAY9COghn41BEHa1rvq4co5Bkt+gAMPbJpiKQ/kLLZ?=
 =?us-ascii?Q?ZNaPufS6vdQhTkIh0ercZyy5VyzhcXn2IC514zwmAAXofB31qmG+Vlr3PlOI?=
 =?us-ascii?Q?6K4Y3iVql65fyhloYhg+/VSHwxOGnehlDcxIXCy7jbdUbfdejUUP03nUEadt?=
 =?us-ascii?Q?FyQ+AQ9dP7J/E73CfiS/dIM0zz0gRRkSNkfdF04W27eWtmsToMM9z8kT/HZA?=
 =?us-ascii?Q?3poVAgySnEzMrqQJyf6CIV6bB5J8zt4D83OmeRerSxseNJWNgSxwRvv4nkfH?=
 =?us-ascii?Q?BxT1mH2fklffBso42tUD3GmqVvqckb2h1ML+KEwKodO5NoGNl6l8VunsD9JE?=
 =?us-ascii?Q?lsJlTiVHvOCiUNighZjPZJVS4k80qI/+zbd/qTb4N2g3uSlZbr7VnXsIB3zb?=
 =?us-ascii?Q?xEWmL3R8TNYNwOH3z2fm7dFbJZGTSinZDlatUDtIPk8aVN31yAdqaaIhcn6g?=
 =?us-ascii?Q?sA2HclaXsXp/L+7wPGuKwkFHoc5y7DPhOXMiC7/S6KetpTy0hrVCF9K3lmIW?=
 =?us-ascii?Q?O/W5n5WdH7cvJugKag+w6TgSootHLbZ5ZjnZBOScD+fQYxV4ujQjBdeyL++N?=
 =?us-ascii?Q?SFCckDXVhZvWo/TN/+XcqrXWqhiwTjcLnrmpFS1MszlbTcV/ZvAYrX17NTDV?=
 =?us-ascii?Q?MMDqKbJRh/ack96QF5D9jOR8nc17JUVMrQIZlZOgORoUmqxx514oztmvI0jo?=
 =?us-ascii?Q?xSokUuu7aGTacA511M02EctTPOfkwGZ8ZGvNqvRlBukDYI6kJsq9j7NVRpZT?=
 =?us-ascii?Q?W3t4VSLLeh8GslpYhGkiTxAvrgqugq2TteGeQCaKyCLAl1kP4BKMF0LOSJz8?=
 =?us-ascii?Q?12jAYVyLYiacw8hB/YYI0SI5U+1fbqw0f1lxXlL/oC3LpkL6Em4xsdE8odq8?=
 =?us-ascii?Q?O1GFJmAGwpp6IGTbgiOqIckCORDt4jtC+P7IR5iScVZQCSOU/NrrDz18Xxqp?=
 =?us-ascii?Q?KHNkbkZnUzDz3HhSes7uzqIC+BTT0KGn8ZRfe4tFQxWS0CvmxRXE+UKA6MiT?=
 =?us-ascii?Q?qs6lndu04j9sbH5rZ/hfbPJ1UXQIgZWPV619+JSF8NzUNCiMonvsi+Y+VXfj?=
 =?us-ascii?Q?EoN8kaNl8SLpvdUWhxfxVqQnOg5LEHa6lYFVIfEGq0w4ua2On3sO4/+XKfnD?=
 =?us-ascii?Q?tIT17AYKd0OyxlDCN+n0b4lkuUgYzQuCeS9wgf9rW2WUeaXozZ0QpgUmPWMa?=
 =?us-ascii?Q?JpYxN3oOjopfHrw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:33.2158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7021c-e059-431b-21f6-08dd7062d49f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 59fb51ff8922..ad63fc7b3ca8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2708,7 +2708,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2730,7 +2731,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2744,7 +2745,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3516,7 +3517,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


