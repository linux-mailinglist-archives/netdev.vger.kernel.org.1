Return-Path: <netdev+bounces-97624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B408CC728
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE690283D94
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F2146D5D;
	Wed, 22 May 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0q5ezHV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E64146D5F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406093; cv=fail; b=a9IpyIBc1e5UVpecdO2YWkscZzxKZsFU7HirBO5D9tLYwol+mgO19J+ubMrc+DnIbdAlpQOJT/+r01blWK6VaHUSFcMdIvFWdM5EQseJoqGurDWQ9qpRh4AQV8CRgB8lzBBBAzCRmpyhBpJ0y2c0FVHLD/NIoqgW05gkJ1D5W0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406093; c=relaxed/simple;
	bh=TeAtPxWjxG+VnxS0BFkXZ59pzb++Cy7BqcTYB7IhMNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8umpP3of/FAwrWtaAbtxFEhS2zhNxMTvWHzICBeVGf1jjOSctP1kqXUkqSnYX9hS/Cnqt05D6j37pi0IhCXiBc0HOUrixdTDmozWSzGn6OyvMVQTZp7woXfISinuMATFcZvKhABfzak1JTGa0v+efjZ0qC+f0n2aV+l5Begw8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0q5ezHV; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqKOwsTLqehNgUBRw2Sak9PvvsJU0b6J8ZF2W/dIVy69ATC1TQbcQzxMo8x57f/SoucOHYcA6y5ae4ZX0dYkNqWLdH1CWdXw113PL56N9LQZKTA2Xb4Kp2q4QYuLIVeA5vT27fa8VpwO/LLibAOQ0asKzbl0HjVJmHW9jC5OJHlrulUYsjQxsxCJOLoP+98QFcCEV0CpKVt5e69xROpqfdBZkjwaREimQ/grG/++UblyzmhjkzWSxi/dGI1ntMwdmejh98pqJDUYqC17cswlrPM9DcQTCA46b3rZcWhf8+8hDXvx+O9KhMxiBEnxhdW6YN7K4r5jRVLi0V+UZD4jNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaatJDdcvo+YQHx1ZXeHFnPCHYQIc07ynBNyBopjh2c=;
 b=WIvehvRcNTGne9VmENP5vttYDspbD0OemE2+fUl2T0N/JS1lPMoaC9XfQ4j82yeCmuH60YuF1t/Ox5qz2RYOcc9M+geBvjKDfwyExr08YqVhzRfgMy4ZZ9BfL+cY2rnmx1TRildoNpwoeX06mgUeQ+aKm+nO9bJckLVXqgrK/rWcvkLzkpZaDGeirLvjwMAbjbsIRzbb90f2xkTwV6MGxx/3PBAhh6OPxyLiyjb55oesjAjYPjukrqUPncwoguAOgfvjdjfBsr+i7XFtwDUlDgXQtBiNaT1j8BzacAbMhU9xYL1GuYr8s+DeO8zE6Q8zc5k7MKqzvU4k2vsFOiHXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaatJDdcvo+YQHx1ZXeHFnPCHYQIc07ynBNyBopjh2c=;
 b=M0q5ezHVNv3kOlERZ6xhku+X61ibEfQi5Oj/50pHw811Dz+PX6QHknfObBL5dYnGUl1d7AtnjIldXLdYGDFvcoidsR3OcL23Bsm2Q2miX1B972x1jZFWC4xHxnU767cPDR8C1z2xS6Pa+LURpULqLggPzlouT+4WBdHZ5Q1d2/VjYpt7BbGnM7xE6ci/Qvd/INDaprEs6F7SwJz/KteNYpotVQlcNgtmzognCYFj8fe0pB9zkBfVS3dNh2VBDKM+16JrD7TqzmrDBVr4djzh/gfrEJ/mYhO6pRhmtrF4xqAZeNYm+Q1kSa+e9n0lcn2pRzOTzeNJBfP5UiYW3IM5jQ==
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 19:28:08 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::5d) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 19:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:27:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/8] mlx5 fixes 24-05-22
Date: Wed, 22 May 2024 22:26:51 +0300
Message-ID: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aa684d-4e2e-4951-7a5b-08dc7a954f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStERVNmQzdMbGhxT29yMTExbDNrNDlBYWVsV0w1eHVWdmU0WVMrVG9YeW42?=
 =?utf-8?B?R2tCN1hIQU9SWE1uZVpQb00vZEpCODc4a3U0RWx6OE11QUpJM2JCbE5FdE43?=
 =?utf-8?B?YVlTSVBGbWozWm12aDlVSFpBKzZyV1dvT3o0RmR5enhNTFRKK0szcGk2Z0g3?=
 =?utf-8?B?WXdXUGhFRXZFczBvYk1ZVjcydFVxZUtzZGFZUkg4Ui9tVjBMcU9ESEZkTlV4?=
 =?utf-8?B?SXNteDh2THVVb3lxSU9pcXc2cWxWbkFrd3F6TXBwa3BLZnNZd0xjdzRsVkc4?=
 =?utf-8?B?RmJIcko5L1J0WlV3cU9NRE14QXZPa2dERFVwN3AvdzRqR0luTjdLbFB0aE9a?=
 =?utf-8?B?YXBEakRlL3J6RjdCWnJnamY5d3JGV2VYZTdoR3NxbzZ1Ykkvd0x4cFU4TDVj?=
 =?utf-8?B?bnJ3cVhqT2hhR1lCdVBRR1pxZlp4cExKQ0taZ0tFamJCanJNbkZmbXduRkpV?=
 =?utf-8?B?VWovNXRVaUFQOWJkQ085aDNMbEU2RFZ2QVB0YWtFWnRxdWZoQWdWWGUzcHF0?=
 =?utf-8?B?Q0dMc05RZTI2ZUw5aC9YT1czT3BXN1dERGh2L2lRU2dkWG9BVHVlcVJJUE9h?=
 =?utf-8?B?V0lWS2tvMW1UZENoV2N1OC9PVFdqSmRtNEhneWVRdmRwVXZVUGpCQlplZDFG?=
 =?utf-8?B?eThsdVlqRXkvVzhqQjVVTE1sVEkyS2E3NVJUSG5LY0lsRTJDOGhWVDkyNjhP?=
 =?utf-8?B?NFdvd0I0YTRwUzhHTEdSbzR1bG5Ib092SXZva1FSZW5aUkdRc0M2QjBldGpT?=
 =?utf-8?B?S01McW53MkhsRkVuV1hTMGpaMUlCVWpYdzBlZkhQQ1ZWRFNyUFB2RG5WQXJY?=
 =?utf-8?B?dERCZ25iaVVMcURxSXNqL09BNWxkWDlWSXJnMjArdUtGRXJQNGxyYnFHWEN6?=
 =?utf-8?B?RDFHeEJkdjkwMXZZOG1zaWs3dWdhczRuMEhmT2hGV1J4VGZYc2RVeUtxN1Vx?=
 =?utf-8?B?RTZ3NHB2b0lDN0p2Slp3cFRLQW9SVG1wbVFtWHNPanU5MFdSakV2Y2FUTERa?=
 =?utf-8?B?cnBtVGFNVnBRdkQrOGo5RUN5V0xkaHFmU1dnUUtQOVBXYThsSGFxWVNoYTZj?=
 =?utf-8?B?MkV2Rkl3THBZdEFOdlEzTUF5eDJQb1N4WmZnWVdQektLQ3FsamZiT0g5L0hQ?=
 =?utf-8?B?M2ZZOEhEeS9XSGtmT01LQS85WGFvdEtLL1VxOFkwYmorUUhHQlEyQ0NYMHNl?=
 =?utf-8?B?a24yQjhyRDBBOW5CU2NtR2E3U0V3bUVLcjBXdkNuRGY0VHR3QXpEK2diZGV1?=
 =?utf-8?B?UFJ5M0xwVTRGMUp6STYydGMyYkxzbGN6VGZXSGtpMG5ra08wZUkxQWZuaVNr?=
 =?utf-8?B?TjI2eE1BQjlBbnI4cUtPQ1ByM3FXS1llNWczeEVzc0xQc29kdGF4WjNCcWtr?=
 =?utf-8?B?NmlIb3RWNG1rODhOVWE2TmNjTzFSTFNCRlJRU1lCV3doei9CUkp2dUNtMVJL?=
 =?utf-8?B?aCt5ODM4UzMybFBEVDVXU2czenQ5bWVkN3FoeGJMZFo0N0FEc1p5NzF0YTF3?=
 =?utf-8?B?K1AvRCtDc3dWRnJUbzgwcmNKNXJsSk0xWllZUVhjcXVCWTJESDZXbXJlWXpG?=
 =?utf-8?B?NUVFYkU5bGhxdytTYUtCYkNNZTBFTzhQTmM5WjFON3Y0Q1RjMUYzOHZyVkh2?=
 =?utf-8?B?cHlzbDMzdGx3YkpsQ291ajhDbFBIZjgvNXpJbEhPY1kyR1Z6eDhUMU04UFdj?=
 =?utf-8?B?ME5kWDhXV2NTS3hnU1VZbi84Q0ZnYkI2Z3gzNmM1cVB0b0xGSzhpbEVtK2c1?=
 =?utf-8?B?NHQ5VUQ2dDU4M01zaUF2aXhHZFBUTGRrUUZlbFpYbThBSlM3aHVnSlB5d3g4?=
 =?utf-8?B?SWNrZDRYMm1CbGZxWWtjenY0Q0dna1Z6Q0hPOEdtaVRMaFJYSlBENzlpTUFR?=
 =?utf-8?Q?1/SNoj5ddzmx5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:07.9354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aa684d-4e2e-4951-7a5b-08dc7a954f72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363

Hi,

This patchset provides bug fixes to mlx5 core and Eth drivers.

Series generated against:
commit 9c91c7fadb17 ("net: mana: Fix the extra HZ in mana_hwc_send_request")

Thanks,
Tariq.

Carolina Jubran (1):
  net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting
    buffer exhaustion

Gal Pressman (2):
  net/mlx5: Fix MTMP register capability offset in MCAM register
  net/mlx5e: Fix UDP GSO for encapsulated packets

Maher Sanalla (1):
  net/mlx5: Lag, do bond only if slaves agree on roce state

Rahul Rameshbabu (3):
  net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status
    rules
  net/mlx5e: Fix IPsec tunnel mode offload feature check
  net/mlx5e: Do not use ptp structure for tx ts stats when not
    initialized

Tariq Toukan (1):
  net/mlx5: Do not query MPIR on embedded CPU function

 .../mellanox/mlx5/core/en_accel/en_accel.h      |  8 +++++++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c      |  3 +--
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h    | 17 +++++------------
 .../net/ethernet/mellanox/mlx5/core/en_main.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_stats.c  |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |  6 +++++-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c   | 12 ++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c    | 12 ++++++++----
 include/linux/mlx5/mlx5_ifc.h                   |  4 ++--
 9 files changed, 43 insertions(+), 25 deletions(-)

-- 
2.44.0


