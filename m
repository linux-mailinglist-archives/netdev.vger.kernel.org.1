Return-Path: <netdev+bounces-107368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874691AB77
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5741C227AE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084F198A2B;
	Thu, 27 Jun 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rJF9gS4Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3581990BB
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502462; cv=fail; b=kFakFYC1nYlzi7TSXbyeGIXE3g0EI28Crz49DRGFq9dRZ8FDGm0xIZEx3P7g8jHv4pJ6YDedQdc+78bnILkRe1tDiv25dZ07qVvgDvaHp+IUgdyzoAe7TV1mMuKjVkLo90Pps+VRbEV1KCsS1+FbTMilOvSeKSXjw4Aex5JQpEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502462; c=relaxed/simple;
	bh=Su25WySSlGh98MyjWzYiBIj1xylOOfWKuIBGndEamVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfWysL+F8eTFHQ2j5rdqF8LoNuyGD3WRjU72b7vbKY7wdvizkD3lsWrPbBD1+Db3p1r96JGBW/pxfqlzsP3DrV5VKs02KmNeFYOadTHxWzkcxi9N8k3DMgi/7lkYBUoZ5qE3h18PZ5rVt2DNU2my0jAI+IVTCs5yzN377b0R2PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rJF9gS4Z; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJNhcXQMpkQMAXYZXS4VcIu5rc9cr9UeQsAEZj7v49PJVMod2lnBVEK5G+DMVaxE+OH+OdpwsKKkrbZIeRHbSRTivG+acHb4uAYJ+ZT++voVwwtpCO/MCEQhUpbI97N81rDeK0ySTltE7ChpgXWzwJuScMaKWIbI55SDbnXH6LQGtSv5rBCpXgoRPVt/X4d0dHlx7/XjWzZ1m6HA5lDJhKetNZPBAVAWP3/YfOVc3uYMUSwxAdCzprTPLE6VDauS/s7mMfNfrR30Yp8a4jmYB3//EqaUHGytxBNUwkDlfsdX9PKG6a9ILXxUQJk84FuF+hHpXTIygk7G2ftYPeMoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvMYzeTocLvWYobwcadaQvuJwu2cNzc0X8cNIh3cj20=;
 b=n5CD8+xiw0ekk8AaPEdHbd+jylw15A/AKLUtIwHeueyfz1M1LjG41qWzoOve8n4vF/YJNhuJ1H8vjCqbS7I9rygVyif4vMcO7Cqo8qN4J521lu7NxwAgkdy7aXHh5Z42hkRlcCnAq6F/iGiOzIwpGNUuyda7Bp2Qcluf/BRlSGpPtCJTTyf2brvJ8v8ReqUXl3Tst8QgiHtdT9lcAmnqy8plqWOSgI9eR0oB26d52YY2mAGwfB38TC+Cf5OTPEve5r0tAF/sw0VQdwWGQKjK6OW0ItMhGyN3hkpduOIFmJ5jMevSdxFJcc3gAo8AWr/Uy2XCU0vqmwuur7SEx+N4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvMYzeTocLvWYobwcadaQvuJwu2cNzc0X8cNIh3cj20=;
 b=rJF9gS4ZUQsV/8xVFWMq6PezeXi9wBjYtElJ96otGiyCmKOdr2Nsyv41bOhCkyqpMUrq2y0rP169POK+aB16DZQ/1nC75eiSJ4DIG0ReR9vzStUAnsjJsBsRpO/ZGeAMc8ZWtH89hRN6qkltKlqpGZMheLsLAgR8Vqa/9jLzw/M=
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 15:34:17 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::e4) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 15:34:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:12 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:10 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v8 net-next 0/9] ethtool: track custom RSS contexts in the core
Date: Thu, 27 Jun 2024 16:33:45 +0100
Message-ID: <cover.1719502239.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a898e9-3dc0-400a-be77-08dc96be9b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLlbopJ795DJnQ2RS2D5EHyXxKVO2qYpyKbh61jOrM+TYRUM2om1kF/vR7lu?=
 =?us-ascii?Q?XOHjbqaC2wln19AkJt7iFYYjsvvrBIuVQYZZnOuDY1cZ8hF+kYbEjOC0G5NK?=
 =?us-ascii?Q?yD6tG/zO4vORkeO1lRrgLrgsGbZEfuOhtllFCY/bqsZz76MZqWeVKNA77YR2?=
 =?us-ascii?Q?CU3H0IVkf8hBnmyLDy8dg6PWn2QJxcskCkQXOmXvX1iiERihGShb8KTUGbSu?=
 =?us-ascii?Q?w67mHGGtS57l5IvkSpJ1iY8xLHzc1s6RzMU+HWIe0LIhbgoayAdlCxdWyxZH?=
 =?us-ascii?Q?tnQ1H73dfp62XQMC93KHTvd4I7K1tgBxjp8EIXg8UK8aAw+BoH+z+Jn83bt/?=
 =?us-ascii?Q?ajx3iZ5ZzLHUODcux+zPnQX37W6Ut7xlJVRq0GJ/Wowmd1efZRvkk+xWQUar?=
 =?us-ascii?Q?W5Owp9Q1YlpBSRcD+qFdAkn5qsqF9LM46ldfHqT+vFB0ICCQJfSJypnLE+HE?=
 =?us-ascii?Q?tCmLlHzZ8D+1BDtlz0DtjTDsn3/ZJpTGTP3XXeCE4BoCa/70uZkuEViruPwt?=
 =?us-ascii?Q?09Yr2/ATWCh+TSmgOwG9Kp+kejxJ9VrmGupf7oZGyr5+BadLmaD3brJ2yI0X?=
 =?us-ascii?Q?1qcYBbAfRnf1Tts4AL8SViIlw1trp7Acpk/bY714HdAgdYIcSmbNHz5a56LO?=
 =?us-ascii?Q?fZ+P0TS6/QasmcRU2/5hj7ctUVttPcxEs8aivvqNqyuBlIXLoTRneob4VOgn?=
 =?us-ascii?Q?oV+fOpUKQKYSrkwmE6aMIobtWkMepRu63zAIsS/yYd/WP5KlMSM10I2hYEc4?=
 =?us-ascii?Q?iGQ+ftpoQMsEEXtKPRqY8GqIc+teBFoXOZTRFmhnsxr2qJbVykqxOYxFTle+?=
 =?us-ascii?Q?Sp7/pJrMO5KwjPbQ1WqAcorAnWFOx25ZM4Tn2f9Ek7WyygDx9GOX5CaQHN+p?=
 =?us-ascii?Q?mDq/eBCTom5WH/lqkYIyRf5CJi5JSfm9BZtRIeDjEZ+0AVHOj81H18YHL6ad?=
 =?us-ascii?Q?DSTS++jpDbnSOl6JnIsFbHr4DGiStW20n2S8DYrnKjyluYYygup9YKR2pkuu?=
 =?us-ascii?Q?4FrKYYUbHZGWAnqfuAAjr9I84Zb6uJEVGcuKE6FxiAl0CXZOvqJbpSIdJth7?=
 =?us-ascii?Q?9uMqcyiJKmpMgnTvktkWpaSRJPDd5SJWzqhdhcimnSSRQoduJ2qV+HSImrhC?=
 =?us-ascii?Q?tnjBN7PSPapxKoYV0mzJDHh2Qb9nLxTKTy/j61VwiUCXADbYgmYbvj2dxmDW?=
 =?us-ascii?Q?KKWjdfJB3ONNRZkW8TnzuSk9ZKIwhH32RKCXn5riFCblQPjv3gf/ljDyHbdh?=
 =?us-ascii?Q?Dd0bmHMGVW5ZJxvoDnIXjemhmqR2UfowF0gs3VWsKRzA/kq2BV2gI4FxBsxT?=
 =?us-ascii?Q?ipnxMOJVEbHkqrOHrlq1UfbNcRNnVb/WkXQMNMJu99e3bhQAgsK+gzpi7arz?=
 =?us-ascii?Q?PrtgIzjbPKdspEv8FNL06+yYOZX6BwvGq92Ve6lkoaOHzdrqENnXlxZuaHmP?=
 =?us-ascii?Q?dFDnWG+oafDOT6bZTWfPJYz7GAja9nNw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:17.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a898e9-3dc0-400a-be77-08dc96be9b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

From: Edward Cree <ecree.xilinx@gmail.com>

Make the core responsible for tracking the set of custom RSS contexts,
 their IDs, indirection tables, hash keys, and hash functions; this
 lets us get rid of duplicative code in drivers, and will allow us to
 support netlink dumps later.

This series only moves the sfc EF10 & EF100 driver over to the new API;
 other drivers (mvpp2, octeontx2, mlx5, sfc/siena, bnxt_en) can be converted
 afterwards and the legacy API removed.

Changes in v8:
* use struct_size_t in patch 3 (Przemek)

Changes in v7:
* ensure 'ret' is initialised in ethtool_get_rxfh (horms)

Changes in v6:
* fixed kdoc for renamed fields
* always call setter in netdev_rss_contexts_free()
* document that 'create' method should populate ctx for driver-chosen defaults
* on 'ethtool -x', get info from the tracking xarray rather than calling the
  driver's get_rxfh method.  This makes it easier to test that the tracking is
  correct, in the absence of future code like netlink dumps to use it.

Changes in v5:
* Rebased on top of Ahmed Zaki's struct ethtool_rxfh_param API
* Moved rxfh_max_context_id to the ethtool ops struct

Changes in v4:
* replaced IDR with XArray
* grouped initialisations together in patch 6
* dropped RFC tags

Changes in v3:
* Added WangXun ngbe to patch #1, not sure if they've added WoL support since
  v2 or if I just missed it last time around
* Re-ordered struct ethtool_netdev_state to avoid hole (Andrew Lunn)
* Fixed some resource leaks in error handling paths (kuba)
* Added maintainers of other context-using drivers to CC

Edward Cree (9):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an XArray of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the XArray
  net: ethtool: let the core choose RSS context IDs
  net: ethtool: add an extack parameter to new rxfh_context APIs
  net: ethtool: add a mutex protecting RSS contexts
  sfc: use new rxfh_context API
  net: ethtool: use the tracking array for get_rxfh on custom RSS
    contexts
  sfc: remove get_rxfh_context dead code

 drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
 drivers/net/ethernet/sfc/ef10.c               |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   4 +
 drivers/net/ethernet/sfc/efx.c                |   2 +-
 drivers/net/ethernet/sfc/efx.h                |   2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  10 +-
 drivers/net/ethernet/sfc/ethtool.c            |   4 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 168 ++++++++----------
 drivers/net/ethernet/sfc/ethtool_common.h     |  12 ++
 drivers/net/ethernet/sfc/mcdi_filters.c       | 135 +++++++-------
 drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
 drivers/net/ethernet/sfc/net_driver.h         |  28 +--
 drivers/net/ethernet/sfc/rx_common.c          |  64 ++-----
 drivers/net/ethernet/sfc/rx_common.h          |   8 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
 drivers/net/phy/phy.c                         |   2 +-
 drivers/net/phy/phy_device.c                  |   5 +-
 drivers/net/phy/phylink.c                     |   2 +-
 include/linux/ethtool.h                       | 110 ++++++++++++
 include/linux/netdevice.h                     |   7 +-
 net/core/dev.c                                |  40 +++++
 net/ethtool/ioctl.c                           | 136 +++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 496 insertions(+), 265 deletions(-)


