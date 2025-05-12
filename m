Return-Path: <netdev+bounces-189828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12341AB3D36
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E8219E4B37
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855C28D857;
	Mon, 12 May 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kC7JgGxa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C15248F61;
	Mon, 12 May 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066299; cv=fail; b=L+Y1U/o5s0WKiNgofqfDZfnOV0P05/i30SfONvkGxSHQdTHvGY2PwOEweEKqy/zs74TNGz9oYUWhPLrY14pFMlY8Tw6+4Hg6sgbcD7sXw5vAW/46suqrP6wZpbUJ/EeL+soSAnoxC3JYk7VoJMQWgkAsmdaizauhkX9bBDjxHf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066299; c=relaxed/simple;
	bh=DVFj6QBY2VBmTjbdiVLX1sbjSTtMef64olgM/x35Fxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHppEIV2ESnrYc9YHkrQfi7oaOWc7KYE3GlMjMcsSj5mzuva5XwMFVQ0cMzdogVzmETh1n69Mk+XIJ2Al4wqGox5wHOcINYWexCGXJ7zVk8nMCUH8uxm+ZJ8LrYyWsjgDQ9o4qa0KEMmQqIB5BJ7mi9eW5xvmZcJsjUBrvpVceU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kC7JgGxa; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiagG8aYgWbbRO33FVVrk1xuxZstpoc5ZnavmyW7nwESieHcXb8+y8RIp1D0qHDYQ2sCSBY2JlNbdWGHpY1Prb4Nnxli0Cp4j1pTqfXPq54NzCt9yNwjVuHVUyZVyhaFsmoyBpK9QXbwSTDuM+w96370oREcSne7SXsKEUlK+0uxJvMf43aEbrg0S+w9G70/AQUX3DDgV1wOGnRNXzoDbca4W3yrIygUBPROEvv2c1n36D1JKd5PUXH5TMUWZPGDWwDjZJm6E0IuU4212lBiX1NGxznyPUaGsMiOyeWBypJK1ZDsarSA0hEEjYTL2wLQkY4DgRUKq3QsLU/NT1DppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFZwl03VpqQ4DC9XuQPmZII+m0GEGqxP7iIjWevFMhA=;
 b=TI+zmKIgq5G3Wkt7eNxk8CkW1zmJJRlUcUk4zRpey82GqHSgEQqYwjWncPKiJd847WGpPhZnYKQ3RwoCR+KIqalJq+c7zc/DijIPuxyyy2CqQmB+7TdjVwL549E2NRFsFhZbI6Ewb9ixd69nEU28Cm4eqbPWpVkEjsGL470HxN5KJXFHxmpbzZBivNogQ8asNndpMBYupJWU5ADdTUHR/GvGUcIdY/tQAY4QrPVQq5jrfwT02tC82RWBpRJtkKLaR0ifwcbJLbZFNJjMt1EncJDU6WOxavxvFYbnaSgdBAXXIht48+4h+rX0TIfjiJDCAKltiMVZmOb9QJrAi1g6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFZwl03VpqQ4DC9XuQPmZII+m0GEGqxP7iIjWevFMhA=;
 b=kC7JgGxaPvQ+11S3CsLIl1DT3ctVknOgvAsi0O6in8B8r3AtyGQ+xUu2mf4UdUPAT/37gpdGpGiB/yhtIydMpth1wE4IuprChnlo3EGAaPIf+uPeEFzpE4JSevVgVWcOqvNt22172NWr3QPEpysi5NFWELO0MxjfWsaCJcNsvtE=
Received: from PH0PR07CA0049.namprd07.prod.outlook.com (2603:10b6:510:e::24)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 16:11:33 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::1a) by PH0PR07CA0049.outlook.office365.com
 (2603:10b6:510:e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 16:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:31 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v15 17/22] cxl/region: Factor out interleave granularity setup
Date: Mon, 12 May 2025 17:10:50 +0100
Message-ID: <20250512161055.4100442-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: d67573ca-4863-4e19-0b6e-08dd916fa95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSj4F3zsqtS9KkVo9moQIZsMqIeZ+RWJZ1SdaqFalbiXX4b/xqhlvqSD4FAR?=
 =?us-ascii?Q?dDs/yThExRdNhRBwmYb3lAFhT4cW6ya1n3ms7bzy+ZY47d/xwk8F2IuSyJME?=
 =?us-ascii?Q?gXpOY5v2sVotV6MOpe3oVguyKS+FP/GhHj/RW00++pudoGWpI+704tbshvjX?=
 =?us-ascii?Q?ixbnWrVNiAns5anY92DgKRk91JxUDy5VmaYn3S4uVA6XWgIXcOXa5P1MRjWY?=
 =?us-ascii?Q?4NSvk+humPJYMZDlItMX4q7wcl5noHPH8qfPWFtzU5GHkqkI4WSQk+kuGnkQ?=
 =?us-ascii?Q?/eGftzaXB6QuAZECcFqMNsKXKQduhpMsEOL03+1uane8y+DMHnmYbcdkxQJW?=
 =?us-ascii?Q?T/f1TmMfTcmshMW64NwVBoQdKEFTh8u0oVrVD44LDvshqKgn52/+rocWVeQJ?=
 =?us-ascii?Q?0x3VXAAwldgRpoqEq6UIoHQZuN7Q/xnTVrMSCZyImV1hBGTj++k3XTcTgF5y?=
 =?us-ascii?Q?50i94uYet3MkZQ9YjYAjt8eKhfrdsL6sSx7t9Rsd6r3dtMTP+orsPyxOC0bV?=
 =?us-ascii?Q?T3lLQZJZlKSqqLnp/g5aPQUuoWj1omM5Wi46MvrlqHrXbNPpnhQmxpHYHl7V?=
 =?us-ascii?Q?9SOVsrr1c9nIFlIo/f30shP4jQ2TqQ9ev5WDt4CpbeDCOvOEMwW0/b5FP6gi?=
 =?us-ascii?Q?gryR6pT+SHtAfzn4VnAOKjGUQ6YyMHfEFvepl0cmxInH9w2N2M1Jd8uPSwkN?=
 =?us-ascii?Q?UTh8gBsrgAbz5B99Sh1Un6di321d9RuQcg6NMIczkQlIRsRx9fMTvzwErRsM?=
 =?us-ascii?Q?/bmUbzAVDekYQU5Sd1EaObWmymptN7afgfbEZd5Zc47gsXa4n42hB+ww9jx4?=
 =?us-ascii?Q?GEz+pRBK78hSs0ZHOOIaZZM3CaP2Iskyhm2qKY6V5zwsqDe67HDWgZFW/oWq?=
 =?us-ascii?Q?yIIj2pUkxI9zR/QEVtLLCMHC2RO9JuuE7S13NYogrmfKkIK9UUu7fTcgjhfs?=
 =?us-ascii?Q?9pMW9P1MjwvywMdhOxFcHiFlAnxbPfTMnMSf7uD+TevYQC04IHLpkp7n3bgT?=
 =?us-ascii?Q?Ik1S7yGL3PQ7NHaYTdERBQUM6oJV8GmdAF8mLAOHUuBmlAWuy5QZSvSjV2uJ?=
 =?us-ascii?Q?rzjmTHi320QUSklaGpeCjElRgBp2dOgx8aBWqZjKblh/ba1sxWIM7Ysh4BFj?=
 =?us-ascii?Q?Dp0hTaxZkpnB/CMPqL15CN121Zf7Pbos73Y06kClfuOwFWcB7G0tyr623NPr?=
 =?us-ascii?Q?0EvqIdzPTJnGL9n3DEc3yesdvKnXn7jhW58WxxsbHemLj+rdrd7+3ZAG5KcP?=
 =?us-ascii?Q?fBnGEcxg7tIvJ/E18WXLSc1MSRfWDNkpCZCf0Ba3Nsq0MJEbyCyH84J7Q9bo?=
 =?us-ascii?Q?2HbBYMUiDhbWszkDy3CPFNj3WeXM1rReulX8qhlgrG8sB1h86t5ets/OTm3M?=
 =?us-ascii?Q?qazoFX/W16XQ4YXWY6ySXTObZNLD+q1d7/YzyFxxZtMWPPtoC6h5fZuw8i6u?=
 =?us-ascii?Q?1Acfq9KepLWj2vv8Xi//OAbQWMtU2aBKIaqbY/d9dnUfUI25ABn7/h7jPMkG?=
 =?us-ascii?Q?ylVZOXnlwOJVUUJyOnoZNSrRl/nvT098kC4m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:32.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67573ca-4863-4e19-0b6e-08dd916fa95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

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
index d97c4a6a67cb..5fd45a879af0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -539,21 +539,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
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
@@ -569,16 +562,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
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


