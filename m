Return-Path: <netdev+bounces-116111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB9949214
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8CE1F26058
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D521EA0BD;
	Tue,  6 Aug 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZDpwDfK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFB1E7A5B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952233; cv=fail; b=ZSlTuKi+GI5Fk/+Sipeer37aYb49Z7HPysGx8gCfHQ45D8IZwb45tlH3pdU2pSnHXg64yD20oIfaETPds0Deu4IRk47cAE40zwCiibrEsENSaCdxXzodqMMzdd2Xo9GLP9MhnBVcIUOdTpR7+45/c9DXv+n0hY9h7DIogsFQYC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952233; c=relaxed/simple;
	bh=AuI4ox32s0SPXvRRN4LD6EGjIpZNYcNc9OZCn0TtaP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c0TkH29d6ohZQX6WfnLfSJITHn+CiPldb3t1nCo2WEcmVh3Fx+ghBhGouK6hYySYrjksjbzlS5eeeoiCHMO1jlTJiK3Q4z0jjZeVyey0o9OGa+zEHvIMITY7HcYr33L2DIs8AiqUAZboJJXqESZazrh1++ffb4o8tDgw6XsCG2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EZDpwDfK; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyA59p7GXnxIlCUZrtLUza5VbqKB1DwxlTFjqdaUEyoDvD0n6H2+sC1azSyPnxmV3C1eWbfb8UWUQUicwLK/cwjqD3wb29zenxGCX9okHz65wP6vhX886bhJUfNrPPXhq5wBVoVon0fb8jbLIA/Y9/gJhDqhtB3b8Noy1c3RB73a1nVY+RhrEg6Hpa+BEFFkm9A1CF3tgj9T9TQtbssqFoIodEYQ4siSJ99aKVvnjkBYOXhuaGPKL/3h1whkidFioCYcAALlAv06pPelRD7860wjvK20xLYjLyQfAmgbI6AjYlN2WVqBjjX9pS1sLcn8dnWSuPYNweUmCPx6rd6hVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btSbT0cpLZaoM95qivs0W4t+ZFQzKEbgOKdVQgO79N4=;
 b=E/fieAlDyGSdgUHf8tt5cofOMXxVJITy7SVj2f3I8AH4FJfFrVfbYYc4zzT4LclU93yC+wRJkjgMNabhukeWGLIu+sQF35MfTXJoKsJpva3RZl3RFRBFN2fJrwm+EPgeveKUGtZvnWSHCtRPRCC+5ew0jWIlk82tdRC/DPL8VLfi9VrEm2DZrHKmWRCHEuQPyhjjkK50eEcbm0VzfyPJDD4mpAOOdLNmckBaLobUaS653SDfMiIukDbGssxM62t7TA/mB4lT3kXyJ34SAD4PQ+OV1AtL/Aw8o91xrntRfei5w8YtvZ7VKzFVfV1hoj18A1EN2oaBNHOlcsmQ7lD73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btSbT0cpLZaoM95qivs0W4t+ZFQzKEbgOKdVQgO79N4=;
 b=EZDpwDfKrfddhpmzlvCsLMj26zDkLJ7V3pn+1jYMSH3IyHGl2M/X2VVerNnnsyJhH5JzmqiW7AZZcryUd9M3YfcizOEE10XUfoi+zPCP0c5pTqJ/KkUX5SMLxntJOK1c5HeBwhFhK+J5gkz+DRWuyYFDKeXd77nj/66x1vE95NVbYq4TJoSONXhV76tJojfeSg4eI4FZjRSxNzbrUOIVSi26QIju5WCLIdZyqXJSbFhXKDAuco9LVvOQWd0/MxjNh0xO5929xfdRGeF1r9y+QCRGmiFOEZ/CRR6YXTsJzGXvXTV7sh8m4ntk3wmSAtzdDdQFu08mC2DXu9Zoh20JKQ==
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 13:50:27 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::e0) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/11] mlx5 misc patches 2024-08-06
Date: Tue, 6 Aug 2024 15:57:53 +0300
Message-ID: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e554581-16d6-4dfa-636f-08dcb61eba91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lHRO2Y3UE85VC3Mcb+FcGuS9/WZwL69qw0iM1/rYYZvoRriiyU+298vo1pX?=
 =?us-ascii?Q?3Tfxa6ILG2sZmOt9xbVaiO9/WbO9zOYQJZqXkfly6A+6DDWy7zzagq4LYiSe?=
 =?us-ascii?Q?QaWFP/zyMph3tHop6EU/hN9OSKTeQpSCqgyyOuSX/wwt+K0vhTdWoufVKZFB?=
 =?us-ascii?Q?G/ucTDrCuuUAHXpweV9Kx7/JyD0mNvzmBfW6fjGnpTQX877DjFS3LyBWjv7R?=
 =?us-ascii?Q?HFPJJR6qtT/6K+cRe2RMn9A7yEJT4mibzCVOeq6nhT96b0suhEBAdW1QDqRA?=
 =?us-ascii?Q?7JzOjuqAzUBHuKnPRhaR8Fa16IOGYI2Vp2OLvR80kT3mDeReTvf0e8vAvV0A?=
 =?us-ascii?Q?EHxg2lEP+Va8BN1bzlCkm+cKoWLVxHA4LnFLhn3NpmxZgUZJMoZ/pgn4QKSh?=
 =?us-ascii?Q?bO47nntiBQyDIncZm2mxbUyrlCPQ63HQYLrwlnf2exbP1//fW9km/zysysyx?=
 =?us-ascii?Q?KEZ2DjZ+NuO93YoLJCW1tZLnt9IHWTAP8/og/zA7yUd6Ml5yVc6vJT19dLyr?=
 =?us-ascii?Q?QVgOhwJyt2GqP3YQRW6W4CEVCBNcG3tMD6khU5YdEpCNVTYvHgAVA+JI37/R?=
 =?us-ascii?Q?JumGX7IFYt6fQfwYlbMJB9leMrMDjxzTzKFUeZ1qXagqh/wHeF+DYB9uxpcB?=
 =?us-ascii?Q?ZFGp5cJ0QJFqRT/Pcnvgr437TW4Hd7km4RCJynEDa9mW1LymOP3kkZfJ+pr3?=
 =?us-ascii?Q?RM8MbAfdVH6HAkMkcR1UIJmYgwmh18AG/FTGN8DwHzWw1bUU7N+TVWRs5laP?=
 =?us-ascii?Q?k+CjY1231xa8cntNh+BGAiUwV6H38istvm7UGr1Ok1QBguY7rLF3fxjdocRQ?=
 =?us-ascii?Q?248ryUo5JOr52YiQ4EFvA9KE/eokcA0ZcVyWJA0QQ/s1ogMI35lLN9/1l6t8?=
 =?us-ascii?Q?QCnlTO1nt+nmL3lkGw7dmdmgozja9H59OBEvzoX3Bbjhyqn4KBqCdsp3LZam?=
 =?us-ascii?Q?7jW3/Scalivd5gJbPaDUNCTyu0H4/snLVjwmoIA6rXcIG3dOzPttSggoJSyn?=
 =?us-ascii?Q?DcMIQrI4ZDTuTO0BLHWbaqocL1FqJAPnFHHCi4k9NCgOCaPpgpHVf83KdYGJ?=
 =?us-ascii?Q?xtppyW5cSO/2udfsrkbTDcf34SYbdeFpVTLQLvH6GJazk17BrBcB5svA0law?=
 =?us-ascii?Q?oy6HonyHoff/fc0zkzfuFTSewWobjoCbDhd2W2GQy5Xu1H9nElh81TagX5kD?=
 =?us-ascii?Q?RBxi7coWOec2ir+i4dMFb92RRYnC6RWGcINjjpknypKBQQEiYuC/d+lbrpK2?=
 =?us-ascii?Q?Gn0IwQM/B1mcEPrUFKRRos+WHNz+GehuzPCWOOBY3vxjMK2X/LxFGtqDKOsF?=
 =?us-ascii?Q?nJhFfoWX9O4ZaJBCujijsKLzAkLb6/ZbwlZROHox3oL8fTcTf+YY8HV+guf3?=
 =?us-ascii?Q?bqgTXRFTbOHX/5F/+O8WwJv5AmHBujEYHYP+Aqi7ckXHn342QUukiMK5tu+c?=
 =?us-ascii?Q?Sc3F0wrBrHHG0t6wmPZq+4vZv99pFPGY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:27.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e554581-16d6-4dfa-636f-08dcb61eba91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

Hi,

This patchset contains multiple enhancements from the team to the mlx5
core and Eth drivers.

Patch #1 by Chris bumps a defined value to permit more devices doing TC
offloads.

Patch #2 by Jianbo adds an IPsec fast-path optimization to replace the
slow async handling.

Patches #3 and #4 by Jianbo add TC offload support for complicated rules
to overcome firmware limitation.

Patch #5 by Gal unifies the access macro to advertised/supported link
modes.

Patches #6 to #9 by Gal adds extack messages in ethtool ops to replace
prints to the kernel log.

Patch #10 by Cosmin switches to using 'update' verb instead of 'replace'
to better reflect the operation.

Patch #11 by Cosmin exposes an update connection tracking operation to
replace the assumed delete+add implementaiton.

Series generated against:
commit eec9de035410 ("Merge branch 'mlx5-ptm-cross-timestamping-support'")

Regards,
Tariq

Chris Mi (1):
  net/mlx5: E-Switch, Increase max int port number for offload

Cosmin Ratiu (2):
  net/mlx5e: CT: 'update' rules instead of 'replace'
  net/mlx5e: CT: Update connection tracking steering entries

Gal Pressman (5):
  net/mlx5e: Be consistent with bitmap handling of link modes
  net/mlx5e: Use extack in set ringparams callback
  net/mlx5e: Use extack in get coalesce callback
  net/mlx5e: Use extack in set coalesce callback
  net/mlx5e: Use extack in get module eeprom by page callback

Jianbo Liu (3):
  net/mlx5e: Enable remove flow for hard packet limit
  net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal
    port
  net/mlx5e: TC, Offload rewrite and mirror to both internal and
    external dests

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h |   2 +
 .../mellanox/mlx5/core/en/tc/ct_fs_dmfs.c     |  21 +++
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  26 ++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  46 +++----
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   1 +
 .../mlx5/core/en_accel/ipsec_offload.c        |   1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  81 +++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 120 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   7 +
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   4 +-
 13 files changed, 255 insertions(+), 67 deletions(-)

-- 
2.44.0


