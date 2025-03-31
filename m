Return-Path: <netdev+bounces-178328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C71A7691F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575273AF81C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B45221547;
	Mon, 31 Mar 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tc15wB3s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F822171B;
	Mon, 31 Mar 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432404; cv=fail; b=onWSJ+t1TH8ZMYmO8CxShSYUJqJMRUAwi8Sicho/UZvi1lvjr8RBKLPUjZ8c41SZ1BkyljKXJLaZsO6nPDlDzeZf0Vrw2wvF4+JZ6rN17UBRuigbrFpNkE0AuKXeRxC5R+lb5wd9epFrch8+DsdSHLZl9nC5R7/tXobYp8erbkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432404; c=relaxed/simple;
	bh=X8GunJG0sGqOR+/Thc3JD4/iFwG0MPFG21OTjxkrde8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2mOgKpbZ0eS3+VNMc6WhF2zCBoMhvT/yiPXFcTqaaxs+6lQWzbj3gss8d2K4KDy7htubqRVFrcBGJvF1qFVMDx0ttb7nfMBZWHGqK943KuGIRSfNtjA0LnPZ0587nvNkDLGo6YLpx5WiBe2YBSWCB4FK5D1mxF/EJOy2UvpeiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tc15wB3s; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1GVmA49ls/pZBtC3DNayr77HLU7mc8MBt/8Kh8277nC/Bcm29FC3v8ONDmoxYJHeZ1vQinlkw6zSdaIproZY/xyqrIuE71aksNAEHGMHH15oMupWAQ0d2kcf5uv4cbLbDLZkovduKu5VgrD761cU58bbh0EHwUMrYhRX8NdWg68dyteT4elh+LIlScyGDH8okn2tHoQ2FEG0p8QP77mbiSIYIYAd60n22w0I+eGE7IGCni/9UyV9EHP/JTiQJQKeG0ODKveDpl8Zj3FixuF3pt8+RPvWW2qrlXwKiW+x8Hf2LFbL0fKIE67Zz+0SFg/1GZiisy3D79ZC8TbpY3rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuE/HS9iQX0fv1PXusKnaUD4bhrChwS9OZRA3kq9aX4=;
 b=RQqv9YSwoSlV9xZ8CdgEw1gFI4ssXknWHgrYLgyLR66YiwGL/6MxiADWvBiQAMMiJlwgmVOkR7DPcnT9L8mRCvnduLfLvgrPPgMogcFgrNlDRHHSDHt/zFWClpwPZNjpyJsY0kLAp9wvuhJjUVeQz3ZCMYlnJXZGt6/3TDAiFV4RTxla4dsvyljYICej9WI1zRxWB4nwPIuMqDRcWDVAn8CvU6OdvCyfJoWWZ7Nn7vGZ/3mHBblA/NMKcNIuJK9dzORXxxfad1JO5uFbZl7YNHxktgKGHs+eSOrcZ6yQhNdSXb6e+iqjw0UCVuhI/tr9YFx/JDxa8mVogaonoMqPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuE/HS9iQX0fv1PXusKnaUD4bhrChwS9OZRA3kq9aX4=;
 b=Tc15wB3sTpHb3dnXG6a/FzgQG2WcMCDKNDX2Imgxdf7GiltoWyVLEPIEHLw2LBkcpZlK6Wz5E/BcDW1TQ7hyI1GIqKS6QkTXMn1lRKrH0Dp8WyMZwEpsaAWKi1McRRL26Q81hOp+4fVUNGDKSK31iTV0256VYfjyOBNDKq3uNPk=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:38 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::5d) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.33 via Frontend Transport; Mon,
 31 Mar 2025 14:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:37 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v12 18/23] cxl: allow region creation by type2 drivers
Date: Mon, 31 Mar 2025 15:45:50 +0100
Message-ID: <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 149125df-d4c3-4c22-3f5c-08dd7062d763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YxWIyqFnRuXkMbyPGdgr/31H6FaGdHaKaw+L4ukBGfCDyz98Rvw9lh+nGBRP?=
 =?us-ascii?Q?sGBaz4TnQbce5sN43Yw+D5zXx2QXOj7TX3+p+k9kf48mEy3SrxYrVcBr+lQu?=
 =?us-ascii?Q?m/EUSvDRwKyp2lm6uA/c9pXU4PFtaLdSodNMxOsqiBju6qtZpL40OMYHNg1s?=
 =?us-ascii?Q?PY+Kns9K1GB+M9xRMBKmAL4a9b+YjtosB4zANRo5HXkh5vyy4iqbPTYdV6VV?=
 =?us-ascii?Q?MwI3kk58qaaBau2l1ZqA509ehMWg8ltEuOnC1uTrDAKAHNF9OSkxp6uYNVvq?=
 =?us-ascii?Q?IpQBMTFl1KShZB1Hbyvx0IYCfLIUm8Hj0un3DL3cXNsSIKqv1hEIASMZAkvG?=
 =?us-ascii?Q?JuXjWiLi24Ly2nVCghQAa5I8oCyod0FNB7WWwL6BmKrpXnVAfZxJhVcTh1nV?=
 =?us-ascii?Q?UT7P+Op2zun25XBbpOZr2MjkY/afluqnIlPfXtufuEmXwzJbz4a1kVQRC6AO?=
 =?us-ascii?Q?CJOibeSIAr/pCS/N+/mviIElkgv4F+NvYlQ1/BRVQFl957Ov9jxbDMcKQrRV?=
 =?us-ascii?Q?yGHGxKiHH9evs2sBgR28D52ZzzjCeqN6C07RMOdKgG+2G1eE3UdN5Ws8LMWm?=
 =?us-ascii?Q?mvLw+5SITBJDHZE85/3STjRuOs2WUJs5w3jL7QWXBBV/jnpMJT26NuE+AY0U?=
 =?us-ascii?Q?fAGqggzVr9WAI6ESkVOplN8dWKhWCWlXOJjHah7d0zxD9HdFYzbLPN+Faxu0?=
 =?us-ascii?Q?csd/uXrQ3YuD+mDaifOhQvIolVlS4Ei9WS2MjEUz3osnnoMOXiP8P7Qj0zXw?=
 =?us-ascii?Q?9zM/1YuHmyb9rJ8YZAXkUlFZS5pYV2LIIlXo9ISaywsvEsPLCHWysz5O4Wp/?=
 =?us-ascii?Q?jnv0uiOneRfRMoBjxWIahjgdLY1IST5CF3m49wWiVcaLKLR4LqLSsm7DXBvW?=
 =?us-ascii?Q?5Dfy+O3IOWtdIskp7LcFAIkNJCK4cxkRNSJSdY5ubcKz1ia37DsuIHMmH/l/?=
 =?us-ascii?Q?+nmHTBW6Cqr8E9nbqnyTSwO2MQiQJ4aHfT6SRv2boH8m8aGdSWlfEH3XNal4?=
 =?us-ascii?Q?m2Fv6i1DXmPzvJQZezpSh08ygI5zvkr7U9bS7n8UFo/docyJEAeVYFbq+iDV?=
 =?us-ascii?Q?5uLk1WkFfmxKdxpLOou/IqLU9y74SM4DtBy9KkNO5Y4wDOdxf/WFdgMs1msI?=
 =?us-ascii?Q?P+Ujd8ihL93QjNk3z4kuPJdL2pLE07bCN+gQ+Zpsi3MxT7+LYG7+iePKDvgi?=
 =?us-ascii?Q?4sCku3HeDWW9v0D2oh6WtcauySeh2Ipe0PvWNrhOCG8FjiScyuqccbL0Kj0l?=
 =?us-ascii?Q?PH42eCh2aNAXtp2Uv5l8lMWtkiB0bhCNE/k6qTjTh5up+JCii7ASObWeQmdb?=
 =?us-ascii?Q?7hLSf07oy/2YNmKaIIQaCLk6PctP9VIX0p0LRaP2URYm6P/g7eCXGCG7Q79T?=
 =?us-ascii?Q?xHvQF8EEZXdWIVG71xdLy39AAHoYJCH0YLxm9twc1ktYD4RKNTllphM743c2?=
 =?us-ascii?Q?//Z+AFmEi7tSH+WMJ6mssqa0lvK1ThbHCSEYK/VHyAJjCKEXD2IY6RtTG3Oc?=
 =?us-ascii?Q?HnhE4+IRngQSH7o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:37.8565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149125df-d4c3-4c22-3f5c-08dd7062d763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 135 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 892fb799bf46..f2e1d5719a70 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	rc = cxl_region_detach(cxled);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2816,6 +2827,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3520,14 +3539,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3536,13 +3553,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3553,6 +3580,98 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d2bfd1ff5492..f352f2b1c481 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 22061646b147..133d6db3a70a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -261,4 +261,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     bool is_ram,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.34.1


