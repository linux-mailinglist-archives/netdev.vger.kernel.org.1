Return-Path: <netdev+bounces-153332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324719F7B09
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF5B7A23DE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5822371E;
	Thu, 19 Dec 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2agY3oh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD971FCD02;
	Thu, 19 Dec 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610689; cv=fail; b=Y8OZy089cH93JdQ67G3jBsIQnW3/XUwUuJcjSxgSMF0H+7TrroVtAh1UugSuBdvaVXvzUWcXSothTWEIrhFhIncX/qNv3hPE0U6ZGovMoBR+KuU6ctmwq8mJKhubRjhz7ypfpqrNhUAQzHvpK6Vf1jjcyY9QYL6BVYfWnoVDjiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610689; c=relaxed/simple;
	bh=TCN3RTtQA17ryiGNXaR5v2kwtus4P0soz48wY85zs30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJyXDG3WRJyMfkC956pKftAc1p+B+RA/kFskXwfIVJREmY7AYokVPb3veeAV4kBoz31VYKSmeRVODgg9QQjnZts0zEB4YQdF+gzJ1JOpAIPV7hbWYf/B+dh3/L4RbDdnnOBCxQ69bqcrNLI8G6cqmv330xCdmMTux7LGARhfdSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2agY3oh; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXY3XHeSQHkFwwGilJfaHzawOENtGEvYvL64rX8Ig2ij0i4fV760cHibhSTte0GsVvZyH69e/UtaO6j02WNyhB69DM4XzvUtCBwxI8PgvIt2Ydz8ONWyMivxSXpeGIASs/2CYA/5YcwQH5eFF7iHuI7/j34dsDfVkJYSC1U7ycVfUmc3kaeREvwF2b7OOWm03p3qb/g5Vi4um3qS+KDVV5s6l+UXS5tVqV+Oz/duZbFdjJ6nZ+eqtaf3+Ssm8c5CmmFoiinFwa9Ap3ytAJo+ksqwf0+IKR4VP26zXyZJJdHxy+18bNfe40FlIfLnlfR8ZXVccU+MIqtAB28nnEw4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx3q2ybJLpBuKbwAjxOZxgV7sRBBZue/I2ol2o1LNBk=;
 b=eiQ3F2wqS9+b1csjJS4kgwO8GULfhN0j3FcAdWeicB2DmNd2JrR4JYDF31BHBjKDcG0HssMKY3E6nf7suR/07nS3VBwsfpbFTUuXWiY8c8QxtmOO6w4xHRULdjczHLqV0uVxxNqd0xptpF8m1SwKT9emWBiROQoSkMp45kE/vRAZ3SP942V1CbTEWlRxuoxh2xy/zn9eCdg5ImtV/QAOEXhpzWG9Tiv87lHDVymI1AdP5VeglGYOaCAM0qVdZuKvLU+L7+2/Y4kdYOx38qnRmq+s95rooR9lvJyZ2Cf1/Kt4HHkR3vcnvNEm1yKD5dizOrEBT+P3TqjMqqVpb5lv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx3q2ybJLpBuKbwAjxOZxgV7sRBBZue/I2ol2o1LNBk=;
 b=Z2agY3oh9paWtsb8WYomZV+fOTzWzWGxKwNuW54i0cOtGnZKiHoKVTBfkJf0Wrpo+nEdc+iiQ7vNubAnwduJ8sIjhfhSnl5MutB+9zFDB2nsc9vgAKoFsaeoa1b+yeW/os7h2L3+yX+XJJ4vGDdQKowqI1Vro1X5MUdo69jl9SG9gsJEBu4hHuQoGlAloFiMxMxMT7KY3xaxb7e7B1pnAUeOB9YIEUl/xcP8rk5HFGVIuPBYcBhhWWgepSM6q1zzw7GLHimBH6hnHrYbM7UOkuM2SiY9WDOR55d3Mi0kse4aiIrZnwnOF7n7xLDeTA9HQ+udX0Pv1UYRQ5akNY4w6Q==
Received: from DS7PR03CA0038.namprd03.prod.outlook.com (2603:10b6:5:3b5::13)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 12:18:04 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::d1) by DS7PR03CA0038.outlook.office365.com
 (2603:10b6:5:3b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 12:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 12:18:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:17:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:17:53 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 04:17:50 -0800
From: Gal Pressman <gal@nvidia.com>
To: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, "Christoph
 Lameter" <cl@linux.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH] percpu: Remove intermediate variable in PERCPU_PTR()
Date: Thu, 19 Dec 2024 14:18:28 +0200
Message-ID: <20241219121828.2120780-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7f5316-0540-4aa5-941a-08dd20273040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJr+JjHUN2X4BqrZnrrS40WJymjLinegZwGvoIwANCERPC0Xi3gdxSPSik+M?=
 =?us-ascii?Q?yxTZjtsED1h52sqWURS0YuaN7D4IbKt1ZQuVT8h08Gb06zvIvfYAXCH/UxQK?=
 =?us-ascii?Q?DdtKDyMoavksNZP1BmD7zLd+BLulYXhgJG/FV1pjEV6/YO8OMfnJawCA8pfm?=
 =?us-ascii?Q?JhmhlgCr9GCx2l7wFsJeVQfaQRxuyHdpYqnwJSL071u2n8OmE68f11tcflrF?=
 =?us-ascii?Q?AVxwiWst7JewJ7NEWdV3ynxZzB7cm05kbeeSm3INSVjpszrWjW8zrAMn38xL?=
 =?us-ascii?Q?KIQV0NC+kKHPGg1AFEa3NwOM1wlNWtmDxvTRTf2UxAeHyKxsHJpK1MrZRCum?=
 =?us-ascii?Q?xp9U4gkE4NOdfJy2s1agk48R4bXeJJfUdHprxyP0A8dMCD6rDi3tGdI51gZn?=
 =?us-ascii?Q?g3cS3yOnaspf3Y6d7IWHa0s9rvc/syQ1cP39VfO8CpXjtMj8Q3Fe+xkNcXQQ?=
 =?us-ascii?Q?UlyHs2fKTltJ7odb3epWIuBPlyl7DMoFJPX9L8PdJ26BGoc5t5CTFXB8Fuk9?=
 =?us-ascii?Q?StA+moPxi75/V1ZZYslnmZ8FfJ75vqcuKzL3BilkCjIc6z3JqdgGHjIOxcwS?=
 =?us-ascii?Q?FKoYtuPAGDtNQosz+G+OkzfYUI0Mn9JWp8r1R0gpXCudElwIPTXYkGnomiN2?=
 =?us-ascii?Q?sJyT2rEc2Z4KzJPcMZruVGMqftFrwYh0JwfKwyZGGLV/cg5JAKAqegHqgsz4?=
 =?us-ascii?Q?UIr9HXN/b9YnIgWVfBwhXlwFJtb779IY9H6bvHgvijsqkm5h9xgcXgLRqNFk?=
 =?us-ascii?Q?YtYJa1cn2V2vi0gyGVOZ6/MSQQQcKmlf9/1h8wIYwphnTvq1N3VQdmFuhFij?=
 =?us-ascii?Q?jEzDwvrXt8KRKGFBCunZEhnv405w9Bxc2HrH7wb5ycfe7+jctnNwW5rO+tgt?=
 =?us-ascii?Q?FT/4leUR0h8gnKosoBRV1sXSPjGirbJ46jxUJmIT/MRHFLFV5+42JqdCjp8a?=
 =?us-ascii?Q?7wPMaV72EqCwSiZL+gXRpyxSPs/9viJp9XNCAQR2THBtuiyCFOSzYQCKM3Jm?=
 =?us-ascii?Q?jewW3sazVKcLscSKKe64J6tAlkAj8mG3BuhOskjmoIn0WqM5sYT65TZXlvN8?=
 =?us-ascii?Q?1hNHInm5Az4BGOj0O2TuTdOKBu1uG3Obm+f2jd3qmiDmWwAsmN4RtpPKTeeR?=
 =?us-ascii?Q?VOweeLI0E8rwsmCqF5naAIVMkEzE0vtJgw4zZayTvQycqar4b8ynr37uNOPu?=
 =?us-ascii?Q?wFhb/9+R45/i0bsspYyAJ2KmxR6806rXI+E+D9EjEaAfC6lU2lsCEqiwCYge?=
 =?us-ascii?Q?D2xOzmAzXaBfAo2F0SARASEHlVMdxhGPfz+42D/LsSRI/KBAyNMBQ+ean6Bi?=
 =?us-ascii?Q?WaKgr9gmvIQpZYIBLAymqtX22GKis+zURCeBGYCClGfdfsw1MA5r+0zPZF4y?=
 =?us-ascii?Q?6zT6+ityQ+epqReAopGC7o2sGQ0EepSfMC22A5DSKfoyC372UFI1X0eOKL9S?=
 =?us-ascii?Q?POx7OQmwaVzijG7xaajhXtsO0TDoygjeLs/pDlOlZqVWAcLp9zHQdmy7G/wA?=
 =?us-ascii?Q?CR+KX9NlitxfD48=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 12:18:04.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7f5316-0540-4aa5-941a-08dd20273040
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

The intermediate variable in the PERCPU_PTR() macro results in a kernel
panic on boot [1] due to a compiler bug seen when compiling the kernel
(+ KASAN) with gcc 11.3.1, but not when compiling with latest gcc
(v14.2)/clang(v18.1).

To solve it, remove the intermediate variable (which is not needed) and
keep the casting that resolves the address space checks.

[1]
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  CPU: 0 UID: 0 PID: 547 Comm: iptables Not tainted 6.13.0-rc1_external_tested-master #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:nf_ct_netns_do_get+0x139/0x540
  Code: 03 00 00 48 81 c4 88 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4d 8d 75 08 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 27 03 00 00 41 8b 45 08 83 c0
  RSP: 0018:ffff888116df75e8 EFLAGS: 00010207
  RAX: dffffc0000000000 RBX: 1ffff11022dbeebe RCX: ffffffff839a2382
  RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88842ec46d10
  RBP: 0000000000000002 R08: 0000000000000000 R09: fffffbfff0b0860c
  R10: ffff888116df75e8 R11: 0000000000000001 R12: ffffffff879d6a80
  R13: 0000000000000016 R14: 000000000000001e R15: ffff888116df7908
  FS:  00007fba01646740(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000055bd901800d8 CR3: 00000001205f0003 CR4: 0000000000172eb0
  Call Trace:
   <TASK>
   ? die_addr+0x3d/0xa0
   ? exc_general_protection+0x144/0x220
   ? asm_exc_general_protection+0x22/0x30
   ? __mutex_lock+0x2c2/0x1d70
   ? nf_ct_netns_do_get+0x139/0x540
   ? nf_ct_netns_do_get+0xb5/0x540
   ? net_generic+0x1f0/0x1f0
   ? __create_object+0x5e/0x80
   xt_check_target+0x1f0/0x930
   ? textify_hooks.constprop.0+0x110/0x110
   ? pcpu_alloc_noprof+0x7cd/0xcf0
   ? xt_find_target+0x148/0x1e0
   find_check_entry.constprop.0+0x6c0/0x920
   ? get_info+0x380/0x380
   ? __virt_addr_valid+0x1df/0x3b0
   ? kasan_quarantine_put+0xe3/0x200
   ? kfree+0x13e/0x3d0
   ? translate_table+0xaf5/0x1750
   translate_table+0xbd8/0x1750
   ? ipt_unregister_table_exit+0x30/0x30
   ? __might_fault+0xbb/0x170
   do_ipt_set_ctl+0x408/0x1340
   ? nf_sockopt_find.constprop.0+0x17b/0x1f0
   ? lock_downgrade+0x680/0x680
   ? lockdep_hardirqs_on_prepare+0x284/0x400
   ? ipt_register_table+0x440/0x440
   ? bit_wait_timeout+0x160/0x160
   nf_setsockopt+0x6f/0xd0
   raw_setsockopt+0x7e/0x200
   ? raw_bind+0x590/0x590
   ? do_user_addr_fault+0x812/0xd20
   do_sock_setsockopt+0x1e2/0x3f0
   ? move_addr_to_user+0x90/0x90
   ? lock_downgrade+0x680/0x680
   __sys_setsockopt+0x9e/0x100
   __x64_sys_setsockopt+0xb9/0x150
   ? do_syscall_64+0x33/0x140
   do_syscall_64+0x6d/0x140
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7fba015134ce
  Code: 0f 1f 40 00 48 8b 15 59 69 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b1 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 21
  RSP: 002b:00007ffd9de6f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
  RAX: ffffffffffffffda RBX: 000055bd9017f490 RCX: 00007fba015134ce
  RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000004
  RBP: 0000000000000500 R08: 0000000000000560 R09: 0000000000000052
  R10: 000055bd901800e0 R11: 0000000000000246 R12: 000055bd90180140
  R13: 000055bd901800e0 R14: 000055bd9017f498 R15: 000055bd9017ff10
   </TASK>
  Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc mlx4_ib mlx4_en mlx4_core rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi fuse ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_core
  ---[ end trace 0000000000000000 ]---

Fixes: dabddd687c9e ("percpu: cast percpu pointer in PERCPU_PTR() via unsigned long")
Closes: https://lore.kernel.org/all/7590f546-4021-4602-9252-0d525de35b52@nvidia.com
Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/percpu-defs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 35842d1e3879..573adb643d90 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -222,8 +222,7 @@ do {									\
 
 #define PERCPU_PTR(__p)							\
 ({									\
-	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
-	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
+	(typeof(*(__p)) __force __kernel *)((__force unsigned long)(__p)); \
 })
 
 #ifdef CONFIG_SMP
-- 
2.40.1


