Return-Path: <netdev+bounces-240133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D2C70CA1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE87834C969
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C4313E36;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5LdcR5t6"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293C1A3166;
	Wed, 19 Nov 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580184; cv=fail; b=VU/0RGq4KYwR8EXFkaub9QDBz60T8ZTHqt7p/JuLyBDl+dfnBDe+61ElfOK03Pm4STfd7udFOx8NoVVOb6Mi22CnT5sT2tByYOYnk9gaIrDWLFihewTXuEWo/LO+szRKPJ+ucVn/0DBapLKf9eRcNSRgJKsLfMDL3/yUrciCif4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580184; c=relaxed/simple;
	bh=HLUHo4gBVMIoKOi1X/FcberHZK2Rr5QemKfXH8OkOqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1s+ppG3DQGxttOdFLx5J7C1aYnf+M27sGub2xN5tQ5PKZ5mTK65pda07GbWdVN3Lgw5P+zEGWdteaWJgzoY/fAQpWaw2EPqHeR5g7A6AtJ5hQJlBoRA38GwFqWm0HvuWDR4HMhSfj1CGZpf0BpvNPLJKsAIzDkiuQiURCOtJdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5LdcR5t6; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUG4swVdfwpreJNAYna0bG5N5sMVBjDCC7IHuCUUGBAIT/7SgAruMudwbglrli+4oyDF72W7MpXBYHlTtbv2u5Xcbir/Yq7WbOnfo8xxybbYUjy7YpcbNpUoOUxyYS5KjXC5oNKhmQZAPFd+Cu4Py1Nwl2WAJFo4Q5ZxvfT81oGShMrljrAiZ1cxCvl0/hTTIWqiHCILoPtTbThAmFruorv4Bwj25UX4IFjyxuxvrM6uUKY7xYQPo+UXPRXsSAn37+HalwtOP7sSJLyRTBnC5rMQjyyNl/2lOTexMfx80EUh9Q1mN50apINal8IIQP/4/Z4D/DjChuFzqfsSyQV7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+peORrZDRpHbc5kaFg3g9+uf8qXMu12tU06HeeuY4LM=;
 b=SRuWBwHDXXo7e7EiZKUoXGyYZ2JqdxdKlrejuyJL4yvRRTnYF9nukRTFc/snRADjkGzYcVU9XyHzb7jOnMnIwUNS2tqz/P+PAvhQnMGZttItWQl6K400klrUkP/VlysX13dP5NEFGY4+3EI2O8anf4fezYJJjDebh/uMbovHh8Va9INR3b7THhjjA8YYxK3NRG6iL4BkqZR6fr1m7YoI9ntrvRCex/OVYj8hRRYyPkvMNjtWQKwAoU9+6vfqyBwb08FsLmH24s+ejlqqArnrWnv9g66Ff1pjPAaKrET9Y0223jdgEO8NSzhFCCM9FoyzEkNuSSNRfyDDANzy7qlD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+peORrZDRpHbc5kaFg3g9+uf8qXMu12tU06HeeuY4LM=;
 b=5LdcR5t6sswl2wBAOR+a+XkIBfQgwZ53JEVsWqMUQw8b2E/xNJ3DogJ4lCMi79z1YYNFCubZGbWZqn3FrloHeA8BUcksixqI+Tf2/4v4JTWnSLe5OlGS/T05VaV9RIg2Sw7s54k4hUahbaMJ4xCfv3IMNLXobqmaX122HptSS/I=
Received: from SJ0PR13CA0207.namprd13.prod.outlook.com (2603:10b6:a03:2c3::32)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:52 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::b) by SJ0PR13CA0207.outlook.office365.com
 (2603:10b6:a03:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:51 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 13:22:50 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:49 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v21 04/23] cxl/mem: Introduce a memdev creation ->probe() operation
Date: Wed, 19 Nov 2025 19:22:17 +0000
Message-ID: <20251119192236.2527305-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ac23ed-45cd-45d5-e114-08de27a108c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ioi9eTKk/qJWHiZGkZoNKhV3l8iaSVFHV9MxyFDaK6gnfmlnImairF07DFsH?=
 =?us-ascii?Q?Y/hSC1teMP9S8aA7xR0XbPZyaC7/ocjG7EFR9lA/4hKdnJR0OPPYYTTfT1Xz?=
 =?us-ascii?Q?aRzfyVUtMr2YGu/7pJ51VLReJGhrYJ+AQxauHI7Hnu7e0sW+3lGsEZRtnhbN?=
 =?us-ascii?Q?0qBPb3TrrZwc/h3A9DlWcfij6D3GEC9ydSuOZFOVv+G/V/CHTqhcxzM4tKQq?=
 =?us-ascii?Q?elLfQishQcmYExzaCBmpcph/LqDgeYzl21dO71bvAaT7Oo7yJ8n6FqH+Jyte?=
 =?us-ascii?Q?4ZZVn3ta4C6J0vWllLrgKPTfc0plW5SKrae7EnZeVnesinE9t9phdUsLhMVj?=
 =?us-ascii?Q?rcmz0AAtChrN35+d61DvwcMLn4BRAJxphmqRD7pIhbeGNx71Fxr9QS5j88Yk?=
 =?us-ascii?Q?LcJmcSG7dZN3Ic352hnqY0MaR2am684crJWfTnZxthB/QbNmAFjxRLuIkGpX?=
 =?us-ascii?Q?gx/N+3P0/ihEJ0n5VH4Yj2Fb8nisAX69RdQnygCTqO/6m5NL/+Tx2tAi/a1W?=
 =?us-ascii?Q?EGVW8HRdWAM+Zvb8UFW5S6bQdaFUqhaD7sl30qoEpiGi4bSR3QES/TehGsu8?=
 =?us-ascii?Q?KKBfRyXh7cTWlT2JzEiJ8eBnDT77kNCCREK0wqdn7vwtOnQmfX8umSRHj1OP?=
 =?us-ascii?Q?renmwBGBqHmKAgok+xce4Z+mZny5w+3dfjBtnKLB29bioLYs32aAwgO83j2Z?=
 =?us-ascii?Q?IewD2e+3P/MfTPh20NUIXmakIFemQegzQy7XKWc2ccKQ3+Mtz8UFZ63gGvWi?=
 =?us-ascii?Q?HXxRS10/lgkhXqM1VoNx0WQaQQ+Locbq9px85luj3wxgx0AWlQzMpC3WA3Z4?=
 =?us-ascii?Q?pdZH1qiTwo9z44ezMfItuvPrOnFshZ7Ld7DOjOEieyNawoeYxsKmDC6jJx+k?=
 =?us-ascii?Q?qL0UvwzLmIO4rMR1I2AeZacPJfsGuD+PDVhz+o97pUWV4ISeVdWaSZL0QaJf?=
 =?us-ascii?Q?Tu20FM8dji1kHMW1IZIbWqU5cjRWRkklZwE5aFU/qS8remPWefgpN/yiCpv/?=
 =?us-ascii?Q?Q+xjtDZ/PfLWBboyxvwo6U+a99kbOJEBcx/Hop7EQehLXdouli6zVy/R86QO?=
 =?us-ascii?Q?DZQdEPapRrN3vwaS4zEeKsz+GOZ1TRoPFpbXEkqj2ahrMS/bWMlGVvf2VCc8?=
 =?us-ascii?Q?1X5PPuVdaVw5GPgZZlVf3DERhua1/1lnkrjayzL/wYbS0M85kNbiPb1zozGR?=
 =?us-ascii?Q?pPBAoNWhM77abwXoj4SQzDS072Mc7znl9nxEfZA6j8vNZimtrAwI8OCdDy5C?=
 =?us-ascii?Q?AddQd8OMw8K7znYGSjFXQGpJFrLQ5bYfmpRSszgkDzBYG6Jki3cNdnDPCCDc?=
 =?us-ascii?Q?iIt87XJzyXr3otgSdHU7eG5TlmwACza/jEqsMBkUePqSVus5L3gUwOHAau2S?=
 =?us-ascii?Q?oAP3rsKrYp7NXE3RHDjM+muGjk1E3QZe6825DcPlssG69QiDikUsIsA8XiJ4?=
 =?us-ascii?Q?yMNka+n4AGpnl/vj6AUQg8uFmwvm24P2tHi9xfcQJmBTSsrHoFVl1D0NCm2D?=
 =?us-ascii?Q?y/C5FNxkwG3nMRnwZxY9iiBgJrKdqrBkbb2NOWsGaCrmAQqGqQNK+G0RsA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:52.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ac23ed-45cd-45d5-e114-08de27a108c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703

From: Dan Williams <dan.j.williams@intel.com>

Allow for a driver to pass a routine to be called in cxl_mem_probe()
context. This ability mirrors the semantics of faux_device_create() and
allows for the caller to run CXL-topology-attach dependent logic on behalf
of the caller.

This capability is needed for CXL accelerator device drivers that need to
make decisions about enabling CXL dependent functionality in the device, or
falling back to PCIe-only operation.

The probe callback runs after the port topology is successfully attached
for the given memdev.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c    |  5 ++++-
 drivers/cxl/core/pci_drv.c   |  2 +-
 drivers/cxl/cxlmem.h         |  9 ++++++++-
 drivers/cxl/mem.c            | 27 +++++++++++++++++++++++++--
 drivers/cxl/private.h        |  3 ++-
 tools/testing/cxl/test/mem.c |  2 +-
 6 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 639bd0376d32..5e8af91c921e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1035,7 +1035,8 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops)
 {
 	struct cxl_memdev *cxlmd __free(kfree) =
 		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
@@ -1051,6 +1052,8 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 		return ERR_PTR(rc);
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
+	cxlmd->ops = ops;
+	cxlmd->endpoint = ERR_PTR(-ENXIO);
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index bc3c959f7eb6..f43590062efd 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -1007,7 +1007,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..e55f52a5598d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,6 +34,10 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev_ops {
+	int (*probe)(struct cxl_memdev *cxlmd);
+};
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -43,6 +47,7 @@
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
+ * @ops: incremental caller specific probe routine
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  * @scrub_cycle: current scrub cycle set for this device
@@ -59,6 +64,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
+	const struct cxl_memdev_ops *ops;
 	int id;
 	int depth;
 	u8 scrub_cycle;
@@ -96,7 +102,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
+				       struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index cb16adfa56c8..b57bc6f38e64 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -144,6 +144,12 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	if (cxlmd->ops) {
+		rc = cxlmd->ops->probe(cxlmd);
+		if (rc)
+			return rc;
+	}
+
 	rc = devm_cxl_memdev_edac_register(cxlmd);
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
@@ -183,15 +189,17 @@ DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
  * devm_cxl_add_memdev - Add a CXL memory device
  * @host: devres alloc/release context and parent for the memdev
  * @cxlds: CXL device state to associate with the memdev
+ * @ops: optional operations to run in cxl_mem::{probe,remove}() context
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail if the CXL topology is not ready
  * (hardware CXL link down, or software platform CXL root not attached)
  */
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+				       struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops)
 {
-	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
+	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds, ops);
 	int rc;
 
 	if (IS_ERR(cxlmd))
@@ -205,6 +213,21 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
+	/*
+	 * If ops is provided fail if the driver is not attached upon
+	 * return. The ->endpoint ERR_PTR may have a more precise error
+	 * code to convey. Note that failure here could be the result of
+	 * a race to teardown the CXL port topology. I.e.
+	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
+	 * before the lock is acquired.
+	 */
+	guard(device)(&cxlmd->dev);
+	if (ops && !cxlmd->dev.driver) {
+		if (IS_ERR(cxlmd->endpoint))
+			return ERR_CAST(cxlmd->endpoint);
+		return ERR_PTR(-ENXIO);
+	}
+
 	return no_free_ptr(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index f8d1ff64f534..7c04797a3a28 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -8,7 +8,8 @@
 
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops);
 int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 			  struct cxl_dport *parent_dport);
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d533481672b7..33d06ec5a4b9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1768,7 +1768,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.34.1


