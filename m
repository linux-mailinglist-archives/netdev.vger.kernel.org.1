Return-Path: <netdev+bounces-48342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1E7EE1FC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E681F1F242A4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F630D1C;
	Thu, 16 Nov 2023 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NAEkW7U8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF59A0
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:55:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/XiKGQQjMImROH3gWQeLvLLeYxWztwBvxTM1TwaboumRs3KaWfDCVkniWw0adc0cil+F5LCVUoxGq5P413VzYz1mm0CSDOVrQbIJICWA5mh+Qi0qT4DQTsrGu2TCz2L1riQycdK68G5/tL/VjXO4qQJaQT/1I9znQeD/UKE+2YFEFuV33HfloqlaYwGvwmZLJWe1qGfn7qSmLFCKEcLqEpkCd0B8CQRAL/5PaPy1x3EHjvHcigtNm2rvsec34dhA4XWBXataT/s2Iudh4+dIYIXlRIF8YHHLxYa+0DY3UhR+WC0GE0yr7Myi2YbGleI+P36hiAMkwBYWtWt5pQFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DC9SX0PvfrZHW7Bktp4cX9Rg50QGsmhjoC2NYay1lQ=;
 b=ERd3Ns1xCgCaLPC5Vg+oDqjfOnG7M7NGqaSz9bbJIHiV19Cw3k4xY7jHENvXRDdGyVmfmuBajTMW4IrLZNybyg1YjX0ZmdS2/yobIQ8aOlnNCLCGCUqxIztyRBcMBd/tDyvAJ874IxS388el8Qru47wq9VbjtAMiXK+ypy0OyQiJrobnJMl/xgFOjiWUbcNr3gHCM3SdOaFHbELsJQJsJcRkWYSQe2oZ+4Z2u1lSm17hLqTGxtzo2MzbElLuQJHraAhqvGjsKt9d2oM4Tdg/MZUCwXgSYwSdQI1iAxFd7R8c5lo37rwr4EQv9gSfJwQ4wZUn2/A5N7+GUkjxKNVN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DC9SX0PvfrZHW7Bktp4cX9Rg50QGsmhjoC2NYay1lQ=;
 b=NAEkW7U8puPilT59Di4PYmND1P0q+qKfiaczzVSvi0qiwn3vGTbOk+YHxsu6v99seZu1a0th+2hwaY27rlWMFVs8FpHBxcNBEAhiGyI/dc92/V1lGDjE/AusRF/KKdxkgXBnZYUc2YTW+Lq62x+i/Nl+9WGSOhtN8AmsO1W/jxg=
Received: from SJ0PR13CA0172.namprd13.prod.outlook.com (2603:10b6:a03:2c7::27)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:55:28 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a6) by SJ0PR13CA0172.outlook.office365.com
 (2603:10b6:a03:2c7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:28 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:55:21 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net-next 1/4] amd-xgbe: reorganize the code of XPCS access
Date: Thu, 16 Nov 2023 19:24:13 +0530
Message-ID: <20231116135416.3371367-2-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed8fefd-4385-46cc-b9dd-08dbe6abb117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ZgieTEwwtclPXiPH4qU3rUDQC1f9unTJ+xOCENRjoZsD6bQqLIODJ6ZvmpCekyvuOq0w/TwcN/oD/4FUcLI+OVtaovr88/3vuPlyWcLpyWD8+9XXsudszfHNmHTNohw/zjTtLKthm42L3asKpCrrxdfQXEAEIWBTAHyQTYTemx6cxhQyvmZZOZwRUnYStxWTIPyyT1MAK5gOtDh88msZufgZoDoDnbunsN8dB8U4EvxlroupXOFBibt0IFb9kju2J24ZOo+7Bnwma6Wqi5zm496ESUOrvLzsWfMFba/Gl11/IYG9t/QRHMUez61Kbk0UE/SGqz3tuDz6vn676/uYOBWe4/tgnjsOMxZ2fUnNSjXlG5rhrZY33Rs2AQlXhbkTnqkfmUcfYnu3zMvBRYXztJFgCVnvPX4LKdnBZ1II4D1odQyl0UKunZQEWsryVPfbEKE7KU9KzyFlMbfLlFiLkCtefOveItaihi2UQOOBz7ngRD7NmoIripfJMehh6hmqtV1yz4nTzemBqtChB2bmUazFSZbynt/n8nPHUlA/DJXZJMSGz7Ur5+KoKinaR51u7oORXD+W9rn6sGqsZo8K7zr1qXMkJCsDbTRtxxmETdKuDW3jjlew/RtN+/vChoZJSDJ5agoJFvBqQVZVZuNlS/TMOtbdeXdf9RjiJww3lbmU9JlX5WBdjn/GA5s5zTE/Kuw1Fer2aTvWJXHJNroG7Dm5JMSo9BOT1NcvboIHBYQa5VzEcTXdrSyAqa1U7DHWLFggEECHwfUnO/jruy7pw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(336012)(82740400003)(426003)(83380400001)(7696005)(26005)(16526019)(6666004)(2616005)(1076003)(316002)(6916009)(54906003)(4326008)(70206006)(8676002)(70586007)(36756003)(8936002)(36860700001)(40480700001)(2906002)(41300700001)(86362001)(5660300002)(81166007)(356005)(47076005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:28.5162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed8fefd-4385-46cc-b9dd-08dbe6abb117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Also, the xgbe_pci_probe() needs
reorganization.

Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
access. And, convert if/else statements in xgbe_pci_probe() to switch
case. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 16 ++++++---
 2 files changed, 32 insertions(+), 27 deletions(-)

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
index f409d7bd1f1e..d6071f34b7db 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -274,12 +274,16 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
+
+	if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD))
+		goto err_pci_enable;
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
 
@@ -288,9 +292,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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


