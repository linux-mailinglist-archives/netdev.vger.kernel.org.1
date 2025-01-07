Return-Path: <netdev+bounces-155719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA58A037A9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF647A244F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0A1DD543;
	Tue,  7 Jan 2025 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjrv2n8u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AA194C75
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230121; cv=fail; b=E01hg/KSwxVlaHnJic5SP4ZXo1V1U++m2c9zOnfTQHVc04LALZJsLiIMyTx/DXbOB+6dmb4MZv7eFrsGjKJZ+BIUAOHUcMZzHLeEWx3wwd3WEmel7HMockYlq0vptP+Ug8A0h4ZgzkUTNyEVSSG/eaV2hijTapct8OoDpgJPSr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230121; c=relaxed/simple;
	bh=hT9HeO3o36XUEqWNEexjV/uBYdJPlv9hwJp57PKQj58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PyNN7p7eHuUnjK+mW2X5exEsCu1cknXsVA/peGO/DrRK4p3/iZWGa6BaR0b4h1Tot21hkBsSfZcCnJjmYYxinzQkY6uA9U8CDqY0bdLsEllYJWSE1EIntm8ztqSGJLxcBQGWT8qrnypdX0LeHn77ffOshMnGwvHdqidMh0abE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjrv2n8u; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhgcImRweuuGoatdkJLbHeqewX8Kf1nl24AIR4nMv0bjXKwpSvzS0838tKMJXXgEBFa3fjtQnto+i9gb7sQSoYLzJE0ZvjXXxWlk2cWVWQbi54EHkeBqT4C1TV2/ofBDse9JgLcOorA1dVehhhLAYd19M/NhBuoXXOSMfjY2dF7LXTKKXS96R/SX/ii93pnu7WxgZCbSjMwqWheOHIskZW/yb/J0ol6/akRkURUi5jQG5hN2UQT/zwRYCrsY+ro5Md7nT93d18R3/F5+D6iRk+q4R7emn16opuFWIJW3A4jI5v1eHVKlGXCgxDmzMOUJep8G4TajtmU11K6B07OdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HglwE+XsePjvFw5W5mMhQLP3W75mEFwAbKW0EV7gq4o=;
 b=WkRpDbypy4L2qMJg3iHUvqqCgGWCc1quz8E0kE8P1citaa37rUpPSFRgkxUkIb/dZUobcBfoGN92QKnthwn6J08kuE9wsHjXsm6NrtGZn7BqrgoivxSmKUMRTES3q9U0QOdvH4sgZLQK5k9qD0uj+IR9ejgRLUL7qMTFOIDk3XmvT/JAFb9Ps/CEQMnWDTzg1xzLsuB/A/whSgocUDO7bqWQCpDqbXrnrmkZFjZz07q8oMPfG7+jwfmcIdh9muyzFN983Wc9eiuW2ykdQD/cHNniE2PG8Dt0A5JsExJtOgwFk2WaAa9EQfeLdJYvlClQeOmrS8orG3NydLI/vYzM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HglwE+XsePjvFw5W5mMhQLP3W75mEFwAbKW0EV7gq4o=;
 b=kjrv2n8uMxXg7iaX4dbMgHut4P4ts4xNAMGg/lAJly7JhMeIaCnouXHnbw2s3TqIneNOtiwcEhq4eiaLIkE9z3C8j4UjMTJRKKRtNj8bxzr6ieupROg8G58yjRmAvgAoz1YStRrlY6KPQVoCRbHM3S2NPpJaFsiAgYSR8oJtg9FYywvCOAItjB6h6BsJSKCXBSTJdYl2QR4eM1ZHVky5K10idGIWdwmMnvYVbI6qUWVaAId+dorANffdRdTliOXR9yiB6Dg2A4nUCedwPhF39D+ACrSze9hVEusZho9W7unMhwD7PIvf6j6+bNLQRVd/JqJLy0DiokozQ6N0AJf2yw==
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 06:08:32 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::7d) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:19 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 00/13] mlx5 HW-Managed Flow Steering in FS core level
Date: Tue, 7 Jan 2025 08:06:55 +0200
Message-ID: <20250107060708.1610882-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b57832-17ea-42d4-ad44-08dd2ee1b630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZeMOGNPq25H27oZyq/FL+IqOAWCeCwEjBmKd6TGowM/a/TW96J9UhcGtLqsf?=
 =?us-ascii?Q?e3kLKxIAqZ1S8uXKvzPnCpnTQ9QDptTxwSkzkVTpkhkkkotDkyaCsCszXlC7?=
 =?us-ascii?Q?fawAWETlga/P0YkQGW634J10FB9uFAS32d7LkjlZg5R+tbJP8NY7P5/l5z9N?=
 =?us-ascii?Q?3kiwm5dBxxhCxKBsxc7sLYOlTFJ9ca3/uonf3fG+g95D68/nLCVMew4cG+T3?=
 =?us-ascii?Q?VbM49jneHNA+bJXOpRfQ6RT7lfxVC+IzvEUFiwnXCbPF8NhnL3yoPRPtqXBi?=
 =?us-ascii?Q?Kkn6D7gF16axDpAmke54aNxi/D78gV3UmvRz+M3g7tY6VPXAImR1G+tsV6wQ?=
 =?us-ascii?Q?kA0Ou5bBCxpJOasIeBUkUUKX9/1VNUuOpBDCvK4199vaf4pUiV3bCyjNyAw8?=
 =?us-ascii?Q?+O4TlDS4Oac+zPJzjX84oMc7wDIVdA36rcLm0g6+zcUPoboVFePmbYVCxs8o?=
 =?us-ascii?Q?AZuinEAMjOnZpCl1ZcV799jrxELKnFOo7yEbqGKRZYgosUkyf0Y270NrG6WU?=
 =?us-ascii?Q?GpsYGC8luNGw3q9pyJVTLuZkKJNkNdqbGzmriEoFm8+l5NCdDNOI83jsiVUE?=
 =?us-ascii?Q?nkcpfKV3fX/k7UmhqMjwePQlMR1EIqGyDJhmZSt67X7cMH3ojF5av3MemqH3?=
 =?us-ascii?Q?EzOfIF4gGUG9ddBCSjvzS2kCcs+xzE4fqCdknpO10pTGcqskVooVX6OOEYel?=
 =?us-ascii?Q?pGnJcqf7tivxotsJBX+qfZBPYz2n+Mt9c0w17hfeumEUKY+wR2pTfE8Xu9DT?=
 =?us-ascii?Q?IxlD/2R8ro70iTFoHMORlIbMqn2WuQiwKwnPPSyf9xTYcc6iy9XMfgFHVkNl?=
 =?us-ascii?Q?MK61TbbFq3Bd+aC8RF/h3ioQ2+RZY87hiT7K8xdce29fdFhEzkU0wnFsBdJ2?=
 =?us-ascii?Q?t9GogMvbm8ICLseyQ5ElurFbDsXkCPp8OZS6DQu52SW1vodcX/FmDpAPdCBV?=
 =?us-ascii?Q?Azn41af9HCeaMXPahhQCqybNcGXs0fAqwPlI82s+aQo6b17LoTrPyMbkkUGM?=
 =?us-ascii?Q?aJaG9E5rC6OzBim1jn+ziYar5+Hd5ewSwsxsxHH5/xSvuj2fifmmcZho4VmN?=
 =?us-ascii?Q?xKuSnSMFfQiv5ZpIUHX3utgtlHZUYuHnKp5d2xTrL/iYosm5QFn7qI9wSn00?=
 =?us-ascii?Q?yePc2yQ0DJZlCnznpJiP/gduiCQSykT52NFhbPQjUWlB0fjHbZqxTw+5ja5n?=
 =?us-ascii?Q?UwLRc8xN3JmkBp/ox5uZJCkTIt0oFnOIPSKd4wU8I+I3ImoyE8VCSlFhqx8J?=
 =?us-ascii?Q?PbxpdZd+/7tIkDjt/x8M8Yd6rEjNGD71mEZJiCW36BE166cxgSvOJ/Fz0xAq?=
 =?us-ascii?Q?3UW2BF+gb8/s3BMsvzARcc/f9JP7Gof+g88Cdl3+u6svUwJz9bIJ+b0U/yIm?=
 =?us-ascii?Q?dsF+BwykfChUun8wKpbXM78MO2OrvN0BXqY562gYmmpnF+EzJQWxjWWt0QgD?=
 =?us-ascii?Q?CW4+BaYK9vcjY4Ij7tLK5qLRzmCSjIb7mUIwiN9TtHO0H0Skbv6aDtW1jsm1?=
 =?us-ascii?Q?5JqDI1oF112zuV8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:31.4234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b57832-17ea-42d4-ad44-08dd2ee1b630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

This patchset by Moshe follows Yevgeny's patchsets [1][2] on subject
"HW-Managed Flow Steering in mlx5 driver". As introduced there in HW
managed Flow Steering mode (HWS) the driver is configuring steering
rules directly to the HW using WQs with a special new type of WQE (Work
Queue Element). This way we can reach higher rule insertion/deletion
rate with much lower CPU utilization compared to SW Managed Flow
Steering (SWS).

This patchset adds API to manage namespace, flow tables, flow groups and
prepare FTE (Flow Table Entry) rules. It also adds caching and pool
mechanisms for HWS actions to allow sharing of steering actions among
different rules. The implementation of this API in FS layer, allows FS
core to use HW Managed Flow Steering in addition to the existing FW or
SW Managed Flow Steering.

The last patch of this series adds support for configuring HW Managed
Flow Steering mode through devlink param, similar to configuring SW
Managed Flow Steering mode:

 # devlink dev param set pci/0000:08:00.0 name flow_steering_mode \
      cmode runtime value hmfs

[1] https://lore.kernel.org/netdev/20240903031948.78006-1-saeed@kernel.org/
[2] https://lore.kernel.org/all/20250102181415.1477316-1-tariqt@nvidia.com/

Regards,
Tariq

Moshe Shemesh (13):
  net/mlx5: fs, add HWS root namespace functions
  net/mlx5: fs, add HWS flow table API functions
  net/mlx5: fs, add HWS flow group API functions
  net/mlx5: fs, add HWS actions pool
  net/mlx5: fs, add HWS packet reformat API function
  net/mlx5: fs, add HWS modify header API function
  net/mlx5: fs, manage flow counters HWS action sharing by refcount
  net/mlx5: fs, add dest table cache
  net/mlx5: fs, add HWS fte API functions
  net/mlx5: fs, add support for dest vport HWS action
  net/mlx5: fs, set create match definer to not supported by HWS
  net/mlx5: fs, add HWS get capabilities
  net/mlx5: fs, add HWS to steering mode options

 .../net/ethernet/mellanox/mlx5/core/Makefile  |    5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   50 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   62 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c |   42 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c |    5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |    5 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 1363 +++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   80 +
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  449 ++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |   73 +
 include/linux/mlx5/mlx5_ifc.h                 |    1 +
 11 files changed, 2077 insertions(+), 58 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h


base-commit: 49afc040f4d707a4149a05180edc42bc590641a4
-- 
2.45.0


