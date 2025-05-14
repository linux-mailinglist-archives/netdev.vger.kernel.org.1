Return-Path: <netdev+bounces-190424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB772AB6CA6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6978C79AA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9D27C842;
	Wed, 14 May 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gY4j8821"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1B27BF7C;
	Wed, 14 May 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229293; cv=fail; b=XFzCQ8j8C9tmxc2ymcSTb7R+iMAEtY0pEFMTn51Uho8wpX1rTdvIj1f1rBDiO1e219SgH+G8DBFZn5p/aJIryE0wXQTxa156Ku3MvBN7SR9l8dt4xxbIZ19lAqou+M9aTcQ1AsBN+kALHrj8jwifwalDh4QIvWa15uAjp8tayG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229293; c=relaxed/simple;
	bh=IYZonW2VIhU25gYQWq34qAIfpxeofIDr5NTDvWb1Vlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp+YLadha0b1cwFLJ8VL2OztWOoEGCPCoU93tGzV2AElmVxdaEksPvJy8anDxPsMAhoQ9Y31ZLDpKSEd556i0ztdOaThnboDgMwHr4m/dk2DAVF7h7w7dQO9LR7GhMtvn7cpFBBl+3rrYgJWa2QJzZEKFKkeKT/9bQq7YPPR6eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gY4j8821; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD+3y+BWfTvlO/8OO2OPcMadr+lJTssCy801Vb7fg26g3C5+ginvT14Xq2fBqNJXdI9whJRmdp7NoDjzG4VVkPjhQrTgPE9trfnY8JxXwajRS15pPjz6M9OpaUaIAaLBOV4jxfDtI1yBoMfSWYwfLXK7FIudeeOJ0/Jzjyg/eKZXVGnScJyRuAewyLNuOD8hZFfuIBWhzIkm7gb3HjqvrTAjaiEqf1yMOtfceXSUdIwIf0WbttNQEG85mE9r70BrWaPzwbnK81ltQQPzsDnNIZav0nlomtGNJx2iEoUGgVdZdLf0qoioGR4CBsAIZkWl/KIVHRbpo+blqu60TgB7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cxJoGB7/SPK9tS5lVbVrSt5vguTKc62C/ZhuUnuBUQ=;
 b=NOobJDdr3+urQXdBRMHEdT5amWFxSEC23iDRkyRMyaTSlgIvDY7EzkVi1/ODJF1atvtPiRDkBfgJUzGtzD0+xOpkr1jb812cJEibaimnNKz0ESMYP7LDRfScWvAXXCcjl5vEim0NmiN3dcKRUJmovT4bd9HwPMt3cw9uhcIE6m3vcdZIJ2WVd45Omi7/sE6MYa2DKC4o1S1uifQ8f37Tm5Bh9krVjqBx9dPZ1XMIsvWnrPlPWUx/cUdO63RdOwyES/i4KChT1vwCQiEFK/Mou7U5dCuhva5wltE0ynQmznG9+wIIQvOZ+ws/+Msnb/5H8AM7pzf5c6Dio8WcePW5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cxJoGB7/SPK9tS5lVbVrSt5vguTKc62C/ZhuUnuBUQ=;
 b=gY4j8821a+psY8epuF9UR4q8C/yjLot1NjutpUQVSAnLOvXn1RN8Yu3Mo6e33THZqRTVZBEA8GVYK/z9ZwPA8LiF9oFwfdgIKdVXRTnl/05iJq3Q57l0PZCsuF0FTiGdzg7BJl6SS3wnj0tMSlcYdrIasAJZa0yKNbyqEaXQPks=
Received: from SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::23)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:28:05 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::86) by SA1P222CA0096.outlook.office365.com
 (2603:10b6:806:35e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 13:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:03 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 07/22] cxl: Support dpa initialization without a mailbox
Date: Wed, 14 May 2025 14:27:28 +0100
Message-ID: <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeb36ac-77ce-43d9-40dc-08dd92eb2831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wBLEtSlk1jmmL/M61Lm5YZxX45EMAyZ9JknbvYdPDjRiUTmEW3u4Mc8eKjE?=
 =?us-ascii?Q?qjaKWcQ9FrvCsgWNzM9kJPoEk41hRgZ7a5w6D3pzmauYbQ9xkDyVmQf4J6KI?=
 =?us-ascii?Q?yLKRmsFRWap1k55jhDibten+2MViGW30LMYLwfzR50uURMBRhGUwuMBKwnGe?=
 =?us-ascii?Q?RZAb74z6ehpP1lG44hQP7AhpR7GesVUoBHs3GAabvlmDEFqDJq7b136XAZ7/?=
 =?us-ascii?Q?pCnPnvNrzdo7F1PN/ZRz5grKOjTDbR4W+pC7NCAwc+wT9XDhS0sxPVJ1iHWl?=
 =?us-ascii?Q?u2cNZCTn2cFeZqPCVQAJbh8gEhGF0ATRJh6+AJIW4B1iLPvssS5t2SB4Unfp?=
 =?us-ascii?Q?k57Hvj7qRK3w9ct9KRO3RbKn8Dgxi1zi83JW/cF68ySKfL4cwY9Ku9/bHSs9?=
 =?us-ascii?Q?JqaoNfZAC65wRQeDkA05LyuYbvwZrXPymWR+HdlZLtuvgQ6lel3ZXBS2yJcM?=
 =?us-ascii?Q?1JwYIuF/38jzPR5hkO/Ya11URxVaqmFVJnKSXq72EeRZkEp5LxxmxjTX0rqZ?=
 =?us-ascii?Q?DnpGHx6A1s8A7xdKoBt3+wXAIcY7dMNWbuRKMc/F4/dKJzxoOUthFFoXiVZV?=
 =?us-ascii?Q?nXVgpC4FjjYOSsHheEtxFw4zr9BO4Q1B9F+C3iy+auzWezimMyEIV3aZ78VD?=
 =?us-ascii?Q?2R0+bD+TsiXkc7Yp7jws3fGk3H044QqYZSuekVkg/KqRk9Cg10ER6TJCCBMm?=
 =?us-ascii?Q?44uGCn2kWCFCQtfUzDx4YtSHl1mt7+qPnOWrDVSOHss4rH+7TqlF44YbKVC4?=
 =?us-ascii?Q?JwQE6MgOdy4rlTPtNNL//5Agn59A5QagKj8hiIrve//2wAtscwuv1HzbwbVi?=
 =?us-ascii?Q?T/XPreH1heKahdyUxWpefMSPfRVvwn8d3/QeFjrrxZTATef+SipbuRBGCpbD?=
 =?us-ascii?Q?CI4txUqTtC8q0eJQB953PSKyjSiE/fh0AHbYXdu1Q9kU6eW9LI7r++yQJrdQ?=
 =?us-ascii?Q?UGn0tHTMcczzyITyXPkkme+Z1wS2mtY3rxCp7zHJtQ9gi3I0z2Jy5eLyUFKU?=
 =?us-ascii?Q?sMy9beJ6esn5gJHY/uffL3pl87eBDZGg60yNQ2CfLi0HjKiAprluuig59FJE?=
 =?us-ascii?Q?keroRdBBGlaqPAlJ1RoLLOxBypTPLDIdcFWhD3tVAH2qU5AyzDpENGbLoMAB?=
 =?us-ascii?Q?Unj4sa/3InuGMBTrPbjVkUbsagSAfPLUJfK9Lr8/+DxVbVf7L1XmDc2XOv/v?=
 =?us-ascii?Q?mnwai/QeOvjGoSnC9ClaZdgoIwAxTUPvBCvzkCku0E0tEm6pOOQ+Pa7LLHIe?=
 =?us-ascii?Q?SOZDkPOP/GOBHLbv92ePM0CWbSYTqyHqv7RRqqyva/1jg/HXCAkv5GTXmbkC?=
 =?us-ascii?Q?f/EeAS/h8atLy5/pA19Ng2SIOqBUDM//GU2vx1Dccv5tf6honaSe8P0Cv019?=
 =?us-ascii?Q?vkltP62KApdxzNVF6XTjY3x40MifnFloSJHhfBrjxLi4p5m2YiAnee9DNN4u?=
 =?us-ascii?Q?kcSDqKjikTgSLgcCEQiIIpre6/KQ4S9c+Cm0WJQAM7+yVAqtwCA5Vc8H0EG4?=
 =?us-ascii?Q?ZPBXLLrMeW1u2OcwKU11XYhIQaPGFi0rrfhQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:04.5015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeb36ac-77ce-43d9-40dc-08dd92eb2831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params which end up being used for DMA initialization.

Allow a Type2 driver to initialize DPA simply by giving the size of its
volatile and/or non-volatile hardware partitions.

Export cxl_dpa_setup as well for initializing those added DPA partitions
with the proper resources.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 26 ++++++++++++++++++++------
 drivers/cxl/cxlmem.h    | 13 -------------
 include/cxl/cxl.h       | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab994d459f46..b14cfc6e3dba 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1284,6 +1284,22 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
+/**
+ * cxl_mem_dpa_init: initialize dpa by a driver without a mailbox.
+ *
+ * @info: pointer to cxl_dpa_info
+ * @volatile_bytes: device volatile memory size
+ * @persistent_bytes: device persistent memory size
+ */
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes)
+{
+	add_part(info, 0, volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, volatile_bytes, persistent_bytes,
+		 CXL_PARTMODE_PMEM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_init, "CXL");
+
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -1298,9 +1314,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
+				 mds->persistent_only_bytes);
 		return 0;
 	}
 
@@ -1310,9 +1325,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 		return rc;
 	}
 
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
+	cxl_mem_dpa_init(info, mds->active_volatile_bytes,
+			 mds->active_persistent_bytes);
 
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
index 6ab6dcf81824..6d2cebae2ca2 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -213,6 +213,17 @@ struct cxl_dev_state {
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
@@ -250,4 +261,7 @@ int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 			     unsigned long *caps);
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes);
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


