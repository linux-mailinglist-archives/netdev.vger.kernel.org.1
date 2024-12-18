Return-Path: <netdev+bounces-153023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF59F69AF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5818836EB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4CE1D5AAC;
	Wed, 18 Dec 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDlepW7R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097B1D5CD1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534656; cv=fail; b=r5wwjK899WTg5LyoVQQTx1nSlKIgBiYPOGBpj7S1aPAzZpiPivLjw8+jCdyizDWk5NdwBqlEmudoDSX18fGMXEUADR3zlzzP+x0tVaGWegzZLERVpJw/n8rXBu6R3HHaW0wyLIFTE10ifOlSW8M1KqwRZHax5lxYRDQTVaGdPGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534656; c=relaxed/simple;
	bh=D2r5LjfLQLtzezVZgVMaozz1fHXbxViyOcwxeNj7FJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GVOa+j88CE819Ord5xknDEUGG0ymEo6AEzEh0jCWLPCPr/neveXD5SyX/Mir0bhODwXlN+4uqL1LPXnhhkw5+/IjJ0tNvVNavUhcT1lzAfOtVZ+wTsF2lWNrQMu1EDCkya8qfJ9hENGlp3VmdhCukyFJTOLwXWmf3qfk8d3vdCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDlepW7R; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOuLQeTPaj2uu2IorXpSXZil86/yTEjPMwAskgOu97AXDrkE8cld0/mnV6wbx/fvKhGjXzCpcrzohyulS3dYgBeP/r3vLWbqu+Cb84P0Ty8gkGQjgyKts0IDrKEkn0SkZlK2SzVKuR5nf81tUuQr7/buzi0jqvhcGZadX+O1waDDzilYano6C3IAx3nrR1N7D4I1JB4raKS8O2PTJ16YVQsLPkwYS9j9gmHCrmB+cZoaQuQk8w3rVTbVsn4cl3gNwaq6/A/Nwrjn/AA2Yl7nDJ9VNgGRPyi4jJ1DRK9G930Xj3qf6MPbZJv9oM2u1+MWH+coBp1T7AepvKfocJhshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5sKOSlaZZb2FZHDL9GhorBLYOavW6TqEMnR/ccg5MI=;
 b=NnabWjOByZ+iXrQC1UKDYow94qZGToxC58nz+J4XMrFMNbD/YH2wMI+ZJYaCV87Uvk3HVYeHI02wkEtbeSfjne0eoKKgReOj5va4ZXYwLKP9YnUf8dEXDxx/iXM3Qvy9x4ehokkrPIJWSUgQvt+Oyr8wdzhK7ZkshWzigdpgDbuLjGVVezKprPqafIjs10Ude5SOmtizBi7KuKWWbHAHW2zjUKbGEPqFUejYT5cH1q6JoyYKQxpFzkvk/1Ub3bGr1nrpjVdehwjF3eUfz0059ew1TDmZ35q259plry5R7Fgca3JQCFQQeBI4B4z8M6JqInR00LEkq/dP5SkztHbogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5sKOSlaZZb2FZHDL9GhorBLYOavW6TqEMnR/ccg5MI=;
 b=ZDlepW7RrrCULBJc/6gp4P1Fwpc2BJIwoqIlMAvZn4yeYXMR8jiMBq0iBfP2G4qFpjfPHrgHIxQF4OX2KdeSMxkNOdGq/c+8fiEa6ypM1pPpkCxaoLV0iie2m7cqufEFo70lU+3HG1PdTwYGTTSxfrnBNDmAx0YuZZh8yE6+eiRawH0otwAznpmXwvU8CJNyQjYZpCuf0P9UuwAaXE6dULzKN83wZgqHtYA3o3petOxdLsYyRGYvEqok2dIeSAEA/dXb96l4csuXCEE4BmO5pjHURmzzeRrTrtuAT4tADr9PyEUF9JA1FiyKiv4CR1KWsiKY7R+PlU7Pz7QPkB45fw==
Received: from SA1PR05CA0010.namprd05.prod.outlook.com (2603:10b6:806:2d2::12)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:10:47 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::b9) by SA1PR05CA0010.outlook.office365.com
 (2603:10b6:806:2d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.8 via Frontend Transport; Wed,
 18 Dec 2024 15:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:10:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 00/11] mlx5 misc changes 2024-12-18
Date: Wed, 18 Dec 2024 17:09:38 +0200
Message-ID: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 01728979-5511-4d4d-af55-08dd1f7626a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H4v5/DKTbdc7VZEXXbkvbrhRaadWsyjyP6H9Rep21Rq6CAL53WPnzBAcsnAs?=
 =?us-ascii?Q?s87PF3vvA/RClNzjzrOZGv5F06J5QXjvPntnbLOIbstRgKL+PY3fYH4gF+BM?=
 =?us-ascii?Q?iDrI2jUuHMC5CkGq9xP0WdCP7yvS+n1Y1REP9iGYiilo4D0/PlMp02Ro5Vgl?=
 =?us-ascii?Q?iqMvUgm5aqUKfJ+jOqbyTLVmH3j4pfamwNK57fhhQX1+8bAbI4/cOMlKiqyo?=
 =?us-ascii?Q?95jD/MeejG8noIVVDnhZ/y6Vrha572qcVbZbWAVGutG13sZz4x/SDuMdBpNo?=
 =?us-ascii?Q?lXPFRkvkpZiT+I7q3CUiwABs97kttczmYosWfB4PIZJRsuPPZlPHOBSkOy9t?=
 =?us-ascii?Q?yzSbQCIDXYMn9JopoVJVrMmCVmoTwmhKk7LuHoSf/QoHfqhWCQrqsETr3EQU?=
 =?us-ascii?Q?BMNI9GqNG9f3KIVNVi4rXIcy9ZG8hQvaxREgSynam4XFS0jpT8Cy74oUyFAe?=
 =?us-ascii?Q?U0SXXcb9ysxEnEO29FoeSsZup5g/Fkj34JidA6KhtyIJxCx251i6ADRWxd7r?=
 =?us-ascii?Q?gvICFXg2UGZhVjTSWynhaCefo13EtGCimfBZ8hY/ZdDG9IfK04YGBk71a3Fc?=
 =?us-ascii?Q?FGynZ8/imbnpGbjG5ttVWVOFWe0MCJs/S2pcFYuzeEWBrPEfFcsqLn/NKqan?=
 =?us-ascii?Q?xJ9AdadzACSuaUl/BhdZjYSBYCIdSN+U0GzNKxUJnjcYjOYe/OFEzH8eufGy?=
 =?us-ascii?Q?3a3MZmQpxmd6ND5rynDysVRpi49IrP1FlHxSi7zqEM7S5vUjy/qtWBVyLIug?=
 =?us-ascii?Q?WCvsDjUm+XKd3Ku2n91obQEJhnzgMrdOizZ4UuS0fMVkSoXegzuZCKOu5nR5?=
 =?us-ascii?Q?DFQWh6rq8q3SVWWOL+YnNcUUPfsyCKb3s5te/FxUKAGoTlvnnMpTp3KpM9uI?=
 =?us-ascii?Q?iSGMX1SuQrvtb8cB8+eoYIOPXw+KyinHwY+BTvnPBDBmbZUkmtFIQhWW5v0j?=
 =?us-ascii?Q?4q6hQxS+9IiMZBPOnzq3YpThbH/+haHInnuY1HtfwlU+RTKheam3Zc3ZR3Bm?=
 =?us-ascii?Q?ydZsWdE7L/kQcaUKGLMwHIbHXTQ0C7XLtR76XkAR8Zs8Anfk6OT9Q5okQ3CT?=
 =?us-ascii?Q?pCUjmZRDcB1NX9yFYROujw4RfgKvvbAg8yVBkDHxsKwcCeEibu5jyLBIzt9o?=
 =?us-ascii?Q?KZxhGF4YsRttPaKaI9dQtDrAi2NVntkpFJVYTCJZg4Qp9WlsQda5ATzS+0Jw?=
 =?us-ascii?Q?WpYN6AU0PKeFXF/m/vlquAZw0RP7OIPM89iOy9viNEO2P2JVMot0XWk5YspM?=
 =?us-ascii?Q?69brLNCzXizkRd5flzCV5NoPu84gMR5d2JYxVAc5AgFTItu8NSYwl8qLiDpS?=
 =?us-ascii?Q?sou42cX/5td7V1aC4MLM8mP+UMsjK7TxWDVP9GKC4cGYgA4Fhw9NVAcciEIF?=
 =?us-ascii?Q?iLC6ahV2hzAnJU3/pBU3zW1Ns/coswhN2R6p948HOWP+NfU+YU6AvecG7XGk?=
 =?us-ascii?Q?M5iNGTXfAhmW+NuoSAwxWpDsg6GVe6nPlL9VNnekQCsJOeJFBQyjwJXu3vC2?=
 =?us-ascii?Q?RBuBpIKJ4Lb8pR4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:10:47.0001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01728979-5511-4d4d-af55-08dd1f7626a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560

Hi,

The first two patches by Rongwei add support for multi-host LAG. The new
multi-host NICs provide each host with partial ports, allowing each host
to maintain its unique LAG configuration.

Patches 3-7 by Moshe, Mark and Yevgeny are enhancements and preparations
in fs_core and HW steering, in preparation for future patchsets.

Patches 8-9 by Itamar add SW Steering support for ConnectX-8. They are
moved here after being part of previous submissions, yet to be accepted.

Patch 10 by Carolina cleans up an unnecessary log message.

Patch 11 by Patrisious allows RDMA RX steering creation over devices
with IB link layer.

Regards,
Tariq

V3:
- Drop IFC patches, they are already in net-next.
- Address comments and re-add two fs_core patches by Moshe.
- Add mlx5_ prefix to functions/macros names in patch #1.

V2:
- Remove Moshe's 2 fs_core patches from the series.


Carolina Jubran (1):
  net/mlx5: Remove PTM support log message

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

Mark Bloch (1):
  net/mlx5: fs, retry insertion to hash table on EBUSY

Moshe Shemesh (2):
  net/mlx5: fs, add counter object to flow destination
  net/mlx5: fs, add mlx5_fs_pool API

Patrisious Haddad (1):
  net/mlx5: fs, Add support for RDMA RX steering over IB link layer

Rongwei Liu (2):
  net/mlx5: LAG, Refactor lag logic
  net/mlx5: LAG, Support LAG over Multi-Host NICs

Yevgeny Kliteynik (2):
  net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
  net/mlx5: HWS, do not initialize native API queues

 drivers/infiniband/hw/mlx5/fs.c               |  37 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  20 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   2 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |   2 +-
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c |   2 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  20 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  12 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 292 +++++---------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 +++
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |  13 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 365 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  17 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  77 ++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  16 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  55 ++-
 .../mellanox/mlx5/core/lib/macsec_fs.c        |   8 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   8 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   6 +-
 .../mellanox/mlx5/core/steering/hws/context.c |   6 +-
 .../mellanox/mlx5/core/steering/hws/context.h |   6 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   1 -
 .../mellanox/mlx5/core/steering/hws/send.c    |  48 ++-
 .../mellanox/mlx5/core/steering/hws/send.h    |   6 -
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  19 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 ++--------
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 ++++++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +-------
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++++++
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 +++++++++++
 .../mellanox/mlx5/core/steering/sws/fs_dr.c   |   2 +-
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |   4 +-
 include/linux/mlx5/fs.h                       |   4 +-
 42 files changed, 1480 insertions(+), 796 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.45.0


