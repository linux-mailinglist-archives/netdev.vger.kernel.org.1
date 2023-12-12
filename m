Return-Path: <netdev+bounces-56250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E789080E3DF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7087F1F21F33
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB41401C;
	Tue, 12 Dec 2023 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cDf9n448"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D3CE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:38:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKO9d5y6u7KiVbzoSxelOHgpI55CCZjF7YTsouGOs1Cx+8eh3c8nCuR5CURxh6GIQ2eEsytFk+1t45o9LDJkBHENFuzY0+lqQZNl93ZFUQFF25rURnjqvGyjyK1NOpplGiMnBbRUy554GcHLKO2mlpGHL5PHrzw800FE8ku4Y+dy0p6h1MR8XSCRptFZsh2YgB03snWZjHrokG4tCsNj0/P1CkxmM6ODbYatQMpD+VoDVosujpxOiJkFqarVK+Le6sF8xwwAVmg9OzXlRHLmMmqipOsjgbI0zgIuOmiJB+bhvw++LxRL6X2nuP8h++oOdxV7aZPse98ltO9duqce7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXD8M7bSDGRPiMAirYIauJZH21quRevEoMk1PEcvEyw=;
 b=AIz8jSPvbSGnFia/Zq4URdTN1OH+DXUmxeWGx5t/w7vdap26jKWTGpgwkWTt4eQuqqG+quHPrNazeaJpC/+tXvOuEms6jAtLjHRRpT/mJ0DEjlUeLK6pD8jqhwA4jeDj5BvSp7SDCJhPoKXAygQGP73S/a99dK/xaYVCqRi8qXd407SJSqdILnkK6OxK1DryfMuNQz0h29yBJ101EATdlY2V32ZqDf+CCX2wb0uCu/rTqV8Nb24Tlc9M6rYXgKHnuOXezLRmuXyoEu9xNoC5yUIDzI0IPRLMCjTvj39zJtXGg+6ZnPrSG6r/lldtYGdpBwQrw47X/DBwPxVCJJJKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXD8M7bSDGRPiMAirYIauJZH21quRevEoMk1PEcvEyw=;
 b=cDf9n448k4LShKKc49MNrJqBTAH2vZ86GWOV7yNJVQ/kTu9NQWDUjpZ511OP2Ykc15JD6FthuBZk5RqKrqCWcZoZMTNToGPlRmhB6lbLDg4Cag9Sn2eQGpaGQNsBUUB0KPH22TdYNKXLjCbFZ5huvFYhV3PoUAKxNwipyYUD968=
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 05:38:15 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::5c) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 05:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 05:38:15 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 23:38:13 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 3/3] amd-xgbe: use smn functions to avoid race
Date: Tue, 12 Dec 2023 11:07:23 +0530
Message-ID: <20231212053723.443772-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212053723.443772-1-Raju.Rangoju@amd.com>
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: e86630cd-65fc-4fd0-01fa-08dbfad489f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qFllzE8Sd3KAI4+dRy4WEqdFF7pRPb6vPTf2dhZkyp8dFfdE+9R3Kr3duwW7qrU7X7/Qo68eiih60f5XOY0NztlqsB7C3wYXaQtDb6x/g6lQMw9rUR3DgDYn2r5RHaw2sh5iKebgASTglkbgTfdeOWBuVCcHIiiIJouTbX64kjx6t18uxEeY6Ju11wTMWpRelPnfySaphvR1hRTz7T0gpRdZPVDjgYZbc+EQNPG0HwuJgVPCPNJiAhkN6M350jp7vKxLmGawk/W8julcggoNM5HBVBi1HHtKxzA/mYbrJag/at+ew8qczjv0YjZfk78F2hVebmMR8FwZCX0Lf1Fc26HlLYOoIqv++2hhynn85EQLWBhzQVLbN1b8h+/u9l1DcQwie5olbccvGAnzH+duaq6zZ+1ZSSuob47kxxmEugKq81NyR+SPT+1NO2HxMfe60V+RvGJmvHlzy0i3BGq7uAwQfi0NeazC2X7Tbe/+QNpbTZgYStX6sr09FZoZKpxTQ0ckF58KfigfmtrLsjJnm7grtZ/XPU0q/NVYdVI+nMMMBwplGpr6ocvOLrBk3rUNThF+lsdKR921BkZS2APEoOOKjEjOyydRB0KxBL25BBkxdLnvnwwjUMaoHrzkEzzuWY2uicQC8mY+wWlyNnyNXQAPrg3Q/ow/vn3dVaxsMQkRlg6MsOH7uHGuBCOv/cKutLCjONw1FwnjPSZyKeZA05RVXO20w9064NR2bXLLXV5n0oNA98bPwK3Pxg55T61HF1cJ43aTO+5J5WLnWMjvog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(41300700001)(36860700001)(86362001)(36756003)(82740400003)(81166007)(2616005)(356005)(83380400001)(336012)(1076003)(426003)(16526019)(26005)(478600001)(7696005)(47076005)(6666004)(4326008)(5660300002)(316002)(70586007)(8936002)(6916009)(70206006)(54906003)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:38:15.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86630cd-65fc-4fd0-01fa-08dbfad489f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests.

So, use the SMN calls to avoid the race conditions.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 33 ++++++------------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 10 +++----
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 27 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  2 +-
 4 files changed, 41 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index a9eb2ffa9f73..8d8876ab258c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -124,6 +124,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
@@ -1170,14 +1171,9 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
 	unsigned int mmd_address, index, offset;
-	struct pci_dev *rdev;
 	unsigned long flags;
 	int mmd_data;
 
-	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (!rdev)
-		return 0;
-
 	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying
@@ -1192,13 +1188,10 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
 	offset = get_index_offset(pdata, mmd_address, &index);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
-	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
-	pci_write_config_dword(rdev, 0x64, index);
-	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
-	pci_read_config_dword(rdev, 0x64, &mmd_data);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
 	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
 				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
-	pci_dev_put(rdev);
 
 	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
 
@@ -1209,13 +1202,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
 				   int mmd_reg, int mmd_data)
 {
 	unsigned int mmd_address, index, offset, ctr_mmd_data;
-	struct pci_dev *rdev;
 	unsigned long flags;
 
-	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (!rdev)
-		return;
-
 	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying
@@ -1230,10 +1218,9 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
 	offset = get_index_offset(pdata, mmd_address, &index);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
-	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
-	pci_write_config_dword(rdev, 0x64, index);
-	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
-	pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &ctr_mmd_data);
+
 	if (offset % 4) {
 		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
 			       FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
@@ -1243,12 +1230,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
 			       FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
 	}
 
-	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
-	pci_write_config_dword(rdev, 0x64, index);
-	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
-	pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
-	pci_dev_put(rdev);
-
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_write(0, (pdata->smn_base + offset), ctr_mmd_data);
 	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
 }
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index db3e8aac3339..135128b5be90 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -121,6 +121,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 {
@@ -304,18 +305,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
 		break;
 	}
+	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
 	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
 		reg = XP_IOREAD(pdata, XP_PROP_0);
-		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
-				   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
-		pci_write_config_dword(rdev, 0x60, pdata->xphy_base + (pdata->xpcs_window_def_reg));
-		pci_read_config_dword(rdev, 0x64, &reg);
+		pdata->smn_base = PCS_RN_SMN_BASE_ADDR +
+				  (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
+		amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
 	} else {
 		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
 	}
-	pci_dev_put(rdev);
 
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
new file mode 100644
index 000000000000..bd25ddc7c869
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD 10Gb Ethernet driver
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+#else
+
+static inline int amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+#endif
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index dbb1faaf6185..ba45ab0adb8c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1061,7 +1061,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
-	unsigned int xphy_base;
+	unsigned int smn_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


