Return-Path: <netdev+bounces-183930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B227A92CAD
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E19B447212
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37422171D;
	Thu, 17 Apr 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPybOwSw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60590212B05;
	Thu, 17 Apr 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925407; cv=fail; b=VmsDpgzq1b2Kd2tOreEzPyjGcB0xD6kAxo4kugWwEhG3uJl/5yqYIZCpmxW5yFzaxKtVN9WIET9KqpeYi9tofZwhdJCN37B6R7fKZq5ESjvFn5jU/zKBfs7UDaYbstCl7h/2dNPziO/pmcD50GBVx+XPbXiw4NsY2B0zqVxXHwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925407; c=relaxed/simple;
	bh=jUfwIMUKlmkTXV0gjngBx6nojo3AJXUEe5w5NqHGJno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkN4Sa5Qa83Y3sHAb6CsR4GpZMZ3zG28wFsf/iJScOuFr2p+DMxU7k5+CbANXJVBjKMz99MS18e5LBc500fxgalRD9ChEcPUdv1cYFA77V5kNHvcHfJsWpGWIcb41Etj/4mNvr85fKp/u0I211ZDLe7OqWdYSXCY44W63Hrv/wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPybOwSw; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJXCHLeGeHKdsdR3dZyn1TMIHdLnaJhnML9+WtxCmH7y+F83vmrP3awXSOF6jTROQGM8tFOBEiQDNdMru+OA6RJE1cgozol2PE3nD4eS6kIpi6C0GEq9cR1rhzM6NXvL+vNbpHiKeD1FZasDj3A2STPHE0LFgLPySzWoFx2Rg53mB1mhgWC1TDqEHUPVT5i37gXY7v2vgcg5Xg3IlEDIOaR8z1mO7g1gpEM2MBsJ/KWBLR+yPuq0zjY2zswpBY4y45SEb0snrPGJPHtKYY3cJzVSxtmp+dtZzyJyTRPsmzWZZDzZiT5C96lGlwIvg4K0GKtmHMEvlbFy4CgXLfZU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwmEW2TUyUBDxt1gJ91Jsg3RhZB4xutgjF8BsHyYfBc=;
 b=Dt9os0aojJokk1l+vEXzjJvnXLoxky3fe8CPYNbf9AmDqNCHkIb4WyksbKJRRJciHT3iUZdw57msyds/lu+ApnTOHcPvQAcP2+pcKvrREm3yRs++qxRiWqJJ5pMjc+uACwUt1IhnTo3U+fHJlVSygkRLuopWmxnD0/3gPtD57oqLEQjRhV1g2dnicKgAJywAIINGeg3b3ucGEVKenK3EYdadcK1z34+KAe3vpwS9A5l5QAQ3yxERbzF/i3AknMpJc4Ry3+KBlpZ4HmdzBBQBHlbVyt2MNljZuostUi7NKuOASeKX5wwFCXs8DbzV6SysaHe3MuqlNPqe9E1wvUuStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwmEW2TUyUBDxt1gJ91Jsg3RhZB4xutgjF8BsHyYfBc=;
 b=UPybOwSwU5N+SkxYqeaiQhl3dqhaauW0/Zus/3mZXVNv8pK7ZHdywe2F+My57Pe+fU6OAxwzjyIqlZUwrnUyXIqKpC8bTcjX+oPceTx1xeOtoIGf7jNGmg2rkxSFLhEUKoWJUXh4BiX2Q393ye0TYNp6Jm9y6M0U/1SfKNizXA0=
Received: from PH7PR17CA0050.namprd17.prod.outlook.com (2603:10b6:510:325::22)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:30:03 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::cb) by PH7PR17CA0050.outlook.office365.com
 (2603:10b6:510:325::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Thu,
 17 Apr 2025 21:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:30:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:30:01 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:30:00 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v14 17/22] cxl/region: factor out interleave granularity setup
Date: Thu, 17 Apr 2025 22:29:20 +0100
Message-ID: <20250417212926.1343268-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: f1de7fb3-9dbe-436e-3476-08dd7df703c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5Cc00A3MQiPzartVjWi1oRzFanVWd4JJV4yTW2lvm+JeIhPT8xMeoNaNJyG?=
 =?us-ascii?Q?Br+Rgy/udQnVw1KTqpEd8GPAazGIeTsjR/uR0t+a+QHdh8cIUVoOfR+atFXt?=
 =?us-ascii?Q?GBfVAJrFwpzvGB4DAYBmYSqswqoDoJ+9sJkBYZHCA/Q86EF7KV9n+VwAFXHN?=
 =?us-ascii?Q?f89fdpYj35+J0Ao4e1BLCLrhLvshhn85u/MYhdx6B31KaWrHUseOHll3LsXE?=
 =?us-ascii?Q?iVYCf9VdbXp8xP/Kc22oYkr56mfx1uXRDbe7MouoduPNKuB0fTY6hq2d3WCW?=
 =?us-ascii?Q?6fKZK38wK3Njm5PFSjUQGwst2v/wA6zIC8d4f2Ht88skSBqiUMWotd2MRQGv?=
 =?us-ascii?Q?ciAFuxYJWdwFypSYY4xk4XYlShXR2pBtWtv5DbbxVUIIaLJHe1vXDfrBK7IT?=
 =?us-ascii?Q?NPIYxmj4wBc1sd2388N5nAlI4lrZDwqL31YdJHdl5cmrieYAeZY3xnjE1erN?=
 =?us-ascii?Q?yU6pz2GCX3t6P++hOnYGSPeKBnW3qVcjcr+H7TfB/ndHiOEXIeAptWzpytfP?=
 =?us-ascii?Q?+20b5zhgqi2mVOFLYsv7VkxOr0jAaetX2CT9EDautgwuPbdvJCQM9SqjANbX?=
 =?us-ascii?Q?oOzjO1gjodzCgfj6xpGayRk/DllrN4jUFxS3RKbjXj//h6K6tikeTVW2qEsH?=
 =?us-ascii?Q?oRtyyVklgNzp/SrYmnaH8wnqdpMjH3W1uh95eMVFbQDqhbfFqXYfTZVXf4qI?=
 =?us-ascii?Q?Kn/GO3S65QwI+VRT6rf3EjB/qH2xki3UZJl7VLCOxdP8zhnjwqykZnMGdbYS?=
 =?us-ascii?Q?uSk3WNFdTFkrLn6nuQj1r0j2hIrVgswbLgX5Xrv9JjnRHor2QnIea33OaTxD?=
 =?us-ascii?Q?4ulCifb6AeGc3eNch8ZpIKv5wkicK6FNAl/GIGIz8RU8Ap2JjxPg9p5kq9cf?=
 =?us-ascii?Q?GyRVJ9JQc1WJOfqa635x/bq1hrMwqmDfUhBxlJu9I0Q0ndYr6VpDxLeGZUkX?=
 =?us-ascii?Q?ioqf89mnbH/5JY6um3s2mmEPoYEBkiHV9+n8fh79n6vhki5vwp6qRCxg5roN?=
 =?us-ascii?Q?vyEUugUZ4Dv1KlHO59+w+hG8CtfEXp7UfD4gPFztictjyKwa39HWrZdWrO81?=
 =?us-ascii?Q?IvrLTi8wNk7tDxhLTGvoMpj913yD5zK0Hd0AXo75Lvoo8Xk4CxyA3uUUY7UE?=
 =?us-ascii?Q?WKfF1W7udomEmgZOJPJLe7vV2dZhxf4n642tOSmy8bWTu6cqRm77QXW87QIq?=
 =?us-ascii?Q?ey2nQ+QOD97tr/w4C8lZBsvVO4uih6iWxjt23S8up1k6Euug1MCYDnIjzlbe?=
 =?us-ascii?Q?hZZXHY/DOjPZzOnVeYrGzTD01DHdW/MviYlR9sOoj+ZwIXvy6+flJvHNuPPw?=
 =?us-ascii?Q?06Mtp+ptQHzm7h3q5EWMdHmIy+9bzy3bBld9Av1wWUX5gCYM4jI3jXCFltuq?=
 =?us-ascii?Q?+EQDT+4HVieNob5gG3tz49/Rbw77duDP6txzp3jD1XP9hx/CrVZTHwh85PdL?=
 =?us-ascii?Q?TzI3OoMmwvuWSF1dcdJiTmhFcfm8xqkYzTPP/FAQ8EYD4QHR7OZfE8gRwp8u?=
 =?us-ascii?Q?mTtIqput9hauB+J4NVIjy/Wzy+CTjYFCukao?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:30:02.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1de7fb3-9dbe-436e-3476-08dd7df703c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 095e52237516..af99d925fdd0 100644
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


