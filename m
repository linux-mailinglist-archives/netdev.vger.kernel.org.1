Return-Path: <netdev+bounces-150351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19C9E9E98
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3055128194D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82D19CCFC;
	Mon,  9 Dec 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="awY36/cY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021D1A0B0C;
	Mon,  9 Dec 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770514; cv=fail; b=DBcadVje2rzKLI4lUId0BVvmgpeQHT8LTZsUhOqEq+L2MnO39ECZppUD6dRmxHNQszAtepsFs2vGmf1XvGzL1YZi2tdraiT4tLSDI6klqIATPmg+hYuTzQvS/DRf44Tfbtks0/SjQLTeQhz7ZRtXwzszciN+tvGOoW17GmDPMkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770514; c=relaxed/simple;
	bh=iWTPXhAf2v53e1cabP+7+VNKZkmXmJ9c5GHbod3RquE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L60pkaqHkQsVFM3BMQy/1xiuctbv0YEMDeIkiPYi8AB7rT1PIaXMSv2gi36XbO9uCqgIYV/Z4m+Bh53zBI5vjeu2rhElDBH5b0zmEFV5mGb56FAKLXVAol8HnIdIEooItQuaZeW0At5+IHNw5WhTkm/VmW4HrgZVuYe8EG8ts5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=awY36/cY; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unBmoXocnL11OPJnF8CHASGOhlaNiiuvovHgONo53E0AYktk5sKbXpjNcIIIs67VLx8VxUegO1sKU+tQLpmngD11uF3MwPoqMCQfLWJWA6naosQkBjoTlywEOGxuqSl1+b9ayNr4iQxjPtfcivP6cJyjnxIBUnAqTi46o6rFmD6WL9yvp6ELtx6TNyrIGh4DADezSe8M8kQrz6cmcDeVQTW3Jwp7Evl/YgFRJBFPFW1Q7N31a80+cb/ARcUEYEo7NNPJqgSpZrm+f8ChjNnmZyz1RhcqZXRkSqzn98ptwrsOvTd4B/bocJ1nhgd6rca6ZEXRCqI0MopUYE7sLAPlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBxXFyTnA4XcXrE4pJYlCVUS2LX4lKRZ02jvDBV/I2A=;
 b=d+RVkTPucL4fK2nG6ENVHwh5pekTBHURr0KD0cnpc+0xjSnX9rhvoTdB2A9mGnvzYijQUNiWlFanf80WcLwjIVSF/i4VvG5O3rFfgxoq83yE+733It9QEHih6R74FE5MbynCYZUpx0XtsIbFzASPFteC49Tt/nYrp9Ai6WBvm3Tydy+ABU3g2WlM6ZaVz4BkpvqZXi5nKBykDRdnXRsp4HdQQaZKEqiJrrTxleQOfnFwkJhqDZjI1q6wgafWc/uIWSgXD+FwG4eZfELWPBJhefZfxyI7V2872HINgv+wMckcE7ib3oGiCyWTcySOo9kbzDyfjV3+pxXCBuF9uFnurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBxXFyTnA4XcXrE4pJYlCVUS2LX4lKRZ02jvDBV/I2A=;
 b=awY36/cYEmmGQOR2Xg1nR7Ivpl0YEhn6Ghx2qkXMBAxY0cBMNpu4WxzRr8cieIYri5kKWqd/MhjErDzVOFqOpCaatJdc/w4lxBVmMo9+9glq8Jdaat1pAhKjRQZ7vlRoyrFXRYFWhYmb4m+9glZen76RLfL+0l/Yze/HXnmkhSY=
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:55:08 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::af) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 19/28] cxl: make region type based on endpoint type
Date: Mon, 9 Dec 2024 18:54:20 +0000
Message-ID: <20241209185429.54054-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be5d492-a7ec-4b0b-c2db-08dd1883005b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NKZv1C6HTUbsaTJwHf2c8Ciklz8Hwl4rqwViCVXcrfkRPMHF20J3TIskCyO?=
 =?us-ascii?Q?FXu99O6RUAdmUNlYC57Ba024nwBsIBXjJ1K8MJG8VghLxEA1JIkZBt5hzl+4?=
 =?us-ascii?Q?WiSpyiVZMFTzhL+M6l3CmxXNCVEC+kw2Y1nmDjMEPwzeP7urFb2tC3ws8ouL?=
 =?us-ascii?Q?KiDgL9AuEsQpYAoLnrS5XEJ5Azm7GF6RPhIVRnM4n1yAkvndtxLVDubygHmY?=
 =?us-ascii?Q?JwRdnh7bYzikPq/ESw0pDJsec0eEaq7TOPFpZyszZiElGbr4Tu2qTqmaFhm3?=
 =?us-ascii?Q?jywxgzdNDgNQgKjiiYaIFJ5WDPvumuUZ13/bfYxZoesrtyjWJgEdNnoTxm2b?=
 =?us-ascii?Q?IK2X1ok/XhD7ERZX7eO2itkO0+pRdrif9NSrmTNnNZ5xyZ/4rEB+xOUOdKbE?=
 =?us-ascii?Q?GXtax6cPb+flWNH/Y+Tl76iinJxnD19/JuuQAnqKj5i43d97jluIQloiuT+7?=
 =?us-ascii?Q?Xa21PkOosHt/pS1PptmeLUIIUY1QR+lcT+JIHNyT2bGeiHtfzWSXcYef0sg+?=
 =?us-ascii?Q?eEFIYwBJBAzzuEAPddR9Ha0vWtM9OVHNrFRxd5C+KbBBVaTLid34VdkKmyX2?=
 =?us-ascii?Q?n2UfpHEKNBVx2IENb3gjig+UtdCmBeRhEbuPYlPGOe4CbrZnDtZDT9lj3oYh?=
 =?us-ascii?Q?lKZhp7qeWl4pxW5iE+xvFYLYb3ZVOHQULmmOsXqgXfPMBkSZxbpBVJZYPMzK?=
 =?us-ascii?Q?DObvhFx/zvUc+bBX8dpQQQwgAEQuB+YtDCMYG5CyczE0o19s+wEBHtT1gIWk?=
 =?us-ascii?Q?lDyjYN8yWUBJKl3uddFFt83tLTgg66oDvdySW9yzM6MCVJJ6AUK5kTUBW/Xh?=
 =?us-ascii?Q?UbgNdi9uJ/PBteeibHj1SRfW1HPWRfOe81RIY5ckNY0kULWhDaau2CG8Wfb5?=
 =?us-ascii?Q?h/RwLhl6ZQq8OzrRXZnJmJNDSSTmBfRvqTttvvT6zSfsliKfWqUFaBxx0m4N?=
 =?us-ascii?Q?916OUcq+vvIrgbFE5PYMoOBgD4a1ebJEDrpH4Le3ebuHbGHZTy8rMXxt9QtJ?=
 =?us-ascii?Q?yzIBwsctIszfRFlObo7b8oUFqqZT692s0x1t7hAxusFqRAoykYzhaJVDOWc4?=
 =?us-ascii?Q?h/dZA6RveNKDj2dql7Z6BvGQyjMygdP0sI1046WD8Rs4C4Z8MLVqu7nRTpgY?=
 =?us-ascii?Q?WMi6chgxbVgWMrQwMdFhDPg1cVxg3RrkhQeJ0/xLXYDsuiy2kTMnS3IXbWH5?=
 =?us-ascii?Q?EBnSvHwIkLLe9cD8dhr1gOloblu8YPa7lmCv1PILJbAmm/C6PrOkHdAbQBeV?=
 =?us-ascii?Q?9yLKO31yesqAkEbkKxWN53gP4xK01CPpdJbVMEBYOXgv36VIrcqBgkwGvPA7?=
 =?us-ascii?Q?2P/P1xeqaTxxBVmxTW4yC3g54ziyrd9ezOve8/TAZKxPaPoYGtcj6A50LoGB?=
 =?us-ascii?Q?6qkA5pzH0TdO/MbfCy8IKAuBPM63lFLkggOXPhWXFsigsuMpTKvI43QBx/w8?=
 =?us-ascii?Q?q536y1zLW5bNSwRBF/eoNGY7uEEtu1UW6twI+w1XkBzhrvRNAHSsaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:08.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be5d492-a7ec-4b0b-c2db-08dd1883005b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

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
index 77af6a59f4b5..4a8f82a866b3 100644
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


