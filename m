Return-Path: <netdev+bounces-48343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40F7EE1FD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D71C1C20A43
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601430D12;
	Thu, 16 Nov 2023 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WMBKwser"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE4A9
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:55:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp2ba3PlL+agVno0VjAfI/cikG/jDMMQv202IPRWH/p5hXJ9EwmENxqNDZ3v039i59r0FM9ZGuRejpKkDTjScYfJ9N1kfZoWp9z9pjSbkT4Feen12mH2jw0kzcLsr2WTH0jOyRXcKPlujQQZ6Shk0Hm0hnKvWBWrRfpt6iNJbIqCAw2qUaG9AMZuqtZPC0P/g9ZgFQM7pH8HzU50AoccsJgpeGoPv/7KDx+4COAA5FyvrH1DgTKgOJczKDzjjsRRrTLMkhu/cYJWb+NS3f4hEZ3xJI3+OgeI99ZvBsmEw93lQzZlw2GEcrDJgFIpCh2Yz1HA+4YlMCYjq78mUJCChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7jrRgcd/HjIoI8WYLwz2gXw195xM6IxUxyClPMWOBY=;
 b=fgArs83RRDeq9jXZGcfixo5artgR3099bvLh2/lgqAPtJyr5VxnYNrRWhq0W0WqFR9CcQEnVu/hlw9a/7in8hnkrImFR9DDln1liuqr4T3LC5tcDVAWlzRvKaUpiwkoq+IC7jfYCmFPBxDi6YlgknxGhCWCRPeR/seSTakvH8S+OBsKNGuywtFKoWQdBwqXm9Xd+FNOvXq6s+ZV43uKXaGAnSPZltgyLcRYqvm4xTm/W2A/BKX3n+x7fhfdVCclQYpYqsEU2hNDmRw/IeWSdG9n5VAZzbpE0Df+XGt76cDblB5b6PZum1ZP2XZ73k4yEkPwGU+Y+e18lA74d/T2UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7jrRgcd/HjIoI8WYLwz2gXw195xM6IxUxyClPMWOBY=;
 b=WMBKwserjoTZZED0Lb/7doWTnbLELj9kAxEkIXYDPQUpsAVOgIG0lAE4lf27ZnIX0+zipakws2Hm1D1HTayma1g+bOGv/56ktLpwsCAw0xuqTT6trgLQXD0SxBviFbxPfg+9gewoYoJVW6Iu4Lel1+0GLF8ffMZdrkIN6bvK4Ac=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:55:33 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::95) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:33 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:55:29 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH v2 net-next 2/4] amd-xgbe: add support for Crater ethernet device
Date: Thu, 16 Nov 2023 19:24:14 +0530
Message-ID: <20231116135416.3371367-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
References: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 566906fd-1225-4e4f-6c7e-08dbe6abb3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kf76Iowdtd/mTmTFJFdQ2wGmS50MlOMpJgAtOz8sQYTg1lX1xLGfnGomnNKiH3XuqCUlF0DpBLC8GnARK+yv6DHrjNQwkaPfTMonPwqmEpJCSjU4pMqKnCArV5eQC5KEcQiFFgbt5gvWpQg+5x0peZJhBW0NWWABeqhOwKMxhhvt7REIDZ1u9P9vMKpEchZpXME2pmCcvMjWGuOg1nT3D1zicvFTQgy+TgLIVTxBmbKuUMUdXaFNhb0z2TGcxAHiMIlFkcvayirD2sZQ+o9h1l1JwYMHpfdnQ/LnLHcPdaT6vyNvaplI1mBS0hVJD2z2pYv3ImJUdjSAkruugLYuhBz1rf4k8KVoXoTg5SkVtrSCa0O+m/J5tGqHsQHm11DIvqkY83a6ePm2ktZQTa7pQtaQRVA5h2C06YoSsuiVoacvLxoTX2nTrxz6DoI/UuWQ70dabKsQ0XtYPrUax0jz0OCk4zGyvgzZQhGaExTbL9n2fupuweCO5lABR70p7rirEtYEutcb0cYdqzje1Qd9rMOz4/3Tf9Y6GwirmwXuL3g0Fegov/P03O2iN8YVVn8b4+pGLKVg0heuOzocjCOTScoUCb54nbfDmJ8dTUQKZFAeo46nyVzZToQLqlyfzKDRX6bsg5c82yvVfN1Laa9N2/aELyVfRMAv1H3CHR/YmGT93xeaRUfj/NiMAb2kN9x9kFRRPEC5GSMNnqouQmeMRLI4guQcFvqbt/Rf+WZ9XjkR6iT3Cd90cBHVSSFt5owz7Utyi4e8T/yuX36/pGGqsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(336012)(6666004)(83380400001)(2616005)(1076003)(40460700003)(7696005)(82740400003)(16526019)(26005)(6916009)(316002)(54906003)(70586007)(70206006)(86362001)(5660300002)(41300700001)(2906002)(8936002)(8676002)(4326008)(36756003)(356005)(81166007)(40480700001)(36860700001)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:33.1270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566906fd-1225-4e4f-6c7e-08dbe6abb3de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the pci_{read/write}_config_dword calls.

Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - New XGBE_XPCS_ACCESS_V3 type has been introduced along with the
   xgbe_{read/write}_mmd_regs_v3 functions to do the Crater device
   XPCS handling
 - Used FIELD_GET() and FIELD_PREP() helpers

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 93 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 33 +++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++
 4 files changed, 135 insertions(+), 2 deletions(-)

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
index d6071f34b7db..22b771057cb8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -293,15 +293,28 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -479,6 +492,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
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


