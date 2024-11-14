Return-Path: <netdev+bounces-145080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC1A9C950F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A668B26709
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AAF1AF0A6;
	Thu, 14 Nov 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TuivwSWc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DC1AF0D5
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622259; cv=fail; b=TXZGwB2N0HHx+NuakhF+BI1xAu64zKA7Cn6HbICt0zWZgDkfTki5Dr3VGVYq2Dac8g5q7Nl+Pqv/rCEov6P/nsHnG4zrOumhZf7qNVXss5/egt57oPuWpls6zBeyK24Dfmu8+fxg73A8QPR5JcjdXYLISg7tPho+uY/9elJqUyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622259; c=relaxed/simple;
	bh=ljVKVk/tqxkcH0ByA52qllkFc8bww79W15J2eMaTJrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbXNew68PHgoqXKh7UG/cLgcbPnAaChRfai0eUMtvO9UfctPZAFsXDtsB+dJW6TU0/UPyzhJh5PPE73S4iYLhS2f++4Xz1j3U664y93GoGnshK3yezqTKscATtWZxLv0ygMaU0ntHa/PG7otgRue7MglrYWiSy2k4NLJXkxisKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TuivwSWc; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExZGzS32jBG3TvTk6ddHca7k4H8fy6Wza6GXyCfzE0ahM63HAdP9v++vd6YzoIzSUmxR+hSa8f73MGkdUUjADDNVzt/XXRSMYVUV/V+C1dJIOzCPj3k0u725hNKYWXDhpfZ8yZPJ4JIHoTwFBTIxdBn/SROy3+JeDrDagKQK9dz0g0aYodYxZcmxqnXaemXWmOk7IYKbWYALcbOOzq3dkjKvBbnHcqseelQcDaxMeB5+6ttnrnq3fS5IbIGNv+k5YlGils+INTJNzOwCcvRAnruO7tCCfv6ApuKy3xN9iX8X375nEgT20jlPKedP/ZQrj0BMfVRvkvITkUFev8X+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/LqjTm0bb+U6iiLg2Nedf/OTD9/Wuq7EKK2+RbGmCo=;
 b=WpGDsUB8nC7N5/XaTY19GJI7uHO6MS2f6PbG37hXg+QKuR+doJcJw5bcukJ1dH5V/11VK8olV+KPQaBq22k5g88bXATaSfKa1wIfI6zCvxJjYt33Cmjvzo9efwgmdSYCanq2aqY/20/rymMp///j/Pi62Hl/f+c8eTFcgYjknUxMSxrhI4WAqP4VMAUjdYmbRdGlgTzX4Z7Bq66goU0EaTcZncZRMPyzF4Fpb8siO+lDPqRF+9n9vnX5kHPRvS5vUWGciGeFeHGv2KRZe8+qkwAZzm32a9OYzVoUKcii+HMIhXI+Uhqp8VZfAWscqRWhyYJmk4+eh5ohn+LogcvKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/LqjTm0bb+U6iiLg2Nedf/OTD9/Wuq7EKK2+RbGmCo=;
 b=TuivwSWcWa+yg3uEZDTSRgz6QSIbJUxP7QDP0afBiFkGFQQyDNDCvgNuB3gDSJrmm67VKU7tm+qgaIP8KMdqy3G3RY5arJ+0QRXOZowyRUAhJRhYBgkkunmgNxKdYwOVxymR8n2SeD2N+3vFMGHpgRLaE9JLcRLO/dMxl9lDYBF/1p+3LYGXQSD9thzsTFFAYXMXXN/ysd1CSt3wpdmdQGtWAzJjNFdDGXZxcClayaVPWbGkaEUy0jpSQvpkngNvyNLVrcTvqLbt51oOkcY3nB89ZtPLKA38xtXoqBJ4tgxcoKVgFM4knH6irtRMiI+NImqxLD+X6mkDic+1HqvF8w==
Received: from PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::31)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:10:52 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::8e) by PH0P220CA0007.outlook.office365.com
 (2603:10b6:510:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 22:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:10:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 0/8] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Fri, 15 Nov 2024 00:09:29 +0200
Message-ID: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4030a07d-e31c-4bde-d0c8-08dd04f93392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0NhdXR0eDJsK2x1Zy9LTU5mYnRSSUtLcDJKdEFvVFFMYloyNVAyNGVPd0ho?=
 =?utf-8?B?Mjc0RUY3b3JSV2NoOC9mMlVnelZrQThlUk9PUXpQemNZOFZSTURwMkhSZDMx?=
 =?utf-8?B?djFQbjMwTUFXNENoTzB4L3BOdjExcXlpQjViSU5GYVJsdUxtSWlqUXVISXd4?=
 =?utf-8?B?ZkhQViswVXl2S1h6OEl5MDJENVVMYnV2dm1XeFBZd2s0ZWxLRGtQenFuS2xO?=
 =?utf-8?B?UVZtSmpIQVJHNTZIYnNYNFA5NEVWcE9WQldyVUZ3Rkdrc2ZuV29KSzMwR3ky?=
 =?utf-8?B?U09QOG1DbVVNWWJQTDR5UVdHSlpmZmpCalZSYlFEM2EyTmRURlZ3eG02L1VB?=
 =?utf-8?B?dHFLL1puYU4yejhUOEdhbnpFK2hKQXBZdDFDREZRbXQ4Y2RuaWF3MWZuamhC?=
 =?utf-8?B?Wm9zT252SU9HRk85RzJpRjZwYi9TT28vakRDZ0RiZ2xLczZpeUhLQmRSbU5q?=
 =?utf-8?B?VGdxSXZGVkxWNHRENkMxTVNCR1hseDJPV1hJVVBjbGgwV0dUSENtOGVyUURX?=
 =?utf-8?B?Si85VmpUdGRta0pSM3ZzUUdVVmZFdXNaK1IxdmFsT2N6dVlZT2JZTmM2QXlD?=
 =?utf-8?B?N0ljOTRJZnQ1aVQ2ZnhON3VRVHhhS3hCR2UzZGNBdVM4ckVFMnVXSWZkNkhx?=
 =?utf-8?B?N1ZkRHVPTTBGdncrbzNmR2RzbVdXMmtmbHF5YmVTKzNqRDZUeDc5S3o4N3pU?=
 =?utf-8?B?VlFmRWxQNXZqZkp2N1VXaWh2a1RMYjV6ZlQxN3d1U3ZqVHFveWRQckthaU9k?=
 =?utf-8?B?T2svbFF4OFJVaGhuZllmUjdFUjNlWndIVHB6WFlyMVExR2lJa0lWeWJuM05Y?=
 =?utf-8?B?d0wyczB6Ri95cmFORndCNlY1Qnl1K0ZSaHpHWDRPckJjbXl3aVhJRS9sQnlB?=
 =?utf-8?B?dU5ERkVSank4M1puWXpQdFdyRS9jTjc0SWhoai9OZ3ZnRzNtc3lUMDcxZnQ5?=
 =?utf-8?B?ZFRLbHlSSmdBYzlFRy9USTlid1RLTHNpZm5mZmtHVitWUGNEbHg1dWRNOVhQ?=
 =?utf-8?B?d3VmUUwyZFBUN0hMVkw2RWlNM3NxeU94NCtDdG5Hc3lEbnRoZC9EMHVKQmRE?=
 =?utf-8?B?SlM5UFZyUDBxWkM3K2M0bjFWYkx5NzcyUWZNWjJrL3JXQVhTMU4xK1k3cjBI?=
 =?utf-8?B?TldDQ3R2YWM0cEFUYm5ZQlhQa2E4eW1rRGV4b2JTL2N0bDFGZ1U1clFjOWFQ?=
 =?utf-8?B?a3dPazRHTWppRmNoaisrNFhQeEViMVNEMlhraGtrV284N3c5UkxoTWx1Nnls?=
 =?utf-8?B?ZUFvQ3d3dHZmTnpKWkRsSkt6Yk1wajVMbTBudnl2L2VacTlMV1l5dlFVZFpS?=
 =?utf-8?B?MDcxWUNkRXVFRGpZRUExNlRaL2VQZElvbnVNRnBQcG1MclNiZEJ5YTlDcmZy?=
 =?utf-8?B?aS82bFByYmxNaTcvY3JGemdmeFd1OHVMVXFYME8zVEVySElMM0hDNFU0bC95?=
 =?utf-8?B?TVJINlB2bjA0bGFXanlWaDhTS2pqeW5pRUpXZFBaYVNWRFF5S0pINTkwam1D?=
 =?utf-8?B?b0FKcGRaWGlBT0t3RU9tYnpmYzlkVVFkcWdzYVZMSEtCd3ZPeGZkSVVjQ0dn?=
 =?utf-8?B?MllIT2dOR0VBUjU1L0taQ1ZFTGU4akxYUWcyQ2ZOV00wd3VVQlNtdklvZDFo?=
 =?utf-8?B?VDIwSUdoSDZGeHFLbFRZdGpCRVNrYXJnSW56VWYyVWhIa3lidWhyTE9KWVp1?=
 =?utf-8?B?eUc0QXhGeDkrVkhSbWc5Zjk2cW85YTVoaTIwOWdHZFlvNlR0YkhzWFljY0h3?=
 =?utf-8?B?a3h2WUhMOHRpOWFvYWdQbUtzSHRyUmt2aXJwMkgvcFdkaWMzQVl0VTBUbE5T?=
 =?utf-8?B?UXBxeE9JREFTMmdhMUNXT1Y3Q3oreXA2MnVlYjNYYktCb0JtSmZOQ1pVS3RJ?=
 =?utf-8?B?OEFSSHIxVHFWalNabU8xcm5DenlpZkpoMnlXa1F2Y1MrTGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:10:51.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4030a07d-e31c-4bde-d0c8-08dd04f93392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

Hi,

This patchset consists of two features:
1. In patches 1-2, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Series generated against:
commit ef04d290c013 ("net: page_pool: do not count normal frag allocation in stats")

Regards,
Tariq

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
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/netlink_gen.c                     |  15 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            |  71 +-
 24 files changed, 1559 insertions(+), 382 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


