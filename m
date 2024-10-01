Return-Path: <netdev+bounces-130804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35998B9D0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2BF283E31
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295119F429;
	Tue,  1 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeq/VCNp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9A1A0BDE
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779087; cv=fail; b=UKHQTFrMDn4vh6q4l2Pm6Q6Cj+eZ1zaeP49B34KuyFUL40wye/rU0519liwhYRC6Y5EDtbVfnIth1Q48c07G3MBIGKkcCj5x+h4gtK46AQKXuYAAflRIOFZ4W2AkWADYGphBlTCMgLTK8fl28f1URPdA6pCCAqrZczAiWqQyN9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779087; c=relaxed/simple;
	bh=5n3sZH2bRntkMmZIJLXG0+s33H09Q+wSr8cLPAA1sAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHW33/9Hkt5gMn1zIzN6nfjtkNqsmI+k1RgADfvA9Nk4n9GjBKLL00Bc0nZI60b4qGoPXMqR2PsYm7gGc1J8ikTHqWQXykBCOrqDvUmNHdwsIUE3LpD+jDqJsc8e5f6szxP8Lg5jurxYlVgmBSjiVXyNREg2XIvqJqayPtBad/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeq/VCNp; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cotk6dmcml7Q2tK2q8wn9m8M1VntEdb53rgjoxlFn/Uu2EM0RALdupW6lciYEpKKNHAuEtLZ2DtGT624GT7vh+zMwjK6ba2agzrkmrw9x7WwIbUiyWhiulGKBRXpFU2tr6CVThxPXfNkym7njOGTvQyWAzvFL+Vtz/QubFFdUm+X9SHXwVZ3lyUqta+/T1HK9Sd+2r1y4cgkg6NI7/3wRSuAYG4aewty6qwyyGqYylXASR+7LDXZhQEGgVMntmkZNIxRKEme9UZWCUHIOu52NxLJsmeDHsy8QT/qO9TBnevSNQrGKJ08v8MIN0waTMUWaI6Wfla9lpX7LwmQ49PWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWeXu8oB5hWGn88YtOrb9nDr5pwy8kUIM1NvQU0vqcg=;
 b=JmL0iAsRFeu8l8Y+vgSt6HyZNl5vOz//wfDubWmbXDw0kMHm2FAG6cxzNIfXixwpQdigCdyN7UcLWbjF4cx3qIhf+lmJqp+5nt/5ETnX2hwkofvQkV5iJz5wc6UGilOk4OuhYw245TQim0W+d3WL4zZ1VO/qkOEXGUbq124Q8/xxfXaSaj0Jz4uNsopQGuuYI2V3Kr5xlPBx9VIH0Nbf7LLv7Fh3ObB1S7VDE34SunpI/X5uKuVYenbIxnhyBpDMCv/y7ddInPPump4DibYV+JZPGYrXgCb7ygjPNFKCtcglPudPIkyzOoe6BUZOgW/kFMEzEE8XVIIWn2SOdnMHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWeXu8oB5hWGn88YtOrb9nDr5pwy8kUIM1NvQU0vqcg=;
 b=aeq/VCNp78fqoTaEo2VGiutMCP0k7cLf2Djf8Iku9i5LOAvQUpXlpdoJczSh7FOREAFnZDNn4qXLn3umZ160qwtsB9VoVVXynlUZDL+EpCSaornC1DHsZSiMCOzjC8Mfau7VjLf+jI4zNtsuFMWei9GkFrc2aHoMf9F6KuXf5FoK2XXDsXUZfwpA81VRdS4xIDxuDNAqDAtL7RJj8H49dkYItFINGtX/t04LMjVWgNHEYkAOOENs9NBET9P+x28qFodeiXX7mehr/9m667SmzxKXO3Aa9zcyGaTKqwM+GxKMcn0w1ptNo7uaZtOw4+xqHAF+ugAFopcpZNq1MVwwPA==
Received: from SJ0PR13CA0100.namprd13.prod.outlook.com (2603:10b6:a03:2c5::15)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 10:38:00 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a6) by SJ0PR13CA0100.outlook.office365.com
 (2603:10b6:a03:2c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 10:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:37:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 4/6] net/mlx5: hw counters: Drop unneeded cacheline alignment
Date: Tue, 1 Oct 2024 13:37:07 +0300
Message-ID: <20241001103709.58127-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241001103709.58127-1-tariqt@nvidia.com>
References: <20241001103709.58127-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd714c3-876f-4aa8-b411-08dce2051ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xfq4B/mWERVJJorl1InEbLJGRKdmC1k9H6FtuaeSdDPqDOhg8Z5s2hLRAOG4?=
 =?us-ascii?Q?2298CGIrrtujB2K4c1f1JwA3xGP6yW546drE2XJn3hm9NdZ8+91kFodU7MTm?=
 =?us-ascii?Q?Ov67yTtEDG4wMkkPWJmbf9+JaQBPNgZ8AX5n9s3kOzvG2fCPHxh5I1E1lARz?=
 =?us-ascii?Q?wrhNYKdtyP96r62TDqQLQ/cVjrhgIGXgyQMPvr+BVz+XJz/fge/0pDVd9rhk?=
 =?us-ascii?Q?CviJZlmCPzvQSePuAsvWUS6zfB1Nzm7ULi9qVd6j4N73qU4CmC0WOt+CxCY8?=
 =?us-ascii?Q?6/hWej4sujGFbmEpgROGCzKO6HDX9MsyK3gJxGg1ijx5GtbAM0Su9NGr6FUO?=
 =?us-ascii?Q?6Dmk9aGa87kZjwsDb5A4YNI5mhz05q+pGLL0tKlpH8GYh3M78Q8in8aHmMZk?=
 =?us-ascii?Q?9EbKSoxEBpdpGcIi6k7Ku6x8wNAHJhAe8830Xi4k8RRCk9cCfFtI5qFhX3OC?=
 =?us-ascii?Q?emqTMPryXocfByyQmA/jXC07+y+3yrlPqNwa46yRcRXw696w3s3Hmn6r0zfM?=
 =?us-ascii?Q?tfkDrHpWZPkRSjDQdFbHgCFelMY3tbaAbj98vGgF1V59DrYjwj8AdT46frFd?=
 =?us-ascii?Q?EXHJ3VZcCplQ1bk/gUnPCHipmdNB2D8nRFYbkea/4WXMOAYZEyaG57pWFwNn?=
 =?us-ascii?Q?HbfNfebL/h0VWJnXLvh5lrcwZYXo/0zyHwoBT4LAupejzdXWrvVEu01IndW0?=
 =?us-ascii?Q?ASQstvlUkG1WyZ7w7jsZBPAQqc/vCzWgdqSr7l3dfBsKlB/59KJF9JQXgpR+?=
 =?us-ascii?Q?foUf/PwVIwi1KcY4xy6OOXi0zYrWP/LZyeseaI1irK8/q+9zRvLnnLoYKEjW?=
 =?us-ascii?Q?yhhbdHIrGBx6IuEYqZEfXslgPnBFTlmcShND7QtrYDODVPrUMSrg2aseyuvR?=
 =?us-ascii?Q?dAjc2zU/vppK9RyP7IVdTXFmbJjpkzY0XNEy2vehVdso6eGv9+616709VxaC?=
 =?us-ascii?Q?DS38L3LGjRGUFvidCkpA2ptp+Af4UcFAKpSDY6imLcFpUAohpbKR4dXkt6RP?=
 =?us-ascii?Q?bcbY4jhd1C0bBrU5+uglayVx6Z5vW4D2ln7QnU0K/lgXLvrvEOh8VddCsoTM?=
 =?us-ascii?Q?0u2nroEVMRpRRKPfTB3Xh8Tr4ANUSs+RJkDvUHw97VmK7JcNmHCnCd2wf1qR?=
 =?us-ascii?Q?0petWrpfR2s+RMmJQAP7GdRRGizheu3ZaUw87M9OM6eOqhMh75Vjkl7RGJN3?=
 =?us-ascii?Q?IuhmJJ4gkbaYlFIvkQ4dZKRx3MzcuCVcLXpQY3Kj8xwJMCecyIvomtzdvJbW?=
 =?us-ascii?Q?yFSPbf/LJgeg3sMqUHHFTNkfLjCCs92xSLfLXviF1S3QhZlaEFv9372zgtFZ?=
 =?us-ascii?Q?F99TZWx3o9IF0fE1kOjkeT+CEuL317aNma+eGM3YhqCBJfen8i+aCnChSlmd?=
 =?us-ascii?Q?1M2Ztvjlp8RoyVEzUFumEswooYJLxg9J75eSEN9j13mCppXcrimmWlC3gEwB?=
 =?us-ascii?Q?OdEQ3Flp3daKOjg7ZqmhwPLG50FUpWA6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:37:59.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd714c3-876f-4aa8-b411-08dce2051ebf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

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


