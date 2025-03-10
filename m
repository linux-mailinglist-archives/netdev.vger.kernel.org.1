Return-Path: <netdev+bounces-173668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF100A5A58C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EAA7A44C2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FA1E0B66;
	Mon, 10 Mar 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wCtIAjGv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3881E0DDC;
	Mon, 10 Mar 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640661; cv=fail; b=jMD9Ok971WMLDnTf8tAK72743OyBsmua6EbefD7HCjaA1gUDLHGPXQNXPXW/EPctKF7msPxqadlS9zr57eW303zg14JuRUlVjn5g9IjBQUxsGKTxJMyfHX0EjS+EUyyuHMt/mNKy4OFzXBnH2a1w8UiutdiPapQR8H3ELJQFibc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640661; c=relaxed/simple;
	bh=sR+14ybIyZVzbbjTCuBTepjhWmI/GlNzCLZ9e01p09Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HL9h9fH2Huf2co7ht2qEw27517J278+QEbSSkeqBq7HHcBC/A1jSGQOUwVA40iIMakwfU345iyt/wUNfxXXwzLh6JQsfXdRAq/1OssvkOAtoWgM31iyY7+y14+Kaw9rqTUlGwlDS2YYT5wg2hEnOsQSV2sbKeR9afm4u20TETSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wCtIAjGv; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1f5ZC3tj3tXNVOy4pTYNUm7Vj1XtxFnPstQDcZkXEJWFgkqDacGeZNrFvTJ3Ytyrzu0eZ7g7CwrVDN7e5EDOtyvG1wW0oGGxNc7poqEtt6+gZwEzOZuhz8LQijDY1EqG9sAgbQbJ+GpYCq5Uwpr69Pfq8Hu0ni96pK6iKskN0J7d0fpfpNr5FyQud71ElIePBAJKu/5a9ObdzAp2mo/QZ5ltcdvI9RjGO956IIUalEOiEdq6LBMH9DOr3QdJykWsOJts+N6Gp1+FX9Norj8NKWRyM9jaT4wamhFG5V/Yj/cS+AHWESWWjwYmxk96P7ZkCTkTRTDX9yfKgtQ/MXRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgsAi1r9TXirQ7DkJWv23WDFltD0S6qrblQqLq8HlSY=;
 b=O8OFlLk5GLYxFw8e6a6VmxVjOEujLfv8kUUbAymAnG42hG51QZXVUeaF0xa8Hfd8yiWaXlHQ87smTFk8yyZuU3Z1rKNEQb6SYpco6s1yzv7qggpnLRaWK3nlR0NnUl8ua+cFtJR65HyqvTaMUEo3ek6wWMcIAMEtiAvN9eH1HDt9plMCCstcb1k9BcOuaeMi/S7n/Az5HKQk3RpawyXY79yQjA4VbOVfIpqhWYQZ0yfrAt/iPG56cTrOU6RZh77zEpyZO8OulxoDJMn/yPyH/X3sEbM8NyY7alZtKfkt6XcoCcDMQ1+iqUKx23V5yQw0jGw+ye94m2rX1denGgtANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgsAi1r9TXirQ7DkJWv23WDFltD0S6qrblQqLq8HlSY=;
 b=wCtIAjGvz5jC/UrVquR64hG76nhDzGdG6Kha0Fbhwfe5JwAKf7xu+wMGekQNyW/KqEv4z8QEVj3fHVp756qBpCAuDeEQ7zr7H1Hz5eM1HkIQq3HuJjF6ocSjGiSiJ2MY7nebzC/wqqoIxNaJ2qqMYLE2+9Awvj7AgdmaBVmlnAM=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:15 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8f) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:12 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:10 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 15/23] cxl: make region type based on endpoint type
Date: Mon, 10 Mar 2025 21:03:32 +0000
Message-ID: <20250310210340.3234884-16-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b910ea-2b2a-415a-803d-08dd60171d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ylLV0qGUZZ5JgU5PtopUwPQLHuezKs9NlZ+kDxmnC175rj1UHTDR+up9QsJ?=
 =?us-ascii?Q?T785L8YUBP0Lpt1+O1kbt27IwTTqZxPlGeXhcJXbgxfFWKXTrMJw6VP/2sB4?=
 =?us-ascii?Q?zDOuHNj52sohl+5H0Ge7bqrtxXWsP+HoQ5K7y4Wj20zDONWSS/ToMhIXJyXp?=
 =?us-ascii?Q?o7IJvZt5pMSdAMfCYQFa2xa7pvsBLm6Lgqk2hhvo2cRpKo1VSo0R20IKQ8ZU?=
 =?us-ascii?Q?fG7PYhTxQAZ9SWJcERbbDdS/R9PgmuGs37BPBMpOHKI50wJesykRvX6r8khc?=
 =?us-ascii?Q?96PK8gpKBZuNvUJ4fQFccdxHxeBS1cpqFIpZdVYvZ+bRT1RdD4wW4gOra+aQ?=
 =?us-ascii?Q?m4R55M+xnt804BSKuVlT/8Lvcaq97c5LT3uRPW1URRE0eWnyvsJvJ3h3tgkS?=
 =?us-ascii?Q?NGijObFP4LV4YLPXOUgwrjGMqt84FeYZUDQ4UIwCSfqG4G3uLdsbHpovz5Su?=
 =?us-ascii?Q?dpJ/foDnZ5oCi9WmiyAZBSMqdzgvFekNcMO7tziYwrFKGXM0yt8QRlKOMm4R?=
 =?us-ascii?Q?vKKMj72e/Cx1DNyh+O7psy3ThOL3OVZAttnz9kL8RbxqmeqGZCq/2l3JUS+E?=
 =?us-ascii?Q?tL5altoy5r8QBmMSnGA3x+A6VuYbxrzj8Pi9aeZUUA7BWG9B3QBgmghbPfW0?=
 =?us-ascii?Q?IXp4LI/VlP/fwDsyqLA0RDN3MnGOQwJl+RnmQZIEa5//Cn3/kyeAdLPRp2KH?=
 =?us-ascii?Q?FXZ6rziO8ZDLZwixR+j4ZKBrfSJVFhwjksnRZ6dAyv9w0kpXpOdnUinKQPWn?=
 =?us-ascii?Q?pbmUheVy8ZN9akcUb2NhQT/415oycRlJyCPVB9qZIYiJ6ATL9irjS+EBscdZ?=
 =?us-ascii?Q?S7khxhTmDv5O4Uhhv0k2xtr+83LpCrE5jBaqs+5q1Aw5WNazj/mu86SNQNw9?=
 =?us-ascii?Q?CnX4eveIZWMZX+P7ZvaesQDn1Zg5eDZNBXlGYJO1taVBH6jqzsmdv11tbtkA?=
 =?us-ascii?Q?kGOpiN1b3M6cS3r0HG9l4q3yvp9pN26IXCdDKhmgi2BIxBeAHBnbd4kusAU4?=
 =?us-ascii?Q?s+XvI0OwdJ43joIyaWE0lBf0d1i66k8bKqU5C7hwfl4vEDcm0O9ZL4VDc57C?=
 =?us-ascii?Q?29zZtDpQARRZdpD4J1/7eYZipXTA9tO9+eqo9TpmJrqqeYmfSXmEbqWLzZ+S?=
 =?us-ascii?Q?BBHFInIz8R3C6GadV6Zqi62trgYMrwKo4I416IHlDLCcmoVVtXFe7sigEG+E?=
 =?us-ascii?Q?Jncmw0LTPxVsiCoYcJNEd0cH3gYYS5ZLWJSROrEqjo3PBrIH7bA6xaiWloL2?=
 =?us-ascii?Q?nHNQxeMP6zPqt9GPU72EYwI7rhHLQ+7yizKVvyM58GRpZTC1tB0Trpmmvfg9?=
 =?us-ascii?Q?33ApOdfCM6sJsp/Bfx6WJV29541ZeQSRt7dhVUEGp5TSAGDFqNM2sebzOxSo?=
 =?us-ascii?Q?5VBKT5gfidC8dvoVJYGZHh9t4puvUltR2YVOZfylMprCFPDYU5oz4vSEWA7t?=
 =?us-ascii?Q?ZJDE1DXux9I116raOPqUKkLogXNTlaBzfahXoZ/stGb2eGz18cFdrF9cezy1?=
 =?us-ascii?Q?DqNb21sToiZjMOE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:14.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b910ea-2b2a-415a-803d-08dd60171d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ad809721a3e4..70e3f49e4869 100644
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
 
@@ -3522,7 +3523,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


