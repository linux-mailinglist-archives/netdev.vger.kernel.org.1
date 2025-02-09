Return-Path: <netdev+bounces-164415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3FFA2DC4E
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9FB3A73DF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED2170826;
	Sun,  9 Feb 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khT1O9Jk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71471C700E;
	Sun,  9 Feb 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096409; cv=fail; b=BlmDWJyJsltM3U7bgWhxMEWx69SBdq2oXor7U5X5LO9Z1cJ75EjY/6neQBrbF8NqfryzXKYK8T0+qJhAeteclml7hJdTf3JQZLQs8TJHexqk8qMzProtwrBcVVc8e1Fwe+eVVOOnPwA155cNZ0dBLsuMjgZLdNr38Eh1WKOHjNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096409; c=relaxed/simple;
	bh=+bADT9a+t+bdPg23wvjBznOtPcp69eFHJVrMGDAQ8Tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLfk0JvwYg29miKm5nFQIZdORW5nIv8q2fGVmkU3ay4s1gvVi69S26s2viu+sQPikJ0PCeAapT6ltn7Wq7Wh4hZ8/+9QutIfogp1QdDuFbtLhj1dDQ+CSKtorBrU7KKVXnxYgWKGOc1zOf+aUuxRpJFhPOcYmBa2zlEU6Kh7seo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khT1O9Jk; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoyujvHLBRQLTei9wRDp0Pkw0dXjnAUPbU/UYcmSUlp69nAyfL1KlxCqxPjO2cs1w45WKGnkGbvqRxo8fdAvQbjFXcG82wP+7/atvec3peZWu6B0tXDoVuhWePHQn7Vk0eZ6A711goJ5+oLM1axVyPODJ2gvWWtE0PCep5A5uUBHanOVkdfRdO59GnVX4+scAbJaDub96qPfWrSYJqdOwycnR4oqWYS3NZ2in5wtjg01YnkCpND7xKOCS7pY818xgi8xTVVIBXhCbIUGyCCuFZ5AWY/By+KFwybOz6n5w+wW8sumc70xTbEvHbrRejpSqCjvADyg6AeHYC2SzhhxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aecoF4oh1DeXVY4EIKyycsLQj5nQQJuaQQZsWhZrDQ=;
 b=Sexa1i6R8/mz2BHv15hFHAH7Za5swAtgABnPX2QBE+ky4mLtG38oMujmaUtBbeM+ZkECl+JAFv/S96ZAUlXoXk6/tOFbN5SLiYTV3fw7Cm9gIPru7XZVYjDAC+wlEH7JFntOulB56bUvkXxgFLyMxRPfFWAwHWwFdy3nLjW0dC22KenXpWyvA2OREDqKl1CL/1Gi5aupqfqkHFyZGSoIgjxve4g3bS6Sixjyop2J34dOj5+3cciLFx1QAor3c4ItbSOxB/eT6z7E6/Ud7VJhLpENoUHBoOFBrByZrP2B0An2kZ/uLf4q/6wtHCJgg3eQsK3hQ831WOBSw0zaPQygAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aecoF4oh1DeXVY4EIKyycsLQj5nQQJuaQQZsWhZrDQ=;
 b=khT1O9JkPOUZ6PfwmV/+0WpJPUCar3Fx+tuaxKYTMJnIEfh1liVGqjgLe8OeBDJq6Cyznh+UGyExZb+5vn/nY7HQCvuEDnVhSOol0sX/iaC+yvjkkxtODfAEoT6qXRchF4EM6tKVoPXLacXh38F+grlKUmxtSokGwJNky42tRaHVlW/HqPbzxkmIJISkY3JKt2cp/KPdUaIXseXnEhr2mDG7zen//ZCISfDxERZIDl6QCo781cpsuQsQmCs/IECOkeaCdZa7wfOyi+1RTXtOIZQzV9hakHvTKO/WRRJqd4nlC52d1WnST/fRAbAiOhFeAGW4gRIq28/vN60gbNr8/A==
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:20:00 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::e8) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:20:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:49 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 9 Feb
 2025 02:19:48 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 9 Feb
 2025 02:19:44 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Pravin B
 Shelar" <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>
Subject: [PATCH net-next] net: Add options as a flexible array to struct ip_tunnel_info
Date: Sun, 9 Feb 2025 12:18:53 +0200
Message-ID: <20250209101853.15828-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d66e1e7-1b1e-4bce-820c-08dd48f34f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MKPk9gEL9Ndvlhrxu/pOJFAT+PMXTvHPIOtfCiPh4U/ekV0DTy08bjrwGPLE?=
 =?us-ascii?Q?DzaTkvjLkE+B6eK/rO1/O0b6ekiZn8PWbGlMNR5XuLbUfU7AwU68bYj2suya?=
 =?us-ascii?Q?HZCRYgpAx2tjx0Xkuo+3tqg8n69MMHPtw2NMK9cqko7A6+Z9dQ+mDJUnW5fN?=
 =?us-ascii?Q?rxiTYEAmLO29MsPtzS4pcgL6cuHI2rhItgXP4L+phpAO/TaPBn3uFulsYY4t?=
 =?us-ascii?Q?zCQPfinX5pqAu6seY4YUtQhXYYsJ705j2m3RIyTUkH8UG/TPqUhtR6IKgJX7?=
 =?us-ascii?Q?Ikq+54N1JMGJfkOzpB6xjPujxZICyoPvexijY2bA4Go9uMZxefn1InILT7mG?=
 =?us-ascii?Q?u1RbMPOtTlsd0gSLQtCR07iRCCjqBEn491ca7xzcDxZPVhu0/ogH6MBexDky?=
 =?us-ascii?Q?VvRGjsxonNGaj0kSfr1BxBfTUnhs8ziyoC74kDRrUjGMKsUUfPTcQy4iTCTz?=
 =?us-ascii?Q?4TxqZcrsDv5082EYnyifsdLSxq8zLWarhICasOyVcPtAaF36UXr71dl1u9RK?=
 =?us-ascii?Q?rywA5NXB5uFMKadg7/XKxB7IbKGb/i8XAxIZpWswYK8B+ZTGNURc+/v2/w+V?=
 =?us-ascii?Q?aUd74+grdX9TLK4DLhME06PUmEmCxgxkKkb8ARuvV1/cc/s8+Jtrw6StPhYX?=
 =?us-ascii?Q?HVHLu165oPWQVVVbjQab2fCp1hmWsJMdgZbTkY4Qrif7iK8tRWHM9nWbX578?=
 =?us-ascii?Q?e7Rlc+WASmIryAEA3h+tXc1zKDGs90x/2XMr1ptUBM094wxcld5/zWayusJz?=
 =?us-ascii?Q?aOKtQ0uI6dYVWDMXauNyeTNJXaisEmv6CqO0EMsXwCzz3tax2yye5Ar+AlUU?=
 =?us-ascii?Q?eiejbZf0bjAxGFRmkJ5wJtq9FWqtlg/C5sEftNrW9AWxsquwS4nGHMiVHMbS?=
 =?us-ascii?Q?ZSGEakTpJYDHbHGzAc5JEM90YGGYMTk4ClPHwuEq6/fUTgalCNtR0hLjMIMA?=
 =?us-ascii?Q?XbVGTfZCYURMX+GEY1FOZxBhDgw4aL1LaHmCFSKAsoxo8jczqTXfsWXjaT3t?=
 =?us-ascii?Q?7WdlYWLO6w1HxrvXuEnFeK66H1qEE6hLkXWcDynOZ1rpeyfCpDith1SPpYWv?=
 =?us-ascii?Q?tF9JUr+wO+T/nIripXyHiee5yanIjgs9bjhN5tjTR/CO28Y9pZJ01BFO0t+q?=
 =?us-ascii?Q?KIzCwzve6qBakiz6vyddU9Pt5PToVv+zJsSecNM7ulDPjujKrNObwI5lk82T?=
 =?us-ascii?Q?gw0nennQc+awUk1iluJZ5IRj13eSaADnxxQDIPb5/LjUTYEo/JJh2dgVjqdL?=
 =?us-ascii?Q?bR8pvidc+G58G5Znd6s3ouFw9TLrj7JNcbgyO7LoFD3vfVuvvLj1LooaCtkF?=
 =?us-ascii?Q?83uRQEvlXPv8PsoD2FQsza71/Xdc/cFBMBuSaiioklyzw4PdhS/0o19OIF78?=
 =?us-ascii?Q?OPP+XPaGCzYIclHobwfXMZDgrj1uJB9A2c0HVNgRl/50DEFavFXcSFhrPtN1?=
 =?us-ascii?Q?I+hza3E2IPpLn/cJCPLij40706O7g5CfJi8pHtrGSBTZ1AitpZOLe5SsJUsu?=
 =?us-ascii?Q?m3f4O/caA0Kb7G8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:20:00.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d66e1e7-1b1e-4bce-820c-08dd48f34f7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

Remove the hidden assumption that options are allocated at the end of
the struct, and teach the compiler about them using a flexible array.

With this, we can revert the unsafe_memcpy() call we have in
tun_dst_unclone() [1], and resolve the false field-spanning write
warning caused by the memcpy() in ip_tunnel_info_opts_set().

Note that this patch changes the layout of struct ip_tunnel_info since
there is padding at the end of the struct.
Before this, options would be written at 'info + 1' which is after the
padding.
After this patch, options are written right after 'mode' field (into the
padding).

[1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")

Link: https://lore.kernel.org/all/53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org/
Suggested-by: Kees Cook <kees@kernel.org>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  4 +---
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  2 +-
 .../ethernet/netronome/nfp/flower/action.c    |  4 ++--
 drivers/net/pfcp.c                            |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 ++--
 include/net/dst_metadata.h                    |  7 ++----
 include/net/ip_tunnels.h                      | 11 +++------
 net/core/dst.c                                |  3 ++-
 net/ipv4/ip_gre.c                             |  4 ++--
 net/ipv4/ip_tunnel_core.c                     | 24 +++++++++----------
 net/ipv6/ip6_gre.c                            |  4 ++--
 net/openvswitch/flow_netlink.c                |  4 ++--
 net/psample/psample.c                         |  2 +-
 net/sched/act_tunnel_key.c                    | 12 +++++-----
 14 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index e7e01f3298ef..d9f40cf8198d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -620,9 +620,7 @@ bool mlx5e_tc_tun_encap_info_equal_options(struct mlx5e_encap_key *a,
 	b_info = container_of(b->ip_tun_key, struct ip_tunnel_info, key);
 
 	return a_info->options_len == b_info->options_len &&
-	       !memcmp(ip_tunnel_info_opts(a_info),
-		       ip_tunnel_info_opts(b_info),
-		       a_info->options_len);
+	       !memcmp(a_info->options, b_info->options, a_info->options_len);
 }
 
 static int cmp_decap_info(struct mlx5e_decap_key *a,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index e4e487c8431b..561c874b0825 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -100,7 +100,7 @@ static int mlx5e_gen_ip_tunnel_header_vxlan(char buf[],
 	vxh->vx_flags = VXLAN_HF_VNI;
 	vxh->vx_vni = vxlan_vni_field(tun_id);
 	if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, tun_key->tun_flags)) {
-		md = ip_tunnel_info_opts(e->tun_info);
+		md = (struct vxlan_metadata *)e->tun_info->options;
 		vxlan_build_gbp_hdr(vxh, md);
 	}
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index aca2a7417af3..6dd8817771b5 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -333,7 +333,7 @@ nfp_fl_push_geneve_options(struct nfp_fl_payload *nfp_fl, int *list_len,
 {
 	struct ip_tunnel_info *ip_tun = (struct ip_tunnel_info *)act->tunnel;
 	int opt_len, opt_cnt, act_start, tot_push_len;
-	u8 *src = ip_tunnel_info_opts(ip_tun);
+	u8 *src = ip_tun->options;
 
 	/* We need to populate the options in reverse order for HW.
 	 * Therefore we go through the options, calculating the
@@ -370,7 +370,7 @@ nfp_fl_push_geneve_options(struct nfp_fl_payload *nfp_fl, int *list_len,
 
 	act_start = *list_len;
 	*list_len += tot_push_len;
-	src = ip_tunnel_info_opts(ip_tun);
+	src = ip_tun->options;
 	while (opt_cnt) {
 		struct geneve_opt *opt = (struct geneve_opt *)src;
 		struct nfp_fl_push_geneve *push;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 68d0d9e92a22..4963f85ad807 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -71,7 +71,7 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!tun_dst))
 		goto drop;
 
-	md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
+	md = (struct pfcp_metadata *)tun_dst->u.tun_info.options;
 	if (unlikely(!md))
 		goto drop;
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05c10acb2a57..9fd1832af6b0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1756,7 +1756,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
+		md = (struct vxlan_metadata *)tun_dst->u.tun_info.options;
 
 		skb_dst_set(skb, (struct dst_entry *)tun_dst);
 	} else {
@@ -2459,7 +2459,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
 			if (info->options_len < sizeof(*md))
 				goto drop;
-			md = ip_tunnel_info_opts(info);
+			md = (struct vxlan_metadata *)info->options;
 		}
 		ttl = info->key.ttl;
 		tos = info->key.tos;
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 84c15402931c..4160731dcb6e 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -163,11 +163,8 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
 
-	unsafe_memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
-		      sizeof(struct ip_tunnel_info) + md_size,
-		      /* metadata_dst_alloc() reserves room (md_size bytes) for
-		       * options right after the ip_tunnel_info struct.
-		       */);
+	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
+	       sizeof(struct ip_tunnel_info) + md_size);
 #ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..2a6dca52e61d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -93,12 +93,6 @@ struct ip_tunnel_encap {
 	GENMASK((sizeof_field(struct ip_tunnel_info,		\
 			      options_len) * BITS_PER_BYTE) - 1, 0)
 
-#define ip_tunnel_info_opts(info)				\
-	_Generic(info,						\
-		 const struct ip_tunnel_info * : ((const void *)((info) + 1)),\
-		 struct ip_tunnel_info * : ((void *)((info) + 1))\
-	)
-
 struct ip_tunnel_info {
 	struct ip_tunnel_key	key;
 	struct ip_tunnel_encap	encap;
@@ -107,6 +101,7 @@ struct ip_tunnel_info {
 #endif
 	u8			options_len;
 	u8			mode;
+	u8			options[] __counted_by(options_len);
 };
 
 /* 6rd prefix/relay information */
@@ -650,7 +645,7 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 static inline void ip_tunnel_info_opts_get(void *to,
 					   const struct ip_tunnel_info *info)
 {
-	memcpy(to, info + 1, info->options_len);
+	memcpy(to, info->options, info->options_len);
 }
 
 static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
@@ -659,7 +654,7 @@ static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
 {
 	info->options_len = len;
 	if (len > 0) {
-		memcpy(ip_tunnel_info_opts(info), from, len);
+		memcpy(info->options, from, len);
 		ip_tunnel_flags_or(info->key.tun_flags, info->key.tun_flags,
 				   flags);
 	}
diff --git a/net/core/dst.c b/net/core/dst.c
index 9552a90d4772..d981c295a48e 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -286,7 +286,8 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
 {
 	struct metadata_dst *md_dst;
 
-	md_dst = kmalloc(sizeof(*md_dst) + optslen, flags);
+	md_dst = kmalloc(struct_size(md_dst, u.tun_info.options, optslen),
+			 flags);
 	if (!md_dst)
 		return NULL;
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ed1b6b44faf8..e061aec6e7bf 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -334,7 +334,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			     skb_network_header_len(skb);
 			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
 							    sizeof(*ershdr));
-			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
+			md = (struct erspan_metadata *)tun_dst->u.tun_info.options;
 			md->version = ver;
 			md2 = &md->u.md2;
 			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
@@ -556,7 +556,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto err_free_skb;
 	if (tun_info->options_len < sizeof(*md))
 		goto err_free_skb;
-	md = ip_tunnel_info_opts(tun_info);
+	md = (struct erspan_metadata *)tun_info->options;
 
 	/* ERSPAN has fixed 8 byte GRE header */
 	version = md->version;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index a3676155be78..e0b0169175e5 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -147,8 +147,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 		dst->key.u.ipv4.dst = src->key.u.ipv4.src;
 	ip_tunnel_flags_copy(dst->key.tun_flags, src->key.tun_flags);
 	dst->mode = src->mode | IP_TUNNEL_INFO_TX;
-	ip_tunnel_info_opts_set(dst, ip_tunnel_info_opts(src),
-				src->options_len, tun_flags);
+	ip_tunnel_info_opts_set(dst, src->options, src->options_len, tun_flags);
 
 	return res;
 }
@@ -490,7 +489,8 @@ static int ip_tun_parse_opts_geneve(struct nlattr *attr,
 		return -EINVAL;
 
 	if (info) {
-		struct geneve_opt *opt = ip_tunnel_info_opts(info) + opts_len;
+		struct geneve_opt *opt =
+			(struct geneve_opt *)(info->options + opts_len);
 
 		memcpy(opt->opt_data, nla_data(attr), data_len);
 		opt->length = data_len / 4;
@@ -521,7 +521,7 @@ static int ip_tun_parse_opts_vxlan(struct nlattr *attr,
 
 	if (info) {
 		struct vxlan_metadata *md =
-			ip_tunnel_info_opts(info) + opts_len;
+			(struct vxlan_metadata *)(info->options + opts_len);
 
 		attr = tb[LWTUNNEL_IP_OPT_VXLAN_GBP];
 		md->gbp = nla_get_u32(attr);
@@ -562,7 +562,7 @@ static int ip_tun_parse_opts_erspan(struct nlattr *attr,
 
 	if (info) {
 		struct erspan_metadata *md =
-			ip_tunnel_info_opts(info) + opts_len;
+			(struct erspan_metadata *)(info->options + opts_len);
 
 		md->version = ver;
 		if (ver == 1) {
@@ -746,7 +746,7 @@ static int ip_tun_fill_encap_opts_geneve(struct sk_buff *skb,
 		return -ENOMEM;
 
 	while (tun_info->options_len > offset) {
-		opt = ip_tunnel_info_opts(tun_info) + offset;
+		opt = (struct geneve_opt *)(tun_info->options + offset);
 		if (nla_put_be16(skb, LWTUNNEL_IP_OPT_GENEVE_CLASS,
 				 opt->opt_class) ||
 		    nla_put_u8(skb, LWTUNNEL_IP_OPT_GENEVE_TYPE, opt->type) ||
@@ -772,7 +772,7 @@ static int ip_tun_fill_encap_opts_vxlan(struct sk_buff *skb,
 	if (!nest)
 		return -ENOMEM;
 
-	md = ip_tunnel_info_opts(tun_info);
+	md = (struct vxlan_metadata *)tun_info->options;
 	if (nla_put_u32(skb, LWTUNNEL_IP_OPT_VXLAN_GBP, md->gbp)) {
 		nla_nest_cancel(skb, nest);
 		return -ENOMEM;
@@ -792,7 +792,7 @@ static int ip_tun_fill_encap_opts_erspan(struct sk_buff *skb,
 	if (!nest)
 		return -ENOMEM;
 
-	md = ip_tunnel_info_opts(tun_info);
+	md = (struct erspan_metadata *)tun_info->options;
 	if (nla_put_u8(skb, LWTUNNEL_IP_OPT_ERSPAN_VER, md->version))
 		goto err;
 
@@ -875,7 +875,7 @@ static int ip_tun_opts_nlsize(struct ip_tunnel_info *info)
 
 		opt_len += nla_total_size(0);	/* LWTUNNEL_IP_OPTS_GENEVE */
 		while (info->options_len > offset) {
-			opt = ip_tunnel_info_opts(info) + offset;
+			opt = (struct geneve_opt *)(info->options + offset);
 			opt_len += nla_total_size(2)	/* OPT_GENEVE_CLASS */
 				   + nla_total_size(1)	/* OPT_GENEVE_TYPE */
 				   + nla_total_size(opt->length * 4);
@@ -886,7 +886,8 @@ static int ip_tun_opts_nlsize(struct ip_tunnel_info *info)
 		opt_len += nla_total_size(0)	/* LWTUNNEL_IP_OPTS_VXLAN */
 			   + nla_total_size(4);	/* OPT_VXLAN_GBP */
 	} else if (test_bit(IP_TUNNEL_ERSPAN_OPT_BIT, info->key.tun_flags)) {
-		struct erspan_metadata *md = ip_tunnel_info_opts(info);
+		struct erspan_metadata *md =
+			(struct erspan_metadata *)info->options;
 
 		opt_len += nla_total_size(0)	/* LWTUNNEL_IP_OPTS_ERSPAN */
 			   + nla_total_size(1)	/* OPT_ERSPAN_VER */
@@ -920,8 +921,7 @@ static int ip_tun_cmp_encap(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	return memcmp(info_a, info_b, sizeof(info_a->key)) ||
 	       info_a->mode != info_b->mode ||
 	       info_a->options_len != info_b->options_len ||
-	       memcmp(ip_tunnel_info_opts(info_a),
-		      ip_tunnel_info_opts(info_b), info_a->options_len);
+	       memcmp(info_a->options, info_b->options, info_a->options_len);
 }
 
 static const struct lwtunnel_encap_ops ip_tun_lwt_ops = {
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec70..35b0fb2162d7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -575,7 +575,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
 							    sizeof(*ershdr));
 			info = &tun_dst->u.tun_info;
-			md = ip_tunnel_info_opts(info);
+			md = (struct erspan_metadata *)info->options;
 			md->version = ver;
 			md2 = &md->u.md2;
 			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
@@ -1022,7 +1022,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			goto tx_err;
 		if (tun_info->options_len < sizeof(*md))
 			goto tx_err;
-		md = ip_tunnel_info_opts(tun_info);
+		md = (struct erspan_metadata *)tun_info->options;
 
 		tun_id = tunnel_id_to_key32(key->tun_id);
 		if (md->version == 1) {
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 881ddd3696d5..2c0ebc9890e4 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -980,7 +980,7 @@ int ovs_nla_put_tunnel_info(struct sk_buff *skb,
 			    struct ip_tunnel_info *tun_info)
 {
 	return __ip_tun_to_nlattr(skb, &tun_info->key,
-				  ip_tunnel_info_opts(tun_info),
+				  tun_info->options,
 				  tun_info->options_len,
 				  ip_tunnel_info_af(tun_info), tun_info->mode);
 }
@@ -3753,7 +3753,7 @@ static int set_action_to_attr(const struct nlattr *a, struct sk_buff *skb)
 			return -EMSGSIZE;
 
 		err =  ip_tun_to_nlattr(skb, &tun_info->key,
-					ip_tunnel_info_opts(tun_info),
+					tun_info->options,
 					tun_info->options_len,
 					ip_tunnel_info_af(tun_info), tun_info->mode);
 		if (err)
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 25f92ba0840c..8ed75e83826e 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -217,7 +217,7 @@ static int __psample_ip_tun_to_nlattr(struct sk_buff *skb,
 			      struct ip_tunnel_info *tun_info)
 {
 	unsigned short tun_proto = ip_tunnel_info_af(tun_info);
-	const void *tun_opts = ip_tunnel_info_opts(tun_info);
+	const void *tun_opts = tun_info->options;
 	const struct ip_tunnel_key *tun_key = &tun_info->key;
 	int tun_opts_len = tun_info->options_len;
 
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c99845948..5bb7d32967da 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -303,7 +303,7 @@ static int tunnel_key_opts_set(struct nlattr *nla, struct ip_tunnel_info *info,
 	case TCA_TUNNEL_KEY_ENC_OPTS_GENEVE:
 #if IS_ENABLED(CONFIG_INET)
 		__set_bit(IP_TUNNEL_GENEVE_OPT_BIT, info->key.tun_flags);
-		return tunnel_key_copy_opts(nla, ip_tunnel_info_opts(info),
+		return tunnel_key_copy_opts(nla, info->options,
 					    opts_len, extack);
 #else
 		return -EAFNOSUPPORT;
@@ -311,7 +311,7 @@ static int tunnel_key_opts_set(struct nlattr *nla, struct ip_tunnel_info *info,
 	case TCA_TUNNEL_KEY_ENC_OPTS_VXLAN:
 #if IS_ENABLED(CONFIG_INET)
 		__set_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags);
-		return tunnel_key_copy_opts(nla, ip_tunnel_info_opts(info),
+		return tunnel_key_copy_opts(nla, info->options,
 					    opts_len, extack);
 #else
 		return -EAFNOSUPPORT;
@@ -319,7 +319,7 @@ static int tunnel_key_opts_set(struct nlattr *nla, struct ip_tunnel_info *info,
 	case TCA_TUNNEL_KEY_ENC_OPTS_ERSPAN:
 #if IS_ENABLED(CONFIG_INET)
 		__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT, info->key.tun_flags);
-		return tunnel_key_copy_opts(nla, ip_tunnel_info_opts(info),
+		return tunnel_key_copy_opts(nla, info->options,
 					    opts_len, extack);
 #else
 		return -EAFNOSUPPORT;
@@ -572,7 +572,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
 	int len = info->options_len;
-	u8 *src = (u8 *)(info + 1);
+	u8 *src = (u8 *)info->options;
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_GENEVE);
@@ -603,7 +603,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 				      const struct ip_tunnel_info *info)
 {
-	struct vxlan_metadata *md = (struct vxlan_metadata *)(info + 1);
+	struct vxlan_metadata *md = (struct vxlan_metadata *)info->options;
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_VXLAN);
@@ -622,7 +622,7 @@ static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 static int tunnel_key_erspan_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
-	struct erspan_metadata *md = (struct erspan_metadata *)(info + 1);
+	struct erspan_metadata *md = (struct erspan_metadata *)info->options;
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_ERSPAN);
-- 
2.40.1


