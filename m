Return-Path: <netdev+bounces-224337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D5B83C18
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2453A6645
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFE307493;
	Thu, 18 Sep 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VCPKQxmF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06416301498;
	Thu, 18 Sep 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187123; cv=fail; b=CtxoLvDN781+HoRXPIBpN16WwbOeXPxdWisYOqpJoNjJX3r9V6+fIuoNc7jZEbKkRZ7VeM4JGmnk1an2F78JOp94Xw0dBQ/ISw9ha6jvO9SvLDhNgrN/HusmIp51uZLNawjaXf2G9TrFWldHkb60MDJRq+YBNQf2hoEo8ofaxuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187123; c=relaxed/simple;
	bh=H9lkxonbWdcCpT4E30ZewtX9aKCDln1HdQWz/QTRH9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0cHfSteJcN6x4XgnIBC9ATLzf2Njy+f7xHnrtPeX7f+rrdIL5mJFCNzJ6mMikhnZwBpaptSig1h9NHFa6oSSCBkQRr13mY4g8wd9bEcjF69WEK3L++AsVpENPL3A4CpMQ8AizoVdS5zadBUQqaC2jSpInAlWtU4FyYJaNa4YjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VCPKQxmF; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkOZAM6PgT02MEPhIr3ionBxOxAIcge37qLcrqoW6U7MRSVJPsP3T63hwWreD6Zyk689NbGkkNoB6h6v7jnfluBVU4O5DXw02LkNBfFTSJfmug8GXW/8gjAdKJ+Pa5mhSinHxvEIKcZd4zlCSQyRNStsy+G/ttUfbmxKiaVAsS3+FDIs8YcJJ9e1j/DIGMiYJcrUI0EAix57dj19dHDoXvSmAo3ZIdo//RUBx8x5zUw+Duv0urT/nfSfGhjgBMYjyXGm30ZOEiG+fA+DmgdjQIs9efb6/CY5j5H4XUXEu4BRYETdtKWW4jvOSaticPVp5tJ8FEi4wuOujTde83NyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azdb6V6o6yAuxSNWjSA9u4uvsq5VByp0tPn/xQtzFKg=;
 b=h6ue4msXnRO5bGYUR+Nkgzp0sxToS3NaglRTnVnDglJAuEHM0eTSsC4BBuHBuoEb8ByXr3PwcAJxChnJ7+Aa7tmqfRIVJCbfC776Uokuiso0QYaWVuO1HPiS3/r/lFIsjp9KWkuIeC7qhfC66wQjRyvHXtghqox4YW+dmhHHCzY1j8Zca4k46qoZOkSapdr5iCHZO1L+kVH2MD5eehmKj9Z6gImxZmal3LF8qEjycUUJvHjv8czjKzoyx/v6x858iKgWz3aqk0gQNKjVsDh0R0XxnAO8ov1btIjvBZoy2O3ciD3kdIDk1woi3ysnd1DTrQzPMiCJFPUc0tOa8EXcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azdb6V6o6yAuxSNWjSA9u4uvsq5VByp0tPn/xQtzFKg=;
 b=VCPKQxmFoL5QWMrl8kxD0BE/XEhq4dAeY43F/PpORwS71YOb6TbelINbxBu0g1yGONmHP9lhyP4jZaY1MdsWk6xBJKusXjge0B0KDYKfR7Q8OOwbgdV9TD8YXCRyT+5HAlnp8Gbhwdsc7ZG+bdgKbFhbfZef/UOAitT3nLiTmLQ=
Received: from SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:31 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::84) by SN7P222CA0003.outlook.office365.com
 (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:23 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:23 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:22 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v18 14/20] cxl/region: Factor out interleave ways setup
Date: Thu, 18 Sep 2025 10:17:40 +0100
Message-ID: <20250918091746.2034285-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 8095a11e-6fca-4592-02e2-08ddf69455c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QDkPj8WGTtpc9C6kLipqZ7HrCoonMERZb+n5XUwyfVbo/ytF9K9MzXRrJDjp?=
 =?us-ascii?Q?yjhXO37ZnOOivqsl6oKP8KoC3usix9+VSIU3PEW99b/u8n98LBqW1QpDrjhl?=
 =?us-ascii?Q?8cRcM0jH3X1H5O+dcpAKn5WUU0QWAAhqnQRpcL/H7pTJa3Z+lM4XJVBCYG83?=
 =?us-ascii?Q?uiMkIjocQ1Zu32wvaqinre3ueTrv7X+8J8w647TIFvFhxGb8ONrNOnXX3bJI?=
 =?us-ascii?Q?QrDpp1AdrT0vf/+bsD5M9bo2biIxdYZsnONhc8CK0xBohpn6+IYuGSYfkCUh?=
 =?us-ascii?Q?5RdT6+IRtJp8H4we9RWd/mVppregPTlxYkgHGcpPQa7g2afpUNJkECe8MLEZ?=
 =?us-ascii?Q?nHlypmyDwXSV+DR4Dm6nqo3r+J6mloLz0gWv2vw57GIPeva6SZQpHgOu94ar?=
 =?us-ascii?Q?c4xtzTzzCaRH9jl+fF5TKjGBQS9ocQFiNeo8vLPIys/jQz4gn5kwvv0FroK8?=
 =?us-ascii?Q?5EPGlrDGbQ4+c7BDEle+VkGZ47Lr7g5pUl7y5cB3JHE7f3CnQIz40zG6b70A?=
 =?us-ascii?Q?k7FVpMBQYTjVV/u6AY8dm5Bbq2XLvY8C6qqK0U4JyGd2bG1XJKeFqwd7I4XV?=
 =?us-ascii?Q?4S+bebF7m+9puM4ZXCfoVS2P2e+Rmt+VB/UGeJi4C4RhmLzlc0Bzt59k5+Lp?=
 =?us-ascii?Q?qIz9e4UJ2XNnvFIaftu1cd9VdBomjBMdrph0tGSnnVvlppJXt9KicIIFTGa1?=
 =?us-ascii?Q?yTiIWLev1VlkMzAUl/NKDkc7c1/+suVgDVvyR07APr+7Ai482hrKJ+VVEpcK?=
 =?us-ascii?Q?RxREJbb5kefPJGocxtcJT7IYIoICbD2L551DuUqKGmj8uJG/C4EssXmnlEv2?=
 =?us-ascii?Q?Ao71g2rdGU8wFfGpaUzKUm1BgH25IR1kRbKpZIvVwX6iKVf/XCqSeOBss3Aw?=
 =?us-ascii?Q?Hlz+R35ZDIyL2nJLg75GnXB+474sWnAWyldBIoouBzF9yQAxRLz6tX6x9syL?=
 =?us-ascii?Q?6xcmumIXBjsJm791FX1sOoeIcJtKrxtnSEykACrkKqxZyQfke93nPl95UYnK?=
 =?us-ascii?Q?1QZXdbJMeUIR0yDcqkrNVWKzZAndJ9PJw3pjyX+73fsbFTVj7JLLxwH7oIeC?=
 =?us-ascii?Q?/VUqyq4AW9KwAzVO/8bjMsM/zR3fJqXN89V51PYPUxq++7XLCamRbTGJ43Rd?=
 =?us-ascii?Q?T6EknPFNoKdz9l179N/1ZiI2+PYg5wFa+XVWk9jZ/oup+mfvRuEnVjE3dD3U?=
 =?us-ascii?Q?5x/pDhfuAAprb7m498vpBgbBOGZDrYRLZ+tCRvNo2w9xvqx6Ml/auAN/mT0F?=
 =?us-ascii?Q?iR+fii2BjSIddVj20rItOvB0x20NlQMOlhayU1dH7VGuOdSV4YouvYJ9d3VJ?=
 =?us-ascii?Q?ZXqyhdy3WDhDjFfABKHn/lDcRpPtzcjPCZXCYIbDgm/Hd8f9pJewZEn44cFo?=
 =?us-ascii?Q?p32VLy+DNZncTm1P3A8DH2glBgALyPcJUnDpdSITp0x1fx+weh9JdmAvXmB5?=
 =?us-ascii?Q?3QL+V9y+2y8I9lPsB7KB99SsuT+No33fe2NKGWTAJWOOeIocrYBeki5DVGpo?=
 =?us-ascii?Q?y9y2ieil8ktRsPsJ1dPw5krRecl+8Upwx8IM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:31.0430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8095a11e-6fca-4592-02e2-08ddf69455c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c65ffd17a98..6ea74f53936a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -483,22 +483,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -513,9 +505,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -523,10 +513,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1


