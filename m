Return-Path: <netdev+bounces-154590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E39FEB26
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28CA3A2B9C
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882771B422D;
	Mon, 30 Dec 2024 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PM1u8S/4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCA1B415D;
	Mon, 30 Dec 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595133; cv=fail; b=j+YN9nRHDmdW0NNEomvqXs/gyc2wjSKbovicWhgRXfud20vSqlczpoOYjOe+9poDrkSH8KQ3918bwIIw8hvaaqkLbacBJcHJNDi26i+0HzTqfOLzBrcPFSHKoWuYgmotzbSqqaok4ZzBspwr+IWJLikbTxDX4a6m8WEcU+7v3tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595133; c=relaxed/simple;
	bh=LsUKAgexKRhpCcAQ4DW8IFf2AAtNQSX9+KxNy183oqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpWamo4YgEIMx83pR/P7OlYV4zj8QIH4LOV1BxQa1kUv+bzs3xt6rkoQQIh5NRQfIEuIIX1QLVIm+bkK8ibqrRujIFX0WZunh0z98R7rWHZ31rpjXk6brBBI/55kKvLJAIlFbdrZpxw8P0vhFxoHzX4fMMbv8oxeyRiKtEKyicw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PM1u8S/4; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1kIFgTdoacRdCWTSTmjPBqnlPvjS/GbXP/I7rGCLMu1X1TTqmo1SprLXSnCqfO5zZHoGBrPBhWFYUrHjyUVWIn8l5Mj8XGaYzNpQ+ZC2lPQ72J2p2vglUpl27HFlRCABicu5dBK5Gp5i40xfx9+cCK8fmowjN7JkNgCJ7JFXm7QhwdpXNbTsiMhgMByNpunztFHTXIfISwj/MzfJvQIC/FB6zDAdfoRrk6f+NorFTK35Dz6XMlZ/pozsysqsNbMnOnX+cACtls8T6MU3bXgdyXZ7ruHdOeoDZQpq7uMLLJ5eRzGhHJxarqpKneBSAYeEw6aBKnK45x5CdE8s0V+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUMVfSVRo38EPIMXsMQOvyLSizdyU5NV22kKlcRZ3z0=;
 b=f3Pdc2zhSnZMHwmbVb/DVZ/Rz0FOQbSELPyEVYjMuSbI2A5kPAgCehEjQf2Q5nKiuM2PcC0TiSHOiLmREJGNndGKCpLxcYYGRBCZiup3pwjmeBPTOhcerFx2606usnvCJB2NfE0BgF0RSBezQnRxtWv3WijHVlVvrQFf0gyWN9uskV7Y6OpVJ18KOi4oegZgugt1xuDBTOxe/kF4OgM1Q9F70U/QOK5/MG0jYTK22FH+vJ64qqzQfaioy6EllPV4f0kHlGgxt7P2l7B6f7dgNN2OqciJA1QinefBzzG9d5cjlasGF8+h5SUcEG1LSmQnX7rI/rmKirNWOQKedDAlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUMVfSVRo38EPIMXsMQOvyLSizdyU5NV22kKlcRZ3z0=;
 b=PM1u8S/4jJXIqykcATUyR6lBrkjnr7QE8UqtdoSvbEI2liF/D51zLJpUC6imMoAVlJcz5oXQ1mn+FC5Zz2C4163EXMamFtRJDWjopbl6/8VwpK/IFvGf33jiKpMbtVR5PLOOtXuYAiDUm9uPV8Og38sb8YUjJDmirdr1X2gV5FE=
Received: from LV3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::35)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:24 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::b2) by LV3P220CA0025.outlook.office365.com
 (2603:10b6:408:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Mon,
 30 Dec 2024 21:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:23 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:22 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 21/27] cxl/region: factor out interleave granularity setup
Date: Mon, 30 Dec 2024 21:44:39 +0000
Message-ID: <20241230214445.27602-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 88be9469-12b1-4d7c-65d1-08dd291b4442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OA4GJ/KcPZ6Ut1/0OPrsIisI2G3+++efrxLUEb/8BEgmlPR4x+sz8zzqr81y?=
 =?us-ascii?Q?1yLT3r81xqhWtPF5LDtJM79DWvTq6J5hRV7PEPskn3Fbb49ST6B/MXDEGL+y?=
 =?us-ascii?Q?VOMakcmSKSNDrMgBLm9elQpXKdM4DzGgl8PPNZ1IyyXbgx0vqk32nigua7L/?=
 =?us-ascii?Q?lz3foWD9Buc7shGelmsyeHzR9itONIOOMngsHxfchPuXK6S+Ra3sfBaHv2iB?=
 =?us-ascii?Q?dqLDfR1ir2EPaiYI1fvT1WvhPt+kTQYD9EHtCJG2s6vSbnT1AHPG3RG83PSX?=
 =?us-ascii?Q?DepUBdkXjqtw01xrlPouh9Xjlm0OmtRtLdEJiEYQJP8wKmw1f7beQ6/EbY4h?=
 =?us-ascii?Q?UBrY7KYE2FUjIZZyyCu8ds/pMsX3VI6nP0GrDMwfHpryiriOPMi4jN5TcEE9?=
 =?us-ascii?Q?id3txQLXyaC0yO5IRe7oxxBoaNdVLYMGLjm5SRbYZ7TUX6tN8KXgpjIeKBDj?=
 =?us-ascii?Q?K4ld/dBot3ruej8tpgTgOjer+k1b588/jY0PvpsyY/Fcof3/L8F3TRMnGcjL?=
 =?us-ascii?Q?W7CYwhipni1hPcIxYg44zOFZxydyLtlsqKJ+eBsXDR73ngaLfxknGo78gygB?=
 =?us-ascii?Q?O8lVujGcy3S9NVR8PwFw/UFrw5qzbsA19nOrbBZBMD8l9WVpRlcidOJDi/W1?=
 =?us-ascii?Q?yEPT7UgX9wD1p4q/lA9XzlumBKi0udb8tQSnNjpnKmeiIOu7KtxZ6yAfRPAo?=
 =?us-ascii?Q?MuWcju61BzqRCxqwjd5kmO3hNUuLbstsE5H0/lX6H/kp0ehbVtdU4Dvz4F9H?=
 =?us-ascii?Q?QwSc27gZ2fh84IKXjkc8paAtDZODDCqwet+TZ+Asx9rjR6HJrLVHiie6P8ly?=
 =?us-ascii?Q?gvrPwWYg14o4gPp1PxYPZ3E27honr03u+sPq4bDu2jyCqK8Xm7/4zctNBt3a?=
 =?us-ascii?Q?FnfvtYqGvrcujyok3bjDqKBgbk2SkB3IBXPVu3oXLy6RipShR3PxgIMhlR+L?=
 =?us-ascii?Q?oWRvri9SBmFASDiraVNaQGSN/NYIyoMjSqfpL4o8LuHr3Hq2Xheb1sYC5kx7?=
 =?us-ascii?Q?4HwQDIAEVyWcXraSX3/hZ1nOKj+hB6kL80pwrvFIGY3pdgj0o66CXb98M5tq?=
 =?us-ascii?Q?Chj9+kN2CV+z8UZqH5IEj3dwS/YuO15xl/ysXROMWcl+6ikrtYtoEXZ+VWeA?=
 =?us-ascii?Q?G31bnFLRRXgqKt1TRIqr8XQMSA2f1UczarjyHBnhf+wUJoh7RNFz0DObbjtP?=
 =?us-ascii?Q?Epr/2fG4VgtDoLdpYXpXFhlbRXFzcME7qIE78PeBu5T7iC/YaoVleDcm8F4e?=
 =?us-ascii?Q?FhNmNfh13mZzP69TRXLvCiP7LN+8KHRbcFcFQziNhwIi7a7zMSLC1UZTa9a5?=
 =?us-ascii?Q?ggCuc0gSKComZkoOch2eKndc+bEE93qJjHBVeYD6TwKr+imVvpW1Cl8iaOxJ?=
 =?us-ascii?Q?djnHNbjt2FChx601hMva16zC3jy5GZSvA+5Jgtwu998gyIQ0itjjhb3Nmbp6?=
 =?us-ascii?Q?BILrjg066Bu2Uvv3Ir12/lOmbjrlptLcOWjfVxR4WogQlqewUVPQ9+fWxFRM?=
 =?us-ascii?Q?YYZnWY+rhTF/cJc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:24.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88be9469-12b1-4d7c-65d1-08dd291b4442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cd4913320fe9..1b1d45c44b52 100644
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


