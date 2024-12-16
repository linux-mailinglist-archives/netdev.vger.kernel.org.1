Return-Path: <netdev+bounces-152292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7029F358B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829A0188671F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DD20765E;
	Mon, 16 Dec 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CydHqZiK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CE14A095;
	Mon, 16 Dec 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365480; cv=fail; b=k74841knIj5CqMmp2z2QTbLA0V0K3u4luiK5g7P0gRWihOYcuVr92mzBoydRy6qf3tzflHzM/0K4Tv0+6uj9+YDuTAuq/vSYfPwtpi+BtgOFFmAem5orL9cjneSIoZOdXHd3OFp2odBjlWpOtSBDeZJae6FPfPUV4n0u5JSkcwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365480; c=relaxed/simple;
	bh=jHuUB8WDUAyo7GPakWuA65xYjl+XmNwR9jDgjkpzq2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N49bbyOZL8JwHTfs52pdSqF9ftH60x19ejzwBPIcmXWBMMaiIJ+mhoXQE2mGQmvUxapghDPUndQMd9p1kMO3t9luXavWTmxVixq54dyKPWxbJ2VQ48FnPObIE/0vOHkx1c2yCfkeKlXe9nvVOGwW6FOnE65QNRco60JTfPn7SMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CydHqZiK; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dng5oAJxBTh9eh/rC8+ry0xr4rHmqOq1mSbLzvIdmbXRxtJdaNDZx6KZmxpHla6t2mnzeLcfCBlPHkgCyeMatxrySVn99s/j14JqNYE/XHIq0f9wi4HglYI1w/+Lgee3J4YWtI0a7zrrnNWBlCsOpR25OnGMZk7ZKTqWdB/zap2rue6U+COXwkaQ10VG0gu1rhpNDl0zbyeNVJjsjLtNtuG7dR5fuf1yXUR4WHul17tBN6KK9XeVKyPMiWqW41mc7PorQkuIOE2EYB5M59X+ZxzJwsBzzvGjhns1evjUOPW4V7Np/7psnwWISlt+QFZBzuRIzL8Izhj4y7YkrUnY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx+TlvbeK9sqwkUeU9AMrer4vMHRHjjn3HKSVawbsq0=;
 b=MmdY1WXljUs4m14fFAk1hn9U/qbQNFYZh7c1ej7lfa8OzC2ujRo8fmDcdIN/mCi+hH5m4jswfN5ut/FZGW2AhF8qgVSwrSSF6DhY/FdwSQeMX2DonYWyrb5bqQWQWJbmZHf7bvITP/zjZp70xUfZjCcqY3BGk382S5MmzIfu3RIfxLQouV6n+DUJfgXbehaSiTUp1STk4wWxz4UEqgLqowN4bmvntIx/RnGskvazWmHmueC6GRBc6PB5p/9Yt43ivL2PLsLA25qjMsC89fP1lakB/y2XDRfwMsamL4wScJjdSbZobcf5ft3yCK4sjeHraocfzixN5FFv1UaLGynUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx+TlvbeK9sqwkUeU9AMrer4vMHRHjjn3HKSVawbsq0=;
 b=CydHqZiKXFz7bfvRvHWjdCbrwZkgiLz4VnrGCsyh3XccRebtalAxqp06jDR71baxyG7K7XtLyhdSh4jWQoK71ld6Tcf1M1hkO3DAjZZuPzMyp7isqMIHzh5Rwy/il6e/JnuEzK4OSVWjUTNqNeN1GHnFnEDxObe02sfvdgy3FCo=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:15 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::9) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:15 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:14 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 16/27] sfc: obtain root decoder with enough HPA free space
Date: Mon, 16 Dec 2024 16:10:31 +0000
Message-ID: <20241216161042.42108-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: d120ea23-4ace-4eeb-5c9b-08dd1dec44ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oTmjaXQzI9srjmPZbB0jONx76JoFb3NYehKQ2B+TsRgx95DGsztzAkQx+v6D?=
 =?us-ascii?Q?zX+Q6QcEi8hsU/M3lEHCHYuiv6yaTHqtgVvVcnp6Ol54SKH+BSzoKpM4TCVl?=
 =?us-ascii?Q?989k5PG0pCO+OfyQahoPo4vrWSgpOMQlctpgdT86hGsgvxSCOZ9dLyTVM6oA?=
 =?us-ascii?Q?kDZPn0EbJ/TmA0y/dxNH/bIODLTtU+b8srniAbCzxxumkdMU2BmZu2gaFIiF?=
 =?us-ascii?Q?sUcA3DmFnJylslf6cF3Hg7BLPfCr875cMCtr3tjMoNkRBwXYNK1zD53eGFtp?=
 =?us-ascii?Q?eO+F3Mh2YXMal/hvHJ2in3bjU1Er/PW0Fgi6HweNLmlJ7GAiJD8QmpnUoG27?=
 =?us-ascii?Q?dkXPZcNZiLdlCMWHyT60Q8qFAILjaHmadz/7STSwII5V4AInKDzzZZZhf/6w?=
 =?us-ascii?Q?47X8RWgTPfI06l2unoXN91Yntq5vQAVJNfBD1H8mUzZVwHXP3GBtVI1u4OJU?=
 =?us-ascii?Q?TFzjwGCWsDiOW02rpK4ROMQXzX2DWi9+CrZGa6Q1DwAtvFZL9j+CIlCwVa2B?=
 =?us-ascii?Q?P7Xi5a/NkDoUDbxMyxJgP3+zOE4cyAPKv1kJiX7pkgCT+gYRTMc/mMExFOyn?=
 =?us-ascii?Q?G38sN1vpzVPvU8A1AJwxcu6RDbezxcdGIiP8v/fOvTRG0f6hePCPj5oeaMu8?=
 =?us-ascii?Q?gk6xz1lzVUpYw3c/VWz4wUtVCkCGI1bblvWX4W6PQeZxOJn3yI4Yoxk2smd3?=
 =?us-ascii?Q?MXdCxoG+n17gvDrdyPQ4NyT3JHTW//I1VvGULfmm1ou6Ozthy6FHjKEORs2o?=
 =?us-ascii?Q?NmTMg0QRXZtU6Hgv283zr65jq3bh/9chcsrii6YLJNBJ2Wwt1k2tM9dGOizk?=
 =?us-ascii?Q?icnI8CblTgxREGV6oCdKZOMwRdvA6Wpo7ALEY+G4HGaTIjQs0D0msbUBvThX?=
 =?us-ascii?Q?Ay6wSv1IY6g+zK/c1v7o7RClghc/m5+tjgBdlKcAPtTFUU/y+vquTS7Wi/r/?=
 =?us-ascii?Q?PKB5iUxTddqSx9Ex1iXv+qfPyB1EnjX7+CGdkkUDya6K5+mEJtGGVgXxjme6?=
 =?us-ascii?Q?vZgtNrtVroQN/lZukyzZa77bRo4DkoI72oPFyUYV27bG2lwmx+qRxBg9vMY2?=
 =?us-ascii?Q?EjDufhJLg7y+CtEAYqvJ48N4bsEB5WYcrWSJaMAMxwCKs29xU1UVIuzIcVse?=
 =?us-ascii?Q?SascyX7PdGXy7MpDqfv+rzaFKnWBvNzdcdtKb/mX+5NM9dc0ZUcD20hDA14P?=
 =?us-ascii?Q?1ZQXXnnZhfOa67hHMVggOz7opRhyib76I24QSdVUcOJ6fc0tKon5TtNkcjG6?=
 =?us-ascii?Q?joIwT7j6NlDGO6yY5IE9iP5GfsNupZGdsoenmIZrqe3BE1XXv9WI7FgBVRhF?=
 =?us-ascii?Q?GqjaLAzyZGRKOXoqDbZwI3aqNxX4mnkjipgqR+hAJO2G7Fb0K/G6R68UH0iz?=
 =?us-ascii?Q?VTK+26Vx9sJrA0gyaerpKX0ROlzYtwELLVJBLYSnkfUfdTWDKPquYvhtIraD?=
 =?us-ascii?Q?OsLL2deG5KstVH5c+Sf5qhkfGVf5kgF1+fEv9pLSQIXb9uQllzA2gLOW3eeF?=
 =?us-ascii?Q?abms09r0mCN71y/m1cLuV2OQaKiB7nZjhph/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:15.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d120ea23-4ace-4eeb-5c9b-08dd1dec44ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 70b47b7f4d5a..253c82c61f43 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -23,6 +23,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct efx_nic *efx = &probe_data->efx;
 	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
 	DECLARE_BITMAP(found, CXL_MAX_CAPS);
+	resource_size_t max_size;
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
@@ -103,6 +104,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_memdev;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


