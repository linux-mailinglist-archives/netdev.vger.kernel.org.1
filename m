Return-Path: <netdev+bounces-150352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E19E9E9C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF1163D21
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C21A0BD7;
	Mon,  9 Dec 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcfjBt7L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961921A0BC0;
	Mon,  9 Dec 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770515; cv=fail; b=QD1S4YA0D0wQV7kZEXE4wDcnhhLm+NlasjlFGAyJwnWSNHeJJnuZsxsPhvip8sFBlN1yYEV6wB88az6RV9SZWXFXLnW2fxEwlfVc8RNtSkX5+Vw7Ao/0WYvWAXGdT7cqPwT6LLOSVcwrYBbexIK9mk35R4hyQIpih4DAQtFUFG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770515; c=relaxed/simple;
	bh=X+N0vlP8bchBEZykyGpNShiHxI3OlxsbH1W4wxH2oJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQeGulqmcLbZNdyndT9Oh7LOrl+1cGX1cXApN/hhontUg4Wyc8hPoJHu/KavY3cE6mq0EsCqJDH20KnrdXx1FZWN/trzQhVLGg7nx6K9ihpGvdU3EfWi1q6hVaiJqIWYuK0zkF96K6GEqJLGrbrjtoT0uyYH2Uv6Xhyef2LFNak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcfjBt7L; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn5C41FPkVnlcz4niZNahNLdABbcNyD4idr0sfgJyDsNwS9M77uUfuxV2kzSpoDGtAbWIffAMl+YK9o9x4+sWM9fqMJL/3F/bhoP8KPxA+ETaDl+aXw/BTKSzgIS0SRxVMJFoF1BfLVrv8nbFqRGlcwHTc+SPSkhfr4cx6SGyP9SuGmKKTT7GPAZJ8d5FUb1/MXJn8dnG4F5Sy/S35nZr8RnYyAYo1mZZ49EzLUk+kn4Mgh3Q5Na2mRXU66w3D6Wn2EwYY7HHss7JELzK3msuA2OS5Dap4a9Ah4hF6LCO5cOJ/4rb4V9b7utdCPvG/zqnzELi6vpBPBu2deWh4UUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbSboHdFXbwFnne9JuVdxoW0rejfNBJR/+ua2UIunOg=;
 b=NfiD2IW/E/8PeZniH9+H3evyqbQE94q4cZfMTeGITPHl4iVE0AR6xnc6Lz5fsg+UY4RUD3uzpVUYfP+MdVGcC4v8zP7oA8ujxtrckthRCJEcf0bAry9Vx8wMBy38v36q3ghV1LIXSGW4kRtAJ7g00RkyaL+9JYyWVFuy8khLiazKWUXXxW16ZISNjE1IckpYIACBDmBsj7+ux8Pgg/dv95elD/oUrATBgt7YSVuRdPzd8LtomL3LFAqsEkaYXZubSgJVWQYrCxDyh7uzqcJUQ5HQuZm+2vYeWKao9hmPNPulPhfbgw9D0X8/ekYvSauSeFhsqbD8UJID0XS+kXl6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbSboHdFXbwFnne9JuVdxoW0rejfNBJR/+ua2UIunOg=;
 b=gcfjBt7LzJXTeKyqEahMf6SMLHHHc1CEKGJyuRpa/KUCZnduoDCombRa2zwnNn8/uoaE/hOCm4jIh4kls6G2cjhxBMQWVMt6bwNc9oEYI5CKW3nQnWtwQgepEjettldeRcJjyswBbkuSZ9YexI1CwrfdeQFZP6Q+QRLJ6o49Ais=
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 18:55:10 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::1d) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:07 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 21/28] cxl/region: factor out interleave granularity setup
Date: Mon, 9 Dec 2024 18:54:22 +0000
Message-ID: <20241209185429.54054-22-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: ca647e88-315d-4576-9527-08dd1883016e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UbMD/9i+XnJ4M6bdN2DBEsTYcF67YPwUzf55Vc0cs2gc5IYnXGWwfHKcB63T?=
 =?us-ascii?Q?sqNBN+6BHNPF44I7TPYK2Oi+oo/ArBw65S5UvV714uWnosavGtvA2f1IXMOx?=
 =?us-ascii?Q?D5huFE0t9OwImV4iee1uPkw+B5U7eRIWW0w/3AZc1gCgosW13YsGhTlO2oBp?=
 =?us-ascii?Q?l7HGbgkwx+vKI2wVGOJXQMmmQzfQvFA/uF5acDr+a3L+frtziXDR49pN/Ywb?=
 =?us-ascii?Q?Wv2wJQfVmYi9FBCbw8eWjYQ/wc2xQ5PnPGtR3p1G2IUNipsXgoBi4tGzISVy?=
 =?us-ascii?Q?aI4gpJejUCJ+VAhDtayF6Fj8xbvfI0S1fvVQFJuoodDK2JGl+BrfrYx0cHnh?=
 =?us-ascii?Q?2oZF01rlSrBDxr6CttVXIodgRWaSeGzZ2s3ioqeuyIezenmcdXYsAF+I+J3Z?=
 =?us-ascii?Q?N51YiUJlwWxy+h4g+upLRZ77q4vEmm1kC9lILkEjrCzIeOfwePUNCxkXvoWJ?=
 =?us-ascii?Q?dtkBgXJHlG2iParQ1AM6O9wPArFR8YRJluei9Cz98glWpHcIRWBumg5ARjFF?=
 =?us-ascii?Q?JK/CUs5ouFGR3XcyfCCeEHxJhmmDzfGyOiRjkqp/VA+cokfhZ3cSf1kvsh9e?=
 =?us-ascii?Q?1g/ZbWcY+isSb+cf1FI3mmVQ8g9mrm4smE3eqiXoiLkNjDoqHyQD2+ZKvie4?=
 =?us-ascii?Q?yiAPGb1x595Y4DoJYTARWYc2fnhkVhMLpR18VtEKdT0S6m5nkKOty0M0JvEd?=
 =?us-ascii?Q?QmpkNjMX0jqQy7WEE4EtZCma3Y67Yeq2rzVdsmp5jgsqR/GonRy8UmufWOAA?=
 =?us-ascii?Q?wWd4ki3DJe5noMd9n68yeUhLxSGo7L3zjAy/Raa2ppj0mQjeduIjvqyJqAus?=
 =?us-ascii?Q?y+J7y/QJuSXPAZvdSlCohH61VR3BAFb0Ms62OHiF7RPE2nfVOf3z7mMccKaa?=
 =?us-ascii?Q?mgHXevis6D77vU7xYrgzZV8ph8aRN/TSiWu9p9Dw8K1ueKmv1Nlq1mjW+y2+?=
 =?us-ascii?Q?GX9f/JMunuU14bjdXsdg1fHQmx9f3ZM/I+qfVJgi1kr5v29SKkpKFuJrqicQ?=
 =?us-ascii?Q?fJne5SjpWsPQX7Nsnoymo98+E9FCRZmPc/gidJwrYnMZiVFLsV5m+nOxEtr1?=
 =?us-ascii?Q?yhb7z5N9s78Fi4v/MeJ/WV/v1QLTD692ieoFUGxvcFCTRxgcEdOWZLFNbwW8?=
 =?us-ascii?Q?PAXvLu5CNtwdibITHkWQWHJqoXjPTe4jAPC9Au3ybVTawLHztiB4TYiq52w2?=
 =?us-ascii?Q?QGEtMpyqnM0Qm4e3fzji8X8SvZcTn89AObpAXIb64b/uXEQe2mhfegyH3CXy?=
 =?us-ascii?Q?e+1VrdPMfHHbbNIXfEYZXtYe++rF6jBpSraeVrDYAsT3vBTC/3jh7x7a1Seh?=
 =?us-ascii?Q?7weS9AEc4J/uTZVavOmMbVPR17xYDxv/9c4NYApFbXrVBSaHydIdgfLUVoiC?=
 =?us-ascii?Q?F6V/xgpp1+JQLzjSF0bIw7Ownv9pc6mb3D7h0Pmh8s+tKjG6+iokqC3/SAyw?=
 =?us-ascii?Q?VCHnvVQ+IfZJIq/ZihHGHcI1V/Buckha0FcDvApD8j7Fw4/u4/9+iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:09.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca647e88-315d-4576-9527-08dd1883016e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6725ad271df4..5379f0f08700 100644
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
2.17.1


