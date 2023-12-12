Return-Path: <netdev+bounces-56249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFEF80E3DE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682E51F21F4B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C91401C;
	Tue, 12 Dec 2023 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSmLQjIu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE89BD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T35x95L6393b+Muf+FbHbUPt9kOoLKDF38rzVk6uCeH/sgDuBQmujHURP58/sgZOC1Yg5bxbC3I09jyjcnhZmAhxuaunssg4K1iUs8fuLjJZVGpCMjdOhNEkyr216vN2apCODuzAj0koDXzIWx5VoyJR42N1ZgmCfhe7jdT8rUYMYYDs+rf0c1DzcUTdj+twMTe5lzNucMSb00LwN77Y9/iSHHSjIEeBz+l7off6/OlVx0gu9m5sbCpUbFuvmw736TaPxoibbruarQyEFIJZbqd8oHyZsdfTrm/6gF9JcHe+W+C5toCTGGkEw47kRp/HaB0wPvEnrm5Hu7Kvu6LQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+gi6HJ0CRXW+MF0pdeY4oEs6QSk+FX4m4vEteSuhsU=;
 b=Uv+Tdqp482AJIRq1fUPnzJzAPl7mtQcBzx8PrupQ9DBygi71dBqKyshoeLua3C8sQZL/UAwDRFDorAX6N0yzWElP2tQau30EEtUmyu0lE6Xn6+u6KSV4Hxxp906r016SAyriRLu1G3dTNlrrhuC2710/JI5E7QbOBhqzAb+AdjnYVGgkTjqzgimscUjmmuOZzssE38MI+1ZOEgb9XuX5tPoOEmyUYZdwPzqfqzknHaBUPNPbuYKo+3eUeymoMUVbYdPBNBRht/RoP9Fmuq0vcSCXUI6aUIYOM5TnDz/Mu+XSG6MaZRhgcFztW6Rp9XkcrZAHGSz0LT6tGinmb6DYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+gi6HJ0CRXW+MF0pdeY4oEs6QSk+FX4m4vEteSuhsU=;
 b=oSmLQjIumnku/Q7CZ9ZYf4DibTxFYBc209nHbeCN6h/VUHXTgLYhQoRn+lR+IrFnw/CWVRAx75Yb59WjyWx3cZxTaFsI2gsPMi23do6OKZf9Pu6+uxhSeQxx0Qe/8el0en3GIuZFCOYcXGFIute+wCPXwKmEFOjiQ2z/LSvgEVk=
Received: from MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:38:09 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:23d:cafe::e7) by MN2PR06CA0010.outlook.office365.com
 (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 05:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 05:38:09 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 23:38:06 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH v3 net-next 2/3] amd-xgbe: add support for Crater ethernet device
Date: Tue, 12 Dec 2023 11:07:22 +0530
Message-ID: <20231212053723.443772-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: ae371f31-bcba-4a72-3a4c-08dbfad48646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ck2JpZaltd6Wo90IXf41d0jw1fOdu2ivbIoYspBMM3DB/WZV9C4TNXUjTgdsjsfPaOIDJFrgh5HaSKjFjLpUIAGiFEYJjm/QeDhWXSP8oddRBqvCXmCDOSisaqaOu63Qf5l9NKOa8J+Wo4h9s/yaEjUC5t4FVqOJMSuqMP8O6uebQcfl0m7XyL0wdnLQ2eXe77iYZ7WN4kj4R+zlXsWrE1571/tXuZmCZCr0H28gtCiqhe0wEf4Z9bCkXQQVf/yz204jAUgWFyJUti3oPF0vCc2qs49AqyvU4Qfuu/ceYy7+GXAJSJmD044FPH2K7ZiCaQebxQ4WuQaDj+JXxXf4v3Sz2vK9YDAKPx3Cfv3+5hnT4YHX78MNZvCHeP4Yau6NqLt8/agU0t3gcxh3BOgiArp1Pv5Z/7Eg7RwS80KL6+oSzYdluxhKrjzLuvlgnXUKR7WHehVNjVXgwKRNciwANYd5a6t5qtJirqS6g4T4EgTCgLIyGWG1Wbix7nlxeB8ilH4ILWT4aCSSopF5ueKZfSXMxMW4iqnWco7q6hU/8kBDVR0G/suKtdDRwnMtQV3Vak8Ql0fppI4ac0k96MBwLku2s3BwmKuEVKbVl1IF59qs4R9632V2uimxG3nnU+Ld2XkqZEq0clhRvD9FryVUHLOq9qXmweP74a0VUYuH9GWgFVTRrmJi5kaZQGqJNUXm022EwE+CvjfJyAgeza2YodLLevkvwnVlfWUsVVxHrkDNw4TY7T4WP5+uvrzN57TPnfEGLp4y/7K4NkLxY1epBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(2906002)(82740400003)(356005)(86362001)(478600001)(81166007)(426003)(41300700001)(40480700001)(6916009)(70206006)(70586007)(54906003)(316002)(6666004)(8676002)(7696005)(8936002)(4326008)(40460700003)(36756003)(1076003)(47076005)(5660300002)(36860700001)(26005)(16526019)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:38:09.5348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae371f31-bcba-4a72-3a4c-08dbfad48646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the pci_{read/write}_config_dword calls. Also, include the new pci device
id 0x1641 to register Crater device with PCIe.

Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 93 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 35 +++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++
 4 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 3b70f6737633..e1f70f0528ef 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -900,6 +900,11 @@
 #define PCS_V2_RV_WINDOW_SELECT		0x1064
 #define PCS_V2_YC_WINDOW_DEF		0x18060
 #define PCS_V2_YC_WINDOW_SELECT		0x18064
+#define PCS_V2_RN_WINDOW_DEF		0xF8078
+#define PCS_V2_RN_WINDOW_SELECT		0xF807c
+
+#define PCS_RN_SMN_BASE_ADDR		0x11E00000
+#define PCS_RN_PORT_ADDR_SIZE		0x100000
 
 /* PCS register entry bit positions and sizes */
 #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 6cd003c24a64..a9eb2ffa9f73 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -120,6 +120,7 @@
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
 #include <linux/crc32poly.h>
+#include <linux/pci.h>
 
 #include "xgbe.h"
 #include "xgbe-common.h"
@@ -1165,6 +1166,92 @@ static unsigned int get_index_offset(struct xgbe_prv_data *pdata, unsigned int m
 	return pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 }
 
+static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	struct pci_dev *rdev;
+	unsigned long flags;
+	int mmd_data;
+
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev)
+		return 0;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	/* The PCS registers are accessed using mmio. The underlying
+	 * management interface uses indirect addressing to access the MMD
+	 * register sets. This requires accessing of the PCS register in two
+	 * phases, an address phase and a data phase.
+	 *
+	 * The mmio interface is based on 16-bit offsets and values. All
+	 * register offsets must therefore be adjusted by left shifting the
+	 * offset 1 bit and reading 16 bits of data.
+	 */
+	offset = get_index_offset(pdata, mmd_address, &index);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
+	pci_read_config_dword(rdev, 0x64, &mmd_data);
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	pci_dev_put(rdev);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int mmd_address, index, offset, ctr_mmd_data;
+	struct pci_dev *rdev;
+	unsigned long flags;
+
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev)
+		return;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	/* The PCS registers are accessed using mmio. The underlying
+	 * management interface uses indirect addressing to access the MMD
+	 * register sets. This requires accessing of the PCS register in two
+	 * phases, an address phase and a data phase.
+	 *
+	 * The mmio interface is based on 16-bit offsets and values. All
+	 * register offsets must therefore be adjusted by left shifting the
+	 * offset 1 bit and writing 16 bits of data.
+	 */
+	offset = get_index_offset(pdata, mmd_address, &index);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
+	pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
+	if (offset % 4) {
+		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
+			       FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
+	} else {
+		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK,
+					  FIELD_GET(XGBE_GEN_HI_MASK, ctr_mmd_data)) |
+			       FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	}
+
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
+	pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
+	pci_dev_put(rdev);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1274,6 +1361,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_read_mmd_regs_v1(pdata, prtad, mmd_reg);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
@@ -1287,6 +1377,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 8b0c1e450b7e..db3e8aac3339 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -295,15 +295,28 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		/* Yellow Carp devices do not need rrc */
 		pdata->vdata->enable_rrc = 0;
 		break;
+	case 0x1630:
+		pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
+		pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
+		break;
 	default:
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
 		break;
 	}
-	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
+				   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
+		pci_write_config_dword(rdev, 0x60, pdata->xphy_base + (pdata->xpcs_window_def_reg));
+		pci_read_config_dword(rdev, 0x64, &reg);
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
+	pci_dev_put(rdev);
+
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
@@ -481,6 +494,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	return ret;
 }
 
+static struct xgbe_version_data xgbe_v3 = {
+	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
+	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
+	.mmc_64bit			= 1,
+	.tx_max_fifo_size		= 65536,
+	.rx_max_fifo_size		= 65536,
+	.tx_tstamp_workaround		= 1,
+	.ecc_support			= 1,
+	.i2c_support			= 1,
+	.irq_reissue_support		= 1,
+	.tx_desc_prefetch		= 5,
+	.rx_desc_prefetch		= 5,
+	.an_cdr_workaround		= 0,
+	.enable_rrc			= 0,
+};
+
 static struct xgbe_version_data xgbe_v2a = {
 	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
 	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
@@ -518,6 +547,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index ad136ed493ed..dbb1faaf6185 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -347,6 +347,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
@@ -565,6 +569,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int xphy_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


