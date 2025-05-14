Return-Path: <netdev+bounces-190420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED5AB6CA1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DA419E64CB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575327AC45;
	Wed, 14 May 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mlS3xWuN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B827AC34;
	Wed, 14 May 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229287; cv=fail; b=nSaz9IYdawIAU2/EP4P3A67RExCzHj2lwsJoDc6I2wtq3X73WeoaKzHgLq2fcAjJuXx7EAQgYrCrk00SuYlY7IBSbqc+F2cf9vFntUmOd+W91VGJdP9NyKjV8KdbxR+kMZDDxL7pO6ObjUmwiiNnMD5w3q0LHxB9qtV137UxjKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229287; c=relaxed/simple;
	bh=SfXzOWXsvIEjfhclfo9eYRXtllJxcFIrag8kYMv2WAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifPSz1ekpiPDr6ZrmJpo1WHsVwFlikwjH/nnqUI9LMOdln3sh9NG8dJ/+dEwrWItkdzne+sCBHq8RRGryKFR+Vnu8yCNNPXNXZvY9Es7LL7GTTh/tMl/6kXLsvBIHhSzVk1Y1Af0ksR2B331yaCL630MHbML9ThYqSfSMiLocG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mlS3xWuN; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTwRwPk69KJomuOJNLSYzNiV3pUyMfSYeksOKSwLqo3gOGR4EIt6cpA3q6N123l0gCkVlg21RPU76W3bnBL78f/3/bnLHnk6O35or/nDmslp0U+2ew3nR47RCFKnoT8YM6eD6YqL4yFszxALlIdX7zOiYgs+HGFIycLXv8p/FOvgRP6tLNkorzBCIiQIL3g0iZVPtQEq4zG6ts1I6eB7xrXB4EM03X1zNkdVi/t1JHkq7/15N1txFXGPNZnNZWvQkgJN8sp0JOJQX8NlhTTS2fvGuUU7G1I+PovNsTEy7pRRurfkBfXItOic1IDJF+jjIdH59rvDJ9CV+9DuY8V5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFoAK/OPAo7gYxIN8dZsfzAPpwFzNyWn3qYJi4P+9C8=;
 b=xiOzldCnzKpJF6UyIaJ0w4v3NzFtwG7E1pUPpbMokEijuyeUoF2+eDFhIAx58rKUUSpBlZ9SEZ3xi4YoFMaI5WEzC9tZKfFl2ShyHNouYSRj14yW9oK6+uPqGXBjMosHUIrVSa+Lrt93LVM8Ke+OwNkcmgK0srWmKCUi9sG8sLftjkJ+v6n8EH23aCY5Oo5pq7MPkHEXiHyhIzPo/e1Tho5awK9l8eQD8NsCijYlKJFmt5fYkTHvuSf2V94SLlixKK+ISDv39vugU5mfqxr1p8t1+tm0DCsFjCiFU7iol/sROAbiUSUrZnm4zZW9GBUiS8LHaz8Jz1JEL4nYeCjLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFoAK/OPAo7gYxIN8dZsfzAPpwFzNyWn3qYJi4P+9C8=;
 b=mlS3xWuNM+tQQFdFrSRlZ4wWRRMPHKzOaLADrg9w8KUamiUHVmgEvP6Q2rrI8dMX78crfqg9wahMW9C3fbTwONNgpNw/yA+IGS8gZtaHzb1MWdEswaElD+aV6VHVY30aSv+WyFwrb/pTkcqJwLCzoUnnKDjsAZdSFSFtwAkN92g=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:01 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::1c) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 13:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:00 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:27:59 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Date: Wed, 14 May 2025 14:27:26 +0100
Message-ID: <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee90b5d-dabf-493b-1a9a-08dd92eb262a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKdAsAlQBIimXqFoSCHYXiZ7meOCJlTPOfgmg82D5u6KBl2/p4hbe0XaDl46?=
 =?us-ascii?Q?2OcGhKFZKZBlp8FSrf8aNBhNfAcWOLwIlNXfD8nSDKT1kn8ZM3SZkQRJeprm?=
 =?us-ascii?Q?iLaqK+nhN0yoTuqQXqm40iBtdUf2Mg6MUjR6jHNRTDN70HMa7IC3afVED7BL?=
 =?us-ascii?Q?W9A4t1HFCOiJxX5U0i224ETLyDBFaeyU7sYZtBTtkr2/ABTFwBijuU1QWbsd?=
 =?us-ascii?Q?kvO50FTI31HudXIFBCJlZgPtLpOVGp4I/ITAlzH1X94ybs4SX2kzj+UP7Ixf?=
 =?us-ascii?Q?UQ2YGBg+/XgNk7N39mM9OteVIcZkPGL1tL9ar3Sy+WZjPOJdOOxgIR2oehhk?=
 =?us-ascii?Q?LqhkFhooTXMKTRcgUalFDnjpaRuAwyAg3gT5O/b9zZZyA2KRm/pGXUnkynVJ?=
 =?us-ascii?Q?bVvNUwQhH55uHSNMWRihAjQErPcjlbIIVkUOLWawGIweN1DfuDZrX/PQqvxd?=
 =?us-ascii?Q?5HX7gsLgdl22kZ7EE568MvA1SGHq5UoVyRcMOTlCU2s/DORsMNjkc1jYhC9B?=
 =?us-ascii?Q?GFURD5lSlsJkkhgI9VGgsjbB/yRRwJFSikTd7SeTqSoAsdbVAk3No/J4MIag?=
 =?us-ascii?Q?PBOWmhBZ1Yu7yzyb52xgCkfIBumlr6s+WDbMRxpHZAJmEu+sT5VfdFHBvuG9?=
 =?us-ascii?Q?ZGqx7GVHWKwuhTXTN4YmLY7sX5CLxs7cI+hwDIs78GSJFsssZnZqCb2BbVT3?=
 =?us-ascii?Q?fEIMcJwOqLbjgiXUYbjBkxktWbqT4cu4L6u728xNKVleOjLJVT0Pib1VADZc?=
 =?us-ascii?Q?JxnOa3SdjtWhej5xBRXWcAbvKnm/s/7VOCcK/xpK9s/kYwPQ3wSkLWEVSm/g?=
 =?us-ascii?Q?isnMoJtNnjZC/0uU6/WazGDIB1B4M8YefN5FV94Oxu0G02maDVJaF1QRcSLa?=
 =?us-ascii?Q?jRIinOoW+iPnNfy0qHhcYi8rfmqCsMhsqrRkGLwLKf0gnLyW873poORyPYdW?=
 =?us-ascii?Q?503BHxsUxDFnhZf9QuNa4WZTk55p0mS4qKk88ND3tUiZTGJMhR3+FMIxY6WU?=
 =?us-ascii?Q?IseH0Ja9elsp6U2rH5wDmlFPFPTQJNsNebxrHCTDF4Ybs70Iok+ouo+tfXW0?=
 =?us-ascii?Q?poRsCclEnHrJViS7AfhiyBlaR31agxeqsw9SlzY79cCAP0McYfRTSWez4sSb?=
 =?us-ascii?Q?7+4NLpXY76RDIAOCIvWAV7WtuZm/VpHM3UbnQZDjMJEn/Yzm8o7Jmmp2Vh57?=
 =?us-ascii?Q?Z+6TVnO1zlRBpyAZvdqrVD1dnYReftxUPQCssMRuaW/5slQ2OgBbJhHnLeKa?=
 =?us-ascii?Q?Gl/qos9uQKgW+aFDFpA0w0p+QMib46WUM15V5NlHRqKH+bFyVlKlaJeAMGhQ?=
 =?us-ascii?Q?UiqzXJqbKn8rApd0Xttx4/hrkDa/Dn9goYJwSXoRrgZD59AbYHmnzI3lziHG?=
 =?us-ascii?Q?oADy5niJk9U+2wIKbWknCdLYBYIVJl6bxFO5CNdyYNw4GP/ANi8dtYXHNdrr?=
 =?us-ascii?Q?UGDSY+RUOSciUB6vdFhkjwxtMTFXjV4dmzH8Ofxrcpg/0B9xlDZx76PwGRLh?=
 =?us-ascii?Q?e3A/HdNkJosZ5ofZt0PSndzL74VrIFlr7/8i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:01.0977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee90b5d-dabf-493b-1a9a-08dd92eb262a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e2b6420592de..b05c6e64bfe2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,68 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_accel_setup_memdev_regs(struct pci_dev *pdev,
+					   struct cxl_dev_state *cxlds,
+					   unsigned long *caps)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps() where the problem should be found.
+	 */
+	if (rc == -ENODEV)
+		return 0;
+
+	if (rc)
+		return rc;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+/**
+ * cxl_pci_accel_setup_regs - initialize found cxl device regs and export
+ * capabilities found.
+ *
+ * @pdev: device checking the caps.
+ * @cxlds: pointer to driver cxl_dev_state struct.
+ * @caps: pointer to caller capabilities struct to set.
+ *
+ * Returns 0 or error.
+ */
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
+			     unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_pci_accel_setup_memdev_regs(pdev, cxlds, caps);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, caps);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (err=%d)\n", rc);
+		return rc;
+	}
+
+	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))
+		return 0;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 412c45a2f351..6ab6dcf81824 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -247,4 +247,7 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 struct pci_dev;
 int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 		   unsigned long *found);
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


