Return-Path: <netdev+bounces-200676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB7AE6839
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77904E0BD3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A22D5C92;
	Tue, 24 Jun 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DoTCstcR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF02D663B;
	Tue, 24 Jun 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774476; cv=fail; b=FkTKchAi0o6cUCYe8eTHHP9c86ZlzvsthjwNBb16VzEpWOAUv3MkmohvRtVJQ/2zib+ZPfH35KyzP+UhkFphTqmVWpe8PYuQt1eEvpb2727IVEHQX3Cj1oFnX7qm4knSpwXYdhK1lTUjROFldD1WDA2SAMD+ZoalGhQ0+vRKSdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774476; c=relaxed/simple;
	bh=b1RIEdlms7MlTaYIAcUjC4YZh4N8Puhnk/45UIOd3Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4eQGCynAtyNC4e9Umto6261YavWPyhTxJ0NwLWh+wHT9iy88q4S3wacGnAthxfTeQuciIHM+BOTrKGTksGoIOjcJttanKZMzAAnWYP38Rm3A3koDGRMyr8WdHdQdpNQEOcsV53/0hBr79BFJ5xWmEQZaU7dtajS5aBW4KcgfeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DoTCstcR; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/RrilwS6a1SqzidRjR7rv5WykMLlZ6x74gySUpp5qpho/IWhUKFIKo1PU8pLz323aHOXlRQC3J8Z2BNPZB/QWwJhJbVX3NklX+J8IlbyZibMG0EZScWYip2M3gULch+3ZwKdfP9NCUHqxQ9j+yLeVJFWMotnthxM+5pKCh294apKlNJATrsh9gfpwBwdAEPLJrq+VUMSPKSNGlVa4w3wjjwksw6ElNty65MCKmRI6BfSBUMJEllmrxEl7J/bNH1dyOn5TTGxTDcRHdHmdz+Q03T+Ffl/jI8qXBs+F0iOGuz5Ib0DFnWuNpffKLkyCMJnCMFIpSM1vbA0iDjYCkA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psRwd/tpCmEL7ZmbOcQZ+VAtkXyXi3PORg+9Aveu9a8=;
 b=mQ328XdtRqTCJaCmOZepkJjBodN35Ds8SFHuWC/J/o51cU8MXUFucMZd1kOfjXNPZWRVPRiFeu+bEhQ9My6zRKQa04R9GsoVcpZHRAXbYg02jvjDpAz5pGfTXADKY8urMltKsT8eZhewuAaeo+eNYjBiCrz8JRC1BUxgu5EDhPL3087UfLjEFH/lxjODUFoJvo4H4POmzglCq4aatDbBmTCp+9VSpKSNGJ0DjY5Syl6STBguTvLMuAhijCXYbDqXHiQqN175Nhy/vSQybo6MkiQqiNf/sQgpG4jlxaFiTlXszLDTHqFEbN4WJ1EETZ2e35hMrDwZYDrqjQ4QrdslYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psRwd/tpCmEL7ZmbOcQZ+VAtkXyXi3PORg+9Aveu9a8=;
 b=DoTCstcR4fs+BLyJDDmL64aZ9SnzSj2/GgVI4PgDD7NPih29aCJZWJomuqDWkEJjG8QNgZ6R4eNlWbZXdpGsFoHoxrrN1Zhx2pH4v/VYB1UTXRC75w6mzTQC4TVtSaY4z4wwYEOhCYMCSSHHKRbTZo7Py11RrKIqlOn8P4OnyZE=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:14:32 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::e7) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:31 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 12/22] sfc: get endpoint decoder
Date: Tue, 24 Jun 2025 15:13:45 +0100
Message-ID: <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: b6672f01-b222-4ca8-5c54-08ddb32970bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6dixI8R4rnWzflbO/4RD4Q1S2X/aPI3fD/JAEXvz2PTYhVy1hOGp4VcjphPI?=
 =?us-ascii?Q?AAWpwBT8In2h0w3oXtDxbCnhzfVt8aLJqU/OJO54r/Y7bweQKNsAwOzqtIsM?=
 =?us-ascii?Q?t089LyiPVmkCXafA5GZbhNfI5SqldJ7ozq9ThsrqafnFZsypqJT/KA+coeGS?=
 =?us-ascii?Q?rtvuvbRH+GvMx0ZF4kXjeOT8fBsfM5YoMHYwpY19HRPQ6Uqu96g90VeZ6vS1?=
 =?us-ascii?Q?x3dNolivwL0ddSb9mRYq9aZtH0uYyCTeWDQIFwtFA8EcBjuLKJ5Z68BYJ2st?=
 =?us-ascii?Q?BqEOT2sTy3JbW5TgDgDsU8o3R+xnEBdAvulMtCJNbK3JndkF7izD1WDBfehW?=
 =?us-ascii?Q?xDNA5zuUQQ6N5cCnozEvM/GxDBpnvax4GfaxKXxe/61C3/+kqPZYf/Stb55N?=
 =?us-ascii?Q?d++TH0Hz+Qru9IsgMM15kZMovKinw/kX5Tg/LytcLuNA8Do3z+Q8jbzkhSJt?=
 =?us-ascii?Q?4q1O5sP/6+PAOd9KnPZz4WFvRVkIpw3JjGnUp4g3z8TGkC7FigIX3hilraoI?=
 =?us-ascii?Q?VBhp8kEh3QTuD+9Eggix/XmNJ5iXHvrbRD0bkRAzy9aGAqtX8f8RCLVZQrMw?=
 =?us-ascii?Q?WeUIjNIXbSagiCsBX6WGXuij278X8PH2kB2DycToGWG3H/duqkUsX+dTULPB?=
 =?us-ascii?Q?cKaWyME59BL/PlfHMBG72U1LCXpD3h/FhcCX79YwaZ50me47eJdKxFIn3Dcl?=
 =?us-ascii?Q?G8+ozZUVsOTJHPQTwq+HX7AZfFMPazMxo4/9KEBl10q4jmCemklrvDLFNaYn?=
 =?us-ascii?Q?yJVJz6OHYh2Jh3rOdQGTcfRf62Rv+EXF23ju3X2UiPmz0fRIKjeuV4cGxZ3y?=
 =?us-ascii?Q?3ib0bU3uYS1YWGx9XZXQkjg1Sa+S46qXnSdTS7kT1MZVcaLAinJKh8cDFnTK?=
 =?us-ascii?Q?h0MVkEPc0A489/3bjqAME31ipZPZD3zru8VQww2rVdZNFOD+NIREzWvFBD5p?=
 =?us-ascii?Q?zqI21v02Ecb0/P2cpFtKisMRt8OlgKxZ8/muEY9AtMfHjrdfNCFYyaryrofg?=
 =?us-ascii?Q?nrmStOt/3m0NYvMRYmmY7thc0Z++f8qaxRWhGuUSFXUluJcDdxyYPWRYO5Sn?=
 =?us-ascii?Q?o5Fc3oCYlb8gRX1HoCq2Uw/h2hz4TTozIY9SJsqyAEIkm74SOJUK03JOxmRZ?=
 =?us-ascii?Q?DVE9oOD6uHPIUkiJPnQUtugawQPMw5KnJWgWVBJ/cGBGpXXBxn1rdtQRB3Gr?=
 =?us-ascii?Q?qBRoEgMm5G6+ptkL6EKh5zsLClB0NIuY4D4XH+SQDeuWp7BxANsEZAlKtBJY?=
 =?us-ascii?Q?Vw54EJZ+IgWfBVUcL9KfMYZbZyJuONFTz0Y4IjmkdTKWxbC+caOksppI3ORt?=
 =?us-ascii?Q?kCNpr6w2wTH18HS2W6sSoCT+aCUG5umWyHAYF6oztQ1dvO4267rfG0coq15m?=
 =?us-ascii?Q?lK3CqV9cb841NFtVh/++W+ZBcRKLBugn9dwRGw8H+4gXUS0zIQgcN3/9umIa?=
 =?us-ascii?Q?dvNImU0NrWBb7oroEx2x642KLPFj09rpt+t667Bxe6ZvtEth1ffuXlvyh4I9?=
 =?us-ascii?Q?5Tzfc0dJIe/kz6oREvaKCA2xw1R43sYMyzrb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:32.1740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6672f01-b222-4ca8-5c54-08ddb32970bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 32 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

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
index e2d52ed49535..c0adfd99cc78 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmd);
 	}
 
+	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
+	if (IS_ERR(cxl->endpoint))
+		return PTR_ERR(cxl->endpoint);
+
+	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
+					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+					   &max_size);
+
+	if (IS_ERR(cxl->cxlrd)) {
+		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto endpoint_release;
+	}
+
+	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
+			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+		rc = -ENOSPC;
+		goto put_root_decoder;
+	}
+
 	probe_data->cxl = cxl;
 
-	return 0;
+	goto endpoint_release;
+
+put_root_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+endpoint_release:
+	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
+	if (probe_data->cxl)
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


