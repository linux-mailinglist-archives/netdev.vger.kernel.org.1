Return-Path: <netdev+bounces-202468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61913AEE02A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B69C16A40F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F828BAB3;
	Mon, 30 Jun 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAVH5DIy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F28C00D
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292567; cv=fail; b=nS3GeqVL+DsEH7DFe3m62bYSG/Q6Zb0Kw0KB0BRNsfFH9bXCtInOC0zfJE15rDsBSRBxqdje3WuAHY+ZMVPq1IaDCQ5jza4BQVAEym/qTyh0Zu3x5rccmPQm5vS++9TY3DNT51kbw6pfOrgg7hgzG75gZkK4yAw+XnYFF+Lj2gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292567; c=relaxed/simple;
	bh=Os44/D96MGVztgd3DgeKIREsTuYYWFaENtaSEUVU90o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQBCswhMKM3q0TDCa4j4fHfblC1CWnUSAoOgSoCCFUIpRRUKb0UWDIKgBWARVkyMeB/893WBOUuGhaOooalWEmJlGQq6R5iufZergtCfsm3lj9igGJtAbWrCcYV6VG/6hVVQKuuPA2nGqiqfNOr2TN8/Qhftkn+ImhDdTQiyuA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAVH5DIy; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJqlRLf2NrxK9SLxbyeNKx/XffTcfaFd73a7GmSGGQ2ogw9xINGmAEGTfVkUEDij5IT9K7sk1i5O1kGaqxB8xF2IK7+VzZZN3A2m5DCrfqfMu7wksRl6OiK1Mh7RimNva2wyrEbabYEENL+rm6uz6kSikHJpFiptDqlH3Fn72OFjJCQ7MmzRX4tYpIJVWQlGGarrDefsrwaVzWw1gkhu6rBsAxd7h2Rj+ggk4SgLeU6yXKV5wYrsv4O40IiBtUmcT8bHzDjrjJsI42N9/RbkhmKZtIAGWBX4Cyln/nC5vjjVllHNgoe24QksBBEs/ZXbHI5iFlnHpJCN8YX5ZYHznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAlD2sZ6C8BdOfzbP5PvW3LufHAihq2z3luHdSSCgT0=;
 b=AoUXZs1s2mfhi2XnHAymXait4m64S0Cx1Rhhj3oWuLli/MlvlCk2fKeuQhznin201dd88I1KdhDI6GPqGVqeCjPkg9HxYR5Si8QEqDWEEP7h8LKtBe1fA52RO5dPRaOUn8eqQxmm36lL8zEuUotzABt5PLNLcr47uGcFJYNa5PPNkCpZaly8Nz7HXTDByAI0/MWhvc4XQTfE1ZDfW7wQ3dtvyXHVfgEsdHWhBoOVjn5wq6ZVZTsDopCMCYMwQN/4maPEV5uvEXWKWXsSNBnT8fejBWlBxCsG3q8uVGfKVcutLSdB1y61U+F9YYe7CNna3TE5Cbk/qxDqvwwW24HIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAlD2sZ6C8BdOfzbP5PvW3LufHAihq2z3luHdSSCgT0=;
 b=sAVH5DIygKNh5jZ/BYdU3cK6aKOYI+t+HbYPd4A0s07lyyLmSOg2klE4CTBe7en1hlGhGetu2f5qCComFxDMu1Wwa0h0DejYZPWqJmlces1xXJYiWv70b8JsqSxW18Na6WmijjD2GD6FN0jrsEb6OFlkID3wC3UFf04CcPC5FfBlR9Yup1m7JW8bU2Ei6CQa/mZ+DXYh8sG2k8yX6k4IJ0yF74tQT2DXs1vU0TxNDy9VONeEXYAO83UoD8vzLLnlFkLrCULMxUrJQtUmfuVKfjdSM2kuIzgnzuQ1xboAeOA7UNIuqVjd3FCrH7YGeouehNmd76ksrfldu3Qu2c+tGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 14:09:15 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:09:15 +0000
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
Subject: [PATCH v29 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Mon, 30 Jun 2025 14:07:35 +0000
Message-Id: <20250630140737.28662-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2297b9-1d2b-4f3e-047d-08ddb7dfb244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EevdO7NGr2csVQVcjtdB77DtvBRwk5M2f42ySNYwxetp9PdRlSOEU/telKQN?=
 =?us-ascii?Q?xFFC4Ii0Je2qFPnNU3NhVTHBTPgrxao1YiigwUfJsYX1AH6lI47zu8hNp5X+?=
 =?us-ascii?Q?ciinrusvbU5wroFRQb/4nNDt2u07vsjN8SyuTsbwhJhEdXnL8qIh44Aev7ZN?=
 =?us-ascii?Q?gkC6/n52RCUZSFoDR8lWCvXLyCydDodXE3wlW7xybPcLp8eacJDYxwnvq14S?=
 =?us-ascii?Q?DV/qvUSkVw2YIKFFl+JJiOxPVDjI51VWtfLwm5kBxOhSL3SnoHaF7o3IQn4z?=
 =?us-ascii?Q?499jeDqMAEAiJEr2D9E9Or2CyeJxW8cXUReSm7hDhotYGxktSfI3J2AjMFKJ?=
 =?us-ascii?Q?Ej3uT+e21h0vRir8DerIWn/PJbmscZMMnAYPpI10HtnxojBk7BmW9ke+T885?=
 =?us-ascii?Q?5KXBmnr7/Sc2NljSHmxK4Jygg8dInPSQB61ZDjrUbbOKHv4b+kzgJZrCPXlz?=
 =?us-ascii?Q?1ldb8k7pFadxQny0XTxe/3xnY9l01N1rEGm0e0VoVqYcWv8HgrmMSejsT2tA?=
 =?us-ascii?Q?mERszAKDMzEzLtx0/fmMpKte+0R6UTRpyivAHNtGmpLbX+OgQNfyBFQ+vAmg?=
 =?us-ascii?Q?Fx9ClwXA/K+ikhWO0VtcEQGtbl6EditoCvUSeTcBpzy6JxmtL/8cMMHc5zsE?=
 =?us-ascii?Q?prqsKk8Fm3nv3Emg3M2Dp1VoxZme7QuXZyTXomaYr1Rvl/bf4swNGAI7LvO8?=
 =?us-ascii?Q?4HBWY0kZ/LOnXt21guHJe7ey6DZ9pnX2qhRGyOo+v5TbQC7kspgE6eMw1tq1?=
 =?us-ascii?Q?I9qgmxzEPSQ9C/cbaFbX0CQ5gF2iPXzSlepY6aeH3dZQfFuUbZkmkAHcLVLy?=
 =?us-ascii?Q?0kwjMoiPJ5lUosXpqi710EZobb2G/hCXSNynVgipjGwHQvdbBaO0OmDJsDQP?=
 =?us-ascii?Q?MWiQ8L6X+uks3k80Y6RIi40/PHiwG8poUZmUxIaB31fUlxktdlJ5t2rGHXiW?=
 =?us-ascii?Q?10HUrNbl582PyROCv+iSbMHpDsCitDaRBkGWLzwQavEGMFQr5jf8mzxbAByY?=
 =?us-ascii?Q?9kYiiThad+ZWnFWcLt4AUdVVmntfNhG7Vh/W5tUPrEZMKRimSSFwikmNEeYW?=
 =?us-ascii?Q?vUSr1V/t0IDrpQgvEIt8PuuWjITEWqx7SKixX52jHgXxlSoZsIr+NRE7r75E?=
 =?us-ascii?Q?v5LjGCiO9CbyZATVvDCFvuxD8zbvBoGsyvv4IiTqtb0pKmoUn9Dwv+oSuzRt?=
 =?us-ascii?Q?qqAMKJU83g9WfocHWJ9mXVyxZKeRbNPRVoUVjycM9p0kMNtthZYqkXK+KqZA?=
 =?us-ascii?Q?k3abyPHv87d5re+RkGrAbqJs0fa7byn2hEqTpzKhDvQ9vuvCIDd1OIP6ZE3n?=
 =?us-ascii?Q?T/BUd9FZ8LBXd0+JAN9HeFL3GDpCD2y/kUrOIndYFYbDlSraXLnGn6cLrDJf?=
 =?us-ascii?Q?gENWRu8k/erjtNRAU9TqDmxeGqobJFP4cN62TMZeoIUWJsJRVCSLVSk+Ndcv?=
 =?us-ascii?Q?UopJDETKRhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBX3ksQoYkWLgprXuntp7TXQfyuSLjUFJb46BFSmQsklq2zP8SCDRN/J4hmo?=
 =?us-ascii?Q?AU4WSlb3Zi4UXb1Zw8mLKiZhJi7YW2c8H52ygdsX+sYsl6k7Yg3esqprwZaP?=
 =?us-ascii?Q?bT7xod06+OC+YN+YVYtz2YTf/kKy4jTVc28K4ZWSCsSq1l6OJ39Qh7AzfpUb?=
 =?us-ascii?Q?t80fx7x4qe+EHziN2E4tUbPBdI/KRH0JxlRHf2OOekArgg2JbBXTJ1+Ga4cV?=
 =?us-ascii?Q?a4rgSkx8QgnivclDs8++d4BrchmSd5SWc5tmrPItka0G0FAVq7B7yfslMgKn?=
 =?us-ascii?Q?ZAZIfbwDhazmSsdzbrQ6+h1nl1ei1NMS8aDIxYXt8EHHjK7WL4BlgZ/JA9Oo?=
 =?us-ascii?Q?d4djy4W4aPiJ7Qm0K4MJMd5YqD9sRMwP69x/yD4YEQAZ/PjNmf8ptL38KR6G?=
 =?us-ascii?Q?NczNdwE5nKhFGKF1jARUmMapwACKnbGk6EeiWxsDFQuqxIGaA+PJF0hXPHBh?=
 =?us-ascii?Q?kzbLX3RGF2P5Sm72hL9ghOs3EhM3UwE17skZTvUPGKFgqoYLzAB3Pjg2LjPq?=
 =?us-ascii?Q?eoXNz76HwZUD5jXoKlp616EnP84WanNQjGwqP/II7J+d5JiyYpyxj4l29jfp?=
 =?us-ascii?Q?ekIfZKdxFeGc4mgIV9WiIaamhUJV+gBqFOYDTTr8qF0kNv5sCMWAMgI96GoN?=
 =?us-ascii?Q?E1grYTKV1dV8pq7C36LBjq4OkTaCBUeOL8OHuNOcp4q9kb2XTQQ8OCRdpAwG?=
 =?us-ascii?Q?J7cwzqkrgyjIX1vm4016vNj0GHC+bvWqpCGhNra41anHF2MrBWXDDtzeEjQo?=
 =?us-ascii?Q?jowKdWMjwtzSowjNLvjUIZ6B59XpRcNKFymgtFloNUMnhFB3jse6nmHzebJ+?=
 =?us-ascii?Q?gv/ZCVJgt0TIuPYdTk7QhqNkllRygSU4P6U+QgKA1MmzPIfhjXrO8cNXSpf5?=
 =?us-ascii?Q?dkrPXNRn2gq/YsybQzqdxlNBrIu1CVrMNhcZcKNcD3w6DdIflRURuEqioi0u?=
 =?us-ascii?Q?5XVEoShn5Ho9jngOIsLhrG4mmhDAEw4eEtrapQL5H55md2PDu04L884FEFfC?=
 =?us-ascii?Q?ClghdHCIuNNav1NpzgomRe2p/dTuz6wMnhXKIY2G5DLwSmHJu9xlojvltP9l?=
 =?us-ascii?Q?lgwvMCREFpmE95Qmx0EMrvo2vpAalA25l+7EYD1szxd/lj4cQpgWhhIJan3k?=
 =?us-ascii?Q?r42J29AaJ++K1l/BNSvR66eJwJaQTi6zHzSZ/dttPm95dJoBdAiAx3EABnBg?=
 =?us-ascii?Q?qdE+BivpLyYDGQiWymi31G7v7s+DiTyJSadKsiN+LfuFHMQsM6c1Q/oD4wRg?=
 =?us-ascii?Q?ArFJNh/7LPWfMKgFxTAWnYWjS+LMHcNRggOx/m/rJ2/fKw3FhTIixotXl9/7?=
 =?us-ascii?Q?lxK/bLPt6+JyLiDxQskJljbk2+0OzaMsBn0Rve351RKjJ8kZ/n5ZCotSyky8?=
 =?us-ascii?Q?ZyiOXJtFkENHvbGgvKa1a/vAkT16bM2NIXjrtwoOPGWuS6QKDSqBYLFzN17g?=
 =?us-ascii?Q?pkvjEZBVTkAIdBHvpCXPXoHFDlNdjtcUJPzKflZqtBbxnUcd3os6TBdyy/wM?=
 =?us-ascii?Q?8JaA7ILo6PrDYoAoLCJvXcj2jTHNUGYGtFEjCk/Nw4hb9EnwkjYOeMAFvZiC?=
 =?us-ascii?Q?+IcKdIe/5rVTbioZaYoUpF6JTOh11fKcA/Qnjj6e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2297b9-1d2b-4f3e-047d-08ddb7dfb244
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:09:15.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qEn29TVgYFqpkJkjAySl01KxETCVcVn7+CFaSjAuF+9Yl3sjs4q7S3SOnHe0LuLYTkjvnLt/Ik18gdU2GJx2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 58 +++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 61e9a8539983..ca32a68a22f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -73,6 +73,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -264,6 +265,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 48dd242af2bb..639a9187d88c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -173,6 +173,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN |
@@ -285,8 +292,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -298,6 +305,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon
 		 * completion, such as ddp setup
@@ -319,7 +330,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -337,7 +348,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -363,7 +374,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -378,7 +389,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -905,12 +919,44 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     ddp->nents, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
+			     ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 4850c19e18c7..67805adc6fdf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -113,6 +113,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3823844b08c0..51b24b0525af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -963,6 +963,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1


