Return-Path: <netdev+bounces-200681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79144AE6848
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1E83AE175
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5ED2D23AD;
	Tue, 24 Jun 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qc6obXpg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE582D9ED1;
	Tue, 24 Jun 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774489; cv=fail; b=ADT3JFlA32J0rxdGSz92lNbm2PIfth+4oGBPuOYEeLeTKE7PCFyGr66OeVaE9gZZUlySqMa1axQIRVrRT2fwtey+6glpBP0o10U9lAIeXUOJ6BbWR5q3b0MhavP3cFJFTJ9gs1ew9mQinxFMBo3wZAQtlrt4O3y8ptgZrGeIaEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774489; c=relaxed/simple;
	bh=lgrzFsRPs9zmeTgalQ1KTGzNuVM0Nfabbz+m54FyuwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyhxg0HD0tM5pTqU7/4BVwipToseqiNOXgDjOpGeb6vGNjVnVGtHjv2zNKHXoKrAljlSPDF+6UM1O1mxUM1vXrssMcZTleNjDQUoKLfIugY16ukn1DFZi5y1SDpYpVUux9gZzn8cGsXbEDxxVW5onVN3r0J55C6Yx2agdZc1EHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qc6obXpg; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhCpTL8I4CJk+qZXnOfBHUHPKTeKR40sLlmH2vbsRoFj2eePR4o37G/cFnBv1xqyjEJf6GmbusougGO4uSZAfRLz1eBAjzfDissRP8KfPtHy4/XRN4uBVtPLGUU8a2dKOqrvU3sEHU3LX+aMKeNoWtFA9EATOIIeTX1PBcsWIIXHEh3yuIYc0l9/tSau1gn+H1MEtl25PCmE4KcK3TcAdZ2JqGRIBoa0/n0jpIqJ3OgKvyUGk55O5ncxdgOsDvP/H6RJLMS0X9yJcpZpG+baM1TYbHXhVxrICeRKGa5b0RUSEkmMVbA5AeH6pRFczXZuR7J42lGej4RdQ4KvD/L//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMvAkCfyaFvPsGoc3QXzX8dbWUERLWlpebqXZ0JZYFY=;
 b=p8ftMJ51d0MQJ8xCf9bINVNM4pvFeRYMzRpQAckbBxBjUZEEFTxkexwV8XzfUlBIoWHscUmNG5XvCLhOU45L53zFYVuR5N+CqKtLT1mM6ZKR4Co2dl+QJDnu8Y3D4Z4UK8m3foI6+MygthzPflFAmZ3UPd9NMJVFk31iwLBQOvvAkmvV3GwWGPmsMMycJQiJMZtNqgDgJucLBXTfs/5X5a0vVW5C4Q3/KyZv/FvZbFdtPv9/bX5XgqIHFegENlsya0fHKYEIZJ44MyzHI1Mmw2ybV8L8EtKJXED8wuSChpi8hr3YqL1es/4mgHrWx7i/a6LRpK8tTk2YzQ7k/zXkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMvAkCfyaFvPsGoc3QXzX8dbWUERLWlpebqXZ0JZYFY=;
 b=Qc6obXpgNJjjTDuVdVu+OhDRAprfXSfnoWF/NBR4+UARngYAxehzND9+fcxuOdHJeyFg9mhvWiYfoGWiAQ+lHtIFPb8sIU/1EvPEVZ0slyaaiUfM2dMWD8OhvYYQt1IQrt/7U1U0Wi7GSS92vXygoubFCGWnY85/uOYomb6KuGY=
Received: from BYAPR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:74::46)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 14:14:45 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::40) by BYAPR05CA0069.outlook.office365.com
 (2603:10b6:a03:74::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Tue,
 24 Jun 2025 14:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:44 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:43 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 20/22] sfc: create cxl region
Date: Tue, 24 Jun 2025 15:13:53 +0100
Message-ID: <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fd2c9a-586d-4bf3-ebb8-08ddb329786b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLgoQNx02XBd558Y4X5rVZHTIp12WGSleuP+Cqfm6uRYnBxY40/TgoiqSNZt?=
 =?us-ascii?Q?SZvVtdqgXWXkkP/3ikcBdX5ITRLIbIt1EHiGZDMC+rMU+jjVO2YO7pbM3f7U?=
 =?us-ascii?Q?O5ue9JzPaMm2f13PJiGnq0dGwsmhJlxRFO/pXBV0VsBJ95GRcn+AxoOjdSCI?=
 =?us-ascii?Q?IRz8AirISITcAjmWnl8iVyIpHIhTYjyknd/jUvnZ1n9NwyENUHVOwijLmPNt?=
 =?us-ascii?Q?YXXLGBddFi212Ski30wRcZbxoZI/N+MARE7mS6AWB3BNvLzQM/S6u9QCwJJV?=
 =?us-ascii?Q?BtS4MdF/gynypPNQ3lNL7WTCzSxa7cGFu+6NbizaRAkPLUFlffhOFcJeyJtw?=
 =?us-ascii?Q?2fn65pqp4f9yiJ8FWJWbr4YHHv3Xpu5xe/w30IiILBXgmw/N5kiYEoWs7My/?=
 =?us-ascii?Q?Cow2LnhYF/8e5e6J7DJK1Spd72Fy7mbUDSalvq2k8P1MlNSyK7Lja2vBVs+g?=
 =?us-ascii?Q?ARg+olLXzwtd0lYohSAdVqYP47J2RMeA64J77SMv3Pa0zVHjXDlc2eBWWDyA?=
 =?us-ascii?Q?LtO7Uq/BxdHa1d701uL+uUoX86bPYgDUFasO9jLCC/Np5ZcFyAXHfgvXdYqp?=
 =?us-ascii?Q?gyQTG/ZB2OfSAqkMV4Xrxhs4F5nLYr6eQWTmWY07543S5TGiY9XHEqd6S0Dg?=
 =?us-ascii?Q?Fzxo0KrZ2vX3pbvHy6crXjGhkndsHHmEw/elb+YDXy0b49BK+GSwd3J5esjT?=
 =?us-ascii?Q?RqIqtFxcXzOluu2BZ8vamPT4k0YE3YxoKBvp5+SY5vED51kQ4DHdi1o/5rXc?=
 =?us-ascii?Q?hRWx4TtdqF3sXgLcn+SHfSQG1WU1/fg+u91V3aRNt5k+kD1v8P0AfQ2PopzI?=
 =?us-ascii?Q?3RaDucTSRazjQyFPhB/UihAdJbRhNi6UVrXYticjp8roOm3sbUqEhFdhEA/V?=
 =?us-ascii?Q?stTV2PMDWudVMCMFopnVTuGR3VMwgggKPZkp66VwFHqC+SkUH+yqnv6++dEj?=
 =?us-ascii?Q?Il8qRj+vYZisz/BB60FpGM7FtlQUYwi7nA7U5kQcI+ixmXfFRr1VfvmMU1QP?=
 =?us-ascii?Q?KLxxzyY2V6WXeAZlSbKHAEPM/R/S6J8wWdaQfNRup9dMEoD2PImGWu4JcbbB?=
 =?us-ascii?Q?ItfAr3SqtlVOyUNU9M+7t/Q17mqOBxDhywYN0EazS5YeagJxr0pp7WWYZgRA?=
 =?us-ascii?Q?sI5iOTyqSv8v/P5ulkQxFrcAYLJ7kRdtEnfPrxjfC850I4jGzl7d58mOssR4?=
 =?us-ascii?Q?EVIWIjcMIKE7z9IoteiCkcE5MueQv4IcRiVqyWtIIbEuHnuI/lty76OPridm?=
 =?us-ascii?Q?TNmDFpJgNN76Vb8Fc+09D4SaewzWp5vTP3p2OMqZIsJ7PuUnN8pH94BIw2U4?=
 =?us-ascii?Q?2VmT8qU9r7JDEwQ93jEH7e5pH/if0BX1K7ECs/oF3s7X5zg9ey44ddV1N4QM?=
 =?us-ascii?Q?R7J3xq4DYTq+f4tHQ8jKCbSDxq2/nQyVFgewsz/s6UyIvu7Eklv1ap312rRJ?=
 =?us-ascii?Q?s6MDAbfS6VGBOfvoTrIjD2P7J0nZfWOB20sk/4HH2mSkAlMS4ZJNvwlBajjb?=
 =?us-ascii?Q?zHhbAiEISwfy3vjoGyZgej7/nZVGZJolPyvY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:45.0494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fd2c9a-586d-4bf3-ebb8-08ddb329786b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Add a callback for unwinding sfc cxl initialization when the endpoint port
is destroyed by potential cxl_acpi or cxl_mem modules removal.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index ffbf0e706330..7365effe974e 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,16 @@
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
+static void efx_release_cxl_region(void *priv_cxl)
+{
+	struct efx_probe_data *probe_data = priv_cxl;
+	struct efx_cxl *cxl = probe_data->cxl;
+
+	iounmap(cxl->ctpio_cxl);
+	cxl_put_root_decoder(cxl->cxlrd);
+	probe_data->cxl_pio_initialised = false;
+}
+
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
@@ -116,10 +126,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto put_root_decoder;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1,
+					    efx_release_cxl_region,
+					    &probe_data);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	goto endpoint_release;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 put_root_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 endpoint_release:
@@ -129,7 +150,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl) {
+	if (probe_data->cxl_pio_initialised) {
+		cxl_decoder_kill_region(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


