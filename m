Return-Path: <netdev+bounces-183925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31864A92CAA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1122A9249AE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EC920FAA1;
	Thu, 17 Apr 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YbmbYcFO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6221C173;
	Thu, 17 Apr 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925399; cv=fail; b=TDU1lvGxL/EqEXsGQ7otfSsZpSdgYipWefxFQVOjPi6JfYnLphS1eDBaZmj5xJxeKVh+iJph42klbRVYASnQ3fDy9OyyDIi6ONkit6z56ZYcH5F/jJDJDOuUqnOsq7GaY/0xgixbJIucutEAKFUhgs1PKddMKo/eecRoJYsnJVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925399; c=relaxed/simple;
	bh=4ffGqWURDS8ZACaZLsWSMFTv/KovvFSENc84ZroHpYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmMibKJ2OZOsRpy2RE/bTDU6xaH1xjMwxKrWoEonfDo0QAtm8LQLJp/hQyA6y5lKIyrXl40JvGptUufHjz8lQefGmOOu3TlwBIhDOxe7FLcPkUuexzc9fmQgXAEiFxPrQmLqGXMFQtVnSYMPTVMJuLhMqDlqQWVeIn6S6HmAJ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YbmbYcFO; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LC4+J/DEDQxc8bLbDbEigThc1wUw2Q6PYOkp0/GeO8g0HYoGJ5Phn1URLhKQaR+2N4khqaesNAKCZITBOX8YD5Da+OitZXQspybXciZqREc1LJlzl+MoZaaeYfrg8p56YDx+zRGbm/TmvAeAxqQj+XCEV9oJpOKP2s4R1rbQSnmcwUo0raIqRTsMOmrRI8LzUNMB3XQsaADzKfqg2cqGu6yhxMWPLWVG5NSUEyajMa2ShZT8BwtrP2WLN8DAUZO5mis2eT70qX6Cfytj7YmCJIsXOT5ro+XR8dkoomz5E29Wk4cAJfU1aqZuMtjEYMUxkTgO79oS0htuaW4LQp8hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIP5Mm24QtRkuR+rluiJvhmWpT6pb6x242MulbaWLD8=;
 b=KRlIHcN+8FXSkZ+ZZ4imlbYZiybIejZGLMlOosGq8KwMQ2LE4GsWY6dCLRqNAEsT9EWLG2fkC6oPiAzVAkLH9r9QmFmRKuR0BftrqnO3aW8iEqoV6iRxayFaClTn0FK2V6dZCf/ZJ2mX8G75BKYfkuPX0XIND5Upwpz/4qPdkU3BzAMXDgrvKEU8U5g0EcArPg6h110jY4BuzvOxJhabRXov2URgcc4SOqG8B3xWV9y3uTnE1XtLi7DclraQkQjsoQtgEsvvRIoMaiM/6ef3fKCGtchpDEW2tdhhrYQnXiRJtAdwrJS8RefkieAr5Tc+Ot0pqCH1dmx3d5Y1ec5ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIP5Mm24QtRkuR+rluiJvhmWpT6pb6x242MulbaWLD8=;
 b=YbmbYcFOxspdEHXR27f19WJNaUzb4aS2v7dMk5v0gc2qc51yOLhxmCCl9kzctFs9ld1l42Iy0qj3C9lQgp+yd5zZTI2lT7IDPDePVbMi6Y26zPsQhCAOFU4pCA/qLB3mpTo0ZGlJi7oa13OfFPOEUor5zvoghyUQyCrwPcb6fcU=
Received: from PH0PR07CA0059.namprd07.prod.outlook.com (2603:10b6:510:e::34)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 21:29:54 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::fa) by PH0PR07CA0059.outlook.office365.com
 (2603:10b6:510:e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Thu,
 17 Apr 2025 21:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:53 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:52 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 12/22] sfc: obtain root decoder with enough HPA free space
Date: Thu, 17 Apr 2025 22:29:15 +0100
Message-ID: <20250417212926.1343268-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dd3d87-f306-4e33-f42c-08dd7df6feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iW85MlaBA0CSDrg5fH0/B3luDLELq2b9j/DCVNJIq3HfcZWkVNHb7UpA5cT4?=
 =?us-ascii?Q?kGCFmlEzD48Q7KDQgYmFVIV+11rEAOd7/y5CWtzQ2pRU6R/LISidR3R1INpB?=
 =?us-ascii?Q?yiI/e2sPaexjsRn1orGRtjC7PkHa/selxUh4Qv6tQBps76Z5xD00P+yjMwrK?=
 =?us-ascii?Q?Ut1kOXe27TC+8BBu8t3hM+ljlPX7DD9gjUFDvVHGTM4JnaCIhN1RRNLrLtFO?=
 =?us-ascii?Q?Le7BIhxhiHhiWaD2PwLaOyAjy7BiJbYJp5+PoxX1mJ2R/FqOGdVE3728uTVs?=
 =?us-ascii?Q?h7LPRSipDFvggrRKB65j3BrdB0CTatHbm1xU17AUr9M0stjRoEKz0DjRfh8B?=
 =?us-ascii?Q?lcPlPnCovLa8J1K7FL2jGt3j5JAilr00Uw4boaykliY5zrc6msTkNL07dreX?=
 =?us-ascii?Q?sCN0AfKpmJY2LYWoa0oLTiMVUrc4SYpj2Gz4ltjwYsUIoxKzBZ8mKhLNtkae?=
 =?us-ascii?Q?kMNks88sazYn/G0VXVZ+zyOPUVmm5B6oQNvrqxNZjYLTz7wfn9DSeEJaFAqh?=
 =?us-ascii?Q?f+QEZHGnOSkU23mWf507g4i0nKyKq3oJOeKTq1etnGBijzEmMv2t9wrvntLb?=
 =?us-ascii?Q?r9SENoaS/DN+VhiSTsHjuSOnN97d6uE1IGaltYT1s6uARG39LZgAyeubPCm9?=
 =?us-ascii?Q?qgJ4sTUf1uIuJTHeuCBClOFGoQ557rOtKWsrVkLiN/KGieFsHWHJJ27EMZU9?=
 =?us-ascii?Q?VkCvs8KGDcEcHPCxps+30e5MWhlfZKyHYOO5blfxYkzYQaOuSlgUr/5jaMdR?=
 =?us-ascii?Q?ecwMXU1Ts4pEYWoqy2mIZT0zacBrcmM9vGMe4MYpbanXO/c+leQ55SyG0ZRD?=
 =?us-ascii?Q?bLZWvXFvsjXeBDpEqT7GVuNUkDMCJCoY0MCWavpzZpYtSnQAgsUjsNQCyfPV?=
 =?us-ascii?Q?p+eJd1jHqXs8N9ZuUEQ4aX8Cju9sgsdXcrK+TdTMB3DRTp7kEvmphxM60TKP?=
 =?us-ascii?Q?x8/i46yEOYd9Qn6GQARHgn0lq2o/KVFYYNBYmsRFPnNrMsiaCE08nkg22tIE?=
 =?us-ascii?Q?aThfJ+2hBfOxW9ggm02Q+rDnWjfY4OspzYebgV/erYkk0ixCT0+nBpcDut4H?=
 =?us-ascii?Q?FY3b8eBnXByJ8BzarIpk5PQZPYSrqT1zL1+jlhr1KqxtDh9BbyNuAeqstvdu?=
 =?us-ascii?Q?tiTcJI/WoQX3uAPyj4+OYDfgTphxsOKPdycFGPizpZz3aWTTEuBQz/v78lH7?=
 =?us-ascii?Q?dmfwbXZSvmvRpkOCdd6quxMNMY2+d/AgIJRbex25NO5yFf+iX9jpzBHGPhfD?=
 =?us-ascii?Q?yI9Y9Tk+rqeTf1bRJuCOYNYborrrNmiBKROH/iyNDAD5plHp7q7Ks06ojiy4?=
 =?us-ascii?Q?duX2ifoDbgjhKNhskx4VN6loudnXF9RZzHCN54g0v9RqRcSDK03O2O/rbdpc?=
 =?us-ascii?Q?z0S2X6XUo2B/B+TeQX4WScTelHzPBWpMH5hmSG6p+VCCBIgE1gDdXNp+kZ3m?=
 =?us-ascii?Q?bKnoVk5MihmtlcvcXSXaBR/twx9A/ggN6UDWiBeqNc8TVbdOtlX9/u3wXen5?=
 =?us-ascii?Q?3xdFvFnKX6T5sI5kb74vl61NTcDyjtLJGzGO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:54.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dd3d87-f306-4e33-f42c-08dd7df6feb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

From: Alejandro Lucero <alucerop@amd.com>

Asking for available HPA space is the previous step to try to obtain
an HPA range suitable to accel driver purposes.

Add this call to efx cxl initialization.

Make sfc cxl build dependent on CXL region.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e959d9b4f4ce 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 04a65dd130a4..f08a9f43bd38 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct cxl_dpa_info sfc_dpa_info = {
 		.size = EFX_CTPIO_BUFFER_SIZE
 	};
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -85,6 +86,22 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		return PTR_ERR(cxl->cxlrd);
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		cxl_put_root_decoder(cxl->cxlrd);
+		return -ENOSPC;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -92,6 +109,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


