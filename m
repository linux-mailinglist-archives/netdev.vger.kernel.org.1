Return-Path: <netdev+bounces-126224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72E9700D8
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B65F1F22C15
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3E1537D8;
	Sat,  7 Sep 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PQKAa9Wx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DD1537AA;
	Sat,  7 Sep 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697198; cv=fail; b=NHhm6pgQ2AcxNHu0SyPJunphbjVJmpLUQ5tiUkZRAkbyZOXTrysFXrFMC6Sbz9gr08PoMfIwMjvtLRWAY5gEUP/i4lV+YAYFwO4AmmJ5uivoo9yeAd2YBOC7ED/b9FRFar1LVO+J4C/nXJ9mi/UDVZpSyAiZGenFQHGgwKA+qTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697198; c=relaxed/simple;
	bh=6quKWQASegmxYifwCqVi9q26VQrGazjhmmvJJqU0pbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYD3scg67MfnISXJupQ5GF4wASKSwYgHgrd/wKhhGE/rXrUi2hbSq3FddjvvPPLlhZ5WF/ZLiLG6RegM7uBioP74qQWSRjOotsaiAtV8BRx5Z1cMcFKg132Lotrf/E6w6amjH1RVmOAZ4cJDB0jKhbPKMSmE2kg3o4FwwAQI46Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PQKAa9Wx; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv9b0gx4VWnmVXmJL49WBXuXmp8tZ/9mw47JI98Rkp0BIDeIPQjpp9xiYwHOW2yhNG8+eAM/86rQMCBCK1MaFGYDUwAUhtO7F6OW8Vz8g9UnhBpJJtYSIQ2Gs4Z36L/pHOhRp6UPaQyCFIP6eVDjMMfle39xRpPvQaQwlcs5lS/UI6358WlsgKtZQLUhEWuYFpWOiHFcY35dow4A8fFFV3cZFhpSjyamccjtgJ9GnCblZWdIX0Y+DlfyGRLRgRnv7sbX+uhI1E7ki/NHzhc23gQdnT4C//Lb5nVQNByLTV7q6cL2VMcRyS3wu6FruoGlRd1sC8iGgISIp9xrcb4Vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDZ7fw+ejj7QKNyzXLiGk3BytzKw2U/A4tsYEgIA4og=;
 b=qzXo36M40QD4wnzwHEMWbTC/xqae/+AZD5jO3BTfjG168KvWYPiXbvGpxDSq/L3qIogGYYqPSHxIhJh1uYzk0gRje7HG2eTXhUEvCmkI0iLk+fqO1ZWtiG+j/amicMzwF/MH4w7JoeOTzmZz4keODP4bmuJlZvggXTDRokb8KsfYC5yi8um5Y7/Dmi4waTCln+ywWg/nfzofxwJ958O5ABtWtea/hkQkGrG5CMYPq+lH+xXjBbj74JF+DFNufwqe57zIONbiQKlHxdOjKWIIqXkL+bQmplTebedJQFZgXm1TRUQu9eVwxHtBTNsDM0yIcSJ13PpHsA/Ud16GlwGz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDZ7fw+ejj7QKNyzXLiGk3BytzKw2U/A4tsYEgIA4og=;
 b=PQKAa9WxvaFZLHM27WjKllHwJKdnRYQj1gThW5rW2UEtl6DlT11oO4N240b4efi1y5bdDEii0J9B3JopxPU1Z4bMMVANL0RvvO5Tatj+pgw736qE8/KrUx7qFrmuN14212HCCdFU41iIDxyuQKl4sR7qitSq7NvVwtvrwOrg2DI=
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Sat, 7 Sep
 2024 08:19:51 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::d1) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:49 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 16/20] cxl/region: factor out interleave granularity setup
Date: Sat, 7 Sep 2024 09:18:32 +0100
Message-ID: <20240907081836.5801-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3f14ad-99fb-4e97-835f-08dccf15d831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGkcU79EmPPnLaYvgRnVxDIzcy6nT+/JoK8QybAEfl3/QcI4GoaCmyC10O7d?=
 =?us-ascii?Q?HKlIzWouyyjnSCTFIvv3ZBvp989q/kLJArvGvZr2uPZDq+6OUs/mZOHFxv8k?=
 =?us-ascii?Q?QobEJt3wlQ6tTQ3vXEhNdJ9f56lSpSkl8ia0iRulc0f0XerWtGfImdBks7R/?=
 =?us-ascii?Q?gRQqaLx0zZ1w2BzvKgHa04GEva4ShwGZ4b0r1e3zmIJOT0686cD4Keuwca+T?=
 =?us-ascii?Q?ZN3qd1W+/++I9TVd3vAe1154oKpmNisP1sfod9E6bciSOgdFAr8oKp41RE0L?=
 =?us-ascii?Q?SrIuXABz977GNqAzIahMJ/f+XmBspT4Xa3HplVRDbrUpXmgR6zvsq6MNzizn?=
 =?us-ascii?Q?RVG47DUlE8MAMLMjlQeK9/FvsV1bOVm8oNONhcTg3c4dJYFSUuurCV244gqa?=
 =?us-ascii?Q?O7DfYb6dZj8uY8bAN/DA2hZat1v6fAjSVrFES2m0Oh0EDb857+w1NLnokQ38?=
 =?us-ascii?Q?PSieJ2PXNaC61uwzJYI/B8hRdPjhXocOWtCYzWzGjSER8dkwoRGFLSq0lYdt?=
 =?us-ascii?Q?g6kFJPkAfEE4q0OwBXWC8z1szNT3AQLWterZ4pUhH04SSdviXK007Jq7pRXh?=
 =?us-ascii?Q?e9VMi02pml/zZDX8btIYpFqQSoSsWh6FMelpO4DYev8VKk9DUSMBnen6QqWg?=
 =?us-ascii?Q?1CkjHTqfXx/ow6b2qyKegNiDY4rQ64oyedmYuZHBzElm8EEt+oCoa5IebRna?=
 =?us-ascii?Q?qBgjQnHJatpM+//0YObVpD28DQQKTVjUWW5lSM/2P9IJVEyK0J8/j2ufjoXF?=
 =?us-ascii?Q?vTNmOpgYdC/HihJ3zSCOev7xdPRTeuEr7vBoHpRJuadw5SHoZM8BO2tLT6Jn?=
 =?us-ascii?Q?LAMIHHcnNdY5p35AlcjRv6Cp9LIacE+YzWjEhAq4BGC2wQyarl8Sp6oORgQi?=
 =?us-ascii?Q?RjWeKSueeqIbdtSW3i6/pQqv4Ov9GaQT/FxVId+sBiavV0sley7kwcyk4akJ?=
 =?us-ascii?Q?FUnXwGJsK675vQE5ra9r/BsQSns3lzXZY/bBjvxsaZU0JxSYU8sxl4DxVRmy?=
 =?us-ascii?Q?cNJJv2vbvtLW84l5XwaHabhnBTEDhnr1otH/seiyYEDkOUFA/anipXH28o9d?=
 =?us-ascii?Q?xNy552ZYIX3IVQ/a4axZPqqmuDzd4/RKj4ICPPisqt//PAnbDGzjbJBuciWQ?=
 =?us-ascii?Q?MiPMamZeRgMVvRiHgl1xm4r1QwNp3j0zthtCAqxBJwT6ykpPh9ICJF6mUeqO?=
 =?us-ascii?Q?fEBkpg9WoDUCaOCU93y6mskYW63oLBPpRSVpzYdKyNXomBTGITB1G/ugsL8K?=
 =?us-ascii?Q?8ajnYkC0DRIYLHagqPxHkjuS8re8ITlN1WewW3cFUaF93TdEQwpSVSCAHKbl?=
 =?us-ascii?Q?HDCL+KPClr/aUBXxjsRxSXkigHB7pubk1LmFebwdtILXbBwuVKgUlhU8b6Q1?=
 =?us-ascii?Q?hg+OQ7+ZTEeBrMV92PvmzCxSzHOVbmVaO2XM8NBem914QTe6DLctniMAmIC7?=
 =?us-ascii?Q?vWYrsAJB5USMcvMMMkkLpMYC2yqB2Msx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:50.6279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3f14ad-99fb-4e97-835f-08dccf15d831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index edd710105302..c6fa9e7e4909 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -556,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -586,16 +579,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.17.1


