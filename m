Return-Path: <netdev+bounces-133615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12039967BF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F801F23EED
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011418FC80;
	Wed,  9 Oct 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utt7u2Gp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB354189F20;
	Wed,  9 Oct 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471261; cv=fail; b=GF9XVhUeal2cf5L4qKvWAiq4Hra8qrXAalFX1V66In/1LDyH11J/pPwgVgT6oWNs7/LL7WzoX0+HvjbyxwU3uDnwPPyvpbUrzg8dbpFd40/5WsUt+rFCvQn4COXXgPUW382ZnD8qMAv9v8y0ZqQKb5v6YxQPC9DKC/J+vES2Fj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471261; c=relaxed/simple;
	bh=iiHFHMUCEMhL8RYAZNx2N5a5LW3w6gVUpT8Fe4a5rKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lzFCdqUHd2jBu0A+f7p6MmNDTgb7J4QRFFqvAK1z9QQrIEuHjufww0rt6GaiMIj0UVlU56NN8TkoyKOR1Tmsu+NeHO/KS9M97RjpBgr8IGoTh2pfPlzffEZ2LB6mh09fCiJevL7uCz0NBBi7dZPZaxEGCRJ9YnZ9isePi8UHNiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utt7u2Gp; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdI16/ZwuaVRS0Rb/sEiP0iW375k7gca4MhglVrf2Q4Nluqfjkr/BIxQnGwFtC3nXDuBdGgeYCErIaFiMlepesIgrLsqVYYL0ZQcKzpYlDjtEgIMaX2Ly+lSw2vGQbNO65+OhJpTvPjUMVW0lTE/vdg8aHS/D+F1KVB/Bjpl2cV6W3CWjn6GhVCI6RyOeN9xpqUNWMMl4IBNPAnOve17GAoID/FjYOHoJw9b/Jxoye8i38zjU4eWvABehsDxdZOE44C04cJvL9D57pAeB8nxtN8flFhAFZDlc+MqzpGHDAGzVPoKqXijk88i5riQxdB6whLTsQqjmpSpS9xUbWG1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgLvs+hnuf9kDi9QxtiQdLRAQeH72JXFI2SBfU6Ktys=;
 b=Onl5ck3OzvrHZsYn2cHCqJDxTatfoq4vITwS/DM5GIES/H3CaQ8PgBPeMy24Gyzg0qpm6OQ95bd3YCkueCWO3p0GxPlaqv5GjVesO/ZZEEf7KhdppiVQEqwq+VnN+zgqmrmim8Zj675h1oflCHnnWDcKrUuA4pFsy1GtR76jeEgdKJ5ijNnvVpCV3oWaYVMzc8LlyZtLbeQMBCJBAO1JNPQLwsGK9M2cbsou5BKTBFuxH6TZWcFEQKJlGzwntEMKsET6UuIhKRxlP+xcoFRzBnlv3gjp89bLCygoVe9z41xIVY4120/XTWlK+zvukBoNiZU9UUhfa3oFGzXp5m8vDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgLvs+hnuf9kDi9QxtiQdLRAQeH72JXFI2SBfU6Ktys=;
 b=utt7u2Gpa+IytdqsYAfLXLiQb7skwK5vYHunN0QW5ezqsoVmrR10h3A0+7io1FokbkumNscRQHpTCXi73cbbQHQ4YZCYXKfcED1LWlbsKqSnyYN4iNb5H5asnvtAhj0e4COGdCeYk9CXQMUD9eqrtNl/DCozPEk2b/8WGMg95QjIIL79o2hUtJt/OTi+1M4AzGYKgHURLz+Yg1b9eS55aHsijGaXs0+V9A+Nuf01I1OyvJ/BEdv19BP13TZSg9Ti5NHIb3pRK0h/RP5QiePyuGcbgAQ0MerhU4w0E8963m5qhphEeBxbfw6UMVSRe6ex5Oo1mXNNmOXbeHPdhKjJIg==
Received: from MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 10:54:14 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::59) by MN2PR20CA0022.outlook.office365.com
 (2603:10b6:208:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25 via Frontend
 Transport; Wed, 9 Oct 2024 10:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 10:54:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 03:54:02 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 03:53:59 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v5 0/2] ethtool: Add support for writing firmware
Date: Wed, 9 Oct 2024 13:53:45 +0300
Message-ID: <20241009105347.2863905-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: b760611e-2db5-4a3e-3d36-08dce850b6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHG6KdsvBpIc7P1WG/fFm+Asq04VUSXBlqDBslzgHAhdLVRZ43or1wJHXoxe?=
 =?us-ascii?Q?qON0jfG1oLQng9f3ED5PmshnQMDHCFblc7hNRbw48eDjSz8sppyOqdJmUTD1?=
 =?us-ascii?Q?OHNhg0ky08D3Jxx8hJP0qL+SwcR8hYU2r8o7Y44CQzblUOw8MnTOf7s8Qqtx?=
 =?us-ascii?Q?dM4rHBt6cvw4gGwtc8m5p1uzv+PnQCd/jnZqb5P1u378fquT5uEGbVE26OFH?=
 =?us-ascii?Q?VvX0Zio0eOSnXiK1KI6LVKf+4jbBmQULQxCWKp2vTg9ft0/mvGJFDHzRsuIV?=
 =?us-ascii?Q?jwODCHGEDktIJ46ItbgzSHHNWwxeyweoOpH6WP+C8Yu1ODbE3ge0+nIVPCE2?=
 =?us-ascii?Q?d7yq1x1dFkUHXer+Dw1svNApabM+juJIt2MBDiDxmcZPxu4AtG+w2LUXk9BJ?=
 =?us-ascii?Q?bKNVA/jBRPz/eRVJAqn7h39Ynpz2VlAu1jgPeRbqRbz7sJxxSaRi0ZjSex6r?=
 =?us-ascii?Q?DnZQX9svvcrwwS9JzSTGXsIMZ2Vq8GWxEQXTzpPAw3XwTDdHgVH+o7y3LU9V?=
 =?us-ascii?Q?yud9NhA+ywv7J8tczdd0BPDkO4Cl9Nsy1jf6NCgkeyLjAJ7CobO0ne1cCoJP?=
 =?us-ascii?Q?8H+Nzu9h/UZRTmxuZkgeE3U+mWlAgOAhwnbSr5NSZwOwwFN9LEMSEF6LtYLl?=
 =?us-ascii?Q?SO74PBgWBeX4cf3rQ2RQWykjYj3JjlUi1Rsp3zCwHQ5y7AYKcGzUP8lDh8i0?=
 =?us-ascii?Q?0aMzP9G7QdozN/9uZQC6WeG61/VYMt99mUZHv9T7AZazOKQFOgqEfJBDL0SU?=
 =?us-ascii?Q?5R0Zb6j1Z8bHSvJdaivqPxbKNatEgvwlOuZlgs/3UyqlyTDH5Xcvqv0vqAsr?=
 =?us-ascii?Q?vjQsqQARbceibucgKIGZRP9asPBnH2wlAkw7363WlDbTkhmCUQrljqC8+s4r?=
 =?us-ascii?Q?Hq9RXj3fv7fqUSRXLwZXoUvY6d3m2pAySG45/SyXj63bh+O+PdBrDBLscil0?=
 =?us-ascii?Q?XU6N1zHcEimBkpd4FCB7tREGy310rku2EO6FKymZ6+kJ/o6KHkwNRJqVeZyG?=
 =?us-ascii?Q?oily8e88+GOkL3kMcfJpsPQtOAHYXwm9MKhstJ/RnLhJJAEJTg4VA0E0TINZ?=
 =?us-ascii?Q?z8gGX/wiZ2n+sFL+VFPq0e+dtFvPqHwRjMJ1U+Y4BdnLGVW8whuNY4ZDpFHB?=
 =?us-ascii?Q?dNohaq4vOs6p1N3HK9haOegLs4iYwN9g4dfr8d2txRnLL31rDCOATJVCCrin?=
 =?us-ascii?Q?GSIPuNTbeczq4TNd8pOEGHkn2BgAWlnZxol2JCh3cVe9Zbd8DrIeURN6+y2O?=
 =?us-ascii?Q?UNZa84BayihKVGTQHHSosPNYMEPHYCHhq+IgwkVLEOL96R4Hi2IgzvrLMGze?=
 =?us-ascii?Q?y6nO91BTfvA0hakVp54WM61oVL5gPGdCaN69ahHLCuMp1VG22WQdRClQFqyP?=
 =?us-ascii?Q?vWpIDF1ENz/+JTb/1zBCzJrtGpCV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:54:14.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b760611e-2db5-4a3e-3d36-08dce850b6da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

EPL payloads are used for more complex and extensive management functions
that require a larger amount of data, so writing firmware blocks using EPL
is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to support
modules that support only EPL write mechanism, and to optimize the flashing
process of modules that support LPL and EPL.

Running the flashing command on the same sample module using EPL vs. LPL
showed an improvement of 84%.

Patchset overview:
Patch #1: preparations
Patch #2: Add EPL support

v5: Resending- no changes.

v4: Resending the right version after wrong v3.
    No changes from v2.

v2:
	* Fix the commit meassges to align the cover letter about the
	  right meaning of LPL and EPL.
	Patch #2:
	* Initialize the variable 'bytes_written' before the first
	  iteration.

Danielle Ratson (2):
  net: ethtool: Add new parameters and a function to support EPL
  net: ethtool: Add support for writing firmware blocks using EPL
    payload

 net/ethtool/cmis.h           |  16 ++++--
 net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
 net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 34 deletions(-)

-- 
2.45.0


