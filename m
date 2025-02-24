Return-Path: <netdev+bounces-169201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACFA42F03
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2DC3AE5D6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2641D6DB9;
	Mon, 24 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MaMjK7L3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78341DB375
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432354; cv=fail; b=Emal4WMTpf4vguCwaUwKdqccyCVHkfa3xiaKh6Coa2Z9RoomOqQzfbJvP7d+5mTTK+viFNP7xt2dFN4XLIcQPJnM6ekeZgdbxSqp7SxchaWMmUxPZavCAKFgz1gQfihZmW9L9oFxHB59WEj2bZNWadK/byqWiQjOnK+VamOR278=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432354; c=relaxed/simple;
	bh=/gGhrNvu1kAFHgDSvnuOojkobRnv24rkylnAMz3PYys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V99ih5ZPiTIQHgcSoYVZqyF/vl2/DIR/vWlYfGPiSQrfuD13eWm0IWUTyPuHkrxrSvtQMS1QqUMAPtEFEFwADsucsO85yt+Q8Glk8V/vTZOH7DrHMhRcJMtzibfNoaOCPFMrEOTKuz1Qfj1EbFdThOn/tN8Zzldx87YUj2KBylU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MaMjK7L3; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azr4UUqZNPme0T0q+v9GKO+naetC2voz5LdLS7L6X0BUYHMnAEiH3LLSanRa9eC45QPjhr441QSOsSlInrrcwd6XXeTnZBJ+StPz5kBlQ98Pfb2lPcYAvdm+ot6QzgnAdvO12eGyTnwgJQ6cbZG9KgHcUFknu+UxUaEZZdDeQlZCp1a2PPhT6aeP+SR7fD7ime+hjoB86tgLJfd18Gb4+Wa/lFJmb53z5QKIqwcCjpGyTc8WyVNnWGE8GpfhLAGhMlhn5xmYElxlK2AEKx5nLFTCWpuBYLgv6Pq/EcJpHr76VCGE1/COqQmMtOgKe848PLfTrrmvp6OJ0SAEsUA+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSb+ZOQgSI15J8FaPdX8MsaBbZj8jH0SrIS6ExmeeT8=;
 b=G3gGpYx/DQI8vqOeaSc2OqqcgmKlquvCnr3xEFQ9tBFuv1Y98sn+cQZb5LuSfKXoQM7/sn3T5VTdrn2hIE2P3Wz69RmJVatfT/Kd97pBD2IbhGkdpeeAbdpDqWTRP5l098/23vRy0eJwSBf/YD8JAuVm5zEPmpFMWk19A1exYKjQmMqjY6rIszen3KS7l1QuQK2iorgUEtf+N/bmBj77zBS2QYxzqfh54kPFcydMdX92RhhMZaur+6hOI5JRxlt64iKtB4bduJSKm2AszBHZ1sgP+S86AE5frH3M55Vwq68pcwKP4J1GsrncsH92t9QmLBnd4aSMZV36xQvNFpjKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSb+ZOQgSI15J8FaPdX8MsaBbZj8jH0SrIS6ExmeeT8=;
 b=MaMjK7L35mWIJaZirF7PhCdu/s7Qrr04Xmm3X/t03Wil3x+TVL6oQV4cezuyiJBGfKKK10ZfhylyabgbOLldiYMAod60/wZMsRz70ZJA+ukFaO4RjNW4aQJLrWvA03pf4YI3K2oJrPVvrZiovWYXmKdgFMeSH1lamSLN6D/NT4FGJQYvUWk7yKBOvzfD3T5Aqq9ZQMTKo8hzThpPhpyJ1WnF65isvwWd0os6XYxp36a1N2TcZlBZHj0CghgGhp/ybq5Q+Al9pY7a94//P9sMRDPZc/pgj5gGgkOLo8VxirtKuRhnxEGZBsFer7Xstgy2BLjwONaW9FQc0XNldOJRPg==
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Mon, 24 Feb
 2025 21:25:41 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:b4:cafe::55) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 21:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 21:25:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 13:25:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 13:25:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 13:25:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-02-24
Date: Mon, 24 Feb 2025 23:24:46 +0200
Message-ID: <20250224212446.523259-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f869ce-ede5-49e3-5485-08dd5519c9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJUZa6pBe/WNJ1H3xtFbykW/DrrGvDH0pWN6ukw3XgQEhDbfjHwCQeg5VhdS?=
 =?us-ascii?Q?v1v0OEQVswF1M6hLoUVrzJmLwepWjeycwr/5jtdDgJGY773IvweX37qHZk2T?=
 =?us-ascii?Q?oABk169ejbstzLnPP+pVL18DoU1R0Me5agfFohBpgKz2ue3wWWDMw75AkxZd?=
 =?us-ascii?Q?M95mFpRHIzqiMZYwkMLoFNBolJnkhquE66DzHidDUPKxL5cwiYIHSjiwVm90?=
 =?us-ascii?Q?w81UoWZXY3BiNDUmBs471ZlwgJPkJKhORvSKPGZSbc53njg49Mw2Kaf/dBVf?=
 =?us-ascii?Q?/tYzE+ul72tK6/U1Oe905NK+6RLV9v2bD9qOFvN7Bs1FJCsZx2ze0vj8zzPR?=
 =?us-ascii?Q?hO63EuG0JKW9bzHkHiJbURoY/jT0xyrhNCFbftmhLWmX6JDpKW2GM5G/O7G8?=
 =?us-ascii?Q?AmlDYIC2wlXrzLUx1jlXFg8txUp0yt/MBHYJKvbmgxch4M+l72V2p8S2Sk9U?=
 =?us-ascii?Q?fGwNm6qpZRGaRucxyES4KMSsq+0tU8H2oo4pUG5JxXdHE6GjJWmoPrkwgGVW?=
 =?us-ascii?Q?Kh4y6B2YBjd4UGq3iC6+q3WXA0WpaxIPqfD1kE8n76dPj0wRFZ/TUk8bSPOC?=
 =?us-ascii?Q?eo2decu9xmtbfgFPcIJ+gl6PJGylTxBGFZ+ru14jLbCWzT8dhYxxjr1EibnZ?=
 =?us-ascii?Q?Iwd5sAyvwHO5BXJtL2boLEvusHExq7/g7GxUMyKwSnSGxpAHHm+cWhiUHEx8?=
 =?us-ascii?Q?Z83Cj5kxHp0AkBMM2/lss7R4fQh/jPxAuacHoq903p2R8X8YqmkTeDWQm7EU?=
 =?us-ascii?Q?bSsvsePQ475AGcMI1xN+iA7Adl26NyOxsNqySKTNlrZqRsKVNnwBUOesQmJY?=
 =?us-ascii?Q?ysSR1zuG6sU9UGZieZqbaqFE865qP1WEWI0hs6mZqOZknmyE83YuB1nYBrYG?=
 =?us-ascii?Q?svDlu5lbtzIDI+ady74vPEp64VM9wpj96Xkk1CsFUgKFfz/Obz2ZS+/jvyl6?=
 =?us-ascii?Q?xNAThket+ifVejbMj1BSSMu/18l0efrraSb9Pcn1memgL2pLcOZYMCB5ZYfL?=
 =?us-ascii?Q?PnVr4fMUSlsijJfdfJ7MCfRJWS6rRca1TinWakBe+BrQNaDrYrqEklfqEn/F?=
 =?us-ascii?Q?py8dAdnkgZh8v4mPCnXdaU/yEXpo9q2hmcHMkttjLATbk5Ofqh1wZkzWiQ4R?=
 =?us-ascii?Q?a7l6UcjjBpfgofmvLl1zY6xYP0uILwH9aBzNSjR408SrSmLWmf3G03wjtad9?=
 =?us-ascii?Q?Eygf0n2eav/FYdYRU/ATUvcw72DIurfjZpYvqqpoCEWFTVtXleWL8/BxsyxG?=
 =?us-ascii?Q?0yxV7Su6ooEYU/XpLKycuxWLS1qDcRyc5sHnzQs2Fyf8Ru/53tQlG3tbLGLf?=
 =?us-ascii?Q?N8f+mwjYFj2KavDtqbSCSgBHSH1dv3PvrHewhpNVrNSQuj34+gZPFREyHJNI?=
 =?us-ascii?Q?onki0BX31MrTz0R7ytl3s4CgWH2wiuVVn9d6uAFjnocKf/P6OHuYvih3tU1F?=
 =?us-ascii?Q?CzNhbNHHaHbOa+rYtKPghzks2R3IQT5S61IwMfUPJsvRHKqKEV91EGI0L1+L?=
 =?us-ascii?Q?U9uI6YNjLM3U4d0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:25:40.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f869ce-ede5-49e3-5485-08dd5519c9e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

Hi,

The following pull-request contains common mlx5 updates for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 80df31f384b4146a62a01b3d4beb376cc7b9a89e:

  net/mlx5: Change POOL_NEXT_SIZE define value and make it global (2025-02-23 04:43:14 -0500)

----------------------------------------------------------------
Patrisious Haddad (1):
      net/mlx5: Change POOL_NEXT_SIZE define value and make it global

Shahar Shitrit (1):
      net/mlx5: Add new health syndrome error and crr bit offset

 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c    | 6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h    | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 3 ++-
 include/linux/mlx5/device.h                             | 1 +
 include/linux/mlx5/fs.h                                 | 2 ++
 include/linux/mlx5/mlx5_ifc.h                           | 1 +
 7 files changed, 11 insertions(+), 6 deletions(-)

