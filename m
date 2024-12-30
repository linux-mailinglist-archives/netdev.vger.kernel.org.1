Return-Path: <netdev+bounces-154591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE089FEB28
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F318830BB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701219EEC0;
	Mon, 30 Dec 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZB0WTvxT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207791B423C;
	Mon, 30 Dec 2024 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595136; cv=fail; b=TdEsxnn5zzzzZmUrQEzyWV0fdorNo+oKuFmZodiS80GBtZMKwztNhogjSedYfCgCWZASyprIMidZKRyP6OB+Gc+MngSZiOcQOqL5WWOiXhB5iwDQ27YXXF4jvjJ3PlZsITQP4qZAYm5HzfiBgpLY5ZaU4zwif3hwBujY181wSvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595136; c=relaxed/simple;
	bh=eyJcc23jNSpHDKmOSFVHnDi3ughMe/FqEL0rACaXzhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEH5KNFGd9UBZgURVvxcmmsA9XLSg3RfHpRAkPTVURcOsan6EpS8yIIcbm90J1p2MvkllVjuGeNFWVXS2bcZBQryDbL7AVY9uiQK+Zsp17imoNHje5BerrC03Qpdrwdxlm0G3L5r+NxwiFQZ+l8EPea7FugyF+SO00gmrpvfpP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZB0WTvxT; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytnJ9B4Jq/P+mjSoxCG4W/apbgkEvXx9OJXgnBgdMe8G6V9koB2XVB9QHIQxQZ/mIrHLDmPSFOES9dpcNqYzTVRIYbzF2QunFOZN991ymu8TC9bPkwKKrV16QQPmWtkH+zwQekGLzgICq56wwuUEUZMVRsPEGDHNuiJVVRMxnkTzkYl9HWLkkVEOhKhjBAgO3zu4CaGQpQhr8Qp2xY6IGP6wrfSLyim72NE3+1u2odnyBOTRBCt2c2CRPsvyZvnzV1uncbEZ8hEGOQc9qkR7ff2fAYa01VPzy6cS7YE4X4zhMRlFTNe5XvHV7ya4d5beGvH1DTQf/gMOH7WldNEEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRp4l1kcXefOUGSl/BjXDtZa+Q/eIV6WTnfQTCCDjI8=;
 b=BHLCuoBWL1Q4bvsd4WdnQRCHfolNv0UIRZxb5Prk3FwNsq8TuZopU1mrKhh50M4ZG+HTFTG9NVU8LM3JdqNMWT06b+a+4BwHq14tA8WBpLbWq4ouJAdSBMUT2rUWWPe88pFHwq8l71F8S8ZoxhZOqJ0IHQltwMzNo/CiywSSaKL+wsLSC3X/LpXG/aSuljUL3QKqatRNOL/BFBcU/e0Gv0f56A3yKx8nNf4ZvzWs1hqNs775d3wYIXFNvYWO1Ziymw9I7DX1Ci3Id8TS4tXTrXi/ZCmqD80nh/9KY94X552NX0r97UU8o7Ud+fj6tG/+cuUDUOSi84+dTr1EuZTQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRp4l1kcXefOUGSl/BjXDtZa+Q/eIV6WTnfQTCCDjI8=;
 b=ZB0WTvxTABeqaR+tmxecV7g39s9SNK0+YTxUV2xQnszkmDEoEqLo1P7moMfgsD4AnD49P4fIZC76wvw98rEOieH1Na+ASxCR6h3qz8zIdlAzQiWjrg/eMUnly2xQCvjCV5elaRcrQ1I/4vPMM+lzH1y9AQqWwmZ/hNZjQ5T8R2M=
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:25 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::a2) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Mon,
 30 Dec 2024 21:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:25 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:23 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 22/27] cxl: allow region creation by type2 drivers
Date: Mon, 30 Dec 2024 21:44:40 +0000
Message-ID: <20241230214445.27602-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 51536f40-aee8-4c39-29d9-08dd291b4535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQfbXYU2x/DcN0pWTHVdVFADvzXYpF9OMcr8xBkbfPI4u+8j+X94tpeDS1/V?=
 =?us-ascii?Q?Y/od1tVBAL6xunAEFRL98f443xWNE8MxkUephbTqDKHABwxKTEwTkUr/Rkmz?=
 =?us-ascii?Q?Kidh/SuUHi6dfIrgxw7tKrt2OFcqjLZBGL/dFosrNyK6EA1N0NzzuHaEqO0H?=
 =?us-ascii?Q?BNlRasKUQ0NLQlPeEV3waCmsNmPWT/3o6dWQxWPZpiI0HUg6R01jzrGcBV5a?=
 =?us-ascii?Q?ndhIlgPBxNl10ADEWWT8cJpcA5WmKS54Mc8s137l4EJ/SVWqWu059W1LUrS1?=
 =?us-ascii?Q?ADQPVWMxlaF8ggm7dlFR3+brpzlUJQEHglVKB8GwR94kjZmLtxC+xVA1nrGN?=
 =?us-ascii?Q?qyxZDTiU3+oF4aVsy3z9sLQ5IDpSjqltPHsdOdTev26qTrJTwRM0dA+TlPaU?=
 =?us-ascii?Q?YlHRh+8BIvRwmJc8hPNe0h2Ih1FZbK8/paZqciTkNGTKTUpjkx1CjrrQQ2MX?=
 =?us-ascii?Q?w7Nkm0deeZMoOTl/mtS4h0QeVzEhpyCVPzwjNhZELy4W6R5rahwZK2uoxuAq?=
 =?us-ascii?Q?7vcz7tHwU+7ALXK9OnrIuMa6+kB3npagoyY7mCFKFvJqk3kEqMTHmL58+hUm?=
 =?us-ascii?Q?1E0p9f3VnUd7+LEGOXP6kL2LSSSUz7FX0D7LQQxDePkbS+mEJGK/BXLI6Fud?=
 =?us-ascii?Q?PWwHmCpUitRHhwjRIXfP9H2RyV6fYKnQak5hX04fi4M+xhwkNT/OgH+xtEyw?=
 =?us-ascii?Q?PZUyRfwIeAQMdnQc3Ws8h5TIxJN6sbQ+d9v7g+7E+gu5XfedktvSWBn3nDFP?=
 =?us-ascii?Q?u+V02/Q6asKOgbgJEayxoVtz4nHn86pFNwgiiLwVml9JowNwrE9LK7YZHjFZ?=
 =?us-ascii?Q?e+z39M9ZuoLmbcSi1bsSUFFRVCznc8DdUcRrrQWa1zfyfmCTrJIJJqF9RuiK?=
 =?us-ascii?Q?2S8Rj8Uq0KuXVQFTZilZYgUHratJJGtH5mPj4gedELDHxnuRD5d8TurrRswx?=
 =?us-ascii?Q?wwpe6wBTPB0n3pcWPzfqf+CaHXSkFt+qLRmzy9yn4k9iRDk0VZr19O6leIAa?=
 =?us-ascii?Q?rt3tRbvB8LkGKYczKh1T+KB8Nvp8sOjaPu8yBLsiBJFsIpQf5XPWavbFJC9H?=
 =?us-ascii?Q?B0W1AbgKmT+GvZQh+9eZQyNRdadhVXhITOA+CMNfVfmvrKNY96PMZaPcHUy/?=
 =?us-ascii?Q?uqSEwq2W2cVHUdYEnoQ90TbPTtRBKL1B6JBDi+3UnR3cnm0n1xrjEf6YYGci?=
 =?us-ascii?Q?/5DHq4j68XYFAxnaYyw1MOwxaPg7w05JdykcwdRMh1vFTebtqYPDFFv7PxmY?=
 =?us-ascii?Q?z9dZf9Z+H0djBCOOmop/KnNHKD10iajXfuVKbDvZo/meOsT0OtL1K8mrnTAB?=
 =?us-ascii?Q?syB4UylNt4PYJCUMGqubC8zK6b5gOFkqzk5iDg+jAvIXgbuTeyMluqdgImw9?=
 =?us-ascii?Q?OANEl8jizXkwA0wIVgkxioFyEpVWYnY3BhqCIOJIVQg1wMBZ2S7r9fhcIElm?=
 =?us-ascii?Q?FYbJPdbW4unBGFqaWRXB+f4G6w5+hV/H0ALLWljFDzkKAgXEqV3QbuAt+BfO?=
 =?us-ascii?Q?HIpTn35OzPQdLVM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:25.7821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51536f40-aee8-4c39-29d9-08dd291b4535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxlmem.h      |   2 +
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 4 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1b1d45c44b52..a2b92162edbd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2270,6 +2270,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	down_write(&cxl_region_rwsem);
+	cxled->mode = CXL_DECODER_DEAD;
+	rc = cxl_region_detach(cxled);
+	up_write(&cxl_region_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2776,6 +2788,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3382,17 +3402,18 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3412,13 +3433,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
 
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
@@ -3441,6 +3482,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3457,16 +3499,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
-
+	construct_region_end();
 	return cxlr;
 
 err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	construct_region_end();
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, 1);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+
+	construct_region_end();
+	return cxlr;
+err:
+	construct_region_end();
+	drop_region(cxlr);
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 360d3728f492..ae024ae8fed8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -872,4 +872,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d2bfd1ff5492..f352f2b1c481 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e05414e0a415..d1264c58f6c0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -63,4 +63,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


