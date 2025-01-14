Return-Path: <netdev+bounces-158103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FDA1076E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C601887B9A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87A2361EC;
	Tue, 14 Jan 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqUfZo8v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917022361DF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860241; cv=fail; b=NO5zi0J+jI/qFrhlubHLVevT22x47LZKl+fQgnTt8TJ4ruuK6xQlc3lSUIGXQK2z5UdpjKjYLamn9Hxch0LUv/4UqowvbYpNX7qVQNGy8fxk/yLvH7mSyRg2rEt1rBGISBh+zl9eFMKPxEuXYRUkLImiSApHfTWwCsawYjFdjUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860241; c=relaxed/simple;
	bh=+Ipls5NBQ+TqBvMHvskR4kekJwljSYDpfZOv5KHTbyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ab9Ct/1/URWTw9HsAlae4ALCHjWCAVpaPyoVwpPLFA/G/gwjCY+vI1Y0Z3cuBIFrg9tXHyV8TjIpRTTdL+mujnY5LSYiUWhtmVfqwJNGcnDV04dWYM/E5t3vlI16capixoc8xm3LqWY50T3wF7dUEDQZclvKhEvhbwW9B7cTqFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqUfZo8v; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N52+1rQmdrX5PYQqZfy/P/4z1H3DTOklUK2UULFXJBpamdGEF1+ouHe8JKjludJI0QGugCzuGGFHY5tOqfwD8ePLBmU72FHKwIzdC4bdk4oK9g+Thyf1te+kETZEjw69kB6GAa2NuSWUazbLQR2f/b70NwluzG8g1t74TIbT3/396pSZTso/1E07YS5R0/QZtZvAr5ENdueld1xSezrPz90owEGsk1NUujX/4nMSLAuGL1gdXzY0FH57ikj6t4c2TxOQbBsw93GLHJ4F8Jt8DGHYU4flGAEZoEUF8tipgrbLWajWgECKvtrSbnFUW6B0KGW6INEYmwY+i4QWU/264g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfzywTfeC7Ay8PrVDWTALf2mrFird69fZOKBF/5zylo=;
 b=SDVMX0eraAaGh5GW3CrrejX6SA1k5IkgL3LhaciyB91PJNBGYNydzYAdvXMBFYty1LOq6+c49LiypSlJ+c8Ec/waNhj1slf5v0t8V8IkPQ3MEgbwZ8HyUmKubH774UfkBSvz0mAj4S0pRvqKY6qu9g64kyL85DSkwQgwBCk8lGHue19sLZLmQxB7fgAqeVUuB1dtnjsUEtiLXdPFFbeNos1r6Hf+eZHYxh/qRZfqEnZ/uur7lffm6lL9QeuieXcDm2MZVE8eDOiIcVUy3gqqrGv9AfAgPbkyQM2PgL66JllshJuBeIOwk0uvgpYz4PJZq77TuebGvYwWERf/UId7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfzywTfeC7Ay8PrVDWTALf2mrFird69fZOKBF/5zylo=;
 b=OqUfZo8vvNXsmjBoTGnAcljwto56FIq9ZbX4jiLQ0uyI8hU4kPtmzKQp5jo4QhlXD4oegKtR0BmgXBQHLnafKr5IoMhECAT+mLx5cFIQPucPPFxgQ8ufCB/ltbSVT2MnZPB7bFzpoQTszRr6uuNsUiriTi3jv5U99K71tqwJIeo//lJIcUpR5+ejxIvU8K9+PA01fr29j7KL2Am1acfKsLHlLfwEMvYyJSyigo4aiVZ+YrgnFS+suFx645ywAun1zqx9jeoR8N8g0ja3GP33v7WJgNkIgjF0XU0jJ6IX4PkfZ3DdpUwO2aurfg1ORLA9IVtpowTj++PRPBUMHFRQug==
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:10:35 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::92) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 13:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 13:10:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 Jan
 2025 05:10:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/4] net/mlx5e: CT: Add support for hardware steering
Date: Tue, 14 Jan 2025 15:06:42 +0200
Message-ID: <20250114130646.1937192-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: a64d0a5d-6edb-4a99-5963-08dd349cd502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0eYP7niW+0gjlq7FFyIA+GP3GcBmAzgD5ajH6HM1SeavZ/BklwGAL1HhOyTW?=
 =?us-ascii?Q?PdEf/bwEb2Cr0AOA0z5rXcFS5vh0IWMwWoZsowEWNEluyYicsycc/KDZ0TLk?=
 =?us-ascii?Q?HF/xoqzmqpjfqydKiAQn8Lc1hssdIyZtsaVtOeWAfGfRNfc/YnvVCqPgSVJ0?=
 =?us-ascii?Q?3zMolBpuJnGzPHFAEOFlRM1cgX9Y489R4g2sKxg4UuZ5AHIgJ/jhdQv1G4R6?=
 =?us-ascii?Q?278BNy2opAPhonGaYcoFJL9UE8WDJ+1DCVED/FcOJsxj3nwUL6qXxmqB+0mx?=
 =?us-ascii?Q?TA5wj1duMLxOf1dS6sGm9JU3dbvZWqZMirnQzMqnP7VMETIGzdINmW1kvQ9u?=
 =?us-ascii?Q?9h47PBAIXGlVzbzZxvS98JTf5IsEQUyIOLmhWR9QeZtaQrWMkx9PR/mn72Kj?=
 =?us-ascii?Q?XXkhsfYVfb/wfK5D8MNCMFoW2qHo3ga+gNaHfecgfsleWAKNCSJwB78lQTFC?=
 =?us-ascii?Q?Do75phavoTpIsaQT4i5G+pwwcG5ULN5Xhnvkl4Hj5RU2MmyGDJUsfDRK8aOy?=
 =?us-ascii?Q?sdIyoXFA6j93Gvv3EsFMsswX4X25497wAgLtT/GoFrvOT+fcAAcD7+fFjhud?=
 =?us-ascii?Q?GuIIQeTqciVlB//Yc5xygKn9Be2d2oGSDAU+uZ3kdnOpd3SjgLyEEhljjndk?=
 =?us-ascii?Q?9fxNhRicypPYS0f/r7S+CRJ+qC88aPMpcqCf5STKRs7sTl+t/xZDU+wJgS+Y?=
 =?us-ascii?Q?JNZAoRFQmAw53611ZTiR9CutS/u56/TooJ8+sIsJhTkIEkAj8Fhi3nVKzqYU?=
 =?us-ascii?Q?Ei+eRb63X8FHS6YQ+IWQRYj++dyoaQUCa1qKVXQV+VQfPLgOgHqd4l0wDFpz?=
 =?us-ascii?Q?femxaeY7i5phfcTa+jqPD8yZqMInM14DoAWFJm96IFE6/QO9BytEQAq3uS5K?=
 =?us-ascii?Q?AMy+aM81qivgmADTkU74Ou4pX6/AAU5tdE4Fl9Q4lGia/32gxI3a8CFqKUwl?=
 =?us-ascii?Q?aeN9eMD7OqAV49qWunKT136nCaYn1u9fuIFNsfhBX6Ki5HZ7nGlMIlY6MFfN?=
 =?us-ascii?Q?bBe07+lBPe3SLOqaofqssJfL0oQdiMNQkzhaFSqZQVcLxHpBNel568lirhUJ?=
 =?us-ascii?Q?WjHf7dWnPzaHnK+A55r02tm8vlP7wgNhfvLp93OK/oJ0qyuMq6uc/biAexjS?=
 =?us-ascii?Q?USj88lCLiK1qT69Snvu/wTBSI27KY6jnjpema+JyOGziafTmS2krqLLG8Ngm?=
 =?us-ascii?Q?kXOkMP7C0hdNdmkpyEfRCQn9WYcfLb6FmbuSkbYIjywQejwtdpT0NQ0dgjZq?=
 =?us-ascii?Q?2gKoXg7rO57DUBqD76HPKbHMT8vhRf1BwMxafQROfvrUbIPWAPTckXOD6Gxb?=
 =?us-ascii?Q?TkU+3B8UD/tfb/MDCakz1K7GdOrRfRNUd+AeUq744pN5JUwYtS7W1Cla8CVl?=
 =?us-ascii?Q?drETTmTndFyiPkYhM9AYPjg7kZvV79oAr65ka4V+oDPUqtGz0QkEFL+2zgd4?=
 =?us-ascii?Q?RtbdFpx36ifbPl8PeStxY91wiKXxSAlySmv0CjAIjpnMSRL8fduPe3918r03?=
 =?us-ascii?Q?CU/4OPqWdXaV030=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:10:34.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64d0a5d-6edb-4a99-5963-08dd349cd502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

This series start with one more HWS patch by Yevgeny, followed by
patches that add support for connection tracking in hardware steering
mode. It consists of:
- patch #2 hooks up the CT ops for the new mode in the right places.
- patch #3 moves a function into a common file, so it can be reused.
- patch #4 uses the HWS API to implement connection tracking.

The main advantage of hardware steering compared to software steering is
vastly improved performance when adding/removing/updating rules.  Using
the T-Rex traffic generator to initiate multi-million UDP flows per
second, a kernel running with these patches was able to offload ~600K
unique UDP flows per second, a number around ~7x larger than software
steering was able to achieve on the same hardware (256-thread AMD EPYC,
512 GB RAM, ConnectX 7 b2b).

Regards,
Tariq

Cosmin Ratiu (3):
  net/mlx5e: CT: Add initial support for Hardware Steering
  net/mlx5e: CT: Make mlx5_ct_fs_smfs_ct_validate_flow_rule reusable
  net/mlx5e: CT: Offload connections with hardware steering rules

Yevgeny Kliteynik (1):
  net/mlx5: HWS, rework the check if matcher size can be increased

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h |  10 +
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     | 292 ++++++++++++++++++
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  75 +----
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  88 +++++-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.h    |  10 +
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  18 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c |   6 +-
 .../mellanox/mlx5/core/steering/hws/matcher.h |   5 +
 9 files changed, 423 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c


base-commit: a833fb852e96c778bff1d14866f1db2c346b3d2e
-- 
2.45.0


