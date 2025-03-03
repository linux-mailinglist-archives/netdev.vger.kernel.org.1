Return-Path: <netdev+bounces-171155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FDA4BB4E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574581894D86
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63F1F1531;
	Mon,  3 Mar 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bxb/j3pr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CB1F2B83
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995655; cv=fail; b=nMQd0G7dhmnSGp/y4grtYxbTKds4GcTMUUVFeuSLVGaZil5Ovz0CpvqFZ0c8M86MlgJ4AY+HDNgQNQD9U2g7v3t/uHRT3jIxtoIQI733/ZGdPHJZS8bgO9387CEnaoFzKzfxmDwJUhZRGv4n0s9CvpHxyhOvphswZfnwZeX8Qgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995655; c=relaxed/simple;
	bh=ktaw1htSZ9wJt5CfcgkmyO7HGMRkE45TkuR0kGv985Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pk6zwoDnf7ubTwIAqDjLkQz6Zwz/9lydP3IIQT8lo7qY8V2GwdsSNjSs38AaQWTUVPNGFLiA8wOAgaODn0EHsQSeQ7o7MV7ZJegldegMquE8+9Vd+Nxgu4/pH8uAPbppd0D9aBLNbbEWmiE0sxhEjwg8Fole9a3IsFNqHgj1JXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bxb/j3pr; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3mKRhen9zDkhlp8rDdrkS2aER9TfcepgLoEVzgLfZisQqleZYobKx0MOPjjUlaC5SbmxcXovUSPQTXizMzWe558/Wsx6YmA7GsAuPomWUrViBwmoPlkDIgLCRCsAUP5QV4ugLfoDbv1fTR2wYMYHbfcscvwNtGamZQIkQZS6QY4sj/lvvkxAX/cp8y9EzaH/Rjyc8c0xGjC5Go1HoPrCWy3GWjiUnloLHbT4emqoDExNgLX3Z8rT+22AE83KSP7zo4a2c8nf0j99R85tDX52lE6/Fn+F8cXl7k+pX8wpi4euMZQqEHPcpzSOQvhNy7IHl5dLWpl25nDIVMxe9pBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWsA/urTyd1064o+wp7N/kBCgk6oBc/ikBXe0D5SpcM=;
 b=Kgtv5VHQvkLOMEpX8eWW7NNb2Eg0M6KB3VoRYSDFN82Lc2Wqbtgwn4kGXvxpKnay5elP4qYmPcMm/O4o3yh0CEkPMCIiLmJAN9M6NAI1sFQxkberCSm5dv+bw0abvwGqVW+i0P9mX4eOkXaZa7bKohQPohFyVfBOe1cO5+1f34yuWasP3byNjCFKEum9W/JVdludDTPcktN/KwRcJvmPB3YqgYNhHcwKgbzoHS5Sa55Ase02n8z3tVWnUsEOtlSCT+KJLnKLcDv7PsgEtlOs7Z2ZKzcw+BaC5M8rDTMvGaDdkVFRwIyDdwHcpvLvB03IW75a1DxvcDA2pJ+LfB2iWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWsA/urTyd1064o+wp7N/kBCgk6oBc/ikBXe0D5SpcM=;
 b=Bxb/j3pr5Eui34BfjUhFaF+wU+NcYbGhnNJ2iLBQXhUq01sBM9suRk15aY15CwZXqnJs1euOJP/+i8e/FXRZMyhY3lj0S5YVRLIklbT7U9skI3X5mCpfYVWlJ4ll6v/ZkPan16zleqVP2Ix+Mg2q7F1ajcXF7tApxJ19Uk5PNPrU0qltk6vT2e2h5MMqlXXfolj/0EHFF/LriVkFPGww9hQCpKdXbkcdPGKQk67wHYpljJ46qZIG6eVWLc7Nf6dC/LCi5its5ER8iEj0CIFU+Rm74+sgB82o+MxmJVrjx1JNHfg7Rc7rWi9H+kRdP3RRlySZkoMKSFDRr1fPpM7ZNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:11 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:11 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Mon,  3 Mar 2025 09:52:55 +0000
Message-Id: <20250303095304.1534-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::7) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c7f043-2828-4917-f858-08dd5a39595a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s7N+y0J+d5dInCwUP2LUdkTPr3HRConeplLNf1g+7yvT3A73m5VuGVKGDydA?=
 =?us-ascii?Q?nSlA44r6gvRH35iD6lo9vJjukbIPeHenNhUlkZdIM47S/g4tw7WLFCJMNsdY?=
 =?us-ascii?Q?/MOObE1vSXjnBqm5M5NFXEqwm0AcL4ItQw2V1Gn0us+08iLMKXPiVB6GQ3eg?=
 =?us-ascii?Q?t8clmchFVECBFmQpeRtIaUSxEIQ7naLz4UYM0u/jwifpoQb54SYXsq4/yHvJ?=
 =?us-ascii?Q?srYlrqflfjBRiRYdSr9zT923hXxiVt34DoHwUV/reII7shNM3PjbCyoA2GiH?=
 =?us-ascii?Q?5Cov/eOc71hy1zup7p6eRFUJJqiYoDtBlxaGbB1laY/i1LToyq1Bu1h8kH+b?=
 =?us-ascii?Q?oWtLmRPsY6BVdz6IM8Q+2vLCjrzVtWhsWIrk2hgyN8mSERNHyQ9EQH9p5ojJ?=
 =?us-ascii?Q?8ivll3ttEHfBcfXnSbYhpeY3CFZmNLcfkRR0V115tM5lUPwP4/QugvBQPpoC?=
 =?us-ascii?Q?0t0r9/IHNPRHKmJBci4ee63LFOw6cAql3Fmxoe62HoFjmfFa8/3SaQVsq2tj?=
 =?us-ascii?Q?29kyq4kksS85LbEdQtQJX7JtvLpSRTTQjn1IZMi7XICPwNgniJWzGbbCfy5Z?=
 =?us-ascii?Q?xUQ79dmAltD5BE6dXTlXon0GbbN1ESSDxnx09i34hAIvzT2UfiFMn/RYAHEC?=
 =?us-ascii?Q?4VL1bPq2GOeBBPXL0H6D+R1msxwYQXcsEC8ThyfxUZ677Cfz7NYNTCYhCEmp?=
 =?us-ascii?Q?2XWxbqC6u7rB/ZwGu844lJY1ObLVuK0+l3lQv5XlLzIFNoym2lWEv7VHN73x?=
 =?us-ascii?Q?eMCyLywIDkvcVGUgTrfRaauflhqwVMw/MZ9beqjqKxLDOjwdeTHAuaiwjIZ3?=
 =?us-ascii?Q?+hft7bKRTPBAIaksCiiNezae2MfbMQ4RjF0xAtdffQwQMs94NMyEQs0MnyZ2?=
 =?us-ascii?Q?vGpDAL9bZG3Lha9r9seeb/KPBUed62LLwuwij5m7SaHjJ9fbRRmWexshJZHd?=
 =?us-ascii?Q?P0er9IVXLSN3a0QzhPHxbzOgK+zmz0rJ0CaQDae//HZjH0z1xFzYrBsJiP/7?=
 =?us-ascii?Q?EyW/bPWeOQHW2uvRrbVLfiMM/hLAk7p3lSxUazOwh/XLpx3xyonzM3x9rxzd?=
 =?us-ascii?Q?KOYZ/qIEvP39rjmR/AMEYRrHKECZ1fOJ8gWvBrXL/Nt/8tmVc8PQTgBluDOT?=
 =?us-ascii?Q?ZnicfDt47g30pwx7iP/Mcc57iw9aG3bR2i/c1gOfGtV6BOFieLSCEVEmrkuY?=
 =?us-ascii?Q?nuQu6+hAZRBeAiuFKVBIqpBlxVuDNXdCmYxJ2rEYJiSY6NFpbbvjTzyiQLzw?=
 =?us-ascii?Q?65v9kua583j2U1CDnvXn5mZXj2O9jJWVoHmENf7/UV7s71YCAbCa2E6SahJn?=
 =?us-ascii?Q?z1dz1FdFnMkzXp8shL9ypCRp244EaLrZkkIv/uWlIUrOvXUTcd2YZW3FdzAg?=
 =?us-ascii?Q?VJ0t891pF8DzqtczGeVOjKkuFsW7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmt1Mxn0q7CN+bPeYDXFiJCOfABGYMkvXfw7P3LG5jkS2hDMGPMG0RuspY/l?=
 =?us-ascii?Q?4++hczzNuVoTxES+hHvUJwmzRKPUjraQXOhGzVu3U9Ay5qHyZ1lTdhyswt2K?=
 =?us-ascii?Q?YXc+zOg+bx/B5y/5tiruulsFd3W+8kjQnsAZ2kNuW8lyekgPm7ZDV/c+wmMr?=
 =?us-ascii?Q?dGI0vop4HZ1o3OYne7lqaWIkSYRdZDR6hFs3bpp7plBnh51m+mMEphoJAabZ?=
 =?us-ascii?Q?4c58FChqiAAQYu0dzToKYQbJViMg3PmVf+yfKKsb/Lpp27518NQPaBdshVKa?=
 =?us-ascii?Q?I8qpatpr1hxVMersI9A6Ar6rfbHv3ovqsKpqfDZ98NxMRutrp3+zJNNNf08X?=
 =?us-ascii?Q?Vzcof/fDoBniVOBaoaUgWK8NmsYPP7/hXaUB+1GjTGRqVMsZ4a/AVnHjEe8M?=
 =?us-ascii?Q?biCdtzhTHrf8ae8d+b+t7Ai1grBqyKHk4EO7BPZGQ3lwjj64rmh8w+Cyh5Tg?=
 =?us-ascii?Q?8xc2aCuJScx6sGgI91mWv7k+E8dxlF+mK9gL6NA+7A2pgAkUSDckWjJAXVqb?=
 =?us-ascii?Q?6qdsemNbcuen2jlnXtav5xc/ROVmUqlnIRsuOQHEylG6VAQYPbRxSZnDDTSk?=
 =?us-ascii?Q?drxUzPHg3OI+fZvSoOqcrLj9OikrGVlQ+7627ZVlLi33SS4juy3zs5lebnlB?=
 =?us-ascii?Q?e029hk4DvAVw4b8xGG/XbBAfgj0jgIS1NV10cYBwi0wf58QAjb+qA281tK2l?=
 =?us-ascii?Q?CerR4zdjp4wrRDpQdteYCu47CKziOwPfOCwJ5r23vleS/r+xALTkS1IDq1v1?=
 =?us-ascii?Q?2apD9kIZJGQS9GXuP2JiCERo+/cvltr6CFFkxQnbHvOqAt+wfM++X0jWWuMy?=
 =?us-ascii?Q?J6Roed8OAdif1yWMVLnbXXJ2J7bGbl89omMAw21uFxwHdD8vd0BR5TgWMMg9?=
 =?us-ascii?Q?h1P1j2HIhXwDg2wXQQCS03YlFaJ8NPR46wsPVzkoNvbjDVXTGCHjGPVm2PQS?=
 =?us-ascii?Q?EkC8I3Tc8RcWQg+/LqpRTM+eHOrcYo9ucscUn5FQUh91MBtX0W0uA8xPtXpc?=
 =?us-ascii?Q?XHYHRCaKTi7lffkW6TD/NJ81TSAbuNKgsAg3NDkOK5yfA1nMRQpD3ufeD8k4?=
 =?us-ascii?Q?Isu1fIY1fyuurMCyhHfZo1z+3Ihl5EQzHnA1mLihI4/P3v9Sy+cmGPzuiHxV?=
 =?us-ascii?Q?nbfIa3KGch955bWJBqmk3ep2Kr/kIDeckOrE0Laf7DvAy8Uri/m2DFfvLq8T?=
 =?us-ascii?Q?EYaKscXwqcEPl7qxwLL+sQhAhCwDHDRqSquKkri5XJuoJCx4yGiNTRjlFJP+?=
 =?us-ascii?Q?YQV798svoRuKxneOsqII6JRzYQddpE/Dr2YrDP/ceNNMFxJSLHj3nil3EOw8?=
 =?us-ascii?Q?v/a80PZAhUGnMQk9AzEs0fh+TK0Jt/knYW3/1zYmxj5nmhKANOgRZ7pvtL+C?=
 =?us-ascii?Q?+oPERKAzRYelPGcw0j0NR3fvesSOZ9Hb7wuoS+LmuLGDHB/9ngLkqjlubcG8?=
 =?us-ascii?Q?YGxL0wA7KaLXqDpTA0tFfZ/0SzYcKjOk37DPxiC9s+JhFoAO4AggNhk+iyT+?=
 =?us-ascii?Q?f7PrIMCKl0csb7ItLrzkn9HQbhTSrITKW4lUDHSPQ02ZYkJajTWXGyxoxNSX?=
 =?us-ascii?Q?UtjNj2K51/uXN+FM+sFbAtoLxgUT9F248TN9Mv4h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c7f043-2828-4917-f858-08dd5a39595a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:11.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCTFD6tVOZYBrnOopgWzzypG62N4qlNGIVb0WHq4xSoZK5ckFUCsz5hR2p6qMI6YgtoyOSATp3Q/8LiT+/XJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionally, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 769e683f2488..999c8ee8c1c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -539,6 +539,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..89807aaa870d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5ec468268d1a..e710053f41fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -83,7 +83,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5d5e7b19c396..229e5efa5a73 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1537,6 +1537,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1995,11 +1996,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1963bc5adb18..6512ab90b800 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -988,7 +988,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1063,7 +1063,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..af0ae65cb87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -179,8 +179,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


