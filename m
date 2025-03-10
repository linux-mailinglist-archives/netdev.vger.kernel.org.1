Return-Path: <netdev+bounces-173674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19568A5A593
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6A3189388E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67111EF37B;
	Mon, 10 Mar 2025 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ocTANGW6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BF1E22E6;
	Mon, 10 Mar 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640669; cv=fail; b=fVChFTJTzN3emLdvpjRSC87ziLtEfS3b8D67QYJlT8/wQtbTjJfFjI1UPJCzrG+L52K0E10oh1sCQs+8d6W4bm+k2Zco1GKT8L3BlV35oWU7h4/0f6RlZnjOd02+Xn6FGsuYJqyNWp63V44KRrKcDa2ux7nkmRobqLYquxAAjK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640669; c=relaxed/simple;
	bh=R/w9EiCuYmgH0wlkckkjEdVEOmAL5r1zCP4MLHfdd10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISjFSvXiWR15PoYJOTVu+IJE6jPGHvzaQbTfWpKgtwV37PbKLE0NZLJd0V4I4df+EeQ84oBnRosaS8Gc58Wqs5pbn963AFVEHNdxtbdpf7WLT7IjYILd6Fw6EPT602GrXq4ns3JSCkoyoNfPQyJoqt9wYy4gysy6KZDlhyO/uVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ocTANGW6; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPJR8ypAqDjNWaNnU3kkP3Om5ZUqRKLOpIabEywrqTfyAtU3ztN2XplJE+S+V9fYlP0nKcGrYJDZQsXCkwgOl2htxVnkT+GLHypNL6ty9eKgZmw7hbZJPzitrkzOZxSYfNRvuTnOJcy5pm0muZHqSSsXNS14YqV5sti2v76EYHBiE6GJVFIABPx957DdvyKla9ocPcQRmfJ+o7yeo6YyCdCWKD7iuhr+sy8cJHNvNWEj+NCOIDS4JhXca5dyFslW4W3ERIg6Z6WDTAvsbktZ+5m+PVGeSaj1lY6ijmFrhbk+CBmegsTzdZxYMHR7lVW7y+9VKGHTFn8AgRej8azcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzo73jveHzbyF1QoTh7XOWjasW24MXMQnL37kNAuy+4=;
 b=oDm1ZssRm6HvYCoEb4DpdfLmFOvF2rWnKqwlVSpHIN4yhFNlusl8uRIvJIC8P3GfUFDQC+PFZUkt0/qGlxzu/UN82XSPJILYmS1Qp+q7jgmqUU4i5nvIL9nuRdXNTiVaIwmOPwJJ9waOGxE9wcbqdLMlpkNy4zve31o7m7qryG7nsgyR8RQ26354vyNpfobomS3u1zErm2cAXTa14x3Z01noJbZhhA+BYWHiqCoHZ5QX9yfO/h39qYBb/l9bcFjirW7RXYc7mP3XPwpt9DxsR5x10aaEcJnaWpVhNhM+yCy6JYOH3rRmQVXjBGzxKmb53An1wzC1mxdE6ursBA8f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzo73jveHzbyF1QoTh7XOWjasW24MXMQnL37kNAuy+4=;
 b=ocTANGW6ltgjoEjuYhQ6NYwEWuDt1XOFPxbjvDXbgsbAjQWW7NPDlHyhDaCgN7OnJnKku/h+YV3s0x9TTDRCcog/mDXloTn9gfdjGRwv5pgrhO+yZ3neLqpmji7mmhPpQFKtvh9v4V96T4VhQlbtJJ+wNGcmHB+ZHhbT4YVVho0=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:22 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::39) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:20 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 21/23] cxl: add function for obtaining region range
Date: Mon, 10 Mar 2025 21:03:38 +0000
Message-ID: <20250310210340.3234884-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dba502-0f96-4fea-9b2e-08dd601721dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/V8iZb9B+IRfyJp2+KyctjYUa40sIvUT0DU4O5HM1MDZvbAU1XhjyaC3I2L?=
 =?us-ascii?Q?Yixx+au7Tx2VGEIUtxbay8Ge9RXH+BH+fu+S00gf1Mgp3Eml8lDVJNac3OIe?=
 =?us-ascii?Q?/e+eA8Gn2Ag89p1jYsLslkdGGlRLIOxIlpXcagr+R/TCrdXD5P0GWhnzWsSp?=
 =?us-ascii?Q?kh7Ci3YTAcmNRGMZWssOrpufDDBnS0BcW4OQR9atnmJrApkxwLf+U/RboQ1X?=
 =?us-ascii?Q?L3tuf8tVoAbPvVLE5EM8sqDingRKHr2fqGf35lBWpVopVKOXjulwUjL+WBQm?=
 =?us-ascii?Q?SpHTXnTUgrrptlj/q1o5IOqWLPFjS4zkkC6SLTphQknt0HIY8hz+sZk+pfkY?=
 =?us-ascii?Q?H0QvUD4Q8GVYAJjZRTws3oQxYIzJV0HC9eCHi7AhxojLwl0PUaMXT8IXmduE?=
 =?us-ascii?Q?L8Mn5hWuTRe8Je8y0lfpxxV9kqZ1FNyorYHFUAeTIPaqBI9ZdTylPooQUT+R?=
 =?us-ascii?Q?XJ0IvmyXAf7gjyIKV21fpVw3drORAbmWgtsGDgrj7bESBzCpYnNfwBXDgFhK?=
 =?us-ascii?Q?lhiMicuvlZEQEgA/3HGsFfGS6VcMYl9TeURGQmRrlaUUBJiln5oGyLhlvX6o?=
 =?us-ascii?Q?EFkHw+G1ZUea4FAcYy/n3tsbnx1zCvZ/PfIqBzKplxw5QVJsAsOUJojDQZOA?=
 =?us-ascii?Q?QGn6m7th3GvpPw/6KoQNqA9+yFbvNSyhX+ohmfvLuTZNfkwR9nrqNooy2ZeX?=
 =?us-ascii?Q?6LbPA8RiqnaHqsqSUxUj5J3fWI2cnD8EUUgp/i2+bulaCiStPT1kOsLsxjIF?=
 =?us-ascii?Q?6+KWspDv6sU7lgNmPTFo9IFf5xjBlm0iuseFcLR75z/PGs0cFIDHc0k9iU7p?=
 =?us-ascii?Q?oo/1g6taew+bArV7XwLMKHgu6WJfuLBRyR0eUB63ZgfuN2g1A7EZiW/DSQzA?=
 =?us-ascii?Q?2LIyIB16SZGRyOdtYTu7D/PlNB3QUDlA9JpA1ibtoU3LUCUzrRdV6uVq0oIc?=
 =?us-ascii?Q?7AhmpBCr7k1a1GnbfbjjLtEEeZ1GgtBbuJf/iy8sXLtB3uA3SLojYOCAzXli?=
 =?us-ascii?Q?pe8lS8GGPdjjWrQjsylgxRMk0x+C02zyxOa7vuyZ7TYJDjABeYW5+IUSoEpt?=
 =?us-ascii?Q?JDwHcSxZCiDO3dMVS/osyPb/Rh3PKHzsp35VeJofwPaan1p9/a85SCHfsp0u?=
 =?us-ascii?Q?Tub2GcvxR49VJVpqybHcjvpb3PMpAUXLddVhrC9W9uNEgEtVPqFxBlcufJfD?=
 =?us-ascii?Q?gPemKpl9c+cVkHsn8YJbCMA+0xFv7fepXNv4wkNd9qgPvfrglGhhfJTKKd9w?=
 =?us-ascii?Q?H2L489HvySrlzpw3Cl9GMfwhsNGDfe/A6rTqM/HN+AbMZr66owwH2K4VBTre?=
 =?us-ascii?Q?8klwXu0Jk5Cw2K3DqgfF5j6UUb+A+UO/jKzdXcKuXcX5PMB1xtENHGfZ/4HC?=
 =?us-ascii?Q?0q3A68hUucTa7ViODT013K/RKEt1/viFcwqnbg5/ao17y/dFfC7oZe0V+VJV?=
 =?us-ascii?Q?hafLehnyUi6efqL4T+T+lkfRXvDUQrf97XfYOGBAeFX7iUBEj3FsOfMu5nbs?=
 =?us-ascii?Q?jNtrnehuPmZPf10=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:22.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dba502-0f96-4fea-9b2e-08dd601721dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

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
index 7f832cb1db51..0c85245c2407 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2716,6 +2716,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index 2eb927c9229c..953af2b31b1c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -811,6 +811,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f54d8c72bc79..8eb918241c48 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -264,4 +264,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.34.1


