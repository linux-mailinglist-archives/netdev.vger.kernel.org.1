Return-Path: <netdev+bounces-79227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222287856E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25C6282886
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7951C33;
	Mon, 11 Mar 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NswXS5Al"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1054F5EA
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174263; cv=fail; b=BoKtBu3KvjjT6FdbHR77f3AaBaF4E492ld32e25npt3aCHFZzRj5s4gHnvhYvd+P/ando77U2KmgW2tRAG4x3vLmP3pOybsD2ENhdQY/ExFznScH2ly5OBytJoypQXNYhOwHN7anSd4nlpAcFOZoGBwyZYSaOHTXFAppQjC6ncc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174263; c=relaxed/simple;
	bh=rHX6p7x4H6ncYycHugaRpeQgR7zEvCiR8xK3LhjQnMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+kJNhYU2altXxx9FGTc3RF02nZ5Bt9eJitrsh5UinHd44V3uHAxNyayvzyONRg2vD8ECbs8h8/BcCP1m348+oiyTgXhBtI5NcNnhaNVvrDQXFr3NIlWgjFy1Cl5X/PDH3g8LuYvnZZ7cPU1MdvdCZzlsTCoHDj7u/u8zuJnhTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NswXS5Al; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbqoURfVhMgzHLQgiSjaBYifrk+INeNe5H6WNex4Xp5QM7HK1ScwzDReZ3i553lr+UhQJbWqiexLN9iarDTm6e8bhnNhpayj8tqNG0cgedvZk5J92X76P6HTJXQEpN74OFxAxb6zF1gql0DWsC1VDT2+XcLhe4Q27Zku0cDMVEqhDp7m+pOIUpBDII8uGRH5Stif3zWN1YSXscVCLPXOe30H2Y9txU6lGJ1KEhM0aut4mo3yuFVAd+EE/Gv91b0Hvu8gWWWSLHroZI5Ah8JTGT3iV/TCiEIyTgm60mQ6Dc9Pv+q+kQSdCrTTzTMWLP3X2qSAQyh4JZvkpLpLQUwzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA69OsRiu9eT95+NDY4+UQ1Rej6hmrl731IUoyUcXB8=;
 b=IaIbWm/yDUnCxAr6bceGS8UNJ7Q0UkRCc8rCn/j06y4OnMo52wC1kSVE1mkmj5paZkERyatElpZNkyXBd2M61lz6u8Y4FQlVFaL390HdHvR3aNph/5MZNCr+QEkbs4Db1v8eLm2O1Yudo11B39+iCPxz0q/iQw1o67JKR11L23lCIEWyGEc22Yl3m8hhbj/CGOqv2rcrgSArCtPiESQUZZN88kdo8D2I0jUS2pLfpcwJFKX3W9oaYsiLewhlxCHqVj3T4M2dHzgcDQv0tBajPJnNdFshxsezCqP6t+BwwJWIXeRwujAA6Y2bFkbKJ65f8yOoqlA5ZfmqHmXCLwm2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA69OsRiu9eT95+NDY4+UQ1Rej6hmrl731IUoyUcXB8=;
 b=NswXS5Al7V6VCLn+vNBvZ15wCg7/F7/ENLlMGMhGeDrUeQ2gjihdZbQRkKXSrLgytc+Z/8satEBv1LlKvObpBo4tKGYrWdsCaHRXtLioMBVyzV/sTakIB7boMKy+XRcfYypit/Kur7Q6O8PNM6NlofWXPjTJR8M7r4KGN0Q1F8xP+qXBHAceJsA3R6zlZzvpaDFE9IyQbLiboxhz1ecFPOnpiLzC31KIfkzkP1tmecgerQmHPtjmENK8xda6LkWV7sL7zoPDpSJSDS5yzft+AigO6FsH/eizHl1kJxny2acyT/0WXmBwPVQUCmNOItUsxt9OtweLluDYRAb1iveMfA==
Received: from BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::28)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 16:24:17 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b1) by BL1P223CA0023.outlook.office365.com
 (2603:10b6:208:2c4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 16:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:24:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 09:23:56 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 09:23:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 4/4] nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y
Date: Mon, 11 Mar 2024 18:23:07 +0200
Message-ID: <20240311162307.545385-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311162307.545385-1-idosch@nvidia.com>
References: <20240311162307.545385-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e7b6ba-de1e-447a-796a-08dc41e7b2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o+ubLeRlLFx/fwrNCP8JCU+HiOkhfrdcp+HK7YWOMHGPqMqSafxZMq72kiv/v5SlNY6LYCHAzBw9RARosYsHlf5+smRctuZq44Pgi7nhzvw+shVUNBZFxcCiZAPMVxBe+MZO74iYpGELs2YgMdKPtEevghzctt23rUm2i3hCfD+fLUAEf6wWJb66CUU76yxn5MHp3sPfC/NuCvV617SkvB1KKC6jX+GI0MwBlPU1ndukQ/bVTGbGaqyLUvqzs5rxNtCmeKwMpQR9DVIDct/QZk2QgiiEPWj7zHfdo/+carDpfSjGf+0X9V7jMEtGF8q1isNz5W0CTPUTbflUR+N/zZczx4Di7R7Nr0lvvxBk8o4WhNbvH2zNjOT4GfXfJlpewW+UDJz7bA8cYOCMH/dNloSpaOuh/jd8keeUK9GDf3mnhwbzybOmcg2jEIlrCvt7ADpJCxCf5gTqPaFTYDkQ5zyhYEjAKcw0oibScZQekzhDIO0beWvfMr/qiLWfJtYiGq5T0q2121IXDLvDy8Q78FpWc/uHGtH5SBk4QzNSdDeBHdISu+OL9Wdid0e/J3rl7AmTj6jecg38l+Yx8KAOmg4mYPh/Okk7+AbOVtKVtQRdzzbxBp1tnRFmfZ03yYVGghOZcToFHPyFrLQDr/GFqWxf0+buAasP3i6JE7nGgi1JTFAH3ETivMmI48LBNYi04tij2qVWVP5G7T70aldN4J6iFko0FgeoPYRKoK7lrEG9RZp6E0OREUy/W6kpN91X
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:24:17.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7b6ba-de1e-447a-796a-08dc41e7b2c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100

Locally generated packets can increment the new nexthop statistics from
process context, resulting in the following splat [1] due to preemption
being enabled. Fix by using get_cpu_ptr() / put_cpu_ptr() which will
which take care of disabling / enabling preemption.

BUG: using smp_processor_id() in preemptible [00000000] code: ping/949
caller is nexthop_select_path+0xcf8/0x1e30
CPU: 12 PID: 949 Comm: ping Not tainted 6.8.0-rc7-custom-gcb450f605fae #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbd/0xe0
 check_preemption_disabled+0xce/0xe0
 nexthop_select_path+0xcf8/0x1e30
 fib_select_multipath+0x865/0x18b0
 fib_select_path+0x311/0x1160
 ip_route_output_key_hash_rcu+0xe54/0x2720
 ip_route_output_key_hash+0x193/0x380
 ip_route_output_flow+0x25/0x130
 raw_sendmsg+0xbab/0x34a0
 inet_sendmsg+0xa2/0xe0
 __sys_sendto+0x2ad/0x430
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0xc5/0x1d0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
[...]

Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 0011b0076c5b..aaf940d15afe 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -673,10 +673,11 @@ static void nh_grp_entry_stats_inc(struct nh_grp_entry *nhge)
 {
 	struct nh_grp_entry_stats *cpu_stats;
 
-	cpu_stats = this_cpu_ptr(nhge->stats);
+	cpu_stats = get_cpu_ptr(nhge->stats);
 	u64_stats_update_begin(&cpu_stats->syncp);
 	u64_stats_inc(&cpu_stats->packets);
 	u64_stats_update_end(&cpu_stats->syncp);
+	put_cpu_ptr(cpu_stats);
 }
 
 static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
-- 
2.43.0


