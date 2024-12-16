Return-Path: <netdev+bounces-152219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D99F31DF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2013167018
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1AD205E10;
	Mon, 16 Dec 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QC+am4g3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7B205AA8
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356593; cv=fail; b=jJVRx6FOBKIArQSIKtUZYAAbtgGkZssnVu+I8IQ69J/sByF7VNoFnPTCzfETIATV+lIZMMVeQZ/w91KzcVh8dYf+WX1Z/AA458zo9VYZhu9CncmLlQ7Sh/3JY+1uTYFqSXa7HB5dRIs5MPcf9hoPcnYehQqZ5yNNAzvi7VlMVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356593; c=relaxed/simple;
	bh=VyVx8GysSPKzNMvboJ3JVsk0KMkDnvlSgw+1eIutPjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B65Cx3cTaGfp1icvg2GVSQlvt0yMqjDClyUs9D2OfNHLqkxcrjiOJn4cvCxiFoVa/Y8cRqCYUbqU1wL1vOC5dAPlNzJWeZD65Y0o748sqNM4EluOJpAqM+JIbUwiUtCcJdXc9axSSyrWeDVfjWE5Llo9TQN0wvqxs220S1o7Dws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QC+am4g3; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGITMNpYO0dH9KTXlA+aF2ERb82eCuJNibmpFXXKhV2YWpV79M4UtK3mGO96HbmZ0c6wCMIwYqYa1oGsCkbqFoCrFySR0oKpGCX7d7e78I2ipyXh+f+/scTOWnkhJK0crgpnLnx7jOJR8GCL80m37TDfkLKc/EjipNI6vLP10jBXRYaNQ55T0UVCZnGi8CK5Nq1ZoC7peHdINHrya3W28aNJtCNkks7j+uaogYDg39mQbiNOLSH69jRSg0zNxz1/v6UFVmYyBKvJBq4yDa0fxNaGYLVWN3uK32Ar1E5ny2m69/JICiZ/War+c/dfWKW89rWBT30c40QUXRaeQguEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH8AdgNZ+AhJYnWWPiOUQoukiMaD0dr0UsWkBHlsTKQ=;
 b=FQgBXuQxduQ/g17/KeTHTjJzsVC6C2ctyb61QBuaR2dCRvlDCa+jUAPuc3W+eAtE+VrvDoJ2utYJlDudJD1j7yI7Zd82BKCi7qceYl5UjoZE0oDvLAqGk0eWSjcpfPuY9mCDCMj2VqokmJpPGrfsMi48dKYaWPn8BVm5lBCXaWcJx2lcmVVmKSPobRzJyIeBXm8n89xj/1btCQadar9FHstksNC0CFgzwujUwmbxZ6vbjje7GXcG3z+PvhFSZN1UpfaPDo+GVD6uwVXhVix/CbSgw9++Mu00eCL1vKQ9jk3M3g+ZHl0mA+DktzNOV6ea9lPdRxvfOo36GbnjIzUzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH8AdgNZ+AhJYnWWPiOUQoukiMaD0dr0UsWkBHlsTKQ=;
 b=QC+am4g3fMOs8Z8HnAGGJmaEzUPTZMTp8jPK48VnF3SZD93POvRRFFVqpveQhUoqA4vOz0KFsGtaiY0rgbBNIW8zObRltqMF1mYBPnHjR3KdB8YcSdpx8r1O/nchd618zWOCCGggkMixu/P0I7ndsf7xI0AGnMe+r0ycIlD26L98mJDkA6wPaDsuwQQ8m3Kxe8s7TSu44R1mPj3D1YgxE8q3h8YgP6uDPcuoB9RI6/pbatOICPYUjPFn1DVOALvpW6P5juh6T9opZYds07EsrM+KTJ/u//InTADr9IxyhXLvaa06EfM1rI+bvcRJBGJjpPJzOetLqqOtjjUlLw1zuw==
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 13:43:08 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::c7) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Mon,
 16 Dec 2024 13:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 13:43:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 05:42:55 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 05:42:52 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] vxlan: Avoid accessing uninitialized memory during xmit
Date: Mon, 16 Dec 2024 15:42:07 +0200
Message-ID: <20241216134207.165422-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 29986c3b-6fec-4737-35f1-08dd1dd79250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3Ht4GkE10iYD6FhrsdTS7U4gbBDWgouOfD0oWRWlYOBkhmab+UIJC2rNOjf?=
 =?us-ascii?Q?eTK3temiBXpsVV4uBjyY9/SOO4vCOHBTONUt1ZK0FKi3bppfKn89wMSF4MP1?=
 =?us-ascii?Q?BrBZ/RzobKapoUY2YVPalk20nU6XJRWsVDmkCyHWwmln94TLKVJv60apRiY5?=
 =?us-ascii?Q?JwdsGzqHIoLEic6M3xSTH/lVio7qx1q33JuZpcZJ2CjuGvpjbnq9FrvX1z8b?=
 =?us-ascii?Q?dRWk93kRRTmEnxQaBb/nERQPXa2DSkjn9B5y0WZI8Sm5PiXtoYB57voq0GhC?=
 =?us-ascii?Q?RZCTb9X/cr2my4IfBgWovr9oPHeDDbvzLwqKT+MB588GbKWRap5zHF2nsd2H?=
 =?us-ascii?Q?i3TibYL7Yjz/6Y9AhT4gPJ1tCcTEU7/P3xWsN9vUZWOU9AkMDuiRGJXiJPRg?=
 =?us-ascii?Q?ze2Ay2cCzUOxbBHasl90UovvbJu8qSaCSmJxxP8E3mpi8kOeOUudEwhWpRQs?=
 =?us-ascii?Q?eui+0NrNIiYasfnpdQ1+qDYZHGxX92n/DiWH+Ddo71MkR+JGiI+pM9XpktaK?=
 =?us-ascii?Q?eQRGGSo4Die1/P/s3vfykvB7p+e5DnHHK2U0r6K/M47SBWD6WjIS0YEZymPn?=
 =?us-ascii?Q?cV14SDGmYaLrBZQKn5Y3LAlPFL2wvaHr7OUw7RSuS+2KKb/n/b0WVmuOSTOE?=
 =?us-ascii?Q?lSept98HAJBQecB2GUf9jfQHlup/6ncSejOtC76CV5x9C5DDGtJ2CKGpBtRj?=
 =?us-ascii?Q?nbKqGDGat/Qkxm7RqQq2iCYxv/Lwiy3Ew+K0/C+T+VySt4lmgilsDeDWrHF8?=
 =?us-ascii?Q?x905n4kD4n1ie0neLKBfYhWLbQYFMftyZEeMvBhrT7vmeLblIyxfthwQOIZM?=
 =?us-ascii?Q?1ToLOcGev8Z2mrwAAp9x416uR2gAAfv2wLC38TGbdfYcw1wVKIosoJZYaOJJ?=
 =?us-ascii?Q?vDr430S8jYIeN6mKSwDn1tVPBIK9DJuKY88N+XRqKhW0izKln4bRo2gYkzRo?=
 =?us-ascii?Q?MBYKGwlbQ7OFkwzu0GuOZS3rlXLr3Vb1x2wQwNSoYqP3IliWsj9eKXJ4ePuH?=
 =?us-ascii?Q?hVhXSFrtOujaSXv1QtIkykUqUXOmLIwol2IwsVmNynzgXNjP7McToh/NHqdj?=
 =?us-ascii?Q?CjpmbV4lSIgzECLwW9h7BleZnyUx9r0btMK6S4hW6suIbu5SRmjA/DPk7wFl?=
 =?us-ascii?Q?zEZtvaZc9ye7JjlPNU2OrfZpBntR+siVFywYW5p4dzpn8fff2osibn92Q92M?=
 =?us-ascii?Q?Qk+PTfe172knUIZlWyKoEniNKLVXR2RckHfLG79x5NeSUjf6xguMo/+zlsSk?=
 =?us-ascii?Q?f8P7/Nq6qBOruZNeUvljzUaK0Cwc7OdySS798bBp9WaHKEp4EqmcLWl+2Wi9?=
 =?us-ascii?Q?L2ksrmm7rsaAbh2bhtEl7qbMjod0MocqcA1wCgDEVz1VRMDGzGk+moBO7VOi?=
 =?us-ascii?Q?vFD/UHQR+ap6JUTZazg20acxDETemTgEooUSMEXF2zvZuqvmhzzJk/7pHb+g?=
 =?us-ascii?Q?iYp7ZQ3hV8G9pB8HPZRCppFwr6fIJym3owqbW5NasiIoTpA8cRdZAFJ+/aIW?=
 =?us-ascii?Q?60Tg7l9lHBgG5Gk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:43:06.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29986c3b-6fec-4737-35f1-08dd1dd79250
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725

The VXLAN driver does not verify that transmitted packets have an
Ethernet header in the linear part of the skb, which can result in the
driver accessing uninitialized memory while processing the Ethernet
header [1]. Issue can be reproduced using [2].

Fix by checking that we can pull the Ethernet header into the linear
part of the skb. Note that the driver can transmit IP packets, but this
is handled earlier in the xmit path.

[1]
CPU: 6 UID: 0 PID: 404 Comm: bpftool Tainted: G    B              6.12.0-rc7-custom-g10d3437464d3 #232
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
=====================================================
=====================================================
BUG: KMSAN: uninit-value in __vxlan_find_mac+0x449/0x450
 __vxlan_find_mac+0x449/0x450
 vxlan_xmit+0x1265/0x2f70
 dev_hard_start_xmit+0x239/0x7e0
 __dev_queue_xmit+0x2d65/0x45e0
 __bpf_redirect+0x6d2/0xf60
 bpf_clone_redirect+0x2c7/0x450
 bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
 bpf_test_run+0x60f/0xca0
 bpf_prog_test_run_skb+0x115d/0x2300
 bpf_prog_test_run+0x3b3/0x5c0
 __sys_bpf+0x501/0xc60
 __x64_sys_bpf+0xa8/0xf0
 do_syscall_64+0xd9/0x1b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __vxlan_find_mac+0x442/0x450
 vxlan_xmit+0x1265/0x2f70
 dev_hard_start_xmit+0x239/0x7e0
 __dev_queue_xmit+0x2d65/0x45e0
 __bpf_redirect+0x6d2/0xf60
 bpf_clone_redirect+0x2c7/0x450
 bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
 bpf_test_run+0x60f/0xca0
 bpf_prog_test_run_skb+0x115d/0x2300
 bpf_prog_test_run+0x3b3/0x5c0
 __sys_bpf+0x501/0xc60
 __x64_sys_bpf+0xa8/0xf0
 do_syscall_64+0xd9/0x1b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 kmem_cache_alloc_node_noprof+0x4a8/0x9e0
 kmalloc_reserve+0xd1/0x420
 pskb_expand_head+0x1b4/0x15f0
 skb_ensure_writable+0x2ee/0x390
 bpf_clone_redirect+0x16a/0x450
 bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
 bpf_test_run+0x60f/0xca0
 bpf_prog_test_run_skb+0x115d/0x2300
 bpf_prog_test_run+0x3b3/0x5c0
 __sys_bpf+0x501/0xc60
 __x64_sys_bpf+0xa8/0xf0
 do_syscall_64+0xd9/0x1b0

[2]
 $ cat mac_repo.bpf.c
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>

 SEC("lwt_xmit")
 int mac_repo(struct __sk_buff *skb)
 {
         return bpf_clone_redirect(skb, 100, 0);
 }

 $ clang -O2 -target bpf -c mac_repo.bpf.c -o mac_repo.o

 # ip link add name vx0 up index 100 type vxlan id 10010 dstport 4789 local 192.0.2.1

 # bpftool prog load mac_repo.o /sys/fs/bpf/mac_repo

 # echo -ne "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41" | \
	bpftool prog run pinned /sys/fs/bpf/mac_repo data_in - repeat 10

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6735d39a.050a0220.1324f8.0096.GAE@google.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
If this is accepted, I will change dev_core_stats_tx_dropped_inc() to
dev_dstats_tx_dropped() in net-next.
---
 drivers/net/vxlan/vxlan_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9ea63059d52d..4cbde7a88205 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2722,6 +2722,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *rdst, *fdst = NULL;
 	const struct ip_tunnel_info *info;
+	enum skb_drop_reason reason;
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
 	__be32 vni = 0;
@@ -2746,6 +2747,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+	reason = pskb_may_pull_reason(skb, ETH_HLEN);
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		dev_core_stats_tx_dropped_inc(dev);
+		vxlan_vnifilter_count(vxlan, vni, NULL,
+				      VXLAN_VNI_STATS_TX_DROPS, 0);
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
+
 	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
 		eth = eth_hdr(skb);
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
-- 
2.47.1


