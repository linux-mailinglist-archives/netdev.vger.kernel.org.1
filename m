Return-Path: <netdev+bounces-270482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPvAKMAkwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5592F1403
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FDA5300DF58
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26480388E7C;
	Mon, 23 Mar 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kJ17Ajig"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D533FE15;
	Mon, 23 Mar 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265529; cv=fail; b=o3xVuN8cUJ1mvJn3wGPVufWO3rWKS1p7W/iLJOdfCoqTbHT3yd00JK3Na1P3Eqcj+1iZ+iOtt9zMZUXqu/Hkvm23uoaqS2JBf/kxjxx9094KgIhAmoQjTefWDB9pR1vLRR9eWmcHWw00B60DCSz61Xn8cB3igtJxKEJ0NDD+vHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265529; c=relaxed/simple;
	bh=cIfbo7BWY4mYWHuk3f41Tpg8tBD61o2bt2ayLdqyfA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfoToGQ0WLATU0F+A4o9tdeJmdqEGlBc3WQhJIAmRG820dQL/pxnoNMdsGO85Ly44pLjbfBov6T275++xINEC6I8ysiYA4DG6kxyzFjHUwJpHAWDOOigDGaffuNxn7lzTBVExpv8IMRBDMgYmywNRNFyyDEUImyqlZ+a7zYCEig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kJ17Ajig; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdRjdpE8SQH8tTlVYzj5OK/hxfKf6cF0aDYQrtofJIm9YgKZEeyKC1bx1JiKDddZQpvm3JN2eP9I8d9L6+vg4UOrkn1U9JN2cC23M5+GfGLdt3AH1QmLhb2H4I53MDDnGQkowTBY7+V9iIhGlsLO7ZP/vuAFulhQgtWEZH6Mlh+bPW6AE66R4r2j6z7fjzJaebbpc5NGcv42kTGQBr6c6McYqSnAftNL7uaxM0sg2qTXXeGtRvBWHglE83+GeQO5ddivN4eQckbfW7sKyMw34PpLc9UirgXF7H9XwhENFjMlJv9C6wp5vslmi24Gmhwg+pyKdEX6S0ssV6F96R/OEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H4HICZJlJ8FsCKvxgyRZOMUlJN0i+ETEClicargAtY=;
 b=cAAmqy01ZbkHoecisxFDvtSq/s0zh8WhdaeF92Hc+HDgx92MXI0u11TYnGukAEpv9AkA2QFfoomHgm0C/zovHC6lcHrD1nKAxy76KRK/v5i3K49fVprWzpsXqjqy8RQt6EBJr608M6TuLbrqZ+IadNMGjE18y5UbsBUEsEWzkwbqrXeE+GLt597t5Rx6yQu9agKvztJ5BACnp0DTHp1h/IS0JP84NNLvmE/JK7efsC6ObiKfbXxXedPdMWFPMKsqOpfhWtFoAUBdirALl1sYkdau32HJTphY65HcbefKJMoAT951ObErQFVopYf4pD+te0KNV9ta8/BLyvFGHu2ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H4HICZJlJ8FsCKvxgyRZOMUlJN0i+ETEClicargAtY=;
 b=kJ17AjigMMqyAFkVXeQMJNY26ZNj7VzQFb2SA/DdM5YT0hlBC7jRB4tlEhmlHR8zHKvkhU+amxq36rEEZ0F2F8trooj3HlQ0FnKP99/wqM2dVpXB1mgflXywwk7/Tc67hF0hiSqygahh1K7F+Ei0V6fglRvfoieaFR9t6466v/Y=
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:03 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4f) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.29 via Frontend Transport; Mon,
 23 Mar 2026 11:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:28 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:27 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v24 02/11] cxl/sfc: Map cxl regs
Date: Mon, 23 Mar 2026 11:31:08 +0000
Message-ID: <20260323113117.2352709-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: a1561e5d-b472-47cf-bfbd-08de88cfcdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bc0ic/RFT8eUZZA1/AxKoo9FaUSNr6zRRZhMahl2PxmtRLwCSDFFVWNzDW3QO3ape+TwQjo9pLIBk8C+ZnWZlg/PRVTRgh6Xf6ZgVIoSz8L3ZyaLlQr3MkP6PbZrU2qLrUbL3AGztam+fNwyAzdBRv1JiZkqX+k3VaEX24InsEd8Ig2yb3fCX1X5uVgSdKsj3ocl5C91AZOjTuinTcnXEIRtN1VDMg2JrW4+B9ppvA1UR/q67QRNlhlLtxuK8qNCP6OFbCjxeyhpkE+X846P7dr2zedQ9oJoupfyaKSuW4xUB3FYx4JdnkclZ11wNycpOmJrlascHY/xhTU80TScTwLoEfBctRYYgbNoxWnAX8AnOZEgz9JMLE9gseEKO3sZGuC4M43UrNdVoxeaMI65OMRgUPQWvQ1xlYiyqdKTj4Ft49lvBhE9Je61KV3DcL9NcKCi8K3Qudys8eh44+6ZEjuODU6EkbKGbSRmncigvWi3HQlO33HV5vrtUnOHPbraeh8w+vdelADKWfddf3znNzfq132X78ea3c/y+ldSMjebYtTsu1cGXk49eTw9P0bjZgAVMzLNvewNGfetJEpiemt0imC73NSooNU2YZjDFWOEPXeD8pQeOwWW47ik/NBDeB4MozE8YMPbSguYVu4AwjZf3E2tlpwkqxHg2Q1E4rJ6ZxRMYittvMN9T71leUk1evJqMZDDcnRjGOU+gdMg5HxQ2k19Xz3+xIobJeYXadfPIhp2hHR+TOF2DeknxpLkQVBiYMM/qyU6FBATBCcUGA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	47G8k7vOMFHwqma5bvRAMSUG6dpkT2qcN4i3n3WQ5bNb2FEkhqkaljCiIHWDTT32c3m6DaYn7B2EHjqy5B2GZvTNvGa4Kf36BZYbwgvcD4JQbDgc0+2ni3yZM1nBAsEfFqYi9Iown90NfWIwm+P6Hd8lSIk7xFUE6onkFeEQQDY2+Kb0lDgmRLUWZgWdcT59zpyR4Hk45a+F/x4tdv5U1VuNwEPC90GGCQ+qW3W6Akis5HxjAmiYZuDOy0i7u16iiJWOCHaoeaFpnHLe+IzTVz2rLzkvNDqSXx2QR6JrsmRoG796icJ8yCsOFOHb4dsCnw1XdKeUJDVEebvH0UOw2VEN8AL1B4Ee4JRPcOygq6w/VP/4AKHqTmzNn6Ui/oTOukd489tMP1+vyhECFklA9R51MTrHXRQ0omkQ+YDx3qnXVDeZkKtoYp7T5x67Lhue
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:02.3790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1561e5d-b472-47cf-bfbd-08de88cfcdc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270482-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4B5592F1403
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
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxlpci.h               | 12 ------------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
 include/cxl/pci.h                  | 21 +++++++++++++++++++++
 7 files changed, 52 insertions(+), 12 deletions(-)
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
index 8e0481d8dced..7917118e4eba 100644
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
 
@@ -44,6 +47,30 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
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


