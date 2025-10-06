Return-Path: <netdev+bounces-227930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A85BBD95D
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEAC3B9868
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52922253E4;
	Mon,  6 Oct 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8cPxRya"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B65222562;
	Mon,  6 Oct 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745046; cv=fail; b=oQ8CpKDkJrhgA7Md5akfaVwve6JKj8jlchc6vK87TlDs1CxQQLHqAyx9tcinxvecn0UpRmorp4kpYB8KfJ8nxaAShpVfoAn5DI5s0Seu/+yq3netg8InYxEh9MU43C3SuhbyYpftbxNm16AEmRUWoE0V9lWBtxz3q0/ds6SWtjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745046; c=relaxed/simple;
	bh=I2vhVh9jEgryJN+GK5QeqnMoVODVPBJZzn1x1TpTaH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaKXbdVY6w4sFL4lWNu3GUrEGf9kY0p0DE9u0yrY8+b8to2frc49SNFtX2cIKCK9f/1guaGupiFv9TZd+/z7dAcBfzbWys8SIs8FP9IuYywM4Lnsyk/b2C/6pWj+8QJLUpUv7WT0E0TUcOAQDpAM8Pw2nRLvc2gkcrIKbEN74bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8cPxRya; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOqZ3TsvG+oamuychRxcbLokmB1fRVvqdPoYsO9G5tbJ0phnbMdxJzonAubguHitiOaBr62uV5TxUK5Ag0BlkHMyvGKY3U3n968T3VT7NXzaiFmOf6Gu9S2M1AtnhxGYmbYKf3Ajw1eXSX8rL5yyeneylXdnuwamnSZRZ+laCDbLTVv+XKqp/oHD0PwrBClru62o8vyBM+M/+BTRYchdAxAj8j5YLAq8VUhDOmwV3YjOgs7PJN0elZyNETaijK+kaKvTffouHLvxOmpSD7kyqlockROCksojWj6m9sJzptjRAyqbaNlD1yU7qLBeiPjrgR+P8UqNpCdRPoLwGWAKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eez4mCumkTMPUCZRTzBjlL9GPXSHaJEOjOkx0cGNIKQ=;
 b=NKa9p7YiIwiOX2Hp1O6Wegr+4rM+nXFRr2BOk4MAVbWkhOgZuLhVZ2lEc3GZP/RNsapg/NaNwzMH739Zhqy2do2ABx5tbda3QKmRWDMaNOx9pj1TnSmPlyovSEFpJ1d6fnNyXRCyeZsaO1OI7l8ZtO1BkMoG1tJX2wHGyzx7PX+RhOrSoYhv6EsofJBDT2yoSp70UHo9l+skP4XmEBqtk2Eo04W/EB+3ldh2chSl1XOuPaidSsMNoF18yGn1Pn6g+T3wZSsnFXgDrEUbr9Wz/jhzJNzjyFTs75UfNkzbGPcq2MiCbrOUSTeNw7llnWcbguV8L2vcPSBgJlKKtVfEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eez4mCumkTMPUCZRTzBjlL9GPXSHaJEOjOkx0cGNIKQ=;
 b=y8cPxRyaQgUgDb6qF1PBCsPjZDcGrQQSJbi7v8B9YZZOm7s+iEDQoOG3z92XGMe8dvZpcdHSE39oCysvYFAMMu483fdiIr5bvmdOHW7fqE14NWQia61qu3LXRfoCOgBbD7CiWu1U9Qq/e+hUC+w/Wri2VGsj1lmM+sBR0zuI3W4=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Mon, 6 Oct
 2025 10:03:56 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::d) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:03:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:33 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:33 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:31 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v19 16/22] cxl/region: Factor out interleave ways setup
Date: Mon, 6 Oct 2025 11:01:24 +0100
Message-ID: <20251006100130.2623388-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a82637a-dde0-4bdc-a13d-08de04bfa996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOdPbRd9rMb5F7sTVi5kR95KcegQwXamTBWRYqXCTIYv2TeqpqBAc87zwW71?=
 =?us-ascii?Q?rNXkTOF2olchxVWqiq2c5J9coH6uDH+OB6LL+ikML0PdUo4ksZAUHQC3utkA?=
 =?us-ascii?Q?C1mXnoALuIKAtdNHNK2oi1rUye7mL1bQtLSFWy/Hx7UyMcs1OgUoGG/ojZ7V?=
 =?us-ascii?Q?/qU++HJ9q4mLenOBoCDIQy+DPGVZczzGLCS7uiqT0EkR2JmPPdEb9e9LJshj?=
 =?us-ascii?Q?nSxpeB3320gHRDTlQusGDBIpCpnDzCcbeTvWrdjhSFSgXcteCKdM5J8hsTbQ?=
 =?us-ascii?Q?xtvwiyrmFnJm46zbH3OJccc5FL8Wa8Qx864bWjAHl+Mn525OPT1hhE8588X0?=
 =?us-ascii?Q?rs0LqIsvi5zRtNO9XiZzmSeqYpKr/ubJrh2HFrNJ6L8a3Z1hbQOoPWKutkwL?=
 =?us-ascii?Q?bkx6b4lLMiYIlnu3krWXbDT2DnYvUSVq4mjjh3WzilbS/nzn/yEeXIGPhPCz?=
 =?us-ascii?Q?+b0sWBjIQfkKAvnuN15BVT8wAQVaqZsHQRgg2sQl6NPPTpTTFQn0TY5JgMJd?=
 =?us-ascii?Q?3xRqC9mlX3mPrMGLL/HkzuY6gHVAzTKa3oDllBxp4XzSGLFu4UQCZM9rUApV?=
 =?us-ascii?Q?icrXpk9azZIx5TD3qGPWAGJ0aPImvQk1bQjPu0OHBLbHD4uQeGwhBf9NoG47?=
 =?us-ascii?Q?IMHDb+bOuGZ7YRHFlqi1vYCFFpH9J4ZmUp0CDYr1HFHE6E+w0E3Rgv4/NiCH?=
 =?us-ascii?Q?LIW2QJiVJu1CGkKUZD/HPX1MW6/GLHzVP46FkFxT6yKWbb8kwhiHNZxQrhZ/?=
 =?us-ascii?Q?mkYuAGswq1IpusMJOLpsGlCDElAZNB8OnHcZOeUF3mW07/WapD5AL/Ocd1ZH?=
 =?us-ascii?Q?d9JB13mSUrjNpsLWwk1/OhA8KzOKvlHqR0GYwcsvIXGA6oCef+57kDy9pXU4?=
 =?us-ascii?Q?MWzo5VUJYUjolvkGzmFsMfXR1OEVY+QScWtiPoHcLd47vNrV/aLYQzkiemiS?=
 =?us-ascii?Q?8B0LhG8znBBJvvC7uIEAYULglf8ETwp9/4HLgZymjlkuCG9ViU6uplDu5OcS?=
 =?us-ascii?Q?eYO55RjpVBDHYlwAv1wj3MvK1Dlsic7O4r7wNqf8puWkyNXHYOXqhNRDNUzl?=
 =?us-ascii?Q?ihxXXdMeLy+3BcFDWA5Dj9dQqo9hM3KIfoGLXEcnmz2VTGFyu9ub9uSBRXpq?=
 =?us-ascii?Q?aEDe0gvNiF7GQSiX9DOF9gyWYHknFfwwEN12tvXqgjKYxC9nKNqGpWUy7EU6?=
 =?us-ascii?Q?7kvrg5SqAg9FNoHSTUTLVFBOmS1/0JmrpOAXROzdPWnVm8BmFRDNo3bIQaE7?=
 =?us-ascii?Q?eTyqtELCajgtiw5wzp7lrFiC/y0SFFi3uSDHj1Ym6lc45M1LrcezwvK/CZKV?=
 =?us-ascii?Q?+6bm56RcBfS8O73Ha8Yt7S+WinSIK/Piv95lSROJVwvo1M2uTJMRdUD36jTQ?=
 =?us-ascii?Q?gDidTF3IwAbUJZe2j3rnxxphuD40eKF2VvUQGPL6VvfyYJPwGnrGpntTv7si?=
 =?us-ascii?Q?jjO3N9JiIKBat88L4ptG5vhvsgGl4kfqU97KlManT/yBYQal9fNAdkz9ZQnw?=
 =?us-ascii?Q?U7eu218Qi4zRg+lAGa39wxGfk2NfnRl8SOObjcqyMir+1peEezFooIhPy1DV?=
 =?us-ascii?Q?5IBv2+8x4tEhQpih+Cg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:03:56.3130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a82637a-dde0-4bdc-a13d-08de04bfa996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984

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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 732bc5c6c2bd..005a9c975020 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -483,22 +483,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -513,9 +505,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -523,10 +513,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
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
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1


