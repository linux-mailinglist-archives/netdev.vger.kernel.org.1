Return-Path: <netdev+bounces-237229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04036C47959
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2E1883B3C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DC24DD15;
	Mon, 10 Nov 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HDGO8duY"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42315258EF6;
	Mon, 10 Nov 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789037; cv=fail; b=GGohBvxMvoGXlGB6snnHrnn0bwfZg18dHGwgQCArnOi5ojLISRpblFwuxoJiRL90wSWGhMNIx+dXHW4FwlncW15/hRp7FdSWIfz0w2abfBr5NsIc4yQz24cvbekwCjroIzSUEUy8cqNACdG0kymc2/ZtOgw7zAJqdPFdmVeD9J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789037; c=relaxed/simple;
	bh=ZlIm1R/rycmfZm4oIeUytUEV7+ywn8VNfkV4CihVWe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHMdnyDcVSemsgFKAfkeWDnSE3XafY0PNJpX0iBiZLJbzj3f5xmL3WV0PzEE1LVlfbHp5chEgx//8h2FOh/BjQiiyB6dAUAvwfGHQco9zvl/zjfle34wdr08CZsqky40JrbVuTR+QBcJ0WicoRXWu58LJ/WrtBC5f/PCp4gLqk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HDGO8duY; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCuzRgW/PMC6aLRyhlp7Ofk+q3jqZYU9GSE2rZymv86WteOCg3GTIfJDUipnJp32lgbbGwtlMtoyAKsZz+ih98aFrsYfmqrjc6zvu1mUMCXAmY5Fhymtj78jLz7srgjKnW+AMHlXyN7MDho+5i7KDB1/Q2jqbNGh0CyfF4QmEjJlwWBkBw6oVSAn6kJX6YQCT3jnfX0Xj2cg5KqT3VJ8cGZ96CsFlpLa5Ww39ayskjPSJ0DPQqVTgPeHMPb5jnH+TqVnStSAzus+X/kLXj4Gr183zQ/Qqbiag4X4FdPt05GXfrokADn6E5rsAl2Gl9mqaukcA9LEy8d7qbPNnipiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AikUXoVFalh9jz5fuA8LMDeb+aWwyKzYvHW7Og+SdY4=;
 b=PAA9r+ntHRE74oTe31S2gOnJ7Iv3t24odTwWZWzVoiqy7dXfvrz4RyyRsZgKqppP2PjUXR4PaRrKAKHWf0lWUaymQnv8oPVgtAATl3FgrEpYhk0ZwfwViXH+Sx+0tkFuAGygwmp9TFYbp1Lr5sxvlf7Wk1d3Bw3j7N//4OF59nEo1qlilRWQtYqnVH2ks8XVeE02b+kLkCxT0DHpdIcyRHp1aHEsCL5CxxlKi+ZrXdzmQu6xAnwPdjNHwcDnIy7JdCAlcOnC8iHjBkGObbYkcN4cd2mq33d7GUMsKobIy7xI/3cGh+Gii+JjhOkednpNnHj/QwuEaIBTowCE4lFRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AikUXoVFalh9jz5fuA8LMDeb+aWwyKzYvHW7Og+SdY4=;
 b=HDGO8duYp+6Pril+XrOBhVqIzqmXZWU28qg2h1ZuX9lG9yv7lEVMTRfzbEL7vQkmPJT+QBuO1AyZkj5U/Ca6P26Ujm+5mBYdH7ZJdmroFnxx6WB4aqHlicP3j/L4HUUz5i9HJyhxb8EDKbxh4ePXmq+zsjNjm5zq153b8gl3Jdg=
Received: from BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::16)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:11 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::4a) by BL1P221CA0044.outlook.office365.com
 (2603:10b6:208:5b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:10 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:09 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:08 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v20 03/22] cxl/mem: Introduce a memdev creation ->probe() operation
Date: Mon, 10 Nov 2025 15:36:38 +0000
Message-ID: <20251110153657.2706192-4-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cca384-5297-485f-5d24-08de206f044e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeOmfJDN2qPNnzbKDy0Auz01S90XPlf9W3/SgAdZbTFfQBWgaX8xiGeBBvlN?=
 =?us-ascii?Q?HsH9HZ9WCwvHCQtiE60As8Ro8UrC4SqTiWxQcAY/eB3+CKpcnXmzcPjHV5nT?=
 =?us-ascii?Q?jrVYQJ9ViiAgHzMyE0VeGHxvXyz5mGwfYqnluxC10lcUpeE3NfckHgFmeJah?=
 =?us-ascii?Q?IZsyxBirnOil4JP5YErOneQK6P7EBxV3CH4C0QZD1n+LL2GBLgK0NkXh/9wl?=
 =?us-ascii?Q?xmem2g8GL/20daaZEzwvcInwSeJNyb8o/t0x2gETol2utLZX2p5OowtrkXY+?=
 =?us-ascii?Q?b97hfEO+ZXDICrOIrYdcv1/HgVDMIeYdPX5z3dJneI4WHkJdDKpi2Rt5qaEm?=
 =?us-ascii?Q?az7sd6uN8aJq4Q/GuY147eBjFsX9ik0j9E1SQS74P5f7cyjsXudxKszmGQJf?=
 =?us-ascii?Q?XIt0njPBbMSwO8cnkeaEuNOYNdmp7JVzYrZL0MwPRylG8ZK1Z4CqNCvzjwzP?=
 =?us-ascii?Q?pwJikagkLLczwoISmYhXjbeC9/AvSRBjZeQJ26BumoJ8Bv0hJMr1QufDNxKD?=
 =?us-ascii?Q?UnWEG6KME4zBcjlU9nuiMw5At1KVOp2+c0Ev1jUAEjJEs6qInCdstRR2GGZ1?=
 =?us-ascii?Q?lShTC8clA3eGqZ6IIP1lcdr3Nidy5dR1f476+hjIT+9uL4fUORufQ7gmjOYx?=
 =?us-ascii?Q?lKBQvRKP9goSWN9bwq2d6Dnbz1e8/7SW7IY0nBenSqJE7e9wCdCMD4H3ci8c?=
 =?us-ascii?Q?qOECFF9ghJd7WMuYHmVNbS08bqD7+jXehOgzuEvxir2rzmbSPJwP0PqrN2EN?=
 =?us-ascii?Q?0xH54irAUUB40Z64bXCtt51PHZUoDoNEYqr6kBJNhx+l/9TDXDAEq/ax3Ojy?=
 =?us-ascii?Q?LYybFuHtlH1ELjrzhlBeW8CxcJ3WX9ClfiDF0OpuA/mNAV+60NnkcjtEShz1?=
 =?us-ascii?Q?3CBJwrwBjqbD8ZS4ZA3d/amip9YUC9OLZHV5mzr9PqqY1WQ2nNNesNdpqpD0?=
 =?us-ascii?Q?zu/MU5q49bTiUmgojHSpjoMyYrnqE4N6qebrgoDyS1G5kBQyBNj1pWAOHcLq?=
 =?us-ascii?Q?nPF5wpTqnu4R27M02zSeiSVyyX9OwLCUqIO+j8I00U7VGg/HjfBi9HNSYImW?=
 =?us-ascii?Q?pDQCgxDPww70USzkjtzifKpIlzlWn2HDMj3NroJ/tmawe/qIU/zf7Oqc13gZ?=
 =?us-ascii?Q?pBpIx8AyoEShmYvYjR80AOm24OXvcGKdaT+lQ81IIubAK+V4aCcNZ+Nnrq6d?=
 =?us-ascii?Q?To4+gGBG354oaKsjwXUEU2hSTkD9btaktz+aA2h2csF5go1ZP7QrkqZGvDOc?=
 =?us-ascii?Q?Mwokx/m6AbrHRRWPFi7mISZvjnlkqpsGjcKjVNYtsdybclIlVoQ7OZsoE/MG?=
 =?us-ascii?Q?92cLLgu0m4NOs1VuxJOUxCA2t73mEfXhORYwPsKEX7mtxGWozJT1Jg8b5cS2?=
 =?us-ascii?Q?Eg1L2ZW1GdztK1QOmWTgQ3qHoJcncJWPLPDPhTazFLlMAfPTnFGRC0u7cori?=
 =?us-ascii?Q?EXka2sg83tGMugaTMir8+WAcbuyqKZIbxkwN/gYbB6dKBf0ItPf9vPbnfTWT?=
 =?us-ascii?Q?C0hDCNqqgR4fBbgf/NxGSrlCmTVu0pEWKVIp1CBdEDIgCkKC4sdNXR3eUw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:11.8465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cca384-5297-485f-5d24-08de206f044e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

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
 drivers/cxl/cxlmem.h         |  9 ++++++++-
 drivers/cxl/mem.c            | 27 +++++++++++++++++++++++++--
 drivers/cxl/private.h        |  3 ++-
 tools/testing/cxl/test/mem.c |  2 +-
 6 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b4601faf66..45b5714651d0 100644
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
@@ -1052,6 +1053,8 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
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
index 01a8e808196e..ebe17fb6bb82 100644
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
@@ -178,15 +184,17 @@ DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
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
@@ -200,6 +208,21 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
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


