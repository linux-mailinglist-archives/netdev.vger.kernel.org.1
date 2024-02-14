Return-Path: <netdev+bounces-71724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8F854D53
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A2B1C2291F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DDE5D918;
	Wed, 14 Feb 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sSHLGeCW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A45D90F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925799; cv=fail; b=uzqKqdsPPEVGBLBPlSY8r7Px2JQH0hTnNYUeDcaCOVtNUXqvvHvCVyhBJ1468xT348RSliqjHuHBOXKu84Tof8PysYDOBLT+fgYEYtO2pHKadH1fOHgKgoCPWekdBtuivxGNuS9YNc7OD0NcV59H1f6iQxnOYwogczWn6dB5fh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925799; c=relaxed/simple;
	bh=eue51Gnwan32tuBkbuC73rgcY7YKQmLkEyUOhyjtI4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSvbamnXWXKvs7U2wEd43efdO9/AfMxZrRjwd/JuwdXqp39zxOObX1Np5BZtcIIiQdmvNg3A/anE+Ynq9nKwfjvCCvyJMvj591rFo90vLPoADdPCZ3TO42lBmrCpwuoSyWX2wWBTEQRB4uHdJd963VUgQMIHvqr6RisalOZckKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sSHLGeCW; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czr168xCEQYAS5Uf4BC50/Bb9edc2QzjYLv7F/IAAwjAB5LPyB5ft8ErBGMef8N9agpJnu++tEaI1zJshjUQPpgkuPMV7QrgTJknPfuFk6+MmcCl2qP0Hvx1cb5I6xW8GiksKFs7wv8nxuS4mrgrd3b1IYSLMp09ZjjpgswrKcyhqUgdfetFUK8qRjbblriyTYQEDpaUlZB9DSQAdPTDlQvuv2/o8shUGWmcc+uUelsE6EsqCG9mfTh2pzWoSrtnicOI15ow2Yn5t20TygqL+zCU13rGdJs9+dpiY1QsJjpnSOwRhn5q+2wY0EEB+iz/+Np1rhS7QmbH4r1Qc4zvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6QbQqFWj5AlwQzp/DoUBKYM/EPi3jq97IkHpIO9YXk=;
 b=KVf6QlCLKxK71LV9bgk65XpmxGjhRn3wjg1pvUzP/Sz0PMmr47MR/gkZkGSAND9LoGqkYtJoRuoNkL/Ey901sBqOweHxlp0TFYzelrbbP5UCDr2hCfUAvUaJhV41a50IT8TvqRQ97013wDYAUK8uI66CMpsZBdSrX/uyvDdsfuGDh7clUVsxwjL9nvXu4Ldx/nYOS9+hm1GK9RtHgKZqhAK4+liS+DnkVyOBT/AXWTGy9HUtfCLamxe18wLi/0HdxKN43nQ+wi3260vymcq8rLiwGnY2UhuLQ6nE12K04zbOJ38Cg8wAvoKB2Gza7ADpQEgKST2M4j1b+O7tK4wwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6QbQqFWj5AlwQzp/DoUBKYM/EPi3jq97IkHpIO9YXk=;
 b=sSHLGeCWfN2eEe1LxIXnovLFCZplsG3mc29MppaB2NPfrEKt7sq6f/ZgLcbK0x2cZHn+6THmb+UYCYJcLLpwYS9u8jJuV+5UwAh5zj7jW1bAJ48GnjIUyBSOPZQyTDYCNwrnSWL0U6HlNn4VTJ1GOzSHt19drC2HDWy2vlHmHBQ=
Received: from BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 15:49:53 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::52) by BY5PR17CA0059.outlook.office365.com
 (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:52 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:50 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
Date: Wed, 14 Feb 2024 21:18:41 +0530
Message-ID: <20240214154842.3577628-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b77c2f6-b8ef-4a30-3837-08dc2d749586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VngBK2J+OwE0dygrfyioR9+BdtFjrjc1dC3cKr3H10q1eZETkmImLzcN9cYNCEw88bVCN8Odxr4JJH6jFzEXXaS0F1+IQG0N6yUnK9GJtcU5d3Kk8WDOhLV12Eb6cJEp1xBUTGdpfA+rl9O9VwAJO5keObLkPHhxWnpOFsQHuPNVp11CBkm8OWeP7KCICDYuDiHv61Zxz7bJuWtHH2rSYGCCotsjWhE1QXUNKk8xW05ZEMabzBVl4cmDYFUAO4xutoLdklZD7/1PqhwfvGevwpiJLZ0nZNQX7hKegJtobETUasIm/1hGTDbX4d8/vw37vBsbYfnaTODjMvyL121grGAwzzNYl21CTJ1QxgSp6JCEFsD//DJCpBsj9JgoIhmc7NEEWCA8iml7cj9N+YC2F+FmP3q0IUp0J1MdMJFCAKAvV6Sqs2+by9oMY6WZEH/MxBDcGCVyLxooOkV91fpJVBvRVptrh0RYO9IjaQ3jO3gR5Ziq5iT/6mBxGBX9E12TZD3Pro7B6o+Gph0ijIRceDI0KkLYjNFYPstok1b1B+vS/8WDbHffSj6u72Ry/83/I9lMTRD1rkXZK3MBS7UWTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(356005)(86362001)(81166007)(82740400003)(478600001)(70206006)(70586007)(6916009)(2616005)(54906003)(16526019)(336012)(1076003)(7696005)(316002)(426003)(6666004)(26005)(36756003)(2906002)(5660300002)(4326008)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:52.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b77c2f6-b8ef-4a30-3837-08dc2d749586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

A new version of XPCS access routines have been introduced, add the
support to xgbe_pci_probe() to use these routines.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 30 ++++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  1 +
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 3b70f6737633..33ed361ff018 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -900,6 +900,11 @@
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
index 18d1cc16c919..340a7f16c0cc 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -118,6 +118,7 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/log2.h>
+#include "xgbe-smn.h"
 
 #include "xgbe.h"
 #include "xgbe-common.h"
@@ -207,14 +208,14 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 
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
@@ -290,6 +291,10 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -302,7 +307,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
+		port_addr_size = PCS_RN_PORT_ADDR_SIZE *
+				 XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
+		pdata->smn_base = PCS_RN_SMN_BASE_ADDR + port_addr_size;
+
+		address = pdata->smn_base + (pdata->xpcs_window_def_reg);
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		amd_smn_read(0, address, &reg);
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
+
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 60882a46fe50..12c074efa872 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -350,6 +350,7 @@
 /* XGBE PCI device id */
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
+#define XGBE_RN_PCI_DEVICE_ID	0x1630
 
  /* Generic low and high masks */
 #define XGBE_GEN_HI_MASK	GENMASK(31, 16)
-- 
2.34.1


