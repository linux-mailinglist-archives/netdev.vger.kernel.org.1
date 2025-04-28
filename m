Return-Path: <netdev+bounces-186465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130ACA9F40C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B381A83EE5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B1126FDA7;
	Mon, 28 Apr 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KJcVEsAz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D727979D;
	Mon, 28 Apr 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852619; cv=fail; b=Umx/LmmsfXsPIvveCr9NBxoMWZILIcZKxmZnJEHcwMeXehhyTHViFmQMrDbKoawh00xNmwQs8M0JSfpTRWL0daZ/pAupCOrVYyT/R2AG8C+N8Pe/D8C3WPohefOKbwOCu7sFGXX5/qHsYBjIDRQplXeTbyQv647im+g+B4+v7DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852619; c=relaxed/simple;
	bh=q0cU5Z+YRaXcdqMmpZOfeDGma4FMsAA/q0/6w7m6nME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVcROZhl0Jtr7+hyixLoCKqOAM9vXynFL72CzfvUE1Ad8m8fbv1D6erYUfzNAAtbqgrSKbFEHJNSTmYHP1MnrdsEHIJ6hecYSNm7JqTlSkrgLibg5hk3kLrJ7pULnfcF32zyrogZpUTU6sKrawlWS2HVBxg5k1ldUrdF6f+BE3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KJcVEsAz; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXuFAFTL1MfuaI9Awz3/nEpRskHr9xLuQf23K9XUbcnrKPQ1o3WJwrgTYrP+5Oy4MnqGcPv9UI3oZieHF/2BAyCs5csztu5qSN1tH5VmF2Ady0Lp7m9dZG4N9lFv0e2EGlonxbf/xKL4xbuDvtS34MfnnfaA8uihgucto3l95z8H2yfomuU04/N2ILCzGQGeuLysv2gjnjgSS8tk9d356jL8mvbmp3X32kxbGEzhW614qeLHiPIAi5I1a2Hz6mzLkTdBIfiS671E/LGd06bwm95OZp2soi8qmcQWZmE8ckhVNyUP5ytUfOPyHgt/0R0U7lq4kqCT0LMUagFvbu4tvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gteq0E/w+FmmLlcYW+gOBXaRtezpWB5jc7wG0Q7WiHY=;
 b=Ewl/bEtEpxL3bvl5oiatTrF0Cds2LLiWY5pI6Ne8Ka27lLqnysAR/LsnNUJ2SLnSQAr5xMBUppkKVg/VrrWH/h98cqAqeJ37He1tbiy2Zckstdbs5urErZ/Srua4asCfJG7MkbIpC+t/QKfSXzgdkYQV5yOOqskC9cA6HPs/wKrd62cRXog934T+WsWKv50l2vY7zHsvxnu6dcTqSs/+K8cyeJbysuJpaiEDsLzCbbhkQ++E2NOuvXr0EZB2KJ+/c72SNQcLGnovMsP/jLoKqqxl/VlP7f+ouKR5REsWjwx4P6KD83nvBrrSHD2Onx8clz0oalWWeupMRKjw+RAd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gteq0E/w+FmmLlcYW+gOBXaRtezpWB5jc7wG0Q7WiHY=;
 b=KJcVEsAzwlUaDUr7SV+QAVpHtgCDgnYJFNdVEF1Kn4W18aSyAdQbG4Iqj4pjr0IbF8SKuLnFEYs0Xy6+Jm+cigI6FY9Com1VFcRosCXi7ONCYJ6nuYnEth2F02ojfiBMaHp0xu3gh1pgs3sWxNwHK5JG/Q042pml+wYxOOhI3f4=
Received: from SA9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:806:20::30)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 15:03:33 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::38) by SA9PR03CA0025.outlook.office365.com
 (2603:10b6:806:20::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 15:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:32 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:03:29 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
Date: Mon, 28 Apr 2025 20:32:34 +0530
Message-ID: <20250428150235.2938110-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7305e8-2077-476d-47f8-08dd8665d7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?992s2XB7owPEGE1DBR+bOzyx1hIeHj1g25mBPKwp7B6e8rZSq+Wa48F/XZkv?=
 =?us-ascii?Q?yBeLmJOGwjMgllHOhCGZq9cAQ1klqKy4xte2mcTdoYSk3qvB7NN3EV2OPS2W?=
 =?us-ascii?Q?VvX62plvwPQp7gDQAGLoGnsXWTGtYd8Y4OQ3tD2OdsshzvebdGlWSbE2HahO?=
 =?us-ascii?Q?9E+6jLsZgDMF47qhEERKRPwUVQO3f0A0Jl3tew2cCV+jMjmzX2tD6tdwZlpw?=
 =?us-ascii?Q?4dyGkZSy0yxInmspImptMGjSpuGLMPd6AXq5lsfsajt/SrVGBNBGCaSteLxa?=
 =?us-ascii?Q?7mEm2611emqFYpgOkS3XJ3nQTrN/Qvsecxg+Wpeu8sCkp/T0/iYtbdEIBmNT?=
 =?us-ascii?Q?nX+b4vapZ1eiAcrHi0o6x5pfe97p8kWegrmByJKCTC9eI21G9ZKqoJDP17Lr?=
 =?us-ascii?Q?YwBhYSVFCFxyCGSU9hRcKzd2WMRfjbuH1WAGQr1EVi2JF7+oLD0SyWP1kApK?=
 =?us-ascii?Q?NueDPGkNTTtr2UNu4Z7fifQ/uUar9j2u8RLtBiey798VXIWV6fAegHmlO8bG?=
 =?us-ascii?Q?mcaECCUN8xXPkeJ/tRM6+7bRAhUkpyde2WeLUyx72GpvtK+UJ3AedZTvpuOR?=
 =?us-ascii?Q?mtiRTd/DDFuWty7gMdwVfrtQnLFQN7w/hGazBWLfjyvdyf5b1UD9RKePZeWV?=
 =?us-ascii?Q?dyO9+wA1PGHYmgqXvj/Qyzf1KOMW2dhhqKHxRzmr0gVvhUgPBB3LxnlRc8UQ?=
 =?us-ascii?Q?zEWHx98WjM6Fdci0xExGXzw9qGYkTlGzPSPw86K4HtoivpZhuDa+QzUS25HB?=
 =?us-ascii?Q?UA5yfJgY/7WWJm4CIRlYpjFA7OR2IbpHfjJFIGl1JSoSDmTHPkrIkSWx84oy?=
 =?us-ascii?Q?RHenNws818dLz3gju/eklncxLw4whc7mzK9yUeR1AVc/qwZe3pvDxf+R2Dgi?=
 =?us-ascii?Q?gSed7XOM9oeJx9zRCNryKnDu8TCdEseSv90mAlLj2+qc4FgnQG3H/0GVTZ5n?=
 =?us-ascii?Q?kcI6p53QYgOW1Lh6eXPt1eLbaaJ5lz11ezUOwKmCUA9PIsr1g4hrk+opQHrU?=
 =?us-ascii?Q?WtUnclJIInR4E+rCz8y6AqsD3Gr8QTWVNGolr5+dMn1tZlugH7ktKa4PZQH7?=
 =?us-ascii?Q?uJLl11DDSJYQd0T104HGJQChsDejM6euU7pl8Z9eY9+7mzlK8UGhQc0Bb1OT?=
 =?us-ascii?Q?UWDZz0sFT6COl4sxkZm5utXEbsyrIgRmHbh5G0t3GCYJPfAASNyvMERxWpz8?=
 =?us-ascii?Q?24miTmLVEyj8SVZeoL1TPz1zEE/hs8l/aFlCb9WXORgXre+Jp+03s27vcdQ0?=
 =?us-ascii?Q?/VWmarjYNwg7s5o/9jA6yXm54mZiaSRMUSxkzUwNAX/1nAnIayRi6TSWmaWp?=
 =?us-ascii?Q?mNFbQd+fOWLDA0WCe7xY6G4HdMq2nMqgGzrJx+vEhUZtRLAfGjtPXVkAomA+?=
 =?us-ascii?Q?vFosV2E7tBS9H5ThnSrw2Cc/xoUQBpv2P5zPvH2AZHblxECD4bycCRZy6W44?=
 =?us-ascii?Q?yQS7pFnN6ti+f1V9y4gBnnVVTMKSLn7F+KIsfwmwUBU91bl4rI3mOsy/A47F?=
 =?us-ascii?Q?ueKyImrhOvPJmER+NXh2d93jTSThXTosypHg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:32.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7305e8-2077-476d-47f8-08dd8665d7fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

A new version of XPCS access routines have been introduced, add the
support to xgbe_pci_probe() to use these routines.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
- PCI config accesses can race with other drivers performing SMN accesses
  so, fall back to AMD SMN API to avoid race.
 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 +++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 34 ++++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  1 +
 3 files changed, 33 insertions(+), 7 deletions(-)

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
index d36446e76d0a..718534d30651 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/log2.h>
+#include "xgbe-smn.h"
 
 #include "xgbe.h"
 #include "xgbe-common.h"
@@ -98,14 +99,14 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 
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
@@ -181,6 +182,10 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -193,7 +198,22 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		port_addr_size = PCS_RN_PORT_ADDR_SIZE *
+				 XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
+		pdata->smn_base = PCS_RN_SMN_BASE_ADDR + port_addr_size;
+
+		address = pdata->smn_base + (pdata->xpcs_window_def_reg);
+		ret = amd_smn_read(0, address, &reg);
+		if (ret) {
+			pci_err(pdata->pcidev, "Failed to read data\n");
+			goto err_pci_enable;
+		}
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
+
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index fab3db036576..8f4416442171 100644
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


