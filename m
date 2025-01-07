Return-Path: <netdev+bounces-155974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE85A0473B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185473A1ED4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9271DFDBB;
	Tue,  7 Jan 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIFVxn8Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314D1F4273;
	Tue,  7 Jan 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268891; cv=fail; b=pZBNADbRfXssw+HaWPXeRyVbrYUxgYcsnbWXrP4kQwY4oQ4z9kXh9BeWZfeJ1eHk67Mm90hLtGEjZcBjLD6tWLnGpleXh7bkukck3lvIbFuYA2t+BNriHNfSUVZngUMK8PCTN1n/ny+GtT3Xw2QaTEbX7SRh0kWJpQQYbFYqxso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268891; c=relaxed/simple;
	bh=q4rizRD2hzB4IOXoZqYhgl/SdAncdnhXe6n26gML1AQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzzr7CVn2xx7VAsJNusp1Cx6VjVeryRtmx0EEAKDpkRE/l+drNHQW0cSbgnxRhpfIOzI2ijAs9sOsmQ/mu6S6/ywou3Wp0J6rnpt/xQ8odgw5T2paqCbhrr5HycdKiqhPIfh6APqfaq3hxC9bDTQT3KNGJgyPXO3KgLsz5TpJv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIFVxn8Z; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUOcjv4rHkn/AlrSR1ZvklgljT9tVmwBuMQ2KOjnQ967X46WVj5U/hu6PRrV/w+yN5bnL9zE5GTAzgKQcIg/IgUXqoFkm+rHsDRespsOhzJOruw6Ycxpag2iFwip98UcfbI+xHMF8elqAMLaaUAgQgVZ6AUZa9L/4DjVj1Xt/yRfJKk1GpowH5L++VjHbIbClixPIXAyRAd63+oM6WjNhmNc98sKw5c1X3O8Va3ZMcJP5gXBNRHFRjmJnKrp0aJczzBwJrm88jmUNeXrdDZPaJH8t0Pq1wMvmgqkKnXc5PJYB/bGttx0V6iWTlYkavgtX1W5G3dIoWap0a8KMMjYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vnjgHWtBsFmaugfuVVe5Y865JVFndlJYVw4LHyWH6Y=;
 b=Y8xBl2YgpxyTS68fcINadpQmHE+07E6NjerUgeU0p0p1Lbm4uvqOZkK7d3SL91IVFrXuGDmxs/b/H6X1QlkyA8hniAgdbJW7P1ACJma/np2rx+AyydYe4K4FiAkEUz/WEwJnvBoaQ4sFCvrYYXPItjMa/EQARHV9kay1jnHvm5rwdQM7idyXaebzMIc4CG8A5IQeRDsC00EWYIQ1CMvKcRQospbSyFWQvyIbLy/oBYozCseUY3qsRMuGPN/2JLyf04xPsVcb3YOgluuR6FRcpEEBeysJ0o6/BdC8SbYYi1FEaeOGwnh8TWiMiaKQcfI/glX0YG7U5epOfkre1VF4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vnjgHWtBsFmaugfuVVe5Y865JVFndlJYVw4LHyWH6Y=;
 b=nIFVxn8ZjSNBxn5MVFpu9Wo3cfQlgdtAI4sGRbrdM8dcoOka734nq71rI34Ss+GRRMr49mcCjW/cC7GA/nvO7Ix72wAQ4VdXcMQbWNpKCgW7BiFGXDR7V3fKZbazb0In20k4q/JBo4NOsttSRl0qyY/anhGZOAXIF5ZgqjEyiMPVT9zUq7TlSQMyy09+8FbB4JqlPiCkDje0Sww6C1ZmbouxSui8w1TiS9ceIOfeOD03VFQSJG7FE3r+5KNTM8H5XFkXjzUy99mKimSfsSd6LCUHcSeUyA/qTH6gYGDuHSNMiiyqX5c/fvu4W3iZ2scrkuYw9onYPeLiahMfUvmwTw==
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Tue, 7 Jan
 2025 16:54:38 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::d7) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 16:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 16:54:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 08:54:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 Jan 2025 08:54:22 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 08:54:19 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>
Subject: [PATCH net-next] net: Silence false field-spanning write warning in ip_tunnel_info_opts_set() memcpy
Date: Tue, 7 Jan 2025 18:55:09 +0200
Message-ID: <20250107165509.3008505-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 28657367-688d-4177-4edb-08dd2f3bf8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qPzgwfyRDly4sEfESckS6fxdIYgbF35guRVG3U/l558vKVUvhqI8r23A6GY8?=
 =?us-ascii?Q?4MY1TwUymw05li3SwJWFF1LdiEHisBZyHFLEMbVFba2Ncw+UISAOs6GZoyUX?=
 =?us-ascii?Q?G+v84FiQJ7tMAvilGWUgEX+EoRJdDGuZ1AzGBRSiF70utohtY9G9WFUQmyd/?=
 =?us-ascii?Q?+xVdaY5TUDgvmd9DqRcEaS0T3amSkz/p8kuXZjloa92j+Ay5GG+X/sIr2fbK?=
 =?us-ascii?Q?Kv0UlXREvztKYvi4f65I1boiKH61e7JeN3y7aCmakCvPBOWfM695EnwHUDbD?=
 =?us-ascii?Q?W2w6Rqj4ie8RVayaozBqGpYWMpXEHbfvyXM+RQK67KYwRnHUeJZ+XUEZsRjh?=
 =?us-ascii?Q?1qSVGMOqPrckXo0V52ChuAngCxBZwIU+Gid34n+n10BMR0E10odUP1sEobxd?=
 =?us-ascii?Q?Vy5gSyLMwQ9fzBMG3/3A+7Sud+FJPCiGVa0UyPOhi7yuYElF0ReW5wJSBGpo?=
 =?us-ascii?Q?LTvaG2ImnbCVp2/6miCklMfL7UbPj99FJQsjsufZqAD2+MMW/dTBIrgxJdBY?=
 =?us-ascii?Q?03cpZzWuVMUPBtDvrYoghQXlFNlJ6Mt1y3Qz4w+oX+VV7GNa9eZyFto3TPo0?=
 =?us-ascii?Q?R0x0wh42ItO2UgIRV7SAhxfWqQI9Z1itR9w16bxr3NM2Xn2/bT15Afy2M58P?=
 =?us-ascii?Q?c6OCU/fyloPM8YMXAUZfYNeBKleGpTI+r9ZYE/miwaZJP4DfaovQ5Ti7evca?=
 =?us-ascii?Q?WzSI16pFLr0AuvMPoQITvH6+P1kXOtBEs3X4piQJmFDRrrOlcgortUtUQxI/?=
 =?us-ascii?Q?oVsqdBL//yNx1gUfhIRkS0nzBt62vqBxatc2cj2sTn9GIvcTKR52s6Pf9P3n?=
 =?us-ascii?Q?LjmoZvExPnk5Ks+OqW3V/Cn/ZST+X/sCJd2bYvBwDYqeRsO5I9XA8pMeWht9?=
 =?us-ascii?Q?WP9lyQH8sGt7/iCM4jdKSPTVGsfb+xdES7/+LKnRmFGZmioDirIeJPAQa9An?=
 =?us-ascii?Q?p16FRiQRqfkg8r+fqXfLTxxrUb7ZzkmT1AFa15fkUNLsz2xIanBI9SpxDBuG?=
 =?us-ascii?Q?BIE8f5QB+u38Ql9d5wh16yLTFuWzrDrEEt9Wj7lz9nFxAPSCLKb+geyWMEsf?=
 =?us-ascii?Q?MGbDgswUcpJ2FaR/21ec4JxFSqXRSp44UEZdvY11eY0E8ZdSPj8mq157SwUe?=
 =?us-ascii?Q?Pfk0pqCYUb1gI05D54RMXvmpXMTJ1qYGN8/+7W5LTeGRJMz93+GnThwnXPn5?=
 =?us-ascii?Q?/jbx4S4aYQjzGeK9kHls2YO6pgp6fvRV4XCEzdPOmBbkaKdyLLJDaeARRrpN?=
 =?us-ascii?Q?NGP1jD+gE0ZfFhYBFHffyu/RHtKDFLdkgphZ9xGjiPd+CtoQ6OLQMFdoNfv7?=
 =?us-ascii?Q?9aXHp2CjV07TGGTon+X5+hjlurR+wNnyKMGDJMz9XcrgcDMOdOzFuOgSB+4v?=
 =?us-ascii?Q?VFaJSi6tlK+uH4LEp328heRSIimVa6/aNtx6OZFzJGqgkYwFVZKQG9gRoK/Y?=
 =?us-ascii?Q?6Ak+10dRzEL83amZDIyz1U5ioJkanNz8wI4BuRPpweakFtwNwx/rHpQquBS4?=
 =?us-ascii?Q?2rwsPHrxC15C7lk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:54:37.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28657367-688d-4177-4edb-08dd2f3bf8dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

When metadata_dst struct is allocated (using metadata_dst_alloc()), it
reserves room for options at the end of the struct.

Similar to [1], change the memcpy() to unsafe_memcpy() as it is
guaranteed that enough room (md_size bytes) was allocated and the
field-spanning write is intentional.

This resolves the following warning:
  memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:662 (size 0)
  WARNING: CPU: 0 PID: 19184 at include/net/ip_tunnels.h:662 validate_and_copy_set_tun+0x2f0/0x308 [openvswitch]
  Modules linked in: act_csum act_pedit act_tunnel_key geneve ip6_udp_tunnel udp_tunnel nf_conntrack_netlink act_skbedit act_mirred sbsa_gwdt ipmi_devintf ipmi_msghandler nvme_fabrics nvme_core overlay optee cls_matchall nfnetlink_cttimeout act_gact cls_flower sch_ingress openvswitch nsh nf_conncount nft_chain_nat xt_MASQUERADE nf_nat xt_tcpmss ib_srp scsi_transport_srp xt_NFLOG nfnetlink_log xt_recent xt_hashlimit xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_mark xt_comment ipt_REJECT nf_reject_ipv4 rpcrdma nft_compat rdma_ucm ib_umad ib_iser binfmt_misc rdma_cm ib_ipoib iw_cm nf_tables libiscsi scsi_transport_iscsi nfnetlink ib_cm mlx5_ib ib_uverbs ib_core uio_pdrv_genirq uio mlxbf_pmc mlxbf_bootctl bluefield_edac sch_fq_codel dm_multipath fuse efi_pstore ip_tables crct10dif_ce mlx5_core mlxfw psample i2c_mlxbf pwr_mlxbf gpio_mlxbf2 mlxbf_gige mlxbf_tmfifo ipv6 crc_ccitt
  CPU: 0 UID: 0 PID: 19184 Comm: handler2 Not tainted 6.12.0-for-upstream-bluefield-2024-11-29-01-33 #1
  Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.9.0.13378 Oct 30 2024
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : validate_and_copy_set_tun+0x2f0/0x308 [openvswitch]
  lr : validate_and_copy_set_tun+0x2f0/0x308 [openvswitch]
  sp : ffffffc0aac6b420
  x29: ffffffc0aac6b420 x28: 0000000000000040 x27: 0000000000000001
  x26: 0000000000000008 x25: 0000000000000001 x24: 0000000000000800
  x23: ffffff8082ab9c00 x22: ffffffc0aac6b480 x21: 0000000000000008
  x20: ffffffc0aac6b830 x19: 0000000000000000 x18: ffffffffffffffff
  x17: 1514131211100000 x16: ffffffea66bab8d8 x15: 2b20296f666e6928
  x14: 28292a2064696f76 x13: 6c636e6920746120 x12: ffffffea68a6e5d0
  x11: 0000000000000001 x10: 0000000000000001 x9 : ffffffea66c399b8
  x8 : c0000000ffffefff x7 : ffffffea68a163e0 x6 : 0000000000000001
  x5 : ffffff83fdeae488 x4 : 0000000000000000 x3 : 0000000000000027
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff80979f2280
  Call trace:
   validate_and_copy_set_tun+0x2f0/0x308 [openvswitch] (P)
   validate_and_copy_set_tun+0x2f0/0x308 [openvswitch] (L)
   validate_set.constprop.0+0x2dc/0x438 [openvswitch]
   __ovs_nla_copy_actions+0x404/0xd48 [openvswitch]
   ovs_nla_copy_actions+0xb4/0x160 [openvswitch]
   ovs_packet_cmd_execute+0x1bc/0x2f0 [openvswitch]
   genl_family_rcv_msg_doit+0xd0/0x140
   genl_rcv_msg+0x1f0/0x280
   netlink_rcv_skb+0x64/0x138
   genl_rcv+0x40/0x60
   netlink_unicast+0x2e8/0x348
   netlink_sendmsg+0x1ac/0x400
   __sock_sendmsg+0x64/0xc0
   ____sys_sendmsg+0x26c/0x2f0
   ___sys_sendmsg+0x88/0xf0
   __sys_sendmsg+0x88/0x100
   __arm64_sys_sendmsg+0x2c/0x40
   invoke_syscall+0x50/0x120
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x34/0xf0
   el0t_64_sync_handler+0x10c/0x138
   el0t_64_sync+0x1ac/0x1b0

[1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/net/ip_tunnels.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..d5e163eba234 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -659,7 +659,10 @@ static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
 {
 	info->options_len = len;
 	if (len > 0) {
-		memcpy(ip_tunnel_info_opts(info), from, len);
+		unsafe_memcpy(ip_tunnel_info_opts(info), from, len,
+			      /* metadata_dst_alloc() reserves room (md_size bytes)
+			       * for options right after the ip_tunnel_info struct.
+			       */);
 		ip_tunnel_flags_or(info->key.tun_flags, info->key.tun_flags,
 				   flags);
 	}
-- 
2.40.1


