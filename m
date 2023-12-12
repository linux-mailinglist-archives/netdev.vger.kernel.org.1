Return-Path: <netdev+bounces-56248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C193080E3DD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B5282E26
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52131154AC;
	Tue, 12 Dec 2023 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XQIo28f9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD17BD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAGoasdLXYcobqf3bHami9i3iGjGMa+SK4OEnvAir2107Mz66l6VGBiN7AAtjsELEA35asbiu7Tq5pLWa+6qvwEc1o4IoR4oEwFA82u47V4SaXIZZQfT2iUATiWKX9krNW8YfsZ9iSwoZN87HzajTtbb9BfCzbwpuGBh08OykC00kwrfNycOKBM3WLyVrPra/jzWJtSIpFKHKWt7GH+w7Yg/IQKM1jCdpfGGqWJdBQAsRQIETm9EBcFIHu9+zl3PXvwf76opRkF/7bUtIgvJgeYJ6fZPFZFYRBejacXW8rsa4UEC/qa2/BNhntIfEIUqXlRITpmjdwUita4lH4N8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX1bLFse7qYMO6Cjxztq7RrtzgSwKFxi7yGq443qcBY=;
 b=f4ALIl6rKtjAe6tp/yUFMw4T6DE+iWVTRlDR/ND/q/AapX+OnqlQbURtjOELueJDlCC5uASdQEdUCRxxgj0URVoKOX416OZJ2g2/kgM4LnrYUtHgwNhG2Yhco7qUjuTNyvldo67r8n+/WP0D5lGQUTWjyZ4H4V6fkGLV435JywsMLPWzIAb/lGfMTO1Xwns78r8sOtj/ayPlXkjdVg0E0BAjW6xH9azMsk6gBTPcgV7Y9RRmoLPM19n7zIRTvKN1511x4rJQX3g0Xkx7Fs8oSsg4mkZLaIFDOI9g7rdhIHluhYl4ZulBHdCtMCI4xGMp/o36+aWGw5DCRFHN3Blxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX1bLFse7qYMO6Cjxztq7RrtzgSwKFxi7yGq443qcBY=;
 b=XQIo28f9gt71lUo1Yez6lXTpCdtPYvBLgmaugV3LoHbSUaRDcG9u38anq4uA02kSZ9rOlNMWalYb5dWxTGsHvG/Z++PnAAH2z7g0mZuK62JAVbI7CJg0CUIq9i4tleunZ/0hub34uhC99GkOg5ZpycwbKJjh9gauzgotuxd4Ouw=
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:38:05 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::73) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Tue, 12 Dec 2023 05:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 05:38:05 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 23:38:01 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 1/3] amd-xgbe: reorganize the code of XPCS access
Date: Tue, 12 Dec 2023 11:07:21 +0530
Message-ID: <20231212053723.443772-2-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: b645edc1-11ae-478f-3f4c-08dbfad48408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wFzHbQNIureCEXDZC6r6F2Vbc//As9+GP6BjbnIcqbHUvZjTTxo+LjQclxcNobDayZPL4JgdE73ncMnQ1FluJOjduu7hsp6n79fLpj6ALeOxEhhINkmyu/EEXoVcVmYgaMVNHwGukwxKZuL6i1v2zrAwCDFK1yjooRx7wUF9kGY1h0Ht09XFfbaCzrc9EJsjOXRhmrfDaVMkRwABwfuxcBxLlcFaMyFpNRmiV3tLp5WJTn05vXWL1FH9Dw2LBjX80s0ojnjvdZ+viEJNo6hEXmRa7dFSO5viAO9YXT1G+0nnGoUyM0LgAV596XyPOwgNXvLnLocw4ScBAd2XZN2Z3DX1a57a1bienYrF/GSbOVVpggXzFGbHQHl1ppW26prJeIGJWtY+MFSHRmEplhRS96YSC7vpgqnGRr9Sx8BafG5/DRH7URxLgZkx7wscPRu4jEGG65o58kCe6pI4FTaNLQzlVLD44hnh3PDkvpwivoiVKD57toNBBifVHLYhfSFX+FOGQkmctJac6MkE+dGmGzXXu8Oq9cuwPhw+BE8ua9dNqd/sGhJy9KEWT5TCvcmNyqSsErdPnjf7GncURPDZ7EH6IUk+f9MwQx1RuRXvv+Rb/Fu3LM0I5/JTYDTR4CWq2LSuO3HO1nNt+aPsQAqDxv3dJd9BsKax2PTYgnMEDL15Fbxik6Y8i9ZbIXd9v+bu/D8qzynQ8evpugfYzruTfyQgJ0YKwUGdzOOtbFt8/k5NuQhJBuSMOXurr2Lb1MuumbQEYl3OFBWp7wM7R30XVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(26005)(336012)(16526019)(426003)(83380400001)(7696005)(2616005)(1076003)(47076005)(36860700001)(5660300002)(4326008)(8936002)(41300700001)(8676002)(2906002)(6666004)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:38:05.7732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b645edc1-11ae-478f-3f4c-08dbfad48408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Also, the xgbe_pci_probe() needs
reorganization.

Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
access. And, convert if/else statements in xgbe_pci_probe() to switch
case. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..6cd003c24a64 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1150,6 +1150,21 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
+static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
+{
+	return (mmd_reg & XGBE_ADDR_C45) ?
+		mmd_reg & ~XGBE_ADDR_C45 :
+		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+}
+
+static unsigned int get_index_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address,
+				     unsigned int *index)
+{
+	mmd_address <<= 1;
+	*index = mmd_address & ~pdata->xpcs_window_mask;
+	return pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1157,10 +1172,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address, index, offset;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
@@ -1171,9 +1183,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * register offsets must therefore be adjusted by left shifting the
 	 * offset 1 bit and reading 16 bits of data.
 	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	offset = get_index_offset(pdata, mmd_address, &index);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1189,10 +1199,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
@@ -1203,9 +1210,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * register offsets must therefore be adjusted by left shifting the
 	 * offset 1 bit and writing 16 bits of data.
 	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	offset = get_index_offset(pdata, mmd_address, &index);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1220,10 +1225,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1248,10 +1250,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	unsigned long flags;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..8b0c1e450b7e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
+
+	if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD)) {
+		ret = -ENODEV;
+		goto err_pci_enable;
+	}
+
+	switch (rdev->device) {
+	case 0x15d0:
 		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
+		break;
+	case 0x14b5:
 		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
 
@@ -288,9 +294,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 		/* Yellow Carp devices do not need rrc */
 		pdata->vdata->enable_rrc = 0;
-	} else {
+		break;
+	default:
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+		break;
 	}
 	pci_dev_put(rdev);
 
-- 
2.34.1


