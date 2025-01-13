Return-Path: <netdev+bounces-157790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EECA0BC3F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6293A4C54
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24141C5D4F;
	Mon, 13 Jan 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVFC5zql"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3017BA3
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782926; cv=fail; b=M0zxjmbTGfUJnpx+bx35z+5FdpoT7J4HwLVQdiCt3uUjypr02huH6BsNCU1JJDfxPgedXtHcjm6EwM01GyQGc3NZfKlpSBvyEEx4j1O+bPri1SkOp4AzFZudKljMZraJ3VKj5bKu5a6dol+P//yfKTQPs+6kmNv/g8IqjVPwq2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782926; c=relaxed/simple;
	bh=uM/K3fd9emwf79rsEUw+sgjub0HTLBsKKmoaCTHtG5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoInk/N1GhM3st7mYDUWGwYI6F/CzgL+O8yu2K29JePVTOF3b7RLIgf2/HqOhBxX/QMF7AinPkcngucj72njesL7MNG0WIV4VNhM0sOX1+CJil8JkZl1ppbd2Z4aPjxUwvdzVrso6xTv78bpQ/CuEHZdiVUxJ/Yb1t/PnftlJek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVFC5zql; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjEIJw0Gu5yURf9bQRWV6MIlXaCLNt7Rt/yCeuXZUcjPX1wyQaHEy5OaDpOH+80HvCWxkVco83s1z3E/nTNmT0ohIi6oSQ7uK4mKODAUfE6h7UF+C+KA9fYyAAtOm1o4QSrrdbn/1kKKdP4NE6TUiIucxjrW3A3qDgj59fnUBSs2GU+exrbd70ky8nDc2ZkZxUgMPQt78YQLlYRResYpzfPZPSxHdyOC2AsMvYZuq4pDb6qQal1MNKxHv6J6c17ouO6VB6JV5ho9r/j0os2v4HdQbmSikHaGvmd8nLCsYmEmCynnpHEWqeKoBZ3O+qCu4bApPhSTkMMah4QyaYEGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlVhj+3tcSCouisoSut9ojv1+C8SS6/FXdAdngmeBXI=;
 b=gS2N1COd9Mp7QBNxbM84wA4BcYFe/g9DmTRLSFyf6+LbCIpNndtMiV9zFl2rJUNX3jWujVGK4AepX1f2eYsj22isepjsqumd/KcJHoZEOSU5liyK+YvrQzZDd9EIh66avBIhqtlsoxuLBPes9K1CgbA3LlnxzUC8gD3d2JKE0MHEiL+90SW5VNyxLI8V+aaApLXvyIlzCWYEReTK5i+9SQuwBCUd6irMR2YE4pVHStxupA4cE+TY55G8QSr/IESAo1blEEpjLLxbgDpwCDnkkYVXXQlFKSnAemo2ErcQG5bQr7nnfFotEm4TetsCqXugnClTOEcJetRCrNWDZa9J7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlVhj+3tcSCouisoSut9ojv1+C8SS6/FXdAdngmeBXI=;
 b=hVFC5zqlWWBVl7NhSbfyj49fQjT5esvEa0qIhzQ53zUf70ZDluvm84nvVONMW1rb85JmOgBrHkKM5OPnbcD0HS8LVFnvgxgS5qBMGeGqTw9L7lQpn+uXlfStnazSokPzGQqN60nD3Dxzzft/8Bp0ZNNI0HSD6F5XAaKSDwljI7nwdPZPi6YJ1DNm+AQUcg8krQg43xziajuavusYd6CAAgiZ2Dx/9kzIxcPnLh1mE6CSYf3pL2ducJss8deq53euNg3SGZlE3rEFzCPztSIeIfFl1gRneJ24RIdVzW5scphQ5SvlvRkoLl8epdPRUt9jQHrsojq3EONB132SgfTdgw==
Received: from SA9PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:21::18)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:41:57 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::88) by SA9PR13CA0013.outlook.office365.com
 (2603:10b6:806:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Mon,
 13 Jan 2025 15:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:41:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:41:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/8] mlx5 misc fixes 2025-01-13
Date: Mon, 13 Jan 2025 17:40:46 +0200
Message-ID: <20250113154055.1927008-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 11459ccc-65e9-4437-2cea-08dd33e8d030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkqtTh1guF9ktma1PmQDMhp+oMRzgosIbdcOTuEbOvWUtFXhh43vT8l1cTZV?=
 =?us-ascii?Q?Ioajbr/ql1FhV4XmVU13FS1qa+0uL+60LoI37o2H7RjDty4uZs+GGkr8BT0j?=
 =?us-ascii?Q?cBXA4yOJnmNLyyLppalZuVfSvoz16dCJbWrJEoWG019xqsTE+MECnsnzn+Nt?=
 =?us-ascii?Q?bSbWF3+WUq0RDAkyGERUHjmlxaXtMECgLG2Hhuuwk5GMeck00nvzVKD9BTWK?=
 =?us-ascii?Q?uh2M+/4DqXwLBm135hRrfir0x3Q+x1JcsynJFGKc5jQ4E+wwRHgNglTEa4/x?=
 =?us-ascii?Q?VikBagXTRDElxYOuVT48BoSGl0B6Q72I1yb9ukTOR/ARtMRluPQD6ZKDMo9g?=
 =?us-ascii?Q?AwZ0EMzrAO/FIgBzztfD+uQSBq0t8qxfBqBJ/wxIyLl92hEQW7gjTrDqKTYi?=
 =?us-ascii?Q?oanPNZkJPrjjAnn7XPHJXZGrdYg/q6rxUFlcZdnw2R92DX/iOX/Z9pZYc3j6?=
 =?us-ascii?Q?Mf6c1H7vyGX+nKUChWXxE9lcU8nzdK2sXP2AOUbdqxYUg7zTWdj2v2NM/IX2?=
 =?us-ascii?Q?9rMD7eSd0g9PNciVyjhzPsPAD5L8BFEqA36JNhqnQt56J25Tw2LquEHFU3C0?=
 =?us-ascii?Q?DGTcIfoWp0toR5RH50HlQGaoeqELgbsLWNiiTvfEGUaAUcM6uh+I/Gp6xw7r?=
 =?us-ascii?Q?qlRhv+/MCXG//gqumJOtrf8l/09T/MIJM5eqmoVmUejDTWgAIfmXQH7Dq5db?=
 =?us-ascii?Q?Mlzb7/DS32u6EpmlrpJooKQTdmFLUzkor8dEPElQK89FQ/WhZM/3hmFziQo+?=
 =?us-ascii?Q?+fHUITEN3XCWyXRC49f6qTZ7e3Z3Ek/cE5JLMS2YS/8DbLdrayu9tweYewB0?=
 =?us-ascii?Q?Mz4B8AwxUnnI05hUodD72P07qP8Xl4WIF9LKy65nVk93SQZ/olWJKmOJ4Imx?=
 =?us-ascii?Q?EoSse0Dc5SB4bilKtm3rX/5qQ8e++wJZeysUHOFfkMFB9x+oF5MZ8b7un2Sd?=
 =?us-ascii?Q?yiE3UCM3lwnva0KaFvAlLb8YZmT2cmP+LinBwkTIcOR3vGDfbEuYEttED1e0?=
 =?us-ascii?Q?Zd00329jj27mirPa5FJ47o8YbkrI8wNCX0ufWhOJPl5vV7cFuy8sBis93oE3?=
 =?us-ascii?Q?ZZVqocbvMolysWlRpMUiRJjM3eAzFUF2Yl/+osjvxtjB+qBPaZTz6+Ah7Tnt?=
 =?us-ascii?Q?RulrWfT9TG5WKlRf21XIW+FUF5eJRvaUKejPhRpouzFZAO0mi3Si+Q26CIk8?=
 =?us-ascii?Q?KKi47PYWHdfUgyrFiRGSrsGd7yrbNEyHiUBNrzx5eT9XHldTd7pXbEdWWSUK?=
 =?us-ascii?Q?bnL9Odp/lPOtx1GXjN5jOW9DUWR+Yo3rtebRJSWFFtwzZ8VZANVq//GjLaYn?=
 =?us-ascii?Q?fJ+ilVYQ9XoIcZHYlTwoTPxe4BiumEV3n7SkdMRQVqL8UzwFdcfd2DolYep5?=
 =?us-ascii?Q?ANaEAtbtwBj049MvMJ1/dlSYCE9HQy4q91MJqiB0+SL6tTuK7vRYA6JBC/Sr?=
 =?us-ascii?Q?dR4wwDMjRtA+ddUu/kROLN9i8/gvy43XdtKadpwfVLfWfbtygg7JHfTCMANY?=
 =?us-ascii?Q?337BhNKr7EaQPOk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:41:57.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11459ccc-65e9-4437-2cea-08dd33e8d030
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

Chris Mi (1):
  net/mlx5: SF, Fix add port error handling

Leon Romanovsky (4):
  net/mlx5e: Fix inversion dependency warning while enabling IPsec
    tunnel
  net/mlx5e: Properly match IPsec subnet addresses
  net/mlx5e: Rely on reqid in IPsec tunnel mode
  net/mlx5e: Always start IPsec sequence number from 1

Mark Zhang (1):
  net/mlx5: Clear port select structure when fail to create

Patrisious Haddad (1):
  net/mlx5: Fix RDMA TX steering prio

Yishai Hadas (1):
  net/mlx5: Fix a lockdep warning as part of the write combining test

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 22 ++++----
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 53 +++++++++++++------
 .../mlx5/core/en_accel/ipsec_offload.c        | 11 ++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  1 +
 .../mellanox/mlx5/core/lag/port_sel.c         |  4 +-
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 24 ++++-----
 7 files changed, 75 insertions(+), 41 deletions(-)


base-commit: 76201b5979768500bca362871db66d77cb4c225e
-- 
2.45.0


