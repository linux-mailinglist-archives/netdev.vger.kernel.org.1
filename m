Return-Path: <netdev+bounces-200668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE35AE6808
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B2C7A728B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC52D5425;
	Tue, 24 Jun 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JShfGzOJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4362D5414;
	Tue, 24 Jun 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774467; cv=fail; b=OjmCX0KVhdTitg+uihJVYmy6vMG4880cJl3Cdag8uctJNaF9mXeoWDsz8n+unvtd+dL0InkCadRev63IJuWSu2mzCE+V+yMvMw2gAHY7vBwo0C6dr/FBkBxuanNnV4HUJ4gOmsruEvg8jDru1w9gMcgiSDeMFx+mBazBraIZ5uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774467; c=relaxed/simple;
	bh=DHNOCtZx2tL/OiH1x9KQdSQdQ4bEBwc3BZlfUlATwvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ13ursukgvsJfaRZcLAYdJQIO64qX+AMdszyMuQpbqoAESbBkwGz8WE+frWIHmrhfHvQikxzbQmlJyCG8zlqMqV6P+INPnf4QdNr0i7HpDZ0eMLNTjnHI/qOE//DNbmaaOyMGaTJI39NblGxOCtXKmNXWsEDQ8H5yS+RgiaTc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JShfGzOJ; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXh6UWex8uftUqqepxSXpPA0qgohWczidHffJMoYs/P+35yVWXGEtnRb3piSYLjho5Hf7b+HRXEt/PKTFM9PsMQHH6uDAR0iQ4Kz2Eohy8myDfVF41dulg7DP6Mo7ZV0bQb+eAsY1p8lnWt8adUTPb5YU2KPUgh9qU8dggBB7FTGho47BKSfJELF84FnOt51f/TgdNSQ7wn1gdmilkrWYVOs/76K2iJH4U+BYA3ihfEwsxuJSei6oCbK4oONUK8QMylg5v/r/rNwAMa++89KEVTDM4IGaXYEVO0pXgeiy0rr/+uEXqN78FKTnkQAmet36cUvuP+XyhFZtRfMLI3XLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNOFkPYDNtRpAt/xnVkIv3gBz3HRrTxP00sP8I8pKmA=;
 b=tasNIwGyR8KExA0j+uWULCvZwbak0285bht2x7NrVqsyhu8pVWFtVcw2Eq2YhrGgJVYhMp/93FpyT+eMfUb/YzFX9ftFxFbsf0aJtu4aoGUohempiPXMhNUtuTkmsv71VRTG0u7JssrK6yfcexc7nZa+ovtEIBy5Hbtq2ZxwuBsJOiFBCOaPhS4jIPUUZNi7SUWyylbC/xL9ZhcpXSGjGGb8hxqjcrs5ldb7qsgzuZCuQ94kghsRF0d5jtF8/uCgvsisNeaEuObXzPzZQxEHbDO+k0Nx+arswy8ufqtz4YJ8lwQ4uFJoFFPp+gZ+6tGAw1SgkQoTUH6/xT4/Ky/E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNOFkPYDNtRpAt/xnVkIv3gBz3HRrTxP00sP8I8pKmA=;
 b=JShfGzOJALH/eTqCj287kWsf+aHw2b3ZA4kZtUwvjhWI0xTwP3D6/bvcpuvFho/GggjDdP/+G19uTGxGsYjpCRVjGSPTYQw/OUeYJjisExyrsD39mSE7F5Xbkiwi/FQ5xIoGHEPHy5pGILVJIIHhLb2dW3BK40YfyjfP1y0BZPM=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 14:14:20 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ad) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:18 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:17 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 04/22] cxl: allow Type2 drivers to map cxl component regs
Date: Tue, 24 Jun 2025 15:13:37 +0100
Message-ID: <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: d67f65c0-a7c7-4af6-a710-08ddb3296951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wqsj7Zqr2q4oDcbKeLVvhBqt5Qty83v+KzqFdIyn5ZwEFu08G1OKZmiv27X?=
 =?us-ascii?Q?zX0f7n/rk7vsk/gRynWtZcWKJXQvAd7azyRfFz9kQ+8ySf5XgCKP0ObLVJCC?=
 =?us-ascii?Q?5QhBQb3ESYpNBI5GDAnCilYwgF2e2M0zEna2oNjr6rm2pw8jCbgrJyg/rYZE?=
 =?us-ascii?Q?NIK/gMaB1uvxwVWgEjSVR6rJ9ae5JC/NkbLHpsFDvnH7rFtwun/HuesT3FJF?=
 =?us-ascii?Q?bJyAC8WlPKTbFiWUb85AutuduN+2Vun+0KNq2xjRRTnSsA4K7y++frh4OeNf?=
 =?us-ascii?Q?iJXlY41be41PHbzKqHOlVI57BMs/6d9cjxVqNtMl8UcSQZtxoohcpcCtc3om?=
 =?us-ascii?Q?QXM4E4ajO9rqdDYbnyIMVxaFgQBqtFL8D7wK3ILB2r8Q5/fIoUZz/FCXcWEs?=
 =?us-ascii?Q?K2EC+2ulvduJ6ruqLgSmCVRvnF6Kg3QLpeWa8r36Ky0OiMpkOmjLgMQfvLru?=
 =?us-ascii?Q?gbJprzPYQhj8bE/leAZCD8hj2Egrz28ofSaUl0AqZkIJb6rUM9ritZO+GqWO?=
 =?us-ascii?Q?8Sm9czrUujdyu0V++y8c0fTaIlU/ImWzMIzPnC7jZ2Gl85DDLAQPAXp1rRat?=
 =?us-ascii?Q?wTi07zezh7yg6Di0CMcfxA+4ogHhsjwkFMxqdmlsiWcNGSK8KLkKCMc7EuxP?=
 =?us-ascii?Q?IJ6WeL22D5PZLbFhQVY4veaUUgiwWslGqrQpzR+6dgNSLcGYzyN9a0aeev/f?=
 =?us-ascii?Q?Rr/ADjz/ovqvX04Eh/wGQ6dMUMpT0hJhmm8fxQs0PhD5VQvEuu7wg/hKoofo?=
 =?us-ascii?Q?QD85UOOzN34GFXMdq3PvC5TDR+BT0M+scHIGOz1KQs7he8uq+XSAAdehEsO1?=
 =?us-ascii?Q?QAqcXdA5DVW6xCaNNDaJ+YhlmO6l0ehaKkcfeiZr56dxkO9J/glSzKSnKEJD?=
 =?us-ascii?Q?/O+nGC0pe8vgsfcGYRD42ZOuJTf/Gito+MqT5zegP1ngX7ILZW3q9B0MByHe?=
 =?us-ascii?Q?Rai4hFA1nRuc0TQukbHH74aPYMJAzjAWeivfxo+/2w0z022jtqoQWLJcBbR4?=
 =?us-ascii?Q?2hZJs8SywK7UQm0DE7JLNkmRPIMOL6QwAWLCNmp/Rc0E0AWjqJ8vTtGaMLDY?=
 =?us-ascii?Q?4K8bzXxLwf/QLb7RRGAYS+iDNMD2McqSHOigwh4/7TKB4ajD0EnfXE+8iEok?=
 =?us-ascii?Q?7Xn0PsDjEka0eid9mFkpoaH8J0Y1mzegpWUoejqoNDsEyM73lYk3+GH9Mozl?=
 =?us-ascii?Q?EWF/HztxoXWtQGFoywRUYqKQG/I0KcgNhuMkipDr+MJHGQUoGLvjRMqKITRy?=
 =?us-ascii?Q?EsVDbVDCJwVPHMNDaNDvx3O+NTrLb5mFDJpyPlUUfC1PsOMKr6e4RRPb7ARX?=
 =?us-ascii?Q?8l6NSIJ43FBUbx0e9n6YtUjqlYTQy73dM+Q2wpNt/tJieayFg/A/LxMm2o0D?=
 =?us-ascii?Q?G6vLLXMtN1Pbd/XWfGvTJ8lT/P+axNgYwBuRlzAT4zX+tPJKCBHibVEWzFsd?=
 =?us-ascii?Q?4X1ub1KwNc7kpXZvtfdS7X2qFAn/Ru+0wZJw/oDubJ2zq5zY9o+mldByjWyn?=
 =?us-ascii?Q?K8w2/67MGgcjjCBXMDKg2VIvZVo1A24Heblr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:19.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f65c0-a7c7-4af6-a710-08ddb3296951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device component registers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/cxl.h       |  7 -------
 drivers/cxl/cxlpci.h    | 12 ------------
 include/cxl/cxl.h       |  8 ++++++++
 include/cxl/pci.h       | 15 +++++++++++++++
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..9acf8c7afb6b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b60738f5d11a..b35eff0977a8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -38,10 +38,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
@@ -205,9 +201,6 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(const struct cxl_register_map *map,
-			   struct cxl_component_regs *regs,
-			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0611d96d76da..cb4aa5c702f0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -45,16 +45,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -114,6 +104,4 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 9c1a82c8af3d..0810c18d7aef 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -70,6 +70,10 @@ struct cxl_regs {
 	);
 };
 
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
@@ -223,4 +227,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+int cxl_map_component_regs(const struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask);
 #endif /* __CXL_CXL_H__ */
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index e1a1727de3b3..521d3449382c 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -34,3 +34,18 @@ static inline bool is_cxl_restricted(struct pci_dev *pdev)
 #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
 #endif
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
-- 
2.34.1


