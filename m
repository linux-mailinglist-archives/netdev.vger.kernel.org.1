Return-Path: <netdev+bounces-150353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6619E9E9D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363181679AF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20C1A0BC0;
	Mon,  9 Dec 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tePQzsE4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5D1A0BCF;
	Mon,  9 Dec 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770516; cv=fail; b=TmbIlZcGn6J1uTUy6HwstM2YvOXhmx0aO3c4yJHlSUR115mJ8LEi6B741NPrmkUoujoK9hQdWVCyAW/ul6Kj3tlhpG8WGKWCdW9jWcPNg3E4ZTqsb0vQCFMqZAdGOghM5M3ZbGlU7+nNKoXIVH2QeMEr2gZ2UUfpGlCw7yz4DQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770516; c=relaxed/simple;
	bh=ss+e+hxwzSCWsro1bfX1x2Bpqzg8CEk9+IppOD4TEwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iuqg5vWsmtRwqjHIuAVW9qFHk/bacZbuCJHY2Mn/NDvsXrDODImerNYSgW9OHBGKuwKRt5r4Zm9L+fAJSQ7cfLt+f+gxkyitiXQd3XDktrdD8GNyyuedyhVT/S9B4vDn05TN9qOdbBIJq6eUJdrnzroCC2h7WzLn1CGCJtEVubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tePQzsE4; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICJBZRyeL7XlDfpeHhUh3e0aMfW0CWIc/CIapNLQ6B4jwq+36wbvQPE4561+yWXj95ALrCngv5qCxPkVrqrlAJ71CbY/rKbveOXLri57evVusndcoe+LL5wTju3erRy4jCJPfyp/hKf3Wz1CcR53PGSFsZOvAPaFB39uobzsYikwpgg+ivu/zhRFVBmMoKaJg6RiT/XFpXi3vpdCarXsl/SxJRC5OVvWYLkD39t4s1N7MAnlqb/0/ozJh83jQuUBGc/MWHeUdI4JybE9xQTNrm8kGtB86Ul0YRZrfczUpC2oNhCqHA28FXSuFRw94fxfeU2WhMPMGx/4FO6BqKmA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmrUsw0b7vF+l7FZKRbcWazMoDXDpo8fqElXKUtgjVY=;
 b=r9e+T7GqOTm1x3C52VEsGIgGF6TshwXKMApgxnXbxcJHuQ7JC4f+2GeQM6lwO35uHqSmTpUotvzcA1Vg2WMkq99S7Vbtl+zljuuaU1WR4dBGDiB2WQ2WHHG6PN78awustMZmqybmeyEgS5InagWABy9Omc3pciHIsddQvg4h6neh6bULpfkERC9nF/Gls8/5JiCnXkFmsRWF0XWVru4xDAEcPQV5DxDxkgicU6mene3C8JeEgOVxqSraPX1EUOz1NwzflzLKiHYi+hpKIMAQfyO+J+zrbxWY0FwPHwfrGL1J8eeLS6PAZxpUUzjBLz+NZVVrYdvfs9gpuCXwEzM0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmrUsw0b7vF+l7FZKRbcWazMoDXDpo8fqElXKUtgjVY=;
 b=tePQzsE4mQaqt6sWw35PVDUPO4WuRkYDTuGxWIkmrFrCJfv/woOjXb3oo+S635r16mWOfRLb78gU+QdUTVsqKi+VNK7R6SrfOUa6lgiF+6WEc94wFFIqXXg8DdBIYrLMs49nHqwOcEBWQy9tfVaOjp3hAP2+CdJlBZ5k5i+4b/s=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:55:11 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::45) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 18:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:55:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:07 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:06 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 20/28] cxl/region: factor out interleave ways setup
Date: Mon, 9 Dec 2024 18:54:21 +0000
Message-ID: <20241209185429.54054-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 341bb85f-f711-4571-09b7-08dd18830216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hwoVbmQDSEL8M28oNYhBAaHuDqisQ2sGrgbRCGLbexdmWUbWQTHsZXM6+6R?=
 =?us-ascii?Q?H3+qoCyCPX23jDyCxnxEpGV50Lc5IcDpF/p1aVSg/Hy0ctaPczDBhKyGTWsc?=
 =?us-ascii?Q?lgJYhR/eGj0BCZbdjDVQKsmnX6MDlihkLcRVv2cYxJuxuT0cUmsdFMuVHIKN?=
 =?us-ascii?Q?8xgDnRa9ttBlQapc5HCEkJGVhv5BvLtIQdYa8aRJM9yyRcSG+hDKYDd9Ppcc?=
 =?us-ascii?Q?PRkS2pMFNjYGgIpnWYwuM4A81drdvL7iRrrHJ+yDWUtIRYI8VTJ9Cm/KzDdc?=
 =?us-ascii?Q?GDXaeVup9JR0Lf2Q08S26C/7rxCFFt7S5BBl9qF6+whLCEthvBgEkdNl41Dn?=
 =?us-ascii?Q?/e9tfqPtIgPftfNgKZ/GUgljQvRcLPrAw0dBED+fBz4qtNsaCpn2WXFdJClT?=
 =?us-ascii?Q?FSyaXasb47AmX5PrGj0648Vr3+3RuCemGjHqMMb7fQGMbXw3dffWdeltUYoA?=
 =?us-ascii?Q?UGkSUVihpLi2z//g4llpHHChSuH5pZJqaE2tC21X2jB6128LG1Zf7u2BORPU?=
 =?us-ascii?Q?qPS6wMxycYCBCfA6YEySoQrbOCcCFm2i0kiuQL/VzjTmFgh1r1m+q+gkEx0D?=
 =?us-ascii?Q?s7J3v/DrjmqnaP40P9hFJN4xfBoHFq/dUuX585kZEayGaXh8uNvRBJqIFfWM?=
 =?us-ascii?Q?awz90IgSgi0rBw136E7qv/J9g8E0tD+XssuamAW9soTqO+jIhu7i3g1kmRMX?=
 =?us-ascii?Q?3/bCTdrzJjC3F2F1TYUIoRVK1g5CxF8pZmUMpOvBNA/JOKRrmx3dWyzQ/ckx?=
 =?us-ascii?Q?JpOPMs+MH8jkUE89BTqEP3tsWUQt7VKcKl6A8kqwOllgj7s0bDwTdXJdg/+N?=
 =?us-ascii?Q?n8BR7a417qnekI4t3VuQ8J+LL+UShCMClFHTTDJFCqqlA8CEVHCseU93ytvy?=
 =?us-ascii?Q?gvvj4zxiVz6gIYtyGLgdFRhw7OJnvrQQDuL/a5Fv4pvQ0MMaS1jM+0Huv60i?=
 =?us-ascii?Q?0MFTJ18FGtv2mvrPU17DxEcec3ylQFV3L0XfoCyZgyW9OKuZvCo/USFFS5wb?=
 =?us-ascii?Q?src3o1OGrxikNdXjRkxvf8U9X0zGIEEHsM2HJxmcd2aC8oK4NPhVh6UX28fP?=
 =?us-ascii?Q?NPMivn7FaX+JrerDj4Gdkp0W9RuueKd1bk2TxViM5tP/JUBwCkMAFD1FzXyj?=
 =?us-ascii?Q?h3fP2SPLklf8W5QGPegYZbm4K2MVp9sp3/VWk+xz8G+pRiynHiavbTGYo4Ad?=
 =?us-ascii?Q?iYOOAXbw8cSeBKbDcTpX0NJO930Skfsw3TweM7lPJnDOi2nz8RGWXhrDATmY?=
 =?us-ascii?Q?Sh3w/qc+xib/ZUVcLE8HKmdA8V1VHAAG5AFXTfU/xPxNkXkbdX9ZlByFS9Cg?=
 =?us-ascii?Q?ueKs5OJLQx403riHna3Vk65O1Qx/+vf52W7OesBQZorq+5SvZEZss/W9UblC?=
 =?us-ascii?Q?qv2q7BPRF4utkL9RCv9hpRmIrUZD1mtol3VIGTYcYahW2iZho96EWHn8tWBg?=
 =?us-ascii?Q?GUMh1B2UJuqWQNEkgXInIelzNGdvg+ZF+bE7kCFVfyXCqXvaqFBqIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:11.0634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341bb85f-f711-4571-09b7-08dd18830216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4a8f82a866b3..6725ad271df4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
 		p->interleave_ways = save;
-out:
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
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.17.1


