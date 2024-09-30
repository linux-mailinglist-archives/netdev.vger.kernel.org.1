Return-Path: <netdev+bounces-130400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7E998A64B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9334FB24E28
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89395191F70;
	Mon, 30 Sep 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m4Wx+ZFC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FF1917E6
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704400; cv=fail; b=kAspmUWfkYHuZGebScJ/OTEQVhSskgy11cK3g1HabXeE+WQFraGupX1FsM2ylsj7Ml7fCcW9oOf2nL1ghhjBCTv5lnuEZTbIZAa3volRnDCjvHhJ9uYcKVt/j7F9UPeD4jqpWskL99UE1lQ9Jb6wwQrh0SPSulUuwy2JHYVlU0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704400; c=relaxed/simple;
	bh=imw6W4TJjbhLjGeDrtatU8pytdLege8OxVRo9mRkSD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=plk9JJtV2ZefLhEHkSGAPAOo/YFHc0KpeuUy8v7cNAraKd/60joQebOeRAmL98kecGkxFfW8jmMjVvtiafogw8zmDbRX3dKo+pToyE1ViUyN+pNLxcMyDzJOr0QHFIegEpatkpkWcQ+TS4vh8y85H+1ZDhPvCZIWg73EIyXmJMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m4Wx+ZFC; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzl6iKKLSN44rzi1aDumYBjU32FzkR7JUmD6urIQLolOjkNPmQYwzJFgPvSSmiy1mnJtdjeVJlJ+I47/1EDMoVotPNmbMGjkCXMKXwFeuSdFgQfiA7/EVTlhMitFP2XQEpJkLP/ooXaffFsPin4nvTOkz6m7h0P7M9COXmsxS19YqPB9AUOfJHA4k7GGIasfCzPIHcJn5CQii5wGVTm6orhSWG1wVyqCombdCcS7MbFSraVdQSYiF6U8jbkYfXwYoSJdxgAPSEui0n/wegI4ygWyduckUOW7zdFVzSLldVEm5wAOilIlXVuibKzq+68sQIvf393chnyvtmklJ72FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlWfv9Q/Q9njdVWUWBYl+o8qjd9g98X21y+DjnYip38=;
 b=WQw81vRigTYl+9QUxBrg7gTb8Szn9r3dW1nBK6po7xSYr7fLozPSehvKJmiOSBDEQjU5Z036wXQAq8f1EyM8Z3g0hrPnBR5kF7QJYgU8Ke+C9j0aRFx6UB0qhwejszAp44cwRrWjIg4EIe9N4i/KpzlcCecFWNUz2YXDNQI38XhnC12vUUCYSwfaHjn7X9l7mYXBZLkhX27L0coBLUG/Iyj6axOeyP9m8zxT2ktf49httuRtq6ixU4gDEyLxeYISk/NoYTLrKnl5gppcupKZaG+V/8VumuTQ3Z8sT1JT8tIy1eQIvevsPK8KoUnq1K0MR+LDEyQiQOuvFYk4QGHFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlWfv9Q/Q9njdVWUWBYl+o8qjd9g98X21y+DjnYip38=;
 b=m4Wx+ZFCgHC9jbhiFRYqs8NJglTs4Gy/2qpBCrxmntfB98RKRAKhYfd/N4VpHZr+YoMLJgPY64sewSbkPPhBwCMvCDk7vdgIOoe9sbDlUz8kUZ46ViopjODeb3J+iyK8eGyRxT8mY4C5NLHnqu2BAH58U5KNpQYbAOqQcabrp68=
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:53:16 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::46) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:10 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:09 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 0/7] sfc: per-queue stats
Date: Mon, 30 Sep 2024 14:52:38 +0100
Message-ID: <cover.1727703521.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 205f7891-6400-4d28-57b3-08dce1573b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kNnmX5pk5cnuxPSYPHHJ5tlcplPXNF2clm8QnVaeywt0J1E9KGeBQ4wTHPgu?=
 =?us-ascii?Q?BWMVhCIY1aF4rdwyKDs+38Jwa6pox66ua75pFi9Q0y0JveD7eQcNrqgGb8YQ?=
 =?us-ascii?Q?HqYxkBjRIY1kQBadrIDVNuP5gfIJC+jFrKnC6hasQq5/YdO6hkBFusRCckL5?=
 =?us-ascii?Q?Z82gvYw9SEA24FvbS2PEBT60jdNBTo8S3XL4H6kAj/PpsmLDCZwQTiJC3eeh?=
 =?us-ascii?Q?MrWzanRA/g3QLL3N5vZxBNMFuJOHVQ+4WlLh6/F/ogASq54k/BLuCy2LjzvQ?=
 =?us-ascii?Q?b9L+gTR1veXMQ67gdaue07Px0ZSF9HvxwPJaBt5UvwaJsHfAr8/cuZKl6aCj?=
 =?us-ascii?Q?RmdpwQAjN/Tsnooh7S60kALH0D0kfox+TDHzFPuE3FgdD5Py6uXeiyuz4eB1?=
 =?us-ascii?Q?O8zg7FBegiqjg5t7cN5ciiAzZ6NJjvxYxcRM+nMxnqOvdjDYuYVeGmYJMlYa?=
 =?us-ascii?Q?7/ZVnWcNxgGlXxn47N/HGEeEDYGmsH3jgf+CI1LRA3ukYjMv4mPGAuppFOrY?=
 =?us-ascii?Q?IQ7w3L0z/4MnQHbS3HtDh71W5+r9SkYPscbt5nrmj6yqSy4JjnKEXRAVlRG+?=
 =?us-ascii?Q?UkD2bzIxFrLXZ+be/z7C7EBp14SBqoAi3GYB95MFApy1LZW8BSA6PAvuh1mG?=
 =?us-ascii?Q?lu/TNtprkCZkfqOzrJfPP1tTLRi40Ll3/G8sKdh8t7V2doi+oRQDfd2b6RXk?=
 =?us-ascii?Q?OPcoGwqN9xsih+y2SHwezKbDJGQH5kFaAkAIgC5KF8RuOgP+mnzYhCaQlN4d?=
 =?us-ascii?Q?pK3ZlKzfcnJ9IomFWBF75cm2SHQUgKoUX9d1ylOkOwm4jmQoSiSv2w+X0536?=
 =?us-ascii?Q?yirjH2ZQ/8kSUbhWDE2msIDQDhM/mVAeiGx05ahOKyH6pR1b6L2yArjVGrgn?=
 =?us-ascii?Q?SwSHRAsCLLGDxRRkIBEgeGKQRtd0E/7H55Hs7AqD4AydCAkOO4bhy3443Dr5?=
 =?us-ascii?Q?qJx9oxKul4uugj5sgFhzdKwQCEvImLg0V2K8VYa4AihNQXJNIxoBnjyOsPd0?=
 =?us-ascii?Q?BSPrkTdDqueVYiUoyNmdFCcc14pPQoY1SoTjYEOnGYYXVTMwZ0LXmrS7kJ4B?=
 =?us-ascii?Q?cbCqvV6S3A+XNUZVkUA1TMRjX/bpqXIWowfH1FjPGBwYfCi55oqU6Yuu1qqy?=
 =?us-ascii?Q?z07WYm9GuqfS/niPcDagY6JxV/InPnD12AFN9LHiViaLerGPqDsQPVny6TKZ?=
 =?us-ascii?Q?GJ+1A2yr8w2WsZsC9swngwb6druXXvebWOt1aO+svrBeZ0ubi1NadRM6UhO+?=
 =?us-ascii?Q?RZAXVm70IDk6B9eRin9vEKdS0oVQ38HXmZOX+NemyuSeaeWHIkA3dFX56a9E?=
 =?us-ascii?Q?96EAAKdQDPorT7hL6CAbI+FHRHrmN38gfHlaPX2L7PXkRS3V2yhB2DxWp0jZ?=
 =?us-ascii?Q?Y8rLogw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:15.4715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f7891-6400-4d28-57b3-08dce1573b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145

From: Edward Cree <ecree.xilinx@gmail.com>

This series implements the netdev_stat_ops interface for per-queue
 statistics in the sfc driver, partly using existing counters that
 were originally added for ethtool -S output.

Changed in v4:
* remove RFC tags

Changed in v3:
* make TX stats count completions rather than enqueues
* add new patch #4 to account for XDP TX separately from netdev
  traffic and include it in base_stats
* move the tx_queue->old_* members out of the fastpath cachelines
* note on patch #6 that our hw_gso stats still count enqueues
* RFC since net-next is closed right now

Changed in v2:
* exclude (dedicated) XDP TXQ stats from per-queue TX stats
* explain patch #3 better

Edward Cree (7):
  sfc: remove obsolete counters from struct efx_channel
  sfc: implement basic per-queue stats
  sfc: add n_rx_overlength to ethtool stats
  sfc: account XDP TXes in netdev base stats
  sfc: implement per-queue rx drop and overrun stats
  sfc: implement per-queue TSO (hw_gso) stats
  sfc: add per-queue RX bytes stats

 drivers/net/ethernet/sfc/ef100_rx.c       |   5 +-
 drivers/net/ethernet/sfc/efx.c            | 109 ++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.c   |   6 ++
 drivers/net/ethernet/sfc/efx_channels.h   |   7 ++
 drivers/net/ethernet/sfc/ethtool_common.c |   3 +-
 drivers/net/ethernet/sfc/net_driver.h     |  47 +++++++++-
 drivers/net/ethernet/sfc/rx.c             |   5 +-
 drivers/net/ethernet/sfc/rx_common.c      |   3 +
 drivers/net/ethernet/sfc/tx.c             |   6 +-
 drivers/net/ethernet/sfc/tx_common.c      |  33 +++++--
 drivers/net/ethernet/sfc/tx_common.h      |   4 +-
 11 files changed, 210 insertions(+), 18 deletions(-)


