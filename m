Return-Path: <netdev+bounces-182301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD28A886BC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC976165B21
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1574A27A128;
	Mon, 14 Apr 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZQEpqM08"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EB2749E6;
	Mon, 14 Apr 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643663; cv=fail; b=t0FM+yGsg8ubYJYXtRj56hZbraTsBxDU0QCvvvRKrkzxFYjxSLRAn1mRCpw2w1G0koIrk81MRob9wqnTEiJfGc6MLFt6odXuXYpdliK9Dc3oGSKRQ89wI4CO6DrxYKKmeBjcqf6b9Birza+7CKhjKFDDsJXRXzluaDxlaJ6jPzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643663; c=relaxed/simple;
	bh=9rDeqR067dz41PJxngqum9Hnv6b0zVrlBzXeTE78EEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb5kwntR76/AX0OIIggswIBTl6bkUQfYHEfrFcHzLdw2bVU0vQhHIKi4qfq8I8urCF8iFAafVbHV9Xy/4LudyZL39DDlZb0MsM4EpaWyGhfYQVSNkkUHwiqPigeWnRz4nXjWwDYfF8mCGX954DuiLlS8Vgxe8mPKCrc7UQ3a8+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZQEpqM08; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASAb+K5gi+PRZEfsV1/6JhuZxA6k+Dqky+T7avnDbPM1kADh+qLgf0QAILr6v4O2Ud5W97k0rXbQ2gR8JYkXuN8Kd8w7QFDjCboxNDAqKnE5lyFZxHnQzhNLFF/Wbg0i1BXqtwqWW2vjuLEmK/TKcHiz2k5VPuaYFc8ooNAvQd7a5EtgeBqys99VEqZE+ZhkniJi27FiBsxbgNcjOy/b4o6yWlLF2Oo83AF50Eu4cEB+mz/m2+8UtYNSdlDH6CdPvdzK+B5GOfGewBIUmAwu/xgUAPThOujXTsQaImbIurkEg/nLl1l2n0ZGDi3QTv1G/hqNrvxvMEdjTBRaEHSOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZXgz37QdIbryzPDdp/UEZPe0p+hLDtEll/ZGO+2/+0=;
 b=dw9b1AeYT2EXhm29x6ufL3HvIfEfPqv2t1KUaO0+4+YmPYYv7+Lem5M8gZwQQjv/JFdMG6VekKe3P01J2cFDBFWsvSxe1Z7PPA3iy7nCmvskkj93VkOHCRIQ5C4eBAey9IGGsUearMuBOEjvRBkNY2Zrrs+R6v7QIsxaSisHpkFGUAl5l2TBKTvAWR3QvclS1Qkmbnb1Mqy3XhHJK89tzpbXWKGU1T53GXu3NrjDq41IiQQCyxALw1nidVvd9Q7y4JSnThPEu9S3YDw9w0WcYDb4Gn1GeqvuHsqx+wjsIo3cc5e5uRzi8UVi1blkifa9loql+ljM537oUSH/8IlH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZXgz37QdIbryzPDdp/UEZPe0p+hLDtEll/ZGO+2/+0=;
 b=ZQEpqM08WcfctMayLxa6mIkRRb2GOZ6ETSmYqXJZi2uwtFiok2kb0IfaKawtRUrAitcjvldvBqlmaOBYJcUvjYtbe80F7k31TmSYRUj3YJ3yodgSIzuKydRnxZ284t8VhGFtb2DC5D+k//RUPJS4Fpd7+zfRF9zGIvDrC7k76d8=
Received: from PH1PEPF000132F8.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::29)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:18 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132F8.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 15:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:15 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 19/22] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 14 Apr 2025 16:13:33 +0100
Message-ID: <20250414151336.3852990-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a0564c-37e0-4097-e275-08dd7b670671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2pqJJBPC5vJDS+DEZXkTTybwa3CZDSG+6/6qThd0IbId8jh7YtQr8sqFDCv?=
 =?us-ascii?Q?VhYmV4pW/7KBNOo2fQ85HKQt5iPODWmU2+BbaSIQkdgBQXuvLQ0Q31dlu1pz?=
 =?us-ascii?Q?IobJp+8woGyVqEZalWvDq/7wPCF63/rl/IfLhvApJGvbArKLcgVai5fHVz6U?=
 =?us-ascii?Q?fLEbPp81+qEWamdZ+/DCfIGkOhwgl0EL6biXu19hwAWKwoR2WT5JsgySNAni?=
 =?us-ascii?Q?J7+K7ZCZJSyfIfbUKAOfmpcROMz5v92tKQZKiNLAiZElfBZj2md1PCuQS8HX?=
 =?us-ascii?Q?w/r9ixdH3jElETjIKgkAIcssjOQin3kDiveZNYAQ0AaiJTIKapOL8ZJAJWOt?=
 =?us-ascii?Q?yDUOTP35H6JooxFfkRHaCHkSsmmSQILJQnaZEqR7WPXB7oZ4KyomjdrJt/ug?=
 =?us-ascii?Q?vOrzPVf+EWwgh3HUQxJyi6tisPxT0OFmDVf6QXBXSyT4nt4dTkFmsW9uR67K?=
 =?us-ascii?Q?xKjDH34yIAQIV/7NzdmtQJFOZWpSZMTZaPdlcQWWiQ6Lv1gMIJNqXa/z2vME?=
 =?us-ascii?Q?XxFl1ivu+SzG0N1FWEMKCTRjJUdJRdHWO/r2eubkTLBlKA1NEL7n++P2KrOP?=
 =?us-ascii?Q?i+8VtMGTGsZDNaF9i4hLjMQFCLfVhIovKYpWBa4XEXBPqI0dtU4AoO6QbIU6?=
 =?us-ascii?Q?f4iw8kBY2rbwyVcI9vV3Iu0X3kWRL1411j9HOkWFl73aoQHg6yUpJ7S/r099?=
 =?us-ascii?Q?//E+g8HVlj1XPyPgzuuFu8rbaYiKpB51df1ZFOSS5Tt7Kv3dkjRhj8sq1zMt?=
 =?us-ascii?Q?5Q4xqQF/LuzCNmGDrTPzvmeuFpVva9xBMVDD8zNctWf4nC1DcJxWup9Y0vzS?=
 =?us-ascii?Q?AU4G+7BL8gwqUoLZRGiWypBdYNBC8TvJPwYQEClUXa99bVYQHW27lkOdxcXm?=
 =?us-ascii?Q?MbfWs7Um4H8DN8kY/nkhqnPIN7Rp7sGmb6FiRpTIjRHtU4tOXSwuzOHFtpSF?=
 =?us-ascii?Q?c0z+IW+wSqfRWkaLjnZmSZIYsZEuyyW6Urp0CMUmzU1SzxSzedMRkr78N/Ip?=
 =?us-ascii?Q?RkqONT5Pq8qiHHiZEqzF5eePVHAQXcpm77GF8IdGNrlzJHlsgDv3HPPUERmT?=
 =?us-ascii?Q?2x6brof019a3Dc786PHt3IFgfvPOQktRg2k4EHeqVCHkXmH3NlcQvZXen8gp?=
 =?us-ascii?Q?Tq8EaKMx1SW2bF/0ib6REJfWgbjsHj3nfa8xpVXoQX9B1KjnBv5WVHr+LtZ8?=
 =?us-ascii?Q?l4o/QwYZAArTYfiQrW1aMqOg8HSzO2GVmsTWAK0FnnWyUBWazmRkumbhmCxD?=
 =?us-ascii?Q?soNhQGLryC4iqjjlWDlDarpAs+EaH4HtPYbCwZK9vKgAtH4FC5szL/X0zOUz?=
 =?us-ascii?Q?Zotsd0s/UsE4fbOOCloRPIoLgdNijcsCT1PenWjn0y1sKrmD2b+HGcO8HIAm?=
 =?us-ascii?Q?Yv00/8eN+fRkh+jqeGuwLLGvNA2IQg/5CN5Lwdf6sv6klhRy50X/M5zHHJKN?=
 =?us-ascii?Q?/x/ghP1Ss2jWsMgsR6t/rkF2HAeoNpMsj68Xqe6t8lx7bzgSaxSJPkzbzKIj?=
 =?us-ascii?Q?CVzMV7ww4y/6W+2JYo3hPuE1AZTJqcFKxbfs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:17.4890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a0564c-37e0-4097-e275-08dd7b670671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981

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
index f55fb253ecde..cec168a26efb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3649,12 +3649,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -3670,6 +3672,9 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
@@ -3833,6 +3838,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c35620c24c8f..2eb927c9229c 100644
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
index 21cb39dcee9e..0a5d97d5a6bb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -267,7 +267,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
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


