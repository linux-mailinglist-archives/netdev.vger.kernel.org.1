Return-Path: <netdev+bounces-173660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625E4A5A584
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB8B7A31E9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF01E32D5;
	Mon, 10 Mar 2025 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rbNVYbgf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC311E2850;
	Mon, 10 Mar 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640647; cv=fail; b=WliU1CpJAAgFKmF6Hrt9mwp8qYuiTt4ZLbXWq+DQrz9Ac1kaqYdunQtS0lHJPz6NMjcySkrAqGQxVF2KsT5Dg113nJl3svtGbOZUoNA02EFi9OtrYOwi4BMvuwXpVro/qHAG1uyeGEEVUpIV6QavYh7XOfhCCbLLziQm2OEcnMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640647; c=relaxed/simple;
	bh=wCN3Btd3HDPyOZftBvPzdDQOQrcHWIwktkHlIN1Thps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTO5lYeX/SyPLE5EXG1PIbeA9sMugUJ/Zm36CY3FClJoCHwLa8woMewp6TNe2SS9xclLS5/ZpO3kAGRLRXGtjMQ6nX9nmDpzBm4OvVgnqU0T6NmShb6jSmpa5iBx99VpWEYe+QXi7kx9Ow6jWBs9ipFHechslwGi3TiE18F5X7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rbNVYbgf; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVQ1AtjW0wpx8NuZIV9ZVXHE5G6xsnmQ7QuMXHuDoplpx25dtkBoNWMZT1AjCgO9TVqhmwZLVcnnHQLtAEHTD1qrVQVYINavnPK4MQ0Kfx8QBOFNs3I8bIsSyPyUUX6w12XOHesB57we8Ldnr1O7Ix9kEfgpx6ebX7R+LRKumZr4F/1AOV+aXbgFX13MIXn/sEBNP5+LRNbwGyi+J6qttKNvufF4wO98eyf8v0pxixuSbBLwhxklN8STww+ELAzsx7puZ2G1sQiGoEbqCqGHFhZX5L5F+VngCAn8zdeLNS4yFv0yKZFl6AcGS97TEjoRNiLu8ntK7W4gpNOHv0uTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx8W1ZuHmRP9kfaDnDLuyEwl3Opw9t3aH+gzcPpA25I=;
 b=Ru7Qs6N1CwUcqyXAg9xrKLUXpN9JIc4Y7wJhWSCk2NsJ74zho2vR31NDffVSmm00XpD1RXv04IK61fMcraSTAAW6MnTs2QqA1fUoRH6s1IS5wRJonE+eqmcTpTnIoqJjBCovfhKJiHm9shv8VwLsi/JrQxQzioaqn5RI4kDiXp60x911uX9OfyXdBwQM3rPWovyiEXj5xi5JCQmZZrL9VdytW3K3Wy5wgGbdy4ZamaTELwI8JZhdZI6OELdmme79C8kCE2uQz/DI705Bgn6skoGvoLyMvY9KaQwQK8XCeNL2k3Rqm7Vr3J7meKtTj5dDQL8sUFR+S/2XGrcPbgegWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx8W1ZuHmRP9kfaDnDLuyEwl3Opw9t3aH+gzcPpA25I=;
 b=rbNVYbgfw+9qI29yTJPJkK0iFdFC+mgUFpbKWHDwLtiC9VtpmkqjhJJKU2uT0nJDDavgRNK/JiIeTPG0KjKYvWOIF4ZA/LzTfLRoMSvZKN4Dtk+PQzErHgEwo0+AJTFvogGb5TsygDvEs24FsXkmsUYSzXM/yAfNdJuRLQN5qHY=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:04:01 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::6b) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:59 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:58 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 07/23] cxl: support dpa initialization without a mailbox
Date: Mon, 10 Mar 2025 21:03:24 +0000
Message-ID: <20250310210340.3234884-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e66625-0428-4e4e-07f8-08dd60171522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvXxDvbumVdyz2UbLT7FfmUKGnGIe1AameIr3YJ2fWDKpBTbZeh5pi4XV3rd?=
 =?us-ascii?Q?LjtSC3Dqn0zdFF1rESmFBNthzVAmF4DIX40tc7tqgvQp0l32r4h2FixdQfAP?=
 =?us-ascii?Q?m1c15HrVz6UueNgSw24Xd3r9rpsy4wQIbE/0W6zhU4uUPmwsRY/SCjj4kkqc?=
 =?us-ascii?Q?jg6pJueP2/t6rZlhNMbbWgNTJLQR0m6l6gxJAyihppmPoZMl8ttjtz+zGEL/?=
 =?us-ascii?Q?G/lykLOHf+X771yYlDaASHtsLkr22ciTVACG1AqT5pIlj2lb48IumFazTwet?=
 =?us-ascii?Q?mj8htwrlONA1enP/TI2nO2JYivcMBR0j00awRDIjttONVKyPvjiTh1FJC4ib?=
 =?us-ascii?Q?IIU1hC5Sa0aZ81oBV8R5dB6ZtahNrx1kn2hM3POOQ05mknnNaKPAGMIxJyzd?=
 =?us-ascii?Q?hQBl5EmX22j+9QCB1yX7/88WjpuCeevMtEv0xFHgGe6Pb4zxFWsTUAFjIVNl?=
 =?us-ascii?Q?w+3ex1IOBVQHTgxKyFChxD39Gl2uTbdbhFDuAe3aThsnFKswnvU7Js7l7Q+O?=
 =?us-ascii?Q?LhFo1ej50LmQirP+vz4jRgGbP9ojiuG/hAHbmMbkOPRfT9MkdyfW0tDbSYEh?=
 =?us-ascii?Q?2HlOWfoqJIHQNar1jdqMdsRBOsue0pkmsEaANuV0bA//NpcMypPZN0wAwYcG?=
 =?us-ascii?Q?txaq9jI+FSGaEhLTsqrqxfDkc1CZFlvHu70CMfkz+NIlEfNsfh5f6ckvoCPG?=
 =?us-ascii?Q?XG51PF/ea8TyRK934t88cA4PlFMX7Q2z8sh9em5e9oiVhKtOlbCV28n5dBO+?=
 =?us-ascii?Q?kSOSx1vazOV1gcvtu/qvT/okX4dgw3gXK+jjLLWx76o0NwDJIQYs7mKFen5D?=
 =?us-ascii?Q?rNn/CnYeINzTTtioGDUhxvXbZ9aDNuBP7q8ErVKaW0sRIv277MnL8ax9Dn2S?=
 =?us-ascii?Q?tWpHClPIm3K3JMneG/CQy8VMYEBH1/5p87oczKcMcxA1XzK6vRBUIY7zMHet?=
 =?us-ascii?Q?1OphHOgsnkNrfTIaI1XXQ4J+5lMmPZw8FMSg/pFdze9tOOQl1hEIqaRJhmSs?=
 =?us-ascii?Q?d+9srcJpI6VDSBkn5BWZOu3w0JysgIzUZlQ/QJnn0Noe1zk31/mXvmCQ+2hi?=
 =?us-ascii?Q?E3V1Gr23WANOyTQ/QkvzXMEDf9JMb+3ul/HAnmP9Tso4CEvOQ9/m8F+YkOiy?=
 =?us-ascii?Q?xC8g4OVLkByzQl1bgem5RfmJdEgd0vrxGSWlGjGcBWRDm/gIBi0kijawWvqi?=
 =?us-ascii?Q?a6V3Ek7xFzpQhWl1/vOZ2LmG4aZBeZMZR8iXch3s+v9gyMJoWhQ7OQxIAt8V?=
 =?us-ascii?Q?4y2VGmLc+w7JUILEeXX4uNGqELoUXi4cGkPARc2J7THe0JgJyOPgFqb47PZp?=
 =?us-ascii?Q?+2RqaTQ79RjqgrTG3nfZ1fj8QFJQ2vs/6j5wioOHEfwUkYHcJxkb3epAD57x?=
 =?us-ascii?Q?0iqMgq2YFraUT9uYqx8FUAUCVYEaqdPSPMa9y7HzFf4ljxn8jMypFfgf0NRc?=
 =?us-ascii?Q?xSJXcBwRS35pxElPwh6Pd7JlY6p8w6RSkatrem51LACYbvJASiqSTxYnveOr?=
 =?us-ascii?Q?5TXO9+Yuu96t+0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:00.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e66625-0428-4e4e-07f8-08dd60171522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for dma initialization.

Allow a Type2 driver to initialize dpa simply by giving the size of its
volatile and/or non-volatile hardware partitions.

Export cxl_dpa_setup as well for initializing those added dpa partitions
with the proper resources.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/mbox.c | 18 +++++++++++++++---
 drivers/cxl/cxlmem.h    | 13 -------------
 include/cxl/cxl.h       | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 20df6f78f148..8128f48e96d4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,7 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/unaligned.h>
+#include <cxl/cxl.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1284,6 +1285,18 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes)
+{
+	if (!info->size)
+		info->size = volatile_bytes + persistent_bytes;
+
+	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, volatile_bytes, persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
+
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -1298,9 +1311,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
+				 mds->persistent_only_bytes);
 		return 0;
 	}
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e7cd31b9f107..e47f51025efd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,19 +98,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
-struct cxl_dpa_info {
-	u64 size;
-	struct cxl_dpa_part_info {
-		struct range range;
-		enum cxl_partition_mode mode;
-	} part[CXL_NR_PARTITIONS_MAX];
-	int nr_partitions;
-};
-
-int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
-
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1b452b0c2908..af7d3c4d8142 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -210,6 +210,17 @@ struct cxl_dev_state {
 #endif
 };
 
+#define CXL_NR_PARTITIONS_MAX 2
+
+struct cxl_dpa_info {
+	u64 size;
+	struct cxl_dpa_part_info {
+		struct range range;
+		enum cxl_partition_mode mode;
+	} part[CXL_NR_PARTITIONS_MAX];
+	int nr_partitions;
+};
+
 struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 					    enum cxl_devtype type, u64 serial,
 					    u16 dvsec, size_t size,
@@ -228,4 +239,7 @@ struct pci_dev;
 struct cxl_memdev_state;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 			     unsigned long *caps);
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes);
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 #endif
-- 
2.34.1


