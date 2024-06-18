Return-Path: <netdev+bounces-104672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90F90DF34
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FB01C2266B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4516B3B2;
	Tue, 18 Jun 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BcyFQk4m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1628DD0
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750720; cv=fail; b=DPbGhrIj4LQNlfEQL/YqTc0XZXEYFVHQP6ymoGWCSs7/WIMzNO2hdcnGbnZZAlCxCPXKu0fk9L7+WJL+GjU0asTZOsgCFCOezsUMKI7r/EU5VkdheM28XnhB+sD1wgSPn0QOUAtiV8H0vAqiD5juHz2RNRe+l/uvaa0JOwNKfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750720; c=relaxed/simple;
	bh=cqO1Yx7WbDtK4bc3Zl7RPSza618qyjjlSFhk41bHe4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l9AWUFHKrz/OYeL4U96c2x2pMUiXpPuP5h+/lvaMyIFN2qdai1PxsR6qHblJSvENl0aOsl9TjeII3xKqq8sOsIYRha0e310p6RP2mb5iLT5QKC3Kow5TzTet7+wnSmBFxEoHGcKsIOVa8OgDWPgRgu6QM4njzQu4U5N4Z+X7h7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BcyFQk4m; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvsfSg3iI40g7ZH1kiMEPfU0gQs0k/VLxyoV90T+7mRwTp3fgkyAWhOE1a4sEv9O2vPy+84gQevYP2xf5/koi7/N9kEL+e5IU7bfd/P2kSyJmOQ9Yq73tZox5IBm5EwOEmcQpLx9aL8fn3Q8hRZ4KjLryM7udStDCbrX+QdiUn8uuHD4LQoxiT+zzg8t0sebuMr2SHMHOYtFfqWlwE7WptZ64+k2c9y+6wi38J9TmlNY2XFL6wCiE5Xh/VMiVbOj/OiGntm077QWV/gOREYqKW+G2+HDXvZxJzayvkainrKoQSOutp91o+iW/jP6HQOhZECsQ4cSbQLgStvR3387Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpZMk3ZbamBz/gPizhHxXPwyqowoVn/gSWFuIOcc5PQ=;
 b=HrKeuJJjOnHbNAnYNsjsSeceXlWKPqXvlkcxjMRjbmqOmZQgsjl4FSlpMmv5mDqlK8UHAAgXicY1IulCMUHSaqmvsX/JotC1+ETgLfWTY47liRE1BXtmRRdLGL5vx2xT3J4aMYi1ziXu4UnOLQ+MTwZyk+bQhM2qoYEDjMaHR0B/9p6W7l7stPLz3NOh5E/U5KxGcNY8zB7GPJYBB3zhuXPSIMS1NWj/Ag26iXm8J9KevBIIkjk1OSzS6lc8y4WVem1t3LpigKoYtwZp18qFY5SNkuRuljjkj1g4ac4kJ8vC23CMNkkG7XE3pY1U/nN2/+ay2RTzd6P8hIvA98n1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpZMk3ZbamBz/gPizhHxXPwyqowoVn/gSWFuIOcc5PQ=;
 b=BcyFQk4mLjkI1cOtpMF7mtA0HGufE9/vPsld7TVAQtLrLMpEToeUg3+9obw6N4WKCyH0zsJ/x7fep70uZOJGvOyklhsCqU2pCL+081HCXD0Wnj2qSy8UOM32JVWOo+ByQJ175VX7MAbxP6zNSMLiNKeBZ7D42OjnQ03WX/juU9w=
Received: from BL0PR0102CA0009.prod.exchangelabs.com (2603:10b6:207:18::22) by
 DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 22:45:15 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::b7) by BL0PR0102CA0009.outlook.office365.com
 (2603:10b6:207:18::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:14 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:11 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 0/7] ethtool: track custom RSS contexts in the core
Date: Tue, 18 Jun 2024 23:44:20 +0100
Message-ID: <cover.1718750586.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 927a9535-277b-48d9-a68c-08dc8fe851fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaPwpqVMCKjkxoRFrv+aWuEV3r1+iHmU/PmNVkcaTEuSqwFC9W5Cp2S8M2sl?=
 =?us-ascii?Q?djFx8jHs+1U0fJA47+UFH02TMeOMzf0J87LOok2vtBPrwKTTKTP32A7wP3X+?=
 =?us-ascii?Q?5pgNdvfrTyHE5VqR5uPZYk9Am4MRWlIKqCOjioPV+F6P/hs0Bbci142KTfk2?=
 =?us-ascii?Q?LFkE2jd6zDtiZwAvJ95sjc6D2uCU4uBCiQf5JNMsUS1B75Ce0cI69BArkBuh?=
 =?us-ascii?Q?nmwsw0dPcNQmaWc9b1KOW6ULkVlPck6JlgQipNOE8a2eIRqWpL/+d/AiivVg?=
 =?us-ascii?Q?rR7CQrJ/M35dzz41hJ5tGsdetZwwEgIf6ml1WhFUbF7JV3+KYbMY3V58M3l+?=
 =?us-ascii?Q?SSFFSDkPdupew8lBpYilydZVUt2qhYCa9ZDJuR4yryO4u7629n83UTxy1JvI?=
 =?us-ascii?Q?oUaBNo5bUMAQ3NWRr5xXBQMRUh2Qb8esmjrTLMvq2RhrCEp0v6jhicN6nqza?=
 =?us-ascii?Q?1KI5D5agem8yubQ4wiYJSVe1GhlRQQnOYWLWdjByv6DcLy56/7i4eUYS4mWP?=
 =?us-ascii?Q?B4HciRaMM4CqBD9Up9YlaTdnacERJi34ejUlVMzObqKChmV+6uLBqECwlL5v?=
 =?us-ascii?Q?GF1N3nk7BH6ki2V54e14uw0PBGKNAP9Lalui+qsSmlpQIGlCROwfQdvHHA6t?=
 =?us-ascii?Q?rPu8B4mwlx6izHHQ9UGwdD+eJYQ624E6iPTPqSDDQK/5MlCLAXhI9oq9aZ58?=
 =?us-ascii?Q?7dpj4qsaVvzm81J8cYxkgH9ilIb1nA4/ZqupGwS1Oy6PtJymTt85IIWmNZkn?=
 =?us-ascii?Q?4ujVHHI5f3kSa9FQATIlriQni2Ui/JY4sb5K8bgq3z8jwyVuiypMhCn75Xa6?=
 =?us-ascii?Q?d0cnDfD7FKlWR2b0fH8s+wk7b6O/jn7nIxiRkeKeEQWToO8nO4a1n125M9Ke?=
 =?us-ascii?Q?rBd/xJnIf3mXonwB2xD45h+0rbJluQug/68ijDk21+KvX2FDir9x22r8Q/f8?=
 =?us-ascii?Q?gEGJ1/s8yjwgmDzecmp3fT2L4LcH11WIKytL9yytKDIW0pgazlt/a9o4/KY+?=
 =?us-ascii?Q?9AKt8w5p5HRQ9Kfd8EDejBmtBUnDIqt7kyRNvxbqVUGh4HEeK8Q3cs/ShdPT?=
 =?us-ascii?Q?WEZeBey2lxRHZdELGYq8kmG1OoD20Zc7E8gHkGDa9NRNJexvTApUF+RYaqf7?=
 =?us-ascii?Q?f0VANLQLG2RAXFycTVRXQ3ewfuD9OvqDyZPs5WGtqwPu1NN+RmYydHnI/7A7?=
 =?us-ascii?Q?0B9i2T6H/HANg3IXgGv8UT4BE4lN4AxMzf23RWGyBmH1ZS+iWFsfc+GKgxZk?=
 =?us-ascii?Q?xXLsH4YclteE7sLSnu57mDMYSwlTofGrenzj1o7WiDE/vzoT7pwX9PuDuZmG?=
 =?us-ascii?Q?/yFF9dPvOYcirEi5MssidJyV3yTGUs4qKH+9nNub4VKBVkANpJ3WFb6uNRTd?=
 =?us-ascii?Q?SBpP7TETLSqxOtPldJHKJU+FrV6rEYo1fbBnMDlf+DyJFTDt4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:14.9839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a9535-277b-48d9-a68c-08dc8fe851fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

From: Edward Cree <ecree.xilinx@gmail.com>

Make the core responsible for tracking the set of custom RSS contexts,
 their IDs, indirection tables, hash keys, and hash functions; this
 lets us get rid of duplicative code in drivers, and will allow us to
 support netlink dumps later.

This series only moves the sfc EF10 & EF100 driver over to the new API;
 other drivers (mvpp2, octeontx2, mlx5, sfc/siena) can be converted afterwards
 and the legacy API removed.

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

Edward Cree (7):
  net: move ethtool-related netdev state into its own struct
  net: ethtool: attach an XArray of custom RSS contexts to a netdevice
  net: ethtool: record custom RSS contexts in the XArray
  net: ethtool: let the core choose RSS context IDs
  net: ethtool: add an extack parameter to new rxfh_context APIs
  net: ethtool: add a mutex protecting RSS contexts
  sfc: use new rxfh_context API

 drivers/net/ethernet/realtek/r8169_main.c     |   4 +-
 drivers/net/ethernet/sfc/ef10.c               |   2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   4 +
 drivers/net/ethernet/sfc/efx.c                |   2 +-
 drivers/net/ethernet/sfc/efx.h                |   2 +-
 drivers/net/ethernet/sfc/efx_common.c         |  10 +-
 drivers/net/ethernet/sfc/ethtool.c            |   4 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 148 ++++++++++--------
 drivers/net/ethernet/sfc/ethtool_common.h     |  12 ++
 drivers/net/ethernet/sfc/mcdi_filters.c       | 135 ++++++++--------
 drivers/net/ethernet/sfc/mcdi_filters.h       |   8 +-
 drivers/net/ethernet/sfc/net_driver.h         |  28 ++--
 drivers/net/ethernet/sfc/rx_common.c          |  64 ++------
 drivers/net/ethernet/sfc/rx_common.h          |   8 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +-
 drivers/net/phy/phy.c                         |   2 +-
 drivers/net/phy/phy_device.c                  |   5 +-
 drivers/net/phy/phylink.c                     |   2 +-
 include/linux/ethtool.h                       | 107 +++++++++++++
 include/linux/netdevice.h                     |   7 +-
 net/core/dev.c                                |  43 +++++
 net/ethtool/ioctl.c                           | 110 ++++++++++++-
 net/ethtool/wol.c                             |   2 +-
 24 files changed, 480 insertions(+), 235 deletions(-)


