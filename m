Return-Path: <netdev+bounces-111574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015393194E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7102A1C217BD
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EBE4D8C8;
	Mon, 15 Jul 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4NOj26nT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C764D5BD;
	Mon, 15 Jul 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064551; cv=fail; b=k5BLQbSXqvjh7vCkwH59EiazdOU/qlAnfTyzYB/flGHgUa4JwF98Q2AZrKdv8BsBlqT4y8mhdFB5WIiSl6ZpDv2c0bx3fnVhUQsloWwlv4xo8SGdLxp49k0Kw5D623HcPSGESOsVLxwL3ZkGcCcIFKeuuv16XLSdIpCR1m4o4CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064551; c=relaxed/simple;
	bh=BakCz81xtmBSGDdcYNKcYSvgjSlGriobi6063kHj8mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trh2OTDQ9PrryDhBynzcYBrFOjfBomWj3F0PlkNlTu5t79TyFSr0yZtLhn2JYUzMc7sDZ8Sgyf0MOu3A/pGPyqPBxr+ZN4fZi8dGqQclkLJBz+dI8jqyhTbEBmL6YobKR92+WPf9joit8nORDIz8eTKHSRCSU9AlQXKH0omRhSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4NOj26nT; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcOl9HVIjC/fsWVQva8HQAbA6DcmUqGNMj37oszPwFTbWTie3VMF369g3A0vA09QBQBkYNTdILqCZAXXCzltK3cMd2uw2ilN9wMuszH99t9KmtReBdh8Fb2TOjhVLQqnTd9PW2WKvBCU2jIV6IllbLFZQgeep3wArKSZXIl9TvEw2H713CjkqDfUCbuaJBKOPLwCEmxi08wKAFVjNVT7Y8fNMZ1iwq4Kehji/iJhcc5DypIaLh+WbYuWwC5eL2gJXyueLgrjVmtxOThordqSufQ7/cR2TRURiXFtqVLqtbmlJrArhs5sqzToLPUxr30wcN5zJ6YidyIQEp0uxrfMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/Fw9yqq9m7TDHJciSAzr376wo3U1OJY+js4w4DOIRs=;
 b=VYjRjFtawXFuJ/YGOBqHw/Wh0f32IwHxdUtYs/nzuurmmglVRAO4qcgzjh+kPkDle/dthbVF/FuUxw6OdBrKwYUB/jOd0UksewQ5kIHW/JOEf18sMIjQMcuKOAWtImAakl7lkVFgHQMJpXDjXpPXysQodOunuvb28IjJoZ05rB8CESvsN4dvYbagB3XcA7lO42AdzBHIjSWlieX5nHRRY68eT0j+fhV8gg+jncDQyZ2Ub8YeZw6+zPYPHEYLqN6B13ER1PJBz5hhKPX0PDNKW0UtwilFuBHriKMrul3CuK66lmbKOaI5pASPyP9vA9m6kiseqFdph3wr/4dzQv+XCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/Fw9yqq9m7TDHJciSAzr376wo3U1OJY+js4w4DOIRs=;
 b=4NOj26nT+TqObBe8JSJuZXoeFeSARESEyGXTDI4ZaDxqZHRvmYLhL8rZMV7gBoYdOLgt0x9gOAzrVrQWWks31JmwKhIwPxfAfJvs4KvSOgtkgGaKRmTeIkDHi05Ap/c4rLqPqzknPXmKBgy5FzxbRi3FCQ+2az8xj08RL0auR3w=
Received: from CY8PR12CA0042.namprd12.prod.outlook.com (2603:10b6:930:49::21)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 17:29:06 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::67) by CY8PR12CA0042.outlook.office365.com
 (2603:10b6:930:49::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:29:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:29:02 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:29:00 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucero@os3sl.com>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 13/15] cxl: preclude device memory to be used for dax
Date: Mon, 15 Jul 2024 18:28:33 +0100
Message-ID: <20240715172835.24757-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3420371f-7b18-4c8f-1820-08dca4f3a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uv8GkJkq5mQhqOCKJu6QRGRq2dDWukNvo7C6//Kniraw1mXt/5vHGbmjcz56?=
 =?us-ascii?Q?g1qfHIhhrzELVMDviQWNNKr5kvnLc0YRm9Smr9TalaypElrytVHQy3Me9yIS?=
 =?us-ascii?Q?oEUUDtdhvA3EUGMpfsZ8A/vPG1KvCujc8UKtelpMhvnYx1/TBQgwgB8M+f33?=
 =?us-ascii?Q?pqK6DabuZXeqNsQ+QNfAxFtFuEF6l5ar45bHojzJtqG3pu6nSbcWNZZG3UXr?=
 =?us-ascii?Q?86rIdIx1Dn6mPH4vJA3HaKUFsbsBYOZiys0SEjIUxD5dDCykgsVG6D9IZV5a?=
 =?us-ascii?Q?AGnJ3sIg9/tmlFEuEt7i9kVxU9sciKgpgzqEfXiHyVOj5fFuXJ8UtDGOaswn?=
 =?us-ascii?Q?5SQZ73id5V/m5h4QIwOFG43dJbXRhUbJZnj1EdHUx7dS+kHT7lpwmX84Jr80?=
 =?us-ascii?Q?MUKwwzCzbj8WzjXrLLRyXG4ud6MY8wB626hcMESq9oEHgrv1fi9AlTLqw/3a?=
 =?us-ascii?Q?yOYZ6a/R+zmpgwVomQAPYFVUqYURoEeFDjlaIxelPT8VBzX25WpGNw889IHJ?=
 =?us-ascii?Q?WH7P7OqZVVbQshFH8VV2/JfZffCvZMuZBuPhsIQMsgBTYnPeSSaQ8LMv0Ruw?=
 =?us-ascii?Q?s+OPMeSk7yfqsE43dmS8I6KwVd8iT+xZ55LKjgeAPb/HDqLZdT2oyC8eoFur?=
 =?us-ascii?Q?ME8Mcofh4EAXn3UtTPWFkh1dYMrhiyP2x+Snt9oQzAmf+3jaiJfIozGNd5UF?=
 =?us-ascii?Q?e/NzS5IFpRUe0hON4FllllQMRK6UNKlPbi3+Tm3eZe26RM3v5EhbUpN9W7wj?=
 =?us-ascii?Q?/Er2yzWKwgkGhuvXr6EN2oCbW7mc8pRDfCQRcNYz65xTJe9gzlVVoOUl3fiU?=
 =?us-ascii?Q?52bq1I+W7ca1mt/FofTjSYPGZkEaPoOtLDCFvP9+E23XTChPE+LTwn962ShO?=
 =?us-ascii?Q?rIldOzR+r9wLLiVca3lRxycqNNpsTKLPtVF8aPmlRM5FUiLaiWacX1QLWrUZ?=
 =?us-ascii?Q?WZ1smYpsfpSRDWe3iNWq9WtMI6/6Y9AJXX0xWmgJaajt+PXyqaWbcIm/Fybi?=
 =?us-ascii?Q?Sbe3xvTthrA1CwaUngT9Suq1FGkTp+KY90AJryuBQnd4WPLfYstS113zEjiw?=
 =?us-ascii?Q?nTKWgP27dCgtXYToYiyWNABFMlXiKRkTuBTQbfTl/dSvJAk2VXDjsek/m1fZ?=
 =?us-ascii?Q?2aIM9ud7oSyxX2gI8C0xrbnHuCpWizmnOpPtzMM9JNVFQXR7HIj8FUmqU7mn?=
 =?us-ascii?Q?Ziw88aNseLi0wDrsonQ+Mo4YaOaL8GrQJWjdRsThkGwwFLp3NXrlZxqOsJli?=
 =?us-ascii?Q?KTlDi5mnOnJSKQqQSrcJUHEZtvohlJkjCCVNuZu3XOsIxRWAgqJeGSlZWdtz?=
 =?us-ascii?Q?NcwUH/TmBYCORlVjToAaZw0RmQX6n3V3obUGJKAtDa9Tfmu4FTPJxcmT/hMG?=
 =?us-ascii?Q?rYqz6at/77OopeZB3t0Vh5nGSwtPmHEXHQdJ5t2gWyz+Cvpz8MUHNN5c/ig1?=
 =?us-ascii?Q?ko0A1isSZr7AjZge/zAzU8FeP7kARH55+jxHZHIjElbmSeQZ2K8d3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:29:06.1370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420371f-7b18-4c8f-1820-08dca4f3a0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

From: Alejandro Lucero <alucero@os3sl.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 697c8df83a4b..c8fc14ac437e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3704,6 +3704,9 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
-- 
2.17.1


