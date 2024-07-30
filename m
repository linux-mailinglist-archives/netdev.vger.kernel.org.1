Return-Path: <netdev+bounces-114178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D239413D7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5474B27CCD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AF1A0B16;
	Tue, 30 Jul 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TsY1eaYV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553F1A2C3A
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348012; cv=fail; b=lQiisGXY+5LT8lAuvpCtPhpYEqDtY8rIlr9O1NmZgwYU0QZsojCho7AwevZPox2Pa7LX+wRHbPoZfFZigC7EMEzw43OVM4eRiacu/S+iSlQFdsMKztpbvfAOndfP+xJt7580DHj16Zn+Cp7F4A/xLQVC1587sm4puL/tUchMxt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348012; c=relaxed/simple;
	bh=uZDLtyJt9/PkRVL8+5ZjpRua9kDSrCWjFmEaRpfeFVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AugQNQB5IY2dLT5wuFu4oNv93j4P8VxXCZKQCoKtOgb58xEVUcsDYEUbESfrTfclF5oKpLtCBoZBO5Tirk9WYNoJranKxNrGhIbuedxK68q1zaHeEvZP3ZMqyivWHpSKpW/5IM9Zb8y/XfiY2rKsedbYMDqfTR45EumoPx496+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TsY1eaYV; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owsGyWpfu5i+x8COGTWxdaVjlvHBo3vdDWwmM/QKnpRMcy2174rxoDZQgKRzF1BioW+f0XA88sUgKICG6352C8X+GTDztYcEJ1as/C1vtlyJWUaIu1ESNgOt6/krTpu1OQl6P2sVxlAHe9TCPciRIcJbaj4eoz9byfMlNNEF6+bZPtix4Jkvw4Xaqva254OB7CF7NxctRJDHfPk3r6tzUP2cvgO54RZid5zY9RNuAH89+g2LbrN68O2QdzVfv2tRWThj3BOuEBcGTNXW+W0/bnVkWUW6EKytpgN8LL5BIPBWxw6KO4BUbTNPoKjGrvtgzRyLPQZcd3145Me4EPXTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhBlg/MXWqCT96G7XJJl1L/i7r4Tzcz8z34K31ymIgQ=;
 b=MtzwyojYH8KeC6fFG13aCuDqTnHydl1fUfStPuyWFrQ9P/wpKBRXtvRv1bOjtFSFmbYzB1WRjyMxuloaZiStqnom7BtVh81z3ICXIn8UpbFFJv9ZQlw8zmlBL35abLimvXvFWB0aUqaxv5hMhM/G+MfJ7Mf9efmV+02ZcwnmaV0xOIHpUa/GwhOWTa73k5AcggSG+wV4hSOF89TVUYH5s4/l7jUYw9MpuYhCdRmlZbeh5TxgSGYRWuulie8C0Q6BSRl6HAiauBm0MQ8zBaRolOpmfFl2S9ZzS3TEw7LacEO/zMCxyCOhUih7YJciJeAsiO3J7ySuzlfARX/Lf6b3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhBlg/MXWqCT96G7XJJl1L/i7r4Tzcz8z34K31ymIgQ=;
 b=TsY1eaYVoM0Kwk42a8FSkqoOFmIkuI2syKUH3K7tvux+X+wx+SYHAruicBQlmCOYssYG6MQiq4FM6G0C1DItsItuSnD8dCbFd/O+qVN23aorKEfV2Bg3Y2KUq19VnfabrGgo5Po8IdR7sXvDlwY4JsO4JUq6eTzcsEKkOSYyEO1Yx5CoCUh25GtWC5Ng1pvWLTVMeDqkXVHqLnzXeiYlDnkSNs9cb/WMW4dzJyqtzJRyAE80KvL6LipFFA6PrZYC2O6luVm8CgbEvKugrIeG4/t5q/AgvFf7x/Y4fjKr/glAhXCzMvBLOzanr2pnfpcUjSRABYuxJ/q9HfW7cpdFew==
Received: from PH7PR17CA0039.namprd17.prod.outlook.com (2603:10b6:510:323::18)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Tue, 30 Jul
 2024 14:00:08 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::7e) by PH7PR17CA0039.outlook.office365.com
 (2603:10b6:510:323::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 14:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 14:00:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:50 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/10] mlxsw: core_thermal: Remove unnecessary checks
Date: Tue, 30 Jul 2024 15:58:19 +0200
Message-ID: <8db5fe0a3a28ba09a15d4102cc03f7e8ca7675be.1722345311.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 903874e6-d41b-4ade-99fb-08dcb09feb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G3hUi87SCNJxVTThl1eJ8AtRt+oeVE1z7xvESx8IzbP+xspPb1Bj+yQfiyyU?=
 =?us-ascii?Q?arE3PYqanr8zsRgiOFiEZ/JXUitQ3DBaOPgRfNMCsKO5xPnJ4TB7UYta05P+?=
 =?us-ascii?Q?kD6APM0EP2TwIpx9juzE6wBglXcKMpgP7DgK4m0B2mnm97xOG2x8ANBzlQ0+?=
 =?us-ascii?Q?Y4YoLHcpXUdWHmjMl7Dv/1Rzw4jjofL7ZZsKnBPy2lBQjwrDkKkRBjmQqZAU?=
 =?us-ascii?Q?LJ9/zaT+N3w/ikrMlaq5LEywfQsLHsd3vZmDRMNTBssJ7p4nXjHARGOd0Mb1?=
 =?us-ascii?Q?sk7Z01BmBUVLcg5gCE3WIZ+/8OuH/J4M+u+iuXjpy8W2ddYCRPzLlqS/6X2p?=
 =?us-ascii?Q?nqNZzx4rG0TUfIgQ+d1DDfuU0T6GP50zyA2WWevmyILsNB9OKwJctwJrXRPg?=
 =?us-ascii?Q?+rvTjKB/Jx935aOlbhKBKQV6BG6BqV5ge2aW2uRgxv+gi563g4wRS1ClXLG7?=
 =?us-ascii?Q?LQ+pa6TGKd0XnClAk+qrl+nM28y/nM6Ct/6eOZF00y9r1NAoLzcpbovdDQWK?=
 =?us-ascii?Q?i/rjPHZ8GrYHHPc/VuFNwIKkdY0M0NcdFVTIgGiPs+eS2CNGTgAxFAHmfFrc?=
 =?us-ascii?Q?L7OdeXwW8mLL1wL9mFXBFuLVmNTUdO2Ho3KZFcTRQBWS5kDFn627dZpDCblr?=
 =?us-ascii?Q?sJjUggDRvPWNGqaocb8oTIbFHQcG/aduAwo8/lkTqW71t99iSRq+4JNCfY70?=
 =?us-ascii?Q?a/R3hXRrtx3XEthz+a14OkFJ3VBHIcKQtJ5Vk1ShVWFTVUsG7BsI+E++74SE?=
 =?us-ascii?Q?nqQh4mwP+a4sWf66hq6A5ELNac6vs6YBsIXvR5VB3Htr8z1sG8bZVoKW+MSN?=
 =?us-ascii?Q?Gl6sy2LgeWYjlWeHAH0TGmepEXj4B7WNVPy2nLPcKzusT++mmM52dLE0uFkA?=
 =?us-ascii?Q?KViNrtxUbeWWd85j7H36iHup3aBB1JGTc/1HzPK6ZUsLlUMcRDR/WxSO6NDp?=
 =?us-ascii?Q?88XRjfrZXsP5Z3mPiXrUwxTDKpHEViQvan0V0ZANpQWpYAkgIyv7Z74DBROk?=
 =?us-ascii?Q?26g8QBkxVvA0EenL4BTOxaeXsX0JFwRzkDbrciBT9jqxwhS2g/XIQyXYTQoB?=
 =?us-ascii?Q?+N2rs6tZZieWg2jhhu274x5wwXFORo/OMicyb+UghCDrl/jKDWIiLbcWna/Y?=
 =?us-ascii?Q?BNdtLUXHGhcoJ2trR9DcAWPVq00mcFKSgmOsGFS/Y+x4kGHR0M7wY1Jt6VLL?=
 =?us-ascii?Q?FaGfFYz0iEPzVNEub6NIF9xBUxp8fMVmw2WvzwU2NAeDuPWT72bc5kN3axxD?=
 =?us-ascii?Q?43N0C35V/u/IotmxkmQPR7597RbE0COdpkucEQFArmEGCpGR4w8jKddfg3xa?=
 =?us-ascii?Q?/gX09ZXuwBTnwsh5dRtWCZn3WXoTm+uvLcJF0Rc2rq8rKwpFddFgvxeUnSBm?=
 =?us-ascii?Q?M6MYE5z9tVapCmhgcWYXrF/JQoBoAOhMRi9/Qyd9cENyx+Djx6/omp0PoZgo?=
 =?us-ascii?Q?OCVYVymgjZe8jNU6mnUWRCBsYxfNDUW0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:00:07.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903874e6-d41b-4ade-99fb-08dcb09feb2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

From: Ido Schimmel <idosch@nvidia.com>

mlxsw_thermal_module_fini() cannot be invoked with a thermal module
which is NULL or which is not associated with a thermal zone, so remove
these checks.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index e9bf11a38ae9..cfbfabec816e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -467,11 +467,9 @@ mlxsw_thermal_module_init(struct mlxsw_thermal *thermal,
 
 static void mlxsw_thermal_module_fini(struct mlxsw_thermal_module *module_tz)
 {
-	if (module_tz && module_tz->tzdev) {
-		mlxsw_thermal_module_tz_fini(module_tz->tzdev);
-		module_tz->tzdev = NULL;
-		module_tz->parent = NULL;
-	}
+	mlxsw_thermal_module_tz_fini(module_tz->tzdev);
+	module_tz->tzdev = NULL;
+	module_tz->parent = NULL;
 }
 
 static int
-- 
2.45.0


