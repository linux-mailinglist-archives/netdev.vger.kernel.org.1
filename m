Return-Path: <netdev+bounces-158492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B135A122D9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6B5188B059
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013C22D4FB;
	Wed, 15 Jan 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2FEh0Dt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7423F29D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941273; cv=fail; b=lYM+YECiSeFy87dMGh+ipkd4V3GNOGVqHf7eV5UosrVl9QJJgMovNCkDR39lKwgpAnFOziMCydIvEDFJxmazSaITS1GxfUxO1bUz3mk1X0YL3xmJjOv9wACGz/mPOILDhcck5siMXQbdluyXB9n9icQJT8tmU+cGXNWsfFUYoaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941273; c=relaxed/simple;
	bh=7k8Yi1maDztbygdT7I8fdJnXhQqpGFUwZjGThb2N7GY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDUQkWT/Y5DOOLq3GJt7bGJGDJcT7t4xF1XpiZlLmKGmy+qRMOYp32gAoAmqbIZkoe5/TqUpybu11sb8t7QVt0SRKfxdvLodV/4dqk6nnGYC/A3AWxQcRPGHZLmeU+g3J/vrb+sxaEigd+8vLvDCKKP9kZ9DdR7ysSyE0JyWljA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2FEh0Dt; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3IqdT3OFMDW8NJqJJdi6rxUIznKkNEsXDip6sccRkQDMzKXp95n2IhWgtHcOT/tGuPXXHegZJsWpV2CNsEE6PogxHvcHnsU0YN2G08NtoEeZgeYQF99ttdJUpOB1DViK0ifX6AxvCKNX0dipljiRS9ZZknG2tJbDR0Sm2zyqNLkd7RfnwdnhG3XqmkxHLmnSNtYu/PvG7aE8jZOB3InTMppYKUEaswFFF5cubO69C8XqJQRPke5txUiUcOBx8v7j0TLvJzco9b6/S8d/zvfLg2mBQGuc1+4aQQg5xKGTiNcIVx1dEQhncGWKpJpjzWU4MDJR1P7xxw8Jr4Fdek/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzpEMxq0biBmwrQVHG4XSCycbfdAtjs5bfMXBkhMsmI=;
 b=ucrWWEsDEVudXTzdooAMtLTGnYdwyAZwVGC004y2ccjQoOMVGpsl2f8vdyvcWGEJ0UTmqhz5WTXs563zG20FEVOkbG3Oj1AO9cCvITk5g9gBfpR1r2BrKSTeBLnQVjTvQki/AhBu0Yk/IMjlMDq1ggkYZZpUYS8N4S31Xe+C9v3Em0P/r+gGnQc225xUqzFF40Wu544iFL4sxhEh253Rpj/QNj1LdZIgDgXW2By5Y/C/E+dKgZn0Si0B1Td0nfhcgYOF1Uzm7FdFmnp9cTUSB44/dREcP3KwvpWRViaBk/HPgpXRX4MbVxqTICYyXh+6FPBgzRL4Y4nTMGfTw12jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpEMxq0biBmwrQVHG4XSCycbfdAtjs5bfMXBkhMsmI=;
 b=E2FEh0DttVmDwBMd+2z6VEMuUR+ljCZcka094mPp1iHhtdQd0wnVGXxy4LfMYZ4IAyPW6TfYYdrnSNYhNUu+LFiraYDQMooTkFgTvFVJKnpJak2RLS8KaBABieRsxq6uhHjVwSJQ3DLNrFXNO4ct7fi+wbAjVX7jqz6npeG0ueqPz1bet9+JdjrtwPnEz5aWbyu5O37PgCKpATkXZelHaRIDupp0T6KoeHLc4DyCGGg6hVHZyN6EbD3jq6R/5RjqIvN4tHqZ7YCkhRJfOwYjkJGc79PJFwps/aG2MNWTkKQK/24knlvc7CsTBF6UPdaCFVDWy6boVOzur0/p+CPARg==
Received: from PH8PR05CA0023.namprd05.prod.outlook.com (2603:10b6:510:2cc::8)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:41:08 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::9d) by PH8PR05CA0023.outlook.office365.com
 (2603:10b6:510:2cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 11:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:40:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 0/7] mlx5 misc fixes 2025-01-15
Date: Wed, 15 Jan 2025 13:39:03 +0200
Message-ID: <20250115113910.1990174-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf9fd97-42b6-4786-4dd1-08dd3559807a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5W7pmBEhN/ZbpO7tc8ko/8fNFFQF8zOnFc4DkfrI4nl84ny0DAlIrTlH8eLy?=
 =?us-ascii?Q?AFWTEacGl8n1LtqYDOWT5XbPa1eiEnRyiV/J/dg8Ayux/hBACGha2H2IbpN6?=
 =?us-ascii?Q?qr0QMHUvCAyUtGSMtLsFExkWRWVrhX7vj5kB1xFKfgXzexzX/+pr51J/ygdl?=
 =?us-ascii?Q?ZcQwv5y95p37SRX+52W6T5Izw2Qc4syNmQgKv+IIzZPvHCw/iQqYFatFzn7M?=
 =?us-ascii?Q?f1PZGq1Mp2M62ijQwvKvENkG2FqMLmvGQ/VH3M7Z3pDL8dAJBHw2axRgB2Ng?=
 =?us-ascii?Q?Dh+Il7QhW7b9Jnj79sa/7QYh/YFp0SEEYQujZelni65h862kFfWUBgxKPX4j?=
 =?us-ascii?Q?SIcL+gHGVZDm64sZpIX5YtMsRVQO3fS350pD+SlrXW9yjpxLErIw0r+PAVAK?=
 =?us-ascii?Q?Qs5/xO8DjZBEEpumXf7oxLOGiS49ejHQ8x3eYbWW8n3sKAQzE3wZddQMmfQW?=
 =?us-ascii?Q?CKNhgOyG3awC9lKiKRjs0lfb4r5iI2nNnPKHdZZl1WZX8BzpwKWyttBWg3Fi?=
 =?us-ascii?Q?Flp8UDmP0OIZOMjTV8QcILp9R9SpoN3g0FfZNKRTDbPjo9JyylBkPMIh7ZIW?=
 =?us-ascii?Q?+R74jjeNb0cDYCJ/eXxZVyc17F6MUnPhTEEW3n8TVJetHdYVHi6mhAl3bmnf?=
 =?us-ascii?Q?rQgKdtjv00rYxLoQW9T20lazGDWyTUyDMcFxAsoUlSXK4RfqXvpYH7vAE6FT?=
 =?us-ascii?Q?sJ+sUup1DrNR6sbOIiO3yBoUUz/4aSEs5GtrLUZNpGIeAirwidydgsX31Fdu?=
 =?us-ascii?Q?tBD6+sxBj6METVgcnWfUeOHb5auF/pyZ35BgMOAkP72ozD3JCvO5npo/CSck?=
 =?us-ascii?Q?2fbksJvIl8KYFxaYE1QizRiptQnB/HCzFoMGLl/CJMtKhHPuoe/qVWFzbAc3?=
 =?us-ascii?Q?rFZln02oNVO5tHK5l2cemfdsJ/aQfBoXRjNjgygHeMislJ+xVYS4fZde037J?=
 =?us-ascii?Q?7YJeEOBf3pJH+uIdTH3mak73ILWp1Fsb/UHs1dDHSUUWfg9Mn+PhHV9qmz8n?=
 =?us-ascii?Q?XKyRxm6f8apjtoZRqaSqzccCQfLB1Y5Pi2r9qOiAH9mrOvZT9QfeyCrzPp8m?=
 =?us-ascii?Q?NCQsvuXdyqdUZoR18GVBpbU4OanO3uPT60T0M3m118dD0NgdDBXxjJyWRhH8?=
 =?us-ascii?Q?d8WmavBlEo05aZrEOdYZZztE4u5qL69b9btNWxKThapBSQzfkAAH9l4q71MH?=
 =?us-ascii?Q?86OLf93dQ8w/d8GXcBCO0lchFGxkkTeQwjBifd/bHzHDP3rEribmCiJ1AJSz?=
 =?us-ascii?Q?SAdXk5GRy10cJGvaQ2lpKOd709RPctyZCsNVyhF76yVLups1ySdGsvf+smX2?=
 =?us-ascii?Q?YHHQk0jov768BFn4QTohuyisZ8/7KesdcxkzQEMVx6RcUDjcbKUrb0r32TT7?=
 =?us-ascii?Q?HqUV42S0zxyvLQFHDobJKhs46IWs1XRfULYl/BlZT4XkP9JZ4TXHD2lem5Gv?=
 =?us-ascii?Q?gy9fKiZOyeR4ii0NlXlTUAjT+uxxFgJLzCBH70+75sfThGwcxXekopRRlEQo?=
 =?us-ascii?Q?8O8rQoSmBSSiPlg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:07.8932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf9fd97-42b6-4786-4dd1-08dd3559807a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

V2:
- Dropped patch #6.
- Added Reviewed-by tags.

Chris Mi (1):
  net/mlx5: SF, Fix add port error handling

Leon Romanovsky (3):
  net/mlx5e: Fix inversion dependency warning while enabling IPsec
    tunnel
  net/mlx5e: Rely on reqid in IPsec tunnel mode
  net/mlx5e: Always start IPsec sequence number from 1

Mark Zhang (1):
  net/mlx5: Clear port select structure when fail to create

Patrisious Haddad (1):
  net/mlx5: Fix RDMA TX steering prio

Yishai Hadas (1):
  net/mlx5: Fix a lockdep warning as part of the write combining test

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 22 +++++++++--------
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 12 ++++------
 .../mlx5/core/en_accel/ipsec_offload.c        | 11 ++++++---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  1 +
 .../mellanox/mlx5/core/lag/port_sel.c         |  4 +++-
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 24 +++++++++----------
 7 files changed, 42 insertions(+), 33 deletions(-)


base-commit: 001ba0902046cb6c352494df610718c0763e77a5
-- 
2.45.0


