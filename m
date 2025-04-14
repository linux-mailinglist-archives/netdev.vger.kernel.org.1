Return-Path: <netdev+bounces-182299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD366A886B7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8919C16792D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E4279913;
	Mon, 14 Apr 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j3VWPCRQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD22797BB;
	Mon, 14 Apr 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643659; cv=fail; b=A87aR5XsWfTPp+Cpj0Z27AEbmP9MPnQ6CTdSLdf4PQeCC41mpd24ZI/lMJSM5cGsblZBQxSVwhwOQCXA7SIWEJVDh3r8A4HUyEh9ibm+cdkFInff0a4Bzp9CHAs0/nvZK1i/DaHoLdMCNYbxO2lhh597JPWMs9Gi2HQn2garYmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643659; c=relaxed/simple;
	bh=jUfwIMUKlmkTXV0gjngBx6nojo3AJXUEe5w5NqHGJno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5ovnjjZ7fXndX/Uu9wmYH+aocHbZmWSCCNZTYSan2AuBGjIQegWBMuLVWzRxaXwXEMcXCkQ5Rvn1V4/vhvlfn16GHsDHnnlnqcHMCg/C7WxkoO/rXGkOJqXEt1DuwTcHXAG+OKyJ+1pt+E5smNPHH8QBCEKlyOxto37HTXMpkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j3VWPCRQ; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piGuwkyvrB8fobONgkAr90SbtYQI3hh4ZXKn7LbLhbOg5dMliZJzgEMKJssBb2irzl/jQqu5N3vbha68nL5dibmSqJQH1XCHz6uqkpjYMIQw28AFuHqjYVq6N5ZwiValb0+xKNKy1ljFwAQSxDQCFIIMmwmqzoHhb7n5JE0ziPB7CToVNPmT6CdWZIVq+82yEDYf210LVVQ2J3EiWrgshtCHbOeU/KrSj+C/vI9te3hbjmerCjXqNFn+d+vKMPDcNJbB5JYj1oYQIzPuPonSRs1e1Q/mg3j6/r17iH0wFykHdabi9ZU+UtZOrB+2vSQqqvTC7jIVripzK4Sjn/ZliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwmEW2TUyUBDxt1gJ91Jsg3RhZB4xutgjF8BsHyYfBc=;
 b=Ds3l815KlpiRsWWCqcVzV821Ad+NXrzTQT8RjlhNefoqXd2+WdPSuoTjaofSOy+TnUIx/joBZwBMDu6QHO8aVOHQT4CbzRTjUb43ZqPuUHEJ+JT12S2qXSsVz9yPi6OlF6z2zxStrB1IIDKu5Fi+YycbhuBIkFb+xPEGJsoPhu7yPOXOLPNB4JfZkttFQDreOupZ5LFclRjzRWuKNEIXjaYN+l6OJkH+7eMKbOjfz+4BFdv98HonKSaMo5jA3jyWT6BLOsO2iFUirQSxheO+NobhxXr3Wg1P8MBUfC9/XOFOZXxdBjiKwqLyrXwJ3F6Fc+Uw3UkOXHYl65MtanZ3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwmEW2TUyUBDxt1gJ91Jsg3RhZB4xutgjF8BsHyYfBc=;
 b=j3VWPCRQmvEFgo4wKlP4bJ+Jw90oOzfDfC8q5VNVeNnAGbmU5Zz3/AJZ9pyX1zYRibVlSzfA+vCWLx5SilE5yV6EGYqgmjSN3Lg0SwHcZkOwcHDla5w0HGNpjDv9jrHT2XgcGlf7JxIudD2UAhVusK3OwDBMzyGw6yVjc0n+lpo=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:14 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::4) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:12 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:10 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 17/22] cxl/region: factor out interleave granularity setup
Date: Mon, 14 Apr 2025 16:13:31 +0100
Message-ID: <20250414151336.3852990-18-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbe14ff-210d-49eb-b717-08dd7b67040e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLO6dVVsBB4wL7HoGakXIOqvKPj+qnhWi/P/l4+C/lRzKskci6f51Bb4eP+H?=
 =?us-ascii?Q?Lr2F3ODbTiYmq6ldIYzjiFP6ooPT66FH1xGkzrWSOiT88k6toDaIvTrNZ85l?=
 =?us-ascii?Q?cFH76pVpWfwoaT/54pQYpJVZ++SQ5Hg/0CHSQ1ahxvsjeeTdONF/J1swDtJ0?=
 =?us-ascii?Q?5qhEhDF1hOdQCOgIvRdiMcDhoroewMcsidWf3No1mHQ3Lbpqku/e52NrPqsX?=
 =?us-ascii?Q?5IFQqLeH1VrcOnEyuIUbjWkB/YLHwr8+9AiTBRxNZBiVew6v9Lx5rpSxEBqr?=
 =?us-ascii?Q?yRiovwCEHs+Ypy0JZI5w5o5OekVMowO1zx7pJEvMIjUMUyWX7WbOxZhfWv/1?=
 =?us-ascii?Q?kh7jTIFELJwe9LMjIdOnCgc0UK8Uzy0n6eJSn5W2LlzYbOmsrHV6d+3VYqT7?=
 =?us-ascii?Q?mh0qGJJPPaYonhpRMLO90F+aWkK9t+UTqQj4CToga9yWwAuHHKAbec+KJWud?=
 =?us-ascii?Q?4h8Rm6Nq9NQlnMlam725HB5USi7Et6KtwGdmwQwoC//qlg67pdhPRQ/0BtW6?=
 =?us-ascii?Q?KVbydEkNcthkIhULtS+H9tINj9HNgNYXMNXj7oF50NB1y9Oy5c3Gf4tNzClC?=
 =?us-ascii?Q?PiyDxZZEZTkuowafGXplurf3YwL6zraisxc13XvekYMW/a1kIywRtuvgvFwh?=
 =?us-ascii?Q?hjSdvn/IDJQ/x0/8daiu+a1l1R0v+e65zUp56tWJEqL+3PFinbwe8btiZRv0?=
 =?us-ascii?Q?59r8Xk83gUkXZu324t3jlWiO8r65nsjKYoAzi0Wkduu9g4ZCgcUyMNXf4CIE?=
 =?us-ascii?Q?2im0SoYfTj14ptCMoaa4OMUFIAfChZxMwtF5HL+4NLfl0/aqIc2zvdDQdzCb?=
 =?us-ascii?Q?NhUdFtEOGhwVcQKID5jXk6wRhbiOq0Kf2d6vo+mv5ALhwDu/SkJE+c3XJPR9?=
 =?us-ascii?Q?LPtw1Uyz2ATWMHkZVMpDp+oVVv+abZ8+i7EDwJvxaEakX8t+us5zhsLrQcUq?=
 =?us-ascii?Q?DQ+ktrKszf5l3JJaQtK+814aATGfRxtLLIXeSGyNThQcnCg0+AN7qucXzW93?=
 =?us-ascii?Q?na1PJ615cZbyeabTYAJgN5QX7/2cHnH8gAYz2gVcQYTzKfPTTEIqYo9DrohW?=
 =?us-ascii?Q?imiA0mwpn5bOYyYhOKKCXHZ5x1H1FHlGKMwbBUS8P8rNVNHJnacNsZVx8Xmt?=
 =?us-ascii?Q?7gfgVhdyOoUFlw3S1G0JnnOc70EAF/abnOJI82kJrjWc/k/9vP58Hj+SZCvC?=
 =?us-ascii?Q?iytgmhOXbrDN7lTm5egiEsxbhBp+ZWDLn41Yh7Qc8YAFANvzF3E/vXR26bGQ?=
 =?us-ascii?Q?S40q/5E+1Hc+fYGPixna2OXKjYf5oEadheB/ZwcFONpgYWQP1JKOwSdmJPuj?=
 =?us-ascii?Q?nkSaDM2tRl15wqt03ABeijNncUpHRuTOBtF1SX8GIcKsONXY+a3zTL/4J1mz?=
 =?us-ascii?Q?L0lw0o+YJG4YlMNMzr7qSnNtWAa/gDJuKe8yO+epfKVXFAYRhxFA6r3ho00R?=
 =?us-ascii?Q?TuDCP0wXLJDKYreEWQAkh/+6ISB3hQ3bdAyjUKNnynHobQLkHB3eQAJgtI4Y?=
 =?us-ascii?Q?dr/06WsfL2LMO5u7Hhz4U9LczHuVKTPZcLjB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:13.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbe14ff-210d-49eb-b717-08dd7b67040e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

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


