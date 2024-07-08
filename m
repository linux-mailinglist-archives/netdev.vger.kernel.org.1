Return-Path: <netdev+bounces-109759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013C929DDC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436AE284446
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC2315BA;
	Mon,  8 Jul 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jhgcpahv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540B25634
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425706; cv=fail; b=cF9aWh5j20Ga4tzk9Y2k7pTdZ2JXj4htj93vmLg9BaOPmY60yTjHXgY4InsGGQy/MrRLrk1ZeCPKo0q8wBOrCZI1+XDGXe2CKHB4zPxnM+WmmjvotOI6gnaEWTyODs7sU9NgR/naLvx1QUiPf/CLsnPH6KmMRvejs1+6HUIhLjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425706; c=relaxed/simple;
	bh=24q8O+ZY6Z4W/Ck8xE/hc6T0ihx6nIA3gJHXHdW9E/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXftE45hp3wliSeW0YwpK57D/2c7bw8qxmakzay4sr6EWIO0otZUGzwd2IJ89W9hfoUJHoTQ9EZA/X6u6snEOqcvIUbnfl1bXR4/O2p/AxW7lY07wuSttbyPMR8jhzbg4l5PRrOFIEDw06YQBH0r88I3tVOkPWSSVz1zr0SQ2IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jhgcpahv; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPxbr5w1B2jYECyrGKQaG60Ya40of72z9EA1Zu6J2VveDQT2tlZ4CYdPG8gT5dAVMlh5S0VIhJ74bfHxm+ObzltnoED/tBEOJmmUxk9DaEbtoRLc7WEBUPHZSdLWlq6PpuywEciS1AEsOC2k/yEIRUcIRjkVSA86vmEcx9lCrP0Bf8/Osy4qkSAmvxlxwaSSAKcNEZIddnlAfbcDQEq+9jR57AHeoovDDBOIry7qEwi4pUdqx8xithsbhHm9mJPl2zHVHBhmsOj/o/5D0o4IO8s4BoMfwTxZCuADSete/322llufNbgrVxFZz7kvYQnhzMbBB74LEbLDc+Cymkkaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2YHXfGyprC/cSrYwsAz9XbBZPck7rDCV1jaxqYFd/w=;
 b=RDSUXPj203w8/B1xlJXaxttdhV/FR3S41GL6I7nUknup7gPSd3yeeE2UZoixQ+bdkTcR1kfYdf5rgHLXfw3HpAIpPMkj9PhOzgNReG5y4g3PmxI6y8olY9WcMzoQwfI9TL8eoc6zeZ4IBD5FrUfwYPOHFdGaLi5NOIMChRzKLT6sgY1cqJ/GJUzf4wsnjt2Tfwep+5oUnmLxa8jtB7nh0cxFGYwPFORcshaJjlCSgBKMob8YE91i1jbNCbAwJ7LMKmiOn2D/jm9OcqLpny7usQtXcpR5aH5awl2vtyL1UM37/SvbTeZfOPqJNvopUE4TWDNUxo6fnnBUrrbNSKNycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2YHXfGyprC/cSrYwsAz9XbBZPck7rDCV1jaxqYFd/w=;
 b=JhgcpahvKIqhOlcjsAMEUVJNlGyRNW9dXWU2qtdlMDO8bKBOndtYXh87pggJYrFMBRZm8XCOsUjVSkrimqU6+7+hFY1FA+uZDektC4hcsjFqAwm+WzRPyvZcNQSymfNvPjjnk2oU/RBe6AnypsBDjCg1ipNhF9Kgk6svVE4fftg/B/rmh2vpDGLgbEpFAdWBhQCEQWGteObPvY434x5HS2ahoGIsEfqmNuIqLgsEEg7+9G/+gAWgqM1/eY1Mf6KgTLrxOfFkb4C74ukDXC1fladR8ej9SZ6zMn3Xux/CuyKIk0mJiZtfTDWEhQvyOKcFkk8wMqjN0pkNeYmbkEU59g==
Received: from PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::22)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:01:41 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::8a) by PH7P222CA0019.outlook.office365.com
 (2603:10b6:510:33a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:01:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/10] mlx5 misc patches 2023-07-08
Date: Mon, 8 Jul 2024 11:00:15 +0300
Message-ID: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef2c928-5ab1-42ed-35b1-08dc9f24337b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s2/8b+LnTvFMUki4NGj6BxC4PxOPUDRW0UpTVjxRcLJzn8GjSWxfkF9Rwx4i?=
 =?us-ascii?Q?9R5wTYy3x6GwZErcQ3uqRmRJZOlFZnQFKBIZFeKiQ1akWRM3uk7F3s7+Gnf+?=
 =?us-ascii?Q?Y8EvGvmPjaBgIK5iebDxV+3Ka5cMnm1JZCVF+yzmmHrRaEruJ8KzfhGiimYW?=
 =?us-ascii?Q?oQkdgKe1kHCEc46d4OWYm4i0sXHLFz61ht6v/dIuDFov4vvHCUemZ/re8pQ6?=
 =?us-ascii?Q?dYhnGkA8EPDYttH/jBYc8+6dFj7cl+SlKCkTKkaF/SULs9UMzkqCDFGO1I1W?=
 =?us-ascii?Q?O6cTF4pc6ZdoP/sYmhi3+9P+4NDCzy4PBqxAfSIFw4dXRLe/HyASexjqf9F5?=
 =?us-ascii?Q?XeRYxK3w7HI0PHf7kNUSHkZs83T5WqRDjLu/Bhmx7W5dKIr6/178WK47AGgo?=
 =?us-ascii?Q?Md4G9flO/4pNQx61zblbivqnKVidThKfO5F8WntmV/yZcOJWnwLSt7ZryBPj?=
 =?us-ascii?Q?xdfFdYKTMtEGL7Dm6lHnQ/l3L+8zBP7Y68Mircc130u0WpJ2RnY6GZhhh0aD?=
 =?us-ascii?Q?ucNyT0biHPu6njw+RsslWwvarHsTwE3ruA+l2T/+JipvAOXeAGY0FvGZQVMo?=
 =?us-ascii?Q?77aiGJulyVSDXCjQ8z76VZN4RrQDP2xJFJCdVKxTSog5yfU/RVNiV6UWbUJ0?=
 =?us-ascii?Q?uBM+tZCbYT2TOMDmWr37vPPPLUtKVvS7F7NpzUHNJ0Vm+XdqH+kJKBDp/x1x?=
 =?us-ascii?Q?CA642oe5uBKcRRYpY8nJmC03MRGTrqej+kxziaH5+TLLnjeyzBJk1cL/NX01?=
 =?us-ascii?Q?eZeMij/8cHBXB6JYinW8rNWR0hm0JOUVs+7EeInCbrAL9Dsge3mO0sw4TbGW?=
 =?us-ascii?Q?kk9zCYTRRDWBgzYIkRESMH6lJrHSxzfQD7K5f6vPKrqH3djX0R4uI65mh4HG?=
 =?us-ascii?Q?rQetFNPj6Chbg9SOT4epoP7oue54j9q0sEBnscfc9xDGDxgNLtVBq5A+nzX5?=
 =?us-ascii?Q?VU6yR4osI/1+KsjKrPuqwgsWX4Itwer7wFnha5VGt6aqwv0n6IV79w65S6SR?=
 =?us-ascii?Q?AQbsxwbptrA35ZdH3XT6wVfs7Eoua1DrTQzoeLmC1xlam95i2vTpCkGa3yYL?=
 =?us-ascii?Q?2CcxPTHWquKX+vxA48r75cI9pR4mfgi0vO53VvA4U0bdIFwhEasZHsQ9Bxxb?=
 =?us-ascii?Q?yBDdfYjSWPW2HXqqZbGt6YU1pbqHgWfZsyA5FWCxxmUpJHkLQ0qk9NrqxS8c?=
 =?us-ascii?Q?R85/7/a90YTCMOLB8b3+v+rYVcDG/Nlx/WxKgvfyi7HIQN4uV5KKaZcOvGw6?=
 =?us-ascii?Q?7jFMhnkjqIk/ykT1U+WJjMpV9VsF/ezbv8lNNaAtbvbvaHmB9xiLcYiDIQeY?=
 =?us-ascii?Q?GIV2bk8ffmg4R24BlSwfnoHPAOeD1U5o3Lu7X6ZpgouGhEYseLhZo/S9jZIQ?=
 =?us-ascii?Q?30abjY+dTG5kLe4lYmWsVGcsIbshy04J0A7wip2OxpRw9/vbHIvaixGshjR6?=
 =?us-ascii?Q?ECknbEQrHa58Oj2QJtsaupe2803ro0S1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:41.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef2c928-5ab1-42ed-35b1-08dc9f24337b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

Hi,

This patchset contains features and small enhancements from the team to
the mlx5 core and Eth drivers.

In patches 1-4, Dan completes the max_num_eqs logic of the SF.

Patches 5-7 by Rahul and Carolina add PTM (Precision Time Measurement)
support to driver. PTM is a PCI extended capability introduced by
PCI-SIG for providing an accurate read of the device clock offset
without being impacted by asymmetric bus transfer rates.

Patches 8-10 are misc fixes and cleanups.

Series generated against:
commit 390b14b5e9f6 ("dt-bindings: net: Define properties at top-level")

Regards,
Tariq

V2:
- Fixed compilation issue on !X86 archs.

Carolina Jubran (1):
  net/mlx5: Add support for enabling PTM PCI capability

Cosmin Ratiu (1):
  net/mlx5e: CT: Initialize err to 0 to avoid warning

Daniel Jurgens (4):
  net/mlx5: IFC updates for SF max IO EQs
  net/mlx5: Set sf_eq_usage for SF max EQs
  net/mlx5: Set default max eqs for SFs
  net/mlx5: Use set number of max EQs

Dragos Tatulea (1):
  net/mlx5e: SHAMPO, Add missing aggregate counter

Rahul Rameshbabu (2):
  net/mlx5: Add support for MTPTM and MTCTR registers
  net/mlx5: Implement PTM cross timestamping support

Yevgeny Kliteynik (1):
  net/mlx5: DR, Remove definer functions from SW Steering API

 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  7 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  3 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 15 +++-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  1 +
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 88 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  6 ++
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 +--
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 12 +++
 .../mellanox/mlx5/core/steering/dr_types.h    |  5 ++
 .../mellanox/mlx5/core/steering/mlx5dr.h      |  5 --
 include/linux/mlx5/device.h                   |  7 +-
 include/linux/mlx5/driver.h                   |  2 +
 include/linux/mlx5/mlx5_ifc.h                 | 47 +++++++++-
 15 files changed, 195 insertions(+), 19 deletions(-)

-- 
2.44.0


