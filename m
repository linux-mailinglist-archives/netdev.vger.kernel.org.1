Return-Path: <netdev+bounces-167760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79870A3C242
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19543A6638
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E01EFF9D;
	Wed, 19 Feb 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWhKYGYs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656091EB5FA;
	Wed, 19 Feb 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975622; cv=fail; b=cjkjpUVgNlR2FU/TD+gKICvpJTZ2AmqbAA6t60sC0j49j4yuL9cmjcKCA8aH1y4+vMAeOTFnd4igf153OURfMkFED0jpR0pOHHigEyQraSJlZApAMPc+BTaFQd/D6kUU1YSiu5d8RYDe2XAlDcOjjLAafJRXlCsgt3kOQnzL7iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975622; c=relaxed/simple;
	bh=VjPA8OY4NcWA/Tt3rc8krRkS58SqmjpS5RRUn5OGAEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6vnziXk04f/bKY3kM/VHfQaT3bto5q3bE+pj9wh4RFLazruPZzHeaWGodlaJw3l9D1TY5lhPSmaoVLcqL4esdcecpaRrc+5cZI/gt8hpGQXjlV3h090+rGvB4XHSEYbyD5ADS22nTuzO6yiwReebUDygePQMA3BAHGPGAWyedc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWhKYGYs; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA+OL4bLyjo02hDvhoU8cABoMDayDSrkP1bO7Oa2/5ku35t3ImaqlUeViDdFmA4K3MXgRd1g4N/PU39gsY5jSYGlNNZk39b0Btay3+6gTrvmJUgAW/u9DM4k+J2aHH1vUsjK/tDqNAM29WoT4onug0nRPwhJQE7d9RAV/arYhmbFIEbdlNRr1V6QCiBBh3MVDbWjPupvvZ89iLUvRyNfDeq0d3tZzGxTlIyBPQf9mpswb27zzvBFTNAHJ4VUmAf4ORIfHcgWJf1Si21nvKn7xKQlbbCVQb7Za/6MexGYnAQG17U5VplW7SWdwLkClO2X9jnR1WR3cg4GnICB/xtkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDsnLxrwS4iXed8QxH9Bq21n6Ki5LCZ+X8pfnLhY4Yw=;
 b=KQ/MJkDrwZ5KiyTIkrzcIuVyCyXVmq76XCeWW7GPxIdM34tJxhABFPK3TqR7IF+bQOPTlKikBkc0Ij3yW59DQTMxC06V1qjynDkbsBs+ygF72BdBaLLzunfHxd0GNf7jk5drCUyCtc+1Pa5R73pV6MI0ebqQlsZcyoRJJrOYRt+FZMmxVuieEHo5A75LuOoubNfqEjeVChByc/s2Z3KMTK2FhFbz2vioyWtDZrdLRCeZKKtdZXUn8Q0iWZ4+wMiG16PuF9SAU4Jd9sTaqSoli95MCtK4bDcD5WSUpLLH7R3lkFlmSC4ZETbBnTOyQCv1tkNOckR7JygkJky7lSP66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsnLxrwS4iXed8QxH9Bq21n6Ki5LCZ+X8pfnLhY4Yw=;
 b=mWhKYGYsMdDQeqXV1h4gKt5qE2PpBLhIBrwSFqa2gv87xUJN7dLUHspd7/+NErIGWQfUzjbqLLwMcyUR1xbDpty0fpQxAZXSVMmQjw4Y4UY+GvFiFbfUoVtQProO1+p/k+YkDmtPvGobz6xc5VzUR3WJLKQww26BXU+96CHgBdEe2EaNZTJWLJlcyNLD7GKqPl2ZowIj+7qNRnXY0qwU9SUhiI2RE6jgBhvYydOMj6/8hSQ1kLE5CcXNZGqoCyUYbGCrtUbKlVyCsaP5qgl9/qls0YZ1Rk8lKX3sNJ/ZgWJTvsukmVtA7a2giMTmvfoBOXbBET73VHymwivKd0Km2Q==
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:33:35 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::76) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 14:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 14:33:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 06:33:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 06:33:16 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 06:33:11 -0800
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
Subject: [PATCH net-next v4 2/2] net: Add options as a flexible array to struct ip_tunnel_info
Date: Wed, 19 Feb 2025 16:32:56 +0200
Message-ID: <20250219143256.370277-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250219143256.370277-1-gal@nvidia.com>
References: <20250219143256.370277-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3cd424-74d3-4c43-2c2a-08dd50f26440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4oYMcw0WsT+NeTOAIlry1+iAb9k0HxXDOwZB80kaIQ58sA3bSzVCAKwTGuV/?=
 =?us-ascii?Q?sF3IecHPEHYB1DsZbgJf5RfKXISt7HKiwW1VZ7Ud0NT+67WO94wzgGiPjeqJ?=
 =?us-ascii?Q?wgPHFX5z2PAPrXiqpdABGnZ5t1POBSAajtBybz1uysE/sdfk+Vuo28XTko/4?=
 =?us-ascii?Q?mxhiK0T2OpwANIttQ9EzxMqjNDbaMzZJv09N+u5lNNuIAy/CTLHwVYlvV3KO?=
 =?us-ascii?Q?E66eh1aWykCE9vOcrxvPkcW865z+JWwzLgnovXRrG9kXKvblKAcw52h0kogA?=
 =?us-ascii?Q?8wGftIi3FjaWjFq3365EsLc7HgyZZPdmwBWukhrCSUlLwxO1D62b2rJXqyhp?=
 =?us-ascii?Q?sqhhpDg7FPKr5SIYfsKNxEF8RjrRJuKKEyxg53bBuLwE8WBr5f0T4h/t6b+F?=
 =?us-ascii?Q?ktgIglSFkOvJjO/dfJYMZgr6RWEFL9ze5cnPRW1T7CCWa7dk7nHm6j2tb2gI?=
 =?us-ascii?Q?78HQfQ+IzTDWxlUiuRutsWEnRXieJR791SsD/P9U5REN9XWhmLY2aIRyUPWh?=
 =?us-ascii?Q?Pi+0/2nNvNbXE/NsB/eWaPj6NfuR2Y1gek3nBis5krdSc72xbUiFg0zJvtnu?=
 =?us-ascii?Q?/AnlkP/LjP+3nTBIiQKAC/KW/RAC+8QytnvoU9LS6SA2U2XmQ8uq+aRZUNyF?=
 =?us-ascii?Q?Sc9BXT1HUldz+oJfdTFs5u58uyMS8htDhm1fvmvIMnUMP0CpgkJrIBSoGzMa?=
 =?us-ascii?Q?ViCQopQI0hL7A9snS0N2gKYFyLJ6+VIY3tKy0TSV2bDgdJtyYiH/MyPEUwrZ?=
 =?us-ascii?Q?bmVpxr1oeg+ilVAm15vRWjkTNY4KOmzjeDcM+5lh4JhVWJyceFLO3Hm/1rvk?=
 =?us-ascii?Q?p1E+FSxh72freZ9VKjdFwwjK03hIpfUzjo998OqxsyzZ476A4Xgj7oKNLUyG?=
 =?us-ascii?Q?ahH3s11H6gRvqLUBjWGHL2WFLS3Ex3FvTAUEFEpxaFCK2iBgqOFYarPgOhvr?=
 =?us-ascii?Q?FDvpm5maE9Onnfabgl6M+i4e4I4gqcD08VQQYSgl7MEHFhuFJzCL+8gVOz/Q?=
 =?us-ascii?Q?PuzZ3NkDyBpZHQYCouGRPSrTzrXQxoznx9D5g0ncIEWaL6yvs+3jylRpBpgp?=
 =?us-ascii?Q?+s9CbKmz5KjFruhKbcSmy8zKcP5DPjZV4rvHyj4/Wss32h9Cjo2YvgBGmdTy?=
 =?us-ascii?Q?s4RfBb1WTvhpz3AAiMFYmMZJC0UL8xbQG+3MJlIGu8vte1SivPMeUYpKUD8O?=
 =?us-ascii?Q?k7PNZfmUApnLmLcqRUC2PXmUHtl4wMaw3VIcjmnNgrB9Qa2f7IB4i0+vkypG?=
 =?us-ascii?Q?Xn+8Sr4CCs/Yn1HVxBrcGpp/I3G0lX6OrozUMJ8tX9UYfM3/ElEDY4SbVtps?=
 =?us-ascii?Q?zmekISXGVuDfr3mSrOjI1dmfemEMC0JmraLpG5uuYtWHAdPc10RpHvqOHjA5?=
 =?us-ascii?Q?C7iQxqFKMR99nNwx4mUgRLP61Xgc+ocn2mhQWYro74Dvbcch40Ts79aderWy?=
 =?us-ascii?Q?JMr/b2PXlHVwlzGINPz42fsbHo8mFNKYL8ltODvLlmbZ+tf9Mw5Lrg1kBxhy?=
 =?us-ascii?Q?uKKew//wo/ruwqc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:33:34.9150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3cd424-74d3-4c43-2c2a-08dd50f26440
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

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


