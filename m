Return-Path: <netdev+bounces-183934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D54A92CB1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41C84471B9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E553221F27;
	Thu, 17 Apr 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AgCx3RyG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B44220685;
	Thu, 17 Apr 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925412; cv=fail; b=t4aTplNMSx8p7j7X0FR6LXN7HM69ClkJxGYh7qhFx9ax1KzlT4JDA5K8h/nBCEavka2qCk3BqZQFhflqpPfyhO7hj69Uhx09oY0oxRyn7n+Ou8IL8uMu+pRO9paYtKyQ9q7+nOjbUIJqCURzNQbcMJ2J1k8V5/+GL/iwHkYOtzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925412; c=relaxed/simple;
	bh=KULIJjirHZtegwmi6PtxbeTfhhAgJcaXLmOrUpzTGMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9aytreIX00BLmapD7EqRku/cajnh/j9hTeFCcJnJ9S72UkEOHHKq3Y4+VCSpHg22fLNejDUZq/OwQyxO0et7hxYW5Na5/2NLLuyKs4RJ96AlNLgpsW6l+nFolaEkDMLd0GHf+jxO3lhz4pckuew+5XWm+z1ozFk66xB0ZldpCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AgCx3RyG; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg0zu57U2NU3rPoGKOT89ZxATfv4NHVc0Fkl6XRaF1mjtRUDLlXzNR2Rc52TZdHcvEBk88A4KMHY6MVxHyoqyLEwJBeMsuSPThc1hfzdaluV+Ytb+7CxicN+qMX1Rt3qr0+LTu0fSiVWcdLELvhA+2XPoRXDwehfRuKMZEDOrckY0WFFfxcjwaKDLjmWc0h8FV0QCRnvJAA59xpGFwVoiCmqzghyyYdUoRHHYsja6oa6h882jmL1ehxy85KGWJlMI22MjT/hFOZnqOwLe0tbb1gxrISH173D+931Jui3Vw13gaHK7T/xYuQdalRtMySNC5vOuHfWzceU7MomfSRk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mROmA/SFTrnk9DOivoqAOWRCa019zQC1Vw6LMIzy9Vk=;
 b=BNgwyBN5w7WZtYvZhUwlrb/isS4jI2T7+NYhV49QLu+4ydUePss3GiCC658lA7ybJNK5wzsFtgKkPy7ipip5nCN4JgDkQsBr/4jc8TMdTr5tWtqSBpzJe9+WeQyBHUpuey5EtMIaYXZ72JErUrIk8a1X9cLVNolSJZaA9CHD3jgdEVY86u8EhHAYb3MKwwEY9+S5ewey7Hv8kHTUJVWW9QfdZ95KYiAGhUlBEeN6JupMsK9jjoNeHOQKFcx6FfLU/pAvkrL6FNjQ3yF4Mb/44aRlvdqd1UnYXFj2oO8AvPiwZhm/dVEn8ZvDd1dtNKEtc70yllBAedHdKz6E1q/akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mROmA/SFTrnk9DOivoqAOWRCa019zQC1Vw6LMIzy9Vk=;
 b=AgCx3RyGCSYZgvQt93fKWpb+woo03tm0RBQcXDSon9tyrNipNONFzkfKJor0Fg3YkkmjYHo77bHpzrKpBIEhTMfghqaM/H5BU23Xlc08N9OKt0UpKmO9VBRvi5kR6bHNE9ZuUhvpMenxgL0S095iKtux/1zCDrKA87E5Q9Wprn4=
Received: from MN2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:208:120::16)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 17 Apr
 2025 21:30:05 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::f4) by MN2PR10CA0003.outlook.office365.com
 (2603:10b6:208:120::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:04 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:03 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v14 19/22] cxl: add region flag for precluding a device memory to be used for dax
Date: Thu, 17 Apr 2025 22:29:22 +0100
Message-ID: <20250417212926.1343268-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d16cc36-ec4f-47d0-26a8-08dd7df7053d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwAP0awAjUcPwD/CVdMz0wirtw2bx57hJbWbymCefqDWLZjVHhxDfNODLeYp?=
 =?us-ascii?Q?yMqzx6tJtf2vEPzaFnPbziekxjSGujvye4tz9O9BmKJwciz5EgMgnXBUBurp?=
 =?us-ascii?Q?pJkqt5OOVUCn/gjGN8hSBjLB82Zm6o8lKKPpuedxoNo4XfzG2yxVt31vx2pr?=
 =?us-ascii?Q?keo4PpKPhkqMRtcIiwspr5rHuDet3/PMIpWFppx7xV5CSzRNvopKSPmzrliK?=
 =?us-ascii?Q?fTOcQJUM1dRLgGUET+kqftyKkfBa0HEOC+ulI/4DF+bmmA9iR/GnlokxB425?=
 =?us-ascii?Q?ETtA1yOL8exmdK681l/2woIgT7TU46fYmMlrnYs8qmF2X8NUE8NymX+eBlkJ?=
 =?us-ascii?Q?kXtIZkcs2wZwhhGm95EsnCOfW95KO98Yb8UHNXjI9zHPwlazP8GV5Au1XSp8?=
 =?us-ascii?Q?ZJiuIM66BMDXyNj6ujhcTVLLfGnE3fj3wjpUZxFy9rH36ph6vJ+dn5xuHBp/?=
 =?us-ascii?Q?Rv+5tAMsuM4KHMObe/nLa03+RWTsyG1lNQTYBya9RmuI1I5jFE+G9fd0Pwwr?=
 =?us-ascii?Q?onyBrX2nN8e342lwLvSSjwpaDqXwcFTS0YHhplTW85wvAsh/jklXYvs9ttpe?=
 =?us-ascii?Q?8xxZUirmXpHHCskp+yvNiTg6uEdNbBN9mE5Q4kSepRMnHjgnv9PKxliqIIPS?=
 =?us-ascii?Q?w0uZzfDrV6X6w8OLS3m5Yk5afhavlXAP2G17wrCrLfy2FJqj25niRr32TCh4?=
 =?us-ascii?Q?SV3IvBHVIOeNyhEuCV8y7UD0fEXw3BYi7Aa+1aNpGcXdv+wuGjjDHycnJUoZ?=
 =?us-ascii?Q?IPEIw7s7X6uZPfly4eMXaf7lyPMFYSdzypjjZG5enNOB1QmuSiBHIEzUQlHn?=
 =?us-ascii?Q?WhuPKMm/BjJxah8aPfwjaGkxcw7VXlhBCZwXHpGN9kIWlb0SMEMmWxxK1dWB?=
 =?us-ascii?Q?4kJfXFFbYo6Z3bHKGnfo0hjYV038+lA3RHVQcqxKeYShGpXwpQxW7AZBi18K?=
 =?us-ascii?Q?huWHA/t028W0L2ldJGzc60v92lHiSH2mOXzx2RRXLc2YGkiXC1m/IcQrGtcz?=
 =?us-ascii?Q?An3vzqKcQM/1S6T5Th5PKzci44IlAbnz3R7qDprODeqKvbS8JEkf1hXqYPD8?=
 =?us-ascii?Q?kQsjYKkAHoSgvo8coNV/BoUzDM30yrvlOa/2ifIDvbUzr2lypBiufnD787YB?=
 =?us-ascii?Q?wtVQCLReY5oLt2Hm3jqJ6iZ86TdDsmJSOQ0YkJ42cAKJqE/xeeNAKIu89HRL?=
 =?us-ascii?Q?ZIP83oG30cG6qpRkyPzAojX4Z/py9PrfuguabhKZbcgIk45M7FF52tjJ3o16?=
 =?us-ascii?Q?RhDKYiB9q/GkbQllVXHV5euyTHHw8+SgkDa7vangkVJmLh7VMGOtA8iOcdN5?=
 =?us-ascii?Q?pKbqxa+Ebam3lofnC0pyvJghyhYxPMlwX/P0Wg8wRwRmM7CIb697kSL7inOg?=
 =?us-ascii?Q?O3/lOA52n2lLt5zukvVykZNsOwG8hjgXyYo21kd4BVo07VlLu2rvsSN5XOA0?=
 =?us-ascii?Q?yHxl/4kVG58g05l/BUckBBN8rq+xBhm0lAUjpnKWJXMlNdJV5uKKrK74yhaR?=
 =?us-ascii?Q?qxSPGGWqWXxJ6yzsuYnWa45bBjxgFKZfuUOW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:05.4327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d16cc36-ec4f-47d0-26a8-08dd7df7053d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 include/cxl/cxl.h         |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f55fb253ecde..cec168a26efb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3649,12 +3649,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
  * @ways: interleave ways required
+ * @no_dax: if true no DAX device should be created
  *
  * Returns a fully formed region in the commit state and attached to the
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways)
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3670,6 +3672,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3833,6 +3838,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c35620c24c8f..2eb927c9229c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,6 +405,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index ca8dd6aed455..5d30d775966b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -267,7 +267,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


