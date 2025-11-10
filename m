Return-Path: <netdev+bounces-237232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15573C479E6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163E73BE981
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5F2701D8;
	Mon, 10 Nov 2025 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="32izL9jZ"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30926ED45;
	Mon, 10 Nov 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789050; cv=fail; b=cEoUBXfx/+6v9vvSBb/dHoUgpbUzoA/setrR0oc0BiDTYb1k9IvhYEU4X0G6mGPn4MX+u0reOCAhb8XOA29Lvw4SWWAeDKv4Q5bJ+rSBtfY2IvpFgIQ0Vrwh3goK3Y0TUSWi8nZ6Fslzjn1vo0zR9kDXO/v1c+dlJt3tJGoa0zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789050; c=relaxed/simple;
	bh=LfyNz83DHgpr1m5wJOiEc5rZABxNYf2+Gt3rE7KqBH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4EWjEsi5mK9LildOHKmM2TB5SYmn5eWRhuAO0HLQ/LPRnlTfMCEx67XtEUKdISBTWFrLaROGPE4/gnQSL3VS1uTt7+2cbjhABjYdqR8xGqamImcoiIzMuRpAFysn5RVk9TjS1G+cvU54B4e46ErFxAT/NHO1cfGJyuY5lQXckA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=32izL9jZ; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKKT1phgKuDthzoa6UuFSBEJbfHlPQ0OGcGVKYDRpH2g1GZs8MnqScKp1/EA+iFJhLxnkECJM8DhYeFsC5b64K8iBlDawGiT3wdrs5IXhIhXtOguBl1EArMmaezzxpID9vabRiHw1Iq5OUlTACAMN3Uz+J6UH4n2MifER/93bJH5zIpjXzsWWhSze3SYIwMiTTEo9pw1zeE4u09qR7iPKt7vd5I+nCLHTIaWhk2NU7MHSLGEbC4z3c17DhMLsBdWo+8YqMPfbGClO/nvgcg7ZwhQpnHmyGhwVwUPguoqzdexH8Tu38TgKWySKtxdper7WWEckOPpRY3S1BcPWmbnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDyCjOzfYtdcbrLC+mGjOraROgZQkn4aXlxe+UnDA5M=;
 b=JFB4GN2u660xJm1/uCFm5j5iHpPSGaU5lJS1HzLsest2Uuddz5RnSFFBqiHGvIgBE3qFXrCTzVddAnr1nSYntw5kOkmUyMQhSsdSpE7VBH8PC0oKBx4OuLz50ykfYTTa8mJk7sZh9AxjOBUXYu7eIrE/LNX+U6ltpe5c7GUUcjdyepL2ANpCxCcN8LMwHhjF/PFPL9mllld5IAZfxWXfQNRRZBM3OqncotrWIg+0NbTmTIV/w+/mKQ3o7tXnPj4wFWgBVQO5jASWYByk+3BRDuC4tx1UGSyUoL1FGvkK3RcgTO0ViQKQbnC8zhSohFLQWTw+Bd6heih1kH8Y5ySu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDyCjOzfYtdcbrLC+mGjOraROgZQkn4aXlxe+UnDA5M=;
 b=32izL9jZZPTiJmEysg8KSTKlcz4QZ5xBtzRt8Y7gTAvDI6KYONhUE6wmVE6HP43Ysx4XbbspFE2ijZDuIkaLpc0D+eKD/n5EdskN0r/xYcw1HH0MQsPTGibLLe6L4bfOS83/+5OUe9Mp9qfIbXaK0/4i7NtI/8XqP6r457Q3P30=
Received: from MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::24)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:25 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::72) by MN0P222CA0015.outlook.office365.com
 (2603:10b6:208:531::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:18 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:17 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:16 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v20 08/22] cxl/sfc: Initialize dpa without a mailbox
Date: Mon, 10 Nov 2025 15:36:43 +0000
Message-ID: <20251110153657.2706192-9-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2165f23f-4044-4c16-3d48-08de206f0c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6QBYnltWZC/S192q9WZAzi8psoM4aW5KgF9cIKRRQJR+WhdReWpPBKY2dKso?=
 =?us-ascii?Q?ZLZGbdyJtnDYTilsS2acuAsMEx8vWgllEIU7iWDa5fynnldkXrHVHIfTGxLp?=
 =?us-ascii?Q?7Rk17oC81Fi3cbtpPEyGBvUmSQwwaU7LFxLpRY0hY/VhO+/VmbpFu+p6QhE5?=
 =?us-ascii?Q?Hd3Q55/iuvvLpl2U8MtpL/KwZ1JkUXs+XRo+oet56X7T9BpgC1I1Ly31Zwg5?=
 =?us-ascii?Q?r3ke8H6hq8vubm2/zqUbA2gVnsgfLo7JsLK3gtf7/+TDERpdhgYzrdrq/WS6?=
 =?us-ascii?Q?Vms4fvIx756yQfXfh82oTOYuM34g+/yB1RqEUaivCrkuUrz4Cw2HsA9Kocnn?=
 =?us-ascii?Q?Q7kKo928/koIrvZk9xvPKYdx2kCEvcYakhovmr+f6pEFuRlPoYsA4yjWpkCc?=
 =?us-ascii?Q?cj8TQWDatxsFZbjAKN5mY4DahLSzMm9CJEBWi9wbVjLrtUusJr3DHyzCneQm?=
 =?us-ascii?Q?Xdrfkah2uDW5C9iYMfMmKxNXfkS9ZbSC+jd2+tx2YaORWz5Nwk5f3pniWvFX?=
 =?us-ascii?Q?hf6yXH80AFaZ+A+/Sa9Hs8XjyeB+ZF/ZLUPlWsMAPje9qr8TM2trGcKGV7Io?=
 =?us-ascii?Q?GJAVc5LpzOQSsXDKZgXVGN/eIjzbAkf1ITldAH0zQ0przup5E6gUCeQXG142?=
 =?us-ascii?Q?9+/FFCBIrj9rV6OBi1IlcisMSiMWl1ZshtAFVJXNoNTE3IL4bzHnw6MBpac3?=
 =?us-ascii?Q?Ftf3uTNEvqN7lTI6By1ml0XvxvZKYapX4ot2M5F3ekIUVQlM3bIb8RWqERKJ?=
 =?us-ascii?Q?BUHafOJqLc0svGmwS0auY7IXCWI7K4jDjp65txCkvcD33vnrgkArS8wA/5gj?=
 =?us-ascii?Q?W/ZRY2fGT3ZTD4hVTyVfAFrc7bBAMzaG8nQTldGp0fImqt47tKkEAWzWQ0yw?=
 =?us-ascii?Q?93z1kfOs7qSX1K8g1JkEgv2rQyN6aE4sieA0nmqaX3bHOjDh0q6Z7cPcKDRG?=
 =?us-ascii?Q?wRCLMTTA6Er/EHFbTEHQOBti5+ox4UNEwaLF5a7usPBBG4bEU4hrafDaNCvy?=
 =?us-ascii?Q?hl7d4rrNlE3K4qcnixFukZknNNjS99INhvLkNSNhSnwi70DO4U5ahrJWyFaV?=
 =?us-ascii?Q?107JRLiRs5EarxQi7miB2dbxYz+dZnGcgvvvUJiSIBD4EjrS+K1Tq17H0OWB?=
 =?us-ascii?Q?mK3UH1kMr9a0uOpjKFyfYp/Fcegq3DeVMddyISA7HgQwxryG9uBWuOVKuT7j?=
 =?us-ascii?Q?YCyY1pFHN0Z545CatQ8637Y/e9PLPqtwmR7pK3FoaThpMT6CXq1tef0ukIws?=
 =?us-ascii?Q?Mb49dYbINqu/d/AJR9dJxEH5tytM+pf+QI5QOKjHv35ZwN6u+pVTuvPwCnAH?=
 =?us-ascii?Q?Dv1qq+hWS9YG+2brnBAV7hATI7IhSdNfOwqd5f0OyftuuyxSy51y2oCZM+wY?=
 =?us-ascii?Q?/4Xc9l4Gq3QPHYhL4dHhgcC7K908vxT3CDy1XijY8t7J4Ncu3YgfGpTNlC/t?=
 =?us-ascii?Q?wNS92iUhvOmgGsxOTT1OjPAQDN8DXu43MRUdZq+ySchrnG6kji7Hs+ejLErm?=
 =?us-ascii?Q?6pyt/d1ciDXVbCajDowvpOmH7ydtFd8jOk4Egh2Azep+V1fDPfY86hatvKa5?=
 =?us-ascii?Q?0usbIU0IT+p49UBgaqY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:25.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2165f23f-4044-4c16-3d48-08de206f0c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/core.h            |  2 +
 drivers/cxl/core/mbox.c            | 51 +----------------------
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  5 +++
 include/cxl/cxl.h                  |  1 +
 5 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2b2d3af0b5ec..1c1726856139 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -91,6 +91,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+struct cxl_memdev_state;
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bee84d0101d1..d57a0c2d39fb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1144,7 +1144,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * See CXL @8.2.9.5.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1300,55 +1300,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-{
-	int i = info->nr_partitions;
-
-	if (size == 0)
-		return;
-
-	info->part[i].range = (struct range) {
-		.start = start,
-		.end = start + size - 1,
-	};
-	info->part[i].mode = mode;
-	info->nr_partitions++;
-}
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
-
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 742efe6ea95c..ea76109280f0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -584,6 +584,72 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+{
+	int i = info->nr_partitions;
+
+	if (size == 0)
+		return;
+
+	info->part[i].range = (struct range) {
+		.start = start,
+		.end = start + size - 1,
+	};
+	info->part[i].mode = mode;
+	info->nr_partitions++;
+}
+
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	int rc;
+
+	if (!cxlds->media_ready) {
+		info->size = 0;
+		return 0;
+	}
+
+	info->size = mds->total_bytes;
+
+	if (mds->partition_align_bytes == 0) {
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, mds->volatile_only_bytes,
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(mds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+
+/**
+ * cxl_set_capacity: initialize dpa by a driver without a mailbox.
+ *
+ * @cxlds: pointer to cxl_dev_state
+ * @capacity: device volatile memory size
+ */
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
+{
+	struct cxl_dpa_info range_info = {
+		.size = capacity,
+	};
+
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	return cxl_dpa_setup(cxlds, &range_info);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @mds: The device state to operate on
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 34126bc4826c..0b10a2e6aceb 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -79,6 +79,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl->cxlds.media_ready = true;
 
+	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
+		pci_err(pci_dev, "dpa capacity setup failed\n");
+		return -ENODEV;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 7f2e23bce1f7..fb2f8f2395d5 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -242,4 +242,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
+int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


