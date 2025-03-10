Return-Path: <netdev+bounces-173669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7192A5A58D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DD31892787
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024041E1025;
	Mon, 10 Mar 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFNztWGD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A091E0E14;
	Mon, 10 Mar 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640661; cv=fail; b=jrWdlAFlzZdq1uF1rtbUJVCUyVVvPnWbu7URlBrnSbR9EMBdkRoZvYaQVhtiLhbbU6JH9qsj2C1IrB1zb2Z9vnOeQRKKz3PiuFVG9Vih1MtdKsuNL1/iwTABJ1oygV6HPjrMfegBxIOws1bs2r1IFhRAe2P0cH6um8+EdnAmbNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640661; c=relaxed/simple;
	bh=CTmD6N9zxwEldQS87x69cNrlfSkey+tiPh3Vslm79MQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksNUMo9vnQhvGKfJx5r7pUyGlSB8hfVKjPVDv9Uk16TBpNEYQiLLueraiqa0bam4xeFp2+gJTWKMQJzuvweA2VSy8Zs2lR+JZ+9DLSTAm3zmjzmFM4kVF8Vc2m7A4sXpurn6lndrDQIUdCq0NvWboctOIVJSI3IvsTkxYDurnL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFNztWGD; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQqY9CIZOmMkZzY+Fl80CWpeY4uk12x4irAYvKtKOTCeQBbumX7WV4pPIVP1Dp4NHSWfyh0HOVqJxZfaVIBCmEZ0zSiUAnLPCGh+LvPGkgoCJJ37tc8cE5gMnUnvV0QK8HyEIsXjQbKEMy9dw6GyIQrYf4PT6Idq5OGgwvkg+kTwKqk/5CE9wzqd4BJc70lVGdExRRzqrrOrtRz08di4qIGr5QuuiFd40qZhJxEY5MUfZQRB0SkTVepLfBbzas9hzDVMp04FKDVBu5l/u5L4Y9JO23E3G6QHUpvdqeeTxRhDcif2I9HupH1bbujSw8SabSzDq9yD0tr/k+sCLZECHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/CT7tgjfohLC8XcL6C/zbR7DwlNt0nwdcVO0HZiwPE=;
 b=om1iHi+g2C1Y1RZPDAu5qy/VDYoBu0tC+UdUiejn+ldYjYoP5wDTXtTWSO+2pGzxdbBhZYw4qgZ1nQkHDtsFrldCrJi9jshPnJpzbNzLkLnlznEk/5e+xhim+ZuB3Jd4JmquBR4zgphXJpoiOO3R2Mpz0RYgtqIZkNWDnh79Uk+xI3K8oTvlMrBM42bQ/kz90dUMo5D9ZzTexlTwAVz00DbOnUZ33pY/KDnOn4YXQy37gMV2UR3TBD9R8ojlH8DvJXonLVEZMsm1CD8SgVbDoiS3I9CxjkQU0/LeSZSZ0QTpXqnagDbVm6OPBnJL8gDiFesnHu6SuRR0haqflF6/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/CT7tgjfohLC8XcL6C/zbR7DwlNt0nwdcVO0HZiwPE=;
 b=hFNztWGDOuVHlw2Zl8Ag0lW0YH1U9fcccP22BgArqi28mDk6qzZh2zz3nhC0LordDH40rYsBsAoFRvsxT6P8ECl20Ww/BiWL5s0CPOvOweaeUBjC/JRBzJm76PVXkEodaCamX4RsdOQsO/i9Z1ol/Ft62oUE7dDrQV+JSM5ZO8k=
Received: from CH2PR20CA0028.namprd20.prod.outlook.com (2603:10b6:610:58::38)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:14 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::d) by CH2PR20CA0028.outlook.office365.com
 (2603:10b6:610:58::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:13 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:12 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 16/23] cxl/region: factor out interleave ways setup
Date: Mon, 10 Mar 2025 21:03:33 +0000
Message-ID: <20250310210340.3234884-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f4abba-70b8-4eb0-ad35-08dd60171d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yd4ymUN1Neq/oEBT2n+ru/hshdyVvmYM0EpXlrwrdB4B56VYUlhjGPuYQwI2?=
 =?us-ascii?Q?KiD4GEpbkDAm4TlfcIdpbV1zz0O+10tb1AVnWxZrx9ucDhszGvgoVOhjQhor?=
 =?us-ascii?Q?d0TiyJM0Z4FI+33dVDueAHacbm56ivPaILJfTQauLj2VmTwXVfRM17PhTmSJ?=
 =?us-ascii?Q?6vvYksx36TL8djNhANVQ6BfnkwhuECPRivj1b1m8dEzqvxxLA51D+s2V9Y85?=
 =?us-ascii?Q?9wNFXqM2skomeOkmQLrEpWKPUT1FjJhkeNIMFrFv9290y9MzV57g18mA1l1Z?=
 =?us-ascii?Q?eNU6AWfgegwWF+yHBFinZL3ECV+yzrr3uDz8BhWHMZbduYYuI/5nFXrENbs1?=
 =?us-ascii?Q?AuKsq1p6ildFQgDzyhvMg0cOjQHQ0JpD5O3Q6LNoW+UAKhNB4GHgTBLRklCq?=
 =?us-ascii?Q?hj12iI9VZxHJxqYPQBmejCW2u7yGzOZIB6EyZOT1jA+peFgUjCtqdRUz4R/9?=
 =?us-ascii?Q?zumWZNqfZkSf4kicsRxoSvsc0eyFClLDBFEkM7K+FeiEkiswW803of2yt/kN?=
 =?us-ascii?Q?F7UNIVcd/hpCFRH4e1ynXc0/ziXoE4DAgNpcOUwl13hx8cyyfBS7c08mFmvf?=
 =?us-ascii?Q?S0Q5xNkmx8WXm8HeuzZDKxNpgE5UPfjJmbTG4gsmSV1gDP3c5pdMxcFQO2hu?=
 =?us-ascii?Q?1zMNlkg56hZDZWHiPhbzo4oJ8JuCjO8mXQXUe6c6jR7/oEG1z0awaCR4Owp3?=
 =?us-ascii?Q?iJdkW2jTDA/1aSrlLOIQJ8L1AnSVV3n2jmMVsNtnY5lS3LgIY3+AmAnCd3Mm?=
 =?us-ascii?Q?9ygYFNi5o68pQv4ksqrDAXZjzklq6EulwlEJl3pXs3FeRj0BFHzFyFLeUbhC?=
 =?us-ascii?Q?tz0DiF7jCQQdMVrq8eME5AHJVL4M6mmGRUNc/4UjZeSeu82K9AROZNw7IduJ?=
 =?us-ascii?Q?55XRnhnRcv7OQURKfFXaPb24eIiCqOnHjVE/v8VuPXKQUVDlq/fvqq1qXo/F?=
 =?us-ascii?Q?yMPcew33Lsdkd2j/hb1oJxG+Zs2kC/5dyQT8wjb286KpRhEhD8LPE6pD8nCh?=
 =?us-ascii?Q?+CpRDCFCzo2RLm2vJJrm5n4hdpvV0cjWI5I8DkeRefrFd45dDbXqI9r50Q9D?=
 =?us-ascii?Q?V9cQxFUVm+iCKDBIBRCW8tedM5QedCwvglBxCOx/IK3H/ZLA4+VBM8nwuyPM?=
 =?us-ascii?Q?6EfiCE0xWXKMdJv2xcMVwlYaE6lbNFcjTQPTh/PMVbjNVRGAJHq11SC0uoxA?=
 =?us-ascii?Q?ifgrETgs9NCkGPyTMtg8nlIS95T0MPdDG1KCl0QS5lwUbS5CmHYhV3iAcZpo?=
 =?us-ascii?Q?k/HWEJjyaSsGlexsISrcIqe5LQWsk64XHE66YZcthQq5TOHYRh6a47/sOcy4?=
 =?us-ascii?Q?fyOPs25YrKihjtKQ1Yh6msQvQVfV5dmz0DhUFcJiEpRFr6klun3Hweet+uxj?=
 =?us-ascii?Q?JudXx1DojhVd1Tn37ey2C23Z398g47tKWiDWgkG9NihQ4tEdC3vE/tjL0Agw?=
 =?us-ascii?Q?Rkd4sy9NN7NNq4kUlSXmmPeEoXz3sU+cKf3cQJQ8tx1sLmkQPshc07vOHjE/?=
 =?us-ascii?Q?e0psg3iTgaK7vhc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:14.2795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f4abba-70b8-4eb0-ad35-08dd60171d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 70e3f49e4869..27b0e458752e 100644
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


