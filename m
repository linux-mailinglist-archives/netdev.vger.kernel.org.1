Return-Path: <netdev+bounces-156758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD11DA07CDB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F040A3A260E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5921D5BF;
	Thu,  9 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s8520lPI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4721CFFA
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438834; cv=fail; b=r58SyVUx2seoWooAVY62fu3AdLogGuFRC1u0mIPiEFNXn6tA+BWfIG03PNn6zGJ+7Yoj5qZDyfZ+R89WC/nNC/7ed70iN6wYqgUuU878SSiWtXaC00fmaSHEORK/lQxRgdgWcYowgJwAYmS6sega6Ntq5NcOSP26S16Dbr13OxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438834; c=relaxed/simple;
	bh=0MZIyoRYZPKpZ24+R5+Sz1x7wD6XN7xsKTfEO/cFyWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6udKj9r8/2we2zmK092Moxyn35KkkvZ1bnCoyxW4zfsLrmBEK5RsJUyjHiD4+BzcOr1AcAssSEGqOtpgxIMpGAWTYQ6MgCeB5iN2452f3qAYSXNcypK2AJD81wQ9/YriYPeA8NRDC23sMgjVajl06K2HU4QxlTx8disbeYvtzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s8520lPI; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhXA9jp4NWCe9CTnS5FDSGBF/6zWEv6tFdG3ZiyLbz96nrnOOvNcS0TE4325L7+X0lYdrFjKHM1pbqvLA6EnCxQFv20f3iNT+BNi+TsigH8xgrMjG80p8duZjMg7L4fzhHSAqBAVE2LqEr/PIrwMO3QlVCRmulTlEhjfil6PJPNJMwkqdwQAcip5/fc9RbCIz1DYskorcpX56dMiCiVOPp9ET6bVXAu3hM6Pzl8oOKm8OeCCqFci0vGGeuI0DmavK0TRn3MeV2/y9PDIA/hOIotZoaX//NFX0iZVtGxc3egT4Pg4U9wOA/4UpUv5K1g+Rc0OWgZ0948dfOHgyY1xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGrdClphlDZMBNmDe1MdYq0R+2G6yo9vYuZEPERfxbg=;
 b=p5gBukOu1ie7cSChsmTGP2ida0Qb6HtQWMAlGRaQWuwWIjDRYaO7yq8X+oYr2Eqmh9NtN3XqkQfkCy4DvcE2e9yVfJo4e0K3Jw9NvPH6bdYFB63S79dlbNbCnQOpWZzemWB1V2sAenI8wB9LKS4c1kNDIILE0+ER66qW1T8TErrz5Oerv/x52s3l3++y+PJlq+/QXyE9KW+MFp96H8WHAubbWmpKBNTUHb2SsrOq123ZbhIUtlTdzEsPJNedJSmlwGuJi+Y0JKK+UBAVB8qZP4mel/El5FeC32gYaATVK8QYGvQ2d+Sy7FmNfD/KledzsrWvIxj7K2GWNQfsEs1IUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGrdClphlDZMBNmDe1MdYq0R+2G6yo9vYuZEPERfxbg=;
 b=s8520lPICL8E77ckoN63Hsmg1UtHcSMpdcY3+fQkdIfLyNe8lfpaYtsL1zpIGQpwloZvFsC3gHFCRPS2JrAfr6RkOwlv6xdpk9ymoV4pdT/z86mry7NWFmB6Uq1z8Wh9mcyvRMK14mwCKy4dkBUB6N/hbpDdLT7GDMJtWsKmjmdoUiN6IgRl5D6IvUOuroOYsAd084FINt4m+qTRA7fhixUeBEkDaVt8KZ6qGuhNhBnAk+6C8uWoKRfBydXcL5a8oq13Jd1uJGL1bJeBy9OJlaI5vEjQxwDHANhHi/YTAnpq+ZPqJ5DhgIIJD3RHoLZoi3E1fSt4IQdimGrf+3tEtg==
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 16:07:06 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::31) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Thu,
 9 Jan 2025 16:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:52 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:06:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/15] mlx5 HW-Managed Flow Steering in FS core level
Date: Thu, 9 Jan 2025 18:05:31 +0200
Message-ID: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aef002-f117-41ae-8424-08dd30c7aa01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJF9IDUCXWFfbVjO8kJ2BlZGZwOUANePqkB4wv1H27b7Fam1kaUS8VVgJQyd?=
 =?us-ascii?Q?CDh6WV8hrid5OoIkQSce1ZIUqmLlAbrYVmRpamv6PswrXsG5oPFf2SfCo4mq?=
 =?us-ascii?Q?XWd3yiU1e8teNE93lHpJdWlToe7nNDYhdnTbS1/jkfKLP2Eqz383LOU20UPt?=
 =?us-ascii?Q?biUoQRFbDmbh2VwdLcuAWVAVPzMf6EbWT0wWyCXgLWnX/u4qpwBoqv6kSpB5?=
 =?us-ascii?Q?zRB4c0C+7BsD0UyZfgZJbsBpupNWhElsm7dsuVF3ngRDVsfPsyhPaEs36ieS?=
 =?us-ascii?Q?9ELu2xk7Wcc4D8aO2KIRh0pCZ+6H33jNE2wjTcO8lyKcfX9ex782p9jgSOoL?=
 =?us-ascii?Q?dkLPnPJ5O6EX2BK6O6vhhvvTO7LE9l22yh77vGlbY3qC4amm2v7ZjvxDxhHI?=
 =?us-ascii?Q?yCYMYd4Fr7RBtc7lQIxDUFMNyVInQRBFxePpuS/rWcjJkNcWNxlfXU0Nr98A?=
 =?us-ascii?Q?FUtHeRliUQApdl+5MARowtMieA8z2tbLiCfDWc5/KIu7tObjjKM7+Pm6IBa5?=
 =?us-ascii?Q?fy5XjqPIGdSvyb5QHi1tg2bYQAMN1t89mVQdrln/NqOd7H3TQBatvIcXzv7a?=
 =?us-ascii?Q?EDkHJWJBQpA24/qNvEVyWiCtouDKr/4fZOkE6zcEHyj0k43whRfKbsecOXSm?=
 =?us-ascii?Q?hZY9gdxYb1chyJG4RHpEHRxWbxj/TLHOZ9Vp9Eg4YitfMhoCeKL7AWk9Ot6o?=
 =?us-ascii?Q?JSFNfdBPhUGRBJRTFLETjsgH2eaxVYfW2iE7+87/aWNXWbxZp6MbQou44zUm?=
 =?us-ascii?Q?tBI5H8iI3VLR0rnsfiMS56vZy+w5B919xc7Ijf3eJTPkumfz+DhOhtzzwd7m?=
 =?us-ascii?Q?qV7InYGjxuHYLPGJXavx7+sYHfUECzjU4Y+9neaJQIGOly8Sj82lIbIyPZ+O?=
 =?us-ascii?Q?j0x/zsKsqmC5SnN49f8nBDNBBcwJXfO8aUMBGT1mEVDUJpvKqqnr3GkTL8vG?=
 =?us-ascii?Q?ey6pSOocsJbxXL4B7BKf4RHvQ/JNk6cDAV4BQey7axirUUJZFrUHJJL1MTtD?=
 =?us-ascii?Q?EbYnSBIA1Vlu+w17nMp6AzYWjeGBWDogIjXHNrv7YOaKFBvf+wuYX/eL4cQC?=
 =?us-ascii?Q?VCa6p2yd4xTuyUOBJGMiPmErhva/uhjQxf85vblskfAfve/5Ep6XYXc7YlDn?=
 =?us-ascii?Q?t+fkM8xNLr/hQhGG+XTtLxg8wNdeBZ9F8ZNVcRcAQ95UxyUHtK5rgChf2uTs?=
 =?us-ascii?Q?y1aLW8IfiiI/SBlTslNKnk2RLNjHg2TA8GCucJzGS3SxYkPYDvayZtk3KvWa?=
 =?us-ascii?Q?42z9DEKYT8WcskPONfT+uMP4C6TvkE/XDFs8hgMDpjsBzDdKvSOnds4LtoKR?=
 =?us-ascii?Q?MzyQ17GuK6pbDbZKdYGZhuYsoXkQ0IT4QHtZjztTmu1L8Q32Qf0PcH0rc0av?=
 =?us-ascii?Q?qDBFFAqg7Kpf9j+uyTlyCEBNFyvP2o89WQ3EAdFoMPkA46jH9ENEw7cSERKD?=
 =?us-ascii?Q?39krvKJ+9KNU/JC4sob90dBMhJlwkjE0BRCRA4MeBKb6WQzDmxBlXFJOU63w?=
 =?us-ascii?Q?2WtyWvEKv8siI+4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:06.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aef002-f117-41ae-8424-08dd30c7aa01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

Hi,

This patchset by Moshe follows Yevgeny's patchsets [1][2] on subject
"HW-Managed Flow Steering in mlx5 driver". As introduced there in HW
managed Flow Steering mode (HWS) the driver is configuring steering
rules directly to the HW using WQs with a special new type of WQE (Work
Queue Element). This way we can reach higher rule insertion/deletion
rate with much lower CPU utilization compared to SW Managed Flow
Steering (SWS).

This patchset adds API to manage namespace, flow tables, flow groups and
prepare FTE (Flow Table Entry) rules. It also adds caching and pool
mechanisms for HWS actions to allow sharing of steering actions among
different rules. The implementation of this API in FS layer, allows FS
core to use HW Managed Flow Steering in addition to the existing FW or
SW Managed Flow Steering.

Patch 13 of this series adds support for configuring HW Managed Flow
Steering mode through devlink param, similar to configuring SW Managed
Flow Steering mode:

 # devlink dev param set pci/0000:08:00.0 name flow_steering_mode \
      cmode runtime value hmfs

In addition, the series contains 2 HWS patches from Yevgeny that
implement flow update support.

[1] https://lore.kernel.org/netdev/20240903031948.78006-1-saeed@kernel.org/
[2] https://lore.kernel.org/all/20250102181415.1477316-1-tariqt@nvidia.com/

Regards,
Tariq

V2:
- Added two HWS patches to the series
- Added documentation on mlx5.rst
- Added prefix to static functions (Przemek Kitszel)
- Fixed returned error value and copyright year (Przemek Kitszel)
- Added missing braces (Przemek Kitszel)
- Added comma on enum definition (Przemek Kitszel)

Moshe Shemesh (13):
  net/mlx5: fs, add HWS root namespace functions
  net/mlx5: fs, add HWS flow table API functions
  net/mlx5: fs, add HWS flow group API functions
  net/mlx5: fs, add HWS actions pool
  net/mlx5: fs, add HWS packet reformat API function
  net/mlx5: fs, add HWS modify header API function
  net/mlx5: fs, manage flow counters HWS action sharing by refcount
  net/mlx5: fs, add dest table cache
  net/mlx5: fs, add HWS fte API functions
  net/mlx5: fs, add support for dest vport HWS action
  net/mlx5: fs, set create match definer to not supported by HWS
  net/mlx5: fs, add HWS get capabilities
  net/mlx5: fs, add HWS to steering mode options

Yevgeny Kliteynik (2):
  net/mlx5: HWS, update flow - remove the use of dual RTCs
  net/mlx5: HWS, update flow - support through bigger action RTC

 Documentation/networking/devlink/mlx5.rst     |    3 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   50 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   62 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c |   42 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c |    5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |    5 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |   10 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 1377 +++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   80 +
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  450 ++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |   73 +
 .../mlx5/core/steering/hws/internal.h         |    1 -
 .../mellanox/mlx5/core/steering/hws/matcher.c |  180 +--
 .../mellanox/mlx5/core/steering/hws/matcher.h |    8 +-
 .../mellanox/mlx5/core/steering/hws/rule.c    |  141 +-
 .../mellanox/mlx5/core/steering/hws/rule.h    |   16 +-
 .../mellanox/mlx5/core/steering/hws/send.c    |   20 +-
 include/linux/mlx5/mlx5_ifc.h                 |    1 +
 19 files changed, 2245 insertions(+), 284 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h


base-commit: a3b3d2dc389568a77d0e25da17203e3616218e93
-- 
2.45.0


