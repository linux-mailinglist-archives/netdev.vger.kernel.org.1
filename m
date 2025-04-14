Return-Path: <netdev+bounces-182303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F5A886BF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FD017C872
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BD27A900;
	Mon, 14 Apr 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J1jlDNa0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9664502A;
	Mon, 14 Apr 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643665; cv=fail; b=CmEBWJ+PxzpiBH1+0DrUgYsCEmURrwC2m8NxnXih54xoT6JED0sUkPlfjTYUpvPzCC6SXrtqrCeHpLLq5w0UGPQnFJ2byaCivjX03AEdLVkANUTpM0Z5lP2Hj/ynQuFDGGMl2rvqWVajwwNSGwpiRJXia5tQuDzZTZoug1PqDzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643665; c=relaxed/simple;
	bh=HLKLHKiw81zw4axgx+uOCTRTiVk3tjNX6PStk6+jZV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWAi6HVWBp3aAZVlystuuckAcl/WKoTE6qFp36a22xg+RHP0P5BMMsAOQ36ZnHI1ZvQM0lpEenwKo4huXSQF3TQPmzgGfRtGdPTPpqApCB6PTAtirNBE4ULdgCDNku4TVl81ZeexichfNDAWDUaXyHx97uK0qmoNnN6o5fNV8TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J1jlDNa0; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXf4ABLqqNgC4kIe0qMPOwQr1V0k43ETuie6W2mZsIyE7jFrjgeZ46zLj76gMexUYEWdEcvsNovb/57RcgCsuH6wRHZ1g2XqpG//9i9s2gnE60K+XDnfBb92mSB3EklqfSg89s3I2a1sIOSEniSG9YzBxj7M3vPaxoMJ2gMh4p/yBH48kyrJwcaoPBcDRCWNBZmONcweXMfq2S/Og+fd6FtwK3S13lqfWV9jCl2YHdBKVeTCpd2yzK4uOYqQigBtSHqvV5ZkB/72R4XwVzd83O0Y/nfzoQawbqIGYdwOURSLG0fcblFWiCE8c2FWsj+pC8PqCpPQjAXcytoT7NfrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZXM0FoEac06M+njRfqYVCTsTCsEPzjxeEEZ/kez85E=;
 b=X3WDLDdRRCyJ2W4YW8f28nhcpZeF82+X8M6kOdAjQ4J6yNSvBHqOhFwVg3nIEir3t/nScho1wEmmDOf0UpMIQBxKEQSvVkTGLtKywDUjqaT81j29kR91Ygqp5Qj2pLVeqC3PJmXsgQ9a4QwvuawnGSZfRcEj1XHD4fmLv5ERN0HdI8ywFEqpuQwrjaCy/7UE6nwpjPA5jxBBd8I0nfBAKWBnrIjO6EPNGy4uCebVgmjrJY3zPMwhEsuHwFJbWWzBAs4WP/aAxLMNrTLWO3tK8Z/ZxkLBLomjWs/uxmhzIPq09ttBXkHeU4u6FIv8Sww5gJcjNLXB3p4EgWVwl7LNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZXM0FoEac06M+njRfqYVCTsTCsEPzjxeEEZ/kez85E=;
 b=J1jlDNa0Qsf+N2yU0N/3ILsoRxFoNReOvJfAsXDnnZixue1laSzoAkoxX0rwD3NvZtscLrZ5FqJWlrSk+jNJ15ZrOmsUL3fUAYQXSWtIiYiC9kbOwrv1SUy5HClY/0KZgWyLI8ThFUhKqwZaGbA9Aq4/k4PSW2+mcZ3Q2cWBj7I=
Received: from PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::36)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:14:19 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132EE.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Mon,
 14 Apr 2025 15:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:17 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:15 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 20/22] sfc: create cxl region
Date: Mon, 14 Apr 2025 16:13:34 +0100
Message-ID: <20250414151336.3852990-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce4d9a9-25d6-4598-021a-08dd7b670714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?21Y7uC84w0JnUKNmrje9/RqyiYVkWvE3LPW2JaG1jqUFEBG1J3tr407UCPqW?=
 =?us-ascii?Q?RChYTrQGRTP8wsMvgO3zDQAg8Fg1DIXUEBKhG4jLEA1TK6qgEUF7Ldc5I4E7?=
 =?us-ascii?Q?LtKfoyWhCx2k4qvrf+DNXuhoq2z460LJYCQh3ZlcAOlexQIrizIboqr5xH3b?=
 =?us-ascii?Q?leBLnnkIDNGlJjhUrVAQTq65ebH5Mf+GmvFsD2qFgvI2oIOFF0VDTK21zygg?=
 =?us-ascii?Q?7MCh/i6ZkUQ3GT90yYrvoOkvZHEbnn9wi/20SpqnYiVDCHAyM+mkpQzBxvRy?=
 =?us-ascii?Q?gmf5wDnnHq2ungyzhzpeZtZR/sUFl/R3tMewbJZQlzJ2c8KMxsFS4DywFtz2?=
 =?us-ascii?Q?+MWTMcg36Dz3QGVzfAGFEhyRfMsD4geaiy9rfYc18muVtFNShIz2MjdKuwmC?=
 =?us-ascii?Q?m2tuiB0FN49ULXsYoS6bSWeoE5iubdA1eBKnM7ozthsvw0A0o8x8rch2Mu9m?=
 =?us-ascii?Q?c3Psf/8juOid9BapocyTRLLuTv0nIhf9XEszKHiy5LVgXx1gxdkkAuBBNQKx?=
 =?us-ascii?Q?IVES/wWSLwwgd5U22OMMQTu7+xWDl7kb/9o1KeWEXXIkxiDQiOjVq1+Ru2dS?=
 =?us-ascii?Q?EOBWsMCxwddJw6vFw/v94Y9iJO2rhNgdDxZ8v+JR4vJ8uAtVCYjMq8AzBt03?=
 =?us-ascii?Q?fSGEdBRUDiyXi08yrlAz1tVrvBt6a/4iZRnlNhN5wdztWW8gXImIOS2OKEh/?=
 =?us-ascii?Q?mZ0frTKp5Vl+yAZD2x/R6MxWbnpDiTFADO9RP1Fxtg44cxgVWvpgSnUxihwd?=
 =?us-ascii?Q?yN7q0Oci+xdLDUtVzmpxC18mRivcUYB7i2ELGL6MmY160hni1+XMbPAroxAI?=
 =?us-ascii?Q?klbYrGSdZ8ntgF6Ms16UmMMIvi5iWoWKvkpB+B2wNEmJQLIblfNxtLpm/5VG?=
 =?us-ascii?Q?ZpM/a5UvYuZCXBhjwjOe9JZYG5zqL4ESN/Vo5UuCqWeZeRULFvMTNo6CAbNX?=
 =?us-ascii?Q?FSGvStAB5J1KUYYVhH/KicEuBHFzrTaglYMoZTaGj+tL6tUFGLqGPxghnN15?=
 =?us-ascii?Q?TSEgA8tytGMpkdZSLhAeC7hEG2ulhcP/+pjMESjt8EK416vnlxaAUXdhNsas?=
 =?us-ascii?Q?979x+BFlLcd2tepZ5oRrIYbZM9Gd0XEyjcy3cZPFD6TnTzmwUSR/cJ/7rc/2?=
 =?us-ascii?Q?K3c4NiQQxcWqv1bek853pKhvATC/jCCU1B2NXEDVoKOiA3XbpiNzB5SNI/LE?=
 =?us-ascii?Q?TArSHOf4G4HeEjNYF3617jHYLC3F0zskBYxGH46Ea6bAQLnsxgGgLugSGFHI?=
 =?us-ascii?Q?AqD1MtzscuPH9Her36hKotusP+0TcBAkgCMAWQrcPY33yzshjyx+VQpEVLgt?=
 =?us-ascii?Q?A/Efmnq7CtnxxGWzMYxI7/PhXVEyDPRjdHqQ1WZqzMpiTBdslnVO7CNhM3o+?=
 =?us-ascii?Q?tO1y4QMfRV2XO9GI4FBfrYD1umUYp4fJ0NeBEbhdAmr/Vn3SKOi62TDjju4P?=
 =?us-ascii?Q?bd4NDyllf6N3ggQxr4sfteObGfLcJLtYcP6prtVLTQ2RFvpuxGis9c01MXMx?=
 =?us-ascii?Q?14Nbycn+KTWaz8Pwmt0+r7mNDgymJA1OlqzZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:18.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4d9a9-25d6-4598-021a-08dd7b670714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

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
index 7ad5d05a8e83..43154da5524a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -112,10 +112,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
+	cxl_dpa_free(cxl->cxled);
 sfc_put_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 	return rc;
@@ -124,6 +133,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


