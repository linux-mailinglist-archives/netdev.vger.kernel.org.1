Return-Path: <netdev+bounces-163025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB4A28CDD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C201886EB4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD414A4CC;
	Wed,  5 Feb 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JieOZqqj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E213C9C4;
	Wed,  5 Feb 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763686; cv=fail; b=I13F6GJUTzOPMPj6DJHWVZwD3hcnIEle/ciVXQzv+mJQ2eZWwtMxwfqrsMBAkJQ0rA7ybeV34wTzJ6Fv7qsqvPX9o1ZQehCM+K7Eo8tYdjdQiENq7dM5uLGY7oUe53KNMzI191rkqjGpaGWjYisr0wOaqIsYkC03MgEB2GMj1i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763686; c=relaxed/simple;
	bh=JRylf9QZehqm9g3q1fPnmuALIke5NPBA/wYtuUbYvYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QPXCsVBM6gdQ8thX0ylA8IYp6HeDkkkltjrdq3G/hqqgTk/7OjfG+Up83HQ8vVBchfUj3LRGeF3ADWkVybNtpSRJ5twEXWA3ICj7Dgz0YYx+UuIhtB0+uc1IXzFXXk2xJEIuxmCnaHvY9FZCdp6ivoTCf0AIb1FX8DFspBMGODE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JieOZqqj; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKcUkDbyIGWGP5srXLPPgBgaaZSh+Epy8ATXV5jp/DnCCM5unCa7y4+4ftMXjcIQwVV9ckdKcPEA4iRq0HsKpo59lZr5lq8AKtoYX9kKZIhVVRKKjoOdWYUiwd69SX606T2UJ2aFKxRMUbjFQKoDA6wQers+2zMSU1SR640CeGjPVx1IplK+HnbsmGLTHCIvj7OXacd/7nGFbk/VTCH/B10xEMg0crqFusI+o0pFLY9GkdlC00GRjX3/p/cW+p5N3x5mm/RPVEcMMC3gbw6tkGumOnG8bdof0zfVMMVfyFh97G0p5S5onhMvKXCcljwdApJU9Z4DvgbnODpSjrkcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMndNKplFxa0z1vpCJ2GBXYENO6RBGuI1Gyvi1zojqc=;
 b=vwnXAGsmfXkNQztOce90WKhhJN9Gn2DdV48A/PjbCW8/U9cxcERY3yfSqg/C+Mi/JmIOSZMJwnLBQn+YM2LhTIavjTDFmUWxZ+VGl+LNgvlXKz8iHKutzk7PtcKnho+gHKwjG5GviFb4IvSRSqwBTblkPGlPxYwroEW/SsHf4/Cl+sNzkn3AaFfzUnJ4LIZiWTvOZnQqq+iYdtMgjM4xWkycpBzq3v2CTyCruHmNWKVgBIJ5Q5otG9L/eSPy/8br1+zpuAH8YRj1G179byRa8sZM5dxFJ+eVAe4hmMGDOb3XWeKlx0sWB155kmetOx9x810nvQzBIQ4so8jQUrXPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMndNKplFxa0z1vpCJ2GBXYENO6RBGuI1Gyvi1zojqc=;
 b=JieOZqqj21IqGcXJKmjLYn0IojWyT6stjmxXFghfr66xpA1KF+IdHu458kLfungxq3QPZ6ZRMkIeVZjsr8WtmXEO21F0VH5/kR2UAbKl/1UDlrEQoegiiUuUgMkuRpWzsdxSyhr/it/BSY0Q+DrWP4NYuSBEb03cwsjOklfu4aCX5XotIf+J/ErD6QU6PYhA4DC/6w/sPLmfg7zUFfsdWbdQF1LPY7KLLNLAE6CDbL1+5IezOgfCriAm3oTyillqZjuGmed2slI7tYYeJUeFFdn73FAreJJWAMgbIJSym9RyI9m5xyyYc7n+LNqYLCa3Kqi9cGGx+/SgeHCeZcmuTQ==
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 13:54:15 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::f7) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 13:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 13:54:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 05:53:58 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 05:53:58 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 5 Feb
 2025 05:53:54 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
Date: Wed, 5 Feb 2025 15:53:39 +0200
Message-ID: <20250205135341.542720-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: cddd8734-94e2-4115-b287-08dd45ec93b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6uhwdTSrRtY7INjmv/GOLMeM3iG2fIjlLdzMKS330vt8YstFogdZ+A/vN4D?=
 =?us-ascii?Q?9xTLJtf1Qdf6T3bWDKmliyBQMWUWufwJj/+ifZxMELTpss+Mb1DahZceiMqo?=
 =?us-ascii?Q?c90Nwda6GOgWbeOZYfVXr6YEA6FIGZvqiGroG0A0HSbe1Tb1HaQqA4MnykAH?=
 =?us-ascii?Q?orZfgT/K5xyyYyyajErf5Mne5QoPH3mGr5VhUhQELJP+VDas4X2jxdc0tQ+j?=
 =?us-ascii?Q?8tAehm5z6/N0mixqiACvqUMMbOiBWir1NQBWr+EfJWE5s+r7ggIIXz90wB+G?=
 =?us-ascii?Q?dIZupjEfpqVPntm1icd0Kd4RTP54Tn/DIj6e+i8vI82yUuzT2+dpNNoUYhDT?=
 =?us-ascii?Q?u9nf+nEzR7fy3EQW/W7G9Oib1QMccZJwashWT4l/2IKNiV5lbPX7SQvLYU3e?=
 =?us-ascii?Q?O8D7+SnSCQ4U83Id7KY1+gtX5+Bv5hubb8sNab7gd3fOKFzOKm6ZyTXNNHbF?=
 =?us-ascii?Q?ExYlhnC1pRLaPQjiE7qgSQRPstIGOsAusyADfkhPMfcko9csOotuW3PSBIlX?=
 =?us-ascii?Q?2sWN8MBYsRCPPYhHC8HqsbxDHf0tbT4GwP5MMUWb7Ra5w10I8eLI0RsxtghT?=
 =?us-ascii?Q?5Anz5CnQxeLfE1cbrTCpz7SurHJ54hiAztplri2dcMJkgzSSAcrsMePcgVmq?=
 =?us-ascii?Q?ydrC5DPhpfVnq0i6DoIljvhzBaDNPk60/xd/lyAmFyVGbZdIpaoZtEg2/+yw?=
 =?us-ascii?Q?6uOydqtjvhyx181MDIi97LuLa0CBqOlXRtEDRMGpE2F0+Cktx+L4SqiVnRWB?=
 =?us-ascii?Q?yjgr3exncU2Ck7HFwoEBZo6xPGqgiykjpGa1exJSL3NvCZ5MglI0JRvULczm?=
 =?us-ascii?Q?sUdj/KwixyBzZTQyO5uDnMn2Ol62MvCwTa3u6Wlpt1TyWrhNEwJR/LK9ovSc?=
 =?us-ascii?Q?Dz6yUYKF++ZW0MCsJ0Ots0hGDQ68uoaTkPaiChHZ8quoVY9GcCanOPX7FERq?=
 =?us-ascii?Q?w6X3nSdU2Eh3adWsL0rJYB/HW6cM25reu9gxY3q8yRpMLl7Agp6T22T7MfEr?=
 =?us-ascii?Q?up67dEg7prwl34Tj7uF2niSRoXWE+MAI/Ds2YnGy8RCcA7Row9rIvwzV7WjR?=
 =?us-ascii?Q?6K/9eDXs0DqVIuRDn7cdfU/0g4pmwCjIqKZf5rwHIYzsVPUEiNEaEZHwToB5?=
 =?us-ascii?Q?E3xCPgWCYQfJbWcKGshLj8tSvzzOBVZCfOx1tMW5WovdyoJfDUOW7dYJ3F7k?=
 =?us-ascii?Q?kxdCHjIvmNMBwFSdRbgOberTyENbNuAjw+D+rZGwOgsj++gRRo3MTb9Vbaw7?=
 =?us-ascii?Q?Qrg8MGKr/TgEXRiQHMF9PviQWAJVWst1bdgCUZ7jnBRQzK2ZlcE5+LT7X4EE?=
 =?us-ascii?Q?bNsBGjFQqlCzMOLJz+Cyl4WNeHDxCiM7Q0JE533xUkNtP72ke2VC6ugZwCEA?=
 =?us-ascii?Q?vYt7U0HH5/38slfA6jLWMFqpqa3SJYVRIguLkB7YH4LTTFDZAEipNIOOnMAA?=
 =?us-ascii?Q?iZL2d8474JJ44E/FVWYKlx6mnMh77edctfgg7ZLWHS5xc7G1UkGwyAlQ3XTp?=
 =?us-ascii?Q?XgZKv4ifdwMZwVA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:54:14.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd8734-94e2-4115-b287-08dd45ec93b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
For mlx5, the default is already symmetric hash, this patch now exposes
this to userspace and allows enabling/disabling of the feature.

Thanks,
Gal

Changelog -
v1->v2: https://lore.kernel.org/all/20250203150039.519301-1-gal@nvidia.com/
* Fix wording in comments (Edward)

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
 include/uapi/linux/ethtool.h                    |  4 ++++
 net/ethtool/ioctl.c                             |  8 ++++----
 14 files changed, 61 insertions(+), 29 deletions(-)

-- 
2.40.1


