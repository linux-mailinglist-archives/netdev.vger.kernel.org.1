Return-Path: <netdev+bounces-158498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55997A122DD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3575E1889BFA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551C2416AD;
	Wed, 15 Jan 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIIA56TM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18C2361FF
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941293; cv=fail; b=g7fRDZRsWZZQYZXsyRWwxQ99e3xOAkCRhTVg3w47u0xGo58fOQ/cWB0CSdCqeL2nkxAWcXBPr2TQ+ocIAZQo64GXKbOGuS3rucl+WpjpHMvBQ5SDBV2xmf5TwOBtsWDBCETTSeQ64aFj0P8nRQvFurghegjp4mpqBqvWnTNKMuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941293; c=relaxed/simple;
	bh=kDaG2cOzbIogowgbkL+I+ROP52QcXHrhkZadl4E/2nY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7lpuEoFeaS3tGHJ8vK7F2uYFEkIaZlpsTRQIbEt/OGMqiOu/g6I6vw/aUJ2HgZOGY3ulMwfK8GPXNub5ISmRYb0b41z5U2ZU7IhdMAqr6MQbuBcm7U6PPv/9Sz4KH/CmMQlYONOAnYkXu8kOMRZAc+7aqk8xO9s91F5iFdFeWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIIA56TM; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfpWCHguclwHte5PxWtmUxcni17mJZ1sykhVcNPjAsT9c9ouWSTHuM67HgcueZP2PEiXzseuafbjeyEyBr9WRtx8nm1M9Nx0zEQaRQpbeRVtIVF76ogaVeAKpr9ar7mq+qe7DPIL6c088iZQTUnHy/++mZSuRCHfU+O92cLo6j52NmQjl/tqG2YmF/cFa+nNGNCtyGtMRhlJ/n0AEPL7En93aY4rH2tnEmqmnzAsc6k5Or7AGF0aYiIxDAxjBWTmuAfrd5ZxUxl+GfexuOt0YMMTcV1H6fWmsaFbrzm29L81qkIr+G8ucCtkofQ8B0g5xUcHJHBT+iVmgzj3kmc0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CI3oAkYeVeN7qpitJWqFdgIlEA6L4pXtKuEepmOtqU=;
 b=kLXi+Ply2MHB2wZZKB/jR9vbN+hW8POAQzX5K4/oCwDhcCfKnKYR6XFk04fbMLjTQxCfCqBKxABYdGUZfMnrZD39VS6k6MqmSRoIkPEazhPGyc+ffzxWYGybY3aemd0JM26jSIUYZPa8okRCR9crsGWcWLYoOUszAw36H08MYEkGQOjXUVsZVySjIPYua2l0GxcpJ7KyUS7uwJVGULk5LeGaBQinxWnOr0cwlGdhXH4SR2Feq3mahlseAPcVdtVhsXaETSKaHyfB5fxd4PDoUlJUnV8IJo2J8UpGvYDmznf1AdTYbRzxZMpq7aw03dTCWRFelW9H0YoyVBV0NdnKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CI3oAkYeVeN7qpitJWqFdgIlEA6L4pXtKuEepmOtqU=;
 b=NIIA56TMRBAYzfxNFe84n6xIH4/aYeZRnLynKeOk2kBgPwB3d1UYWIqRPFrp37+ex2e1u2X6lQyU5QjC5SBCn/YU/VTEdLAzAzfM6RdD4CybKw8X5IgOLb61/Hk8TIcQv/bnSbknZnDQuUkjoauQxRBbMYteEs6K/mUDD9FwCf0508xRuVnGzGP5cMI53hnF57ZeNqdYVVwduwqwwmarlntNCaALHhbg5XxYhS6M7BPVZluDGfymQaYB7TLQN2np0PDiG+TfsjwH81BFebHiiBKq2mbpRryIGuxfwGTYaHMj9q48l8Ao5vwA0K/V/txAa4ur7VqzmHFPkzO5Zs0JYQ==
Received: from DS2PEPF00004565.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::506) by SA1PR12MB9491.namprd12.prod.outlook.com
 (2603:10b6:806:458::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:41:26 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:92f::1002:0:5) by DS2PEPF00004565.outlook.office365.com
 (2603:10b6:f:fc00::506) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.4 via Frontend Transport; Wed,
 15 Jan 2025 11:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:41:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 5/7] net/mlx5e: Fix inversion dependency warning while enabling IPsec tunnel
Date: Wed, 15 Jan 2025 13:39:08 +0200
Message-ID: <20250115113910.1990174-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6205e279-efec-4b91-f2f9-08dd35598b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twbIfK8nyFm3rEO2YLi5E/ArCjphQO22GJEJXNdVmFJ5UIIHR1cR3VKurQ7U?=
 =?us-ascii?Q?uabPFBxHpaorBqs+d9+wHup3+KcJ3oMgYHFhJypoZt3wLnRrZ+cIEKXQ3uNu?=
 =?us-ascii?Q?Y/s/SIxKx0i13xKiKqbIq57znVHo71t33VCVkKt0S5Oajwv1uocEPCxw7LWb?=
 =?us-ascii?Q?HczuhmYeIElQ5gsfCvXbObotOeWUfKmorL7dIf0hQq3XXPrtMJvRk60Lw7UR?=
 =?us-ascii?Q?4Z0zoO5eVb4waQ9rp+Wg1hLV1x7ToOtWf+TSY6kG7IJ4SuBMOe4+lpgITtT4?=
 =?us-ascii?Q?G++dd+GAKZB2zKzilpHUhhM+h3kroKCKu2qHbek9RkItOXVlyAXnrBHnwaoU?=
 =?us-ascii?Q?akbnqmNBIn09oa5F7Vjq5IovPb67xprQCFlYAKTuoQM+Epbrzms4rRPQ3ObT?=
 =?us-ascii?Q?EIuUAnNfnb8+sni9VI/ProPVg/iJp+pWDBWhfALbzOMyf+C69Z7FSaR7fI+0?=
 =?us-ascii?Q?bMRJfuPH/E7LqRyrkBxBdvQREFHAVGk/I+xL8KcsZpbs2RSFTkG6gDOV6gVS?=
 =?us-ascii?Q?jF2rZmwqFzCZL/qjsF2wplemKvpLrCgTgNLhbunavcffcDGcOmSmxYLE+ol7?=
 =?us-ascii?Q?X8ZIvmSyIQr3m2sn+bI3rIGG5weyIaSXNCqL+0FQM0YQG1xZ4WxweOyX7xyK?=
 =?us-ascii?Q?l48hQfnYTwHc1sbChDxrleIjlXFVce5wLf6qaEbe5n2WfH6Y2Llx6XxujfeR?=
 =?us-ascii?Q?18VLiFz8Z5EEq+vSrGpzv39ApgYkyEqWt1SDacNEDu+N2Mai/8vQBTPmXCqw?=
 =?us-ascii?Q?F27ZPRmhrnsBOvcoZPy8xIn11xhnJCx4aqPWsA0X5ZPD09qz/zmWTTuvmjyQ?=
 =?us-ascii?Q?8C+WHtapeP4s7vhTmZdify5lAeC8Ws0dXrdByuojK88tljGDpnNNtFf2fiNO?=
 =?us-ascii?Q?kTOwCPGikO8rU6gJpFOqVOdjmwwgOU47rn1PKNe1tFb13nq/9OMZkXpfg8XR?=
 =?us-ascii?Q?zamgXQ6y6aM29vhDm9QVKUS0Ku5wvxQezTml2/9nWBWVaZqghizSc2J60Top?=
 =?us-ascii?Q?waDIy9QnoJoxk0Eu96Vhwbv9T1+DnVONTDmJrvSeGUWkVZZoVhPznbMJObLV?=
 =?us-ascii?Q?2r957IXIoRr2uAiIi8GRD3fOyGHouRwjWouvHnGsfFUvFweC/k4pYNxvx1rH?=
 =?us-ascii?Q?GEMMWXzro0IKsPyxvUbzhZq7mNirvoSN1J+bflVKOyl8eCQf28u3CGpjYAuJ?=
 =?us-ascii?Q?IR0NCMKdI5ujGIu8JYmYe1b2kEGuoq9FIRWEIHjdFpwpmmV5/YBywymZJDm2?=
 =?us-ascii?Q?6pe652tCa0hAaDfnJpH4j1kkpR1HMXok79FglIwInOlMoqwnO4fZEpOQfILO?=
 =?us-ascii?Q?wIRwDJnaW41W4kOOYC1Gv4lWXb+e7rXCsn94NTYQUSOdubRqA3HN8Rfdo60W?=
 =?us-ascii?Q?a0twbqmPRS4gcbQ8gnD/H2/Pfb1vdjUsPPAUvlRxbBDbh7oeZHUC3u4G24oC?=
 =?us-ascii?Q?8FKPcHKT9/Gxb0g+8ycfEZqarfvDkwn+XPcmBXs+fJ7ezJMfHx1EXGuT/1Ei?=
 =?us-ascii?Q?9w8mwhY5nwm7gJU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:25.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6205e279-efec-4b91-f2f9-08dd35598b1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491

From: Leon Romanovsky <leonro@nvidia.com>

Attempt to enable IPsec packet offload in tunnel mode in debug kernel
generates the following kernel panic, which is happening due to two
issues:
1. In SA add section, the should be _bh() variant when marking SA mode.
2. There is not needed flush_workqueue in SA delete routine. It is not
needed as at this stage as it is removed from SADB and the running work
will be canceled later in SA free.

 =====================================================
 WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
 6.12.0+ #4 Not tainted
 -----------------------------------------------------
 charon/1337 [HC0[0]:SC0[4]:HE1:SE0] is trying to acquire:
 ffff88810f365020 (&xa->xa_lock#24){+.+.}-{3:3}, at: mlx5e_xfrm_del_state+0xca/0x1e0 [mlx5_core]

 and this task is already holding:
 ffff88813e0f0d48 (&x->lock){+.-.}-{3:3}, at: xfrm_state_delete+0x16/0x30
 which would create a new lock dependency:
  (&x->lock){+.-.}-{3:3} -> (&xa->xa_lock#24){+.+.}-{3:3}

 but this new dependency connects a SOFTIRQ-irq-safe lock:
  (&x->lock){+.-.}-{3:3}

 ... which became SOFTIRQ-irq-safe at:
   lock_acquire+0x1be/0x520
   _raw_spin_lock_bh+0x34/0x40
   xfrm_timer_handler+0x91/0xd70
   __hrtimer_run_queues+0x1dd/0xa60
   hrtimer_run_softirq+0x146/0x2e0
   handle_softirqs+0x266/0x860
   irq_exit_rcu+0x115/0x1a0
   sysvec_apic_timer_interrupt+0x6e/0x90
   asm_sysvec_apic_timer_interrupt+0x16/0x20
   default_idle+0x13/0x20
   default_idle_call+0x67/0xa0
   do_idle+0x2da/0x320
   cpu_startup_entry+0x50/0x60
   start_secondary+0x213/0x2a0
   common_startup_64+0x129/0x138

 to a SOFTIRQ-irq-unsafe lock:
  (&xa->xa_lock#24){+.+.}-{3:3}

 ... which became SOFTIRQ-irq-unsafe at:
 ...
   lock_acquire+0x1be/0x520
   _raw_spin_lock+0x2c/0x40
   xa_set_mark+0x70/0x110
   mlx5e_xfrm_add_state+0xe48/0x2290 [mlx5_core]
   xfrm_dev_state_add+0x3bb/0xd70
   xfrm_add_sa+0x2451/0x4a90
   xfrm_user_rcv_msg+0x493/0x880
   netlink_rcv_skb+0x12e/0x380
   xfrm_netlink_rcv+0x6d/0x90
   netlink_unicast+0x42f/0x740
   netlink_sendmsg+0x745/0xbe0
   __sock_sendmsg+0xc5/0x190
   __sys_sendto+0x1fe/0x2c0
   __x64_sys_sendto+0xdc/0x1b0
   do_syscall_64+0x6d/0x140
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

 other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&xa->xa_lock#24);
                                local_irq_disable();
                                lock(&x->lock);
                                lock(&xa->xa_lock#24);
   <Interrupt>
     lock(&x->lock);

  *** DEADLOCK ***

 2 locks held by charon/1337:
  #0: ffffffff87f8f858 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x5e/0x90
  #1: ffff88813e0f0d48 (&x->lock){+.-.}-{3:3}, at: xfrm_state_delete+0x16/0x30

 the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (&x->lock){+.-.}-{3:3} ops: 29 {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1be/0x520
                     _raw_spin_lock_bh+0x34/0x40
                     xfrm_alloc_spi+0xc0/0xe60
                     xfrm_alloc_userspi+0x5f6/0xbc0
                     xfrm_user_rcv_msg+0x493/0x880
                     netlink_rcv_skb+0x12e/0x380
                     xfrm_netlink_rcv+0x6d/0x90
                     netlink_unicast+0x42f/0x740
                     netlink_sendmsg+0x745/0xbe0
                     __sock_sendmsg+0xc5/0x190
                     __sys_sendto+0x1fe/0x2c0
                     __x64_sys_sendto+0xdc/0x1b0
                     do_syscall_64+0x6d/0x140
                     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    IN-SOFTIRQ-W at:
                     lock_acquire+0x1be/0x520
                     _raw_spin_lock_bh+0x34/0x40
                     xfrm_timer_handler+0x91/0xd70
                     __hrtimer_run_queues+0x1dd/0xa60
                     hrtimer_run_softirq+0x146/0x2e0
                     handle_softirqs+0x266/0x860
                     irq_exit_rcu+0x115/0x1a0
                     sysvec_apic_timer_interrupt+0x6e/0x90
                     asm_sysvec_apic_timer_interrupt+0x16/0x20
                     default_idle+0x13/0x20
                     default_idle_call+0x67/0xa0
                     do_idle+0x2da/0x320
                     cpu_startup_entry+0x50/0x60
                     start_secondary+0x213/0x2a0
                     common_startup_64+0x129/0x138
    INITIAL USE at:
                    lock_acquire+0x1be/0x520
                    _raw_spin_lock_bh+0x34/0x40
                    xfrm_alloc_spi+0xc0/0xe60
                    xfrm_alloc_userspi+0x5f6/0xbc0
                    xfrm_user_rcv_msg+0x493/0x880
                    netlink_rcv_skb+0x12e/0x380
                    xfrm_netlink_rcv+0x6d/0x90
                    netlink_unicast+0x42f/0x740
                    netlink_sendmsg+0x745/0xbe0
                    __sock_sendmsg+0xc5/0x190
                    __sys_sendto+0x1fe/0x2c0
                    __x64_sys_sendto+0xdc/0x1b0
                    do_syscall_64+0x6d/0x140
                    entry_SYSCALL_64_after_hwframe+0x4b/0x53
  }
  ... key      at: [<ffffffff87f9cd20>] __key.18+0x0/0x40

 the dependencies between the lock to be acquired
  and SOFTIRQ-irq-unsafe lock:
 -> (&xa->xa_lock#24){+.+.}-{3:3} ops: 9 {
    HARDIRQ-ON-W at:
                     lock_acquire+0x1be/0x520
                     _raw_spin_lock_bh+0x34/0x40
                     mlx5e_xfrm_add_state+0xc5b/0x2290 [mlx5_core]
                     xfrm_dev_state_add+0x3bb/0xd70
                     xfrm_add_sa+0x2451/0x4a90
                     xfrm_user_rcv_msg+0x493/0x880
                     netlink_rcv_skb+0x12e/0x380
                     xfrm_netlink_rcv+0x6d/0x90
                     netlink_unicast+0x42f/0x740
                     netlink_sendmsg+0x745/0xbe0
                     __sock_sendmsg+0xc5/0x190
                     __sys_sendto+0x1fe/0x2c0
                     __x64_sys_sendto+0xdc/0x1b0
                     do_syscall_64+0x6d/0x140
                     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    SOFTIRQ-ON-W at:
                     lock_acquire+0x1be/0x520
                     _raw_spin_lock+0x2c/0x40
                     xa_set_mark+0x70/0x110
                     mlx5e_xfrm_add_state+0xe48/0x2290 [mlx5_core]
                     xfrm_dev_state_add+0x3bb/0xd70
                     xfrm_add_sa+0x2451/0x4a90
                     xfrm_user_rcv_msg+0x493/0x880
                     netlink_rcv_skb+0x12e/0x380
                     xfrm_netlink_rcv+0x6d/0x90
                     netlink_unicast+0x42f/0x740
                     netlink_sendmsg+0x745/0xbe0
                     __sock_sendmsg+0xc5/0x190
                     __sys_sendto+0x1fe/0x2c0
                     __x64_sys_sendto+0xdc/0x1b0
                     do_syscall_64+0x6d/0x140
                     entry_SYSCALL_64_after_hwframe+0x4b/0x53
    INITIAL USE at:
                    lock_acquire+0x1be/0x520
                    _raw_spin_lock_bh+0x34/0x40
                    mlx5e_xfrm_add_state+0xc5b/0x2290 [mlx5_core]
                    xfrm_dev_state_add+0x3bb/0xd70
                    xfrm_add_sa+0x2451/0x4a90
                    xfrm_user_rcv_msg+0x493/0x880
                    netlink_rcv_skb+0x12e/0x380
                    xfrm_netlink_rcv+0x6d/0x90
                    netlink_unicast+0x42f/0x740
                    netlink_sendmsg+0x745/0xbe0
                    __sock_sendmsg+0xc5/0x190
                    __sys_sendto+0x1fe/0x2c0
                    __x64_sys_sendto+0xdc/0x1b0
                    do_syscall_64+0x6d/0x140
                    entry_SYSCALL_64_after_hwframe+0x4b/0x53
  }
  ... key      at: [<ffffffffa078ff60>] __key.48+0x0/0xfffffffffff210a0 [mlx5_core]
  ... acquired at:
    __lock_acquire+0x30a0/0x5040
    lock_acquire+0x1be/0x520
    _raw_spin_lock_bh+0x34/0x40
    mlx5e_xfrm_del_state+0xca/0x1e0 [mlx5_core]
    xfrm_dev_state_delete+0x90/0x160
    __xfrm_state_delete+0x662/0xae0
    xfrm_state_delete+0x1e/0x30
    xfrm_del_sa+0x1c2/0x340
    xfrm_user_rcv_msg+0x493/0x880
    netlink_rcv_skb+0x12e/0x380
    xfrm_netlink_rcv+0x6d/0x90
    netlink_unicast+0x42f/0x740
    netlink_sendmsg+0x745/0xbe0
    __sock_sendmsg+0xc5/0x190
    __sys_sendto+0x1fe/0x2c0
    __x64_sys_sendto+0xdc/0x1b0
    do_syscall_64+0x6d/0x140
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

 stack backtrace:
 CPU: 7 UID: 0 PID: 1337 Comm: charon Not tainted 6.12.0+ #4
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x74/0xd0
  check_irq_usage+0x12e8/0x1d90
  ? print_shortest_lock_dependencies_backwards+0x1b0/0x1b0
  ? check_chain_key+0x1bb/0x4c0
  ? __lockdep_reset_lock+0x180/0x180
  ? check_path.constprop.0+0x24/0x50
  ? mark_lock+0x108/0x2fb0
  ? print_circular_bug+0x9b0/0x9b0
  ? mark_lock+0x108/0x2fb0
  ? print_usage_bug.part.0+0x670/0x670
  ? check_prev_add+0x1c4/0x2310
  check_prev_add+0x1c4/0x2310
  __lock_acquire+0x30a0/0x5040
  ? lockdep_set_lock_cmp_fn+0x190/0x190
  ? lockdep_set_lock_cmp_fn+0x190/0x190
  lock_acquire+0x1be/0x520
  ? mlx5e_xfrm_del_state+0xca/0x1e0 [mlx5_core]
  ? lockdep_hardirqs_on_prepare+0x400/0x400
  ? __xfrm_state_delete+0x5f0/0xae0
  ? lock_downgrade+0x6b0/0x6b0
  _raw_spin_lock_bh+0x34/0x40
  ? mlx5e_xfrm_del_state+0xca/0x1e0 [mlx5_core]
  mlx5e_xfrm_del_state+0xca/0x1e0 [mlx5_core]
  xfrm_dev_state_delete+0x90/0x160
  __xfrm_state_delete+0x662/0xae0
  xfrm_state_delete+0x1e/0x30
  xfrm_del_sa+0x1c2/0x340
  ? xfrm_get_sa+0x250/0x250
  ? check_chain_key+0x1bb/0x4c0
  xfrm_user_rcv_msg+0x493/0x880
  ? copy_sec_ctx+0x270/0x270
  ? check_chain_key+0x1bb/0x4c0
  ? lockdep_set_lock_cmp_fn+0x190/0x190
  ? lockdep_set_lock_cmp_fn+0x190/0x190
  netlink_rcv_skb+0x12e/0x380
  ? copy_sec_ctx+0x270/0x270
  ? netlink_ack+0xd90/0xd90
  ? netlink_deliver_tap+0xcd/0xb60
  xfrm_netlink_rcv+0x6d/0x90
  netlink_unicast+0x42f/0x740
  ? netlink_attachskb+0x730/0x730
  ? lock_acquire+0x1be/0x520
  netlink_sendmsg+0x745/0xbe0
  ? netlink_unicast+0x740/0x740
  ? __might_fault+0xbb/0x170
  ? netlink_unicast+0x740/0x740
  __sock_sendmsg+0xc5/0x190
  ? fdget+0x163/0x1d0
  __sys_sendto+0x1fe/0x2c0
  ? __x64_sys_getpeername+0xb0/0xb0
  ? do_user_addr_fault+0x856/0xe30
  ? lock_acquire+0x1be/0x520
  ? __task_pid_nr_ns+0x117/0x410
  ? lock_downgrade+0x6b0/0x6b0
  __x64_sys_sendto+0xdc/0x1b0
  ? lockdep_hardirqs_on_prepare+0x284/0x400
  do_syscall_64+0x6d/0x140
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f7d31291ba4
 Code: 7d e8 89 4d d4 e8 4c 42 f7 ff 44 8b 4d d0 4c 8b 45 c8 89 c3 44 8b 55 d4 8b 7d e8 b8 2c 00 00 00 48 8b 55 d8 48 8b 75 e0 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 45 e8 e8 99 42 f7 ff 48 8b 45
 RSP: 002b:00007f7d2ccd94f0 EFLAGS: 00000297 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f7d31291ba4
 RDX: 0000000000000028 RSI: 00007f7d2ccd96a0 RDI: 000000000000000a
 RBP: 00007f7d2ccd9530 R08: 00007f7d2ccd9598 R09: 000000000000000c
 R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000028
 R13: 00007f7d2ccd9598 R14: 00007f7d2ccd96a0 R15: 00000000000000e1
  </TASK>

Fixes: 4c24272b4e2b ("net/mlx5e: Listen to ARP events to update IPsec L2 headers in tunnel mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ca92e518be76..21857474ad83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -768,9 +768,12 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 				   MLX5_IPSEC_RESCHED);
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
-	    x->props.mode == XFRM_MODE_TUNNEL)
-		xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
-			    MLX5E_IPSEC_TUNNEL_SA);
+	    x->props.mode == XFRM_MODE_TUNNEL) {
+		xa_lock_bh(&ipsec->sadb);
+		__xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
+			      MLX5E_IPSEC_TUNNEL_SA);
+		xa_unlock_bh(&ipsec->sadb);
+	}
 
 out:
 	x->xso.offload_handle = (unsigned long)sa_entry;
@@ -797,7 +800,6 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
-	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 	struct mlx5e_ipsec_sa_entry *old;
 
@@ -806,12 +808,6 @@ static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 
 	old = xa_erase_bh(&ipsec->sadb, sa_entry->ipsec_obj_id);
 	WARN_ON(old != sa_entry);
-
-	if (attrs->mode == XFRM_MODE_TUNNEL &&
-	    attrs->type == XFRM_DEV_OFFLOAD_PACKET)
-		/* Make sure that no ARP requests are running in parallel */
-		flush_workqueue(ipsec->wq);
-
 }
 
 static void mlx5e_xfrm_free_state(struct xfrm_state *x)
-- 
2.45.0


