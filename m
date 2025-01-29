Return-Path: <netdev+bounces-161432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C3A215B5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 01:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9971888976
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516C17BB21;
	Wed, 29 Jan 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WfjVGI6y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F6175D39
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111442; cv=fail; b=OMA8zet9VMF7/HQklz/1EjF2MJP6B5FhO8kgcGIJ3pVtGqUg5IMyaQf8UYxGKC8qYn0Y7FJ004FAm0y7T26c+/JXdCP9QWVygkgTNfnNkB3qy5F/s8/Pc0EjAryXlPsSH99bE79yRc6Ik1M0JTcGf8ybyTVYOZmTOlK+aRPhbSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111442; c=relaxed/simple;
	bh=0nrY8Vd7txUNhEfoul9WliAqWsUvAuzfBlyB97kT0aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJrPey+D4tvJ7A/biTq4eHRFMbqKEmvrADfg9heoG+A6aoe5nBYkV+COIxx01LuYZlKnMJIweahHquMNQ/3QmqgrdiUvdNXcP/9AxXeNR6ENdrYnZZZPrVlYbhx+H3CFmLvei0KrmazDBjp+Uai++LZ/RJuhKdUWAysi9OfAM5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WfjVGI6y; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sV6/TX+nzv62qonGUdhMQGKvp7r1M5LAS9zn4FRt1yNXGsjB+eIoxjhaEHYkhZ8BzYt36KyYtbAdIVPMMVJOIuxzzaIYoMgqkWiVFA05D3tjDVOOIhrL/a0CXd26gW/0dSR45hhRWMtyfvHRACCRjB5ufISRH1nshVbvubVAco1NjhXgtwwK+0cvtDGC2WyBzJsEslGNmkRYywpmMrcvr5PM9IEFHCBd9PzKpAKflDqcqQWnhj96kAapwuWhYOM25BoKAH2qgwdrt5Vxq+TdVsyfSfPrbKhfPF1rrdHcZuoFegVcOTxzkRb9F+Otjtza5+a7wuY8cZYgheRaixx3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifneiq/8iwOEEZm2pX1GcgnIWyoBCq31ybVyvCirYuA=;
 b=Gcb/E5ULdyjEfU9m8cT9lSmgUeL9ckk0a/WGURhIWmMPEoFAdr8dicc4kkDMYEfSulffGliCRDZTIPOhH+cep5VR1PuFHQiVUVK0DKn17lJZCnJojhhptruaym/HRYpGBCm/OKJlBj/XUZeZ9EREyRsk98R5KJaGahqTD9+ZH9K2VnVrp02qRZnJVWaCpfIitzT+KuujkgSE4SPd3Q11zS/102yWuMHO0zISxylvdErZi0BxUUwt5iVCaavw9mSQBdaKnl5HSFkXInJd0+cT99Z6MoGt+Gz5/wESwV47yj/3Db/1dPlBrDzX3cY9qJI4K2HKuFFCoCiA8CmqiXp9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifneiq/8iwOEEZm2pX1GcgnIWyoBCq31ybVyvCirYuA=;
 b=WfjVGI6yjCftblWrR3IeTTVeEnGLiNGTwRxc4aMqddrVWOYnVYBHv0T3SCYPWCB3kOmFBjtbaj0jIWQBqrAd2WhEoifiVeMmy6jYXANJ1ykL3HNtTPeGvRP7l+n3u//nlF+fEYE2kyyd5TsXwsbQlY+O8RGAbCnE1xPvgrgJJfE=
Received: from MW4PR04CA0290.namprd04.prod.outlook.com (2603:10b6:303:89::25)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 00:43:56 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::64) by MW4PR04CA0290.outlook.office365.com
 (2603:10b6:303:89::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Wed,
 29 Jan 2025 00:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 00:43:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 18:43:54 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 1/2] pds_core: Prevent possible adminq overflow/stuck condition
Date: Tue, 28 Jan 2025 16:43:36 -0800
Message-ID: <20250129004337.36898-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 560e0d19-9215-4e5d-fbb1-08dd3ffe0354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQYTC/Gs6Y8p3dvoDsyMKGKvP58zOigymyMYhtdkybs5IrNPCdRbXkqdL4ai?=
 =?us-ascii?Q?mpSY2VRaEoTLME0/C0ViKwCqKrM7tepVuTeJW56seOdV2v5LbmHJOmyIEQhG?=
 =?us-ascii?Q?DedJzkzDj6jTaPhbALPlW9MZSr7x5MbVprdUCCw3ASN8R2TEuGT4CyBd76BV?=
 =?us-ascii?Q?5DJj/umkXpksMdQFA45gTHKMud3vKs3PdgmYfKCVcMCapoSf8sr7judWPlmT?=
 =?us-ascii?Q?HsUczqIOJ9bd8br5DadcezAImGaGmLjJcB9gG2pgqH8Yg9s0pF6dEwuKmNRY?=
 =?us-ascii?Q?0ijTNQD7/m7FYm1Sb/O+/bmBrH0zNm3bR5uJ5sRvZn3cKXXXvODTkxlaLPNB?=
 =?us-ascii?Q?W0mCPKQ8SCh0sZ8kR6cAhRLYp9rD4nSuXV70nXxPWAmWBuCBx82SXu/v3tF9?=
 =?us-ascii?Q?vUb0s+JG7SwTbiADXuLhFlYeCW3vyggbEEMDHNNHQWOi1PJjl2tB3sk4qYqg?=
 =?us-ascii?Q?CAcpykhMfvfkg63lx+1s7nbG8iH0bK4kiGNP264RpfSoHPcMYbe2P2b/THre?=
 =?us-ascii?Q?cDZKgayLfvLTA6gzq9fzSznPKCMmFCJMCW2RKsto45UwpaAkIShy9S4NBsal?=
 =?us-ascii?Q?MCxn1htsVH42EW8ibGi2o05Vti7Q7Kvi28GTPrvlBiqkYEcz2mfLjnlbhKNr?=
 =?us-ascii?Q?b2olgI0UiyKr8M0S78xQZaxGCsxNB7HXZRxzWG9rJpybQf/Aqnqr8gubWu48?=
 =?us-ascii?Q?LpdfUhIyIV1i+mcmh5gb2B4EVmao5aolJu1s/sOoHuFZqTyqj9GYbcKY+fDW?=
 =?us-ascii?Q?aOkNfY8ZUwTJYrjlhCcfYGYrmkNZTUlJTZxcfBvjFSXvWHoO7mcPIVOXzZgM?=
 =?us-ascii?Q?si1qR2hXDC69w3HPtGhGWkm2W9qDJG/YNr4iCSRHtwn62KlZNeb8jk5gZAQ+?=
 =?us-ascii?Q?I0iHDGUQMAiQF/YIgYkAMPofHmnYmd00cI2xfxh2U56K38TXanI8F2JtgxuE?=
 =?us-ascii?Q?n9qwOxq0lh6X1LggtNwV0OnEE1nrPHZKsMqmT1eyWBcp4aRnRKcYlDxqM/m1?=
 =?us-ascii?Q?7R+ZgiCKqj5cnV4u7zxMcPkBoJVahhXrVpfHXOu+Gwi11uhn2m+yda9J8ZGL?=
 =?us-ascii?Q?3dw6DdKBsFQqbU6Wlji3LHeqdntN4vzi3FyXDtAtDf9npaA0ZumuQadFGeLV?=
 =?us-ascii?Q?sQ4UmIyE5OvMkRfgH5OlLCdPI5mqZtLJXBSmmt8yQMyOtsVN3Id9pDT3QmqD?=
 =?us-ascii?Q?2fwhxCvSP2KOJnf8PZg2PzvfUwVYzBhZW8jmEpKVBkRhzIl4DE9kJMEkEYVt?=
 =?us-ascii?Q?o/7ZHzOPmj6zJqyUr7hIySn2mdc113H9NAaJsodjXwtN0r6DwMRLbfSPLVXe?=
 =?us-ascii?Q?hx+9sC+jaJTS12WS3BFU6FFEkIdFyT5OfQ0WLukeGEqgE3o6GzxbXBw4sB54?=
 =?us-ascii?Q?uLMQvkC0EkYFyBglp+lG+kjBWCevCq2cKx8vukF2e+FePY3WKsFyuE7n1lcp?=
 =?us-ascii?Q?2+Dkkd2tIyCOIYp1Em13uhQzGNYdIu4FnuqkwdXSlAmLPDcrXnSsqhOakdOt?=
 =?us-ascii?Q?ujM/aDL+tBLKGXM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 00:43:56.4903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560e0d19-9215-4e5d-fbb1-08dd3ffe0354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060

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

This is just the first step to fix this issue because there are already
devices being used. Moving forward a new capability bit will be defined
and set if the FW can gracefully handle the host driver/device having a
deeper adminq.

Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 536635e57727..4830292d5f87 100644
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
index 14522d6d5f86..543097983bf6 100644
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


