Return-Path: <netdev+bounces-114173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D819413CB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A891F2464E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C971A08B5;
	Tue, 30 Jul 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LouQETa9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2019D8A6
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347983; cv=fail; b=flhcv1uhHyA4A+s4jxvIBZSYofh39ex4m4fxu9R/qnr0ycqh8vlrW4COaBQFEOMJtRZ13I7wdtdgNvK4sCfdTFbFlISavrrgA8CFJ7Wf6aSKMveIeztYuIgiCvnsXHE3eLNAlSbOyUez3VgdaUq71Rq0pcJHGynYbR7UvT8ySrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347983; c=relaxed/simple;
	bh=Bj3lZJfdkSVrr6QF/Cb6LVGUhuFolVthGB0SKBq2H/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPuKMY61BLTKJWOldrWcF5p3sHObJXhWRSf/J6mNvt5PKgOBnx3W1+/oSFHbYzvMo1jn5CMfPxdTj47ZpyXNg8O42DwdJCsbMTNHe4TNpIVWKgFDRz2HUQkQ0F3q9puhiw8aaTMy3fhj3hVU/pqviW6cScxnVy83wRafE+8vnNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LouQETa9; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2P4hSOG5AUHaYE6FtAJxLwUFMJCS9vkdvYHTMTsvJrTY235ORzkqDVdhK/KtOrMz8UTnzMXowFEnPx6DMZAZVs35sD4aK7jX+62K12Y6y2oEKR6NJYBgYayvNZ//VmLF6VvLCGMYwIFkkKRXSNuMG1u6Kz4bilokWM1Gvl3PJBHek4hxMr5FhjJZ9KVpiYmSCDYEV3fxnOHwHrgfk8HLQAIuoTaQVNlpwvMEjAhkwnt2lVKva4wTpFBzYnrRMAhW3dmDAn9aLCJJcWQCrfNccODx0U2SogHTxWJ1EIth1polPAG9J5v7iIHZeIP0W0P+54XX58fz0crRR4WXPFGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA/21JfFR/kAhQ+nOfRYhWRqHJiTIIm/aGA1sUmltUw=;
 b=TDfEwxlmtfPjH8ObA9qjwKC8NuXg8aZEYhikbrN1vMhN2SNR22yzIp9+c1iJ9d7LzuHP8Zy055Um4eLppxdfPdtdmuM1YdcIFQKZMz2139nV36rvelgpy0oSSh+3gwWhh6UeoWmFHHhxkGmhlKXrWuyUQo6NfZOK4Hlmp1Kvvve6l6HM1ZhYIMC93AneGihxsZIFAbeltxYqcV0QvUaHMlDkqkabxl0GtzTG0uvFDVak/jTBud7p25BXnDqHfrv4GveNbytneI8ux9r7tgpuAwGBzcXXAGlYGTZW8Wp+335bQ2YbhurFW4hHDbRDGjOCB0pCIJS5TQz9PmXa0gNGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA/21JfFR/kAhQ+nOfRYhWRqHJiTIIm/aGA1sUmltUw=;
 b=LouQETa9Ob3XEncsLraviUYqhKMygFLrjCDor63FfWQ3s0u4/ka4XsNTRHh5lffyZOHWaeg+/PItQiqDtww46BenEjSWxfnaPqCDHNqAIR6kiUlXUeBecCKOXMQ9J198OgQ/g+5YfvCmumQ5e+96Vm/HMCe2B1VFIoTBW0CKG+8lvFKKPdNB44BleK2D4l9aSHhwetQEzkuuLLy20YGe8qiOBVy6ycAaEOJ4k2cZReiY4q6r4Cxd5SpGLntKuFkoMguTkrQmSMQ/Gs81UsyCs7XgItzROyiKpumFnte0eqh1Pva56+7s+FvsqQDlinI4hcXUAGK73deHvk5PRu+pAg==
Received: from BY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:a03:1a0::42)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:59:38 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7c) by BY5PR16CA0029.outlook.office365.com
 (2603:10b6:a03:1a0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:26 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/10] mlxsw: core_thermal: Remove another unnecessary check
Date: Tue, 30 Jul 2024 15:58:14 +0200
Message-ID: <fb3e8ded422a441436431d5785b900f11ffc9621.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: af3c4db5-713b-4c71-bf0e-08dcb09fd9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQkJVxW7w0RUdYxawDI39l1jN2HXXnmfWgqmtjydcFuZTUHF4bmkXix7ofhK?=
 =?us-ascii?Q?7UatOR/DlrBvO6wSvhBojSEt0aTohBaSRPYZ1Y+21ow3op7J5wKV2hes5YfP?=
 =?us-ascii?Q?r7HtAurcc2wfq/NYG4SEZK9bFqBEyutfx/YUgXOmXvH50Hg6GdDbitXUstGV?=
 =?us-ascii?Q?8l/lESkpn2+6D36MJUGjZX2Q9OmmxE6vuS2ycibTLCfTcYfcjgQ56jXi53DV?=
 =?us-ascii?Q?MEb5KmCKrH4hO91d83AZhagMrRqm64q4kiEbt3UmfNmwH+2f0VeRJeux4yik?=
 =?us-ascii?Q?Vzu3rBadKcil/CVYcx3S4481RlexwxJCuYO8t5LbmFvEjyt2FgQv6hL9XZKj?=
 =?us-ascii?Q?tYKBfg6sXbRiJZXDLq2OYvR+AVC2zAcTyXP4jy5A0BKBz71p29B2GOK9Pkgv?=
 =?us-ascii?Q?qOAM1Dl60toebFlniK9OQLA+vaVF2WwumQsNRAkxNcP0DTDPy/bHt/4Y74A/?=
 =?us-ascii?Q?e9kD+b4qHZD1PF1RvkKiSgOzzL1tvV1bgOq5KrvZ+kGnpN4EE9FzeSkLtVeO?=
 =?us-ascii?Q?y7D2DvesQXjC6fd5SJ61KulXsEmUz+tedFCVWCnunrU/LAaTvV+KR55cbLaT?=
 =?us-ascii?Q?rKgKulAT+4y+QFFsKSqf9PTEg2MJ74+rdf8eyCPn3bVclntGU1A/gvaH+K+P?=
 =?us-ascii?Q?SCN1XSApjdJXvzGBlhqWLeajftB5lPPkTmwM3MGGMwJEHrOOFtXsGvVOSKIW?=
 =?us-ascii?Q?RCYYEVlsobL2qC7v9Twju0ozYfcHYV4pd10edKzaWzd6UIbQY+qJm3jbwLMK?=
 =?us-ascii?Q?589HVDDNf9z9TLyZeYvJmXA2vK5pM6+BBQ7myKxm/GwngsfwVFicE1N0zrUD?=
 =?us-ascii?Q?yFsI7ocrFOpvDj3MElQJk40uXR69ZlNTbKcTsdUXtZxFlbsnBhbaVhsL/Slr?=
 =?us-ascii?Q?hclE9GfCDKcV6+RqZJQZ9D8ee1bDcyIAQjE14YJpJYXez9QVe+xjs9LzXnHV?=
 =?us-ascii?Q?zarVysZ1LKbzi/rmW7/TOS0acOLHBKnfOdUHMch27fqYk4g7tOiVmP37dLqu?=
 =?us-ascii?Q?wwy55enK6iVrMS6R8Yd3qoQbThH7eCSa0AxzFMkQk+l7qOR/ZcflhHIFAubj?=
 =?us-ascii?Q?cpGZKbE/djiWSdXYV90fFNOncTYy7hS+GBm8Ut8G27DG3rPGNttOgH0RLaxZ?=
 =?us-ascii?Q?0fauEWOKWgs4sL7+3anHW4lkLoUbxyWNTmdl1LuYsSUxeul7g/ey73H/BART?=
 =?us-ascii?Q?qo9KUQwzaSDNIVa2UW4iyd19G+oBgWRmzsOdgpatHy/JmjK2gYBN5AAtJM1P?=
 =?us-ascii?Q?SkgoE5piKUOAMtOSNOTo7FPMEfrzYdOXatblnhsaMrrelHRMfQeFcqfs0kmg?=
 =?us-ascii?Q?BZ1Br9ehvwjj9vPuTBF9ey8e4eW3DuMsdoObGwM8KVS0Z3gX2jqvlVD3WRqc?=
 =?us-ascii?Q?x4CjwWmSsstK98bJ1qGtohPIW4p+nfPpvZ8vsELbxov1e4O2TU1J7uyZ9F/P?=
 =?us-ascii?Q?ReJIi+wPWSuhnoPjer1n36uDax3A9aMA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:37.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3c4db5-713b-4c71-bf0e-08dcb09fd9ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

From: Ido Schimmel <idosch@nvidia.com>

mlxsw_thermal_modules_init() allocates an array of modules and then
initializes each entry by calling mlxsw_thermal_module_init() which
among other things initializes the 'parent' pointer of the entry.

mlxsw_thermal_modules_init() then traverses over the array again, but
skips over entries that do not have their 'parent' pointer set which is
impossible given the above.

Therefore, remove the unnecessary check.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 394e4fd633ef..afd8fe85a94d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -505,8 +505,6 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 
 	for (i = 0; i < area->tz_module_num; i++) {
 		module_tz = &area->tz_module_arr[i];
-		if (!module_tz->parent)
-			continue;
 		err = mlxsw_thermal_module_tz_init(module_tz);
 		if (err)
 			goto err_thermal_module_tz_init;
-- 
2.45.0


