Return-Path: <netdev+bounces-145943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511489D1597
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC6DB2649D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7441BD9F9;
	Mon, 18 Nov 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="migTuVa9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6A1C1AB4;
	Mon, 18 Nov 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948300; cv=fail; b=Ia2a8dK70jXDtWxqdA07S5887Ca+HNf77Cq/NFfAd7Gk8u/87yRTkGTV1dB9GSk8NYilsLkEbBPuUxHWqBW5y8gdimXfoTmWLbvzBSF9PlK8oEhV9Atp96hzRkqm5QhRGzehTsyXOAwJ1ml2D2n8oHcDK30rVR24qrhfwSo12mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948300; c=relaxed/simple;
	bh=u39dTh3lLxFT3QghIkvWLEENG1Mv4piLmNw7DtlJvXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7AqLsswkoRLVJNsV9r+7Ujd96QTS2T081N3njOs9+T7edeKcYsaIxisOa+GEjCygDB2WNSPhei//7eXCnva8p6Yrya/6E11+0Ube4SCPsUFAuL0ILGaZ80Cx8fQzzLUUm5PQxRdNlHpC0bjm+evCOhHiOv5nXY/3mu7v24Riew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=migTuVa9; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGoDcqPM+fhhqwzyBPvxClPBMKi09rvBmviCaXzkM63c9i0Gif2ci6GuwGgpK0XEdLzyJ8VGecCYu05lbYUQy0MM4mn5YPQFdCoMirNU01ZgVvfOtRNkkWOav59dROjSdKU6Q0yF+azg1u2ZojkLMnGG8kMOP8S+y3jZxIAGWqSF4bgKTZhOG2LJlDivaFRcjaxir5mwQZyMHvFOsipWZ9rHRJEVCncOvQR3zSqa530M73TS3Z0UZYffj5MbK0KR4X6ZXb8tm+QSP8SGDSYG4zHEB0jpx+Kpd+11nD6oV47U1JJgkzvAxh37UqHo7FLfQNLlSdmDvWvZEOUfhJdGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV06fflleZ+l1IVhaXX/spVI/4cZTPXS0ZaLVyAdE3I=;
 b=ddG9KDU/QIbdJVZHLJSK+nFdp4bEhUxd1biG9uoKVSzA3FgquRk/TPEcO6lPMIhKjCcgAfu/dNsxVH3XdGyUegiCAm5Co0Asl6K/Noy2szUxX8BWVokTn+RTEEZ5U7v8ultFC/TjQWPxYHLdy1PEw4P1BDnpi7OWiZqwjgMknpZAgj0QEf+hxWTKFzM9gyy3uFIg9ePV0arnz3R8jzvBlir7N8eWxp3/k11NQeUvth9dO4qgDAxF6lDnfAIL8oF9OOnTSa/C4uCBSPywdxQISIxYl/8BJm8SOiBqMExMVCENnTLRBAWqUmBJ6vTtVmNOMYdO5PLifz4xN/7TwzpVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV06fflleZ+l1IVhaXX/spVI/4cZTPXS0ZaLVyAdE3I=;
 b=migTuVa9eC1ZkEDv+CGH+Y2HUroxB2sXlqHaJEj6KfVjyKBImj6U5+Sxnt0WjuGlslsJmoNuuoEK8+w28Ngza6JhY2qr8sFnuq6Y8IpkWSll2d/qLZJV2PXYNOaC0dBdKn7tGr+HVMoaVSABuJO8HDxWz3nIaHXhBiBHaA8b2JQ=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:44:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::15) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:52 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:51 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 06/27] cxl: add function for type2 cxl regs setup
Date: Mon, 18 Nov 2024 16:44:13 +0000
Message-ID: <20241118164434.7551-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 6789d755-b044-4b91-06a1-08dd07f053c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1YEeX4VLtrnGZWgBOdCAQVWG1out3ctdc2YDRwL1RjLLfNiTt91TCthfuUMv?=
 =?us-ascii?Q?fA3sqeesyv2tsN9cDSRGsX1YMOsZggSMjWt65st02B0ZtwHRJ7VVaPSwqXSu?=
 =?us-ascii?Q?alPzxNGvh29Q/wIq3R3rk2KiE861psYJTLz9DdhRk1ycUXiSZ5MZTOoBMyCT?=
 =?us-ascii?Q?GLuTWF1DaeSMOf5Tn5JSLkRfZi1ho+LFifbvGuIIVBfJPWH39pFqPfhBZzeH?=
 =?us-ascii?Q?1CTQk1VcWT9iyhcE4jwX5pI1Q13l7nUaNLKxr6ZUmj8psdRJvnViJg4RJoGd?=
 =?us-ascii?Q?mGqPfLyvL5gjbGNbDOU50cfFPmeHI1PpKUVAhr+zEmLaHrfpqpGzlGq0Ltxx?=
 =?us-ascii?Q?0Q8pIYrqTEssp7vKfgn29re9NBDvcjNoqnQ1HEjhUQ5UZmLWDwVFaKRJ35qG?=
 =?us-ascii?Q?LOQ6uQDf/o6l9SOxU3pybQ63YaoJpBLWMNoMarmbqODlHngEeZiqp6zqmu0y?=
 =?us-ascii?Q?2RltT8PhczURpE9wu2l938x271Q/zRVcNlxjFBMHKzdETRGXBymsdIcaqZXC?=
 =?us-ascii?Q?CGS37Ik5oFfK+pkj+BrE88w1iWM/uuZAnjGa+1n0KUZk7v2YUKy9wzD+dRQj?=
 =?us-ascii?Q?kTovXaEjd2m18+fI4tBwjCzECXyGRtFreP5vSEwNW1Tp7xjknmRYZ3NOIY4x?=
 =?us-ascii?Q?LBTFRbjGNf8VrrSxG7rfv1A5dsAOQlE4v5vWCNl1PCd59QHNB1wY/0VAFmOZ?=
 =?us-ascii?Q?ogLbL3EaAJ4wHLIzWqtLNzPoOylIKEUQoZd3dIm3iNQGWUW0HHHNBzzER3/o?=
 =?us-ascii?Q?ts7w6Vc6lSjXYCfUUS8PEHFZH28pDBlyxikobxzWcx5JnI3VNBsxJ5lBNov6?=
 =?us-ascii?Q?Fx1A8YQPq8Ak8iujjzq3NeQVEob5qzGGxLYehd7PU1FNtoWAqhSmp0z8D12y?=
 =?us-ascii?Q?cX19w/2JVWbpdKIuFnOmc3Wifv4v3i9IowYII2JSoxBUoyiFopNM6p140kJM?=
 =?us-ascii?Q?Gz5YDkgB+plNzqeuqRAqraku+PkOvxxSsghdicJq/Slcxuh5F9RYPJsV1dG2?=
 =?us-ascii?Q?OHnz/LXvYfQA4Hz6H+mKEQWWPT/FL2SqcQqfOv4qNeapN+NeGqVHqJwsmuMM?=
 =?us-ascii?Q?kf74Up+jvUsL7UiYAAdOwbSiPqgjHY92H6Mz8aSyBwYDmMa9Nx8brj1JsL/2?=
 =?us-ascii?Q?dDKtdYZcQKJmJTWl9oe3ZhMz6iEsaT8F+5c4jCAMi5owfl0+w7c2jvcambOq?=
 =?us-ascii?Q?cugeY+9tSsjkQqiNuhuXEZknM9gEJAwTJ0nYpHivoyHmboluueV3q9qgDSFt?=
 =?us-ascii?Q?u1/nDOx7jdMHXEMQKGV27dOD3LymDMc1UCmuamVg6OHbKZprfvJ/njx1w/LB?=
 =?us-ascii?Q?D/SfpTFkkcpgtEStKQSOlTRNv7WtOj7hOHCgRlmLSDLcx3GjXiqE73BKKlyX?=
 =?us-ascii?Q?iKIUMaOoPWk6VEAo9s+q6NjZ1aM/ugZ622VzAztz+ifSgDePTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:53.4663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6789d755-b044-4b91-06a1-08dd07f053c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bfc5e96e3cb9..8b9aa2c578e1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
 
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
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index ab243ab8024f..a88d3475e551 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/ioport.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_RES_DPA,
@@ -52,4 +53,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps,
 			bool is_subset);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


