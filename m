Return-Path: <netdev+bounces-153471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF39F82BE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05A1162455
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9119CD13;
	Thu, 19 Dec 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5G25Q2x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56316155342
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631182; cv=fail; b=jIr7OsxpJt2aHgNnz43lRwTjmGhssRrsK4ClBMaOGxw7Rztp5pVjwUX7XSwVvPO+c0V9Lx7365GygVfm0j2PFqJALqgg5+av1TwbsDx4jcq89q7oLaAtEPGwP4zGRXF0BcJIpmZRQ8jxmJEjnttLWkFHviYxyw16JgreC3tFyQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631182; c=relaxed/simple;
	bh=mv4rpl6cVbrF4hDHgKcdYruHMfagiF2/XQ/5uDzSSl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HI/VKGaYtcrGNHellC1Msq/7XzDXAOLC4Q6uvrQl/7kal1TxvaOt1YkRmnQ7lUqgpkFvktI8VsVl0/OyOileh2DLlDWk2l8pSLeSJsQPcF4/ySNNUyAgHQABhkus6aIsqpSSkvPmKhnn9vqqFKBswILxyDYhl5nxAwu1QTScanA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5G25Q2x; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlZtFgq4Np+ioznMnnz/tgfKfb7ynxfKY7oipnZZ03+sdRIk0ioFWHBuR/cPeQw4YKV9oVl5yz/A6xp8F+jYcpd9ZfgznBmSSs3aQyB3n2soST0fYyhM+iKl9m62ngDp8VjXZeKDFfGg/CMRGAB1CUCbnaVTsx3Phf4iTvuzaGf0Mf47tU+JjcFrCbO/zW2QgBsX7LGgIi/IZR0VU2nG9oUfBcJ8Y3kjH9vG/S81mq6WYiifU/5ONEpx9llsGWQKMn6TTj+gbF9LHrFtxJg5DcJIr2UVw+Ra5ZcQ6nXLj5WlFoNsfAAL187cr16jMJdzZFKxJizCC4lzm2u2GJ/fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTs59Hivp3LJ6vK6LhLcDj0XsHivcfYmHZTFX3t8UO8=;
 b=wiy5cire/zYdbYsJg7QvqyLpIJT8fZhtHk7+wugwCCGd9uusYi1gWTqe2L8jT8R6L8TmWf+dIC2LDyywdkOw4c0uuB9iyeYBL7dRJACuAFucrPSuIg4wehPeq6x3bKjWiyyfLA50RoMveQcmKWMtqKxg12H8DkpwjY/KjVpJlpM4xk8hvzMwKzOMFbyPFjldivaMPlwY7FV1uYsac096htS6NFv/1xUS5HZEdahSZoj07hr4VEu/gBBm7yVucDYMOCdUIfVnysj/kEyQfyO+/SRYjRBVjAHIC1nQ7R7AepiJnhqenA4iEwPDkUw5XO0OTAUfcA+Zjmb9/fvNRMO9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTs59Hivp3LJ6vK6LhLcDj0XsHivcfYmHZTFX3t8UO8=;
 b=o5G25Q2xHrJE36sckAF5a0aoMh4wJcrHNx3P7X2pA3ZDQjUM2FElZZsm7xiGKYD/JEhxd5H5BA2+MC71Qrm97X9jNezqy2KWEi87coALEPeAiGX8mhGB2ISbt6IfadncGFPWH9cqCVAQCPfPeA0v4kpKyNvqG4YqFL4xsmqny24YNCYkUbumonwLnmrvm6+qU8aS24B1nKnz1bTFnbSoE2tfuWacij/xp8Xl7smZ7BI8NKFGry9J6EFR2Yugo6RQ4NJEwzgKczN120ZZ4uqlndT3ctM5c49sXJ7+dEP5kejPEIN6Fko8iSyVGr6dyST8bdSQ4GXVe4F2CgpS5N8gEg==
Received: from CYXPR02CA0094.namprd02.prod.outlook.com (2603:10b6:930:ce::22)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 17:59:32 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::c9) by CYXPR02CA0094.outlook.office365.com
 (2603:10b6:930:ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Thu,
 19 Dec 2024 17:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:59:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:17 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 00/11] mlx5 misc changes 2024-12-19
Date: Thu, 19 Dec 2024 19:58:30 +0200
Message-ID: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: b869d4d5-201d-465b-db09-08dd2056e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Le+E1jo0C4ylKdlUrdU3Vv7TUZI2xAeeoRpVbtyHPX9QEWM6Vw6k/fHEjhEj?=
 =?us-ascii?Q?J5rqUjfZj0zgqOB4UDfmpgGm0OH4sGGyin0DtfhgtvK0HO5XVjwgmzpqs/z4?=
 =?us-ascii?Q?pUMwyhQNR9VZvzcfpBYoBd1SMZFB4gAzxyY/77MH7E/byY4gKNsq4RgMgvzn?=
 =?us-ascii?Q?S2YdWrShYk6aLiFy6CdsIBxE89uSONkmdk0dPdy0FoBZnXGOnMNqKW4pwKzD?=
 =?us-ascii?Q?22RSHPwE5Oy6xqNaIBX18+iG2IaLJWlQtT+ywpd1pc62zjqWOo9l3QZ6cjoK?=
 =?us-ascii?Q?nmB8rtjFEPoZSr+CPtZsDSfQPnXifPb22bkEKfhj7PJEoYmWJC6u8x2JsY4h?=
 =?us-ascii?Q?ornKhqO4zJ1LLO1Ki4UWcvN+7wSvDDuKIsJi7Ah/1rjS9p7cATSw1sNJQBBU?=
 =?us-ascii?Q?UljVz+L+cJplyrbkQBGiRAKFO/0th+Hb1IJowlS4xqAUQt8hy/virqIZNOXr?=
 =?us-ascii?Q?RHrxtSEAAay5VQcHeeYeDTQJr/t1DCZrVjt3QYCu7RZexNBO/TOvFiOd/ixB?=
 =?us-ascii?Q?AFqJcu0L3XYeFrAQQtxjMG6/cbIFNMPjxeUM1ehWHVK7XNLJ16ILpgW43ZJs?=
 =?us-ascii?Q?RQHpES+wlrtMeDnnSlsAjsgOn4a8zAbe+h/TPDIiGgp+smdTmgk5TBnoWZaL?=
 =?us-ascii?Q?hx+zwgQVlbihJKz7BkjwCA3OPkSoZBhyVcX14PnwqGQmA0KPCpXMCCqmNMb4?=
 =?us-ascii?Q?0iKUCxC+Q0tHBe0xQkw1l4c3Re5sWIYqdYCT4IgvkduFCm1/yiZGJp+AMLQX?=
 =?us-ascii?Q?lrIo2NQpHRVrJnRpEvwHPzazkE1Xtk/Ah6oDdzd3VVuC/rhC0Fvedq/u8QEq?=
 =?us-ascii?Q?xWN8D7KtDoquAb9Q8sjxYYR4tgSuXG7+lhUVs58eY8L0MA0hRaMwDsgbacWq?=
 =?us-ascii?Q?gQS5G35MHd2VjCkcUNoSSjieJnUT1jDTlDWA3yHxk8H5gLIzb14qyenw27qi?=
 =?us-ascii?Q?IwZV/z4ar5r2jVGk6rMIQJF7LstbDXNklbf+pa8ZbWy1FncZ74o4C+7/PAHR?=
 =?us-ascii?Q?O/sAb0FLlEfaWvOI60vyd0TZzONxBPf5xoQp2Ov8BFQQJw+3e6Ya0OAO9+vq?=
 =?us-ascii?Q?x8A6HR6YLi5erk9W/1uo/uOokp7oV/mAAARWxWRjNxLmp6hFG7WZyE3EYZ6v?=
 =?us-ascii?Q?3Hu9OkKd3EI7X4W3KDCDXe0EDn55Z9ZqjHFYPNsztaD+YdWAGeEcXFG1BYoj?=
 =?us-ascii?Q?ptv6ogOWiAceJpvaSGg8pd8SIuQkE4JIbgGPlqeQIGx8OLJvvv7+iL/xT5rd?=
 =?us-ascii?Q?vPP/Kephf3WfaTnQ2llSl4Awr45jI3Kyxz1A6v4dKa63miNGW3eONpgLhvT7?=
 =?us-ascii?Q?QN4I99Zq+9yNnXeTzIHAa4RGNkqph9WWBtrRGN9vw6T6vBnTEYBvv7WEyf1s?=
 =?us-ascii?Q?B2lmKep9BgHUAAJro//fgcTQb7uhPnTRHHN3tfguDX3vm5J1RtDjic2WkyuK?=
 =?us-ascii?Q?MKrd+hjRFzhgF4csVb3ID6BRPmlzOK58GHKD6DyzEXY0SEvtZ/p3VYuUpGkw?=
 =?us-ascii?Q?IBpbXvMir/mkT7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:59:31.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b869d4d5-201d-465b-db09-08dd2056e3a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

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

V4:
- Patch 3: Fixed memory leak (Przemek Kitszel), renamed variable to
  fc_bulk.
- Patch 4: Renamed labels (Przemek Kitszel).
- Patch 5: Added Przemek Kitszel review tag.
- Patch 6: Keep mlx5 name prefix (Przemek Kitszel).
- Patch 7: Re-structure and open code a function to improve code clarity
  after the renaming.

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
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 293 ++++++--------
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
 .../mellanox/mlx5/core/steering/hws/send.c    |  21 +-
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
 42 files changed, 1462 insertions(+), 788 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c


base-commit: 2b9da35f48a552c158a8965a61f36a1aa62fca34
-- 
2.45.0


