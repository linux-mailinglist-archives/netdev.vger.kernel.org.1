Return-Path: <netdev+bounces-136682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB4A9A29D4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459441C2083E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122A1F8185;
	Thu, 17 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MntAbkrL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C21DF744;
	Thu, 17 Oct 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184032; cv=fail; b=gdW90slkxvbhllKzpyX18aAx7p/MmFlesMLOwyAUW/Ub+9+7YSE2o1YEYSQype2gwWeDKhDbqw5Ucu6asr+xKvVTifCUg5yJTpJukc75OLuQs3QPG5jgpbqMjbsZMoVlhvBIGpIH/xDa/flPP4YEgsKpL4BmbC//yIzVZrtDBEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184032; c=relaxed/simple;
	bh=eJ2d7z6xaopoHCaA2c4rgoGOZN/RaVXeAn64XMprCmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRBhCnvhkfo5o3R+/IAcUIJuMqua/VA/0A0Li36ngl61JUrZnBW0qb65LV7Th7AMEmyw3J9IqtB9AaoBkfLme7OVKjIcYtz3tYvkX2c5ZW83endvQBveNASw/Y7A8oPGy7CSHT7kCg+M8H9ICf1+ZEPBr3r6mY1RUCH0GQUeKY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MntAbkrL; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3wdIqRHMsYWywpIeGmjzn+Xi5/l6iJDM0TMkxVB4n1EU++ubNpHEU8m75YaSUWniwEKceZtb380s2CHA7zWsl38Tfl2FhsUziCrqrTUlOroh4s1aHI3G4H02/IpohqZqMToqgaGqwSLeYtnlwjLzAA0v2GoBxq+ySjDGwCFkyhDRkGAOKQvJKt+RyuYDWCZ0PtvaFpuDG3LAIk646IOGylOsgPVhIqOhUS10g9DQDc9/qxMWLO2qCg8PdZ3YfYCpbGkOi4lA/Y126u0KikqlJCfg7Q5Zp5m6ijA6EI9OJTFsu1af147rGkfCWy1aeuSPsLcJ2uEjh3FI7JO7VePkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w+qHnk01yle/9U0lXXfCFrmvkDkWu1kK4j4xiNcF10=;
 b=FDPcihGEf/CA8LeNd7YVscDspHUJU3Yyeac1eaFf/NskQZfczKRkw+0pD/FyTb3K7t+F6g0YNMQbXpwJlZTP3DXM4hc+DE3ncXuXapensvZzMOsUUiDDeL4UV6MTcpfG7HFJ49wrQCZvqGKIant4FGNzw8fjvPIh+eyi6/0MUJiEEuuSMb7z0xxS7FeLyytgWi2StOFGFc9Kx7GbDB/9XfGIsucqBlnOIOhY/2j5UBU99rLcs+66Gg4wE9ZfrOTb5++5MrnFqAeYw/Wqob7g00zeP6hM6y0MYPSSlVQ+mjgAbrOqTFgsg8stK0FlZBpj6Km8Ktq2894XdfD8zW/2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w+qHnk01yle/9U0lXXfCFrmvkDkWu1kK4j4xiNcF10=;
 b=MntAbkrLzwcwPbQ5UYOLSqrUF9Nn5MV/QZEXVaQPvffOwJ3v93uTp1G08Cf0uJrS4Nbw+AspJFtlgnSP2NxCjP9NKHjOKkVewgulbQGQ8pMGIVN79zIXnrD43gLgSBlIWp4VZi0FTozMkWcJpCM8uPLf4khx5u4BDrPO66L0QTI=
Received: from SN7PR04CA0106.namprd04.prod.outlook.com (2603:10b6:806:122::21)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:53:44 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::c5) by SN7PR04CA0106.outlook.office365.com
 (2603:10b6:806:122::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:42 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 21/26] cxl/region: factor out interleave granularity setup
Date: Thu, 17 Oct 2024 17:52:20 +0100
Message-ID: <20241017165225.21206-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e15d71f-ce8f-4709-792a-08dceecc42c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xL8PwQpome6MHBjQ3nEU+urO7vCZutRuZT4WMnV0OSTKQCfYBLtUiI44fts?=
 =?us-ascii?Q?zWTDT9lmpRKjx/OXo+09KioitQA5MXm4qdlqfbcqi2Jxj8egxpHWbxypZs9x?=
 =?us-ascii?Q?eW5tXei6bRtF2vHKL2Z0Xiy1nhyYugo4cDCC4gP8e791DCa0Xs7AX3iON+jf?=
 =?us-ascii?Q?tdKLrcJLMmrrxaswz6BuOTna1z5P30j/yLv/sUf6BFDdCTXziu9wJm9yIUAr?=
 =?us-ascii?Q?M93Uc87M8gPQ06RFNlCutthm7cCyZA5p9WTTx+dZTfEN22PYk4rfaC3oWXVY?=
 =?us-ascii?Q?fIlFDuqUr64KAQFLzLy2Yg2D4QPq6I28porz3MrWQ2V5JY5mE9z8mcPUkMSV?=
 =?us-ascii?Q?x0xIzlh9AGLPWl9zvkcROIQHgqA55KMeE4v7SqxgmkRIe19rpVfeZC+rBlnd?=
 =?us-ascii?Q?yMoPYnvnP2P/5QOawgUx+ciMSpxkefbJYZ3CSdV9xXoo2/zw5OoSuQYeK15e?=
 =?us-ascii?Q?jdVrg4kOkeLuymIwsjGYKnEUf4Q8cA/E+t11rg/YUwtQawDmhzPOlehdNuRa?=
 =?us-ascii?Q?/dO8+aTtrAduuu2O5ZsW7wIIyU61w+qo9kADiGtYFPHzs/gCH94vp55mAaiN?=
 =?us-ascii?Q?Iw5CoFxxbuk/7oEPyb4UxlYrLRkrZV8z4ztjDU89FQ4juxlDmQAlgf5SDGnL?=
 =?us-ascii?Q?/tgw0EwufTWecZY7F2ZHbxX/MRmnGg5ADATWQtWhlMlOvpvdF0Xl1ULSJpWo?=
 =?us-ascii?Q?ecRJ24nNeva9j2ax8fLLaGJQA5IbE2/hXamrC3/hPRmZ4/j/dLKLAV6xL0uE?=
 =?us-ascii?Q?y6EdQE0az6LJp6uXWsW+gmbO7NwyRAbMQe3Q2GW8G/BGchvKLAccK8x0OyFC?=
 =?us-ascii?Q?7FIxo7jCEAV1VC78ux4ck9F6sLAfouxiMGfega1rnckEG3wPy1dLB//4yv0C?=
 =?us-ascii?Q?aCwqlknd4KYRj7AWfn3lXSaKrQOxePWWr6UYyvP1UlOlV0fnrswLdymNRQys?=
 =?us-ascii?Q?BDq1h3cNs99FfVjJEBS0kmclo48J5kO+mfH5SP0/iOQPm7FaOWkpSEMMspNA?=
 =?us-ascii?Q?iXxx4rOoxP+jhO03kxtRYat5CKYVdGDKblrN8VVhx6yZiXIpGECVtzQOiDNx?=
 =?us-ascii?Q?VVqGbU+EVOkyXeELynC/G0GF7KGYdUYtiCetkqmLk9i9K2UWOYPgxlrT/Ssx?=
 =?us-ascii?Q?DI8onZiv8fO34fwxGwIq6wafahfk63wcBIcVlbbp/Ky73cPdWgv5s8YfY539?=
 =?us-ascii?Q?5pUVWvz6nXGHWpr0Ryw5RDpe+mzxZ8+/9rpHowNIt6B47tBhFpTwX1yAe1fQ?=
 =?us-ascii?Q?/Xa+hsL2WceotAc5i4kuGMMdLVYvbiYUfe+swcdrhVWrJ2a1dQpULRo51nkC?=
 =?us-ascii?Q?Xw2rU8WczqXsAcBbLpq8yKda3+RtIs8XPWuyEK7R6GW3mcHMj98kltlBROBG?=
 =?us-ascii?Q?9T8W8ILLek7OB6bUXvEFgfKEI0N8PGH8wwfUMI6k12GE1+WUSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:43.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e15d71f-ce8f-4709-792a-08dceecc42c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ad5818fbdeb6..d08a2a848ac9 100644
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


