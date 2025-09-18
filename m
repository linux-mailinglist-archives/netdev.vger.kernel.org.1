Return-Path: <netdev+bounces-224328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD774B83BF8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32D452747E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62874303A2C;
	Thu, 18 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oq9Zvqv+"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30263302160;
	Thu, 18 Sep 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187116; cv=fail; b=HuAHcAd1fAS+xdv5SSWX0QL161YIhI9pJ1hG0L3oAdMtX0Jq+hi6+bHufUxk6qGrjOP27W1b44kzb6MPyf93XwNGSY0VpAF2ebIcJFOtH1l7K8Gj2tyYHljrM9O/qxiEuSaWTItJYgtIx1PkxDLqMWY2Le6OaaebD9yPs6/sIDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187116; c=relaxed/simple;
	bh=y+U4Sxv89OIharSGg4XN2tZoQg9PlIxM9TYHRH5lxNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcsLWfn3Lkm63dQlH0plJYs+rhRnxyHYM3ERZc797Jr04Bl/ulQc4idproS8D6oaG3e4UYasCNK0cO23KV3JssVQ2cuDLZzFpN4iDCNWXCcRdKD/Stj1kjIHKBm3EpMbS+r7AlCWuyuFo9OBt8RmSMTjKGBZAHd4SfZysmzm/88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oq9Zvqv+; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXhDAcNjAl4vU0XoJDy+1OobjjQiehkLhLfLpifdfoOhrmBvwbTPDTPXVDw3cgPv9OIsRxdUBLlOfSkjE0ah1eN0KqjqswbrtiYv9x2KR+RbSyXq/aqbpotL6jRrU7AQRpHo8Qx2aBBbSP/x1B1GqIPRmrvCJo4bNdHqAteTQbXa34jnHXFklVk+wFFMTqiirJ1nZchKk46y/t18PsP99SUHjNjwg8Accz7+vloaaWljXbZvkDin2tMf0mRNGlMNL6WQxlcq+Cn50gSQS7MMVfWRM4QSoYzrVKt1YtrdIt92F03qjP/5TSZIMHYXNPUXEFva112xZS4ObK1tHhO7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuU6boBdRAL+DQltkGCoFVGtXn5vmYkPeiByee3SN3Q=;
 b=vpwK7AnvTS5MZPYGSrvrPBGPaXMnk4o8HMjGy2QAb4eVKGHvyePr2pM/DnjtfKXBc9psS8uyBXgGY5rebl18fxSifUL/Zjubhn3zQaHO0X1Dsj3a9ECDxsQ+MkqItvUIUax3UTrR15jIpP0s/HF+J7XB4ZFA5IYQpkPm+oGnMj6beym/v32DdCy3dKs+r4KZYKqGQtyVRLtsz9XYd8GWMKoA8Be3FaRsjkfl5FPE+v76vWF1sf09H9L8dyNPmp2artaj76Sl4bzR67ak3Tlo0z5ALgDxi2oTqE1Zh0UeM0MXC8t5rQRMX+ZWEB5SOoj7VoXFc1Zou2pWxpig6gA8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuU6boBdRAL+DQltkGCoFVGtXn5vmYkPeiByee3SN3Q=;
 b=oq9Zvqv+2hNrmDhpDP8JXeWIoCKiYh2dvjMp/StR2NnYcpCNN4C9wRV+W01K2ZT17CmhTKy/Z50G4o+6tqGXIU4mJOv/lnXHuS5CvXRsOEPht6y/6tCxA4nPZ+fuO2zHCp8EdQsptB2pUkp7HiF/aA51MaVpcMWZ5C8j4wRKzbU=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 09:18:28 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::ba) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 09:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:27 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:26 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:25 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
Date: Thu, 18 Sep 2025 10:17:42 +0100
Message-ID: <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5aaf96-393a-4770-f54b-08ddf6945412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgKD/EPQ6A6SebjoPnvkEF2+7Q5ZN/YDFRZJflAl3ToUB4xRcfIr1eU/jW+a?=
 =?us-ascii?Q?o7mfhi6Gs1YxsQryDV+jsRhyqL9r8NDXqpVwRg6JCzz34XiYTXkn2M0Twtak?=
 =?us-ascii?Q?cTLYuOA31q3p6GMnxFeO6LDco0TdJo7BM5BVDRYNPZdvQsP0Z6VvNf4vD4vv?=
 =?us-ascii?Q?oNw+Y+MlRELYmmoX3BS1Dn/kMVlPd2TrZbX3w5gGCLvu9VSfGEoKVxJlM5Iv?=
 =?us-ascii?Q?3h7UJEEs9snhKGKl8+9XE3uJhaffCdHbnH3fvJVMPRmz/TQZCs9cBKFVDOVZ?=
 =?us-ascii?Q?iQ7Pt3TlSwGipxyhWo9/xL5q/0/MfiaJUZDjPzrmCAQfaVLSaLJz6ovhABfa?=
 =?us-ascii?Q?TxfrJz0qqeLbEDp0HhlFF5LT3oHDg3M2Ch4AXl9g5fpvM9BVGJQVffhQ57Yz?=
 =?us-ascii?Q?5gs4UG6swA599SABZ2SxxPsBkW3cNOvVw7Re3Xany14r507wL8Pf1zGM4s43?=
 =?us-ascii?Q?zkyWB7bFJf/dWfzbGWHgs9usGU8fjaqV1/G9DkxiMvstVMNpvhOZP5+9RcTi?=
 =?us-ascii?Q?Db5RwcGTirSovr6VC7f3J/+JifgZilBdmpJRezS/SIuCYqpRP6XtIX6iYmJb?=
 =?us-ascii?Q?LRWsUU8meOX9oO/NAN5bkvMaqWCm9l9zm7qatZx/eAt8aGbcI1qugktvz5Eu?=
 =?us-ascii?Q?Ay1FC0afjhUzrI7erD9CBsrR/RP1YP/0dZfdYnWBXcTx0DfHqruu8VJaEUEZ?=
 =?us-ascii?Q?NxrJN+SNJVxw1cuQiW6PeWOk1FnWJqR1rHi5ry3DPJ2X7Pk0ea7QUg+x3TNC?=
 =?us-ascii?Q?y5O3Bt0wB/f0+YU2Fk2rRHNRzdfsFwIuwGpX6lpP5WiOi5t0vIQuxzLCF6d4?=
 =?us-ascii?Q?ZK7kf6Q8whzrjbd0KNdIZbLJdg36xM03wM0OyRE2P2q01OGLeihIan6lWTex?=
 =?us-ascii?Q?g2fp+5wqdfFDkuckjSy45f/Z6+ugrIOR41yOYJVurv9tprGnjFmi14SB9ASP?=
 =?us-ascii?Q?iuBPL0ISg28lfFjpx4vIvl5afp2EMT07YXpvknTBy4nNWGi6ybG51iifahQA?=
 =?us-ascii?Q?NfOuiDKmn/N4OtVm7fXDCD6qVNoBGe5Jb/MJD0HJ3d0ByZYw6cC/vmE8f4t1?=
 =?us-ascii?Q?3ufopmemMIVXq+uw3rENo1PhNOfPBTpaaDtDR75nOx+g6eDKKbaDRAaxbrJK?=
 =?us-ascii?Q?w20aeCXu01CPwR8T7nKKok80GmRQZmjIeCCgjW3pKMHMgnHLgFXayA9BxlHi?=
 =?us-ascii?Q?OcXXS+2gza5UtuZkOt3tnyzIbz97Uv1HqPPwvDthwziVV9oNna2BhhRHT/GM?=
 =?us-ascii?Q?aEMSfsZMG2jBmiusYxVG9N0ezz9gLK9yGQQ5fe3dgc4KlTh492GE9AUOITAr?=
 =?us-ascii?Q?6VxmI2Un4I3eEHjUSkRNx1I/j1tRDUWPFAV68FvIepLBBZe8n482flXH/lNd?=
 =?us-ascii?Q?rTxlqFYoKW8k+upaCgtNwYN+qKIFgptSd75A32T4TNY9BXR16Y7EOnB+1jAk?=
 =?us-ascii?Q?Rb1kIW7czbNdqx1sT/bexerbYTpyLCx3m0wFnMgHUQcVSZMc3GPUuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:28.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5aaf96-393a-4770-f54b-08ddf6945412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Support an action by the type2 driver to be linked to the created region
for unwinding the resources allocated properly.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 +
 3 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7b05e41e8fad..20bd0c82806c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2379,6 +2379,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
 
 static int __attach_target(struct cxl_region *cxlr,
 			   struct cxl_endpoint_decoder *cxled, int pos,
@@ -2864,6 +2865,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3592,14 +3601,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3608,13 +3615,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
+
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3625,6 +3643,126 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder **cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc, i;
+
+	cxlr = construct_region_begin(cxlrd, cxled[0]);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		for (i = 0; i < ways; i++) {
+			if (!cxled[i]->dpa_res)
+				break;
+			size += resource_size(cxled[i]->dpa_res);
+		}
+	}
+
+	if (i < ways)
+		goto err;
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto err;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		for (i = 0; i < ways; i++) {
+			rc = cxl_region_attach(cxlr, cxled[i], 0);
+			if (rc)
+				goto err;
+		}
+	}
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ * @action: driver function to be called on region removal
+ * @data: pointer to data structure for the action execution
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways, void (*action)(void *),
+				     void *data)
+{
+	struct cxl_region *cxlr;
+	int rc;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (action) {
+		rc = devm_add_action_or_reset(&cxlr->dev, action, data);
+		if (rc) {
+			drop_region(cxlr);
+			return ERR_PTR(rc);
+		}
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 static struct cxl_region *
 cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 83f5a09839ab..e6c0bd0fc9f9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 0a607710340d..dbacefff8d60 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -278,4 +278,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder **cxled,
+				     int ways, void (*action)(void *),
+				     void *data);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


