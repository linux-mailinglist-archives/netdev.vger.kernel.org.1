Return-Path: <netdev+bounces-130935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BD98C1F1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4F282C65
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E01CB313;
	Tue,  1 Oct 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1ASDDOS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BD1CB316
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797540; cv=fail; b=Lj3GBMvrrcpLLwbbR9aqsZnNzUum8/lfxhZVEHBMcKFKiYX/OPKYFe1vVxHai1of8HHX5N6B+sz09gR2wst2OS1iIL9bdEPpSteEBtf1nSZD7bxURoYx9/yCDElh7Fjc2tfV8kefWHhCaZ82f7CWLUuk/tTWzxiaFYsFbLLF3WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797540; c=relaxed/simple;
	bh=mMgr3VsiADD1NqRbh7uJJw64HgiOdidndwcWe5gvkak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XI3gGUDKryu4lQFm3okUlXe2RhCtpT/PwtwK6iunxxoPPVbdLLI9bu4ZPLt/4GF/CFPsozsmyjmamYVoWSqpm45YnIqYbsrrCArHDiEfOEcMDOogQkUMXJ/1jej0LXFyx0qfsJVWVmPtv8opS7jgjMkuiMq7jaM1F8PRIL5r0i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1ASDDOS; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYDnJQzlc3EFyEUm4IutIUCoC2DL9AhaNjT2uKJQf0FXLnR9lhF929hqv9d9tQzkYLzT5HsoSXDHDLyXWc3H0tvYgHpCLR0ezI5NKPZXbflwI7PAA6HGyoKvsGP6YvpUfrVaaGK7aCk/rqnHsMIkoJr1JSyaMo08Ga8h3qf9pywcnRmuGY0sa1cUnmvHC+CaE8/vuAMIRD3bcUVg5E55aWPvOEkhZx1veJD4cLQTN6eRwMDH0BplBptZ8VhVKTj1L2dii2OknP4gPB+vMd3WSPJpIg4p7m6eCw3hSDUkAVNoZBBK+1uc9y4P49SJXWWE/a/4Lhg5+6IufmHGoitsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhgJ5pQGFtzbNJtpDoe9/HwnxBtJ07uzAY2/fdPc6rw=;
 b=Jk6RYDLwW5psiPnGzRwvumzauwEYsFiME0dEZMnlMBMSbczE3xNmJJpzQHVrY0e6tSzXT05i6YQHfvs7yjJNdniRGTnnrVkuC5TXDCPOj0SV+BniOZJSeLO5zcQMRP2RMKT/5bXzyv5+9Pg8UvFjMEaCKhwF0jFK5R5N/uc+rlCxj5uhHGmmCBgG1Sf3ENRxWbST+YFkLEbLKRbBtk3KyWQGtBLF2B0wHirXYMSKkvKFSeuRPYIEV2EIHsFyEa6TwPhgvpmn66BRFJjxvUVCEgE3RySrz1Dx+d5ZtmDnKdzYFgMltxEVcq0rJMIlxrgYTXM4SCzEe9KQD14vGXjOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhgJ5pQGFtzbNJtpDoe9/HwnxBtJ07uzAY2/fdPc6rw=;
 b=R1ASDDOSpHc/W4nhYn9bQhDfaw1XUS1czMV3uAzXTimFKD6QOVWCcNDqjuXRmWlHKbXLsm/e3ODTFkM5F5jin3B8vrBxnwb9LWfNc1CpcHVJw/skzy6UMhB+GvgvvcKuf2EDUX93yx6Jst3ROcFLFO4B8AKzscKCbh7U0HNiLG54QFazcnw5/jYrhH/p8sVcfFZPoWD72Dj9oAPXcYoUXCgQ3FdRofir2vNRZJBSvLEjBMOEEDrauUiibJdECybSbbp0zIPuYT4egdHYZKkGJs0Hg67HReyAixcIfiovX4bPoIzF3d2LakjJM9sgU/25HLqot9YULLGOjN8q/f64Jw==
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 15:45:35 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::1e) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13 via Frontend
 Transport; Tue, 1 Oct 2024 15:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 15:45:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 08:45:19 -0700
Received: from tetra-01.mvlab.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 08:45:18 -0700
From: Andy Roulin <aroulin@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <pablo@netfilter.org>, <kadlec@netfilter.org>, <roopa@nvidia.com>,
	<razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net 1/2] netfilter: br_netfilter: fix panic with metadata_dst skb
Date: Tue, 1 Oct 2024 08:43:59 -0700
Message-ID: <20241001154400.22787-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241001154400.22787-1-aroulin@nvidia.com>
References: <20241001154400.22787-1-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9de132-baf9-423c-e3f0-08dce230170b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eHBAeN3MAwJ9SoGSg09Z2d5vpPSHaKSJvQ70ayiLkpqVHmtuMZYKixG9EvP?=
 =?us-ascii?Q?4z2ZjXJJDTvO1K+haKf2Ia3+vVW5oUE4ri8S1FOJ9XKA/9LrcgbPyEGS++Bd?=
 =?us-ascii?Q?Lq0mmp9H0OTnUZSZe12yvepOZcpiCEzKIMcN7xLQO0Snr/zWQFHG9M+ocQjR?=
 =?us-ascii?Q?sxtpmTcxO3Xc8Pw2yRBm7nLvdPVWX+gKcWtnslM5ErEuD6VKkbIr9upqqQst?=
 =?us-ascii?Q?MorMbSso7f5mfgKmswld0Cpn89ho40nXriL5gbTFQmgAiqxLMHqxiUBwFlEF?=
 =?us-ascii?Q?DmekwobLrsO3Q0GesFxS6F5BIZk/BQGvRcYUDLO4JkEyLnmtwi8LkN6t15Pr?=
 =?us-ascii?Q?ouZ+sDFV5T0pLpykhxGp7a4RUyq5Ls2QGgcEbuqKkgV2G3It4bZYEhViRYMk?=
 =?us-ascii?Q?GfJewafmB72NZT1V0hqlh28Qjl30ZCPWTsCn35gqmiMlXYyh0my4DIWZjasF?=
 =?us-ascii?Q?qVhnNQNIHLH55a/5pxFnm2YHFdhaetkKp8+xNYTOVa77tUFR22+3fAnHZikQ?=
 =?us-ascii?Q?oMb9YgmC46bwEj2Y0UdCgF101sKNxuNfaYofoaLlTgqMXbvxCnue8emStIYO?=
 =?us-ascii?Q?ALzmZHon7ZERuwTEKiV/F+hcMLhXZaTGy3vRwDdKC4k5rC5VytLggILT4Xxy?=
 =?us-ascii?Q?GqRkBx9WIxz+WliMk72HkykIyMIqcHq8YfIQFxj8cZKPi0MW0Y598/kpPeBG?=
 =?us-ascii?Q?1nSYUzZCQfIAxSEme4iTNwH/u/KbaS69q7cOsg/AFGSH2RL+lo7S32Yk2Rrt?=
 =?us-ascii?Q?t5BKBAyjydc+UnJBg4N3QRREqzFwjlgdRfCjF97uwUaNL9HbOj8XyJ3vb61m?=
 =?us-ascii?Q?KZKEXMTjZ94wUmiQfamQW+SqzS9s5/LH61Aa+YZk3IVI3LEyC3yYAveR1a/j?=
 =?us-ascii?Q?aYbecGUzijwJzqXshw7HK5LdgtbEfXLuBWhQyJyqJqniufnRHdssABu678mE?=
 =?us-ascii?Q?1im6LfA8SDYQTfCca3mESK3RGNWlWz+PioCEYXn5JbZdF2fd8X0qjfJrrjqD?=
 =?us-ascii?Q?ht2buGbT4o0fTcEiS+QMzWUBRYOXKAfitXtMOMsYq4mdx+RREr4nzbMfGCJT?=
 =?us-ascii?Q?kBRISCxXBzFve60fDVFsi43npfivENmVlAnBR0sOcMy6XBq0Pq37T+/DIOnD?=
 =?us-ascii?Q?rJ4nXaGomFxt9eSv+1TW0w7AnN21C0/xg95Z94XMkyD8HSj47JDrbSD3di+y?=
 =?us-ascii?Q?pGM0nFF0urS4zhMZn5IZeu0tZMrhgwhhHyCeW+Ia9jresM0S0HvFRgzkUafc?=
 =?us-ascii?Q?0hTyd/ed6WpS7/OziC3p/BVYRSpD49JGwqeSPl2Yt2lsAdvHEgKik1sQ3Z3W?=
 =?us-ascii?Q?562TLkOm6Ap0HCydx0XIQFqpCz+2Z9U/CzaKEdJcyGEUZ0defDQ22cNeFW3B?=
 =?us-ascii?Q?IxuFmI0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:45:35.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9de132-baf9-423c-e3f0-08dce230170b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

Fix a kernel panic in the br_netfilter module when sending untagged
traffic via a VxLAN device.
This happens during the check for fragmentation in br_nf_dev_queue_xmit.

It is dependent on:
1) the br_netfilter module being loaded;
2) net.bridge.bridge-nf-call-iptables set to 1;
3) a bridge with a VxLAN (single-vxlan-device) netdevice as a bridge port;
4) untagged frames with size higher than the VxLAN MTU forwarded/flooded

When forwarding the untagged packet to the VxLAN bridge port, before
the netfilter hooks are called, br_handle_egress_vlan_tunnel is called and
changes the skb_dst to the tunnel dst. The tunnel_dst is a metadata type
of dst, i.e., skb_valid_dst(skb) is false, and metadata->dst.dev is NULL.

Then in the br_netfilter hooks, in br_nf_dev_queue_xmit, there's a check
for frames that needs to be fragmented: frames with higher MTU than the
VxLAN device end up calling br_nf_ip_fragment, which in turns call
ip_skb_dst_mtu.

The ip_dst_mtu tries to use the skb_dst(skb) as if it was a valid dst
with valid dst->dev, thus the crash.

This case was never supported in the first place, so drop the packet
instead.

PING 10.0.0.2 (10.0.0.2) from 0.0.0.0 h1-eth0: 2000(2028) bytes of data.
[  176.291791] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000110
[  176.292101] Mem abort info:
[  176.292184]   ESR = 0x0000000096000004
[  176.292322]   EC = 0x25: DABT (current EL), IL = 32 bits
[  176.292530]   SET = 0, FnV = 0
[  176.292709]   EA = 0, S1PTW = 0
[  176.292862]   FSC = 0x04: level 0 translation fault
[  176.293013] Data abort info:
[  176.293104]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  176.293488]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  176.293787]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  176.293995] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000043ef5000
[  176.294166] [0000000000000110] pgd=0000000000000000,
p4d=0000000000000000
[  176.294827] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  176.295252] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel veth
br_netfilter bridge stp llc ipv6 crct10dif_ce
[  176.295923] CPU: 0 PID: 188 Comm: ping Not tainted
6.8.0-rc3-g5b3fbd61b9d1 #2
[  176.296314] Hardware name: linux,dummy-virt (DT)
[  176.296535] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  176.296808] pc : br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
[  176.297382] lr : br_nf_dev_queue_xmit+0x2ac/0x4ec [br_netfilter]
[  176.297636] sp : ffff800080003630
[  176.297743] x29: ffff800080003630 x28: 0000000000000008 x27:
ffff6828c49ad9f8
[  176.298093] x26: ffff6828c49ad000 x25: 0000000000000000 x24:
00000000000003e8
[  176.298430] x23: 0000000000000000 x22: ffff6828c4960b40 x21:
ffff6828c3b16d28
[  176.298652] x20: ffff6828c3167048 x19: ffff6828c3b16d00 x18:
0000000000000014
[  176.298926] x17: ffffb0476322f000 x16: ffffb7e164023730 x15:
0000000095744632
[  176.299296] x14: ffff6828c3f1c880 x13: 0000000000000002 x12:
ffffb7e137926a70
[  176.299574] x11: 0000000000000001 x10: ffff6828c3f1c898 x9 :
0000000000000000
[  176.300049] x8 : ffff6828c49bf070 x7 : 0008460f18d5f20e x6 :
f20e0100bebafeca
[  176.300302] x5 : ffff6828c7f918fe x4 : ffff6828c49bf070 x3 :
0000000000000000
[  176.300586] x2 : 0000000000000000 x1 : ffff6828c3c7ad00 x0 :
ffff6828c7f918f0
[  176.300889] Call trace:
[  176.301123]  br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
[  176.301411]  br_nf_post_routing+0x2a8/0x3e4 [br_netfilter]
[  176.301703]  nf_hook_slow+0x48/0x124
[  176.302060]  br_forward_finish+0xc8/0xe8 [bridge]
[  176.302371]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
[  176.302605]  br_nf_forward_finish+0x118/0x22c [br_netfilter]
[  176.302824]  br_nf_forward_ip.part.0+0x264/0x290 [br_netfilter]
[  176.303136]  br_nf_forward+0x2b8/0x4e0 [br_netfilter]
[  176.303359]  nf_hook_slow+0x48/0x124
[  176.303803]  __br_forward+0xc4/0x194 [bridge]
[  176.304013]  br_flood+0xd4/0x168 [bridge]
[  176.304300]  br_handle_frame_finish+0x1d4/0x5c4 [bridge]
[  176.304536]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
[  176.304978]  br_nf_pre_routing_finish+0x29c/0x494 [br_netfilter]
[  176.305188]  br_nf_pre_routing+0x250/0x524 [br_netfilter]
[  176.305428]  br_handle_frame+0x244/0x3cc [bridge]
[  176.305695]  __netif_receive_skb_core.constprop.0+0x33c/0xecc
[  176.306080]  __netif_receive_skb_one_core+0x40/0x8c
[  176.306197]  __netif_receive_skb+0x18/0x64
[  176.306369]  process_backlog+0x80/0x124
[  176.306540]  __napi_poll+0x38/0x17c
[  176.306636]  net_rx_action+0x124/0x26c
[  176.306758]  __do_softirq+0x100/0x26c
[  176.307051]  ____do_softirq+0x10/0x1c
[  176.307162]  call_on_irq_stack+0x24/0x4c
[  176.307289]  do_softirq_own_stack+0x1c/0x2c
[  176.307396]  do_softirq+0x54/0x6c
[  176.307485]  __local_bh_enable_ip+0x8c/0x98
[  176.307637]  __dev_queue_xmit+0x22c/0xd28
[  176.307775]  neigh_resolve_output+0xf4/0x1a0
[  176.308018]  ip_finish_output2+0x1c8/0x628
[  176.308137]  ip_do_fragment+0x5b4/0x658
[  176.308279]  ip_fragment.constprop.0+0x48/0xec
[  176.308420]  __ip_finish_output+0xa4/0x254
[  176.308593]  ip_finish_output+0x34/0x130
[  176.308814]  ip_output+0x6c/0x108
[  176.308929]  ip_send_skb+0x50/0xf0
[  176.309095]  ip_push_pending_frames+0x30/0x54
[  176.309254]  raw_sendmsg+0x758/0xaec
[  176.309568]  inet_sendmsg+0x44/0x70
[  176.309667]  __sys_sendto+0x110/0x178
[  176.309758]  __arm64_sys_sendto+0x28/0x38
[  176.309918]  invoke_syscall+0x48/0x110
[  176.310211]  el0_svc_common.constprop.0+0x40/0xe0
[  176.310353]  do_el0_svc+0x1c/0x28
[  176.310434]  el0_svc+0x34/0xb4
[  176.310551]  el0t_64_sync_handler+0x120/0x12c
[  176.310690]  el0t_64_sync+0x190/0x194
[  176.311066] Code: f9402e61 79402aa2 927ff821 f9400023 (f9408860)
[  176.315743] ---[ end trace 0000000000000000 ]---
[  176.316060] Kernel panic - not syncing: Oops: Fatal exception in
interrupt
[  176.316371] Kernel Offset: 0x37e0e3000000 from 0xffff800080000000
[  176.316564] PHYS_OFFSET: 0xffff97d780000000
[  176.316782] CPU features: 0x0,88000203,3c020000,0100421b
[  176.317210] Memory Limit: none
[  176.317527] ---[ end Kernel panic - not syncing: Oops: Fatal
Exception in interrupt ]---\

Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_netfilter_hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0e8bc0ea6175..1d458e9da660 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -33,6 +33,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/addrconf.h>
+#include <net/dst_metadata.h>
 #include <net/route.h>
 #include <net/netfilter/br_netfilter.h>
 #include <net/netns/generic.h>
@@ -879,6 +880,10 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 		return br_dev_queue_push_xmit(net, sk, skb);
 	}
 
+	/* Fragmentation on metadata/template dst is not supported */
+	if (unlikely(!skb_valid_dst(skb)))
+		goto drop;
+
 	/* This is wrong! We should preserve the original fragment
 	 * boundaries by preserving frag_list rather than refragmenting.
 	 */
-- 
2.39.2


