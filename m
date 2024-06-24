Return-Path: <netdev+bounces-106016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2F9143B8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E486281E68
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62031A89;
	Mon, 24 Jun 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OC/Z/XGV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6383EA83
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214282; cv=fail; b=iihVan0Bcxam8pTSyX9w2gduTQDMEMb+8K/ux160EfppE1yyuY796L9joSbPjO50IjcQ/xh7adYnJxf7wyaV9J6+Tgvpam4hICITcLDHZz+r9DHBxZOjqubfypbdA++7nQRmgdue7rEHlcNdu9SAQj/089oCDEwR35lxSqsBuv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214282; c=relaxed/simple;
	bh=AhPdjCIcaPffA6W/Sj/97r1r1CaTqLDe6+7RrjfSvTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZUgEsSTP9LMZzjZ3CTvwj28KwMc1SrkeMks7JdDjOkrLiBY77Zw02aD61/GuyrGi1ZzinZEecIM9T76Xu49w9ozF2Iu/l/E8EdDDlzpolyNlw9GN7UuxJi+9LAKutw32cPzyF3kcekirWwXljsQeJmG7Kk9gjpKvW6muHpYJAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OC/Z/XGV; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXkggDLX+OQUixuXr0UdkQr1nUd/Pmqc4q3lIJGYhembSzyjmp3Smb3z0EzgxHB87ToiwhhMwlzd1cfEhDZ/1G76/UR17Qvb3bOUH+HrfRpJmozpmEUK9pTwj/4Tqwaf7ck162WOUTFqeH4EmkA6rWV0JygU2btfmUMthNW9XlYQRl0bqAhEBzAynfFysl0nzG+cQdwcNxedXchP165i7HwwpzeXAsnAl3N1fjVPNTJLKv3rlON6eIOjSBxTE94zHB0zMAElikX5ece4V6m/oscLXx/j7OrLxyhmmDyvQTKVbz2UhQhIVYSo74cfwXMVjmrHz/inZSQltuu/S2zMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWZ/GwuO2nCn11CP0qQqolhiKIKPasA8kMS6vvAmL4g=;
 b=BfYkkaryO1MqcqHEA7cj08wISYQMODPiFemQNABFG5Yp9HRyoTkzeXPEMdA+l9pjvOqCRGSJsJMMkcYCuPErAOMPbzOU1y1BNzs0It7VW4hzNbIbYNIoYxqFdAj4SGzxepd/VyomoaDdkC8VQKkv3Q0X2ZhVFEgobsgDra7fASiiVf14WzxArIWj0dfsdR4OWa7DKSsadhvLG0RzzT7vIkVOexvoOTi8FeGY8c45AQD54LpgkpH76sPadgNZl0ThX2PN1Wnm8iul5WUsO0zYbDsDhxjoXnslWW11G1IUG/1V9S+b2GnPAADaLw7qNdlMmRnE9WE9RagggfKhr5XW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWZ/GwuO2nCn11CP0qQqolhiKIKPasA8kMS6vvAmL4g=;
 b=OC/Z/XGV/PO/VS5Qsas4fKVnS8MuZbUekJrwa6xZGT/Y0rYi7jC3z8Vi5+LPEVkTGAww5R+gPCLb1v0mhI582o54NEQO3g/pGgTBpFwWts2bNJMrWXl2eQJNkKjnJ8QiRns712vCrDi4PoUD0Ty79/7ljmR9DqVs9iS1zJ9Xh5SrNtUbKcSFDw2HU/GubqKuCXqLrwEAJrfd9LrfvhPqbqvNMWzpzr5NcgUamOMYsrXuRQjHTBcuFi9i9B1iRZ4kgJQPNlf89IctL4cYUcUEd553eccwCfrqi2XbkopJr1Ph+KhUf/8Mu+jL8pgBs3/L/2ZQmGNFrTcDOdVX1HWenQ==
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 07:31:18 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::5f) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/7] mlx5 fixes 2024-06-24
Date: Mon, 24 Jun 2024 10:29:54 +0300
Message-ID: <20240624073001.1204974-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1a0700-73e6-4d8a-68cf-08dc941fa292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zedqKv6GJilJ2mRHtOKDubcu6R8QP6SaYLCLLwa4zw5MROfDIlKH2cA2Vg/h?=
 =?us-ascii?Q?mbMqN++A2KGvPOQJKk+mcN1s0fLLxk4ChlkPp7+qRZ0v7mjK4TCZ9ribPk3v?=
 =?us-ascii?Q?HV1jsbTS2KMzJFBBSNGHwmL93Hum3NyeT/B84AZ8f4zluIspWCDOu3afSWkZ?=
 =?us-ascii?Q?ARy/DH2exzqINWMAMEa7A90ErQYNLFLcqryA+nSIF3c4HRzF6tg5LH6e6Sux?=
 =?us-ascii?Q?BDv86wsJPdKq4NAS8AKGzC8wXGb7SVtUqqxaHER0ha2cRcr82lmSl+GeVmw2?=
 =?us-ascii?Q?QMoC3T50SxYCpSEo+PsBxerKEYCrSP13V5C9IUTq4Jiuxj5MMCP6o+qMjagK?=
 =?us-ascii?Q?KQlf8XOs6QqePM/GTmoVtcGsgSsGIOkF4vFJ4t3raZCJ8d1oPDiZEdQdvBaT?=
 =?us-ascii?Q?S5+iigH+5PZ3scf1KO2pHOCtziIlB8qQ++4mXuKUAvmGs5bCUF9UHDSrANhB?=
 =?us-ascii?Q?shgql/MLTmJefSa35Otl31OffIg2ptzHMtS4JOmSt4Y6rv0jYiLqcJ4r6oIu?=
 =?us-ascii?Q?U2+YqfC7O2ysZVRMm9trY5AYAn6MHYPnFqAQzu0EL7U7gd9zyU/8Ck+gegNc?=
 =?us-ascii?Q?OOtO+OSb9XUITrHgQKtkVmhP5aGXG551muwXNCxjvtwC9Pxnj5X6d7ZGWxbf?=
 =?us-ascii?Q?OtfbRAPtUyqhjUf1U9Qo85/Ev9rAB9SSJptseiucf9oMNI5K2BddDXkV/uul?=
 =?us-ascii?Q?Sfsq2ubMi57vJwZiuOMiYFVcetrVbQi+oJ/tpi1uqf82T8I/Y9wQQiO2F/2h?=
 =?us-ascii?Q?6nsrPZ9p24YvcWxyS7vBeC6zcHkd+1Mn0qPrU2CDuV0OlLmI2mq1ofNJfj8C?=
 =?us-ascii?Q?5/e845jphnF/xsas20xI1vLebZONtV3tJ94dvfc+oiKQGQNAewvr/JQ+NgGc?=
 =?us-ascii?Q?uBDG7fEAzk1lxe2zlwk+xL3rLx2TEuPvJYae1BHbwVNdfpWff+KggWX/Hozb?=
 =?us-ascii?Q?rOppw8kXBmi830AXLbIpZ03YZ+rAJDY7ba35f8VZ2BDvm2/HsW2YNIlNkwq5?=
 =?us-ascii?Q?X3pJJKf/QEGFrqYtvFZbcYh79FmuJM60Y6Qy+320DSx4g789ka8qhNvapRcZ?=
 =?us-ascii?Q?y7KmAx78SKDS5D5a+PwJLEBLvi6UYL5VkKBW5v2vuh5ITBN70J0XKMNEnTdN?=
 =?us-ascii?Q?i6g+MGWVSG3mP3ROlNhCOIuZ46RXZDpZhBKFrOxS13GFjx/fcmSwTxEFvGCk?=
 =?us-ascii?Q?dGdxivUe6+CaSWv6NyNjP3TOC0Cuf4Yp4SFwiM6y3tOtKT1mtf4/hq6BNbJS?=
 =?us-ascii?Q?Pq0GUuKlzcJUxMZcs67VveM2nimXjmhqxmfdwOjRNCTpjHIIVxFD6VT6K/ct?=
 =?us-ascii?Q?S30LKH1XCO/aGAM3GuLWhNZlLoqkT1cDvn/2E6Q27vuT0uBR05hniP6WWlD5?=
 =?us-ascii?Q?TfN0LhBzq6sw1CZFxE8kMdPQWcSyt7jonsNpu5YlOuyVhTKPKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:17.1387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a0700-73e6-4d8a-68cf-08dc941fa292
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

Hi,

This patchset provides fixes from the team to the mlx5 core and EN
drivers.

The first 3 patches by Daniel replace a buggy cap field with a newly
introduced one.

Patch 4 by Chris de-couples ingress ACL creation from a specific flow,
so it's invoked by other flows if needed.

Patch 5 by Jianbo fixes a possible missing cleanup of QoS objects.

Patches 6 and 7 by Leon fixes IPsec stats logic to better reflect the
traffic.

Series generated against:
commit 02ea312055da ("octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver")

Regards,
Tariq


Chris Mi (1):
  net/mlx5: E-switch, Create ingress ACL when needed

Daniel Jurgens (3):
  net/mlx5: IFC updates for changing max EQs
  net/mlx5: Use max_num_eqs_24b capability if set
  net/mlx5: Use max_num_eqs_24b when setting max_io_eqs

Jianbo Liu (1):
  net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Leon Romanovsky (2):
  net/mlx5e: Present succeeded IPsec SA bytes and packet
  net/mlx5e: Approximate IPsec per-SA payload data bytes count

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 48 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  5 ++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  4 +-
 .../mellanox/mlx5/core/esw/acl/ingress_ofld.c | 37 ++++++++++----
 .../mellanox/mlx5/core/eswitch_offloads.c     | 22 +++++++--
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   | 10 ++++
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  4 +-
 include/linux/mlx5/mlx5_ifc.h                 |  6 ++-
 8 files changed, 103 insertions(+), 33 deletions(-)

-- 
2.31.1


