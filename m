Return-Path: <netdev+bounces-161433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64244A215B7
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 01:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BAE1888DDA
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 00:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68517A597;
	Wed, 29 Jan 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E6gO4tOJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C917E472
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111444; cv=fail; b=p4YwNmkXInEXiCZyvHO6N0cuGqE3XeeN0Yiz+cp4xG5NNHoyXiSHnZO7maXu5zY+1HVSb7h6PZJOdKV1awWHalFVP3BN7v1zkBqJyMV37kUlOhde9hy2Emmi65EFVf+Nd2Q2d8kMKwKIdEAFuLIX6uvMebRIGufU3VJVUe4zKbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111444; c=relaxed/simple;
	bh=pjz3LNTWe7E5c52K+8G8new3YJjYSLqQnxoTDaJShsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B70SdbX0CqEwMjVR+qHJ6QR6hayBKCaXf4/RdB5CAFBw9ycyfZaEtngdPgeXMRibrZgTkmlNHN/DLtRBbHyNSipg5uIBJ5onDaa+193kPVc1UKTwCQPlu3vb1CXPprF/rZYoPQ8oPofQVu8h+DQlEwr/CX5MVAd3TurWu+3+uLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E6gO4tOJ; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN9CmrV32SneMZVz6DBUu7lhJFyWyhC2+MQUhicWwUxVHRzrV2pc516rs98r/5JL5hwVMpvvF40MSe9nRTVw34HkIjdQqFly9VF3sC3z64os76bafKiTWQBHu29pSM9zBy9dYURXPHUNt7026SY3y4SjQNRJk6kwfDA+mxe77jJGfZQBs/p7V57W1/rYywLbmg/dyYlrDH7WR0F4NzAv3RKXvA4/cbbbQzhTcxZche8XBG7940l0KmpGbjnehAmmiKkxkCI8nGrE7ozuaBKd5K89ILxXwnSLzG5fAds3+mos5jtlBCaiFFzZhM+Z3aKKlnSJkPWqbY1b7wJV4wr0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KULOvc0wL/mwkaELY6jxnY3Lngg/U0FhM1OdKt/qsOY=;
 b=RwNVspHbqQU7DZo3OVInSInupUiJhw2kIyG5lz5WeyFWfA+i8vvYY//xm6+nBBBDapf/P/unA3TCqDNUaRdBaOAIcO1x0mmbOP4rDCiVSYpIkl+wHHadN12XAin0Sas8AwC2fGxOLCxzZP7jlkYcinIq1t3sJtns4gut+4+33/vd5ZpRS2DmyA1/9PMc599Tf8t3D79x4vD7JpuXJnjyyc8xT8hXjNsD/CA3U92S7QvaJ2kNoO957+HHht77Yr94ybwC6Sx3k8d+afAwkrNM16ZAamV/YbwaKnOdsofDbS4V5AU5xAr9e/H8L2XPYiR8gDX6+X+rhvwm6jAFm3/paQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KULOvc0wL/mwkaELY6jxnY3Lngg/U0FhM1OdKt/qsOY=;
 b=E6gO4tOJf2+tGvasmSPsSZwHYT8wxTrmW6xz8VgtqSB0A7qsogl3zNqrVZMxhJkr7l/N8xNvc9H1FK3ZocrJ0f1JAeT6VCy+OhMl3PqdWKCptzW36SjzJLX6WqOEQvQkjxAofhAbSCGRg1D+eWPoSlaTuPShk/9wFm2Xh03ypYY=
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 00:43:57 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::b3) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 00:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 00:43:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 18:43:55 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 2/2] pds_core: Add a retry mechanism when the adminq is full
Date: Tue, 28 Jan 2025 16:43:37 -0800
Message-ID: <20250129004337.36898-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250129004337.36898-1-shannon.nelson@amd.com>
References: <20250129004337.36898-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 336463d8-61a7-4f68-09ef-08dd3ffe03c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/8rv9MG0GcpIhfGCsiBuRwTDo5+oGYTZavfZoIzXCQWngCpPy37f95rg5mH?=
 =?us-ascii?Q?zafb6AYwU3eQEsSBhIQuc6IzxwH5E0N6AutmZfy+UYaoilZkbVixtJ27vKJX?=
 =?us-ascii?Q?XpfE8Jz5jJhixRTaYpThimfhdqDrtUjtUEVRJMglmX2orZlbVCq3edGZTRlb?=
 =?us-ascii?Q?TUNQqJFdZyg5GAVDXT3CbVYgJipbjRqJk5qnVSPDrc9w3rAxVzzuAZFtcdY5?=
 =?us-ascii?Q?FyS49WM4m4s1oGiFFCll65gVXhTomwL1xnzndCZwVHSM4N/YO/jCne/kKTGw?=
 =?us-ascii?Q?aPxnAmK2bsfdvdYXkesevwQ/Pq/xs0UF/U7gVW7R2/Qhv/yjoo/MORmkEmmV?=
 =?us-ascii?Q?0Jbihq/GSFQnbgIYLOhDAToogfJyBltpKF94FoY0ddcqX95laP9Gn/eMVBqE?=
 =?us-ascii?Q?1tD3Z4Aoa6lyIhI9sE7oidN8WEzkMrssSuBWGYdgKqDMGIGo0wZRm1eo0X5r?=
 =?us-ascii?Q?AUCs/hJBMJlL7kwwsn67oeFXLLq4Tj8Mj7hrogCayh/TsFF9Admd9a9eEXfy?=
 =?us-ascii?Q?silWB7hGOEQiQ9F/Mi+PE9w4w1RRrvXU2pnqpK+8VsutlwZDT7/SBqtbdTad?=
 =?us-ascii?Q?G80PVVuaB3JS47lG4/NFYZAo3pJ5fCQ/m5LyA7HnHSS56+6Ti/Q7chV8+W2f?=
 =?us-ascii?Q?4Bq4Fvw1uiU/pDdOB3ziM7yRLH5kYy8DnMw5BdyCuP6bVCV7nmxnDTE4kkT4?=
 =?us-ascii?Q?JOYNLPaCvh+n/+f5xbH9CzCbGq2TnGihsEC8TmOlnmjvlW3eLeGIGRfwN1kk?=
 =?us-ascii?Q?SpuikjmxqvYBLKOSLXSh8fXXyLWGVjf6sX2uKs9A8pxD+zzfUQWpCK4gh4qP?=
 =?us-ascii?Q?aPkTn8hJcgnhDmjnV/OYQ6MTU2uVKlFOYKMTdjej7hUqIAX8R0CfVLQ2Jy0o?=
 =?us-ascii?Q?xrafJsXoseUsXTbfe47EqM5bQj1yOSqQAza8tbmwVZxOOkQi10wfZ01HF+PA?=
 =?us-ascii?Q?q7UEx1Bjjhqovxg94ov4FRyOeCiwUarCUhbFW40DHvUUP2bIvFW2vyHIRkd1?=
 =?us-ascii?Q?BzbW7vvhmdE9jSlqkB4O46nwMBjtOzwTbdecqhd1Bn/IAb0/dPXY3M0NTNUC?=
 =?us-ascii?Q?NpMA9+EPLsMqt//D/706T7mz/3jftwqHBr33OlYQb0w54G66hqdf8xaJs3Kl?=
 =?us-ascii?Q?P6VAnN+GeyWAv1nVwf16dN684LfHxTl1md6ItVWibQqhPLGRyDFU/u2nCNEM?=
 =?us-ascii?Q?Hb76UrakRvTMCZw0k2dlml9OFukX7cDILKollaVIinNvJySnEKmeMtoMl58A?=
 =?us-ascii?Q?UirJlo/QArY71qmmEj8LCMtwJSxUysUVnliE+qcbO0Qk18nflCeBkBR3c0WE?=
 =?us-ascii?Q?ALqzeroCFXYh4kUILM6XyD0Q6GXRFiXq//eTypLtUsCjn9Ab5ci65l5HDBug?=
 =?us-ascii?Q?/2hELzNZBeqefNBhS22dCq5cxPIswWlCUM0qfps/oJ3RQbeQTStv9flAh/bJ?=
 =?us-ascii?Q?y0URzuMeYPVvQfWQiJ2AD0o9ntSaFQHRhQSLCVkOArf8Ao4HI3qv345+2FEg?=
 =?us-ascii?Q?LMVeNgdSogE9Ac0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 00:43:57.2403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336463d8-61a7-4f68-09ef-08dd3ffe03c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

From: Brett Creeley <brett.creeley@amd.com>

If the adminq is full, the driver reports failure when trying to post
new adminq commands. This is a bit aggressive and unexpected because
technically the adminq post didn't fail in this case, it was just full.
To harden this path add support for a bounded retry mechanism.

It's possible some commands take longer than expected, maybe hundreds
of milliseconds or seconds due to other processing on the device side,
so to further reduce the chance of failure due to adminq full increase
the PDS_CORE_DEVCMD_TIMEOUT from 5 to 10 seconds.

The caller of pdsc_adminq_post() may still see -EAGAIN reported if the
space in the adminq never freed up. In this case they can choose to
call the function again or fail. For now, no callers will retry.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 22 ++++++++++++++++++----
 include/linux/pds/pds_core_if.h            |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..387de1712827 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -181,7 +181,10 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	else
 		avail -= q->head_idx + 1;
 	if (!avail) {
-		ret = -ENOSPC;
+		if (!pdsc_is_fw_running(pdsc))
+			ret = -ENXIO;
+		else
+			ret = -EAGAIN;
 		goto err_out_unlock;
 	}
 
@@ -251,14 +254,25 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	}
 
 	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	time_start = jiffies;
+	time_limit = time_start + HZ * pdsc->devcmd_timeout;
+	do {
+		index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp,
+					   &wc);
+		if (index != -EAGAIN)
+			break;
+
+		dev_dbg(pdsc->dev, "Retrying adminq cmd opcode %u\n",
+			cmd->opcode);
+		/* Give completion processing a chance to free up space */
+		msleep(1);
+	} while (time_before(jiffies, time_limit));
+
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
-	time_start = jiffies;
-	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = msecs_to_jiffies(poll_interval);
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..babc6d573acd 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -22,7 +22,7 @@
 #define PDS_CORE_BAR0_INTR_CTRL_OFFSET		0x2000
 #define PDS_CORE_DEV_CMD_DONE			0x00000001
 
-#define PDS_CORE_DEVCMD_TIMEOUT			5
+#define PDS_CORE_DEVCMD_TIMEOUT			10
 
 #define PDS_CORE_CLIENT_ID			0
 #define PDS_CORE_ASIC_TYPE_CAPRI		0
-- 
2.17.1


