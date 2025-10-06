Return-Path: <netdev+bounces-227931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA4BBD96F
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8484349DFF
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386F9225785;
	Mon,  6 Oct 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iAMEKsKJ"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B86220694;
	Mon,  6 Oct 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745047; cv=fail; b=CKjtlY1RETuhu4qwn7UwI2aewmHcKJBXHbNEI54kIBjnpFHRTKqAaYyon1jsMhBiEnU2qMPrdGDO64owNjFpaIxFT+gkOZf7b1yne9yFEiTmFoynkWA7VQ4FU6HtLAX+SL8VPKr5b8yKPkTxqg/dFAm1q2r3DbEYUGN60l/1ICM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745047; c=relaxed/simple;
	bh=GaV5+4GT82EjxA72HvtczSX3WEytsNk8TDhzdmPru+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpvfHrT0Lp3+9lvowJfSPZe78K9VloKtOOXUtbXbf1PvwHd0Z1oCVoYZGwJfwvvfY4tLyv4TEOMCgSg30hawuMvYSdSjsKyfe1jw4i7jWDSHSQjHBkAXLvmvTl0zabr8CR0ef8f9fNdz42jP4Z4TC+gwwFUPLuFzp2CHo2W0hFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iAMEKsKJ; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+euyFz8qRzBcv7vrNxACHLXIHB0YH/5uY/WVwI66zTQhpRwsNYr4JAcn/LmvH/630hS5sslSGybVlEjtsbEGgr1chw9vNWlmJrc7wMAwkiKBXrrjbo/6e14oUdxgFrdwOPGfm+SqXiaDsiE8j7Wa/VqebTV5iH36DDEZmG5jZpMavDGuUULZGlhBrnDp12S7y08t4wzV7doURKi9tmQcWVf4MM8T1wbWMID/RlHhWzDpBTsR3IDvR09y+gDYDy9ob5jmuO8VLwhC5Dy0nGLieN3nEQLRBKFtZVuEY+v3nh+zCcDQUSgG+Rz3VbRtkznfTXOKwEnLb12FGS2ntBKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ap1mwhlaheKx8xsnmYxT6kTTdIOJmmGgloCPrMIZKY=;
 b=DiL6c7ImeyBjrr/lrh10gyVWmMGI7J+IYvGtqViEMR5Y26m2UIo+jnoL+EmIe2uonGiRLwf7/9A4y9GB2HXeDgjd8N2ocCJKWrzBtJ0r4WiQmobo/Mu5/6jcaxuAQNfZH8yMVPuYN/OSpoWSFKyUf3KZRW3z6p0Ez2SMXsdWSDS315hVbVLVT7+bgB9nfykfVPUyVpqz5gq8AE0WeHvuSlp9xQFKG6piTJ3e0Dd39LvCHTHB0RoPUVhDOT0t68lwskyEasP/86xI4WcA9+hlQ3sI0z3GBUF/MFXWEGMvMCBaJ46ugiCfwK8gmpmPNL3A6Md1wK9tsqCoIOYF/+xI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ap1mwhlaheKx8xsnmYxT6kTTdIOJmmGgloCPrMIZKY=;
 b=iAMEKsKJ9rmaipe1sulvgcsApvjRs83b3ez396V7v2XO0eHtqECl0f1xaZKDRKOBB8G+p/Gh1Osk03ScnZnZEKn1tFAmovWV0XJX62UU8xxik8MRDF8HilxmAQqx+aafwth7VkA6cZFVPHGKhTqP4JVEpczt8HBXrHqkIbZbiKs=
Received: from CH2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:610:4c::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:03:56 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::9b) by CH2PR10CA0012.outlook.office365.com
 (2603:10b6:610:4c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:35 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:35 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:33 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v19 17/22] cxl/region: Factor out interleave granularity setup
Date: Mon, 6 Oct 2025 11:01:25 +0100
Message-ID: <20251006100130.2623388-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f560cbb-02e6-46ae-f285-08de04bfa9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQxNF4o09HUG50czo1pfCNQpaD6OuWsPgV83V93GNTtg5l3riXbJRuGZiwsI?=
 =?us-ascii?Q?ToJlttdKrI+YmdxjvzXKs7Z52E9RBT+xFsVDQ6M3N3ZFOra7yNiS/lg+VSmb?=
 =?us-ascii?Q?sBmKo0NHgSixSHnPEwgehy87xfId0kumKzmJdWy2ywNNB3BK/RHLFNbKXLgq?=
 =?us-ascii?Q?AlbPdHU+3Utsinbm6BDFl4A3uGZhuKK9t8yd5hxO3WnlEHv35O/k6QQRmLJo?=
 =?us-ascii?Q?wDvoJvF3qC5gBoRLTA9Rl2Z/PZLlYv0+x1+sZ5O3elc1m7drMYiDS6Sclb/i?=
 =?us-ascii?Q?tTnIm+avBkEgpEAVHWA4Sj1AQZy8yeDZddKvDRJo9jepUcjdpXm/uBu1gMrN?=
 =?us-ascii?Q?z+BgSyx9sIo4qCzotI3a82Vw1R8gn4N7D34+TCMvwUyKg+ARJ+T42r3wleta?=
 =?us-ascii?Q?MtlYR8/kLeOL8g6pgxuOpxQWyd6RrMa2qeWzYFb8yxWy6Eb76hp4W4NmWo2T?=
 =?us-ascii?Q?je3NWMGUzWVUO0DOgZ4NQhvAH/FqqxneLGapHQUCMejgGcIm+Eb4Bow2ncTQ?=
 =?us-ascii?Q?JGO0C6UC3MnwkkJZWWwuhwDA4EzqtnVBt6VKiCTDEC3Ulrn9VP/Ij8ZArort?=
 =?us-ascii?Q?iOv/dVQVmDd+M3eizV0oI1q54Ibslpc0+xgB0rcTCT9w/L7XQlFlM8NfLuiY?=
 =?us-ascii?Q?Dbrnp6YVpEJ/QPff/Hr0YtzkRqrkZqwIqWP40RZ3Rsd96YxcJ6Z0o5oG6sP2?=
 =?us-ascii?Q?PolyND4pOU65prCdZJIVmcXuIRr9Ll5fc9HK/smKm/pAiepYYZvAjNIZEYJf?=
 =?us-ascii?Q?kl3DkoBRscmZn21tlOuRk8aJiYnSkuVx/xMlbA/JVdaTgMCoe1gzQNZGxn08?=
 =?us-ascii?Q?NSp5sc0EqcpRO6ghf7UJAs6sbPGQrY/5FCgGYBJTuZ4CLWXNFx1DrIxQKwlz?=
 =?us-ascii?Q?5dijfk/8ZxqfP5HGpagVjnWnReQ//E/VmEdKSH60uHHUeNEoCpEAy/CoFCMz?=
 =?us-ascii?Q?IEr5d3tKrRL7dBlsTqY0u8ahAo4QcPIOvcDneLW/AGvYzpBpRuCrXU7SuhuO?=
 =?us-ascii?Q?Tw7zHRwRBC93eUaakyuKMv6yHmaqYc8mkM0jLZbKaS7GzMm5kCJXlpLPSQbs?=
 =?us-ascii?Q?Lp8ldyfy6abRTn3DUJUnCCbF2yQuPFAZozZinn+Pu6VVFBvqUyeW+hZsXJ+H?=
 =?us-ascii?Q?+xWhMntrmsBEEigK1m4wEYGoqcM++Ugjzhg904u/xnbWtIxu7pOL6CvlL8sg?=
 =?us-ascii?Q?a9NizmM55bouGVEaB+mQGCsgAymqgMQKhrSfiAHwdNnpwW/UYK/I3HyzE8xZ?=
 =?us-ascii?Q?OMXJhYLkxt+Zqr9GbrJEWV1vlREjjDO1W0c/fBTs5rfe1ogz8t5rBmKRnbgb?=
 =?us-ascii?Q?zerEHa8t9NohEg9WDp7fVDJ0R05c1TH8UreGsTBxBrVug7rFAmAay77IvahA?=
 =?us-ascii?Q?Fxu7pD/ayC8xCaSO3XV8XMiVLC75lkj773M9d8x6FxgV0WkFarkffs/5sAEE?=
 =?us-ascii?Q?ODwm8TEP2BcnAyHaH8ERzFuY/YZZ4S5eooZ7SE8CdOSawVKpkOdFL57CNn4A?=
 =?us-ascii?Q?ko0nQNht4zAw5VXQVf1yGYi2+QnfWCXtqjhLFSRl4oOG8D74MdahaOvKxN+M?=
 =?us-ascii?Q?O4tgAL8GQN9aSjmG4Yw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:56.6241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f560cbb-02e6-46ae-f285-08de04bfa9c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

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
index 005a9c975020..26dfc15e57cd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -557,21 +557,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
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
@@ -587,14 +580,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
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


