Return-Path: <netdev+bounces-243800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C760CCA7F23
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C639B33609DF
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C2330D3B;
	Fri,  5 Dec 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M4KDmm2s"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BF32ED46;
	Fri,  5 Dec 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935622; cv=fail; b=a5fKp/AZB7UhTPma5/dqDYNDbK5ToXGAs3Lyc2IethKvJVj1pf2XlTz9OBpnYIqiHChKCB/nOvn6BoyxcNZ+ZBou3iHhy+dhTQDYqxR7NZ1UaHUQAVdayRs93hMwm6piXzhzs3/xclUrarGlynHl5xudNf7GFIkLc/XsYGcmElk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935622; c=relaxed/simple;
	bh=p21u4Qz5y+JpHGhvQ9AtgCD5u1X/3q/huIWlVGLm3ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdEOfF3Axr1TdoVo4eUIXEuKVpmr9eYQmQuzD+4qScnx/VjlGqnCaVRpE3cX94RgjipTnymtVshDGogfwS+gAecLLFiuI/nEX6eCzRh2AXCRuFdddfLPt2cOHnccwKxbnqmQZ60Uvumnx5k4h3TXQIK/PIuLhdCbd3rkwVTp70s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M4KDmm2s; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGgS1t7PE497SAbZa7zD/p4cPY6OnDKQhEf0tw9ZVFEh6ZwaNd3KJWhuwO551ruV6ZKSCrGoUu3Ada6IWEsHo/zMNOqWtVc9PS1K/RbXw7IO1o7BEcKPHPJUwt2KPShmW/UvxBaG/kQBFCvl0pij8kiEbl+uowhsX5bHxbdM7dD/+vLa7w4wogP8H71Bd1w3y9OJSI9MHhWA/lAufWV2GQ19aOI/0imQrDMgQXCSdEZ4A89UFrWvRBn93oBMchva8mBklogZOBITVthRNaibt7apMgU+/qe89+lB3ZlCXPmEybyf6cfMIFY9HCK4RvIKK1xbmlrZlz4sq3VTH+NGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE8+OjksNVknGWDSF4RGj5HecrMVVoQ7EnTPxs3vzyw=;
 b=ybBAvAkoZ0laFSutK6j6cHBPOJCaWgr1wgqMIDT0QS+0Sh6S9XwCsoAWWVwEcbqvTPzT7TSF4S38qHXEBdUbdxh0ZFiq/iE03kpro6KnHDPcVPlu7yCcD+BOhJm4BJDSXNkUgzbzeEiquUNHoikYGmOqztwwI09Y5UM8NBNkbt0vPpd7zfN0053A3qsusoqm5jiQGmtgIwNzxuU9U0ImrpAK4pbKEZaYO4luaS/qDRoM6yHQiYi2M2X13HK9FJ5PETRP1vl5zxG1qFjMVjFbqYk5Cev3bt+ho0x3HP3bmH6Sw2bs5K6jyv3zHB2xTuzSn2T0ZsLrRLer/KB1ktzTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE8+OjksNVknGWDSF4RGj5HecrMVVoQ7EnTPxs3vzyw=;
 b=M4KDmm2sRx7zZos8G+K9XI25NlKEdgv01dH/LeiCh+taiJAqUarm11hwFaDc076UB6dbcthUDXOmP4VeQzRxoamkZq7a4yjqJV72ATmvdfkv4cBNcTOK6bV5iMSiQkmFBD9PFnzxRkuamd5/eeDiYjwT4ghgf2qpkUJC7rnhVeU=
Received: from PH7PR13CA0010.namprd13.prod.outlook.com (2603:10b6:510:174::20)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:29 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::44) by PH7PR13CA0010.outlook.office365.com
 (2603:10b6:510:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Fri, 5
 Dec 2025 11:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:28 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:26 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v22 20/25] cxl/region: Factor out interleave ways setup
Date: Fri, 5 Dec 2025 11:52:43 +0000
Message-ID: <20251205115248.772945-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ff2704-28ef-4e10-f24d-08de33f4e7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCzT3g8hLM6axR51rIriZNGZ0tex3aa3uBiRMCf+l+iGFhrh9dnqcYxq+t+6?=
 =?us-ascii?Q?vz1NBh8ghkriBps8uGjRATIzVQ8GKIBBNz0GdfoHi22MSjcDlbaZVipYunHk?=
 =?us-ascii?Q?JtHNpuoxZv8voFCBbJziw4mR8xA0tzFX6m9PWr7Dahh+v9DGDGMrPMIY5r1V?=
 =?us-ascii?Q?IvGrtQeidhTY/bEkEvlLqIiWludJ1uZckVz53pKljBF+u2FIQd9zox+TbcuM?=
 =?us-ascii?Q?OcL/ktjiy2noIZZkYrPmNIEUiBbSZaSNH5w68K8bClbdoIkLFJzI1gZmo4us?=
 =?us-ascii?Q?nGOI8G0WswR7MJGyFwv25nuFljtYTutGdVi1MBvMYGzwDsjw0HOis+o+Pc43?=
 =?us-ascii?Q?usknjIDpGIJ6FA3+zKm+33T49FrrfxL/XzD6fFcw9L+QpmxsHNmXiIQNE5l6?=
 =?us-ascii?Q?qnlzIbWR0sP4hApoLxG2QPZd92KitNExKSgajyJ4Crc5i9XNwyiwyQlkUXRL?=
 =?us-ascii?Q?O6xEmJMCh4H2PP7mRJb4tAMNK1vTokr73eEyJamlAar00uTMXnJ+mUNyGt6Y?=
 =?us-ascii?Q?I9MN1X8CKqpNe6wSlcv9WHGNyhiaw+Z8uLqfabHTOa817oziqgZhGY3uWrPY?=
 =?us-ascii?Q?GcxYT48iZrzb4CzNtataz7JbnoS1SYuJ0ixDONh+W0xNdbwMSr2Q/xaySV4G?=
 =?us-ascii?Q?lwZLvpmpjxDWOVd6i1RZxhq25zPoe6oWIVScBaX1hi/Iu7CvGz1pV+rMbD09?=
 =?us-ascii?Q?bOYgCWbJA3ymJHfehe4TqJhM/XQa2IW5eD2TNTZha62gjxsReNBo0YmqJhdR?=
 =?us-ascii?Q?RD5ygnqXaE9zi4W2dAiloqxsWwLsznUEWfQIMjaGID3TtsHb38x1jsWIiiJL?=
 =?us-ascii?Q?DnJQGrbVSt2C+ZT55Dzuql0r4lVzK1g/X8x83dFWgB8n6712ddX9ZkD5s+j4?=
 =?us-ascii?Q?SAFJORIsfOfoiGg/faCfl1IRI6MEF8pKJb+8lSCQmibGEI3245+6J6eaJOr3?=
 =?us-ascii?Q?souJmDiFUF0kCRfpMKFCww3Ant+u+qLSsMzfRWGJL/9M2UiNNqSnMqMv+ZTo?=
 =?us-ascii?Q?1a6MY5eDy75lE8E9YBcxWc85TNpgYHXJ6Yuk0NkdjCgrFhBaerz9IkhefQ3Y?=
 =?us-ascii?Q?CPbIit3LjjSq6cYXqrBeWmOOqQYOdbqw/RMRi/MicXsAIh9/HdNAv1hyhaSl?=
 =?us-ascii?Q?wgu19Wv4pRYdtDr9+8GMlEuTJyctnZ7ljFtRuMcryWnIVnUfwP3Fq4Frv4KI?=
 =?us-ascii?Q?LB2kuIesnrxMl81DaEn5myjTZ7qyx+oYMfnKpeRX3JUqjD9QYdEdP2ECv1t1?=
 =?us-ascii?Q?iiQueQe59aICkskwJ4Vo3GCKD9OZg/r29t5ZVsf+vnTW/6s4+GDHz7wWqaSD?=
 =?us-ascii?Q?ZTaVk5FShiEVYU4Aw21DqDnepE+zoqL0oV23a94YpHVE/LCTDiHJVJgCrt/t?=
 =?us-ascii?Q?gCAjgYfVKJu5e2WSMf70pBko9V/caBLRY21CDOhzEqjIV9SKgt4/UCpU2kyd?=
 =?us-ascii?Q?g1CNE+KOfc/C9tgK2NpeT9bqyPdNafuPh8XZ5NXKi6Yfh3ddSR6wjU/eXuU2?=
 =?us-ascii?Q?SP9NRGU+7CqKrTy3hM58SwW6LeHJKkb8AJdqeSIuoBM3uK6BblxRKjrSwSjR?=
 =?us-ascii?Q?V7ZcE+6WJTzcBbEzxLA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:28.5499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff2704-28ef-4e10-f24d-08de33f4e7bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661

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
index 9aeee87e647e..157deee726a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -491,22 +491,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -521,9 +513,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -531,10 +521,31 @@ static ssize_t interleave_ways_store(struct device *dev,
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


