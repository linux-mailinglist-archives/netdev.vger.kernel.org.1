Return-Path: <netdev+bounces-216275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CFB32E35
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98C5204AF1
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA9257843;
	Sun, 24 Aug 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5athfdA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A91207A22;
	Sun, 24 Aug 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024815; cv=fail; b=GOfRZLOZdsnhePbAysFkrgFW2www0Xcsq8qBU3GPDUPD6HEu70FoSveWfLnJlC4EZtWISVu597HRgdkTKUHG2lQDFt6pJ6wctGW25qL5NQJmz1wu82vSOCaqbDM5AxMkGENdLeYJ06MB9kXN8+5ZlyJvdxQGC5uURMF/upoC2Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024815; c=relaxed/simple;
	bh=J0WBmoYTy2lmm/9mEuCsKxJ4Up89hNTAOKMxYS+v6EY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQ/oevCwJ6HoH4rNXQ/+CNTClUA5OYXsgFaiqTKbyOA8nx7LONg5uudP605WpZC4kfCrc5kTgQowj63+bJTcZXYVcdApGODuiGOXmkNGSDAHtPkSxhkIzD2cc1ezDqn56X7pdD/kT6QixukisW417/yzhMA3hUN5xdRUSF4Z8BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5athfdA; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag8J/6tjsCGW4omeb1dWR+18Y2G1lWLACQHHOVa7xqbwqOURY8qPmy4dnv3zye6lJT83mJaoO955azb0atbqE8UjfdHTSlPyDqQXpxAyRLT4UIybqa9/lj59x/vzrZJqFenJCsx0hwAuDdkW5O+0yEdYijEbEJ/KG0blSH8hG5KUcp2Jh3hN63/1ZVVlnSl+WHijvJStCMm8ScqgRxRVTU3DTTum0flTSleEAGEOY0JV5bqTWx/haDzNeQTaVoAHqDusLcv0CkSzMaBGf0aI2BdZk2JPb+PKlpup63xiL+kMYuS6qoJ6WzgAx3dgq8OuXgUk3EgELulI1ZgrBlw7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7ew94jjvWanxt+wBr3+vugsTWftm9rPfZ5DsLpWeKE=;
 b=Pi4sJqsE/pgnp6T4x//7aUqGaanjlI6/b63yB3bqq0Ud4dImdfSQNV7dGc4p2544aM0iacBww4C7SGV2z3AlYC0PFo7uEwhx5y+6DVS5zGryya6l7+tceDLF4x9qPoCezCZXc5nlfwwURDeRB8PM/jWO4psBpir0/9as0nT6piuA9+ghgEvfZXty6UH6s3l2RHSVJKDfY7AQKUzMcRC3eavyc6r1JTBUxg9fIHarZjsPeqgxFpPvovXsdrkAmrCTurlKZ7jGDiTRvtq8nwNIoUL/jbs564wSqQ73zFcWm0lw+7eW/VtaDmsHf7FB6DkIt5Tm31diY2pHWLmBLkYW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7ew94jjvWanxt+wBr3+vugsTWftm9rPfZ5DsLpWeKE=;
 b=A5athfdACyqnCH8gAjoZlr37jBBHY5O5NOu1uBy04bR8Av93V5Fl/PjUNuyKAQFIeLp71Yn5MN0HwKYrgwbu2WXiiWAFrCu7cyDAHB/aQYc0kpfFYseicMOSu6zdyVihzKXoZG7lKsTcv1i1Uv8uGKLSAK/SrKeGFyIn+UkAAWFGAXH1iaNV/iVzgvbzlRB7UWI8Qx28lOUF4gwapkviFRPlkf5yRBs3jXnjzv1Zev+wIFYYGYXW3Cv0S8UqiJ9jaQmkYzoOz6biH/r64bhamKaRGs8OfzsfIOMFgD0cLA2Hz5x7o+jnWf80j9XxDnYnfSB6T6vbHCd6aIZD+Ix0ug==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sun, 24 Aug
 2025 08:40:09 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::d4) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 08:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:39:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:39:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:39:47 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 00/11] mlx5 misc fixes 2025-08-24
Date: Sun, 24 Aug 2025 11:39:33 +0300
Message-ID: <20250824083944.523858-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: f1237b69-7155-40db-c504-08dde2e9d598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EfE9qmCGZWjHmdcoCba4QTXjl/Vgji3LwhTtugwQ3wnDzErs7iSWE8zsFrN?=
 =?us-ascii?Q?2Fm/ezRJmAITH8ayzdj7c3ppPOZfwTQDg1zO1NK+Rm/Z5V6WLcokXIOBJuXt?=
 =?us-ascii?Q?LlUWxqlYqiGzmsAH5j+Xb0Ay6NETxx7Sa7lEI8lekL2E/BTh5xxPhqQqgt7V?=
 =?us-ascii?Q?jXkmdR5bn5USvqNY/46v8WYGyz/B+JeI9DBra61M2u0Dr/+35PXMwonJ79Gb?=
 =?us-ascii?Q?Kd9oKjen0BvJunCg2nMQTdaDWuMQk1AfQaRD7/gGw+7AA4NvdU+cuXDxsC1l?=
 =?us-ascii?Q?KHy/1cXXZYB6dExt4th6P6ND3O7tCTtKbV/P/PRlCc5BOpAmOSnHGF9ntOpp?=
 =?us-ascii?Q?HPMYK69jJPnH6GdWkwppPurCAfMoW61ZiCv3sNu3MoE/IEU38Ae7Tx9Gearp?=
 =?us-ascii?Q?LrMSSNVX5uHaeAgIQi8MPYVDehTfVbjndqlXXzEIY55rcfZic6xgSmj0dYUH?=
 =?us-ascii?Q?JUuizUmhNVjZEfsiLJq2m8vVsfrmf9a763gzTQr3ZcUpTf0+c4VBhUcFiwtH?=
 =?us-ascii?Q?uhCO7JyOouyDeg6H7nB0B/rQV7nSAPmA97iw9TIo5gx8mNLXwXWfDpnCGcG9?=
 =?us-ascii?Q?YBMAKWoRKGN3Pn7dO7Fi3BE1LL11SZfbR6qTQyJd+yJLeZB06zfDiiOPt1/v?=
 =?us-ascii?Q?eapmHIgbwseH933CNIke5VD5XNekWdlgZ/FTW6YEoF0jQLrRvTqK4Qyommwu?=
 =?us-ascii?Q?OiqN28bEFVuL61gRpwmPdJbc0PLdjzbqm44tseJkHqmZkt2f2NwIw4jz99yO?=
 =?us-ascii?Q?ARqNllSkjARP2hh79ZEnOfSZgbVfSqKZ2TGJageBDVUy1bDTPwZNQu1bbvAj?=
 =?us-ascii?Q?PiMdkKvVFH+RN5+zrX8iaPvVeFUnoQf31zRdIOiC82PJCVXLxxs2JL5njvzY?=
 =?us-ascii?Q?OBFetp0ZAeUvMEuR7pYQ4gfZBlxllVrsxTSYrMIB7XpbuOkJ1ZxFdcJHWzA6?=
 =?us-ascii?Q?GHX7iKO1rrw6ZiOwEBuyLGndtPEWiWmDrOtBJ0Z2fSU1xDi+lClPEHHsrYh4?=
 =?us-ascii?Q?pmm8Ut2Ant3lilSxAlFb703k5Ha9XPUSEszwA8MjYcvmezXN7Klg19s+NBBW?=
 =?us-ascii?Q?TYiqyOPqxM5w7dAe/m77YyA7af1usjwB+hRCovXM74Z4UjTVdm31xJkvDzsX?=
 =?us-ascii?Q?SgYvX8n0kIFYdhmDYCoXXotm1YiajiTiRNAy5BXQj6nEURFeuEfzzXWt0J5u?=
 =?us-ascii?Q?VD8TXj9RFZGsobVr8tVgEWk1WXvWyfAqTiiiyscpXe+IBTBi4ZeUNzk1pAJw?=
 =?us-ascii?Q?Ape4R3Z7ohSmjPvcRh4Q4W5ru371m1rtuS26JaWjoiEHYYZ6nIt0YHF1DUi0?=
 =?us-ascii?Q?gwz7loO1qSiOGaAp9pOtjLd4hknV2dwbt6wDYoXRmHv07BxeM0DTsdg8PDsW?=
 =?us-ascii?Q?Qa4Z7SnJ4LMGwTqENyznezTgfNSceuRs5Tko3Z1GMhxHtF/39w1BWYBsrhQk?=
 =?us-ascii?Q?u6pe4Y1IUzM5k+feYwrLY51SAemkdhUYgdNvhWIstCeVJZArP1FtIgMwYGGb?=
 =?us-ascii?Q?MDhuQDmkXjaJxjKXDlnUSf6QBZBq7Lw14orG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:09.3666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1237b69-7155-40db-c504-08dde2e9d598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Alexei Lazar (3):
  net/mlx5e: Update and set Xon/Xoff upon MTU set
  net/mlx5e: Update and set Xon/Xoff upon port speed set
  net/mlx5e: Set local Xoff after FW update

Lama Kayal (4):
  net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
  net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
  net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
  net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path

Moshe Shemesh (4):
  net/mlx5: Reload auxiliary drivers on fw_activate
  net/mlx5: Fix lockdep assertion on sync reset unload event
  net/mlx5: Nack sync reset when SFs are present
  net/mlx5: Prevent flow steering mode changes in switchdev mode

 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +-
 .../mellanox/mlx5/core/en/port_buffer.c       |   3 +-
 .../mellanox/mlx5/core/en/port_buffer.h       |  12 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  19 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  15 +--
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 126 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |   1 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  10 ++
 .../net/ethernet/mellanox/mlx5/core/sf/sf.h   |   6 +
 .../mellanox/mlx5/core/steering/hws/action.c  |   2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c |   6 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    |   1 +
 12 files changed, 136 insertions(+), 67 deletions(-)


base-commit: ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a
-- 
2.34.1


