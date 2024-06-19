Return-Path: <netdev+bounces-104969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6590F532
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE791F22B25
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCA5152534;
	Wed, 19 Jun 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLfT7X/m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8655884
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818480; cv=fail; b=nLNaROaBZdDQfiHX+jK2WNZe1qC82EV/rXbjAi4GPyybtNzxjCR4PSVT6FYG8ESBTJp2JwhEWRSLBKKAcYUdOOKJ+f0gPE3l++wrbqvolW+5F4qSnG+NGTjc41irLd1bcCl47Qe+3n0gvAVtAtXcrISPZuGaAM4uZCVsVAb2EAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818480; c=relaxed/simple;
	bh=QZ5ZPO3vKireJ1Hss/xy6MHbkHiP+blXxw+oS4O8QGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8r89+10NBK/f1IKRE0dJyZCx+44F3zKpMJWG4jf3xt4mDr8VMpbz8lfx14wT3Msg6NMibSvyrmATmZujJynH+6okiplQFhu8ax0R3THjVANf9jn7v6eUWGb0OoP3nC+ZXblZ53r5RxVvg7eZCBMuN8gIQx+l9Lsj1D91kZygYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLfT7X/m; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3whC/c2/yBXdE9FI+gKianyPeFpW+0k4uRDizsk897SlQykG98nsdHe6P1HNHoHBPfJspeRW008sc0Y3WiNONjkXuvU8nHZMgAu+bmxJQYkucDsjukPGO7PHQurmHRjiDdv/zGJuDWbtdtjuYuI9C0gp9xmhI2Cv+Go+p0tQCz+BqgXCXcY3vTdRMuzMDROTAN0ccmMh1M0gjgDW3mEjQAvDic4f2iXrcZ74il7siPcZOb0GC5Ast0k/J3nDqxdYI7jyd371kX2V2PEnr6TpWaQf/4UiXoMjuex7tMlZ+rQpLwRFmukFMhYy5NKagHuE3L+HJFDUitrDSioZB13tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBd5o9AbLH6AswZhjJiWWBF97Zw5coMa+IzO7WkaCKM=;
 b=hwjsQBLRm0EAyw3+r/1eRDwmnT1M6MZBX4yHipATmklVlIvPKWdCZBwrNkzsKUp1FGDygoiKyCopmamZnc2U/85BntfuM37nE18drzSk8j3mtljbMe2aT44WmyBjtII6TRx4QiDIAe1rZCd0HiFaoxLqEy94X4WvmA0l5Xq9ARwmWE6Z1PEcAry+i53U7wBzS8c8C9DVV2kMk++QKCyyCerzs1eMRsVfQnncVUywhkMh6dIU+uFFHf2LibDDQgbivvJVzdwvArWxKOoU1MUlUds4p8b2rwPYynjWFX5IuWs8krUXIogm9LPG7hNH2ZXyZ9MONVuG4Dlh7n3rr/3D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBd5o9AbLH6AswZhjJiWWBF97Zw5coMa+IzO7WkaCKM=;
 b=hLfT7X/mkxin9yVPMg+mplYkUdIT9W34YsB2y596dHLb1JG3DR6XBdk/w5rofDFt4+Ldvnd8G4K2ya5YCqzVEqHsc5SLdrPcDyQrfy3nxueHbdHs2xcl2T4EtIUUDEIU6tifh2u9szkMwg09mmXwXlW18KK521IY5BoB5dyojhVjn5cn2CxYGzR35SsJsA9/qrTqS+dVlZIDDb4gm3EzchbcOeHrcRFyzI+8O+LFGts0OCjECrq4Bh3lBkgSvkzE2WRozQcXU/TBwhxys9Ifpj6v6m3h7c7f++oNOiQO7nuDbQW8mUt8gEF8gc9aeglBKcONOe40KcZNkrA/5+Q5bg==
Received: from PH7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:510:339::28)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Wed, 19 Jun
 2024 17:34:34 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::2a) by PH7PR03CA0021.outlook.office365.com
 (2603:10b6:510:339::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 17:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 17:34:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:34:14 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:34:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/2] mlxsw: Fixes
Date: Wed, 19 Jun 2024 19:33:47 +0200
Message-ID: <cover.1718818316.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a67c878-d3e1-4e0d-d786-08dc90861559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpL5eC4S5UdAbutPrn4MKriP//Zkx3KTIsyrdB6s78fS4bs8GHghyxCupDzv?=
 =?us-ascii?Q?hC3AJ6lusvFEPjysjr5/P9dOdZZD7PvIaHL8pDRTCYcAgMnTAIefXHAOsFEO?=
 =?us-ascii?Q?vvcE9XhgosKs5heRqYw2rFC8V6XmyPdSx6V1d3pbig+lGNU5sZZuPzpnEF+C?=
 =?us-ascii?Q?QF2LogSFS2oRIVQPMelmGhoP3ZrC5GW/ohnOyOTtIQmXWV7NHB8juutJMMjk?=
 =?us-ascii?Q?FN4Tru9oFr3i2/sQ+h6Y6UpYLV9Ccma4qv6DsU8C3Mx+XYtleBuDxGF5S0zk?=
 =?us-ascii?Q?jVKKpAmgwy3EripYflan/fo+ifrkHSpR0gOPH3b8P0F4sK4u5FJUNbIvURF6?=
 =?us-ascii?Q?aM1B3ZYIWZo3ARKm8x5hwPD464PQXwPwFZfK6CsYDRQEE6DNy8vPK2qx6Ws1?=
 =?us-ascii?Q?0Xl1pr1X1N8UyDDctm+QZMOhMUqNhBB/hiNSXSSbT8fK1+CkthO4Lf6O1iew?=
 =?us-ascii?Q?JQscy8PvO0nIJEqk0ifUUVaIC5g/Eyu5Cm3sFvRKHkUIGGOXNNF6WEFZzm4p?=
 =?us-ascii?Q?IHD8qQbwT87MNTrblVbBQL7ss39TVJTKzliCyJ9DuJGsnZsJOtFr6yGXEaP0?=
 =?us-ascii?Q?J/J05npB/lJfQy35XkE2BbB8U2HJJhNmq2n37FIAGAsojxrtAB0+lYXc+oQ0?=
 =?us-ascii?Q?ZHkjue+C4oMbpvvY3nlbBH2BA2gPKIwbhnBPGFeo89cdWvVXdMHJoUtKmEuS?=
 =?us-ascii?Q?Cq/aOQL8z0WluJBGgN7glHNH7yQP6JqwT7lFwPlhW4abxCsasu4wAlq0OjFS?=
 =?us-ascii?Q?0bsjMm7yWH8dRWrwKp37st8AW8ZKZsBeHHSgplSnPV1yVf7JU+juBSboU7Vt?=
 =?us-ascii?Q?4UpyRf0ZoCyTGUZbeRnI+ebEI6bF/e9lSIiNN4SGHLSkZ7ZWaP+51pwl1AHa?=
 =?us-ascii?Q?7GpNT/uOcqL11tqhizZmz6uDebp0nYy+V4NyS/fbsQI7q/Xt913uYThnVliE?=
 =?us-ascii?Q?t9x5gWCCWw+/jfJTfsIpDbfj+SnGyZia6r83c7218IFNwZNjYDaPBtLw+A8Q?=
 =?us-ascii?Q?LcrxcTfRrJO99ZoOTFFJ43XKzV+mwOVUKxdZrN9eKCCZVGJzeCmjwjNICb20?=
 =?us-ascii?Q?JZyBCqO08U9nms1Jc0tjrDegQYaiZH9myOre2rdhzgIyDmqOB84InkUhJfCr?=
 =?us-ascii?Q?hn08OSweS5+v0nPG73UNlh4ztqIs+JL1eN8JbGvUQpzFg/g4FnmyFOPeCysI?=
 =?us-ascii?Q?tjvP5N7wo0Qd9ezjJqDEDvoxB7qhJSdWiHQeYPK+lNDxIw3nP08fyITGk3jl?=
 =?us-ascii?Q?Nc9jWAt+QI7I6QArGR8nBaBZVYdrkCGJbrUGGvFrw6fjLACUfrUtSsZ8R2qi?=
 =?us-ascii?Q?3VC5THfgYoMjtVVEml5l68+UEWSTFhJcu8v0G13OiUrNYB/Uh1boh9Oh+poQ?=
 =?us-ascii?Q?Tgvm7EWByRSvlNd1emD10jY5Cncp/dXH7wuuv4v0jfgVA1MfKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:34:33.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a67c878-d3e1-4e0d-d786-08dc90861559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705

This patchset fixes an issue with mlxsw driver initialization, and a
memory corruption issue in shared buffer occupancy handling.

v2:
- Drop the core thermal fix, it's not relevant anymore.

Ido Schimmel (2):
  mlxsw: pci: Fix driver initialization with Spectrum-4
  mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 18 ++++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  2 ++
 .../mellanox/mlxsw/spectrum_buffers.c         | 20 +++++++++++++------
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.45.0


