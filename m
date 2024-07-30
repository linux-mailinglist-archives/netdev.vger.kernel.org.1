Return-Path: <netdev+bounces-114175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF69413D3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31501F24C1F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88801A2547;
	Tue, 30 Jul 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oiRtoMpu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC41A2C04
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347999; cv=fail; b=pT6sHMEX2sSgtWE+yjdyZXrkZ3/tn+gvHw2C1DSo/j5U9acVAwuh6h3HP9RajKEZ3JaPQhONR4+mbY7rgr/vkkB+d5aIdUj16vYQh2LqdzzSxAz9OCQPJk1OFBrvahkQQlAeMMZX/lB8xc+QtOdw5WygmS/AxIn5Gf8v8KmjWcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347999; c=relaxed/simple;
	bh=Ji1v34/uUkDAQN3CIe/AoHRE7fJV+la3if05RN8m+rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDc2YIs3fJKvuPuaf6uFgsZ74A4Ww14adstiWVaNrq7qG+0UgMzpYq9E8gUn+/KYeD3mOpMOzD52fp3CWECIF7YHApf8p66i3ja1NIVQMMoM1rA6vfzHkS15HS+fHWC/2dOT5ILccvOU4OlwzO6yBZYS8nC8y9jLCuCQvxHvk/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oiRtoMpu; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLbkw/HpyfQfhJ+XGMq0S9vj1REEhPWd8gaqPWjwmEFonKn5YnwqG07XUhnAu+FD9WHzanxpjzGGJcO8EZkMRu1bu/F47o0CqaoBzI1kf0cZA0OwpFqg9LJ1Ce6DC2RFtsHAKaEg0/qkWSAdoB0Ny/Ipq0DFSz656tioezfQ4Dj4dBs7HU71Or6PjXAyBFidtP60Jya/QH6vLn9Wx5j6MhLnFxEkfoVRbkpTOjMSW7TwTptMjvGrtUr+ya3sV49Ea//hpfBApstqU9yU5FJCVAu/g3vg4+W+sim7eyUUBJOZEfJaZXK4vd7Ba6Bp3HHd+eLLV3AY9VkkMsLL5RXQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsvJM7NECxB6Y9qEgqKE4cC8CJDLCjTYJVDzH9al7R8=;
 b=M7NNQS9jKz+zp9YVY8JewN6cy3ChXzrv4LNiChQXm7ZcWrBE3tMrplk+e30sjaKkdD7rUP2+ac2ztIxJcQgyOCIceJ6X5eFIRQ8I29ZhNjYSa2HS6B21EqTq91V+ePk1oRNfnwoLZEAJFnL/jsXSqF92I+U9/sQYIXGEEhLrO5Ah9chJSdCZPDIJ4WsBAZ2EXdmFuLA+4dl2W+o+RFsP0QyF9nAq1hqUlcfPs8o5gH9jWQZh8puenRJivfofBmZ23ffJx0LIWdLGPwPMmJgUp0qDRLx7jxCiT2243eGGQhBY4C39cgRAUtBW6DBMzGlDxlj1prrvkm7bdimQXl213A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsvJM7NECxB6Y9qEgqKE4cC8CJDLCjTYJVDzH9al7R8=;
 b=oiRtoMpumD0HPq1/RJhEGU5ouUOSeFhS1V6b4j3ghBamRBxwisuzjKk7O/G38GBYOjT6AHAQD1tXris9i4kcQEubblAc6ThV4dx0wXTVik5WLQxsgAZlnCQgAHLvGCWdzm7AZaqMf0lIqidsuONJ2EnO9+36wI2XO98MS2NoPyna/5jfcRip7SZtgQM2jhF4EGfjPVQrXgA0in3pFE5X434SHL1PFeOlejFMhZyRRS6ibLehDo3lTRiM9QgBH9DlKs5n6/+aI6neGQBlw+I7ml798XqEl6n1DYqZeUyN9ypYitFK9NZjhgdDdCFgXsGfxip1fM9QvHKe6jOrlO+JAA==
Received: from BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:59:52 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::17) by BYAPR01CA0011.outlook.office365.com
 (2603:10b6:a02:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:35 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:31 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/10] mlxsw: core_thermal: Remove unused arguments
Date: Tue, 30 Jul 2024 15:58:16 +0200
Message-ID: <563fc7383f61809a306b9954872219eaaf3c689b.1722345311.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d6c03f-a13a-4b74-1bf2-08dcb09fe1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JNwmLzinPynt0JFkM1RVgUxFolYy8rv9Scjm6gZZzv8/viKKkHQGxme8EJ1I?=
 =?us-ascii?Q?AvIpao6D6g9d2xJGHE6phYQvbghXojb/K1kJRhdFKbq1jCpG7JB/s7fTnGTM?=
 =?us-ascii?Q?Pfi2wloU+F4EMixVx0fg4zxSJb+pwjnZe3vqAjzHatx3uYUttp97chX40WEu?=
 =?us-ascii?Q?qgBZiMJoyqklM9QVHAMMJd5CsMpUtDu65cC3RG/t/o84nXDB9ILnqGwMlY/M?=
 =?us-ascii?Q?wBKJV3haqOoBQzlylsNu7jWS2PwlZ8LxPINprWk8850WA0MzY/9g+/9YVV03?=
 =?us-ascii?Q?63xbKGTRiK88h+xcCjVYk0ZAGg3cAvI6HlVe9+M06hQJ2JpAE3+ibvaCJMTh?=
 =?us-ascii?Q?AjiEtU9uChpA088NCaNupxwo4WUD0STyZzgQ8I/IULAe/lqZlaquBnBUBx88?=
 =?us-ascii?Q?AJCpaJ9SpXcuqC7sHHS8LnzklSfykK5e6RRdQ7OaxFuwBTuiS2hgVhOl6PXT?=
 =?us-ascii?Q?pp+Ohw2vrvjTey1E7wx6ryl22IT2Unnmx2ET7V7d7sl8w3Byac7DXOK9+TGc?=
 =?us-ascii?Q?gbxOKX0EfPyL2WSiJTAr/rxUvUKc0hhWfOEwVGOzR6bwysZkIE+leo1hBAne?=
 =?us-ascii?Q?/q9Coah+VHtYyJiiHzD2mD6KNyOid+t6y6XAlVVGXr+G11eoZEPHeokJmxtk?=
 =?us-ascii?Q?EOp2vx6Y/n2MM10EbJBMMcSYuKOCxQ89GmFKouPe8NsY4dUsc4QHpF7SYuWb?=
 =?us-ascii?Q?RuD0pxiAnR08WcKydHJq72fgHElJvS27n8TvPrh0iVKwGj8g/OWf1oEv6T+Z?=
 =?us-ascii?Q?YKAHGuOGwKJawNJemIcyL2gMZSrygD78yGnNg3FFqK2v+0wwxVOew0YwURwk?=
 =?us-ascii?Q?/UWobmhT+kDZNuiYydZbkSdY915nFGmuz86odQP7uDvz6fsyhgR78pvdVKCy?=
 =?us-ascii?Q?NfEU+oxvm9OA4l1vOXslmoSzbinL4wu54cLVfigLI+5zPWSQ+Ly+oEDUXq1y?=
 =?us-ascii?Q?mVt8OS/Mp//TOafiOnAA3SMMA4isWLznlfI8SOeya7ej/B+Gu94za1GjQYzo?=
 =?us-ascii?Q?reL1RnPibABdCgcDbEh24YsBUiKtYBLJcrpQy2vENFPAVlb2P+GoZ0IxUpF7?=
 =?us-ascii?Q?r7nVZ8yZyiJeuUZBUTQLKRSQ8zgcisJ+W/6rjHUwnZK/tqQoroPxekhxKlFO?=
 =?us-ascii?Q?YciZVfAgxDavHQSywFfSBc0B4XfwHfa0AmZYH65hrcEgM5nlDS10A4LRylOw?=
 =?us-ascii?Q?opswnGNgfsGLp5S0iq/JJHO5c6jUTh8Iv73U6KouaLTisfrfUsLZd3R+qU/J?=
 =?us-ascii?Q?z3tXX/gvb3WqKeYc09BeKo0do+7jQzp6tWW3wQLP1b16OHBTrFr0ANZXcQj8?=
 =?us-ascii?Q?/nH0F83cVrFOa1CG3fyUrAri5Dto+HiY2UbjLhS205EO/s3sCaaX+kIbzECo?=
 =?us-ascii?Q?TJYoXo+PJh+0wENJ0ze0ikEuJGwhlDVh+vDOghKHq68YCEPB9TfzC9bRWzKv?=
 =?us-ascii?Q?LB6J5w1Zk5/uYY/2JWgw4vNWbO+EBhrV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:51.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d6c03f-a13a-4b74-1bf2-08dcb09fe1db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

From: Ido Schimmel <idosch@nvidia.com>

'dev' and 'core' arguments are not used by mlxsw_thermal_module_init().
Remove them.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index b2a4eea859d1..95821e91da18 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -446,8 +446,7 @@ static void mlxsw_thermal_module_tz_fini(struct thermal_zone_device *tzdev)
 }
 
 static void
-mlxsw_thermal_module_init(struct device *dev, struct mlxsw_core *core,
-			  struct mlxsw_thermal *thermal,
+mlxsw_thermal_module_init(struct mlxsw_thermal *thermal,
 			  struct mlxsw_thermal_area *area, u8 module)
 {
 	struct mlxsw_thermal_module *module_tz;
@@ -501,7 +500,7 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 		return -ENOMEM;
 
 	for (i = 0; i < area->tz_module_num; i++) {
-		mlxsw_thermal_module_init(dev, core, thermal, area, i);
+		mlxsw_thermal_module_init(thermal, area, i);
 		module_tz = &area->tz_module_arr[i];
 		err = mlxsw_thermal_module_tz_init(module_tz);
 		if (err)
-- 
2.45.0


