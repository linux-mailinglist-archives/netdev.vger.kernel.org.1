Return-Path: <netdev+bounces-200684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872CAE6843
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1503166662
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C412DCBE7;
	Tue, 24 Jun 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrBHpgWK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DB2D9ED5;
	Tue, 24 Jun 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774490; cv=fail; b=DZRXYLCd9gf9sBbo3KqwaWbMItj1tYKg783aCjpUq/D2QfdJEcjRBZf2M6CCQdGXC79FwQ1L+rgTHmhJ5EVLfoCm7OaaQjbfnl85VvofNqKouaDSgUo0xR7zJoeNFdevSLb3DhjWqBm0mK4yRma0p+xG7Q88f5hVnzXO12MrBcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774490; c=relaxed/simple;
	bh=qt95k6BK0Pdojm0t3URWgHUVeREg8sI7sj8bQq/s0Q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOJnb0OK216Dx6/cN3zhzTc46W96VOcKsq0pTOsOVxr/gk6q0LBTO7zBbhCPhjID2VNGQHe0T0lVqWNjTGv1d47PKwDjWz4MPJPTd2Vb+RjtBJeOlV7ByDe/WGvomfuGnShao2MykXZahZQU3LrEOrlNf4Mlw1e/3RGZZIPa8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrBHpgWK; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/RSqszYO4WFKzmGvLCKF9Ty/KSnmk7QfiNttq8/NjAWbNBnoycbVf3QeKvqEubkxY0EqxLdD7206JBSszHzKWEuJy8s7gdaTzTWYFPNC5X4b2yQQPrVrwyJIi4E592T4krUHkDgGPdVenWkXJ4vJq0Gpqcbezo/6lG83x86fL8CNWBkqFwHuvbnF/doANgP3ciLN0DJapOlW9jW1ydTwAtZfgZTAFYo8sHAzx17JXiY/mN9V+RESevl2+gzvoaG2gOJYySBXOwgBIt7gsv/NKI41dBAtpfHrCsaSR5+mg9Yvg+z7hH6via/tuyO/guBKvpgGzHp4G4IkYodHEV/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMpUvrH9dmNF6vYwf5x/HJE2YZKylnL5HdoxtgbDqcA=;
 b=mrcnn9sMqnOJXzfJpgKd1ewNw2sZU3l9wHfWyzZIojXCUBf19xZGbInd6627QFZkOn+2vessbEhAC7kONZyqd97eJvfdCHIHAui1zQSf9NKCTDpidUKJgUF9MmfSw6KlHien9L5vmyemn4yhVWFOhyW0ezGmwy5hL48OdjX6wl6gpiPc/evdHcV0TXjB/f1O4buvO8Rx9bWHx7LuWKKOu1aBnIfFHIsE3tQwUxd6ND4MXBxR+bjbkkjQ5CICmRutAQiVVt/6sYIZcsl9Bxhiy4ZLUZIDO0OnNTnMR1XVjSB+8qxABfPvZN+gRIaYnH+0wLPBtB+LRgLBGrIs0lqikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMpUvrH9dmNF6vYwf5x/HJE2YZKylnL5HdoxtgbDqcA=;
 b=QrBHpgWKCJiMFKiyyAvFPQ3iexfQbTicZAjjhWZlxJ1XK5k+QhcSXdKb0ESOZHro+TvyfvE5gMxQwKL1A9ouk5G9NOyjhNmSgPZrmkLApe3p3Ht1/dIfO1CqHYJXNvlPYe5emu2hISn3z9zaFlmwthNwZE2duSK5MWanj1QnYow=
Received: from SN7PR04CA0222.namprd04.prod.outlook.com (2603:10b6:806:127::17)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:14:43 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::54) by SN7PR04CA0222.outlook.office365.com
 (2603:10b6:806:127::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:38 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v17 16/22] cxl/region: Factor out interleave ways setup
Date: Tue, 24 Jun 2025 15:13:49 +0100
Message-ID: <20250624141355.269056-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 759fd0d1-5e17-4677-9764-08ddb3297736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/DAf7QAPgGbq1Jm2jzpr4u53daDAjsMIUZOOXw/YtBcWwAjHnd2MND0rGV3?=
 =?us-ascii?Q?YxRANfGUAdBIBi2PzgHpDjVqTXq1YFrmCfwlxsZx4wB5IIHQ68AvoseI3/JN?=
 =?us-ascii?Q?3wSpFIBc16gyBe5ixQRAfg4i/bvYN+Aui170u0fuCJ3GYTjiPrFjopJkHfhK?=
 =?us-ascii?Q?uSNtMTkoVRuo4vAUgS4df2bhBCf0NU04IDd47ziXY5PlZV7dT/LOO6TrUDry?=
 =?us-ascii?Q?WaR+HTGSyZG7owzuZxG/wX63D1ffaGs6ZOYtNfOQZu3wp4DRSd8LLZGzZ0Xe?=
 =?us-ascii?Q?wfCsTSb+h/+xfvXEBtaiBu3Oo0Q/mMkGlS0mZtpGgZps+d17/3Q8NJZ+tMPi?=
 =?us-ascii?Q?PBLV3/4AnzEyjc0CrYTqyYC0g6G/DrjnbzvIQf0TbjJajCPGjG5AVRv3267A?=
 =?us-ascii?Q?lyujoYR02N0K0y19ADrXLM9JxUSUjdx8RD3C++vw+lUbOeEnw4srlaUvkCoJ?=
 =?us-ascii?Q?WsOR7JmbyOxQC08VbGL6ezsA/iakqd1GAPSuyO37unRhO5Vpb+JfITROKhVb?=
 =?us-ascii?Q?77MFS7YOv/wsA1VXvb2U7aa5NDFX/nP9JDOx/ZrXlWqQEDUgVvcfmcSGOfIm?=
 =?us-ascii?Q?DwVo5tMDxgrnznwVdU8DIGc5wEX/F7Bfs2WoSLjveT+DJboF585ddyN9Uxwy?=
 =?us-ascii?Q?eaVtGiBFBt7kT+4lGWDEoR5lfx5f0KihsOz1t2eAnAKUP/ytWcMvIPoWqqSH?=
 =?us-ascii?Q?X4wshX+XJBFONfcG4cjs/tZvBrpsKnC1LTfoageNIC2TiwLypnoh6frlBaiV?=
 =?us-ascii?Q?CvBv7MtXVITa0DmbJNC5VzA1O6Rrr0m4RuLQRIvwoHyQsb5VepBqKIYgibKm?=
 =?us-ascii?Q?f3IMNVxuuqOl24MYni1ExNfE0MLDi0PjZmHeljaNaa4sNzVG5n8IWuFmGooL?=
 =?us-ascii?Q?YquzSqb3v3s6cRRMWO2HXx4NCjCn5lJ2YV222vTeQjlielZ37VlTxXnZlQK8?=
 =?us-ascii?Q?YwGixt4GwKW9mtgFWoYkMR2uwOTTtX1X+0uIDAgmbBhH1YMQlIUc8Tul/KAm?=
 =?us-ascii?Q?IhItDzExwl8kugOu8ilmvxX4a4snZDEAmkNOxIZ/Ey7DTe2vg6aKRykbgKEu?=
 =?us-ascii?Q?pq46o0SLMI+aRpP2HsBxGzp5LOrJ3m50Q8YbK3mBo4pZO/BQirUTWDeiIlBV?=
 =?us-ascii?Q?SZLG8z83HZZQaR0ejcUQ81O5bCCpvLxRTeiXxTLPc5XnwiEVbP1EytBpd+2x?=
 =?us-ascii?Q?omWfcU73SaWWr7KzmAQc9maePabad2fmkMKnNlnHHRHYALD/o89pm/Gh3EuT?=
 =?us-ascii?Q?O/E2JXhq/kniGjjmePEl0HHl92EfFzs2Kh6i2hIGtkuytZMbCV2YmB/tw9Ip?=
 =?us-ascii?Q?nxCll+CnYUm2PmEEqg3QJjTCBisiYJr+vhlSiIKL4C413l4SnapYpORu0iqw?=
 =?us-ascii?Q?s/BjFTlaf5cdtCux6X/zaGM4y9yxc/v6WgfYA6h2hpBybrKED4e/7Qevv3Ds?=
 =?us-ascii?Q?Mq4MSW9Mak9PuttxaNZC0Oora07CQarVCSFBiHAU8rbWvD9CTLkinqbhoNyA?=
 =?us-ascii?Q?0KA8ADJgZurFtJxXg6hLOOOBqxvj7gP8cBkl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:43.0913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fd0d1-5e17-4677-9764-08ddb3297736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c8ef30db2157..c0ad6ff67977 100644
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
2.34.1


