Return-Path: <netdev+bounces-190422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270FAB6CA5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194918C761D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556427BF8D;
	Wed, 14 May 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2el2m7qU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44C279910;
	Wed, 14 May 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229291; cv=fail; b=RO05JdZPbA5o3sIbaIsz8vfVMHMPdLqYZ6fV1m2ycelX7Pm9OKNbTMxgikqFwSPopogm9W7FhXEDg2oxiRtBp2J4hu0S3jJC5euueIu7pP/N1KgjIdfULnUlkY9YDyZXGQ4wuKqY4PuyJtOYa248bPKMdjTgkW+U8m2WAF1xiOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229291; c=relaxed/simple;
	bh=b3/emHABQImcm4CKlkSl1DJB2QRMaXLHTUetMk1J0xY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZobmrCEiTn6i1ah9/bGWj1RMQ+h6hauVeqPccuCm6oXVIozGt8dnzKLqPscgh5ICwrLzdgq20EYX3BNV/NAVpz+g8PZgPNxoP5Hi20M+U6mV0U/3qHkkMW2JQc8wx0b8SREQQJLZo+IC5O0y9udp7nqPjLs0hVRxm/VEJJzFVxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2el2m7qU; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn522lfDIhnX5/S9K3WZDUmofZnGsuA12IT/P5R7tLGKJPcXVrZFnWO2pkD6vAFoklyMc9+wjzqCcyzujChvc9iuELR/B7qczk/c3MQeuw1nv4a8RtrnQGQkytkuNExbB2Jy+GoexEfj0Cbb/ZamrCeveqVD2/z0AFYDC4op6dBTYKqFUwhBGNhP4AIrRLEO+OhhU9uNkoGEc4Tnn9GPEy+yC9qINARqTXlBxy8jX6k2ad9f4b97DF1gLgKswjWrlem2NwEzBpcDPhHgWVty9wI1qIOlKt7Rq9sBXpt8Xifnm36BlkwBIG5opvqCDywhPlZZMjL1HvqWMEGEdVLFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSBn0k4KzrXNMgZKlb3Z1/V70GGJQRvnGu2YO6I2Yag=;
 b=gWhoHyGsw1ndfgd59eV3LUHZnDwk9mH9ItXkk0FaLqw8sDIu0T6h61S1gGeugsHfZygLyEZvP6YJ25nPUZ1xWc2Ol0zROtcM2GMCkOjm681i1DzFvE/tY2+f9e7+zpXw7KiKEsS7G0DPOZqW+MYsp4Hf0ITVrZ5TvUHp8vw1qZGuH3K/vd/A7dpaaDMqytew8YaLj6HZNZfA8RCD+IznxqeUfiliG/RX3vRWyMgyksLTIidBchl5z2ZHlxY/MtjvSJVMvo5D/r3pAmMqL7RE6xQwLV8N8SiDJIiKLC06sAE+7K9g8fYap0CotJr5oIeVohVF/bWGHugVcKf9y26Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSBn0k4KzrXNMgZKlb3Z1/V70GGJQRvnGu2YO6I2Yag=;
 b=2el2m7qUghfNO+L3/a68TH0iSphLaVolW1GX65OEz9gYfQpKBbK4+nHtZx9mpnb6JxzCr90Pq6tKL5aLmI5h6Jz6RmTJzdk6zu9K2wM7Hd5AJzwsPvtuBvrDc0Es3Lctis+GJgatq6rz6T6WmdNdo9ViwZ3JGGjL5qT2wHdczkc=
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 13:28:06 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::39) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 14 May 2025 13:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:05 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:04 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v16 08/22] sfc: initialize dpa
Date: Wed, 14 May 2025 14:27:29 +0100
Message-ID: <20250514132743.523469-9-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c0e812-2c80-4f74-91a0-08dd92eb2909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BmCAllNQvHMGWf6pDf3vzIfBIW9ioYNhDS/QxUjyAOECnuFy6MpH8dzlLLn8?=
 =?us-ascii?Q?segE0GechhlR51vGh2ZQRLBX6XpwOub8oYbXfSTRH9b3Mt/ZXedzoUc89J8R?=
 =?us-ascii?Q?LZ4BWf972w6eQO6C3wr4/TK01CjxfG0cqO4to8MrIqog5T1pwBFQSnWiQ7nz?=
 =?us-ascii?Q?Q3XVdZcpgcxVeiFfxc+SYu/cTBUsj8Bdp2iANGAftwpoZmw1hcqS6xBB4SZR?=
 =?us-ascii?Q?67WjUxbJal4YJvQRjcObpkEmZsM/jGlQ+XcAYGNrWpu6lj9M/iAcsEO11PFo?=
 =?us-ascii?Q?3T5fBqog7iZJVBjErWv8DQYWhPveh0QSB2Q1bfzlZ6GUBCnxi6gSCzea17nN?=
 =?us-ascii?Q?tZ9msJD8NLj/VkKl3fUYu66dQB/uip5URjLyEEpUgpglIAV5USeJKXAAWQbV?=
 =?us-ascii?Q?r8BWLRnwMUxLfgj3e8rxtc4JD4SfW7RpVQuJW2h+NmngSj4RIfDf1MkOTeBD?=
 =?us-ascii?Q?icMUSEOCGd5XS/rOsSKWQxpvbMeuGTmK5sDa5Ht1XRXzMiXsCZg5HfOSznKr?=
 =?us-ascii?Q?at6HgKrutq/Pj4jEC6IO+x+AB0tMtdcToFnjKHX95TucnBs73X9tXtvRFuvc?=
 =?us-ascii?Q?81rxMJuKuczXnKFcdQaXyFyEmAFOwp1RE78rVmxQVVXknnigXqDe886ObnUW?=
 =?us-ascii?Q?xfkVWRuUMr8HAdFv50ANhJOjnrdXKISOaGzlWMjvNoAOba+rYNmmTlhU8KqB?=
 =?us-ascii?Q?Q7/Od13gDoD94jUGxQOy+ev3OMDMTStC3zeUbz7fUk7y1R+g7S9RGfUUaaN2?=
 =?us-ascii?Q?DzCMTCyKmyaaUS2G0qcq1X0KTQg1+MsHPXbBRpzPQ3ZA5Pi0WviuFCx/awcE?=
 =?us-ascii?Q?25UpuOMaymGNXVCSTzyWdFllTIZm/gOFwvnUZ+cvcIfatEDE7UXli8l3rs2I?=
 =?us-ascii?Q?DlP5wRf+sqWppOR/lW9Nm8kG2d7n0RVH6dfvxVOF8xQE4PTWRCucSPwX79n+?=
 =?us-ascii?Q?iQHC0xxZv6V9XHQbtNb3wfPklknwWkgYvR5WF8y4Et15kx8fRWYMDhbtwSxD?=
 =?us-ascii?Q?ZHlQGY3PuaEk+MnCVOl9u9LoR2Vc84KIdOvsaUf1jbK8VZGYG2gKdGFEk+vy?=
 =?us-ascii?Q?hYlcWvGJITex9JWYeyMkwLaVRGvHnWDJqnsSjdV/5H3fveb1IRCoTiVKNQfr?=
 =?us-ascii?Q?j2WhpzmSO/rUiNxCGZ+kKIBpial2zkphC6I6j4dPmKySir89vPqTsxwRyYvJ?=
 =?us-ascii?Q?jZptq1W2qY7vbadq8VsZ1JvDANez7SB6g/sX0N5BIqLtMThg3a+01zF8QN5g?=
 =?us-ascii?Q?yyAeuDcUnhDzsfU8M040NtEryXLv/OROBx1Fh4OHEd78sPa0HNws6wplngrP?=
 =?us-ascii?Q?u4XHTZjq4LALBF28BbCsTdqvssniusLczB56+0g7X/JK4ivqgPlHb8S0Hxdp?=
 =?us-ascii?Q?Csoip+p1CUcOr1Jlsx5uiggFRWTBWsW+JzBc4NNzchBc9/1TSyRHZjkfFgPu?=
 =?us-ascii?Q?oeh3fZrbioYLSkUkdBSv0XL9+CVqmqiVaSCdYzNyyrEJn7keW8gaUNg54p3m?=
 =?us-ascii?Q?YbxE2yiEhChNosQ3HdTEOUMS3Wu3zlT/E414?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:05.9502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c0e812-2c80-4f74-91a0-08dd92eb2909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319

From: Alejandro Lucero <alucerop@amd.com>

Use hardcoded values for defining and initializing dpa as there is no
mbox available.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index e94af8bf3a79..aac25d936c4b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,6 +23,9 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct cxl_dpa_info sfc_dpa_info = {
+		.size = EFX_CTPIO_BUFFER_SIZE
+	};
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -69,6 +72,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
+	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
+	if (rc)
+		return rc;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


