Return-Path: <netdev+bounces-152296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B5B9F3589
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4047E165AD3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74B207A30;
	Mon, 16 Dec 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g2cbpoN4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187D1B87FB;
	Mon, 16 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365485; cv=fail; b=SrX0YtHwWgdnQWbvHy54LywZbluQpLTJT8YCYIKX5gJ/KcfDSFMpVyMiwP0PAqZ9jIw4SCEZmUecpFNQLhmW8fe/l6kxVWGFYTSTnLYC/E//zWuQVFkpfeBkd+53HN+DUxt6JbUF0sLO1WhjYMhMnYWbqLvOAuLb4BgGJZyPGiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365485; c=relaxed/simple;
	bh=+v38H2SegW7OEOQ5lKH7S0Z4ZVnSSLFsfd8aehfnhPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQw0Mm+7tNqJcUYdpdrjAijiOUHdPgcTL6eKMqr/PfYxFbkAa4Vkl8MaAp6MTFfNI2YEBB5kIONRu6eKUZRExIxNOEPItf6UHao70y7ZUYxXHBI0oZN8lIlVQe2D1oibd9zaIPOcCOv0LqAmNbSrsRjJx7VVvW3O1ENTpGUcsXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g2cbpoN4; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjC16rmAeOCt9S2RI7W5He1/78iEOJ27Qv0Z+8afOFSbtNlej8CM+Y68JT3rxnK7l8DEqRFM2VdsJvgVJPeoHSXRdgMraqp/tp9hYxonSMlyKw2dkbP2/MUC1b3NIqThp5TdaLr9rnvwY6bjdC7RBdSCSoVuq0vkRJq7zUTyvSNl4KKhYLRb6LNULfFe+Fiy7hkdFxiWXEaE6U/KiHVKYD/97sMlyCW4YS4h4FLSU4Hc3JGZjla9RM7nbwlJpOg2hqfyha4x0aLbQWVVEi3Z15xBFUd6OnWycp1e/zC/05PjfDRJhh9D+FaEfNbOxpmPS5pVQSDxn8+0GnydY7kv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEghRWyaPb4yXlv/noHN3U+PmgfzxlcXpQFAsXycdK0=;
 b=LUo226xm4Ugm81WT6klm4VUXDt3pjU138de3Ggnu7ozO2llzevOyGhHX/NIIZN5PvRsww9o/ZErBUJn4XokqdC1v6dgJSEfqHBUsWHugQdxO8MSe6mHMdVPm/UX7+kU0Nh1r1+omrZjqtdwarklFW5tn5OcmgmVbXZ9y/+FaWzYGf+W0WUEYzjLkf1yyHuEtdBOn0XM5hVs3FkmjYqaORUuFbMqLLTiZp/ZfyinlpW0nHXrVWumtGq3BGYb2CLg+RyU5b4q5k7VrCR+T5tGVUXdCpx7r1+olmsWAzBlwK68p+HXiJKoN4SHi6AD+cBzbtNjHHoy5UBoTA1JupBeD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEghRWyaPb4yXlv/noHN3U+PmgfzxlcXpQFAsXycdK0=;
 b=g2cbpoN4mc0CsANfEsySyUn/CH65S3Bmsf0bju4tr+l0lboGgkSaX/tygRtl71wxjwT1N93/vJUhkjZf1fMwBNTmLc/6L7pjI8Xv7ASnT6+X7EOe7wfH7laNJ0t22YrFB15AB2kE1Nw8QPH9l+bHxvlX6UFq5NT8VGQrOlBegno=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:11:20 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::3a) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:19 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:18 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 19/27] cxl: make region type based on endpoint type
Date: Mon, 16 Dec 2024 16:10:34 +0000
Message-ID: <20241216161042.42108-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ba1550-9f64-4100-51dc-08dd1dec4745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DLHPY/gMCSK2Q7JIVpTmUPPCOJz9Hksb0zR/1YXPTvOrpBVN2QWlwalL8NmO?=
 =?us-ascii?Q?EHhV26I1HmjYwQTsl8aT4l5CjBU4ouTnQZG6n9STNKhmBpSpgXLwD0E69NT+?=
 =?us-ascii?Q?zYgerZDxbcy6gAlXctQWLUsLC4UKvID82haozPVP0l8e73hEVp/tAyu+qNVK?=
 =?us-ascii?Q?lnE9lvjCcdyGGtC3tjg358a+zRtDV2dV63uP+54JNHxb+4qEH8RqNklCKe7p?=
 =?us-ascii?Q?t25OGTlz8rk7A9uZLb9tRhkFsGcd3voejzHoOdpcjrQvHAykGseHPqFpJl3P?=
 =?us-ascii?Q?hYcEWXapCWy1aoTDrfog7IR1f16nVvpq9U2DhfYueaVieJ6oKalNRRSD4RiO?=
 =?us-ascii?Q?Oc8rNkB7EiETAKEuLnpo0ZKULe1peVjNfDf2DZ0FZgUXvMf1Zfwy9a/4+D8F?=
 =?us-ascii?Q?OHYCrXhPc9WLtRNvfwKFKgktc7GD77ykKumVc0FeT3X9cTloPrgv8Q3Pph1N?=
 =?us-ascii?Q?61P+gi/EOCU9Ap7C20kWUUevXwWFFNaSzpwcveUdwV0a5rlvrTAVuyTe3sMa?=
 =?us-ascii?Q?3lKOYGDVM0AEkrzMTnYl8oJtuiU6Sd/Z3qz9pYpPLkfKHNhu9H3FeOqHrR3c?=
 =?us-ascii?Q?LxdfXYcDiroPHzjPYUFxRShupfqdPPGrX0h+dyZVNOaXkWWo/X3qhq9tBJPk?=
 =?us-ascii?Q?t7r8Lv0obNCUgRga18iuO3tQHky0/TA9ty/+L/2bMiqOKja60fQ4ZFTQPvNs?=
 =?us-ascii?Q?yTv9jaMwXAid7Iw+Ru8op2x7NzoZbbJMkuv/lrR/TKB85T7RaXM2JPrIm29P?=
 =?us-ascii?Q?kA/YtfNdRkcGqpMuAAmICT1J0Xqzm7+b2FpxgL4NcWfbsFJ+3a3wj+DikOOs?=
 =?us-ascii?Q?OuC/fHrC5Pv4QdzyYKTCfCUx4VkO11sYsvCTIT9uZhz9HEUAZibixxOxcN65?=
 =?us-ascii?Q?nMZR1/KSPAvgbgshk3+haxeVDsBNb6RTNAOapXpNmcQHWm292U0pk5HjcXIM?=
 =?us-ascii?Q?nmOziYgL6YQg6v3G6OX8h9iEljTOj0BhAQl7yytbr+FatU0FFkbRvNJQXBHM?=
 =?us-ascii?Q?PVsf62JkKq1JAHUXvTyRXXWRLgq4/dIeanJXKvjw0wf9nWl7W7Ckcs2iEgOi?=
 =?us-ascii?Q?nPK4JYBdtkAAjEJz/EvgHrSZdmg/Awwrm1hKj5VVXrHBTnZkPBFdgLliCf7M?=
 =?us-ascii?Q?R23h/s9Nk/Lf3wu3JVhPQZOcxz5bWV8786wTnHfZSZkVN4PgrPzsQlghQGY+?=
 =?us-ascii?Q?HCdw4YVMkxYm1KRLsHI8ASB+TtL28cPRBktIms3QvOATsOsRjmoOIJFHYZxZ?=
 =?us-ascii?Q?RIZn7j5Qg+Mavk+flNB9qSdRJ3qkgTQJpG0Npv+LidYQG4K6Pet10JcIZRxP?=
 =?us-ascii?Q?GPWcRy+08+9Yx1ryUdZjgRNqDMcU1tGWa8PMi/nTQBS/pa4FFckmtAc2EjY8?=
 =?us-ascii?Q?RzzOsE2MEP/3w7a+jN+5NWAzA3RMIi2YaN+RD+UsAQXA4zyhmFdQI2dok2uf?=
 =?us-ascii?Q?xuHq3n0Gm8Wy/b5yswMZui8IcawhJDsO8gGdg3W5MGkL8lxB5ViUBpDe/dim?=
 =?us-ascii?Q?/mfbbVOSNaCYmRTDij9/HiUBXd1gW8IqaWfQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:20.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ba1550-9f64-4100-51dc-08dd1dec4745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eb2ae276b01a..583727df1666 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2667,7 +2667,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2689,7 +2690,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2703,7 +2704,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3379,7 +3380,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1


