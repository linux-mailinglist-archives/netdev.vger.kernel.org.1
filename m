Return-Path: <netdev+bounces-168113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F409A3D8DB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D706172800
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805521F150A;
	Thu, 20 Feb 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="boxPvnYZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4A1EBFE4;
	Thu, 20 Feb 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051316; cv=fail; b=VK6zxNSZItziMEUV7Ms07OHbvw9CCEOJCslwvspf/+JLQSrA3t+q64U6SYxGm2JC70IoObRl76RP1tIyUDyJUoGBUfiuxhCEgsGAn4oK/J1puMNWg9a0lnAmuMwSX4KqsQWSedQGfdLeVgw3fSSlLebjEgVDuEU3EM2TqwVSLOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051316; c=relaxed/simple;
	bh=Koet9KPWZt4OEt3sfjH3LB8OV5x0O3qu0FjkFh0avhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hB/d0qHpjUBxbXlu6xmSaQpH7q/8kPzBv8YUzteRKkg+gn+tPo8zG8ycxFe/mp5htrI8SFKGlA47f+Y7HreIp3f6FJVyTYw+Yth+2OzcWKPnPRpojQOAp5NSOXvM9gl00mMOmYg1miLVOHGN6VOT4kzF6esUiAQlvljW0gCErBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=boxPvnYZ; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKeQjOEoJJyy/WgjRS6qL5kClmyeAQ2HWDIxUUWCSFgF+2okSHEVfkvDaQ5fyVJculNl0ahifKSZTBoeR3V/HQ3okgeHCVP57jMu5hnLVlygSbaiUMIvKcWmETxDHxPgF4f8pRGsnsBu9GWEeGcyubwNqAbvxclG3qMYP2Gt4eh0rO188kDKecHom2ztsAUjdwVjdtQq6HQL4/ZZ8F+I/Qrv2ke9kD5lVvmiRVQ2WUtuFqcNhe1pYoVDXFeaT11gETeHP2pdidGyvoKFDTQBEhsm/Zt/aN6HDKzWR7a536SmbGXGwhIN9LvQN6rlkuI+dYiP/TiNVto82qcidz8fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+M2se7DJp3jJW+rBT95SstKcxaWJaWHuBv7Zk8FTd4=;
 b=X4WviyIuLvAUYeuGHmdXNoWMW6MCLj9cbhpbcQK1N2sgr8HOV/94AboQrVgDFsF5j+/iCXagodA+D1Rqu6ybXv3IJV4Fm1mWIrQSdqdADDwrkQgvyWEIS5Fhgbnhwltxtchh/FGOdDPjSZ73vcPHeBC1E9dDyfDLj6ZaBYSChY9Rk67B4lR/RKIjmi+w+eDPSIud+Y8qCsT+xnl761VKRA5jVAPq0WS23y/rl90VnALdIIsGPrw3AQapXu+AMoG2n7Uw4LVubkVI0VNu4U8Fs6vqWdCXT3e2Y8B1Zl2xwZH3HQ30m8La5JNwmTWJaPTiTSELycKlIvn3QqTRtFZgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+M2se7DJp3jJW+rBT95SstKcxaWJaWHuBv7Zk8FTd4=;
 b=boxPvnYZmE/XYJX9ohCM9XsqCsXDp3h4Xqy4msekG0N3VbUiaEjqcCrIb8gNOKQfkVJUKo2MQKy6QHpVxu5KJW30ZYI1d8mvbUxX17DfHviVgIFqwyAxA+PoZ3j4DMZyNTLKR2PF280evl8IhmMcT0eL3DMdZ0OTL63Moo23CIz0SIh07TGD6JN58HQTigpnvH7CmbZUuNRc+voj4kCgbSFU7zByn0Vb63HYiJml7P6D6GU+6F0vnjpPQ+QfW/fEosQFVbujw2tM9A0Ke86I5qF4LGe775uQMoHaZfWbKtCtKhGE0kC8tD3kIYm84iBLUW++VuhxbmDyKSUGsPmg1Q==
Received: from MN2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:d4::38)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:35:10 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:d4:cafe::3a) by MN2PR04CA0025.outlook.office365.com
 (2603:10b6:208:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:35:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:34:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:34:48 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:34:44 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v4 0/5] Symmetric OR-XOR RSS hash
Date: Thu, 20 Feb 2025 13:34:30 +0200
Message-ID: <20250220113435.417487-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 105dbca3-7f7c-4140-76ba-08dd51a2a193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OqnwWwLK4MJOYojdj+HWojtIkZFv4aX2BYB+wINqmJQ3ZeltjLdu/YSlDu2c?=
 =?us-ascii?Q?LkwqSSSy2Xsa2l+mu+c2zUQWnz5t4TdJWp5tFC8ixC0WUsEDSQsInXT4swj8?=
 =?us-ascii?Q?qnKlWWY9skbiPZyaGqgL1M92Y+y3lIyxXtksMogBD/itWdydPMrPzTQKbW8A?=
 =?us-ascii?Q?QDRsz2AwLXZXyNABfwDL0vqTd4pwjsvGZtIEi00akopJEpDg2Dapu5jms/bS?=
 =?us-ascii?Q?TcqG1hbRlFxMAsehylo3hG8Flt1rtCTNomRBCFgvwfE/KPJ0zX8KPRKT3lm1?=
 =?us-ascii?Q?hJaBYJJe/x+5fMrMA4rK4Y3M//B3qlbxoHfwBXVVEp+UKOV7AjEB6HrjhMMG?=
 =?us-ascii?Q?D9ThmkRGByRJg8EC/i6DGJZhgaMV5w6cwJaLDNagEzWZ3yYCVYsD3mc+mAJ+?=
 =?us-ascii?Q?ym3dXO62Dyo7K+YlBg3LcknxdBhPvTm8a9mf3GI0hxBoaeDrU0TUoOtqAPd5?=
 =?us-ascii?Q?aykSTzaGTDX5QN9Ln//RZv9BKBYMClUz1WfMfzOn6gWCsbk/u6oUdeZOAHZk?=
 =?us-ascii?Q?5sNjWRqAe5A+BPFrVNqsMVfOoyd5g4jGB/VH9DAOaFVB2zOAq5Oy2XOkUmrP?=
 =?us-ascii?Q?kwOo4bFFn5/xR+AIT+xcJijujg0eapyjtBIZDld3FdLVkyZkXkrmymeJL/L9?=
 =?us-ascii?Q?C1ZA4NSmpXOjihenjGWXzECcj8wW0GNxOPa4U7Hf8fFYU6NRVIEjqs0ULGux?=
 =?us-ascii?Q?hl3vLNQZmjwhGkxJy5b6id5zVedGGyedVNgZM8i2qSniMZJB9JmSlpj5AS1M?=
 =?us-ascii?Q?cAJVgPgKjJD4Fjj/pRUcw2YhS7iOwJYalTYxsLC9S8hRDz+G9BX4P2myJMFl?=
 =?us-ascii?Q?+GiiRsofr+ylMiyFDQbgmEjmogku9ecTdx/hV+pVEuer/4HaLrB2Nr72UtZI?=
 =?us-ascii?Q?KiNBt3IYHQCKZMaPV4TEaNm+cAe7F+Q42pxAYcyKCRHzFdRPlZSyo1qFWvef?=
 =?us-ascii?Q?JYxvOqNemB94lrWnN+B73MBldL2/L5VDZnt8P2ATPA6m1NBDjMfIaU4N35Cr?=
 =?us-ascii?Q?M10wWJYqKSVVf18SRLBT7N0FWITeKqBNYGRqmzmkstvsiB4Is8Jj+ke0xEuZ?=
 =?us-ascii?Q?dMuBZdzRqILozu30NFdvHZVG69YoNLS/gatm3PWatg2ej10bqD3r5IvBHgvz?=
 =?us-ascii?Q?3gm3fxBPwkFL98clQNo+UZ2hclfyKs31glJoniq8e6Xj364enwfgB5m99TKO?=
 =?us-ascii?Q?ric9KzJQSVIMlMfxx3uQgQ4cz4mvTmCj4sljxhtvWDDADP/xan+nAbZwZWeg?=
 =?us-ascii?Q?7xdunnQD87LbQxlG+bRNQPI+up6GMPeQTroz8eV0rPcOzTOYClD5Bc2QbP+a?=
 =?us-ascii?Q?jJBX07Fqpf2EeVuNXr3rXcs/X5yvuNaZGnAZ5MP0beH6Ciaq7//7gAjZrUUd?=
 =?us-ascii?Q?jbkE8fHps0RnNW0ZiB1WFb+VHRXvNZQz7B89dmm/lANmV9uI9w616f44VD7n?=
 =?us-ascii?Q?pqSuNavW4bvr+dembA0BFyOvVAHYiGfrDyFs3DtYGooWJjutFMqzS3sywUTH?=
 =?us-ascii?Q?iCrsCBeSereQuF0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:09.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105dbca3-7f7c-4140-76ba-08dd51a2a193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
For mlx5, the default is already symmetric hash, this patch now exposes
this to userspace and allows enabling/disabling of the feature.

Changelog -
v3->v4: https://lore.kernel.org/netdev/20250216182453.226325-1-gal@nvidia.com/
* Test adjustments (Jakub)

v2->v3: https://lore.kernel.org/netdev/20250205135341.542720-1-gal@nvidia.com/
* Reorder fields in ethtool_ops (Jakub)
* Add a selftest (Jakub)

v1->v2: https://lore.kernel.org/all/20250203150039.519301-1-gal@nvidia.com/
* Fix wording in comments (Edward)

Thanks,
Gal

Gal Pressman (5):
  ethtool: Symmetric OR-XOR RSS hash
  net/mlx5e: Symmetric OR-XOR RSS hash control
  selftests: drv-net: Make rand_port() get a port more reliably
  selftests: drv-net: Introduce a function that checks whether a port is
    available on remote host
  selftests: drv-net-hw: Add a test for symmetric RSS hash

 Documentation/networking/ethtool-netlink.rst  |  2 +-
 Documentation/networking/scaling.rst          | 14 ++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 13 ++-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 11 +--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 17 +++-
 include/linux/ethtool.h                       |  5 +-
 include/uapi/linux/ethtool.h                  |  4 +
 net/ethtool/ioctl.c                           |  8 +-
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../drivers/net/hw/rss_input_xfrm.py          | 85 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   | 22 ++---
 17 files changed, 158 insertions(+), 40 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

-- 
2.40.1


