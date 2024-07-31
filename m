Return-Path: <netdev+bounces-114452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAB942A30
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD0B24823
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF31B0110;
	Wed, 31 Jul 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fMMbunLT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3951B0109;
	Wed, 31 Jul 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417404; cv=fail; b=Em3i4IvzgxOGkVI/IirnDpe9K9qAZcEkDgoE+P1cetGmOkTkvBdxunrMebmY9qPaRvR/uuOxUU2q7v6QicaiUK0hZKWf1R23ofl2NM3YhkguVejHvY5SNxzsiSRLjsEFVF8/hSpXD+izCMHTlHheevgyWlKVE8YctlIc2AVXVDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417404; c=relaxed/simple;
	bh=0rCEVsXW5J9MYbMPjjA7+ee750RFxk3WebeG9k5GbF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDSRdb4VjsFQWki/p9YRnn1VkeSOV/qF+d5sV0AV335L4zbuv3yIu4jcqpr72F1ymtYWSGK+aUVF74khReA6pCg7CSM5zOm+L+bThmwfzAW2cEGCPYk/MGzj/w3hHG4aUD5MBK1ZPc3Dv52HJUiiqk5FHqs5NlvUnzZ/NgH7sJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fMMbunLT; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew9WZUaoAnhQEtE391P4q0sNQTMkqSdfciuR0QPZb57EHdqy77ndCssoDbFVwCzaEVQIbARpf58WgTMuC70OACaUpyrvccxe4afWn/0U4v7FDCDZrvsdXODZajOZrCkhfJIWrObBxWfYy0FltLjqWKUnX/VjJlSAV98GcxVF/Fo8ydbtSTRqZJ6tpIoicL3XenZ9chesjqx/kNplosUVAbi5yW4A5q3gU8RrRlnN+XZW1iPskw5e6iXRQE/xqCZLJzSeMe9XylyRxrGkBX5053W7D5AVT5D5r96HwpNbPuTaDCBqmCqM/BKATc1buXMpC3MjP577TMPGb3iDgmLDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jaj+NLpO5nXP0Im3qi7TC5ay+Ez7VKwmTaDiDPUWJi0=;
 b=lf07fDMuEb+nNCB5uhPKP9OojWrJqf2+lIfN6wqVAHDXYPMRpLqS+mnNt2EXlHCRdyI7CIELWEnHlfOZbX7HRrEZRy1vgY2cNdIgHHZTDEem4LoGPG+lwl46cP5tmYfQllUn+Xu5liyEuRiwkeS2dB3KAqBvct8rmt1Ir6l2+xiBuT1M4pgu6wA6VZQALAgDtgr0SS1zmYtvJGC1e9LjeRHABPzoGF9skElFd6Swxy8Iv57srOb+n755I8cAblzo3zTgmtbZrqmnMtoZ51Rvsu2CngtLQuvyTbIemSqCVUWRS7zwuB5kN/AN3qKB848LvFA8Mm8SIbY48jsPpn6dyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jaj+NLpO5nXP0Im3qi7TC5ay+Ez7VKwmTaDiDPUWJi0=;
 b=fMMbunLT4cLdeF9RrAzeQehmHFZPPBg0vkNkp9ulFpIJ9rYf8/tM3/CwveW70FhIz+nkecdNdRzXgznGWl7vkkS3X1OH4Eed3rFdh7aWAkWVRNelD8dsjKlyvEu4sFPIsb8Sgn6YCDbAhW36MU1thBB6idw3Oj4lCSp+XGvxkG4=
Received: from CH0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:610:33::9)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Wed, 31 Jul
 2024 09:16:36 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::63) by CH0PR08CA0004.outlook.office365.com
 (2603:10b6:610:33::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 09:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 09:16:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:34 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 04:16:31 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 4/4] net: axienet: remove unnecessary parentheses
Date: Wed, 31 Jul 2024 14:46:07 +0530
Message-ID: <1722417367-4113948-5-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 305fedc2-66a1-4536-3d53-08dcb14179f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CeHpN6HV6dA1rqc0QbJp10y1jZi6vvvzGJIFeG0ZwYnvE1hDfiOItwdz50bk?=
 =?us-ascii?Q?SINwF9Qg2yRuuBCKd33HtwatsLC9szHIbR4JcNwMe1MST3K0YWzomVG6vCvN?=
 =?us-ascii?Q?Us77wyEFFTIZ9W6Gb/2a4MwMspJ7aDL8Xn4uHhhlfqWaXpAzkWtm6EDMSoRu?=
 =?us-ascii?Q?M3QXG50ZLxD6PQEN4liGblGOW3x+hhSqB56lJu99GXUMiN11xiEDGIJulQR6?=
 =?us-ascii?Q?5xhNZ9sfV+AbB8kvbxxCVKaRgRYEJYk7HPY6BpqAO+HHGFvlVCTq+YwENyTR?=
 =?us-ascii?Q?jco70GMHMCL2m44gFM/J06g8/Y3nfkBTEqwoXj9Xyr93sYmbz8lU7sHHBEiV?=
 =?us-ascii?Q?jprFDVKa6vp2QvOQt+Iam82pdQWR3l4KdLYqLwKqCdwRL+xIZ58MijV+81zP?=
 =?us-ascii?Q?V0uGoM4amYIdUDFZrAZelV/fpNiljxUrPezIMwQYbOrm1GCauGA06x7EEGZI?=
 =?us-ascii?Q?IGiaI6qDOnKxIkl7Mt1V0G07G2E7NB+AqIlYcaBm/h3bpyc0XJGmJ5Z3gwL6?=
 =?us-ascii?Q?9ygQilZUINLCVUG+s9nmYlp061YcTJowqlgZpJcp6coeLddU37maLLdGOayR?=
 =?us-ascii?Q?wWQKbE7tSdTO6UMNdzGbnscvWW7ctqBQa0xWq2xDm7cUb/l/hlfOTZT1m6bO?=
 =?us-ascii?Q?xIBVEudJTIsUrt2pD5R9bgASrPTEtp1Q6i+NvkzvOwdJCbp48F1fIJrN026y?=
 =?us-ascii?Q?p1u8jNh2aDGDGJ5uajbOwgA6rjEbHBUmChNaCDwVOtlW7ObmU6l0atq2fm8Q?=
 =?us-ascii?Q?Re5ydMwZbLoCb4cyisPlZYvyRjvxt93WxU30GTVDeQbYmB1YgWar8CSahKLD?=
 =?us-ascii?Q?ckeElcCoiSQ3gKqFE++wR5vrQhlBXW9FVkT7gm632Inxp8pN0shfVrAd8Ytb?=
 =?us-ascii?Q?1yd/4GH4CRFhZWZ7ftmD7UVaO8wUWlpf5/cO6A0o4lhVD8I2ju/2HV7CwZlP?=
 =?us-ascii?Q?H6JFW0YJuh+0oFGZz6JLGfuFAWcGODztLpbcYg/H0f1s3SdOEhFmqAHn+jIQ?=
 =?us-ascii?Q?ZLWynIkhfc/lp69YrxyskDhacqsIxcLfUZlyJqe4FflmINwGgsJq3NJL434y?=
 =?us-ascii?Q?qrh+r67T9fn3U96mm7Kz2RVJyerenVrJl9ipUsQ78Xq3LLo+JKHUPWSsLxvv?=
 =?us-ascii?Q?KQBrjo2WzXXN/WwEC0BXFKHKhyheQmhQRupKYfh3pDxbMfXofn2PrGJsbQnb?=
 =?us-ascii?Q?j4Hhds8gqYjksbivIOE8Z3JQfqKHMIOPnS10e/j44Y6X/syAlr88lzlHxq5l?=
 =?us-ascii?Q?QDIF4AvUzzVVrxwa9X1OL3oTKn3amKK9GckUzsZk3KF1MtfJU37yhpHRu0pa?=
 =?us-ascii?Q?BilrTTmXzSIfzWEbhwX8Wa9Psibd1X360KZEY02pSAqqqFovDF+gsuGzr/u4?=
 =?us-ascii?Q?QcbTs+hhfAG46U0LFD3Hu4ikt+I40JJMrKPzPDWJWzd4FmVxzdBGMx5XHp6R?=
 =?us-ascii?Q?YC6fiZXsSAQukl0nC18ZYnU4A7dZi+H3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:16:35.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305fedc2-66a1-4536-3d53-08dcb14179f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

Remove unnecessary parentheses around 'ndev->mtu
<= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'. Reported
by checkpatch.

CHECK: Unnecessary parentheses around 'ndev->mtu > XAE_MTU'
+       if ((ndev->mtu > XAE_MTU) &&
+           (ndev->mtu <= XAE_JUMBO_MTU)) {

CHECK: Unnecessary parentheses around 'ndev->mtu <= XAE_JUMBO_MTU'
+       if ((ndev->mtu > XAE_MTU) &&
+           (ndev->mtu <= XAE_JUMBO_MTU)) {

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Split each coding style change into separate patch.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f8381a56eae6..937d02a819d8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -614,8 +614,7 @@ static int axienet_device_reset(struct net_device *ndev)
 	lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
 
-	if ((ndev->mtu > XAE_MTU) &&
-	    (ndev->mtu <= XAE_JUMBO_MTU)) {
+	if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
 		lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN +
 					XAE_TRL_SIZE;
 
-- 
2.34.1


