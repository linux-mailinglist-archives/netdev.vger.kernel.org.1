Return-Path: <netdev+bounces-167101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8CAA38D4B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208CC1894C8B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16230238D35;
	Mon, 17 Feb 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3Zi6gZB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2F207A06;
	Mon, 17 Feb 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823944; cv=fail; b=JuevM/oZ65LkF5RiDD0HNf2o0djPfzzpfJYwFcRk3THVUMt5LS/SsjzdGP4U+ct22TCysaLTudm1EkQF7B0Teoy0djRTxMNcBfPem4Tlo2nzTjOYItpvALRHBvdP3qO72IQ/dgs41RtqI3CxapZQXeYXDDXEpiJ2Cg9E7NjrBQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823944; c=relaxed/simple;
	bh=r27Pcaymn0ofX6K4gmuuPC+uuPR6nmChA2H1rbRXkm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNCL7s6I/mGycJ2CYpEoOjzqf7/uRWRGVK5TljzziOdNr/PT9QPZMJ/T6R9AWqzBd3R5sdOqlf5q9zMacpP/Qcx0QJi8tSelclu91epdiApopRQZLxjasHcSvSj7vY8vqzWOgyLTgkAtwxdP0R+Np0SmO6rqeQt4AH/QGnOLMGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3Zi6gZB; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chgs4y9QXUvaoKz3M2Y9fZXShnIKAxrLoCoxRDOvsJHXHx3mQFeQ3576oiCAJQZ+hOlePqyY0g/yasntDiAzA0VmCZpsYlVTLInv/gv58m35pkO/vxnhcRYSeFwLKjaBPF3gRGGMRyWKzZowyTiHtCYM89EVrc3Ao0E7lXebuWJcydEy9nStSLeoOZx51rV87t8G7UAmgyedfxHctuOIcSFzz6H15bS3ql5W9SqsM+YRBOi0QMf1nHc1rjCBhhRMVjQANlRVc0naazuHhcLf5Dqnc2p/L2/mtJmEw5iTajG9iE5VrUYE0ceh1UhoDaRj8w4tTsYtUHi0LWkyP+BDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDsnLxrwS4iXed8QxH9Bq21n6Ki5LCZ+X8pfnLhY4Yw=;
 b=Y+k3VwCCXIMvFuTBdwUcEuJ65VJ2RBBZsC2OZkYic6p86jMOe1CJRUF+h+X5YIaXvwjd10810AHLs3DqANSRdLYXUGrjmrbZ0up4gplL9vCu9qpKgv6hjYp2bTqsyh0bPLXiZ5qUxHI/T6kzuqYhGHw949rdT1iJp2Au4YxBOj4bGp9vCzHDhfIfl2ItGxG77l3VtYZnkMYeqiPBEUqxLYPbMGx212ZfWeVjpWTXzpjoRsHKVIu/uQQSrWBu6nbz/r3wVno7IKr8EGQOfa2VFrIN/bGCRSahPf+pKexkEgwjNIzpkGDLs5gTY+aNUKziyDw2NxEEotPUcU6gMEm0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsnLxrwS4iXed8QxH9Bq21n6Ki5LCZ+X8pfnLhY4Yw=;
 b=q3Zi6gZBSkM2kJEKYu3gJIBovU3RIY4G4O2VSN/0pq5VfeTcQQrkokWXNNkR8/FH8Xs+f6HQu4W2FeNghDSBZRXpiQuy5PUTttpYwWFxqhM+2OX0lIV4pbl2og6VAScDxg28Xh7Xh74q1BdY0VzslDPyn18GUlEN6Sr0jO50rnVY+2kAE7GRUeFwyq8GkjI/RDR/FNZT9dpe6prXV2yuDO8KsdETOI56e3OuqkuPXuH9MXSJFyjEnc1S9TejIu+QOi/4UmXgB6Hyi0yL6gvA33RYtTqMYum3q09g4frwivMIQMzagRjnST/4Q+qWRQG61uQ+4VEQQEgbXFzmb8dsNg==
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 20:25:36 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::fa) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Mon,
 17 Feb 2025 20:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 20:25:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 12:25:19 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 12:25:19 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Feb 2025 12:25:14 -0800
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
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v3 2/2] net: Add options as a flexible array to struct ip_tunnel_info
Date: Mon, 17 Feb 2025 22:25:03 +0200
Message-ID: <20250217202503.265318-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250217202503.265318-1-gal@nvidia.com>
References: <20250217202503.265318-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a91478-2d8b-4cd2-352e-08dd4f913c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7jIGNYbguvzWckSsg+Zybqw7tClymCw1koTiMMm//pu8UnQCq6DDEI63FdIN?=
 =?us-ascii?Q?E0p/UQIDU9JXr2ZiHNFSFrgNN7f6FI6WPMmEj8tFnmXnel8BkyqbLog+dudM?=
 =?us-ascii?Q?abXWA/kTRegr0WHm/z46GM9B70UKZMiAsrz00TV8kNlF1eqhDthYdQfd3B8P?=
 =?us-ascii?Q?B22Aqu8OZQs9CZXuQA/GTKDH5m6MyP9ReG3BBkk/EsqrNCNuqd1Vze3eWO3k?=
 =?us-ascii?Q?k5XZCa1irdbkc5XXmGEh6QcN1xpcoLifom/KZ4lsgtu3779rZYv7jP505IKd?=
 =?us-ascii?Q?ohqqjX2psIJp1AvNqmDdrA5sONtwzortbFAeDIZPUIb7Jqg986mMuypbzIs4?=
 =?us-ascii?Q?H03VVAnrfE/MZnAPfyTYMRLwmJIE4xPLcQrVoRv/YhC3Wp8Os1Du3jyhFlDa?=
 =?us-ascii?Q?D5H+AjP/a0I2mcjgdqvhoIYPQCW1FrYuRKTHK5RCd8j7Oo+YnSf1X5TqsgSx?=
 =?us-ascii?Q?Q66B6lfcNWXBzUGpCALRkuZYgT0gZmUZy+X9LdW4Z0+altb6vNxqksgjDV4w?=
 =?us-ascii?Q?Yc4qzzwgmPGTZ0xW3oDkqTqOdrkc1eiix0AlIzZGOhvnh27GggOG9VPvrZ9B?=
 =?us-ascii?Q?M+8/MOhx4tzV+zmDqRK+vt83uLO0ka/jUObJEK+/qWAI3J8MeGNwHSyv3Ir1?=
 =?us-ascii?Q?p5XIOJ6RcGeY51uaECNIVr0b9tXkV9iNfAD4IbTuKBwAF5VaoNTu6Vub7pZg?=
 =?us-ascii?Q?1YpqOaM2bm54adR6jZEYfo4gs8paqgSP7TxRJ5jjs/9gA0IODTCRpkW8vzjD?=
 =?us-ascii?Q?U/ZN+tTGOLAAj2hG0gVp8GpPqD5vcV/q5hGLUOrT7hUyLnTguGIa/ZynX+lg?=
 =?us-ascii?Q?Oh+zx+KX1Z3Zkw6ewYyeLhgCaqn9zhBWKF0JHG7QPyFkw7knFwws0HMgqgBD?=
 =?us-ascii?Q?UhErO2YZp8wynZU+wkacWuKqaw+I+c+sfTzTMV+xtfo2R72mV2cPMCfFVltx?=
 =?us-ascii?Q?Tv4K+j4tuVWAq6s1fjjwY+ZBgH2ViImM1F3r5mcQyObCGVchhKSWASNj7l+p?=
 =?us-ascii?Q?w5m5OZZ0N8Eh97nN9AbUkD1j/MHzTVWJ5F5ibM97mfy7qhggYqDIyfNtSrQc?=
 =?us-ascii?Q?FYbDL6LwDkqhQiLOeztiSpQhXDBguYjY4hNT8Eb4kCLlYpNyB+DFQFB7omiw?=
 =?us-ascii?Q?+CrORirP+n3OXkN415c8siQezdZTOfAsdeIpvaDH7PVq3fKQafoEfC4N5Oo9?=
 =?us-ascii?Q?hOdpA3+X6S/uMK3ywlJLEFfFCX3xFAKaWnsemur29fq2QbJqENCV+Jd280/K?=
 =?us-ascii?Q?d56HjZNJZ8wnIjLX6HI1pYD2ll8pNTPEW70dV2Qs+/vRb2NWjdeyMnX78W1y?=
 =?us-ascii?Q?8DymH2biBDMlP/cWyufveGIvnSghzcSli4Azhx7IpBwW2lGrrHHueoj4vkRJ?=
 =?us-ascii?Q?THK3DMKK/jOlZcXnJLHIxgrnOjRNMLjr2dxC+vLUnDYM/FkCe8Ici1did5T8?=
 =?us-ascii?Q?zwn36B+3Dgy18h+qvexu6IKLv+xTiMuPuHJd6fGdNKSo7cN0J/Q727gNPKl/?=
 =?us-ascii?Q?RGSUqANnJla8ixE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:25:35.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a91478-2d8b-4cd2-352e-08dd4f913c71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

Remove the hidden assumption that options are allocated at the end of
the struct, and teach the compiler about them using a flexible array.

With this, we can revert the unsafe_memcpy() call we have in
tun_dst_unclone() [1], and resolve the false field-spanning write
warning caused by the memcpy() in ip_tunnel_info_opts_set().

The layout of struct ip_tunnel_info remains the same with this patch.
Before this patch, there was an implicit padding at the end of the
struct, options would be written at 'info + 1' which is after the
padding.
This will remain the same as this patch explicitly aligns 'options'.
The alignment is needed as the options are later casted to different
structs, and might result in unaligned memory access.

Pahole output before this patch:
struct ip_tunnel_info {
    struct ip_tunnel_key       key;                  /*     0    64 */

    /* XXX last struct has 1 byte of padding */

    /* --- cacheline 1 boundary (64 bytes) --- */
    struct ip_tunnel_encap     encap;                /*    64     8 */
    struct dst_cache           dst_cache;            /*    72    16 */
    u8                         options_len;          /*    88     1 */
    u8                         mode;                 /*    89     1 */

    /* size: 96, cachelines: 2, members: 5 */
    /* padding: 6 */
    /* paddings: 1, sum paddings: 1 */
    /* last cacheline: 32 bytes */
};

Pahole output after this patch:
struct ip_tunnel_info {
    struct ip_tunnel_key       key;                  /*     0    64 */
    
    /* XXX last struct has 1 byte of padding */
    
    /* --- cacheline 1 boundary (64 bytes) --- */
    struct ip_tunnel_encap     encap;                /*    64     8 */
    struct dst_cache           dst_cache;            /*    72    16 */
    u8                         options_len;          /*    88     1 */
    u8                         mode;                 /*    89     1 */
    
    /* XXX 6 bytes hole, try to pack */
    
    u8                         options[] __attribute__((__aligned__(16))); /*    96     0 */
    
    /* size: 96, cachelines: 2, members: 6 */
    /* sum members: 90, holes: 1, sum holes: 6 */
    /* paddings: 1, sum paddings: 1 */
    /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
    /* last cacheline: 32 bytes */
} __attribute__((__aligned__(16)));

[1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")

Link: https://lore.kernel.org/all/53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org/
Suggested-by: Kees Cook <kees@kernel.org>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/net/dst_metadata.h | 7 ++-----
 include/net/ip_tunnels.h   | 5 +++--
 net/core/dst.c             | 6 ++++--
 3 files changed, 9 insertions(+), 9 deletions(-)

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
index 7b54cea5de27..e041e4865373 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -95,8 +95,8 @@ struct ip_tunnel_encap {
 
 #define ip_tunnel_info_opts(info)				\
 	_Generic(info,						\
-		 const struct ip_tunnel_info * : ((const void *)((info) + 1)),\
-		 struct ip_tunnel_info * : ((void *)((info) + 1))\
+		 const struct ip_tunnel_info * : ((const void *)(info)->options),\
+		 struct ip_tunnel_info * : ((void *)(info)->options)\
 	)
 
 struct ip_tunnel_info {
@@ -107,6 +107,7 @@ struct ip_tunnel_info {
 #endif
 	u8			options_len;
 	u8			mode;
+	u8			options[] __aligned_largest __counted_by(options_len);
 };
 
 /* 6rd prefix/relay information */
diff --git a/net/core/dst.c b/net/core/dst.c
index 9552a90d4772..c99b95cf9cbb 100644
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
 
@@ -314,7 +315,8 @@ metadata_dst_alloc_percpu(u8 optslen, enum metadata_type type, gfp_t flags)
 	int cpu;
 	struct metadata_dst __percpu *md_dst;
 
-	md_dst = __alloc_percpu_gfp(sizeof(struct metadata_dst) + optslen,
+	md_dst = __alloc_percpu_gfp(struct_size(md_dst, u.tun_info.options,
+						optslen),
 				    __alignof__(struct metadata_dst), flags);
 	if (!md_dst)
 		return NULL;
-- 
2.40.1


