Return-Path: <netdev+bounces-243783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491ECA7773
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA96330295CF
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E0285071;
	Fri,  5 Dec 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYxIK1Wp"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C469312803;
	Fri,  5 Dec 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935595; cv=fail; b=dHxPSdzZnsRm4rk6nwpXCnKyCOH2ilj2oB+/VGjOxpcDvqhXBBuh11IczA3KEXoRo7HR+nJ781XF61kVdrwWmJZga3M6zGbGDm8NySzhSqBTKkEcBATgYc0YF2teOZpUkVCelg+eu3b8M+t1at29iGvs8sR7aMrA6Ssc2evzslY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935595; c=relaxed/simple;
	bh=HHh9iOzHUefUzAkftt9ujTMLTstgDtUqOubdXZEqVdo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKyuvmJ2qq1L0vuHtPprmSPHL+ukpc7fVWa9p79H2xxLAl5GsM/P4oz3Bm4bYh3bgYMWVasKL+NcNmBsgpeCnG8SOlFCkGbTmCA+5AsRdDGtwOyPIApONWNeGcGDycbRxfQqsYMqP3oTURN6x0SrsytmQweBjlU+nBYQhsLZ5Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYxIK1Wp; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR73qGCMDbhUIcayQP9A17eUmEDias1L5fq1U8HUZeg1yvBkJAYTwYTXyx23d+U4DSJcnQnABlCI3HkxK6CO59zJBmNxUFMJNfxhwUiCX0lGRwMhJmy8dMHTHo2i4Km+nfM91KIivHN5uONbnZaUY7Ec5xt1c2poupKNrWO0344VBBRjjgkjQQJoGoKpPHxznRyEwrkSn40cFtoS0RAOUb9wWc3tn6aAdACPoNeIvgyIFE9xzT+WGY3w944i+/EZL2hQXOwAn/ShQwzwKcIib6Lboq7/o9vYyysArlLTynSzJXnTPoa24Yxx4aeT2cjPxtFvbuUSuodYDpTd3djKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUXtvu+5xTjj8aOv/zGHf+PlP81e67Ck8rJvmMT1fkU=;
 b=q3iCt/05thYG0NyMb/l+ggX+SbtwVFIHBU/50abWLuIUZK1k91NmyOtp/JfEinbvgiLkAN3l8vZfvNUIGZT41h0N1WVAgQuwmM/vuCj942LivU5RzVYgL4nW1NnxR1smkNSOtSKxnwDqDryQgTvE46ROqkzNW2Nchj+lFVCj4cH2k4RDfGNyZ2q+9WDWjI0IYNH0ChXbcpB9OhvwGdJXpVkirtMuk+IhTaBN6v5w/28yyvPUwuDWOonB9EidMcpJfcwJeGx96zn8UFOBd8WusMxwFFBb0aS7NSWplSs2RXZYTWHpF0Yn21SbYX8qUD8YikSYcdfqoVlBsMjhcV7zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUXtvu+5xTjj8aOv/zGHf+PlP81e67Ck8rJvmMT1fkU=;
 b=uYxIK1WptJq1a7qiKzS+LphKAuyvTWGab5Yq08tfXU1xRA0QBpA6rH2PrtDbor1eE+owxep7HtePVzsN3JLQUeHE5ogOzFzsyds2oAuES2oo4LZGKwzt0AoXcpJIEsCiSlwDMUvY5ZAq2fHrCTuCF/qQFWnYX66/0y2mEN3PKkE=
Received: from SN1PR12CA0045.namprd12.prod.outlook.com (2603:10b6:802:20::16)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:04 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::62) by SN1PR12CA0045.outlook.office365.com
 (2603:10b6:802:20::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:01 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:00 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v22 03/25] cxl/mem: Introduce a memdev creation ->probe() operation
Date: Fri, 5 Dec 2025 11:52:26 +0000
Message-ID: <20251205115248.772945-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7342d97f-f284-4ff3-d4a9-08de33f4d935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Tu+CjCmWdnyddFfmDNSIBUcK1hrWHxeyS38itZxQLBomI7NZ16mwKU2OE4h?=
 =?us-ascii?Q?t7zv+88tFf3aQLdrbZhnOvQ0Szg0OOiaIQAfyEDysfcrrm8yEn32w9axQSeN?=
 =?us-ascii?Q?U75u71E0ekOSYceoh2ZU/07uSzmkGsAN6IrhOUo975IAkzMBmXyVhxToiQKm?=
 =?us-ascii?Q?8hYRMMIoCSBUz2Oj/8sTukBVIZEQyv7D9uv3DSq8s6JBLmvBgSGeO8Zqwi0Y?=
 =?us-ascii?Q?RgGBcC91JFuBDy9HLB15NoA+c2Fld+0HYP+doOjB6dDOyOKtrUobiOXBfoT3?=
 =?us-ascii?Q?Pybu2ax/o2wZZ0kuXidgmpubkid3WTEs2DyKpqEtpaew6G5d1iYOoudGYwRJ?=
 =?us-ascii?Q?GcSzkbSiZzjYcEjOY/mL/5RCq575sfCgU15FY6HQwJ2TWr70NQDwcfOy1dVA?=
 =?us-ascii?Q?kXjQ6JMAxM7ZmHhffYoWjEJVo73BtqkeyhLr8mvNv2IdWVzSK73xGed/GONv?=
 =?us-ascii?Q?IMsKL5MmFdMFXjKekgOSx98lab2rc8XEWW45r95qEY/k3uUszftoACpNJDly?=
 =?us-ascii?Q?2/18n0EmAqIU+30PvS8TxW4TzKZzQJOf+EVAJfovU4x5rAKmxGamlmxRb2v/?=
 =?us-ascii?Q?G/tvRd814QxEt3E2E5LJOatcttm1Dbi0bENYS+JO3X2DEZBAkqXwHjfv0f6V?=
 =?us-ascii?Q?JrsbRYbjrtbZRiHqowXbtzjQwfq9LxNRnmmQNbEYyZtLLAyuLTENS4SBwNy4?=
 =?us-ascii?Q?OaDKj99E/D0p8h5wvSwz4mIbAFO0W2I2Pi3UJ6qXTMNqLOESgXsRLyvGNKM4?=
 =?us-ascii?Q?zlGFbYWlqWV9nWDRW5lwnCoO0SbZnyOCsZ70N014CJyac+GceOEA0U0YKArZ?=
 =?us-ascii?Q?ydfzw/nKrzHoPle5v8+sCNYv39+Boe9LvO2J5BaVrGyPNy4MWzGtgGM1EOC8?=
 =?us-ascii?Q?7E9dmpgxKaoHZBc0Hk6v/5+NcZxX0888O0mCDRDhQg3bNf1FUAJS3Npv5k2/?=
 =?us-ascii?Q?UxGSEXkWiSKtGhz30AOtyFzKE5o1bOQI1OuJnEuXTjE+gWeLDOwBapyUY1Nv?=
 =?us-ascii?Q?8pzHUBBbK3NlYTrIxRb2xou0Ovrta0gmVakZj+OqJubvuIuhpgug79poPlve?=
 =?us-ascii?Q?oI+s+9v/AGT7T6yIwujaYvHdZ8l6ZUFPN45868HE31nC5iPLUjYqhLt7z7oO?=
 =?us-ascii?Q?9d4C5zBwSNeiUWHBlI/90Qq+qrKoqXqkmvzFUlFoVe7iWR3ES1ySTEC3/WeT?=
 =?us-ascii?Q?RH7nfFaZJ6rYpgT7Jz0NgXxKOAhZC91KLFT8yYKfLyvaztvRjJK0Bi1LvJVw?=
 =?us-ascii?Q?8iSllAvzEZ2wHH4RIjEHxC+HVG0UtO5mUcv+Rc6Tg9oVLN/rfrWt5Bna1Q0e?=
 =?us-ascii?Q?MAXanrIqt3aCyMuUyLzTiBMgLI8WtqfyC001zlmpZwchl4Tr0dvZg7GO2h2o?=
 =?us-ascii?Q?9MoFZvlbzYR4CusANRqdHybxPSFLaVMD8rWt7RRZ8JIYrTEs09skNXf25VUX?=
 =?us-ascii?Q?W1yVx5sAIkYtfx/ym6kPuQlMBdRvp0FFhKoQ3DZd2gAMf2GLQJaV0WWVIGBe?=
 =?us-ascii?Q?6F8VgRJE9ymB1q68k1tN99zp1pnXkjhw+v6bCqDhGeS8bYzlDUtBewb/UQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(30052699003)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:04.1768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342d97f-f284-4ff3-d4a9-08de33f4d935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755

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
---
 drivers/cxl/core/memdev.c    |  5 ++++-
 drivers/cxl/core/pci_drv.c   |  2 +-
 drivers/cxl/cxlmem.h         | 10 +++++++++-
 drivers/cxl/mem.c            | 33 ++++++++++++++++++++++++++++++---
 drivers/cxl/private.h        |  3 ++-
 tools/testing/cxl/test/mem.c |  2 +-
 6 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3152e9ef41fc..fd64f558c8fd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1039,7 +1039,8 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1056,6 +1057,8 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 
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
index 434031a0c1f7..63b1957fddda 100644
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
@@ -96,7 +102,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
+				       struct cxl_dev_state *cxlds,
+				       const struct cxl_memdev_ops *ops);
+
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8569c01bf3c2..b36d8bb812a3 100644
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
@@ -169,15 +175,17 @@ static int cxl_mem_probe(struct device *dev)
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
-	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
+	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds, ops);
 	int rc;
 
 	if (IS_ERR(cxlmd))
@@ -189,7 +197,26 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 		return ERR_PTR(rc);
 	}
 
-	return devm_cxl_memdev_add_or_reset(host, cxlmd);
+	cxlmd = devm_cxl_memdev_add_or_reset(host, cxlmd);
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
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
+	return cxlmd;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index 93ff0101dd4b..167a538efd18 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -7,7 +7,8 @@
  */
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
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


