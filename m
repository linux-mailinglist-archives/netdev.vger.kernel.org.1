Return-Path: <netdev+bounces-163060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCEEA294C1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E973A3B4065
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C51DDA18;
	Wed,  5 Feb 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvAUOZUw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7B1DD0E7;
	Wed,  5 Feb 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768839; cv=fail; b=gqHIev7AWzBV/PwubTeae5l5+z8WvmcEAlnVF49aVSDeIm6sSEL7WUvCIAydWCiC+lE8KAy55JGsNa90c6yZCiNIC3gdpMSQ52fQUzwaxaJrt85b57wLLtWhW/MecbjjZ4/CQUiItgGGlUhNvqDGVkrruxfUa1IdwTbH3dovyVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768839; c=relaxed/simple;
	bh=6tqUj0J96c1FkFV5bjJ/Q4QqobG499/LtlsLBGWA4hU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChBUf6DPZUdFm88+MXgCScqUOZT10zAJNzG3OzBtMkx1nuYjQI9g8eGRotrhLK7/U3cSqtW5vTO5T8rX3Zr+CVS6dDS8njg59Xwtg+m5Kl7wBb8uB8Ao/Lais7wFEjMcOxzwzrqdBLKyT3gzPqOHKJOWyzdTAUcQEnoESc3N6SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvAUOZUw; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uApKriV1Ax6bj5vGS0pOe8DnoB6IiHvmsc0HRw1FKEqpTLI3+D2GB5pLKNlrz0SVzPU3lpI+6kaeIw+NkoW56JTK2jauycWmxkRmktLBuBYNK+huiPHm1qrFL57WTosxwIM3z1tPs7ZpZec4aNtMlhXtF6+SKq0r29uAR34OSiazOme4YyQF/ooor4EREqa4tFPL/YnElCEJMJ7sxlvIXTFAcbysKnj5E+Tf0qaSo9PfebewfgfU7zXu0BxIah3JNLDU4t3rFfjPyba7sv5HpssQIwlhHJjrRUawpREneG6Ae8ORz8yyNIXCjQ9rhIA+JRLnEWA7fZqN3qOX1/vitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AsaupMszCf0I3+8LK7ajZefAAoWWuh92+PlrR+OBwo=;
 b=RFr4S1wt9uwNVQFffoJGO+YHeixgS7TxvzQ4r5VjY3xUug2dSAfa+UuaMFmetEWCiDwpNwQz1ZZfg3POMZtPS3NyHFEIHxXY05U43Mh9BtIjYDjoHqfVDl/QlshKFGJ+/ldsd6iU8ZC4utHLUtV9EX/X3i8aGdVVtxU/ehcR7nuAvvjxIhCjtEdn87gs02oEjZXIfdPfobVSifBzRM8jrBLrS4GNKKYDM9YShIdz3SMycsiHZJvjTEG8DB36Ka+8HiAIMcD/OB7SQHy8OHF1bUtDFXglNyc0qktj13QeaYJaettWAf3RN/KIUL6iiOYSknRwxOnPL1aIdaEek7nVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AsaupMszCf0I3+8LK7ajZefAAoWWuh92+PlrR+OBwo=;
 b=QvAUOZUwLUV4nc5weaiRoe3N8vmJCGPKzbCef/lIGdiZNhIbfOw1R0wwBRS/BNNya7S6VsqV0DpAGaP/5q/KaUT6gtqJSfKoXBY76++mCxPA+bfFjI667KcyD8oFAOxtjWauQznpJhmuiZoAvdDgfjjmNyIndoS4mQZZv81jXUY=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Wed, 5 Feb 2025 15:20:31 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::1f) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:28 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:27 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 22/26] cxl: add region flag for precluding a device memory to be used for dax
Date: Wed, 5 Feb 2025 15:19:46 +0000
Message-ID: <20250205151950.25268-23-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c600b46-eeba-4235-ddbb-08dd45f8a11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzqzFpRYv00HtBsYaMJV07+h3I9mG7vUnbFipD3kFOTHrx6iYtfV1/2d+IQS?=
 =?us-ascii?Q?n6795LY1q2ifzyqBBdT3jwsacKkRxfmbBDwjY37m6PcAYHzsq2/+ZcKX8r+i?=
 =?us-ascii?Q?rwgyqn46oXuElinU9F5KrMVl+Sx0vNAjkm8SwMxVGqo1YxXe3kL0XRvgZPQ8?=
 =?us-ascii?Q?Y5AHtNzUoKEfitmi8PBETWlYUAQGU69M1tvedX1+SN1p5GyeWjCkdr4bkCQm?=
 =?us-ascii?Q?XzC5HpTiIoxuhmAQyjSA1wFMmVy0JbaHMYq9gc+FYLnJj8oX40UcTRZy9T5y?=
 =?us-ascii?Q?Nv92LKIVlHG1nLylQAlWnPQjx1NrvB/vx9KvMp4EI9nTzBURMuNTfs5I6/6s?=
 =?us-ascii?Q?tqyppa4zqSmiKgorDN4OPGaqeA9EJ+jADPf61vs0DFVvmyYZ6AJTnksYjim7?=
 =?us-ascii?Q?bRFw8eaoKTgTlcGuhrqoJuYQxx68KwFzyuJEmwd5P7x5jXbamMmEstG8ohYy?=
 =?us-ascii?Q?a4piSSwkThsxypgpIoluDuE+fWEaHT+/7+pP5H69jfmeVt1MVsm2EKzZETyg?=
 =?us-ascii?Q?1NY0jm7Pv1t+xhM0injgEnzoLN0hXBwI6dxsKjck/0Hecfl+k1+vvMWm6bcu?=
 =?us-ascii?Q?MOGevXVIW8GwiCcVovMM0RZqPbZxdF9IARWBZwFMHXq/GYD3XiozuGVixtaF?=
 =?us-ascii?Q?YpB3PNwqzJ6D0gs2s1w3Kr9iK4IR7ZPXF7L1pczrhuZFDhuxmSWJQQzHnJhb?=
 =?us-ascii?Q?evPw/ewrvo7+1T6dqsJCl6tZyars0fEpSyVrV2VYsRpvtZ+RH7Ror6SHFcPa?=
 =?us-ascii?Q?oGB1Hc25lA2722WWpXdIo+EU+4yTznetwTTlqgmqDd6n+LgOHwCD/E1VTJWs?=
 =?us-ascii?Q?8OLB26+9MCp/0wEDf9E4UCOjRfgqoZV9lf8/0G3LwmunI2+B2uURt2dq+ixl?=
 =?us-ascii?Q?T38VOM+yNtNcSDiT/+AQ2glOrlbw4w8t5PNl3BcJfVH9ftet5nt239Yq9Mab?=
 =?us-ascii?Q?vZFZzaB+hwet1c5ARlxCDnbAFgeNWHgoGcqirxBkonRBhXSxXWv4UG/bQpnh?=
 =?us-ascii?Q?2QcuGGDx10GRLTK8/Ps8XVX97mLnxQTzoEwpLJ8V03QmVl6w4YUDClPcf+mw?=
 =?us-ascii?Q?8zutnD00mhjyPF0Ej3rxiSK10N9ypHtiCNgHN8xgKAQBzlC5JObtRiHRYp9c?=
 =?us-ascii?Q?k6EJfT9FAqeUTangjLslBqadmFnOaIZiIZEE8CzWZLJtGCbor5kmWgZSC89L?=
 =?us-ascii?Q?HrYs3OGo5CWXz6XTVxyhM8FyNngvzLjDFI5rZij6lsYs0PTkDGxJv/b7U1p/?=
 =?us-ascii?Q?9C6wOtC4CH0sltS0TnouVzeCuWdBPvqPkl59cQDh2z+wHjau3q/c55gC1nI4?=
 =?us-ascii?Q?2nTY5AKKcuLWbkQQdq97dDjif43FvvZa2qrdjn4n+dayWST/yG+Z0lQfvfL+?=
 =?us-ascii?Q?TQm1UyPMFT6P0wVcbfN/d+lUyohMKSjsbyJnptpdHDiTXDxFuGjiz3nSF1eB?=
 =?us-ascii?Q?VYvTRA8N28RczBfsPHunxAiJS9eDJoM9jiubUPcxb+WAssUeW/7wk/rh8cJH?=
 =?us-ascii?Q?YnjJuWntjKNLFo0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:31.2483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c600b46-eeba-4235-ddbb-08dd45f8a11a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 11 ++++++++++-
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      |  2 --
 include/cxl/cxl.h         |  3 ++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 55a4b230b5e9..742c03e983d5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3580,12 +3580,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_create_region - Establish a region given an endpoint decoder
  * @cxlrd: root decoder to allocate HPA
  * @cxled: endpoint decoder with reserved DPA capacity
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
 
@@ -3601,6 +3603,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		drop_region(cxlr);
 		return ERR_PTR(-ENODEV);
 	}
+
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3736,6 +3742,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e1a8e3d786af..4f7aaffa04b1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -494,6 +494,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2b260cf93d7e..760f7e16a6a4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -882,6 +882,4 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
-struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4f93af062815..6a0625476f24 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -95,7 +95,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled, int ways);
+				     struct cxl_endpoint_decoder *cxled, int ways,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


