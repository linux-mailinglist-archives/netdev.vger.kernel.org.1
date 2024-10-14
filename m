Return-Path: <netdev+bounces-135320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045899D88E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7413D1F219A2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0931CB330;
	Mon, 14 Oct 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oVMkxdQj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0681145324
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939255; cv=fail; b=JGA8xCFpJREjtTeoB53ZsR5ue5QCDY3p6W2r9bET5oAxvKRLvBqVzxAKLNrgoga864XWWMN+vTiAHl5NJ94f/WQ/y25OYoYqo2ol4YgOk7IwILakNuxZK9TktMd2bZCrQFx7Y2QKoks3piHMc49r03p3FubPtIVA8zPm5cfUfU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939255; c=relaxed/simple;
	bh=10CRcdYe5YuEGYZA819Duf6YpquoHCqN9mVpAuYeFG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nBS52pRlD480tpFaCMJ0dPYtQ8P0RJh7wrNPTEptkEkLcv802C8iueg7wmz6DYGJQGP5M8oI08WjSby9EZ+pGpMo62vvgM+b+OIij/5kUTe0w/9J5tXlJRe3YbSONuylGLECulIijtA0VYWYvEeK4yaHt1AHWWWPRljL6vqNtzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oVMkxdQj; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkklZOpS47lihUHYirZT9LarRYgU1adwl+a606HAxPHOLwoAXcH2LG1jKa3CbVgmUck6jxgGSALZFLkNXdb7Jpvwtp8u3UY7guvNQjhS3chyw1YFP0ffLy/N5cdmgJBHbfJZCU0MvhrOB9fT4xQQc2H2NW2DLt4J3ad/xI1coB9n4SfHz0cP9LuskjLSJ642oJ3GelYoSNL1Hd6Q2aCgjL3wIXee148d+Y0aF6DI0wOWCJNj+JpfbCegrbRtBC7hbQPAQnu762KLWGspb94C1/0neN16q/6JJc7QfzclauGkh88oI8Sd3KgSO+X5nx8YbobT7/B5g4UocWdjVTS1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUZWX2dUG1+Nsz1Y90tJcmRMceJE0n3W73k5Yxv24F4=;
 b=wq9B8rBMlIOMtaE5xNX0HwqgYg1foZgLmGYk87bLOt7H+Rar0U9MFMvCwJzD1SRY2UnezrVhPfaMjThHNXSx36ufj8P9K0AA7zTfbNkI6uJ3pQz1aV3+Fug2oCpZLBjss8s/CipfLbaS4ctwQG1RZ2U3oyNN9OjVGe+xcJc+pY/tQmmP7Ptw/FU62QO3YBKwcP0UDdHYfzn5ckaWIhw05k2nN0AVCBQ2pZB6/ViTevL+eO8BJHlldNou8YEaPomF2B/BUJ800ebpOKZdntgQjK2MWjGV0/sAGXOah9fP2MqsyqNrda9Z2/U44yumSi83vmZlxsawqU5lwuUzb+GDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUZWX2dUG1+Nsz1Y90tJcmRMceJE0n3W73k5Yxv24F4=;
 b=oVMkxdQjqlaC0pLj2vebGUQVFlu3f0bLV8xf5lIUoGdMBeFLvj7ZcCwvG5AEcqy7n1xHWsF7pt41BGVfd7zGKwOQkkjpg5GmQ6hzjOMKY5OXAEMoTu6+fBdoYsj2Sxfsc2impIMSKb2tQk1cXNgj9JfORiqaL1U8miaPTdZmBGbgoOkoal7PeU1ie3mgHDDa51tw++9kVuO6uLtAA9Fv5UeWZ38psRZpx80h+AP9Acsad0utThS3kiPcxL7EbnrgHM+stbLt+uWS1HNpxNDwQN/encVjR9BX/xo6KCQXLEBUm6N6ZznxwZPazeOxfAh/SkppcLElCYFnIGwD6Ra3kg==
Received: from BYAPR11CA0091.namprd11.prod.outlook.com (2603:10b6:a03:f4::32)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:09 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::87) by BYAPR11CA0091.outlook.office365.com
 (2603:10b6:a03:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:53:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:53:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:53:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/15] net/mlx5: Refactor esw QoS to support generalized operations
Date: Mon, 14 Oct 2024 23:52:45 +0300
Message-ID: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cea62d5-6b2f-4cb1-a1d2-08dcec9259a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDhBczl3Y3pKa1oxSzVWQmN3QXUrUWVzbmFpVUhqMlllNU1RelpQSVR4NW84?=
 =?utf-8?B?Q1ZXbUZUWjRjcWxCcVR4WVc4ckZZRC85bWdqZnlqWEl3dVM4NzFnQVVaL3Mx?=
 =?utf-8?B?OU5paFowR2VDK0t6U0t6dWNkemMyYkk2bzZlR2pQUFdXSmZHVHJhbWxxWHdP?=
 =?utf-8?B?MVFzOUg2NzNQRXpic2ZsL0tTZGdES3dIbVUzYmprMmJ4eXU0SFU0dW9rY1ZJ?=
 =?utf-8?B?VHN6UzFKazM2TVozcTFjVGRQZHJTQUpVUUxZMk1kem5EeTVBWk1DNnNiK2JI?=
 =?utf-8?B?ZjVHbjE1cW9qb2I2dENMQXQ4UUMwOHJzblc3c0x4WXUwNmZsbUU4SHRyZno0?=
 =?utf-8?B?UnN0VjhUQTFVajFBbFBqaE12bVgydzhzZ2hSVlFnNlBnM0tKOHhkVS9RMG0x?=
 =?utf-8?B?aDdBWno5dmkyWEFiYmNFdTJHS21RQy9XZlFsdExzanpoT0lVWFhvN1JMTWly?=
 =?utf-8?B?bWJ0Nkd2ZmVLa2Z6NWJXL1Jrb3dmbWQvQnRYbEdlelphaU1uMjNzQ0FkK2pS?=
 =?utf-8?B?K1B6TC8rb1U0VmxQYUdENFQvbWljRnZFQW93R1BrNERnUmJja2EyTUd3eXFv?=
 =?utf-8?B?ZVR0cVRvdmc4b0ZjUFJQRHIxS25ZakZoOEpMSWg3bVplYXcva0U2RUplaG9X?=
 =?utf-8?B?M3RCYXd1b0JLTlZnZDFWMEU5T3phSTlUaGpEODVsQ1JGVHdnMGozUDlQai9Z?=
 =?utf-8?B?Qm0yYkx2cjRJOFcwVGdyU1JhajlEU2kyQ2dKanV6QmU2OGlhNkdDbURhZjY2?=
 =?utf-8?B?ZWtDcDFqYjEySW94eHFtUGpLb3JYcFdKeHZhK3JPQW5IVUk1b2dXVUR5QUdj?=
 =?utf-8?B?NWV5N2pYT2Jab2QveDJ5VHVTVlQ1Rit2MjZNdnFJSzM5a1VCUkdNWTN5Ty9p?=
 =?utf-8?B?WHd5OFN6NytFVVNNRkI0V0t4RE5xRVNjVDZSL25Gd1V5OExoR2QvbU1JWm1k?=
 =?utf-8?B?RUdpa2swZVc1VWtsdnVxaWR0ZXZLcnQ5a0lmZjlheHJKSmkzKy9USFBQRUxj?=
 =?utf-8?B?emlUdmZyZENoNXQrUGhYbGJnQWZRMkpmUW9hV0NuaTMvR2k4SGhsN1RmSnll?=
 =?utf-8?B?Tk5rMXlxd0FqZmo0UHZSNFIwdkJFeVpMS0dzQ3Y5T2pPNU1kMjRHOGhhdU9J?=
 =?utf-8?B?ZHdSVlZ6NC9ST1poa3BadHd2cWlpYXVSOU1UOFZYaXhaZnVnTnh5SVdkbXUv?=
 =?utf-8?B?UU4xTUx5VXdkQU1wQ3BMKzlvZ1JOa1VMb2FaMWQyTDVGWUxwT0FOOFF0dXBL?=
 =?utf-8?B?Y3VKVTZaUjR2ZUt5R1NITVA2RkhNYVRlcjhDVlB1MUwrQWdrcFpvbXcyRFg1?=
 =?utf-8?B?UkExU0w5OFR2ek1pUmVwaW1teVlNT0pEcFkvNW1jQ2pBb2ZNZFhxY2VFL2kv?=
 =?utf-8?B?Ym1YTW9TMG0zNjdnYVpnM01xQWJYUkFLRks5c2ZicW9paU5sbU9wUk95dE5X?=
 =?utf-8?B?ZEM0T2pld0U1OVFrKy9JdlJBWkgvMDB2c2J2QzJwNVY3NWVpc0RYWklJd3RX?=
 =?utf-8?B?dk1lT1F0RElqdmVBc2MxRElpTjd3dzA5aFRGWFFLUEpNNDVpSkZvQ0lhZTRO?=
 =?utf-8?B?SjRhTGQ1MG1MaVNqOXFLdkhTZFFLWnBXbGt1WGlxRWlFTzd6NWtlMS9ZTFFT?=
 =?utf-8?B?VC82NE1xT2htZk5DZ2RXUThhVzU0WlduWEMyM1hXNGwzdVFua1JDQmljS04y?=
 =?utf-8?B?clVWSHRlNVFOYVRzeFBESWhQb0ZGQ0M3OFl2bDdyVHZaTGVzeW1XZFlneUNy?=
 =?utf-8?B?QVpuakhjWlAyRXZEeEhqc3VNVkp5Q2FSZ0NVQ3FrQ3VuS0QvM0drT0ZMUEVp?=
 =?utf-8?B?Z01XcDFnZlIzTjI0aStUa2lpMkx1TlVpQi9PMXJ5d0NqalUwSi91UjBWajh6?=
 =?utf-8?Q?Yx+l1dWXcTx4l?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:09.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cea62d5-6b2f-4cb1-a1d2-08dcec9259a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

Hi,

This patch series from the team to mlx5 core driver consists of one main
QoS part followed by small misc patches.

This main part (patches 1 to 11) by Carolina refactors the QoS handling
to generalize operations on scheduling groups and vports. These changes
are necessary to support new features that will extend group
functionality, introduce new group types, and support deeper
hierarchies.

Additionally, this refactor updates the terminology from "group" to
"node" to better reflect the hardware’s rate hierarchy and its use
of scheduling element nodes.

Simplify group scheduling element creation:
- net/mlx5: Refactor QoS group scheduling element creation

Refactor to support generalized operations for QoS:
- net/mlx5: Introduce node type to rate group structure
- net/mlx5: Add parent group support in rate group structure
- net/mlx5: Restrict domain list insertion to root TSAR ancestors
- net/mlx5: Rename vport QoS group reference to parent
- net/mlx5: Introduce node struct and rename group terminology to node
- net/mlx5: Refactor vport scheduling element creation function
- net/mlx5: Refactor vport QoS to use scheduling node structure
- net/mlx5: Remove vport QoS enabled flag

Support generalized operations for QoS elements:
- net/mlx5: Simplify QoS scheduling element configuration
- net/mlx5: Generalize QoS operations for nodes and vports

On top, patch 12 by Moshe handles FW request to move to drop mode.

In patch 13, Benjamin Poirier removes an empty eswitch flow table when
not used, which improves packet processing performance.

Patches 14 and 15 by Moshe are small field renamings as preparation for
future fields addition to these structures.

Series generated against:
commit c531f2269a53 ("net: bcmasp: enable SW timestamping")

Regards,
Tariq

V2:
- Declared int err separately to fix the type mismatch with u32.
- Fixed potential NULL dereference in the node allocation error path.
- Removed "rate_node" renamings, as it referred to the old "rate_group".
- Replaced 0 with NULL in mlx5_esw_qos_vport_get_parent.
- Fixed vport node allocation error path.
- Initialized dev in mlx5_esw_qos_vport_disable.
- Access vport_node->esw directly where possible.


Benjamin Poirier (1):
  net/mlx5: Only create VEPA flow table when in VEPA mode

Carolina Jubran (11):
  net/mlx5: Refactor QoS group scheduling element creation
  net/mlx5: Introduce node type to rate group structure
  net/mlx5: Add parent group support in rate group structure
  net/mlx5: Restrict domain list insertion to root TSAR ancestors
  net/mlx5: Rename vport QoS group reference to parent
  net/mlx5: Introduce node struct and rename group terminology to node
  net/mlx5: Refactor vport scheduling element creation function
  net/mlx5: Refactor vport QoS to use scheduling node structure
  net/mlx5: Remove vport QoS enabled flag
  net/mlx5: Simplify QoS scheduling element configuration
  net/mlx5: Generalize QoS operations for nodes and vports

Moshe Shemesh (3):
  net/mlx5: Add sync reset drop mode support
  net/mlx5: fs, rename packet reformat struct member action
  net/mlx5: fs, rename modify header struct member action

 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |   4 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  53 +-
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  |  27 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 669 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  25 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   4 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   9 +-
 .../mellanox/mlx5/core/steering/fs_dr.c       |  35 +-
 11 files changed, 435 insertions(+), 398 deletions(-)

-- 
2.44.0


