Return-Path: <netdev+bounces-178330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2402A768DF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94157A45AD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85623221573;
	Mon, 31 Mar 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dv+0B6G8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2233.outbound.protection.outlook.com [52.100.160.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE722171B;
	Mon, 31 Mar 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.160.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432407; cv=fail; b=TDy6/jjnaUPMSlqXiWwYeb8kHmb3FsMBccBbqa1wTUR+ioDv8zjGGUMXfZ95ZF4jcqHD9TnPJH3kscH/JRpUgi6YQrBhDNIc3Rq0C+RWkZ7ZP/i7D80cWgLXJbrs2bK6mg4kz2n4oT/FfsQqCkkHF4/vYPtAe4Zo7VAenpVIqGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432407; c=relaxed/simple;
	bh=mwxeGkNltqmM667UjONMpDP+UXyIY6MF4l4TpGACY9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkNtnpDygMm9R3L/h0Nn9HfWqNxJwWMaZZIhZh0Bj/Ddid6Bjx6pB40YM2B/SOdt54dAEKM1+xYwnR6qqtXpcqyDiG0xx2n8YUUgV1sAcUdvFxca6gfvIXfr7Yl+eXzodXKEupILyGqB2DGxV6VqoGN1FHnCVq9rsxpvKcISo5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dv+0B6G8; arc=fail smtp.client-ip=52.100.160.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AihQcUeMnH33+aBJr6V2+Za4V/+sjbxr2YLchhAPVPPFS0iIk17YHQHMnDXpemM0EXiFfepN0SPk56tBkuBuGadm5+pS1erp9REVAXwem7ygFvleCaY9LoxtWdroN7pmol9+MSw4YWmPHrt1BdxVh06oDI8Wmetfsu3CpjDpahjMP69gpvBP+5wLW2Q4RMIXMvaleyKwLzJD3Z5nSRKJBbfgergA3ULdP3Q83eJ4e7aEQTFc0bkBqnaLhPcHiOsTmkJ0TYVsVsyDktYpsQ3bshXJ2t9/LX+ocldJGkTWVRjDNY+RWF1yiLGXdAmjW4QPbuHivukmiQrbhKmY+MRo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpYpwvOrnasV7GQo7ya6oVa5BaOmZszWnZbHDYdABWA=;
 b=YwdEqtSwr9FDRzFvvxdY/pj5kTp+NPbVSiDuFkBzZE+cMHhUJyKG47ozQGpkuu/Ob7GrodnU2YP31iX6pK9gI4wfpZte8XMws19dvFWgRlG/6iMuyKTlCCyoPeV4wWyXiMX7NXtgdtpEcn6ZLWGe4IZ8vpzu4+fQaujnMvlkmz8OYgXZhR+8FTxK216rw1po3FJ4ajy5mhK+lpZ609ojXNiI0SSSSCnBZvb2dwuSn/KjIQvxOsLLSoQxR75x4oY+jdJaX2HXzc53FUFiYAuZ/j8GcDPghneS7+NPOL19jHrRxtCsdEaUrXQr/EDIKsuZQzjaIeJadUjG3mXFi6IQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpYpwvOrnasV7GQo7ya6oVa5BaOmZszWnZbHDYdABWA=;
 b=Dv+0B6G8EGBIJ4V7PyGCob9U7DpyjS81vvddQuh5xFbChxmtO6aCIFLokqPc3x2jJtuX6iUFK3flPY5vTyaHURbEp3IJQuqCup66A9Z77NuDjUYFkmBEIMiLWSu/3LoPvDTWe8PZdI000fuhUNfMOyCBXOy4m/FUTI1Zv7XPDVo=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:41 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::58) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.36 via Frontend Transport; Mon,
 31 Mar 2025 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:40 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:39 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 20/23] sfc: create cxl region
Date: Mon, 31 Mar 2025 15:45:52 +0100
Message-ID: <20250331144555.1947819-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bccd92-0000-4b79-8d09-08dd7062d955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|36860700013|7416014|1800799024|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTr9Zq1xZDU19oiflcgIY96O/53o2NkKbNqxfMd2NSNRf0byFvOtHaa3Nwxi?=
 =?us-ascii?Q?mM7vczSMD7bwtCIGPV6OCBs6/r+7dCNDbPfN7ddAFEsKgbQEcKmHd1Bu8++y?=
 =?us-ascii?Q?ocsN078X7gy+jMus3ihcb+o4jY7/Rzh/Cj//MOtlyOcUqONUtxreDhxph7cQ?=
 =?us-ascii?Q?SegTjxdqLfauCnFjdIMk6lw1M8Owd2o6ELBjhsy5pWr66NCRLwkAhfPfRgKT?=
 =?us-ascii?Q?eiqs+Jc620fztkobPz7aLTxpoQS9bIdzb3ovXqspdMeE5VzqRBFCb15dw9uH?=
 =?us-ascii?Q?1TYb9HdxRb+YJ/GDd4C5Ksx4MRLUPEzHxPnNf2YlKCf0JAdUtrg/9Pj8wvcV?=
 =?us-ascii?Q?mEll5umstJcHZyjMFV6jh33fGOx8YotX5GqwoUet9YQmeMEtAe3/wGLzs4Za?=
 =?us-ascii?Q?yrbPjojEtofu3b9+Sxo6fz9ENQGqTol8t375wNCmAZdrMixOitSyJxE0OPXd?=
 =?us-ascii?Q?cR3ScbrHaY7PZS1PI3zIqH7+ioqh7jfKhu/QjImUKWdaN56mIy0Hhx4FXSMp?=
 =?us-ascii?Q?02fa8dNgcx0At8NsJjJ5z5Go7K8s9fzPlNCYhsSdd7DGtIAZ3zPQyKirThh/?=
 =?us-ascii?Q?SmY/oMa/jFxffBXB4Tqcv2ws/MTXBi2asVDwoUC5lGfiTeFHZPZJFyBLq8VR?=
 =?us-ascii?Q?mzZISr98+O06N/7XfK2BIRHfVDb6dbqRtdM6EpPioNQrq5VmrBRHmcfgV+iS?=
 =?us-ascii?Q?3tsI8UppmNK2mcUZEUROsUjjTaw5/ag40jVyN3H14EXyzG0rJK+q0VrxECk6?=
 =?us-ascii?Q?bjxun/djj9WkI210tRgQZavN/fyqOSSYgdhEfduolEynSnEtarmfA0Ana5rK?=
 =?us-ascii?Q?U2ywOA0BGOXlN3ZmL2jPIQVUsgK7x0gpi/179N5AvlLVi6XRxcAHIGU50DEt?=
 =?us-ascii?Q?XR4AxYH04I4fO10fTH/af68BGyp5dhZVRL4UBBv+1cSHXnRg6/Xp6JcWdx7I?=
 =?us-ascii?Q?gmhS3wCuTyPxX9rsqn5xPsZ0UEMXHspoFPjYx9O9COVBIRVaCW7OJGjkAKN/?=
 =?us-ascii?Q?C15ZFone3QqTBPtw+1qbL8DRWD/BtBXQRs9EowmUKXbuEIWPQIVLsINpga/s?=
 =?us-ascii?Q?otsqmp3ui+dDJzbzRes5t7g6ZjNsvcrVqIslW5jXIaCIrOBUHFoxey/f8QPH?=
 =?us-ascii?Q?HqKpcwP/OR7fOfWhHDz9XwX/tZ4bb4VJnqZWIYzakJfnRyW8eb2qVv16LzBq?=
 =?us-ascii?Q?CV9sUAI977TsGMSnbl9p8eDQJwsp3f8O12amrfBACm317vNuSUQEybI/BKWp?=
 =?us-ascii?Q?mWD3hRQVFMX07YuDxSbHUXo06MyEYOvHEdrSeLi5i+S9Ro9hHwTgkVigfxla?=
 =?us-ascii?Q?nvweWxfLcy7UsqK3YtMXxWEvsIdfOwt+1bOHAM33A9mWVYLL/FgKj5lNdcUW?=
 =?us-ascii?Q?EVtfW/E5HSZoMv6XcHFu3ztXm5Hrgjs5q/IdbEsTEYz81csuWj7h90yTu3xB?=
 =?us-ascii?Q?SFh2xgLTPLq3QG12pSxLYlVRe5Jyh4UStsYrC5o8vyYQzDJoUpGIgklLlIRU?=
 =?us-ascii?Q?gbAv7VKdfANm8M0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(36860700013)(7416014)(1800799024)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:41.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bccd92-0000-4b79-8d09-08dd7062d955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range specifying no DAX device should be created.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 20eb1dfa8c65..424efc61cc84 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -114,10 +114,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto sfc_put_decoder;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(probe_data->cxl->cxled);
 sfc_put_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 	return rc;
@@ -126,6 +135,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


