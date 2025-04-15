Return-Path: <netdev+bounces-183050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0CA8AC18
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18973A8D02
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46322957C5;
	Tue, 15 Apr 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vUXKfNAA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814328DEF7;
	Tue, 15 Apr 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759806; cv=fail; b=FyPOjHypJHdnZmqPTBgcQGTVWqA+PaIfYH7wBMvTv12Q2fbLb/H1REtxllpQMVeoLFKlGwF05IzlR6tsbgvaSvjovuamrLKDbF1imFiM40lZwPWJgvfYedwhS7rFFmiykU1gl6WrDo6dp8vHv+3XTb0b7uefZj2O6mjvptkUF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759806; c=relaxed/simple;
	bh=jpQHxQaY8VQdeivAMX5f+jDbUr09TpuwO79u4ekMR3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VivbPYZUvvQopiesC5GtCgcw28qRFcE3MV0XEHTJweLeniK27B0P/+ZNlDknA7zHNunUT9ijKurpOtv6K+28+ZYSBWsohSoKJvYN4a/27EbTI87Grrsz+W3uL5sb7b3uSXyqYrUBptesR7xlWP5/nG/Az7ge5RqQzzHfJkGiKf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vUXKfNAA; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quGCwRLr5aHVPVQBvmhjAFlgWv6bL90cmnpvZnItAkOjsZ/7nTEwI4t6EuaHuKApynKVizvXo7dIKCmIZMKYui2SrEpDbALZ64/HM5bG53P11cUag/i51wZRZ7s8A3pXkGE8j9YnxVW8q9dy9mtqeY7ql76LnlyD4k8zkf0auTcqI/kedswUt51fG0hY+/hUvln6NHMvPQUwQKFekVcNQ3LaEFuYAZCUg1/5joxtdxgEk/mTPUbMkGCLGL8H7m9k5YPfBx2EEBSO0IoXfieKGBrdeuyBPhQjkk7OiYDwZR/B6J2PbbqN3+hxm1qtiQn8r8C8Hjt8qTImrryhhHxGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJbEixpyW5F27jTSxxh1MHL7fmxvgSogQ9tuFoJyR2E=;
 b=FMAxSjrdBJgCmcME7IGrWpyxvul1wBz3cmegUtL2eMtQxiQO/fzV2DgsUSCJQWSkcP8oEfAq/GJCA6xwpmae68OVl23jh8MO/xN/zmhSJFrCe6zMUq9BTzNyllTlKuIzNpyGuT2Alct+dHoUwBnsuD/WZ1vBDH/FlLsRPxyzDtds6vLkLXstuxXzY/WJDkT4IpaoJhIuIx01/zTjW38YDwF/r6usX9BFb3Q7g7UBkcsmM2mHEgvTCrODmiNpoqKi4hgneAR89j19ayBWqAVkmX117I7XK/W9jqtd8nzQZ0MeFlGaWOGymoQLTB6scLtiKQmjU2jDSil6AYf+0/qPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJbEixpyW5F27jTSxxh1MHL7fmxvgSogQ9tuFoJyR2E=;
 b=vUXKfNAAQDo7CNOuG0wwMJH1m6eeOha53Ix8Kikf0bFNmQaxKvdKz0F5ikB9vzoHrhEUQLr3uKHYY6pky8vboZT8+/XktE+Bfs3/NajeCCDINA2xkmvcgXxg9nKWSgCTBX8s9BYn1dmRJxpYGDu7ENpH2IrC4ygi8j9xpIyerqw=
Received: from SJ0PR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:332::15)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 23:29:58 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::94) by SJ0PR05CA0070.outlook.office365.com
 (2603:10b6:a03:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 23:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:29:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:29:56 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net 1/4] pds_core: Prevent possible adminq overflow/stuck condition
Date: Tue, 15 Apr 2025 16:29:28 -0700
Message-ID: <20250415232931.59693-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415232931.59693-1-shannon.nelson@amd.com>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9fc1cd-e387-4741-b04c-08dd7c756f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qka+Th4cl3PKbinDGglghvY5GlKmFUDnndl4nCw6iSlMTUeYyPPlOJv2snZB?=
 =?us-ascii?Q?gjUc7gBv/nE409z1lEtqaVF0hpjgK//effkJhxp5q/uF9G94kQcTWOwsiWMh?=
 =?us-ascii?Q?6SuB19M0ubiaNokIJaO4MYg/uz8ySuNETtFhCZg4rrM7/tkkM+MANSqA5fEp?=
 =?us-ascii?Q?j+DLEl7mwAuTZJ/RFhgUBsMoPrie/yANqc7B9/WBbjGrc5AJh7GCTp7n0xTN?=
 =?us-ascii?Q?tnn/VF+fSCd5h4klyeclUpNiaB9Q8KDKBQAq2KiMLornpZpVgX1AQEIG16j1?=
 =?us-ascii?Q?MZInVqzORFkxul8JRYnMRlWECIghAQFTNrl/+qpyCkqEh7zXss75aCzBPtTa?=
 =?us-ascii?Q?WhF/+RT9tRIjmFmreF1hObg4ANMFWUhAgHKVNsIvz97uEWDmVwguctodQfB4?=
 =?us-ascii?Q?NeXWBfwd4B72+XU3+KHf9xmlCVvLY6GC5qDoXd1L343WjKRl3V9kdoqLIoS3?=
 =?us-ascii?Q?v5oZBedbFEToPMOokh0tTGJZbeEW7+HWeK5Eh89mFaLl4hq0bGd+fJaM0Trh?=
 =?us-ascii?Q?3190B3LPEBSWNjevt3rjY6m3WIO0VUS034GlNK+OkGuN/xnX1rs4ONQ6Y+91?=
 =?us-ascii?Q?qTw9YDFPImeYfR4sv+3Z0aViRQqxaiqHW0buAQuV6Q5BYegycsDPNFDarmTH?=
 =?us-ascii?Q?79PfE24GPDRjGgNU8tMaXctsTT07F3I/SFxjgCRWb55BrhMuC11+Xif6zP86?=
 =?us-ascii?Q?F5GPHjSIEQ0Ic51SYNp0Ux/VcGQ9YG/iORI6MFXPbINhzr62HdSkmpDwUSQP?=
 =?us-ascii?Q?a1E2wYrlcay7uqyHftY6eGXZunk/YygddEfnvQfOHlVH8OaVICTowZIzPst1?=
 =?us-ascii?Q?IC0fFmbrdnOJE5SK9LDRLcFvj0Dg8XoyrfQY8V+S2v8WfrkjLMm5omAQy1RL?=
 =?us-ascii?Q?Q+aR8+Lc60aXmitUduP+vlRElH94HWwnB9GKzDy+02CjCA20Zw8+v5L3WrNr?=
 =?us-ascii?Q?1U1wNlyfRMFF3Lpy3bdJwwJJMwaZWclNx2njf0BH/Js98h+PJtJOaffGiHK/?=
 =?us-ascii?Q?cTJZkao81PRzhp+3ArH7GgCe6ZBP87XdGFDcqR2EnR/vh0COfrRL9mpl2C68?=
 =?us-ascii?Q?xYkjZGtjZgw/Ry7DBU0BLGKxQJc6f1DmIimSsa79BSPv4tHoGF9FjfOo3OWH?=
 =?us-ascii?Q?DHB/eg5gjVfv25E39alsfN0pyi9FDLByM4CNgqnloRK03MjcMEbKbChtok+a?=
 =?us-ascii?Q?zK25vRDhLDok62qppTqPpABEwfZy+Nkw2RxWS8eV5KuI7jGSwV9ScGlmyBVH?=
 =?us-ascii?Q?TJgoiZWtam4hij9RH2/NlOtGWJkzplA0Tq7/DSNAnK5opjW3Iv/j+LcUMQyG?=
 =?us-ascii?Q?uPf0euYOlPzD7mZtOb2qSkaH75o0ejf8vlgeWMAmrSOhB+eB8WOr7+7bEyOQ?=
 =?us-ascii?Q?2MS2mpQLaE2WEcvcRhjJVaWMuquv3o38seZKYFwHLRhSbory1OhuZlJYAyQf?=
 =?us-ascii?Q?fGE5jMZ4KmGA3qQiCjoZEcepY/EutMF3jJSi2jPv323OlQXGI441xz91iC+R?=
 =?us-ascii?Q?h1qtTL0Lwgj4yh3zKTqrfIA07C7N76f2/nouiRUzf2MVc1Sxj0sdfee2eQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:29:57.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9fc1cd-e387-4741-b04c-08dd7c756f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580

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


