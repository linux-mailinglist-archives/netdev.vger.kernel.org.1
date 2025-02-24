Return-Path: <netdev+bounces-169125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D47A42A34
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9514116B23D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE726280C;
	Mon, 24 Feb 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zr8kQkVX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8572566C5;
	Mon, 24 Feb 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419083; cv=fail; b=ukNVRWd0kyNLo8SvFBXDd97DGsjMOUKwk83l25d4UEN1JL2vXwB74W3BikE+mRERRZDJoU82r1466Wvn12cT2hnI+lRjZ1NALOIfUmZL3PIXCzlthqPjDAId1z3aUE0vmnB9VeRk6K3eC/6LpUP5OAAagugzNuZSNGyQWD0mETU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419083; c=relaxed/simple;
	bh=fSYBVmWOr3qZeLx9EYUmxFMXBHEG9BpD67P+1wYlq/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N+qZj5JRG/vxVGxPIhn/zzDG5H04bJ1/fL2Rst8Mg5On2yP8y7NlXDZHLAtu0ZgIhvfBalUb/QtJ4SA+CAr60NpZ60fNK2P6jAvANdc5Mh0mDGOqpDeGCwtonSnBS4erzC5PP06xfErvZtL5ST8AMQxE0bOhmNehX4JFGGNHqco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zr8kQkVX; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2X3g0iMSaIDHvcE+FQ5wd5ndSfBb2EY/VDld25Iu1ubxaPJ2pqyVjMILCJne5XAWvMalwuNs7FjHKAg6f4oz8B9HuNnJRnBtf5IPEBGnSm3sTMEfut9pweQY/KGtDaBj3DRu7H6ZLpFO/0607AZWGaxGmDNR609E+Vi4Poa9e/KLJuiWKcMAW43LoAC2GZ7Qf865KFQYLFKRnkkuWUYs9Z+vAbAZBWZD3ev76gbUlL0M7fY4A1IHqyAQYLt9nkkaz1NMAiiXjj6rGYcEpPoNox4VStrv+kegF38nzDgXvRXeKUToXKhNlg+OXYdpQSqxUzM4q9vN0gINuFoah8kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj8GIkJlr/gv9wlduLFOtuIqaIy16+MvfJ0K4lhWs/c=;
 b=c1PFArhAn+K2JykbidGyfZzyjQ+DQWY6E8upeUmcVO4FNHzsvba1XBliD6BlwushFY4Og/qHCTFWiBIRqbbaoAE4zzJB5EG6wLXeEP3Ed1lGPSF5jYS6QFJ0v7/83BlpfPC9Qpt6QBiV++irwrXtMRGdujazl/7Rg8mQGXGI0HMY1kTQw2KzpFHTanxjg3ytX1zXPzkw5DxsTUbGgAOdHlm8MY/mG5dvRxfJHmB9Z48P9q4OfaqFpSUjEXdaj80NrtIWCLRPigEqPum6xv4G8n+HNYmsBSlmzEX+jLeLEINi2t109GEkj2n6Epu5ay3z/L/0qNyMvNIDAVIXvDy18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj8GIkJlr/gv9wlduLFOtuIqaIy16+MvfJ0K4lhWs/c=;
 b=Zr8kQkVXdyeRDu2zjhvDjMe1jdt9vVDb7vGss1Mte1oTgja+P1j0M9mMS7m5lSKJoTnNjVMULTxEBOWjfG+dQGiOPBwBDn6P7+TY3dxVSWacw0W0bfo8ORbyqXxMrf6yisoa9W1xFmYfFxT5O6Cl3Fu5/CtMDCgNrX/+u63HGrpuOd1YDY1GXc/fWRF/inr9DSIGMgqivjICeO+A5EboR3DO/rcEiZ9EdViHetS4JtmdvYSO0JeWcIbsZkRkymj1sDROAjt1y0rwWYFWDQEZSV9BLforgusBstgciw0XzEEqhGbOgvpM4nNLbYOJAqV1Qmc5pk8p/eVtCtRv/23QQg==
Received: from MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:44:32 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::5) by MW4PR04CA0251.outlook.office365.com
 (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 17:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 17:44:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 09:44:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 09:44:20 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 09:44:17 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v5 0/4] Symmetric OR-XOR RSS hash
Date: Mon, 24 Feb 2025 19:44:12 +0200
Message-ID: <20250224174416.499070-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba68f5a-65bb-4b6f-1002-08dd54fae548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Au9neaAGEcduOUFWGmxhleNWwr4d2LQs/82qQDyLpxsnEmjHF4fQ4S9PFoL3?=
 =?us-ascii?Q?DumrVxCT0cOJhVrdAnX0Ku5gOxAertqdUC6C09YB9GHio71hzedTPehXxQam?=
 =?us-ascii?Q?X7pzUjfwoFIhavBLodZqD7piferoEps5XPzaWqGI5eCkWBZ+rYEZ6bJJcQrE?=
 =?us-ascii?Q?pLZdEkq7eP7k5ADt/heKo0VdKqxiISEXFnc5zL4XAloAp0sWLirgxtmeuQmM?=
 =?us-ascii?Q?9Bj9p2Ig6a56xZmmJYDuAKIvE+B3o1DOIUIS+hVsJSAQ53NLj8Zhpa+FSQkT?=
 =?us-ascii?Q?uqXu4eqWZ3ST9TE+RLt06/uC3ehWN+pCeM7SYUd3sD1j2zVDHY9fIpXtt2sP?=
 =?us-ascii?Q?tK5CMZ28Li0lZm3w0Krf+SnJg4tWHLXsglDJfcAN9eU4aqxmxmL6uplSosLr?=
 =?us-ascii?Q?lOMT8HhaAQExFJIIXJdF16eBqZ+eqOkTPTHkH5+FMBNLelIcow8Xt2oSbPTV?=
 =?us-ascii?Q?BXeu3va/pLRrpAmT8eFn3kQMdxiP218M+aws3usZUDiVllI3JI3R3K6eEkgp?=
 =?us-ascii?Q?aPca6I7uLvpUcj8kC1NApGvVFfukd57m/1jiK0uMVwL8wGMcrqapKOxYe0L8?=
 =?us-ascii?Q?vEL9c3fhKH4k+zdyvDG2nUtNLp0stGAxRwkLsdeQhd0hjWHucoJxc2GA0Z3l?=
 =?us-ascii?Q?xRV62I9efq8R5fCRsgD3I0QWiijgEzdDDt5+4SSl8c8PPVv5q9lqvP+bfV05?=
 =?us-ascii?Q?nUiqjNjM7aTSZrUvssQX5ayluOQ/XIy92iS9QQLXr4I19ULfLUp1ZU9Jw4ky?=
 =?us-ascii?Q?jA7lA10nWdGhYDpgsvHf0xSAwcmOz8z38X3EZpTPvkqJ7a+25TeRpmmv6f3s?=
 =?us-ascii?Q?BfCHxfptPlpakmTMHm3b8Ng1EOz4VB6ENFqdU4Nz0wMWJHb3Jj7S2vzZbJBz?=
 =?us-ascii?Q?zaYgaUi88C812XDCUrRIzKwptJvccIZ4NGLMYJA6P+pjAai2sQnUJRzLsYyy?=
 =?us-ascii?Q?3+57Ih+XYmwy3qgUK8y9YV+5YnV1qy3XnWxux/i3xjDh4loPtlIC5sYRAsxt?=
 =?us-ascii?Q?7CXzikyvvFQrLt7gpU8PK5eS71P0u40G+y+IrxydjEy1Fmth5ny1xCc1MIji?=
 =?us-ascii?Q?CAADeR+SV0LEMNvZAsAAVZC74yMJnf08EJ/eFbTT+V9EvuaPbYdYqD1VlFaK?=
 =?us-ascii?Q?Vra2566PMm+KH6Zp1kqqmJKSxKcnYshnUBWbtARI4TrCYA4LjCekoJXyVfwo?=
 =?us-ascii?Q?pX+0Y0h52Hh2e9XP8q9FuAbb0uyI6LO/pBihQJIGeYmr+jsuTsWwsLG3KDeB?=
 =?us-ascii?Q?2liJdkphu7hFgzENSfjWI686CB4yJsHXlqKpKgXnuztewavmsJRGYeN0oRuH?=
 =?us-ascii?Q?9zSDaE/e0lrC7PthZOpYdN4FpSbNc8491I/g+eQ4hkmqzAjmfRWi8GKjLsjW?=
 =?us-ascii?Q?lnIx0lY7rr8+R0hP61srnro68K8ohkBxY6I0QcICnWX/1td777eyrPxZWyPW?=
 =?us-ascii?Q?rMd8QvKSv36bJRakcEvuwDwXhCHNQm2kJ2pVjDExTk+CqNuea3jUIy83jTTw?=
 =?us-ascii?Q?7S6ovB5OhPhA+r0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:44:32.0803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba68f5a-65bb-4b6f-1002-08dd54fae548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
For mlx5, the default is already symmetric hash, this patch now exposes
this to userspace and allows enabling/disabling of the feature.

Changelog -
v4->v5: https://lore.kernel.org/netdev/20250220113435.417487-1-gal@nvidia.com/
* Documentation rewording (Bagas)
* Test adjustments (Jakub)
* Verify system has at least two CPUs to run the test

v3->v4: https://lore.kernel.org/netdev/20250216182453.226325-1-gal@nvidia.com/
* Test adjustments (Jakub)

v2->v3: https://lore.kernel.org/netdev/20250205135341.542720-1-gal@nvidia.com/
* Reorder fields in ethtool_ops (Jakub)
* Add a selftest (Jakub)

v1->v2: https://lore.kernel.org/all/20250203150039.519301-1-gal@nvidia.com/
* Fix wording in comments (Edward)

Thanks,
Gal

Gal Pressman (4):
  ethtool: Symmetric OR-XOR RSS hash
  net/mlx5e: Symmetric OR-XOR RSS hash control
  selftests: drv-net: Make rand_port() get a port more reliably
  selftests: drv-net-hw: Add a test for symmetric RSS hash

 Documentation/networking/ethtool-netlink.rst  |  2 +-
 Documentation/networking/scaling.rst          | 15 +++-
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
 .../drivers/net/hw/rss_input_xfrm.py          | 87 +++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   | 17 ++--
 17 files changed, 155 insertions(+), 41 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

-- 
2.40.1


