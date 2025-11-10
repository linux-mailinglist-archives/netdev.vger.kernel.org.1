Return-Path: <netdev+bounces-237247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8994C47A16
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC8954F5E60
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6888426ED3D;
	Mon, 10 Nov 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPzxg13k"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E431B127;
	Mon, 10 Nov 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789072; cv=fail; b=UHI8fZkwiN33p/PZWSBzEJrfnDNI8XsVQBdXDadkjr/906XDep7kHuyvNrQIUeXPSJiYRAoVwfPvqSIJY037I2PdTtBDbn+yeUaHAfh1HOIEXmSPnT+DV77S6+dRgxurulK9zSjG7Ao9NyonHhOKUHztw79qZR0nI2JQcGUZGyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789072; c=relaxed/simple;
	bh=IzsqAtW3ZkqASU09eUNn5hoC+kH3vb6zPM5pW3A/HX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDyKhbW1Vtgl2svBSYsDhhkkQRP34j+nqNsoid1FM0IPrLQbYwQuhF5HSido9kqVGIVLsZZlMCiESpDy549wLy2UmHEJDCOf3wdcDwgaTCHonISVPCsRPj4CWVmedS+h4EMNrCZAksaYidFRAtVOf4vX35FfLUdAaeYVV7J6spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPzxg13k; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE5Wfy2Ov0Lmv9rOZuzekDDRcIepcxWrs1o56oMqjy0rYkCuwf7Bo/E6C0fy3+8/4iztmPLnPWumX78vq8fOOpXIK+QAzmKA4PTMfdGHc3sbvScaTyZZmMTvfyNBf1mK9sodw3A+djanOZqyicTLBZ+tags5TNVQeDVuatALqesyRGgxV9nv+TwN8gAmGPSYjqTqgwy2QjpJSVpW26lIEUiHFBPdfFqRE/FFPciin+e5+yFyV5B/OaXmnxHkHTf7gRC9UKWmY0o7a++Sb/aUkRfFuuX0gU+oQHvVydHOqfXNs/f0ZRqBdo9dFO8NPvPALhWEZPch3bmg9uzAflJOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhMHEcJsR02Y9DD0pwkWUDSVjSCPLq+wCNrJTWXvQms=;
 b=o6GKGaBk7C2a0r6/RzOb3D7X8VVXzzgynVhuN5I+B8LNcmBURlueq7gNJHQX6iXLUPyBHasEyfW2h+wS1x8dhlKtFHjzwqOvy3dbzk+EwJ1wK1gDuC/xUnUe5quwpOS8Uhhc4IxnSFtK1eTaAIyiG/j9dFBFxhalN+hTF1iiHdAjJuZkCR6CeXoTSn6FXy9FQN//Wlfid7e9yMhwi4JpNJVVEKFzx4Uwx9tP7mVRZHgLsDsI5K7LRTnrxpB1ERhq7sfQS5QsXLuPd3X0HV+KqSjk0JlM56mK1/gxrUyasA119Yj4gx5WL6aeL6Zr7U1TcnYXjFMTq8qRGXwlUlS7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhMHEcJsR02Y9DD0pwkWUDSVjSCPLq+wCNrJTWXvQms=;
 b=UPzxg13kQwy9pTu8u30lpH5htDgsm7edZycgsZEK5D2yi+Jvw6emmqDyfTkOJ28jGlcqCDDmdp3okiQBFAr5N+C1qWrAT74+iD5tB++rnN3Gv3Lm431OCYbkSmd11f61JsaWg3yR0jSa0wKKHBzAAN2z82hZKwpFkvMSiG6SKBQ=
Received: from PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::18)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:46 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::cb) by PH8P220CA0014.outlook.office365.com
 (2603:10b6:510:345::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:39 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:39 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:37 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v20 21/22] cxl: Add function for obtaining region range
Date: Mon, 10 Nov 2025 15:36:56 +0000
Message-ID: <20251110153657.2706192-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c8f57b-cab7-405f-ca51-08de206f18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+lY/xwnD0ZSPeOVJY/PKi9AMgFcFwyj78oTIC6TAScJxXQBAlJzg/E0nKQ7?=
 =?us-ascii?Q?E5vfheUNksnO+fvfD2xVM0iqXhMjr7qktfZnG9b536Z2KFcO6CAq7MoGXY6q?=
 =?us-ascii?Q?+ch6MzvvuEoMAaLJ9l6fxaR+sX5mbO2L8ygmiX/4l5nT5p1Vw2cSG5bnJ3E6?=
 =?us-ascii?Q?C3kPioDsLviGM8b/IF1alIE4lWngMrH2UVQzUH1Ef7XY41CFanzSn1FuNLxr?=
 =?us-ascii?Q?x/35hhOUI0AFHmtn2g0I0hMFnQF34fZhuFTxZcqQIXwhF5oj2KPJmNkVAYrM?=
 =?us-ascii?Q?8xHWW2ew+SLj5llAlLjhhXe5MHtWHjaWyUvwuJSx56KK64ZgDlfM7A3qMoNH?=
 =?us-ascii?Q?JYo6Y0oGN9pFsC+XVVzagoKw4elZho6g72f3tJkZmdbI+FXu+t3bXqk+YK1I?=
 =?us-ascii?Q?nqmWo6cTF3rihkVerxznPqo/w6k1Uhis6JfIN5wROiCLq0+x5jv5NQdiH3x2?=
 =?us-ascii?Q?ckH+C66ACJW4tWM0TSc6IOGDlyFLGc7NVetvdPri3872HDxlGjJwpyKLS3rs?=
 =?us-ascii?Q?yDrFb1AaWmgiqL+uCafLY7TZuAs7AjkwHdSbtz55+MQQ/2AdC8/LdGphetXB?=
 =?us-ascii?Q?ofK6YDcmw5601jeEOzDBeVPRbFh56pNN0AI0Wue2gc4aBgTY6YF18LmyuYZ4?=
 =?us-ascii?Q?yttONbj/dQUJKfStQcVZjq0kSilvJoxxjQUMif5TaM+KoKzX4wqFMlbKwKCh?=
 =?us-ascii?Q?aOOK0D2U9rAISwXL1GFBnG/2BpIl5iOvK7y9eHm5FB2hw/groi8jho8cbUaD?=
 =?us-ascii?Q?EzpU7tFI2srvr7GaTXrcG/tTpeEWMgvY+oJ6xg3S2ndtT8lfNaoRvokgO+dw?=
 =?us-ascii?Q?s8v0a4h0GlZJVsqc/qHuGwB+upQjx2GTdS+fPeU3MOzjd4P7LLjG7isYdZKT?=
 =?us-ascii?Q?o7RW8ew2p7y5QLA3PZ7Cb/t+sPVEHavKBRJg7B9VudVT1beSKWJQvY6YhW0q?=
 =?us-ascii?Q?19scHPPY44UfZamsxntnqlZK69qRX7vUn7BBalLXdiRVhWnYGtO5Tw73BuK9?=
 =?us-ascii?Q?l151+Xu/4T0SoQACs0GifliGDGYV0GMdkUfhvRAWvVNHIOdt83L0uKUW3I8M?=
 =?us-ascii?Q?jYzI7xGz4EENeqi44ug6fEFgc9m6D5jiSxkELkqdy/IJhROoKsnws1zX8UOA?=
 =?us-ascii?Q?Yz206nmCU2ySxz6zwjiLeMlval16muVISoO+O8LsVZseb3BBIadf1m48vav+?=
 =?us-ascii?Q?ZKjbpWnAitNQ9Is5USVnjNopoIl9yiOsKtXb/Qr7yPMFQ+EDz0sKSJHBMt2Y?=
 =?us-ascii?Q?Sn31Di7jV8Uwt4XE1HygWRvO7AMLs4D0vnEoycJnZ3NAsdMG3X5KjsKkQFy4?=
 =?us-ascii?Q?XzhNLbt3sWbnq1SBO5MJ7DDh8mY1iRQXMvnLw+V4RoYifPjgG2qLPpv8lNvj?=
 =?us-ascii?Q?jKrk8ux2dspyews7tDweJlPKv7ZD1oBUJZhNuDi+ZAoVq6rFYRr8g/1sttPh?=
 =?us-ascii?Q?nK3jEizIMqNrNl2kqF42MTdjKDPspfyNaT3GF8T/0sZxMScIJWOLuZdvYq+T?=
 =?us-ascii?Q?uBnjJkFBAuMK4YRHc4yNx874i9uB6GxfatBDgur0qeFi2RNw7+DVP2sIML8v?=
 =?us-ascii?Q?Zn1xNfOxri1vmezD0xk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:46.2982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c8f57b-cab7-405f-ca51-08de206f18da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5ee40cb9d050..e89a98780e76 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2762,6 +2762,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c6fd8fbd36c4..e5d1e5a20e06 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -286,4 +286,6 @@ enum cxl_detach_mode {
 int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


