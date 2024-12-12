Return-Path: <netdev+bounces-151519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119949EFE4D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12EE28771D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A61DA100;
	Thu, 12 Dec 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QBUMz+aX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139A1B21AA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039147; cv=fail; b=sCx8n/LmVJkHBj1iBZvaykUCtEuLRWzkbehua/oDF0PAvgHkZG4HDg7IjqX+S6T6xwZcv4NyZqRJiBuBFfBe9nKWnHBZAI3qIF264+5acQCnoABuhSgKVxVyzblch3YdIFvavi8odRiC79Qol7Plt7/EfvMl2f+StPXo5o4sRo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039147; c=relaxed/simple;
	bh=wsnuJA5O4s62G60RQvmi5CXZ1UBveF3b7fp2NO7sbzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX6S3keD1gMrqsxznGoAxFu1x96NyFwBCxRBV2kbtoABA3xOw1L5OeaC+nhwbq1B3G14gb4WxQCq3tEkHhzamm5zRozyXzayQSqQqVryyXYbvq9WeqdPPCggyD78X4gyLrMZXMqBEYidAG6mIW3TAy1xImLgXdBzsQuaZk0H15I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QBUMz+aX; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAJ0XAKIwj92wY3XegvOzuBOhe/5sTslVRvOFckvdpDV9lRwOnmgwRwsJWHuedxfK/5dAtslS0sd3rGklJN4K/dqDwUrlbyWSe3tjwsWK28wmm0wmb0/slq8K4AbSdDgIk8lYKTlNuT4NJTADpzK0dDMI/TFIDUkgoY65myPHkzIRHV02/NbIFIzuuZjaK3MmCtUjAk3fGrUOUnjgf/5P1uuTyGWZLwpXdTfo+jsXHnzDmaPM9xhg8EwvU0cX4UM2oq22o8S3QhbYEjVafnkTMSNC3sOJgv1O2ntbfm6GXhjX2fCC2+NezkECi5q7IrFXnh0oCAknijin8Ei820hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tnmOvRBipRO86D2hN7Zrwe3H1wQlpdNSx7ldcKH7/s=;
 b=X9bvRCqzBUV7oeXGUFjoMEm5jZ034P9h/fuTVcgPGWZw5bnjdjzBPLaWGecS+bORm7tfMW61nnFQHJuvPHvALo0JTEqvCKno1fSWJQbTucc+uGR67YqhDDaIbZRguupF2Dz43zStnNULj6pTfmrXiR4REFTvhtq4NNEh95w5/eH99vKupWBKBDgulanHTSoyZYFim3pbklYk/vGD64t02PzgvwkUw4jnM1uv7TmMEKX9p4gOlBCSy/iKfazm9Tdx3wa0uzsaAOip2QezVF8NJGLDdTiVT0cFc7ehDfx+hvdhhJG1bTZ2L1iCKJuWWL2OgRdT10b4Y8wttpV9aWqhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tnmOvRBipRO86D2hN7Zrwe3H1wQlpdNSx7ldcKH7/s=;
 b=QBUMz+aXXkJZhwfeiqZ4QtzV3LePblt9eXN429CTH60KkXsHSRQcmRn8oW4Qtgb687ph5ekEnE6gejqz7PS5STQkZF+1i7qsFdmcc6kxr4ylY9akJ5oODGXMCcZwiREzn3yi4J39wZDC19KbtjAoi8uD+q+YwlbztszvoA5Q2cA=
Received: from MW2PR2101CA0010.namprd21.prod.outlook.com (2603:10b6:302:1::23)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 21:32:22 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::e) by MW2PR2101CA0010.outlook.office365.com
 (2603:10b6:302:1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.4 via Frontend Transport; Thu,
 12 Dec 2024 21:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:32:21 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:32:19 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 3/3] ionic: use ee->offset when returning sprom data
Date: Thu, 12 Dec 2024 13:31:57 -0800
Message-ID: <20241212213157.12212-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212213157.12212-1-shannon.nelson@amd.com>
References: <20241212213157.12212-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 32da3325-5534-4242-ddfd-08dd1af4767a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gnL23aYDCj+AiLvL/vf7XvxfjQiLaMBX8MYIV1yPtj0uUqP/lTvABEA8h2H?=
 =?us-ascii?Q?jtNhZJgm+eDVOGu92v4qomdX+RANkMWiqI5fbQ0XyMnEn/drGejhhc81w/SH?=
 =?us-ascii?Q?AM2RAf8LcVGHxwQEKYt8N96uU3fNLEqKzwOgrbS2lWAVa1RkXOj6qKFmxVV8?=
 =?us-ascii?Q?RJU2pZjY78bchz/yZudOLA1MncSLkC7pRK26yFFWw3wJzaww0kJ9+COP5pNJ?=
 =?us-ascii?Q?mwWGrClGfdf5YLTNLyALcVKQJJPk7xbz2kbLd8xrUBFWMmNvCiX0RPH6mJw/?=
 =?us-ascii?Q?MujdLC9scwRbqxjYHnvEviNV8TsxR5rkfjCcE3Er3o0TevTbvPCWN2ImZC5f?=
 =?us-ascii?Q?SpTRpkudm59egjjZYyZrUuBp0wfRxC2e/6M+iyNsiOnGabggFabAHpwZyRcT?=
 =?us-ascii?Q?1GbRdHZ1zStuoskSUFvUnKzXPS8wC7juINZGgwEtBIyQ5r1lI+TS6ghqMG3g?=
 =?us-ascii?Q?1pSBqOEzW12yj4gAt/PHPdc+EmWQKluK9p8N4XEY1REjtB1Dc4eGMTlCS3OJ?=
 =?us-ascii?Q?u+7FJqy6JKTGtlu88Rg5hMimyLTHBip4WTiqU3j0IpLznFxs/cQmMui1s7Z6?=
 =?us-ascii?Q?8e2TKZczC97jBXsgcl8eD9mHIqlE/cK14HjSenvy/pdlKFheKaVLSlRQyLTL?=
 =?us-ascii?Q?7DmbDwyIiPoHLg/i17NIzBDahWUNAhxFPmwRiSnHghNrebthkNTZk8zLqHUs?=
 =?us-ascii?Q?YDm/JqAOXwWQlqOdVsNtxTjRKd1u77oIuw7pB/0DG/YipWYIMiy+3ZmTWas5?=
 =?us-ascii?Q?O6ljDZJ3s81DZnvTqZ94qEAE3Rwryr5pz+Iu0b0L020r6Y1RtI3uZTtBuUYs?=
 =?us-ascii?Q?jFs5KZO93za38epE2oTr5iGmVxE6RNVqcUfJ7pNNEI/hzEl75NFgnBulnH8w?=
 =?us-ascii?Q?PYgz00zOiSH+WcAzXFcKZdI9iplJdNZwEBQAcpKO0ilCIedn+wivCwGtNLTv?=
 =?us-ascii?Q?jb+10bXuGG6ob91+xgGmiV5Eao8p6AFvwZpk64eDGBA7fn/2pMgiIOHj+uzV?=
 =?us-ascii?Q?XZKg+9xVbguqwk+CXqJEc8N3dTcpGHf38R1ojeu9IfgAJVB+ANg32MIaT8Uq?=
 =?us-ascii?Q?8tKZdLnN2fx3veBhGMDEnxgxlprK10XJmWmcgi52nkWvO0m35JIYgQDYUm88?=
 =?us-ascii?Q?4uRjdFonM6dD52cHkvjcsWmVO5Sd0Cn+j+aBHrJu7aafeIliyoDnWsORj/Md?=
 =?us-ascii?Q?BE4hDPyCJN+rsw2t7R5I6Neibe+f0MoM3FSIojFATnCau4687h4NPOrWbxCV?=
 =?us-ascii?Q?gXLoSoGU3Jve74mmUfOvJvWiWHqYK4F1hLaOhqqbzGBo/RutAjHilJB9nAWz?=
 =?us-ascii?Q?OflLGahUjhuKTvlVsUu4Y9do8TcHMtT+OQGLFfO+/XP1PVUTZ25Xrm1nsCy5?=
 =?us-ascii?Q?2hCYA5Jp/rcH/xGPsuSw9+bT2inC0s/yZVGt1CuGH9Sd7Pikd51KtA0cnybp?=
 =?us-ascii?Q?PFb2i7/57S+L3MYRbA8j0BG4RVDH64Cx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:32:21.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da3325-5534-4242-ddfd-08dd1af4767a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576

Some calls into ionic_get_module_eeprom() don't use a single
full buffer size, but instead multiple calls with an offset.
Teach our driver to use the offset correctly so we can
respond appropriately to the caller.

Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index dda22fa4448c..9b7f78b6cdb1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -961,8 +961,8 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
 
 	do {
-		memcpy(data, xcvr->sprom, len);
-		memcpy(tbuf, xcvr->sprom, len);
+		memcpy(data, &xcvr->sprom[ee->offset], len);
+		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
 
 		/* Let's make sure we got a consistent copy */
 		if (!memcmp(data, tbuf, len))
-- 
2.17.1


