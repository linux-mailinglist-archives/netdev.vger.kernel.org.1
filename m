Return-Path: <netdev+bounces-207119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9AB05D74
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3FF7AEE2E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A92E6136;
	Tue, 15 Jul 2025 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdDF4/Bj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3E192D8A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586164; cv=fail; b=Q018wi2pMJT1HwnALxWm2/AFwKiNm3d1p6YHBJ1JX9STTv64swHILAj1NdWF0Azv2BuwstXhfPyOA4Aa/uGikaUSHNh3svrGwgDypqERiL+nr9QWBY/ASWPJLSiMbr5W3sfOfKoZ/HabDDz/NJoYZ4eUaybwShFKrXWrJyzz/CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586164; c=relaxed/simple;
	bh=GDowMsJiEajbPaPyYIxqZdde0O2cTUCbygqBan0wWpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKeHauldIcwX3oRSKkA1sjbHiS61PQKKuEo20CMkWYqKpXE3IYkMje5J04Kj39F66HRkvOJ+awWsA+Kv4j29ko1wpXP+bE/1T3EezjauqiDNd3GRjdgr96P1ZSDHa+OrSr+4nFTrmFLGMkiU/FbO7M+6IkZbdHC+br9Nzg01HSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdDF4/Bj; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4fcQDzWhdDrRliTBPS9G2ygsRebl7xxyhleWm4GKC6Ym5rYeC01Zasy51ZcGz/7M5NN/kQIkAuV1n6O++11GAzHsxOimUXI596TblOQ1XASF5Nz6GZFRnlIieIyTaBwgtIgYnUe/zBYkz1T/WC2N8i60T/Fnvn/Pv03h4t83qhNi7pJEbelmbljbvRbM1liEZKXZe1xbkrR08LqgMThrmKAoPWgkyWxHW8FD0guaQecyXvZmFhfyPdbUHIPbpGquPVTGrt8knp+RqY7772PVK621/ddIurOtlJ84Ird1tYxMkGZ5nuBDD2MB6z/kC2FLsVF09xC+rp4ZutUSesHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5cC/EY+rDBYAV5iSpeHdxvNJ4Cbgh0N6A1iJXSHQhQ=;
 b=gJEruU93D+5eyfpXcOIfmHO3DXiB1TBZFGbtygHkgWli6M2d/bBLnxzAn4lHCH3rr86krDDCv/tk7E32Orv7bhbAHfwIpzQeaD2OnWEOjzaySna0GCMkgp3aQ6UbKIBZ+XOb3uYwBuAmfmpJuqI3U9eJW9+ZSbc1hdQfhJFBEajx/kzxe+241oWXG8I0peZ7E44K6kNk5kkN0Jzdd5QuiDh2uQ6v1PzKbracqu45JtSQy34qxa8nJR1v10GlIYlkcwig0ISlNrtpGaWmMaTK62+UYE7hqCW1OP7itUAhAtOUUxOA10Nw8eMWRgjKvXoGoDBObQHWObayapDAYRJfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5cC/EY+rDBYAV5iSpeHdxvNJ4Cbgh0N6A1iJXSHQhQ=;
 b=gdDF4/BjySAl8odmwM2AGnfv1yjHlcYSCK4VEVz/BHqj7kfDLM9fdm1q0PoFV+/isWeB43/jCgsdR1qLWOY0/YyRhmw+T4qoozeMvyfHqQRUsAqgzmNla7FCuGcixleLm9wkxnT8iwyrTPzC5gqU6Bjbsv2itnL3W7Q5FoKl0NY3equtqaajK9g+4n85D8bxyq3VeKXcu6zfOTsxi4tPxen2uOi6o3rtizuTew7AKWRApS9iCql2CV9MuO8ojAauULcbdLHb28pi6uOkOgFo/C0DwsHvhkf2vfKEd5/6Lg0+gGJYAyyfxMCMmDskpaIbp0W+2hckEOOD7ZZ8qn7ytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:19 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:19 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Tue, 15 Jul 2025 13:27:44 +0000
Message-Id: <20250715132750.9619-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 099b021a-c664-4838-8122-08ddc3a39a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWiKXGScUIg+IM8bgpw8O9QHKSNAJkZqJxYRli6vPYPu11v5CmOe0eIsb9iV?=
 =?us-ascii?Q?TksgAWPSNcgaAk5Wmq7X0kndnWFsz9om7Dq2+0dSXuYz5HNnIOZGU1w6Tdk1?=
 =?us-ascii?Q?UKMRt9SFvJUAv+X/HYX4gblP+73BLnph1btbQ77QdgNwteV0E6k51k3ZusWO?=
 =?us-ascii?Q?mphScdttigDqCjB7zExdYWZZk/qM9ZvXV3eBHuQ7j+ZuitlNmAzh2JDaO+C1?=
 =?us-ascii?Q?D9Vmbrr2AyBT0HSw/k94xP9MpFs6Obd7jC2ypCeUAW0Qk2JpZ0UuTrecQKxe?=
 =?us-ascii?Q?4hpVXz/5qeDrfTQqsuxYp9AqEEP5n6heLz7sfnpfBosEg8V+/FS/mUC9Db0E?=
 =?us-ascii?Q?/Awube7TCfuXUbOsbZgKjJD7L5aAZZPfU0PAa8IOsBMRK6G71cNP9X3+kYCZ?=
 =?us-ascii?Q?2PPSi6Gtm8s+YwnS8a4B8M0H2F3r5qT5G/5jTRS4Ks74lwSuUFJqarTOqDQd?=
 =?us-ascii?Q?i1eSw0zOvMVmj/B+7VQSjhGU96oYOBzO792rtqiZlRriKYuMsbnV5d8YoT/O?=
 =?us-ascii?Q?LHGdYcqMMS/qIsPBU9X2u7rQvSLaHeyjz7u8tVkkQ6QgtAhsLcELvaQODVg9?=
 =?us-ascii?Q?cYoZkTAs/HJ628iFUu9BtFQ9IrleZIKGJe/ZQqQUXLpZHiHbyHIh5YhW4uTv?=
 =?us-ascii?Q?LMcsD4m5UFhror1HjLr5aF+sVTXmuYHVFwHEL+T1JVkqzsQiAbPb7f0jedIm?=
 =?us-ascii?Q?bsOrartB7lXVEkBPYqjFq2GowDXX65/0kKB3n47zVxXtsAh2e7PJLevVYM9n?=
 =?us-ascii?Q?kCrEiX9FuOzxKmvtesZhA/ANzXK92RjSt1XSO0vDvHtsgKs2qocGYeyTP1EP?=
 =?us-ascii?Q?Ix1jdbcwAU/zXeagFNNfvzek7Gfz7O84ugciKRX3p9XXZIYevnoIIH+Ruevr?=
 =?us-ascii?Q?mwYUKkzlMSefGlgWsbbnG891mdawLITMINra5VWzZ72L0YwnVqMMRMOzL4SN?=
 =?us-ascii?Q?HhrXtbXgBZux9DeJbYQ9xy8QazKGk7dpQ1oxj9vzvzccVZFMzyCfpTZxkJMw?=
 =?us-ascii?Q?tfSNzjwGvP2GFzRD+3WSNi/gnuRLjrU4sJimGUM/GRshPEjGNyLsAAVOM4cj?=
 =?us-ascii?Q?aWwIdAdvySMjTYIwcGUcQLRytHOjLxqtLCOw/Qzpr5OJW17y+dU4iXyp2mED?=
 =?us-ascii?Q?1ug62E3kx6eRBWRrkCkbbKu8KjFBjVcOFESkVBIESrOshGh07C3207e3x6ga?=
 =?us-ascii?Q?+6VZz+FzGFgueOjgL/AW3p1DPNQ6r3QhjPkQnrdpBxcmu6z3KswR2doYqJr6?=
 =?us-ascii?Q?KjDGQwq4Jy+iL/irXoQJ2VqiyWrUjk9/qsPasq8EY7smmwiBm+bodQBl0up2?=
 =?us-ascii?Q?cGTdgtIXPvCN/2FscKasGRPJZMQ9R1xpbzoUBqI4rX4ERH5XWnLpzRZO+v2r?=
 =?us-ascii?Q?tbuHUWAY72+816DaZEcN2FiNueIdmZ9TfVXVsv5fCn26JDA7E7fYGZr6pD32?=
 =?us-ascii?Q?u2/I0VIVNE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGacfOvve2b5xBDIwOw5luytPWvJjR5kNi8gmdOsfXuHTm3x8EWxor/Db3kL?=
 =?us-ascii?Q?8clwelOgCtA+vJNgNl5ANf6lVdnPFeMlJrKHmysWMj9UYOzm3crk5j85JjNu?=
 =?us-ascii?Q?qwH8olHfRVDjeTkW0UbTU390hPcaE/ggYFjuMH5K0B4nw6CtfwbYEtcl6Tsc?=
 =?us-ascii?Q?xRTAhlzjhh9awN6Kye4QrV3axSYkxHkFQtEhYrruOcTQRayPevWq65NiE94O?=
 =?us-ascii?Q?+f+0jMVDXlUC+cTGh5LGaf+j5SfMVjcj6YT5y98/qRHVfijb/OBrs04j9yz9?=
 =?us-ascii?Q?4RfkYVFScfyVqpj6kfxeC29T0JFypRIKlw6eZJlpI1NmAyCYC7xy5OYDg5Xx?=
 =?us-ascii?Q?HUBJKdc71rBLC0h3hGsa+eipTDCrHtAfcHERPZRFFuSn2i+tWdRTJJoHcgwY?=
 =?us-ascii?Q?BlnXw5q8XWUpBhnq0UAq9eUoA57+uK3kFZeM6FziWa+HLKLUYoTUmhGCTDyF?=
 =?us-ascii?Q?gjp80maM5Nnw2/s+hk3Klu616g/UebabJcsfwtEiU36uruxmM5G1acr4HFuk?=
 =?us-ascii?Q?W+v8JhiVG8m5GAnE9xnRsPf/S+9CCtPcwflUYHz6NRJW9ixKrPS4ewvxH8JG?=
 =?us-ascii?Q?eFbOLQfYnhjcQxDwMHw2g/L/Q3zw7rMx9hlbqwzK/1djqFdIltZ5wZnINOVB?=
 =?us-ascii?Q?5j9f1VuEcrV3lixOzDrOsBETuvJFoBFpBWK7VOrLiVP1mv1+O7q3VoMKsDlO?=
 =?us-ascii?Q?2ylIxvNUrVY6apRvwWtrIhW9mFeGUDTqarofebuS7clmy0e3UNK8J/IEjiwF?=
 =?us-ascii?Q?P/80AULQVt0c+I5QxCBdmVmwRCSxJiwJqWqebbEsK4b8w6RW/l+EgvU2nB9j?=
 =?us-ascii?Q?+xgPLbepFvovGanEYC6SdY6QfgpYQFghzVMGKUg1PP2A6daeHiKjT9Zb+f3t?=
 =?us-ascii?Q?ofmG0ZLsYNud0APZMldoAe0vWqB4xAZNNavDjKzm0aDAvXl6rFK8lwdwrmj0?=
 =?us-ascii?Q?85txSxSwHY93OdsBeAQJJQIhG9W0e+vlb30FaLTwqF+9QTRyrcuVEhHeen6G?=
 =?us-ascii?Q?6oYKEHtEHm5zy+JBZgesCrcp03CLZaCCc1gY9M77jdn9c3QQgxDLL3KIzKm2?=
 =?us-ascii?Q?LsSvSa63ahRT2dvANDLyRWtkh/NUd/lsx99WeCinNDJ7olXvFFajTsrBQdMG?=
 =?us-ascii?Q?0hnHNNwBpYFxjG21+T4upno0jnqlNjqK4af2BpGLZgmzc+5Fu9LkROwsewH9?=
 =?us-ascii?Q?V0eKuaedPp7/Y5/Wcp0TJK2Q2v8xKDM+cFJvLd4wsCKlNXfHYnSY2DFm5rMw?=
 =?us-ascii?Q?N7p1BZZQQnKcST/zBrcfY9hWCJ7+IQeCu10tehDU7GuQnpuukhYV30tENX0X?=
 =?us-ascii?Q?O4fT8dCzYYlYlEtODEGgK4GAUYZucSlkw4hKYt9kzp3fK2QSMmA+ZbThpntN?=
 =?us-ascii?Q?NE3KKJlA2TOsbQvVRj3AYUewMyyuWx9YBZ7tlwat6qYdhwa9gQQYqEso35QJ?=
 =?us-ascii?Q?anzQ6YWV+4FeSZwOn5LrFc/Nd5J0Oi+OhBJ7jNxycN/s2wGGyKZlgd2DqcuF?=
 =?us-ascii?Q?yFsspevyMeikU+AxOCbm/ZHdsQN5NQvMZeJYze/tUgVwmQfHfOKdmVq/ykKX?=
 =?us-ascii?Q?MPFM9sfMMWJMP5f8L86hGonzzfkqvjSebn7N9CyG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099b021a-c664-4838-8122-08ddc3a39a49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:19.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4vKVMqxjra7FKmT4+qYvkaKAJGsthNJ0U5QinClMJxJ/4PfwjvouglGzPZ285HogEiG8wAOl0bIuFxYDWXO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  21 +++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 149 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 5 files changed, 212 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b7ccd7dcb000..923373295660 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -146,6 +146,27 @@ struct page_pool;
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
 
+#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) + \
+	 (sizeof(struct mlx5_klm) * (sgl_len)))
+
+#define MLX5E_KLM_UMR_WQEBBS(klm_entries) \
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KLM_UMR_DS_CNT(klm_entries)\
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_DS))
+
+#define MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
+
+#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
+	ALIGN_DOWN(MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size), \
+		   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT)
+
+#define MLX5E_MAX_KLM_PER_WQE(mdev) \
+	MLX5E_KLM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * \
+				  mlx5e_get_max_sq_aligned_wqebbs(mdev))
+
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5aa5b5833c56..13a9c249cd92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -71,6 +71,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -290,10 +293,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -307,6 +310,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index ca9c3aaf941f..f5df4b41c3ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,146 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+		      struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT);
+	     i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
+		       struct mlx5e_umr_wqe *wqe, u16 ccid, int klm_entries,
+		       u32 klm_offset, u32 len, enum wqe_type klm_type)
+{
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->hdr.uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->hdr.ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->hdr.mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+	u32 ds_cnt;
+	u8 opc_mod;
+	u32 id;
+
+	ds_cnt =
+		MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries,
+					   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+
+	if (klm_type == BSF_KLM_UMR) {
+		id = mlx5e_tir_get_tirn(&queue->tir) <<
+			MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT;
+		opc_mod = MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	} else {
+		id = queue->ccid_table[ccid].klm_mkey;
+		opc_mod = MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
+	}
+
+	cseg->opmod_idx_opcode =
+		cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+			    MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN |
+					       MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size =
+			cpu_to_be32(ALIGN(len,
+					  MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords =
+		cpu_to_be16(ALIGN(klm_entries,
+				  MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe,
+				klm_length - klm_offset);
+	wqe_sz =
+		MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries,
+					   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->hdr.ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+			    enum wqe_type wqe_type, u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length,
+					   klm_offset);
+
+	/* not asking for completion on ddp_setup UMRs */
+	if (wqe_type == KLM_UMR)
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map,
+				  sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map,
+				sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +186,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f4c8c3f3c0d7..c89f0fc70617 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


