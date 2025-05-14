Return-Path: <netdev+bounces-190430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51ADAB6CAC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9FE4C2461
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA827F18C;
	Wed, 14 May 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aXfRzDtV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B027E7EF;
	Wed, 14 May 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229305; cv=fail; b=PzyEKi0v8R83Vd+rsjdOXN+FMukwUCFDTu+6tZTFjRgU99ceWCxNiLaCJJfKxs0MrrP6lmfSbzUhvFnmvr5uW0dFOEaG7qd2A7XvUGREXz82edZkWjHLAhSdGqWQh10bTntKAwdx3lzypMoxAkz2ik+ng7RePizcUsaTHY2Kipg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229305; c=relaxed/simple;
	bh=tFkraHrTeDcX8jukOfcmoJHLxyVqTX2Crs8knJ16g8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNzsrHWJE4MCZyrZiEZJku0ibghXX+IKFpLr71Tu5uInrLtzch/3wgELqvjca5g6AN9TjQ5hCENvaFIReB7wEAHA7wplRxF33K3q36Sap6Ttlw2A7OxxRgxwMLtcJyCYehhKEzds5VUylR4CgLc4RCLVnFOJ/r1YOuTgtLtSknc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aXfRzDtV; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVBrfkfYuXTu56A2oV1ykB3IrZ9j3rzefWK8ydcpWD5m2fp/EKAoDljZiX0JA+q29f2PzbY9gm4K08cSRaR7mCNzUL0rU3vG1OIfwJ+r9Ma334WJXmi5MjNpxMNuifhaesDkH5+udJTqw1rUWhnK5yEFpczjGf1TWWDciku6YCVVuG7AZ9kvzd9m7iGD9riAgUSk2w/hzmRVsKndthrvUr2KKhrmAPbbzc/Uc36KA0mqy//XjqSbLVpppNIFDJXRySEIX7DpKySNWj/tSPx2OC19oI+hBpThyziTe02W7x6YmTQCXZauQOxOzH5Y9U7F3mHXYut8VcmYF3lLK7/lBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7S6YReqPTYpf+o2BRl1ax5G+FuTtmiar2P7yDfiMIA=;
 b=ReoAIFcXFGdCLOmxkis8jB33tjXrDvBW25J15mijqcC2EUZzj7zhi26WFLoAvIF4D1oayscot3E2WRhVInzKxcadKqjNhjfG84mhjgY65d8wb9rjP47VMPHhgiFpqc6YeqZbfKwdi3GWlaTKQdiRbapZI22T6M4gtXVNRnF6xoV6Ojxt5Ryjkc+PK7di1eZTbSOGOSOPIGtKA4wxIjb7L44zqnDrlI/bgd7F1TLoeXD0fzU6OrVaqGY4elcQ8ri2u0C8FG0+r7SOmn0QrD8lP0Wc2ItGQW4uNchAmnK09EcOW8dxn4m1b3x+0ql2Ojmji3ihzPzNpMXazY2CgdpL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7S6YReqPTYpf+o2BRl1ax5G+FuTtmiar2P7yDfiMIA=;
 b=aXfRzDtV2B2QEyUopWHbNB3YZQFdOvRL8iB7imrZBSF+s7y6WIqGXLAx9RS5pRW1z2pw5EuKB1aVLqnrvyiSpO6kKAo+bgIS9qrTTtmtYFmV9hcHjee64OZEMowoeVlvq1QyV/KUeakwzbMG+YVj7F99xNf6OJScSidRD6z4UpY=
Received: from CH2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:610:58::34)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:21 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::8) by CH2PR20CA0024.outlook.office365.com
 (2603:10b6:610:58::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 14 May 2025 13:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:19 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:18 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v16 16/22] cxl/region: Factor out interleave ways setup
Date: Wed, 14 May 2025 14:27:37 +0100
Message-ID: <20250514132743.523469-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f04fed-0f3e-46b3-549d-08dd92eb31a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIyR+gdIWjl5wWFqi+I+8I1okJhx7Jfub7e1oNZ4o3yCSTn6K+PNkaugrOt4?=
 =?us-ascii?Q?GolGmqXAXhpj8R8MvBZW6pzhcz9k1oUUoFjJO6dJz5Xld7sRWawRGAOzC+rZ?=
 =?us-ascii?Q?LzYczeJH7ZW/bg+VBVesAe0bNHHCAEUmKzmBueCzBGogcR9dmExXqGUOv7mX?=
 =?us-ascii?Q?M2XePakXGE8qArKHEulhNvq0LZAIvE0pGYNjOSXrf3eWifJe5TWMT3CmI5og?=
 =?us-ascii?Q?Px5d/7c7YpNyyQOJTGElRh88dKvGkc2CVSTsCw9jp44yoW7y2xENr346T4b/?=
 =?us-ascii?Q?qFO6KNAaVhjjhtCztF4TNsqBUnmALgKcthjwKI2wKoYQqymJm1txEJy8YiiI?=
 =?us-ascii?Q?mDTah5liKk9SduPCZnTp7yVO95sEIG4yp/q81iXrDzS88UoSDGmqr1K52l5s?=
 =?us-ascii?Q?3H/5TUG6k8oWgXKMd5E4qlCk4bdFE4e+sR7HtXqcgVQ7p2vF8Eojq3BJ4YvY?=
 =?us-ascii?Q?xTZj7T/1UZZqs0ts4ozAsU2tihIIlK4av4lUQWA4Tj++6LJ05oLOjdy+wgnU?=
 =?us-ascii?Q?4mau1VAGDa63ELWhhzbDfQrZFtixdHedFGee2bMYTZQrCHe7L0c4gjQLarCz?=
 =?us-ascii?Q?RXWTJTzUqgWznbOwX5J7MiRhgUf6SsWY3cSiTz+0DU9Gac+ztcTW3xduR1Qe?=
 =?us-ascii?Q?DcdVu4Do9mBmngU+7/N/4Nf+eNxqPvQikOUO4I09w5Hxl7i7t0D7GbQ1Pwfn?=
 =?us-ascii?Q?ZshYE0Jw6cx2Bd2Ay2SdAJpeKQRwYjtoJODPn13xWCF88YTwKogcVxBFoCEd?=
 =?us-ascii?Q?hQCYZGcHm+zIJ3CQYkhXDnbT/CpiVJzCu/5EcQ+XZzbhYMoSMLEQkEVAZ0bI?=
 =?us-ascii?Q?ns2osSYkYSjueSoIA/mhFi/FD9/PtgFNpZ8eEzQI0FTOq+c/0rW3Pj74jrgB?=
 =?us-ascii?Q?OUEKA0Ibp6O1R0etyAgPbm+C4k99aO5016k+Sbdyan8qFZ5vwekwpGtFtkh9?=
 =?us-ascii?Q?Xpb3rwjgD7MkU7cbEOqexPv73zLGLQ8Nl9J0NwD5e10v3yDof3eKvAcBNS6r?=
 =?us-ascii?Q?v4jYD8hUpHMW9BwUmPJvvE37bYMpCQDuOtEU8GsIQuszU09JwZOwIC3u4blg?=
 =?us-ascii?Q?kzuwmcRJGP5B3ZhAFb2HDyhnZi/2UpVDmPrb/G1R24pJqje8D8vrIKqv4T1y?=
 =?us-ascii?Q?JeANF7p1tZDNRSA9x+5AHRt4NBiqC59/QL8fj70474Ok9pwtLmCfbakpLSZF?=
 =?us-ascii?Q?XShzKb6T9FCA5k0XM+AGrfaOU9kwwHVgkPGidv0Uo4CGeKAZc7uRKCd5bSKa?=
 =?us-ascii?Q?aG4KBn+98zKLPfCYwjtf9N6mDR+PEXDXhnnzSS/CuQKkoCwFpgj/acGDGUi9?=
 =?us-ascii?Q?xjdZ9zocJfo4C2RjstQZimjHtLo1xulaq1CLjoGjW2ucrVfuoUMVLKhJnAEm?=
 =?us-ascii?Q?ByjoDjh/gcA6KGpZnh5NiYt58j81Ku5Zfxhba4LPc1EqeXE2X78W/P+PUGEX?=
 =?us-ascii?Q?JQS7ALHJHW48zh6JEMoAOXhqWTlcVM13CZI+pI1N+WuAvl1vm9eMa8DkEjKH?=
 =?us-ascii?Q?jvc2GHkQt9E9aGcU6dVfC8xLR2SjWYUzV+ha?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:20.3937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f04fed-0f3e-46b3-549d-08dd92eb31a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

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
index e13a812529ff..0f61c9e9b954 100644
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


