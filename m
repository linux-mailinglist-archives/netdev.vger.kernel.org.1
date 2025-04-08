Return-Path: <netdev+bounces-180421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6BA81478
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251521BA4D03
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45F23E341;
	Tue,  8 Apr 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tK7rMZjR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA623C8C6;
	Tue,  8 Apr 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136450; cv=fail; b=swyEVqXC7eVNpP0+rA3cyhUPjIdH17BTZxF9kDB6abVoKv6ZQhuNJO1NyEe4DgO8epdd2BxbWztyC6lT3F2xreRrc+QozEgpTgHhKIxWuTPRx8xFZk61ZMyR8idSYIAFAb/Q9EvWqNZR+Y8QDbCBcQg+rqW5KKmfOskADuc+LkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136450; c=relaxed/simple;
	bh=4R1cp7/416ZWt63LgD4ROQTpnAuCFJL1mgjyXf8C3sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwMNLo8lECZ4SS5ocNnhavZHiDcyi4He5LH3GHvVs9s+////7g/sZ9dVDXGmzjx3+ZpB1iPc3PhGIMZMMBRx27AF2PJxymBs0b15jeDY7HjVGG6HOuj/uVsmqDEynv4CcW5JdVJfdhDv+sKtTyq8VaYrLG9uZvOGmZRnGh7oIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tK7rMZjR; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYRjb8K1w49dDQySecsVRoQuvIEO7Fo66NLoRsT9MBk7bioPEGpO4je+IQiNaaRyhsiRKAKGqGECohZ2Tqy910317oSCQ7ELW/6OObjXHjAwahuHRqACeLs/tgr+WyJBqcAmuqImFhC10L91sSgfHyhGri9XSrVAg/VqY/CuWEfiDZk40NZIKttUD+D9kwZm/qgeioGU0sOCHC03uTduxmLKpnwNKtnIYHy+T+koY/4qJ7xSUxoCzf+4bJ9J7GX5wJ+WXmhoGeaOCcODrqX4zzIAwYpkOmgtMWQeep/XPAjzfAG+cA9BAiodmSSQ1rbXX2ZluUc7kbCogbqo7VzISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY3cdmMRF4yD2AO3o3nS3mLI+mfBp8LyAeG877yLcG0=;
 b=u5BXkqQhkb2BCLqTTQOkWbZ82bOfYdVHqqKbY/fhjYFOjbtLjMsurau87sFVG+bkLNlIZ+4uw18Adj/g1HiHu/y7hIjZkKNK28o9Qg09TqM37fbHetgasc00EI/x15H8HLLS6MxQeFXEPZzi3deRErgpOqQq4kKjJX0tAT8JWn1ZFOzNWM46h7pkf/Sr61sV2S9sEeAKNE+5+NGfe+0QAJIma0aLtuRhmeiORyUanmsJjOshd79XbPT/SUGupovYThjUMdfX1xNyScWV1pZqWQXCqYmNgtE5bVpGfdamdtOKe2bZR94aVTB0moeem4z7QVCcHGbzx8lrJulfaXgh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY3cdmMRF4yD2AO3o3nS3mLI+mfBp8LyAeG877yLcG0=;
 b=tK7rMZjROd7vcXboewkiu9YYIXIQ9JeP69KmJfUt4aii/FkOzprxyRSfkYS5fA3Oa2xWNd4hphPn9b/hg6BhCaaa7P3Hk8ETym/jTIvKG7D0nrDpf4rq3zMZ4Sr0HJuuS89ZA8i3qCu6FUslzbYr1agCHZ08xpYS4fZsEuv3OcM=
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 18:20:42 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::1) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 18:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:41 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:38 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 3/5] amd-xgbe: add support for new XPCS routines
Date: Tue, 8 Apr 2025 23:49:59 +0530
Message-ID: <20250408182001.4072954-4-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e677989-d078-46fd-a049-08dd76ca1245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5uBTpS0WZuGPDCoWwpfHFamnoFruosHWeXhcS3lZd3cSEe6XWyFsCOKbHiln?=
 =?us-ascii?Q?lLZa9zvns6FAD7kDOpwKEikZYQJoo6h7ocFWct+Of4szNf7jRCqws/azE1M3?=
 =?us-ascii?Q?RkgPg46LF7LOB6esKv5NGg9qr+nsRciBPK+CVRhA8UbGJdOtwd/I+JhAhFBG?=
 =?us-ascii?Q?mCAtwaRg/cMt+sWuI49VIG4sUzIx1ygz6gyX6s7+Ib339xPbHANX9N3nA0w0?=
 =?us-ascii?Q?08gkfT+nC0ThEmJ9DAwvLCxsK/X2w6tWWvnapqf4U/1H2bm7r73G2d3qzCjH?=
 =?us-ascii?Q?gdWjsqfDD3pkO8TC3qb4Ebg0o2XWUZ/qZXH3BXx7EsKVP0lfMZV1ji4UKcSa?=
 =?us-ascii?Q?JwZ16WhVYTFywLJK3IIAtO+YWRcjKC2r9hilxO6y0Tc82MuQ8wpxTvP21iD7?=
 =?us-ascii?Q?z37YTEe0UrOvQMYbXOhYh/mNilp2iBLra3iLOTad8oJxGWFACbNqY1FjIUpw?=
 =?us-ascii?Q?PJtzI9uLBz22aqrh9Pub6t6cYu+9JqhJlAYnQqlz498ruYwHFVMY/OFYVjfI?=
 =?us-ascii?Q?et5OOj3RS1gIFyu6a0FQ1hGhzmhOT2EZ2vnTGJBYvN2b4NkxncJYw6uArIlc?=
 =?us-ascii?Q?qM0/iBJQsDQJKprgNX+XTjJPYU+UwWSpCddInrV1yMwakxmX8fjWQO6PvKN6?=
 =?us-ascii?Q?zb2eQkAeWSqerPqvNNJyAHe9pb4O/DbO6SSyIUtr5CicTXkeL25VGZvuqlGv?=
 =?us-ascii?Q?enlHdF/3MeKh1nHv2OjQjuOIHCiN4ny7RZtrcCFQ+1S0X9NOd1QOTA/SR55Y?=
 =?us-ascii?Q?kKd//3Nu9lg9ZcOPmH99s6sQE6r6dNLgV1OlFyt5JZf2BkrBFge1+BdiRQ7X?=
 =?us-ascii?Q?07s7PrVcj/c0KxODHxcLPUskJPS9h4XA/D5tBFlyVBjHDjhXGtyqsuVU7wgw?=
 =?us-ascii?Q?ZCBjmlyy75ox23KykFLys0F1mJyiXD71e569jGXGb7lw0PPheDslLhppOu7m?=
 =?us-ascii?Q?PxlTuQ9fiat6KGH175kNyue1Aqujgcr+Dyp0uiE9rsdUarpmD/N2u653MTMH?=
 =?us-ascii?Q?hZIB8TbButUlI1bikaqA7CWThHu6V3uA35rbY1zm7jxMhs22PtdrRUJ2c8rm?=
 =?us-ascii?Q?NLbuX5gb+lCAXmvdtsgkh2dqkn4CTLzaUkpEwqQYgv7l5+OhlP2I/TMNc4aE?=
 =?us-ascii?Q?KfZA/F3GupkEQ8dYQ29xSNhL3JwAG4h/CZKzkle/em31vTbd7mYnmUigik+n?=
 =?us-ascii?Q?gwipR2Nc6TJp4HAKnq0Wa4SFamXgloDuwys7TXb335p/7yj77fqAeQoJ0XMD?=
 =?us-ascii?Q?ngavD3C3P26GPmhyfskVozQ/Ie0pj6vQjfokM3XLszcx5iTkGQKC2hWej3gZ?=
 =?us-ascii?Q?WURfT53MRw5FjtQ58JrVSHJ22vfAKgATE0p/ssAUjurQrfbHSeQRvv2PPfRy?=
 =?us-ascii?Q?zrWihlmagZC1VaAhS0dkwPKwuN8yE/HLneLnNtXIqeSEi0lFLUr5ySAyporN?=
 =?us-ascii?Q?8W83sKQ0LzFDwLtLYy8OJBfBmJn/GaX48TmWYJ4FgpK04tTLaSswlx5GfpKF?=
 =?us-ascii?Q?v6Onnj3aM8jMsok=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:41.7096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e677989-d078-46fd-a049-08dd76ca1245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the smn functions.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 79 ++++++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
 2 files changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index ae82dc3ac460..d75cf8df272f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -11,6 +11,7 @@
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
 #include <linux/crc32poly.h>
+#include <linux/pci.h>
 
 #include "xgbe.h"
 #include "xgbe-common.h"
@@ -1066,6 +1067,78 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
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
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
+	pci_read_config_dword(rdev, 0x64, &mmd_data);
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	pci_dev_put(rdev);
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int pci_mmd_data, hi_mask, lo_mask;
+	unsigned int mmd_address, index, offset;
+	struct pci_dev *rdev;
+	unsigned long flags;
+
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev)
+		return;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
+	pci_read_config_dword(rdev, 0x64, &pci_mmd_data);
+
+	if (offset % 4) {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
+	} else {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
+				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	}
+
+	pci_mmd_data = hi_mask | lo_mask;
+
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
+	pci_write_config_dword(rdev, 0x64, index);
+	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
+	pci_write_config_dword(rdev, 0x64, pci_mmd_data);
+	pci_dev_put(rdev);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1160,6 +1233,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
 	}
 }
 
@@ -1173,6 +1249,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
 	}
 }
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 2e9b3be44ff8..6c49bf19e537 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -242,6 +242,10 @@
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
 
+ /* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
@@ -460,6 +464,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -951,6 +956,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int xphy_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


