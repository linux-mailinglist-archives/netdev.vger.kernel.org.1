Return-Path: <netdev+bounces-240150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC47C70CD4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E18F4E3FAF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B537374D;
	Wed, 19 Nov 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/P9Ms40"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D113191D4;
	Wed, 19 Nov 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580213; cv=fail; b=HOrOfmXSVCXmTyrYPBzPUM3L2fNJydVbP7wtCaII2uBq2xHPP++qMpvZaxPxouYUGbtQSuARX4kXgVXSowfBCdth34ap9Rw+s0YTzE53x8KsN9z4hhs1SV3UZ+xl0jvR3x6hmC7nHJzVdb71jcTAuzVpzrBEtdVQhGYKfHn20gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580213; c=relaxed/simple;
	bh=6QNPoFoDgeTqTX1WdFsJBps0n/v6BiCPetHOgAe7lzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5dmI1u7ZBIaHrcBuszpph1VKeuWG4pMc1YYcvdVTTy3C7ZQdMcCe6439lsadLXbq8PXqudklqNLWAusXQ7MpWWswuLap2968nqnSgDujAuV22s3CSKwnBZWdSAMT8JQ4DE51mYTmiTsIOEWN1zWb8w1sxVum+3KooRiUSBsSYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/P9Ms40; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLJmkHWIQiXjLscjslh0u2YfhnY1hi8ep8b0tO/Sl7Gl2zUW/yA85evX3plRo5379X5QGGy5NF9GAdupoSUkSAd2NXw2QH6dly2G4dd0Ed0DZxdZuxVXen0hYjHXP8FA3Zb6FCsCVGzffEaqZZ9nnyCRuq6v51FkZ0MnwjmD25b+nNNxy3D3MNs2UhGvSPSSWbMGWmmiAtbW/EZ0Q/8Ie53toTV+nLEqTY6SEm1lwTGyv/c8rqx1L4KI+aytRwoDkpUreIDjwE+Kdfj4KVIOxQOfU+ofkJCUN1oTGwIqbLNg/aNJPPQ3HyPg8D3BAIE0iyC5PyqVVie1Z+sb5bcU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeJbFFmflV2ClqsdqMduJjc36aRJ3YzzisnFcEl9BmQ=;
 b=lfy3LJi5sD/rs4LUDiNH1CpbJvLGrwfudHoKr4HqNC36WYorhBm/NIn3FA6n7O1jxoDpflZTUjXE/NzkUdaS9RStJ+d1npnurBvJUxtKB6hRMZnqYP0hD8T//LjBaQMPXt7ghemerDHlCmunxPi/jVXMN4F5ALU/nAhPb72zFvvkUK+zzBxwSc+A5eIGhbjQj0QUFSgviL1AAh8DXlXe/hOZT0Db4IkfzE01kg09lpsVx//vuqGx+ziiq3yPm/gH/GcjOE5GOmGDm4EzsdZMenhpJ5aS7sRbop7tc1dQuVEAdI2071ifotQMN9ok3FICFIl+HOlydfUemg8SlPK5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeJbFFmflV2ClqsdqMduJjc36aRJ3YzzisnFcEl9BmQ=;
 b=z/P9Ms40YU55klQOlnjl2yBhj3adKKJmjogeAPfbCpB2u+hE4KoXkCADDYc+d/QQFEb8hJydoFBVNHaryXl018yDprvE/IabW4JsMr7aiy3JxjiX7vo+X8o/bPzviMKGoUWGD9r6jbX9gcur2vF/qEj7nvfV9KtZ0SRUIyFrpAs=
Received: from BN0PR04CA0165.namprd04.prod.outlook.com (2603:10b6:408:eb::20)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:13 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::b0) by BN0PR04CA0165.outlook.office365.com
 (2603:10b6:408:eb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:11 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:09 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v21 16/23] cxl: Make region type based on endpoint type
Date: Wed, 19 Nov 2025 19:22:29 +0000
Message-ID: <20251119192236.2527305-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 796302cc-828b-41ed-1b7c-08de27a11541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6f4aGIXGs5VvVARYp6uKiAhVsRbchWyGw+hu1c004IgmiF0YipxNITASOEe?=
 =?us-ascii?Q?jF+TKOWB19dsgVy77fAhBKBSgc4JRkNo5tKq9oHL4lbPpgS7uM3asle6PMA7?=
 =?us-ascii?Q?rscTCesena/ulCRBInhQ3dWT+kLGyXaUpTU4JuI19KFUnzly4Ix7ehhi0zRY?=
 =?us-ascii?Q?UcKbYE12h7kvaxsmQMzftTnMfBJC28LbhO4t5eMQaj9KlppeZ+FdxP587qhQ?=
 =?us-ascii?Q?4T292yvoz/LaSBdUItJ6YVWa7uQUQrxMHQ+sPo7K0XxS2NPDFG05p/Q6NCbR?=
 =?us-ascii?Q?VXfTzKuHCzV139/B3psyJ1f4g0KaL4vN8czpLotXgbHHI9QefEcAhkOLyclF?=
 =?us-ascii?Q?pOVwxT2zdNPJKLOqsHMyrvup9ZnqNvQfBlqagBkdJPXGvQxbxX2toxRJlEnV?=
 =?us-ascii?Q?5U1+IimrOEsggRDR24X0X4+R2MtNVRUeGNhsrIkHAn0p5Rzi1GUbgBn/wBHQ?=
 =?us-ascii?Q?rCOHtXRGxUrSeg0dWgjrCNRYOZmHSAQx2Ydug5UnGCx5pISW3H3NzWo89okp?=
 =?us-ascii?Q?jHoEpsjBerLF9HyA40oJQgbt8QNHryEmZMYagZ6cjVPKXsKoE+d7on1AZA8P?=
 =?us-ascii?Q?b4a3CY5WC4KHRbZPmf/WqEWy4jWXI8n5Erg2Oo81ibmIwzIXMTwYRjB/t4/l?=
 =?us-ascii?Q?VsH4ELoRAjN+2cRYE8/T2EFygpgwuXkMGH6GeY9pSL0VPyDTJRM2fxd9T293?=
 =?us-ascii?Q?7uhXbH1XmAlthgm289RoJowEc8d2lWwFgd3Cm/4+/uRxPGgiSOLWI2wwu326?=
 =?us-ascii?Q?+bRic4rlwDh4HR5AX9JAVpZ8Q5lLsk5maIUTBKMHJzQ0H4NKfI+58IWhnqx9?=
 =?us-ascii?Q?d7KU+Wz9FlTG9Agze8ctS8I0wYCpPag7UGY1bCZlC57UoHUicYuR+77vDyZg?=
 =?us-ascii?Q?7UoLj3+8yth13Qa+LtpqtmHajPGPR3GS/bFU5GnUTs98w9kNJUsd3wO6stzn?=
 =?us-ascii?Q?IWDTPRtiMRJl74wFtS0ANJpqd45Z3XrO9gk46ru7ih+q1/YploHcWcyAglhO?=
 =?us-ascii?Q?2tSm1Hu+NIiCbha18vu4eBFksOhZQsiIxIFpF+EoUJZj9BZhFGaJrFiN7he4?=
 =?us-ascii?Q?idrfkZaf5hqPGFHzgGPk1QS4c+Vfu4EMu0L7DRbiYAnVKNC1pNWdr7xUfm3X?=
 =?us-ascii?Q?4wSBckLIYbGf18bS0xugeTAIdd3KgzGLeWEwT9kShAhNn5ZWOb6f9hprRg6G?=
 =?us-ascii?Q?2B+LJEM6cn5sUcqLu8urABZjslXTJXB/WidgcUonTQxqUA2HNP1/pmsk1GBY?=
 =?us-ascii?Q?0wX+47tr4vixF3X+HLp874NfiMdk0WWuymaDAB4EU7O0Y83XUFcaCllpzzPm?=
 =?us-ascii?Q?2Hp+/M8VQwoXbKEEe9tf0fuBTqJ5/MXu8tOy7fTMqMYBtFcqY5lmPPCi11Mw?=
 =?us-ascii?Q?Z4tBE9+sd25tHHFsl+jKcZEgSp6i1gzsk6AhQJeEKpAr1fCuR0Hz6Vz8UsqN?=
 =?us-ascii?Q?u7PIPtxHso78/OCw7Z8XQj8dBELbfUDQLSR+B224UuHVlfEaec3Y064XEdX1?=
 =?us-ascii?Q?HjS3oCV1lqs1plb78PcWr5v2yLB0iAZfIX/3MTbW+x0IHhGydR65KV2XBntg?=
 =?us-ascii?Q?D7dbO+dYAuCIvVW4eho=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:13.2551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796302cc-828b-41ed-1b7c-08de27a11541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c9bf7415535e..85c2c7ab45b8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2752,7 +2752,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2774,7 +2775,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2788,7 +2789,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3682,7 +3683,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


