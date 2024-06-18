Return-Path: <netdev+bounces-104476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855290CA78
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFFB1C227B0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D42153593;
	Tue, 18 Jun 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="daHxZvM9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204E14F113
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710533; cv=fail; b=SPDn58zowCG8Wpi3h1yXf3sNBUe+QZWvfMLfIEmv8lB9Z7ZpCfctxOlMam5b7g55hIvdLkloh3dtYrghtmwTKd7x/0790pPTVYdn82yS0u4ZxcH2SStdDxb+KHXVkBW1QU1OI4uId4O+ZLMnDp0OhCg+vgDHSH/eaY+SViVRf/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710533; c=relaxed/simple;
	bh=GLAcHNL/tYoXkLs699GgTiu7laBHP/fpRmWCGxqnfmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6tCPoqk4QqjogJtR9KXPrTUuJn46ADiTdinqoX/vof5vb1+gwZAT+8TJg37EVQLcEmvIxidV7VjVspIrfLTxMd4v4d931bHwMU0J9efzT4EAPwhHnxEE6IbwXnyP1nG/KhUr3m8H2OQQ0zFYFF7dhHwZKssdLr0UU7q992vbSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=daHxZvM9; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neHSrozz6RabkT3MDGIOWj028kJtI5A00856xuJEDZ4lWtZ+1cSrE6lNWFrq0uJ5prvWtr1emTp98DXapWaf5VGwhU9Ohuq2+lBCzyDjqToGQtYTBvFwr413+WWmyTwQVTa/huORxiuIL0NASLySg5KA3IgJBBj7Ls42zorxQSKs0WwBz+LzHtyprAyBhC0lR9fyTlI7KjFOBK0e1r0NJ34Gag1yi1WDA7faJM6mFKh0EoxMRtO6XVYBIRb5PhQniArlzCeO5shph3rR4xN89sdyqW3DlFpSn1mlbvjqcboa1txtIFcZp+BAZrgMcVmZfY3QD9V92g3NBUpJ5BSqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG5t92+gLA03yf7OR7oc9yQqp//zzLI7hpef3xVaqxM=;
 b=KtGptNKMfkKmaE1vH6TeDe4FNEerD2gAjjUrg++5oGgkWf9nKGJE3U0g3m4G0A5EekCpsw2+o+x9fjIFQLiyk7BI95DYrLUEyUasm2Fh5Et/ccSOx7I8coMng6bHZfX+zUQw6A9PdqQp1dWZPBsIOKQBQaeneQUhJhllivh6yVSBLBfAYbEZhjmVgOItOaNgsODWPE9aXhkiyn+RE9HQczzrxlQxgXUtXYG4Xo0R5Q445h5L8eI29l+9VEw9XbmkMS7BUpyZJuPmeRk44wqWLEtX8Lc+MDXa5kg/1Tq6CRuYuMUyTaNwIJdVnYXdAVsyFwbspBVsSo/ANMYJMtaKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG5t92+gLA03yf7OR7oc9yQqp//zzLI7hpef3xVaqxM=;
 b=daHxZvM93AfSFdgAiva/i0cchKn6VsBRKyArB+743J+YAIgbI8J8TTXBAWYX6t1MNT5ecHcT2zbyt3rNka6BIGeub0h14NIKmoemB4vAwfNnyEWhi5hKe1QEk/HRmY7pSLHXiLFP2sM7RxvLinjwEdtsVesT7zzqxMwvBna2EmC1Ukz6Rgd4lbEkVIyO8VJ5eGasbjy+J7M7oWdF5T14XZ5HJM9dpcAaKqGU9eoE6eLlhiAslqNWlUGBawTGpN/VL8yRsuUmAGeiQ3YpgfAIxQjz63tlYNOe8NTqe5KgMLR2Wod0Xc6HX/MX2FYgSHH9oBuOEQPDoC9vSdYC8lmIwA==
Received: from CH0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:610:b3::25)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 11:35:26 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::4e) by CH0PR03CA0050.outlook.office365.com
 (2603:10b6:610:b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:11 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:06 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/7] mlxsw: Use page pool for Rx buffers allocation
Date: Tue, 18 Jun 2024 13:34:39 +0200
Message-ID: <cover.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cbc693-6373-4140-52e7-08dc8f8abf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vVnBrRH2ZRfILzuIaPqeGyNFoZOHSl4Jn0J33106hojSg2kz8h/VX4JNuV3E?=
 =?us-ascii?Q?qiSGr8s17KnVyuEQDdb7hGMfV56tNcIbsqq9ekpN7BrpiSe0YJ8JP6Yw1uCA?=
 =?us-ascii?Q?2ayAyhRo6xkHQijgjS+5jxLJntCCcLagp5K4B2pJhuP+KPllS/JlA9otfXMx?=
 =?us-ascii?Q?wEX+4/C+YnsSKaYiwtzQlI1wqBlj/SLX50R9ri5SoyFO1mxPL4MgigL4VJum?=
 =?us-ascii?Q?xpuX+Pv+Zdirl0XqBQb4q8Cbs/Hat7GMWySxOIoyVWcUC3FSo+wY8toSixlc?=
 =?us-ascii?Q?ntHdfnj9Ie3UmAphzh7x02Lag/bcSo4FppLLHPowjLMEFOHRrnMP1bLMFTVR?=
 =?us-ascii?Q?Xj4MRvPv/csXflAmwJUfddRmIZkpL/z1qOBoJNMyzXNXFjBrULe9EbQzb0i6?=
 =?us-ascii?Q?jSTKTv8AD4ibpFdJMzA9LJzTrFRpId21LX5kdYmNnH77BRSLiKjtiqzn9Fm1?=
 =?us-ascii?Q?4cU9VcxiIoreaLK3Zl/cGTuNbed6qwJmKjNBJ+CFPrQgwZbmEKe+xw99SNx5?=
 =?us-ascii?Q?nipPWLFDTvUe/C8OJz6J67NOwLe9faaCTIiiaiecHZkOZEt+LxOYUC1e1ORG?=
 =?us-ascii?Q?9GrofQCXokSfAf+hFvH0ckU8hjcK4j1yYAZu5qgBfPTFc6uJZpX9i98SJjJK?=
 =?us-ascii?Q?5UNN9n4+CTfDvnovR17QKWtX0qhPcaqu++FKPnIwJgjO3oi4JGjwKiBqdZAv?=
 =?us-ascii?Q?+W2XHs5k0heOteHU6keElYEZ3coy9GWYWQFkUstaNrC17y7DhlnO1/WVcQvt?=
 =?us-ascii?Q?yzmckOl2vIjOIUp9+xf7cXUDDldpM3iXVEiApHpS2oCtbifLlFGDi1SpgVw2?=
 =?us-ascii?Q?jwZJ9MLz17wQdnt6xU9bt5/C+1biRP07gbA6BNEvcx1YY3752wbEudLV1e3C?=
 =?us-ascii?Q?AxG1z9u4UO8xzxGYl60Arz7YMkgpe9u+RpRNQB5mEdk0p/r9n7aL6PChKbjt?=
 =?us-ascii?Q?6KzMQhncG2MDMDREV2y4pLDQCUwJg5bjAmsjA3XkKVX+KnB3o/GyeDk3rwAy?=
 =?us-ascii?Q?s+iyOPSAPgT0tEHIbDNnPIB88L66kYyRUVdYBx4dX9V/CgIDTVU5aPlDCb7L?=
 =?us-ascii?Q?rBvIGNfvl5gx20RB/1ViUtaa+mJJVKcpYTVqGW2NBYLe3xWBsRayR3HqrC2+?=
 =?us-ascii?Q?fUEANkkhGYZeVi3p2zBjdMGzDQXg65PvZC0vvefNVlXpDEpDhB61cfhahWza?=
 =?us-ascii?Q?OUawaSBmYrKZqLsw/A+nk0c6Ap4YZCbjR1a+FMzu929cit5Kg5DQuxXIHLpI?=
 =?us-ascii?Q?elYbKWkpd4vVIcD+SjPe+R6YcUtewgFyuvIoDWbrMu+0zl40yJSQXIujXP9H?=
 =?us-ascii?Q?DFhbJ7KTfS9ssdsQOLilOmeiqEKeX3ZBaQeEiOvkaV4/x1UAYr5pD1oNQbaa?=
 =?us-ascii?Q?L9+wmzDK0BGTvtD4aRGQRBbohptARD/CA1HBH826cPBCLZimWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:25.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cbc693-6373-4140-52e7-08dc8f8abf5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919

Amit Cohen  writes:

After using NAPI to process events from hardware, the next step is to
use page pool for Rx buffers allocation, which is also enhances
performance.

To simplify this change, first use page pool to allocate one continuous
buffer for each packet, later memory consumption can be improved by using
fragmented buffers.

This set significantly enhances mlxsw driver performance, CPU can handle
about 370% of the packets per second it previously handled.

The next planned improvement is using XDP to optimize telemetry.

Patch set overview:
Patches #1-#2 are small preparations for page pool usage
Patch #3 initializes page pool, but do not use it
Patch #4 converts the driver to use page pool for buffers allocations
Patch #5 is an optimization for buffer access
Patch #6 cleans up an unused structure
Patch #7 uses napi_consume_skb() as part of Tx completion

Amit Cohen (7):
  mlxsw: pci: Split NAPI setup/teardown into two steps
  mlxsw: pci: Store CQ pointer as part of RDQ structure
  mlxsw: pci: Initialize page pool per CQ
  mlxsw: pci: Use page pool for Rx buffers allocation
  mlxsw: pci: Optimize data buffer access
  mlxsw: pci: Do not store SKB for RDQ elements
  mlxsw: pci: Use napi_consume_skb() to free SKB as part of Tx
    completion

 drivers/net/ethernet/mellanox/mlxsw/Kconfig |   1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c   | 199 ++++++++++++++------
 2 files changed, 142 insertions(+), 58 deletions(-)

-- 
2.45.0


