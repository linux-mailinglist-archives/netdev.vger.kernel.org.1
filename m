Return-Path: <netdev+bounces-145944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEB79D1598
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34857B248AF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006C1C1F1C;
	Mon, 18 Nov 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kMUaXP1R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04B1C1F14;
	Mon, 18 Nov 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948302; cv=fail; b=LmKhzXjzos+0fiG+C7qtW0KHhfuVAq4Qbfm1i1XDWeQ98xVwSIM2y/Omy6tAGgIoXq4KjNQeXXurCYp8UPIfynz7Xrt4IL2YaUO1rYd3he9rsfn9YqmTaEmP6Y8V90ZmGAMcMzHtrjBk+mYSl2tBfM9XlEIKB0k8A6SjoRtkFHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948302; c=relaxed/simple;
	bh=DBQiN0Ozt1FIdZD8D5UNI/q2bK8lmr6PEgu/2dYvYFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLw9z9GcCPP5boGlsj3FsGKO9/ZKOrYpSQ/ogUrZf7fi4T+QANtNlYurklvZroRIUsLKWD+xao2nWxirNOAtecD3SLyZse5UXF9nbB5Nu2sh64ug2/nqP94H1mtCAbpcRMqTNsVKhrEAGNqJSTlYfGlhHr/KfdiH+SR4MngE2Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kMUaXP1R; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1CTcCOdFFonveE8MZz0Dv3Qvkgfm1YgGtxy6wXIMrozBgcct6Hyy5DMy3lAFyMThBEFi7AJYuk6aKhbQBNMPP4Mkq1D3LVaz+HEMvRLaEe8OZIlHCSdm6mkUV3BHT6NfS746EEO6+GYKDclCfKtIBcRt9CAQToAE21s+icJNFUjmB1NhQ7IjD0bO3prKLbuTS3qEaFnsMIQD2C5rCyFSpAmNVyo1BXqwbpV40YVZRBzPZPBRJ+eQKExaLfNYx/9Pwm+c7fIhKegS7U4f2nLzQalkFqArfeIURq8oT7vS+B0wNgBvkFxqFaeNenagwIfP3r2XI8TUYO6yZ/fqglJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFT1kkg/Lz4XNDHEgaisrIgXSMiYCB7llULK2VDBTzI=;
 b=JmbzACeYEHWcNlw187FEThGQexRkLwYP9bu9OhSTtxv0nG2RV69xrSKswepmQHGHKU3wuYDuxw68HdYYwX87+aKLz+7x60GtJku2a/k7YvTkO/+1AGhMXdKRADV+NUflarLKdVEh0Vp1ccvhpmD6bPjHXcVXFk2Ukiq8ob1f7RvDEzOO+B4GCAdpdAQZiNKkJiQueEtMWXzlCDG37mYv4/pTg1pZm2iBbPhwIObCThAyWWlwiTOCzLIgt/nE7mOiWWMxfObC+mgx21hwcApposvgp2RrqtrB8Irfx+wib0UP/AWyHRH1RI/kLcDfUuIaU9zLEjYKZC3kL3tiyUOj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFT1kkg/Lz4XNDHEgaisrIgXSMiYCB7llULK2VDBTzI=;
 b=kMUaXP1R0Jn3uLvtjCShCGvcPZT1fF3aohgJrebq42QI13UNFPWfdPnoafHlonPfAzZDklsjgOPxDReoRIRVwWDnN35RN8tQbyKVNqF0UMEN2xSvrqXLT2dstyzYgTXaLctLB297aIqO/nZPosATqdNsoUhC1MQ3uamOAx+xVHw=
Received: from CH0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:610:cc::27)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:58 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::66) by CH0PR03CA0082.outlook.office365.com
 (2603:10b6:610:cc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:56 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:55 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 09/27] sfc: request cxl ram resource
Date: Mon, 18 Nov 2024 16:44:16 +0000
Message-ID: <20241118164434.7551-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3d2328-dc36-48d4-cd20-08dd07f0567f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TisO6aWFlAlRsgiA0VBWDtvPOUnf7dufST+/pw2juxBSIUsfCB8Bd/T/qOKQ?=
 =?us-ascii?Q?cK+BYf6nkid5kO6kwsCae56UJCKl/B82rTkyEL7vAJ2mtFVA49kUimwY3n3s?=
 =?us-ascii?Q?SHAZoq1NvB2kTubYtwTtJbwQvuY9oTj6M89Pw+SNMSztVXilBiT6PJG2+PBy?=
 =?us-ascii?Q?yHHIiv0fES852WIdFKH4R5TdHe9KAKNfrlKgHkD4qj5bjfLKGCvDmmrd55e/?=
 =?us-ascii?Q?Vxk83jHxFYpHjtwG/jPDgjawuz3tgjBhhqQdzGO2zTxs83GOegGdAPycexKH?=
 =?us-ascii?Q?nTy3FSluIx75Hz88SoDrAuTsaudGitJ6Q82UfF1Y4syR8zKDbNX/PlL1YILq?=
 =?us-ascii?Q?faZ93x128DFD/nS5FKuD+ILSA+sTO34dec1eD1zekgbncDczqcxPt/eOv9Et?=
 =?us-ascii?Q?Yj7g8a8OfSzdvdkyZ9NoTjdutPRzRbzuXIEhycmzybNNlkVJcZY6e2WheGNk?=
 =?us-ascii?Q?IxKUm1Q8kNW8ggvQC4ROkGNzOJS0QwhXx7dsRzhDEHGQ8FX7VEZnLCaeEbBM?=
 =?us-ascii?Q?o5k68E6aXioyDYaoCVenTdwEHHmv3zNL5GhIBOtDAAEiXC3Cd3GeNTKnKfE8?=
 =?us-ascii?Q?pSo8ngG02m3BqEmlmkITRN4P6Lu11NQPdDCPrW9EuNi4cKbLzN/6oo9r96mV?=
 =?us-ascii?Q?hOjmzuAMZykeT1gUQXz/1neVTd1WhjIIZHlVhwuq+w3llmARrmveC61pDNje?=
 =?us-ascii?Q?oM1fk2Scmeg/XmWzyLoqFonDmlZAricbc+lpfoviTAumNRi5JOOM4ROxf4BW?=
 =?us-ascii?Q?En0NGuXBGJwQsP+PidbjzxI4VLn3NPfZis+GYNDWIciFi/JFJdRUQZY+ykm0?=
 =?us-ascii?Q?0tUY/rF3Fw3M5+J0tWUfgGykSbFc9WKNVB2m/q83JWNagrJQLSUFyYnFLoDP?=
 =?us-ascii?Q?l+1Aes+4ceZBJoNlSAJWKa7I2Zejjjc5gCkm+GxWIjZL7yq/e49TNCN8a92k?=
 =?us-ascii?Q?cjn41L9GYMofcyXxp6ydd0mso1z5BdZQYrFzKgIKG6mSHulywhvLWDZtZeXd?=
 =?us-ascii?Q?AkVF9VP2UrD/6U2lZiql74xCeTzqPeAohJCOjm5yNZgsWmDNhr9MzsgoRkiL?=
 =?us-ascii?Q?9nA26ZPSTFIjcVSdQ+LaVjOF0P4vnaWQB1CgvaDDlWKrUnKzAs6n4Ky6uhEf?=
 =?us-ascii?Q?x7LGV1twV3UdBKHJUgE8DMaGsQQ6afFOwg41t3DfNK50GsdFbAeUE815vw+J?=
 =?us-ascii?Q?YNFG4EYUyJUG4nj8AYoydpMAQAPSX54vkL8okCbPl6J0mVh3LqdL0wroZTyY?=
 =?us-ascii?Q?Cq0R4RZqr+v+Yyd7xsmLIYf1fx89j4rYokuJUVROPtqiZTyR1krjl+qIki/I?=
 =?us-ascii?Q?+MllrzL00MaTU9ARgnIifpVvL/joE2iaYYRX8unne4U8SN8wUO//cS4Et3OY?=
 =?us-ascii?Q?97NT4/w9i/tkBSpgDA4V5fuUko/m7Sk4HLRDM4WZpNzjMffqpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:58.0146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3d2328-dc36-48d4-cd20-08dd07f0567f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d6afd1b5499f..06a1cc752d55 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err2;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


