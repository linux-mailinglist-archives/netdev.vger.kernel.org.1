Return-Path: <netdev+bounces-135110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D499C4DC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06061C219E9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8BB16F288;
	Mon, 14 Oct 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sceLoyKQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FA15DBD5
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896884; cv=fail; b=EPhqLoknqyaNC0zunm2O7EJLT1sDcoIKx+jtVn1qvfDUE57egyXmsMNlX2r6zoyT/dX2U5jE6SFOxi/8v5hbsbOlHEUuBA3xD6uBC3XoFRpPqd5pHsZ1toM7Rh/OhqqYyLthnBNrQoqAJtXaGgCwn510OMdHL1EUuVoPJ9ipY7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896884; c=relaxed/simple;
	bh=8/SZ8ulzCyOS+aVWw9S6C6vIHoyFRS+BEWAp99WwNMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWBWxX5v485MEGtNsyUvu4MUQnOLTSOsUs9zCLPalkw5FPhUukfL+NZ/u9+u7PAAiHLHrP/62HLfEco5jUDw8kCKSAWJ7ievGc3cAqxXu9MnPXLM9qJu2BkgUvLjAbugugyTKm40h04HFAZobjnJEYVnjlb5mRVTVlu9n2Kr7wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sceLoyKQ; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzSdMFDrrd4mMGSmUwLIftk9dZuiYoYzRYUIGRwygBqcy9TW5Tsa8eqxp47HWLuAOlLitGzpUUaEre89jagvP3FQ8nbOSEk6nGpuv/JXts8SOmkvoDHSKOmJLPm8bU95QTnrazPmoWbEMVAohlMXZnF33bg/D7p2+9+c5C4Y/qXM2Gm0NBWwDinTunx+796lnLhOzY2aDoDcpR9ot7aLm/Qeb5A8mUhO3hYbZMqA2ml/Fn6eiZ7SE7+OaLHKebekaTnRb08OdGtRuBzrQvAICU33HEODDJtoS50A82QDtVM3Ou8Z1wD201yV51PpbSNZJCJgYubj2w3/yavNjQqc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dn5axt14S9p+YbAl5zDd2UUjbCxP8vlaZw8MaCiAc8=;
 b=A+o7vOw5csHkIo3wD1HWsyVDf92Db3HYX1n65fQzLf0HgxM6QqsRcHBc2MX9mNoC17Z/UBvbQaYbqXQqCCezmhAslr7m0/6A3CypEoKTYTjEcKWdBdtXCDsTqOfY6WQOegKLLkruhQ9LIu4n+XBaOiaONFHnLVAE3tQzQnkt71gO0qIzuBOuxWFrKoavJ2u8q6GrflvS3UkRvYg5gqmCAQtKrWUgw6fv1jgHmAgKFbiGMQT/ku4bDe0dtSLuFHP9y9yaxFX59SXGWm1NbmGWzx14mtiNyqv0/zUAifFnLykDRsbXZ4YNmDv28MuFB7Lqgl5q++6y5J4/MVHo0lP5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dn5axt14S9p+YbAl5zDd2UUjbCxP8vlaZw8MaCiAc8=;
 b=sceLoyKQzg+IpstXu2i8ZD089xpzhI7H4bRhnrjCQ9ZOp6x8zg7wy1hIuh0USFlJeHrXTRkZ8N9Kydx55yGrzBFy8WdGUZPDFgwtuon24jiX6AUMldpNwUwlGS4/DoS+St5dxBFbJL1rcb41KrAg86yMV0VKu3ZLBBYhwQQdK5UzogdLZXrWXZp38qDSZOgJSjMUvDOswJ+q4wl96myLwG1fKve3nVuR0pL3DkBIPRHBGC5h/HaabQlPnG3Bg5DNBDM6uMQ3O2U13fAid6khjzB567uwxd4dfYTTjeZEXSdJpVL2UJtVjGO9ErHvSKZLzkbrQHgwkPhSsYFBvLRmKQ==
Received: from BY5PR16CA0009.namprd16.prod.outlook.com (2603:10b6:a03:1a0::22)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:07:58 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::bb) by BY5PR16CA0009.outlook.office365.com
 (2603:10b6:a03:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Mon, 14 Oct 2024 09:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:07:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 02:07:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 14 Oct 2024 02:07:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 14 Oct 2024 02:07:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net] macsec: Fix use-after-free while sending the offloading packet
Date: Mon, 14 Oct 2024 12:07:20 +0300
Message-ID: <20241014090720.189898-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: ed335fe0-6a79-4038-32e7-08dcec2fb215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|30052699003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sAdqfV7/aXPiqD6TNtkMO0UYbmbrg+zdFG6/t/lHPQKox7Nv7VaHcShoAc+?=
 =?us-ascii?Q?ERSKOXomH7tD++MFTMmf/nUhnX96Hyb+01ETeaG7UqCh4QUwemYrfl4OnW+i?=
 =?us-ascii?Q?xVlxytwcJVyv0JxhfmJpzHEYyAPy/hX3GyxShRMwpgY32udOCuzbIm6tg75L?=
 =?us-ascii?Q?NiMazwJ1/t6mrDhpBYEJpo0Ca/VnQqDpqGqK3wXEHm2ID/fD9DDeWQH8FjVr?=
 =?us-ascii?Q?Kis5ZULIZhy707z3vJwHQL0tKSNbhZ8/cHFmCBcWTCYs16YebAHlClwP+hWf?=
 =?us-ascii?Q?/v86neqNtzpQHZ7YwSyFK937kIeLDX34FdVRCyBMMk4LSGeOh4RXnsdYcwLZ?=
 =?us-ascii?Q?qr7v4Ucy7mv5+IPkwZQzOTE9bvQWSqICmfuP8oc4eaGZUFNenXvZYMNhhfMM?=
 =?us-ascii?Q?+DuPeq87FDL2Vw418GR1EtIWtAAG1EBehjLpFvGukR+WhWx+RAoiaeRxsDYd?=
 =?us-ascii?Q?vBrlgclLq4yzOwiV3LuWrMDuRwdrluL8uR5SwGDqEANvmuM6CYDwa8H58m1O?=
 =?us-ascii?Q?ylYPGcy/irKkAiYVJq6xE7v7I/WPEC1fxt4cFwwkl1E+9n66YbAB7CPRuefD?=
 =?us-ascii?Q?/MPuaZqEpswukqFxxAX2X41diB8EYJeIzXdMj5SiTwUy2iWKetO2soRQsRBp?=
 =?us-ascii?Q?78sp21D41uwUHFrKQJQH2nRLIDjyi7ik63+RMqnVaKz+FR5JxUZ68vWaieXM?=
 =?us-ascii?Q?1T8wXpE/foCJoH29y8yZ6dznuVJfZ27qlj1cp5wELIOXfjCoeuUbM+eHMkuc?=
 =?us-ascii?Q?zGVthwjE1bt6mQ05siv4w6vc4yG85ZcG0sy1hy5l0R8iMlo3VztrKvEgHnlB?=
 =?us-ascii?Q?+TxLtQFXcT1DCJbDPbOknyLiadqWn5trt6t1L/BDHEkc/iTysIn6d7zZ4cF7?=
 =?us-ascii?Q?YUHRRIO/EqVrd0P2DAmZRM7fAb5FN5TS/y7WKYPb+a9N+2f5zrgo6phKVZ01?=
 =?us-ascii?Q?QgEIgBz7Cf5Lzbe0QY8cbP+ybAazWtnUkDAIrhAREbdown8+NaQwmXRjm4T5?=
 =?us-ascii?Q?KXkUFbuqlkwICDia4q9JW3unhG7KJRgFp5UGcDhqE1nQeBUHLJJlRwQh6geR?=
 =?us-ascii?Q?Xa/xZs5JueXcNRFMfZgUHQBwLSa+q2cPVRV4Z+ZBPXO4ZLl5bc342XuNPhlx?=
 =?us-ascii?Q?czkW3uRtDfGuHjnCqOde7NP74alZ5m5bzfBZm2NdmVYc3LGE+j/CUrVhbtTS?=
 =?us-ascii?Q?SmROM8hEkkKF55fwCsuixmAkFI9SKuN/Ip/xQnmmVmXHnCT9vaY8Zb8AM1sM?=
 =?us-ascii?Q?Ej++h8N6FeA1p01ittKuZiOD3D6Msfl6UwaxI7vOOTXMMRjRh/vBYI5V/XqI?=
 =?us-ascii?Q?ngsvWAc8/yW6iT/wzWR5loNZ+19d4hYNej2HAFq1y1Z94eZLifQr953FdszW?=
 =?us-ascii?Q?FcD6nx9bhQv3sVIuhybHVaXau+OJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(30052699003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:07:57.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed335fe0-6a79-4038-32e7-08dcec2fb215
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

From: Jianbo Liu <jianbol@nvidia.com>

KASAN reports the following UAF. The metadata_dst, which is used to
store the SCI value for macsec offload, is already freed by
metadata_dst_free() in macsec_free_netdev(), while driver still use it
for sending the packet.

To fix this issue, dst_release() is used instead to release
metadata_dst. So it is not freed instantly in macsec_free_netdev() if
still referenced by skb.

 BUG: KASAN: slab-use-after-free in mlx5e_xmit+0x1e8f/0x4190 [mlx5_core]
 Read of size 2 at addr ffff88813e42e038 by task kworker/7:2/714
 [...]
 Workqueue: mld mld_ifc_work
 Call Trace:
  <TASK>
  dump_stack_lvl+0x51/0x60
  print_report+0xc1/0x600
  kasan_report+0xab/0xe0
  mlx5e_xmit+0x1e8f/0x4190 [mlx5_core]
  dev_hard_start_xmit+0x120/0x530
  sch_direct_xmit+0x149/0x11e0
  __qdisc_run+0x3ad/0x1730
  __dev_queue_xmit+0x1196/0x2ed0
  vlan_dev_hard_start_xmit+0x32e/0x510 [8021q]
  dev_hard_start_xmit+0x120/0x530
  __dev_queue_xmit+0x14a7/0x2ed0
  macsec_start_xmit+0x13e9/0x2340
  dev_hard_start_xmit+0x120/0x530
  __dev_queue_xmit+0x14a7/0x2ed0
  ip6_finish_output2+0x923/0x1a70
  ip6_finish_output+0x2d7/0x970
  ip6_output+0x1ce/0x3a0
  NF_HOOK.constprop.0+0x15f/0x190
  mld_sendpack+0x59a/0xbd0
  mld_ifc_work+0x48a/0xa80
  process_one_work+0x5aa/0xe50
  worker_thread+0x79c/0x1290
  kthread+0x28f/0x350
  ret_from_fork+0x2d/0x70
  ret_from_fork_asm+0x11/0x20
  </TASK>

 Allocated by task 3922:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x77/0x90
  __kmalloc_noprof+0x188/0x400
  metadata_dst_alloc+0x1f/0x4e0
  macsec_newlink+0x914/0x1410
  __rtnl_newlink+0xe08/0x15b0
  rtnl_newlink+0x5f/0x90
  rtnetlink_rcv_msg+0x667/0xa80
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x551/0x770
  netlink_sendmsg+0x72d/0xbd0
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x52e/0x6a0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x4c/0x100
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 Freed by task 4011:
  kasan_save_stack+0x20/0x40
  kasan_save_track+0x10/0x30
  kasan_save_free_info+0x37/0x50
  poison_slab_object+0x10c/0x190
  __kasan_slab_free+0x11/0x30
  kfree+0xe0/0x290
  macsec_free_netdev+0x3f/0x140
  netdev_run_todo+0x450/0xc70
  rtnetlink_rcv_msg+0x66f/0xa80
  netlink_rcv_skb+0x12c/0x360
  netlink_unicast+0x551/0x770
  netlink_sendmsg+0x72d/0xbd0
  __sock_sendmsg+0xc5/0x190
  ____sys_sendmsg+0x52e/0x6a0
  ___sys_sendmsg+0xeb/0x170
  __sys_sendmsg+0xb5/0x140
  do_syscall_64+0x4c/0x100
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 12d1b205f6d1..7076dedfa3be 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3817,7 +3817,7 @@ static void macsec_free_netdev(struct net_device *dev)
 	struct macsec_dev *macsec = macsec_priv(dev);
 
 	if (macsec->secy.tx_sc.md_dst)
-		metadata_dst_free(macsec->secy.tx_sc.md_dst);
+		dst_release(&macsec->secy.tx_sc.md_dst->dst);
 	free_percpu(macsec->stats);
 	free_percpu(macsec->secy.tx_sc.stats);
 
-- 
2.44.0


