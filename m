Return-Path: <netdev+bounces-119468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E46955C4F
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13CEB20CA1
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640518637;
	Sun, 18 Aug 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MB9NC0vT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0817557
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723981424; cv=fail; b=DWKQG4fnrbS2G2GkacgjnJY20kZ85GllGEQ625wv080P08rf6d+sI6PZ3MpUZPah2izXAOWytl5PF0IMOmamjK5wdWE+TeBiv+nS8KU3iFSB6UDtGOVeKEGg3Gv7hsd5uN9FFQvsim8ha1VwirZFUEcwHUluckzuGEFB/7xYbCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723981424; c=relaxed/simple;
	bh=Sg2N5HPav69EAhXOoyE9sTKA3uwVYeTaVrSebBxs/ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hk/wqL3XkxLJf0LAnFmj9NmcyV2DJX7oXa2CbFh85G7hX7qoK6u+Kuc+GaZPAt5fa4Ny9BF/dALMI+FgWEdQPHc6kX3e+sxbHsRCGZXGGW65UCvjJiZD5F92eiVJDQTRkc6QDrh/jJZ2IWyNDm0CEBbYCxrdmd4GsqSzVQJXeHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MB9NC0vT; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDf0fop3KLdusGVBDtaL5mfIs0GiRplLED7cIv3PAeeX8SlYTNr/Cv1HDgXmAEAvHd9Ve4Xp+6w1F4jRov7gf9w8JiehwH+Kdvu6746P+XYDFNGM268tx1X3SQgLm04tjhM5BYOycNPiatqmIvfJHIl3p/p5Z820TJ4xVcwECA0pBeCIVgMuhBtVD3C+j1S3VxTS5961zGoZJRW1N/Uh5STTZOToh+ZN7iuUdq4A/ikS+Fm5HgJ4I/rY/XBMoaZKzIb06bgUpAF//RwDED98uEwFQzI3INcBVLh8TyfyMrX2hZ76sZACOdsf5aD6ePoYtOGptigEepK9Nj1hOkeHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7pQgmhz67Hi6HyTh44DncdyvtO8aViCZ6+9n9rSpIo=;
 b=OtG3q1MAre2e50fEAVSvNexvCkHQjrOyQY8gIGvORz/hkxQKYVt/8oTvr/uaH35bHp9vY2y48aN3NCID6pIlmTSRp+PJLY2K72qKyj3acmI1u2EiYp4hqcsuiDWJ7Eyld5QD+qWEjbkVEfIqKA85QaTne5MZG05jIfLsEJ6VL0/he8cFanR4T3xMgGZ3rrNbhUiCiCvMiENuLsbe9Dmr96RMFiZIvn4VBpf9zUXe13zdsKnwBFRSDOVh8JciQDPNjVMom9SU0X+Y3dJ/NKHZxx5LhcRqFwnPPLAtp+WYQj+TG07YbwEawVPTPHj0FVZmCpl/qkfdy6jhuPuprChPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7pQgmhz67Hi6HyTh44DncdyvtO8aViCZ6+9n9rSpIo=;
 b=MB9NC0vT/gbuYEjLSTed7m9frPJO378WAfVO/62+mUOXNcCDbR28V3T+e4dWugNMCcKt4KSt1n7np1FHRD6o5HHrm1wkMnjn1JMw97lwOPwPjVSbTxLB2UUmqjDSZXrU7rtL00JGZuZULB7WClilrcN6QuaA20WX2IRBXSW2UZyOTV2sU2q+u2u8PPuHUcjVgemAlStuQ0VvwOdmeyc72FMc9Mp7P8sJNFdJpLhCpJpvn42piSCXrQJH0nUsQAAPt63M6446gUXUbd/RlFW6VWSI+a3zdJHtWJS34qtg1v/ak4PhbNjgEVi+CMV3jLfplC+MHaYLbxU+2PXErv7F0Q==
Received: from SN6PR01CA0025.prod.exchangelabs.com (2603:10b6:805:b6::38) by
 DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Sun, 18 Aug 2024 11:43:35 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:805:b6:cafe::e9) by SN6PR01CA0025.outlook.office365.com
 (2603:10b6:805:b6::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Sun, 18 Aug 2024 11:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sun, 18 Aug 2024 11:43:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 18 Aug
 2024 04:43:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 18 Aug
 2024 04:43:33 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 18 Aug
 2024 04:43:31 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] net: Silence false field-spanning write warning in metadata_dst memcpy
Date: Sun, 18 Aug 2024 14:43:51 +0300
Message-ID: <20240818114351.3612692-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cd4557-d567-46c8-991b-08dcbf7afe39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNNkvcBPVMS61955XWRD0EKWxd5Iyr3iJlEtKOqdf96C+zswXudzS4XogEIK?=
 =?us-ascii?Q?9bzIslm3HAyJt3VPy21GE0gB2NOiz3skur5jU0ntuHUm6oAG4VO9K8twxoSf?=
 =?us-ascii?Q?Bkd6CnxfcJmdCC6YQXRUYwcZRILVOw1ouvUdtHB+4KMDeQoKguGQiQZBR4Pu?=
 =?us-ascii?Q?8wP17eoyc+mgOUH6KLfDGFoof5cNvcwkvq0KHV+OCdnyc1AeaNj6XYBAziwA?=
 =?us-ascii?Q?QFwlRMFDgzwqVdt9UtbIo2x92PfGrodtdh00hzq46rlNDv9CVaeA8x09lSql?=
 =?us-ascii?Q?nKrTvN5qmT8OXaekkGkS7v9Q07RkgAFUp/GWxX25JZyzI6mmhBdUjaJwGGKJ?=
 =?us-ascii?Q?RZQGl1Qy7s93GB3om5JiAP+v89aXL6KRnrroxkY9QAMb069zT1zUFgyZL29k?=
 =?us-ascii?Q?nX1O3Yobvi9PMemWrp0hKPBjOIgYgKqfaU3eWZH9fnghLSDIDKxP1iqgu2dI?=
 =?us-ascii?Q?w6SRwvTL38WBTBsTRolC57SjjST5tYorm2MB5iQ16qBLXc6G6cNeVs1AOLQ7?=
 =?us-ascii?Q?81rbOk475+So0oDj+Zk60+mDyKO2bXKa3TyWTz4NWsMgsppZxxCBLjC3uvAr?=
 =?us-ascii?Q?mJVTnWVBf4JRtbLdEwqKphvFFST27LpW8FEpfxC1RToWKDbDyKhvzJmJNgXv?=
 =?us-ascii?Q?J4M8a6oRYFyogRxPJISTg6aq1F9h/gb0bnZgMVPCqVjIF9h0tjeni9VpPsib?=
 =?us-ascii?Q?5ZdOenkF554okb4D+GxFUDxACLMmFQcUKTV1045FIPUK7uGvtTbF/0/bN3Yu?=
 =?us-ascii?Q?CY762jyLNpN2/hrZ6Yn0I+Cp2RQhzEpEjlExRrlZWhophsLKwvX3y582qU/s?=
 =?us-ascii?Q?TlkRGc8ATfuPmx+cbDGoROlLYspG8MqK750lVBzpP+oKTf7zQivyLDMG7wHr?=
 =?us-ascii?Q?bw2ul+EW4gKFUZoEndULPYF4eBNpWDg54VsB8kE/hxnASmHX0s6LNoRHfPRb?=
 =?us-ascii?Q?MZDjTy77MJoriwO9QGjnQD6+8UiE1f1yZ3Qr4yNAGe69M9zDLCD75+EYPvRu?=
 =?us-ascii?Q?eY+3BoUCeXeYVJTnO/dsuWpsxJD5hZg1pJ94WwlED8T0ovECFfD4SSaA9JdC?=
 =?us-ascii?Q?fucLyezGpJ4JIkCEIZq/rQgHBLFaNqJLBfXgxOUfYn4bG/WRMJtRU/jlswK1?=
 =?us-ascii?Q?VBVXL46sZugAd4S8j3VVbf6NjXgoYHdM85bhfOCsv0EVsdJEkzPfOV2uS5iY?=
 =?us-ascii?Q?GFPn0fskFRkKNA3UsLkcXdVp88AoDmcuqBwcP2HFQHp6ySW02yj8SZiYDA6Z?=
 =?us-ascii?Q?c8F+b0UCizTAl73m9Joholwvgy4rcQuVdbP4MoHlcpscp3w58TmLMkT5v4cK?=
 =?us-ascii?Q?lDG8x7F8fMb2nxgZJtNCA8kHX/ybZB1HhGaRJeK8WfxItMJiUtlDSwaCKj7X?=
 =?us-ascii?Q?F1apSbZmARbdKcmgOzBUKvU3wl21TTduIZAHCoOYpaheVRi5BYNdoqt2ax4b?=
 =?us-ascii?Q?z5S5wctZroFyZLWZfWdM+vg3wdjsQ8Fl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 11:43:35.0465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd4557-d567-46c8-991b-08dcbf7afe39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

When metadata_dst struct is allocated (using metadata_dst_alloc()), it
reserves room for options at the end of the struct.

Change the memcpy() to unsafe_memcpy() as it is guaranteed that enough
room (md_size bytes) was allocated and the field-spanning write is
intentional.

This resolves the following warning:
	------------[ cut here ]------------
	memcpy: detected field-spanning write (size 104) of single field "&new_md-=
>u.tun_info" at include/net/dst_metadata.h:166 (size 96)
	WARNING: CPU: 2 PID: 391470 at include/net/dst_metadata.h:166 tun_dst_uncl=
one+0x114/0x138 [geneve]
	Modules linked in: act_tunnel_key geneve ip6_udp_tunnel udp_tunnel act_vla=
n act_mirred act_skbedit cls_matchall nfnetlink_cttimeout act_gact cls_flow=
er sch_ingress sbsa_gwdt ipmi_devintf ipmi_msghandler xfrm_interface xfrm6_=
tunnel tunnel6 tunnel4 xfrm_user xfrm_algo nvme_fabrics overlay optee openv=
switch nsh nf_conncount ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser =
rdma_cm ib_umad iw_cm libiscsi ib_ipoib scsi_transport_iscsi ib_cm uio_pdrv=
_genirq uio mlxbf_pmc pwr_mlxbf mlxbf_bootctl bluefield_edac nft_chain_nat =
binfmt_misc xt_MASQUERADE nf_nat xt_tcpmss xt_NFLOG nfnetlink_log xt_recent=
 xt_hashlimit xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 xt_mark xt_comment ipt_REJECT nf_reject_ipv4 nft_compat nf_tables nfnet=
link sch_fq_codel dm_multipath fuse efi_pstore ip_tables btrfs blake2b_gene=
ric raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_=
tx xor xor_neon raid6_pq raid1 raid0 nvme nvme_core mlx5_ib ib_uverbs ib_co=
re ipv6 crc_ccitt mlx5_core crct10dif_ce mlxfw
	 psample i2c_mlxbf gpio_mlxbf2 mlxbf_gige mlxbf_tmfifo
	CPU: 2 PID: 391470 Comm: handler6 Not tainted 6.10.0-rc1 #1
	Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS =
4.5.0.12993 Dec  6 2023
	pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
	pc : tun_dst_unclone+0x114/0x138 [geneve]
	lr : tun_dst_unclone+0x114/0x138 [geneve]
	sp : ffffffc0804533f0
	x29: ffffffc0804533f0 x28: 000000000000024e x27: 0000000000000000
	x26: ffffffdcfc0e8e40 x25: ffffff8086fa6600 x24: ffffff8096a0c000
	x23: 0000000000000068 x22: 0000000000000008 x21: ffffff8092ad7000
	x20: ffffff8081e17900 x19: ffffff8092ad7900 x18: 00000000fffffffd
	x17: 0000000000000000 x16: ffffffdcfa018488 x15: 695f6e75742e753e
	x14: 2d646d5f77656e26 x13: 6d5f77656e262220 x12: 646c65696620656c
	x11: ffffffdcfbe33ae8 x10: ffffffdcfbe1baa8 x9 : ffffffdcfa0a4c10
	x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
	x5 : ffffff83fdeeb010 x4 : 0000000000000000 x3 : 0000000000000027
	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff80913f6780
	Call trace:
	 tun_dst_unclone+0x114/0x138 [geneve]
	 geneve_xmit+0x214/0x10e0 [geneve]
	 dev_hard_start_xmit+0xc0/0x220
	 __dev_queue_xmit+0xa14/0xd38
	 dev_queue_xmit+0x14/0x28 [openvswitch]
	 ovs_vport_send+0x98/0x1c8 [openvswitch]
	 do_output+0x80/0x1a0 [openvswitch]
	 do_execute_actions+0x172c/0x1958 [openvswitch]
	 ovs_execute_actions+0x64/0x1a8 [openvswitch]
	 ovs_packet_cmd_execute+0x258/0x2d8 [openvswitch]
	 genl_family_rcv_msg_doit+0xc8/0x138
	 genl_rcv_msg+0x1ec/0x280
	 netlink_rcv_skb+0x64/0x150
	 genl_rcv+0x40/0x60
	 netlink_unicast+0x2e4/0x348
	 netlink_sendmsg+0x1b0/0x400
	 __sock_sendmsg+0x64/0xc0
	 ____sys_sendmsg+0x284/0x308
	 ___sys_sendmsg+0x88/0xf0
	 __sys_sendmsg+0x70/0xd8
	 __arm64_sys_sendmsg+0x2c/0x40
	 invoke_syscall+0x50/0x128
	 el0_svc_common.constprop.0+0x48/0xf0
	 do_el0_svc+0x24/0x38
	 el0_svc+0x38/0x100
	 el0t_64_sync_handler+0xc0/0xc8
	 el0t_64_sync+0x1a4/0x1a8
	---[ end trace 0000000000000000 ]---

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/net/dst_metadata.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 4160731dcb6e..84c15402931c 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -163,8 +163,11 @@ static inline struct metadata_dst *tun_dst_unclone(str=
uct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
=20
-	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
-	       sizeof(struct ip_tunnel_info) + md_size);
+	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
+		      sizeof(struct ip_tunnel_info) + md_size,
+		      /* metadata_dst_alloc() reserves room (md_size bytes) for
+		       * options right after the ip_tunnel_info struct.
+		       */);
 #ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
--=20
2.40.1


