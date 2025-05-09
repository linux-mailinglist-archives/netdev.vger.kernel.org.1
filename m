Return-Path: <netdev+bounces-189317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BAAB196E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0450B22133
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD34235BF0;
	Fri,  9 May 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="laq43jIi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F62356C5;
	Fri,  9 May 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806058; cv=fail; b=PdEknlsn3ntiBec7N7BD+T2NF2KHqXgQ/jw+KTcuW+Pibybb47WpUlcgFaaUAQ/Kf97ui/J8pA+XWJR95XqkjbTP4EW3yf9cNIVAXYEdtQqiEL+28ng9DLyWFwWou+I5jLQefZHZBhtCjPU8VsEzDJ9o1XtPBg36kcKxnTkAO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806058; c=relaxed/simple;
	bh=GWF7W53RQi51lcM+WXL0Ci+yR2zHjJtSOVtpqRqirIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dwcp6UuF5icRz+gV5dHzhJUe4tJLIPXGbaulzs5+mzuY9cv/SDfL0Bq2boSZPdkMdoqL4mit1J9JTx7inqkTKiF0nmtKwQhpTu7tGOmjI7FRu8H5Vyl/QZDMkaeQS7/UcJbPlA+2lyzvQQ5M10x+N5kIe08+1lZfqfawkikxGjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=laq43jIi; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXt+KEacaSoi9S4XosUSsYke0lsa+yWhifrQsPWKGysO7Wy2NC7B48y6Tm7UFZ34oJHFYSyH52NSCqt5CBI6suxs3vs3/tT+SxDks1NRV03e+T9Fec6KFGII6gKpOsxxWq3+Zt5D1Qe+YWEox6vWI068RFM0XaGu07QbULlJ02Uc0739hjd0Hw5e6ijnTe4mjz0t0jAV3053h6YuDLJOEJh5FxPa/HK2O2GVInMoPduNcNkXCuoBhNxs2nIMt4xVQwr3XPH02OMB4L9Ubyl/lvgaiRqv50JCdFfD6CRJhGOoQw/6c4junMMB4h71aR9UfRnxAl3ZCWT2JqrrseA0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nB0Y3fejlfzSQx4M3hC4X6Zuys+6d84bMw6gXCXIpI=;
 b=rNelKAF00+FpaS2Jgyp0bFjBtXnSLEiqfET3bv4NN9YFFExK6wet8xmUVD19euY4D1BvJj37dzOQa0MHjBqg93n1j9+YTLCayFB6gxv9rzqyRvWB1qVMph4Ia1tC0G2cJhhd+En5EsxS+4dszIsO1SA22TfWy7fHFzWzcTN8tgWpPM9U3tTfpMM7SAo+gnscjWm2HacmTtqhaFLOZiDjZ1r5c5+JyCC798HPDZrkTx7OZFOwctYH4BAyYdFq5s4Bdns6aLSarblIio2ei94clBJPOX7oqNWUlK6bCmbvEktJAdg9U+VVai4BYa2D2n4aeN0mfpw03OTWbuzswO3DNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nB0Y3fejlfzSQx4M3hC4X6Zuys+6d84bMw6gXCXIpI=;
 b=laq43jIi57NrvO8JouZZL3q36ME3DgcLSy02gSQFciTEtf61yNm8TnJHHClSSL0/MRdpx7JT+gJ2+vOArO6wuZc97CulzRZ2yFt46fv2U4l80KYRDsBYslcMlodod/kWuJeCtxrTktgfTr1Xwcg6v8RFBplW6geVqZU61loFXaQ=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:54:14 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::81) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Fri,
 9 May 2025 15:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:54:14 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:54:10 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
Date: Fri, 9 May 2025 21:23:24 +0530
Message-ID: <20250509155325.720499-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d8ca80-5c21-4e73-dff1-08dd8f11bf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bhuEoufhQfviQBF/NDnzFABGtibuxPztwboHwJvvzT6yTT92ew/OE7R/3oMt?=
 =?us-ascii?Q?ImVXZ0d7VFLhWIiwXOARtQivma6r8WtzDv28zhBv7GeIF+v6yog9IRF8Nob6?=
 =?us-ascii?Q?JA89LK3wsHT8WD10d1oWEQEtsZTWBNqXQK+M68Cc2UrBH2019Ffqp15hpR4p?=
 =?us-ascii?Q?jnLK6/5TOLh47bfK3LzmwNCwK1DyugwldlB5DXAX6ImcpyMdEwYdEpX7sD8Z?=
 =?us-ascii?Q?JcnEeeAebTilVROX17BC2rX0ShaN1Ss4ZloVxa8N4O/pivuiOnYdQPg4ALbP?=
 =?us-ascii?Q?UpDDfRFTBEBIz3pIdHodNG1qUGf5ifJ/qb4OJXjgEzLf/SlneholXuBS/y57?=
 =?us-ascii?Q?0WdJlLP0xGUkClzBwJ3ir9nItl6xNSOCwfi6gMAfYVzweKFNp1N4IrfnnWOr?=
 =?us-ascii?Q?F0CnbVVcwyuBly1YDn9ICMJBLs3xDN8OUq1JiqwFTreWDZy9TKLjwNf7fEIB?=
 =?us-ascii?Q?zNliBTa8aitJZ73iZ5iAf1mvNk0A74Z2+vkTDr1tn7E+AbJYkM/SvdLW7IS/?=
 =?us-ascii?Q?M414qMyppsBnoj3aIEYKWoGWbRBu1WDidTKF6z0hG6WQJBg9a/pBKcmtebzq?=
 =?us-ascii?Q?mXAbDK1mD6GAY9hpXEOdVWd8Eo+S9xBXiHi6ygzKJVk5J8L3F0gxLnMcc7FR?=
 =?us-ascii?Q?yvwU1vr6OCG5R1oLhQuJ6tAUQtxZhfJ5g/xKydrOQ+o21VHsve+jxymVkRwj?=
 =?us-ascii?Q?0+IcaUFXVpW1sQNTER/OUxPKUEfggvLhMXBqxDSRa9jHbxzfWKHvyhYETWlM?=
 =?us-ascii?Q?SvBkb1foL8B//hMydjcr1Vvv3ql9wVVIfOaoqnXtu2eKXVUBq24VaEAXpLwE?=
 =?us-ascii?Q?iO9jBQF2dhqwiHmLz5f81ItfvD3kw1e4bMWxJwTjmv5artEC3qcQBvZDzVi0?=
 =?us-ascii?Q?/G9oEQJrpSp2KjYOEnz1n8JJ8nstfOvInHla2WZAdRRm5iAqM0tpzBhL2kSw?=
 =?us-ascii?Q?tbSwCI4QeO/yRMp/UwM0urZHTyXdAC5NR09tREpW4i5MtgyweGwcGl96jM8a?=
 =?us-ascii?Q?HY0q7Mu8xdq3d7esgqqQCK/z4wSO8znYlTduspHhsXROLizwf5tAZ88Pz7kV?=
 =?us-ascii?Q?FJJuJjEkKyD9elLBR8M7cjb920THnuSFYpAgF9Gaghio/PaSx13bhqfGALf2?=
 =?us-ascii?Q?yh5C94iGChfK2zkE652GSbv9OqV4sxsBAz7ToS8+4Wfq6On5Lr/j1LgFWjGu?=
 =?us-ascii?Q?+plADaIIh1ulcRcb6m8Ggao/wVF8gkGWU9pE7/TFyAB3KisUhepv7EyfqT9s?=
 =?us-ascii?Q?PM57r22XFM2nr5hw2NJLQyCx1DgkfZCj+FIq2rLaVgMJ1sFe4sCZpW43cyO3?=
 =?us-ascii?Q?9v1EoaLY/mwp4goDg/0Dqqlb/sHhJyxBAqXOhxQF9M23tqnE511nkzg8ktt9?=
 =?us-ascii?Q?tsI7cHsN8XobNe8kNriJR0uOYCT+G/mh6+gQMaEXzW+6q3hHesZ/5LP7WlO/?=
 =?us-ascii?Q?3Z+y5Ugudy+71eNEIm2ek+KXvGjXkGX2UcQ8b9fKqGFIUegMZLC9SiDi4EEc?=
 =?us-ascii?Q?ygBoUSG9eWqNhBjWRYcSWY+cU09u5YWdd68g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:54:14.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d8ca80-5c21-4e73-dff1-08dd8f11bf3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

A new version of XPCS access routines have been introduced, add the
support to xgbe_pci_probe() to use these routines.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
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
index 44ba6b02cdeb..6359bb87dc13 100644
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


