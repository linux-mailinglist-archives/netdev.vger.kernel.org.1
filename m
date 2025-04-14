Return-Path: <netdev+bounces-182302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B2A886F5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445EA19062CB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90927A110;
	Mon, 14 Apr 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XkRASeOk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365327A122;
	Mon, 14 Apr 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643664; cv=fail; b=HbzBCBzn+DY5ODsToDuxMckqC4WjOnyDil0bEwCWQOV+6ju7qSV11EmjexvQCgD+qRttNXntyjV0a+b7G5cPCks4t6EJlIT/OMEeEWwXgw1NivfK5hD7QwtnLl2hn2D8qN5B9idB4ACS6yiCOojEuBqEqqUwaQ6vijPrh41cLaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643664; c=relaxed/simple;
	bh=HXsQmCmxCYQkvZLm5ANTWPD0ox5uDVYeay97apcmNX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfePxvStWL3D7RQPA1SIki6j/YWKayAdu6i0eiZ35YqupXrsz6lZXsr7qc9TPYhqwCeithkz35v5hd9BJJMZ4eqO3XpJP4fD74gPalc3IWd9C1IdbgD98XDyriNw/V+SLcZ4RHo08ooPPTxXIaw9hO+UF5mGQmfnZrDLZB/uDmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XkRASeOk; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5upGsKQFUZAg/TxftwHIp24SejQqX+gnWeA4Qos9x3nYoqgF8l6/EvpwHpSDJdtAnrygsOJt+WqBB0U3uJx+jsLGEfxQ7t6GaJmChahMuIpLot3ekj7h5NX+Xqt+RlisFg743rnXsQOutNopQjquCFbMV8/McogAWqB2J339C44c+ylKkX4Pc8bkOYblvAsiIBHJ6fpm2DxEeXWMOes5tsjqJuWhplfgITLiIDJ4pPdLYf0Dk2cwVtzrdtzgswse4upJvAgOhzJ01XgrPoxYPjZG41/etZ4cTbmxP38ZD6535tVuvEO4cz1nm80rYrQTW7mqyqZ36gZkrzfHnkzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QEKb0LC9BOoMIUgzcXQ1O1y/crfNF+kGPmIzUgKGDk=;
 b=aM0hjONbLcaifQn2HZMUhqc87n+DBLUCNQ+JbGupU91eF9WHYpeG26UbDIYbMokzCCJ6WahR7+mkxOJ+Wpyyo3JfqqFugmYO1p42t2eg0q2PJGTWrfV6qk6tyIoh68WS/VpWIuI4MqvtfIAVzS7dwnLcguDreiTZ53pQjCfCxjqePArRQvwoxiV56mMdJFPbHLPEV8WfNh/IH+MFB2eWA+IXYKbSpQ2+nScCurNmdDbILvodE05mtIbh/DBt0h+paf9YBtm4oV47qBbW5QeXjW+mDtkpmGCse+LtcoiYJ3JoEqkWcelvm9dUOG+37bLz1MxQ31EvFi2JnXKIWkoeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QEKb0LC9BOoMIUgzcXQ1O1y/crfNF+kGPmIzUgKGDk=;
 b=XkRASeOkzrQVRAaaDw6AuxSj2outnWI4dqFVBGmMdGUO+i5RU4wAAefCxHwstYQUOMG0ZfeMdywCf0E6ele7ucrzgjzT/32on1HKFStaNgf/Zf1lsrn92E64XQ1gBpgGr4NI7aM2D2f82NkLVcBKEf75tHOWbJqW2s6n5Hx3ESs=
Received: from BN9PR03CA0635.namprd03.prod.outlook.com (2603:10b6:408:13b::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:19 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::35) by BN9PR03CA0635.outlook.office365.com
 (2603:10b6:408:13b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:18 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:17 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 21/22] cxl: add function for obtaining region range
Date: Mon, 14 Apr 2025 16:13:35 +0100
Message-ID: <20250414151336.3852990-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: e1826e6e-7824-48de-e0db-08dd7b67076c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BaHMJwqIsyoHO3fFjxivPv8FXUwCdf3wq1a41vIbYDPEa6+bncTPT9XQp24m?=
 =?us-ascii?Q?7QPHogdGQio6TT8kKM9IZGXTuIalVnHrjT8iJHKM9STijHZroCwMAthOwo1B?=
 =?us-ascii?Q?tfqYW6p1pMRCSPMv2AYue0hMCTcYvLx7/igZOeZjHGxafqzUC7hu698YDwfM?=
 =?us-ascii?Q?rNLKmXQLIJZY2X8kbRGest1P9shpssyCdzBtPIH/ccHRJ0lGf+bpUvsB+bPZ?=
 =?us-ascii?Q?THaaiHVVNIePp1455N5LnJosMwpIEJ7CDSPG/ml+ca6lV1y7OSxCr3Y1rfWb?=
 =?us-ascii?Q?lXYyyHRrsbPMil0V0NNJsYVIBTK6mtztS43bi/QhS6ZDZOLwGacXldNyDaE4?=
 =?us-ascii?Q?UU7Qicj+CsUorb5bNxzKjLKm2Y0PVq13Fwyq1lS0LWdbLqEC2kQhI10tuwJV?=
 =?us-ascii?Q?Cs3PqQ5KClPKSUC05CIavy6oP7ugZpEKux+jeZGYPnwg9RncjTOlqEWy7DLf?=
 =?us-ascii?Q?TNhjoz0nG/rEC6ly/ec9UKd+7Z6NehC/L07uEwhVyWG4SMWepG20K4CS4C6P?=
 =?us-ascii?Q?iCXZdMKqSEMKaYhvDt47GBgUK64SW/EHE6LuuJDd23r3MuQU6fBF4mujRiHh?=
 =?us-ascii?Q?Kbh3ayDugzIXUv+DLox2OfDuLhreEz4nvCF2AwN8am8CvWbFJZYAaWRakKhX?=
 =?us-ascii?Q?Oc6wXX7xld+oHJtRlUZT8fh4BRW2rsKrG+c1+l/XKq9EglEVOsqSODVTvQhD?=
 =?us-ascii?Q?WeQbS9Oaa3j8yeTmmZA7mdu7XDmFpjvwOhwPF3ilBJ6BTfpf8okjf7HYXyRA?=
 =?us-ascii?Q?fUsPGbVZSo7s4ZR9jNqTEAaKtZLh0Bav66g0XoeZ7lxNoHPIbrjMUmMh8a3w?=
 =?us-ascii?Q?Jr+kMqoLPs2ID4L8KSCXiAAkE8nHNFWz2V3KZf6Ps52+RInMZB0Xn4WOyMfM?=
 =?us-ascii?Q?PRtn4OBR2GCbFHObxnTlviAYS2U+gWYGAovtaaW5mwKaSD+/7qGBY3v+hoSG?=
 =?us-ascii?Q?2/q7PVssLEtsgmtsB+tciTnM59txY5SoQYlYGeKXkcKj45jOaIR0wzUGZe6i?=
 =?us-ascii?Q?FL35aki1JiX1bRfqfb4gTvu1VLmaSfAEL9qnJYHbLSunhia9/aUME5LADc2A?=
 =?us-ascii?Q?dPDemML/+mEVdtubIJoG++sBqxKRl/jwTxYxyzg9Po2KIEDVN/QnMjZVRqrW?=
 =?us-ascii?Q?TK46OF48xm7k16VARoiu1NQ7ePX1t8tRXPY5ycf0t49/HVTbUkxeiT/ZYVrW?=
 =?us-ascii?Q?jm/1P4gJU3e5RHptNA61oZa+JUeY4Tg1VmaIER1LjpB994Fi7PPcs2J6bTn9?=
 =?us-ascii?Q?N6j4SImpGsazxJyyFgrKl1ngMPtuk5/ulyj2uNqW4USk+4/5jg+nkXnlL1jI?=
 =?us-ascii?Q?tfQQCDlo2Bg7rP1gfdTEKOnYetyrs+Dx+Xuk11+HDGMNsH9D1QH2O+tnTF+4?=
 =?us-ascii?Q?tJ+fKzp0LH8BfGaRKUwm7Kz1v2NJFCu68AImry0To+dlWbc961e7zjorykb4?=
 =?us-ascii?Q?x++wVe2Z5audbPl0IVlqGnpb/VesrDMUlTGG7W3x1bQ0HVrArIjtrr/eexU4?=
 =?us-ascii?Q?00OHyCRIIe3fAQDImUvncvW8LkuiPKikjSsY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:19.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1826e6e-7824-48de-e0db-08dd7b67076c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cec168a26efb..253ec4e384a6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2717,6 +2717,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
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
index 0a5d97d5a6bb..0395846cde27 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -271,4 +271,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


