Return-Path: <netdev+bounces-189831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CFAB3D3C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B019E56DE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B112920BC;
	Mon, 12 May 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e86KE0DY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284429290D;
	Mon, 12 May 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066302; cv=fail; b=BF76CDGYaVT+jNlRrhiZUPvrZ/k3aVKPqLG1nszr3PnOcOM6YxCmkduW3vnJirIh2QGBhNB3e+/3+64HRzHqtouwOOPu1v+VQwdIeJMtZ0mOHirQgKs3xO2+yqz+cf9tGiJEXfDDcmdqwLg6JL73aN5ofUeSNc4ZChMzRcDbL48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066302; c=relaxed/simple;
	bh=yZ5lZcG5rvF/0GMvBVQRzUt1RIPqfxciPxSDqAPJV5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDiE6QxJhvmjjvTaGTughrTO5qEbCiPfA6A9gYQQSyY85l6aP2YfNUJlZ/yD82reaZlDq1l7yRRAQCakcaLAKMXDqoC561O/rVE8BwCSdZiCIIwP9HsT+eyQAKVprMBSqP8CqPUTw8oBs00Ec6dwmD3mjLQOA7xQ8Uz8ZEY6JsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e86KE0DY; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJue84i5zFw38OVRj2PyoKGtl4atuNZkFlxEyeXxYkNpONL4IK5Ad3UeV8WWzPCCD8xDbFWdZOFSe29cNiQOrBD76VNhSau+Cbv4F8liwYQ+s9t1O/VElkIZybUD4l+ieqJ9HqIyvppHxm5sc/+P/f5aLXYOH65Vziuj5V0CKLps/3YocyZkOrVOTykTA07ardAZp7PgPqlje0+WLC74YQZJNE0NJL/XBRaJlU0sea2C2LfGi8W3V4uMMCMxMGz6hbN1oipKfybbx81swGpy+V4UT9OPlx4nsF9rYdNzU7XEwKnkAIH/4XVDVAY26b9PRyBGXtUXTu4dz5px2am5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1NODaWcBXBIF5rSwiq4+4XMwW8jBbJKR2PbEPNKTe8=;
 b=k2t3+rhK8yrjjX9rW0gwquZSsappLCLC4xNOAcpkC8T9ZnMZ6eDPlDJpUPd8K7mfowhvEHi0gMAagOjQ4uN+KUnLGy6NXh8lyMH96le6R5YQOJcwxyPT4xzWW8pKsvcoX96llBf3gzNbBBvrqaEF85d46sIi2zGNqF6V9eU6Xwu3w8sq0bKdRVlWiH/e3Ix0Jjv3b7g755cyKOyOcWUQ8FWwLRr3x7U76boyD8RJgSTHZ6O7/qTZvNNqpicb1P66gKZVmDElwgS+KAa5Pcs74jiBgOwvEZHyGN7vuyDO4FEFTmWrQqAe/5gsNnwwVBSIneg74SPrhh07AIuMrG22zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1NODaWcBXBIF5rSwiq4+4XMwW8jBbJKR2PbEPNKTe8=;
 b=e86KE0DYWfAV4OLtfcbXMKv56LKWpcELo3jnwy6rC+S1StBxWuZ2vtnSWPgU/1Eh8qj+rlY0CfkDEVsUU77F6qlUb4t3cnWxnjvflhzNPhrZkSkY0Oo0JAQf6i/24Zvhi+0Efg2ICGGR0yLEbn/AoyppO9AKbS4VOIevF6uUuik=
Received: from SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::34)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:35 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::34) by SA1P222CA0001.outlook.office365.com
 (2603:10b6:806:22c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 16:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:34 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v15 19/22] cxl: Add region flag for precluding a device memory to be used for dax
Date: Mon, 12 May 2025 17:10:52 +0100
Message-ID: <20250512161055.4100442-20-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c78f0c-f7f8-43f9-2023-08dd916fab27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4g8YAmFF0ejRTj0pUxnN1Z7fxpC2xBk+b6wePKX9HFwHi1UtO/KWcAgjqPOL?=
 =?us-ascii?Q?9fMcHVk6ExGz3OKQtBf+2TbBxckw/g0Aws5bl45C/sqmTXF+bOyQxDsf5REa?=
 =?us-ascii?Q?Pb5Twhy2k0asJFiqvY7Tmidn/xqcrcpo+LDUaz6Rg/MZwpIHqx8ObF4dvkyL?=
 =?us-ascii?Q?Ja/oDYsNydvPvtvlbnp/50eex9PRNExgosSGW+l1tBtNMiacwj0e9teMESn+?=
 =?us-ascii?Q?ov0GcRipyWGTGYdq9lzjxlpcd+/U3SYROqwd1Nb9acrAvEVc/m+5iJILwwcY?=
 =?us-ascii?Q?TWzh38SQuT1tUz2iY1wKjiD9/261LMc1rhDkmt+n4WjF6xG4X+ObxiVDM4AN?=
 =?us-ascii?Q?n2snhU1Wlg5Wlv1L42b3yYUqHUY53a9Lwin0OiYKHJ1iz9/NH5+/G3HFdv//?=
 =?us-ascii?Q?wjxLn7C68SPL3/HQcZ8IdHW3Bqt8dgw9N3YxfEmBpS/Sk4mQpkdOgBdwtlKQ?=
 =?us-ascii?Q?/BjzMfXr+b5KHU9qfTdKoqRQN33i4nWMYQdUwKbNqT1jHXzgF+d+G/n5N5c5?=
 =?us-ascii?Q?IsigRvkaIDLOG0zTsp4oohUkMgUYjqx5P1NIlUFx1g/KlVfurh1D/beUR+dO?=
 =?us-ascii?Q?6UktiHabxol3RKxIGh0d8XBDLkZ/YIbs+CQfb/+uLfEcRpkTl294OJnY7QZb?=
 =?us-ascii?Q?AKDSvpyqGaMI+78433EGzC8DZoRTQP+80H7E7WCxTWlQggrvxfz1dZvFjexQ?=
 =?us-ascii?Q?V9y3FdNTr6+r36zkLjSQny7X7hd3zxMlylyHjyqusM+q+tkZodkzrwzGfT2B?=
 =?us-ascii?Q?l0jVayNhvgWS1QdqO/uRyK3Fs9ofQ+dXHUOV7EpuHYLgxOYoBoKxjuiUYaz8?=
 =?us-ascii?Q?hqM///wRzRQ4PGTFLm+DnHNMNAlLKYQRIsHo+eBNNPF5vPZcH1vP1WEC24Hh?=
 =?us-ascii?Q?l6BU9a0dQ1bfcizDUNq2tNd5V/YK+ESp3lqVvTn9Gnu8EofPbW3qt6KjQUki?=
 =?us-ascii?Q?SmtV/j+23G5f8Y5L36t0ksv/97bROZOoAglrkCDd28Un9b3J8zYU7ERFz8CH?=
 =?us-ascii?Q?5IetcEIYuDRk3ozA9wJB7vJka2grripqPSBTByRNkTax5XfjoT8sRWHGIp/2?=
 =?us-ascii?Q?TOitBpx8P0tROys01vB0fUbumgxRlocKFCv3LOTxMuWhbXLVolG59VlqwC2x?=
 =?us-ascii?Q?AOvBvmRxwQvVJmgg7jD5KDA++1746nCKLnmoy0FekHgABO6LfuIQp1fpChY5?=
 =?us-ascii?Q?pivDlvsS7SxpHTxMfcuzZc3ORnp5vcsWsm5T0aZBgLHzTH0lo5kAaBggJwzt?=
 =?us-ascii?Q?geFgoJh8iD6eS0QSuj3HagRZsKG6BtVjQzL14sM5wfKl7tFUOqWjZURlgvxF?=
 =?us-ascii?Q?OK9+bWSf+KQIswW1F7NXnTW0lKb05Bze0iwIh/tqLXZNgHux5X7U54badKLI?=
 =?us-ascii?Q?7aauInLuO4zTw5c/BuEAwkv972STWnPUjGYBMH+nd96trX1fcc44C+e58HHt?=
 =?us-ascii?Q?br5eP7rEqUokSUtfMtUzOyAYdiwO8TlIh2C4O41OptXNhpbQjo8FKaYpaqF8?=
 =?us-ascii?Q?fWSbqT2tcpaAI/xsBFk4aLIC5wdvNXhMihWE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:35.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c78f0c-f7f8-43f9-2023-08dd916fab27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 include/cxl/cxl.h         |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e1953f566004..c9d21d95ed19 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3707,12 +3707,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
  * @ways: interleave ways required
+ * @no_dax: if true no DAX device should be created
  *
  * Returns a fully formed region in the commit state and attached to the
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways)
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3728,6 +3730,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3886,6 +3891,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 176b63cf3d1a..1301ed700163 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -405,6 +405,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 332cbaefa7af..c93b2f37a4fd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -283,7 +283,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


