Return-Path: <netdev+bounces-154809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F239FFD95
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286071882C65
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4122199234;
	Thu,  2 Jan 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZgGGpRoP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C141B4120
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841721; cv=fail; b=rzL8LENxydQncxraDw8DzGxQP6IFtM+1DztnNoERZs/ytlWal65TzdGOfo3oMTTHDHRQc3EzlZvtTKGMbq//fGJowEH3yY73rSXd0Zd9rLAcOW52+lQaQ6uM7wt834hF+5ty+XeR951N8mGN24tR1a2zXWxUUjuITHCSeYwpORQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841721; c=relaxed/simple;
	bh=9xz3qiA2OyfzfVWixHta0c2R32/m8SqwE+iArawR8iw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgaU0w4J4+AGo23RgkImiLZkCfW/k0oQlzsPMy/rz0s9iP35ddueX7O3w1ODkVZCiTHJpH6DJR5nN3kRfs611tqvpbYFGWVtryCSy5c3pOoN/L72DkxRQlaEVZG2Ug0z1SKrFTvr+AFwrjeZzUt3j4bG3+77toLrbLmAQ+0uBlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZgGGpRoP; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEU3dRnVS2tN6znJnY3U6np69y/dMczZKH1tVCuNpJ75++yeViGYklhK/qoOEht2VYVoGpHOl+LKTwrO2fA0wpBL9TkbKWhuzCibkViS8ZrGfnCAlM8JJaNK+7cXrP0lfHdDkIOiq+DxJQFRAMG7K2GHLrEuxAU7urnol0bCH518WmcTPV7XJwwlRW3y/9h2E0RVscSvtWgeVGd/EE5X1YlUC1S9WK/faKItR8ie5k+P+G01PgViecvbkLEiiDzgKRkSwzUDCsQzbDbo3VsnHUCndYyKa96Aj7pOouhqj/YJ+gRznH+Mqj3nEnYqsDoBHcxe5tXftyWssSQuvm0nXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBGLLlYl8guUDfpxcz1qdPlVqkLict8JWL+cq31MtYo=;
 b=e1onlt03c3TL0YuiQO3+VUJ6M8WLgPBFtoZ7lIwtDcItkYSZGVnZN5ar38IDwQahrRxKWlPPQ21Gobp9JgI3UHO5uvUqdawNLgSog+HTY71Uz/0PG0ltyNBNLBL4EicQMrvUdhQcgn/YVRtnL40ekfiKfmrsDLcesq782jXHr/JYWQqjkZi7W2r10Ig6BJQ/I77LUMCFEdKkgO07/67AGyKODjFiqGRIMW3wOZ+PL8IJBRE8rjcS0uj/rbxWOnCyOBahDH56TG8acr1sE22SWnTotVV6Y3Z8iiBtPOEATEpFxqpiDjDkWFKIK4YpjhxX0+l0I5E7ioqpOB1D47oocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBGLLlYl8guUDfpxcz1qdPlVqkLict8JWL+cq31MtYo=;
 b=ZgGGpRoPg9+CWrscui2fJzoGIdgmyuB/Sufru6K93SZXZK38Z3OB76Xg5KMDSHSmB2fjESrREDoMC07iZw1N/kr2f2O2n+CWOFEXm9i0uXgMcWCYvhLAfXmP9ayg3iAV5B5sp64eUr/WjREvfzLf/+9h5VREiB04CSlfCO0EKo5luVnb/Ev/TztPOLSVe4MD9EMbqaIGpR/B862q7X7hPbf7OdAnQgDee7RPmVMv/+TKjKARnWll4MxP1/iaLBnJZxouU1FmW3gdxfj+EAmHkzahnx/C+6V0WF034NqtNyx0XP3+9I6lfTHgiuue58IcsnlGl7zU/qgVtBCIpFDXyA==
Received: from MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:10 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::e) by MN2PR22CA0015.outlook.office365.com
 (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 18:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:14:57 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:14:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:14:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/15] mlx5 Hardware Steering part 2
Date: Thu, 2 Jan 2025 20:13:59 +0200
Message-ID: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e695234-deef-43b8-8606-08dd2b5964ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hbxFde+nD1lipg4ibPjOw8p3gizYNq2B09U5eczbAIwTk0DnTwIZ4DaJz68?=
 =?us-ascii?Q?9glZfiQYOK5IAltsqKAgCFpV4O3wDwKVvhKg0PjKj+N6J57mrBzypK9Yt3cq?=
 =?us-ascii?Q?CkAkiyPi4Cd0SobkZt1ITQpnpgmGOhucmdQvzcZwnjZkyLZiaJt6AQ6snJMe?=
 =?us-ascii?Q?Anjp+O/ackzBp+CD2mhPf0MrIEPZ32IFLDqfzksbZkyH+MqWQTOMFNrr9pQh?=
 =?us-ascii?Q?RW2VbJwmo2FU/v+ARxI4vJyrt0giAwzKSYySBAX4SamDCNC/HvG/64EHW4t+?=
 =?us-ascii?Q?zM2jXLyCNU3kBpvWI6p5F1Lg+VO49XkVtqnpwchZipGC/U65A5KLStU7wQ+o?=
 =?us-ascii?Q?X5qksSjTV4wQOyvVKdGPl5syEg8sL42ubdqjbS7/1Abnj+l9Hs8mMx/YOb+f?=
 =?us-ascii?Q?XXXoA7Z8Ozta8/WF53Wkq+jTcNlWu0ZcjQkyl4fjzLaKOcpKTY/vmKSsh7la?=
 =?us-ascii?Q?ksfqA8Adi1bSEA4aT7H0NkgMLxNPmtPbX2qw4dKkgNvx+a/F4tZg0JvrBGx/?=
 =?us-ascii?Q?zh/BIw1jD5TXecTGNfhOA4kUY52m2LrsZWEwgLoDg2bRUYgEg2a8A0Vqebjv?=
 =?us-ascii?Q?ikqxIqikBp4lxBi2qep/BboHvo9OGx+LCy9ploPZ12UTq7MoUDjT8DSY8eI3?=
 =?us-ascii?Q?ey41fPOW5m5Dad93wUVzQyXnPJofK/Emlab1vMff7ul0QHyNt7T5oVTuyd5k?=
 =?us-ascii?Q?ELSsQ/NWVYrldkb6MtCxwevhTGFSMQmFpUdaYi1c6hCJ17OPXZeVzKjRd87H?=
 =?us-ascii?Q?fxlYhp5Vsnb/flAw3IC6HQkEMfCP4LXYKfkJfznWOMh/RzLvPj3DdPO0sytK?=
 =?us-ascii?Q?9S0Oc/hqpTe+zhZNOSKYVu77kWo9OBp1AtpxBp6c6z/OXa9Lx488IAHa+5U4?=
 =?us-ascii?Q?DNOh5O/jDOvbV6OogrSIbtA9ITFL1Y6Jd9agsbm6qnrO3kPBAc6SOf/hACwf?=
 =?us-ascii?Q?jpp6ifknVd+LW4CvVw2qy9j1esQ7PS3Mqt1tXt1aMIVKdOvXNGcDYp1YbhKg?=
 =?us-ascii?Q?6Z043IigyAJGD+v9pAjYVplDhIaZS8prHRuHKU7r/ijLfNjOkl79K9BWLUsR?=
 =?us-ascii?Q?uW00BZbriJ1EfVdd8O0upx1vU4K9VZp5EUDdfFg8Tp5wF9Qm4G9OayinP+ru?=
 =?us-ascii?Q?4oUzy2RQORvziie5qS2gOQUWJCAFAdWVhcgfeOzL6aCdqWMgQ5lRfafbVyMt?=
 =?us-ascii?Q?841aPCK3FcxWqYDgdRePH1TMzsxR1Rr5gVonba3vpxS7QoXdt54Wp9V5JU08?=
 =?us-ascii?Q?kZDn4uJ23VdafhXyKn2o/xGGWDv6nhLv049mXm3Efx9+saT6J7xVmuLfuY2/?=
 =?us-ascii?Q?zJm2QE7boFZQLXc42gQNcf/g1pXbh20QDp2P3J8D8eswM0Uwh9b/ZrzLNh5v?=
 =?us-ascii?Q?hzph+dX9XPv+eELg1XRXkPbpWJiTBev6HucFvY++kLoxbC4S7Xf+LywitBUI?=
 =?us-ascii?Q?EWQkp7W1Ri1JBqqRPl8nhbN7bQ1RAXPKyPJx6M1uL3Wfzu6M+qlUO62jsj/S?=
 =?us-ascii?Q?Sx40IzKl7GL/ogg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:09.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e695234-deef-43b8-8606-08dd2b5964ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

Hi,

Happy new year!

This series contain HWS code cleanups, enhancements, bug fixes, and
additions. Note that some of these patches are fixing bugs in existing
code, but we submit them without 'Fixes' tag to avoid the unnecessary
burden for stable releases, as HWS still couldn't be enabled.

Patches 1-5:
HWS, various code cleanups and enhancements

Patches 6-14:
HWS, various bug fixes and additions

Patch 15:
HWS, setting timeout on polling

Regards,
Tariq

Vlad Dogaru (2):
  net/mlx5: HWS, handle returned error value in pool alloc
  net/mlx5: HWS, support flow sampler destination

Yevgeny Kliteynik (13):
  net/mlx5: HWS, remove the use of duplicated structs
  net/mlx5: HWS, remove implementation of unused FW commands
  net/mlx5: HWS, denote how refcounts are protected
  net/mlx5: HWS, simplify allocations as we support only FDB
  net/mlx5: HWS, add error message on failure to move rules
  net/mlx5: HWS, change error flow on matcher disconnect
  net/mlx5: HWS, remove wrong deletion of the miss table list
  net/mlx5: HWS, reduce memory consumption of a matcher struct
  net/mlx5: HWS, num_of_rules counter on matcher should be atomic
  net/mlx5: HWS, separate SQ that HWS uses from the usual traffic SQs
  net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset
  net/mlx5: HWS, use the right size when writing arg data
  net/mlx5: HWS, set timeout on polling for completion

 .../mellanox/mlx5/core/steering/hws/action.c  | 159 +++++++++++-------
 .../mellanox/mlx5/core/steering/hws/action.h  |   9 +-
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  54 ++++--
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  12 +-
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  95 ++---------
 .../mellanox/mlx5/core/steering/hws/cmd.h     |  13 +-
 .../mellanox/mlx5/core/steering/hws/context.c |  29 +---
 .../mellanox/mlx5/core/steering/hws/context.h |   4 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  36 ++--
 .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
 .../mellanox/mlx5/core/steering/hws/definer.h |   2 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c |  36 ++--
 .../mellanox/mlx5/core/steering/hws/pat_arg.c |   2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.h |   2 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    |   4 +-
 .../mellanox/mlx5/core/steering/hws/prm.h     |  42 -----
 .../mellanox/mlx5/core/steering/hws/rule.c    |   2 +-
 .../mellanox/mlx5/core/steering/hws/send.c    |   1 +
 .../mellanox/mlx5/core/steering/hws/table.c   |  22 +--
 19 files changed, 227 insertions(+), 299 deletions(-)


base-commit: 9268abe611b09edc975aa27e6ce829f629352ff4
-- 
2.45.0


