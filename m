Return-Path: <netdev+bounces-94881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7308C0ED9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281301C2102A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158313119B;
	Thu,  9 May 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqUmyABO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B413119F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254290; cv=fail; b=VxKGCl9taOlmS08kIGy/YowibA4ti/I26m9umvreBpacmMsESAX89dRVBZ28VMocY+daEFTml+iDTJYdgD5aUjdVBbPpDdpdgq/7tVH069JrGnuEEotUIbvFpIv6XhFCuDZKhNNjR/hAQNYQbU+l6YYI97Lz8LD5S+d+lglva98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254290; c=relaxed/simple;
	bh=l72TWzn5p5HA5EJVNylUX0kS1CZEVqumkoFQPtPdBMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTWEd6oBCOrED+Qvc92l3ioe0ffbzj0Huk5BriWmDtWYbwOwxWQVfctlNtKdUnPXSV2ic+/HPF3vixttdEnaZEExTdInDra9cliOBa4SgL9dyqaImuBhvrGt02NPbj7Gl/5l2LshuT/GZnMh8tp4ySsELhS98TmXvSOx7O36TfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqUmyABO; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkT69vI870/HmCoBntCaixp5dWfnIISFEXTegEGiuFU1bT1HB7ywxp2QfbTuaQxtG8HHv4o3IlH4uGWMVzQDaq4+yJi7a+0OStJPTJUMilgL3QHoTh2Rsg1BZl4gZ7OYy7Xjm9KoWhjXTE9UqTFhRVzx/8gOAHHWQXiDpab8Ibl9BS/LUcRhNwSzNp2a5L/vlQdj0eVk2q9UE97ZpTcBh2Na5odTV0A8nQSnonPIZzvafOUhjUCsJbqpDmyZt9a2+yXjv0PKprjIlXmyXxfwtL5J5FADdDEf+FfWiaGkoyKgNsOfx38YWkpY311in3/5/JfBGvEJ33RThKHlD36lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lRB7zJXneHb1CbgbiAau+9yMB1UxJKxy0khV+I/xc0=;
 b=BNCvZXBryRzbw3Kt/xUrspWfYFVau8CzCTE3/KBH3h6cA1esZ3ZYPRVSBHtRN6jGk/ggtc6Mkzk+EjmXiczzpY8r+xJbQ87qCVB/9ESSC7UibRS+yCljgsLX10nOrITKTN9RTdvtcrdseuIz3lMmnvirazn7L0KPNDC4Gi7cJoMglM3BAi7F31Ee2fEddYQJSBXN8m3q/1qipU44sAsPLrrtKMDs0gl68DNMXqsRyBQvm/35U72Juzbw1SF3wgw7V44tSVYbRjyKmyot8MFDa5V7m5DnWe6HC5ziivd839B8FyuFqpq7KWpB9hicj1SktpoWmYSMOIwg+ANHKppRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lRB7zJXneHb1CbgbiAau+9yMB1UxJKxy0khV+I/xc0=;
 b=WqUmyABOrjqZGaEamNllDv/mrqtEA1UeDqSFuv67GRhxvGPPz+cCf6AKENrUQtgY/rFtXCpBT/8EMU8H5HQaqA46RRZtOXEB6mXiY1tq5D2mx91aDW0Ns/5+kBvc0YThVcmq54ujovK8XFoxVC+mbeGL5PNGla8CaOyKnM87Cl43Oz9+HvFd1TQLcGuivgzHgL+FuOcZ5313HuHwlLA6ucrDvOSuiEpeJjyjbqcVHnb/fPIOM6awgkBl03dkd+jmQiByQbrRBexz/PTOxMpxpheu9PX1Cn1vV2Vl8qvfsTaL0HvnjgwMuuk3Nn6awS9h/RZ1AYfVzpSf+R4bp3Fr0Q==
Received: from MN2PR17CA0036.namprd17.prod.outlook.com (2603:10b6:208:15e::49)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 11:31:26 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::ea) by MN2PR17CA0036.outlook.office365.com
 (2603:10b6:208:15e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 11:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes
Date: Thu, 9 May 2024 14:29:46 +0300
Message-ID: <20240509112951.590184-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 31038c33-180e-4bda-e627-08dc701b8f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tO058CaAMpwFuIZIPWfB1QgmlPeUQkZz82w+Kro3j6vwcbyUa19buEOIZSsx?=
 =?us-ascii?Q?AVqhN53nK1TdrqEdxVnu0fJLSFVocT8vQdQflJtoJR7J9Bcue83Annt/f8VD?=
 =?us-ascii?Q?Y02xSUvCZ0GKZPHGXRdcgOlKzfZIyA8eo04ttZDz17WCPI/Lc7ClS/ZQZi3j?=
 =?us-ascii?Q?bNQ9tzekXIy3WLfGcKLFRwzOOOTs8An8mD59VjH9iEPj2qGqufPaxr/5TJ63?=
 =?us-ascii?Q?9E52wtrYMD9v5nv/6HoP7YYRWJPzp7iu4aBnDj4Vcrv918bPfKDZfG0SgvZy?=
 =?us-ascii?Q?peGd0Y+8nGuCD1LLve9wZnQw4YBJEwx8EwKDibhLCtr6qfkfTXCGpwZ3vs3z?=
 =?us-ascii?Q?wf3PoGf7eP5Nwdbnxx8Q9miigEHYHHTJnRMuhP2u4tXpslA7DOTenJG9WW3B?=
 =?us-ascii?Q?k+OLfrn7HU292NfMVc6CbMD8+QlBM+dn5ioEFd8TWPCseDSZXTrvRwRQ4xVl?=
 =?us-ascii?Q?IzoWgzZK6A0598C4kKwDAZqy+xTg5y5zYbnY0wjv1ZJh6uCYfvmc5ie8zG9h?=
 =?us-ascii?Q?FvEPGLnOwsDRbv5PzmegDle5xEddpRjngqOEMpbkxwOaC4UJJGw6FmQ8dium?=
 =?us-ascii?Q?FyCHoWKL1pBhc0vbuJQHUPYLC68rK7V8FOuGTYz88bKDJH4iz3Pus8JB1mXp?=
 =?us-ascii?Q?m04/8NQ78NfJG46weEdDBTvtX53aLZjUjah0d3qAjWZyf3zrByNxs0Pc9GiG?=
 =?us-ascii?Q?qbPL8o/BQ8wGDwBfRShVHOzv+XF2soIh/sRHSgIWGNL5dmO6h7hmGfeksxWb?=
 =?us-ascii?Q?4398B14/yLIK8Eh9D/cZRCsQddXaS3aiJ6X79/L4/21HXAoCcJVxaDXxpfCZ?=
 =?us-ascii?Q?JJRa5gbaG0lC1vFBbTzTrdhWhEmwQoMHzaI36OBSBl2AotZBp91mPnc+o0pv?=
 =?us-ascii?Q?SUw698wFTjx2SPlKRv7f0nLadC7gAnbY/Bj5vX9i80JJOg2UPq4zMm4pnZ/5?=
 =?us-ascii?Q?xl9oUgQcBRilIoTRwtverq4ftqFrTUNNInVtDBCXpKZjI2IpYNJbfQlf601/?=
 =?us-ascii?Q?kUwlaK77AyN4nsnb6iradOnP3VSYS2z/ORTo2ujFqIyiTmKi5uoAE56o3Wqm?=
 =?us-ascii?Q?nMZFZbJYjj7p+kJg0Q2whbvANQ/WuIw7LgU0YfoIFu7DdSTKkhM4OhH+ktHm?=
 =?us-ascii?Q?AtrkmVAyOUm4kWNiQuKLzxF1jyaHzNzDoaWxpBYJ+0k6KX/uOZ9Rn81RdPAE?=
 =?us-ascii?Q?+1jL+5zb/fnk472vPtgeo7B+44n3uNbW4XCCWZzXAh5cHw2/Wj1Ew24dh/1E?=
 =?us-ascii?Q?BCpShDPx0/VfXOrkJSb5Y/ymtot8GfbOECX9irEdliwiIQLjdKrMyJHTzai6?=
 =?us-ascii?Q?ZVltRpoxUViQqYZTXSjRlsxXUpaBz16AXPM55DWchlz4wKf9qNUTmg1kWiRB?=
 =?us-ascii?Q?UORgj5fGQqSPdGZAUt710V2L3ZqS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:25.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31038c33-180e-4bda-e627-08dc701b8f70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

Hi,

This patchset provides bug fixes to mlx5 driver.

Patch 1 by Shay fixes the error flow in mlx5e_suspend().
Patch 2 by Shay aligns the peer devlink set logic with the register devlink flow.
Patch 3 by Maher solves a deadlock in lag enable/disable.
Patches 4 and 5 by Akiva address issues in command interface corner cases.

Series generated against:
commit 393ceeb9211e ("Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'")

Thanks,
Tariq.

Akiva Goldberger (2):
  net/mlx5: Add a timeout to acquire the command queue semaphore
  net/mlx5: Discard command completions in internal error

Maher Sanalla (1):
  net/mlx5: Reload only IB representors upon lag disable/enable

Shay Drory (2):
  net/mlx5e: Fix netif state handling
  net/mlx5: Fix peer devlink set for SF representor devlink port

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 44 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 28 +++++++-----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 +--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 14 +++---
 .../mellanox/mlx5/core/sf/dev/driver.c        | 19 ++++----
 include/linux/mlx5/driver.h                   |  1 +
 9 files changed, 79 insertions(+), 51 deletions(-)

-- 
2.31.1


