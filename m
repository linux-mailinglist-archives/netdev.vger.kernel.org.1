Return-Path: <netdev+bounces-162145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C43A25DDD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA371885FE4
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD52080F4;
	Mon,  3 Feb 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pwaf+oq8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99A25A656;
	Mon,  3 Feb 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594914; cv=fail; b=cZhQlG8Suydtx3MH0imh/oZ0DXJHpwQyanYs9aVSAnvYL5GsZlYHewoWGmTolHWwTOvH++Xx+A5Ps0b4y+xDgFdcEJoxb+zy6FbDsazqaVzpEpkY0n5hpTeGajI9ysnxeuQveuKCMg6Lkynz9yy85zs26aEtc+qa1qwQAU9XZ8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594914; c=relaxed/simple;
	bh=DisK/ccaqcft3O80p5dDC8SiPcTa0K0NTk6c+IMpNGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gzz3NbRgRHcB19hk8yoipXyy4KPrXA3ShY/dtxOLq/CCJN8WWXMM9nfocSr/lqDy8v+FfvC+pl6ofB+urDUgRk5d4o61EAjioudl37Fq2o+Bz+s28CSQizcYybaiLgEwLzH5haAhzhzoLaCZKRajbbNbUz1y/heZ/g1cLXAhXvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pwaf+oq8; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTzhCfRmfPpOtg9oqLW6TfeuKBNeMO1vnWUmycPv3/KR18TZAuGig75+ibmeciOqANr1rKKxjuei3pOIHDncGK8d+808hhkhRkyDm4YeZUfmHfGxaV3DmbjE4r0NeNDTVtMKSATQ8BL87deTdR6PmF917BmfbHMW2OLhpTfr3R9JYEdBRMMOlslS1Pk2XHrCf+XapBX3aqzI3N2A95PkiOTOoboCaprekRjvQVz0HZiA0SjvI50b3GZY9ROcnqO+JesJOKFsIZG92083eYeEMu+KsDEwOgUBZssDtQ16ImNA/tUInkzDEBqJ1NKjq/cupORXKEnjhJEWAHlv6JjUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvHTLNpKbbXJhKiRJMGkhrYNKPdheLnzbD6UTgxe1kU=;
 b=hvJcxwKqPYx2sb/Vxdnre9r1A3Fg2qSGXulCf71d5KR39WMENL0+qTENenVguKIxyH6eDhgzZGiBNcvPztp7vpt9iS04c5ctZvSZtx32qf91EGXiiPzpns8LBBsA/862+dN3OOOysRsmKDzW/ghgSAVie5tEzNjdXmE+WdAsHlnvJ+TRLCJkzfcjwJMGNzkxp0BrtXGT59VhNBPrTQTtKWstokOsB1bWoNpzsfGYCTEuIDvs176Iwv8FPEYJdO8jh9qSySh3MP9GAemmCOx5pp3qAcN5zbMXQF4Ll/X8Vc5mShsVsEU+aZ51Ld5QVfUMgfmleNOKNXtpKmodNfswng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvHTLNpKbbXJhKiRJMGkhrYNKPdheLnzbD6UTgxe1kU=;
 b=pwaf+oq8Wu5LVQjtRlCaiXU6s2kkRE4rWkbghxvFY7EILnY05RFcEcSA6sPi8rBVLiFwGe3WSxKCIkE7LO9rYrzniC1MiVcp9Q3jLHjFG7cs3C7hJpJFqHOWVeOoWPu2YuJjyoSLyF07icFbIJ2ScOtwJbd8WKOXuU1lQeTEurq91yt25Y5Hub1x8kXRCzk1VdLkjakaJjJU0BguB5xjHzE6EPRim2zDNV6NBabfxfOc+FPJAs8bfR0QCpjPVNguRuz7VgapmIIzZf8rqm467PlOAEjFF/jYhoqSsJELyxLHntieXtk+CK3T4DD2enzdK/hn+TpdCB2G8KHwqnGhpQ==
Received: from SA0PR11CA0162.namprd11.prod.outlook.com (2603:10b6:806:1bb::17)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 15:01:46 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::cd) by SA0PR11CA0162.outlook.office365.com
 (2603:10b6:806:1bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 15:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 15:01:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 07:01:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 07:01:24 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 07:01:21 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/2] Symmetric OR-XOR RSS hash
Date: Mon, 3 Feb 2025 17:00:37 +0200
Message-ID: <20250203150039.519301-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b313469-4dd8-4d05-7550-08dd4463ad1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiqQ1Og+OuAzovBrUEnk+J3IXylTA0UwRgXlzmqvqLp0kc/8RqwPLzxfv14B?=
 =?us-ascii?Q?NP/FA2Kimv1npYkwM1vPZP960FDh9AC2wSl7XCrnhbGhlzSrqtSsxhvKpxI5?=
 =?us-ascii?Q?S2sXs4cP0mtSFqNGt8Jv3L2jOeznydtod07Qp0q09gi7M+NzLhjf10mK8hXB?=
 =?us-ascii?Q?tIYoZ4tiNUwo95uZVqQoENdh7VEhjMRBhu2poq1oSfMheE75LG+ExNATuDV0?=
 =?us-ascii?Q?2wVs9RnAeqpsSWpafBqLd8633RQzTUUFCuStwc02RGi4IztlCmLfbVI00svh?=
 =?us-ascii?Q?8EHu5tiK+aZCr0sumQ6DmfeReE/BWTkuMrDXJ6CVpZ9qpPNagIfQXIhzCF3x?=
 =?us-ascii?Q?mCWOJTuyoFV+gIb7Oue3MWSjtqMe+/C+cgzPqesuGgDTCvrV0zEd7CjoJvgJ?=
 =?us-ascii?Q?IltyBb6j/10U2YzhELvO3Hgt8QNfgGPj8f0+1sjFX9Q/BksyJJlMjg1puXTH?=
 =?us-ascii?Q?4Xn0dHbpMzDpmpjY9k05eGJrl+jzAfdXgcyGFZ1PvWRX5T1wSyWq9R8Bj4n/?=
 =?us-ascii?Q?bCZC5qElLFxEuX1oBEQCgEyypoFOtoOAr1Q9a0KsuW9qHfiesIx5InM2rFRA?=
 =?us-ascii?Q?z8XfxM/Ya+hJ+ARgG4SAc9MNouhTgj73j/LBK52gEmIAI7B2UIpyTmCmtevl?=
 =?us-ascii?Q?Ye7t1SOVRTq27fOKiLngJRay9GSGyZbK5I5deDB1/k/cocGIQ9HFv4pnCx8C?=
 =?us-ascii?Q?3O9aWuBQ5H0Wd8xwVwOrjTppLEtmpI6kSiVvSpvjdcqIqRM0U5HHJ1gEd0YO?=
 =?us-ascii?Q?b3310/I35xyu4sItVvb9+GbayFm4+QC6yhmFWEJ3HYYJA9nQGg2WKempjN1G?=
 =?us-ascii?Q?mh511MZzuxpGj8cym+QbWONtVhBspjs5GLuk1sDRGHeh4oGHw84vLWvbWdCm?=
 =?us-ascii?Q?hQwH1RfNstiMXeVdo7W0ZIIal9Qd/SxDQigVE2NTP7qHxCmPCwWHGIIJ2ZrZ?=
 =?us-ascii?Q?glk9Lxld6S5yCm6CQfwEOZkMIkjGa3t1h/BsygHsydrShMZ5tY7NpLgcVifP?=
 =?us-ascii?Q?zBEwIzvC606QzssRXFFZ8/hyP1yXdYQoEbDet4bhGpVoDywsioeFqfxN9gVo?=
 =?us-ascii?Q?NeXgN/WvUyB1De7ka5ozRL8PPBOd+CrvSuo8SfYaeTFwWvamau/vEeG8FewH?=
 =?us-ascii?Q?3EoWtOFlXzJ63ZxJcdPpgF0YRRCEx73lqwa7t42s2/5D46+V73R/WfYQX4kG?=
 =?us-ascii?Q?35SszsuviRWgOuLUKlUwPC2oGAnCT3pT57W51aa/od0sB+1FXBH1r497sVcD?=
 =?us-ascii?Q?5dxbTms8XKh3OXMNLtayRrbnb0fx/81ZSPpBiKkdr5cZjlEO/oZw+5guHbj1?=
 =?us-ascii?Q?lVS8/yyJC/l2Zncu1aTi1x0No8q3+Vtn1FsW/aG3exwzAihfUx5rZQwi7jGy?=
 =?us-ascii?Q?V7+GUUeIryl2YiGJnVr9hsIsKW2DQXbiG9IA0Zk9m+9JKqlaL1uRv36hD0Ae?=
 =?us-ascii?Q?6Otc0lcVddTh8VnhXbln8732WCeBO8n0LRFrbTO/BmvNopiQ+vkaaeR8Se8E?=
 =?us-ascii?Q?P7px3g5maB44/H0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:01:45.1040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b313469-4dd8-4d05-7550-08dd4463ad1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
For mlx5, the default is already symmetric hash, this patch now exposes
this to userspace and allows enabling/disabling of the feature.

Thanks,
Gal

Gal Pressman (2):
  ethtool: Symmetric OR-XOR RSS hash
  net/mlx5e: Symmetric OR-XOR RSS hash control

 Documentation/networking/ethtool-netlink.rst    |  2 +-
 Documentation/networking/scaling.rst            | 14 ++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c    | 13 +++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c | 11 ++++++-----
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h    |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 ++++++++++++++---
 include/linux/ethtool.h                         |  5 ++---
 include/uapi/linux/ethtool.h                    |  7 ++++---
 net/ethtool/ioctl.c                             |  8 ++++----
 14 files changed, 61 insertions(+), 32 deletions(-)

-- 
2.40.1


