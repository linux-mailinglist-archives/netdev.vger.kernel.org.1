Return-Path: <netdev+bounces-152191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9329F30B4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9A7A192A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277A202F97;
	Mon, 16 Dec 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZoDWzOFj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F41B2194
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352871; cv=fail; b=faOfCMjpnM+CDu+xLawY7HwarTZoIN8BXOV28SueD80SE91Y68Z3O3754X8juImXTSQkVbugnUHA6zUHriDaMPt2uXkhxU/QJSnoMpYdSr91F1B/q57aBvv3FlvKo58zYtTrbnrr7eeLWwvOWgdFZRuQ2vimYdrGo7C/cwivE9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352871; c=relaxed/simple;
	bh=2kQDbNpfMUMgU7jIO74YULXFCXIi/yFjqc4NF7DfY4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNYK0HhXvxI/odU23XLjxtwiGjqgAYvN6iyvMZJJFFWmWDXhqcVOe2BCph67P1dDTRLXuxmUlNj3U+08ULYOltjFnPg051NKhXhbnxC36XrtM/l95GA3H1cw2BgQVB2KYqt8UiXAOnM4fDBiiZRMmWiBDOn7h18gcPCGXwk/j+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZoDWzOFj; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ24bvUHADEauWOsDZJxsFKeDCYJYvG57dBZq474HlWd5wjq4M44qE/B30KyPb9AxWnL7t/97jX72XfcuCn7cmXMPSeYLl3r5MBVj1J/IBjEA7WfJpavSBH4onqa9pFUec9NW7GJZ8YESzFPJp/xw2kSLS2+gkmq2eS+cEzxzY7JDvjIguJFa5mSpJTaR+VTq7faRrA3JVochcoGK/f3mRQrkn0Jv1STgStu7aaKFdRYKrfyFwK+8N4SANmXFemYQreR4/QamCzFxIRirC5jqHO+WRToUNBAEAswFibm2/9x0wEOJfHCqyrzJsHLtqfNKbCtCNEajAaw7KsQB6u1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty035XY2Or1pjUqlQRXTFoaJFDNzzCN50ID7cJIl4qM=;
 b=y9cmwb2a/Uxaur2XUx0uG5Zo5yhhN0D+sEmaKqpSpct25B1ceJSrMjubsgmKsVXUTPfIexlUNrR78Yb48GeogsqMLrRmIaYea5BPsoSMFV2X37ToL8at65xcwGXRb3qhI2bU64Aq7OYAzxNKS5Kz1wzREZEJlZcanscSLRgLU1Fk4t7XLYNn4KjRoWWhMBguCBw4BL7OspL180YaubrXDks1y/dXYgTaGPAORsKcKr1ibpQSFdSC1R/JjJEshjZLi4MHF80MTjdlIIYVb9M2lRNlwFai9hyrRLR6Tl2u5vQDDHnHqUDmh5TQa5SdATtLVzyYoqZPKq5r2SbJnTHXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty035XY2Or1pjUqlQRXTFoaJFDNzzCN50ID7cJIl4qM=;
 b=ZoDWzOFjqSU2eKktzeDVLUS4zAJo2scupBfxAhVNz8lDMdnInbmhNKBZ6BExifvbsmipcwJifoKfqjwuVW0Rq1uPm3L52B0/E4+qYq+BEr+Oc9jFeyjXcMKSXCeOnqAyty2CfGiqVcye+hZS0E4tS10KFpqOLcIv2lBA0RIlY3FmuTv53n4bD/S+xtkpf03HnzcP/9fxrHLfl6BCrzLfUsvnGNeAHtPa4djI9PSELTf1TAMfn/gwhW3h5zOAGV8XHFM4LVt2IpmIYcFTg22Bl4YCuwaPy5mI0vhzBzQTHBnn4YtgjGZji6euPsVSgPG7zobdbqSwDuMGfo6s7O92AQ==
Received: from CH2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:52::27)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 12:41:06 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::33) by CH2PR04CA0017.outlook.office365.com
 (2603:10b6:610:52::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 12:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 12:41:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 04:40:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 04:40:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 16 Dec
 2024 04:40:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [pull-request] mlx5-next 2024-12-16
Date: Mon, 16 Dec 2024 14:40:28 +0200
Message-ID: <20241216124028.973763-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: f42c297c-a84d-4b46-9bfc-08dd1dcee8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fx+LcY1PKmvyLhPCGKqL0HGpdaknB9bsCBQdOAbgCJLS1ttLCVZTF3+ik558?=
 =?us-ascii?Q?bsb2CPfIN88kTUvaeK8k/VI+1xhF3vv2KcdriXjuVTy8egkJoZAn2sp3uH9l?=
 =?us-ascii?Q?z2g8MCBExMKWz519YQBeIlwffY/sJFyzJAqxoEVoK0ATFFOwdq3e6x/65OaF?=
 =?us-ascii?Q?W0qZgAsNZXBdJg2vtqPcwrlJYBjyacnqUwgfiEM2EDwsXdPKoMHAg9w3HCfk?=
 =?us-ascii?Q?NMsETxqHx0f3jTar3tnfNfODjVRW1nw7uIX1aV+/K1RulACsFHQT6AjYv3mc?=
 =?us-ascii?Q?dC9WWKqW1+C1cB+FUM7ZXgyucvs54wHOhHaBuMa4n1GCt/EY28wmlFCk1Ly4?=
 =?us-ascii?Q?Os/zNkpwh/31/m4xtqobckXt2hMn3xUZpwqVOzW3WRQ/U3hHtr8+RUiKi77u?=
 =?us-ascii?Q?89BpxmxQvgRQmgDtmDVgoAZQ1Qnw1vzAkVQazG4RH1wujNhc+RqPrJiJwwZe?=
 =?us-ascii?Q?0GMw4H8Fb8sNE6ldQWat0I/l7xMMpjeqb/GSwoihN9WYnFhhUc1J5aTsj8ED?=
 =?us-ascii?Q?wE2DKCfm10LFrrpjElvI8H+cfHuyzjoDCMhbJuM3Xed8NF3dsNqXGhuHoWk8?=
 =?us-ascii?Q?bE0c+cmAqJeEdjD5wzooAdMPkX7jrP0Q2FwSMjULQIHlCXyS0EMWrQ95ueZ3?=
 =?us-ascii?Q?w27kHp+svQx8RQLoU3et9Sl+NRV97c5Y0mmjJXXVp8St6uCuvSlIhvV8yOgq?=
 =?us-ascii?Q?APHYtih/ua6No0knAQ8at/d8nZJCnE3GYptzi+SrOT05N5fvp2JCg2e9yzG0?=
 =?us-ascii?Q?nZs0aPPxr4I0boIHu7hf4FpO+Vp/2B8EWhr63O8cbRCzUMw/0KcsjqgNO9ew?=
 =?us-ascii?Q?Vm2Nzt5RVB03kScIqGQqIRjq+CXQUZ68b/Q9icbmrHIVyThapW1nLVVhb1sd?=
 =?us-ascii?Q?bXQt4SqePHN+SpJ5/5hnJcVwwW+owEuzDFJG548vN/DdYLPcwvki5Zb/uAG1?=
 =?us-ascii?Q?CW+y2mvxDWVSBT/P/wyRlP5M6xTB7hwsc9HNQ9ASOiCQizmYg3whhb9mofVA?=
 =?us-ascii?Q?9+Y8Hq4PAw8OZ3F8grgGz+kHmB67DwNsgK2s+KUe7v1o2wWvj+ZyxGSGWpg1?=
 =?us-ascii?Q?HrEAPYCn/yu0cbQKkH9TmYYl8n7JOnD6BVqSpaxPal+8MypL4dK7kkBhjr8W?=
 =?us-ascii?Q?CJ2xR3QLmdkOfFiV8Rn9gZNnJXuz6jREalkN3tsPFa3QG/C6YCAnNUyTkJ7e?=
 =?us-ascii?Q?AzPU2diyOWX4AxzJrHUqG9bcfpAJJJrS7TCaFkPARJoh98EgjkJ5c7iM93k7?=
 =?us-ascii?Q?gpMlOLvwAGpMRu6zCzmlF/da6qsn1XxMgWF38lBQggb1zSU6bsVTB/lZb3WX?=
 =?us-ascii?Q?/b83LqRJFsc2lrBC+U7Ni6Y6GnwQEtKaYViTxV2OwgbA1aZfCJHujLow78kF?=
 =?us-ascii?Q?9hUN2QVkbptw89wb1yYDeW3n25VIt7Rh0YTUp9qjL8IfRx7lfvy8XpL4Z40X?=
 =?us-ascii?Q?zcxLQy/3NANO/MDV+WLeHW15Axb1uJ4OoN6vMgBe7OBderRNIuByv6WcWkwo?=
 =?us-ascii?Q?FpOjEHnwhFLVbzg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:41:06.0452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c297c-a84d-4b46-9bfc-08dd1dcee8c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

Hi,

The following pull-request contains mlx5 IFC updates for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to aeb3ec99026979287266e4b5a1194789c1488c1a:

  net/mlx5: Add device cap abs_native_port_num (2024-12-16 02:29:16 -0500)

----------------------------------------------------------------
Carolina Jubran (1):
      net/mlx5: Add support for new scheduling elements

Cosmin Ratiu (2):
      net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
      net/mlx5: qos: Add ifc support for cross-esw scheduling

Rongwei Liu (1):
      net/mlx5: Add device cap abs_native_port_num

Yevgeny Kliteynik (1):
      net/mlx5: Add ConnectX-8 device to ifc

 drivers/net/ethernet/mellanox/mlx5/core/rl.c |  4 ++
 include/linux/mlx5/mlx5_ifc.h                | 59 ++++++++++++++++++----------
 2 files changed, 43 insertions(+), 20 deletions(-)

