Return-Path: <netdev+bounces-184420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215EA95574
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B4C173881
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E361E5716;
	Mon, 21 Apr 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D5F3eI+p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03221E2606;
	Mon, 21 Apr 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257605; cv=fail; b=otxX6FjtdcMF3cFfz+TS+AZfPh1VdES7j0Tc+GepGd9RqmPj3VQWCqHpdOCpbjlDr2NGp2BQCYRtAugoe589NHyPuVWVxXXzDQUjHDmBn5JJYqZzfCvRTjB+4aduls9hEgf24UjSdKbtSWOsV9+eSFZyrLBy1dX8kGCC4ac7WjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257605; c=relaxed/simple;
	bh=olCpvmcBpC3jwDgThvwlR/q4z85ZVhQFkNXHDLygA8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1mnCD67H3rl63TAIJkAHzVvTsVJRGUgoPcWiMVUb4Tlz+/RjXzh5PFx4xmaG41TDbTjm32iIZ+FRq9A4iXibhKzozUmm4m1H7qTxeVXsNtF0Bl8pRHkT5wqDNdf6Okcpu1yZvrSiquag2exPxP2s0sP/HYhk+FmKYgVRfueS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D5F3eI+p; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2G4xWIGkxe7oyHatCoH0Gc8k59W3Dt8S7Yaf8EQM2XnHrUXKc+Fs9vbVpZFVYL8ElOu59Pm50V3fwaOp2j8H+xh1uFz2XXv/7V0JBA5x/uOt+HjmiuXW3rfiqinb3V6UbeCev+io4e078M1o1gdyYhDBBtlvyqVno7VRO/Gya8hjnK6gTxWH0DWbJ3XRoT6i3+A0WsZ3XW5YTANCeh9uSDjdPZV56h3+gXFbzCmnGYQmKrw2fdaVhLAw2FuoF/RTXjBtOAprVdEOM7aK6E8sKPLFqOeBrUE0DSoaGIYZEFMSAn2R/2zaaVtH5goiewDPlPIFqu1pao261Fp9uJ4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BD/WcJPhhOwQvQD5Kzl1jxErw90YuQHE30vv+/4xWk=;
 b=Ah9j+uLUtiM7zY4eRTHa458rpW2RAgDv30fQSyNYPRjGAfWaoIxZtDDnnBMzG1BaF9N4tmQlPA4wVt32ODKoKQzjnEYlDdh6tXMFDnygzcWIUZdoZXdYgjBQNVDRDBoY6KDSTwN9hgCFUoAc52UtdeBOiZ4tfezD2L8FFpzgpev3imVadRkjmQFqAtnP14Gc6r0kKnVqRNTECuuWaknGlsfP2MltH85pdSSqfI87e1NvUI+HWWYI7CrjLvBNw3J6rHFH8KM8lX/fcv3n0eOFJdUA6uCIeaJDxiMKVrTTa39EbYgp9BjPQkat++jdfty/Buy5sUWmhJDS90TS4jNI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BD/WcJPhhOwQvQD5Kzl1jxErw90YuQHE30vv+/4xWk=;
 b=D5F3eI+pVVAT4M5uBA8JCRo+Kg7RTp3laR3/NqEwrh7xlBhyqru5rtOx/WAAhY45gpNBaszVXUqseWFf7VcUcozHtqhV2HUezi6w/VzFnfXE0bSHs7CHV5JXzM5pZu3wD5X52FVI8pE2bGnEsdTbpYS4UQ4IoOOJ4sgr8wUPY2c=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 17:46:40 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::37) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 17:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:46:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 12:46:37 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 net 1/4] pds_core: Prevent possible adminq overflow/stuck condition
Date: Mon, 21 Apr 2025 10:46:03 -0700
Message-ID: <20250421174606.3892-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
References: <20250421174606.3892-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d742791-8f30-4849-3ee9-08dd80fc78a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJQxe6cfmzm+TTNsp2Fs4qr1wDhpl8MxJtkAJVmNk2a/d41BhcmZHqqctdsH?=
 =?us-ascii?Q?LWW3nTW1b2Gns8XdY0siGdCHGqdzv6OY8iOfF6CmAFnc3Q1Ntiy6/JzdGcey?=
 =?us-ascii?Q?jlS8d07imm5q1C6aBGXduEbI02jX8++CQBhMXmEOCmb5ZBI8hjbmJlOkBUYY?=
 =?us-ascii?Q?txf0uahyfsL1DGSLrQu//0FQQ7S/5rHDVxcBFwt+IVlervzkQn1dME5xTsVC?=
 =?us-ascii?Q?i+k1irrS0GLEJ15E9r4fG99Xzpr1AKV/uCR6T8E6982gvgAl8GoRrKsjviob?=
 =?us-ascii?Q?7XcYu7nQ2Ia31rAstXRYXMVVlrz1B4Va+5VTpQdULnIkZVaaNvdUswKQz/1m?=
 =?us-ascii?Q?S23IVs5M3TstTuZiYmLKMTwdxAfFQ+SV5Ld5saHw4I/0z6xTzJjOm3YSQM3I?=
 =?us-ascii?Q?WCJwtDk8fGGbVAfbS9N5IrljQ5QaQZZRCee7j9052sKOk3pDWqn7k4Lx0v7X?=
 =?us-ascii?Q?0ckcLSjP1o6q6CCJJgSaTcEstdTcy6OyyY27XZfUyRFdwylYRBGHcqrPrarn?=
 =?us-ascii?Q?tOuv5DEDZLG5uaQoq+ZOVfROQwZ8ZCRQTucEco8L5FAes5MMxM8V+V30D3sg?=
 =?us-ascii?Q?gCEY+A3DbamPcWHqXrNPzyeOj9TSvZD0q1SMMnGnjJGkQhpE3dpGlJdPIlhv?=
 =?us-ascii?Q?eRlgmWM9a2otVAf7egULTi2AyKmQbgspzb/+9zrsGVaN+gPFvany2c1KRexc?=
 =?us-ascii?Q?1u23eJrVxK6GOIUKvKqUFEbq48UlllTI382NBckiQSKJLAzgVEBOJauWlkw4?=
 =?us-ascii?Q?AOcvZ8k6RngPL7T2AGVim1Kb1HNKuM4W0dDGgoa6xkopJjSBezfP9c54XKYb?=
 =?us-ascii?Q?nv74mXVoVWY5ieJ++MwAXSd7W9f1b4YVdDIQLAgZYxthDEAUR7NKjQgxq6MM?=
 =?us-ascii?Q?lOZFiyw5jiw+t73NARzTSQkFj755v75A82jEaLgnj3vVZtDAKF4i4rw0qU36?=
 =?us-ascii?Q?11o3KclbjDR2ZYE25OlBchDAesMMrTYmuuRu4aItxWktY+I7FIfNvmdSceP6?=
 =?us-ascii?Q?dhf0+gCBjXdJ8PnyaK+dfD02zGO0vbHguoe9JD2x6jdLAEI1QUXUb6SbQRU3?=
 =?us-ascii?Q?eTF7s26SbH0ZaMV/WyIDHbM97YEiY0r9kEXu0QR1DkrzN+gbuoNr85fLrVkx?=
 =?us-ascii?Q?Cz0SDoot/FNscisNUaZEJuTYf7l6saYICRmd9PuOdNg3a323kWtIWUMKJnBt?=
 =?us-ascii?Q?CrgiAytJIXiNZD8pIseWZ/i4AHRP8bMqdigvjHp1D8HSMi0RzZhSbIMK5vHr?=
 =?us-ascii?Q?paVWc95fuyqX3OvDDK44LShQKRJSSc1PAzWCE4Y8Wf6NQWy9k4MFJ6VjOQIy?=
 =?us-ascii?Q?MWh8BJN0HXAW98L88f34S3bmNc2/GJ453h6y9anPBm87XsGqs182EFbQy0E4?=
 =?us-ascii?Q?3BLJs/RaAi2wcsX9RccVNqzlS+irwencxooNwga2V7dTjmgMEmxjaNHFbQxK?=
 =?us-ascii?Q?P6YzPFy6KhLShyUtYA8rHhG2vJTXzTDAB2/UYRVElXARNbIhtD07dSmGyTuV?=
 =?us-ascii?Q?FsM59LH09jLblrqlRBNrlsOKc4+Tx0JpcsiROR3UwPb+SoNSanuNGOGVqQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:46:39.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d742791-8f30-4849-3ee9-08dd80fc78a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

From: Brett Creeley <brett.creeley@amd.com>

The pds_core's adminq is protected by the adminq_lock, which prevents
more than 1 command to be posted onto it at any one time. This makes it
so the client drivers cannot simultaneously post adminq commands.
However, the completions happen in a different context, which means
multiple adminq commands can be posted sequentially and all waiting
on completion.

On the FW side, the backing adminq request queue is only 16 entries
long and the retry mechanism and/or overflow/stuck prevention is
lacking. This can cause the adminq to get stuck, so commands are no
longer processed and completions are no longer sent by the FW.

As an initial fix, prevent more than 16 outstanding adminq commands so
there's no way to cause the adminq from getting stuck. This works
because the backing adminq request queue will never have more than 16
pending adminq commands, so it will never overflow. This is done by
reducing the adminq depth to 16.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1eb0d92786f7..55163457f12b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -325,10 +325,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	size_t sz;
 	int err;
 
-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
+	numdescs = PDSC_ADMINQ_MAX_LENGTH;
 	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
 			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
 			     numdescs,
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 0bf320c43083..199473112c29 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -16,7 +16,7 @@
 
 #define PDSC_WATCHDOG_SECS	5
 #define PDSC_QUEUE_NAME_MAX_SZ  16
-#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
+#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
 #define PDSC_TEARDOWN_REMOVING	true
-- 
2.17.1


