Return-Path: <netdev+bounces-136675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A1C9A29F9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E7B26D22
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8C1F12F6;
	Thu, 17 Oct 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31jJ/S81"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D81E0DDD;
	Thu, 17 Oct 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184022; cv=fail; b=qTzjHXSon1otkb0tB+sdAdEYqvDm7wFf5jpcMTHcLa1BJwTGOX/NM/UAXmlPMWIKrk8muGDFelTdYhmBq7MyW2t0GDFlmPZ0t33mRzX8Vfp8d+FYj2Kl674ODnhkYZC+CMdOHFwp7cukYbcdikIuptco/21bNq4HfBSkoKb6LoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184022; c=relaxed/simple;
	bh=uoTeAru+AULjKEYjEAA7d793qX9lt1QmaPyMc/SMhHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDflwDeksaNKSQ6FCRZDFSFjQA29nNTIbTXsXcxhiHtGeBn/5Qvu5TgHBgSfRMT9sjMdKA1UgYSwRhD35aGs0yPd1Mm/0lIKeqnnRYxTYwQhzEgCHWZSjstOVa+YMrnE4KJGFWSsPQQCvwia3V1acVKea3jYvhF4oAOzv/pcXNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31jJ/S81; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy7BPm5n576Ly/YHc4wLVUb7Dldi5s21ExfwiQ073ILguYryq1feCDkTGZVdJPPMZVyYse7x5FYkfm9UKjAIBbeiwJEoOIV5TUmRGcw2gJ9zauIgYMCA3ZH0NES3FKFjDaa+KqmVFBbld4xgb0HEDaOdkrhlirtZyYOZIVK2Qwe/cC2Vs2ceS4m6GElH8OQc/sUI1Ggj7S+Hj+Xs+3+jBn4tcf6nSSbxPIq2nNvijDRClpyMhS/JJALKys+EYfa8qQN/uSiUVSeGMauVtW/FL1T214yGtq+2mh1hTsaPKeKkzCXuZd3hFZ5nLop0sShBqNxxGZTtitBoiTlquX7Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJJc5TT2L8CBAwMHksOa16CHm7CWZpl0lX+059LDFuc=;
 b=dq8M2XW7RU0aepkXtAPFghAsXS78xWyILxkbsU03hx5nfAnUsymJIFGAZJNTAoeinezmi5OfhZ/URBIGL5y5l960xErOTKdQHocCDH21ThuKB9XTI7YpkC9B3or9cCCnorjNq89t5QVoie3dRQ8TnFIjv8Scye8upoPvhqmp8MlXMHSM2T4FVqEdFSWarli6SAuHmye/ZBj8Hwyz/hgGArAsyYkVpZoZ3TZrvm48Y8XG2mgvlW/DuMYFY8iLQ/sHBuX8zU97ThbetvZAw6bixGeFW1jOXwhgw1vrGxuC5J8l/Y0XIgVbQopCVzFlTwcN0Oac1VMib3/1YdRxEbYf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJJc5TT2L8CBAwMHksOa16CHm7CWZpl0lX+059LDFuc=;
 b=31jJ/S81+oqsSUjbgKFmH7VqyIuzIF3W6qL5pJc3TtSO1F4yYit2OF3qWSn4+gn+RDqPQpZ73q8dh1pLK3ukKOzEm3EUJGUXQwaUkHfmYem+f5WphRUNgNlPPEQWLDJ7RDa2dZkOFHjOUlHMKpEN7xDyTF+eVS0KT63aIJjk/4M=
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.31; Thu, 17 Oct
 2024 16:53:30 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::2a) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:29 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 12/26] sfc: set cxl media ready
Date: Thu, 17 Oct 2024 17:52:11 +0100
Message-ID: <20241017165225.21206-13-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 186ab2a4-3031-4f89-0252-08dceecc3a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8G3Kl8/BC2KYQSXRktFEmsH2vSfB6P+Mz9Hy0ZySvEUSisVus93GzNDd+uiE?=
 =?us-ascii?Q?zEKmrPDdJhRKR02+bK+KfaI4yO/hoqq+yaUsnju+ay3jhSGu08IFaJbgAmNp?=
 =?us-ascii?Q?vkGNR9u9ujRNkQmfMWkQktSLpQhpjnTmmJLtrvoSVBIjNwV3CRS2kZxg36M2?=
 =?us-ascii?Q?xFcpgmJ9nircwwVDBs51Pbr82TuOu323ssjTfgmOu7+1y+dCXeVIbUTbZdVM?=
 =?us-ascii?Q?Rl9ax8DThmNygJkSUfFNvvlzGrAAx/WdCsN9sjDpJOWdsTCZowCCzdYgt6a7?=
 =?us-ascii?Q?BMjOQOfDMplbLzhOB7OOVcisU7g+mTOcXlWr+nCGiO8DeVsnJzq+gGIXXVov?=
 =?us-ascii?Q?6gERXcZJOU7G6gnJvu0q9Osj2WhytnXw+BXlx7p7d8TdXyMDPv/30nLJQq/6?=
 =?us-ascii?Q?ll3Rlqs72IW5QxxjisA7WE8dNHky4nWPfpcQKY2LF0WMrmesXqtypPoJ+XOE?=
 =?us-ascii?Q?KyJdR5M3W8SRnnEBoJ+VQmEJG2vICtln21OYaWEo1l2SeJU7Myzf9bnafCvI?=
 =?us-ascii?Q?WmAiO2/WMAu0aA4AKYqa6143X6iB3AwWDn4cAaLH+IUqrrMHNmtvr+kZZ6NN?=
 =?us-ascii?Q?gJKV1hBoJ2yLJJ4OAL59OzlUS45qsl78AyXnwFjiRx+bQ3jF3VT8uZGJru94?=
 =?us-ascii?Q?wZ4nubv2VGfJkikvxN0ZoLV0cbitXkKYoeEdfP659Tel81572oQRLCkHO/Np?=
 =?us-ascii?Q?LvmlmLXkkaEHGCp4Gf1Rv7guv6RD8TQlG9ekTTwggOqmjDYsT0tC0+uK+hml?=
 =?us-ascii?Q?gu2/jRbpKuH0ZRr8+AcW4whl5KVUuFmuv8oYIsrOunC8/6ZM1ivI8Yljs7bl?=
 =?us-ascii?Q?qOKWc6tGqLrmAwYMFMIENFpLJGfLWNCSrN4cYWPnEDIHLdY+bgImEuHnh6jS?=
 =?us-ascii?Q?NNNa37qEiCKr+BNmOTxvuAjSoVtMgjuP8YFkxKJbm20bvkdVfICb1Qc0Hlun?=
 =?us-ascii?Q?17XRc1hab2IR5e4eCDymCpl/5xVdRU28Z2FtfruWCUh9Hm5O3w7z7uf5aAvB?=
 =?us-ascii?Q?kxs+XWNIj+YLlMh+L2vdH8cIBpToFGNCcAGXN78DMFmmPb857Gtt/09NNxsE?=
 =?us-ascii?Q?noY41z6IxbiWzWk/MCudAYV12YT3OaFGR6nTvFT7w5qOKEkMEe2eHiuJC7cV?=
 =?us-ascii?Q?RXsH/Y+5s3LX/nAFj0zexPGS9NAPBLVb2BY7IbwocfY1zahwHyMEXGeJxnGY?=
 =?us-ascii?Q?Quwa+hkDNXdFcncZ03s5IJ/ZDNUnbPzxxFHlP3mOAkhXW44rEVcWnJFGPHnl?=
 =?us-ascii?Q?nsf76sgd+wICn+1l8FG3L4GG+V2qjfLHo7pKHZ9qMOnTTZBmgLuGYYYkEz74?=
 =?us-ascii?Q?QWAVg+zQ/7Loqyx4u5WXjkfwlbhe6hQcZyFsc+u5ZNIDTMXUdGjEOi5bPCzj?=
 =?us-ascii?Q?SXVACBg22uNqELQxxCHz0gF9HJI6U8sqxSkoBtosyDBTYXvn8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:29.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186ab2a4-3031-4f89-0252-08dceecc3a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d47f8e91eaef..419cf9fb6bd0 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -89,6 +89,11 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err2;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlds);
+
 	efx->cxl = cxl;
 #endif
 
-- 
2.17.1


