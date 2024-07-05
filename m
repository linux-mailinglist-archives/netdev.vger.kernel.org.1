Return-Path: <netdev+bounces-109363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51992828B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C0287261
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF10136995;
	Fri,  5 Jul 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ig9DNODm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699213C9CD
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163724; cv=fail; b=S1Kscpa921i8JK712uA78nkN08Id4c2SIGAjEkEub//4GiIlTfRT0KxSrFlIo1BhUceD1NvzBZ/+RB7tfZN2FhWmxTPMnAlxoKugXELgu5fqI1srMS/LW4jdgXQWnvQSd4VYHRF5JmKmfMEbBGqY6jw5KiKfb5gVCb+zDlitiM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163724; c=relaxed/simple;
	bh=zt/35s1AFPIcP192DvYrCV7T1umWgUnFk4wDLDY0Eos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDXi3sLkdM+E59i4C92iBzXjQzwoU0EvbiafrDxZjN7l/c3fvwMNFNBQwRIKaJyfreJJSHN/6qVqXJjYqCNAq3KlnVGRniyxf37NQNshmPC6GuwmJ5jusO7MhYGYNHlnkBlIlqUq1jyecGpd2UfRFnoY42c+kYKfYRQQY5AGb5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ig9DNODm; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK3JAlhIj0oy8cuvkN7r/mkBXsLSl9BZCwFW3lC2PPNn5wLOdr9BjmnRcUUFjPUwqRF7VK3CiESdwj6n13mwPMXvipVz2nb9DaW+3IbCxxNQOMYHtF91IqMf+AZZ1apYE6dFKIlFHRAytHKL2gH5Q/vRlz70G3X9BNkH0QfTtaNFVqukkqCs1ey2fwJFSZc3iBEPOC6YuoNJUZ8Hk3qGXsjn4l7WM9Mtq1sZ3ClzVFbIxziWJ+4sRsPk3aOhV6lT2CBGEN0COJ3cU+uS9QUZi8jiyz9/nvyCbZPtBe6uYjEtkiIMufwIOcjLmeoZ30dRRTgrUaftDfrftMfr+vV9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L7jVHKm5NTxZOqWeS1hkvL+Bi3XWbJFJuDK+ea1V68=;
 b=VcWwu/eAt1LFKIHSMRNnRBAmJjl5Gfad27tQrXpHwP+6nMqG8sb+zPnpSRtSaI12vSajxMCRJ5zii+CqWBEG27/HHvfPqk3GUaCUSnOfzxRh/rghtEzjrLs7y/kNr7X7UL07GOgBTfUPunyyAGC+ZqE2613sxTksHnKmus7oe6YVNINiMoR6vnLAhWQtJApmO1USWvBDUaScF9DMENB01xlRr+u3y1lJDETej9sHswIE/9D4mfB2YBv99V9QfFOji0/XSRbve6phs9SeFvwfVLBtcre/8sJeZZNjvy02FTFfWPxYqC1O1QxLwLVWsWO4O6u97YK8FiqhNXCFjNhl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L7jVHKm5NTxZOqWeS1hkvL+Bi3XWbJFJuDK+ea1V68=;
 b=ig9DNODmkjz3AhT6dBObCtMMh9JybmcaEbYpYKZV4ivO6gn7vczB7T24rv1SByufC6wwrDdGG3Antg9EDOmaaCSlbBXM9P02kNf8khhzAMiNbpIGgSScFFi7PtvFB5J6EcTYh+0hgW/jyGDi2em44PhzQlQrx3rTr0nWbV8ObbcgPIpdcUhzh9I87JKyPIen7ODoHY84VMW+pU55onrlB+VlWOxdN0m7Rm/0FFrBvlQ3Kc8D7h+++K53v8YkkX4PKql/8nNK03tDLdh2CaK92JUCBNbKRQ7T9r2cLk416adr8GNmWlGMAokt76rn31EidjqO0D11UR2msSRM+/ce+A==
Received: from SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) by CH2PR12MB4053.namprd12.prod.outlook.com
 (2603:10b6:610:7c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 07:15:19 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::a) by SN4PR0501CA0128.outlook.office365.com
 (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/10] mlx5 misc patches 2023-07-05
Date: Fri, 5 Jul 2024 10:13:47 +0300
Message-ID: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: e2485a7c-3e58-4e64-caf0-08dc9cc23a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z82d2HhdRl0mof+HFCiw1oVh/+KIY6RVfWWOGmj7BMlXmJdRYWscG9s48CM/?=
 =?us-ascii?Q?cgr2YbzG7uoYm8pzKh3Plfv89qgvll9woysH8Sj0B5Jgsm8vsvLHHNSxKNTq?=
 =?us-ascii?Q?4y6fJnoEWqVNDdONOqBqnZ3a0SLkM7F9QsBzc/ZmjYraqzbkqTQ2PvS7RgM6?=
 =?us-ascii?Q?LZkDA9DUgwrCblES0FdPaOq/yY8HrefkEF8YLCuqgtNUfDuz3nPJgBReyV/r?=
 =?us-ascii?Q?SMSCPgrMqbR3ClROrvWbip5taw9WvBjxgH5M1VOP5cJfu5mt9oCAuwJQL+j0?=
 =?us-ascii?Q?fLmzCKesmhl21+WyqBO6pO24bSDSaumEXea0pjGnn2VfPHj/Kt6iTz022TUx?=
 =?us-ascii?Q?p2n7mcPdYgSY2gsRdNoAIy0FQUyo6C11mN40ZiSiDepNe3s+8HnciQoybpCw?=
 =?us-ascii?Q?N74Mu4Szy60DCD3GRmcoKvOIKveTQttx2kcri/UOaoUXOLc3vJGaw/gPYhOu?=
 =?us-ascii?Q?pCJAhA/66vmpJhfO6mKxqWCD8d3umdRQby55RhJLeviLDaY7jGUL5h5Wq1MZ?=
 =?us-ascii?Q?VVT08qTaeX2rv8V68Z2C+Maute3wWMfuhbP3qunyHJZlpHJ3Cl328HWIKIrb?=
 =?us-ascii?Q?7FLRz9tH9Xjbk/17b0FfvUU9jyQr1TjTVJu4++f3JX+NouZg9lnw5HXIdYYK?=
 =?us-ascii?Q?Auw06iLJK4EUTe/ghFRYAgZ07NPFUD4OV+Lv6M55j5WaNwJaCqjUTMxBaP74?=
 =?us-ascii?Q?AyO7xpvzgiv3wxf0YEyVVebN8tSA0o3032FcYC49IeyDUH7JAwLbHXAfBkYZ?=
 =?us-ascii?Q?NBV/vO0tYdOimMN/Hl8p1c+xcBdVxDY+QPgyCCQsqUrmQvdaoWbBgU4eltMa?=
 =?us-ascii?Q?/1VUp+qnF6wQ3YH/XRM5ZksLr85a3m3MEj0f9hSk7soIKrNfUsQK2To4K2kg?=
 =?us-ascii?Q?Vql1VcBYTIiQoc5S3sDTuUjQ1BI6S+GC8A6t8f4DTIegMJOrhRku5fk9wIcI?=
 =?us-ascii?Q?bqZBEEy5d0s5CzoOu97jw408LSNVop6C+Gculr0qUmjh5TqQO3SmfCHD811c?=
 =?us-ascii?Q?UQNBYEvpy1VepVTCX2P9Hqw0+cZaRLXn1ggOHbhHpPFVOYN+xyUgJQ/Vsv3U?=
 =?us-ascii?Q?wKGhrtQAElxlk9+6hK2lWvNFYiLoQg2KhIylFUdIui07N8dtAgw9bRBTtQE8?=
 =?us-ascii?Q?zT2bLwkqdlqJzQ+HBMSXzt+9ObDqGfFEU0v77vvbQuuJd/kkQ/Lx7VnkyM2r?=
 =?us-ascii?Q?qWEXlXkc0+GIeuH8egc3hHYrIjIQk+9IF6nJmLP2fcfvdTk8SYTp1SDNrF/K?=
 =?us-ascii?Q?oY/vTPwzQ+gbvVn3WwKfenRAJNY278LXz0+Ep1gOzwN8kGFniHjODJX51SNR?=
 =?us-ascii?Q?/my7eRCbPZpvOOYeakjiFE/E2dkD2gP1V1Temfj6Q5oTNjaiImGIN+ejQyhp?=
 =?us-ascii?Q?dMhGP3kdD6X5RL5nOpmiM8+UmikH1Vu5qugOxnn2zPb87z+dSqgnwgw2xS4R?=
 =?us-ascii?Q?P68LExRj36NwHU7w0h6Qcvps11Me4351?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:19.3405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2485a7c-3e58-4e64-caf0-08dc9cc23a42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053

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
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 86 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  6 ++
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 +--
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 12 +++
 .../mellanox/mlx5/core/steering/dr_types.h    |  5 ++
 .../mellanox/mlx5/core/steering/mlx5dr.h      |  5 --
 include/linux/mlx5/device.h                   |  7 +-
 include/linux/mlx5/driver.h                   |  2 +
 include/linux/mlx5/mlx5_ifc.h                 | 47 +++++++++-
 15 files changed, 193 insertions(+), 19 deletions(-)

-- 
2.44.0


