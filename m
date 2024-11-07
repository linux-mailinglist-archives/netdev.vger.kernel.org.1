Return-Path: <netdev+bounces-143005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598409C0DE8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18745284546
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848B217440;
	Thu,  7 Nov 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTOxMdD4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90449217330
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004606; cv=fail; b=XfmS/gVFWDo5wp2nvOot97X5I5VMfXZbTTcixmD4bEB9G/JmAMNRNo6fV5ZJGKjesZdpVYo3+LZw3SpLA34jOoA8065JKswKi1wCOJXTg/GH8u6qVDzD2M8Re7I7aCnPmT8GOTOzj51sXyE1EBkjhvIltTUhyHacyri59laYYPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004606; c=relaxed/simple;
	bh=M4XCrWMnjsUqJ/4MA6O0F3MkTIE4kPs5HGwFgitl/Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiRQrkapgNs2qjM045rr7BhFLvOMP6gD00jUplgCwLg0ADgn076BuaoSukX1nIT6jORwXZ77ATyqFxMIL1TqG+LjdPw/KSSQ9Kst6xuPWyJxx5hO/bOdKt1i3YyGoFYqW+WPm0wgtduLLSqlatBcn+jIXDFLrckJdLQR1wuRNaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTOxMdD4; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEGVnzQmhvP+07YtkdrRquE1NwpW6PjG++4O0NFikV43f5rE0CIPzv7n5SuNJw9wdJCchtkUpbmzXBqEoN4V+HJJd6D/NoZUGZUnkgKnSyCFKfVE9HebTi/SF5/PwctjdtGCrixn0QsyEcPubknrTKIk4GZGtA7LwAW3RGHM84TjYJCGBOMD6XF9iLvPigimx6RRh277QpVS6wG7rp3UipkcjqY/maMQHyGpdEIGRk4qQjume+qLM6g5LVPlxcbx7H8nnHc1wwLCPNSlphGgHH1cY/Y2Ysis8FQMtkCSDC3ojhXfp5U0LsFXaevdKWOKXt995DtWwgS15zwCXYS7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHzok/D47q4mb/HhfKQ4HNnsPr9zk6NO93kakVQ03zQ=;
 b=lZfov58QLzxjVxga83pzC1ysCeZcETyXJc699XJ9aU6wmnuWCnNnzH4rX8nuqS+rCoHWcTVrf5dubqqzHCwOIF57OYi8ejvCyzA9Q/hLyeZK5SNB37+nrik5goba+iO/dMebV9MShAK1EsWs5vMvTCWd2KtiFl0eIRgjP7TGLhRhpSK6td29rK1wtiEGRizgRLNaee8fBWQ/XpirEXCNe+lbPmoWTyzop24sAFSOFTWw43wUErJbBBewaXJJd8sG715jVkWYj9zphMcgw42yjCjE4vI1SuJ39rbDcBWyr7haTXQPJ/ljr7sX4uPB72fMVUV6Fu3BO3DQa6ANhhiusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHzok/D47q4mb/HhfKQ4HNnsPr9zk6NO93kakVQ03zQ=;
 b=GTOxMdD46NvFAblyIlCW0VeX6jarblvnwiTaRJHMUhq1ThaDsw4UNG8TOZ0r1HuCEW1vo97MxyblZnkxxKlItzo4L7FpLEMHVy7dS4NxGIdKo5YmBbxzrxIZQF5yV+R/sCGJmqjJ7aDUG21gf3YJ3ULk+gcRMXVb5TxNo4DjlzsKrioNblSaXGjFcJNve9C0mjypjWXsUqeBEQOBnawwkUE5eHAzvqh2cuNw4W1NuHGfRWhYDUv7fsjl2v+HKrrUYyL9HBVaEdAIsDR7e381Q3mI+vskhlplAtQrRw2NkfbHBAunDPdYjnwFojUhpygwgcm5/3F0ZlK8K2JHlNXPAw==
Received: from PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::30)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 18:36:34 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::29) by PH7P221CA0022.outlook.office365.com
 (2603:10b6:510:32a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/7] net/mlx5: fs, lock FTE when checking if active
Date: Thu, 7 Nov 2024 20:35:23 +0200
Message-ID: <20241107183527.676877-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d81dc64-6e94-4966-2406-08dcff5b1ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z1ff4nSmEXiznjqgVOPZd/LKGGHNI8XuIKxWShqVI9kyhZMN8HXzfPswZbGe?=
 =?us-ascii?Q?M8Myezi1sFKQ4FX4ucSW3R3y7q1JIKxCsokljbqo8nT/jng/dOTugoVy+zSV?=
 =?us-ascii?Q?vizXiDuZ4nvabD5WxHfhabrqp6MmfB3ELiTEgMlAtp5KUKLcwJPCKg5a70Ii?=
 =?us-ascii?Q?MZro1om8gq6s3R8zX/ZkTiJK+zhMYDO+6T2lpgg5+3XrD6VohkVzE1e5iCkg?=
 =?us-ascii?Q?/rJvcQjGzAsDSUXXgn8SVb4vyANCADymoSFLgP69AJKCNbh0lfo9yRkvVUat?=
 =?us-ascii?Q?YWONdUvv0j3A75LKW57IsIt+uMnhn77WB8pkj4O3oBISSGtrsus8tgfGPU9m?=
 =?us-ascii?Q?EZnrED+AX5N622J2yHp/C4MSvLfZZmD1eBzLiMoy80Z+DI1jhXHkjMn6n5qi?=
 =?us-ascii?Q?zSGvTILcOxieVgRiq5ogEQwiI88AxudLVX/9jyEPw00aL8ioUKU1+wVdbRYR?=
 =?us-ascii?Q?d0E2jIGtA825msFLEqgaG+4BHxJd9UEi3Nd4R7NXOsNhak1g4gHro5NGspyM?=
 =?us-ascii?Q?F2359Oftn7RVzLT4sVlyt0hZgRi0aS0IDtsErtNcDbeyXPq09JQf80Un5n5v?=
 =?us-ascii?Q?DhNaB88Oo+s4++EAejMwUARv+IjIWB0BZqrqwCBErsY6/WNHrnSZR2nTuPht?=
 =?us-ascii?Q?sjZsbIcDAagrYfYSEPTd9/ezQ1I54gjji3g18ZJR1C9CBYaxZUBiVgzOfoPP?=
 =?us-ascii?Q?7ZOuH8C32/mBhYkZvRnXQSis06ytI07DJWu4lEIwOIzayNPU0CU8wRrIOt++?=
 =?us-ascii?Q?pUJDFZQKRKSQZxe8vTiHa+skJBVtyAK9q0pVF6hKusTugZlEiSmTTP0RbZtC?=
 =?us-ascii?Q?vLC/8E0QNL0ZGZmIuKhiK+Eoc+zzjvK4b/gmAQ+vto+xxlMQITBRfMMfg+5+?=
 =?us-ascii?Q?b9zNNu5BbrgvV7AI98nIy+fAIIrqKD5CMCcLB/lfe0uahewftvI5erVcOoUq?=
 =?us-ascii?Q?zeamSDI5o2YfH1yQxb5SnQhfH7r2n4+75ggM1zgKORjcm1JjNOlYyehMHAhi?=
 =?us-ascii?Q?mYV5wx3W+V+C9nJT/+NEMnZgHJ2RQyp6whoeM6VPWtPvqpUQioiPqjN5nocw?=
 =?us-ascii?Q?mbnVIni7D6fod1UMY7YO+likzz7XFY7FTc5pJsil0bA878F2LUjRnof3ooth?=
 =?us-ascii?Q?xb6fx9SSGSjAkAsKuY44sZa0s1VzRgn7LgjVkcr6kEAM48Pc2oLaY+vdQiju?=
 =?us-ascii?Q?a9uZH9XM7tbvVP4Ootq+HZGxyj112+QJ4VixD71raVWPXgZD+XzHGr00wK9B?=
 =?us-ascii?Q?rFSkZMWeyPOiNu9i7MuV9NmxODQYSl44keFYNVAOzZ8d1sZDl+ogoI5yDZiN?=
 =?us-ascii?Q?u3Z7tnsZ4yzY2GTG2R+81AoYlFaqaLTq6BJSlLuE9A7vNwgOLyZ+YpU+7Mq6?=
 =?us-ascii?Q?b0SdHrsoiuoLgJTkW2i4ZKLUoRviA+Yhwi0LcGe32TrAhn9Rhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:33.4736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d81dc64-6e94-4966-2406-08dcff5b1ac0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947

From: Mark Bloch <mbloch@nvidia.com>

The referenced commits introduced a two-step process for deleting FTEs:

- Lock the FTE, delete it from hardware, set the hardware deletion function
  to NULL and unlock the FTE.
- Lock the parent flow group, delete the software copy of the FTE, and
  remove it from the xarray.

However, this approach encounters a race condition if a rule with the same
match value is added simultaneously. In this scenario, fs_core may set the
hardware deletion function to NULL prematurely, causing a panic during
subsequent rule deletions.

To prevent this, ensure the active flag of the FTE is checked under a lock,
which will prevent the fs_core layer from attaching a new steering rule to
an FTE that is in the process of deletion.

[  438.967589] MOSHE: 2496 mlx5_del_flow_rules del_hw_func
[  438.968205] ------------[ cut here ]------------
[  438.968654] refcount_t: decrement hit 0; leaking memory.
[  438.969249] WARNING: CPU: 0 PID: 8957 at lib/refcount.c:31 refcount_warn_saturate+0xfb/0x110
[  438.970054] Modules linked in: act_mirred cls_flower act_gact sch_ingress openvswitch nsh mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib mlx5_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core zram zsmalloc fuse [last unloaded: cls_flower]
[  438.973288] CPU: 0 UID: 0 PID: 8957 Comm: tc Not tainted 6.12.0-rc1+ #8
[  438.973888] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  438.974874] RIP: 0010:refcount_warn_saturate+0xfb/0x110
[  438.975363] Code: 40 66 3b 82 c6 05 16 e9 4d 01 01 e8 1f 7c a0 ff 0f 0b c3 cc cc cc cc 48 c7 c7 10 66 3b 82 c6 05 fd e8 4d 01 01 e8 05 7c a0 ff <0f> 0b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90
[  438.976947] RSP: 0018:ffff888124a53610 EFLAGS: 00010286
[  438.977446] RAX: 0000000000000000 RBX: ffff888119d56de0 RCX: 0000000000000000
[  438.978090] RDX: ffff88852c828700 RSI: ffff88852c81b3c0 RDI: ffff88852c81b3c0
[  438.978721] RBP: ffff888120fa0e88 R08: 0000000000000000 R09: ffff888124a534b0
[  438.979353] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888119d56de0
[  438.979979] R13: ffff888120fa0ec0 R14: ffff888120fa0ee8 R15: ffff888119d56de0
[  438.980607] FS:  00007fe6dcc0f800(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  438.983984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.984544] CR2: 00000000004275e0 CR3: 0000000186982001 CR4: 0000000000372eb0
[  438.985205] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  438.985842] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  438.986507] Call Trace:
[  438.986799]  <TASK>
[  438.987070]  ? __warn+0x7d/0x110
[  438.987426]  ? refcount_warn_saturate+0xfb/0x110
[  438.987877]  ? report_bug+0x17d/0x190
[  438.988261]  ? prb_read_valid+0x17/0x20
[  438.988659]  ? handle_bug+0x53/0x90
[  438.989054]  ? exc_invalid_op+0x14/0x70
[  438.989458]  ? asm_exc_invalid_op+0x16/0x20
[  438.989883]  ? refcount_warn_saturate+0xfb/0x110
[  438.990348]  mlx5_del_flow_rules+0x2f7/0x340 [mlx5_core]
[  438.990932]  __mlx5_eswitch_del_rule+0x49/0x170 [mlx5_core]
[  438.991519]  ? mlx5_lag_is_sriov+0x3c/0x50 [mlx5_core]
[  438.992054]  ? xas_load+0x9/0xb0
[  438.992407]  mlx5e_tc_rule_unoffload+0x45/0xe0 [mlx5_core]
[  438.993037]  mlx5e_tc_del_fdb_flow+0x2a6/0x2e0 [mlx5_core]
[  438.993623]  mlx5e_flow_put+0x29/0x60 [mlx5_core]
[  438.994161]  mlx5e_delete_flower+0x261/0x390 [mlx5_core]
[  438.994728]  tc_setup_cb_destroy+0xb9/0x190
[  438.995150]  fl_hw_destroy_filter+0x94/0xc0 [cls_flower]
[  438.995650]  fl_change+0x11a4/0x13c0 [cls_flower]
[  438.996105]  tc_new_tfilter+0x347/0xbc0
[  438.996503]  ? ___slab_alloc+0x70/0x8c0
[  438.996929]  rtnetlink_rcv_msg+0xf9/0x3e0
[  438.997339]  ? __netlink_sendskb+0x4c/0x70
[  438.997751]  ? netlink_unicast+0x286/0x2d0
[  438.998171]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  438.998625]  netlink_rcv_skb+0x54/0x100
[  438.999020]  netlink_unicast+0x203/0x2d0
[  438.999421]  netlink_sendmsg+0x1e4/0x420
[  438.999820]  __sock_sendmsg+0xa1/0xb0
[  439.000203]  ____sys_sendmsg+0x207/0x2a0
[  439.000600]  ? copy_msghdr_from_user+0x6d/0xa0
[  439.001072]  ___sys_sendmsg+0x80/0xc0
[  439.001459]  ? ___sys_recvmsg+0x8b/0xc0
[  439.001848]  ? generic_update_time+0x4d/0x60
[  439.002282]  __sys_sendmsg+0x51/0x90
[  439.002658]  do_syscall_64+0x50/0x110
[  439.003040]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 718ce4d601db ("net/mlx5: Consolidate update FTE for all removal changes")
Fixes: cefc23554fc2 ("net/mlx5: Fix FTE cleanup")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..6e4f8aaf8d2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2105,13 +2105,22 @@ lookup_fte_locked(struct mlx5_flow_group *g,
 		fte_tmp = NULL;
 		goto out;
 	}
+
+	nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
+
 	if (!fte_tmp->node.active) {
+		up_write_ref_node(&fte_tmp->node, false);
+
+		if (take_write)
+			up_write_ref_node(&g->node, false);
+		else
+			up_read_ref_node(&g->node);
+
 		tree_put_node(&fte_tmp->node, false);
-		fte_tmp = NULL;
-		goto out;
+
+		return NULL;
 	}
 
-	nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
 out:
 	if (take_write)
 		up_write_ref_node(&g->node, false);
-- 
2.44.0


