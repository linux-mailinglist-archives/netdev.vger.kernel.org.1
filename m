Return-Path: <netdev+bounces-114171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7719413C7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD028401D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0141A08DA;
	Tue, 30 Jul 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5M60MCt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13C1A08D3
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347976; cv=fail; b=Zga1Sd+6x/y1CJ9ja4YZJUimwPkNCXxmPT1vdRFN3LpuIuqXPYJmUXGvSRmvoFML3zkEvWzkEfPlFJxv9W5kTjAIiPwOi1s2VThx+wRtmAvU9NkTzgD2nM6Ryj6A5NGaLwdaG9Mjm044M+oYgCtHrkTwiIIkSR3OkYmr9o/L81U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347976; c=relaxed/simple;
	bh=nE0ErH0LLaKt8TrvPDM3ffo/gGy3CuzpPYfcoUnEBdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMrml3mtMr6ZY9+ogkclCmSNXoTNJazDeotNSYZm2HA6uNKXuj625lqYzr1LbKONq3rk6AlIewHIbmGmAiCpymRNhc9cuok7N/EkUmgHFXh4MRWaO4ajCvQ3dOF3QT+eEEqO2nL1tCZcrkAJlYkrQqm3COnyN6DsM6xBx1IaAo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5M60MCt; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGqfGa215Vn47jqAUrSfG/9IJ1zEVOWpo3Ad6V1wB5bOznlEeK5yU8utpYGPoQLIOqdtuW4BmlrBLq+OuUgq0+79198QjtyWe0NtAL60TLuP6MkcTM0fo8rvRVHqsntMZff7hSudjULDgPUCO5EoYFz5imrJcw6E9KjU8ccpkurXXwgxdwCdV9d4wQb0N+2yzBTAj7aSsd9Zfy2PZVWaKz2k1XeJZQAYqAigDDHEH50Wq4WdE+0yYsZf6HDhy6vYyNVP8z5/qYpi7RGk4+HhB19GSKqTE/FCPE99yV88v4Ov6a8SNQsGWNwpn/3Av/tZBFL2OOjYwjlepZRwaQZFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ff9LG8cf6Cbw2DEDcilI1j8naFOQPzgPleQ3uX2Wk8=;
 b=NISLsjWn5V7niBYIJh+7IG7WcsSM5V6JC0utSeTa4Frl/D2698hKGlDZv8u2gzNulCqC5rIkRKraCRNXU7xKfIPpG3TGX1TZvk1rOkiWvuTggbGhiWGUZMfta18anlWs4B/iwct5NKdMRILKKNDce7udynLzwq3fllSKv0PoyGRyvokvsLVYU+X0w6eP+N7vPbxY+Gm/h2pZPQFKReG/aY5arNT4/PGliUssFjtwbk04ONcWVLaiVDQRunot8lXulMxG8cr9ooqgidsytuStmVZuJHS6k6gsDHQ8RCEnulZnPtVFxX5VEzsY3xDfdXsuubQQitHDjlVpzckE8lRaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ff9LG8cf6Cbw2DEDcilI1j8naFOQPzgPleQ3uX2Wk8=;
 b=l5M60MCtbxB3gi4t54kgnoxHv9bdwzSxwDNkR767P+lnorRTz6J/LVyB610Qa7140i2W8kN9G6AxuNblNhyFvfOdrrJDosCMHKlpLB2MEkxGqoQplN068r8qEaf5u16syJjZECo4f4Cijtkr8v2AWfWeM1xzZl3zNmR8emzEXiwwPcyq1tJCM0IP7nbed2KqZixqtC1PAxi0mJqHoW662qAZCKpAtqXi5rvZZhq0V28gKJpBlh4YTWkeY+x9vPwfVrlwDGgei5jUoR29oRMDGDTj4PFBJaYxAGUKVnef0eJt8S0rnSbgyv/2Xai7kLvQ6VLTKVb+i0ht+PcS4gOTYQ==
Received: from BYAPR21CA0001.namprd21.prod.outlook.com (2603:10b6:a03:114::11)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 13:59:31 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::c5) by BYAPR21CA0001.outlook.office365.com
 (2603:10b6:a03:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.3 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:21 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/10] mlxsw: core_thermal: Remove unnecessary check
Date: Tue, 30 Jul 2024 15:58:13 +0200
Message-ID: <87f5b8f52fbac0047e0be67a76851b3bd3c6a2ba.1722345311.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cc16da-f54b-4abb-8889-08dcb09fd5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1v2HghmPelx5Rlo2BKsW7vbVWHXq1sKmhwP5mdEGzH3Kiq6I0We+R47a9X/o?=
 =?us-ascii?Q?7Km0xJdm11qz5mNxmHPIyVTVY6eO5xeGny6fW2hc0A+50te4N/40Zjf78+gA?=
 =?us-ascii?Q?sTyD1SqUmLKXNk5n8Hp7iLe6lK7TjZ1jDTZiqdKSsoyB3y/PYqU9g1klCDiE?=
 =?us-ascii?Q?3QKgHw9DSA2ksm7QyRn8lVGkYZggkQKYbP2//jrfbS8xFdEAtLBSFPzzSpMg?=
 =?us-ascii?Q?rBQuORGhpzvtF9so9jazVlNESGeTXI/nCtwX6tNH51zZwnalYG3m7qAwfAEX?=
 =?us-ascii?Q?qzf76K9JX85U1iZZk3BS/27U4+pioWQg3nDwxyokWzU0iDc3jl6SstSPJ97n?=
 =?us-ascii?Q?ntMJUa97CrshBLGI0p7EuYDc9yakIfA8UMOIKbzEz0RT3YLs/J/0SnjEFY4S?=
 =?us-ascii?Q?y6CVV84dEZDcuvWVvBawu/bo0APQDHI5gEoQkBjdM2B9N1UR5WLU2XAtkmss?=
 =?us-ascii?Q?vrqQIue8XcwIr5swaS2ybm+P7b3uFWmE4ciWlBm+vG9649HpvkPdwdbMbzIN?=
 =?us-ascii?Q?Fe0WcIE7FibFsnzzn/2njXSwH6+y88VJxVqEuw0Wjzo7TW0uprZ5+bwE15tK?=
 =?us-ascii?Q?E8woM7wZ6Yd3jVdd416cP7ESeZBNSRtivg7WTHytkOOKulPyvaKs5q0wmW5G?=
 =?us-ascii?Q?heZ1PvK0TLO0iiY3gaR/RDZ1nMid9vfkdBfLGimtBIct3q7XgXhjOnWpVxG2?=
 =?us-ascii?Q?WABVqg2PakG0ag+VH6j9LR5L2NuwX/daI+WWrs1q1hOEuHrJ+HBiV9rNY6xU?=
 =?us-ascii?Q?wkxJAH6kMokqaVCLMfb73hfstJii7oDMJZ7alcCfUKQS6Evddtk4XeF/mw/I?=
 =?us-ascii?Q?evtSrdB2l+PST/T9XO5T5zhx/tCNKcEPgfr0yK12lAg1/y0uHqU5k64e2EkP?=
 =?us-ascii?Q?PzpY9gckRzhpT4DwkYlME3gVZrNOwKMXn+eySZYGh2fR6Q0vMeSRUNH2GbTY?=
 =?us-ascii?Q?47vrhFmqDhBXDYybnwVPxs8zj/i3zIeBDKcYz14zj6AJIE7Rzs0HXqsHKV61?=
 =?us-ascii?Q?roriXdB9KOXN91vZB1cOU2ByKHrcTIPANNIVzkQ8YSxkXmGHBL+FsRw+DqsO?=
 =?us-ascii?Q?woEVoYlPLMJU/ByJDLVbKyZxF2o/apQQwy+CDMfKzA1eKdzicSTaIdYxODxl?=
 =?us-ascii?Q?LONLwMZnaVEf1zNHEceTFByAtp9nPjGR5DmQTxcN4JyRsnhBDlNlIysgOk7/?=
 =?us-ascii?Q?o9ZH6rcaNMhN7trTf/o5Y0jpOgH2ulzjk/+kihtQ3zJGoum1cBRc+pC/e9/s?=
 =?us-ascii?Q?UR49TOANuGMGaC2e23l3WyCeqrKPsolvrGh6zD9RqnMMvbGPExtB+7yxVjPE?=
 =?us-ascii?Q?eJV8wSoX2l1iHsjGuoqL1c1FZi2bm7h/JSVDFtnkidYhvYvyPEBrIbN9U4Rx?=
 =?us-ascii?Q?K+ITFZUQPO13C1nQN0uD4Xl9Sj8i9bkV9oHj6DasqNbYHkFMli9k/uPZoIT3?=
 =?us-ascii?Q?PQDJWR+gNu2xVvCvCYYIpa+QC5J7QBbg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:31.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cc16da-f54b-4abb-8889-08dcb09fd5ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

From: Ido Schimmel <idosch@nvidia.com>

mlxsw_thermal_modules_init() allocates an array of modules and then
calls mlxsw_thermal_module_init() to initialize each entry in the array.
It is therefore impossible for mlxsw_thermal_module_init() to encounter
an entry that is already initialized and has its 'parent' pointer set.

Remove the unnecessary check.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 0b38bab4eaa8..394e4fd633ef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -453,9 +453,6 @@ mlxsw_thermal_module_init(struct device *dev, struct mlxsw_core *core,
 	struct mlxsw_thermal_module *module_tz;
 
 	module_tz = &area->tz_module_arr[module];
-	/* Skip if parent is already set (case of port split). */
-	if (module_tz->parent)
-		return;
 	module_tz->module = module;
 	module_tz->slot_index = area->slot_index;
 	module_tz->parent = thermal;
-- 
2.45.0


