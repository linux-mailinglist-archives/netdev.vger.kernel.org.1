Return-Path: <netdev+bounces-183921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF014A92CA4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09F1446F84
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E520DD4D;
	Thu, 17 Apr 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTqITsQJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6720DD48;
	Thu, 17 Apr 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925392; cv=fail; b=PMgtplrAq14Ssc08w9ggKgeaLWbYMY9OLEil3ocBudnWhkxcaezFMEGaX8hgkr4upC+8YDvJHLRDQ009ojM6E8DYQknlGQa7AEiZrjgm487IVkgRbP2QEfyS7CjmtfuiLRikFbRqiKd9EcRfbgT1ZyNnXiQWmid709YGNbIIOJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925392; c=relaxed/simple;
	bh=KGgIdiHwe3Omhn4dYIjHlFwpO5dcBgyWlOS3Cy2xoEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXATrjgVPl+ItgSN3z784HF25HiElOKZtDqyfOF597wobjmE2nTBt86TzIeSVZyOgznrLN3rowxcG/SS7mgg/I6Q9Cxsw4rLZ6jvRtu2AS5qFxzvaPzwy38DKCHZ+lyZyjEoQHqLQ+6ihsf60k9VO49Awdk+5xBUcCJ9guvuFz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTqITsQJ; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCU0up2/EcqyzPstVFmLJP80HPrbX6zm9Y3vlZ9xU5jP/SQ9P4n/qYWpFEneAaNeFkJZyj7mhLx/UdQ9b4UIUdmrDSbhosA7O0oqia8hFexskMIi0X4mWYsM8TJILg2tqkwYGAjvteT9oe8O10D5HGDFXjyRtEZVAbzkAKtGo1fi+ujUEB4uSCCRRNgcrjcVt/hQ4u/6BwDh039pNrlUIyFnFV0C1V4F5zIhosZYrZ8qQWKGA2kj0uJSPeA3r8aVrwTXrrIaTPWGA8OekqWFOPDLToVXRsIXZ+B2A85eetOnsln4wPcbsudW+NsX57IsYxzFfIXSjInwR3ssVGfYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grUqDB+C1rBMfBiGDSTlYgZABXNivce1seh7N2+g3xg=;
 b=epIZ0vUv5G/XKpJWBljbR3ZMPJMvLNlOKpze25C+sGjqYzjw81uUxOigaoh5hGF4lx1YUpb6Ts/+zsQu52234qvShBfLz3Tlr/o98DSBiziiDd/IcmV7qZPCE7nV1nJMH0zIGiknYj3ouC8UVNvIfhcgbAQogejcf03ukwuubi3EKD2g3vdJnHu6dxgWTYedAiqSlAmCMm7iSr22iZS4L58KhZ9WBqnqmjhmK2RjkDn3N4cG2xlxUQiKXX2VpPjUFMN2MUAZTKgDQMZNjsxxcnqU8pHJ4BIQG7KpDOLQvtHeloBsitEIpubkke+My1BSUWZuzk/Qi5b371XtQcqx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grUqDB+C1rBMfBiGDSTlYgZABXNivce1seh7N2+g3xg=;
 b=vTqITsQJsYyPwYVUPKRJzoAhZfGLVYjxi1BizOle8l0p6jvJg1vevVYgSSq4fZtLRig1kOcw9Q8ZCJt2thYtMGpg4PxBWYohk4eVqwtHlAVWX/mcX8GN395J9D/gr4iBU0EcsdzB9AIRrK3eozKGLP7LdghBkwYWyEaT0qaDlz8=
Received: from PH7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::30)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:29:47 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::44) by PH7P222CA0023.outlook.office365.com
 (2603:10b6:510:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 21:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:45 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 07/22] cxl: support dpa initialization without a mailbox
Date: Thu, 17 Apr 2025 22:29:10 +0100
Message-ID: <20250417212926.1343268-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: d12a937d-a9ff-4602-5559-08dd7df6f9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YCAMWDshIyywaDxjP5ddEs5jVkEsWliy/LlU+eLEVNEa+Eb6aQH+Ter1sxBG?=
 =?us-ascii?Q?RvCL/pdRmdm8MXpD/AHe+sGP2bO7tXrLinS4siFOfn/PMyHWoGhwqpN7pZYY?=
 =?us-ascii?Q?H6fzO1KdWW3LDqHhNacL5IT0sJg2HHKPNSRKfiKoizhrraGOTiSHen9AOzhI?=
 =?us-ascii?Q?BjXmbwH11SGCj6tAfHzqUFLDtEQI4rYddd0BgzYa649MwiPmvN9nZQi4cLlH?=
 =?us-ascii?Q?jPjjOoECHEZuyl4GeM9H8xgnKeS0DhBmHvAi2/oaCnYXqysPBQ9N+E4KHtiM?=
 =?us-ascii?Q?9AaKezSac2pxN0M+ZwZIEnjVZIJvZgMXfCRznXjkykqNdY11WblNeHrXXqfC?=
 =?us-ascii?Q?9VwRwTy/Y+skdXT/JNlX5OjUaH7OxfHAFJO2F2mPhX6McI9+KUNQBr0YwgU5?=
 =?us-ascii?Q?EWeX92YRhi+FajIkQt+4qrG/mniqH825Mn8RWZs+AK2CKMZMcqVZQJeVdWq6?=
 =?us-ascii?Q?H9ziCxRR3OFM/64CewKZZIM6ExJBCn1GjEeEPla1+ghL7TIHyO6iJsIr39aK?=
 =?us-ascii?Q?nS6Z/m3RW4sFSPftR6K1o1+fALSZBi7vfrVokv53wNZtlSRgp5dBRIwxHGPX?=
 =?us-ascii?Q?LIV3kzQNJtb96DTR5RnJuy8owqX2jAVoYqvRnLzbzvBm5rWlqiScbLtoubD9?=
 =?us-ascii?Q?DhuwGebv5OX0NhUKwegWqLYLcyu5UdUxiNZuZ+N66Woxewf0I2JAYyNfOJQg?=
 =?us-ascii?Q?b3HTx/PBnCwPBBD8SB0E7wylhpsfcrZKVyUAA6pQRrGulvh/2gA4x/jGCCFF?=
 =?us-ascii?Q?sL7GgTwEsLzsnhjn/eWY87lkeMfbf/A+tQ9PX+yWIS0nI3W8zO5Y0zBBF68B?=
 =?us-ascii?Q?5U2CAEkjrFQbzt2YZwQ71PhwH7GH5BcD+1GVrRCnyuEm328qGrTrTR6Tg0iC?=
 =?us-ascii?Q?0P/GjfPfvas5I432vLXOrSBiaDroCHXg3dDmes0KaPIIilZ9MKIBL+E7ZWlu?=
 =?us-ascii?Q?6XgBAcPxKjkdt7k0ormSEfil6FanIJbAL5Dv9s1UV/9Cb6fduyUMd7DA6J1R?=
 =?us-ascii?Q?/RC6oQmMBdXq/PZaLrQEsRtHjowKcfNk5zwjIMWMwmwRwkVQltfZjofVQYUs?=
 =?us-ascii?Q?said4fKVBc4oGHt00K7XDqQ/cy0sSs4wMssnHfIule9oCSDYlaOGJ+LLZWNU?=
 =?us-ascii?Q?sJAJKowZ4nt6tuyG52hkpNnB+cZvtFjcuRO4YYJu+X+DjW1WpzHRmcnRc/qV?=
 =?us-ascii?Q?Gwar1iE4gjdZRzqMnHddudb31TYwK5iM+aKap0oBApImydiXWTkHKoXsbCS1?=
 =?us-ascii?Q?uqKa0s0PZhcp28bmyU4eE2iZaNCT2IUdGVHpDGRuFLpvtluB/CHAUSUJOtYt?=
 =?us-ascii?Q?0WPDodmMo5GcWxqTPyO/5AjD4lRInOBo8IFe1Qy4Y1N/XUV5AHQpT+zpUZRa?=
 =?us-ascii?Q?rC4Ba3kXMsEzX/gcYJvCRX97DfXlFY2mshm1JoRyBDAcJNJ7LChHTbKymZtr?=
 =?us-ascii?Q?3/GGE/2AcWtgWQydPC4tH9K695CsAG+U7IyUKMXav4gVqT9RWn2htgi79ZXA?=
 =?us-ascii?Q?1oAeOrQG1VdJ+Q2X7T/LKcmLxjOsGuc5Q7Wd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:46.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12a937d-a9ff-4602-5559-08dd7df6f9da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

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
 drivers/cxl/core/mbox.c | 19 +++++++++++++------
 drivers/cxl/cxlmem.h    | 13 -------------
 include/cxl/cxl.h       | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab994d459f46..ef1868e63a0b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1284,6 +1284,15 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->nr_partitions++;
 }
 
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
@@ -1298,9 +1307,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+		cxl_mem_dpa_init(info, mds->volatile_only_bytes,
+				 mds->persistent_only_bytes);
 		return 0;
 	}
 
@@ -1310,9 +1318,8 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
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
index 2d8b58460311..66e5ca1dafe1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -214,6 +214,17 @@ struct cxl_dev_state {
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
@@ -234,4 +245,7 @@ int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 			     unsigned long *caps);
+void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
+		      u64 persistent_bytes);
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


