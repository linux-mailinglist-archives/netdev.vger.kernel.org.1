Return-Path: <netdev+bounces-79033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C28777C6
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 18:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A055B1C20885
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04643984D;
	Sun, 10 Mar 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9xU4GX1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E324219
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710092004; cv=fail; b=MvU1TDt1JMJ8P2kqnsjyMP7OA6EdN3uRP/vaW/JymvcyBYg9b7yH2ghDR8QMJMLrETwNUBRNAp0e3K1er1p0wUcbSgrFBKoVMCD4b847B3gaIwpSPrkA06ruu2yf8sT9vaBXOc4yW00tTFrrgPQ4AoUMoQRjNtOf+0oc/8+PUD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710092004; c=relaxed/simple;
	bh=kxwayL4VJWJuReYVzq4CikH/GTUbIWCsVpBInry6pFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUxlfeGSrU9+QT+CfRvL5yUiL4BIUYbgSm0dCgdkGVDn7WmIWuwCQveKRsgfNceaK0Sb8jUt5iYin4IsEVif8qY/Ii+QgvlBnnaqDdaBzNoumI7QuRWeEIwiM4HF5kWgrY5rQNoPjPwA/g6SfG2JLCSAmRy4bgvNmjaIHuNpIN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9xU4GX1; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIXoiKu9K+wXtz5IToae2idphbO5Lv3cZWigSeq4AJhz0HLoggOHR8CwSrfpW03LI5MvTDS9v8w76p/A7nrAE2AaL82g/E7SyA8EFu52YKhwyIE7bVBfBWpiOXE4g18pvA69zuR9eiuLDidE5Q5con7XOnFVsLXo+OGdtWB7tQZJV3PocrLdnreEbsaUmI1Nv2ovzr3jtoX5vtSJVucFkCeylXR6Yw6hkK98XGOrc2J8H61Zdy5kxdtcIPTuIAh/1It79m9vgN2S1jdgg77wN0qHoQ52sQzYzzFGN1cpk67lV7aA2UmwHlzN4ucSbF57XIid2DJuqnMe3ZWPgow1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1VEI+PCYChapPB1TTnJVpxMYe3BtE3M+Efolm3i+JQ=;
 b=YreHg3WQHGrTTK2z1c6z6UCq7gHJGnph9lZk3UqLzixGM//ZPWeED2udOo4walozJs/1i+2e7RjbEuIJpgJdDZdxUrm2WBJTIp8mXnCzMPwvg0DRBpYGgZ1Ntqu3aPkTv6PE2k639b+UzFePEMWg/C4yBioNmptq+To61tCJ3W2PQuUAz6gQwDD6y24+xnLNtZauVGLGPDZVmAexEml4iEqfK5nLx8gsOM81LBrcUW/GzxJ1AMSw5vIh+pE+WveNE9Gi1Dt3USXCvj/u/A3zqiKwI1nwB50F2jrWqmlr7/DZZcCmhYIjHVrHz2JSnxJEr+68EHebw7z857fRH+E8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1VEI+PCYChapPB1TTnJVpxMYe3BtE3M+Efolm3i+JQ=;
 b=b9xU4GX1uVXZmT0LRk4wFwMtFZBHTdZkrbldSaiVuVICVOehKS7CFY1S3kvCegxcY570ZYPvHbrwyzcDAdJjHztdm1i26rffQw3xRg/8YDxjq3xs1IDkrbKcUoQKudWQKFL57M8w07ObI7Y76bsD0OSJjX/FYiIAvofmz7sGIp0gv4TaXIqHaZv3gWgyOmkZSzLTxkc0L1jAaAW3+8NA81FUiGiT2vN9J5cQDXSCMGMd8YNZes+jebqEdd3ZuJ9ZD1w9NqVKj8a09ss4VQ1u8j9g86LFLz2+dKovtl3/QdfQjDRxxs42wYYbOlIH7qwy8uHt863NEeRrURRkuhkEcw==
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 17:33:17 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::b8) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Sun, 10 Mar 2024 17:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 17:33:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 10 Mar
 2024 10:33:03 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 10:33:00 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 2/2] nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y
Date: Sun, 10 Mar 2024 19:32:15 +0200
Message-ID: <20240310173215.200791-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240310173215.200791-1-idosch@nvidia.com>
References: <20240310173215.200791-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a122a45-e41d-4b04-8ddb-08dc41282bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PaGi0vpsIB1HalifyAAgm6m5ZKmUEP1HldCKMJRw0L8WiyI0cZWVmqS48j9OQf8e7HU7YtYR48HETUr+wUTJQv/VDXTaDZ7QU/KyFh+IAIIqp5jXk8WnOMrYwuISMfYP7qb3Q0A9ink+SuzVhNXz1L89WxJ8PHrHnOAwbZ4E5sr6jLI3DdU3wddsdCi5a0jRrCg3IXPQM8CMcZ6ynBOusBXA7p4q9EOX2DFuxBdcdEW57h/v08hcI11VJEx148/mZXG3qLVoVLLpCKxCtO+qmBscoJQxwIyBqTpRXFY1FjjoyUAxnRpdiWTHiXstSFXkn5u5R2x4VU6NG7ZPtgtlB1h0Axc7TT4iKRkNoEVkzlVr3xO3x0PLhhmhaEF3KgkP3n+zEu4bh79wvOdpMbryTRB5fM5iELpF4vCAPQYz9uKCxzjtxP39uPaW/2MYa+QPAMMdL0DjEbgqpbrHMK+cG3Aab4aQhEk7uFoG3n9aZUnZlsSpYozv3AkqICCGpKuESkXwbbBsvbdjgRPUXHMsTEbcNa03nWuyDsYNGRtXqrLGrCfVL9b+1HnEAim4GxcjAWjgNrPXl4lWGXBWzhnF1Zj7jJoymI6jGfya541XWdr2cwP689gzPPIc+yzQC81Jbujs/yOhZq7az284vU9aIP2sH8KgM3uBBTH7AFHa8tYEXVVV6qovcwtXTYBGbg8jFP4Gs8lA7GMgGqoFfDrEmObcpKNk5HV2houHR7hxIJaa2RhW+c4xza1kQ7kmEisr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 17:33:17.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a122a45-e41d-4b04-8ddb-08dc41282bfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

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
index f3df80d2b980..fe5531f1b39f 100644
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


