Return-Path: <netdev+bounces-85804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1B89C4C5
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C12819F8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64287D3E8;
	Mon,  8 Apr 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gn1WBo7F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F257C092
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584174; cv=fail; b=UaH7YITXly1cavQIlAEoJ0t5kiKIxbMBFu2E4GEpJGh62WKBX1EZ1Jz22qXa5EV07C9YU+mUtrTMubziQ9SEC8OZuRhN6epahBQq+kR7S/bka7CxlpwZpFz4WJASqkDGJz4jPu9nzsUjjWgiTyLTyAJUfle0Fq8kFlefj+WscTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584174; c=relaxed/simple;
	bh=em3++lal1NPpYFjJIsEgxfz97f+/FY4N3gs8fN60jkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3CPSQxfRojbT+/cClvZ/BcsVPdxRenom/AdIFm31//Ys2lnE7EyckcjYn0ZxYOUn+IcIH+UIcxZ4RRZI8vgzYnE+n8MOJLfmXwPW/muRAr1erJgzaW8CGkYPJbqck7AmcbJcph/s8/lavu6vIVv05H5Wlil9E5Y2O7nP2EGzt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gn1WBo7F; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyjkK/BsL3gqtyi4bzYOioEpqz1NzhThIqhNW1JfLKaE194E4NefJMi8moBlGJtfalu4lLhyvnDfkXw32prgUrlj8/HaAcIOs9Sb1qWtGT5aZoEF/E+Ll8BuUibkWP6Gp0glfp2Yz/om1Rxp2qzz4Jfu7SMhkeKeGh7VOZDXt4KLfTQQp/O/MTpXGmBWRa8Lb/f44YKmwTMAPugVZ/9ck4dWPHkZbpDzrsIHmV9sAjiHXDmoe5p6FIUd37l/j/TM5WrbsSESjULoy8pR6B9EjeCO8nLFUgBeyv0UdLoA5esJjBwKGLCxjO0hGa/AwLhoKqiisuIxVg8Xd4MJxlfFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApD660PSN/cKeFcOPP82XyIBboIWg7j1vQS53QHKOvw=;
 b=e2mKLCvRuwmm6AVkvaDb0+9Yu5RWHseJaMyBNci4ogs30EAPiz/ZnHqe2cKNrCmJMr8nqew8cKwRr6nYOuDfOaHY12pDbuZnrZF4HWMcxTO1p0+WuZD6T/VaV8lLgQtUXwlvslk3gIcEy6PV8nsujVIvpz7Rizxli29MTUc6mSlebhnfhMFicrxkDWpyDKu+uN08z627mwI4DJ5eSLPwJlOpb5hRsgn9oY2ZTNcy4vNGXeXnq3Vjl1oVy71RindDbK3oEkkc/Cb5dpfU4ugJpHLzPiS91Nli/gvYf9DrM8lu8/qKAg2a/e9lA5wdpx14wM49BAv/arG2zd9XpD2FNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApD660PSN/cKeFcOPP82XyIBboIWg7j1vQS53QHKOvw=;
 b=gn1WBo7Fgrj36BYEb9WCZsvqzQGCvxbJ/228hxka4jslI35kp91tddAuXW0fBQqoL4SZRw9NC7ACooGp0RgrNCuQ8FR0AmJCtFSPMqNknJhI5fFuZXFYemNDmjoPcVrPXb0W+/oU5ZAUCanDhJU9pc4b2QUQrR/KMQGgWW5BdbPPdGlQ0AZvlKIZY3qBKq7/31EPdIyoTvQyAM/A1Ql6ZgrzGlsibm0vRTo0xF8kgw1RtIZdpBxOCeS7xHdutF5a1hjJxYfu0zIOg2oYRMnYw0V2RsXtewQYfa5v6neTBITbgMESZVAOgfxYxRZ7YBSrTua3ZSjgxAxXO+Kj7lWMrg==
Received: from BL1PR13CA0406.namprd13.prod.outlook.com (2603:10b6:208:2c2::21)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 13:49:29 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::b1) by BL1PR13CA0406.outlook.office365.com
 (2603:10b6:208:2c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.18 via Frontend
 Transport; Mon, 8 Apr 2024 13:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 13:49:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 06:49:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 06:49:08 -0700
Received: from localhost.localdomain (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Apr 2024 06:49:07 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <ast@fiberby.net>, <davem@davemloft.net>,
	<marcelo.leitner@gmail.com>, <horms@kernel.org>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next] net: sched: cls_api: fix slab-use-after-free in fl_dump_key
Date: Mon, 8 Apr 2024 16:48:17 +0300
Message-ID: <20240408134817.35065-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5d9559-9829-4f01-78c8-08dc57d2b5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yXqClyrk0QwFup7jRaOS/b3ifTBYeIwBr0OMEzoFMfq2/sMHOvfM9imy9GqfY/Q7u5idBV3jOD4DtuCsX8xwGcK0VycYN+5ySWabdFfkrav64CzlhLv4U2DZge30HUKtvXciK2ZnExE0NJO+Rg28UGGc/AE+Xv/s2YuyIrQ6K+V4/M3e3gM9ou3CIGGTkQ98DmzJpv6fg4T6gFD2+VdXanIjTxsZMiXHLmk3pxKXZ4FEuW0OiR8ivXpls7LRBj/SvAZS+uL09z3Nr3VZxZP22x0NIdiutLbTM/D+HrmRNjNwefXXpCXgKx1Rk5wE6f3T/EhN7LdjJqjsqSAMrn1cYiV5HmBJjolG93scd3L/TaTejbr+G+kNhuKqsp3sbNxHRYssqU83Syrq+2SlMxJAOVaFKa/R0gk1XPyI8OR1g5+xJDEc5o/rwgORE/b1ggaXYM6+goklkeTjNdBKv7oA9hN1LNM8NUZv40XvUc6priP2+1k19p6QkTh7sVudpsmpbaDDX4IVJhkgo0poS0tZw1MO4ddnqCf7ZnGJk1SoftcFbBfT6kd1CeOWltcTpc2K2g2/4BRVGM/pSWy5UZONhOAkFmp6+WS4o9olvA0wfS8G8MXLOugL3iuN826q1xvmKba4jerZKqu/kjXwS1bIn/4F73/9cjZ45Juj0ai7U5uJ++NcnNDn4QUQ0ztYsTnh2ZNwV5Sg33UI+GrQX6qGowwbclKhqMIwq+9JYplpczy47aLufZLAZdS+pR8C3hbl
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:49:28.5707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5d9559-9829-4f01-78c8-08dc57d2b5fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

The filter counter is updated under the protection of cb_lock in the
cited commit. While waiting for the lock, it's possible the filter is
being deleted by other thread, and thus causes UAF when dump it.

Fix this issue by moving tcf_block_filter_cnt_update() after
tfilter_put().

 ==================================================================
 BUG: KASAN: slab-use-after-free in fl_dump_key+0x1d3e/0x20d0 [cls_flower]
 Read of size 4 at addr ffff88814f864000 by task tc/2973

 CPU: 7 PID: 2973 Comm: tc Not tainted 6.9.0-rc2_for_upstream_debug_2024_04_02_12_41 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7e/0xc0
  print_report+0xc1/0x600
  ? __virt_addr_valid+0x1cf/0x390
  ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
  ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
  kasan_report+0xb9/0xf0
  ? fl_dump_key+0x1d3e/0x20d0 [cls_flower]
  fl_dump_key+0x1d3e/0x20d0 [cls_flower]
  ? lock_acquire+0x1c2/0x530
  ? fl_dump+0x172/0x5c0 [cls_flower]
  ? lockdep_hardirqs_on_prepare+0x400/0x400
  ? fl_dump_key_options.part.0+0x10f0/0x10f0 [cls_flower]
  ? do_raw_spin_lock+0x12d/0x270
  ? spin_bug+0x1d0/0x1d0
  fl_dump+0x21d/0x5c0 [cls_flower]
  ? fl_tmplt_dump+0x1f0/0x1f0 [cls_flower]
  ? nla_put+0x15f/0x1c0
  tcf_fill_node+0x51b/0x9a0
  ? tc_skb_ext_tc_enable+0x150/0x150
  ? __alloc_skb+0x17b/0x310
  ? __build_skb_around+0x340/0x340
  ? down_write+0x1b0/0x1e0
  tfilter_notify+0x1a5/0x390
  ? fl_terse_dump+0x400/0x400 [cls_flower]
  tc_new_tfilter+0x963/0x2170
  ? tc_del_tfilter+0x1490/0x1490
  ? print_usage_bug.part.0+0x670/0x670
  ? lock_downgrade+0x680/0x680
  ? security_capable+0x51/0x90
  ? tc_del_tfilter+0x1490/0x1490
  rtnetlink_rcv_msg+0x75e/0xac0
  ? if_nlmsg_stats_size+0x4c0/0x4c0
  ? lockdep_set_lock_cmp_fn+0x190/0x190
  ? __netlink_lookup+0x35e/0x6e0
  netlink_rcv_skb+0x12c/0x360
  ? if_nlmsg_stats_size+0x4c0/0x4c0
  ? netlink_ack+0x15e0/0x15e0
  ? lockdep_hardirqs_on_prepare+0x400/0x400
  ? netlink_deliver_tap+0xcd/0xa60
  ? netlink_deliver_tap+0xcd/0xa60
  ? netlink_deliver_tap+0x1c9/0xa60
  netlink_unicast+0x43e/0x700
  ? netlink_attachskb+0x750/0x750
  ? lock_acquire+0x1c2/0x530
  ? __might_fault+0xbb/0x170
  netlink_sendmsg+0x749/0xc10
  ? netlink_unicast+0x700/0x700
  ? __might_fault+0xbb/0x170
  ? netlink_unicast+0x700/0x700
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x534/0x6b0
  ? import_iovec+0x7/0x10
  ? kernel_sendmsg+0x30/0x30
  ? __copy_msghdr+0x3c0/0x3c0
  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
  ? lock_acquire+0x1c2/0x530
  ? __virt_addr_valid+0x116/0x390
  ___sys_sendmsg+0xeb/0x170
  ? __virt_addr_valid+0x1ca/0x390
  ? copy_msghdr_from_user+0x110/0x110
  ? __delete_object+0xb8/0x100
  ? __virt_addr_valid+0x1cf/0x390
  ? do_sys_openat2+0x102/0x150
  ? lockdep_hardirqs_on_prepare+0x284/0x400
  ? do_sys_openat2+0x102/0x150
  ? __fget_light+0x53/0x1d0
  ? sockfd_lookup_light+0x1a/0x150
  __sys_sendmsg+0xb5/0x140
  ? __sys_sendmsg_sock+0x20/0x20
  ? lock_downgrade+0x680/0x680
  do_syscall_64+0x70/0x140
  entry_SYSCALL_64_after_hwframe+0x46/0x4e
 RIP: 0033:0x7f98e3713367
 Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
 RSP: 002b:00007ffc74a64608 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 000000000047eae0 RCX: 00007f98e3713367
 RDX: 0000000000000000 RSI: 00007ffc74a64670 RDI: 0000000000000003
 RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f98e360c5e8 R11: 0000000000000246 R12: 00007ffc74a6a508
 R13: 00000000660d518d R14: 0000000000484a80 R15: 00007ffc74a6a50b
  </TASK>

 Allocated by task 2973:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x77/0x90
  fl_change+0x27a6/0x4540 [cls_flower]
  tc_new_tfilter+0x879/0x2170
  rtnetlink_rcv_msg+0x75e/0xac0
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x43e/0x700
  netlink_sendmsg+0x749/0xc10
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x534/0x6b0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x70/0x140
  entry_SYSCALL_64_after_hwframe+0x46/0x4e

 Freed by task 283:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  kasan_save_free_info+0x37/0x50
  poison_slab_object+0x105/0x190
  __kasan_slab_free+0x11/0x30
  kfree+0x111/0x340
  process_one_work+0x787/0x1490
  worker_thread+0x586/0xd30
  kthread+0x2df/0x3b0
  ret_from_fork+0x2d/0x70
  ret_from_fork_asm+0x11/0x20

 Last potentially related work creation:
  kasan_save_stack+0x20/0x40
  __kasan_record_aux_stack+0x9b/0xb0
  insert_work+0x25/0x1b0
  __queue_work+0x640/0xc90
  rcu_work_rcufn+0x42/0x70
  rcu_core+0x6a9/0x1850
  __do_softirq+0x264/0x88f

 Second to last potentially related work creation:
  kasan_save_stack+0x20/0x40
  __kasan_record_aux_stack+0x9b/0xb0
  __call_rcu_common.constprop.0+0x6f/0xac0
  queue_rcu_work+0x56/0x70
  fl_mask_put+0x20d/0x270 [cls_flower]
  __fl_delete+0x352/0x6b0 [cls_flower]
  fl_delete+0x97/0x160 [cls_flower]
  tc_del_tfilter+0x7d1/0x1490
  rtnetlink_rcv_msg+0x75e/0xac0
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x43e/0x700
  netlink_sendmsg+0x749/0xc10
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x534/0x6b0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x70/0x140
  entry_SYSCALL_64_after_hwframe+0x46/0x4e

Fixes: 2081fd3445fe ("net: sched: cls_api: add filter counter")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index db0653993632..17d97bbe890f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2400,10 +2400,10 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
+		tcf_block_filter_cnt_update(block, &tp->counted, true);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
-- 
2.38.1


