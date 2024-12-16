Return-Path: <netdev+bounces-152282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEE9F357A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0286166E12
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03D1509BF;
	Mon, 16 Dec 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qgvPy6s4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A320628C;
	Mon, 16 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365467; cv=fail; b=WbC0dvK/XAy3tw6QokM1Zbb/6dFJ4v2B66yGJkzwzQud1UNt1QtYqNZXFAcYEPw6lReZq1KPOW5hYCYoSgCvccNz2/bAo3by/BEqGjU3GWUiHW9a6moZ8AYQG/czcrJFLhsEc1+1c/zOivQO2ZRrGbXpVsdLghnyLTLn83uyuG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365467; c=relaxed/simple;
	bh=JCup7PHOAx1Xw+rlb8dH4prkmnNUmXKQncUVBK9btcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUtKc+v9kqeYG9AzLg/eaesNssVa+34qLMxBI+ZOKCD7LUbTX31TCf2Ld3BcjGtg0JRVrPHBNBplCgblHannbR1EFF7MUe2uzV6I6g5dFUO/ZsMApyKiBOIkT6Gt0/2Wx+LIsaD8GhHjpdhosKmWh6rEn/8fS7Ms78/iIxHhI3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qgvPy6s4; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/COWnnqEqamJZqcfkuuua5OqJ/MdAOAmsIlcMU9cG3aOot9N+59e1afEkZC6ehLkoZJKOkON593ui2gwzsr7kcKoj+Fz3OJaYEIhMsg5Rw7OIy3y63jGBJHszjEmZNMN6mcAvZGvHmT8ZJQgiLu3D7ay2UiRMhOr7yk/0O+Xqd2oMEEwwAVOX8+mSLVF3LrRupR+taDBcl979o9UO6Q1/r+OworKkC4ceHhJ7SdeXX6POT3z3smPSf9KglG1zxfwQzc78xHMZfQKbWvjESx6LyXpkEg+N+LeIt4lq8R6O+qVCKX71MxkRUSlcn5CEC9r7UkXrq/eEJyYpxoYOKHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDAM9H7efLEUMiHNabigx8VgzwoFyLI5laLkDY2U9VE=;
 b=FrR2dw3d/Qz299og/97U1qyk0vh93/kLlqhy8D6BePxTgXfIDJh5ofUk53ac1oBau7vr1GQQfDxrT/3MiGOzMOUuWhiDsTEPDRsXCsi19Zv1cuP/Memz/9I8L8aUGB6Q+0zbVky9iswkMaIU3Mi3CgBX/RxuR8NUSrVS2u7vcF4JfCXVY6JdWan56KxSfiSZTiRvKRGWc30D9JTTo9gm2HwJhQjcJ3mewQ0NdIVPn7ms3lXxcpNsojxJSKwJuFp21Il0XKyxGSPlZF3NPTqvWsXudjaqhOgAX6SUNqu8+LlDE8unMH/nKLvFiGFZSEqchaHtPPhjDY5S56Y71YByCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDAM9H7efLEUMiHNabigx8VgzwoFyLI5laLkDY2U9VE=;
 b=qgvPy6s47/hZVX4r4BXXsg5XVEy8PPTUm4OCE0s4frxBZPH3hEW/xkXOe+YMpJ+XxgUswtHZJ5bX5rwGlFjZ5pxBDjQmDpGHnVZnFujzAw0zGfMomwvAGRoEJMTUczSeBNIDndGs9BMIHxS65Ll1xjUcFNnnlE0O14dGhHZAFNY=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:01 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::f4) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:00 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:59 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Date: Mon, 16 Dec 2024 16:10:21 +0000
Message-ID: <20241216161042.42108-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdf0756-6709-49d5-e92f-08dd1dec3c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGau2Zn62nkcpei0o2MRU0Ye9lakWK/hVhO5spsaEhKCqHm/M1ZYsLRTeC9H?=
 =?us-ascii?Q?GM8yGIKZtQFzNGdNHzsIHaazU4LrmE4W7VyUFrIrrOexvoiMdym2vIbGMLXq?=
 =?us-ascii?Q?ksuVk9en6GLqpoKDToKjl1Q17kRYwlqMeVJKQsnDeLJyP/ikPk6K5reKLdz1?=
 =?us-ascii?Q?YwV4x56oE4Kdp2YIZnfwMcPFOPywUlRYlSy9RIlk8RDm01wo4+TSJ8GwzV6f?=
 =?us-ascii?Q?G5Mdrkmw2KaqSykqKKFIjFJ8GD7zYuZd5L346FCGAZ/JsYlWWkIQ5mroKjx1?=
 =?us-ascii?Q?WlvlyQh5najhvjDAiFH0qkIvVH9WB97zE2DGCJtyudVlAThJ/uzz4b4REXe5?=
 =?us-ascii?Q?9ljP7bklqnc0g4RmecPAtrXuNuerOJGiCK1MV2oEFJO9zU8Ki4hFlKaS7zPF?=
 =?us-ascii?Q?zU24SdG9ivw2C3n3JIzNcpyV1ZmpyfrYjv8kBadALx/ri72kOyRq6v4NdHou?=
 =?us-ascii?Q?sM3029kn3XlcqsqUkk2Bj/G4Mfw3DnjvLr7JVPnNBFUSKlrOQO58PL4QuClE?=
 =?us-ascii?Q?F+PNJJabzK6fynS6sWGlY1xKVuCKOy199dTK+gIbv/Nv8BHw79dXJrkBcqr2?=
 =?us-ascii?Q?RbYZVeoNNDnmhcQyjUn12od3LaWD9k3KF9NdFd/wvi59VowQf9AFKoDeip8D?=
 =?us-ascii?Q?QDF+rXCvAH8obF/PHQZczBw2r5PJ5DZ6dh/5HHlFtd4QKxSeKHuglUG9Nc7c?=
 =?us-ascii?Q?6U/cYIRj5fZD+ircAjbVe11iNczJ+mpZ+b9yutz7CSI3KInBbigMyZfX1eF7?=
 =?us-ascii?Q?nSsjoFlnjJXLfNayFT4BprykZ7HXqLswBuso14C0fo64VZIF1ok3uvE5GGBW?=
 =?us-ascii?Q?+wE4TXq3BoUmuL+rW1ULVsKGPgVBfx75Wcd/Eal0gJrup15N16frTkuhVD0I?=
 =?us-ascii?Q?kFA6opex6M73P7oKceryS+ZszHI1+aY8qlaiEhbMoI33/wMUbdX7fdYgVwX2?=
 =?us-ascii?Q?6s0OiXUacujB1NKFMuZYKDwpQIGcerrRo3BmIOSiCiyPGO+1X7U6ffOtKIE9?=
 =?us-ascii?Q?2EN3bJTHRzTfZETObUfMc3TfSEsY+1SLpwIGQXOlsQm4lOm+x8RgXj1kijzL?=
 =?us-ascii?Q?3WJV+bBwZphY2fq7hzfYL4oR6w/VF693CuHcHaYaGlbX406N7EXgfYDNwg9x?=
 =?us-ascii?Q?SyBH+WwXYs0Dv4lPRPuZn5dzvdpc7kf4aeA7pnw0cIxcvvDVyzglCMffNqSm?=
 =?us-ascii?Q?rsKfGuSdRRSu5mB5cOOtt5TjKBimqJN+A4+6FC0E/7raNd65Ch02h1HAxK/8?=
 =?us-ascii?Q?tFk31aYR7ze+fFDbSNqd7L7J13ai7ndeSAyzTyZW6FasQkkmaVnmcnEWM51V?=
 =?us-ascii?Q?9xB3ncKQZL8/bYvaF8UL3p6ux8bmkwhBExKUKde3Y89BzNojv6r9jyOz0COq?=
 =?us-ascii?Q?meR1UIUd/a7d15zXv14Lth5Ofla09lNRjfuATPrywHXVMOn7Iy5S2z5/ip0r?=
 =?us-ascii?Q?ebaAA09t86WFRQKGpr3vyIBCmFxbejcDdKn5brRdtmROiMBZsrcheF9tvFw8?=
 =?us-ascii?Q?zd0bZL/87nxtEoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:01.2139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdf0756-6709-49d5-e92f-08dd1dec3c04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3cca3ae438cd..0b578ff14cc3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
+	/*
+	 * This call returning a non-zero value is not considered an error since
+	 * these regs are not mandatory for Type2. If they do exist then mapping
+	 * them should not fail.
+	 */
+	if (rc)
+		return 0;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, cxlds->capabilities);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
+		return rc;
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
index 05f06bfd2c29..18fb01adcf19 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/ioport.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_RES_DPA,
@@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


