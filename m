Return-Path: <netdev+bounces-125609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE096DE9E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49A61C231C7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A4F507;
	Thu,  5 Sep 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bu4Sln/E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010B1991A1
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550949; cv=fail; b=rRpO2P8W0KQgq8WnFwCjbDLlQwAvD+1Vc76MFIBfKAKmICAVSojhB81wDV+MskLlopnG570nvJOE3UUA4uvz88/+UHJ/w86dILD5VJfauOvAQFH+DZJA4YKz5qQPUtUIjb7xn60zq4ygWpnJtIp6ZlRLAGfC8bSq44T1kDDzAWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550949; c=relaxed/simple;
	bh=WUifj1d8sczINwF7VWLYUFMIFuSH533RHNSzglPi5zU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G4NkFAAfGSRBzWiB9EsGTeSqfuUiu8OB1TR9YAd8DPSR4uATZ9eWZyat/J/wPqcA2fREHGoZzHIaKFdtcfsRg6fp3TrWJplqN+XoFFP7Cz3N/FZNbv+X+BXnL9UGd0QoPTJ5DDJ/V8Ns35zqTsOwFrwY4nQmShOVJxUlBf00pAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bu4Sln/E; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f136YqfOcCNezgW0fzny8lh6zQ7PyLmv3hCoxPwFqMm4YgP2NQuY3vfoanOi3VA9CDaG9iH4WUkpTh2vzzpH8lglm8eMpUAIcJ4jZWpNQILO1UPmtJiix6AcHcE7rXapZ/yb+TVyltxBcD6beFF7ZeZblhoMnTExSxV1pPKHCBt+fswYqe29xDJ3mVjRG+OGF+8hkYAB7M2qxUoHobUYx9baUEDEzR56Yv6UxSQ8j+uCl64ceDremd56KqPOxTxpb5F3WqxUoOhFyJFa7IWtl2zEBhIHtz2lLO21x3nvxXtWfVqDH4SOsecdDJ7cDpeU67FhGH6kb/dy34vTVOYThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWgQYmFjlGAIqYgqSmCFh5RUdNTOrjbE6bCSCTkrI1w=;
 b=xqr274T57XHDEuGVooIe51zkrDojPqPbqujYGhUkTJvdYrUKMZSygqE2A3eWmrQISChH7XzJDBZK3F4SYu/QdOXWk4/lOSKylVYGK8KFVzaZaGCibFz5oLXhlwV/GkEWA9DLjlKU5BgXuqpou6qUbiyN13xxuaHs9H2HSsG6S2zhME7CNq7Cu1XcWiqUr6UyJJTZ4a8ch4pZkFgNuPVlBsK4a4j6okWsfreoy1KakECe1FnBp2wO4KJDDncN4dNiECEpTbZ7xd2uZ+Ae/3/PXFIeJlXZKksxUSyCowjqDLeRDBS+c1/N0AF+YQyk0kqtxRdfSfxEojxgdTt2k4o3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWgQYmFjlGAIqYgqSmCFh5RUdNTOrjbE6bCSCTkrI1w=;
 b=bu4Sln/ETq2VhZoc1ETMT2V4J3RB7XqqXe7LkN2RgxRFbzAb+pYnUEL6XI2lO56b4ElEcbDUY8TYsrKbPiS5zIvd8EkHxSn50sqy4+17Ezr3S0NXyvy18wAjXBxjA81xaK+Q7QZo5NtfCndHngYJgbQOIyvASN/tYxE+cue9ufg=
Received: from BYAPR07CA0087.namprd07.prod.outlook.com (2603:10b6:a03:12b::28)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 15:42:24 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::2d) by BYAPR07CA0087.outlook.office365.com
 (2603:10b6:a03:12b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:22 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:21 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 0/6] sfc: per-queue stats
Date: Thu, 5 Sep 2024 16:41:29 +0100
Message-ID: <cover.1725550154.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 75573aa6-f3b9-4f0f-3191-08dccdc15677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVaE5+Vd8GyxgEzXL80F/B3eM3sOutEDl5ykbrKxbgl4m3kH148O8J7V2tCe?=
 =?us-ascii?Q?zZbJpyorLTqZ8guPO8tqAVlMwB+jodYx0sHU9E7vRy8xNADDt4damZorZJZF?=
 =?us-ascii?Q?wA3gUNELrFodUkDbQmTG9RnOioem52dz1JLytyRFaKLg5pZbEMWrNV+bp1TR?=
 =?us-ascii?Q?1TbZGwfXhmWpNmeEgCavm18/+BKWEv58lLLU7gSQSkk+uvHLSSRc0XMC3SMS?=
 =?us-ascii?Q?DlXoHz6v9hGWKIyxMhWqghFHxHqrO12rnI3bU/CAFVA0bdGZgTMsbeh2+LF3?=
 =?us-ascii?Q?3l3Syg8StBuaaLseh6N/RvWSQfWue8QWJhn0AE0JOJMiGrNoj9iBcRCtkAU9?=
 =?us-ascii?Q?T2AggpxZyY5O1cIprDxDfvuYho8Cm3koADDWscJcGeBoJ4kMCvMekCmMcL0E?=
 =?us-ascii?Q?T9vREAWWIMdps556AXmHVhbXsQgViv7kkeWoDOsvR25oU420w76S56bg6sed?=
 =?us-ascii?Q?WeygabsNE7gDrDe436D9inxQ9FMmcQGsl/L3fN2sQNxVIBx6O74ZgThu7eEM?=
 =?us-ascii?Q?0NSKETtBX6z5mAK0CMI8bnEvmo1daizxHOq2+hlKT7QF9Qf4dpHUGOaNRqAp?=
 =?us-ascii?Q?jFa92EpMTVp0ZRGi14LyJoTkw0dl5MpLWFxkV+v7fFPEzs3NONhiY4gprzhi?=
 =?us-ascii?Q?CFLm7AKkT8QChPIScjn8HcVRh/M0LsTA3fN90QTNc2jpcsVvVRX6VhSbfuAL?=
 =?us-ascii?Q?2rqHNXgJqW/gohIYNWUqmfxhscdOvvyHCQpmu5V7wqImPLgJuWHKNlBkKi2n?=
 =?us-ascii?Q?k48300K/9lkzzX3bE3JKZn7mGXoWHRcipq3/odlxMDVjGwBro25eHXC5brbq?=
 =?us-ascii?Q?4lTXgkF1KyYL3tKTKwxyRtoA0qZ6bWYOJiy7RVWHjePVvo1DrqQHYoZM2nOo?=
 =?us-ascii?Q?T20+UI2KZqJ3793/TMvHJv1995XivznmQXdlV3EuvWwE/KY2arbqyY5VaZGJ?=
 =?us-ascii?Q?ayALUZVMmIKqSF+vQvUaj4UhbbIo1DDol4MctytjKqYhoVkAjZ51YYElnnbI?=
 =?us-ascii?Q?g7DoSIAuUR1CRxSPFSRxOuPiO/xS3TqGCGM0yhQDN5qHblk2lhBdw6ZPffrr?=
 =?us-ascii?Q?gKymSIPEPlb/75H+umQYuMcA8Gl2qkp51uOnRpWKYFErSRmLs/T8MDl9JqeE?=
 =?us-ascii?Q?8LSD5ocr2LkE/BufbrZlebvLONNdbEvyp/6XiyLkgUOGjUEvSHhuBJhPYy55?=
 =?us-ascii?Q?itENavCUo3l8Tf20+pmqKTUq/d0r9sg7Mvls0j62CxeqTkyJj7PnvrRXYr/6?=
 =?us-ascii?Q?RJQwGq5lhLmvA085l5awEEOhWGe2TmNq6pxCTtcE1V5CLGyzCYWXqhbzWYOu?=
 =?us-ascii?Q?EmMd7hmSkS3AHxGH8nbDd79A13/4Qet5u0GVJCgTRL6Kubgel4AJWlDLKu70?=
 =?us-ascii?Q?h4IHPn4Eb6J2X33LS3K1lHXQXd60B2Yj0VYZ0AgG8qDXTsA/A2r+skA+Xyzk?=
 =?us-ascii?Q?oIS/jELS97izcmCAODF0WeWp8pITdLVz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:24.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75573aa6-f3b9-4f0f-3191-08dccdc15677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

From: Edward Cree <ecree.xilinx@gmail.com>

This series implements the netdev_stat_ops interface for per-queue
 statistics in the sfc driver, mostly using existing counters that
 were originally added for ethtool -S output.

Changed in v2:
* exclude (dedicated) XDP TXQ stats from per-queue TX stats
* explain patch #3 better

Edward Cree (6):
  sfc: remove obsolete counters from struct efx_channel
  sfc: implement basic per-queue stats
  sfc: add n_rx_overlength to ethtool stats
  sfc: implement per-queue rx drop and overrun stats
  sfc: implement per-queue TSO (hw_gso) stats
  sfc: add per-queue RX and TX bytes stats

 drivers/net/ethernet/sfc/ef100_rx.c       |   5 +-
 drivers/net/ethernet/sfc/ef100_tx.c       |   1 +
 drivers/net/ethernet/sfc/efx.c            | 109 ++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.c   |   4 +
 drivers/net/ethernet/sfc/efx_channels.h   |   8 +-
 drivers/net/ethernet/sfc/ethtool_common.c |   3 +-
 drivers/net/ethernet/sfc/net_driver.h     |  31 +++++-
 drivers/net/ethernet/sfc/rx.c             |   5 +-
 drivers/net/ethernet/sfc/rx_common.c      |   3 +
 drivers/net/ethernet/sfc/tx.c             |   2 +
 drivers/net/ethernet/sfc/tx_common.c      |   5 +
 11 files changed, 165 insertions(+), 11 deletions(-)


