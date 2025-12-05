Return-Path: <netdev+bounces-243789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025AFCA778E
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC963155FAA
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7F2750E6;
	Fri,  5 Dec 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JtaKAljN"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62232ED33;
	Fri,  5 Dec 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935602; cv=fail; b=YJ2An+7kNPxRiveRpILwiXdfppmcz6ylrhE2OP25Yev/zi4wrLKpOTDqtk6QNSgFqt3cmlrboKPRW7inPj1itLwmTc29+goJUTbSt0yZds5MeR9LQosDGSTx7ULYgAnrCnM9P3OtYQTTRASqFLanrBCuysa2GCVDakQbEXPFYjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935602; c=relaxed/simple;
	bh=2eGVzPP9X8jY8+kIh8SfbBfG+scjAWWn98Wh4tyNUJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ59ARMsmfaxZmEWYGP3f6Z1oKCmV360Oib4UZVtkeVi+RKN6idGL07zE71kmXMWwCRDvzgf3D/3O4aNP1WlbFb6R8k48LHKccTxouDA53qPRrMOB4VskG7VyfF34SYxqfPwZTKdjiwfD87ZtGNP+7hPAUF0T4VsDpbRanquapY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JtaKAljN; arc=fail smtp.client-ip=40.93.195.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB7i9TMf4eHFBvv2UsfpngKMZhPDV7N3TkUVFQ2omp0i3TDb/CqOj+w/3MZTWYcGp0k2PkwEj06Rt9CB14OporFGB+vq0rygL4Tml+3BHTZFjnWYYNNQt0KrcfAPONC9hRghjV0WAC5lc5WvzQlkI2m2qFQu8yynbTdqpAAsb3VdJoes+wVBr/8lAqpE/glSaEWWrf0ItpIsyiXKxgXEiF9ZhY9WLx1tG55KN57D6vyhal+Up9bajNC5/CB42eFR8wrtQsM+j5naGb147MicJXlRNxwQIx84NRE2+k+S/5cb5HKHCzoJyDFmIKqllxVdXEEEbHLfskcq7MvlkfMvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuzX/oN+EHn2SD3OVXHI3h/eUlHfIrB/fC5N2Zmo1c8=;
 b=n/DYFuiFFvR5eJsO5DSOfhYvkBS+KIvX/WAP7CZmSOYT3184SD2gb5MNW8h03/9nnI0fI6Lw0lUuc2MFYw1OdKeyYCfplcoJ11Pio6DeluOlRye5hiWPNN7tSWU0x+e2RV78GFNKQbS1uRyMG27NiJxU+FEYAsVA73pjFaoH3fIMgTjeWmjwHz5auyl25M/1gGRoSIDzg5lNFVTJw7BhFtPxKMSd8IUMooCbFOLDNCfkgwAAINzL3VXfeB2dc3bNFwYRL1UK5BcXMYzTl+r3ogg6KIaClQIEmuHPxtGQLTry1ttRn8q+9SGdMGby3Ib30d06jCj/GreKnC8TRsgDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuzX/oN+EHn2SD3OVXHI3h/eUlHfIrB/fC5N2Zmo1c8=;
 b=JtaKAljNnxRdCuFjddOcNGdc4TcjWk13TWeC9Fam48eHu3qg0hLm5oG3ler2d9sUDGNVmCbzdVWOEmGovBVYL/kV7N+8mFI7+hsNXMC2zNYV280SLNe7YTivayh9S5nlBXg6ux28jQKF1hD7NAZ4GCi4UzXWAmEA/Hhb3GN3GOA=
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:12 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::da) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:09 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:08 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v22 08/25] cxl/sfc: Initialize dpa without a mailbox
Date: Fri, 5 Dec 2025 11:52:31 +0000
Message-ID: <20251205115248.772945-9-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3604e1-4eae-4917-4643-08de33f4ddbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1RtwchLE0tisUtEQPjF4IfF6KqVHwKmcrFQLkLe38+Y39zMaze5gojcxKMf?=
 =?us-ascii?Q?mbzbd78AnsZOPuN4QmtNWACBYR0ZXFyO9WZUCfmyo3TcVgwJGwGrlK2ol1vN?=
 =?us-ascii?Q?LpTu8miSW1LMpYQP422mggPoa41bxnuNgIQVNgJO1jo0tCDZooRRO4GAJtja?=
 =?us-ascii?Q?0xrDrWqsvqJed2jmGVlT5tYDzv/0f4kWQH1F9WbRYmtgrEF7vdpZqoMaIaGb?=
 =?us-ascii?Q?yvbx2gr7P+FOrCGd+TFavpHHaRzx7wntn6FfobX77iZDzDzt65xZy66nmo5J?=
 =?us-ascii?Q?pYIicwGwZIfAZ6HZVQ12WnK38VbECUuf5qE23bDs8CX37KweBiznh25bhC+1?=
 =?us-ascii?Q?QPvTrMjugUp0IHRpJUWC5nxwlZE+uhstyPxd3BMQYqgRwfHRbdrUvUxwGovu?=
 =?us-ascii?Q?CX4s8l4bf9CjZll5EUa75jDZmSSNuHiXbWXv4Nu7L8oEfCvuEwhjhQnSebPb?=
 =?us-ascii?Q?Tv7gy94Ntv33271SJyEQTf54bd3T/wrE8aVNxsYOmY8xSTX2ZlNmsYfeMKOj?=
 =?us-ascii?Q?IzTl3v6SaEjuk8SI1akiiMxCSNHqBOKyYZJXLaRH802rP0DHzbCTDDcJLGDl?=
 =?us-ascii?Q?6DFh9QtCYYuXdR67Fe5Xyz4AyLWmCYD92pt5urHkRTqJdd6vLCnV+XDWuGhE?=
 =?us-ascii?Q?1pnhxwyXRaplkyD+pTwpMX1AU1916rXOzwXdrJ1m/iGmKCYrBn2z9a7FNQlX?=
 =?us-ascii?Q?2oW1ae/xpST8oxIe4mLH5RxL0Gd7YdQnMEtm5dTJY9fB5hD6pJJFgKpZ2Cwf?=
 =?us-ascii?Q?ZCtOvB1XnO9HgZDwXF0wfC1iQxHAG/FQnvJZSzNTD9Quj8we5cDDHk0GDkT1?=
 =?us-ascii?Q?PnMCXRJZC2xcf8d6WDBWtriabYTLiABq4P/fdjJvYmnyCRMspPf5nzbtGba6?=
 =?us-ascii?Q?VepXgCDMavBWw1G8gqNBuGMinYmGsKX79QIaGAckVUycg+NrmKo04OnWH8te?=
 =?us-ascii?Q?aDSqMfCdLYQ8OEXTOO/P8yt7WTm9oZmb3YWGMPggSuz9yUEx8Wreo0ItXxtz?=
 =?us-ascii?Q?Mby4f3061zMlWSOwxTvbJO1Avtrjwwe1RaJoBlasQVtIKoh/gNV4prpMPVZV?=
 =?us-ascii?Q?oa+AR5auR//r1k/4suHTYc3+YgvHryurZGFFMTxi/v4oqaPEWmnb+zfk8YSL?=
 =?us-ascii?Q?XfzoWhRrAkBunkzdK61rCBMLTjsWVlpGT/cjB4lPSr6LuGki1C1yRefSxNuP?=
 =?us-ascii?Q?ovaWT5H3FmeoRbn+qjks/AcA9A6VBGmUQ0BZbEP00s88E4DwuZoBez8evqoM?=
 =?us-ascii?Q?SgHyRc3jKxZrWJdHIIWT5W/fXxh4e0l2CX+YlNs3MwADnSUZZNbhHHVCwsn/?=
 =?us-ascii?Q?H9ISoQWoyxv82XZckkIvjS5ktXJD1hkbIQDjYmhTritjNU/Ow7NLQtQLioKI?=
 =?us-ascii?Q?vB7Ig7DFrVW9tsb8dxaHQNUvh5hJP0XPK+CdkjRoqZiP/Jp5h1keMF5jOVZe?=
 =?us-ascii?Q?wGLY3soF9jN82vobne3yAC62v0C+FX2jSLridI8/41mzZU3w/FxX0ttY1imX?=
 =?us-ascii?Q?2DrjGE9UuxFoVUB4ySpO36r7kQxvNQIvA7s8guLZAYB7gYBdb1Pl4fQBAddo?=
 =?us-ascii?Q?cJLQj0HnjYGiQGxdmWg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:11.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3604e1-4eae-4917-4643-08de33f4ddbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

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
index 1dd6f0294030..e5def6f08f1c 100644
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


