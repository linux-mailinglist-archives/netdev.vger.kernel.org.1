Return-Path: <netdev+bounces-118726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378895294D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FB286B9D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337E53365;
	Thu, 15 Aug 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="piPz5rPk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F118D62D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703076; cv=fail; b=nsSz3/clsnFCfcXkwtc6YTUlHavjseWdxLCXUC3j0AcRnNKt/KXYM1P1R3WpDFIhTg6YzVvuN+i7WpGc/3rx7h4e4Nc94qru7bfkRrhuBc92stspCeJLLy6qH48vhd3rbjueUWf+/lK0FI3ZNJVpkRY11dm8W1wx02PKjmmptA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703076; c=relaxed/simple;
	bh=egccxer5YjuGdnqtZpBCSWW95Shk9AbCWr5P4GyQ6Yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bypYg8P++KNkFsMyFrOxjgXCR/He+U7P4Lwk6oJZbx8fH1y6/KewIChUJJT0ICji3QuKgS3XnsC7rB5DZgjj9r4niA+80iqPk54fjD1B3UsIobTECh8t+5nL3z/8Co8+R6smrGdmLZrZ0gURDmCuccUabB+y1Idmbv8EhgUWdDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=piPz5rPk; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpNenEhWQNAaHAvl5DcNRuTquZZqWozFKiCbbZNtOUcrIcwbian8zZ4orCJ/+f/OeDC936OHRevq5WoIJwZd5VYAtDKibT0Lr9/NXetMcv/MnPDoXJg7ZNgt7VttuLEc4BoHFwrjkknp5GsiKQl9VbDAKqnUMEaLcd/RYy3/MQwzIvlA1jwTW+zmBiwxXBHGsm/IHrJiYhxsxjYAZaJyZL5W330p1SPTJCMz3Nb3ucl8rV8Yw/A6zjBkuj9spb1nOBaFFnx2tuQFVviP/hHKLAhSxeoLVAEnywbe837Z9RcnjZ7QBd8gFrIqoDP3dHqAvg0CXy8zGYobI2heEc63vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5jxYt+gzV9FhkhbnFrJC3BYWnYnBBx6f6b0SraGu3I=;
 b=iQRKNsuas9zzdgZUQ+poPKfQ6S0eZrnKxguhvZWkoCESl+cezMwpDVRNMOXOdkNZAbYDwFu7VbwdoDJgUVVxp2mUPf/UfDuCfaT6oAe5BpYhCiYJO5d7goE+EaMSpYTLFDHtMMf+tF0IJ8L7pZhZBfM9Q8p1rqhg4rGvq26U8e1n8GBJo1vJZrVb9b7rzOGYSxd2OzLzWNBWVOOQc/bSTpBw13JUVm7JtQ5ZgPnL1tyuG29H5qh+AhrJbbAQ1XLaSBRDe/d6naSY4wUOeML08F5jJ4tnKjm3NQRgHdw0O0qlmH1ed/85Kt8mxqlpuW0nD5di45AgQzXboeZiWz1ZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5jxYt+gzV9FhkhbnFrJC3BYWnYnBBx6f6b0SraGu3I=;
 b=piPz5rPk1SkdH4XUe4aaLkmDrVfVDO2zqm44Xcr7MmQRyhPaJM525fGk9vROpeSeDc6tt9RgaOdTWJJpy4IhcGcrxVE9TieqjVKoubi3eJLu2jek54qPN3O6La2F4XMpiOP51sQswicyvEVeRob+EZN2+0WxKOGBGBK+von1BS0JFKCiZpPNk6mXYSne6FA6X5yfl+/DdW2mwaKb9aOFfRlfW2QH7dMdfN2jh7J59LjIg0tjmz4mCsusyqDuTrJx0kj4JDPqt9kX0UVkq+zIzKnoZ7cxq8aAsCtlcoqToMrPUpCFM+eUxbHU0MYr64/MWPwJDJiNplZKGpkaguT69w==
Received: from BN8PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:94::49)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:24:29 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::6) by BN8PR03CA0036.outlook.office365.com
 (2603:10b6:408:94::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 06:24:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/10] net/mlx5: hw counters refactor and misc
Date: Thu, 15 Aug 2024 08:46:46 +0300
Message-ID: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 495b321b-b8fa-4e01-71f9-08dcbcf2eaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/lzeGr5+ha60+XCMt1onD9VKwjMHVNvYIJd3AlsVUYkjIGP4wJho6rJiD8l?=
 =?us-ascii?Q?NUtARHTyPYwhoPug/q2hzUdmkhd2iANP8BrFdrHUwrvf3NLzGcmpOmu1eN5K?=
 =?us-ascii?Q?eu0/cRvEBqYuX2H2q6JQ5lVwds3/u/rZuXCCqtM1FkDpDeXC54CQyi8V5L4G?=
 =?us-ascii?Q?QN9rbuR/U0M5BtyiijQ6G5aUWVBIMV2WtcuWulFtcff3I3ZibqLkXW/QcblO?=
 =?us-ascii?Q?sqjhV0KMjFZXGwsBO6I7hV562j1OC1HXIkYyIv+Z/WtDzjq1Vs5c6odCZeYL?=
 =?us-ascii?Q?8DO07RsuWGV7RA8Dc5kG4MA4MRRPmvJtfZLOaOPtUGcx1nhaKAa9IoiSMtDa?=
 =?us-ascii?Q?mAYASLZmZKHtnTGaMEwzDRgpByHXZQLu2ENZVLvzEOOuOcD3pQg/RWnZCk79?=
 =?us-ascii?Q?BH3eYb4jeX+RG2d/IG7gZdQAP7Htu1D6qXRww4tg/U2Uq4iifh3iXmMG+FZh?=
 =?us-ascii?Q?Yp0H7/7TP3wg7/8p8IOOwZlvjDxBMXFQyvNGaN2zr4f8va45gTY1st8yFHhq?=
 =?us-ascii?Q?/KSJVRe3xk4dsEgW3p0vIbBLVCU1F7CXAtNQ4/eAu0nzBHtH9fiPUjRP2thT?=
 =?us-ascii?Q?lUGA+80F/hYQag+obVOLfe9J2xtwgVXWMFVWcEqqbJ0eGxFnyo58Fx1iD6HF?=
 =?us-ascii?Q?KROczKN4svhmYbfoApQqB54UNV1KRKLDGed/Xv6EjRaTBok5h3nWRasmmIjZ?=
 =?us-ascii?Q?XjsTGB3OH+IiDC5W43QC9BsXcxNdDPrrPRUJpIbQTS+lle1kSoh1L6sdJPFS?=
 =?us-ascii?Q?9XzWr+C3/VZ0+5s/MVo/w29hIJQOuz/9Plm/l+fOXOOVBGj9NbLER34XA9PU?=
 =?us-ascii?Q?Bru4yAlHXfu9C7MRXuywNR4Bkx/r/26dgFFngursgJPKCns8Pb3qF6vqSN6k?=
 =?us-ascii?Q?NgXuiS6W0MzYrstSrttUV7ibbcQ/FN68gKzQ/drYsaVyilyhcG8+joeB/zGo?=
 =?us-ascii?Q?ladCeOgXSgHXndAZ2lDx4tJ2x48D7WLW45WK3Hmp8rXqlOTRrQndHCpJBSKs?=
 =?us-ascii?Q?jMSdYMNJopJgN5y4yK2/JMk/RfwDm6fJb+KE10aED43Ll/phIMzRp2tb/z/d?=
 =?us-ascii?Q?NPROfJu/iiaQooZPdqUFp+yUY6Vo/G1w3/OyGYESxvmkP9Zetb7arzftwjRm?=
 =?us-ascii?Q?wi+v9SHM31ps5cZnrENKWfTzxN/8rdtLo3cYibsmVfbBVNP5YiQY3Q1uAEQJ?=
 =?us-ascii?Q?utgQhdNuXOCEgmLIuop38DAAk2x1NyQhLHCIzhihfX51W0qu9QP0E8g1wzF6?=
 =?us-ascii?Q?5/aPq9MaVvqhaZZqeLSngex3NsRrK3zE1wYlU9xk2hyAc3JAZAwQqpAq4khw?=
 =?us-ascii?Q?kovhLpZHiN2BV/zyZ3Uhg7qq8dIzb8H8x08TTC34aUyHXmkw5RxkZruMh/m2?=
 =?us-ascii?Q?/VLBUOl7jiWfERyXXgmN5O2wowzA1h9LwZjk65CtFLrnzZPwf+mX0DUcDPKO?=
 =?us-ascii?Q?dALxlccrGHabAARKd6Z2TSM3gSA+ztr+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:28.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b321b-b8fa-4e01-71f9-08dcbcf2eaa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

This patchset contains multiple enhancements from the team to the mlx5
core and Eth drivers.

In the first 6 patches, Cosmin refactors hw counters and solves perf
scaling issue.  Find description below [1].

Followed by two patches by Shay for the core driver.

Patch 9 by Dragos adds an RX SW counter to cover no-split events in
header/data split mode.

Patch 10 by Rahul matches the cleanup order of the RQ to be reversed
to the allocation order.


Series generated against:
commit a9c60712d71f ("Merge branch 'uapi-net-sched-cxgb4-fix-wflex-array-member-not-at-end-warning'")

Regards,
Tariq

[1]
HW counters are central to mlx5 driver operations. They are hardware
objects created and used alongside most steering operations, and queried
from a variety of places. Most counters are queried in bulk from a
periodic task in fs_counters.c.

Counter performance is important and as such, a variety of improvements
have been done over the years. Currently, counters are allocated from
pools, which are bulk allocated to amortize the cost of firmware
commands. Counters are managed through an IDR, a doubly linked list and
two atomic single linked lists. Adding/removing counters is a complex
dance between user contexts requesting it and the mlx5_fc_stats_work
task which does most of the work.

Under high load (e.g. from connection tracking flow insertion/deletion),
the counter code becomes a bottleneck, as seen on flame graphs. Whenever
a counter is deleted, it gets added to a list and the wq task is
scheduled to run immediately to actually delete it. This is done via
mod_delayed_work which uses an internal spinlock. In some tests, waiting
for this spinlock took up to 66% of all samples.

This series refactors the counter code to use a more straight-forward
approach, avoiding the mod_delayed_work problem and making the code
easier to understand. For that:

- patch #1 moves counters data structs to a more appropriate place.
- patch #2 simplifies the bulk query allocation scheme by using vmalloc.
- patch #3 replaces the IDR+3 lists with an xarray. This is the main
  patch of the series, solving the spinlock congestion issue.
- patch #4 removes an unnecessary cacheline alignment causing a lot of
  memory to be wasted.
- patches #5 and #6 are small cleanups enabled by the refactoring.

Cosmin Ratiu (6):
  net/mlx5: hw counters: Make fc_stats & fc_pool private
  net/mlx5: hw counters: Use kvmalloc for bulk query buffer
  net/mlx5: hw counters: Replace IDR+lists with xarray
  net/mlx5: hw counters: Drop unneeded cacheline alignment
  net/mlx5: hw counters: Don't maintain a counter count
  net/mlx5: hw counters: Remove mlx5_fc_create_ex

Dragos Tatulea (1):
  net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split

Rahul Rameshbabu (1):
  net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of
    mlx5e_alloc_rq

Shay Drory (2):
  net/mlx5: Allow users to configure affinity for SFs
  net/mlx5: Add NOT_READY command return status

 .../ethernet/mellanox/mlx5/counters.rst       |  16 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |   7 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  25 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   3 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   6 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 387 +++++++-----------
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |  33 +-
 include/linux/mlx5/fs.h                       |   3 -
 12 files changed, 197 insertions(+), 292 deletions(-)

-- 
2.44.0


