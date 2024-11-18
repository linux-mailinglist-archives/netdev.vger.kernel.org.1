Return-Path: <netdev+bounces-145957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2999D15AD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254B61F22D5F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923E1C68BD;
	Mon, 18 Nov 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afoD7s7B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6481C4A38;
	Mon, 18 Nov 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948323; cv=fail; b=mga1V1UomCo6SIG5LO6D6ERr1vYUbTC0sA4ZFXfpxiCFangSBYUc47pZO/maFOm0eQR5dPUrRD1YQ6Tw3Nq9q/YAP2u816kIs8A4duGY8wGQZkX82/l2YZW6zl0YsRCWccAxchZP809f6zzXRk7FaqzdXhtwUV7cbLQwk7S+lhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948323; c=relaxed/simple;
	bh=GlD7okOFYcRo0xenQY7cQCJ1AGW+seGBim86tYb17DY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgPC1uEY6RB9gvW2R7HXcEwtWS0wiX0uMB8a/USQqcwq4WWAPFv6RKpd340fXil7S8p8d6wU2wfUgAkyRZXmgCn2oLGBwSo7tCqnSwRxMGb58+v9etEe9MOZQfS99YQtxTCJ6OnxkZdbCKXfdNC8oYugUeVK9pMu1S0isTGNoFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afoD7s7B; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPvv7moNnXjuZmLB/reqvZRBswCtmrW/q8n/71hSF56ZVcTqWfg/sLjNXYy0bUuJ3AT9pdE3Ufl+ZdM16bDuk00i+hF4TEG/jiWaBCMEFPBtzXLkgD0z5wOWzGq2c9/1Y6ZukYaVm8yctyI73xI/R1miaba6Az+6DhawlNaDkOMYltwQPmdYU1V/ehSGetyuGERO9pfT6D1rOKLSxBj9A8gPDo5u69IliS1u4Gz/c0qjtFFdBBniXHVyWi1k3PCoKMSLmJwzxQ73KHWlo61sWDjHUhdny/boN4oIWWaE30DA0FEz2GzG9ZKQxbYxp3+9Ngn/IqGkXLwKidd49+ehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7w7EN51qNM93rBnB+cBz+YY8U+Wi99HtMyoVZ+LwtI=;
 b=Oj0gPIgmFd+lAzktOiecQ+YqUZRthmBHdi6eP8Pa9uqjd77HAgiq+iafOx7YIT8D+MAW7GeDMY7ytG20nSvBYq7HY+mptkoseWdaQP9pc2wAPYaZxSSRkWLvdibDMXD+VsMu3DxzOZ7Lfj9i/MS+4nfR6ekO3LidWO5ktajY9RUR4i/bMax4o7v1c6xhR02zAGNL5ig8VIXS7dg0t+su2hqWjxvO8pnDWRhJldQ2O/Pmb0Mp4C7uxNWNaNCT8ToWj6tltqY4mHblqtWBWxtKK5huN+a27q/NUK7PhN1gGSgnUUMi3gv+bbwAjGjQgr9whxMJvGDvmaxXddL73vZIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7w7EN51qNM93rBnB+cBz+YY8U+Wi99HtMyoVZ+LwtI=;
 b=afoD7s7BNN2qsCXVchMWLeChOZPzPASadNHvJwHEKWQPSP4GOICedYn+U1KMQL9Q6B4oH+4S4EBffUovVZp0gvx1PiIQsOQqoUmqKVadk4JVjFcGlWqbV3VW8v/4/H9RbrtmwQNJXKzDLeV/llD2Xwpe+SPY+B+4dV4AbeJ1x1Y=
Received: from BYAPR06CA0065.namprd06.prod.outlook.com (2603:10b6:a03:14b::42)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:45:16 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::49) by BYAPR06CA0065.outlook.office365.com
 (2603:10b6:a03:14b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:45:12 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:45:10 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 20/27] cxl/region: factor out interleave ways setup
Date: Mon, 18 Nov 2024 16:44:27 +0000
Message-ID: <20241118164434.7551-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4893d93c-daf8-4903-7971-08dd07f06146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFqrNtwsLRJS3umRLLBDb698CFQlssmHZpzhmND8QdLQs2xuwvvna3dh5KEz?=
 =?us-ascii?Q?OFTgtQZC1mdB6l/tn1TAvEr0bEqqDlhzhoCtVBc6/xwMUOw1rQS36t+NrHv0?=
 =?us-ascii?Q?bFHAqPHV0uYTFHDywIysjTpiIIWS7pgqxr5KcfQ+yvd91jQLUTmROleFW6rb?=
 =?us-ascii?Q?tNDRdqZHUSNaMXKu47Nluq9UxcGBBCbVzYOEisGQe5GOiW3Tkxgf7UEPvO+o?=
 =?us-ascii?Q?gOZrABk2PTPzDZcIWaYuujVFcoYhLIF39FYa6sFdJYI48D/PfeaIMdZ9x8fe?=
 =?us-ascii?Q?fk6duy7JlNbTg+H8ILMda+Lnmf9y/Sp+//s2/E+oDKu4TolzgVBpH8dAqmIS?=
 =?us-ascii?Q?q0dRo27LTD0uozMvs8/u1NwPGPTpOzH1iniLDWnAAogAgwPVC5apgpNSokps?=
 =?us-ascii?Q?ytdnlRUK2ECjrWwoJhU0ZmR3GA03CADnz2BxBZO6QovVWDzNQ3n4VmK1vQTp?=
 =?us-ascii?Q?Zyujx+X8XwbuejI0KHQ0P8b//n1A8HclCFbg8T/8rJj0wvqmgY1Ke9ytyJJx?=
 =?us-ascii?Q?1pvw/MkJI0GAwjJa6SyQPHfX0CVNyvTq2f1kR5MWgjxiLxU8gtOMJI9Mqew+?=
 =?us-ascii?Q?/QGqfwy5/CTmgw6ukUmmIwrX9dACp9v3esK5G3vorXC53f8WkihJppdRYgnR?=
 =?us-ascii?Q?xXubi8sfxrso6oGQ+/jRcxZXx095ZRskc9IZcN8X6C2ATquaIqRY/YAj+lbl?=
 =?us-ascii?Q?cdyipArJo3/ErD5u/h47hWIa9CzG8QwBfezXgn2kMt/Sml43GWx3QS3l+oyx?=
 =?us-ascii?Q?kkG64sxHown9LBXmtlvU/bLrKBr+VVGvCp7tPlTP3S//MNb3oSlyZNhuSri5?=
 =?us-ascii?Q?g493kxmWxYXKF0TwA9mJUrYzylmZukDrsPA/KfQdgXwvprC9NevliBC6nAo1?=
 =?us-ascii?Q?rubcuKrw5vCu8/VgtTbDY9ZkzfyemynUI6NDDd1OmRegzEpdofSF/M5+MwBi?=
 =?us-ascii?Q?wlAecX2RuXXdZLdp5rxTF1jnt7UR7LPSOYFJvFlZNNjVDoU0sTtrU8NlMSpX?=
 =?us-ascii?Q?qnt19gHTv/mFA0zcDQd095Vk/PIE9+Eux6Ht4RAbw5Q3fzS4WR+Ljo6xFWrs?=
 =?us-ascii?Q?IDmbc31BXVEVRLbNnYXldRxu+UUA/16tDhscI2vqa1EyfpmvA3hH0NGySdgS?=
 =?us-ascii?Q?zkclIpPd2+UmT33x1we3N5CqAJ3/XXmAlcovv2rDapoDVG+Di4l+Cr3GRLpK?=
 =?us-ascii?Q?7qER9DsjhgLmBCwTt+1m7RPGHAZDGVVm+S/vYE7TfIJTci0NlUnvGmC+uskb?=
 =?us-ascii?Q?5LT3nzwdZ0KTftJ17l/+vGe56t5BPt/IWXYIhR3wwdb6U9JreRckJAthLGEw?=
 =?us-ascii?Q?jECZu5uG1vmdw0+C9gGYTDHp4boebN7hgWCWgt7IWNwN4TK7Wo99qXG/QN1u?=
 =?us-ascii?Q?mZKGBQCgO3Sp7vy1Mh2nCgDtb5/pxpx7R3Hob8TTPvVIIItZOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:16.0469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4893d93c-daf8-4903-7971-08dd07f06146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8e2dbd15cfc0..04f82adb763f 100644
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


