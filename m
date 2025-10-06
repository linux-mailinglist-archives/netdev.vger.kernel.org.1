Return-Path: <netdev+bounces-227932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B4BBD975
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73FFE349F66
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A55229B2E;
	Mon,  6 Oct 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Huzeey24"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BF21D585;
	Mon,  6 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745048; cv=fail; b=JZI6u+ZYW9UhjjrX7QEL/OSWFBmJ8c81mEEbscVU5vHkxMz9Z4J4E3Ta2cmaYBqP7ec0k8gm91YJcCYoWOJ8bJo7lAtPc7I/EN43nD2OeLUV+mNmcpW6UFJE+yRKxsaMzgWMkFm7qLDUifYmisOzXTrw+d8WUmVQDtdWyR76L3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745048; c=relaxed/simple;
	bh=jelgNw0caPOaK3tCxeJPUIa/1AHbvyPTVwoegKYvmsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxeDdCMH89gSdpYi7GqaEu3T7np90N+S4gKjHXiBeSAqoa6i7q2jCEWxKVsy+NGrV9kSByyrve/AET2uaLG7/bnw9tpcAD0Hy6oWLtoIxNr40ZSx9GIR+Vczd/fNp6wDAjjq1/wy/vf+Xv+OFjsv+w3BPn3Xg9UF2D218VLsKnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Huzeey24; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTjgK3+Xi05Kau6Jd4U6LLHzzdXpAmaLWw6Tk8qAsRV4b80H2Z0DKEjq9NshqH67fQk4bFPFD3dlQZALvljIPXtbZRpyC3uZbYwzPIolLi4PC+aFVv8oYygozoGkFSu2UKj5Qxik01fcsnYXnEW/bgOpnhuDXPhZe7Z3vV/ZHDZkSItHvddFd/LFFVVJILAT31EOt90TR8wvjyu4p4f/7Cj+TrXX0EGiKe4Xj2CkyG4sNSht6Pg9POOafr0DtLIT5ezk3Ie5yoLXNgTBu2+k4eEzeQV6/zDgdRo8WZmAVYrvuIvFbxUHTtg/C2AVg3m+ibyF3nj/Mjq1pK4bSoMTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GlSEGFW5BNweY7gJRzupvzPLy2dE0QGHfOmFJ+mtpw=;
 b=SGGmIMtbnnyZ7RUOuC5rsVX5LWrXWAR/6mp705qsTBgUny+vDnzti47dI4Lw2yYY3zbATn+ajcMReAcKW7c2I7iHpL20eL/SbswdUzQiuV8ljibt68WQ3fDbyWQWd4+UxJTEDJLH2/BbrpurtFOXtPaXdBsNDMX6wkL6Y52fAG1ED8xr3bfih8pFCMq4kQQC0klLhRi1RNxJocEGPwKwVo8fglI50jDAZN9CTBicx1VqJhyYCPeQYCQxWUwVZNilg8Nd2mzRhp+Eq8kGxM0pSzcp4EcREke0KPdRoFHVbD+1PFPJaRfe26H68SYg2Yt5qVERlAjGPI8FQY6UMlbG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GlSEGFW5BNweY7gJRzupvzPLy2dE0QGHfOmFJ+mtpw=;
 b=Huzeey24mDE/mDUiSWtTF7hDk6FZVqQEWfO8A7ourgJ5XwmNOZYa1os3I5qS6niNscIZoNO4sKjStxeeeLHYQ8U+QXC0rccbxlI8Lma1sVl855g47RuKpTCcaCOOSO6H0U33NP7lQaqGfYT7Wmjgs7sEIeJC04aZmNF8GlvWwN4=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Mon, 6 Oct
 2025 10:04:00 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::5e) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:19 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:18 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v19 08/22] cxl: Support dpa initialization without a mailbox
Date: Mon, 6 Oct 2025 11:01:16 +0100
Message-ID: <20251006100130.2623388-9-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6477da96-1ff2-4c7d-50e1-08de04bfabac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lvw6nHAyEcZtb6Yue4co1zZ54t4sdTFcuCjJNkngyOsrfssy/2EC7ZJ9QOHQ?=
 =?us-ascii?Q?z6fLheBjk7crGtVa2OVd2OaZI95gBNKfZsEk2+rgTOSkXgoatwuraFM5FlK8?=
 =?us-ascii?Q?+iJM4nqy/OFnUIZtsmIOmO0xy5knxq3rhTOlMaAkpII5HIUv+9ZkzYT2aVXD?=
 =?us-ascii?Q?YvI6WElfVCe7qeH8ppAjLZMAa+LKPuL9qKJ2Eu2cEGlzDVvYoEEM0ZIQy/+t?=
 =?us-ascii?Q?NIu3hpyqW97ZobrM/f2e4IbksSTRYceVlIKUYcLxtl85bzOTTL14g6EpZ/qC?=
 =?us-ascii?Q?EBu2yxoCngJ3Ex9j6kfJ2UR2jPbmHtV+FZmvxBjbFziLOgwSWuDcnDb30rMt?=
 =?us-ascii?Q?4I+QMO5xKi0v+tj/Yl9p/bWyvccWOkIR8jRvgI1BTI/nbTVu5sWnFPrekc8C?=
 =?us-ascii?Q?ozvabu2Tt96q1AVqRyOtatAtMtUmu5Wbr46657hfxwtXvuvqD8XN+WrWNk8l?=
 =?us-ascii?Q?4IkiMLLzaBb13I4aD57ibXLxp+Q579U/jyRPDmikLglMF6fD5qMPImZ7AxOX?=
 =?us-ascii?Q?RaDBwf4FVC+tB50IXAgDzODgJNQIrMTjVnxiuXx7lv3LYjqe7I3LlmBNd/bo?=
 =?us-ascii?Q?3qdxqokvRPLBARfUlLuMNjyv0d/Cl/pYLVR8iKTWFvJc+X6de9k3bbnU76e5?=
 =?us-ascii?Q?6JZxZf9NZSsDJzM9UCPTYgQYC//p6WdjqH7BS9Z0tFeEU1ncuIwSRmP35bek?=
 =?us-ascii?Q?E0KTulbmi9Y+xSiRY86vJlfhU0jACzPBG1GBeTteGZy+IQD2MNrmVltTlo7J?=
 =?us-ascii?Q?qUn2FueUSOv7W9/gUBgKeHx1IxyKx0wS4puyYZpObIcoCInZRF2RzSQtnbxK?=
 =?us-ascii?Q?B5MYXj8Hrr6bZZrEAedux4SmPgi4OSANQh4Wkgr4idhmoZv+NtrdheTqQAgg?=
 =?us-ascii?Q?muRyVJ8FgMx3LGumECjjl9EiVO9B054Ay6q3zTJ5xx9a7WSvQJ/Tggm3lgK5?=
 =?us-ascii?Q?cLFSCEBIkhn4j0jriTrHheMYc4jipc/x8TC5S05aZd3Nxn7lctbuuC17P/Gp?=
 =?us-ascii?Q?DylqkdKJdbeLUFSafnO4ac6w4v+DydH4XEM+tJqSQJVUEMc2baBpPz1GPTOq?=
 =?us-ascii?Q?G+uoVfzij2K8Kq6PBfx6tMXhRympSm4hjazbtjMeZ+ZWGtqwLh6TXf8R021W?=
 =?us-ascii?Q?F44ruyHmZQxaSWyUHtUTiMX2Yu9KsP0vPejPTgsRRF1giuokBdJC3OzXRuC/?=
 =?us-ascii?Q?8M7VRat4K/PTh//bvNfx9UIwDjVOE+FXC0al06evZFXOFMNdCPVKCqsA4E8D?=
 =?us-ascii?Q?Z7NOUz/PVMRfTYTPJsLP6zojAN2KWpcRcgs0IZ2pa96ZmOCIcm1dbquFKROh?=
 =?us-ascii?Q?OJwnLwJH0HVwOH7898Hbj+vg9Lqt3hKTYrUo3KuG9PNfbzQdc3/CvelHLFbZ?=
 =?us-ascii?Q?yEhtWhpTiHZgJIu4ZG1+Zse4CKpICGqAab0kWdZe4eopqPnAliyuj+mpQAAv?=
 =?us-ascii?Q?OZrbThv31N0gdxjmTvJHBgOVFcRczGH3FmlNDRVGxR/yn1d48g/vA3h/+urw?=
 =?us-ascii?Q?TcZ4UJnUGigDe+kI67Xt6q17Ly34IsoMSf/EWRcQFjkN7Ip6nx3b+X4PjJpd?=
 =?us-ascii?Q?u6CYyTCCR9pvVJzzupU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:59.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6477da96-1ff2-4c7d-50e1-08de04bfabac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589

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
index d96213c02fd6..c4dddbec5d6e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -90,6 +90,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
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
index 66d3940fb60a..1f1890a93276 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -556,6 +556,72 @@ bool is_cxl_memdev(const struct device *dev)
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


