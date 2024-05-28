Return-Path: <netdev+bounces-98623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D8E8D1EC9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E26B284340
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403616F8FD;
	Tue, 28 May 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GottMPVQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29916F8E9
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906564; cv=fail; b=e5kf85RaTIIWRDts3ZciFJuczH2lBwCxJJNGcKnLRenFUFx0HHWRUPeYZKKx85ji/jZFmShmCMEsfYNF/hQXu3vw6Wi4MPC+bzXG7XRI6i1SaRk1JFHSlZXHtr3c9SNWjYLTHFd9JprhT+m7Ri3DuEezBkyYhqU0i025M7ujdPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906564; c=relaxed/simple;
	bh=Q+MbqovZF4E26lDqhwE/fRtaUDAafAVSgUFb7WkVZ4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvH4iDnvZ9jLiyp6FjhhLkuxSJZXE8t6UFOUrn7F9s7yUSpbtAphSzCOpvJ/tQ233yiypmynjYq5z96tDdsaxpHKKGSqyq+W5fEmdLEH1UQ3Zh5RY9c+Jd41tOxXCKzMvP1kp34zmgDgedaq2SYHC6KkgE2lNKgkvKwcs9YjxYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GottMPVQ; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY8d26j20TN9IOAZ0KJZflEOidgow1vqZmNpECkdu32P8XeWfNVy1vfCLrsbgE4p9wQW+ZedyI1l2AAPI21wjLtHwvHtk5GTHNE6N9MfrsPq+0djX1j4lI5BFVtpSZPPVp0o9afSP8sm4I9611mIOkBmCid4ZabhEHg0u77+7/xnB8iXan225kycLkPd7zxnk/wGwkhyTW5mqXTj1jEQblI4evpFSrknHp0duV81Nko3r2FmHVO3bMzFuhkV+STj5ShcPoayKjyd/e9gHAreaXkfRw8qs+wjJ8q6I6C4Kudso7F++6Tic5DiWvhRHN2KirR+ieTtqyZkupFw+9IAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tSMP5kFwkepLg7SQyMXrbCtxRdlUiX4vGsYPBblrdQ=;
 b=V/jLkPqpZqSWUTSqZBAQfXuq7TL/xDubQigHtLy7rnLFSDOD7DPZHwMSnNgEORBHq/lI9bYjpPGy+/7cOcvUjd/Ih6BygbSW/295VH5fYgYBLZidgWBJ9Jk7y2lxuKrDSCDt/wsyN1NOMPdrp2s76ebDvrU8nsZ5Iyc3oKOYyy20kOc/iv9AXnXywwoTL/6jJ9jCKy4u4R9F6nCqy43zNjKFUVyVqPX7SkljV0rn7c22mcg9POy1F44jOLwTli6niUDw4rd9nO9CvoAzVK70WlMKIwfCfycmy7EnbCHTnd5T/vGrGrVuzOlHZMR7ECDsr1vayTA0YWxAC9130cX3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tSMP5kFwkepLg7SQyMXrbCtxRdlUiX4vGsYPBblrdQ=;
 b=GottMPVQqCNDbNwlIFRSRwX6gUgRhlbp/bv7vDqCvN89nxfTn/wncyrrt+YVjAoxyhnWVIJeHnZ07FaHWD9jzo+aqtFZLGF4mimqECUG0NgWmvYfsZHr/qjBPC3OBvWTqj3VLHvMrksv3+COQIZXNZH6hCozh8FBkwvKXdDGQQTteqNHQwMKuF4c5BKwecsA6D1T0jVSH7WW1V5pGwTAkXqn0VzSTBZh1AksZ56UQUexZzuVh68yisnej+oIARNGbRaVKmZ1HZWvIbOQoB6wb4IxA/e7wGvOzTLZiWqr7m8GvYn47YjJsuyJLdZDHMkll6vKpRVrPRcFRYoagx7jhw==
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:29:19 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::e) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:28:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:28:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:28:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 00/15] net/mlx5e: SHAMPO, Enable HW GRO once more
Date: Tue, 28 May 2024 17:27:52 +0300
Message-ID: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c37ccc1-ac83-46f6-05e4-08dc7f228e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wViIWJlD+ps/yvq2TSHfWl377FCWXrzOWmsJ/8xAbzzKxid9kaCGR6R+cLhB?=
 =?us-ascii?Q?cSgUT1QYzZGmh6M3z1SpX95fhlA8Nw0QI4bRfVkbmvQYd+axe6WKv112VF9F?=
 =?us-ascii?Q?CIiNt7vEzwNTBCf0FoCbP6UX/uJcuJWpFBvQL/whnE5gOFFOlg7UAKoBWtBq?=
 =?us-ascii?Q?nYJiqqp3YBtHnuoFi+su6OSztUlPw9+cPqq+GEZ8Hny8Ten9f1aBFM12BRln?=
 =?us-ascii?Q?cBiIh8tyq3mFexOMGjdeKtZEBtrO5XRKPxHjsMfOiFVApEfb8I3Z2UXqB3b8?=
 =?us-ascii?Q?qVTTyoy2DqETnn8veH0Un7Otsl/K3DUxwdqlHhRvZFLRBsJ2NNOBd2kHHLtG?=
 =?us-ascii?Q?YPczsIFzxxl2dqh2OCgqYWfeONOFtZcci2AexVTfHo04PJQIUbRKJBEMA1Ez?=
 =?us-ascii?Q?3FSbMCbUg0FzP+mURNyv3eDsPR1L8zd5EcFU1AyDS2AU8+/+/6b18utmUF8L?=
 =?us-ascii?Q?eJeITfIFN+BXB/M02GxiyKRRyhTfHLtPZNSmMSc9W0KaHiFCNChpBWJaUm5j?=
 =?us-ascii?Q?DxXfPlQOpggsLlP4P/VAfJmb2J+SiMiKDayYn9G+oGf99+aqovneuq+GBcP+?=
 =?us-ascii?Q?0ZhxsyRE6DheSDSzL+9a1Fq7h1K1qo3nZvK+ILuidElEH1pakX144fNPWrc2?=
 =?us-ascii?Q?9TBjPK1zdY7gsfPrxE0MjqmdJ+/s1urdIUH+OsAF2y426Ny1mye7EvsMXWrA?=
 =?us-ascii?Q?1Oz+MSMlFIJvi7r4f25mHTtbbCgV2Gv8q9LKJHnujeSVFWSt2B6EdDeF3AKP?=
 =?us-ascii?Q?Ovhqj6h2SIPMTHbWSf/s4RnkOsV062R0HTTIQUmk1Qqk45hmE1sMRbOHQEoG?=
 =?us-ascii?Q?TY2L91e8ARQBUGzjA5vA8i2o9fXLMIjVDbMfDOgNGjskFQQhUkw8/ycrNQ+I?=
 =?us-ascii?Q?ArSS5ZIXcSY+vpi+OvgyqK+emoiWaIDgREAY9TTHpiAqfF8UXrhwbJswLiIH?=
 =?us-ascii?Q?jcrHdXA8I9G1b+dIAjRxZ51JOj434nqMRTMotHIwh0eSoplIOv/CjmiEyeq2?=
 =?us-ascii?Q?hnhlPvA4cNtJQs+GRS3EEQCZPcVhWHurzFDgzRbW7Si3VAIbaDkiadv/Kt58?=
 =?us-ascii?Q?9WMY4zDllnWu/56buJiVgen6Un/zqhgxAH6Mhu6T32S7Qs2QN0cKzeodRsD2?=
 =?us-ascii?Q?bpmCLNuyEYp0s7zfINikNjb5/Ck3kUJIkUKC0UxCp1U34gk/2fbFWLsNJi1j?=
 =?us-ascii?Q?y2EASi1xdzVdoCHcoIjO6BEstM8vZKm3NBNph/SQMzbOemzpyCEiBJ4dwzgS?=
 =?us-ascii?Q?G9c7S9dMTOFABk+Sa98eRCEHGWtvtkJFZi7YsCklZTUP0G+BDvIuAwwva1R0?=
 =?us-ascii?Q?Z1Z5Vy8A6shrfQ1hHpyq4dML7H9pS/S2SILotNdVU17hPxIHkXCRipHh9Ptu?=
 =?us-ascii?Q?I18L0DfRaNd49akcJXYjA9+Kun2i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:17.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c37ccc1-ac83-46f6-05e4-08dc7f228e59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

This series enables hardware GRO for ConnectX-7 and newer NICs.
SHAMPO stands for Split Header And Merge Payload Offload.

The first part of the series contains important fixes and improvements.

The second part reworks the HW GRO counters.

Lastly, HW GRO is perf optimized and enabled.

Here are the bandwidth numbers for a simple iperf3 test over a single rq
where the application and irq are pinned to the same CPU:

+---------+--------+--------+-----------+-------------+
| streams | SW GRO | HW GRO | Unit      | Improvement |
+---------+--------+--------+-----------+-------------+
| 1       | 36     | 57     | Gbits/sec |    1.6 x    |
| 4       | 34     | 50     | Gbits/sec |    1.5 x    |
| 8       | 31     | 43     | Gbits/sec |    1.4 x    |
+---------+--------+--------+-----------+-------------+

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Series generated against:
commit de31e96cf423 ("net/core: move the lockdep-init of sk_callback_lock to sk_init_common()")

Thanks,
Tariq.


Dragos Tatulea (11):
  net/mlx5e: SHAMPO, Fix incorrect page release
  net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
  net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
  net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
  net/mlx5e: SHAMPO, Simplify header page release in teardown
  net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
  net/mlx5e: SHAMPO, Make GRO counters more precise
  net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
  net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split
  net/mlx5e: SHAMPO, Add header-only ethtool counters for header data
    split
  net/mlx5e: SHAMPO, Coalesce skb fragments to page size

Tariq Toukan (1):
  net/mlx5e: SHAMPO, Use net_prefetch API

Yoray Zack (3):
  net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
  net/mlx5e: SHAMPO, Use KSMs instead of KLMs
  net/mlx5e: SHAMPO, Re-enable HW-GRO

 .../ethernet/mellanox/mlx5/counters.rst       |  34 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  22 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  12 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  19 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  71 ++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 205 ++++++++----------
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  11 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  10 +-
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |  16 +-
 10 files changed, 223 insertions(+), 178 deletions(-)

-- 
2.31.1


