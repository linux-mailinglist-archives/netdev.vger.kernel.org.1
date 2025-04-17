Return-Path: <netdev+bounces-183918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646D7A92CA2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF264470D9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CED20E02A;
	Thu, 17 Apr 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+eWfhV9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606E20DD48;
	Thu, 17 Apr 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925389; cv=fail; b=RZ5BR/99BF22XTOaEbxCehIF0AMSYO+NTqVXu9AihkvDQlgeyvkV8T6VUc5DjV1uuadGq0J/bxIovcq78Xr6wEpnW4jKw/JLenv4Mrb9iyVBebc8jY9N4Vci3Gq9MSBYJbxaKWylcm6jqX7F6HHQrEBsU5zrUcdFmkbMqckh3mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925389; c=relaxed/simple;
	bh=8ymTCQ/t1Aol5r+WU9j0pnHG/X2IT7MZbQoXy6AqzW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWJf3TJhkfvIpYKI+IclhtbzCRf3x9Zzzav9HvOPpKOeVzTXnVycRfR1dhJun4ztxsQPt/ThPQG2bhAmPDxjNWfUkRLEqYRuoLogyf8sZe8JoRfFvAyibxRjIuqs6EOIJWu2XopFXQVyaoaBUFnsx0MuVGCN7TWvkxjTDreeyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+eWfhV9; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ4HL0pdyXQebKHhFgxjVWyfICroUBxBadniDZcOIdJ+nrthrLfC3OBn99ZWvFSNEjOJiNZjbg1pF5Lhs9GdeRYwFl6JE95qogX2ycpljCJnCH13BPOFUF0bgcG7WoTSe11h+bumWiUr75PCys9eDDk1U5zJzDpTYfTxVURc26+oPtbASvUxOhHXW/zz0U92kyn5pn67/TqYdlicCxPhiic83IXg+7jmzEII+7LqjTxxHJsTywYG9QY4tbOHYxZcy9BtRzV3lInqlXt/YYK+tjoZ98D4oZJ6ezrXj8BYberkJ1k8VSPVfIFHeYtedRJ9EX+Dx8q988ryzzkWEOFdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYCA9bONfwd9byJzQqwimhxQ17k6XbAZGxwuW4aL0Xk=;
 b=D7qpRuFBZgfphudvpYtwVNKXn5Sfso1TqKXITc0L3HK0VlUN/c9V75AVPFdNi0Y0Eky+ZgPG9fOm0nCmnHjzbXYjtSgGYEiYbUfUzW5r5MQOPh6c4NuEcEx/dvkRW2lxMAPmSIM3QzmQgQt55ELS2SayBC6ADyehT59eL3XpXSgpQDf2bKQQiJZIM5fg59yc/GGQE2dz7EYkN/kd2CvHDExzaSEVDZa+F3e3Wlwu3vYfUxOY4Gb/3wleOTicalsQeQ0v0SnkSBvQx4gYRFcdYga0bBqUZroMaIAWsxZfNfEJw0TVN+K7YNc1xYd3UBAQ/IVob+tCymJJvC8bhgUa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYCA9bONfwd9byJzQqwimhxQ17k6XbAZGxwuW4aL0Xk=;
 b=M+eWfhV9N2uCUSBEl4W/XRFCVzI5LE6Nw+JCdJTPJtvX0Xh8lQRgH2kaEKEj5ZzrqCuadD47ARZos90HChJwY7tOR1gQXEKhWBVK1QpQbEZK6BBGgx1UEIcOp3KW2qaSwGMIux697R4NKzMP8Nx1EdFCovdmGA/TgnxtYbsk0GM=
Received: from MN2PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:160::26)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:29:43 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::46) by MN2PR13CA0013.outlook.office365.com
 (2603:10b6:208:160::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:42 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v14 05/22] cxl: add function for type2 cxl regs setup
Date: Thu, 17 Apr 2025 22:29:08 +0100
Message-ID: <20250417212926.1343268-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: deaf5c65-5bbf-485d-4594-08dd7df6f7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQwOimiwKEez4Aijz/AQ7aq20u4JYI19XxFqPUtNfNzCMzE61N41MYDVaCa6?=
 =?us-ascii?Q?MC58aCSlyu6Tb68du+Vjgqa98JwQIW0X5jEGVtnWaqdaRmG9TlZerG+ALLTb?=
 =?us-ascii?Q?E38XCHk7nQD3dtwL8S6GJTMLmCh7Or1ZEiLFVGhAghBd7GOO30UScbH2bCSw?=
 =?us-ascii?Q?mZnWiG2C5kWq9W+wKRxb/WzvEPVnHtzqGMqdEmZwTqjqxWOVJh/7CdMxhw0W?=
 =?us-ascii?Q?FeTq8pCUel+L4i3nk7rskgRhZ7ViAsKE8No4QbYxh1crUrbymQVdfw7qs3hs?=
 =?us-ascii?Q?nA9rB/PBq+RLA0e9zmXnwec2iPiz22UczAp2L0ka1wX0AhpPRLPe3NvVjei/?=
 =?us-ascii?Q?Cyp5dW9dmtaLd1SURTTY9w5Ul23Jyxke0egNf/EVsV+HnQ3QGRjiy5YbTl/6?=
 =?us-ascii?Q?Q2z3mQtAdbPkZtXrLKYSaAvP/opthohiFjCYC91XajJbfRzX3mlMVqo8Jz+3?=
 =?us-ascii?Q?zft8mnjT4OmnRAoatwJ+2KTIH7GUW6CBt+qzR5WTVjIm0Rv2Vl0OVVuHAbag?=
 =?us-ascii?Q?m/+awp1ebJsS+RBRbNlbgyrTLX9jS56/zSYZ1ycaneXdCTk4HkdxMeLakkdA?=
 =?us-ascii?Q?rom/YXMFaPE/BGVYt80Kfj+D3AUPBeBr0LD9pMRE7laKnya4L45VSlRW1xe8?=
 =?us-ascii?Q?TBSJjM5vrQL5YU2031FjZ7aBFSZcad/kfX/PwQ7BeWb8rBW++dSK7u+p3bL5?=
 =?us-ascii?Q?W/TdDq14uyunQ/zGfL+s4nDf6EDx66Iw64/rLnjrGckLdcrBroBWRK+unXh1?=
 =?us-ascii?Q?inh7n+auqfDoJUclB3unoIre7+GxoE6S3hpFpBi7g72cyVzS6RMI09mfN+/h?=
 =?us-ascii?Q?/8u0mtPNmmXATXQCGLCSzhdMSGvq8QmWf6dYSrSNL9/8meupqzBqrOfuYpfK?=
 =?us-ascii?Q?hvIHXlqYWiV6toh3nOIL1auXCpdzf+d5Mj/dsNseMA0EqaRzkvyPQRyH+Aqy?=
 =?us-ascii?Q?2BlJe477GzzyOO1pTIS+vGLY/9R8PwPJat8kohZ1ne0Msx8z485JlmBm2ZdR?=
 =?us-ascii?Q?cAty62C+E4XSDjOBCUVPHrkFRyhFAd0QrIUuNf/NWJ4L/H8YlXbUAbyZk4kM?=
 =?us-ascii?Q?gXN4csJZqCkpmxuZtiNVmMHr8W2TmaVbpd7iTRs/8H93aStAM0QhpfkL1eSs?=
 =?us-ascii?Q?8XKb4mlR99tiMYER8dYhX5t3fTs1DMQpdkqV6xWzj7MnAO1CvcWYKgYKIJVF?=
 =?us-ascii?Q?p9KTjukpaly7FfkVhjlzjiWk+flluEQmJj1yrFiMAmsG0sit+ENL3gPKDe2L?=
 =?us-ascii?Q?DCZ2emNk5NepNe5T4cgOlRGHEog2DaRZ+f5+sj40y/oBTYw3+EugqHhu83Nm?=
 =?us-ascii?Q?W6M0ZgdegaWDE0sGKkXN6LjcgmG3iiIekvhuKQMKu6+DUXVA14UIj4o6YfU7?=
 =?us-ascii?Q?RzJRTA45zdyjpf9j4rHV7pMT+Qk/cbyYJU3nFQISaR82CvHEB/FX1/41tLa8?=
 =?us-ascii?Q?Q0T4wfINO2BIUHC9QuC+tEKLM+Asb2tKZMR2qkECheNhx1x2Kn5u+ZHPTWY9?=
 =?us-ascii?Q?0V7IHQnrsa1JgENjQ1rNcnGgIrwT27HUM1w8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:42.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deaf5c65-5bbf-485d-4594-08dd7df6f7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ed18260ff1c9..309d1e2a6798 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
index afad8a86c2bc..2d8b58460311 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -231,4 +231,7 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 struct pci_dev;
 int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 		   unsigned long *found);
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


