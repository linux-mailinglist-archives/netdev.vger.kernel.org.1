Return-Path: <netdev+bounces-180422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7EA8147B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823F81BA6047
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1A24394F;
	Tue,  8 Apr 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xNPDDZ1O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68905243369;
	Tue,  8 Apr 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136455; cv=fail; b=sEYov4k/YVDDBXNQxNnMFjkrso/cDeX9bxcwy6J6IdAnxWeqsS6wutiYuAxsfm9JWZa7SCHtgG38TX7xfQjX6O4NgfYU6tBCVx/jofkzaZ5J2PFMcfAfCi8KP1vuKyNXt9UR0A2NLB8D9nPSPcfUn/Ao2sSxJZTlnQSx0eeetoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136455; c=relaxed/simple;
	bh=8aaevpijU4kNu9KI3hSRGJw97Mx3KaD09TM+jBgOV/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6EuxzcqGTs4qOLSfFu38zIY6QezaNRamEr9eZ50ws4DGqRl1yH2epcwR3dAn0HVUHm3wOuUO8s7uperdU0CEhPttTDHuvJRapmRSKpFIrrpbdRXb90U21Oj6fCmncTiSeYNUN8IBBojLpO94R3LitSg3XdE2yLGlRt64d3OHQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xNPDDZ1O; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJLRwOpFyht/mHby9YJr0wPN0uagx1VLcN3N0j5sk/hnJBhzfub/YaY5jjnf9GdvoUmE3Vdbw6NBcIx9r3jy/PU5zOZTWl5Le39cDKZm3TEizIMEtl0Hp1Sg8QhsUGl5d+/3IKHVBA5YM+XseVahC4DZ5yxzz+Co7nVq2v09aZuRNFUredD/a0CObsw+D9ejsvfUtolABxSEqTUfN5bAEjopv+2PHxbqnloUANkC86PVWMJh+jZgwOERpwpPE79snc8a87jxSSGXCCwxlGtJ/aAncJ0ulk7XpaM7p6wlmlKTu8YMqjWmbwF8yZKrtvmQgT+n2Df6XjCnocKQE2G9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS32IGhSUzeuskEbwnGKpwxLOZ4PJdgnXKmLuuWaefU=;
 b=DIEB6QGfWECOfMuoNbZqF6XEHkHuSyYCWJqSMA4fzUEBepfUyKXsabLL6BWJZY/5tUEG6iP+COG9aHiDL3j9DWqO7/HxrieaEbhv9jeSJS4jhKnmiTRLsKASUMziEBJd9LLu3f+BU9DGMxtsEQYKj0gSMIp24tDHuPD1TlYkclOfT6y+k3biHHE6O5NeB6hzF8Iu4ZhhCRXGqtWjH+wCYEXEqlJQzIBSnP7v1nBLq2wfy+ZrC8V+yFY8pCugY5YXLgLsroxKM28K8aC07sQ00TV2uT60W1orRAfAqQuLCy87hX6c9mzc3BOyCHxE0tiZ6qzdF8CBg7GbvgF3LRZPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS32IGhSUzeuskEbwnGKpwxLOZ4PJdgnXKmLuuWaefU=;
 b=xNPDDZ1OQkVdk2Z+MwV/ffGP98pR3rgHHgFMtb6h3CtDkmSQ7Dx9qgC64OIlXTjVRt26ZQRTDpZB+79tKU5OD9p553ZPJi92KUUb67DYY3fL5cowRJSAjpsDdh6C5JPBA6vAN+NgtM1lbfc5DBzjj7KgJp9n3gUBKtRdt/TM/5Q=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Tue, 8 Apr
 2025 18:20:48 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::27) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 18:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:47 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:44 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
Date: Tue, 8 Apr 2025 23:50:00 +0530
Message-ID: <20250408182001.4072954-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 277eef40-05ee-46df-79a1-08dd76ca15e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O71H5BAQ2VY1qiehnrJPMOJUV0O/AGa50Pqi8/KF6mlFAdPmP6Q+EKtzYcJ4?=
 =?us-ascii?Q?kfWtICRR2kh6PIvWQdnqyhfRWPPROwZshhODUiV2w6N/jBAq9mDGgSIqsPf9?=
 =?us-ascii?Q?FmiR0t8J3IWmilhuUB6+611iksLLeOwI8NMi5KPUj6FfiIUw9AipZRll1YdG?=
 =?us-ascii?Q?PkNduDLKUZGmwlAA06v5brNepkk1x9AiJ6fjl1uaahctABsG3xHHsEsk4qgB?=
 =?us-ascii?Q?67qsjtp98Jz8r27N1VHaM/lnsPUDxL5KFq3lLoC2iwRtTgL+Fn9TTwOOSTtH?=
 =?us-ascii?Q?W0JgK652MrDJdmwPjMkpar8AaJ8rspzECiTlasmZMKXDKfbVuDpnSPL8aPZe?=
 =?us-ascii?Q?MF2o5dDCfuz4BtpfN54AVl9GUVyRR7a+LUnBnLVNA+pzARjNhymzUGf9KMU2?=
 =?us-ascii?Q?+iFTqUIwNY7QRSmWb9IwaZzkHVnQap+tlMI9qesCR7EQg+zOe/6TDQhEmjta?=
 =?us-ascii?Q?qt6uK8mrrLeIRggyr12l9ghLH5IKZHLubuiieHbdCImaROZzI1b+KSKh+ZwZ?=
 =?us-ascii?Q?8VUYw6V90KwLV1NRLoNELUifdRIC7oM7Adl2hfZysgzssLQQXD5GEjiZsaq3?=
 =?us-ascii?Q?IoWxE0rO4DNV2fDQjYJgoPRqG7g08zPt8XRaXTfMTL6CGhsUjxSJMr16lfRk?=
 =?us-ascii?Q?S4A6Koq5E6ciDW0yzhwwX7j/qZYLeUOpamVJM5PD3sIaX/50SspuluC2sdC7?=
 =?us-ascii?Q?ILgYBo2QV5d2DGvNtijZZbeFWaQtDIyF76lDJtXysAmRixWoY25fsERnoplg?=
 =?us-ascii?Q?xq9mnBtlF3gaSI6ec7Po2AEkDRDa+HekKtZPIZifAB7RPKzphVLrq7j1LqP1?=
 =?us-ascii?Q?TCexi4pynKVYaCk5P/CImtrGpyj/cGX4sCjELRg5mMpUzCRb2PLOsrT61G80?=
 =?us-ascii?Q?PSycsxpWixDb8FLKiFQzpA+nbMcMGW2QzjIOBoba31QxcQIQqQu/sWCV239/?=
 =?us-ascii?Q?lsfz948GokH6QluoYJ+aZonFDnUnQm2rH5dodAFMNJaufE5Y4jAtWQ2mlmvX?=
 =?us-ascii?Q?NuIxipMrN19WaGKEiLWTO0wWUs5xtSf01UtLWruPJAFSSDaB8tGHCclU8wqp?=
 =?us-ascii?Q?eqi3g2YQGrQCbpaDkIecHEcz6XLHpUbFJ8hDMvlZA0VEIcY0BiaYb31hpYB7?=
 =?us-ascii?Q?eP+ObPDob4v19MJBkyE95ltECbpOPzgcSEYlnRM8elEtKRiQvkW9ka7lNU1g?=
 =?us-ascii?Q?LADRYoGjjKVv09EnEhaeDTXipga+CkO37ND4L1NOfh0ma7hzByzZSFjHzOzU?=
 =?us-ascii?Q?da3E3Tp7/BYo/2V1MegjFaAHfVm0toLZdtOu6EYmwvUEm8SAhkyFXHkaJqiJ?=
 =?us-ascii?Q?dQIinvVtaT1gMLJgrICMfwQdLwV5WaJntkYSdlZzexJLc5j8LxlOzwy8avEl?=
 =?us-ascii?Q?b+ConXckH4lbzVWyPCTG6raTPCZHtkIVBoz9dQiIzXJd41eE5Ami9TS1rIP+?=
 =?us-ascii?Q?HQ2iRNLz2qD8rDFnrWfn4Gtbqxkaf98aMuACjNMBd3LRMlTJVGGfiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:47.7878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277eef40-05ee-46df-79a1-08dd76ca15e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

A new version of XPCS access routines have been introduced, add the
support to xgbe_pci_probe() to use these routines.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 32 +++++++++++++++------
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  1 +
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index e3d33f5b9642..e1296cbf4ff3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -791,6 +791,11 @@
 #define PCS_V2_RV_WINDOW_SELECT		0x1064
 #define PCS_V2_YC_WINDOW_DEF		0x18060
 #define PCS_V2_YC_WINDOW_SELECT		0x18064
+#define PCS_V3_RN_WINDOW_DEF		0xf8078
+#define PCS_V3_RN_WINDOW_SELECT		0xf807c
+
+#define PCS_RN_SMN_BASE_ADDR		0x11e00000
+#define PCS_RN_PORT_ADDR_SIZE		0x100000
 
 /* PCS register entry bit positions and sizes */
 #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index d36446e76d0a..d692f99aa231 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -98,14 +98,14 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 
 static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct xgbe_prv_data *pdata;
-	struct device *dev = &pdev->dev;
 	void __iomem * const *iomap_table;
-	struct pci_dev *rdev;
+	unsigned int port_addr_size, reg;
+	struct device *dev = &pdev->dev;
+	struct xgbe_prv_data *pdata;
 	unsigned int ma_lo, ma_hi;
-	unsigned int reg;
-	int bar_mask;
-	int ret;
+	struct pci_dev *rdev;
+	int bar_mask, ret;
+	u32 address;
 
 	pdata = xgbe_alloc_pdata(dev);
 	if (IS_ERR(pdata)) {
@@ -181,6 +181,10 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			/* Yellow Carp devices do not need rrc */
 			pdata->vdata->enable_rrc = 0;
 			break;
+		case XGBE_RN_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V3_RN_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V3_RN_WINDOW_SELECT;
+			break;
 		default:
 			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
@@ -190,10 +194,22 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
 	}
-	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		port_addr_size = PCS_RN_PORT_ADDR_SIZE *
+				 XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
+		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR + port_addr_size;
+
+		address = pdata->xphy_base + (pdata->xpcs_window_def_reg);
+		pci_write_config_dword(rdev, 0x60, address);
+		pci_read_config_dword(rdev, 0x64, &reg);
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
+
+	pci_dev_put(rdev);
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 6c49bf19e537..a21171503ce1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -241,6 +241,7 @@
 /* XGBE PCI device id */
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
+#define XGBE_RN_PCI_DEVICE_ID	0x1630
 
  /* Generic low and high masks */
 #define XGBE_GEN_HI_MASK	GENMASK(31, 16)
-- 
2.34.1


