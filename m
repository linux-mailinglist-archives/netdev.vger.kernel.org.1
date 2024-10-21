Return-Path: <netdev+bounces-137412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9F9A613E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE8A1C249F8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674B1E4113;
	Mon, 21 Oct 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxR3QQK9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891391974F4
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505039; cv=fail; b=YkiLF1uORefFMonkYlY0IEqu/hiOqG1PGvX50LZc3sbfxExcllMgAtTFoLgIVbV01+lJs77mRQ2ZrXPAB/EnuKcwQibgDkYOdskIB+JinCZlS3LGqKsH1w8GTNfFa1Xq1UkuhiI2FXU5NS1mLfiqg94t/Qy0BYsYGkfqzYZlYe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505039; c=relaxed/simple;
	bh=tmsrejfNIThpHrw34LS1rBqlJF+324HeHoWvLb7w9a0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RbOUHJDt+BVp26cq90APN9dRP0bQ7NW2pvzTmp2EFde0C6f2SJofEXtdEoiZ5s2xdCbj/2ce7j9qbt9VZo3xdqgTMmagEelFuGj4gaRaT+PjD+kRv8mSRMWPFVmrElZWOXZ64Baloi8+9UKH+k/Cj6SNW7xtKGGjr49TAjESRu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxR3QQK9; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoIJ7Ajh196otKexeOlB9zZL2fGB4PJusBHw1VhLb2TbjDOCvF8yDLmNR3jCb0yaKbte5/cMLD6kkjeH+wDB/axrnqvyguIMhZpt1ab7C7PMHuV7hSxIKxc3NUIYczhdKD4GNGF7kVH15wZ/pF+XhvSm5MGVnv2a+28MCiX1ELRnama/XG17HGIv3rz4qfS6FWFXstEdVm9gl4Jgp2TfDjWijsCCVH3d9Ip+cwA/Jx+fFPbJPXsMbGwbTsonppUN5SIe9BLlQ5nMSAmp6FLP6uMvh5dazA9nR6aLA35LdHBQBn/M4jUwERrbjkIF06YGVtBKQ+Y3ci/3PhBjfyJY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0HOZwVp7txxiSw8ZezaP1JeC5uNA3E98O/8tkCBihI=;
 b=GSCD7p2xafudc768jAVdzTeCviiC7lS1KjXVtubpIsFXAbA2yhfPr9hCpLv4bEY9rfZ32cuGz00W/eruD13vBbgTT73G03hBazBbYL5EZ0/b8eZKfTErYD6Er8jrxGEEcDCAJmFoPRWTdG/f411tm3TOlEBwCZY1KSP882FtJ9xHJTvcGnpn0iK+Mc82VzR6FbHdPuopMqditQQgohsCz1vfEo4IwjAvyNN3fQv/l8m474EfditGWBS+cfRmj2YGGOHQIl6NVJBN1GF37l6mPxiZGEruvlB245v9Wlq9+ggwDmt4LqECCoIS9l+wWKS6dcfQEakdQKtry3IHsLI/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0HOZwVp7txxiSw8ZezaP1JeC5uNA3E98O/8tkCBihI=;
 b=kxR3QQK9XIZ6gWh8H9BTF3fOvm2t/wVtS1O9EeZHha/xrHiX8VwVmECX5PPO/0h3AFR3NpqF43WZgdHKxt51bdCYuPKXKaHbEOd3/EBN7WAcpEWwXPCMOcHCGZ3ibsWv4wPK078Y9ONoPTXQ63GaZIOXgYeLFYVoLz0rDjSKLYbq3SjDbo6DITf72d1uzn2MqyqKS7/310a8+o8jwAfZFPcPd4nKsTclkegR+sHJU0B+TXZCLtnuW9hfuaQ9ERRGw6CdYcVMjQ1kJC3H9FzJFKdC+dqsSEWDfyMHt3trmthqv2LUWrtGCTnIc2FUFkiLzDo4PM6wpNyCtZJiz35K5Q==
Received: from SN7PR18CA0007.namprd18.prod.outlook.com (2603:10b6:806:f3::27)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 10:03:54 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::2a) by SN7PR18CA0007.outlook.office365.com
 (2603:10b6:806:f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 10:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 10:03:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 03:03:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 03:03:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 03:03:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2] macsec: Fix use-after-free while sending the offloading packet
Date: Mon, 21 Oct 2024 13:03:09 +0300
Message-ID: <20241021100309.234125-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c120c-83d1-48fa-dcb1-08dcf1b7ab5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNAIjDoIriawc1aZ2+Mkt1G298loOVVtHnn+XhpnhzhJ+xcg4ZRad0x7jgew?=
 =?us-ascii?Q?894tB3o+fZurMtR7fq/BE+BH9h+SZ10DLpTGiLvKsLR+npHbRu/xzIWbGgGr?=
 =?us-ascii?Q?4Fs1mwShZvvy7YbEkUnCwv0ePtPbuL4PCQtwK5OL/pEhOmY3gKnAv9k3NYES?=
 =?us-ascii?Q?cg2aMzwSV74GJfKr/MCY/LLZc3G0cWasdvoZQK9WIjPta47/ntAhz+uxxj09?=
 =?us-ascii?Q?CqN2CwfIKhHZWqPvGBEleopLZ25ArTNwZ/DRiKIqTS3AnuB2mxXw+Mm+jACv?=
 =?us-ascii?Q?udhXQCKE1aLbcR0kNNqQBmSQqQs0y8UFuNouF0742jFgjxEzPuAc4wbk77mw?=
 =?us-ascii?Q?PLBe588C5psEIcqWz5Z3D+lg7y1vAqCuVBTRkSZSmDYP+o/UDglGMwcbj3so?=
 =?us-ascii?Q?BueTaL/Aw0Y/Q5V5voagU5bGWHxvWteG9K+I0hHvXUJpd33dOqmuM6N0dvq1?=
 =?us-ascii?Q?fn14mE7qXIp18loRwIzYwS12z0buYdX9fDZiYfHDmrh8cSOQZV5luvP6YYiW?=
 =?us-ascii?Q?Nh5PRtsKL7ZLT6rai0JuVhPfyQMFK9Y9HKMG+vDD3bnGvWDA8PupHEsBvGlq?=
 =?us-ascii?Q?rUF/+wxSgOjFU72yNij0bjqYR7Vc+LuCDTAF2A4M6Z0CLk9TVlvXxdPwyfEz?=
 =?us-ascii?Q?PjdPLZXLKrtWtkpI9IrtPt5vsxklcN2YsfLp/ISmw38eFhgHt5sv1AdWaDSS?=
 =?us-ascii?Q?wOBDw4SunYcOAm3i80qBZ7ZF4GnR7M//X6ypj6In7qDW9Aldi5wB/7KJtRZS?=
 =?us-ascii?Q?09FBSClPKWYtstOdjM84bcGZDOdB+XMwPT50/dF+O7vzNnOWpqL3iBARGT4F?=
 =?us-ascii?Q?SOC+IhDIfV7VGvrHjIfKfS47o8bVnsflmcUEWebLfP/jwKaJlss08DkIuk/2?=
 =?us-ascii?Q?LKpY0+EW6FuuxzBcs7zy0ZZEd6NxvLAG8dVtM/1nqR94TS4qR6Zkg2C2Wmq3?=
 =?us-ascii?Q?a5RRiAccUzwmC6mximPY6kZ0+pNYSdt4Ruxpsj7OJvyFm1KQAiVyup1qs2rq?=
 =?us-ascii?Q?zp1Fnoo/5j8zEx1nuN4p+boWijpy0MqdMTWCV2DzLhuq4METTs8qFMFhOqT7?=
 =?us-ascii?Q?Ho22tsX3dWvun0msem0e803/6jAjq7o/ZFRJlvHnGCuPZ7G57vMPjf36I7mb?=
 =?us-ascii?Q?dOfHcOiKZ1WGi43YW1ouwwAQWPyWKGk2raIzLs4HTRPxybjQenjV/qM++yXc?=
 =?us-ascii?Q?LUvq6sUAg+HrsYpLtiEUHq7bkJR5t0gvoJ/x7dDbBnSmej8/O569MyalYCCh?=
 =?us-ascii?Q?+VI30B3r5S4UvEJg4S8WvlAYZKYa/FEI6NEME5cIP8Bro2qin9OXNtPjZYQO?=
 =?us-ascii?Q?79ElRJ6sxdI7f9A9MrDAdLRkey585S0NLIQBTGzZxgYgDSMEHhdj3miLbckA?=
 =?us-ascii?Q?TSCfsAVrX3Z6oBAdzXFPlIgQvW07eLi06Kaw/eV+1wrQX2nqXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:03:53.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c120c-83d1-48fa-dcb1-08dcf1b7ab5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

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
 drivers/net/macsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

V2:
- Removed NULL check before call to dst_release().

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 12d1b205f6d1..6223c1fa2f09 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3816,8 +3816,7 @@ static void macsec_free_netdev(struct net_device *dev)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 
-	if (macsec->secy.tx_sc.md_dst)
-		metadata_dst_free(macsec->secy.tx_sc.md_dst);
+	dst_release(&macsec->secy.tx_sc.md_dst->dst);
 	free_percpu(macsec->stats);
 	free_percpu(macsec->secy.tx_sc.stats);
 
-- 
2.44.0


