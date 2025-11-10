Return-Path: <netdev+bounces-237241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9AC47A07
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E234E3AC5AA
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F0315D4F;
	Mon, 10 Nov 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wj/iwWft"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFD314D21;
	Mon, 10 Nov 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789060; cv=fail; b=hdOh1Y0sZVm1n1XOGXzxhZ/Llj4Yt7SMiZb41A7HjqSuC77/9oNoXU57B5Xc+4pFBUrilaZAbfhjydfGoPj5wbnYaIJV6gmNqDcHshQorPoq2srXunMM759zncfw1GVmgkdy+2nQiQdeO6lWptL2COBlU4d/gJS1zrHAXhPzZ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789060; c=relaxed/simple;
	bh=dmc1wIDBB5TyV9e2UM7g2UjaRc+XcAMHXPvE2B8cCzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKCAt8s78WI0NDjLtFqMinsw9y4ox28V3b8NZLjMS3QnkEZo8t6Caq09C2d6YOqE2HqtHzhvMCrnQMNFQU6dd/sDRsEm87YbeWNM6yaF/14MxKqDe2ncJ272LosDVvrYjDL2boORJJjH7h/Y+FF0NhC79J0mPzskJAy6bB3YFlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wj/iwWft; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnCdNVxt1UMEUA5ScabdozcFJ/trZZEVWULpsWxgFuHq0BUbEiqLjkb8f19Uw/h1DePSW6pDrZAmQXm7JbK2mmuEAl3vapwf2lzsNNqoeRYfy6ZafjI/aBuihHy5SxWbFHfk3DHjvgJTtVD4sORvvqhF4I+D+gWBSKMM10jKtrPwtUMqXGmrTTkP1vQXV7YIlICy/q9IMmi111p/owNAlMGpnx1TyOM5TeGm9hrClrIyJ8KEQxHPpR0pxfFdYZ4fYzH6wYlTrSbXSWaoQoXQ4/MoDq7urwA8iZbvsFUZVFyUou878Fiy0ctHVUsa0F3xu9W9b9mhR3ICYa8smkajQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/LvcczzolGJB/+S72HGvVCpL4nPG9YGNksAX+MrHHE=;
 b=xvw7UC+0Jleb0dhfN+gNOrYGxKcIyQibF1PsCNjc1dL3It/OVoLjtLwr1KmmCJypqdlhDQDvI9+aUALHZplLu91Z6tUxtzl0M9IiZ2BoBRkEMHjiPdX0W9NCvJptS9IVwfY/oLzgZKnOE+9MZs8zhbCKE7dF/Rpb+IyZ7rKl0cym5Q7kEF/S5XFyilzjsyfcP5txgpxXptVArsWJBkCeHyRtdB1WoAuwcdIjYbP8MreboKgLE6kXQlu7NzfKp9PBJ8c6cPwdULgWhVKeSLGE3D1CjhbR233QZdlF6etMe3iEnx8RIpRSphX1VLZVnx6x3BzbrMgZboVWWwih1wm5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/LvcczzolGJB/+S72HGvVCpL4nPG9YGNksAX+MrHHE=;
 b=Wj/iwWftcFrc+sXt7AYKO7wVkTS03KBySvvkwf1GSQDX3RKTlwNqJNssLR+VS+c5PUXKk1eiaZb50l3CdQ9MB1+kGy+1gIaHODWknXxIa+2aEAuE/79br3/kIt9Ai5hMkRWeHKpyOqVnAMAlwtVCjKiZ0vNubvDNRN54vcsn57o=
Received: from BL1P223CA0040.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::13)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:34 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:5b6:cafe::81) by BL1P223CA0040.outlook.office365.com
 (2603:10b6:208:5b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:33 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:33 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:31 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v20 17/22] cxl/region: Factor out interleave granularity setup
Date: Mon, 10 Nov 2025 15:36:52 +0000
Message-ID: <20251110153657.2706192-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b62d031-0104-48b8-bd3d-08de206f1161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z3VvnRFPWV2ABgL0qsGe6GIIGTKJAs9bxvraaXtNLO8IpkPwTRSKakutk5Iv?=
 =?us-ascii?Q?fzxZzbiVLRFkuWED3N6u8PfsmJ1uMb6RYuvWLyr2y9FsZBFfUV7lR8sBZ1cB?=
 =?us-ascii?Q?w9YnuHzUjxXT2QUe/N6/6YgpRTloJRaiOnwdwRH3BaQGHoXXfLXPofskL98d?=
 =?us-ascii?Q?yxCyf8YpcWDRQBsGHRipom0ka+/bN/mXPugG3iyGRe+f2mw82xsL+wIP97Q3?=
 =?us-ascii?Q?UjwHCxT28wz0tbhrrrYoGUsttX0tThkMizNdCWplNeW7bS4oAi2xOJte7CN8?=
 =?us-ascii?Q?pxp5y2jCYJjkfpK8O9NjMd5cgOHjEzVA9pu4c/K4U42SYLOTCvECIXVcLtaT?=
 =?us-ascii?Q?985ArbCK2WEB5xW5jBWw15k8Rn1jL31v7sw/hesIkAhDSSvcF/sJAJcCpq5Y?=
 =?us-ascii?Q?tsLL4NrX6k13k19tTlRWbjunAeuGc2Y9xz2rgYiv73g4h16BejwWTkpIW8ve?=
 =?us-ascii?Q?kRGNXURbfsK3ylZ/b462ltZHRpGRl00pgYB0NC/SyU8WdR5VAvltZIj2EDyn?=
 =?us-ascii?Q?HINBVAc7QwwnucTrJNH2jUCP+B4pD9FiRWWFZcMES6lSkKjMkhJ6dUlhCGo9?=
 =?us-ascii?Q?ej/28Tj+v+NSZYwtEH3fRpwNyURPjynsqcnLncqv8jNjiymJPwGZNjHutTR8?=
 =?us-ascii?Q?kFnuE1GJNEfnHxui1Cai9bZeoQrEG54sAAzigwY+q87/U0WRSWvKkbhhlKgT?=
 =?us-ascii?Q?zlHViERRmBV0rk35pjrBs7NcfRXkBd+SSWEvZkb5py6SGR5IMllvxe8XM3Iq?=
 =?us-ascii?Q?aR23Nnc+8tz3ObbO0IdO5qGDf8SoRaA5D7dYrJREt0/3WW3m2gY4V9JFBTev?=
 =?us-ascii?Q?qP1ElTg64noFVYKb/0zZZLVypBZHg9rbUE5g8IjDMCEpqDDa75DOqkMFBjXl?=
 =?us-ascii?Q?8ff/86yjOsPhOU/p8TEbsJz5q44j1Wnw7NvQwwXRWhhvrzxJbCTvvkCKwQVm?=
 =?us-ascii?Q?eoUfAobfSjhmlt2twkoO9Zct4yQicGeoiVZg3vNvzz4aZdy4OwMApJZJzvop?=
 =?us-ascii?Q?H34QUijI4DaT0Q8p53CNGC7G9/LH7jLhkK76W+p5lT1nSyGzt9LL8LvAogei?=
 =?us-ascii?Q?DdYHAAOW/X9yW3XXZLRUIuU9i7sEg77bTMtIiBk3uG6ERfk/6iWFqw6p6m6a?=
 =?us-ascii?Q?xnV+V6KpOZNwJYydnQrYiPChQ9pj/uhR4dw12Uu0NgQSU8Q3sQgLYNf1tC9h?=
 =?us-ascii?Q?sVQQrzMfQf2MqP2SHbDgzkqE+zSqeUUP4RgGhzqfShV5W8ty/jas6/1A1wvQ?=
 =?us-ascii?Q?4SNhk5cz/Gkb8MzrCGTnEs+Pq3xlw92mS4srb6JYApiLEkhlGnV+c11i7MgT?=
 =?us-ascii?Q?ehqG8A345DQMHou4wbg6ulQxUPMEyDIg8mso9JuxCbQQ7L8LSVfHGOTXkXnj?=
 =?us-ascii?Q?TO9SHWBZmQH8pl10MmcalO8/lrlgPlMvvAf1rFFJuddU5NuBaNBshT6PFY3O?=
 =?us-ascii?Q?NQjx5emorNjK3oYCL3V8fMW6zQ5NgQdTGqju/joV/+nxB5jgVcLHAa55Q8+K?=
 =?us-ascii?Q?gmaHZY3ENfUaaqmGyCnE5nvCYlJpLGh6M0MEsUk1lCfByO95FCPe8ITwdgnN?=
 =?us-ascii?Q?tJ+Mr2ZsSUnr1JtOvFY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:33.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b62d031-0104-48b8-bd3d-08de206f1161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1d26a842c99d..2424d1b35cee 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -565,21 +565,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
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
@@ -595,14 +588,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
-
+	lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
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
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1


