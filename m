Return-Path: <netdev+bounces-169764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CCA45A64
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3437D188ABAB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0D1E1E18;
	Wed, 26 Feb 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKk7bLFk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146F258CE2
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562771; cv=fail; b=odQx6IRiahucbYZyKN5qfbZ/FA4yNDyaxUt5nFhDtOxQriHmPIGQ+6KQ9xSFXNeAUFAAmWcmGRz9tF/oHz2fjZpXzgLqW6xutpjhS9vJ2GVoHL8BYKKEolr3iEzLu1agx6uWeVKkrAjdfz8D5SRHncXKg4Vj+TMl1qRmWfBAMnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562771; c=relaxed/simple;
	bh=7nxUJByDYx4sYCyzcWk6ce6yB2zi1f1GbB3V0wZmKgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OcyNYnRjXMwvvRJ2tumWIfQKDzZQEOwX5K/CX/QiLp57UhSMbTXHvJfsLo8KLj+qCLWR8QQFuaMg2QJTgZX5FsACIMvWxFm9ikVwuJRq6YhklugKJoOPJsISuX9z40Oy7+5lYUT1iwR49ojH57Xmhzd1lbe6Erbgy4evxoV2rdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKk7bLFk; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx5aeONOZ7p9PV59KEbYFlypsI21v66HVSOJQuKgUUDPbugsk7OHsS/nzD5+kf9rQZdoHdcIlSUMBcfrAotiMzdJw08bvbFHCvvdS8eLJwQAd9sBPXfe9sP1MWSbkmv2lHZgBY1y8GgdShUqLTNrLUxWvvqyBvQVwZB8gH1hQhmdRxaaFdZzSUkHjVjbECmePRKU5vahCLZ0/JKwsA06CFIz18JEbWNYLAgAQhL0sRWiCHYBLPhp30+sUpUDOAOrlv5CemgUTKYLXbtYIVudoiuv+vPctBwVoMdI/6CthGMuydsSdZqVW+MjeU17vMp0ByTctbSOBoxC8WiBZvNQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thk8bC9azETFD95SOcvD3HGuxdRRZM0hA9sMW+62GB0=;
 b=Y3TNquFHEk5gbOtBFhkc4bBJHnAlQhRxsQw1qM6i9Y8qL1gz7ybVU76UuKMry20GOi83fGyMqQW16gnEznIc07Fv8j5PVVrCGKqpmafE1yFk0HTs+5zt+ObMM/ou++l0vIwwfKxqv8he3/YAUjp85SQcfBp7wRHDWwEs9kGYRqYzaGTxTJuW0mTIjevR24A4rEsDfr1Uk2vwgojTGCPJWAP78MzDfgWm/S5YjvRZOiqHC9Hpr/hNjA4w9P79v2UKy9rekjh8iD7t57TGqDNggmH+gln4ujYUqDEYYDh+tPxTKogFddEgadSarPN9jOQ2KQttoI3O01HIedagN2VSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thk8bC9azETFD95SOcvD3HGuxdRRZM0hA9sMW+62GB0=;
 b=eKk7bLFkJ7EWq6tS4mxfVnzRVCbn4+AGCgy8OLGl7yr/A94BZBJHd6rCRF7LMnO/daYzyTGkDk4/skSxolEa2LXdz4mpz+2FJFcnu1kagQ31HPeOOjKGX1jMQ4DXzrC7QD3rLadXo4ZmKnk3AqCHM52m2GIMY1IkcKcHynnzp33fSYTqKcHhYz9zNEW8oSPayaDPHfP4B7mIH49uRnzi9fEbBRfoOnDQl8DnNJtFG41UrMXT/HSb4Fnsih9VCswEk2HBWdZtMNL+kPqpJVuqju7TTLavXmNIRd/WCk14iHIyQPSTsNjHUYmb+BcLH8j4O4LvRpKVqL73fxa3U6UZeA==
Received: from CH2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:610:50::16)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 26 Feb
 2025 09:39:25 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::95) by CH2PR16CA0006.outlook.office365.com
 (2603:10b6:610:50::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 09:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 09:39:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:12 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:08 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/5] Add missing netlink error message macros to coccinelle test
Date: Wed, 26 Feb 2025 11:38:59 +0200
Message-ID: <20250226093904.6632-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: a324386e-54de-4bda-9d96-08dd564974e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOsbObLAGkk5TilKtVUqOHjDvEU8rWfJoh15HajbF2FvcirxD6hDJvBqcaSG?=
 =?us-ascii?Q?08MlDM0FzZbWVeLSXQTqXLzwFnBpkO5hcoRkgphfrFlZdCqYNmjxMEKbuu3F?=
 =?us-ascii?Q?RDEmp5J9IG/c8/rmfo2DX6StrpYsmfEw0wjXzLqUdIBo5oy8Wc78wcB8VlmY?=
 =?us-ascii?Q?W67p+6+q5W8YXcnnAhLh5IIbBG5UhLwFubXIr2wXuVZKFQpG5gXGH2y/k6b6?=
 =?us-ascii?Q?D9HOq5J1DbZvu8lbj4EqztlNbBfVd0Cikk5FSJ2I4Aujer7eusgO5GjFMfgi?=
 =?us-ascii?Q?FuYYGTjtp/dunF8QBegsuiisClxKVILhCBJjRyeUxaxVfw2kTUcVp1Ds7vZW?=
 =?us-ascii?Q?jptixxIj2NNLlDDBYLi+S1aCpiPkNjiFKpyxtWuZS4gOT9EVj+MyjIL17AQ7?=
 =?us-ascii?Q?8s64jUbaArFd46EDqPTiNUkZA8mMKnHVEMB2eNs7K2EclPNJUErLRNhfhygv?=
 =?us-ascii?Q?DllL2wVnaWXB9SGBBtEW3k380MrBc9N85iO6W/i76Tc0joqfWfFUSXzexRVQ?=
 =?us-ascii?Q?ve8sMvoYm4PVQ8qrv9KiTYizr4BUrn35vSIN3WEtvDnjIOLr4gVOEUz5Ik4D?=
 =?us-ascii?Q?0WThdjFoQtiJ856xoEFUnIND2j1ynJ4reOJ1F5LeNgyPZ+aDdo0shRptNgZI?=
 =?us-ascii?Q?fqLVTjNk6k55GAqy/Ys3Nki7wHedMIYPdf2HLZRjWhfdr+Lf6fEX5zytfoF3?=
 =?us-ascii?Q?uaeee2dZ851eEQUqX0e07T78dw6C+ie4OlomGZwnFkvAkDfqymW+d4qBOAVD?=
 =?us-ascii?Q?Pdo8o1N8COF3OEUQ0luBbZjB7NMR8c2Za6lBGFY97dqWqVovr5z/LUfXVdRi?=
 =?us-ascii?Q?1kDJ76OtKwAsPmYnb6h6+CSU4REjNS6E9j1GskiURNWRNUOslfasCKkvndA6?=
 =?us-ascii?Q?C246+Y9XTvTs31GE44yQV4QuGCamc/HuDYCSjt2cp8Elqq2jlZJ/OyK5uuCN?=
 =?us-ascii?Q?Y7+syxHaSjNoZHLpu0b1FOrRikw5bfl2yLwRusVXbmkuF9Isct7UFIhHQBON?=
 =?us-ascii?Q?PhDjBx+dW7bUMPjIeoBRs019g+J1Dm7InTl8eLzZHquON3Ys4F1gWLAhzvAR?=
 =?us-ascii?Q?YSkJ9OzrkIPs+tL+N+8/DFXJYcMOLO/yzU6oUpeILCBqo8honHflg2CZbDNu?=
 =?us-ascii?Q?OKubeWB0qRAwLsgOOMcFE2oL9mBs0OY+OhNVJ2bXnE0FFvLcCXmPZNQqjnY9?=
 =?us-ascii?Q?wSMFdviEXH4mq0C9p1PYGNBqSs6FZgwhT8FO5fSBq58TMU9HHQFQ0BVMdpj/?=
 =?us-ascii?Q?+7jKE0wG4VFBd/+rFkOrWtz4wTZU5ZIOi3FUmEopE74/wGdx+caA9XjNiMyp?=
 =?us-ascii?Q?JNXAFXG0Xx0SkNcfyBJdzPwNqzFKvvLB+jcoSHHeA76avGIr9b72nsz1yZiV?=
 =?us-ascii?Q?Bsyw84lj0XDGmMapA5kz5ZgjBrg5voircFJa32je2lA5HLYz5SHM620sbMgE?=
 =?us-ascii?Q?u9yqLo2DFcxg939Omy3N+9cXbxw/4xs16xuCUphoZh9WMB0I7QgUXiHhqfsp?=
 =?us-ascii?Q?23JMLiCaR7wcmrU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:24.8162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a324386e-54de-4bda-9d96-08dd564974e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195

The newline_in_nl_msg.cocci test is missing some variants in the list of
checked macros, add them and fix all reported issues.

Thanks,
Gal

Gal Pressman (5):
  coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with
    newline test
  net/mlx5: Remove newline at the end of a netlink error message
  sfc: Remove newline at the end of a netlink error message
  net: sched: Remove newline at the end of a netlink error message
  ice: dpll: Remove newline at the end of a netlink error message

 drivers/net/ethernet/intel/ice/ice_dpll.c          | 14 +++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |  2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  6 +++---
 drivers/net/ethernet/sfc/mae.c                     |  2 +-
 drivers/net/ethernet/sfc/tc.c                      |  6 +++---
 net/sched/sch_qfq.c                                |  2 +-
 scripts/coccinelle/misc/newline_in_nl_msg.cocci    | 13 ++++++++-----
 9 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.40.1


