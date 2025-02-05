Return-Path: <netdev+bounces-163039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05484A2941B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259BA7A0444
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831C13C8E2;
	Wed,  5 Feb 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IaltoffP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BB188704;
	Wed,  5 Feb 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768810; cv=fail; b=Jc8XbXe2DjTYud2tpNMVCv2fIq+csvRrtVB3lSBDOYoM62WFjOjcXrCNn97itIJcx9d4AAsnMjRs8TQzpN5v++DfUHe+rB4OZhgZwD16s9CSJJKSxrfHC0R+B4whngJ6HmiraT3u67QhXmToBVVj04ehJqDRQY5JenqRyGySccM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768810; c=relaxed/simple;
	bh=0w1WFdFc+zSYTUhj8QimegUiZg8B6bPUtqsaNEUwB4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndk7xG7nzyL2PJuKgy+FYgePJ7ljVvNuVGD/pkdLgDJEKAPU2tXRTg9/RvooL4/CEkA8MnqOHb9ZQhk3VBnkqEnK1gSRQaY4pP8Gt35lezgXQ5mRGyV7fFJrkLlBYvM7fpIMPVvEb3CBjQn7Wfl4satjXQRUhQzkSSGmKjuShaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IaltoffP; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S05cQPNJRMFqJe+ooMaHOgdmes/ZtzVb5xLHwB2QdCI/QIHcwUisLXU57zpg8y0qCtYa4fwzxUP0WC2hAbDTHZZQQow3jc6cTwnX/FUtdnfxEfqrJMk2nq8O/EdncVcOz1Kl+c5I2W1xvQ6Q6sfQ6Y9QUlc/itAb1RULYVYbU3LgezxfPYYBv3au9RDLIXbfe0TIXG9U4Gbjv+3TgnWyMZ7b21LuQ6aXDX6VDip+1kVCNmEjFtayNc+m+usQi4H59rWoozTAFEXh2OJ1drKFvlH0EabVKyugZ+JiYot0wsCmCcdeQ4nVBwuE+exoKvhmmMZv86L3ffNNyOByUzbxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4vzqWuwhOnY0u18Uzznkaw3fQfreLIwyH3HvtUiy50=;
 b=wQGi+v9b16ZVYq2fka0EuUlMn9k4Z1rwAp0J5OAfcuFkG0m8QfkBa9gRKRX+8PFSpdzNRiUT/rCpXnWBSxKYILwfIl57yRJP1TD5Lk76N7cN+A4pwaq65YK8MhHJdosau5rhi4+3ESuDVaEjo0vgzTOFMR2fSWor2kclmcAT6WuFfLKLmGaIFD2PzfSJyihok65b8bwE6pGumo9bEpEP8+R2YKsRHsljDFLWkC0oy+avFX9v+k6A47MF7CUkBBPo31EOJ5uBo2lC2QeZlYcJWiMrn2g77NZM9Pr9dNBPieXK8Z03w29tH2KS9yAZTLByjecyPG1t0t5FaeOE8/DT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4vzqWuwhOnY0u18Uzznkaw3fQfreLIwyH3HvtUiy50=;
 b=IaltoffPom44ksHTrKyNn5fa2SYK5oco5E0w6kibXSIIBxALF+oRagW5+QzYOUK2t9w4swyqhEN/8U61fe3Uii+gmbmDgcH9CEC0QX9FHOA6PBIxzr84CVp0i0QHrOHi1f4nM8jlT2D+qagehdRoYyskowmXlEklcNfCB2P6guQ=
Received: from DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) by SA1PR12MB7127.namprd12.prod.outlook.com
 (2603:10b6:806:29e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:20:05 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:8) by DS2PEPF00004553.outlook.office365.com
 (2603:10b6:f:fc00::51b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.2 via Frontend Transport; Wed, 5
 Feb 2025 15:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:05 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:04 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 05/26] cxl: add function for type2 cxl regs setup
Date: Wed, 5 Feb 2025 15:19:29 +0000
Message-ID: <20250205151950.25268-6-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 78981360-d86e-47e8-7cae-08dd45f891e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NCW8MPAyyuIP+WaAjAGZffG8dWPTuJbprdD039HCPV42Id2J41sQ8uwrGYbc?=
 =?us-ascii?Q?psHXUeqo/sBfP2BClwfRZj6qI1dBllNY52L+KsqQYL6C8KwnZD97t0Y1oOTl?=
 =?us-ascii?Q?gDQLNFwN1ZKpSfaEoG5AJcYBaLsZ1SigndEwva8+J+uPN5poxZEoi45LcLIh?=
 =?us-ascii?Q?il2/xL7bGsDAhLhISMzAn56eofU7wY6wrYsmv2z7PHG3c48+wKtOq4fkecdx?=
 =?us-ascii?Q?GcwamRI/ydGYeLbqa5GLUSQptNC+M54BOSKi3fMSNATdLiIhIqWVEZSN0Zoi?=
 =?us-ascii?Q?as5nCtq8LAHgCaVrMH4eah4uObfp/BtMajfOSWrgJ5phkfXiqLn9G9x60iWi?=
 =?us-ascii?Q?/Oy+HqOxpQxK8rMgW0xczbQsU5T9QToiVw+CK5bger/ZWjnzvm296CSQrRkC?=
 =?us-ascii?Q?PIWwr8cfoOlbJ3GrWLOJqt3g1cRR+8nPbYGvBtVyNeRs7UvS1MhG3E7Mejed?=
 =?us-ascii?Q?PUv5xvq/XOVK58gsAyqWMMkvoCyhMZfT5+qkiJoWk8byGvjk/5v8P8HXJB4A?=
 =?us-ascii?Q?p7K+y2jtCt/FIuPT4e8OQBfVJ91XzEU0qCW/XKmXLKdgPA7tyMNw2D7T1rYn?=
 =?us-ascii?Q?vOiNYnSIiwCXqwoPuKvUFTcuVhXvj0jRdjy5Ns19l+k4GwWV1znpXM8NOipw?=
 =?us-ascii?Q?rS6QHsHml1T0AXxm9uPywZCqrgTzvAsrALuGDhILi7XRawCQsxP9BxT7wDCz?=
 =?us-ascii?Q?aKYtAKSmWiJcfayq/SYCiiUnQgFrWt56a20Ej+ntXH3r06q87YpM9FRDsoz6?=
 =?us-ascii?Q?T8qJpquXyTgnpghmKgknv62QFidSu4juNe5mcJsKg7BhGwZg4bSVGivg2+AZ?=
 =?us-ascii?Q?gI8DmFz7mQbtd6QJ2z/H/qGh0ukD/Va1OU2GPlnowDPDH/TFRGDOfCteo6Ka?=
 =?us-ascii?Q?VAyVRQ6+E31NPLhhzeECvjy0dRBrrTqxezTfyI3/EQqnQofjlgWx+GV1KquD?=
 =?us-ascii?Q?nffmmII+34vgibqEsegBqFYHZxA4K1WX+2Djc6W/R9is/r5QLMutIiw7RkOG?=
 =?us-ascii?Q?4zh54JcYvHxNpv2Qxts5ENznqsEX+4BFVwaUktRCYvnydmj/DYFAij+Iow5E?=
 =?us-ascii?Q?1yeEfdQVz+/xVCmzddvH8cUbzMwZ8NS8TYEO+xfa6dVgDpQ+DvWmzfScAqtx?=
 =?us-ascii?Q?SrfLCR97Jg88xZ2t911+KIyV/CK8MBJL8wdPhhyUgZeYAlLBQ0IdlKpew02o?=
 =?us-ascii?Q?rmZwZCMRROuTujd/SJPMhHm/r+PjRgTnlR6WW9/2QZgGQC4VqNR1SVk91eHo?=
 =?us-ascii?Q?+CD7qU+RDWzQQIEpY2MDrZOEARFX72ucojO2AD5T7r1Bs+IzJl+fBQ+rWUaB?=
 =?us-ascii?Q?QkIsrcpgwbZink9y7Rm5sz8r9W2x1t1gzNxuTGVtbYxMoYCRxQ/fsgkbLwzc?=
 =?us-ascii?Q?AQtVaeITyvYpUZblmHmI+pmObqd+xN0oDVSPRRfSDFDpq2QwilmPKPel3gkB?=
 =?us-ascii?Q?oThne9b/jL41lw2+N6eE+SmVihKja9xV5CbePFyE6zEddP6wYkTP6UpsynyP?=
 =?us-ascii?Q?HOGt6BsHtLjJRck=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:05.7120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78981360-d86e-47e8-7cae-08dd45f891e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 973348aed6c0..08705c39721d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,59 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlmds,
+			      unsigned long *caps)
+{
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
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
index 790d0520eaf4..17bf86993a41 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -42,4 +42,8 @@ enum cxl_devtype {
 struct device;
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 					   u16 dvsec, enum cxl_devtype type);
+struct pci_dev;
+struct cxl_dev_state;
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlmds,
+			     unsigned long *caps);
 #endif
-- 
2.17.1


