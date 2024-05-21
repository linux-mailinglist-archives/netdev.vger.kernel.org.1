Return-Path: <netdev+bounces-97267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0508CA5E3
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F74FB22330
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27499C14F;
	Tue, 21 May 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K/bKRPvX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581ABBE4D
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255474; cv=fail; b=D5+rQAivfewEq0gJTkadd+jI4VWMogfm+d1om/TESazY4YapElP6Kd0vFR94GRA7CfENxrBX8aW2uNkk+V+rompo37v6vEdAedCkZ7v+IhTy79PxMsI8KIEM7O2gCiE0NLdrf3krmz85pgqa4NO6y1CmtJmUlx+lwgyc0QvACMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255474; c=relaxed/simple;
	bh=/HtDFq29tzlKV+m+rSRP4yLMQLpLsOOHkWQmRv9SDgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfepC4nwHfUBIGKinlXkqqqsoazar79ztzVrvCtsSLUgqAFM0fccjKR1WYa5wgx9I284eGsI7O3u4xJ5QcY6a74UtCMKOba4o8J5fnv+hInXdzvgqrHNq32zis/7/1A/5rNo4o3znv2Pm6jYTbpmeOFqrBycYk/8LwGzWh7QzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K/bKRPvX; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l54h7xqhKqf5pBPDCLQlVz9nM47W5uFd9mVILjkr3LGFAAAHTgeELExxN0bLOrKVJ69X5T5mo131tqPAv6sYvhS5SpQ06E9CL+H5ySqzOJqLtfeoMGtxJkTYHm/f5XYvqeF2iTciKgrOI6R95wOZVEhlCCSpvVzbmNXRXwzP5atlVyrR8rnO3dNDuoJcRY8M8Gwi2XD6Clkn0w8nTDJtCanhJTq1QCi140TfGFmCyZmbEoDOjJe97aFARQoAPyRxiIrVgTOyCGhMET9VcsP+bUY8qSxK/ggD22GLaftKJDfMQExHyUctRQaOm601J2as9HLU6D0kyny5JSf1DVc97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkzvYXDx7IICfKnxzJXyLIxp1qLbSiVtMpekrWfa/SU=;
 b=lQn2fy3kyPN8b0Q77opxpgvSrFddlN29rkuN3sIx1Csz7xLNYNN39DYXTJyO3mL1TYu3OL0sRK8MfSFH2/DXs3pqwv/AuaDDWTZOuKCJWa378D4C4ZVG9MC0ilcvIrbSrLSy5nqwHzuaXYsntPoHpiCAVWldiRJuUsOo1pjDkSuUxOC4Gn7i2YVky85C1pGrkv+oMUPKEkcRMYgstcmKdpWpbTYFqJZAZ7oRy41xdUElOhV74KDXMb9Ke3pQWi/HS12Bs9uYsyo5JYOvUH2X1/YFFL9nfjs0gJDxNLKtpHUC2+4wiTlnaE7xpUaVFi/Tr/7+hOJcGljjMn4xZydSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkzvYXDx7IICfKnxzJXyLIxp1qLbSiVtMpekrWfa/SU=;
 b=K/bKRPvXh0BYNSqCLGybHxW3fUkqfdEE85gqt3Fudps354AoovEWtVzH9wosYg5NHp4MR2L0P94r9nyBnCEfKoIYwaV2SKwUIQpPp0baqVbwjLhCwpcsYV9PGIMxHfRDRHTaLm/MoFgF86Pv0WLL3ShE0h1BX1r4SMvofbXXMhc=
Received: from SA0PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:d3::32)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:37:49 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::81) by SA0PR11CA0027.outlook.office365.com
 (2603:10b6:806:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 01:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:33 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 5/7] ionic: Use netdev_name() function instead of netdev->name
Date: Mon, 20 May 2024 18:37:13 -0700
Message-ID: <20240521013715.12098-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a17f03-27e4-4500-3ba9-08dc79369f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQDCozsfWssw02QXZct4k3D+MnSRavoS+76yIK6EiTdWL7nINGw19hWoZ8/c?=
 =?us-ascii?Q?yMwFCwH7rFIWu6+rJKr1mZfJNJHaoIGNqT1kgTzU0QGKqbyo2d+6Lhl5cbLy?=
 =?us-ascii?Q?hnH+tPuVRBecJL4kQa/+oK/wq9BvYSx5YnNv3vd6XcN1Ad5UCQR9GtHKXnlX?=
 =?us-ascii?Q?S3vw15Z5bci4bJqgQFo4x/Tx1xmUQmPIeBDaYARnNKYQGoBLZD03IWKlEpNR?=
 =?us-ascii?Q?NwM4ngHS8cd3xDsbGzNtsSov5txHfdrIBxyMQoFfhLckTeayLYVnfmkc+Cvk?=
 =?us-ascii?Q?/4HFWPb6KrU6t750+BnZLu8eEx8/4ZnlfJW261rZgmDkYq2F9ii+uSzwnriq?=
 =?us-ascii?Q?jNUT0MBURBQNlcJZpCbAfe016EDB3pdlbyNS9ehQxxVlwkBeH5b64xlRNqmd?=
 =?us-ascii?Q?ux9I3CnmE+HJzdpMsQ9xYt+OJ/jQbGKMnVvGj1EuRuXoIneucVfXJLc1UG8a?=
 =?us-ascii?Q?O6WevhFpj/BbB7AgjXEauK6Y0a17sMMPFo++w+MZ6ZwVkihYtmoyhTWSC0TI?=
 =?us-ascii?Q?gLDw2k47aalrTCZv3+eHg7PaHfBkHsJVCb4i63LL0Pcta64xOfR7q9rqe2JZ?=
 =?us-ascii?Q?zmwIXz8BDHrRfoAp2pwHepXK9v25nGtBwimALmg3LbRlDhLuKu7vPF37uY/W?=
 =?us-ascii?Q?GwBz9QCYc5WsukHwba7z/N8SLcvMqk+TH21ATfU7kWIPb6si24cwxDQ+FLw3?=
 =?us-ascii?Q?/ah59rruV7jIxIfvko8jn/h4xuoaFhk9f5j4jQXpheYMuMOSvbbnjQlXOn/I?=
 =?us-ascii?Q?UGAOp4gB8r/ZB1ksjk4QPM8u16ZXJI5VRb2B4KW/APpaXL2ERiVbvCK6QChd?=
 =?us-ascii?Q?h+j/sVI3L1gsfvTZ+XJHYYPyJI43NwwECrCG5nAdPaaBYu2a8blndkK4kqs1?=
 =?us-ascii?Q?akkuPF3pwyOqEvVU/d7KiDlMdndtFuJYtErr1Td5FzAC6FUam8G2T/wSVTcb?=
 =?us-ascii?Q?GG42DXhxtdAA8huBx2f8GbKHvPRRQrH/pkhrKOdQ1svV4emxCypPY1ryldny?=
 =?us-ascii?Q?KudoW0eIGgqe1YqFQMtolM6+21Id5J6CDgFAHKTEjAnI2MJHR9pqQYVfGeXl?=
 =?us-ascii?Q?KzZZTbG4xDqHhstv3VUjb8O506/tgojQ76phSbwhCqUPLR181IK+yHSpGk3P?=
 =?us-ascii?Q?kFEN3gv109ybXUf6Q43Pokw1xWSaqHaXFvjvAG2TWPJbauUCISLxNNLcgt4A?=
 =?us-ascii?Q?UfZiwvi/eyQmPjfpqzUFKdzRHLcsJHCD+H0+hGLA5JD36KvxRLYhbHf9m7HU?=
 =?us-ascii?Q?rkNpQj6NzWavOauUIwRqfUQ6KshQXjKuQd2bjVeov2uy2rJ3mNg/ygGHy2Ue?=
 =?us-ascii?Q?J5dOEJ4Slp3F4KeBBjeNcLGisrS92D9h9qUQ0NZgdrWX4uqGvMOZu59j7oO0?=
 =?us-ascii?Q?mm1i5Hfdr7L7YLh9ilrpJrd6EC/b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:49.1498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a17f03-27e4-4500-3ba9-08dc79369f92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

From: Brett Creeley <brett.creeley@amd.com>

There is no reason not to use netdev_name() in these places, so do just
as the title states.

Fixes: 1d062b7b6f64 ("ionic: Add basic adminq support")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index c3ae11a48024..59e5a9f21105 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -220,7 +220,7 @@ static int netdev_show(struct seq_file *seq, void *v)
 {
 	struct net_device *netdev = seq->private;
 
-	seq_printf(seq, "%s\n", netdev->name);
+	seq_printf(seq, "%s\n", netdev_name(netdev));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 101cbc088853..23e1f6638b38 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -237,7 +237,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	const char *name;
 
 	if (lif->registered)
-		name = lif->netdev->name;
+		name = netdev_name(lif->netdev);
 	else
 		name = dev_name(dev);
 
@@ -3732,7 +3732,7 @@ static void ionic_lif_set_netdev_info(struct ionic_lif *lif)
 		},
 	};
 
-	strscpy(ctx.cmd.lif_setattr.name, lif->netdev->name,
+	strscpy(ctx.cmd.lif_setattr.name, netdev_name(lif->netdev),
 		sizeof(ctx.cmd.lif_setattr.name));
 
 	ionic_adminq_post_wait(lif, &ctx);
-- 
2.17.1


