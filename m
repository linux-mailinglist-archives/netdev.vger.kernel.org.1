Return-Path: <netdev+bounces-48345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552047EE202
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851FF1C20965
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D530D1F;
	Thu, 16 Nov 2023 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f33fZSXU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73AFAF
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+U2yqOcEjcB973w1JMAUIykdTATIyu+/nABi6+hJ9vx0uaT/mNEMV6n5B+d8ug1GuiBG5AYi3WjCYO0L8Ax0XnjkDo2U1Vy0gne4HMuySvOZiEGycy2oxbe8FyGFwPeEUnoyaCo2jLuWcgXRy+lY2jVWtsfi2vB5ilxaRCKiaiyr9ltTl+FA4ROpMXz9A2ow9ZhpwRU4IZ59TI3YQ8PbJU6mHjgK4k9KGbX9hVAu96m+IgJN1I6kOj3T/v0U/YRJR58EhTO+7jPT32s0l6BFDNzOHDch97XCPKVPO49EPalnX46vbEaEoLux3+dHBdmAP1RDKLSDFekjxplbUzjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3K3iMB5M26DcsU5imyaC6mQPTuFGkiGuE4tiAeGmAI=;
 b=lVwoW14Z0Qsh6jo9GEKb1o+q+3mcVLIESh+rrtcYTH8WUQjzStTK5/kKb13TrWj8MPDE01ZEkg8Et3Cf4PyUEvSaY+wyn5URJSkeAt+PMSnbmI1wYhND0rh0suwlSVnhk++vCIESo8XN+YVoIXBYAS4pbPaMlGy44e9h4f0AqkOaD33bicMeJcjXqxwKSG2Oe2RHJKCm2TMyKC2U52T62jiii2ajqFTFrAuDhKIm2GagH7oqDvJwN1wP6wKbVsRdMW/B0qVKugl/Rh71gzHkdAjPYLc+NnZyytMwvLZd28SGxpVZJfdt5b5ExA6+PO98DD85ACCS1bcDhlfelQbEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3K3iMB5M26DcsU5imyaC6mQPTuFGkiGuE4tiAeGmAI=;
 b=f33fZSXUKBM9MKoJxfIwytwDtTUlyV9BNJ9J8eUuuwNbcdeAG2UBaUgXcxdvyBKvfjapGC+PkvbkeaeHKw+AQSBdRh1zJ3m7WjpjbAzRAlgNGQ2tA+CNMd1J4hSSRBudUQCBai8pdVGw2gE36afSorfoigiVyHpbhZkI/CMALd0=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:55:46 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::7c) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:45 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:55:42 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net-next 4/4] amd-xgbe: use smn functions to avoid race
Date: Thu, 16 Nov 2023 19:24:16 +0530
Message-ID: <20231116135416.3371367-5-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c370c28-be3d-4a02-2ac6-08dbe6abbb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fl48Uf/oFrBh3PI8B8p3mFCAG0B2h5LLEXyjXHRElYJU+MH1vBmgv4ClH7dzKclWXgfgYGcZZ586IlVageCaVTf1t7yvrRgy/Tke5/Gb2vXEVQfjv9ULrqYiCymj3X752aRLefEVKt4tFVKAuPk7aOi3NrQxWjE7utWdVgDGsTxmUa/O4/TvHe3wmtWyPammh7vwb8EywXTPLL/MnBoSzlWTlyzFMyO3aNlRNoTxx9cOEThwEawoZ67aUgyWQ5T0cTDsFekIr6GDmZIluWBEe/AP5ysgm3+vntOEkAidW5OOBdZrAGT/v0+jUpdYsZeUtzFVHRTR7TZUJVJksiSfjglJbRo2KebNaDHSkbzf/X3AXJxjhrqLDnMB8lPTCjfX0S1IVIetZ23wYFDHyW5I6J4nqchvJi79wedrImOgl2ICMZzc4KOyKI2L5k/4wMOUXxM+fF2C6JkasbkuHFy5HgwuoUzzdifRY4k3tQ9eqmflrB7C38pBE6R64tYEW1YM4zStOfoD4dIYuCr9wERysVamExi+hTLZuXAQB5+Rn+S1pf3PncrT4t7uVTx3ay9ifeWDR/nEexWSuXl06PnTu3P6FmMYK/IAVMuVaBV0HuDsYCCgJqT6RpUR27CbWG7LSc+FbBOlloszFAlCOL177H7Jql7gJLPXcOD4PiSWowLOSIvO+9TudTO1vYxKB/IgElpN3aWifkVH2GlAwtG9v8KzFgFF26Jd8YcpBl0XuPU+2f0cD0KK4b1NT5EGuVauOlpbZAq5UL5puZMznFXg+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(86362001)(40460700003)(36860700001)(81166007)(356005)(7696005)(6666004)(47076005)(41300700001)(8936002)(4326008)(8676002)(1076003)(426003)(54906003)(70206006)(70586007)(6916009)(316002)(336012)(2616005)(82740400003)(83380400001)(478600001)(16526019)(26005)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:45.9981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c370c28-be3d-4a02-2ac6-08dbe6abbb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests.

So, use the SMN calls to avoid the race conditions.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 36 ++++++++----------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 13 +++++----
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  2 +-
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index a9eb2ffa9f73..1f43456442e5 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -125,6 +125,10 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
+#ifdef CONFIG_X86
+#include <asm/amd_nb.h>
+#endif
+
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
 	return pdata->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
@@ -1170,14 +1174,9 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
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
@@ -1192,13 +1191,10 @@ static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
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
 
@@ -1209,13 +1205,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
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
@@ -1230,10 +1221,9 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
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
@@ -1243,12 +1233,8 @@ static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
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
index 5496980e1cc7..3e2a5bb694e7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -122,6 +122,10 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
 
+#ifdef CONFIG_X86
+#include <asm/amd_nb.h>
+#endif
+
 static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 {
 	unsigned int vector_count;
@@ -302,18 +306,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


