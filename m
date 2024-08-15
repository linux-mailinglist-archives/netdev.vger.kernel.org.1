Return-Path: <netdev+bounces-118729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05309952950
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567DEB24E7C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D26176AD3;
	Thu, 15 Aug 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rm5tRIDb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409C143748
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703088; cv=fail; b=VzeZRBzPTm8yKzPh83/1OZMPPN+Dd1AEImrEER2J0DCiHKz6m64FfXlo+AISdsQJELeOXIK4NPqAI0peRVya/SitrBBcsRfUhzp6ZQi7BiLuBKoeHjv2pIENQiaPGC2p0YOsj9tgZiTGqSI33XZVW/1Pw/Nyvd2TojsdnD1Etps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703088; c=relaxed/simple;
	bh=5n3sZH2bRntkMmZIJLXG0+s33H09Q+wSr8cLPAA1sAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6KbLappMNAMS9mFGabgUoRanN6ZNRcCnNHk6KDlIhTvvpWDvcJEyqq3A/bnoAsRYDkqLjZluVi3tR0g3Lim0Rcu5v5uSRjHO8ebL7QcTkn8ehZs77ufuUmvnMpCx06fXDvhQx+mfAT/pzRcMG+A/Fj0KiN/w/9PZRWtuFdCW2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rm5tRIDb; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8+Bqop4anVK5JX9RaDLVZ3+ucrVaQ3EKexKuNbMsyLW0iDzx28Fjg6l//kwnJ6zK4gc22pmePdtiLFaLgWuBNxmiyyOSItvnKcfi69Gw7C/AIWVRxbi01vEHXqRa7OTIX8u2uNjeoy60qjktkxEpwD8DFgKG00Psa8ybA6fX3zYrlCjhuXSjM8zIh8cbsnYE+mj4W/rf6Seppz2HocGBxk0MUTK0s2mDIhjWZsagQfDj4sWDvxn8FBka95Iw3UqHSSNmChlSyWBjyL+5yvao5Fcq6Aw3Wpg6SjX5TCDQdR+XKbXaqRvOWf9Y3K5/Iv6hM6f3E+mGmtIBJ6F3hX36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWeXu8oB5hWGn88YtOrb9nDr5pwy8kUIM1NvQU0vqcg=;
 b=Sc7vEFFcAfV6/0wI7QUl1zrWvv+yo4o/7y10MsA1++hKMuxgN8jM7D1dTnGTBclRV1vGZp2+amG3idynJ1Ul0NFakXdtHR3MIV0YlAn0ZY7L3F+cY0Py1bexnHu78rWUPIXEfKEwd012kEK5mP9b61zklDy8PiLYMKdvI4obc7WZI9yRHdsMbaRsy3+siJ9vD8R8YvsjksFkRhGxg36OXJps4osaz82nFvTryx1ddGtlrpf3sPT/GTVBRzPInywxuaWA9QPpqxOL88KL/6LBJwG3o2Kyx5+Z+TisRtJ4LNRPTupmfXmDBew2b3tbs6v6OjOueMZajoGS8WB0De084A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWeXu8oB5hWGn88YtOrb9nDr5pwy8kUIM1NvQU0vqcg=;
 b=Rm5tRIDbMgVgCHlFPs6ks7pCiPswGwhXQd9FmpiTkSeeT6vctqqhz3y5mJuO86E8ti3jQCr87F0V5+yaoe8FvrIzjFCgNGBCLWQe3t1TVgyrDvioJGhT57R8T7qerFp2jRFM2S3FuesAXeR8E+rxb+gWxIRj7O7YRuLBDMU4kfK3bg3OHUhnuP8p4qe5tSGSeegjicXE/e9wXXtQ0UDz7vtVYxEKRE3yLYZZAwjqVfSnRuEInFzoafu+3QRbkTRGZhbJZxvJE9WGPtgjy5fgEI8ZT8qEhzlIDMGQP0S97LgmYot+ysZg/+esnIHLeBiQ6r8th/V/gK1ktVoh4+IYtA==
Received: from BN8PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:94::39)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 06:24:41 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::58) by BN8PR03CA0026.outlook.office365.com
 (2603:10b6:408:94::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 06:24:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/10] net/mlx5: hw counters: Drop unneeded cacheline alignment
Date: Thu, 15 Aug 2024 08:46:50 +0300
Message-ID: <20240815054656.2210494-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fec92e-6081-4a2b-cfbc-08dcbcf2f257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KdI5VVMT24f/Bls83pTkVJGOK82Ysyf7OAOrnBrT9BMFyJrkGMEt76P+nej?=
 =?us-ascii?Q?LFw4x3CpJ4xL5kezvNukQvIG3uUbSA3L4MaTPsF4gmdOOs3PpZvkVKMl2IL2?=
 =?us-ascii?Q?GqNQX8uvzmWvXv2Uxeyief+d9t5FaoM7z1hqM4V8KWDjIRloy/1EQEYAG45a?=
 =?us-ascii?Q?AxjLUvhjdV5z9LYRzOFort6CJkZM2TaiW5JB5jTWwJEoKXZlaB0S7fCcoTWh?=
 =?us-ascii?Q?4ab69kGOYtpBMSOixGKDnkbSLjo0lcGlJTtecJbNnqrdulHtfCkfvEqrO8xL?=
 =?us-ascii?Q?4e0EBodgc15epKIrEp+8cfmdTP5+UbXp2kOz2UEowF3E6U72oBnU1dJVQi5T?=
 =?us-ascii?Q?JPxU7iKtf6ZdSjjIDyr2C5l0OUZPZGHwnGEEOlUY3seM9BD5vHDMuaTnVL3e?=
 =?us-ascii?Q?NwSOZ5Y++UrdCRH0l3U5WxC/rA6Sw64g4CIpguUptYq5yBK1JzHS548uVi0S?=
 =?us-ascii?Q?sx/Cqm8apSmaSvMk6bNAqcaSblB0InxSBxgjyhtr7bD3Re7JhR5csiyJSygI?=
 =?us-ascii?Q?l4YskP55hVs/oHoXVxOfwQjiVaH5JYtzJcsSSUGKdFbib6yVCzJjy8Y2GeT3?=
 =?us-ascii?Q?8hZ3afKPiBkzRXSaK8Tw98oT1Lp+hB6K5mpWA6nGKfoHve+9+8uyJe8OlVVC?=
 =?us-ascii?Q?oWzHwK7eVDwks0b8QxJo0lx6RYfBzJQENsGN3gD+b/dOlvikXm3cqUUNqNHc?=
 =?us-ascii?Q?McnErkFcok5jW2AqW2QKRLbRMAIt2uexfPCdQLE2zAOsO7Nyv+vU4rO3VqK+?=
 =?us-ascii?Q?wTqiTIpa5GNgDWemq5b7imHcNiIJjPchYWyc6g6H4iUTRnyojR//T1e/ENs2?=
 =?us-ascii?Q?bxdN8pHd7G2K27/GILPPwCk3F47DvqUzF7VXGETczZw6Hb+zMd/XJYaUqmlV?=
 =?us-ascii?Q?VBvmtJL0vEBd+YkGgA9/1xciEVYBtOVqyLaIQyci8o2asU2hucz8V5ZLUY/n?=
 =?us-ascii?Q?zPAjK/b07MWu7sL2/TUK+BxqfA7FvuYLjKBbKZC6gSCasQSWKL1SYFprC7mi?=
 =?us-ascii?Q?VcBTKVLg33nyhEWjk2pEpdxYr3pAGwzMPPyVl+Ly+k7dkPPUGApkTA6Lb2mF?=
 =?us-ascii?Q?y18TUPXB4zsZvyvdDYV802tI/Oh66CEJJfwf5c6i81eHqMc09k43J3gAIyC0?=
 =?us-ascii?Q?2feBZjIEjqL4/O2wlNTGslUqJLY0Zn/w1a3c8yUQE4oG1PB0l+md6+vUBzu+?=
 =?us-ascii?Q?gF7k0hYkI294rDyvuyvLA55cBvgmr0MBb04c/y71jS4NmQK4b5zEFd3CWVtd?=
 =?us-ascii?Q?nCPU/d6bHYszIZWxDvVdpqOteKpEigF8anAr9d4DhKb9QqKuYNXeWv+y8TcM?=
 =?us-ascii?Q?Gvg1qoMp7pdR5qHvN7x+VM92iLhQMiq0wT/eEnrmKL2XG8etBGP1UfRfw/p7?=
 =?us-ascii?Q?KVGk8NmbjRIybkIMM6h+U0VaA/m7yisTPYjt8xJQuEv2bG2YlyQWQIBXDtcS?=
 =?us-ascii?Q?GBcheMgopiR68xWk7cLyLs045ztuZSdM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:41.1372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fec92e-6081-4a2b-cfbc-08dcbcf2f257
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

From: Cosmin Ratiu <cratiu@nvidia.com>

The mlx5_fc struct has a cache for values queried from hw, which is
cacheline aligned. On x86_64, this results in:

struct mlx5_fc {
        u32                    id;                   /*     0     4 */
        bool                   aging;                /*     4     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mlx5_fc_bulk *  bulk;                 /*     8     8 */

        /* XXX 48 bytes hole, try to pack */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct mlx5_fc_cache   cache __attribute__((__aligned__(64)));
	/*    64    24 */
        u64                    lastpackets;          /*    88     8 */
        u64                    lastbytes;            /*    96     8 */

        /* size: 128, cachelines: 2, members: 6 */
        /* sum members: 53, holes: 2, sum holes: 51 */
        /* padding: 24 */
        /* forced aligns: 1, forced holes: 1, sum forced holes: 48 */
} __attribute__((__aligned__(64)));

(output from pahole).

...So a 48+24=72 byte waste. As far as I can determine, this serves no
purpose other than maybe making sure that the values in the cache do not
span two cachelines in the worst case scenario, but that's not a valid
enough reason to waste 72 bytes per counter, especially since this code
is not performance-critical. There could potentially be hundreds of
thousands of counters (e.g. for connection-tracking), so this quickly
adds up to multiple MB wasted.

This commit removes the alignment, resulting in:
struct mlx5_fc {
        [...]
        /* size: 56, cachelines: 1, members: 6 */
        /* sum members: 53, holes: 1, sum holes: 3 */
        /* last cacheline: 56 bytes */
};

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 05d9351ff577..ef13941e55c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -53,7 +53,7 @@ struct mlx5_fc {
 	u32 id;
 	bool aging;
 	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc_cache cache ____cacheline_aligned_in_smp;
+	struct mlx5_fc_cache cache;
 	/* last{packets,bytes} are used for calculating deltas since last reading. */
 	u64 lastpackets;
 	u64 lastbytes;
-- 
2.44.0


