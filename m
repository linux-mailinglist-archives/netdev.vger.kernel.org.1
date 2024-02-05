Return-Path: <netdev+bounces-69248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D284A81F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571421C28020
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DF137C4A;
	Mon,  5 Feb 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/DU+Fx6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC83137C58
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166180; cv=fail; b=urx1aKKgXSds5MPAAYkvS6dYOj5OkgRSyGrOqpCPkWe7ql/CXFZwbDQinDtvHfnyTZkZ0A7LvBTB3jWAL6Tn3yXf6oIyIwxiROIZYdsRrwMf/P6Ubc+OPCt0YOkgFjRVMVqht5L9WzWnvmohFj3WTvJEzyWFDIB7oRBOevNsqTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166180; c=relaxed/simple;
	bh=rRHOwg9dtoD2K/CCjyVE3mAxjcrIuvFcOEdXZ0Sq+7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Poj8TKA36wqpS80Xyg7crjErkuX2utWmiD60vIlBDCdMYtMERF2mMCVsEcjl3i4J44aARcRsPHgpR6VRScdC+mILKnYLHQvD6YgfWbltDK5RhC9M9pqxOxyMV9TuSKSGPtEF6W02JZsifjRCFWdVEdea70iGwP5WxXB2VxTCbCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/DU+Fx6; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlU2lLn4OQ3da+sHmVq/P9RCCP9tWmITkBbbEHFEKbsI/KuBx+exAqSerbDLxQOLg4Dm2VWMYua7eVGesy5sIzfHujy3TrOB+mzCl2ZDgjt0mGLZq1k+42HoG24AdH9u3bk54+/RoJ7iTLjSg8Q9Z4rhNCvGysLuxN0TkPF29PsZAIAOqIgQtkPeUjheH7kbuW8rWvjuDJ32vCeZ3O6NWXL5lXYxNx/qB9HoNIuiwKYF7K2kOYUVVOKuSMjETU0Bar6lcpTsb1iOnwZZWbI8lafjHtYF+NC77GLTIhofriRTCyPNHtegdmVi2xrh3EiVxmw/A5lm+0LhVzmPsMpXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ1eFg12MUMVm3Nz9JGUjtc93vf6dM5VGJjqcdqbUb8=;
 b=LnsUVFEulz2J753jYSuQr8way2/HWMmJRdP+WNgtlh0GeeOEx5FSyDa6qZ3Gdmp30MrFiM107BHuRPWin3o1bAaRhc9rANLFJhoOWrAwUHtBMjz9O7D+dLqa9VxQYVR/oJdCmIaO6KUxCaSAoEj6V2fD/bDRN8QHhX17EESxt5o0H3TSPn2BRqlBEXoaeOjB10MjRQEWw63CvCahk9vXBBf5phjdKl3zsxmwFkbI2RGRtnoNaHRHZ2rY2Y5BcALlz4/5k6aXcPFw31g2nDpmL5RIsszWpOC6Qvvk100UzVcEedSTWsbsrz6RY0Oah++BlMyTZmJdIKO2lFp8HsB5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ1eFg12MUMVm3Nz9JGUjtc93vf6dM5VGJjqcdqbUb8=;
 b=s/DU+Fx6w2lF1MqjjglHLFuVMk27noqoMho1UdjO9NPRSYY8HvGPyiKBTzVjD5wsXqaK/+19fmQ8QhIbbmQmL02CODfXh5rC/a0OVEG8MowlaZmlTUcZZ6FGKCZMHUOxxgYOdtbTT8MOaXi3yK+2whHG4rygy83badz5nd1M0bo=
Received: from SJ0PR13CA0156.namprd13.prod.outlook.com (2603:10b6:a03:2c7::11)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 20:49:35 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::9b) by SJ0PR13CA0156.outlook.office365.com
 (2603:10b6:a03:2c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Mon, 5 Feb 2024 20:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 20:49:35 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 14:49:32 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH v4 net-next 2/2] amd-xgbe: add support for Crater ethernet device
Date: Tue, 6 Feb 2024 02:19:00 +0530
Message-ID: <20240205204900.2442500-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a92e10-e011-4ea7-c90f-08dc268bf644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6RLCN+GJ0+jfqd1D5FN1I28I4p/x8DdACMcKIM8sXrvLWUbuJf1hKEwTx0mRhgkyFIJjyWIEELJDnS/00ySMbOnHWrtZqcpp+HjFA2JUicZ9lhIsILb7mWuf1tb19OaD7hyRwTah8e9Es4wvPouJVRiMwjuFLtx6NJLeCOGcq0Uv27OdXyHMZgb0CBAWxX+0LE9tvokk9lS14/XDSffxkWNpuq95k1o+HXZhzDTI7b0lK1/+2NSzGwXG6jZcWb11xXC/IJ7Bx5+uLZ5SR0gC/t+ICtVkjvZ6Pw8FEx9evpUh3W/iOJvdDmrjxwF6XR27LrB1uTjyA8JrF2DOLe9aYUwRsq+DpF/nMPIWKA9LPzKkNeP/uS8KXxbYUeBMz8AwMEU2V+a4uudjAssvnW0lRCsUnEdUv85f9FhGiZOLjZx5KIfM09Hh8v4npESeuSsYtwdGYHlbaKoEy0eoZbc+PMC648lCA9phHRk8Wfrkw56EZOK0mfXUp4kgdDc1vRGm5wAzlIVVyYypDzslcS1YY2IOwSE4Q9C2umDeTmrePoMtp6wNqQIByCgRfspfxO61fEUWoqRPLCvUEl/emzmg1fSmjW8ArT5ksQeZwUdNeKjJF326z3mgM7/j+k6igzJHPOo/Bm8IMsaP22IxxljHUt3xrhpyrRCmAd8oMSZoaCswj0IaFVz5T+isfhTQxUC1oF8q9n980oi++4g3M78zvbHr/DxktJJkeibzltWqVrD6vwywtqxpX3u5a5rUefnFOv0WGDXzwqkhZhL93rAlaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230473577357003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(66899024)(70586007)(2906002)(54906003)(8936002)(8676002)(30864003)(4326008)(5660300002)(70206006)(86362001)(36756003)(6916009)(47076005)(82740400003)(81166007)(316002)(356005)(36860700001)(478600001)(7696005)(6666004)(83380400001)(336012)(1076003)(426003)(2616005)(16526019)(26005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 20:49:35.2999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a92e10-e011-4ea7-c90f-08dc268bf644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the smn functions.

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests. Using
smn calls helps avoid such race conditions.

Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    |  57 ++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  33 ++++-
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |   7 +
 5 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

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
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index ac70db54c92a..fee22d099007 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -123,6 +123,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
@@ -1174,6 +1175,56 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata, unsigned int m
 	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 }
 
+static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	unsigned long flags;
+	int mmd_data;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int mmd_address, index, offset, pci_mmd_data;
+	unsigned long flags;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
+
+	if (offset % 4)
+		pci_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
+			       FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
+	else
+		pci_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK,
+					  FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data)) |
+			       FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1265,6 +1316,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_read_mmd_regs_v1(pdata, prtad, mmd_reg);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
@@ -1278,6 +1332,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 18d1cc16c919..b14e98f5d835 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -121,6 +121,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 {
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
@@ -302,7 +307,15 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		pdata->smn_base = PCS_RN_SMN_BASE_ADDR +
+				  (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
+		amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
+
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
@@ -480,6 +493,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
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
@@ -517,6 +546,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
new file mode 100644
index 000000000000..30ab83a29ab0
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
@@ -0,0 +1,139 @@
+/*
+ * AMD 10Gb Ethernet driver
+ *
+ * This file is available to you under your choice of the following two
+ * licenses:
+ *
+ * License 1: GPLv2
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ *
+ * This file is free software; you may copy, redistribute and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
+ *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
+ *     Inc. unless otherwise expressly agreed to in writing between Synopsys
+ *     and you.
+ *
+ *     The Software IS NOT an item of Licensed Software or Licensed Product
+ *     under any End User Software License Agreement or Agreement for Licensed
+ *     Product with Synopsys or any supplement thereto.  Permission is hereby
+ *     granted, free of charge, to any person obtaining a copy of this software
+ *     annotated with this license and the Software, to deal in the Software
+ *     without restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
+ *     of the Software, and to permit persons to whom the Software is furnished
+ *     to do so, subject to the following conditions:
+ *
+ *     The above copyright notice and this permission notice shall be included
+ *     in all copies or substantial portions of the Software.
+ *
+ *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
+ *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
+ *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ *     THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *
+ * License 2: Modified BSD
+ *
+ * Copyright (c) 2016 Advanced Micro Devices, Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Advanced Micro Devices, Inc. nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
+ *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
+ *     Inc. unless otherwise expressly agreed to in writing between Synopsys
+ *     and you.
+ *
+ *     The Software IS NOT an item of Licensed Software or Licensed Product
+ *     under any End User Software License Agreement or Agreement for Licensed
+ *     Product with Synopsys or any supplement thereto.  Permission is hereby
+ *     granted, free of charge, to any person obtaining a copy of this software
+ *     annotated with this license and the Software, to deal in the Software
+ *     without restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
+ *     of the Software, and to permit persons to whom the Software is furnished
+ *     to do so, subject to the following conditions:
+ *
+ *     The above copyright notice and this permission notice shall be included
+ *     in all copies or substantial portions of the Software.
+ *
+ *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
+ *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
+ *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ *     THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *     Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#ifndef __SMN_H__
+#define __SMN_H__
+
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+#else
+
+static inline int amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+#endif
+#endif
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index c9f644ecb1b5..602386982d0f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -350,6 +350,11 @@
 /* XGBE PCI device id */
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
+#define XGBE_RN_PCI_DEVICE_ID	0x1630
+
+/* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
 
 struct xgbe_prv_data;
 
@@ -569,6 +574,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -1060,6 +1066,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int smn_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


