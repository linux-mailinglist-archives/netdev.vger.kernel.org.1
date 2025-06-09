Return-Path: <netdev+bounces-195880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CD2AD28C7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECA4163FE6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC4221FD3;
	Mon,  9 Jun 2025 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfWK1q4f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB341E3DF2;
	Mon,  9 Jun 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504533; cv=fail; b=pwK32uxXGcoJlodY7nZhmpZhyfaJaMXu/9h/N38HVLz1rcgVKRHyLbVwQhh5m1je3TZUgzcsc9TTBUtXUactJRoxua/CwhyhtMkFwH71u+XMtm+vIlzEoU/R0KfIg/ggZBrx3KPVrRL/mtrGcizQtwUqRV8UuX2LUdJQjXYXfv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504533; c=relaxed/simple;
	bh=XZk0JlOXuB0/FsG43yne3rxfyitLItDULdl6NcL1T6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TaFNgDSgpgoZIN2bBrU7Cgtt5qOq+rxNd2VhZs/Q0l8y6rrzA6l24gG0t7wmQG62MoQA3tqemVh0ddUVsXnpxy5erlqquS18CsFYvHcHG9corJuZK519jo8jJZ5WuII/7zDps75UoLewcswgUCSmPLlUiEuWA/iHq1urkkWn47w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfWK1q4f; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfX9+uigH2nTJeer3ECr8BvHYZxzP16k0maxBNbmsZf4KGm4kaSqnUx7vLVSuK9NEAOZu0pU8anrzThd4+60b7LGQ2j/Q+eqvRY3zH5+Ip/RAcyaayJ5idsDgPp6+5koWjg4Gd+zbQ/P8tAFFZZ8cH51spnx7hpeENQ11K4xEYZcZQsmcDm3WjcutF3fEq/cnRa6kd/bEvGllgJOMnq3H/+tHO8D81aUTXzkN5qYeYP8K+zDRvC1TWPbo3U7UBkBqnkkAugVdZDmQRJmwFIHgkdSDMvdUTQyu3gCBi4/iJZfn1d8zvyyKJkWtEJ+s+/JBWZ7MHxcfG0fxkFdcO60Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBAed7ELX5u+XLarNRxS3nkIAC63RbuBic0mXTxVjw8=;
 b=QSwuBO8DU+CcoRfbtX9MaUeaa09ZHvK/twEJURCeiXtGChSVeGTrIQhl5uS0/9BH24/KTF13ylMaQtHKqkh0auTQmr760h90AXlCMLWEEqkNAitZ8BibZwQdg8CzpfLZw7q2v2wgIvClpRYmuWgVO2YrIcM31ICq4YssqQ/vqgaADf/jvoGpQUW+huYhQMJl27G+3RcRAGh/J+sLmtKE9EIovQXVOC1I/RJTVbEbn5Q5aRjyXd42a+5EZ9GBgS6FZ8Mt3oLrFEVB/Jaz9MHkCXwQTPh3HbM5+oSGpp36kW+7Va4K7PY2e+fjN6mPvLtLGKOUVdLsiSK7TQtGUjuHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBAed7ELX5u+XLarNRxS3nkIAC63RbuBic0mXTxVjw8=;
 b=QfWK1q4fTus4xqXYSdOj4XX8cgmWOqfSIzJ7+fzZhl5DtNcz5DwL+rKDEwaYyRSgZBAiyCoQTv1MweTMPWwUN0P1eUIEs9KY8x4wu2m6dLR5S5NNlRXaKGJFkjqjFf88+XsfU3Vfin444sUOzTxiewuJwuZ/H5wefcXetPvTMP8=
Received: from CY5PR19CA0044.namprd19.prod.outlook.com (2603:10b6:930:1a::24)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 21:28:48 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::a) by CY5PR19CA0044.outlook.office365.com
 (2603:10b6:930:1a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Mon,
 9 Jun 2025 21:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 21:28:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:28:46 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] ionic: Prevent driver/fw getting out of sync on devcmd(s)
Date: Mon, 9 Jun 2025 14:28:27 -0700
Message-ID: <20250609212827.53842-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 782b0082-6f81-47cb-1baa-08dda79c9ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ss7FkqNNE9/QFzP8MEua5guDAJ+MYHSGPeVOK9nOiOPtc6SKAUdzoBlrLg/?=
 =?us-ascii?Q?YOZf+41OTQzCIf9TxiuWJUl9/LsgDGuJJj59By/VFc5hCKDusIaXEh4nKuvD?=
 =?us-ascii?Q?38NJxCFvzXAMUF5cZC9eqbHzPc1AKHVvC6G1zszHjpeRzFnNWkz0BHiq1N3X?=
 =?us-ascii?Q?GYpUVnLSOLLf/m3Iz78iW8y00Tf0psKDIGDxRGC4brAhVenkUK7FL1ky4O1X?=
 =?us-ascii?Q?eAxpfiMG66188X/rNbj3MGZWwDy34TlXSL7BhUdgwGqJshG8TSkBOkbpm04j?=
 =?us-ascii?Q?tWyq1uxHUtIzUQp8c8c9JhJJNIAi0342h+mGzb5eqjAajgtVYG58mwFdbAeb?=
 =?us-ascii?Q?KL4T14FqxtT++iMDxv+ovWK9wr+TMGjSU8aTQ5me6YTruKyem/jjMMSf1QUg?=
 =?us-ascii?Q?c5IsH2FC2TgRzzz4Ny8iPA3D9kICbcwZ85qH+eOmNePzjJTr1wzohPAg9r7o?=
 =?us-ascii?Q?TLuL2neA3jPxVuRy6CwoGSZ7snDGlLaNsd/nIY/i7bVmajSR9D5eFfeGWgIO?=
 =?us-ascii?Q?yRVf5P0tSqPGJ7air7ysVCljmDL+VU6Ud9lPPAR0FCzo0NW6HjbG7U/tf0S1?=
 =?us-ascii?Q?MSQer2H0OH5zHYhy43pKjAiwn62pIhejrvoiFJjDBcx1cDgI9Ga9iTIc14JJ?=
 =?us-ascii?Q?PxxjMT8oJjqEGz3zYgNXkkG3ZpmTiUsK183FKAZPC40f7erOU2vxpOoxsUaf?=
 =?us-ascii?Q?7gF2x4nCW/XY5vBlid6e4JLo/sSm5XuOIGESiSRhKixI8ptfLkTxBKqTnbZJ?=
 =?us-ascii?Q?YeaUwkjDctlYw1J74NL/WHgHF3bTSzzHwtq+mWvpys/Qh5esglEt39F+3ckO?=
 =?us-ascii?Q?FdIkAXZLjMa7rr9f+jXUI+cSde4L+73ysGYFY7sQ0uXqvOfwGuBrHjLgs4H+?=
 =?us-ascii?Q?hxNAaKvvqRMl4Yuq8J3JBLb0FDtf1d2Nr8/yWNa19xr3DnT/o1PHMqPITzWn?=
 =?us-ascii?Q?4FegwhcXp5hFvcznNkbFYCo+lwWEYXL5z/eGUu4LxJCan1dWg7xAMteD0I2e?=
 =?us-ascii?Q?YGuUEjRGH9UynLVLEFNAVuse5mCyOGB60srdKJyhPgqVoytnBDW+dV4yN/V1?=
 =?us-ascii?Q?zDDqE1RRWmyh6TrRQqL8kMIvEZlAkcGlVx7SIdsuN2JigvqdDkaEvmAsQhjF?=
 =?us-ascii?Q?fbETOeaheEhgYTPNyL38wcgm5LxJxxHeHpAnX7LSFwZ6z7wTI2bGDZ7mQXo2?=
 =?us-ascii?Q?5xDPCkXAe78uJVtxsTW3hfYBAqXyfNlhiVAnHH2csZMFH3qmif4qIchJYDbU?=
 =?us-ascii?Q?tLHbsOtSWWwFo74XhHUC1KVRzolsJmq75iIYjeHDspg6Eh8N/FTytdkmiW6g?=
 =?us-ascii?Q?gdXWHf/JsF6QdVDereUorqzWmalcTUVHVLSHp9pwcDVHI8EFrjHVgo9AADNv?=
 =?us-ascii?Q?7UuXspp7Y+IqM+siDihyhq5Bl/94AHutHsXlf0tmWfO8JSd9XjcR6ezlDU2S?=
 =?us-ascii?Q?HjGYlS408cKmgAjQB8fZ/HMFYmeKPipNmArwGU/XnE+XvFoSEiYmZkXfMQJe?=
 =?us-ascii?Q?hboCS9HyBaQ3Cw1mC3wLl/ALDirA1Hi0jYog?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 21:28:47.9045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782b0082-6f81-47cb-1baa-08dda79c9ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869

From: Brett Creeley <brett.creeley@amd.com>

Some stress/negative firmware testing around devcmd(s) returning
EAGAIN found that the done bit could get out of sync in the
firmware when it wasn't cleared in a retry case.

While here, change the type of the local done variable to a bool
to match the return type from ionic_dev_cmd_done().

Fixes: ec8ee714736e ("ionic: stretch heartbeat detection")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index daf1e82cb76b..0e60a6bef99a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -516,9 +516,9 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	unsigned long start_time;
 	unsigned long max_wait;
 	unsigned long duration;
-	int done = 0;
 	bool fw_up;
 	int opcode;
+	bool done;
 	int err;
 
 	/* Wait for dev cmd to complete, retrying if we get EAGAIN,
@@ -526,6 +526,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
+	done = false;
 	opcode = idev->opcode;
 	start_time = jiffies;
 	for (fw_up = ionic_is_fw_running(idev);
-- 
2.17.1


