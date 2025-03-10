Return-Path: <netdev+bounces-173672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DBA5A58F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F518932D7
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011A1EF396;
	Mon, 10 Mar 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxit9+tE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002B1EB5F9;
	Mon, 10 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640664; cv=fail; b=rfODsWy5ziHH7fBtygtesaDI9X4Pd0G80uFiJ9Qv4cbY1Qf4FhCe0f7dteplVMJec4P0iiqXKSdyQvAByBONjCiHnNYkj7o90SxSck6ackH6+U4onn5GiroKgtixSpgPZJqIzrUPIuzqw7qMGs6s99tIBhLDerDACy9Z/GEJMg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640664; c=relaxed/simple;
	bh=nq6+310qclKEm6Z06V35nbAgOCGz7bwJzlg+i5xnEpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXVZuHxFwbwKA3cPURw1j8gRxu1vAzrJLv5CwPboST/FqU9/mKQP8SHAbU187mDZVOMtJZE6dtsfuxyH4Wr1Oz3AgapDCrFoqcI6ds61kSAIWXiND0HXoHdX/65LxBW1wk6S33VjS/b3iahxqEwkt5v4KfEM+N/+9Jir/E6ZtpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxit9+tE; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1wXRiQuQCT2SpZOMBn+9CMx6eTgJjrTCaog/JA3dybfZ1Qymxr3F3QsEcixVcRqJ3sxPaTk7MbWwXBcksMWrT75xksNzGfCK2TLRKejKtcGi3h28BdUJPBntvaQXkv4luxRr1hb0lpPIMoK/dVCIFPY+IQCenwdxXSiyqifh8lNhqiDkYyTHMtrgLesw9mXYhLII3SxN3GoENkb0TcsccYZS9IUgNXr9wBylKXbHvSietDn41ilXogEMU+oaPhw8A+ntCSl1Y1ReiqEON0HKzBVl4yiYxAD2isG866Fm6wYEi2rrwPyfW/KfFSgEK0wzmw47MzhY1U0jOCu8ggavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIZK5lIEx8ZPfY52ZRm0po9gtagHg2U5u5u0yDGUw1A=;
 b=gYiVqpllA0gTZFmPniZlYHYL8BuW/awYnn+d6TeoNdcBFDoeZB0zQJNifb1d0ehN33NwK4+1TOL7RciDTBibZYtmLfyEffv8ppNLeFgfxjawFNahC41B7YAqN7hqOvN0S1a0Cx93F1kEnYoFS0vMipFjSUCSiMorLn8bnTJj1ZgtvbjaeBlohaYlNmW8ohXoAUAXvfhuPvC0TR5A8Qyi8HVYggVE2sJP/W9Eeueqz8pvOnPPtxStCWpjeKJxy1tYKlGUCMZSRN2cj9dyr1+cwSPQeTESBAMNM5vaoMMladU0FluumUbuza0iyk1YLft25JLm0RJ7lNp70ekWsdAlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIZK5lIEx8ZPfY52ZRm0po9gtagHg2U5u5u0yDGUw1A=;
 b=oxit9+tEzXQ0WyV7nw+aY57oCWKJFSJGMOwnJdlgDZBBj1i33rLFCa/I5RbjetQNLP9N61IH2tIR33mLmFVWm3beJuFF3Xwc3L1dnxGnrnzOiReTg6Z+d0K2BLEO7A+sXQXpCiz8qA6skENaGlpUWXCwdz/Qn3uIq2qaPZKkfG8=
Received: from BY5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:a03:1f4::28)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:16 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::bf) by BY5PR20CA0015.outlook.office365.com
 (2603:10b6:a03:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:15 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:13 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 17/23] cxl/region: factor out interleave granularity setup
Date: Mon, 10 Mar 2025 21:03:34 +0000
Message-ID: <20250310210340.3234884-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 05572ff2-705b-41dc-925f-08dd60171e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1oIgdf+WZNfN/DZ/t5pMwmu0MhKPSF2otT+ODRDDNNfkVFjx9VFRVo/snMU?=
 =?us-ascii?Q?kn0BAKzOinoF/Zzyih2YYtSwsIM1I3WMfFLWEWK2zl++MLORrOBGhuSiqYpl?=
 =?us-ascii?Q?8tKyyCZL3qRgVo38woqKVK3AlW9g2icFoJfkyFy3PGRLacJ/v4h5gxypsf8h?=
 =?us-ascii?Q?R+J9PezbbB7tNwqIGbcn/xKaSxa8oh4P49RtlmGCP4jkdTjnHMij8f4EUnhY?=
 =?us-ascii?Q?W2GNwYE02/NwrXPcKa66F86d+zrPCK+acHDuF6D0BaOqZ/i+GYwYXan6+ciU?=
 =?us-ascii?Q?bvjb94xiPksmiESPlOL/5JypDdwmz1jDKodlVU3So+KPYphRn7Rj8XgCovVQ?=
 =?us-ascii?Q?IyExXpyrqPDMmEyV4DoesdwFSYYpXNDwTcHWrNIroWBNFRWxlSmzV1x1Sxxd?=
 =?us-ascii?Q?VA9TH+hk9rmEKu9o43L/+cgt6DIcSa73jDYaY8M7uaBFk9ETMd7/Y4+9DNnL?=
 =?us-ascii?Q?Q9Wrk4s6Xqswt4TGpwBLl7gcQNmWalMeDOvFVMtEu27ZD1mf9V5tAglrZO3u?=
 =?us-ascii?Q?Ytj2yn0UqNeX4o+Gl8YYDzcHDApNx+UopkQqBnFxE/hgA4XJG7WPDgXdIFXd?=
 =?us-ascii?Q?FEeMahILBzSEydpw2D8NTxgH+zg8787Brvt/AO8XcBQSQap80VZ40fvqjNm0?=
 =?us-ascii?Q?mmfVCKa8kccw02IO0lvnh0xrE6UrvAF3FLWoHCh5R9O9Ct2odjnCAst1ZPPT?=
 =?us-ascii?Q?jUZ0FALIcx9uQiwyMA534na5aoUb0xMJn0Fid8yPyDUJmyknvfGvrI1W61YE?=
 =?us-ascii?Q?8xWFyy8NkT/TWDzgKEjn/WIbdVhdL0dc+aubxolEyxVJ3PQhMOJhG49eqlo+?=
 =?us-ascii?Q?69wp/gsBHpSOuvmpoRzdchfOMar0m2FJmWxAUwi7EcYQo7fqQrcX0yWQ2q2x?=
 =?us-ascii?Q?pf2wLUV66nfrX1oeibLPeaBXv6DFvML3m4WgsuVvlE2FCFqAt45fHbEDhSYw?=
 =?us-ascii?Q?PEHXt+VERafdLUL/4s5ozJZhB058euSO3WJ9OYARv1SVygxnIt6wIgF8Xdcg?=
 =?us-ascii?Q?gpMe9ewFHtX6FoFVCCpFXCxlUmi+Rp/iaEGa9YOBSBWOS1z+Z+7AVkB5M/+B?=
 =?us-ascii?Q?JRWDHCrQTLW96/igjI/4ps7OS4ii7WdBWdcvO+h+H3LYSIXvxo05Bdrqe9Th?=
 =?us-ascii?Q?9Gu9cIpQcpjn856oN2ubIK2sPd2b7uD37qsXa++FbO6G9ktFUDG4Vyqe9NVI?=
 =?us-ascii?Q?h0UpSdY0aIWjgazVO6VWHec8a9OWoz2lJEYof7kS5bRKpeMRko1NmhrMb+TU?=
 =?us-ascii?Q?qtsz6CifVBdJkvOtOYHI7AUkDGdUb/9VaUDZZOsyDh7SqM53E9mc9hbyXpQr?=
 =?us-ascii?Q?nuHXSjH4F6HA9Npxwx2bfjOAeaWqzNxeJhf/0eh6XVk+UwXqnDWBPIRRz/+H?=
 =?us-ascii?Q?ExmLiep2g+yafwVxnNiHYyWA5JNEU1L03YJMDgeS1ci4Z/4owZUb7e/+oO5v?=
 =?us-ascii?Q?fNcxe0Z/hy36NVas6iiQgeLCjEKbbcNtqkvzhApnC4zkk/SuUAYVgTiOpaQ+?=
 =?us-ascii?Q?kNw5vXEAUZ15r0s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:16.2756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05572ff2-705b-41dc-925f-08dd60171e3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27b0e458752e..e24666a419cd 100644
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


