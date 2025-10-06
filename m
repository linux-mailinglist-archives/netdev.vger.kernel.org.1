Return-Path: <netdev+bounces-227921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E3BBD91E
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716CC1896388
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286C21CA00;
	Mon,  6 Oct 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0d+gRTm"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF251CF96;
	Mon,  6 Oct 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744978; cv=fail; b=PQXS9q61mfwrKT0qRny4tzFF7ahp5Xn8jMeRGr1kqtPenbXYqRBtCi7gkujusJI5ZOX21CERVQxv9FJN7k+zbFbPdTrDkRdPU5bWOUAiR2D4uMqVcHp3r/1+OaEeXSZpcf74zZ2EUWUYygwDg8+cZa+agojeVTsZfjhuBABfUTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744978; c=relaxed/simple;
	bh=5VCPIYeZHyLRP79rJpoMcvyyRccMA8jd/80dZLb2J58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f37SGjuCE75jRFi+zVDZjewQo9YVf2ckLZNfXBwa/+o0asXGOZSzFZnnE5HCBXdy3hluyTUw5816SFN0NcDP/6kUybB2IXrifB+v81bZtDouJKNrMHi+LGFhKSTj8J+Xg51gTYobbJZ062prgI53Ws7hmGe9EfsYKjYLIc0LcTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0d+gRTm; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn7JujJFg2NAeWVFwQCPV20uWMsGvL4dEj9D6+1JV+YTN5La5tulfvIP7dAt83gRmcAKdPU4C8RG10XxkYtd3qlJ9OKCgByy4SBEU9OLcnl5UdkWLsgjSOHhH4JsU1b5w4O5i6Zv5+F5KPpMlWPF+FdtdNRObBQ7UEHXbA22RV8DeuTvL41PQsZzVh1nQjLwJl4Va4UYSxF/vVQOh5wEp6JG+AxbulGvhsnlpXjclCaTqiymkO7Mu0+3B9ud3YPFJ+mltkWC9SE5BhYcFPfx0bNMOV1c+GCeLaI3NO+xPnwKjc4IK0B5Ba2ZPx/9wmQxXEpzyTzKtM3IyEcgdWWbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV56aSgy/vmXBSDT8ND76CmacgNUhxXCzzUKxrEPios=;
 b=UK5XcSuUkc81WasPDHE6BgtBNrjAny1RZPXsFewqXWpU5rb2ZCU24YpdQUpldKIsQLbbmSzOHNhTt7xMy5q6tqa8R799JF5CehGtbX0law5De92wzTNySnfOyw5Cwp7ob/wEDTt4oBtmoG8MRMdmIr41H1cTPsYFG2FPo0K+XjBZTbCG0Kjt0mcFhJ8K4cf/7CFjKspUjim3FlsAzdd9BqtvRv4otoxr8Tc1V6zqf9uUCgSMwCft/LNGHoSRWToMTN6CIGwNGm6HYDztcM74S49HNu8zb94tzHb+mfjyp/yvBx5MGGcuNoyam52EIzWSdMv9lypOFOG12RrT7moTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV56aSgy/vmXBSDT8ND76CmacgNUhxXCzzUKxrEPios=;
 b=X0d+gRTm0oa9ofq6/VDrcbvKO/0J5bhodYqzRv6+YFliDXOh7Kcw+GKIUlEMhW62hpJjc6AHOhuWP8/pHXr0naC+8IGKWhD3WpvI3sW+pGuRSU4eFVaSktWAEyOvBXhld8GBYInFB6riMc+WbMP3dfgEYMBZBTvPF1xN0SOiSF8=
Received: from SJ0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:2c0::19)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:02:50 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7c) by SJ0PR13CA0014.outlook.office365.com
 (2603:10b6:a03:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:02:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:10 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:09 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v19 03/22] cxl/mem: Introduce a memdev creation ->probe() operation
Date: Mon, 6 Oct 2025 11:01:11 +0100
Message-ID: <20251006100130.2623388-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b108954-be44-4c8d-8794-08de04bf820c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udWCgMLqb6nNtD5x1+3I3fV0ebq/MYz49XwjwfP9lRg8EKZMfD6KVe8r0LfU?=
 =?us-ascii?Q?JRiymyqvOUeCN2m2g4cksRNQGRgtK9AMmAXwkDg1yYQpl7nM+RoKhaOkKFL9?=
 =?us-ascii?Q?8GKtlfFNpLAtrUa8CwXbSlmvI/4/kPoFXxa+ABNndD7tsV4JyS+rHLnCT2Xy?=
 =?us-ascii?Q?NfkWi8bonwEytGAQQ6kC4gvmjvJX0V87rtJ2H746xTDvPJdUhJCedTfjQc2R?=
 =?us-ascii?Q?hc31IZ2KMguks7dUVGIDDqW6drc+jigz/V/ltAhJBOKcdC/krqn1sn0yc0qg?=
 =?us-ascii?Q?Lnbl3n3gvhljFfJ1hslPcDHmTOmz7lS0SG7S8HX6BuUjcB2kPv0AmltUEolD?=
 =?us-ascii?Q?7IgeteWVMk3A1g+EEYAD7ezLPKpUpk9buGrXIEZy/BS1DMPCvO55jvCgspy8?=
 =?us-ascii?Q?d8jIjiMR86KGCrMdMy2nzcvxn0r2ofJ/xpb1JInUdlhMWEb5WtvJczDrB/LY?=
 =?us-ascii?Q?OCrJMV+XnBwiZG3ap58qAJd1EsM+OVCgEokOn1kt8jhGYGTKxVXIAbERyNXf?=
 =?us-ascii?Q?bqI1fXK0Ao4XBF0b0ecm48vtwbA10gFE1hCSaIogD3wb8BmL1T+eUN0avIcB?=
 =?us-ascii?Q?PAOrptQoHs3RNHbl3OX0I3Qj4Ub+bDQpmHIFGEtfTZt+umle0SC5vfngegGk?=
 =?us-ascii?Q?o88kJWCs8rYU085l+g3F4JvVXfuyVAFc3Y5gAkweWbQuV5XBu2ljX0qCYNCo?=
 =?us-ascii?Q?bsEZlFlcq4S7fxuaTXNEOemtCDVO5gwXzyckOm2FZAV0Za7Pf9bjM5ip/lfM?=
 =?us-ascii?Q?TJ2gLktor42GNYVijiyElHfuI/FY9pHko4sS6MSpvXdZHwgvMURcqwIORscp?=
 =?us-ascii?Q?/EBOD3zC0FclZRFdXviO/Ekyj76ufAmMfqsX7lSmxo0H4ch+Jd7AiXLics6R?=
 =?us-ascii?Q?rxCF33+pfDmHXciTc4qJ0YbJ3/SLwQRoQgJ92neDeXFUx77V4fPQe0TcGtlc?=
 =?us-ascii?Q?AiVv2I7pGA4CK/tRda+vsAbLG+O40yX+gmi4XDXHuiVF+/fvhgMrZWlTzGNZ?=
 =?us-ascii?Q?ESu5XyYWO1GK3ragJPMv0x5IwFufQqd5w2e85TiHMg2DK4eSBWqa7irZA/gZ?=
 =?us-ascii?Q?GEPRtbCeSguQVuqfp6G3afbmGBWO2o66ubdOV6SJjUqIOtMAx6Ig241e9ivX?=
 =?us-ascii?Q?hGW6X47eeqxbAJqFrSr8YbMysbo3ZQiPjZh0rM7wCnQ0acP3RBFhCmpc5AA6?=
 =?us-ascii?Q?7iN8cDUKWo15CK9WV69Mgr313KWe/filcXN3b8ku4h51epzBi4uQMaZGAbSG?=
 =?us-ascii?Q?/b4YZyHbzPWeQhk7zxjiArPv/bHIQqgIB3KOepP9ktu30Zecn+xiVgajOg8f?=
 =?us-ascii?Q?rrUx/3YGwuA1LaRbbWbb2HL4zd3oF4YPakdZzNXV4FGtpPcFGDASp+8qTHcY?=
 =?us-ascii?Q?fT66oQL4C3qifF0zeUpq36u6Dr2GEc2Xtb/0AkiIpaagvHtaKqzu482rj9G7?=
 =?us-ascii?Q?msiZeIeGsY4Cz1mvoOOJPUSH9y+uI0soWFVMN4bNE1VBBMVinUjbiRjo9F34?=
 =?us-ascii?Q?B1sYv1tO537dxam9AX4xdDyMLK0JLDzkVvaxJ7IUj+OKPMqZP8bYB/r6FGYH?=
 =?us-ascii?Q?q6pw5p7i7vt6kri9XnM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:02:49.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b108954-be44-4c8d-8794-08de04bf820c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

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
 drivers/cxl/cxlmem.h         | 10 +++++++++-
 drivers/cxl/mem.c            | 34 +++++++++++++++++++++++++++++++---
 drivers/cxl/pci.c            |  2 +-
 drivers/cxl/private.h        |  3 ++-
 tools/testing/cxl/test/mem.c |  2 +-
 6 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2bef231008df..628f91c60c90 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1012,7 +1012,8 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1028,6 +1029,8 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 		goto err;
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
+	cxlmd->ops = ops;
+	cxlmd->endpoint = ERR_PTR(-ENXIO);
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 751478dfc410..82e8188c76a0 100644
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
index 56a1a4e14455..aeb2e3e8282a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -145,6 +145,12 @@ static int cxl_mem_probe(struct device *dev)
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
@@ -170,15 +176,18 @@ static int cxl_mem_probe(struct device *dev)
  * devm_cxl_add_memdev - Add a CXL memory device
  * @host: devres alloc/release context and parent for the memdev
  * @cxlds: CXL device state to associate with the memdev
+ * @ops: optional operations to run in cxl_mem::{probe,remove}() context
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail if the CXL topology is not ready
  * (hardware CXL link down, or software platform CXL root not attached)
+ *
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
@@ -190,7 +199,26 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
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
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6803c2fb906b..0a3108d552c8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1007,7 +1007,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index e15ff7f4b119..f8a5658e7090 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -8,7 +8,8 @@
 
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
-struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
+				    const struct cxl_memdev_ops *ops);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 0f1d91f57ba3..3d553661ca75 100644
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


