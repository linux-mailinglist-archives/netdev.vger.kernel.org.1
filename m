Return-Path: <netdev+bounces-234308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB5C1F356
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37B694E814D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0934028F;
	Thu, 30 Oct 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nz0RjI5h"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563C20C004
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815553; cv=fail; b=J711RM6KldP7/rkh56vSM7fYehRrBxrb14xYjEY/wp4JPaqPEnl8C1B3XnKBHJUsPYjSUq+75Rqej4QEuMqMF7CleG+ilvUxCAl8owqGHjjzJbeP0jowgQtdJ87/UJBAgr0RT76D8TGM48DmGdjDfGKtGxm7pruTBZxhwvPDbvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815553; c=relaxed/simple;
	bh=AIe67SS4P8iklpTht9bcTq1UIWduS1xw8QWDgrLwDlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJWk0+pnjfMweD5b2QrLGBuNFJMvdg1j59Xki40LTysTOaqaUq6vWBzMmcPXpooFQL7d+TJxEzxsR076c5fN1DROPj3hDAi7EFr/ZUH5bG2E8TIvrG1frZznrdSfMAetLHS382h/tbJZah6H2z4bZEJ+rly/DDlR7idh4xk+Ddc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nz0RjI5h; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6BLEPhIGEWqwjAJXlVqKmgIRC6QoVKM7ZxU9SinFAN2788vutEGkZLqrVCNTe67w0oexbhU+hew5c2OwfHiWTbIqHM4MyqFV8ynX+jOADk2+vJhCjbqb/N6OU3ZF9eTtd2rB/Qh+O1uRb9FTG8uATeAv6JA+7S1Hxpg3pPbJuP/NwyMM8unm2+dMrvVYWjJ6HVcScex4Mo7Xy6cHaJmWDboC3LSFl0Fjuyny1KssQPku5a3DObI/7TpjeGSRNN9Y5AsMBBddn6HnEUP212Vm9yPJvvzszXlRZgATXwa15sX1Qc7GYUaa9s9K/pUIdCoulZyqwvxzQCJ5gduRC1fgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuqkue9gf64KstX/tux2hD0D00WROirfFdrVcOBM81c=;
 b=VKlMz5SQ//TgaYJnO7hQi8I/ZjtMe8mR48mAB9NY87tdIr3EJg/7BiKnq13cbUMRMSGWo9GobQTAtmJrQyl+rLqVGT/Tt2nEi9ZAJbMlcWd/ybDJPgpFkOaq6IgxZkKDpDCQZUFbJWGQJhYJIxvnJ4K+WMtYZWzNGKG8TlQDTzL+VVO1gnPw9xgfYM+OR0e32KqAMOPR768fqqmH35fVms2Ct+S4DjZhkl6le/sYylV5Kx87CSLd23s8BOGfKxMemt8geLIiJGsSspyP2mYVAEef/4dStCInCjJNeu/iJ9h7Qj01fz7B6Nqrz9mS/1pCCL09E2VVWeNWvamVSVsBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuqkue9gf64KstX/tux2hD0D00WROirfFdrVcOBM81c=;
 b=Nz0RjI5hX1TDDtxaPPsi41idkd4bbE6tPVfo3P5fDlpPHJ6qFS3/eR3HdvjjcZCNGZkyUf0HcDVc8EN6HCPIvpSEoTvSYXsmbafWzHtIbJwJApRoHemwSrOnG8mTKMhVdreNunLsjzHbdo8ipEjoxF+ggCZgTMU1ngQz/AzNa14=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 09:12:29 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::d0) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 09:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:12:29 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:12:24 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 0/5] amd-xgbe: introduce support for ethtool selftests
Date: Thu, 30 Oct 2025 14:42:10 +0530
Message-ID: <20251030091210.3496318-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 458e105f-27c5-40f4-1f96-08de17947377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plWLABFkHRa60UOKXLA84Cb1urxuZbgrubrYSnMI6eGN2Lg+J+u1LNpG2hQt?=
 =?us-ascii?Q?gH6IgOd4O5+4i8TqcI69tHaK+wd5hBPUp4plXIIW8vvefOBbwBCcM3CC4Clf?=
 =?us-ascii?Q?8ZtVX65fb+xCgcOllnZNdGuJ766qgNwANRrqYnQskxULfbYRPoMf0/OUxsSg?=
 =?us-ascii?Q?1/QNKf/zuStI/4BKqHLIIRqkaL+XVrz5GYtqvwo4RyurbRmec2CdrwN6MzWS?=
 =?us-ascii?Q?lmtq/kovQ8SmbPNYHOy4kbCGQo+nkBUDZSCPov5egnEL/zCUoMM+6GtJ0hd4?=
 =?us-ascii?Q?U57VoAkPx8QYz3ruO5oMq67jHuGvAv2dMthMNimY+j+Ds0hleV6VkX688M5W?=
 =?us-ascii?Q?/jgTspgjD+CYu+6Ibo08Am/+QBQyKdtF0W6oK12AKuGoVui5IvJOGwkCPnJN?=
 =?us-ascii?Q?ANFkgQLAKQnL9hY6iMmz6giQAJrQLi+O4vzAv97FRy6B1tui5zMiST9ZZnC4?=
 =?us-ascii?Q?BAm8cRpcgnc/NMC/DhXZEk8i0ZntjQrlBQ1a9w54dd7luC/P4syphMOqLXf0?=
 =?us-ascii?Q?uw4BSfnVGmOgz3+Ttm1iy/gByjCfRGWgWm/H1LJ/Q+zhXOBAamPVRMXTlJUu?=
 =?us-ascii?Q?kP5IWgzVOJUW+6gAiSdyD0ttbBGtH0MfX+/4sdquYXSx4lDe1sw5zTEf7/hA?=
 =?us-ascii?Q?wlRQYxfVXfGuWw99Smm6MSXpcf/NvihshWZPrI3zGwIhv94h1wQNrF5ofb9s?=
 =?us-ascii?Q?gZLnBROCrwJFYi2Opt8XTyVhLfsvzPTAKqBG8r9L8+rSuSMIHnQqdNyCSCMA?=
 =?us-ascii?Q?xlVSJix5Gnt8cC5sbj5/BUA36bVNHVwsqGYCLX8kEEXp1uJILNAyq4TQz2Bn?=
 =?us-ascii?Q?xY9+cTTbyAyrpboYEm0gxO6P4IbAZ3qg7VQSCJL7D9dUp6slgxlTTQlwDOqm?=
 =?us-ascii?Q?IKy6pkGAE0TSNo2xXiskZu89cJ3MgZEr5sYRj3Fcu//LfTWiRX9C0kt25smX?=
 =?us-ascii?Q?sy1RbZOTZbkfrno9kSDN1tE7VoqaLH6VF7XGgVLJbsliBcLmhSgpz7bfmEOr?=
 =?us-ascii?Q?u7pCe87pHnWGTsEFBNkPRmoECJRFGOcfH3RlNJ915wSUD/gZHPWQLUwEGD7R?=
 =?us-ascii?Q?2eHoP3m6V5aRDGn2TE9XsJdk8+3ALFHVwmAxeh9qCKD699KVKE8OiPkhJ+hM?=
 =?us-ascii?Q?nuWObsCQhlI9oHNN7eBsjT/eGrCRVo5lgWFbtzRkgCFEJyMXPTMEVHwGMoS5?=
 =?us-ascii?Q?7WDRUUIt1IddRV4RhPW6d9i1qmFpE9eGAuU+c6R6Nt7zSv1j5+7vZu0M97Zs?=
 =?us-ascii?Q?KSK4fX3YBzLK2/vVfv6yrPmmmJBz3LJ7jx0s3Mf5Y+RB+rhNc3JRc6MNk9tJ?=
 =?us-ascii?Q?zhmDubHhJW8+zPFLHLiOneUJvlWozjtZrDXhM1Cz54hmkd6DXg9MNT3teEUf?=
 =?us-ascii?Q?MZ0FAidoCnVAbtzAlgs/iRKSlUqDkagYaE+dmfLP8PAiuD7+40G5ZEqgeAv9?=
 =?us-ascii?Q?NhmByPQ6cX3MXWqNkFr66tWdE4j8E4iy2ylFe+9L98eI0daXHKdwecL8olDD?=
 =?us-ascii?Q?tjmZ+b1HlmzOBUqFhHtOSR419yi9DYeLnH2JbUl9qTXUTtd+FyFx45pL6PQB?=
 =?us-ascii?Q?wKfep7XBfxLSM0YfS/s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:12:29.2525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458e105f-27c5-40f4-1f96-08de17947377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

This patch series introduces support for ethtool selftests, which helps
in finding the misconfiguration of HW. Makes use of network selftest
packet creation infrastructure.

Supports the following tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

Changes since v4:
 - remove double semicolon
 - move the helper functions to appropriate file
 - add inline keyword to static function in header file
Changes since v3:
 - add new patch to export packet creation helpers for driver use
Changes since v2:
 - fix build warnings for xtensa and alpha arch Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

Raju Rangoju (5):
  net: selftests: export packet creation helpers for driver use
  amd-xgbe: introduce support ethtool selftest
  amd-xgbe: add ethtool phy selftest
  amd-xgbe: add ethtool split header selftest
  amd-xgbe: add ethtool jumbo frame selftest

 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  19 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 346 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  11 +
 include/net/selftests.h                       |  45 +++
 net/core/selftests.c                          |  48 +--
 8 files changed, 437 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1


