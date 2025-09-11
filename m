Return-Path: <netdev+bounces-222008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF6B529E1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261941C25F0D
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85826E708;
	Thu, 11 Sep 2025 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VlOO4/qk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718126B098;
	Thu, 11 Sep 2025 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575707; cv=fail; b=PQ6Xgmypi4/CLtU/Ns31Qx6URHLjl4X/0jSY1ugEzw5lNca3f39hfiVwLlsLEn5PkXW06bEVGTWFqP1cBwhYsYBOmLmHBrzephW5KvBfn0DmUPV90vJgOQltbgWRpLJMWCeLlGZE79hWy5BnDAygjbtxd0wKI8LkTdbRB6L21hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575707; c=relaxed/simple;
	bh=R+7AggwJKgEzC33oYR1Wl2CImP1y4lIKYEBoj3KpErQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYMZsi9NZCaW7Om5aW5W6JcgiiRm2ieObxihTU9/wyCuhTf2UR4HvX/PvwqYUV8mHrr2Dl5zvrPlJvQ1es700CJxWuRUTEqfp4lzCWKjE8R1unJf5GD90Mt8Q1tMIxgOQHtZobtVjtE+gdFTghDPwPFNrggYXEjYXiygGR5iaz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VlOO4/qk; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Ri8hIIf42HFbnsGACYQqwhB7HhOYtnvAwFUBGHmwKOtd45cqA29KExCXDUhkeMhz/+YETfa2T1q7t0CSYukR4ImatrnuqufYGVfF3In3kr0kx1aNWxnAgIgHoKa/+rN44sgp/kleU+IVL6fY5R/RyHNNOtMWw3mqX/wj13HBCLYPMQpCVcx54aBFJUk3r3jPf9o58wD4UnEJhaI+MRvutWbUrTb/Il5966V4UQJN7NCiqjzOHuQeKMwlrEzY6u5r/XZ3vUgTysrMWoDwzyqOIZhNRmAc9Vb/WsU7Dq2z/kq+HO3F/mbtLQRspZ7WcbEkaslhsISbLgaUIlBDJsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UZehzmT7/1prMr/Kl8uEx9VnOQwKMsRQ4XnLU8IJDw=;
 b=gJO+BcpppKMiIvr7/xDsW7pLBSctduMP+mDlsBXwvML3oACHeHaMiIWHjPRsZN1WHl9roj9u2cvJ+gl+xscbxDWhioFs8m5wqPZlxZqB5YSlx5OyyZJCS6USLp3AbjMuXb6r9vYJRwb6Yxq01+BvTDM91dgJd2Bn6eT1R0uXQ264wFLjvm34tC3GgnGq3HsDDiZHGXxPMdblRnFY8rPSVJqkWDI6+5RK02Dw8uhn0KfXxeotvogw61aT13OB9YXUiGifHW4mr9Mi0szIsoFiFu7UJSoskX9KL5HKa7aZPGmpL60kLMRz+7DevrAkExfwBtORRG6Y3ZAsrqqFFA8ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UZehzmT7/1prMr/Kl8uEx9VnOQwKMsRQ4XnLU8IJDw=;
 b=VlOO4/qkBSS3lQxL3aw0QqRtQvrwYXMKacfa87wv0zPp4Zow7Vdx97AcFlXJwT7aJE4YqWZX/T0YKKZ5VQP/dHHdFTfudDtVA/dDA65EaARhwjiJhZpJOBrNRn/JkR83D9RJjxjeTifFPMAlW6XxCjfEoYf+3Qbr1mdGDgxEkxg=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:28:22 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::b1) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:28:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 00:28:20 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 00:28:16 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net-next 0/2] Fix Linux style violations
Date: Thu, 11 Sep 2025 12:58:13 +0530
Message-ID: <20250911072815.3119843-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4a9e7b-161a-4dc5-2f3b-08ddf104c9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?72ugz+EBz+l+sKvXhyxUk3xYe+Z9AuwaaSVuJ3kc3jrOZ8yObPfHQGHwLRUO?=
 =?us-ascii?Q?+7vmuwGSoZo7Ttk+ufXcYdw/0TBHQK1HW0uwcI6RlgKD0kUgdecwQMqpNIfA?=
 =?us-ascii?Q?wvMfaWFPo07KB2cabZv6L6Fmx77llx2s6GURrKGUyYFbVak/KrHmA2cQ0OKa?=
 =?us-ascii?Q?pg9dALK/Xmq/97eIYi2s0cCg9sAKpDP0Taree2ur/KQzK2f+l7O4jNQDp1EW?=
 =?us-ascii?Q?6uf+v6Aywi5N2bSmqX1WFNKZW6qoUOjaiaR2jf7L5noaD6fkRiREuY3F0t0P?=
 =?us-ascii?Q?ZvBI/BrqTr3yTj5lX0LXYFufEB1jZ23gXCbm9pxiKSX20Qfu1Fuyl5Dp1GIU?=
 =?us-ascii?Q?iWNOgzcnJStW7Lg43OWF2gj8MguZ+8FOFW6ZNdbOpKC5V4I77ih91SW93cmY?=
 =?us-ascii?Q?7APSu6/+RUw/Ku+G5LeJoj8M9ql74EJ3LFBWFvH7rpfofwMqnI0m004ormAm?=
 =?us-ascii?Q?uEgrRXhrP+CItu5NxqZCEWHk3pgwoaSmJSlroHKpM2UcHaNdqq9QAoDjGu+q?=
 =?us-ascii?Q?ISJwpmpd7LwlCqWbI9kia7pWVIKqwIAAxMZhbn/J4DjEI/wAjv6ZJrsHZbHH?=
 =?us-ascii?Q?Ym9K3WNKFD2mS2IyA2FevA6k5hzQkQD9aGS41FD4aSb1MUiMHrlIxibOnSdd?=
 =?us-ascii?Q?tvUsgREj73SAV03n76ALtazE5t+YGbD+V00EfXbiOxGjuBsKDqBVIjFfE+FA?=
 =?us-ascii?Q?VAJp2AM9GvS6MMoI6Ge+QyeQxefYJZ+EkfdWnfLmljOO+oenhZBUiXOBV+ZO?=
 =?us-ascii?Q?NkU81HE9Est6ZmQgcIyBxs8HkOZRgQx5LVGonHlVTZ6fEZixEkIqWUHFmUoo?=
 =?us-ascii?Q?UFqUHz/seLNovQtSJxLAUoZhBzVgFy5Vgu9v3QoKUTVXe2IZEgGodnVjU5u3?=
 =?us-ascii?Q?bUevP3zYMnYP7hFCzwEd+ZY5M/yjmg6JaBGaLbgvV5y8BM6/tYtvPkAa91rr?=
 =?us-ascii?Q?/pLV7Pt2PsE+fFCtRdRCQgW+HNenP1i8kh6l+NST09gPJSdjcQILK+thhBJD?=
 =?us-ascii?Q?V7F/uWwo3hOj0WqRfl/6KKaWScmw2yzKOwP//VdKQrjSq9WxbXfShHh2QlaX?=
 =?us-ascii?Q?+yD2FXPVdkC9FZ1GKKjia9OtY7+vKO2eKewwLzjr0yYDjq6sGH8uU/uq0s9O?=
 =?us-ascii?Q?qBgGPNFyMz1Yt4+X1POCuKxKf02wwe3WQtN8Iygt6+eJVVwjeIzwN7rfPNGF?=
 =?us-ascii?Q?8tf59jE6m9K5qVqQpGmNQrHor+d624umt0hPL/aDwQV+5raPZfha16ckStgx?=
 =?us-ascii?Q?JMoykCecLn1dYDSZL0KBOIV1Edd1YhliBGNebE7Ike9KST0PWNl6Va6zKzDl?=
 =?us-ascii?Q?nadREn5dRh1+xngf81+0PONZAGjBZ0sa/z03zWRVv0swP7+OdMK5AhK04oNU?=
 =?us-ascii?Q?1dr/YHfXiwJ6ctOazZhGhMD2pwBnCCPP6pcprYIlCxHWpP5vUpzWwTO7ghW8?=
 =?us-ascii?Q?XZMXIKmhByhhJyLbO6qk/MsHGi8HckTkX73VRwLTsHZ1pdqpPWgxAnub+Ynw?=
 =?us-ascii?Q?UUYOqHh8ekt2PqtKkCey496fbYUfERegZcXT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:28:22.2049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4a9e7b-161a-4dc5-2f3b-08ddf104c9bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

Fix Linux style violations reported by tools.

Suraj Gupta (2):
  net: xilinx: axienet: Fix kernel-doc warning for axienet_free_tx_chain
    return value
  net: xilinx: axienet: Add inline comment for stats_lock mutex
    definition

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1


