Return-Path: <netdev+bounces-273222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KaGELOPymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5E235D519
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D3F031A45D2
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F52E6CB3;
	Mon, 30 Mar 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5obnAkbA"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B42E718B;
	Mon, 30 Mar 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881526; cv=fail; b=H1m7muKIouMfwrfskkq5nmc6lIcvOJk/h69Iucy4KnPbGcUz97+9xk+wl1EptSLDKRQT29CXNgdswbn+3Ve7mMATPP+QhLJg7/BnamWEhpjfyK22wfMg46AephHKydMKSfUcwZuxwpdsli8ktOZkDuPPLOcZe+AA+c25LY/V8H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881526; c=relaxed/simple;
	bh=GJ/WGuUP8NRdq1xbuEJDD4Iwzapot3sC2+PgUqYNheY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja434pE0Ke3FBFWC28ThdNeG0uRpHsGEDogfPSamjUb/GwTBaTxvm8cojOYt3IJAJrOna1EVRtc9GPP8s8PhW4IS2SJtKrbs5e3lW2/HYFarx+T9f0oBFudlp6lF7qq1bq8PmHwGlvRWVfGxrdlbYo/id66xQcIKs3WQXvF2aos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5obnAkbA; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReiVXS4abN97+Z1W+QcdJ8lR3g9Ds9+HY5hopGqtpUR5NcKAX/mitat/EKEyuKGC+3F5n6NdclKTkrhNrZmW8Qlr7d3XZ3rPT5zJww0gBlQapQeAljjsqA+lAM0M3sg04222w+rScNi+I6mzsRWm1GIhcii6yHwLCQudYvfYsyWNmwPBLkBLIwDgBUcdLvc4xJw9NGsOOlER6VA6VYwRzlOsNugzQf76JVb8C8gtmne3mz3phPn+FrwDb2SUtml35FhHVGi5ZecBQR6MuxvgiUlgJ8Q0rA2F39+9EtvKYuOsgNjPEQjWwODCWuIIT/n/KBmZqMrvTGWprUyuATcMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqBjZ+pQCpuiKRprtaICtd4ZE6UDZ34aOaEjqDzCBko=;
 b=q22vyeJPX571onu0XbcUGPp/RwP5WUwEDwKRw61MHxNPVbDnmJ64xrI4hY3VBhNOPeI71eJhfOlGPKJn37dTw3P6AU6xiSpCdgEEoEYbVvWtx8hv5IUY7oOr+wYMHmt78j70b38lx6d2mS0AnzYp0OgI/28fjdH5MW/A/1DgqDzk+FWTxCpNihYWMhlkK0cRZYWHdu2B3RgkJ6HYjoPheyJ45q75DMwT4YheUTCmTBTxM+EturqCB38tyiXWYK5C/L0tmmxgBbFMk/vUs+P2G0jKsLHxbSrNUDpu5CHH9WVI1I/EOKDaS4tpsRU6xEkdVQA0uqv33oN7ird1YiPSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqBjZ+pQCpuiKRprtaICtd4ZE6UDZ34aOaEjqDzCBko=;
 b=5obnAkbAjkRSxWKBanVe9TtkDqgTGtcts54Vo5glW8pMh6Ixpt/FOTtm+MvxXbt+RilUP9lpfe0C0Jy2Z/vngkBZ3909GHuK2HCdP0M4Qvz5hW+AKHczjobro/J3rHF7AuNRk2W1wcgxMiqTfc0+DMnQAyf2imKKy1pLYFH50ow=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 14:38:40 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::74) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 07:38:38 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:37 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v25 02/11] cxl/sfc: Map cxl regs
Date: Mon, 30 Mar 2026 15:38:18 +0100
Message-ID: <20260330143827.1278677-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff888f4-4934-4078-4fbc-08de8e6a090f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BHCCJVRqRPMmi/CKwCI0dfLSIg0zkjc43yF6+4g8UM9OWH/wl2M1sLqcXvZdipcB8t6JViOvS5rncdAOJ7C4lI+/6cMR0d2VBm5TP8QCdKNjqQfobZmvtT5tPWsalhXHVoEcKXERF749xSbi5jYnHbXOh/Eey4LrU932fs+kwknFvjoIaipbw/W3y1Eg1zgi7k0FmuDzcb8WBZj/3GSB82p7gzUgGyFvS3H62ZiMEI4qJWn8PpC8Y4u0dWFJ4R4/OJSR22GemwWSNoggDEUteeilNwNR1Ixzkst7zXChSdUL/f1UyBGCz82E5w+QjziWc38OmRWA4SEG86CMUpFF/se5Z5Te6rMG6UTuvSostdWvywj4S2zoEH4O/7TODAHu1N92urvZIh3D/iM7OMjb/Gz9yTByj4biI+UWRphXfyJRv0qAIo7g3E6GdDewrjdkbthoah0nTxRF9JDvcgMQS9TZyDpZijffnoBW5YLo3jqY35lGAOMARNRGztptixG/GxOaUjn97Dvy+xkQi4cYy3Re0ZmaNrSshcITvI36bw+DW5whldutqzGAalCi4RXhyHD4m35VpZ8IwjE7PO17tTpsgpU2Yk2jN9gqDxaEfipVvy0BSNwmYvMbvzFgj7RLaqL0z8ajgVg50+yEleKawzfJbATehlP47AEwviFZUryFiO8ffoNaCUOfylzKUHEsysjWrkMlYoxu1AGK1Dz9DGA/9LB0SY1yN/L4MZ8qv68bOIaykWwvvbt6KIPk0+qX9PzgW6+CmW72XsXrqFEy3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ma7lh9N8bIE8Hbgp+uOb80eQl0+dUmuPPCAynMszGVzzR6swhbGKfax6uq28cmxp/8CeAOgVB+qQ0+E8cBrX8NfGtMD2hhWMN1AlAeqkMrmzTj8wsC8KbyBZzIYk/dd5RYsMDbq+5buW/KusrVn4JSZPvVojhPs9gtHFSaKNGdeOFzjsKVLYrCI5IdmStrOlIWVLOyrgV/NhHGcxrFjrv3MDuaSjdsYZP4+mRL6HHPW89vhcDrB1FZF7LJBp1mUfefBSbXZzuijGR5SaVneAxG2Wa/Az4vz38ua5leC0xsOzl4bEp85QGsujSH5KD04vavyQs4HKh9ckFfmhlPeNFBbvoxSjPzoclFyim8b7hjCH/FsbJdvVSWlbOn45SlIPB3faht4H62xVd4zxYghIyY4/aBXq9PTlSD6Zh50GXLLwRtrQjyvH+RO95Rc1DS3+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:40.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff888f4-4934-4078-4fbc-08de8e6a090f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-273222-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CB5E235D519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxlpci.h               | 12 ------------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 include/cxl/pci.h                  | 21 +++++++++++++++++++++
 7 files changed, 51 insertions(+), 12 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..2bcd683aa286 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..a53b87de70e5 100644
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
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..20c2d9fbcfe7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..110ec9c44f09 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
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
@@ -112,6 +102,4 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index adc7c4bcb03a..5cad118e7101 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f66db976fde9..6937616ec362 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -7,6 +7,8 @@
 
 #include <linux/pci.h>
 
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
 
@@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -44,6 +47,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		pci_err(pci_dev, "No component registers\n");
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pci_dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		pci_err(pci_dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	/* Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..a172439f08c6
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
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
+#endif
-- 
2.34.1


