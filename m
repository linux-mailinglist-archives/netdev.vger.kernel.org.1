Return-Path: <netdev+bounces-189823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DBAB3D34
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D87169020
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2AD250C1B;
	Mon, 12 May 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qw1Bu2Gn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FF248F57;
	Mon, 12 May 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066291; cv=fail; b=Rn0NMU4o+70hYNWFcxJ1dWUCalG+zIrZExTQD1A7xy+9MwEiCpOlxDBym7Thz8I9pFyx6RHLudR8nCjoEfFBEqc9JvZc+ApQzQIa6HwR2Inksz9u05kRsnIUIYCcE1ufUmbN1Fq2lzKByBAdloBS6fXverXydxoaI0CypTXK0vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066291; c=relaxed/simple;
	bh=4ffGqWURDS8ZACaZLsWSMFTv/KovvFSENc84ZroHpYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZY4f5DrMiHwV99PrnWa0u1azBgnyTiRfXz7dmx7oDEhGXrnVG3Z66fBOvOOSmD/yVNijg+pgT6KsT/SnA3vlNFquUYDPX4rpqnoJD1cu9nJBBPDduBtG0FaiheHF/yIWZGcobC1RWai/zadvG7+1ExR9kx3yGj4d8LHIXVWjWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qw1Bu2Gn; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkvXUN4JwIDizC2jGGCAnTSUv7ne+yZUVc2cVDr0Mc/71eSw6B4p0SzcNHet027FQF0qNJFnjZYk58tzIOoiCvCsqYA/SBiCuxN35+u9RGeyaJ1z/VnVmYGYBS6C4Fqag+/gNcr2duvaACIC9z7f5pjxACsRnDjtRAwto9DqgjSjP8+eJOezntxKmy4zBqetbcSv/uRwsnFkBWXkowGWzRvNrH71YDUBnFob/xgkM/k+5e+a3XKfUhoEv9wKj6soCWFCFGYoha7PRF5XHOYFuwg0XBiNZ2ixdwlzxmTQ5wdsyZM5MlhoU5sVE23tq7mi4DKXFbS2W3gm4dIVK5TbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIP5Mm24QtRkuR+rluiJvhmWpT6pb6x242MulbaWLD8=;
 b=MUntX70ft9cm97jOSOvnTDJQBoO+btYbfY3zUht7cJ7Z5do/aBLETwmOamPcYow7JbL4HO72TbtUlarfFSYIiFoe8cL/e/LudUFP6gnJoLzMZwJJreJWdlVcFmNWw1Gho5nek4nEhZOf6x0DJfAeQQ/EAUZUHnpA8XzEq/GYNxQ/K/LweiGD4Qln6THoo2M6aWHadunPM6OkGWORjZnIT2cJ+PZDLI1Z3Mpzo+BbGNZ56OCIIwX5R3Pvi2SXQ70IDN0/cspvx+ncb0kGjap+0259Wx+WGNKhyfj+c1BBUKuvR3UxAOHaWMqoSwwW8KMkVk8gSbZQ4ijFxusfK9k/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIP5Mm24QtRkuR+rluiJvhmWpT6pb6x242MulbaWLD8=;
 b=qw1Bu2GnSmVWm7CZzqAl7KiJfXT1RU7BrLYINeVcfclAIKcIZWh5+yw4bsaqJgeA1KGiFxCDNSfCrYp738wL1YvFYblovLNRn2TrB2Dz8u4wlmszSX3VUljD/N/AredDlg1tH4qR9WIkna8CBjTUqQZxkUdW3TOOHFgT610J6Po=
Received: from CH2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:610:5b::30)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 16:11:24 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::96) by CH2PR07CA0056.outlook.office365.com
 (2603:10b6:610:5b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Mon,
 12 May 2025 16:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:23 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 12/22] sfc: obtain root decoder with enough HPA free space
Date: Mon, 12 May 2025 17:10:45 +0100
Message-ID: <20250512161055.4100442-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cc0b1f-16d9-43ad-374f-08dd916fa44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O2vmP0O3P+72lXLnO2WlkxnjEvK4X0sGhqdtakiZIm3hTYl9V2PklfJqSTlB?=
 =?us-ascii?Q?H4YBUROe/XSOHuNJnrEE54rCvmhBDNpRna0sgq2xlThoMDarcu/GdDckLRJW?=
 =?us-ascii?Q?5b9VP4ofkKM0PPddEXWKqqw1R5HRthsj9Zi4a/AXpjTFDSBWcBDoE16PM/Hu?=
 =?us-ascii?Q?UcxPdCfHkV2b9cUa4vjZi0tflp0oW/YNTo3Z4lIAZ/A75WSUBLNxIkXQokZB?=
 =?us-ascii?Q?5z0VxVeYIxXEOdcFIViRq7Z/iMFBxil3+fJiXms7OcNG3DMzCUqimbtJPkx6?=
 =?us-ascii?Q?E4QtV8IV8cj8QfM3Ji8+kOk0EdaSCUKbdXeT7uc5NPP+S/MjGjZRvv615NAS?=
 =?us-ascii?Q?E08zU5vZkISSM1KTNGj7Rk20k13x+ijN91UyrsfUafQm2MIjEknZe4ZpF5aT?=
 =?us-ascii?Q?tu94+iUr9TpmSfMhLa9kkGikOp/g3mjsq7yJqtnfMdlBbXFdhVY67X/PO0aT?=
 =?us-ascii?Q?vfPN0miaVGOi5z4WQfhgmgSTCsG9wWH8x/YAE+PpiyCJ5RW//JOshvCKSaYS?=
 =?us-ascii?Q?ce3vXkMlhgkMA5rj8XvFWEkA6jZJhhsotaRwGGF5+nHHBLXAFQuk0sbwEBLi?=
 =?us-ascii?Q?X/D09H203YAlodLVjdmuXuSYZP2kWH1uGDkl4y4/qmApNqXU9QMMKP+5y7bZ?=
 =?us-ascii?Q?nYTT4digYpN6iNLh8FJ/idbcK2ScgNQIOJY4m2Bl3mJWHFXWqo0Q7B/fNcNn?=
 =?us-ascii?Q?BVMagQeUGAPxMtf00DtVY6mpBKn2HYODd2yHuyAccozEQaSr6cxs4iGdIFGu?=
 =?us-ascii?Q?FCWNE2V+0rUrbedGIXtb5hDps3/SxfQdZusoOEfeSc7Y5RIy/LF1BC3jMe9I?=
 =?us-ascii?Q?/zPeN+MMyalMi7ez3OarO8iecBo65+AZ2vRLklLbnrm82/61KX4FBejfAGli?=
 =?us-ascii?Q?UKbdCX2TGFAuTIh6enM7CGlgqqmT2p7mnFzoJfarknL0GkuJjGr0ty/an2WX?=
 =?us-ascii?Q?LRZ1dPKnRXMTJM7qbZwQOJ2wvPdac4M0qQgoR5aK5zeGFKswYFIU2S7rd43H?=
 =?us-ascii?Q?h+YHCFaiKjKXFUOOLa78BcHt7WdrdqBnpnzT9iSeK6yd5u/MeyWhWb3yLXeG?=
 =?us-ascii?Q?LNkaw1+wE62Caf24/kEGQz5UBgyNo4AbqANSFZioQUJ/V58f6jDqXX8rcLqB?=
 =?us-ascii?Q?fnr2yXD5VTbe6XrG0OiPiEAUqcrH+EgaTPmdQL18GF/dYx2FTEYr21tmzkqa?=
 =?us-ascii?Q?tXg/LuLb/QNr8sdy+RXUBWueHcW8RGncfe7WcvgTyDAGgC187OQYrl4X89pk?=
 =?us-ascii?Q?8BEyYtg/GB6m3iezN8vIgr8t0TKU+jzYh8EEKokhdzSALHk6qHTdTrIh34+B?=
 =?us-ascii?Q?CEa2a9b2mOmC8vDvITYim5YrEZ188/V0tEqrUH2gcyOUMVVNVyuElBw5rmnT?=
 =?us-ascii?Q?yKX2htjwP695i8Tzsp1utZp6gnhQd+qykzVbiT1NPuEkTqef6TQeQ2HXdb4f?=
 =?us-ascii?Q?8RKIkl3YEa2l4sQPz9cOWHhUV9GFCmEeue85eKAFFnaclofw+icas5E2n9bp?=
 =?us-ascii?Q?ml/+FBrlPef4rUiUpBrMrhX5WzqnP4oE7vtk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:23.9389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc0b1f-16d9-43ad-374f-08dd916fa44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

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


