Return-Path: <netdev+bounces-182298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD7A886B6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6291217C403
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023B4438B;
	Mon, 14 Apr 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tqomi5dq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A122797BF;
	Mon, 14 Apr 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643658; cv=fail; b=TV5OsCANWMLK8hCC1msQXqVsaF1e9VLgNXAa39LMztJsrlvdE6LqtNpKMD0QCsBGHL61Fvo4QAAX73ELz8xLogEz/u0zD0eubN8ivTdHfASvbg9GOnnXXX/C2rFKQ/JhilTBVT49TblCIHpXur3lrCAkukSMtuK6j9nwy2Qudbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643658; c=relaxed/simple;
	bh=OkPz97BU1pbWCzvB1TcLv/s8nsNF38rmbNNtHbsQN80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USqhRVR3GfA4qaQi+MpYkVAb1DP/bgSc0+SX3ejXVSGb/YvMDw9SnLpPyisqez0OVk1O02Qiz5iMceMibljUy8lJN7jyY5sckh1Pvm5SfE8Z/8hFMDVoPSmpZFqtmqcMEzoRH5Pmv0HMf56f1EUSqEVfb9deOCm7riPI8FUt1vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tqomi5dq; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qES78I5HZ6eC09Ea9npjjhrP2sv0VKkoxPioFlcOmdeQKd9sMV8f6BZQSdIoGYHBBWNZLDBcfeAM0FrmVR6gMIHCngg1QrlGuYWiOk0CE/PSO57jqY6ENHVZKOYYiKBRhdOLJwu6fRyMSFqrfFpBvliNNZ0ZmlGEdv8u6hVskczEPqFzWIOm7v41CVpIspm+fYARRdFFTqVCQBDW22z2Pogfcj32FaGlHooIqXhwpXgj7ivKEGQQLjhkj3LGmzgC3mvxjeFUZ3FEyzaVwj96NCC8RU7y1C35gVL6B6PUNgwVRHI0/T2al/CG0vgSVQ+3Qg3hUlpFRs659HO0E5uguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2t7yHcav8jpeoXJTgtqbF1rm7AfMwLPF5am9kbPZ3s=;
 b=aq28tURcmcXgKec85pTI/KCH6HAUtpcoV8DmZ/TWoDhY+AFAM+UbHp26yH1GHDxNmXGsWs8NV7zZg/7O4qoiLqv2TG9D8rzWbAGEHcota7vkgUOUp1WM6shp55hQaF1fmv182yiHtS954iUJWyVsYSS4lorDZzXlvdCsBlHm9xmACbxxq63/CKZvCTKohP950lDeVxaV+TO7N8kw4PvhIMzSLAX2rvxQlZtGdpMy0hoW3O3vn/4TgfgUnCAhW782v6fLujEF/1zNHEOApmohPxdMazCbOY7yVXUgXgGZFfK3I0N1H4diwcaDrfz4/qBFGOPmCaMgeeBmeX1MxzXrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2t7yHcav8jpeoXJTgtqbF1rm7AfMwLPF5am9kbPZ3s=;
 b=Tqomi5dqltQjpdxOEzEcOhkEpZ/O7PmlBaO+FCel7TyQyVIzRNW8yDGw0S+c6s8kprtaGSDRQPzXhkRpqHWYuqcWlyl/X/mSt1o1k4E4Xg7B7YTw/Sq97s3zCIuCMFOUFQKS5VtsOcCenQmELYThFstpvYxLoVsg563OOoWQscw=
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 15:14:12 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::b2) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:10 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:09 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 16/22] cxl/region: factor out interleave ways setup
Date: Mon, 14 Apr 2025 16:13:30 +0100
Message-ID: <20250414151336.3852990-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8326719c-6f58-4da8-4e5b-08dd7b6702e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KalzSEPS8rpiNBFrUKVQCDvOoVGebyUYazgCV+aezvuBDJlLBrjRN2GaCLkJ?=
 =?us-ascii?Q?vujwW1MhTjM//p3Edxxxfog49FuKveIkuMCa6C71xGKYBvljH3okYmIsePu8?=
 =?us-ascii?Q?GVi7dY4JK02aA1rPZ13gEB6ywhJxJEjkDU0IZcsvSCcb6mBFldMl0tC1Lujv?=
 =?us-ascii?Q?cBbD9OAm9yweAYvebriiyhPl2bsnsh2RKCcRcKOb2eKFUyqdUubu4vAZtWvu?=
 =?us-ascii?Q?7fAtiwzYloRmzG9zttOd2cm1v0WMFY5TKjcyGutrib9Slhl2n0tf6owk+nHj?=
 =?us-ascii?Q?b35ILlq6uF37IuOE2jFpEbOdK3UzXaf7wprU+ZY8ySs4xGUTCWAJ5LT/yPO/?=
 =?us-ascii?Q?yirG22xErUa2uZV2Fvkma1Yc5TBiIvjfpOE6+XcK025fiRX5eoLQuh2yAzhX?=
 =?us-ascii?Q?CZ5BgSHooknMt+dHqTyj0IaVfEpqXK3PsF+PBS2kWPQcAwhz22pq5Tcf2eij?=
 =?us-ascii?Q?oA2y9oJX/VmVrsn83JoMQz740eblIzf9V6q7nbc+cWIX8qpx7cwrF2XNCb99?=
 =?us-ascii?Q?766TKHNJDM3oz3jOzG8WOeu48BKXdggW0zzA/3pSFp4zTzeUKYH1eVwlwmEr?=
 =?us-ascii?Q?y8sguiIL3XvI6Ll6gmTksI0gUUJ0VFvxe2VpaAvVV81j01sEKfVtLaLX+o9f?=
 =?us-ascii?Q?kROO9qG8UE1rBfLSAUWVGOFbQbkXxBLXWxq0k65bnmNKt9q2QcMwKZxgISkJ?=
 =?us-ascii?Q?rjDVQq7ZAs3SfSaS/RXxIa4BN78Dl/33YNen2ONHqrvULIt0jsTdeRhaf2ch?=
 =?us-ascii?Q?ldHLAkC35YDXkZUVzNziZAGfLZ8zyOTacwfscKgLiGjI2PsJdjRiCMuFzAXt?=
 =?us-ascii?Q?Vxb7TducFJ+wobrjV0PeUSY3ASaAXGPx6cvDvwj4gqIL2hw2lyjdjdHxMgDw?=
 =?us-ascii?Q?QAW6oGkVmeCX7yOO2FI/FaxCVe7L5Yww9l5pIDhOzY/AaiStUWhzONFZFYsG?=
 =?us-ascii?Q?HHjqx0NlrC5Vym36fOqPfQ0nwZy/1+x5unP/JMffbPUEbSxaaPqMWpidsvLW?=
 =?us-ascii?Q?PogQeMccOJya/KhHvKaatb+rLnrjthEsExnTDTJmzReCkt2s3hRcgLdBRM0M?=
 =?us-ascii?Q?V95n5EfXON7BNWRNAI/UR0SgFGwQG7hohU1Ay/uOo1aizQI8ngBYA11Li1rO?=
 =?us-ascii?Q?wMueYNd+XhaMW77g9V3w7P+wELmJcHtzzNqlBoJocqDgSFXFgPJITpXI3xXA?=
 =?us-ascii?Q?jfUR4JDzZ0X10t3ak6J0quCfJRgp+qZ+acUW9QlOaIYYlBjWCT6zVAfbD0Ue?=
 =?us-ascii?Q?CnqiJgFCD2QH+ZzTjwcu+08M79F4S3uoAg4ue7zmk4t4WIkYLfqG1aiydkxV?=
 =?us-ascii?Q?1CzK6Erjrcl9n1Lnn3onQLdV1cYmDelPKbw4Z63G+C/HTo1SOeCVcx+yYuyR?=
 =?us-ascii?Q?MVKIU2oICfr4QMj3d/h0UWFS0BszW8kTYJ0lilbTg1XXdBVyv5ySqa11YUHE?=
 =?us-ascii?Q?d57Wk9T5tS2A91/7wg8ijjvBseGFoPtxyvPlZTStNOyaLBUjYtteqknhccl0?=
 =?us-ascii?Q?oA5X3UH9x9DVkL/berTFscYm/F6Mb5KVDoom?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:11.5149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326719c-6f58-4da8-4e5b-08dd7b6702e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6371284283b0..095e52237516 100644
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


