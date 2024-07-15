Return-Path: <netdev+bounces-111516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213729316A4
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09BAB218E6
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFEA18EA7E;
	Mon, 15 Jul 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="owTRrKjY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B18C197
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053546; cv=fail; b=j9AX5qgRxogiYkvHCF7L8Y0YXGQgb0v3XVSTT/WSwmsVuUjrx9fH0xzFt50uljZdqjTUVeAcaCQm7HvrHjmHU7UgcnBudt78xIS8zACwzF0E0qdEl8lDjirFhGAPQ+ezkU/l2DLS+VyQNVYgtL06JpSKmEZDVdpc6LFFdRRubDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053546; c=relaxed/simple;
	bh=WfjJnRgcfILezCkRIdkua/eBObwpSNFq35GCaKiSFks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHfciH2/Jb/UPQpQGEYtGd7ch8RAxtb6AQ1LW53iUzWxF50hXOvGwveEqLgNV3YAxCTafaYIsub9ljnAfeHlVkvPX6yzvxWq+9P1FZVItgJC9Z2thRzpoL6MqOwY4vL3O+UlZCiYcS+OKsavJQU98xtcB7w6yy0HMTiJHwfTfq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=owTRrKjY; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5zbUtyrfWrg7yxQOKw0khgf3063djL1XBHoelnQKSdPrt8+mQEXZOpJQHOyJv9oNCHq+NGIMPyGuoU3sTmxPb02ONFS0ZRa0FZ+J7FMeWZlE5FHJ8mOS0c4PBqj328Cm2g4XqI0iembsXfQCEsquNSGITuXZKemkTJM+u24W3DS/+JTMo1MozSkzMkpZG0N+cXTNkEH6/KlJDNmottksDAgwWfl6UXPq3nJuP6yaPYrXoXA8o8sI0JqJNUr2zRARvwtk7zCQhQSij0eld3jhOHBcpK7JQQ6SVBgdJupRr04Qz1Xwim5mwO1v/UWp8/JwOZf/8HI0fofKxx40xE2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzXu5qJdRG5rTgNLnZfxwGhJzNUVRbay4M1N7LWCzb4=;
 b=wZq4XgtF7XVwG7/B/PgaqbB5JHatO7UsPQiOq3C+aohA0R5GVDAhI0E0QYUZ74NbeE1EfexBcwmVB+8JwDcNFaMVHkHF9u79/7iFjZUmX8jXw2jQ5ljfYtKpXZv0CR+0sjU2MeuQauE5uw0W4vVBV1+2cYrjLTMKt4rxFr/vBqimbK9k0f+9FmAf8ufCDzpz2zU4cY9MddmGCqsPjpZ9HJ72+hD2mmhNhXgT1KVGc3xVmtdXuwXGK1oARUQKZyEwgKUJ3S4mQldm/pPMdy3VyoJA+Blv4ZoqsOHoB75sXvdgMPipEm4XZ47I9YemxLjKB41RaC0YqNB0oMDcqXOpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzXu5qJdRG5rTgNLnZfxwGhJzNUVRbay4M1N7LWCzb4=;
 b=owTRrKjYd8IaEpc28LBxy8kmUMteha06HZ0Z5JjkuyPRCPflOY50wLMOfkJS30c0J68Yonxx1kCmhcgXNGPt7iXo8fJbJ+1nz6om5BrMtroZLcmnq68Y2wc/c5n4Y/lLSEgLe/NJOeBlZ+Z017lGFEe0K4By2ULK+SB/E6UR+6ReOuynKNfXwCabKc2g3Wf0BmgEA8F5YZGjnAlvmG0D5wdVYoIUFg8T3eKnkt3thBa5X6HmIK125bG5OlY0vC/fPfF5PXOM3xqCQdiZHLPO6JhxJaZG/buq8jLRmsHUZXxMVMnU8qaBmEZAPDsS1vioRDHGhOr1MKZjLSFot5Gu1g==
Received: from BN9PR03CA0422.namprd03.prod.outlook.com (2603:10b6:408:113::7)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 14:25:39 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::39) by BN9PR03CA0422.outlook.office365.com
 (2603:10b6:408:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 14:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:25:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 15 Jul
 2024 07:25:14 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Jul 2024 07:25:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<roopa@cumulusnetworks.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] ipv4: Fix incorrect TOS in route get reply
Date: Mon, 15 Jul 2024 17:23:53 +0300
Message-ID: <20240715142354.3697987-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240715142354.3697987-1-idosch@nvidia.com>
References: <20240715142354.3697987-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fca1ac5-c1b3-4d1f-1ccd-08dca4da004b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfgGw3WVd4TrliqtRTHIpYs8ktj4Z1hrFCKyPfyUCkB1XhpwIcIWsAK2Kwpx?=
 =?us-ascii?Q?ZvkR3k9ZL96DDpBPHZIerfpHUe04HfTt8bNT2qN+Ea0PJq/rgR1ejFmykvBh?=
 =?us-ascii?Q?cScytgprvVgKdffaPxL4mXQwxkuvHfzNFsP0SYasVeGcW64P7lToi09htI/7?=
 =?us-ascii?Q?Z0KuT+uM4Kv2GCCNiovz0vsTq4wXMPtcdj65LIOntjTDXimMNlh+cL1kVwZy?=
 =?us-ascii?Q?39+1uljO5kbnBQcTTFcXoMvD/QK4TCdT7GEvV3YvWj15/FEvyftY5oRPTmG9?=
 =?us-ascii?Q?8Rmgb7hohwlqCoMqVO3XECZPlnqqth3NpE/gOlyWDDyF6cDuRfrSF9tjS78y?=
 =?us-ascii?Q?7daVDryRSyNOQJ2otnAkJTHixBAFPC9afVC3V2pq/8PcvicRfAcT+uuUHIKf?=
 =?us-ascii?Q?/aYxxsxef/uSgMD5ApWn3T3Ws9/aUWBQq5eWJgMfleTqtlSDn2ZwstRBDwjb?=
 =?us-ascii?Q?D5AMzaj8Jxqx8LGV9e/hunsIOFJfHB1ClhIJVOKzwtUqHtV1FBSpTueZ8+9I?=
 =?us-ascii?Q?1dhxr045l3Sy4yVhiGpoBjjBvYJL+4J25Y7Oe5wYx4frlA4zDUNWQ5J+b+Q2?=
 =?us-ascii?Q?H+KnYlscALLGkqqaMQFyy3yztDdNjrTFHRo9PMm6iovNV/4ZdIlYQ/2fzST8?=
 =?us-ascii?Q?6AHV0eKeKIr2aKWD1mhRfnHAJZJnEXkhMK/BO8K32VWh36R29Q/GGdO/nLqK?=
 =?us-ascii?Q?6VXbR3SnmUrdkxLlBOSoUiBWgXxwYcqs5vaBf25GKEtNaf8pyzmtXK4ygwB6?=
 =?us-ascii?Q?mkK1cDBYOKzwF7NJSURGwKOkG6aaiG5ow0qjewgh3BGTsyNAulupFDAQ7swS?=
 =?us-ascii?Q?Z64qXrNLiF/UC6hZRwauKIL2FSkYSEis8MkaiYrwK/3i8gQ/7xOH3MKWPCs+?=
 =?us-ascii?Q?9hyaRJ2J0iKmZDM+QcijbggDllBfgZ3dZ/Ir/B9b4gjE/WC7MM6WDj/g+Vbh?=
 =?us-ascii?Q?1tFVo10y+wLJeEirG5ltmN2Mu0CwnLJoVp0HE0Eiwsdw9UFS+p4kT7w1VAhn?=
 =?us-ascii?Q?Uf6eE2SF/CrM6CqBzWeauRBCvbtasiicWAglWdCjvGwivx+kLHwJ5bR49iKJ?=
 =?us-ascii?Q?TpOHHP9KQica3YJOtFp6oB5+eOtF/Bn15LeCXG5E769Cp4D3FeLXEoS+VuYd?=
 =?us-ascii?Q?u/9oIdsvGIgOTO5VTa9YT1qTX0GESiB9D3Wh6VCCG6hHX46qQcb9vlsIdC8N?=
 =?us-ascii?Q?WsXgSmMaDhuRO2a6HvmCNX1NKvaFjsnK6fHcBWzC5fKT63wphqh1/5D+0VKX?=
 =?us-ascii?Q?ACtkXTf7qp4Rs5b99/KezTZ3vs6jIXAdoFOnmUSmzArr5mIdZ5Od81TBfAci?=
 =?us-ascii?Q?QOm53RFFY2ODP+JveR3nfGYRBe4Fj2VNePqUaC5OzmFlhhPfuEcs62J9+Qot?=
 =?us-ascii?Q?8MVDsg+DMqHlGrImWrFIHPLvYQP/bUDZCfJTiEYYF/s5E7tbXODxZUdUoGiF?=
 =?us-ascii?Q?SoZii4SFfOIoi7IPgSXPLnvpyX+CqUwx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:25:39.2484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca1ac5-c1b3-4d1f-1ccd-08dca4da004b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

The TOS value that is returned to user space in the route get reply is
the one with which the lookup was performed ('fl4->flowi4_tos'). This is
fine when the matched route is configured with a TOS as it would not
match if its TOS value did not match the one with which the lookup was
performed.

However, matching on TOS is only performed when the route's TOS is not
zero. It is therefore possible to have the kernel incorrectly return a
non-zero TOS:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get 192.0.2.2 tos 0xfc
 192.0.2.2 tos 0x1c dev dummy1 src 192.0.2.1 uid 0
     cache

Fix by adding a DSCP field to the FIB result structure (inside an
existing 4 bytes hole), populating it in the route lookup and using it
when filling the route get reply.

Output after the patch:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get 192.0.2.2 tos 0xfc
 192.0.2.2 dev dummy1 src 192.0.2.1 uid 0
     cache

Fixes: 1a00fee4ffb2 ("ipv4: Remove rt_key_{src,dst,tos} from struct rtable.")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h |  1 +
 net/ipv4/fib_trie.c  |  1 +
 net/ipv4/route.c     | 14 +++++++-------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 9b2f69ba5e49..c29639b4323f 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -173,6 +173,7 @@ struct fib_result {
 	unsigned char		type;
 	unsigned char		scope;
 	u32			tclassid;
+	dscp_t			dscp;
 	struct fib_nh_common	*nhc;
 	struct fib_info		*fi;
 	struct fib_table	*table;
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index f474106464d2..8f30e3f00b7f 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1629,6 +1629,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 			res->nhc = nhc;
 			res->type = fa->fa_type;
 			res->scope = fi->fib_scope;
+			res->dscp = fa->fa_dscp;
 			res->fi = fi;
 			res->table = tb;
 			res->fa_head = &n->leaf;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b3073d1c8f8f..7790a8347461 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2868,9 +2868,9 @@ EXPORT_SYMBOL_GPL(ip_route_output_flow);
 
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
-			struct rtable *rt, u32 table_id, struct flowi4 *fl4,
-			struct sk_buff *skb, u32 portid, u32 seq,
-			unsigned int flags)
+			struct rtable *rt, u32 table_id, dscp_t dscp,
+			struct flowi4 *fl4, struct sk_buff *skb, u32 portid,
+			u32 seq, unsigned int flags)
 {
 	struct rtmsg *r;
 	struct nlmsghdr *nlh;
@@ -2886,7 +2886,7 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 	r->rtm_family	 = AF_INET;
 	r->rtm_dst_len	= 32;
 	r->rtm_src_len	= 0;
-	r->rtm_tos	= fl4 ? fl4->flowi4_tos : 0;
+	r->rtm_tos	= inet_dscp_to_dsfield(dscp);
 	r->rtm_table	= table_id < 256 ? table_id : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table_id))
 		goto nla_put_failure;
@@ -3036,7 +3036,7 @@ static int fnhe_dump_bucket(struct net *net, struct sk_buff *skb,
 				goto next;
 
 			err = rt_fill_info(net, fnhe->fnhe_daddr, 0, rt,
-					   table_id, NULL, skb,
+					   table_id, 0, NULL, skb,
 					   NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, flags);
 			if (err)
@@ -3359,8 +3359,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		err = fib_dump_info(skb, NETLINK_CB(in_skb).portid,
 				    nlh->nlmsg_seq, RTM_NEWROUTE, &fri, 0);
 	} else {
-		err = rt_fill_info(net, dst, src, rt, table_id, &fl4, skb,
-				   NETLINK_CB(in_skb).portid,
+		err = rt_fill_info(net, dst, src, rt, table_id, res.dscp, &fl4,
+				   skb, NETLINK_CB(in_skb).portid,
 				   nlh->nlmsg_seq, 0);
 	}
 	if (err < 0)
-- 
2.45.1


