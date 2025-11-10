Return-Path: <netdev+bounces-237236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15DC47968
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC371882633
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0A13101B8;
	Mon, 10 Nov 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G9mIVMMy"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6425A340;
	Mon, 10 Nov 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789056; cv=fail; b=Ce0P0LFc9lGJ4SMG8uVx1oYRTA6LUWuIyr4ePROzIflzDFp5XaEj+zhe+WQMIW0U2hMpeUnK9dkBC+NQmjyu1fqOvrpolsw6Bw4a1CdAPT/z0E2TOFDjNjo0HM2x2+9XGmvu8QDEihXdOhpElZkMjPXzfKr6igfpYPst7cfFPro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789056; c=relaxed/simple;
	bh=xr8rsLkM3vMgAQPfCJXvtZn9AUtFF0xrfEsHuR+N6jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nttNS4f+W6BBEy//nRnKMJZp34xQE8Al6q4PzA+CBZL7ZTK6Y4/vh7HGnFihdut0wq7tzqGB+FFlE8nWsmEF5IiCnK7K7FfVeJhi33a81VdBDHMxgtWCy8t6w/a39zmHKRlFrgB7qCzInKLTGpqW2oZEBib7/xXl/LdelHxLy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G9mIVMMy; arc=fail smtp.client-ip=52.101.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKmHc9Mja1jJsoLp9LyPNRA61EY5HbdOfu2R34wQ1EVtaQ2bRsdVNx0bOOmd1WwnqJ1yO70dhKfCvAP0e9qWQGBXNdBfID+Ir0zU1wrJweDywvU2gW4N9MWmrCfLUAGL8iD4RyaiQ4PCVvW6KsrHox8+zcMVBcOYhwDFgJHa5qvXhENkXJ2C39q/+Wab3dC4nZcAFra61rGqc4Z2OZcpjiOLRiNQYuaGk058cRU8o5slJYiZW/mLnhHjBXmqla9J4V08N5tAAkvwN99Cz7lOp6SBepihuCj0GLlnM4qZRx7xp2g/RnUgdeQKucOVzpfKBPpDO07URTwXzUHO9T32Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUi1JtyT4FtkBqJunYy/GE4e9yZtoVwsCmZHi/2xFzg=;
 b=tYzN/cUaOVnkxqzb7SUHbbgDxfd2qAks8yocBteXpD9BsnljlgtUnW9VXcUJmR3Wvbba7myz/xP+ryn9+UJVuadvpsZoJ0uuZ/TPsfG5epFy+kwNsy9RK+mB/WhvmZzr+ZDpaU92PHDnXhOI981p61rdOFhs4Mv3TDuTsjdxrkr9JtaS542K2qmOzy8gRMkpZlS8ERiVhqZm/wuEMBCsLfkONL8KyIqQgTbDer2JcSn/mgqsPd/FA7HJffE2rJV67/0/ycqJZ6F/Gvq37F4WuS2DRj1O015X7XTTSW8okn2qZCXPTOxNyxIPUvX+lOxFCVL6lLPhveOsb2KJ9SIbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUi1JtyT4FtkBqJunYy/GE4e9yZtoVwsCmZHi/2xFzg=;
 b=G9mIVMMyA6RjzeJc6Psn1iIPxHly4rk/7QtHgrMvO6VPjpHgkZrvbDDAnlANvxPbirJg9ivxq3r/XrGtEFuq7EW0CVq/tknBpk57j+Siu7klRtRhNuqUrY604a4Fr9fP1KqkAe1jE0k3WfKYBp02d50olVk9zNi5GxZ6XJCeIQE=
Received: from PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::12)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:31 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::c7) by PH8P220CA0020.outlook.office365.com
 (2603:10b6:510:345::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:15 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:14 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:13 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v20 06/22] cxl: Move pci generic code
Date: Mon, 10 Nov 2025 15:36:41 +0000
Message-ID: <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d441d2b-9282-4c5d-1300-08de206f0e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COUCKlrW4JDXg9uwhBNj4IIiOmzgqkrXbbaaGCp0AhdgD5pEDv00ZcoBOan8?=
 =?us-ascii?Q?8ZBvqBOqlqRFKhxGG8aRGZh8HRvcoZFmkVekwtzRJqnvPpGBjYaVsBEZ2sds?=
 =?us-ascii?Q?gXL/ZylhKVpaPnOFWlbJt9XSw7ZQvLiR5u17YbsbO23LdNHBlQtf7EBqKWnm?=
 =?us-ascii?Q?Tekb1INS8qh2tDj8KYptNhFrkkGXH8bzddpN0L4T1L468tx8YWI5YsgTAiWo?=
 =?us-ascii?Q?LKT701D9UEy8z7AKP3+oAHLG4ymMF5VyOxPhYn5YjH7XKhJnZPt3LyiQIidc?=
 =?us-ascii?Q?VJng4nLncnPC2kBGG6Mkr8hI6gqchR8TkRygOLgbVEbxTxwbOZrf6fhtEpQ4?=
 =?us-ascii?Q?B2cZisjsLT1oYx2zfssByH111tTzKEjXjUEwj891oKLfQ3UzAaQIwvPDPfMq?=
 =?us-ascii?Q?D9QsgHHUj8QxUrkRbwHutO0gdFpaAPVIJXzibajfL8711fbYyT0ZTEeNgGzi?=
 =?us-ascii?Q?sRdiMOl6scsVDEkaOz030LndJ4Z9aCKZn6HowEN4as8d0USVp/ynrfV1ODOC?=
 =?us-ascii?Q?Xb6IgBwI5ROW2SH4XNHqcjfrg/pZlCXULjZ3YTwClmg1d0+B2cCAktMJm+Pp?=
 =?us-ascii?Q?Mg4gWTydP/Vrf1Zf/pqnQ/bGQhVZE5dyxS8bGiCUuRRVcSMOo/Mjstyak+Q5?=
 =?us-ascii?Q?gPNAsjSSXIDLu+bKMWlvsfZS5rJWYHU5UTUGYqq85UTkf2t0tbVL6XaJNrpl?=
 =?us-ascii?Q?JNfQANc2Pso9cJ9554H2Oq+ybS3FPx+JuT8oPnDaimBCYSXpY3oKPp/hLafm?=
 =?us-ascii?Q?nolAn16/5MTAj54pEKIPngwHaM2cpMNvghWy++1qVmtzyytiHgbUFki4FgFf?=
 =?us-ascii?Q?AYKbY8R0H6IIYhTXBD1vZRohIzkFzj4MxCUV0JXPlpo38Enkcks0EU9koFMG?=
 =?us-ascii?Q?q6gVgrGfyTFFJZlZqBUVNnCWGdfE5zpTPOSgBPj0d0+JVA1sYrRGtg5o1mO7?=
 =?us-ascii?Q?ODWbWJHKglY96NCGM7uSDECyk+IPR2Z8PUQOFGrUIgMQDSTcj1M/pSpqr6gK?=
 =?us-ascii?Q?nykjnYi5eMnYDlxGMx0eK2sg+KqvhMmX9cpXTdHAHSacShQYMTloV8TIuKTu?=
 =?us-ascii?Q?CbvqNJfLPYvSr5LXddpKkNNOi8xrFzmjBEoBiS0Wet7gHF3hZU+yFAIIAHU2?=
 =?us-ascii?Q?LTsTSwKzGGqwbz7Qje+b6DbE9ZL+ca6owKkT6ntjFixoKOLPeuV6gRhkfSPa?=
 =?us-ascii?Q?S8EvdZRMEKBvezBqDlzcq8VUdx67izFxR/a0ewg1s9pln2SdfGvGzLKspfNr?=
 =?us-ascii?Q?/L6j+u79XbWu6NJk7xUHZjU+0teJdjUBoZJoBPNn6DhkZPD5tyrLUmaCCjgD?=
 =?us-ascii?Q?GKhwrNzMc0UpAjiLRCPLxGKr5aoXbEYPhQnyelEuK+LVx14EMkzxuLK7Xo6p?=
 =?us-ascii?Q?KwmHXu+3q0vGpUw99zXctg9bP0NSKp2ucCgXv4py2UJLTwuUfNxddVMMws9B?=
 =?us-ascii?Q?RkgE9ygVsOYZW2KrbZkWwEfnpTS/KF/6VDgOGVMdyKmu+lMjy0Rc/9i46fGB?=
 =?us-ascii?Q?iG+nCqzcAbYJQ8nRfcUWQjrioFMzrkbF4m+414Gg98GzLP/t2JLXCXpcBvW8?=
 =?us-ascii?Q?uo6iSH5/08doBD/jHgo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:29.0199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d441d2b-9282-4c5d-1300-08de206f0e8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Fix cxl mock tests affected by the code move, deleting a function which
indeed was not being used since commit 733b57f262b0("cxl/pci: Early
setup RCH dport component registers from RCRB").

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h       |  3 ++
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
 drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
 drivers/cxl/core/regs.c       |  1 -
 drivers/cxl/cxl.h             |  2 -
 drivers/cxl/cxlpci.h          | 13 +++++++
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 8 files changed, 78 insertions(+), 91 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a7a0838c8f23..2b2d3af0b5ec 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
 static inline int cxl_pci_driver_init(void) { return 0; }
 static inline void cxl_pci_driver_exit(void) { }
 #endif
+
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a66f7a84b5c8..566d57ba0579 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+			      struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index 18ed819d847d..a35e746e6303 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fb70ffbba72d..fc7fbd4f39d2 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1517250b0ec2..536c9d99e0e6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 3526e6d75f79..24aba9ff6d2e 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCiEP with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
@@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
 						struct device *host) { }
 #endif
 
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d8b8272ef87b..d422c81cefa3 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 995269a75cbd..92fd5c69bef3 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1


