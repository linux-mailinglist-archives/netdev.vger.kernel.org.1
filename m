Return-Path: <netdev+bounces-111564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341A931944
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D285FB2213F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A084D5BD;
	Mon, 15 Jul 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8949fBq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA54C62A;
	Mon, 15 Jul 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064535; cv=fail; b=BvEcXP8gh2+eSDZBAVnWpot3m9uouDyHHs/K3KWejbo6uwkwEPT/o7YVAxhFXFMbI4E8SSPyVsTSccpclF3e3fc+Q7BvINWpJ1MYTcmmZDD+NguiZ9CfhB/2ROXBOICcwrQWlGU6L34+4HVV2iiAQ1V5wlopGTocoAY3+A6OQP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064535; c=relaxed/simple;
	bh=F8GS8p34b0XV0Mca70ix3TkEkexLAGl85pp7ZlgDGf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc6PTPv6hf/pu2twIH4cCILwonaRQ1FW5zBKHwR3sSZjXNLfnWTwt4eQML1y7FljUC2xHZECcDxJMK8Qkd8IX0zpzfpafyQGHvp9Z8QYy73uWdAX7zSF6SWPrdp7T1hVs4JhnQ37imGvfdntBkhrksg0UZOthN/tAqh3aNt9KzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8949fBq; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZokcBjthEsfakMuIdGH4kBMPTd5+5PV/yky0d5l0iTenoxjUYZq5WSyv2G/BTZkE2fmeJORpkzIZq0iqF/KFqSh5BoD+QQRkzi5DHR/DME+IJS9Uk+3DdynwVgQRKgZ2mt7Mn0kgEJM6/Ces8AaGgkbrWIWPBsAIxbjb721LA8P+DSnOBTnDK+1cF8ewaUoVbZbKBdF6frIhH9Hy8qcruM0WgFhfmvecuBqYQIDBP+dYkX+3wPMKBTK7ze5lvcGnSszVHNksJSI/NOTqtBm1dbhhrvMVRikzkG00R+jrgyb77WSfyx5SP7GDwKZWJq+Badr3Y/9V8JfEiE7LB5MHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPUzow2Cq0ECdT/dOJDe38VC/lapsSkFdWjr+H1KO3Y=;
 b=kv3pMzOTOxE3bb3QbsXU1ZpqCGMC6DiWQ0diheOXhLCvi5tLBBUB+WxozL6NtTPWkS1TJEzVL5YIQql5S4Eenu498tGYZIbnPXcKEdIL+kDCSdu6wHTQW9VAQM3hCys/g7CnUXMYCflWBoA2OJbO/ap6Bo9kMzJBzhG6Zn1my6zy+ZVGOxDWUD6gxkvwViVpxP9AODvD+Rkqcko/78tdJeQ92o/gYcPVltA5JI+koaET6BvJpD8lggMgkeUjFrIGLE/9xxP5zz6QGS9n1lPEMdVrfZXaq4usdMURnel0CzX4aRqw/D9PJ5/T3OB47TGAooNxE2MedpMgrWm067zzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPUzow2Cq0ECdT/dOJDe38VC/lapsSkFdWjr+H1KO3Y=;
 b=b8949fBqZygVmlp9m1FDgdOa9VbDkIP+2ijvYAkvXljVEyV0SVXfYi4YOWji/fTTTn1ahkoRzt/bs7XGrg2CyR2jsQv2Tf5FxH8zYlSIla9+VRcWGQHye1oQ302CqFCHaQ7zQL5eJFX1q5pqz8ugSVtF058d55F7pO+0r75a4js=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 17:28:49 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::d5) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:28:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:47 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:46 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 03/15] cxl: add function for type2 resource request
Date: Mon, 15 Jul 2024 18:28:23 +0100
Message-ID: <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c7fbf3-99a1-4a1b-72cb-08dca4f39633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7BkGHQSmfSWlp2uUygq1exiXG0qpIrCEFKKUcjCwOEgZdQKdo77hYwam7SH?=
 =?us-ascii?Q?v0FuIiTqEj01w1DAYAQUNHx8wkOb1paTktc0ZgVXbr0kgkoKRzf+9HkzB55E?=
 =?us-ascii?Q?RamUYo105KDNfAift8vfZE8+nYs0zHW1OkyNW5hhdbHKEa8yJN2qRlpqTYZN?=
 =?us-ascii?Q?VmGBpL8mRDu6g4ezqtDZs4KurOCck7s407N2CCVXgeTQrMu0pqp6w1wA2VPf?=
 =?us-ascii?Q?qC2jrw+Z2MMSvfYxzZkUQhcEcvUcgMDMfG94J5vC3dEKtuV7LZHrhD+SYiCL?=
 =?us-ascii?Q?j8DX8WUBrGALQLF09+sE+Mj4ycBSCwBrqUcPWwa5N2clNJ13EVk2W1Cshwua?=
 =?us-ascii?Q?iaq4I5hf+qXJc/w+gcm2Llypbn4b5txxetMyylIxptbqmRqNwaDlDX67txBJ?=
 =?us-ascii?Q?OWooIWTAu/3qGVQz7B+LXBCIjUDCpDmTB7zO4kJ8rD22arMaOLgzP7br2wrR?=
 =?us-ascii?Q?zP6q2al1JeNQUE3QfCv6KbmzM6F7KjwoNA7IIzkWRfrTojyIfnWFPlUhL4L7?=
 =?us-ascii?Q?q4gCqxmHpEJNwlJZKBkyUhDdMMWCL+lqD8gpXiuRgVTZOonJxeTgmncrJ2nc?=
 =?us-ascii?Q?5K7OY216jJBgXeKU7cmSDuBhBfyVRwm6ADVEmKfyG2auvtDs+icIEwsEV8GB?=
 =?us-ascii?Q?kmUJMDuvV0fo7OXHKkFes0QiC8+jPPo44AgR3Cv4uPvrtx9n9KVAxL/seTQE?=
 =?us-ascii?Q?f6oOM3KNpUK4qKkXjnDfQDwg02+gR26x1qzFE74qlicL2AqdKVmEFKdEH8rj?=
 =?us-ascii?Q?FudAhKJtXwi1gTLTzld8ezJzzIbwqs5g9/wHzW+hTPWuYJNNLGINZv+DR+FX?=
 =?us-ascii?Q?MkGhqmJQpjNnJj5kYG3998Xf9UYjGp7wQLMLWdjxKx9jQOaYHGnn7JipLHZP?=
 =?us-ascii?Q?Za3Qm2MwiQmYhxu/zj1pLqn5DSATxgcHdNjshymOlNo27UtoWhaLL/G8Twfd?=
 =?us-ascii?Q?JC+N84KVBMTZirz+PHp+MiprTBonGyEHrEK4PnhsSwwuxaZyyWJNEzqgZmE8?=
 =?us-ascii?Q?WOuo5TUD0s+0h9Q0hxTBOB9QrrypzrbCZgA9qj/qgZEaF0KeQIbFhImv+1U+?=
 =?us-ascii?Q?ypLcUlYUiZKD4VpkgSJ4l85iRoxgyLsLt2YT0LLWmWEC2E2IHgHVw48HBmmB?=
 =?us-ascii?Q?F6lTv6nOseH976y7+tPMWFZjcFiULwTkkNEDyhyKsTn+lcltk1Utcupp2U3I?=
 =?us-ascii?Q?JaKHIaApjaF31lF+gGtswRJQN3Q+3VvqyvoChcixVV4/ef0RBnBh7dCgciXn?=
 =?us-ascii?Q?c9nQ+hcWW4/YUBzWtFoEkxgLBnWl0LsliznG+jTzmi+4Q7xnRdnQ4tzVmhFM?=
 =?us-ascii?Q?QBKw08xwn41SixOX6FGJixM5XXLkcqu/1OEVkfROHcYByXvZVbUypNYE1YAX?=
 =?us-ascii?Q?2Cp75UOo5ORtiw+Vu9p4NlN2CCaWAgHcMLgNzALjJ8u44/MXEjOSC18qUctB?=
 =?us-ascii?Q?IGU6iItrZaE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:48.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c7fbf3-99a1-4a1b-72cb-08dca4f39633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device requesting a resource
passing the opaque struct to work with.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c          | 13 +++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
 include/linux/cxl_accel_mem.h      |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 61b5d35b49e7..04c3a0f8bc2e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
 
+int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
+{
+	int rc;
+
+	if (is_ram)
+		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+	else
+		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 10c4fb915278..9cefcaf3caca 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
 	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
 	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
 
-	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
+	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
 		pci_info(pci_dev, "CXL accel setup regs failed");
+		return;
+	}
+
+	if (cxl_accel_request_resource(cxl->cxlds, true))
+		pci_info(pci_dev, "CXL accel resource request failed");
 }
 
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index ca7af4a9cefc..c7b254edc096 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
 void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 			    enum accel_resource);
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
+int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
 #endif
-- 
2.17.1


