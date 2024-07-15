Return-Path: <netdev+bounces-111565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A37931943
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054AD281804
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B924D8B9;
	Mon, 15 Jul 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="anyp9Gz6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E44D599;
	Mon, 15 Jul 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064535; cv=fail; b=CAJe0Ucleo5ail8q/HYl7m4VA91NzhphDw2FNfiD17Cs8pdW6Mv6vEeN74zQFE3uqT/GXp9kCmR5Iv3SHJYMJmnImjrxg/mz6pXYvEOyUJYCfcoad2pBO5EU8GXWP/F3teqXO73QIUN2xjyV+MIP+4jOdKLMTzq9zWSJ7A6n8aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064535; c=relaxed/simple;
	bh=KbvS0L2V6WUOenSh3BY8rwT1gN0n3MDbBGja9lJobfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMKQ/po7woJwAbLMS9Xw78EIhQ+UaBzJa4i7luJC9le/LdimW6ijr4iapGhfmWKjLPzdeWfZdjhS7KvjOUbR9+EmJ08NQcMHmwmDMCvyAw5go6JcTKb36KoKbMxDK8I17dcTmQNL8qeXq0tET6fAe7GpUF9MhezedUumCrtDRpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=anyp9Gz6; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blLSIidqKWOxUODssdzmXP4dpwcyA3oyU1nJ1y1GaftowIKp28sQlFD9xWdc5hZ1/TLnOk3r8OxreoTjEeL9bcCbeitElu2rOC3hhBTF1quUVLHVLiXN0mifHTqYNmiL4u9v7mZEmCvBRoe8V+LjCCZ7kFFlwLfFb3yMiPO/mHzOSXiBCr7Dm8jTvtvHZ0MfPmiXTihV2t6w00lal6/zfyuArHdPqV6sp4sA8cehjp+QdHNUj+Q8WwHKzxj5UWtz5GSpK+oPnEImMDT0Xbq4AWDRhMUxwlIwBYkQaz4iHyKizhZWdZyr2KnIEIFOh2h4XgAXHRdvUjUroAYEiPHgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvurDS4JY07gUZudNXkHJINl7mq9EFEWTO8lAzDZTLA=;
 b=N9/q5RXbm5p0sAwyRBtRF+/zBZ+Q/VsErbYtAdK110xFARKYjj2rf+hxupwdmkkJStyBoni/5JJQx/VghyBJZLLQNm4KHlX0RAcH0YAaWiAmRliuXNrKFBkbnN09stx62zIcDxuq8aM0AyFfq8wjbreIQneV+YraQeJszlsyRRGnQd3rmm/KFQDkVE6keOUNsg+PhBC2nKivWNlP0LL1ICMf4QNqQ+AKBpLDDVF2GfvtZ2/Xg2QJ7pNb/Q3koyPbZ1TYHEEOWrDD8kCfSx0DbEkdIHMYGUHm0YUaHRbv46uvxc0c5LZkTz2zvonLwnfN/d2mLk/Ng/xV5PTbq2rbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvurDS4JY07gUZudNXkHJINl7mq9EFEWTO8lAzDZTLA=;
 b=anyp9Gz67ps92iiqhIa3MPQRs96I/MQWFUQtEiUjGwy67CJGLHP+cJX9fAXN0cRnR5hVYZzMeRFsDZC7/+OlILyKUpCpgEjAdI/IjXkaDGVqSYKS9T7/VVo5gSpj/dVHrropnzBlCFHftLL78qGsaTWs+J9DSHYY4X1NK+8CJxo=
Received: from CY8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:930:49::28)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 15 Jul
 2024 17:28:49 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::77) by CY8PR12CA0028.outlook.office365.com
 (2603:10b6:930:49::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:48 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:47 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Date: Mon, 15 Jul 2024 18:28:24 +0100
Message-ID: <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fec45c5-ffbe-49df-6726-08dca4f39707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mfgIHKXP7DJtK04sGYoIvrCQ3tEa2lo+p/fEIcpMughz+Cx68fTCbDNvV85R?=
 =?us-ascii?Q?PlflBH3Tk3Yjoqyr4mcYA1ScAaV4bHbaupORuDv1hNyLQghYwBibz0TvhLK3?=
 =?us-ascii?Q?Q/W5WLuYYrBTcszOYeYxzXqsYxO8Kkg/OGWgJee0DoKJg7pvbngn1hsX53h/?=
 =?us-ascii?Q?VW6BNeUHOWH4y8FUTN4CD75lYssN+DagIzYGTLq2/0doOuLq74PfUYdip3ZA?=
 =?us-ascii?Q?iT16l/RXlf4trB8gkVujOJPJI1/KbjkjhY8l4+3cuhsYAWQa6YE+QFuTHK5s?=
 =?us-ascii?Q?dbnv9ngKMq9pZdYaKGnejUIPx7AUnEGOGyaxVeI2GCKsXVjlML8cg7/wkOJz?=
 =?us-ascii?Q?HiVDKz5nRxXh5xgbzuQ4Xnjfe/LaNHUgz9Wth3zgbMlgaJB2YwXAiXMXnweX?=
 =?us-ascii?Q?9gSz2P9nmnEydTbkFDdSU19REa+HnIDsEHmOnfW4w9bEi1Czup2RIZFnndD5?=
 =?us-ascii?Q?EMFhVvcuZ+rSS7gTDbjOlnlc02fF3rAKnu8zgUsovBc2NZGLCjYgutbr67XY?=
 =?us-ascii?Q?vhpi/slYO6a/ozGqvQ+q13P64pTOb6JxkVgY+pkzfnOITMftj7LuLdvGzcfM?=
 =?us-ascii?Q?XSeDdmCyyHg8f7yeczMlwQ7ONdYOEbU83+bAViSISPZ1Is5H6VoK9ipE2jl0?=
 =?us-ascii?Q?LAZac++Q2R+GYSXNMmSGiFVYZymaXRz5NW/f9gHXv7WNt4YZ+Mh4m0pLRvRZ?=
 =?us-ascii?Q?LR5kGGvQiicRorDw5KBMbEIzeTBZOf6W3KwKvziASeL/SqkP3USEorPZ6v3R?=
 =?us-ascii?Q?Tmxb1rapdjWZY+Mz2v7L7t5mvblZYRNI8xCFsH+EAYzUPnhuI1HzCKFmLcjZ?=
 =?us-ascii?Q?5UOG3ShRq1tqzHCbOgWVi9b5bEiLcxevZ4J3cj2CdoocHZ8vhjUXXzdHIh2Y?=
 =?us-ascii?Q?cAVohTVxJ+/r4VSwBSiG8DXAqXjm332MD03Z8b2NOtxUULn5x1Nq+76bDFx6?=
 =?us-ascii?Q?tUIZpfYdBAFRbxfdgGxNErNgybFOkhmWTRpXykaQ3z+Ky1zGKbGGb9AD8AEU?=
 =?us-ascii?Q?bzS/88f5skkwNHdtyoFxxHKhVHW07u6QK2ex7yDWJ0Y2jheeLs09F7ophvkB?=
 =?us-ascii?Q?pU6P2c1JTcNWtHomqhQsnrRPYrFnnz21gd5EWg5YRK60b+2K4pw7iMVkDWxy?=
 =?us-ascii?Q?ycxaIBBCYulv0vLUPctbnXp64upE7R6VkavzSoAh6O0TIAW3sbw+OzQZFqzh?=
 =?us-ascii?Q?ESiGb+nBY/Pws38m7tYW9s9GC/8YkRb4U1u9ij0nrij2tIfjU9c3p1b+SNJb?=
 =?us-ascii?Q?d4vQguoqDOCPTL19Hm+bYDQjM9pZZtwu4OSoHKX8h8GOixSH9M6h2M6gA0Mt?=
 =?us-ascii?Q?rxzg4Vj/EbzW1p/rPlmBPKAM8fUbz/QFEB6mydsil7jqoIc18jGV7TtJDMIx?=
 =?us-ascii?Q?IguDXV10KnfeAxE6g0GSwhkEgPAuznGb5YxjdaFzvRk7dZFWt6V+bXqoSnjP?=
 =?us-ascii?Q?p1jPIBzDhHdnimEks8wJbCnRH2AAdtaY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:49.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fec45c5-ffbe-49df-6726-08dca4f39707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

From: Alejandro Lucero <alucerop@amd.com>

Type2 devices have some Type3 functionalities as optional like an mbox
or an hdm decoder, and CXL core needs a way to know what a CXL accelerator
implements.

Add a new field for keeping device capabilities to be initialised by
Type2 drivers. Advertise all those capabilities for Type3.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/mbox.c            |  1 +
 drivers/cxl/core/memdev.c          |  4 +++-
 drivers/cxl/core/port.c            |  2 +-
 drivers/cxl/core/regs.c            | 11 ++++++-----
 drivers/cxl/cxl.h                  |  2 +-
 drivers/cxl/cxlmem.h               |  4 ++++
 drivers/cxl/pci.c                  | 15 +++++++++------
 drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
 include/linux/cxl_accel_mem.h      |  5 ++++-
 9 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..2ba7d36e3f38 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1424,6 +1424,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM | CXL_DRIVER_CAP_MBOX;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 04c3a0f8bc2e..b4205ecca365 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -616,7 +616,7 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev, uint8_t caps)
 {
 	struct cxl_dev_state *cxlds;
 
@@ -631,6 +631,8 @@ struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
 	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
 	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
 
+	cxlds->capabilities = caps;
+
 	return cxlds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 887ed6e358fb..d66c6349ed2d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, 0);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..9d218ebe180d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -421,7 +421,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, uint8_t caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -437,11 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
+		if (!dev_map->status.valid ||
+		    ((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ||
 		    !dev_map->memdev.valid) {
 			dev_err(host, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
+				((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ? "mbox " : "",
 				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
@@ -455,7 +456,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps)
 {
 	int rc;
 
@@ -463,7 +464,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6613a6f8923..9973430d975f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index af8169ccdbc0..8f2a820bd92d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -405,6 +405,9 @@ struct cxl_dpa_perf {
 	int qos_class;
 };
 
+#define CXL_DRIVER_CAP_HDM	0x1
+#define CXL_DRIVER_CAP_MBOX	0x2
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -438,6 +441,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	uint8_t capabilities;
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b34d6259faf4..e2a978312281 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -502,7 +502,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
+			      struct cxl_register_map *map,
+			      uint8_t cxl_dev_caps)
 {
 	int rc;
 
@@ -519,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, cxl_dev_caps);
 }
 
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
@@ -527,7 +528,8 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
 	struct cxl_register_map map;
 	int rc;
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -536,7 +538,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
 		return rc;
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
@@ -850,7 +852,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -863,7 +866,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 9cefcaf3caca..37d8bfdef517 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -33,7 +33,8 @@ void efx_cxl_init(struct efx_nic *efx)
 
 	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
 
-	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
+	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev,
+					    CXL_ACCEL_DRIVER_CAP_HDM);
 	if (IS_ERR(cxl->cxlds)) {
 		pci_info(pci_dev, "CXL accel device state failed");
 		return;
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index c7b254edc096..0ba2195b919b 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -12,8 +12,11 @@ enum accel_resource{
 	CXL_ACCEL_RES_PMEM,
 };
 
+#define CXL_ACCEL_DRIVER_CAP_HDM	0x1
+#define CXL_ACCEL_DRIVER_CAP_MBOX	0x2
+
 typedef struct cxl_dev_state cxl_accel_state;
-cxl_accel_state *cxl_accel_state_create(struct device *dev);
+cxl_accel_state *cxl_accel_state_create(struct device *dev, uint8_t caps);
 
 void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
 void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
-- 
2.17.1


