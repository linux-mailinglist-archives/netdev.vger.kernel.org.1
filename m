Return-Path: <netdev+bounces-122786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9E962920
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385E01C21E69
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC3282E1;
	Wed, 28 Aug 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZBjasoVe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD31CA94
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852762; cv=fail; b=m9H5Q4X8DHnemjM7wDbKhzezAaYf9pJwOmNAe7FAlg54/RvH5cbuJtxFsHUAFBCrAFqZ91Qkg6qNr2bIWoMB+3OASvgNl53pfH7wjaKlx4y52lfSsQXlVc8iv1v1pdZbPof4T+bK6bHPHuUbmB57gdE2qeMZ8HjBilp33As/fPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852762; c=relaxed/simple;
	bh=2uUTBNmv82u0NDiD2dfUfgc2vuO3CioHR4kzovaP4lU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=am1xCrz1Ym9WURH/mJFDnx6nrVuHMs/EdZchwbKZCXIqHrfaNYlaONfIa4iuJFzDJTwULKTs2sApNixFUudPVKCW29udOK7/azjrcEUqiAH2HeAI5FAUZfvCiLnZiTqea9miVr+SlOXODctX/mIy9bYwyVbatDk83F0aL7HhR34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZBjasoVe; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJm0w0JcHnCQbhhC084bWAoRXQNMkwDViYPYbhtvC0XZBVnmfBETZPV/S6MJ8KOl+b9oYGMRsVdIpnuV2xNtmbnqfomOFdfv9wOLeu0sn0gdQdsOtj4PTa5m1bwGsEVc4LgD7F5vOPIqOENhf685iqi/06DIm963BqniXDO6sikS9JwSSJvgSDhrQM2Mi9jSNWKmnBZc5+Xf9I1X6abmmtbkQGkUImT7ru6bf88Uf/u7PRhaAzHviUikYE1ZQPnRE3NOXewOMYcXhCfE9MqvqBUzC258NaCp1TCgDGwumhOgUJqgJaMQM/sUsqW6uiFnCM7KoiwffZ7ov1gN6OYxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzZA1tRW46+I4CXJn2kBgKKclEhBD1aMn3nIPljV1CI=;
 b=SjR35AAKP5vbecpRoJLLjvmTDlAgfCo6RBpNDPLohxBgw/4YsoSHZx8sPF/11pO2lgLVaxgogOFtyu4x5VNGLZhIt7B0vduqPhWqJm82a3h/oUBtm4tD/LsVrEDI5ZM3sEHZn8sQl4ET12kUqkcKRAU74tCZbWG4B4JVx+643F7i4waInB40R81vZP24FLdae9BRDTdnQpNqZ1GXaa0opVZ5HB6NG5SFlnZ9P3WmQ4BV9VFfTRPBd36ueswXORu9Sf18nbUG8Mxp2ZHPv/8aa7eNXNDEbF8keofQrfbYfoPK+vtN06sq7XJUU1as66it25xNmiSakXXqGCAFzjj0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzZA1tRW46+I4CXJn2kBgKKclEhBD1aMn3nIPljV1CI=;
 b=ZBjasoVece23cs3MsqIHZECC76auEINCxduGM8suqQ2NnMx6p6L4nKKXNWU2PAWdzD4oiVwxi5igYgvrQlFdlP4xNYvHugy8dWp1rvi9JyGBt51VsbLjhzhQI4+YV1idPKsSMfHLdoLnDPHRYJ+w7IkhtBefcvfrMxbGoyNLEnc=
Received: from SA1P222CA0066.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::21)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 13:45:57 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::8e) by SA1P222CA0066.outlook.office365.com
 (2603:10b6:806:2c1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:54 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:53 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/6] sfc: per-queue stats
Date: Wed, 28 Aug 2024 14:45:09 +0100
Message-ID: <cover.1724852597.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f62578-4d81-4bde-28d5-08dcc767bdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CIxY3dT+9MxMbDmg0mEouUC4RVSxzoCOBNuuk0aIrBk0ZObEv/+yFYu+Y5q?=
 =?us-ascii?Q?izi9PIkDiJTDRsgpkXwbcq0XrxuNmCnqNNGoMCij7ZfExaNyodlXPJAaA4g+?=
 =?us-ascii?Q?ECpi9lr6ORinGjW5hHFF82fy8vFc40IhH4aoEEML9qRM4EOBiZucU0ItXvdW?=
 =?us-ascii?Q?A6IjziGRevU1xMYDx+KDIfAIuPgAKZ2OBM4e+krdzTrjbptyDW0FSiAi3vBp?=
 =?us-ascii?Q?uC88vzuHNL8wYFn3EtnqzMn12EQED7Tz1/9YmNoavXE5IJ6Hg0jS2pKbm8hn?=
 =?us-ascii?Q?qE0Xdg2civgDFho1aZw0b79OE/30iSU8WB4vajHdpiLDSPtm5en5tvob79Kf?=
 =?us-ascii?Q?D2OC1KzrF06rNxnEebVRFjssmZ4q5hGxHN/h+UTl3zoG2SSte+/2v3SlCfdp?=
 =?us-ascii?Q?Xd+hAjlj5IK+rzEWFHIJn5JgAL9cTxD+BcAQjm0/fyofQWAl6Hx2QdYfDl/U?=
 =?us-ascii?Q?FvODysU7Jcww9SCBHLfaWwTN25tebHdxI1MHDIP9eVmE4ph3kGW5vH5eUEYJ?=
 =?us-ascii?Q?NOHH9an9TPDiR3GAluSnchiAGtmvrz5NlT8MPADmiL7XtnvKCmd6DEJunHND?=
 =?us-ascii?Q?Jf7MJeE964SYfT8Z+i3n9tBPPInNywBhaRvootypoJYBCT3ThaHikv+e5nCY?=
 =?us-ascii?Q?xKv4UrKMjMWzaegPQAY3+KINu0URw52Gm3YVeCJ+aF8tyooZLmgA3PjsJ4vU?=
 =?us-ascii?Q?zxfJYADVb09nHo4c6rc+Q/eQfUjuDFWkcCUhZc3MJs2RBulc+uwiBzqg1/aY?=
 =?us-ascii?Q?wa/sKZ83tkx+rulULJTfMtsUtBGfSuWZ6xv1DAqk2bPtkELaMORCVAEYMWMH?=
 =?us-ascii?Q?1ciYuzqSaU1IvoeIEdQ1Js45aobtpOtFwkud0BhLa6yLvQpXsw9kATBsm9Ea?=
 =?us-ascii?Q?xRjSb2RFrMAIi5zneieuu12rjehugrBmib4cGX92gXeGAKsRTMSjopJnx3Xz?=
 =?us-ascii?Q?7B8NGrwv6Y69TQV+y9nauhW+bqn4S/C6Li6XYY+DmmaO+jLqWkYiqIVSztwK?=
 =?us-ascii?Q?SIxWxE3JHuRxZbmiryfXLa1s1SnKJCUdiQ1tzX01dCAue29AOhcAA+8NyvQx?=
 =?us-ascii?Q?L075xQerwBuTfxAE5uI3tDM2BBVgfXkHJDmY9HMtDs3Vm4wfBrZMTrfmDkAJ?=
 =?us-ascii?Q?kcMlf5M6WSqs30+AonurlvjAlhnhBFyZxzTWuHT+rD02VoSugvfG8MVlsMsL?=
 =?us-ascii?Q?+dtq6paTHeQ+TgGMflnEAQ7RdX4UByrmQCvkgpQ9AwRQXQTvWsOQ4ZRqMgwP?=
 =?us-ascii?Q?RBMvYXfcj60MBo4nV32j9Mm1VeLzA9tHyrY+QgRytVtrT8CnIQj9SlgnxTtU?=
 =?us-ascii?Q?EoX/wUWa5w7pzYksBaf2+v0MZuhwzqDIRswRuFXCUPJdHCKW3fwdGo2j43DW?=
 =?us-ascii?Q?1zahP6LdE9fS7YfzfC035o3Hy/4xspdDKK3Y0YUikvEGl+dy+hKLi4JwSTAh?=
 =?us-ascii?Q?v8ZGhUsgAUrxanbEc44rTk+iDD1leYUc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:55.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f62578-4d81-4bde-28d5-08dcc767bdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

From: Edward Cree <ecree.xilinx@gmail.com>

This series implements the netdev_stat_ops interface for per-queue
 statistics in the sfc driver, mostly using existing counters that
 were originally added for ethtool -S output.

Edward Cree (6):
  sfc: remove obsolete counters from struct efx_channel
  sfc: implement basic per-queue stats
  sfc: add n_rx_overlength to ethtool stats
  sfc: implement per-queue rx drop and overrun stats
  sfc: implement per-queue TSO (hw_gso) stats
  sfc: add per-queue RX and TX bytes stats

 drivers/net/ethernet/sfc/ef100_rx.c       |   5 +-
 drivers/net/ethernet/sfc/ef100_tx.c       |   1 +
 drivers/net/ethernet/sfc/efx.c            | 106 ++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.c   |   4 +
 drivers/net/ethernet/sfc/efx_channels.h   |   8 +-
 drivers/net/ethernet/sfc/ethtool_common.c |   3 +-
 drivers/net/ethernet/sfc/net_driver.h     |  31 ++++++-
 drivers/net/ethernet/sfc/rx.c             |   5 +-
 drivers/net/ethernet/sfc/rx_common.c      |   3 +
 drivers/net/ethernet/sfc/tx.c             |   2 +
 drivers/net/ethernet/sfc/tx_common.c      |   5 +
 11 files changed, 162 insertions(+), 11 deletions(-)


