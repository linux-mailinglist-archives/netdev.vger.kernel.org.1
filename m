Return-Path: <netdev+bounces-157794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577BA0BC47
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990363A474E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C01FBBF0;
	Mon, 13 Jan 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mwNrf5FG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A81C5D7D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782938; cv=fail; b=sy8VtFsPqZAr2sbKdwfKv7CAPpb9lVrXGZ0Zh15g1b81ec+nRuXyCZCLtRXHsn9oJMJvBLjuPbm+Um/knmvvnT/9DcUGkTnvfV0sNo12R5hzFopQkA+0IcAhsE1Xus+zUaWZLEyZf7pUZceV3WCc8GuCjWulqdLy9VFh59FG9Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782938; c=relaxed/simple;
	bh=Fv+2Fu/FjSLvPTQJrCoVXEl7uNGBOoERO54mNw7RDnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HehmQgwAKBZ+wPh3dNuVLRmJeYEoGl/OERlCJ03h+iGXxKjIu9wifEEQQBAnr2nDfE3+sSfdBdziw+hjQqu8fNC1h+/i9ulMCv1p6Af/rdXrQ19Oq76oDnnDH8/m/bZbjdMyrunLNj0UxSSF7iz2QalXWHpRq/NFpG9bRTVCy+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mwNrf5FG; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0t1oDsDfK8QQ3gWh6AdpgmiXa9HsYP6wkA20VOCURaeHqvinWHNuhe7HR+J8TmwvpV+aLthcEf4/Wmk2P8HlEydlGfhMCwtH35fjlARWcKaR+2NeXBWfNHH9YwRM7LpKu/gowqA4GORAdwtyE0bo1yKqwiuEgoBhu7BA7g8NNgTomUej1jOjNjgfb2OiHmrnR5qCi0MMAG2rhrALFKe39Da3pheliJz+hBl/fVIaHl3ZXwAfFMGMJWXhxVrVlPIJ5+5wwUOKZohuiIWTNtan8wErXHQx/I31NnMfgcplqeXToFwWvglNaEgcuz7MhfgSrcKap3ZvyTwJw7hfEf9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EscYIakMaMaZa3JV5cG33gg5hqqx8YKRX0GAPN6kWcQ=;
 b=A8ZLaE3WgPp0NMMhCH3o21WGuA6ipqN8ba04fbJ82pwcfk583zmntkyUrh+i0ixMntibmwckNd/u5wWcxnstZFpUjcZ0NCQf/y30Zs61Hxb7w5w5uev/cUCHj3pz3Bn8Yo38/3y3f9LZ23MaM4xYSNjTa/ARVOgkY3AreNw27upb+l1TQmHjsxaWrApKeTbfnHKbI4aUTenOarzobrt+v1FMqA8Ys2BYhVq1gxhqOBvOc/gJNZ4YemTnfbX4n5g3c09E7Z3y14Xd+vlhZfSLTHSX+fCsfvL/lbHmVAPlyr/RJhT4yypMPAF3TPOas9/dkQRlqWGQ6xN8tOFkLE4BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EscYIakMaMaZa3JV5cG33gg5hqqx8YKRX0GAPN6kWcQ=;
 b=mwNrf5FGJkX+Lm0Lg8wmOEaJuc4/7op8rbWGA5FVjQsHwewROq/8TIxzuAJXo92CJ9ovq3WTI5gMJ1ZSL9btbG2mP5+IBtFHr4WP61EqMRNBizG/AohjnocqgtQVY5g2/j7bmnyty/XHDUwGydmCmpFcssqpdBsTpCxK9jA1zvYumfP8qYFMFK7Gx5taIUoJZnMZU1Bi5NZJbuYdeNgJOD5we2DxK43gSSQneULs3uHFxJzb2cy/sev52wIXb01wJSWfKgkk9sVz4c2CD+26GszYeCtvOFyu/Uqy/Gkfv6GMRQrXgvlXBr1LFR3fVKB+Yi+lyBCnOrmTqfAf8QYPHA==
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:12 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::36) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 15:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:41:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/8] net/mlx5: Clear port select structure when fail to create
Date: Mon, 13 Jan 2025 17:40:50 +0200
Message-ID: <20250113154055.1927008-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250113154055.1927008-1-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9b00a3-0230-4521-8665-08dd33e8d91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Az+BCWlZk7Gk0ZTtejoU5F4odMV0F0jBwKpIGq7aynm0d04S+s58fMFxU2iW?=
 =?us-ascii?Q?1qjDL7YR74Puvmt/lQmFs3QaH0P+FZN/vPTHsvyTCluGdhw6tBOuRNZ8dSue?=
 =?us-ascii?Q?pId0U5uNib4xSA40n3V5R8qTxvjflem1zI89wqBB8ZypGXXDnpolZpi26Lgk?=
 =?us-ascii?Q?OJ3yOWrUfPhhQamclSj76J89Hl0aU0LO60QHHTHnW1fJ49hSEaEdB4eUi5gj?=
 =?us-ascii?Q?ZFWPyV0i+paBheJEtV/ym+pP4/7Q47W4C8HPiSKuQY/u7XsvlbXax4oKNwWf?=
 =?us-ascii?Q?o0JmKMMHFUlkYdIO+iGmGZqOoprQrSotS5Vn1p+xhrHgLUddMwWDYWqoPQMW?=
 =?us-ascii?Q?TuK03WrbPqTi0lW4xTQEYVQ0WAbOwqzc+oajwHZhz8N2RrF/lO04Umxxox6D?=
 =?us-ascii?Q?QgUfj/f6UWhA5kLNN/pl4AmVbCDOEQK0qoKI2Ss/qK21vU4mG4A4yMCSQea9?=
 =?us-ascii?Q?vWgiCfGqPolkFbeicOKjCgDjTC6gt0zubVPFddvNu4CJ5+dTKVUMMFPeaMF/?=
 =?us-ascii?Q?9Yg9YP0JNEriK4AhTOoQKYESJlyzuYWpK6JUUqRKza8/QidIl3t9Y4br0qAT?=
 =?us-ascii?Q?DTEtYEGz65HpSJJpxs4J2fBCDxB2PjbROgzxkS3/zLA+Zk1QpbrR/sA4QAKC?=
 =?us-ascii?Q?Q6FrMY64AdlXaMvnCJ4M0xOI3jg3YI6vmJXo8pT5inDGBy19jHbQgNqxg7Uk?=
 =?us-ascii?Q?kPlmAYDM0+0XEQ9z95ajOJslM02JXFoakOyjoE73EWeFMs7nlpxAT4Z89qxR?=
 =?us-ascii?Q?/83gfPWrev81IEnSf4Y8RnBDNtOgYTJ6vlHNVzNA+DUTFpVOu+4aqU3stM4k?=
 =?us-ascii?Q?sxFz2HMHlqJs2n/cfjdau2NO8k4QcLqZvoVkav2oTrvdRtxrg/yuacTjBtmL?=
 =?us-ascii?Q?zsvMO3d+iruHXOfYi2ZAx5uKoK7gEjyZ3Dpkd2e7MXboo43oEO0T73zvS93j?=
 =?us-ascii?Q?u6FNqyqTmQCc+OA69pHZuoyHDXRetiBw3X+o7jSO2EDadJYRqCMVLjs8L/IR?=
 =?us-ascii?Q?J33L/QWpjojBnO637rfDeC2mOYUMSXugOp7whH1jAwGBCCFkb+pigsaqFfKQ?=
 =?us-ascii?Q?2g3bU3NE4Z/Sp2ku5ya8xsdiHAHEtlBUJLJvqDFHJ6758EDjSmoP8lHrMqWs?=
 =?us-ascii?Q?J3KRGtnO2EzCvoSMQF2dmHrp18gfatwU3op/S4xeC2fCGx2SoSGyIuRGSn/O?=
 =?us-ascii?Q?zpNsSIolPfkvaLJIGlDZ66tBR6Pu+nHhAZPLzzLUnB5+8S0OsrSfFfvsN7Ap?=
 =?us-ascii?Q?HXBeHSp21EWK0iNirWb5clZ5jtpXkq9ItqIgUZ/eP1KVZKLPo5Fg0Q6NDTQ0?=
 =?us-ascii?Q?qpiMECAWgtj/c7E8V4py087cbAdZ8b1ygfYFrz8OjJbeagYoF3G9HECgLfUm?=
 =?us-ascii?Q?LJK6O1S+R8FRNgTy3nZMqIAufEtP3OS0n4nc8ytDVdx+sbYmTItqSP/W+ta/?=
 =?us-ascii?Q?wHhQwlcuxzs+vY0+yEc7g4gEQLOWH80UFLVoj7aOI8QetuJtomO/b5e9M/yj?=
 =?us-ascii?Q?Fu777CBmMeVz0CU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:12.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9b00a3-0230-4521-8665-08dd33e8d91e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778

From: Mark Zhang <markzhang@nvidia.com>

Clear the port select structure on error so no stale values left after
definers are destroyed. That's because the mlx5_lag_destroy_definers()
always try to destroy all lag definers in the tt_map, so in the flow
below lag definers get double-destroyed and cause kernel crash:

  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 1
        mlx5_lag_destroy_definers() <- definers[tt=0] gets destroyed
  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 0
        mlx5_lag_destroy_definers() <- definers[tt=0] gets double-destroyed

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 64k pages, 48-bit VAs, pgdp=0000000112ce2e00
 [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
 Modules linked in: iptable_raw bonding ip_gre ip6_gre gre ip6_tunnel tunnel6 geneve ip6_udp_tunnel udp_tunnel ipip tunnel4 ip_tunnel rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_fwctl(OE) fwctl(OE) mlx5_core(OE) mlxdevm(OE) ib_core(OE) mlxfw(OE) memtrack(OE) mlx_compat(OE) openvswitch nsh nf_conncount psample xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc netconsole overlay efi_pstore sch_fq_codel zram ip_tables crct10dif_ce qemu_fw_cfg fuse ipv6 crc_ccitt [last unloaded: mlx_compat(OE)]
  CPU: 3 UID: 0 PID: 217 Comm: kworker/u53:2 Tainted: G           OE      6.11.0+ #2
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
  lr : mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
  sp : ffff800085fafb00
  x29: ffff800085fafb00 x28: ffff0000da0c8000 x27: 0000000000000000
  x26: ffff0000da0c8000 x25: ffff0000da0c8000 x24: ffff0000da0c8000
  x23: ffff0000c31f81a0 x22: 0400000000000000 x21: ffff0000da0c8000
  x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff8b0c9350
  x14: 0000000000000000 x13: ffff800081390d18 x12: ffff800081dc3cc0
  x11: 0000000000000001 x10: 0000000000000b10 x9 : ffff80007ab7304c
  x8 : ffff0000d00711f0 x7 : 0000000000000004 x6 : 0000000000000190
  x5 : ffff00027edb3010 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : ffff0000d39b8000 x1 : ffff0000d39b8000 x0 : 0400000000000000
  Call trace:
   mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
   mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
   mlx5_lag_destroy_definers+0xa0/0x108 [mlx5_core]
   mlx5_lag_port_sel_create+0x2d4/0x6f8 [mlx5_core]
   mlx5_activate_lag+0x60c/0x6f8 [mlx5_core]
   mlx5_do_bond_work+0x284/0x5c8 [mlx5_core]
   process_one_work+0x170/0x3e0
   worker_thread+0x2d8/0x3e0
   kthread+0x11c/0x128
   ret_from_fork+0x10/0x20
  Code: a9025bf5 aa0003f6 a90363f7 f90023f9 (f9400400)
  ---[ end trace 0000000000000000 ]---

Fixes: dc48516ec7d3 ("net/mlx5: Lag, add support to create definers for LAG")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index ab2717012b79..39e80704b1c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -530,7 +530,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 	set_tt_map(port_sel, hash_type);
 	err = mlx5_lag_create_definers(ldev, hash_type, ports);
 	if (err)
-		return err;
+		goto clear_port_sel;
 
 	if (port_sel->tunnel) {
 		err = mlx5_lag_create_inner_ttc_table(ldev);
@@ -549,6 +549,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 		mlx5_destroy_ttc_table(port_sel->inner.ttc);
 destroy_definers:
 	mlx5_lag_destroy_definers(ldev);
+clear_port_sel:
+	memset(port_sel, 0, sizeof(*port_sel));
 	return err;
 }
 
-- 
2.45.0


