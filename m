Return-Path: <netdev+bounces-133808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61E9971AD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBCBB2328C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1D1E7C1D;
	Wed,  9 Oct 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pyV3h+ZM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53C1E7C10;
	Wed,  9 Oct 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491342; cv=fail; b=udw0j7wlhFj+Tz8mqMwMhAhNsQLKv3I/LHNO38uFo34AXNXo+90sqq1PN6OL9R4boyjGr1QBW0k3swJxQEfqnh55vCQe1NLdUrUbKtSIQ6nIr17lh+WpTB4+W8zYVXyuOuQBZrhzXa4zVtH63pbSlgFV3eX5WqZROS2JDuEYRp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491342; c=relaxed/simple;
	bh=ygcw5p/XRqXoujaH4AvGzs9P/bZ5eFZMIwNBSy1CGsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8vljVu+8bk5XeTjx08HJgt16M6YybhiipSpDlVzQKRAfehq+BH28zFaLfjMEB4pVLmCZAJwF0fH+cduO/TU5hISVJlaPgTfOU9r98wt6WESD1AlOrIrd/XDnGexcqn1uFadzkq+8N2VTa7DTzDQ6vjgN1FWCd666DURXsaP/Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pyV3h+ZM; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBvxsg30z3sGKiPnAR0eYqSY9BBJIeCpntOduJBjaEtIQw2NnVEOY0KP/Mmms9yOBG7RUOreTLhK26klWglqa2W3X3XzNqWE0AauqWPMyH2z96af8yKc9i5JKSOYFv/cErPNvINLPolnZkUCvus1rfdo1TxtZkUZcVOAbUzL0+aJeFVaPZc73mRpLhGmbPBxmP6IPuOe/jlfQ/njzu9BER8gp0nJMsD0ACFlKt1KVf9AohOWWi22xfFQOi8RnWgl1gJA6SwWQeIWSE5fzlwj+88Tareakr8+e3iF0O07KmzYKVfnnWOoKNJ/Q5fA5xgPxcGhDNrR3vIPJEKLbGXXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgCEXeRvoeN3HOEHOXIE+vepb0QSLGYnZYQdL4dlYbc=;
 b=y5VvOk0ZUj0+X/NYe0L5d7NUAcrxqf+bSswV+246xa8YJiA10mOqONBBHvD2yl9GGPhC4K6uH6Uq0Xe14VnGpM6KVi6PMTPsOG56wXsg4LCjr7yFI0Ts7WcDOYozTY9D3SRy87m1hPMisRECjUMueYkyBaAMJARAWvqWvX7DXW4ut8AeGuRZoSDAR4fv1W0FZzFqB4XP/46f1AzMqOtEdr6jMjVqmijMiGER0Gn1yCnkNGODOhBHLUM0CeHUyAlp9fGwDE9HZxtb+HIEMD8vAXWPTr9/K/Ob2+aRf/x2W1vEqIEnS32XdO6/CJ7w2XZC+Uhfv1VMBmREd1fg1fLS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgCEXeRvoeN3HOEHOXIE+vepb0QSLGYnZYQdL4dlYbc=;
 b=pyV3h+ZMsESRT9/W88STz0q8XC985bI5PsmlW7eT2mi6tp8NZsPQuXTD8iohIaPsap6HO0+0IjqR9OE6WbsO0lPWxu1bTb6gbbogQO8xQA0Vu3ad4peMnTDBOoKIVhg+jkatTFbzDFO4q2Lay5swgbEAI3NBKFJX/20vYD1a260=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 16:28:43 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::94) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:28:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:40 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 11:28:36 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v3 2/3] net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
Date: Wed, 9 Oct 2024 21:58:22 +0530
Message-ID: <1728491303-1456171-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: e4795d60-43c9-46d9-89b8-08dce87f70a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UMUl+TGPlavqQCMtMczqx043V8mQDAU6XibO36GomBQy84+yi+sSBk8WWfen?=
 =?us-ascii?Q?4j1zxElcGVai3zkyR6QCbGqDNzqwZqWLhX57KMziv2OR/cKI3Z2xOszZXrhV?=
 =?us-ascii?Q?aBog8jeXb8eZeeSrRU0VkG7rsCWLw0UNK+Ic2EWIg7gIxxbY0vhD70cDoXbY?=
 =?us-ascii?Q?XliDUg8mNHmg1X9P5uyE0HNENPmsiaiFwcD20XZFFv773592JqamBcDPbhhC?=
 =?us-ascii?Q?Dh3qUJKxlndkYEQs/+uSBCJTiwWjIEvm1++sTBNbgc340V5zdmBpvvOw868c?=
 =?us-ascii?Q?oEwO9wfHGukVc7lSvBHlpzYt+D3NaIcm4k4eeFKR2xfv8h/uIvQxTR+IDF0e?=
 =?us-ascii?Q?FcZL/v9sZOXOpQA6p5JPU4AY3n3Pn2Mw8HLPvaa/EpswJtYAI89Te2T2oIQv?=
 =?us-ascii?Q?t1GlW4UVRRSdCbT1v6NyO7k4TAJ7VHH+1YGctY5Z5mA8YL8CCygOYjnpK4zx?=
 =?us-ascii?Q?anLuFHDWBDA0ZlIcP26mKmaoBNgYwac5kBPyqTeve3ea2JQ6gsYl8XsHlMzW?=
 =?us-ascii?Q?crql2YKJitoQI87x5P6zq2Le6nPXjLRMCWvvWk938WItP+QjFQhI1MvwZ9DO?=
 =?us-ascii?Q?u7ddRUOnT899VdSTk9NzxduhxWIEYzn8Mzn7y3iCNqy2/8+yhc+QOxbQusUA?=
 =?us-ascii?Q?r7RtEQNEH4Rf3rhTIKf9WDmnzMV0ZyZBhl3D714ImWLrZG7JlSTnU809j5q5?=
 =?us-ascii?Q?3In+HyzBugIwQEf2cgL1yzOnyeX3xhYQVkxcSyjGD5MA0rwfiJ8i7HztLKGj?=
 =?us-ascii?Q?p+rOn3+I7hrkyQBkBmLc9vcSyCyfEkQD/7N+fvHxVcy6P/8xe42wVnJGhpR6?=
 =?us-ascii?Q?Z7LnQG41rau12iaiT1Q4L0Gta8qFIJCZxw1IxK8hH81kscAdLTbf3PgSJRs2?=
 =?us-ascii?Q?gt10tRjNHhFQPERBo7rTdOWbGLz6l8I/Tnzrd7Vk2/qGkf35RQY4BXqkzzMf?=
 =?us-ascii?Q?2uV8sFXa5yysFWJ4Zq1oreqyurQ3nQJ925yEydyozVbxrH8HB3AmiSW2ixd7?=
 =?us-ascii?Q?+Ei3GyxG8ajF1UZSWjixYKpbR0YHgTQ3fb5XHZiU95QZ5Y0TXHJ4abHMchFz?=
 =?us-ascii?Q?uwtHjtlH0Vjnowq/INLk8F/djVu7SL6HufyAApRyAruyBKmSFYLJA7HoZNeV?=
 =?us-ascii?Q?FY2Yo6yuR6cOfDznZ6TdLaRVa/GHuvDf/lXd0hcz+8Af75tS0qXCTDM2f1/B?=
 =?us-ascii?Q?A8N6UVsdNEe+oUSzUEwuwzAlcHfNwR8N0GJann/M9Oi1bFnCADfyvxc+9/qC?=
 =?us-ascii?Q?9/ST2GqpYORLDgDbB5tn7dlLwHLb4/NLA2kY7O/8KOncTXVWJlWTI2494VPK?=
 =?us-ascii?Q?UTDSG/EmGpNqk9AuTifhRp+ikq9PJntAvDJx6lYCbFb1r6WLGwkRTsPL113S?=
 =?us-ascii?Q?zhKEn3VKPmBnquTLJejHdGRKIImu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:28:42.5796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4795d60-43c9-46d9-89b8-08dce87f70a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

From: Abin Joseph <abin.joseph@amd.com>

Use device managed ethernet device allocation to simplify the error
handling logic. No functional change.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v3:
- None

Changes for v2:
- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2eb7f23538a6..418587942527 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1097,7 +1097,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	dev_info(dev, "Device Tree Probing\n");
 
 	/* Create an ethernet device instance */
-	ndev = alloc_etherdev(sizeof(struct net_local));
+	ndev = devm_alloc_etherdev(dev, sizeof(struct net_local));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1110,15 +1110,13 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	/* Get IRQ for the device */
 	rc = platform_get_irq(ofdev, 0);
 	if (rc < 0)
-		goto error;
+		return rc;
 
 	ndev->irq = rc;
 
 	lp->base_addr = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
-	if (IS_ERR(lp->base_addr)) {
-		rc = PTR_ERR(lp->base_addr);
-		goto error;
-	}
+	if (IS_ERR(lp->base_addr))
+		return PTR_ERR(lp->base_addr);
 
 	ndev->mem_start = res->start;
 	ndev->mem_end = res->end;
@@ -1167,8 +1165,6 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 
 put_node:
 	of_node_put(lp->phy_node);
-error:
-	free_netdev(ndev);
 	return rc;
 }
 
@@ -1197,8 +1193,6 @@ static void xemaclite_of_remove(struct platform_device *of_dev)
 
 	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
-
-	free_netdev(ndev);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.34.1


