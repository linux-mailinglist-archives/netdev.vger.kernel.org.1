Return-Path: <netdev+bounces-104180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA090B724
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC4A280FDA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE73B1662F2;
	Mon, 17 Jun 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ungSgpTK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072415FA6E
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643420; cv=fail; b=Nw1lghRqrKVirUqEhKVoshQDXnnW0JE0l9Tv5Xz/vRPz4pebesRjEVUjhYIBzS7MjApZ8sgSHnBFUHIX2CVXSRvYB3EIP18PcxQ6rHU6/Y6MvjK1+VxuLOxFgwvPAORxVi91Z7sAYc1UigXdLIDr8OoILVjqUYjQR2900EEcRKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643420; c=relaxed/simple;
	bh=rUWuhPzCekYHqvsj+PgmNd3gvKKEPiR6KkSRrwDWLM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7W6/L4/U7mxfcrJvtN8MqBnF2UiB0+hPiwKTSHUNa0vsuyzGRqoV0biIAGZqEwLZuRJbH8NnO3EjnGP7R+PVfMb9FgIdXMLHGRSPxBm/mSiLS/lcZVLCCj9XfSeylhDuCuaMdZD3HjsvVG9hi3I9BCUP/nd/Db2ig51D8oQ0do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ungSgpTK; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvNg8D3M7yRfHgMS/Sp20YgGgBIc3BOh6OEqpcd/57LOrBapyd+LbBcGwL1tAZrcqlq1ZtC1tw0pjok94Jkj4hhrBmb8QyqQBLSRmKPGByf0dK+jf4PRABJqXA/L+zRlT2o5cghkjst/u84rfZvW/Rg2f2+FvfofQJBjsGUovCeXf89Vf0QcqFAn+ERuw8E0n8PbVU3bunbTDbMBx/ztjw/mGQgM2PpxDbjNknYKrcB/906o3FusQME21zfM/j1sVad5bBqG2220zEW2Z+Nt2vtpPWbom2HvQoSpRAQQ79Jd/PaJHJLzPn/lzZ9tY17g5BZleCmrp3SaGULEAQP+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMJ2mnrSuFi0Pm2Z0pewsuO8+3v4TzQHB+tYaZCGKtU=;
 b=FWFDQlvAZHMjKYw2xT4jpLXzwbgLUtsSaTTVdukWw1sARGjweb6GKNUGKW0rsNmcEl5ach9zrSJrAtSfhM3jjrVB1AdpXOOSiv0pE4ipeUO5C9BaJANVnuRtwx6NhttDr9sH2mSZKHlS2cMdrgvuTcJ9bia1adHNQP0FGbHU14xj4W2EWfML5/WgS8OJR7xbjEucfGUkGYqGt7NsfQRzRmcIMOne93YG5LC70Rm1xsMBwqraGgL3sdGxyoSLR7qrVg1psiI/OzA3jpa4QHbxWWZPR0ONkof768wk/p0MXyew9F9DhIE6qSnr/fqPWNcpS0EYBqdelmF0TxLBsrMQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMJ2mnrSuFi0Pm2Z0pewsuO8+3v4TzQHB+tYaZCGKtU=;
 b=ungSgpTKDVLmhqEyCr4iDiQ/P2gT0h4wCYJtwQQGqWaPHplhgZSEvSO2RgVGLICFugorx3xBoVxzTa4aE4zJRpNEXNwfG0ZpSI8dM0jzB6YbxRX50KHksCmKUOlCzgkerIz+V5zmI8saj8l/tt/+jLkt/XkMbm2gDMom3l1tUJDf73IUKSZF/Q1+o1VOng98CJV6RyWYUAsmxQQgrohYptWfQIGc9phT42PfKSGH+t2f3Pzi9h+fNtIt04IQpPlTUjufHtoXfBUGXQ0LuHoCnzBjfnS27Aaoqd3tdAzfhJeZpfIo7Qn/t6SOacq/w+l3439uB2+d0MKaxV4sIymiAQ==
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:56:56 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::45) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 16:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 16:56:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:38 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] mlxsw: Fixes
Date: Mon, 17 Jun 2024 18:55:59 +0200
Message-ID: <cover.1718641468.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbb9828-5924-47e3-81ba-08dc8eee7e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqQxLeUzuNUDanWcfHjZ4jAFoFC4Lk7XSae+2VtgdCc067hOAbX7AJ8tCJRd?=
 =?us-ascii?Q?w5pJSqA3RowLksD1UtPt9HbLr4rTnlZcaA16mLasGlEKiEFatk0SAspNCP/o?=
 =?us-ascii?Q?6Ki+dj+SFDQMTYYnw4VAaxKiAbXsWew676WlOx2oXkt/lZME4HghMvXIqI3m?=
 =?us-ascii?Q?+4xJy/j9KtJ1E2ZJ4P9kwXFc57+HVwVdudCT3llgJX0MsoE46EUH4cx0nnDz?=
 =?us-ascii?Q?Pcw5JBIjqOGleiqUfzWNkeiNdmNvLZKMJRZaPe+er434t9suejIIHLwgdFXn?=
 =?us-ascii?Q?Z/zv4c9xtiIx57ccbr8mLwxhRKbyCCx+Be7yVY5lYsXXuaw/k/oD7UJHGrtg?=
 =?us-ascii?Q?Zml3oRfq/adLHX7Cx/VFU2lNFbZjf8Y1Mu72H8Cdbbm3TLZxYRKMx8qBubTI?=
 =?us-ascii?Q?qJSEq16tuq3KWKKD9iXW+53ucZjgb6zk6Gm8yqZel+iIS2alygF8stgfqmAs?=
 =?us-ascii?Q?4rYN2ZwffxYs7VkfFIxD6qKWAbR/d0FXkrUZ2Xvr4td6RTqi+RmE3NgrBmHf?=
 =?us-ascii?Q?ZBcYHRGGg9w9zIF2Qqf6uvvjy/+tU/YTp0i++15tGZ9thF5lX8oP9iTLMJVd?=
 =?us-ascii?Q?1PBPAL0nshYAmnOiz8E/feRCA/RWzZ5a7vr34h6pGD8i96d/HyWt96UMMVYQ?=
 =?us-ascii?Q?uXPGOWqQCx6yTzSTcpsT2e17/XT5CHd1MQJmfO2teoRQbXBKRb+BS+8ULJgw?=
 =?us-ascii?Q?1rhv+XJjby5pRSg707vBRLavFk3BLwPFyhMr/AZhiHzNYlnRovqsKyYi3iqI?=
 =?us-ascii?Q?GVeuCKu/RSI8YtdOn0gmIGSsHqvjNicMKC9Nq2rg1IU70lpOqabNds8NsF/H?=
 =?us-ascii?Q?AC2q4/EkqBBVhEn6md/j252tEXzSYfDh1BIv028O/SQqW4ll+DyDQEcUm7aF?=
 =?us-ascii?Q?nvXD9WTG1Rx1AHpOvxI+nL3qLhZo/5GWpNeY4qcbJOFlqbsOmao+0NZmDBjz?=
 =?us-ascii?Q?JC5fHhCmws3eQiUBGIVNU1CEh1IlSeTfTxGn5olfqUGvzimK2/X5SHrKtXdO?=
 =?us-ascii?Q?AVxjD0lo2yBkkiWXgjSI5oHtdD/kFoWY5njnWrJGhCL5XnkJBpL57OOiobtm?=
 =?us-ascii?Q?fWNF4fQZ0GrIoB7Vq8HGVsttHdNqwCLsDcahnJ67oNXOPmJxDxo5FJtOb8g9?=
 =?us-ascii?Q?jApcx0lTaukA4P8FkY19BINO8Vk/CpSJI5SgIsDVfS8GSc/kHmtqINKrEs2M?=
 =?us-ascii?Q?tZ1yh2qMu18oZWLhAjP96mUvYeDcUpFhIqsoYK4TxrFt4JFnHJzp0VNIESbe?=
 =?us-ascii?Q?LvrRfoNmLvACdcuBJFupPUKx5wGGtvlSlnaWIwSOxWLfBV7/qy/+3e794UlF?=
 =?us-ascii?Q?RsjS7z2UGbGOBV2c5/byr8R040kj1Fj7ypOflPtPnBhrsyzFI5Ol8f3wTuDR?=
 =?us-ascii?Q?FIbb+ypG8W/UDzBXAwZcEPJMUd6N4VOBdxmZ8p4vswqs0LWX1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:56:55.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb9828-5924-47e3-81ba-08dc8eee7e68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

This patchset fixes two issues with mlxsw driver initialization, and a
memory corruption issue in shared buffer occupancy handling.

Ido Schimmel (3):
  mlxsw: pci: Fix driver initialization with Spectrum-4
  mlxsw: core_thermal: Fix driver initialization failure
  mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

 .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 18 +++++--
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  2 +
 .../mellanox/mlxsw/spectrum_buffers.c         | 20 +++++---
 4 files changed, 57 insertions(+), 33 deletions(-)

-- 
2.45.0


