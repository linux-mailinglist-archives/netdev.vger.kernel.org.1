Return-Path: <netdev+bounces-178325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB9A768FA
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1145F188E962
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F6215F7F;
	Mon, 31 Mar 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5BYSo5D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592452206B5;
	Mon, 31 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432401; cv=fail; b=mMucrcS8ejMmVIeqqjTfusQl4i42ixnvEKqItoIPp/onSYKLmBdvndiK+uBjsg36dVwddNwPi5HDetTYRpVuGmBlfQvlTlqbT0U6FKuh1K1JUbuVGEjUJTD+a4fhfkUIaebWlt38i/YP26L4+54ErAlBiFAiO4Xtnp2Y3tO4A+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432401; c=relaxed/simple;
	bh=Ai6eiN56IKsFSNLDaCQ+9hVmZRyA5VeYvxLr2xb7r0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/YVc88lzHTJmAiPUetqYJKt7gDAOy6Zn0WJzynUo+4zZaEibXA7CE/6LXxUTy2HEQuPsQ9WwQQzTGOB2980PyOVPrgR4Yg0nynZ9a/tEvMDG/5yjau2JEsA+1/L+mKTkXvxCkt+JVBKricbk+kZBvtXe+suoLaXxjOSocpwET4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5BYSo5D; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlrX4S65xw6HQo//wFVKpHH1eN6P5SUk9SmA5P0CSuv210R2SeuDqQdcKJNp/tL9d5y3l1ZYbz+iJcUEv+ZsaKURTV53aWTBy5W4W8fXdKGrKczF29h9WL6mnPPknWltugX7DkXQ7WmfpJcNqhq7KDg9v9r6VpfQStwxjKXP48VfWwZWtwvhMGKluuswzVbmTfKXsBnwWI5idYMioAhrm0WSNlqrl6jIVRKKVN8S7M6OkenuQfFPi8c5/HlDtV6nFai7QSjyAfaPFKp+w04JscDqpj7uF0yW2/kypFrd+CFwQHfSR/whPvX0BXR5Qx0ZBCUXuY/hI4k1xOowUIMONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB70FYIuQcw2tgT1y4Ke7TYAvMfq0RulEdkWqiNIkBs=;
 b=mVJspTO9lT4Q+TXanXyzQSy6ulJKgs5qrxrCBrL7CjfNwKn9D9MtFoU+OAZ5eM/v479eWqcOrwliwPVJh9UFdAGwOjA47UiLY1WXstHD083arsCwF3UNLOjtYX9+UMUWVF828gdiu8SpLue9wmh5MhM+CKNyx+XZwTrsjpejy/PPTIofez+NR/dBXU33maq/JnpucIdDsvCpRZMK2cuGYmEFhzbQgjxbEKE0h+In9WAaHX6kTzIxYzuC0EZb4DDV03UX57PZ+Y/xAFVjQdvX6k2OP1A/IxgL+naXKwlclDISRm7rG09E3+f6Ckt/9GZIHHkCEbAi8LrzDvr8KDcF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB70FYIuQcw2tgT1y4Ke7TYAvMfq0RulEdkWqiNIkBs=;
 b=i5BYSo5Deoljaz5Fll8RCCmlTIIZ07GvWEvy0c2vzu/lmZ2AYaZDmtJGsJ6/tKf3C60bLS1R92jS44bFuyOipCvUrurpuA1bwTp5mzqQJ4fRPnFE38ozLqu6T/ikzakB+J5AIgm71xBj+cP9+ozs1jJeJE9epaHHGmCHoqGZVI0=
Received: from PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::24)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 14:46:35 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::12) by PH7P221CA0040.outlook.office365.com
 (2603:10b6:510:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.38 via Frontend Transport; Mon,
 31 Mar 2025 14:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:34 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 16/23] cxl/region: factor out interleave ways setup
Date: Mon, 31 Mar 2025 15:45:48 +0100
Message-ID: <20250331144555.1947819-17-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b41179-5661-462f-0706-08dd7062d5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|34020700016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQDySD3QSEkDcC8oba/HSYh9+mF5pP8q7CwipoNml4d8TBy7bTwJmKQAtA0X?=
 =?us-ascii?Q?1cZf8YNJIRGDYMqWXpNPPrhewWP9Xe08vjlnm+ftkEIZMa6F0I7MA/jUBMFP?=
 =?us-ascii?Q?IWV9UVS1geX6CLUOB4q8hI4kAwO4AWDHPcOpwn45UGoGz/dWegMlp0c84u60?=
 =?us-ascii?Q?lsil2V5/fJqTXefBm9xYAHmvhZTgCEabuF8EZCOo5AdFZkQXrd12ihox5jD6?=
 =?us-ascii?Q?BRl7KSRrMSDHi3P50ZmXua6KQ0Fj2+DYvNT99DS+DyNniMKl1lRr0Zo5/QzQ?=
 =?us-ascii?Q?ADGRwRoDXY15ruNOV7JFoht3aVZFDyy3cHoWORtyqlYaypO2nPgcx2CNeK8a?=
 =?us-ascii?Q?etxp5tr3zMXsC4Cwj4eQXuDJIhgr5k6nlqqaK2fFeFKcPFxDQw2ekvv9O6Q/?=
 =?us-ascii?Q?XnrxALfqNKB0hE1zaETNG1F+B1USugFvNNMfXHW7KA2hiwnQXmbKez7Qb1Qs?=
 =?us-ascii?Q?rVI9q22oHKO4hDejWzHXLysJ2Dq9/CPVmc12QCv45xkK6Ne1554Pet3OgOlJ?=
 =?us-ascii?Q?MZQ9BKDNcpaGYhg6WKJLOOKcSCbDPDRFlklRWudCO8m0g5iSRZ6sPBnUks6e?=
 =?us-ascii?Q?sA/9QIzOjnV9I14wQuCY7a5lLj30ZOzl4vcDBUaZUT/p3fj+xh0HTiNcN1Vn?=
 =?us-ascii?Q?D2l7O69XyexYyzkysVbH1h4IGKiYuzNj3sJGbUEORwbHQw2hoo1TRH068L5/?=
 =?us-ascii?Q?t0x2UUQdLgmbdjJzs7pCiQSTeuyRslTKDJrNmubGgEnZhRJ3Rud1ayvr3W4G?=
 =?us-ascii?Q?urgl/dT8B7lZZkglK/voGidDB/6+TFz7bQuveMotYPcKfmfpO8PU1+KBP/Le?=
 =?us-ascii?Q?pHcEmcLuvNB+w8+w/lPm7kewVMpTx2MXQjnToxFjlfo5rKc9inmdgIdn4Qry?=
 =?us-ascii?Q?fkzija2j4ximi0w9RPaeZI6ejODZrKTvUCIJet/Vb7SU/MIoj7VVdOZtfmmz?=
 =?us-ascii?Q?hzW4FKSMDe8EaHPnn+L/SISTQ9cfStlgijfYbPkGbDLJwlGYPhJxSrNijrwM?=
 =?us-ascii?Q?kXeP9gjvJcxnjM/5bMrGmqoJES/IbExzG5+cfTPSmYGSmrB65t/y4uRwc1rM?=
 =?us-ascii?Q?jTfQiUr1b/0bfA5IsM/RLIwt6HfC1ce5yaU6sfy1BpisUU2yuLtEolh/1QJk?=
 =?us-ascii?Q?AMNgfEWsglP8eWagNs4xwSKi+Mx/Hzt104UAfiICtQr8rcvmngK/EbIH2mDF?=
 =?us-ascii?Q?FAI1H1dTzb67gvPLMFPrdqluJTLXpaRRk5iZCZuZTgvUf411GFZhkvVmLt6X?=
 =?us-ascii?Q?CNe6oI3WcwyyRK6qdSD7i7ezznRz9CDjbVAaG81OSYWE2wmAUHrresVh6ymp?=
 =?us-ascii?Q?10uPMRqTEZtHZW/eDflzKBW7k2HPh2RfmQ8G+9jO37Jt0afBNqgtLQuOpgIQ?=
 =?us-ascii?Q?D87EY6xNGDQpb9UvBOZjjUTy9jwgoZTttWgvX+SJL2hmTKVdWiplu51bfrCA?=
 =?us-ascii?Q?juSXMfowTJI7IeRJGGczz+4ozv/xrPWZ38uKnOdmef8CVI4Bc2E6z1tI/cEL?=
 =?us-ascii?Q?fQaBRX1kFbUwlow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(34020700016)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:34.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b41179-5661-462f-0706-08dd7062d5a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32

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
index ad63fc7b3ca8..816f974a4379 100644
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


