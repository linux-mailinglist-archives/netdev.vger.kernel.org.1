Return-Path: <netdev+bounces-237238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00AC479C2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AF4F139F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04F3043C9;
	Mon, 10 Nov 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CAbQxvUM"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0B279DB7;
	Mon, 10 Nov 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789057; cv=fail; b=eVnpXtdJIDcsBvVTiU2HwsL/Bha+vCeMXUDnaK4iGNbwSS0j9SfsHKuxa7Tyi2zCsrMOJQ4sGmxMlGYVyJWNib5g5B6fTI0B7x3/H8vbi9Th0UrJRG4P+drSUH7Cdkg+kqmXEX2CUxmI44homC+82L6DTsXtZaX081TOveK4VLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789057; c=relaxed/simple;
	bh=wXMrzqDNvyxDyUh5tzDm0qpkYkiGQTfWc0ZFObHSa3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeK4R+nAne8p6da3bDXod6RLnCdWYLQ7L/W9ZCtpinoIFVjJ6Daz+DT3eG9/Ykuev75DTWdyCCFg1VObZ9MmQ6VDPy4yXcEmg/FOZufvblyge2eLxlX5VUKC/Po82MLHeOgvGIBMmvKnLD663NCYYGgiVqZp8/ivv0d902tWJ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CAbQxvUM; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvZ58JGpN59KvEPf7FsjV3eT3DmbILP0N9CI5x35H/KKwdFIz8DfXVdlKFOaEoGmrAu40yiJ72UG+KNe8r/JBO3lbgxfGLoGbi20gvpjMWhyRVLuVdiE785yxRKv9fRJntGnHVI2ogpRRK+Pn/qq2gnsuZDS3631FiWy9NKp99I0XRRWzC1LgCBxq35YpvapWJzPbZx0933XgtJyeu/V14vjG/VPIjw176TAPZPhsoftFopCz1xo44FziSwDfqybPpzhGaHBojysbM4UWH1DnjsjXLXbiHvXsanUVpK7bx+K8EObzJCuwPVGCVJnryENwaiqp3CzSCmhqApIV4yTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQgG11vv/HDUYXrod9C2CwtVkw8JqrHOlDkexOhsIGY=;
 b=NPv7mOpYsXjCc1BimbdKjM9yGX4Zok+iw1+GwzEBBk5HVNtE9NXYtOP0iiGitQSN9Sk3lIqhq/y/vXwZK2EPBZD2ZMQnaqxEFDCpQj5fWTYTKefltNg4+ng03wHaSzMpo/uxdGZxqJ5wGOs7DSs0srfrau6sAKmKnCqI9sp+JcCBVGoCRa/zoJ4ZjomM0gnVexiB19YsSipTaz+jWmZM0O4pQewbxAHw5yddO/Zb3ZoSrDnhoBvMwV3M/nlCOhEiWVtSn+RGWvXyJgoBEWj9xOUb4wdyU7Ox7FR7meIHdsln8XzJGPj1xN0YhcEqO1NVGSaiAx+Bh3W6kbfL18/U5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQgG11vv/HDUYXrod9C2CwtVkw8JqrHOlDkexOhsIGY=;
 b=CAbQxvUMqFmPoIJGIcpOty/tl7l30FRN/ga/hKYkwxLklbql70G1QvKwZYcPAPEoThcSKzLUazY4TIb4BBmgimrTeOwT8Boh/nUAScZiVgWYuXROWBME0qC3RK4woXF1zyvR2LigFazjYuBrgeJ/bqbkjh1WZnQRE7aaU0GBmM4=
Received: from MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::25)
 by DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:32 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::27) by MN0P222CA0019.outlook.office365.com
 (2603:10b6:208:531::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:29 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:29 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:28 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: [PATCH v20 15/22] cxl: Make region type based on endpoint type
Date: Mon, 10 Nov 2025 15:36:50 +0000
Message-ID: <20251110153657.2706192-16-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1850659f-09d8-49e2-942d-08de206f108d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiOXPIOOdH0ZT3UduEDAlSniPC7rkfn82NSx1em2Dvt8E3MdC/ObhdwBpjag?=
 =?us-ascii?Q?cOGH9HoGFQOcEVHTkyMUBepElqqZifLuRCOWpkUpvCyoePZCTTtPGtUjPIUY?=
 =?us-ascii?Q?CkzJBojwkSbJzvS/YhEDGZHI3GPPm9WamgT7XNyhkyuOsIYfuMOjrrINi61T?=
 =?us-ascii?Q?Yo7yJMFkZIwkdFkm/tFrktUaM7twhVVNywRePUVqpkTrNVQV0WqAEQdReL34?=
 =?us-ascii?Q?qcHx448iN+C0I9e/qAjrKzalurd3r4+4LKlBgK8kVXshYGpzSJUHIkmU6wZG?=
 =?us-ascii?Q?VodndnEum/PW5Ozd3Suy/AGOQ7z+Y2qRe8mkNpB8BoPl70HsCadXdRtup4BU?=
 =?us-ascii?Q?vMao6njicos4j9kR5pPfKWPGt5iYyikD2a+0UzFpR2DrDZ4XW2yOAuvcDgFr?=
 =?us-ascii?Q?XzHL/Rq0bcsqFUNftu16F/vVL7uTgH+yrQNsozFbvAIHxIpWu6i+Htm414gs?=
 =?us-ascii?Q?xphSTkpopmz9y20MYxxR4rfUA4BUCcsk7jHeedaz/QX+FqyRq3ILg5RAk04t?=
 =?us-ascii?Q?ilW5E7VtXTQRae+cZjdycw4uT0369vo6oYtJ2G5kl4ABlynCheMEe8H2F9hE?=
 =?us-ascii?Q?ih3yhwYjhuuMe04cYovV2T4gjKIAU/6stWJfZ9E0XVB3DVR926BQWwLvR7VY?=
 =?us-ascii?Q?CS8vzovKnrnWfYwlrIMF5BL8uWJQYN3+BrvwzsOtG5u5hI3bPIlfYwDTWPBX?=
 =?us-ascii?Q?3XbyjEPhRPxvxExa4TSxo7KRF6+17MYg1X6oNYOYSQmvc1NwEBAUOYBR2eop?=
 =?us-ascii?Q?Qmfcd8yc7+6+vEFwmPMcbiX0QRBaKjkOTnYo5ETVHQzFX1U0kKV4Ha6eJ0M8?=
 =?us-ascii?Q?NIoMelD4kIgxHyWxm60xt1eI5fHzuofdlPlM1l3nx2tizBzKyzJHibg5ceVL?=
 =?us-ascii?Q?zXmPuwdxFnuD8NLUJSOeI2kVzxvk5cWzRzmMXaqZiV9Rypp4oaTZz1ZQt3p+?=
 =?us-ascii?Q?WOFSMzhtfqCTxjvGBPazJ3uvZTBk8BehoVP+eIDtz6/WTqDOOLIkoNWVmYpl?=
 =?us-ascii?Q?sVdI/Cwa6/taeN6W0Z2dG3O13VwF21LnZ9ImeVsiVdrUBCrMr6ohSXiBIdwF?=
 =?us-ascii?Q?RUkhvgU4tE6eH3Gchc3tBfgMMzS9niJZPJtTUAA31bWSJ8c0A6RVOokPTx0K?=
 =?us-ascii?Q?N65SJbl5HhJQZT5/nUyzaFd/OLPnAPdNGrH8hg8AM9gMzkTY0Pi3lWefcRzG?=
 =?us-ascii?Q?RSMx48Njloou4bNoxOeIY8ChF+U5tsS7q0RsnG2DiGFKGBq451fYpwCo8kBV?=
 =?us-ascii?Q?JT2pKb+rjybI2jpvsHM98ElbPYMkqxF/5UBK6ueq1m4e80TlVBPGtoEhfeMh?=
 =?us-ascii?Q?XvbxDuHh+qWz0PnalQZWkPixH6JWzXetLCOMZXno/EY+asIEPTIQZQZjzTeJ?=
 =?us-ascii?Q?T4UkLgdonv6r57pwz6p1kGraY8CWgv0cujyAwR6OJC/+Gdp9GwaSboDKVke/?=
 =?us-ascii?Q?ru5w3n6G+9uCtfWF+FvrD0WYAuadS2F9PH7IxX6At+J7SH8HSzC5mfF6jMml?=
 =?us-ascii?Q?jZHXwy18s/htWdJyMp0caUxDhYvHIPSyvjKBIW5q5rst4F4wNHFX6op4bx8M?=
 =?us-ascii?Q?hVYEVAjDz0KJbAPBsZw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:32.3911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1850659f-09d8-49e2-942d-08de206f108d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type HDM-D[B] instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 99e47d261c9f..5dc309cf54ce 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2757,7 +2757,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2779,7 +2780,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2793,7 +2794,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3687,7 +3688,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


