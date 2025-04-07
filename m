Return-Path: <netdev+bounces-179978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECDA7F070
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855F617B7EC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443E22538F;
	Mon,  7 Apr 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xQuI0y0t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD5215061;
	Mon,  7 Apr 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066308; cv=fail; b=HFYZIjldip/Efk+mkt4HdKtGPpChnHGWHejA+qTN9JhslmMlE1SMDGf/VIPMonwx32GhOMqnLYfGIDgRfJkrE22UPPGz9wDxJqsg6MYM2XODy+vd7yp4K/Y1n8lC8DNXbhOZRyg0z5hbAH1AI5TP7kT1O3eShF4FXAU8sPVks5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066308; c=relaxed/simple;
	bh=IY6lpO1i0gXq/BitqUv+oxlgY3OCTHTV5/BcpzG61o4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQ57toUkikVM50k3j1tn/1eAMi+kRdWLCUwbmW82Mgp7MMlzyFdrOUkVZET8TKTE0mayQaATuIH8izcWY9A5QJnFrMVq7wvaeGomWyL2GLDAoA30sp5DqEnfjXDFuroqrzCsv5UtuHmLbytyq1pSmgjeJbnGqgn8EeenohNWxIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xQuI0y0t; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL70WsAgv9mywWbN/SXNVAMpBsTWPXt9rQhOjY8ch55lhdKx4tizt4h0ES0BHFU66BBk3AI0sY9lXFvR4PIr1bbO6Ot0gSRlo0yNyCHEQD407T8w65MbZ5Kjza3D4w4h1f0CMGhNTmgqeoPy12ybm5He2hhf6WpV4qzDDjdjq8SGS0xDBVWFLHtMKK5EMOzncwc8HF4XMLzLbr6aBK/SkR0GOksNQ1uhelI2TM70ZRJBsb9mX5DMg05eOTu21a2gwJ9OSkME6MS+M3KkxYsq/VZtvzbz9ihd8BHmllnl/Nz5NVJa1c6bduvzUHuR3r+9+tvwORkRqS8MCcPsy6z8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEie0PeiUC9DpSKJL4dAap2yZv2nyX5GuuVyD28R9dk=;
 b=jQPsz039tfWOFoJOnCFF8iNCpl0ama76O1rzOgWe1j5YaiBqCfz5Eyfd73lgI6E99RktUiYQ6DRLGSDxfCa/XGvKCfvxYKn1xdjlEuYelplNF6fvm0BAeIUMClVw4cqiqgmfPZW3X+T1+orzv4v9r6vaFavmvlfPoaGCW+KK9yGvYTJXwZO8wQhKMJ+ZIJRAy0QK75AqmRyr1X/TADLZfEYdILu+6feR6G9HfnyOI19lqjIJC/iSjGjKJYQYfEFjRviomxOb7fanjwHk5lAsEMbHU1irLytLZPUwAb4bEu7E9Z8jyPODXorEEOslYtsPCwgL7f3O9Ni3tOBEcQ2y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEie0PeiUC9DpSKJL4dAap2yZv2nyX5GuuVyD28R9dk=;
 b=xQuI0y0t8mKcwHBIkBTi8lFtaMMGOKzsspzdXhd+3q8FCSGJt+G1Do6RUvn3r6eYfdHoUOJGOGyqzZzog92fcjS/I3/xOFlmHFozrOnRBljgwDxwbvXYd0/6R25CGMBWG8sdkTuktZPVUzKDVvEVGR/EpivMsZ86/RFPRCxeBbQ=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 22:51:43 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::64) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 22:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:42 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 0/6] pds_core: updates and fixes
Date: Mon, 7 Apr 2025 15:51:07 -0700
Message-ID: <20250407225113.51850-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2fcd28-d72e-480a-ae53-08dd7626c45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7CF3JOy26VllN4ORG+h0bYXmAnRGNCGpxRZWQT9c0tGXWkKYvT0alyuLymhi?=
 =?us-ascii?Q?n7isZZQht+fz0dHEmekSKyectME3zZHVE09/U1RB7menHGN5OAr7Jp3dFWTu?=
 =?us-ascii?Q?LtoBMiboKZv6RL63qxMwqUo4eKi/ZDHUdC9mpXqLPHNUSwoZWy2cCLwTrg0f?=
 =?us-ascii?Q?ME5GQX9n8HclK1QeMEdGaVTEasE4VQKXO4a0erD9sUq1pJvQ38qf0e7QEMSn?=
 =?us-ascii?Q?nH42H3GgQG5Xb85XoSFDQLmPv8ng/gvJTcpwFVG+A80K8LPLyaoHKR7HNRG8?=
 =?us-ascii?Q?tdwvBGLnetxVm31KXX0F5j/sVRGDlwHcZpnEYxs9umZuqbDq4G8ypdZe2ZC8?=
 =?us-ascii?Q?gOOsiBocPf64cppEaZCXn+qV0C9KEw1x60wkUowFYEDHbcwhUQcTWRE8Tz47?=
 =?us-ascii?Q?hiPwjLTR7hWkTFu700jg8E/m6mVkUyKh7c/8FCny+naLVCprRA0ZUQIPNaRi?=
 =?us-ascii?Q?nJlgEZA/p6N3VFj/2qqhpjHLmoSSpwla0J0znTGdz3TyjJNIQ1bdOMjgSZ1H?=
 =?us-ascii?Q?kHWWMKILRax64CggKfZZtnSZ144IxY8AC4PdqrHvIU+FzYyUNPVAu2iicSnM?=
 =?us-ascii?Q?XahK6uwNnoi6/hRwM073NtoX2D5eUM7i86JoqWr2Igv8v3g5Fkru9vHrnCyO?=
 =?us-ascii?Q?se7Wk0+hN/B1aSDq8XpLTt2ZFOn7kKzB6ESHmgFVjq/7H0mW2Ykn0EdRirVl?=
 =?us-ascii?Q?bMY3ygX+32Y3CpmbxwlI2lkqOtifMOywhuVD0GukEDGonK5R1KjLeJQ8p40i?=
 =?us-ascii?Q?+wMzbNVjzUn8AMIYUsyDxdRGJ4F6j0NtquryLjiAtzO9hi7zJHjK3fdBijmf?=
 =?us-ascii?Q?wRhcycRPbGUcY+eMO3ZLa9njgXe1t/1Wv+wXewXE+l4QkRJnOnaoSM8dO9tU?=
 =?us-ascii?Q?c2xfeB6y4pEc2PpkKgpn9UVUIO1TxWv2RYdoDecH57fNiyBmkanpc3c+4y7W?=
 =?us-ascii?Q?Dp6Goe73TIDSOMp/wXowqdnKyPvcQQIHZ23wk4WfjPCKZ42ic6V1YtT6PLif?=
 =?us-ascii?Q?AgQ2blLn1jJXqKnhJrjvsgp9mRbK7rskRQWkBaZRcK+twclOKQbW4ule8JKB?=
 =?us-ascii?Q?MeXgL2gJUDeF3cpiOCJ2B7tPth9bRqk5LurUYm7lUVQ6Kjf29IrO6HMlZ550?=
 =?us-ascii?Q?4/AzlmEHXKnnsUjxP3vxHylDHxOF4OiU7wvMAUGX4qhpZyVOjwLiG4/ryo8F?=
 =?us-ascii?Q?kTGotzr2qGjxPSaTRq92pabIIEcgN7N0VrvG1y04gP6geXcDfSe3axyltuMa?=
 =?us-ascii?Q?9axSPW6BvitCYWd7BGRUxUqVSvkrkeoj1FafBtq7Ko1WtB1RZtmuUkTdluBO?=
 =?us-ascii?Q?L3dA46yggH63uAE53apvCr8BWCQSk7d3mxcG8eo0lx+HPrVESRqttiaEYCK2?=
 =?us-ascii?Q?7YLDW19habqDzL6NTJihRFdk0POK/qOJTd/0R/iBVsQ8dNt3emUOa4huhadC?=
 =?us-ascii?Q?q7bGxtEj1R1TyST1YGgIrcNvsiofLSsMmUkwKS59xNll8elmuNBCmRVaX1Tv?=
 =?us-ascii?Q?BMTyrCOoeQx6EEc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:43.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2fcd28-d72e-480a-ae53-08dd7626c45e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

This patchset has fixes for issues seen in recent internal testing
of error conditions and stress handling.

Note that the first patch in this series is a leftover from an
earlier patchset that was abandoned:
Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/

Brett Creeley (3):
  pds_core: Prevent possible adminq overflow/stuck condition
  pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
  pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Shannon Nelson (3):
  pds_core: remove extra name description
  pds_core: smaller adminq poll starting interval
  pds_core: make wait_context part of q_info

 drivers/net/ethernet/amd/pds_core/adminq.c  | 27 +++++++--------------
 drivers/net/ethernet/amd/pds_core/auxbus.c  |  3 ---
 drivers/net/ethernet/amd/pds_core/core.c    |  5 +---
 drivers/net/ethernet/amd/pds_core/core.h    |  9 +++++--
 drivers/net/ethernet/amd/pds_core/devlink.c |  4 +--
 include/linux/pds/pds_adminq.h              |  3 +--
 6 files changed, 19 insertions(+), 32 deletions(-)

-- 
2.17.1


