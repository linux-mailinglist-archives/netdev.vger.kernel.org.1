Return-Path: <netdev+bounces-136683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEBA9A29D9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1E1F22AD4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790BE1F8917;
	Thu, 17 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbFH00Ir"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08921DF27F;
	Thu, 17 Oct 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184035; cv=fail; b=r5MTdjR97Kk7WJ9ProvFpp7Y4KV7IAM//dtMiSpPXl1R5ij0GtsL7nlw7vhB7Dqk4JT3wwavc0aznlVl8IUQ3Bv4C91M7HCu1j3qSO5Km6R/IhETxFxDoFZo1aFEsDoVbuZYOy5mLLr6EaM3iDKOktw8BA62vgZyU/aSea6yDN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184035; c=relaxed/simple;
	bh=kefpFDZNlSjkemGXn19oyGi4AtDjrZ2k5knD5/E0LWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNEGVDLMJsA8/cm22pw6EDktziOPq8M3MUlvDrkeRd7J9jcqgwzIqC8XjV/WL57ZehfSPu7qCTRrUzVd8ld9AxxaWS+ALsixZVZwqeKAxrhMhgfdIfkhbFaYJjpoz/m8lyM/ViLsb/ZsH5ThvdLVE82Zjekp1qNy7CTHFm8cTqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbFH00Ir; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMJOPOGyuIcwluTyfrcQudCgLjgp/QKzeIvBESQcoGg9EPB41OADNNPWbVVqMAoeUVTToOQY9WWhnKqnWPUW2pzRK6gXpKZsGE/5vXcRVqEj2aU3R8InbqERtMiTWS+DCpqw6YyHHz10L1wzeU2O68Bx0YuOUWU9CqC/mlIo51fw//5AColqsrkUI1EiKfpqccqcckQhwaa096yjpM+laEN1G1HZS5iXDvay6iY/rv9pLUEhhCwbcLw/i675scFUwbRwAhFa1ZhaUdAMjLHMvjZoKVISbJu/A55uPzIWZYY12LiVg0+9mZT4NofXa3COnFRohWidS0wCrbWsniGIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tODdWFGiHG2z9NRllRcsnb6U9JgrayQp623lpzxvpc=;
 b=gN7+RXDHdYMlE1xkmT9iF1xVtHt29p3koelwzOsN+HCBZK2nQKYcmcNTgHnnKRDaQEQE1prFXqHE+p83KrW2NafLrh8KrEtnxarogTqo1rZozKIoWTdD4v0v9Ipqx8IH8Gk+3TS+mayofwT5RMcbwmzU16oGn0TFp5VFbgRWxVTUp6RvNFxZRt6mOvUUVJbHeLRJkt5ACRBNUmpCrmsSsS3j3TL1IWhXHopAVF0M+ROooRRXnk20Tc2XBbHDmaDJ/Ks5UE6xtOD0YNrnj58650P3jRXRRd7wqdw9704CBdKs1WQL3fX2zfRpo/hyWLwe5Q5nu9m0OjTOGc4/YPBRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tODdWFGiHG2z9NRllRcsnb6U9JgrayQp623lpzxvpc=;
 b=FbFH00IrOLXwn1TXpbYUIJSUv1MLLNys5qPWHUr2bkmBuDR777YLXuEJxStCFudYkdNUtsgAfTasOYW5dXTsjuX1bw+KuILiszg0G9hS7A1F55S9WQaMka/P1dY2lBtNnXxzeIr66/tDJ5SMmeH105X7JDtmz3+jvrXruinr65U=
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 16:53:47 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::da) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:43 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:42 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 22/26] cxl: allow region creation by type2 drivers
Date: Thu, 17 Oct 2024 17:52:21 +0100
Message-ID: <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb9c968-c06f-4976-4bb2-08dceecc44fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lpl/tPVfZc5Ksj8TZzdXVTkRrQNT+J9xT6pEhakNSMz82X4JTCBp2GQZfvpA?=
 =?us-ascii?Q?nqdVZlbKUiHmaGus08xhD9TxliDEY4tUntm4L/9MHHQv7rnYsih2foQEKaxj?=
 =?us-ascii?Q?S3kqmBOnTMA6mH3qAeLR3J8X4BvCgit8zYIeOGgwNVN1vT2dH6gjN5Mrj1xd?=
 =?us-ascii?Q?TgcEpJ9sXNfg2TNc85RwPyjKKwpkDqw+krPrNxjpZPJXQVwoCP/EKB2w8T//?=
 =?us-ascii?Q?K4FvRkKyhvf/K2N2JeNOhe5Mvs+n4uFJ9MznSYU2LKLr1SDdrdn6bwsmQEgR?=
 =?us-ascii?Q?DqjFCqG4s0ddSI5RsAtmOJw57+neMMsQwUDdEu/j9Phug6GAZgRtOmRCE/V0?=
 =?us-ascii?Q?Zx4Py9ppR91rvA3X9VZlYeAIWfZbEIgxvyyfEPdkBMpbeGakS3FY/PDZ+jP1?=
 =?us-ascii?Q?h/8iXLbOL/LiJZXv+SRrfy5/wRZYbGzdyNchle3Dz9uJCb8DxWLiCegNIaTL?=
 =?us-ascii?Q?pU73jMHijqGIX5jdDMD3kil43ygqUt8qBSE+oQK8KUS6Il0yxwa3geTLmsa/?=
 =?us-ascii?Q?JiFn9Cy+PFma29YX4h9T7jrmd5AZ8D3CE5zEXkwi1WAVlHC/51m/ajivwM52?=
 =?us-ascii?Q?DPNBpJUnXxyKW1fu/jlzfsi707z9oFCKHbYJllcZXL04KXn97TbobcXT31D/?=
 =?us-ascii?Q?sCLexK9iK8NVL9Q8S+hz+KC3XNzUfskDRepq879ETHs2KfyC0ECgQxb5aVm8?=
 =?us-ascii?Q?zVsG3QfKIqNv630aUPGbcNdJflFMqNSY2agYT65Eb02GIZxWmlUXMZvCEc/Y?=
 =?us-ascii?Q?5O0fI1mX+Q2RZR5eXVN1aEFFa0DWlCyJsjv23QdzuzuscXs3yPOnENfa3+pI?=
 =?us-ascii?Q?13EJT6YpVCek8Qwzy4fLL96yE4CHT1kO6Zd4tlnUncPelDUtevffKjG7lrKo?=
 =?us-ascii?Q?4TV8LgpmoaYlKwiGvHWY5kmbQXzQXgFdgrUECn303+nQcZvwkPF+sT2t1wHo?=
 =?us-ascii?Q?yhnGydIuXoJFmCpwzzu4SyMbPVAJN0uExWmYgxEU2ja8BuY3qWl8UVRxu3q9?=
 =?us-ascii?Q?Hvjh1wnyhlUmPyO9rqzv/CIANco4AhPIkMjSc/sCeDB7Xm0BvDDFrUE/zH/o?=
 =?us-ascii?Q?OQ/hRIR+/VwI9xI8fN7nMHFt2nPolBN/pmWSbFnROJmXBMERoGyiR/Q1pu6u?=
 =?us-ascii?Q?yeEiDfm2k5btpJB4O4FSKo6MT7LwFLSWo04261Xn3RS0B8BxN2MU6akk9o/Y?=
 =?us-ascii?Q?zxC1rBQh+WxjEYT4WLzt+vW41/MQ4JJgDuH7BNuK9lN1nC9zemwsHMRhZxPw?=
 =?us-ascii?Q?5s1+/CLf5iZyOwGQr8h2tQ3ykIDe1NV+bxivcro1HDr8IBgRFjJQRjovoCEm?=
 =?us-ascii?Q?OWFno2TRv+QebJumcBOWKCkya/is0CQN2BVXZz6ltyn2Wb7Td6kWp0N01oaC?=
 =?us-ascii?Q?c/mVgCZthJg/sT/YJLF8Hg+QNcgY2ByXSR47j20on8zGXoT9wQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:47.6979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb9c968-c06f-4976-4bb2-08dceecc44fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

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
 include/linux/cxl/cxl.h   |   4 ++
 3 files changed, 138 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d08a2a848ac9..04c270a29e96 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2253,6 +2253,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
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
@@ -2781,6 +2793,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3386,17 +3406,18 @@ static int match_region_by_range(struct device *dev, void *data)
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
@@ -3405,8 +3426,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3416,13 +3436,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3445,6 +3485,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3462,15 +3503,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
index 68d28eab3696..0f5c71909fd1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -875,4 +875,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 45b6badb8048..c544339c2baf 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
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


