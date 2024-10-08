Return-Path: <netdev+bounces-133260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87399569E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F16286CA6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A9212D26;
	Tue,  8 Oct 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4kk6ujb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA0320B1E5
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412397; cv=fail; b=QwTQu8c0WslYT4FhFUSi13lDXvVXXw0l6Z+/rnBH+JPmw2m6vun28Nck+2o+7k1EggmepBOX83DjAcPu0sSL+E4hPfAoHgjnxk5q4usk8UjIx8uqU/LBrxRgC2WtH6QAzAPH0TDZnAdILpYoXolT+DMwrBA6h+S9Y+ZbZ1mJhPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412397; c=relaxed/simple;
	bh=Stm+jKuew8lXpkznD79ezr52SRGqSSclvRonQT+XAg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZLa4gKQyi8MIzZ4hPhaN90nHnnXipa67Qxuko2Rwh18JKQbOAG8tAjaSIyYdODDw5Oks2VwvTFemde0A2Tw+wfd6sKIbayL3N10IR2pTB5K4z+7tRaJ6MooQYqjyPC3Z+J4iu9LgeD00eOYdZVIRakj+MxszqkYhLpAsV/0qfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4kk6ujb; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6p9vE+6Rqtej1xZy4EjEXwUfzID30IUEpxx+oYlkZKNRopzipVs/MoUJB4n2xurvotFXvYInxkn3SlY/J91PkEnfoXK3TvDRZOvOWastXtveVfYyUMMnYXe6gYfxvgPxkh+18hHSmScVyhs2x+vQuS3EPTyulHDolMaMGxOHSkEYghuaVD9XXgpnizkm4MqYf1xpo4w+76VjIkHSsj/w+Yc78VONHYN0ApXtcvnksjteCJtf5uKNBeD3oZmnSSFg0C5SxF8mo8R0gEjrUltkLZIdxskgCG7jeiKsL6HGpPnQs4njkmVzbVjsR0MF4fgQvrLZyebHXNyhXmeqby3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pswKCjn7yhIo0E1svcIncg9wW8j7PHko5OIJWxTiAdg=;
 b=Az1MYf3iVHtmLfmUMM5k0hQKSXkH8eIhvSMddAZbXLjPS5BBdAEQXIka6LicSGNLSFqkU8pyFGYbkN96gLQPU+e5N5jWbxDlEBKrzTJjFyNLrUeSID+pjq1hCWCyME6VU0IJERv6hqj3WdQT542LXvmybhuXwPCF3pzRywde3ffgGBCPHb+PWaZlFSQUzCMr66Wz/1TRRc3nAmW7EByoYJtUAeGat1nRk4HLEMtYpwGzvCjdbX8EuD4U/k/N/NHSe0FdE+ONqZ+EaqKCSs9DyHFyQX6y24o9lxgyvOZh4t1tjFNygdGfgHEgJWnOYwg70IyPSNaHaSNbhRdwJOd2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pswKCjn7yhIo0E1svcIncg9wW8j7PHko5OIJWxTiAdg=;
 b=n4kk6ujbKDAGYU7JmJoe2kUyauH/qr9IZFWkVah2/k70+eV5JJxBIsNpPk8ZjuC7QPWtUj7quIXGGJoXvkvLCh+pZe5jEoGQ4F5pe8P5O0I9uBaO5h6bhGAIabWdMYF6k+nznqIeVTNCSpNMmJXEUE6+6K1ODbFQkUzrQtgO2Ky0RvvNlnerO2Av2ttTPudvC9V8zrYWmLPDpJpuTHgYD/zmKbBGP2YeEWcRkvD0/hFb/33nIkCMZb2/ozU7hH0c0qLOWqa9y5B5AbzLNPBanvVkP7qHLTkblJLjXm9M+4h5oJ2eSJZCl/kk0TIz8Y/WRwwBmhcIy1+tHNKl7T3YQg==
Received: from CY5PR22CA0082.namprd22.prod.outlook.com (2603:10b6:930:80::27)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 18:33:11 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::ae) by CY5PR22CA0082.outlook.office365.com
 (2603:10b6:930:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:32:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:32:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:32:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 00/14] net/mlx5: qos: Refactor esw qos to support new features
Date: Tue, 8 Oct 2024 21:32:08 +0300
Message-ID: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: c2144cb9-0b8d-485f-288e-08dce7c7a92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pQSGmDCVgoY9AUk9H7UnwW3q0JxqK6300LShNEjVzHU+Z86LP/iMe6tFPR1?=
 =?us-ascii?Q?773H4h4AN6o3ohohcJSMvKL6qaUllu7KTNSXqZP6B9oSQqrSkTO1QEvG4hxE?=
 =?us-ascii?Q?m8S+7qOfBWeihOky1/uO8FjkrR5YNUwCv3v2WPxZQowgBzT7hRGVzns30M7F?=
 =?us-ascii?Q?iImp7qBX5Acg39SxXdP2NmvSt614rcU2biUzf9piF3Y9oy304hNWdHjFlP6w?=
 =?us-ascii?Q?vmD4xYAZHltF09fA8ZcWz4RCSVIoGnDlIbvB7hYa9h8OuFJMdZJTXVPvEgce?=
 =?us-ascii?Q?Pp2dMDwaMuuVNhPM8GjEWgEwhiwh4zmvWSsmLYTycCfYiuDV5pGe27cM8tcJ?=
 =?us-ascii?Q?6EE6r03/UHhnwM186y57e9E8HXne/ZVwQVuJVibj4gqMxCsF/Qyw/wk4a+/N?=
 =?us-ascii?Q?qYJzhHGSHSM7HvdoxFPCNHOSmN7TVmCDLx6pAS51phh+ZInHLnXsOPya3arC?=
 =?us-ascii?Q?5iaZDYoCrPN/l9M+QYaamfxf5QAEJaM5f8Nr1fZAl+srCBNFIkAJ2vuSI4XB?=
 =?us-ascii?Q?YE2z9EYi4ZT0tMyar5St8I3ClFT7upOSTwxncMl0Me58TrA8SxhzaI39rlYQ?=
 =?us-ascii?Q?WuY5stnoRc4Tfdes+tt4bN8nug0F2bA9DCkKq6mvVcvbKprwGVq2QRtu1lnx?=
 =?us-ascii?Q?bAy9ZMUF8NygFritWQLSkFXxaNBRYpny/Kc9RdFInnaJ9zLPsXhU4YmUHZPP?=
 =?us-ascii?Q?65n6kZfPbiNBAyqp9U67M2uP4xMIaLZ06tyN3FZ2bAVJ7fPmTRRmaoRST/DY?=
 =?us-ascii?Q?UXHcl5y/38b7RYrkoIw7OJiWqOG8do06A7QGkZVZYNc08Tj78dbElcpgzw/m?=
 =?us-ascii?Q?2xjRAwoDt+fYQ97N1A1KL3JrpsMaSQf25GKwO4S7zK+G20FU+HLxclTXRNkR?=
 =?us-ascii?Q?MEcibzq6uycMz98ZpBirD+KSibvdwpI5ND6nSOnKwIlzaYNlYG0N4xH8qzO/?=
 =?us-ascii?Q?FHt5W5qQInawO0XE3CCPoIdaYAyr8z8wTr8JfGyjS47niy4+Af2vVdPvh8GN?=
 =?us-ascii?Q?GNOwkXuhETRGerczeAKNBphZiEvI+A7iOTXnSRdppwPwilB86rhRmfQ1kveI?=
 =?us-ascii?Q?u7SvCurTKeNwL8py7HRkKx8NP5Czjkp95fUxUyx9oAVRSii9yo0QrHdJ6a5V?=
 =?us-ascii?Q?oSbchWAWwheACRL7R5zlxBUXs6j8cRRhHN5c+pTGQjveKmeG058jzRzP3e+O?=
 =?us-ascii?Q?LO9gwQSp3/ydgHYF0eoFF/O2bQZGmTz6xwS4lonDN8X2rgPzIsvele7D85KL?=
 =?us-ascii?Q?UWN1bvrqZqKYkPzSJ0QI32nyRWmZX2a9m348NBgoGQs1w22Ha9WI6uCVMA9O?=
 =?us-ascii?Q?Hi6SO1wa3IU5Z2dec9jrAKotXFeMzt1HVAU5PCQwWai/otd9wLl3jYZidm0b?=
 =?us-ascii?Q?/PMdcWlxKX0Hn44EvQszx2KH2fTu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:10.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2144cb9-0b8d-485f-288e-08dce7c7a92f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

Hi,

This patch series by Cosmin and Carolina prepares the mlx5 qos infra for
the upcoming feature of cross E-Switch scheduling.

Noop cleanups:
net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
net/mlx5: qos: Consistently name vport vars as 'vport'
net/mlx5: qos: Refactor and document bw_share calculation
net/mlx5: qos: Rename rate group 'list' as 'parent_entry'

Refactor the code with the goal of moving groups out of E-Switches:
net/mlx5: qos: Maintain rate group vport members in a list
net/mlx5: qos: Always create group0
net/mlx5: qos: Drop 'esw' param from vport qos functions
net/mlx5: qos: Store the eswitch in a mlx5_esw_rate_group

Move groups from an E-Switch into an mlx5_qos_domain:
net/mlx5: qos: Store rate groups in a qos domain

Refactor locking to use a new mutex in the qos domain:
net/mlx5: qos: Refactor locking to a qos domain mutex

In follow-up patchsets, we'll allow qos domains to be shared
between E-Switches of the same NIC.

The two top patches are simple enhancements.

Series generated against:
commit f95b4725e796 ("net: phy: mxl-gpy: add missing support for TRIGGER_NETDEV_LINK_10")

Regards,
Tariq


Carolina Jubran (2):
  net/mlx5: Unify QoS element type checks across NIC and E-Switch
  net/mlx5: Add support check for TSAR types in QoS scheduling

Cosmin Ratiu (12):
  net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
  net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
  net/mlx5: qos: Consistently name vport vars as 'vport'
  net/mlx5: qos: Refactor and document bw_share calculation
  net/mlx5: qos: Maintain rate group vport members in a list
  net/mlx5: qos: Always create group0
  net/mlx5: qos: Drop 'esw' param from vport qos functions
  net/mlx5: qos: Store the eswitch in a mlx5_esw_rate_group
  net/mlx5: qos: Add an explicit 'dev' to vport trace calls
  net/mlx5: qos: Rename rate group 'list' as 'parent_entry'
  net/mlx5: qos: Store rate groups in a qos domain
  net/mlx5: qos: Refactor locking to a qos domain mutex

 .../mellanox/mlx5/core/esw/devlink_port.c     |   4 +-
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  39 +-
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 668 ++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  22 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  32 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   4 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c  |  58 ++
 include/linux/mlx5/mlx5_ifc.h                 |  67 +-
 12 files changed, 547 insertions(+), 376 deletions(-)

-- 
2.44.0


