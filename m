Return-Path: <netdev+bounces-116897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411094C020
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71380B26836
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653251953A1;
	Thu,  8 Aug 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ood1hYbp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65888190477
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128192; cv=fail; b=CUefxkS86zIr9XrZ7/YlZN2aMhTxWfaMOXdQV/0N7o8BxIAk7v//PDNTELXO6vrUbn4mVpLbEabQm/JZHndtyDgnO4Yck3uIgdKGmZm+TQ+TcyfBdiFoGpRneUZJ2hOyPwkk22IMI+OXNpTzWOUmyh+7P5jUR1bXa3eUiyjHUwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128192; c=relaxed/simple;
	bh=gBQgQaghYyyltahUDAwjLTjG6168tOYu/HzCl6NBOM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iijvCOicy//X7yq+BfZsX/LtYpwpZUfK00kAyal6cF+6r94xC9omTjXR8Gcx1Et7pDqKLzUnpAouXpMLgHLXP+iFrN32wliqRh1HuXKzr2rOUmTho5TJHqSiV0kd5pPNvoRGGF1JSE+11PSiJ4QykOf9S0WNtomWogo71Fw2lSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ood1hYbp; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjAOOHWcz8jEXkYNlkbQLemxwyfdkAx//SdscWVUrIVqUmXZRcibyIUhRc/nvwL034A+LCCtBswfXUO5bSZCQEs1utefTKsYsgUpGsOk7KfiJfY3czymGU//LbFzVoCtIG7CxisURVqijR2G1w4OO3XRtqZ21RN/CHi+ujQ3Z/hSHjL+XrwyySeAUjfWsafzoRP6noCoL6qPFYoZFyfbx5bvtEHxptzWSkTmLKUJLGVRoJ43wrpz1F/nW6cqhYy1YfTd96ESXIpStTeyEf3tqzu+b6kSLCCGFop2j/f/TEJCzvqt7qZxvCIsWAN1/T90+9ZCDzyyhjdHUyr9z1OR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZukfm0eEA3bMyge52t2tzp1r0tzLVkdluUQmrHQBW8=;
 b=va0Wzg/gsSrjcIbsKQdAWDPT0TYxi+by7HdRlv3TWeAUY4UOQ0eINNTRGZtj/JJFNKpti1yyk04jPJOfREubiO/pBkKkmvAi7Xug+Wjv8/Mq+Lz7gpo2uvdB0rJ1dkSk9V5r1sHkdEBNudrWEfebk4XhTd/7t35liYMtpJ6i/zbGMOr8bGDRuaFKZ7tHibGTa6W/BRSONx17CfI1GY+hlQd07RKPDMXhkS1g0ppcv8tI48v6ZDYIaw5bgXEgDgyvvxF9w6yIVNBtPPl/KALW+Zxy/ygZ+hZ8uNqWH/KPAoMf67XuEvFi9HFCp+kBWfMCrqVtWETb9yfFnEC1K7RjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZukfm0eEA3bMyge52t2tzp1r0tzLVkdluUQmrHQBW8=;
 b=ood1hYbpvJKRwMgOG15xHu7pd/9+ePZPKi+JzoPR5TSpnMcD36YPYA8QdFZP3b0WcdLFjeIN/BAHAg1etJMd9zrMDgW/FUMZgzNbP4K8ALNQ5z0YQq8lW2FOmws3HkJ1Bk+BfGPWc8bIhufNGItv0JUasPsNds9ViUbukra8H7c3AkdOyO8B70Y+IxIEqcDsEo+CLw82dp/Jf1xoGqF0AJU1Y/jh+t3RYg8MHxLPZJe/fmGVYIhypmX5rDg+VsjQaKJadAJYxow2BzbuETsD8HF5k9gDxjZpr4RchSxIqfAHyKgLbuglf2d8T9vwC5q1+OsD0Uc8ucG8Lt4Q9aG6Lg==
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 14:43:05 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::b0) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 14:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:43:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Joe Damato
	<jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5e: Fix queue stats access to non-existing channels splat
Date: Thu, 8 Aug 2024 17:41:06 +0300
Message-ID: <20240808144107.2095424-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db62fc2-5529-4df1-1f55-08dcb7b8694c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YiIPvoek5ZF3nJvc5vLTmhNRyHYwEsfHPAkaxOJc4ffkAmWgF+2hucFEdrr?=
 =?us-ascii?Q?6xsVsInzrz1sHDLYFEkPhM3Mu+j6YwCpE9aRb0WUCeRYn0DvcEDl5bhqodEB?=
 =?us-ascii?Q?oIaYK9AzboJpkIXbSPY8RvChhWqdL5ovAgu7X07ljNCW4Lt/c3yYNrVKp01z?=
 =?us-ascii?Q?RLJ/OF0AJeavX/LMPuPHjtP9gHEFzrSe4JsT2yxQHguB+0jtVeuzp8BPtQWU?=
 =?us-ascii?Q?NLpnryQ7HqHfOBUoBCWZ6hK0V0E8RFrVIgoTn6etMLjoMTn7yFqq+7SUWv+2?=
 =?us-ascii?Q?8oo/7lXGM/UOY8lxPJcHqst9zdElDUF4GALNU0Oa0doEYWf0ZEQfuq5b4vaa?=
 =?us-ascii?Q?wE7z1OsP2+u4mp5ypOeRFHUgi2U6xjZSydL7Imb4qDqRI884JLg8mLuI9sIk?=
 =?us-ascii?Q?BScUXAKEVkchvplIGwwjCcD6NgrT2jg0zl6k9eSUdrJ0N/1I6yQXLKt9D4pM?=
 =?us-ascii?Q?hPxaYaKK8mZHGPEueUQKp83OQ843sa+Lhhl31LCgGWo7qEIF8/0yIsl4U0Xh?=
 =?us-ascii?Q?SNOzpdpWv1gfAwwR8QX5O/ued6UcqZgw43hD/xzGez97j7fcy1D2q7h3wVZn?=
 =?us-ascii?Q?TpvgeuOdpOooT70nFhiekR/k5cjTyazo1GpUtTEKNRSR4QbFAJYT1l23nuf8?=
 =?us-ascii?Q?zlKOz3LBWZfbeWc2Xe+ymERw1aDjXkOmr++P+EgJnUC27gIv4z+5LSIiDb1y?=
 =?us-ascii?Q?hPwVYRy5HD/dOAhlE62JWKve9uUAeeiVoI9fca3/31zB5qJ8fkh4RCRGguGq?=
 =?us-ascii?Q?FK8vYi2PSfKGFJ559RcSW2V2zqTx4mY7jRQxkSf9dDzk1+2B8lYtYvhcd6Kl?=
 =?us-ascii?Q?thDGAo9nRiNidB0kA/tR4/+URZ8qhl3DiYH23cLO/X8nfanjiHmiLgAYqhXx?=
 =?us-ascii?Q?7qD3vdsc3zUVwFOlyF8LaUpIrrwoTCFqiojHzG76q9stmZso6aBd1JddqJQb?=
 =?us-ascii?Q?GaTypTdXpzAU4680noznDkbezL0kbXiTmvjrMlWOSLjo6K9d8gTA3H8PvrIA?=
 =?us-ascii?Q?88cbevEsjo2CRt3Ny6WhJP/hB4aNg1w5WGX+sM2aaY5BM9yVMestl4/pph8G?=
 =?us-ascii?Q?OKlS8bl83NvameHZCHEjug/2SYh1pSv+H2e2milKdwxuei00sQgXSNuUI/7t?=
 =?us-ascii?Q?/91WnZkNNZ0QRy6EWwjR9fsA+nwlZ8WmiqMnl4Ku+y5bPoQH+8aiPWgCouJi?=
 =?us-ascii?Q?xTn1yespS7yAq3Xgt0WanknFV6ySigVxgYiohQdpkS15YhMmCHCEgHMECezN?=
 =?us-ascii?Q?3NY3G3F+KSnbGZ03YBh2QlnJmEEarRL/VgQUrl6qD0cYdOtWtqXkDECr+rQO?=
 =?us-ascii?Q?v7bYxN1Xx7eSCjOCKn8SAcBVXXIO89LL3Xj1SWx/8cf815KVBel893lEOUuV?=
 =?us-ascii?Q?AZ7GoFBMctYzS16r0FCkOXIAwwqKHy7qIk9N0NHdZJYtKAJvo/PFf90VFJ0H?=
 =?us-ascii?Q?V4yk/XpzJ7SM6i4q2S1GNpP27qiVU+XM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:43:04.6979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db62fc2-5529-4df1-1f55-08dcb7b8694c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

From: Gal Pressman <gal@nvidia.com>

The queue stats API queries the queues according to the
real_num_[tr]x_queues, in case the device is down and channels were not
yet created, don't try to query their statistics.

To trigger the panic, run this command before the interface is brought
up:
./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml --dump qstats-get --json '{"ifindex": 4}'

BUG: kernel NULL pointer dereference, address: 0000000000000c00
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 3 UID: 0 PID: 977 Comm: python3 Not tainted 6.10.0+ #40
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5e_get_queue_stats_rx+0x3c/0xb0 [mlx5_core]
Code: fc 55 48 63 ee 53 48 89 d3 e8 40 3d 70 e1 85 c0 74 58 4c 89 ef e8 d4 07 04 00 84 c0 75 41 49 8b 84 24 f8 39 00 00 48 8b 04 e8 <48> 8b 90 00 0c 00 00 48 03 90 40 0a 00 00 48 89 53 08 48 8b 90 08
RSP: 0018:ffff888116be37d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888116be3868 RCX: 0000000000000004
RDX: ffff88810ada4000 RSI: 0000000000000000 RDI: ffff888109df09c0
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000004
R10: ffff88813461901c R11: ffffffffffffffff R12: ffff888109df0000
R13: ffff888109df09c0 R14: ffff888116be38d0 R15: 0000000000000000
FS:  00007f4375d5c740(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000c00 CR3: 0000000106ada006 CR4: 0000000000370eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x1f/0x60
 ? page_fault_oops+0x14e/0x3d0
 ? exc_page_fault+0x73/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? mlx5e_get_queue_stats_rx+0x3c/0xb0 [mlx5_core]
 netdev_nl_stats_by_netdev+0x2a6/0x4c0
 ? __rmqueue_pcplist+0x351/0x6f0
 netdev_nl_qstats_get_dumpit+0xc4/0x1b0
 genl_dumpit+0x2d/0x80
 netlink_dump+0x199/0x410
 __netlink_dump_start+0x1aa/0x2c0
 genl_family_rcv_msg_dumpit+0x94/0xf0
 ? __pfx_genl_start+0x10/0x10
 ? __pfx_genl_dumpit+0x10/0x10
 ? __pfx_genl_done+0x10/0x10
 genl_rcv_msg+0x116/0x2b0
 ? __pfx_netdev_nl_qstats_get_dumpit+0x10/0x10
 ? __pfx_genl_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x54/0x100
 genl_rcv+0x24/0x40
 netlink_unicast+0x21a/0x340
 netlink_sendmsg+0x1f4/0x440
 __sys_sendto+0x1b6/0x1c0
 ? do_sock_setsockopt+0xc3/0x180
 ? __sys_setsockopt+0x60/0xb0
 __x64_sys_sendto+0x20/0x30
 do_syscall_64+0x50/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f43757132b0
Code: c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 68 c3 0f 1f 80 00 00 00 00 41 54 48 83 ec 20
RSP: 002b:00007ffd258da048 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffd258da0f8 RCX: 00007f43757132b0
RDX: 000000000000001c RSI: 00007f437464b850 RDI: 0000000000000003
RBP: 00007f4375085de0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffc4653600 R14: 0000000000000001 R15: 00007f43751a6147
 </TASK>
Modules linked in: netconsole xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib ib_uverbs ib_core zram zsmalloc mlx5_core fuse [last unloaded: netconsole]
CR2: 0000000000000c00
---[ end trace 0000000000000000 ]---
RIP: 0010:mlx5e_get_queue_stats_rx+0x3c/0xb0 [mlx5_core]
Code: fc 55 48 63 ee 53 48 89 d3 e8 40 3d 70 e1 85 c0 74 58 4c 89 ef e8 d4 07 04 00 84 c0 75 41 49 8b 84 24 f8 39 00 00 48 8b 04 e8 <48> 8b 90 00 0c 00 00 48 03 90 40 0a 00 00 48 89 53 08 48 8b 90 08
RSP: 0018:ffff888116be37d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888116be3868 RCX: 0000000000000004
RDX: ffff88810ada4000 RSI: 0000000000000000 RDI: ffff888109df09c0
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000004
R10: ffff88813461901c R11: ffffffffffffffff R12: ffff888109df0000
R13: ffff888109df09c0 R14: ffff888116be38d0 R15: 0000000000000000
FS:  00007f4375d5c740(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000c00 CR3: 0000000106ada006 CR4: 0000000000370eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 7b66ae536a78 ("net/mlx5e: Add per queue netdev-genl stats")
Cc: Joe Damato <jdamato@fastly.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f04decca39f2..5df904639b0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5296,7 +5296,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *rq_stats;
 
 	ASSERT_RTNL();
-	if (mlx5e_is_uplink_rep(priv))
+	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5316,6 +5316,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	struct mlx5e_sq_stats *sq_stats;
 
 	ASSERT_RTNL();
+	if (!priv->stats_nch)
+		return;
+
 	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
 	 * to date for active sq_stats, otherwise get_base_stats takes care of
 	 * inactive sqs.
-- 
2.44.0


