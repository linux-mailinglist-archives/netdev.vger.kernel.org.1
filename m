Return-Path: <netdev+bounces-189818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F438AB3D31
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8366E861B76
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F72505AC;
	Mon, 12 May 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e0c432XL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CB253B77;
	Mon, 12 May 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066280; cv=fail; b=sLDyYosLfAOgvCTm3ldfIA34wWyySMqeRt+lCtb10JsRhjtrXrRiGAovUQxlOviaJQlkyAE3yp5k1AzQ8pLi+TEp4fEcBNS4IwBzhYZmbPAFxXS2FsFTK9CzrXfZNOI8ZbsoVND9p448Fftm1xgVh8eN8eBQCCd/6uMNgc652K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066280; c=relaxed/simple;
	bh=F7YyqId36J0oipZhVpSVx5jFiVzEPnnlEdk4KEmBFGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3twEYhJwZkQJzcL/iWhZPNVMlanlnYkWZtX2wSAJQ6q/A+mq5sFhMmd8jk8i/XSWHXoJw6hq6CDCcv2KkKg+Vd4Z5a4ymfh+gloP0HUSqOOa4sUlt8sBNXFjVKhXZi2ORATZ0RTzzCLiSj9HrprLi1/tnqZV8jk70YFKaUvwjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e0c432XL; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL2yvO5heC3UX8vjYBdYBJQ31QMMF8ob9xICaseLU+RrVgH1/79f8pEMpdo+iMyvZGc/XKYUHKzc41JxZRu5J6U5q6ovl2Dmxc1F1mX9MtA8ioBGe6rl/is2uXAoVfVBSogh6dfkBSc0Kvc3nHm60L2sMRveKCGXxv5NRWvNc7bGsFg5S5Tpa5CQuOtRTBqFj6cLQtt6toDAyYaigByXVPsmGhqNd1UlhAY+8QKWb2tfYNGe6UU6z+cB+NecFiOGSsDthg16952OzowcPHSSdaCkrV1IZdDlrWLl+PxNJGqpKr8EkmV2SQ2y/ScpX0EWB+Pj4YXzN+kysosnwJyrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2o9jMUOdIcCEKRhS8yZ+Ghyml0ETbGgwdySAyPXlno=;
 b=ON4dmCWhA5TSNHlCOF0AvoBSmvArR2yXk1T7XDCnkYhaAyfGSuOUHLmTmJsHavNKyeONMCTgyrpTRadhWs9ITkjDzDQwkyEYmm/2KeFIesvbs3jygLz2dK43PnkQ14PRL+wdK0QuYPhjTDSEC1yNwhB/BIRn+aPW2l8WumzAqSISrtQP3hqjY71LRLb+Ck0bQIND6F8pWdQQ39/QvFp2QYSXhEw8HEe/VwIQT+XG92TrdNir8ClUbOeWxI1aXwSZiyAFeWeHcgpLWwrdalO5vs2alaXZrh4X0wpbYhFoEi47oTyz8Cg1PGkCPY0QL2Snmnra+HERNXJQuese3sx1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2o9jMUOdIcCEKRhS8yZ+Ghyml0ETbGgwdySAyPXlno=;
 b=e0c432XL9AZA+Fu8RtrTf6LlOBrMgC7hd0SrCoob1kAyLTZAol0Ay2ZecRThsvBXMTs6Gz1DAde4dMMQiGjATSJQWXuaSc51sPCLC/bsfWdm6xSrsSiTkvTvNrRAWQ5FBSMZoFgLqZE0Jn64nPT4xComIudn9hMYNJP3mWu4Sh8=
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Mon, 12 May
 2025 16:11:15 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::cc) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.26 via Frontend Transport; Mon,
 12 May 2025 16:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:15 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 07/22] cxl: Support dpa initialization without a mailbox
Date: Mon, 12 May 2025 17:10:40 +0100
Message-ID: <20250512161055.4100442-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: a94ebf2e-99e5-4da7-189b-08dd916f9f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+s0CNbMM0PbfoNWxqlgUGV4sjKZiyG0N/dtaLZ+SA4Q6JS0eFbCiU69Dgd8?=
 =?us-ascii?Q?bz51o6MjhmTZtW0GVf/XbZj0nL/Mdzx6Y1ZXDY8zS5rjOtUURwErVugR4RvY?=
 =?us-ascii?Q?yfbRHI/A2mgNNHXneEnMzHm+pJyyxwSza9n3tn4+YBiRKkFDghzXfxxcePpB?=
 =?us-ascii?Q?mgo6f1dZpFuQw0JJRuFSPURhL32nAHnM9hFdXj/OGNEIguk1Wc6aiIWEwwsX?=
 =?us-ascii?Q?if3JyDEzD6Y2ZxfQ4Gurm2RZPwL7CU4NWD37Bku2GtqbXBk4phaYMI8/ytO8?=
 =?us-ascii?Q?l24r6sYkkF2zmk3AwgPZ5iZOKfHrNWCBlvikqP5BDPOCvwfxV9Ub/mpVHJfE?=
 =?us-ascii?Q?mDVA5AeI6DS9aZLtuud7PQ9Vk7Hdb6x7QF1RQcqstq3RqONftTDbCXnt38tF?=
 =?us-ascii?Q?QQyUufssn5RVvq7lnPfn0Q+tmlFWgBr8uwB7GJNLTICzfw230R4Rug+HypWt?=
 =?us-ascii?Q?W0XISDy4U/4DuS+D6/Ygid4R4Hz/H3ADr3kK0ORyS9T6aDqL1/x/VKZVNL55?=
 =?us-ascii?Q?CTkk0v6zHnNCZTIPBvUS+SwuQJtW+aSQdLXA4aA2RyqEzgGLEnfwyGvZMxGf?=
 =?us-ascii?Q?f5B2fW19zQ8WpE/O1vEkoALmiD5MlbhekGcbLtteZtU3ppCalF5ZCBDrnOB6?=
 =?us-ascii?Q?RmhQ12SxyxRAqLOogySUVz4q0iVS6I8k8Tf5p1CIFlM2zqB18Qyhug16oZzi?=
 =?us-ascii?Q?6Q3H1bsV9OZe7IDM2fJeZxAPfpFiXJp4Dqq+puj7+cMHu5Q7wQGCOP/EjiBA?=
 =?us-ascii?Q?DGflgkRAOz/k7MprJhO8pD4RlTHCsAxIth4i64pEhQLyYzfsAPU9ueR7GMsD?=
 =?us-ascii?Q?1q9zlkalfvtcsJTc0ZvIYFV7NhSJqvxTIy50IBJuesnSsbXT+eaXEvwjgz+q?=
 =?us-ascii?Q?+9FvEEeV/QE3r+p1bA6LOD1JkdEzuCUm8fJkleeRpe4GsuIaJcJbAvQ9PGsd?=
 =?us-ascii?Q?/nFMFXgpiQqVXDQoMdvmbK38q3Huv3xtsH/xCIhSxG9kdxvvwbecXfyOALnJ?=
 =?us-ascii?Q?9s847ptdlJr7q3dpWAyphQTkC/V5vWgxjo5izSjssR6JKLXNY0d47A5osXF3?=
 =?us-ascii?Q?dX5sDBiumJ1QTvycrsbqj4SEx/fCCN6FMxxyFpa28wsv9J66MjnjDDvuv7rT?=
 =?us-ascii?Q?z8Ed+ToGuc0k18WemQDMv/Db5aPL0NbOd9mNJsrbeiVO3uO7SsGVEsiTCdQP?=
 =?us-ascii?Q?2tYu8PXHhcUgIPvAcy30DobjtE82drxljcn7nvxtSMAAJlOx0dHPnSEAH+G8?=
 =?us-ascii?Q?tolPmOu5tkxyvnwEI8cu9yybSv/O8PzJUNvuD/h207O95oZ+nq2Hy3P6zOAc?=
 =?us-ascii?Q?bX/s0UAdAmPt883U3iZcqzK8YPc4sgOqdANO2jbATm/IfI7fjsOBv2Y4+O/1?=
 =?us-ascii?Q?rFH1ETJcNjKo/dUrGKso4yYEtF1kS2A4WhmgDnxYGtLXUIaFEc0UTcFAIeBd?=
 =?us-ascii?Q?V5T1xhsaC/pDsEqYwgBLBw4uTFmagc6O5SCZvUPppA5jAzk+tESvseV6pi9s?=
 =?us-ascii?Q?yvUFQtNqWk9UdXq6u8+iMwDCnHHUwbX7AnFi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:15.8132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94ebf2e-99e5-4da7-189b-08dd916f9f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

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
index 5de090135d32..1698b2f90a4f 100644
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


