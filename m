Return-Path: <netdev+bounces-136680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083C9A29DD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95775B2A62F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC101F7096;
	Thu, 17 Oct 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="er4vurph"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148581F584B;
	Thu, 17 Oct 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184031; cv=fail; b=VdmS6jRyLirBmRAS9sn2MiYZwbgwJdnyYj1MkVSFQ6BN7IQ4COZI2PPn7jFAqccavr47cgVBuFRr1eg/cTg15ywG7LKqwTXcOvCLfPjg9yFobpPIaQwyWrKc/MzIiZRhIe0geZ12Cu0d1k+g4dkVuahUthWtMqr4cJvxaQT2CaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184031; c=relaxed/simple;
	bh=8vM5VpB18hkW6OravpFQzAfR4Qb44dsogb8LKBkuddw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXSOF6c8ylSbUbrCBnUlqSHj8r+unPYSgTfZa1SiG6RQE1foRMA0snQmqtFnYrrsHSTftbQxkFtI/ietBgjeqsfudw4Vag1LfXEJ6vd8ckxW5ZcirQgmmTZB7Ww9ORw4/KEdep3Mt3Shb5Cu8X2W0QtboAf0Knv64LafEDZ0KWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=er4vurph; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYgfDerEDBclQCwSjdX9N842aybJpYTSqRu+xNIcPZ7lECzPAQiL5fOUORJ9PvPAYkYxqisJSI3RoC2myO+YWUC1ULewdPEK6Gi5a/d2xzpQ4M1xJUxjtZnhRSVqd+NGxHFsK0+AKf74zL8Mi2weM7CTofhd9LKRN/XiPT60ZTNggwzvkbNJDGBLwhN2Dt99Xtz1ISRxkUpSe4BIzWy/aaxhPwASwdy22rlWvwA1DhAnu6wg6I3OLB1xclZyW9vvigsYQpENphsjKSQyTm/Aa2DMR6fNqHRY/86hzq4VdHWmNKNHqIXemq0YRqMpUM6heiEN4Yz9drLNSVTLipmbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l//icrCu7LhWsVrD6OjS2cFsu8bUGAodFWVrjIn1cZA=;
 b=Rr7eqfYkZr/sgbt56SFYcOIIfa9V8OWPjIO1S7FzOZCG+xsuss9hAAPz0OAisbY02hl1itXPFEVgMp9js5Xawn7cUNBB70YSDK72Eu6WACFFTe/ORMwrTZdbb1uqtWuMQcr28hNp6By9qTL/hi9HEGVGvcoIyVXfPUktlhojzFbH7718jUWxEeW8JjA1jEILwZE+FQSaRJbyqPVITyULZ8rfkpYILU5nYhmEebW3QnFwn+VxX0i1qL4yMmEk5IiliJ4esikKVnH88YQm8I5c2nLcpuqPNJmCbvRXWA4E+K+5OvSJfskMo5Vn+PGoR+P7suX7Z9Ga/vAU79GGvYCIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l//icrCu7LhWsVrD6OjS2cFsu8bUGAodFWVrjIn1cZA=;
 b=er4vurphzTxS6PTnIU2WSTImN9pMts/LE18LVNMIo49UA7gDGJFt0rGS/jSFhsNEi3dqlGaRRSLvNqd+WX+Xl8VqmqIEJ7FAsoFxgzM/40CTEOqIvqGZXUVwrBgyVEVOssU/MRpTLgfF23VGhm7bgZM/QEdfB6adAFADTY8s5Zk=
Received: from SN7PR04CA0107.namprd04.prod.outlook.com (2603:10b6:806:122::22)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:43 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::1d) by SN7PR04CA0107.outlook.office365.com
 (2603:10b6:806:122::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:41 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:39 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 20/26] cxl/region: factor out interleave ways setup
Date: Thu, 17 Oct 2024 17:52:19 +0100
Message-ID: <20241017165225.21206-21-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1709d2-75f4-41bb-d6e9-08dceecc4179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHiXkF7FwZuJ4CtDih5KfBD3v5yu7mBidtXZZydaNF/HRrmEGT35aR660hOb?=
 =?us-ascii?Q?b6VuP/sMVe85mP2zmARrQzDKtSaDDoMFcy3eZQEj6ZLJF/3y1y/MkwO9TEgx?=
 =?us-ascii?Q?DL+wCunV5UEQ08Ad4e/xkHURjG5ZgoDxr2acrzEKFrhJa9+7Umr6ViaythcB?=
 =?us-ascii?Q?8EQIwDlyuNVuUs8fNqSuFGqOKrq1oXtjTI6zI+omLa79HwMugikq+9ixTZVg?=
 =?us-ascii?Q?ZNsDZJS48TpE/PFX7fyPeNX6M+5LTVmxsnCaqz4q5icy2DUfF6JxIWCF2NtB?=
 =?us-ascii?Q?yYbY9BfmEPlxt/89WtL6/9xSTl15A7wVRHmrJhvT5yOlYGWNvEQuyNcATIJf?=
 =?us-ascii?Q?iEUR0Va/56ttAFHZ8s0W3fAIiwSoxs6/lqgKDwEJGh/oqCe4xubXwrkKO5NZ?=
 =?us-ascii?Q?zpbNJSJxvKcVaHJnHqORITwuIugZzI6tyOZKXm3B4fk8ieV3ssfwyzeRVYVS?=
 =?us-ascii?Q?g4rPS231J6Haybx8afugyoYbq0f47UCS+Vs6OXFad5JzRt4AonnvnANuYZtE?=
 =?us-ascii?Q?TQWR4GIRquJgxww0+ZEaCkGpxlACZ8pD6d1zzSnfzPP4HRbP0MtldrEc6pFu?=
 =?us-ascii?Q?UvCSoJiz2mCPKUtiVylDYlf1lxFBaXj+UAegPoMJPG0XpubudPG4ikEEswZT?=
 =?us-ascii?Q?GbuDXn37JWlFArkJrWoireKknd6TNZZwJiqiRWrdrfWtbpNG2Zdku1rYQJkt?=
 =?us-ascii?Q?Df5HQ/EmSKpqZ7ojq7zfz3IW9ycjVWGR1vXfO0pkKqLHkTZ85ZsYbsFEtQIs?=
 =?us-ascii?Q?emQYHHmNr/lrF7zSMF7wu8/Xj81ZzX5EIxEiKOpcQYKPKTdP+ES0nlYczDvx?=
 =?us-ascii?Q?lLoPQVwAQY8hrVtJ3nd1E2f2mTx4GSD6lvPp1ZwRLHz1jeBad+7vUPOOXtKz?=
 =?us-ascii?Q?XjQ5ct3JTEZ2FZMleYp5lhhA6og1er9qrby2icqL8+Dc+0/kOiua1F26s2V0?=
 =?us-ascii?Q?Oi8GgD6gctRu7fPViRScX7VRWTl9WOj2fEK7VJ8pox+KV79ptJZFVmDbQ/a4?=
 =?us-ascii?Q?X2/aysoVqYGh8PZ95hCk6aCQdqNtEOskMhFaFoIR8Dtx9ZrXlYK+F6bmyXmd?=
 =?us-ascii?Q?4r1W0zrPgYb/OBigHsZw4DeB/dPHwH84vOsU02ImPLg6ycr1hx1HuUBoCSSd?=
 =?us-ascii?Q?/sfBB+kNNQCy0OL1TQ1VPxCkbD97l3DJI2evSvkKN7nbli+tLrJZKbKXhdtl?=
 =?us-ascii?Q?Ai5lbYpYVy12QT5f2+JAiIf0ksYy9JuI36d/JbGfUIQ0hGrIk3sS0Dp9X2YK?=
 =?us-ascii?Q?rMVtkHQGgAYAntul5k4hapXUecAflNr4U/iiYbPYRkrSN5AhWmv5V6v2VWp8?=
 =?us-ascii?Q?Ym54xH2M75yjrMPzToFM14NOhPksqP2e4Gymx0bgEYjSsviq2y9Tqz8PVVGS?=
 =?us-ascii?Q?oYVDbHPVJmqaum6bFhZrmXYLDTvmLULZ4UQYGv9uDOS217BPiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:41.8073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1709d2-75f4-41bb-d6e9-08dceecc4179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c0a40fa1b10..ad5818fbdeb6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -480,22 +480,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -510,20 +502,36 @@ static ssize_t interleave_ways_store(struct device *dev,
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


