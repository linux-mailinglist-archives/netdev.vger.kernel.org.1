Return-Path: <netdev+bounces-145674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1C9D05EB
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C891F2183A
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFD1DC184;
	Sun, 17 Nov 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="in800z8e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72D17BB6
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876712; cv=fail; b=FHAur2rQl/T/rTBg9A2xHm5USe3zC71YffRQKjPx1UXiF5LaYp+TV4+hLy7lzRveN3Ngg8eNk0Ov0cZ5wsGiNp1eHRTjIwodAnGUP2uQYYl6YGh8oBJTKPyxi8V22YtOSkX+TkSUkEWAIhJCvdsyaAessO6MS/0QBZFBdp8dDLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876712; c=relaxed/simple;
	bh=ysi4MP5sMeol11Rd37b6jclpm1pPV8vNGhjw+TvLwJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UCluBi1ZnbZ66g3/XJXFem1OUBAOgpi42XolgdH59I0LX/BmisCMSgTxS41rrWkVfj3Lb0o7o7ONBkcGEawYRCuw/Lj5YwKHtrd5RzQYWiOTD7tQGlDkxxhFBLYq3jCTewPh4q2rQrakc1cVQWUaxw7kwfZtsI1KC97Bvx5Dc3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=in800z8e; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYjAYlkmgLpjyDnhagNopyglzDRIjmiIyNE6ZukjTDam2U3RyQ9NwRupXZ9RdRIyHLAbfDJbyjfz0ZrSNJqqHx3oDxVJJ1IXHa/9YBnT3zUqPn70kcL1HFuq4tCeDPz3BXb7gqiilqKhCqjie5lswfThzfSETP15c5Gbhdb702fy4ZCNOSNz1coKqSTOjKjjhF3Fv7DIhFZevXKDSQbLgWzEpBuqiyHdEAKzqB5Ga0dXUoAjceIEp5ae0JFkaGDfIn8I8ky8JyQ/UpqpGJhs1xrzOGU4fdhzeFKWBGqmE2CIZw2QK1xIkMUNjOZ9bTr1b13SEfEQNJEzIpxoVNoxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSug5B4nilrnJ3x3YObpTh9VSGBNn3JaEbFLbVcgeEY=;
 b=bdDT0YOwSmaAGLdSMt4fix2W9AJv3mHB0+K/jIStNUMDKPPy0ou5vsij3Dt4959AgU0wHbD8FTrD8GfK6Uy9jcLWIZ7VLw5qj1oQCzePtlBHLczxY8crhS1Iu61Uo73+eglvXDv15TooObxOGTdDk4rNjyCVjgPvVxODSWX8Kgjo32nZqhPF5Z7GVBexwLbMranUxji0JzYdr+iOZUlTLFxyXRWLdf0LDe6HQCwZUiSLWkydyLd7gLQctxC7YrwIvwzKl3raTRqutKmVNt6GsVHutYdipLVay7P1zx0AcXzZ9BzuwVd+e/u+pv7Dt3Ps1F2wdwjcsliEUt0AqXV+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSug5B4nilrnJ3x3YObpTh9VSGBNn3JaEbFLbVcgeEY=;
 b=in800z8ey6HNAvPEoTaneT+GCZFEURyn1qmGyuTdcFnttllPyDXGGyd8vE5SwIbk3Ydo17BXf06JVcYNKSfTT2FlsJwEvl8V05hq7i7nt5/OpNflagCgvLB95DHagV3ficFmWsIlhAd6jJ2+QKq1f21k8sdKv2/HIwSUWedcXrGH+RXw2UPg0prM7+GPF6tzANVdJBw/p4oaldP7HYCeRdw6DC1gbq09Iws21YbOSLRjv9X3M4SkFvNk/SY85whlKAteLTrV7ToBe3KM7apA3Dh+//KeqfHArDhoyd4O9htjR8/LdPSxoq6sst2zDn4f1A/xo1B+HtrYqRMno4r/kA==
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sun, 17 Nov
 2024 20:51:47 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e9) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Sun, 17 Nov 2024 20:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 20:51:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 17 Nov
 2024 12:51:45 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 17 Nov 2024 12:51:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 17 Nov 2024 12:51:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 0/8] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Sun, 17 Nov 2024 22:50:37 +0200
Message-ID: <20241117205046.736499-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7084fa-aae7-4d8a-57e7-08dd0749a692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elV2c3VzV3ZobnZYV3NYLzc5QXNnSmpkU01tZVhhT0tRdUkwUkExNkdMRHpM?=
 =?utf-8?B?L0Jhakd3MXAzMmZSaVRxK1J1S0o2QUswb090Z0t1aVk4VWxGeC9kU2p5SDNB?=
 =?utf-8?B?dk5GNFlzcWxiNGk4Q3NOVS9Mc3V0VUlPcW0xOWFaTE5Va0lCLzBSYi9XdTd5?=
 =?utf-8?B?WWhIM3RMZXpZcHpFZEFjUnVvUmJKRHRQTVcvd2p5Z2U3a0sxbFVteXRpMkJk?=
 =?utf-8?B?YlBtc0FuU3lTcjBZYmNMcnFVdFZGdEkwZzd5SGNVWm5CVlN2Qm5ubDB3R01J?=
 =?utf-8?B?TXpycEc5SEYrazlBVFRIVkFudjlxaDViOU8zTVR6cEdCZUhRQkFTcmlVZ3Ix?=
 =?utf-8?B?cTZEYmVyZkt0amc4cVZneGM2QndrekF0bmVOSU1PRzNuMCtWRW5TN1ZIZDUx?=
 =?utf-8?B?MEFlVzA5MmkxWFhQTHRkL2tDWFZvNDlJOHlFaU1ZTmRBa3RHcGJ4c1Q2MU0r?=
 =?utf-8?B?S1hRR2lpOUt2TUhsZk5sRlJHOHpBZzBlM0d4VFAvY2pjeU1rK0dBU0dDNVRu?=
 =?utf-8?B?MHN3bUVVT1MydU9oSlI1ai9xQkhvRlhuOFgwdVcxRVdadnZhY0IvVHZHTkhJ?=
 =?utf-8?B?UFdlMmlKVyt5MkhyaVVNQ2lCWHlQRmEzMFF6bnFncHVrbS9DL0RTd3ozRHFv?=
 =?utf-8?B?QVN2c0VmME1aMmg5ZXkzanJGcDcxRWxjYmc0eVlIRHkvR0JSTW90NHhpUGww?=
 =?utf-8?B?WlhQQkE4ZlY3Wm52cW5XaGRLZHJiVHp0SXVsU3F6Z1R4TUlJNCtUNGt2RUp3?=
 =?utf-8?B?bW1kTjBoV29kSDFKaWhzV2VqYU9iK3VRK0U0Z3o5UXdqWCsvdlZTTlZKZk8y?=
 =?utf-8?B?dUhUbGY3UDJxVGdqTUFUVHJDNHBYaGJOSkcrNERWRVY3NFc3bEllZ3FSTHlx?=
 =?utf-8?B?S0MyLzhPb1VQcjMwZmpOMTRxTWp0OVloejZ5QUg4UDNUZjZhV0U2N0VtQkJs?=
 =?utf-8?B?alFXZThvaHFNQmdva2ZENi8yc0c0Lzk0NFI3dENOdWZUYnhUV0o4QTlFdEkw?=
 =?utf-8?B?U1JzUlVXQVZVd1hzTXRRb1k0MHpxS09pVkliR2MvTi9yOEluVzVUMlIvUzZY?=
 =?utf-8?B?SWFZckMzam9QNDNsZlREUmJrZENTWFVBcFF0akowdmhhd2hJVXZZL05iYXBZ?=
 =?utf-8?B?d2dIOWxlQlgxWTZWeHlzdytmckxPdlBuUG9xNUJFK3UxQTF5a1NWSWYzcWd4?=
 =?utf-8?B?aEpkbm0rZEZ4UTc3REtJcXRyUExMK3JjaXRjOFBNVE85LzA2U0Q3UlY0N1NW?=
 =?utf-8?B?ZUVHSkZTS1N6d2M5SnIrdXlRZ3owd2hSdk9BNjdWQy9kU3AxNEx2bndtUk40?=
 =?utf-8?B?ZjNmY2pmeWd0VmFqS1E4L2RKeFRIWFZ3cmlzL1Riemx6aUNtb0FwOWtTeEIy?=
 =?utf-8?B?ZzdkNlVyN0FHRXZrQTB3c3N0aVlxSVRLcXlEZEs0RG9VcXRTZzJHYURJK2Nv?=
 =?utf-8?B?akg4Ry9ZSTZCb0c4QzZBVGNVUWdPZ0NoMTdIRlc1YkpxZE9GOXpObDA0dUF0?=
 =?utf-8?B?Q0RaWTFkZDF3M1JMSVE3aVl0eE8wL0xYZ1BDdlhnN1crMUtIWnpodzkwNGZN?=
 =?utf-8?B?YlhYR0VobFovMHQ1Z3poNXVlTTZvYUVCVDRJc2VjTm5QVUpvbWNETTloRG5V?=
 =?utf-8?B?Sk1IRWJsMGNMdzluaXpEdU9Zcndtb0lxdlowTGtCSzlmMWc1K2tkdy9aZmZ5?=
 =?utf-8?B?QlhCU3RBSTBuT1BSTko5UGNuZ1ZLN0RST2hYU3pHVk54bHJQMmhuRlJHbngx?=
 =?utf-8?B?cEFRM2lNd2IxUm9haEsraUxvaEloODhDbGs1SmpxRlhCQUxwSVdEMFoxT0Yw?=
 =?utf-8?B?K0VTYmhpMXNOUis5bW96SE51UGtoZDRwYXlZNFpoRnZqT2p6NzdrRjZwNzRN?=
 =?utf-8?B?QTNjQ3lKZHBibVlDenR6YW9HQmZFVGFUeEw1Uy84S3NTdXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 20:51:46.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7084fa-aae7-4d8a-57e7-08dd0749a692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

Hi,

This patchset consists of two features:
1. In patches 1-2, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Series generated against:
commit ef04d290c013 ("net: page_pool: do not count normal frag allocation in stats")

Regards,
Tariq

V3:
- Dropped rate-tc-index, using tc-bw array index instead.
- Renamed rate-bw to rate-tc-bw.
- Documneted what the rate-tc-bw represents and added a range check for
  validation.
- Intorduced devlink_nl_rate_tc_bw_set() to parse and set the TC
  bandwidth values.
- Updated the user API in the commit message of patch 1/6 to ensure
  bandwidths sum equals 100.
- Fixed missing filling of rate-parent in devlink_nl_rate_fill().

V2:
- Included <linux/dcbnl.h> in devlink.h to resolve missing
  IEEE_8021QAZ_MAX_TCS definition.
- Refactored the rate-tc-bw attribute structure to use a separate
  rate-tc-index.
- Updated patch 2/6 title.


[1]
This patch series extends the devlink-rate API to support traffic class
(TC) bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally the series refines the QoS handling in net/mlx5 to support
TC arbitration and bandwidth management on vports and rate nodes.

Extend devlink-rate API to support rate management on TCs:
- devlink: Extend the devlink rate API to support traffic class
  bandwidth management

Introduce a no-op implementation:
- net/mlx5: Add no-op implementation for setting tc-bw on rate objects

Introduce new fields to support new scheduling elements:
- net/mlx5: Add support for new scheduling elements

Add support for enabling and disabling TC QoS on vports and nodes:
- net/mlx5: Add support for setting tc-bw on nodes
- net/mlx5: Add traffic class scheduling support for vport QoS

Support for setting tc-bw on rate objects:
- net/mlx5: Manage TC arbiter nodes and implement full support for
  tc-bw



Carolina Jubran (6):
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for new scheduling elements
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

 Documentation/netlink/specs/devlink.yaml      |  22 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 795 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c  |   4 +
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   6 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  19 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 +----
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 +++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +---
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 +++++
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 +
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 include/linux/mlx5/mlx5_ifc.h                 |  15 +-
 include/net/devlink.h                         |   7 +
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/netlink_gen.c                     |  14 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            |  71 +-
 24 files changed, 1559 insertions(+), 380 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


