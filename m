Return-Path: <netdev+bounces-90187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C698AD0B6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969D41F22FBF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00581152E1C;
	Mon, 22 Apr 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csCvvcDL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800B1534ED
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799751; cv=fail; b=HKZCRouKWZyo+RkUlCfMXx7s7JXX/Yi5Eband7XR1vRmR30mS/xCNo2547uoJvxiU53I4b/rbW9Nmsj3C2PYQxrM9bAWAF6zygc71a/X4GB2I5mzioysJktGBfj/NIq/Nhr5+sBa/s0HpDCGMm22F/Ipp57QabtgpK725E54ZC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799751; c=relaxed/simple;
	bh=ta00F/obTDJJfJLvMUHquKczWxUI2/KbbUNgJ/aSC0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F4lDfas9MB38ogU0WFxy16q1MG95WKxsfuhmJqwuyVLOUMA3Rgf/WoBKjcvr5QhqAkKUjJ/bczogR78C96aDfYiIC8A+BG6ZGoXe+nmSTmA3xmMqaaalPD4KjoJq1T/SkAuBsi1jLiGd1zugs8wqbJdxqH652Vmnk+02PbCeT94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csCvvcDL; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuVbeUBo4MAHmnpJ06+YYh7N8xyxKhdu1bIsvDtQ0xvEmklRRUul4EFlhHuaHFLaIWNUu0hKzDZfJ7mt7x1+N0C24i4sJJEX1Oim7IC9nS4rXcFLNMZ2kOC197tBG7EggmVXtKGhmvdaqyY/oq37UacgEqML1hl0TQd5zZzsjys78ZaAKDyfJU/XYbhjNgzW4TM33IhuSmERaOg0qXMiVgvlWv8Zqp7gLoSr/jXLvLuGIS+NDS3e5cTeSxYp+g2OoNmV/c85owLc/oYCdvnudK+XW7m33QwBEb1xoLGFSqwllseq9wfCPzTUYFKpzghvOAdoaVcQF/X1kSl0UMh9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs30O91kkonD78OnDwLOEGckjkUvo0ER9doFYWPYt78=;
 b=nhLzQP4qfZejK3RgOvgIPTzECUYksRW8yKN3v2ljoOVCkabIDQltOGBuWcDZM2PiZN+5uTu9ksyLYwYkZqUgSXdQa4KgVX6dofFGFLAIm7czjUvrKIfty4AUQz3kd0tJC3eTSnk9waPmqSq2Cjoy5YcH8bInjFmJcAFIZ2sLvTtI11HQu+/2E5mVJYozm6A/ZghtfXSGEgIgKpS5aBmZtDDToS4pS8CU72AvVrj4vIaNtyhqvQgErBGyNCXdkB6Hn3wLvsXHz4caGFYIG3AJ02yx9BUkpCFgnmK/ZOFTBO0cdQZNfpH6jrqXGZw9qgQGSwT2lr94Go3gRPELBCufRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs30O91kkonD78OnDwLOEGckjkUvo0ER9doFYWPYt78=;
 b=csCvvcDLNB3h3P8AVn3AhnXO6PwyXUcFBmwo3voK6ZpcqYCZyy1zGnvsrmcMpu38NUoAX3bw01bx18NBbsk9Dz5AoGuIRqZ48pUaxkocEkydnz+oWiLi+dJ00HcHG4ozmMl8AkJBV7wCldKcwlS1+XPrXWrHD4fZ7W13j1QlakAFsTVvfK++4T6mn643v6OWX0rUBIerC8i2oV50vEUvLGqkHdY0GMqQtbFcq9nxvcbXm8akWLvEVcLum5BVx6LrMDMO9RUH6mmjCEQ9hfWbYBXxE3zp3KQYadYA0iXwAH/y/ELcWf4hHrIURKwzOzf3hJEFIV1lKd3W87rPAb7QqA==
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:07 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::e8) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:45 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/9] mlxsw: Various ACL fixes
Date: Mon, 22 Apr 2024 17:25:53 +0200
Message-ID: <cover.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 79be4123-05d4-4299-cc27-08dc62e0f303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHqnSqLzu7mhgEV6TK76VMAr4INKIMWGKwYzHnsE4ZJQ9MNscpFn2jdfAdfr?=
 =?us-ascii?Q?VwusfGG8Gr3y4yd8KcfYSirWmlMEijrwje3s66ZO+x5hOpNMX6Ft5jFuwmRD?=
 =?us-ascii?Q?OQnMHz5gryZdXg+SktomiC3V0DSNTz+MFAbMqvn/pZPqvQwD3fa9b45EB6rB?=
 =?us-ascii?Q?YTIpZ5lttlZBopvmqEwGNkAzhw71at8rwj1Uq/ivnnZnuPMzKJKhJtHIrTZI?=
 =?us-ascii?Q?xeNB0jRrJA9ReqiKjJWHM0cTFOmZPxV0gMj3Qe4waWjEFMUU2J0Iz0yFs6fW?=
 =?us-ascii?Q?ms1vX0ePGYB55fagBdlk+1b8cWzAYidqJfq4YGAGkhyaDHH/YM43QdCJfrh1?=
 =?us-ascii?Q?FU3UXgfwAFe8cirflKO+ROpoYeZoNFZRxhqi6ZHOCdgvhWJcQMZn/D8JKd5s?=
 =?us-ascii?Q?FuAd1wcJz3R7dYxCCt3KrduY2o4DP828aAbne1pXhAl0NLr7peAIFZ6kfFKc?=
 =?us-ascii?Q?cYWzkIPKWWi8Qmc9qQh2d9wL/dMyE6GYVsYqiHeq6wFKvsH2XQ6rX/mU73co?=
 =?us-ascii?Q?+2uMt57KzAHvhIYhiM7x6qoclaUZQ/v2/3DWqN055V0cSx9bf7jDvncpT/p/?=
 =?us-ascii?Q?v5aBnoshbtcSptTIysqtXV/gWEBli/TWo92P519ojlV/dRY4NzQi57wlzcRe?=
 =?us-ascii?Q?ihhFDhLefD7vDrc8lHLGQuUbgN9rQceDIszgzvPZoTfS+KrBRrKinWMSWZ3H?=
 =?us-ascii?Q?3+M1vO502iq1QiwXL46vLry2dRaCK6fPzm3GMEvRX1zUqYtdJCuug9N0fnD3?=
 =?us-ascii?Q?8LZvSEbKsRo9S8m7x+M0JoPRWuOwbBijcvfJ+L/lUEHU2CDPQkHzo88aKQ/P?=
 =?us-ascii?Q?F86z2+nDaOdxQTnSv9a9SmSp4myeag91GLWo4eaZg2gwKWb+z8qlEoDFe4GY?=
 =?us-ascii?Q?snZTKMvyxXqiju9LajoWqeqjkGUCHzbDXLj7W36isddhKY4EL9ff8luBvcZT?=
 =?us-ascii?Q?/5AdXPCwTaO97ybLxDnbADGhw9D49OHb9fXsema+HWL6QIqIGJLZl11TK0cl?=
 =?us-ascii?Q?OIxQUU77HZjxGEBhq0Bbjl8nHHqq/5g9OQ59Jwx8kbJ5Pbz0k63OhwFwBLCo?=
 =?us-ascii?Q?VOijJC08UALc5Vn6H5ZH3kTgsZAsmsa08dyvDQ03hRWDcuVpbbpAEmIgPghj?=
 =?us-ascii?Q?4S2S//myph1oyUIIRqL4lpUlfKWyUy79J1gW1a332u0kHbfb71kqzCOE9z3Q?=
 =?us-ascii?Q?hKxdd/ceWywm+6fPQF4IBwKEWCE7TQXrZPOj5vTF+h+xvnhI5VNn8fji6RY+?=
 =?us-ascii?Q?7zKeW3Sy2HPkRx++Ocixq2JXDUjLIEGE0QaFGCniJuSgp7Yx0/WBiTBdljAG?=
 =?us-ascii?Q?K8dye7T0WQy1rwVZnodQDL6ODfr09+R3Wc7CM070A2Mjw1z+l9pUs04ajkJw?=
 =?us-ascii?Q?UrtyqHcOKyslLjzU4bQbmv/4Jytm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:06.6263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79be4123-05d4-4299-cc27-08dc62e0f303
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

Ido Schimmel writes:

Fix various problems in the ACL (i.e., flower offload) code. See the
commit messages for more details.

Ido Schimmel (9):
  mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
  mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
  mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity
    update
  mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
  mlxsw: spectrum_acl_tcam: Rate limit error message
  mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
  mlxsw: spectrum_acl_tcam: Fix warning during rehash
  mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
  mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

 .../mellanox/mlxsw/spectrum_acl_tcam.c        | 115 +++++++++++-------
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |   5 +-
 2 files changed, 75 insertions(+), 45 deletions(-)

-- 
2.43.0


