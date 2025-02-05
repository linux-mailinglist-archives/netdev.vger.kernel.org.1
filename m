Return-Path: <netdev+bounces-163057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5289A294CD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6728C18957D0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30D189F39;
	Wed,  5 Feb 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JhehFRX6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42F188736;
	Wed,  5 Feb 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768835; cv=fail; b=tdnw5FzPBS7eHmn069K7ToB8oknwjz6cWwoYkDw0vTR97+ERQv2HKSbIM4waVQ2ZFFJz9SZcsU8fPKcmWwylxVgqcbitV7S+h2Hm0vbc5zvL0LyO38GjNvbYK4wfXekZJ5YWHeSylc81jmE41sM4pABmuPWdh//Mstlzb9jP2nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768835; c=relaxed/simple;
	bh=XvwzD4WHOopy5ea67q2Ihm6KgPyutmJZaOfJY8+0IgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orUa0OWVTSZkbf9tWYp+C6QohreZqe99XeeoP6szXbjeAyr2/vY2NUCcD9iKD6xYHl9cyyByFbPMjC4q2zx5/gSt0e2M3QNHmedjyLZ3jjgqBrmtHXyRLjB7/O46+8SsZ+Fx1hL44S7WbTauonQPYB32z+ozWaiU3dyjbFq2yJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JhehFRX6; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHhU/I48NVAqRU7n+NGOGz5EYWAAk3mSFKXj6wRvE6fxINS9vN/bgGorckki15sPTUAb6QUE6jcZoj7wTkzdEIm5+kpNnEtOnhMwjrmEMd7YDJVvqWaKhA99VMeVc52Du4YZvbeQDu1wbs4IUQB8/uhd1cM2SJi015BAyMWJOcvn2hpRstz4aU0UaTQwfKihb+TvAE89g5NgHOuJbs0gTBsiex6Y/U/TUPwv+82+DqpPR87JZoMvorepd/257ZGo3Td8R2vbTlQg5bJgT7wwrRkNTfzyVIF/tQ58ihG/GJCGFBgoktaRydqbASGxsPyV8DBZ7eR9vjRFLD/Ag4kQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6TgMeh5cTTUgyFp/0YJE0A5jPkXPvKwlp3+kCN08TU=;
 b=yUuSKVfsvqZluCdyJ69DKuzQ/cH0q6CH8xfRAPfmOrMX8U47bmG5dJev36YxX7is9fMq4/KhGHjQXyuWIknkX6IlEi61QSbPUUFOoSyVYW4o3QyFgFGtXioat8pCBZM1Z8i04RTfqfsGe6V4n1wd29TRBXgZa0MCWQdXKVjuOAg+cfg2dB2RFI/hKB7R8dleOJcguHKGNYF4GK9Lqwjonlbhwjrtch/tlwjKTidR342lhsui0JAH1JuDOyGHA0W5AgZFx21Ly6lcgjo49CIK5K33FiZ1KVAVXuKpHfm2Ed+8UC9GTw20Iq5yHM/COvbjgPAJk5oEne/ns5RL3qBQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6TgMeh5cTTUgyFp/0YJE0A5jPkXPvKwlp3+kCN08TU=;
 b=JhehFRX6tkEq7g8ox3d09tUzHeNTgTum5oliZBK64gTLMT8pFXMJZydMOgMkr5wmLlfgjdfnN5BiFUASOSX9W7MNCir4FUETcRj3MSU4JGYXmMnPGq/SK2kHdDeHXYK9GboBfPKGwIXb3TappMCWKqkfRF26m4yexJYFwXAEjIU=
Received: from BYAPR08CA0039.namprd08.prod.outlook.com (2603:10b6:a03:117::16)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 15:20:25 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::35) by BYAPR08CA0039.outlook.office365.com
 (2603:10b6:a03:117::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 5 Feb 2025 15:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:24 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:23 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 19/26] cxl/region: factor out interleave ways setup
Date: Wed, 5 Feb 2025 15:19:43 +0000
Message-ID: <20250205151950.25268-20-alucerop@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 11be8d6c-69dd-4dfd-0674-08dd45f89d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Jiuf8Y6pa6QJK70uZE2tWDlT+iSSQJWzaDy8oLU406gI2o8MduQTAkVk6es?=
 =?us-ascii?Q?uWXWGVMAXf7O0ZD5CfdGGG+UnWmmVfubKAm12munONJVgC9hCEjfb0HrJmay?=
 =?us-ascii?Q?F6CUzRCKYlnU8nY0fyQInnJ3tQyc0fn6VQFXjKA7gypD+Zn5oWtHdHyIrbNG?=
 =?us-ascii?Q?lhANR8JGryynN0WfwEHXhmBLmcCPpEziX0fd/YAd7Mcpnd7ya3tAjtvN6goX?=
 =?us-ascii?Q?bnwcrH/fFWX0YiXFPMnbAH1hJLeJlRzBJcKhGFg9Oox0E1BwHPUhF2Fl3NP7?=
 =?us-ascii?Q?6/Ayp9EBvjXxN8KS4tmPN6+oJ2rC+sJEU1BH+fpGp9F+XemYpQIm0fo3FRkO?=
 =?us-ascii?Q?C0JZgZc+a9zvug1aO5mKsYBIMhcn6CkuBrw2pGdXDeIbXI85r7gl3yKuL3JT?=
 =?us-ascii?Q?6LNmqNjiu/weMwHSb9tXMekE+oABAbltmOLL6yzezDGbl8fOK1ffIOqND4SB?=
 =?us-ascii?Q?bULqXZmTS4emaddqo5P9y8TB6JHRi/z7F4xHceAi716HfYsdcPIwva2+sL2d?=
 =?us-ascii?Q?xwwzE/jtCdmuAYsnVE3MQJmmoE7tgdIxDyipo4VZCXoep+6vmPGCRHGWVD+h?=
 =?us-ascii?Q?avbKuXtQbQmjYg92mwuUpDQj9kDiqJbPabRCpbWTxHEsETXLq6yLYDwpoonw?=
 =?us-ascii?Q?jTIrOXtja/s09QIfF7JRo0NcOr6KfSSfAMeV1S/WwDTPzPXfCQOyRYO2eBbC?=
 =?us-ascii?Q?wkCy/5+L4KSFgXPZdzfCfN7eeQpjYxtvAiMBJ44qlRvoOdiCgWtUpq6L5HCI?=
 =?us-ascii?Q?0/blyPiMgXwP1fcnzHVTOhC7ajtZMEcEw7BD5ecGwGqvjS1091DeM/YHt+l7?=
 =?us-ascii?Q?iFemLr/r1qo0cr+Hmbu05smBQUgPi8xk7jNJEuZM2oNBb2ptjVbQyAe42DD9?=
 =?us-ascii?Q?rKPaEIgchXmd4kaQbI+srsPOe1VvhaxWWKzOh2VtLd6iEdJk6Rsr9sR8gdoR?=
 =?us-ascii?Q?QkWV4MX9Juc/8lmgdTCUM6Ov4t6z17DPvCvYxV6gLtFMfQEVg2euPORozkwY?=
 =?us-ascii?Q?KFtMkiIYgwo8wRE6pO/jy5ygPWDLxeRJSyraZhvUA8jWWBLEz/KmX7jmUQlD?=
 =?us-ascii?Q?TxxaKxt5bPGzRxDXZhP6M/cJcMQ2DdEygE1GQrX+RzgAq1bagObTvoreb8nh?=
 =?us-ascii?Q?CPGKnJSXS6G2JwLWB5rzPX0Z68bv16lj25DMk3i0QmkWRUDSFtkmHZMK7IZc?=
 =?us-ascii?Q?uWwJJd8Ib8u2eoKxGaaojsMGOFgb0N5wCkSHX3UdUgpHf6SRJ3TGNbN00eqO?=
 =?us-ascii?Q?2FPusOMwVJrZUE9kDTGXjgm3uVWM0w/59UxObsv8x0ZaXuAA6p0b+L/kSX78?=
 =?us-ascii?Q?9vcSF294583zNcCfikcMPAAGglw2/HOdlboWurHew1o+FQCUMDW4u4ocjlNq?=
 =?us-ascii?Q?ZgZlEQmFlOnVi371H0Dg+/gPM8X326/yJC6j9g6HiyHRD9bCm6+7CA5IgOK7?=
 =?us-ascii?Q?w98X1hce4BviabOkyJ98yiqmo7nky/ZuxEtEtp+eFjdTgL6RKVhskkNPXILA?=
 =?us-ascii?Q?c0sB/zwfuxl7E3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:25.4151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be8d6c-69dd-4dfd-0674-08dd45f89d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

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
index 22ecad92299f..7e911793c0ef 100644
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
2.17.1


