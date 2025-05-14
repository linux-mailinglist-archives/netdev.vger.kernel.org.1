Return-Path: <netdev+bounces-190431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB07AB6CAE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200AA19E87BC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C227A935;
	Wed, 14 May 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KKcvpZJX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284627A92B;
	Wed, 14 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229310; cv=fail; b=PRHjAoMGnSrJq88q0uaNPKYodSIqVNURYnPB0BwNfQr8nbG8f8ks3aQG7Ye1cxNebpc17oK8y+DMT1n5yrDqWXFp1SZEGlGTidmXzDByq8EvQvxD3Yu7Z/NtrHFOxR+8RACLiaqntd92sg7GDnPzZNjuoiMS/wRiYP3PWnOMig8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229310; c=relaxed/simple;
	bh=E2bMTK2WZ1aJPtIobFgftzFBlwrSkUDAPCnl6p/RS8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fscrzlmBz5Qeu9yw0sxmeMttaXIvTlxm1+iV7VPgVaoWcwuYP6ciQ2Whxi3vx/mG+OXhZ1NhJBF6za/HFnRoeKKuQyLxxNg0Gf6e8kVk5rVtwyhgC/hQRSVrgSNcvad12N/qb9fM+5FOGGeYpO9/mEo5Ca+qMuqd8l+eFXU45LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KKcvpZJX; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxDrayjShb4UPxac/6+PsBhoRj8PbdqNRF8jkToWbLpWei3o3NS8+F11FexhZU8uc7LgKk95GK/NMF+jla4Mtd3bI5D0om+ygFUMZI4FHoY7kGcuNeFW2UOf44IzCgzeZyylLXq+15eFtrIVqNz8w28CtX/7NHq+3yDttEUizBBNAc4RjjMuhxaYZ3bUjQmZukhjdy0l/X4r9H7ELoCv5ilIgfrWbRMA61n5OkHpd2vK7rvZOOaujzUyOeqMskrjRB2lebFn/6vEL6IoNn/5wyY2D8fTCdLIeXuBwyY7DXaTUvJFtAhYo4d2dFtgOWjBPHXgkPzqcE04zKbGSPPg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GALtx9rXmAzZ3VTz5ZWtCt1e0DR0RUPiCSnwRG3bwWY=;
 b=mYb5r5emI/Pbkoj0/24cyjMHCJsq5f9P+ZDMG8sjOiOo4J+EpO0tUxNrerapE/L0WwXIkRk9/fq6M/Up+gqcWDKKRqZQ+G1sESUP2uVTLj7Zk3MRKSWtdHlTm0eWAFFQUKOAySxFijO7js7QQWNtaxeSednf/MbSFRJsZ42gSNeXhIV9c7pQt9L01X1eKM6/RhDPvMXS1ysfiIbOtibYeeIv2Kae9SeMCgL49E4+BpkpkOijCfxnDwWgyNBBndw7XoZEGDm3BXd1YfU0yf+IkDGIJiTr1Lrk9+ScuuQ7VIez6RRDtmnIWQV8C+jDxeiBh76hMXgs30RzYORnrjlq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GALtx9rXmAzZ3VTz5ZWtCt1e0DR0RUPiCSnwRG3bwWY=;
 b=KKcvpZJX8hzQgIlCV2ffYYEc5lwV+LTdVLMnaxf2Gvvpa9dytwrZkRLmNHJBU2zCYvztebF04WK1cYE17Bntj6yjk0CByrn9knNiEM1vH+/TYIQyotxXPNUegn54iMPzVjFggbuFCqwDa2PV+yAH6tudOI8SNv51EaefShqkfW0=
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Wed, 14 May
 2025 13:28:23 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::a0) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Wed,
 14 May 2025 13:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:21 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:19 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v16 17/22] cxl/region: Factor out interleave granularity setup
Date: Wed, 14 May 2025 14:27:38 +0100
Message-ID: <20250514132743.523469-18-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 3982e80e-f2b4-453b-9ca2-08dd92eb3283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dCGToPS1BKlGIffN6DL41FC9fZ0qjGZRfhQUiD0mILjBzRJPhnbzq12IQvk?=
 =?us-ascii?Q?xDGXEs3b8URMdSyHuqMO5MwSgQAwOE+taAEgXWqAhV3pDVGu9V0Q8tDC2ILo?=
 =?us-ascii?Q?zQ/AjEWo49kIh3i5ery2kZLEd8SK1fdW86zrHtG8WGJwFxYadQ+AfwCh4XeG?=
 =?us-ascii?Q?5rDIQls02qcOn+S8Z6kDnZDsci13LeE6aXnRBZLldrPhvzQwHkC3MiYZ350w?=
 =?us-ascii?Q?9tdJXHHUlCm9Omr3RhA8JijNoLYuGvCYMqjn4m6VYtZJo4fcKbFhXbJrLOS8?=
 =?us-ascii?Q?GBG9OCQLKnVB4AHOMTU0LUlIHyrtiaAKS69TpjfkzWsDTTybodEO5Hkho6Q+?=
 =?us-ascii?Q?oTGhoFSKUIWqLuv+brBXWZXPSRVPhdRLdcrP+R5uxTBsoo4HEaWZcw4xW5D4?=
 =?us-ascii?Q?VRaSfaWJWZuKIGBspqp0g5D24+EP5Uzp6wytJtjORJ1Hp5KD6Zg7nC1npAtX?=
 =?us-ascii?Q?48AmAf6w3CHIo4/ldGgfagC7B8JOXEQvLqG49VHT2RN9gR91lFcz4WAcXCwt?=
 =?us-ascii?Q?RGS6rT/EWEfL4bFsD7IPvmLIIGX5bZ39jtSR41oU+r5rY8RAzXHfskqLXWy3?=
 =?us-ascii?Q?TcrRce6LXK46+NnSI7JxSP5eQBkzXl2qs5tLEpunVFtoZy/PJY80I2ta+x7L?=
 =?us-ascii?Q?Q2T0zKGjitu9yvj3IiNsOSHlaKuMaF71VdUQtpFfcPW38Qs8crxU1k+TIJ96?=
 =?us-ascii?Q?butpc/Lt1wfc7f+1Lqiodqcn2OEnWbhymkXgvDv17XVWQ/3e4JnEaeFxssyC?=
 =?us-ascii?Q?Nz3oVGlYYkHcbRZJmUAVAjKaLNhvr8odBVHNg1bJgMZ7pFWEc0HzFPqnO5PC?=
 =?us-ascii?Q?hW9sp0ElM5BMCoUcQ81J5p/kMRay0c0MfMtNPOhpCFEk8+EekZb6NRUvVAeC?=
 =?us-ascii?Q?L6rSSHdMCtwxW0PXl7yi4oye/pOg94Bp9H0jH2uwxyZwqNLDbyepUSp4nPgC?=
 =?us-ascii?Q?yav/s/ouNy98iBSRccNTlvoFpRFivK3+H3UWyR//U86TQVg3pL1KoSUbEdOf?=
 =?us-ascii?Q?KnEQf/Qshx8cDTfFVbZuaqLMKiNGY/axHbJi9iouX9myjzWKceaaDPMzkrpk?=
 =?us-ascii?Q?ZaNFJ/aZwVogVMIAbZ8Zc1qosedTvd2CXXULuHS9uk5rk2F0Q+H2QuVJHeEc?=
 =?us-ascii?Q?sqidw3Ljs5ycRV9LH605MFbIrmTGTiWAFCWXfbKF0UdVfTW9DTrYSStvkVEv?=
 =?us-ascii?Q?Nmq0B0K+XVRgEEgQvBWZmBwwSmZt98lnq6p0qpk+iSzE+LFtPjxA/ZFpFp85?=
 =?us-ascii?Q?Nyvg6TyW4Myqk/Jo/oB6kWxCqlewh+hIaOrVL4yWGUSssqw/s0vm1rq2EpWC?=
 =?us-ascii?Q?QOxE27Zh4H6vT6QQNAMXlJuXo9DsaB79RJ53hOAVrGqsFLhdIlsI3C1sUMC9?=
 =?us-ascii?Q?IysTybrbgqYw1suQ62KJ9gzjGrbBslNk2FSagVbHEQtc/rynPcRITL3iKWg5?=
 =?us-ascii?Q?RYdUs5afpffT/DGBhCIwcDfJjuvSc60oJIHE9E5rWZzeZrkWTtgIQy8HWct4?=
 =?us-ascii?Q?ibmciCCsRFZiWzFUkqgt79tYFRGNzbBw8ONT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:21.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3982e80e-f2b4-453b-9ca2-08dd92eb3283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f61c9e9b954..4113ee6daec9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -540,21 +540,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
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
@@ -570,16 +563,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
2.34.1


