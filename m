Return-Path: <netdev+bounces-240138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C51C70C9B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 030E44E23FE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6036C0CD;
	Wed, 19 Nov 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ar8rsvTm"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E4369233;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580195; cv=fail; b=Gg5KOQsvi9Jay4AnizCp0mU4THIMDwEiytiv+u+pzQkJJDbha2Ml/dOAzVWK6/ZtgWvwBoPhJMhNWAL0dAceO4kWN7/JbfBUU4TN3ddGUftKEDCyabdK2gYut/ARoEVKZhlj5gdgLgStYxW9v3xQKaC6zscmC8V5jgbeAOk+fjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580195; c=relaxed/simple;
	bh=Ov+xmFenfh52t8v2laUp0IWEXj6z8A697FwJEMm/4tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI03RkNMQh4tSxW2jw0xiA5QDatjaewIf2sIxzAs+JdJWa0r2/YdPDgPif+he+6kKhgahnnHLU4V5R/B6n5YYTdFnaUQvErtiDPsVj/K+PyyywfjTJxzVvDfolH2WseaEnLJ8cAKrYb+FaVrq7RdjCSo4qadpiTWOrwBRl6NRcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ar8rsvTm; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eimfs5sEjm+Qr5MVHQkhfqeNa7A03WYpnliH7OgB1QtXTJDkHAa+9OpWO6qjI8CwgE2VJvRqEQqkFoUo3xstjM+yhDsui4j+WzsY4DlUZESuDihSg0ZPgzPgU20UVMRmWq1R7jZePu5HjxUgtdrHLqB7DwrAiGGOdIAt/9v+1M/it4KniKQZwRcrRQ+TehSrxY4BQCuyYMjHR3bKZ/imgfP0IA//016mmb1VHIjKLaZ5gA0q+qFvRSAjh147iuMjL7MsdTi9aJ4B3IlAMpcWr4RrCEwUKg8Q/Zg98zhGjaj+/4C4/XMafMF2Agm03DH1SCZ4ZoB1aZgfZZR2P/Py6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4PMXjNaeM1Swjeevb0I+8HpDQbluziaYmOcZXxfogg=;
 b=cEU4k7Jc7hGHnyD43vdarWoOM6niXkipuzPX1LGqrA9/nt4dvyLE1DoBDOsoRUJjo2d7fgFW/0XD+3U9KHm/ucDmyUnJ+xHMayTrmEWVGlR9XFpliplKq1CzsTyvoI4rbhRE+PW4jyXB42nM8R4OTmkDjw+bybBwmEQ+r8zJyJrqMTJeuXNZGKSzDCdTztkFUZbu8AXStBFNw065B1S0M7dK9Fbj5+JZ3NQEhlP/fw4+MZxEeMEO9aDZcKvdBrM2leBrl7Q/JKc5RdGgH0WRXXe73z23BfKku+BfOQOMa8nsi1PihI+EfY+WaBSxZU9Xgj1gBlZ0wt/YK+HXlM95Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4PMXjNaeM1Swjeevb0I+8HpDQbluziaYmOcZXxfogg=;
 b=Ar8rsvTmE0LugsYvhVI60TEpsLFYEUXiorvBj0mQ1OXMO5kKBvxh05Tgkze/MzV64OvnK4vgD2YDlN4i+wPX5o1XGtrI0lUlV+MtQPfWApk3Elez6Rj4lL+AVcEmRFOOa7R3yBultxPoDSLrOeZUmq+E/O2h3ZhOdclj6MIJ6ZU=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:23:00 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::d3) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:23:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:59 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:57 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v21 09/23] cxl/sfc: Initialize dpa without a mailbox
Date: Wed, 19 Nov 2025 19:22:22 +0000
Message-ID: <20251119192236.2527305-10-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6989e7-2a83-4a49-b45f-08de27a10da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfVp4zzGizR9l+vNx5c1WBUdha2o3Z1RtRfYxFLCgM6RX8+CUuYg1lhgRaKG?=
 =?us-ascii?Q?UFA856Ot78GFXkG3zABj0IvkBm0Or7cgMsn8wfDUh62DC5TVtzhdT8EPu1m4?=
 =?us-ascii?Q?xJRcBh9RxTIPLrCn/kiNJxbwphoOcGgxlf26Jl4zUpt5Mt+M0IbsPaEiaZR5?=
 =?us-ascii?Q?BY7pocGLOM6Tsf+PP7NnhBFluiH82ZoYSNJlbQ/clm4Ei4U3anCG/PgHoCqP?=
 =?us-ascii?Q?FAIW/YLKqvBQYwEZrrqJLby90PjlXhj2Wad5FZwlwc0bahH++cwj2I8k8CyR?=
 =?us-ascii?Q?f6P1oIy0sKHwiGjqEV5e/m+/8hustUbg6rJdnupcLiZw1HcKn98aBimnWmyM?=
 =?us-ascii?Q?D+Vq4NvxSTPMmMJT221bTMnL0zuiLJMV4YZY9/z0l0T2h/ZUxhNrI8tARUNE?=
 =?us-ascii?Q?B5nxXG1o/wrXWc6PQ8hBN/cy+LuAfAplHpQg3fgjQT0OBrccREZ7QcSmbpP7?=
 =?us-ascii?Q?6vQHMOcCl36J4PRK7QNF+uRJYwkuqCJqmaMCRjne/YjqFbEAcsUkvDY7RPqw?=
 =?us-ascii?Q?IuPZbmVs2pdj1oZqjhUPF9Dj/dY3II6Q79ed7TQbMg+XTLw04o+Mr8mJFJhF?=
 =?us-ascii?Q?Inz/vFdVC2eE1hzD/jFRuU6ZfFD2DpfYeKEHJaxNnzGH/BVQ5PGwVU7GSCDG?=
 =?us-ascii?Q?dY9cDMurrcYRv30+ZSxkKI9Hrze4rU0o7uuz4nL1GQr6xgCpk1MVzFym6Pk7?=
 =?us-ascii?Q?H/gA7a4CgyNtuJ/XngQTuoz1TTz1OMm3A73ACZNkWaTNBsCMXSiZ8N/LLim7?=
 =?us-ascii?Q?lXGncqqoW569XiJL9vxKrfPPEn+CeB9oTllMpFBXhkUHd+ANNd1ZQO02sI7R?=
 =?us-ascii?Q?1hrlpKEY3PPy+/K+LS9iWsjqUq1SAe+k4VakyUEkUnAD7h3vRjpSR35q+QUX?=
 =?us-ascii?Q?F/g/eesC30xhTpfQ3wWlvHryA/v/sLIs/v+Ke5vLqBt/WCFSXVaOs8v4EacT?=
 =?us-ascii?Q?vG1XYDg4hS4RKl7XRzaFlxNva7VUCWblqjetuD9/j8T/w1d8jJmZHYG2KtWe?=
 =?us-ascii?Q?a3aDwPsIlvCVQs3JGiEF+1nBquCbsZJNDwiK7afnc5lFMjqWGQgrRskfhzEH?=
 =?us-ascii?Q?jdcUrg1Vy7mjZF/Q8IdAV5gV2LhbwgTq2y8RQEITsNQBwyEPdq+X45XJsUNj?=
 =?us-ascii?Q?tIewsShwOf69//qOoxHiZfeECZiUg7di8N3NE/ibc/9kU+bJunwiJI67Dcf1?=
 =?us-ascii?Q?eIaYWPdH3Aqh5Eb20Wet+OsbGgJNKxn+UaOgUBVasJa8vPnmkkYqXEy47SS9?=
 =?us-ascii?Q?pkU64EiHETKBOtCLBbLZ73+/anK4U44yULAln/6dBtcHv9D2oGI61p73XStV?=
 =?us-ascii?Q?/70UgYedbEsFRUgkspU2igYdUwmKsa79cdpQatvHrYYawlIVnWD7sx88uOZj?=
 =?us-ascii?Q?slGrqiBx/UelRtaJuHge+UToQgeJXCArhu8kaQYN2Etc60uUaisit3kiFDSc?=
 =?us-ascii?Q?moted+F9W5l8Rq3LLJq22cI97qKs6cVGjy1kedzSraz//bfB6+JlH9e8nbUp?=
 =?us-ascii?Q?Ckbo0XaBtBFmqHuvGgKbJ4eU0uHeLFf9ZdjrivpJS4OJs1VY7y2zZAAxlnw0?=
 =?us-ascii?Q?nS9wVT99s2tW+Tb1W2k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:23:00.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6989e7-2a83-4a49-b45f-08de27a10da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DPA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile hardware partition.

Move related functions to memdev.

Add sfc driver as the client.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index dd10f17eb6ad..b995eb991cdd 100644
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


