Return-Path: <netdev+bounces-163055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C666A29482
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0814B16EC26
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6371B532F;
	Wed,  5 Feb 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wf8d7SR5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DF1DB34C;
	Wed,  5 Feb 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768832; cv=fail; b=L6VGCi0tadM1SOSUmDOUO7SM169579BpsfxLygCj82BW7/e7Y8l345fycu6inGO+jJYDkckw1XFvUmu5Niq9kJxyjA+wfLAVIxinLKTvmhNBGZdM5lg1kg4eFb8VJuomSSHcMd/fsQbAr95nlUjtQM7JxZsj8FeIg6f0MkUNkPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768832; c=relaxed/simple;
	bh=k9Ki/p4oIpjHtl1yh+eJh9KO/hfDwNYwsROqv0FuwdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZRe9qG+MtqwzhDD39Lb6mg7xJF1uhnNMyNR4GIDEolxqLzrmd7xL7MUR3JhPK960InyZ8qMC9/ytnNEw0t6S4gUoboXCX5b/N0ny6Fuo5D+dHdoT7Y3HN0q2CXJZCCzejgMgQcY2nHXyfJLmNjjKCZW3VFMwDxIQwxdwOucVHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wf8d7SR5; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEuB2kfF3KPr3jyAeRTQBmkBUGnLIvIzCGaG1teE9dPea/xPNQ+nqQv4vx3thSZkajXA2er6Ujy7RYq0Zs8XOutZohujfch0jliXLuaYUomfRY7xZ4Pc9oyLjRBwXeZVFa1ICedvJjqfEw19MpdbcCiKgPqHOZkstcA++gW4ccO/h1iCb64Em1tspGGRfOlh4wrnZ/l+dmjs9tyLcZ8WDR9L/VgnwYRxnSICN6dHFqo/vP5f0zgDJjrp0BW43UkkuZNv7oZuTT4MMGYhXOquacoyHWyQOHAM0ijKAxfN5Yy2KVjhq/Hu3CgXn5zfQI220mCL66rQg5zVMnj7wUEoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfB+sM8PbBtfR8ylRjigmJ3oFb9y/kwAO0gRp4OqjSk=;
 b=czATrVbeA5FOeI4ZZPQqrp2dXqO6W6fEhlBqsoIRTdItnkJcKB1WOMO57zqD+MMvUNmQvIC6hrSQehjpCFaf28Vv/apbEQlVO2LmU0AZCSuryee4N/8bZpmwnaFh7YfSWulALAYfwJ2aSA7I3KQtHgsJxWpCE1jpVSwv4OPPzvwSck2qdb4LeyaLj4rEOksaGdEgjsJmJDut2XIuSGC24F45Zc31Nrro4d30Z4UmXV/RTmZCcOs9/+W/Gnj6ASQAYKX90Fc5i1Qp//+NL3Ve32ALWU3z6k5R1eLrhMmbZ+ji33E3m9Umg5QI7Q0Xl9j8x7nHDhhiFdtRsEi8zSl6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfB+sM8PbBtfR8ylRjigmJ3oFb9y/kwAO0gRp4OqjSk=;
 b=wf8d7SR50EbdKBWeXHhwSXHkSulPDEM/CSU7nOus0KRR1zjGnfFAyy5oDlfhdTFJqPLu0HCpsmq8rkK6tQ/BbyurN8wyxcTW7ZotSocl+ZD0elHn0eQ4PGTQPgGkov7PZ8x45djT8cRqJesqoMIIeLgeGdif/s+engQF85m/iv4=
Received: from DS7P220CA0056.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::14) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 15:20:26 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::37) by DS7P220CA0056.outlook.office365.com
 (2603:10b6:8:224::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:25 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:24 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 20/26] cxl/region: factor out interleave granularity setup
Date: Wed, 5 Feb 2025 15:19:44 +0000
Message-ID: <20250205151950.25268-21-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 421865a5-028f-494e-1c33-08dd45f89e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/cHoGukBWqCdwUO42KFvD5os9DjCfnSv5TS8gOZ4WbmKhCpVyAgEj9qiQK/?=
 =?us-ascii?Q?2dZn1JK6JkLi6ML6hqXGGHtbF/7gavMmtm0VT+Jk/ZF7v8Fzko0D/b9ISc47?=
 =?us-ascii?Q?/MeEEBEAXHX1h/y1jfDz8XX3AVjC9tsDIunBfeYUqOGwEaNWMLz4kvWrYDgn?=
 =?us-ascii?Q?O5WyLjeYOafIAE4CkBClULmI0pSNOAZ8ua2rxuyRxsPRcZ7yk52VNxRiV/CE?=
 =?us-ascii?Q?A91/LOruNEUMx/IaZ01ShHldggDEQZyq5rwFi8CDgUa72a8jJv60eKJMNOJB?=
 =?us-ascii?Q?3ks/9TCFtbTWghfZXQfE81gyJNHdwPb4CQOLPOACwN0RB68f5YHAqnH0ICi8?=
 =?us-ascii?Q?qgF2S2s0rffM0k7SYIw0EzBFkFWUVHvEogONGLa1ev7Y16VZcW1xZyo2Dd9k?=
 =?us-ascii?Q?VYwk76U9aTbnAgahVIe2bU8k2KHJc689xaK38FdyH/4x5SyIMtLMJcglDSkC?=
 =?us-ascii?Q?eLIpY6N5c+wWYPL2OlILXUYPuWnAtGJSPCe8kkqow2dZUd7ahVOESLp47G+N?=
 =?us-ascii?Q?mkz1UoHF1YudsQMTcqUtN2NwhTDvB+vjoitLBYTJ0gMHtTePrF+/o/zteThl?=
 =?us-ascii?Q?eOrhw4CkR7ZcRFxQ4N5O0O8WO2OnsuAI6rlza0iTQScJtQ8a6q2G7IrmsyBg?=
 =?us-ascii?Q?PcwzXt9skdYe7YzBYLpeyRuHwLUyzJDrocz8/sKkYjn5QsREpifGMvUev7ju?=
 =?us-ascii?Q?MjV5VWzNR8gBFxkmrLyjWoVavCE2iQgBIq7knzj9ed43PuPHdpM4USW2SJY9?=
 =?us-ascii?Q?1fDrrUx8JJV9lmMtBiu1yZ7bU4tPoot69AWQIWiT5OktYRmwa2/Kr5H2lQ4t?=
 =?us-ascii?Q?riZ4j3EgoegsB4cFRJY3oL25CIhgkp5JJq2L3O0bMc+ldbWXXUFVUp/LV7mY?=
 =?us-ascii?Q?4djOgK+4XYVeNQp5bBtcM8+aMXip1uCjAs2y1vYs/TO1mlYtfxy9B6cVRbXN?=
 =?us-ascii?Q?VlXPkndRe90Fdu3aGTME9dkE6H8MLnJPCOBXfOCIzz2RPWNa6/VO5WI7TGM1?=
 =?us-ascii?Q?guGNME9RRSuJ1uem56dHtV6hxs6BrdbT7JdPFDMUjydXKDJ3QS22zfZr+aVl?=
 =?us-ascii?Q?TNtFct7+8I39aeWe42zQNzijIH0NauBkdr4vL/32u1bR8Au1Sg9MwOtPrdW+?=
 =?us-ascii?Q?cEFKHqidvKiDpMrxNSw6//25+Ij8i7fJ4oXMrFRfOWf+EZnOXYP9+f4ypEM/?=
 =?us-ascii?Q?wzrGsWxNO2Z1jL0HVT3ZlW7CAX0ooNSI1h2oeQsq84gjH7sCoumXDReeieg+?=
 =?us-ascii?Q?K18ZlsaXCjUklmr3+smCH6RFyJAFSy4+eyPKfBUDKj8Q2r5LH7fvOlmuq+TZ?=
 =?us-ascii?Q?RJm9n7jXPAeMwKkZw8U70p9zLuuJkxLiomYx0296rTPLGsX9XAg05yxAZTJK?=
 =?us-ascii?Q?SNz40eKc6SRAasuUEFFe+FXpAA2KBHEhdjjH5iYtZTwTrAL92+aJmdQwac2d?=
 =?us-ascii?Q?rF5WhGzYNMa2Uunj7Sg+OE39x9egeFlBhXQ0viq05PX3+V44aPDyJAtN1wKP?=
 =?us-ascii?Q?Vbhvg51mmZLbn4g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:26.6165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421865a5-028f-494e-1c33-08dd45f89e58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

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
index 7e911793c0ef..60db823a5ebc 100644
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


