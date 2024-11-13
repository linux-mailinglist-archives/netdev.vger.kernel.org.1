Return-Path: <netdev+bounces-144512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09749C7A95
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BF7282DDD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1C20650F;
	Wed, 13 Nov 2024 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OjuBQHDs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF220605E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520908; cv=fail; b=dkoeB9s3cIH5Aug3cJZeZPbscn+5WjHUioKYw7yZD4r7OQ4oBX1zyfuYqHqMolnk4SG4YUk/fn7hZ/8axbDidPnCjGaJjnQMVj5akrc2FNeAT+Nlk8fuSE8c7oPGoCYw7lPVaXuUqT4pUFEZts4HSA3fMUePGy7qLAeaOdWO34U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520908; c=relaxed/simple;
	bh=aip9KYTcX6zJvB9qA5/TDn3t+jUeNZ86SAVS5j0ZJEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDsf7UaGwEiKZN5cyGMhkXJtlLJQmaywr9BJaj7J9YinEoXdZiNhufJdkYuHcmPtHJ3ZI95iYZMq3We7a1F40ah0gEuLvPNH/sVK0ALI+lGASYTjGAtPFxvt9VfcWpIFs2zTG4XzYsCV4C/eUIxFQcboj+cl7iyOdqlpcBRhqU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OjuBQHDs; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlIN51ReVEg4OJk771jqD7nkund0KkwXzCwDy5kcY9cpYFH8Ev7zYXt86QInxcFic4QaMhRfXseKTlwdRhd7pKz/G55TZGV1jPShoWh1vxPoY9oJqkn8yGMIT5c7KAeT7GUgQteef5KZwfxvG+dc4Ocs0OKCHOhManTpZWAAQZOUuWSzJv/jl6bKInYCUiNvCrlFspZWcd+Tfm0hP2BFfHUI+90sNvO8yGpIW6EMMLKID4bIrvXmTrw/HkYWFvSW6zQHzBKNT32aZqXdsa7KSU2ZFvtETwjHmVM+Tsg6nfwxHpOhntKRPH2WiC9M3lLx1Yc1CJ9hPYTcaWUCvIvXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F11JG5zG1QS2Jly0zRQzyzYhaYBSbVzWLasAh/j+QbA=;
 b=ZMeB3B+/uF0FK3PNjG/faJVCUgXP45UoMGwMHipV/+mZvbPcOm6k+UddohOkrXTW57rZR/TjrtoxuBvfgUH3Fir/2ueWszaZXhNvqfhvsPhyBxjQkgJx+XakHN+vgDp9wo8LzksVgZeB3DAguDJGXQAsUnxgfQbmwdXRfiRXmnJ2FeX/9nBtKkBe1Ib5tjZxi9BN1OWvM5Ag5cNWe7mN/JHJg3IMRV//Pjp1UG3I43OmDbqHTynPsyIY1WcEIgvetkw6JG2ewcjb9FocMMfGwaPbHOY4thfYWJICdyFMnlKRkDZ6h446z1eSa6PbkCTfm1bkBlloezt/ouSMUAuweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F11JG5zG1QS2Jly0zRQzyzYhaYBSbVzWLasAh/j+QbA=;
 b=OjuBQHDs5QjnNZHb8dGqfiptcEaI+x/JqKr/zVwYYdCJbw/QvirzeP7BGa0DChcwK00n4nfwViwyp86lYjP7KloQnN9s53v2qEgzs7pILrC078KyilH6V1wOF89o72HSUGLdQbPu45GK80uzdGQ0sduk4QiHrHXz8vaIDzaAMroAXRHULQOay1UC3a9pR3r3p/47E9IzlYt13JryFTJCNIX/jKvDroAtZWZM5opfgT9t3GrJVkyKSYZwEcFgDmkGHHTlHG1Ani5I+HYZmsmKAwq8zDMtIxb/GNjBkeGa7+buq7DI4iuQcn9y7dUNNROxFp3XcH5D2nSMZnYUCEUAbg==
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:01:38 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::a6) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 18:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 18:01:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:01:19 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 10:01:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:01:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/8] net/mlx5: ConnectX-8 SW Steering + Rate management on traffic classes
Date: Wed, 13 Nov 2024 20:00:25 +0200
Message-ID: <20241113180034.714102-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d22a39-4ac0-4181-d31c-08dd040d385e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkQ4M3dVOHZNSmVYM2h1bVY5NWUrK0dET3JJMjdCZXBQcW1pb29GVktWNktS?=
 =?utf-8?B?eG85T1NtQ2pYOTRpeEhWZjJWanRRTHljZlBET3RDdTBDUFQ3SGdPNFdGSXZn?=
 =?utf-8?B?Mk9KTkswaDVSS0Nldy95cXpiZVBXQkI5cjhHZmtiMGh2SHEwWEc5TDBqbWtX?=
 =?utf-8?B?UDl4dG50eDRvdDdDaVNEbEFIY2lwdmpFZUlCTnZZTXp1K3FJRytldlNsRUZk?=
 =?utf-8?B?ZiszcTEwYzMwM2JhcFg5OUNseGFWQnh3K2RsMUdnU3hOZCtkZ1NObkFHS2E3?=
 =?utf-8?B?ZHRXY3E5VG5Udlc3S05USEM4OTRUT3VsUVJaSXFnUUJXak53ZVNLZmxCbnZ4?=
 =?utf-8?B?UWtzNDRFeFRtRk8rK1U5K3o0eGc5UnZvYmEzSDlFK2xjT0RoVnp1c0ZncUhY?=
 =?utf-8?B?KytEQjNYdS9QTFRmNUFCYkIxVmlTZTJwVy92LzNxWkdvSzhPVzJoczlkMmQz?=
 =?utf-8?B?YUQxWEpZNGxtVXBoeUlzVHUyNTNYcUZEdDZwYTlacHUySzl5TjR1NWZnZm13?=
 =?utf-8?B?RFJKQ1VsZERLOVlSdHNNM1BXVTEyazdXOWxqOTYwS0pGU2tqS0g5Nk9ZYU1p?=
 =?utf-8?B?dUxMSjh6SjRRZCs5aVZ4MFc1bFYzVmhZY041cy9KMEM0MVdZQllXQnF5SWhR?=
 =?utf-8?B?L2dIdVJCc2xoeU43WnZKV1YwQjc4RDBZR3h4N05SOWZVVjRFSGIyT3FMdXox?=
 =?utf-8?B?Vk0zOEZvZVhxZ08rWnZGQkdLQ2UrKzVuM25wT3RrR2Vma01ZYlU2SmtNeGZC?=
 =?utf-8?B?OEpNelE3UjVpc29xOXEwWW9CdGt4Zk5wOU4reVlreWRzdlFkS05aektycmxZ?=
 =?utf-8?B?Ny9QdHdIMFh5bGtJbHNOWnNOMFFreHlFcHRrZGx4b3IyYkJ4SmQzanpwYTJi?=
 =?utf-8?B?b2p2K1V4Q1pDb0ZxdENHQ0dWUk51SHgvSFU4NlVwUmVjRnJPZzB3ckRqTEQv?=
 =?utf-8?B?QUhpL0RQdVY0TTJLMHdiM0xIVFlPWmFpMVdhV09NZUVFMHN5SjFvQk5yNmNW?=
 =?utf-8?B?OE5rM0pWUlBHYUVxT21hSTdvYnpFV3lsU2lIaWFvYldZYjBHUlJwWTlzMno1?=
 =?utf-8?B?ZW1INzQ0MURNQ0lIMVFKbzRROVB3L1VKeTI3YWRaR2ZWSlNPbXBianFpV3JR?=
 =?utf-8?B?VUJCU3JxdkJGZTFuVjNVUEF0YjNRbFJ0R3UyYVlVNUFjSU1DQTlGY1IxKzBX?=
 =?utf-8?B?WUZGeGpoL202dzFzWVc0TVBUa1pnaVpjVDRnM09TTVhIMHdRd2xhZzZxVEhE?=
 =?utf-8?B?d01PTUxTYUw3OXhGUE1LY0NGMUlzandBekZ3ckVZMFFuc0NicTMwT3pzNjNN?=
 =?utf-8?B?VHlxcTg0VGtHU3dFQSszS3FOS0tyNTYvd3JnKzB0bGFaOUxoaGZ2TFF4eThs?=
 =?utf-8?B?UUV2Qk1Xd2VSWVlPWUUyeDlUclQxNk14akg3N0JjYVI1Z21RRUR0RUVoTURZ?=
 =?utf-8?B?Rjl4cm16MG5PNytPZ0htTTZzVDhOQllBM2E1emlVWlFMcDJMOXNsc25pS1ls?=
 =?utf-8?B?SXZTUkNnaEptUWlrYnkzRENlYnR3bDd2S1hwSHJpaTFDSUNERmdFaWhtMkty?=
 =?utf-8?B?cjMrekR1Nk9WdTJ2MjhXS29SSGpHRDNlYUczYnBPbnJna2swMk84NDFpUmtO?=
 =?utf-8?B?UVVsUU1qQUR2eGtQMEs4OC91YlpiQ29rb08yZUQxZmh1WHdvY0hvaXBKNy84?=
 =?utf-8?B?ODh2TlVCaW5TRzhYRGxqcWdUdG5VNDBId0ZWV1NkVklLeEdsMkUrMW1wdGsz?=
 =?utf-8?B?Qmo0LzNqVFNtbFJXdExMMUpuRWhPbXJHb2lmdjNOdThzQXB3eXVkM0N0N2Y4?=
 =?utf-8?B?eFRWNnFLQkNuOTEra2VGQnVETVZtMElBT3lrZlVEZGkvODV6QmZQVGx5ei9Q?=
 =?utf-8?B?YWxTYnVnQWozeXdEZnVmUzMwVk10elh6ejRWRHFXa1ZTT0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:01:38.1584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d22a39-4ac0-4181-d31c-08dd040d385e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

Hi,

This patchset consists of two features:
1. In patches 1-2, Itamar adds SW Steering support for ConnectX-8.
2. Followed by patches by Carolina that add rate management support on
traffic classes in devlink and mlx5, more details below [1].

Series generated against:
commit ef04d290c013 ("net: page_pool: do not count normal frag allocation in stats")

Regards,
Tariq

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
  net/mlx5:Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for new scheduling elements
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and provide full support for tc-bw

Itamar Gozlan (2):
  net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
  net/mlx5: DR, add support for ConnectX-8 steering

 Documentation/netlink/specs/devlink.yaml      |  50 ++
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
 include/net/devlink.h                         |   6 +
 include/uapi/linux/devlink.h                  |  10 +
 net/devlink/netlink_gen.c                     |  21 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            |  60 +-
 24 files changed, 1587 insertions(+), 382 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

-- 
2.44.0


