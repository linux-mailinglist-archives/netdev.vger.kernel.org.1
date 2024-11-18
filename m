Return-Path: <netdev+bounces-145960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0E9D15B1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A69B2A4CE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AF1C760D;
	Mon, 18 Nov 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i/FCNJ8n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF11C68AA;
	Mon, 18 Nov 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948324; cv=fail; b=V0cuYBBHT8CsEcF55+0QzecJ/Kl01ZmKwUta1ZAaL4Un9Y5xFZN46xE/a11pPJ2HgwyqJQ1UK+v2JQYEVtxDYbCUUQel13AH7CoEwneYWb3yXskcPAlOJB1Eo8s8vabBRLrDIRlyWVP1mPunBWzqZ3dCS/aqbZb+INI/V/6yWE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948324; c=relaxed/simple;
	bh=DwP6y8RWb5moHVa83bJ5+Tm4mVdXtGl1aUflHQKps+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwGLTR60heLMg1OAQ7n6NU8WBZBvu/0wQhr7DhvcGmcvTNOlfTDVK3Y2IYcE6DnpxOSUmtTDLY7K6MkkErA3xeeezoWY1SbcKX4uq8QCe3cqfEj2HmId5nXEhf2z/TL9G180lFLsaEDVSKCCKr9VCIQRGrcBhlnOq47flDlCTbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i/FCNJ8n; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4VG3yGsnKmpqia7mZ4auXLoJTBnBKiAF6se9r4WPCYrDfKqcCMuBuY+3ZsjbJxv64evqVOpmMWIjDcsTI51XLcLrPnK196zkK2JM7yxTlqpbASO/wVS6mJdxOJBv+dtyPZzc2d6Khcuh2yYPpcDwFJ9dDGIPZt6JsR7b6fyXzNRP3mT2prKjaP9k/MAb+o9cJcbJHPHdLlNeBrY67RyL2BicKmx8ti8msp44SHVvYYFh3pHlbj4XLyNtD+KPmmGEmqhEge/KJxVc+dg6H9mf7Qq8yU7YsoLrRrSYZFn5+xMcL86zTh3Y5VgIJfcjYim92YrG9j9RqSxuuj184lXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p9lH+IX+YpnXaSaZCNqdSkfMoAIr2wwDfyW3mUehK8=;
 b=UTht5lg2qtFlqd6xpieqoyzNLyZa2NPhBb6//iP/E1TubTYhumK+F1WDpC/TGP7BaRWAmkIujx6edNlyzuh9/Ut5GxlB1eUk6gz/3m81WelLnSwi8hWnc9OY3/K2+AWm9tcam7K3cZZD+tG67oXjS+WPMMCR6lg8bOJ/FFulYXv2wiOBBX3n3dZoYei32bhBdcqFJkO60LSMDfBN9K47rqR8Ll79cFNB3KimXOPYuNFb/PXhYPVBagE5wNLENL+DuvGSn0lr1DolNtBthtPZn872KWBg1kDl3El+Z8A7uYfdVfyi8BXl0iU/zik6fEn5Hnf/8c9ZDUHBf/pQCcb8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p9lH+IX+YpnXaSaZCNqdSkfMoAIr2wwDfyW3mUehK8=;
 b=i/FCNJ8n0u1GaaOv3y6snZjTCkYpvM6TRtvBMoHYC+HGyyaVsrnDvqs5VmUkKagHibXxiGvAfWPsHJlS5ecq1TfBOHuD+Ck0xQzCB1hNggXxSFQtA6Oj7/fiu2fe4sfjBgC1ZeJGaOjSYqwChBkxe3i1s/nsyehW9VtcwJICwEY=
Received: from BYAPR06CA0048.namprd06.prod.outlook.com (2603:10b6:a03:14b::25)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:45:18 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::96) by BYAPR06CA0048.outlook.office365.com
 (2603:10b6:a03:14b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:14 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:13 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 22/27] cxl: allow region creation by type2 drivers
Date: Mon, 18 Nov 2024 16:44:29 +0000
Message-ID: <20241118164434.7551-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 373292f2-be67-4e67-e0cd-08dd07f06291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uWDdDo1XYlrUFHt4UvwktPGFkjhAAOvj4S4hETXpFh8uuyWDZC0ep0s447DU?=
 =?us-ascii?Q?MNqg6Grh5n7RE0tIM69xuOQPPtOf3FCkiDP+Wj4ax6cFK2A9ouCM2vvU60Sn?=
 =?us-ascii?Q?dP2kdjEgjl9sIaxmDzdyuJjxosObDVIS+MmKCx6fD37ZvZlFdWojTsV/zlFs?=
 =?us-ascii?Q?eHLBfHtsVEoXHtnMnp7IimhMEl3qcHzxqXD6cQE3499o917Yx/qFPIjiyYTN?=
 =?us-ascii?Q?OsGQOazt41Ce7Nl3e4N9FCeoEachUs7VCHkD8vhGxYInsKHG16cLCWKSD7yy?=
 =?us-ascii?Q?hCbVZgKjEDtFTQ5SCk8lxV3IKBiTqnbMW1a1Vw5jUqhKOPyip7Wa+RiiNRI4?=
 =?us-ascii?Q?ACK2ves6W1E9kLa5rqfh55jr7FiL/xrRJqwpoN85faAm8XXGuL9UI1csg4io?=
 =?us-ascii?Q?z6kE+EZxmg4jNlRYOwwm1Q3+Yg1+D6KZk1Qw5EMl+Gg3yNFd19tBkft2+Nas?=
 =?us-ascii?Q?tQvjtHwaI5fChPSugQNYXul3lNQnQ/X4GCa1uDDmUC4HxLqEnZpwV2idePTo?=
 =?us-ascii?Q?anrvk38vuXzIWdKEszUkv6w5JHS8TdfymEOcyo5W+ZV/niCkE4VCCjaK0Q0c?=
 =?us-ascii?Q?u8E29/Riw8btGDBv+P43UtaBnap6IShIEqio3/xOJCM7HJCNEbd2kOvyQIn6?=
 =?us-ascii?Q?Jq3iKjfSCCno16UxmYiBcjTYEKcQsO316dPBkghiAqP/giO1YvJBz+4+RjBZ?=
 =?us-ascii?Q?GsThHEYb8SiAhhsSONk/gDfvUUdePrUJETnaF+WahKwTDy9ynnjk6V/BHHXQ?=
 =?us-ascii?Q?QiP//77G8TZ4CCuGMzxJM9m4skMhp4E2gUpAc375/HZAVdWI0pUUWJ5cuMMQ?=
 =?us-ascii?Q?22cw2zdFmvlFH/T8lR7T/l2+7Th1dyQQZMb/e1fFp3AMbL6rRNyreBKH5XA1?=
 =?us-ascii?Q?/1KDQmMVaD27wrxKHpy62KZYhKxjTlOwABsvcBQGYoaZ67jxVRA9jpVrV7al?=
 =?us-ascii?Q?DJt3/AjywVapx5qj8JJUGQgFQBhZW2yplDQUneKcQ7qNwcsYQGYQK0emsPR8?=
 =?us-ascii?Q?IyReyiLosL9V2Ih4tQwodm9qURynpFlXHS7RwaQ8l+8C8aqvxzO2EFYBug4c?=
 =?us-ascii?Q?aVy6TyAZ+SnZxcKwiqpiAtlV04xjhaNI1P0yGEKgk+FcT2m+LS/SIjZUkwzn?=
 =?us-ascii?Q?FSoFyvO1lk19GJYyvxMcLTA9xSkLl4F+uVH+LeJp6tpOTKNrPoJC9iK/qe+P?=
 =?us-ascii?Q?CkfCupuYoxtXD1atcOxVXqRgZgzCbe3UaG4qZDqnhDsNWqEX1m1EdtiRiF4Z?=
 =?us-ascii?Q?EQroD+t0udKiMgm+YwB9c4bB2Q89AsyZWH849un/Dv5UnPwjKkhKQ9ZrckKt?=
 =?us-ascii?Q?CEYPQjyb3zDem13VG9Mso/p4+N5qwh7w2flQtB2dN8NG+QEHzrqRcTMOq0Qd?=
 =?us-ascii?Q?wc7A+HdXccLjRALMlluoN9vf2hXCVf9sK6In33wCO3lgvZWkVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:18.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 373292f2-be67-4e67-e0cd-08dd07f06291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxlmem.h      |   2 +
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 4 files changed, 142 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6652887ea396..70549d42c2e3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2256,6 +2256,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
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
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2770,6 +2782,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3376,17 +3396,18 @@ static int match_region_by_range(struct device *dev, void *data)
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
@@ -3395,8 +3416,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3406,13 +3426,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3435,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3452,15 +3493,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
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
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4c1c53c29544..9d874f1cb3bf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -874,4 +874,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index acf2ac70f343..ec1f0cfb11a5 100644
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
index 9b5b5472a86b..d295af4f5f9e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
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


