Return-Path: <netdev+bounces-244374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0ACB5A22
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AD7300762C
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7A308F3E;
	Thu, 11 Dec 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bm0uww6U"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10C304BBA;
	Thu, 11 Dec 2025 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452551; cv=fail; b=rxu7Sr3ymrR1g8BNSGJdrnoD3KwK+OpYxTzw6GoE8VNxJlKjWzzlQSKqGVmNjzEQHiIooD6b+j1CXNjhaY1usIjqqtSoaxRLg4klnq1eV/A/HXfBiKrz8Gw/ihLVaPSYHPm2roHQJq3D3HVo7SmIt1R/vP77cN1uSlAW2+DvRMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452551; c=relaxed/simple;
	bh=AysofR79Gh5jpSbSohg/ZSPJAMAyTJl7nlcgq/1/3GM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljds5WkD9/sekxQzbTGc61wgSPofN8j4WeakwPGHvSSPplk1Z1dSzPiiafLzKPpWsis9TBW62D3Gh7CVcJ7v8P22NKIRBrlhykTN2hLI+Rro8N+7JB2ELC99fStLMDtgP6IV/p2qLhu/9GIyIPgWdrW4VG1TeWKHgSHhgmi8ktU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bm0uww6U; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIPXEKSc7XTom5AzEKK4nHVptnhmS30//7Xw6i3CtoHc6BnVo3XGhZa2Qn9qTz1NtIgSCMcJLWXsuvKzElRkn3AfP02J1AsvkZDi4u2fN4flcVBW0fAf9JLfIJhYNG7cXrf0gnJVZfQsOn+oDNQmsFx6xYPdJKCiGV9yvcgRUe6KrmX7/8fmifqyqTRxDrnjqZmdleXvckIYInNS8p1UMLPc1JWuNIY6+DAVROwa41Q5UioQNf/CTE4BVytq8aVnf2Q3uSYh1mWUkb1OGKhuJmDBgpPbI0o0TF7B0B1CST5LE/aeI0t1Dhf0C0Uza96s5MQPkPWg3r97jER2BjLeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adLR+QS0TmBGZeNNs5k66HUWxpi4OwETw7LyooVNtB4=;
 b=codIRwxALz8zwg3qAnivMIMJpakNGbhGRSvzRnqex6fbtyHu6hde9cjNrvsmkKwwoZHZO2mBTqguOJdHdHtt2U2TN6qVxXxeiMXkcg7y6QFP/gXuNYRh9ncPc9Q7OpSnzjnUfouFOp99OsonSoQYQ+WjfOkOsBEejb269wSIq4HOzlgrLk84swzu0YflPjAN2zGcpv4FPOu0inB81Gyjnx8TdwzFDj1fUfWtEE9hJ7pGfTS0PgaxDen32vbl8b7z04sQmdxoMES3eYb4LKKA1oEK2MtJ6k3e/7/ZVEZQuHjp81YELXyqqhNjFHlK/TwI8u3AVZsmlug9oD8jzDpFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adLR+QS0TmBGZeNNs5k66HUWxpi4OwETw7LyooVNtB4=;
 b=bm0uww6UVPcZiDcDanS/EGaiYKFoIhbgir+RfMZjTwcZ4PbnLOkpOecr6FEJkOUOonEGxaUoNvQJ++BooVEYbyeucU4i3a9waUgLgmDK3QG1PPqpxdDYGHgDg8yk1eMzPtTuXcMs7DAUKGJ7rJk95GkH5SAVYUdCN2WV4J7C9jU=
Received: from PH7P220CA0138.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::31)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 11:29:05 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::ed) by PH7P220CA0138.outlook.office365.com
 (2603:10b6:510:327::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 11:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 11 Dec 2025 11:29:04 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 05:29:00 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH] MAINTAINERS: Add an additional maintainer to the AMD XGBE driver
Date: Thu, 11 Dec 2025 16:58:31 +0530
Message-ID: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 713cb621-2cda-4a91-b009-08de38a87d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRMM+Zvhbb0xykykALA0aRUuNgUqYh4MjabfAPZ9K+r83BvAyM29sUo2FlCK?=
 =?us-ascii?Q?jHbNg2cdRZffbkTVxu/EohWpgnOahdUnluZ/QwNhMa0ecZul2WFToVyakVK2?=
 =?us-ascii?Q?hvKBrCJ7XPEWsNyZH9I11XMkrvygWY3+ecHU/OxlMmK/CfrNb58nJHUmO44A?=
 =?us-ascii?Q?w1nqcshpmRJFB7biVizHqXdj7O7IEtdUWbOSA4zf/ZbOCAwx15+OqLQcJSiQ?=
 =?us-ascii?Q?Q1ziNvnOZHNWw3z7BJTsuorKCvJ2XJS79xL9/P/0njrMfjcuXXPo4hqJTE4A?=
 =?us-ascii?Q?Xp0i+ZNI+1pIteFD+BBXaedKQf348ZQt4FZfhIM7DOEB5KfaiIpRgX6qRx4h?=
 =?us-ascii?Q?5QOPAXznwneZ1Adg+dfwag1g3DmcyjOn1TFNcQp85zKZ4bhW+8Gg1BIC0fQE?=
 =?us-ascii?Q?6HETXd5dqGNO3u9qAM4lmISkhAkqX4aPw3BR0xJgrXJNG+IjJQhivWHcIKzl?=
 =?us-ascii?Q?5FeMw4zxTpWJ6c2mKg6+SIrStqaKe5+dcbWUQbis4YWNKYCnWUsozI24XwxD?=
 =?us-ascii?Q?FQmge5bAXqMCLx92Wwf2y0jJpW4wXRw3rFj2KCjTPve5Rp3Sb02QmVisQdiO?=
 =?us-ascii?Q?jIA0/KjKelOgKx7vaVvYy7OSbTU0UfW9a+2ByVjMwIp3hUJIr9waRMfgDld1?=
 =?us-ascii?Q?q/hL9RfG8zKwOiFyJRksFO4K6esiNuGN2Zo7iZ7rqfQPGLie/Zf5+76/5WOH?=
 =?us-ascii?Q?jyb32zJNwKUkBfHV+yVnZybvvj7xvvMCNtNmHt4HIxvWYnCvY3Fl8S8pFELK?=
 =?us-ascii?Q?fti5T3F84OZNW+WIy0Imm7T0bIY2/0rzUJPyQ8sxoosV4vjTIbMg5XGV1ZeU?=
 =?us-ascii?Q?RF6yP7XWZwH12fjmNi2QFKV5CCB4kg/DNGQcb4rAIgTlXm9/LvRgyYNtj651?=
 =?us-ascii?Q?CN39rx0BU+cRwgFPFkPP3+V+xiLfFeBrxe+svSYCsUmgkJi4D/6DVUjrwUQF?=
 =?us-ascii?Q?I6MvygVpR3aLwnaZRZGhZiG7NufYWgwaXPBYtGBk/dqOK01lM9RV6IEoTIwf?=
 =?us-ascii?Q?pNIpWOGRu1J2i5eIJf2rrvti+5d4YeKAo+6zFyvx09YeC5aulYGAEPhDUFpW?=
 =?us-ascii?Q?+CQcDgELId7u9tlE3nD3teHdJPyytB2nWH3I2rYEmp/DetslxgqNdlqM52bo?=
 =?us-ascii?Q?Su1kM2IoHYSH9+r6O+L+PsqeOj4piCAsAV4WHb0NVmnaYQxgkUtNsnDjURk3?=
 =?us-ascii?Q?rx4MtKGVz4SMSQaW+XcXJ0MAgXbOjvyhKhajjn7u6Eew9miiqkiTgVpuxJin?=
 =?us-ascii?Q?XH4zkthVVaSi1PARe4ssVn4d3hXpQPXEco6FUQwOz/kVDBSwFnK3YX0FZ6cm?=
 =?us-ascii?Q?EqZpuPcff0tr4FAhQpAf5PD7XiM4VCBXy6/QF62ghV/su/8xqWHiAzrMjMz3?=
 =?us-ascii?Q?pPrYro1/74p6JaDXJGN0Ebg3ugAM0TelorT03L2IjByBl+Ff5KLuWHMYiLy1?=
 =?us-ascii?Q?b+DZfSATt9hMYi1+P9Ith3vades0uRDuC+d4+YBYcW8PjILupr0bTfd274OA?=
 =?us-ascii?Q?EqbZjbWRXIz35ieZ4ZvzyMN+UPupRuAXorDDUlESPkj98BS8jg6Xc9pIKIWB?=
 =?us-ascii?Q?jxXnO96CKg24ZM2E0sE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:29:04.0943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713cb621-2cda-4a91-b009-08de38a87d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

Add Raju Rangoju as an additional maintainer to support the AMD XGBE
network device driver.

Cc: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8f06145fb54..b82621a8c0ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1271,6 +1271,7 @@ F:	include/uapi/drm/amdxdna_accel.h
 
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
+M:	Raju Rangoju <Raju.Rangoju@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
-- 
2.34.1


