Return-Path: <netdev+bounces-173657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0EA5A580
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A03D3A6320
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC01E1A3F;
	Mon, 10 Mar 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LBR1XtNl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CD1E0E0D;
	Mon, 10 Mar 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640643; cv=fail; b=ky7rathpye7BevYftyKjowNCyBRrQ8Ao3s5Hl85dJedS7C4V/UEq3P0R49LESbDqw7tPwrwrWaByvSRIhG9FpkBsG0Z+hGQ7t7NtfPSVy+TVX2M+O83Ulu/Xyf4CIXbnnk/PUF91iBgiWM/cWdMh8/MNL1dgShtapoTpCLgA5gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640643; c=relaxed/simple;
	bh=SF/rgFgD3n0J38wmcuaiLavbtycB77OobguiSIFex5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+abEic9ZLHWC3Ikxs0e7IDC2cpBTRB9QtwwZ6lFc4lbBTyNcDC9QVQq+btUY/I5ga6mczvsIhbfUqXepW0JjkNucCsyXmi5kihxxQFGSNAnGA84dqOz12BZmvVXrbmFkZH8ek+s1dUzo1uIPw6VHlfVfhVSUQ0yHZUsIz6bpEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LBR1XtNl; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxgDDSJ/QQfda6h0X/hWv2KA4XXSomZ7UCImGnIF9VRGWVv3se/7wq8+OZNqomqwKdCPAYpLmudwpeCrHQ+NRljK+4ZOPm/++uZrKSVxsVy/MQSoWNf3mtChDPfc9t1nJVdcfxWMUetaOGzjyYZm7EzHDJ/wuI39DN0OYkapqOBY1SuQHV9ZLKuAJpMJ1irM/zq3kXndriIGRmhSRftrpA3Up3UTbbUuqPurfBtSm2wAOeuqs+oEEzXx/p9VcUPz8SsVOdvNjgo2dOrre+6oYmqlr1EZyKUF4bd1T2SKQel4oeISPFS+ixL7wceH9FLowhnccsll4+7qt6n6pbhWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/Ivlum5XTdg76eZQamFuxmbPfXlvjD5gDWV8e9fx6k=;
 b=JeTfC2LoG8FyzXQKUEHXUbKRqQrfCfCbwoOYoO7+jXhTAzeHrbTPyYKeWSj0xrUIkJmOlLe2Yd8BiCGBEXZ6U8SkpbV7j158hP4qr6VRslJjdMP6+TSSx36ALrNIkwWfm9TB8DhzOznRRCnHXbM+NMrAVW+qRqZrU5cyV9oRNnmc6nTXFIHJywVTXuO/A9N6EHerzEn33wpILj7Ws9vqMn5kmaQUsoZGbLkKwl2ibhrDnI+csDxIGEOhZahNdUKmDUmNbmteGLe4cMkNBNm8PAxIZNAeBFl5kNzcv8I2g7tT6V9PJtLM5S6IdzwyMyaXJ0JN0mwZAGmSOjs4jpFlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Ivlum5XTdg76eZQamFuxmbPfXlvjD5gDWV8e9fx6k=;
 b=LBR1XtNlI9ZuA0XVME9YOn0BmcGoIGaK4M/R6bLGqLOwq/KCzx65lQiRd/hpB/YenXiSq288g4Id9AvTxChPbACSv+YmIdyhQFd3bgPp8VnSF0FQ1LL9RLm6mm6iFOvNw7dIpWkb9oaffPocnbeG8sQ/FTebKgveB9GPEKKQCxY=
Received: from BY5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:a03:1f4::48)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:03:58 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::bf) by BY5PR20CA0035.outlook.office365.com
 (2603:10b6:a03:1f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:56 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:55 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 05/23] cxl: add function for type2 cxl regs setup
Date: Mon, 10 Mar 2025 21:03:22 +0000
Message-ID: <20250310210340.3234884-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cc00e9-92bd-431d-4db7-08dd60171336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNVzZsVVI88xId5LNt3WcN7AZEuJT0nWTPS2rs8M//GwkpyqBX9U267Xvilo?=
 =?us-ascii?Q?fk1KAe+vFEof0mOtKtKJn1kTxx7FdQqwShF/J9sjEK6E3/i+REl2TqqaBj0V?=
 =?us-ascii?Q?yJosRdENFE7Wk+XpgCQAe1IUxF46IfW6GuGsr/fQQ9OqDGod/rwIDnD4KnTG?=
 =?us-ascii?Q?/6ATReYwKnQKItsR2aWYxFcQHT5jVzuzE8lwbVw5gleXMoB2+COG2mpSTmkN?=
 =?us-ascii?Q?uGjWV6e5YEvSO9zPJSXI9R7UwpS0czmRt2e6No+bRAb8shnjUGqN0aN2jcS/?=
 =?us-ascii?Q?yiUXt2tfNVbDALukGQcCBGaOBRfB7JZiFIMKb/fJTXT0gaV/xH4SAn6oYs0S?=
 =?us-ascii?Q?4BHxRad/a9ais/Q9HPHTdK14HPwMOIlXI/y9Uuhibhgwr7D/7sTyLbjTCyLJ?=
 =?us-ascii?Q?AXAc1RMYW2xIPkbBxiH3z12BBddLkUXEdmkNwCFyMKHgkCBB60OeVlOG1YUN?=
 =?us-ascii?Q?dPRjPR/vA7HquhgUMJIesLlX74YAarzxZQNu0jYftoc6iEU6cjZuq5mTXdtB?=
 =?us-ascii?Q?t/rpc4IkkBG4k9kJCuHYyqvUdgVfVMfd/GbpbPo05KwxtTo1vknITicQrJO6?=
 =?us-ascii?Q?JGvwb5DcuorS1Ij0I0oFHifWwi43BArIjBukdyBrbYTsSyDfGDYkwPPO1FSH?=
 =?us-ascii?Q?FLOFJBIMolc/AuPKhI/FAHkXwQ7Lc3vhNatb5Cl9AlhRSaN5VsZMxlHSQaBl?=
 =?us-ascii?Q?YjrOZ6EY5cUC2q7FwIG63oEonkTYwvklFDaDsPkh+YlqV3Tb6OaalPBTPEdW?=
 =?us-ascii?Q?cHuqpZnh7XvsaWjYKCCkACJf5O/13B84q+3/1Ne6SoRdhXC8rj4d8oz5TX3A?=
 =?us-ascii?Q?JGpD3EgxSPWkkfusH+9DvBMWou/zpphtWg4C3Oc0bIfarK3pvwyYrlqmXVnV?=
 =?us-ascii?Q?qaDdqvUp8QUwI1jdI+WhCq/d+rRJfa0JtXUUyn0rtmQ3Y9KlubjP5Qk6VRAm?=
 =?us-ascii?Q?r8jjpICAvIvILzooxDnozglgygJ3P/NcArtzd9gmKXze1m35UkjJtczB7Ass?=
 =?us-ascii?Q?fuuzsSP/gbSjlYYww1MSuwzRmSVY2DfyfyTSwhT39TMk85rAv2JSh9fbb3MD?=
 =?us-ascii?Q?wbUk8EWFbouenT8EDBD4/ZAFVewG2lXkpnjsqfCBpacrj5reJqPRwQPti3Zh?=
 =?us-ascii?Q?jwWa2T3e0hlNNlvWysGR88rcvHGEKYk9demGaT4ILvj0go1Gi5e5OCyTMVTD?=
 =?us-ascii?Q?kxvteYkOpHqSJ88aIHgIFJVYp80TBbTLkOWXQ3PBl/ArfbXsFvu+Z1mtvqTg?=
 =?us-ascii?Q?nC210ySPa+uxZKFJ6sNqCCUK4B1fzQerDGuOfHS6Cd43cB8wsFsBDkJa7JfV?=
 =?us-ascii?Q?utcyKGRNhjcLgBtJgiDmiUxiw6xoZllj9NjjeBo1A4mBRKNVeCnlFoevwZ7M?=
 =?us-ascii?Q?XvHB3siSuXalE3ppGYOljqxie5FN6h2b2MPyyermz9at7mjA+f5tyC0nJaQn?=
 =?us-ascii?Q?0ZeM1OrCfY4vxbAy1F2QlvLVlGPIsVtyE600VzxQX9VRgiLdczWO2Gtv5QhY?=
 =?us-ascii?Q?Y9EhFh/45FQ54rA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:57.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cc00e9-92bd-431d-4db7-08dd60171336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 05399292209a..e48320e16a4f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds,
+				     unsigned long *caps)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps where the problem should be found.
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
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
+			      unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds, caps);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, caps);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
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
index 02b73c82e5d8..1b452b0c2908 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -223,4 +223,9 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct pci_dev;
+struct cxl_memdev_state;
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif
-- 
2.34.1


