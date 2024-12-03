Return-Path: <netdev+bounces-148677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A369F9E2D8A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640A7283D78
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CF20125D;
	Tue,  3 Dec 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuOnHNUG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420E2500D3
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259014; cv=fail; b=JT+fYiQz80HYVwSoXjEAb+sei7Q2DzaOimn85sGd1YhDlbWAVG+4uotUpYnJf34zx5+dip/frSBDW6aEA/C79vciGLCo1S66msdQEJur3kyCN8waHvT2Kxo051iBAj+oXH4fHt/cDjsZBhQ0Y6Y00cLyQ158AyJNPSZbqxP3MrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259014; c=relaxed/simple;
	bh=Gu5psmX8F11OrYntPEa5SPtmpwLaoBzqd76nJ3q9Tko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nECFH2EjnXbAq7id1C+P+izhO2K6HeIOa3ZuA/tx0DoTFqDijLsG+RyaUoe99t34HU/fLPjEMRtKhJFkmz1+0bBjWlBvBSRZqZB2wYQ0xecRDCd4O4eY0xC6H+FrzwAyS2+Ah7uOkzKYo9uGM6dFCJ+yQeDSyaUVIREVcvKOWjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XuOnHNUG; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5A5HhLV7VBuyWzTH8r2LUTSYw9t804qMt3SCHs3wRTGJ60aMlTp1TGNM9y5W7g5UeUBu4uoMQ9EOK/Xb8/vfzwMpvoeSCUjMEWH18c0h0cFD/gn/G08egOYtAUZfvrdLusRLt8VseUPYQReBIK7lYLf6kTexyvr9DZ6m7AYeySh623LWi0FbgPcvyBmehch7NdbuceJ9JzCl3deZvHcBMYnS1UWR5G0I1vMvoWDI0UD84U1VXSzkpTJInzIyTfouEaoZ7eFgZbLjQ62SM1/tvb/yGFTixy+d6/a4GpasJAvOZX/os2iRYmZFpmyR+m+z0hBJW5RQmGfXCZ8YrMZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPJvVukk7pKgKYOpPMT8PhNvVrWD/adITyXEuiqBJdM=;
 b=Oci14IxJ9Yfkeg5840b9dj3wGvCsM5B6OW5ag0WsZzSW5DIam6lSljX5YH/LiYEaNK3+rDHkUinZ27WoZfU1LxnFg0y9SgVLkWbR5SI15hHqpP79hy9Kj4Wh2gdHET+BsPA27LUOO7b1rJg07l8bQ2dRkIRVik86v5A1NTPF7dlWOuS+60X7GkGvlJ2etL2SWIs0/vXHW6l9lppYHFozg7yOhRnk3az6R4h2yrzCaJKYIubPasxP6AhlmNW09HhKPRjDht6qn1rkVGfPEeM2xS9cgQpK/rmJ0rVz34Kueb46KfoXJZ3YSTZmzuwDzCRG63t0T3OIxp5N0utRhFPaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPJvVukk7pKgKYOpPMT8PhNvVrWD/adITyXEuiqBJdM=;
 b=XuOnHNUGg05n2/NwgkIQwxj6p28Kfx3pqwAUlc8QnA6M3z1OMv2N3zkjv9hhJcY8CZ68Jt0JurBtWGFc0/iD0cc/zDCCp3GC6q4AHBhioHkk7SjZmV3SyuZsz0LqdjxEHTae/aI6jzQyoSfKh9w4Q+Lfgyo4iYnnGoTAUO5u2QHIjALV5HxhJqvy0GakpB0OEpdK7QDo0byOElHfzpN9DaToB+I0RwWPT/9+jZ5885WKbRS3LiyHqDbGdIBrbjVuGWrREcNXp1PeHdHt0McY9PdXTxNhXGymh1qFd0PxnSSwiHvOlGyzUzesIbvB1cuoiFhbaPsv/zLxX0xXNQ7DTQ==
Received: from CH2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:610:60::15)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:50:06 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::e3) by CH2PR14CA0005.outlook.office365.com
 (2603:10b6:610:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 20:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:51 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:49:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/6] mlx5 misc fixes 2024-12-03
Date: Tue, 3 Dec 2024 22:49:14 +0200
Message-ID: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: f076f3e1-5129-4a6c-c9eb-08dd13dc113c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wg28Gkmhn8pFgsToIH43RMI9svJjS3jC5IMwTp/TLHDVYOUdTF713wc4gAIT?=
 =?us-ascii?Q?ZTVATIq1q2NwpgHOxers/AV6BgBcKTD73716TRW0feirxcvgxcOILGjc7tlM?=
 =?us-ascii?Q?yCNyic5x5qU8Lv3evhJS9Db98prBzMBzbkDAFpwTjONVwmmV9D1K82VnxYBc?=
 =?us-ascii?Q?skIGUxlDeWfxUj+Jbv3i/Nr/jTlgrkS7Mxl3v2gnCx88/LBZfzyZ5NLneVeV?=
 =?us-ascii?Q?G33oGSwxR4r380ozucptRv6LoEMPa3xisCMaEV0+6UxfNI8O2Qy+6MZM8M+I?=
 =?us-ascii?Q?XlZSz6svbDUKaF8jvs92C6ldqIjX3GkPhHV+vlDtDZrR8qUI6V3bLOO7U51I?=
 =?us-ascii?Q?DKgd8apz5Y/QaaMecKXWPMxNPW3kXbNPLIHxlhPG1ZQq050HEKbue5wk6FYL?=
 =?us-ascii?Q?R+YYRUrEiD4/GdGHdW882XqFjtahkfR6Ego3YnDUgsapfxBpbvm7oz91jPh3?=
 =?us-ascii?Q?yBQuHd+2QJfrSW7dBwv7rZ7s20Xk8jIlGWTpQDaGoIJEGO7OtS8efvj+788Z?=
 =?us-ascii?Q?g2q5miqWBtqc1RaTtuP7bY1tV1Fxsv5bqXspd+KAVgZCV/0B372Con2slHrb?=
 =?us-ascii?Q?546V/H4ToKfkn5Q4UoHrdBmflaL1y4ghhvGyYROMrfsSr243f2j3JHYoZta/?=
 =?us-ascii?Q?2ARUeR/ZqUi0nH4JA6yJQ84OTEHCOyoHs98m7YlLCKpJ2HJa3BSm3Q12HywP?=
 =?us-ascii?Q?5xIYdc6eIdgS3F09p9nZz0/GGnHZfCIb2pCfYGvhCunl1T8FK7RvpeLN2Orx?=
 =?us-ascii?Q?2XV412qwyB4XJdLYx9g5kHBTewl8wT3l7Q9nc8oPIh4otweZgEI04zvOGH86?=
 =?us-ascii?Q?fQ4RK14kW6sIcWaGmIRubnNss1QvpP98y7o5/TBGPCVBGQ+LnIvdHSDKW1xl?=
 =?us-ascii?Q?TRMXKWS42/GOH0EztFK/+vSNk6mthJ7cigJ4zK6acBQuYmzNg3hZbdCQnkiR?=
 =?us-ascii?Q?Q6sEwwf5dC7IkoSJNQy0PtEAuSoCXLaGXsbe3xoP6HUXqRvsOTqtFjlMeE+7?=
 =?us-ascii?Q?Bp0pqAqBOc6Sqo8Ykf6CwvEHtZFJexegxv5mK3GLsnce97Plbha4uxM3HByw?=
 =?us-ascii?Q?7XXmv29CDdwhlPuIRztyJ9QPnpp+ItuKAeoQKXfar636EMpfbD/v4qrDHlh0?=
 =?us-ascii?Q?VbqCWaME5foZSXBnnbpGi9XTDHFZudm7ONoher8xZ5PE+tl5pg/qGvRj+MfM?=
 =?us-ascii?Q?bMOISiPSnttQ9Zvu7lc+CnGmTkws6Doe4gB84W5gkCmNAHcotJV2G/ZMqDGu?=
 =?us-ascii?Q?MRmoChn9aNF86JEryjXwgTE6np2SC3F1N/ntzz6JFxdQ6rAoJYZG/FBYrl+E?=
 =?us-ascii?Q?bZIIQCwa7/1ikpUhcLNUTxU7QaN/FRZuM7oBBFQTnziMCbyZfX1e/O0yO3XK?=
 =?us-ascii?Q?z+d9BBmmNiFAy0knuJUM4hsVlicoqLjOF4oj1kRYHdY0ZbfvO3XfJVTnvFaG?=
 =?us-ascii?Q?zBAojZS3EN+BjDpv/O9x4FZ7ShLtrTz7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:05.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f076f3e1-5129-4a6c-c9eb-08dd13dc113c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Series generated against:
commit af8edaeddbc5 ("net: hsr: must allocate more bytes for RedBox support")

Thanks,
Tariq.


Cosmin Ratiu (2):
  net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
  net/mlx5: HWS: Properly set bwc queue locks lock classes

Jianbo Liu (1):
  net/mlx5e: Remove workaround to avoid syndrome for internal port

Patrisious Haddad (2):
  net/mlx5: E-Switch, Fix switching to switchdev mode with IB device
    disabled
  net/mlx5: E-Switch, Fix switching to switchdev mode in MPV

Tariq Toukan (1):
  net/mlx5e: SD, Use correct mdev to build channel param

 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 13 ++++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 ++++++++++---------
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 +--
 .../mlx5/core/steering/hws/bwc_complex.c      |  2 ++
 .../mellanox/mlx5/core/steering/hws/send.c    |  1 +
 5 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.44.0


