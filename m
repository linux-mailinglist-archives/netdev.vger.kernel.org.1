Return-Path: <netdev+bounces-148178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3459E099B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3924B2827F0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF41DBB13;
	Mon,  2 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TAXtifHu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732EA1DED46;
	Mon,  2 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159593; cv=fail; b=nTX6r2U+88gGsRIs1xpaT/96QliRxbCJmtAtDzO7IsPgFElb2yowfBTiE7snPOLXaO+9x0RGGMOkWjttMchPcAJm0qhkq6+lsCBZfFAMHSI+S8QrCCLcHE/CTpLgtLV9yC2NNwgAwP1zsguuSKLv/ceQQ15W2lefzouLeFTECm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159593; c=relaxed/simple;
	bh=6pwCCTbUfBWxRWkXtUHAqNorvm37jJIC+qKttoH0s/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOIm4pazkwYWrOEVrXiXlFAA6Zk6TUjZiGkVBg+41u96BrrGbw5q2J8DEKLR4HLoaBmvMOfIcsrQGQwyCnIJZmf9uddkKGulI87W3foMK+GwjGxikYTdN8td3BNTke4GWNwYyqOJNHhKcp+YrG3WG0/M7OdkL+pu/FPRQHqwjyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TAXtifHu; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl4SeT0NAU+yaAci6LduCKcDjsHq7HVjeLqQGumBwKyGD/+Z4J+Ks7o0CqBXs0ilH3BmUJnt5oAhSCaVBXRFqBbT4f3U5GfgKyatyjqjc7JfNEaVDL6AlPotqjeeQ//bot+SJYGEQjtmz15621B/naUbF5vFgB4KdE4oxLg68s13LOqP8YLnJptGjKXQn3tw48LjALDvrwzJTTV9PhebK670ZWHQ1yT7V7MoLq5/ptRcPmCTlMahGWHIU4QZ1Tcmti/i84PO8hl5UV+AWJlsZxT4rvMxUWfevM8lE/au7xcUMDh9VuurHsRYpLU51PP/qUPBXz/QWtwlLjkF4ejGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe2JQaf5w6u6VPeb3P/Yzsj/mqF+Nxm2q/oU4yDUrCo=;
 b=Y+4id57kHaOJ4xzDIlJxqeComcCyRO3LkP+KkCn9TzdjWu84l2L8I5YK4dSn7gynh1QR8sd0nl+gIvDbAo6Wli77Lns0zh0PsUoDHFmjOFItV3tGS2Z5ElGUZin2KcuBFDqJ0mdfkddL1ewcNpMvd4VaXnDvoe7W5e0lxkB/NR38C/5jDCIBZL0zcc3Wi0Avyvt8DZkOp7a/gHAwfoCu5F0QSHR0K/VfDsMdazp+4azNn6Ie1j4U/pO2Q8u2czjk/eZrZ5hnWrCWxKUrYEX046uYG+c4ehCqBOfvJk6tmh3ClHmLMDtmou/A7P0uM4RhSEUrBVfUJED+2wzhRNo5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe2JQaf5w6u6VPeb3P/Yzsj/mqF+Nxm2q/oU4yDUrCo=;
 b=TAXtifHuygbqofMOvZoLViWZ2udQssm9krsWtd+zAupfh5nX+ERrMhR/bdrRrXcRTAtypsYrhLi+hlTO7/hk+maAxDHVT2N1qCMR0j/8TjOjRc6RY7pmtOJ9+gHI7IC2OXqgTHZFdhB9MzN3zGZeeCPKyzH8BSp6RZl5Nx85DV0=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:13:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::72) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 23/28] sfc: create cxl region
Date: Mon, 2 Dec 2024 17:12:17 +0000
Message-ID: <20241202171222.62595-24-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 4422bbbe-f07f-439f-ad61-08dd12f4974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MCBeEqrIm/WOUzzPyH+hi7pGl4dTeBFVarHx3rEQ0Zrcnzs7NMzvfz+lf5u?=
 =?us-ascii?Q?P+0uH8Hv263cSlgJtSQns/NsJWsEkztWKVA7IQqRHDzUaSfA4TCHjEEF/WFa?=
 =?us-ascii?Q?KycaWq/qErwljj33WUct2mJtcTf4DcizzKxsuSZAXa0WfnHfqvMjlyE15rKR?=
 =?us-ascii?Q?lIRUGsXnhDKlA2C6ketxkXKuNFplYlmWjqTMHJZ0hpMjtE6w9djCQBw8JPyi?=
 =?us-ascii?Q?SuUfkCtAGcICrtZfa1Weh1ve+GFx8XhjCKnLenxO0dlFuJIQ41umAZlZrIdW?=
 =?us-ascii?Q?Qy2qSqewf+xtIBr0uCEmvFgy0b2YeJpfUYHBKsHLONX9yiSMxqBE3WZusSGJ?=
 =?us-ascii?Q?V3jFnmYQkCKB24dDce51iIFCE1ONh6nS9hFfOhANcs9cO14IIlE9yafumN1s?=
 =?us-ascii?Q?QxUUgO0TebW353TdccmFfvDlZdIVNUJQSqLrUK7Z/Obj+RCn+2HBp/nrsjtc?=
 =?us-ascii?Q?j8OWyoc2ps/2+KpeYG4ECot0miReZ+rvSX3cwrTInz0KxHcpLL3RGLpK8P7X?=
 =?us-ascii?Q?ckibEL6kHx+WCsaU9yDDWloCO/WuSRyu/h/Dmh2oRqqmNSkjJJV6lgHfHuO4?=
 =?us-ascii?Q?xttpvPDzBK0WbwiPajObEwKQl0ep1e9PL0IGG2bfmNj08FSGsG/tqdgCLD4E?=
 =?us-ascii?Q?J/O+bayPLAaqoWmwTuxQq59abIKNLv/gcEbFYKYbbqcZvtTjSdpGqJd3vDYc?=
 =?us-ascii?Q?3+Pv/Pnso4fgAX0Rtq+qgzvQRkb126yTeiEKO1mQh6QMChBf9I/KL0vR43BI?=
 =?us-ascii?Q?oPlC4ZVAImmxW6f+jeO/LIfmAHVxaCf5z9qnhH2LbRI6VTJ7fRusG7FnElqW?=
 =?us-ascii?Q?aXpZGukMHTr2924437MUUMADw8+qhMYOqsn8XwRtkzi2lBHgIAMO8kz1dVud?=
 =?us-ascii?Q?jAyAoOGX3E+J/cl0SxPA3NyRqK2+IjjppnCuerG42QYW0EXwSFXdECw6vD7d?=
 =?us-ascii?Q?58UjOYYkHOfSMIwq0KhTcYV3rEi2WKNkzTXIRXAZNXvSfdBo/R4PBmVKNKAD?=
 =?us-ascii?Q?l9QoWkk5OIzE4YyMNX1rNNNQ3IWZkjJQc06twDYyCQ0QqFqu/dxR4baASw1x?=
 =?us-ascii?Q?Vj2aWAyTMmg1WuCDrNCrVB1y/smYnOS+ASGhulSSjX81snMC/0gaDtEgIjmw?=
 =?us-ascii?Q?MjBzFbF/SnzVw+oSR+Ws6qIM8lzTHKnXNEjd26cuI5AGwCKKv4qs3eJydi13?=
 =?us-ascii?Q?bTa5LO54Xqy+TOwCLZMBeKSH7vRrtkAgRUOsoeEP4peDM6o+sFeCQiVY+E2S?=
 =?us-ascii?Q?e4A0MOf4tsWBFP9/o0hzPBTRMfYctxklRfGLuqJsiwIDTfiW11DSLDrboGel?=
 =?us-ascii?Q?xpUlrm3vU097hoXAMNtpPhqMxOwe09RNWfaRc4qotU1PUrJVVTT/3zS4TSlU?=
 =?us-ascii?Q?Se8I+QrEXFrl/ZwMItHJbRi6fnzgsy6LNb1CJKberSx0FTAxfEnGddBR1gkG?=
 =?us-ascii?Q?JclxEHNLLU1jV3R8a6kwiFljpBH/XWUa/FzEwX+u8IAaAw/Lqx8Zhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:07.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4422bbbe-f07f-439f-ad61-08dd12f4974f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 6ca23874d0c7..3e44c31daf36 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	if (!cxl->efx_region) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 err3:
 	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
@@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
-- 
2.17.1


