Return-Path: <netdev+bounces-165558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E9A32817
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A2C1630B9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7F20FA84;
	Wed, 12 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3pnZqNi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9920F088;
	Wed, 12 Feb 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369435; cv=fail; b=uBZMP6t6UpaSe0vqBMSALGemlagHQEzp9b+tUVdgKg15hJOvVur1qfoDETanFw4pW6Eo5WhPrPXmof7/Ig598pEgpRIYn0qVhUvp+wlfkem636i09B9wG9BW3nEmOPi1jCCnXFvKhGyFtgx48I6466yAHuvfsyUaQgVAuBETW4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369435; c=relaxed/simple;
	bh=VC15e1XcG9db2hoKfZ1xPv+h/ts85m0HqKrnec0poYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mfe3jMX99/J/gQd12HpVfBNHQU6p308oHCYKCKvFQCOuegpK4dWeEtR9zL6pLx7CknANPhToRbBBe8oRNl79HXSOov74O9B5soIi6sTrwAsCB3L/g62kSRZXCAByLbVsOh/Sl6nRI0qeqgpgUqAriJLHEKGzWH2qiVc7jcpvGUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3pnZqNi; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odUTDVOlbIZgvaPhWwyUzAkjLpA7jJwtn0iqzqZqqjKJ7fUhnkatF9LeW1D0Z5TCAm23WsgH1E1/yo7EPqVu1aarFSdJ7OhIPu8W3+QoQJUjj/5RTPLW9oxUyV8/EOJPE+3rMH+3bwJHr6BNm1/r8W6aBU/oYHwfmozMDWGUX7dwJ2JhsjIZF0DCWycYtgnJxDHhrxcbjm8gZISWgDIgzGEbdJ+HrPBLVnWacD656807yQLfBP/9kPDcbVjn63twzVouGJZJWGAdmBBU/l34RWu5oty5UQEJQDi9s1vgjOTJyY3pRcSsqIHFRUPU3811A/tn84vNVyPF3pn14x0glQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBDRC2hvF9Yfh5EF5qj4jjbRej0z0FK7+5dJkGzayvY=;
 b=U0MHNatc/b07fTP5Tu8OjhipAIX9qIKIDIIeCorYSuRpzOdFN46MXxOWu7jwxv5qx9LS1VA8jPrnrOMwkwdGllDhj4WqilP18Y4GDt1lSRT9feiezS3joQ0mp/56atyMFSxTtnPA+ppVpcdtBvi6pr7TUMdD/jVgvnPMODXjnhWNw0JHxGygCbBod4FIIC++zOY7LV1VtztYNrH4RzRlsERJFsb8/NzsJJH1URy3le9nAieKuWdLtQchpayecszh1qjn0VEFWdW655at99xlxwQLGfaufAU3q2VxgdRl5nK74SA/bQN6Jjc2aTDuXTJupmQbpyXCvtd7/MbhLNpikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBDRC2hvF9Yfh5EF5qj4jjbRej0z0FK7+5dJkGzayvY=;
 b=J3pnZqNiLrtygQGWtnDV0/WQ7SnaebUbjafYe38r7lyK5R9ZbWtoUE4AhBMuRkWRb+inRO5e0L2UMZu1/xKbzAFgwYRYRf4YIEEeRCWbkeINIaxLIxN5uXke+of22mieb/rraI3EeYo5jwFtsHeqK+jjXGr6dZZ71OAKOfkDjWnjXuxSifRDQIvltP9E7O52fW7vI9Z4P5Ffdzv6WhWjgc2iTZI7NJKhROkpxAzPxbd+ueYRDroJkj2i607n91g+mLfKvwHttxwD+c3b1mgKmkkBcee5lGp5rBv9PVZDHR7I4/XDpjmBtRZHjjQSoRtW97ZwtsBJZyxkaHPmBbJCpQ==
Received: from SJ0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:33b::27)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 14:10:23 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9c) by SJ0PR05CA0022.outlook.office365.com
 (2603:10b6:a03:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 14:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:10:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:10:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:10:06 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 12
 Feb 2025 06:10:01 -0800
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
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>, "Gal
 Pressman" <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v2] net: Add options as a flexible array to struct ip_tunnel_info
Date: Wed, 12 Feb 2025 16:09:53 +0200
Message-ID: <20250212140953.107533-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 62318a9d-ccba-4f9d-75c7-08dd4b6efdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IzhoQaFlt4PNXPW4xljXz5byBAKZ9lLe8KR5sQK4FFyxzK/O2bb6sSao6k/s?=
 =?us-ascii?Q?YcVj0HPxbFPCdro15b4UWYRO9u9F5mUuZ3lUZ3ePkcFyymAlnCBB35k4H/Lv?=
 =?us-ascii?Q?iTi0FyE5WffmUq6WnqUORafivubclWloYx7Rl8UMBhkli4j1CQRyQtuisAg0?=
 =?us-ascii?Q?cQ3uth7z13jsUc7wrxDBj9qoKjYOy6I1VezJsVBrqxV8QMmF5u9bX9dOR9lV?=
 =?us-ascii?Q?BI/+389dXm0xlndDRwjfuxldyi6qGaQZ1kMzL7PwPJ71KP6Orm50geLCnMdE?=
 =?us-ascii?Q?HjPd8eVOkX9DQq+3DGGawKjcrnw0yF9zhzYaZMH182zXa3LSqyim7xEXOG12?=
 =?us-ascii?Q?afAWbQqNFQ/FzK+kZtp9mrGsY9rZEx6Wfb+wPpSJU0E60BBQa9FpSyz6H1vU?=
 =?us-ascii?Q?SJQ5Vm9ueL7zr5DCiXeCvnv3Ef1cAPA+k65ix1wZwGZe/xXgGwwJKfF1FvbS?=
 =?us-ascii?Q?MrSBaYEJHEbOSpdn9AC1zQKx/z9a5m1LUbdO+/H3AYO+8/h90/89M0aMH6VL?=
 =?us-ascii?Q?xi18UgUfkOnLtf+t3YLc2F5pxfRaeblkIv4PwSQxydqIA0BDH232cFfQjfNP?=
 =?us-ascii?Q?Ygc64HgulstOlI9YBifTxR8ZzIaVyptGuDfKUM8ow0p3zi5ZNxYamEY42d4D?=
 =?us-ascii?Q?tT/BZ0BO8BU5vaeZdh/Jrf34st9/6/keR6OMkDp9IBg8ZQJjoJ2oHr3XnGBj?=
 =?us-ascii?Q?+t7g1S+KdGl07X6GX4CXW4YlKz25H2sTw4JauamvsofC/ujz4/gUSYTnoLfD?=
 =?us-ascii?Q?2gfBWela+LTVdB02biStDRNXHj7ioIM/V578HFjHSlq72F588NMcZlud8J+L?=
 =?us-ascii?Q?52cA2/i2QdkG3YKPXBw+XhmB9SXsfUlZ4QxVvU/uIiDtlHIQHmcAtsf3J0su?=
 =?us-ascii?Q?J0BIFrUMZIEtFrhEQ5O+wXAda3pBG1eVlzoJxPKyK/NIDrQAF7HnvqyK+MZV?=
 =?us-ascii?Q?NWG6aj96sbYb5TtZKbTSSW+OE3wgzezS27U/LdPGRNx6F5X9tndDVGF88jzo?=
 =?us-ascii?Q?ALH1wOmHHIRTzPhcKZm9G/SB2jGGtUgJBkijZ3Sns4kos9zV5OF/QUb+28Ue?=
 =?us-ascii?Q?SfimuIvf2p/idO/ZDOjOyLt1+prFMQNJ7PTSL79Lwq/92eZHslLcPy5yvXNt?=
 =?us-ascii?Q?8R4cjrKgceTcTAO+SB83EiyHwTX9wmlcgBfy7gBwn1EvY2X81JmkiNWRwEDW?=
 =?us-ascii?Q?XCERI8MHutLB7uidqbITveGraedQhftU1IUTE8znbmCDldw0olksLQ0/LynW?=
 =?us-ascii?Q?z7qpIS/J92NI/o0HizRBodSgVONQL8aFJ0kPd+ERm/QikxBLn/jX9W7eLhCt?=
 =?us-ascii?Q?UNh2Wp8g1fY1DD40MfgMYKsms385RlYCkyTauSjZ9Z7FvFRN1Bh0FCIsiaTE?=
 =?us-ascii?Q?9MWDbyQO7orJFDGRHXS6MHnr8/VREnTxE7kOpTdY239ySh3LCdYJ5JYyBG83?=
 =?us-ascii?Q?LQyPIzgfEGLN1k9ZHJY7eAIOjzs32m2p8mo7IXYr+AglPG1tMWw/zdxpqcdd?=
 =?us-ascii?Q?VZSjokmRqTRsx8k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:10:23.0085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62318a9d-ccba-4f9d-75c7-08dd4b6efdb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

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

   u8                         options[] __attribute__((__aligned__(8))); /*    96     0 */

   /* size: 96, cachelines: 2, members: 6 */
   /* sum members: 90, holes: 1, sum holes: 6 */
   /* paddings: 1, sum paddings: 1 */
   /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
   /* last cacheline: 32 bytes */
} __attribute__((__aligned__(8)));

[1] Commit 13cfd6a6d7ac ("net: Silence false field-spanning write warning in metadata_dst memcpy")

Link: https://lore.kernel.org/all/53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org/
Suggested-by: Kees Cook <kees@kernel.org>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
Changelog -
v1->v2: https://lore.kernel.org/netdev/20250209101853.15828-1-gal@nvidia.com/
* Remove change in struct layout, align 'options' field explicitly (Ilya, Kees, Jakub).
* Change allocation I missed in v1 in metadata_dst_alloc_percpu().
---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  4 +---
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  2 +-
 .../ethernet/netronome/nfp/flower/action.c    |  4 ++--
 drivers/net/pfcp.c                            |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 ++--
 include/net/dst_metadata.h                    |  7 ++----
 include/net/ip_tunnels.h                      | 11 +++------
 net/core/dst.c                                |  6 +++--
 net/ipv4/ip_gre.c                             |  4 ++--
 net/ipv4/ip_tunnel_core.c                     | 24 +++++++++----------
 net/ipv6/ip6_gre.c                            |  4 ++--
 net/openvswitch/flow_netlink.c                |  4 ++--
 net/psample/psample.c                         |  2 +-
 net/sched/act_tunnel_key.c                    | 12 +++++-----
 14 files changed, 41 insertions(+), 49 deletions(-)

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
index 1aa31bdb2b31..517f78070be0 100644
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
+	u8			options[] __aligned(sizeof(void *)) __counted_by(options_len);
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


