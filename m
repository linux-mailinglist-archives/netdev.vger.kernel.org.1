Return-Path: <netdev+bounces-240144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA668C70CC2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8522C4E1578
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A05371DE0;
	Wed, 19 Nov 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dxzVTrrM"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14A315D55;
	Wed, 19 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580205; cv=fail; b=LMpTMg9SlAaSnD58VrIw/RgstWu/enfH0O1jEz6v/+N/H/X1f3Jlt8WaDja18UTL+YmOqYXH1XtMxY+ueRs6a086kjGKySKy6+wNLdcRFnzNl6uIf/LuGTy0RF3YE0eAFj97qQVeuxZV2IzEBian1rsLwlF8JMmpTUfdOxxAnnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580205; c=relaxed/simple;
	bh=CJ5/5GP2NwNnzYhONl5XkQFXsoiOtkmbggvkf5pR4Io=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3N+67R+w+D4l3Kv03pAEO/b0cgnNafWDujBYz5vMqNBVl5THI/L1Z+BapqGixpNclX9jNOpuV9j11Kivvz4CGZbh9qaY1oXfaY+HFlqLrQTCLAikWfpii0LD197WIpcEAS82c3osFuIDhqxe1MLWKfP4H1oNp6vMEvTQmIUYi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dxzVTrrM; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Qe1kcFKsME1lve0xJMjlLNKI4tWd+DiVFY1K/RdPAIxgmnitqIdKrk7bE6ZfmEt5QCNeCtLYJsCvVH+KS5o+J2Cpqhc+BqP6ipTeh4skYIwfR4pohaiywsM+wYc1tl55qfPRSjRzeFajkpN+k+iowe8pEsD11Hz2HmuyvkndHA+K9eu8+agB9X4sEaFKFPob41wi8zcy5RuEoWbROhlv+qW9LgnYNfRxqfLm+STyA8Rt4DRUiNQvE/aaZD2GRzsps4P8OH6voTSVxHeJLEGN0vEwNROpyCKYJgfSf/GcM6V9mhR0TIi8mV1eDSovL34rASJbGaHhzKSCOebXDHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEBUN2modMl7hD78GcqTgFJr6l0F0qCLIqG3V7kcgmU=;
 b=r599Q7aqus9INQzZ7zEMPsPN1pztAzqeHSpqj0cz1O7fucHqBD4IrTNCHS6CSCVtzOhznr2UBFEQ1FBW3Y18uMp7XYjR12EssiI4s0YrzrG2yvhYPIukLctJmcb+7Vb0HTgelQyHJ0SGMxQ6mFakiBQa6UIWXRRyMb7vaZjgSeqWSrM+U0pxp95+ZuvIwPwib5BnwunvODGxWTPvyAr1LobmV0g+8TM9HNcZsbPUN/Gu4vmwISEPK0/R619tOwHPqqtF5aUkJ8J4h8TVmLZRSQKPhEdHTzMSStb3gf4/xB4JmJi3LaevGAIV0bUgLMJq4vl1pRi784iYYcfEpVHotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEBUN2modMl7hD78GcqTgFJr6l0F0qCLIqG3V7kcgmU=;
 b=dxzVTrrMrTzWhX1FuKeZezpvjH3ZMExChXGbe4ubUuz+qIpb8/FSpvsA78aEGsr3xjPoHvLyR3G+D0L7Fe3ksfz4QCuMah+DaNSBJFpeK9jUL9hAedPodckhVbiKqroVogtcxCGGssh+X1kZNbYHPNTb3ZUibOdW2CGrv9YmfQI=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:11 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6b) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:09 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:23:09 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:23:07 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v21 15/23] sfc: get endpoint decoder
Date: Wed, 19 Nov 2025 19:22:28 +0000
Message-ID: <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: b238cee7-efa0-4876-fa45-08de27a113ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvEjkpGNQjuk/JpXEiB7Yb8P2/cS3hj1FpD0BDRoBM3GOFkkKd52SZ1gWeQ4?=
 =?us-ascii?Q?cEF0FKr5+UBwLJ8o09qc1SdoN5ypAFHXAuG31pwTbSL/pyM8ij7c325yh2VX?=
 =?us-ascii?Q?g3Uf8kDc205it2qKEuH0PIVwqHwLNPOP7xyWe2A2XRznjS3Kys1GiT69S8K3?=
 =?us-ascii?Q?vtI8LH4r2ZX5F23rRydg81hvX4EX+uoe+51USyIa6kfBYGrleLxgaMoDla13?=
 =?us-ascii?Q?wekjBFfJstU/ahQ34DM9f0uuq2XCj+U2a5yGoIbJg98Uo6p0hZHjZRQwQJDJ?=
 =?us-ascii?Q?pYrCvw9rYn4sAcuLsmyhfzEyPQBjQO4BKeqQtO804QHZTsGp2cehh3S7+aCx?=
 =?us-ascii?Q?M3bmRLNQPtqorO6DfxVcOp9BCPidzejfdGy+64BGjE4j7a6NuPEeGqajnJnS?=
 =?us-ascii?Q?95Ck9xFkEfzmNeI4IR992Aw9WbQXokSDSmWOlDBBjA1pTF4tiRJJbeSe11ef?=
 =?us-ascii?Q?sWXkYyJ6zxVm9xuJQWGiJB3nMLLPpP5ZWFeObXzRJhx3Ha0YimZKXxbsufRC?=
 =?us-ascii?Q?KdefWjo+Snx0fb5hxR33p2bTfTRDfc/WVtRWW5OF0QXjdFWqQaBOwq367zAt?=
 =?us-ascii?Q?tCyYzhrOOVl9ysVm4azr7t2JPyi3Tk7pFGP9iedbKbxnOfQhxWxOtn7AVYgf?=
 =?us-ascii?Q?MucrSdyGF4YLfvsRsuhDTYzSzxH9Da1/yGeMZ7NkRu3UYcVCwzVHS3rz3hvE?=
 =?us-ascii?Q?ARDTZDsAmt85MiGyIoEm5SH6v29Q/wXp0L0yV6Rb4mtK7eCEH3nrBaZsh4/M?=
 =?us-ascii?Q?MuxS5MPOFWIp84LlR+SIJHKv5qHOIomjROfJ00oXk7O3/HBKMyIAB3doaCF5?=
 =?us-ascii?Q?By0KMS/qlfXLzPTj+3H9YRbXs34HbOBe0dKZlXaJsXTRHpbyaab9LCAtVoUB?=
 =?us-ascii?Q?zRq+gNHxsOJuuq9+LVI/pZiVox9GEsaoSwrad/maARNRCqURNHWSl6ReTEaL?=
 =?us-ascii?Q?K12E8HnNw8fkp28VELVgW/w1LqhbJv4pLxkOC8Qfw/p52wIkReeJbwhprE/S?=
 =?us-ascii?Q?98rJ33yCuURmPQMhgoe11AEZf64AZXfcFuWxcz9xlE8XqYw6gGcr2MeQ/MPF?=
 =?us-ascii?Q?zV7nFVLQG/wtoqjGaE+GxlaX1Psvy57xuVKFhocSQfCyMZguvYMRMqoOlzNK?=
 =?us-ascii?Q?V4DXerYBTA+rxUOw4hkSKFd8axqMrL+zVrQ3dDUCEmENXnGEiLj9bWguhHgB?=
 =?us-ascii?Q?acpfkwSCG0uIKSqbKSlVBKF7jWmDUXXW3M1NoX6PXDFOOFXsEpQrBtXbTDKk?=
 =?us-ascii?Q?Q2Z9pSa7OS6qhLOObXCfdFbNMYnQ7R732h0D5r+VwmyRzoY4BbTMiNSMCA63?=
 =?us-ascii?Q?BH4/MSyFOUbLmce5t8jSokG4Kw5rpaixLz7UjvcJLTYAwrXc1PAre8qVkeBl?=
 =?us-ascii?Q?mQUU7RMW20DmnyzM4LdV70/IiYROIzSpoAPlHeIpUY/UAfEFk9TMMr15YnN3?=
 =?us-ascii?Q?ic95L74ijBiFVkrYaV360rSP5rLSENn02drAiLHDc7rgGhUXw1xhYKa+W0DM?=
 =?us-ascii?Q?fqrjxbRYvuaBL4YQ2aZXGUr8DhtGd4QSBu+EJB3ipt+NZmgXgZnslyfcViux?=
 =?us-ascii?Q?aOi+rsrwbM2+uPY5hHM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:10.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b238cee7-efa0-4876-fa45-08de27a113ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d7c34c978434..1a50bb2c0913 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENOSPC;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		cxl_put_root_decoder(cxl->cxlrd);
+		return PTR_ERR(cxl->cxled);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


