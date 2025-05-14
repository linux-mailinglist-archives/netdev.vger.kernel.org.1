Return-Path: <netdev+bounces-190429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD5AB6CA9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871B57A986D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E01827E7FC;
	Wed, 14 May 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="baKKZ/9s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2527E1D0;
	Wed, 14 May 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229304; cv=fail; b=gsE/RZWmvMSATIGTyuYLP2XRLdiHh6oRB/LOxjl9Oa3pOQciNqwT4k8dn2vPsp5ovvk5bT72GMsMLYfVtQqsy5NJ01PFlVfqv2O0zRey0i+W4r2bz6sAfYMd7uosti3exeaPTNCzujYO+Ge3vyLJsjq1klIpNd75Gl1rgJzZyGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229304; c=relaxed/simple;
	bh=P9jnZNdY58MNz7HvwlYied8J9+w0md1rvCOmE+tdFN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0CEJiIEeateBPIbI/u4Oiwx8ibAKVUYa1T0ptqweRmPAXVPtukliiXrH8rzMOiEIK28do9yHzTLCnapIJz5AsjFBX+mDbZ7H5CjwFTK6T8oK250WCpsYm3RUGL/sJjDKzl0Pv0SQ9jectUqtKJ9doOAton7HltD6OPmwowk5YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=baKKZ/9s; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz3/xDzWnYVM15JIHZM3SEspyd0CYy+mVbfJva4zlcR3g52Tfm/l0oVCI6UhW/K9AgxLw/VxqKyLK7/oint1UxQ0ckjJ1uVaHCBDqeqIrJ6cK7dKFGoS2SFWZ6BMVyprM1UQWmGKDrYh4WWqNLCzQcxuojZmLvCtpTV5PJCf9+eY21FLC/6uh0gf2joIc3fmO90oZmSdCqJ7ivtyHIndCEunTPubqsoy22HAcPQGdEbQpvtCfbEuwOXRt/YtM8bj6O8ArxEsKEuRlrwBZdZ3XZqtEAWDDPr4f1KTFcBQxXVmH1jLOtvustTNHriL5cl8JFKXiYN3SDQb1KUIVE2Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm6pEfh9QPKpIcX1BcszK6c5XqEI6zwa88K9rMAA9Is=;
 b=wpOJ4g4HdL+aporaGHYzODPCsby5Frj9JDbA+PU1LJo1Fq6xea4JwcUtLdLbZ7vmd3gXKuFaGA4u1gnN1VF8Dr0h97zEm8PeSQnZQ/idtNA75vLW1EQggKJJdsd/lxGS3NrLqQC/sk4zlFVXhaNeJyx0aPTgpeoVcVIt8I9tkw0D75jvLEQMHF/qd3ITnqz2QVenTSJDq6EHWCVlsi1I2UaTmFXUemI05Z3C7NssK2bMmP3SvBDbiPm+2lsTmnqh4INxkMQxPdrQKd3UY/O9P/VZQzucaWjk+dCJ7ZDyyiS/2HB709RjGVEMauDKv5Ypdz/2Ye6+0mt7dnPQaDivJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm6pEfh9QPKpIcX1BcszK6c5XqEI6zwa88K9rMAA9Is=;
 b=baKKZ/9s+GawgOZxSnsltf2fSBV8I+aWdci6h1CZmYx+JpyPf6bmOzJzysM/6X6vJ+Lh3NbBDACC3bVXrru+lmU6sMheGBfoKMUo1GLiWFvKZF4w7xspJ730MoLTUuNQy143OAQpm40pUaOPyCAs6PcxwDb/rleUgCDgxV4cnSE=
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:19 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::f0) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Wed,
 14 May 2025 13:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:17 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:16 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v16 15/22] cxl: Make region type based on endpoint type
Date: Wed, 14 May 2025 14:27:36 +0100
Message-ID: <20250514132743.523469-16-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a44c62-0f83-4bba-9d34-08dd92eb3093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TS4o2RHdKmcOrdTC/bCzIxG2wn9x+/vW/898ivByHqYsGFOMLD+z22tLTQzk?=
 =?us-ascii?Q?gzCj+FOG3V9m/PJFOvgHFQrqFSfSQ0nY68yFSD9fD7XoTMS4zrqXOWO7KII/?=
 =?us-ascii?Q?QtAZTotipqc8Db4n6Y8oxcSO+JGpdFMJVHSZciLuihQ8rCmpReJCthWqsqMz?=
 =?us-ascii?Q?Nfgf6Il0orFTx+BiJ2tzRNKWaggk2giYdSPe8BWvS/5xacsXlE/lv+gC5OIW?=
 =?us-ascii?Q?m8738FlMWoNvL4DvAqhPKSm5k4tFe4mPuCTvdefnoYt3MgxwT5eJdNKvX7C7?=
 =?us-ascii?Q?A/CDlDxiNvpP2CwfhtwGmNYHPt9uS+5e6dRoW8WGaTCX92BZPfHTg/xABrkH?=
 =?us-ascii?Q?PV6pLZRNfUHBYj/qWr3izk8TNMXXLj+P3VnSvoAyZXzo4lly9yvGsk+KZFwY?=
 =?us-ascii?Q?0TmSUpcaxJw1MJIU7mMK7sz9RoDmJpJXkYGOlexYNsshXzrPQ+GBvt4O/G7z?=
 =?us-ascii?Q?mx0SsQWCp1PWbhzwhdOGgyig+W6W411lr7uck6WQn8L1nl+IaGVmNvMqbzei?=
 =?us-ascii?Q?x1+wJOHAbJMK8ruK24H/wHwAgtd9dPmg6tq9k557fpBmc2zHrRV+PLMtr/h5?=
 =?us-ascii?Q?d/Uz14hkUN06VQHrdrvBWH+tF0PSE4ESdC3s1NklWjcpQ1lpDIaxSnu6n9c1?=
 =?us-ascii?Q?eiZmePtAFWRsH1jn5C4WonxJ7loZH3THjlvWCzT42dUytgAJZoWirMHLPvy3?=
 =?us-ascii?Q?0+eEuAM9SR0ttjfPybYJK7OOvRZcv4EQJM2JB/otrowg6c35MqUIszyBS1/e?=
 =?us-ascii?Q?3C/58DgrTdYc1rKjSO5K0tiTX/Z5Dpfoe8D/mahiCXmEpEVaoxwU3GVJIXRu?=
 =?us-ascii?Q?9mK1yTjYz0OYWoZDXQK5jaE1zLF/uFNAtH11CIM3dfKMpc0duyFv1g1qmPXC?=
 =?us-ascii?Q?/NU2n/tmU8YsvFxR94GTTIINMUrJHOsuONdq7L0uvKbr2N62r2enwPY65Qpn?=
 =?us-ascii?Q?IgeWJu4xXKi4u+4JA+zUon33C1bK9YKfK38ObwHcZ8+GUvfSxXvlSYa6yH5T?=
 =?us-ascii?Q?cbN0ucOTXTYB1BVd+ZkCSSYGfRY7hDghDjQBdpAkYndYROglAicc7V3GCyy9?=
 =?us-ascii?Q?Vuzk1l0Ic3fvUbTh1H5A8Way4NrufYSiEdOzfXfzczM4tcciqw8DbxvI/eJS?=
 =?us-ascii?Q?UBpzAKtw8lC7qd3X78t2SRXJgoYMho8fbcafWxXmTaSvFJKhO8wsWNLT+fnu?=
 =?us-ascii?Q?4ZUiwzkmBMYsMCEIalBdWxJXPMRLFfFV0AM6IU3Zwb0X3PNTz1bkCN5ivgiz?=
 =?us-ascii?Q?yl8+XgaMxegaB2yu42+ROMoyJPODLH/Bm9qOGR21YQrz2refAjhEHxR6G+Nv?=
 =?us-ascii?Q?HJCkxxv+RFObHuv9QWLuew/CpSi79dnqeQhME9zbPkWCB0f63j2x8zyUfwML?=
 =?us-ascii?Q?iyDIa9aw0xk04dQacFN29QLpv7GYcrO3vBRNrzL3OOLg9xU5gyGXJhJ8aVyt?=
 =?us-ascii?Q?QlqiMrtCygWONS5HtW0vPL+yOa2Lxz0dFbnAAWJ5UQ7wzTL0bAb+swLnoUzI?=
 =?us-ascii?Q?gNsXTftFpsrQgS8ng2NisC3iqXwWqFgRpwNN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:18.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a44c62-0f83-4bba-9d34-08dd92eb3093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4affa1f22fd1..e13a812529ff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2714,7 +2714,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2736,7 +2737,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2750,7 +2751,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3522,7 +3523,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


