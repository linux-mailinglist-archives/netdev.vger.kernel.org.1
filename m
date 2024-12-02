Return-Path: <netdev+bounces-148180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383379E099D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F41516441D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D551DED5F;
	Mon,  2 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xILB72BY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747761DED47;
	Mon,  2 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159594; cv=fail; b=fB01ZCCTjKgTGDpqrTVZB9zdwWfjowy6SVrbWTFAtqLF7VcF46nxU+zevoxVgA61C5sPik5b8+37QsZSIeqbVK78F1UPghq41mAr026nhyALq3+32GaU0amKSwPWWdeBIlM7lTuIk+ncaH3uG2xDPp1X6ATCX6mk+ZnByukcJ28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159594; c=relaxed/simple;
	bh=pT4FA9o6M6v9TdaOQAlvN+bWckfgm8fBftVkUsaW3EA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIUR0ZIVi1PtwsGDTjxHUZMec6rCvqSJ5hn1NGh26NknIeh7d+zYfruJERW0sFeK4niZ/XOIQDGOaz3eRC9fofZ4aQZOIBg4olmINDQqxY2eXKLjSGKBqmbanzQggnftvT4HtVNMrwjSabSm+9llQ1WVRoMOYTWjnHFDajy/O7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xILB72BY; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBoLp1a+zrgMhdxYFsmIOaZszWdcrYR8GfYOuLwcZmrmiboKizvJPo3E2ccm3wi0xZbeOz+BOVLAoTMk9KWmOW4/hOhuf72xbI7q7xaWHnfKamjcBDxzo9tlE1950MHsSkE/adolrpfIg4Mbp8Q7NnaaAzDtht0/kiXZufVZBjuRVwJ2YV81uQduXtpIvaOW3yAok1waq8srbNzU3pAVTX6xHvX6qFgS+GVghkQVQNI/pskNE8QCsS2HSh9Z80C/WAeiq3p7wtQIvB6c/xhwA2AShkHm/p7EZnb6KFn0yQwj3T42Kg8kh0fh2urz47JcwD9qiaX5TrBOdqymGBGezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dNW5F7i7J3LlwRWpCwTa6835vLSlQepONbDGjZYXRE=;
 b=XT0gqZPeYLILh+6qnkUjLuYokdqtBSHLdUq+gZhUd79XGxHt9M88LDq+6avMAJjO5NPUkpba2fw2jMCfVYGm16EQRaXM7EODKRnJoznQxda9vCuQfH2Xy9sNsqXtFX19nfd1WHYISfHKhCeruREge0FkZUESyPThSE5BTdlPkgB3Y5fwBeqiiJNRVtEd815xcDzGOloSsex3aqT4e/cU2lwb10gH53XDPSJ7AlQc5/9MrYTapeF9QNI1bHZSDdO4Di1sHoO3IxW1RIgRFcYLLIfe2oO4UTLQvLdet7IDENI7+ysxf/8+2zyAHlo9CMg4MeDQNFqqkSJ/F9qY7eGQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dNW5F7i7J3LlwRWpCwTa6835vLSlQepONbDGjZYXRE=;
 b=xILB72BY0HPg5HJvBNTAOeHzqHPEmqQQasHuVpzO/Sf7Tdkq3/qRpeLvZNpy3ajrpZjbCqcThD9XEyLCgTzq4imvMJ3EnviwjE3BsbFNlBMIUL1mQ8IxTBFAts/gXbU0ylaPtz68effrXSvxR0T9v4L6opHH51j5LdZgITe9sfg=
Received: from CH0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:610:e7::20)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:13:08 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3e) by CH0PR03CA0225.outlook.office365.com
 (2603:10b6:610:e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:13:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:13:08 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:13:06 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 24/28] cxl: add region flag for precluding a device memory to be used for dax
Date: Mon, 2 Dec 2024 17:12:18 +0000
Message-ID: <20241202171222.62595-25-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d203248-16d0-47f9-c6da-08dd12f497f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgKWXzayyRYLvj2v99vpmNn2AiIdTqYOREuWYpdneDUAJzrH1dgih6HI/w/P?=
 =?us-ascii?Q?uMifJv0MSprytGYRJkVb7E79lY1O3psMFfiO/zwJOrdnZfCPwlDr7FHUIU9H?=
 =?us-ascii?Q?8yMECa10z0Uetg6uVB5toRTHhh7OHDE/e5KyIPrPSte5oy2sqMnCD4r/k41T?=
 =?us-ascii?Q?Mtqb70XgjQ9d6fAcxc2kNGDDWnqJ2fcDloumloLTIXVdngEmgboLBl3imOju?=
 =?us-ascii?Q?q3sGOpz7AqXWWuz7k1pe3mGbqmm7K5lDrJOrZZ2yEFyslzT7QiC6hYkxaq9v?=
 =?us-ascii?Q?gm+3JLKNJvgEPKxmq19+P08gEaQLHWP1UlDW5Sq+nnOqZYn4huRJC8iB4Sja?=
 =?us-ascii?Q?q18dLzBeFhBmi7MY/Gjr1wpeq9jGqU0DSbFZNySIsvNhe70I9gbWETZsL19y?=
 =?us-ascii?Q?f4ncZyOKfqTpx36xP56xHMQfcJJAXFx2qpcLcVZDumfr9kIYUDZxyjQJjOsV?=
 =?us-ascii?Q?p8T3oRSxcKy65yi+Lt0dVFkdWmSWf4WvB2K1Ep5ZXSccSQ0ADNehxfZ7PFik?=
 =?us-ascii?Q?a4PdqNXNMmRDXLGjMZgrOGiEiS5hzTTBWwynsHSlaa4JZa7KTsOVF4qrjO+4?=
 =?us-ascii?Q?YcVF5GBiurjiGaGWewJuOSDEZBmTf2fxUBHDH0WGXCTuOhnaycU8D7bwt6bL?=
 =?us-ascii?Q?0+afc/DKDo/Ybc9EjFd3apDhpkwuNdV6nCkvYimFSDWj+La4EMytE5E+/Sfl?=
 =?us-ascii?Q?ncE9kU2BkbXhz7hB8yDkUhnd3CxeaoMMhRKgSKh5Pd8fm1y03Sqb1fVKGERd?=
 =?us-ascii?Q?rEgLtfh0HkeGNlMs3ybu/CeJOYaPwDfvjr5Cv4ikvfD4by9w8R2cUWXQR9zf?=
 =?us-ascii?Q?epxQ71ggbk13Bse9HesfH7VFwwKm5HQGK1QNTbKHNARlLyDw4hEY7PXOaMDR?=
 =?us-ascii?Q?h06C5MFfD5UJQ2GDVurhQAtpkC8s5XLtA24gFFaEc69I5qnQPGqO4dmNLN0/?=
 =?us-ascii?Q?8Y7gNq578MEc5kS41l89c5axtSyffIo+qpcY9AZwYoNLLhJ8lZUmp2AblF2X?=
 =?us-ascii?Q?ko6TDulsQyQQ46LgxM3G16aacY+RJXr+XwD2ZSfJzwRhBYbkoF0LEA1pNo2d?=
 =?us-ascii?Q?L6B8dMtb8BwAu1nIck52PN1Rz11MGO3/yB9bOshtVLQpfyJJNdWwEldxFkze?=
 =?us-ascii?Q?DUyP01nGFUc1JTevUmhYMpajYBKotm1lPBYfepxf5D6vWF+zqYgW4aRADvtt?=
 =?us-ascii?Q?UKMSVjDt81MMNjXXgteyYF8aWBeTEGnT1BDMikkCcHdcHZMFF/CX9g649Ux2?=
 =?us-ascii?Q?kZEhG3yQ3D0HTic3hDEOkRp/d19KlwgELd97+HT4syqRYR2VUwniwTtVcPq+?=
 =?us-ascii?Q?/dyubl+L389dhqjh5dYU4j/9WYZKs272wJXeFTsukcleQJ4Bnymr3jm8N0qL?=
 =?us-ascii?Q?Odh8s2AGIlVyOCEF+UMQq1vnCa8EWXNq8mcGf30jp+pNauWMfveErUykqGKc?=
 =?us-ascii?Q?XPDM0Ap2VWzw4dDesOXJ47ibgMImuvZMMS++3dq/PhWNZ/eiprf6eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:13:08.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d203248-16d0-47f9-c6da-08dd12f497f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses. However, a dax interface could be just good enough in some cases.

Add a flag to a cxl region for specifically state to not create a dax
device. Allow a Type2 driver to set that flag at region creation time.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      |  3 ++-
 include/cxl/cxl.h         |  3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 79d5e3a47af3..5cb7991268ce 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3553,7 +3553,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
  * cxl_region driver.
  */
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled)
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax)
 {
 	struct cxl_region *cxlr;
 
@@ -3569,6 +3570,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 		drop_region(cxlr);
 		return ERR_PTR(-ENODEV);
 	}
+
+	if (no_dax)
+		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
+
 	return cxlr;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
@@ -3704,6 +3709,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
+		return 0;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 57d6dda3fb4a..cc9e3d859fa6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -521,6 +521,9 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_NEEDS_RESET 1
 
+/* Allow Type2 drivers to specify if a dax region should not be created. */
+#define CXL_REGION_F_NO_DAX 2
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9d874f1cb3bf..712f25f494e0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -875,5 +875,6 @@ struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax);
 #endif /* __CXL_MEM_H__ */
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e0ea5b801a2e..14be26358f9c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -61,7 +61,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
-				     struct cxl_endpoint_decoder *cxled);
+				     struct cxl_endpoint_decoder *cxled,
+				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


