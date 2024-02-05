Return-Path: <netdev+bounces-69247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CC84A81E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CD1286BFA
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BE137C3E;
	Mon,  5 Feb 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kPywawUp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5461137C44
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166173; cv=fail; b=GXVcUUKiXJfOeHdpm0IAGB+PU0ZmG7r30WW7o44IFeDJtydKBmmc3oo6YGZAPX4xnXFJzij0h2FVrAYxCsYVGWn6qShUki+IYDSY9VjmFFnpZlOMvMyaTC6bSMnl0+o5sNh0O7VSeyHcw526CrSdx/fNHoZ9d01hsDeQPkkdYQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166173; c=relaxed/simple;
	bh=bEW8mw5AfO7ISwmVWNz9gQHrxkoZ4Z3DGF4xiRYZ200=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN5dfjM2/eClA8Tx4xN1OvhkjfHl+Ta/jBU1cWvjN4gWkLXwOrdclxV8sxiHkISCh+wtsRpFyVDqztT44Oubs+73+7z/oxozOh4pk7lpndnKpzfolHNFJrZRWL9nIb5M1ACvQbRi6hlKp4X0o9wwZ8+/iCtKo35kKWSLbrPMW0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kPywawUp; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzHkey5ALRq9QecsjYzV7DgK26rG7g+p49dbCpYPtVuAXMc6NcwgFJB7h2WaifVLD9JcwNjx6xgj7DJo1K28BWL6JBAJlJjwM2Po6CCbhi09BroxYPs2rbb8BoQCPnDBoYkZKHSTMWgD5k5ki7kROh8fcLqU4ocfzqfwDyzGtukiw3CkSJC596SIQcxRKyYMd6eXmqqa6avflQ9hcZjX0T16dkwwpyFLtZF5Sf7e8XIFUZNDU9qKL98SO4Vs5yTdycRKkHDFj5EqgtdSWZmxDihYn/U6UjUOnV0042jGH3tRkuB5IfUlHRv6MIV1cak5C0BO4eH4TgCW1LLVOcD+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weM13yM0F8GRVEJVkwqe8DM2/LhMdJp5oyUIcq+nTN4=;
 b=AUQs8W5BD+Xfe23FabdvfCusXgeS5gKM8b2U57QUeCPdih9XoAjeVXqOL64sZRexOdqzwPWNLVU1m2Dz38bDaTsASLNeBadBuFlMb8B3UKTDouHj49x6dScdP5ILXunbsbXJGsTvbzFh3g9PIt0T5UFp1YlhCSH013gcCLzS24AkBoFOFwBl4Lm4M+X9i9Z2aU+E9+1kOWmk1dhE/m5ZlhOAH5IZZ06Wm3v0pg+3WbFI8MjNJe7a8lAu7/5Y81HF84+IrByQd5tfJ1oG1Wp/4Gvxk4qHD38rAO/CfVhemAieNPjRdPXDAtACQmN5GsGHwd/bIIcPQEuHdhRStq44iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weM13yM0F8GRVEJVkwqe8DM2/LhMdJp5oyUIcq+nTN4=;
 b=kPywawUp/4emwLsLmdkrmwF01Fxwuxp75AbInnbdkgQy6JXaVf0UXKPvwSUbDuqFwNHZp9qrNvCgGMCCLHqkCxIW//+++v8DJpB79z/SM9f2fWi8F8hMxgz41vX3YJS7sZcP9n1rl01mAStGml/Me2mhFQqEptOO2/bKHKCByDc=
Received: from SJ0PR13CA0165.namprd13.prod.outlook.com (2603:10b6:a03:2c7::20)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 20:49:29 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d0) by SJ0PR13CA0165.outlook.office365.com
 (2603:10b6:a03:2c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14 via Frontend
 Transport; Mon, 5 Feb 2024 20:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 20:49:29 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 14:49:26 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v4 net-next 1/2] amd-xgbe: reorganize the code of XPCS access
Date: Tue, 6 Feb 2024 02:18:59 +0530
Message-ID: <20240205204900.2442500-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
References: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9763362a-59ce-410c-598f-08dc268bf2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XlB1+vRjKW7gMablF5bRwqLQCSM2XVKtPmZM0lgABatURcdeu2GhiK8pwUzkEZIIQ0FtAOZpT0yTSNCdLAJTndjwh3O8b+gUHDhIomj1DH34rQPUL8EY1q68MP9MAuiIxJLKmZgHT2vpVghSCtA9IkEChDIw2JXkvpZmnS8Soy/dDH6ef9IXmcmm9C5TLMbVdi1V1OdIxwEO35ApNA5jkHPCqxzrw7FiEifsMXp/eXV2ud/7z18PJIV84XvBdt/s/UY7obo/8AyRNtVKkG40qEdwia/2zAIq2YGvMqSRLgAdFx74p0boZ3uJLOXVypy2xj7sog/GkClipWVLpPgo5W4yI5brsMtxARgbDXVbzS8nIaV1hSMFp7IuFqNdJwNuTyFgdY44yp7wtfaTpIYvvs0SPTcd4vwTKb3jCPP1tY2NIYhuzBPyOPqalB2TQrYGGBxHPZUXWNYgMTb82irse0SzKoIa1fe/CkhmYupb2tMLq2o2qwNS9OJzL9Ct8MZLaa3CuA3Iu8mJjN0RBm2r8dN3DY0RyPpzJ/VDK2k2OlSrIuq+EZ9VaF5qoUFGY8I5OlLOraF4+llNpA+d7BEs5qZo0ScbPLmWY33Npk8qv8vy4GCdMKaEqvm6af4Qu2o4CZ2iu5zzfXSbR1vLizjYzev5ZBlrJVm577e0JXLg6jHIHZPJY3fJ5EpZCe+KEnHcmw6y9qngrGcaX+wLO3bkIoOn1Wc63L3bKpuPz+4Sf6RYUZ7ss62UR9MnHgnuUAruxGzrz07+nkYVtmegNMRizg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(8936002)(8676002)(4326008)(2906002)(40480700001)(54906003)(70586007)(6916009)(70206006)(316002)(478600001)(47076005)(36756003)(26005)(7696005)(6666004)(1076003)(2616005)(81166007)(86362001)(82740400003)(16526019)(426003)(336012)(83380400001)(41300700001)(36860700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 20:49:29.2218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9763362a-59ce-410c-598f-08dc268bf2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Also, the xgbe_pci_probe() needs
reorganization.

Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
access. And, convert if/else statements in xgbe_pci_probe() to switch
case. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 62 ++++++++++--------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 +++++++------
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 ++
 3 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..ac70db54c92a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1150,18 +1150,16 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
-static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
-				 int mmd_reg)
+static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
 {
-	unsigned long flags;
-	unsigned int mmd_address, index, offset;
-	int mmd_data;
-
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	return (mmd_reg & XGBE_ADDR_C45) ?
+		mmd_reg & ~XGBE_ADDR_C45 :
+		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+}
 
+static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address,
+				     unsigned int *index, unsigned int *offset)
+{
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1172,8 +1170,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * offset 1 bit and reading 16 bits of data.
 	 */
 	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	*index = mmd_address & ~pdata->xpcs_window_mask;
+	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+}
+
+static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned long flags;
+	unsigned int mmd_address, index, offset;
+	int mmd_data;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1189,23 +1199,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
-	/* The PCS registers are accessed using mmio. The underlying
-	 * management interface uses indirect addressing to access the MMD
-	 * register sets. This requires accessing of the PCS register in two
-	 * phases, an address phase and a data phase.
-	 *
-	 * The mmio interface is based on 16-bit offsets and values. All
-	 * register offsets must therefore be adjusted by left shifting the
-	 * offset 1 bit and writing 16 bits of data.
-	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1220,10 +1216,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1248,10 +1241,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
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
index f409d7bd1f1e..18d1cc16c919 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -274,20 +274,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
-		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
-		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
-		pdata->vdata->enable_rrc = 0;
+	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
+		switch (rdev->device) {
+		case XGBE_RV_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
+			break;
+		case XGBE_YC_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+
+			/* Yellow Carp devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* Yellow Carp devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+			break;
+		default:
+			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+			break;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index ad136ed493ed..c9f644ecb1b5 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -347,6 +347,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* XGBE PCI device id */
+#define XGBE_RV_PCI_DEVICE_ID	0x15d0
+#define XGBE_YC_PCI_DEVICE_ID	0x14b5
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


