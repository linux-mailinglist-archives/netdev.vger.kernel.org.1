Return-Path: <netdev+bounces-207124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A408B05CDE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA116AA89
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5792E888D;
	Tue, 15 Jul 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sfx4ZIwr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A622E6D1C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586191; cv=fail; b=iEOQrawZk9JMcWdVzNg5ReJw81GIoxu+9VMfKJbXBx5AIf9das9HjoUKxjoPxELVXdhkDgBZZolRexe5U1ta16KLZSsP1R5L8J/uEzn7vfDTJ1Jw6NweB5MFB9oQOA3G5br5VdE9MHCIsbM/z5BmOAMShm5vhteM6EytZJQywhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586191; c=relaxed/simple;
	bh=CdEZB2XJ+f9v856+dKDx0glj/x0C4tHjZ/sH0pWF6zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldAEdJJDR6toNUSxYtw84aRxojLjBrjtsAjstWQLVYnirqAGNqH4TtKNpvc1GP3ki7bl6y10kSz4YedKm1dcsHnIgw1ddb/dDvRkikR9JztSwmaOADfIeBTGmPSRyJtq0CgptWIzXVL4FCjpRULFpOnm6hsi8333KuT8MyBpO8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sfx4ZIwr; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk+AzD5rgexNNAcjVu9jrDEat2YQowFwTJJGhxjZvCR0AJYgVpBhlvS5YRkweZihx4im8igIs2Zl4JJaykX3ef1/MmRcP4ONaOwWcZoJk8FTz0eRNtUxi9ufsv4f6XyrRJHRPxthpuNdFgPBJIqqHC1Dp5eQXlqOaQfXqu5fWPVf8yv8yfQ5QAx/0oOe/z/xxN/J2IK5q5z3ce4KrD9ssmjprP1wyzpfZ+1PmOiErF8YXHLUxv7nUxT+ImzIkVrlhAiOXU5Bi0KY5m0MV6VJ7899/kyQM+GQm/SBSluDQQJ4luX6160m+Zrz1YRe1Yx4hGxr7JUDsKA/bahEMl7ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BFdoWbkdfgGJ7P17bgw0LvQKUT7YY3UFBrk9A2D+lw=;
 b=Os+g+OJSsmtBhRPiofvkEOHnUCcp3eifcviocn+smfvnITWtYoGaAJLu9CbJGMzcqNjeVH5X8EwEtjB5AM7i6bL/HDa0Db+bzwY63YwJ7XzRDknNnTUgidx3l8aKs3A5cSMjr1MM4xErOPx4jyuD86YI5kF3NP/kbYlINzt6ASNki13q0FBXzoXtuxmlCjENDbpKKa2MrzDN0XiEZe6DIK4zeQfwj/gp8Ur3uGurhEyu9vF3Ry8sDIgfaQ9M9jcLjEy0k+EvltsLxZFsNxShpVLUYfvcVnFAi9P7P/PD17eHONFGNPRqbdGlY2i/9q/VNTxlEhm9+zMn7h48oneQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BFdoWbkdfgGJ7P17bgw0LvQKUT7YY3UFBrk9A2D+lw=;
 b=Sfx4ZIwrXM1ApufoB5JAukexqcGp4v9J+/ct+5hL9PX8J3rgUj4iu9mQCEUP1RsGiH2bFpo2xdCu2gt76KyHHW5zOuqiSUpYL+FLmgMD1+t4yj3keyfb/PvaHa5UwHJjeDxBywGUSJp0pdBJzQSXDJ6D9GJcGAAKHNDh97L8ASRX6rXubh8/f1xrPjICuNbNN3zqSZsdak28CxBkYdMtfB3s9Ea3PNbAXDeyN9sAefFsXPGkPj1M3io30IT8l+YKTuu+Pb3j5GKS6phPcKKwk1X7VV7eEYQ9RY7i2IWqr65UyRcpjb4k/gCqmWKLT4ucNf1gJVlyyrpq44qz8aJAVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:44 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:44 +0000
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
Subject: [PATCH v30 19/20] net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload
Date: Tue, 15 Jul 2025 13:27:48 +0000
Message-Id: <20250715132750.9619-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: b932c05a-96e9-4093-7949-08ddc3a3a972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fq2m7hNaarIx8qglQ7VoLOquC7CU8VOjyE9Nmj5Ky0H8nWGVIAyHyNASjryS?=
 =?us-ascii?Q?dWu9h+tCaVsXA4efQxcLzdNp6seuSgRwfAl47+mhohUw3nzh6ruc3HFBuRVf?=
 =?us-ascii?Q?t0mKxiJHiM2ZOVjrD1mTNMj3j78+RD8fTaVeW6WLxHjdcMWWyQfJkOzxSCY5?=
 =?us-ascii?Q?I8f7x7kL45eTA+mOAuhKgY7naPY+nvziM/TlHvYK2UZV9+fuJaL4o5/S/ujE?=
 =?us-ascii?Q?okFufHl9me0QMx8Hxl7zqoeKNCpKrVrEaMTIc0FBr1CUGRyyMnotVnWoeB4G?=
 =?us-ascii?Q?W0FvKfb+j5/wH4Mo37Qx0dNnQRPNMHl/JUdfQuORGiLktYFzboF+VKnX/toL?=
 =?us-ascii?Q?0qrSIGiJ0YtdI2rLyWY1iXKTdQr5S+bv837s9Qn/syqTUkghl2UYwI9f9VV0?=
 =?us-ascii?Q?sMMbbJNnnAhd/T5hRZk5bRKEDN3bv38uHFAWSe3hbC72vtjHp0clnjTkanq6?=
 =?us-ascii?Q?lEF+tTIVlnMgyUCrdWJWVYhuzfP9lOJQVeMh+mWqZaaSguexzoBCc4XENDr4?=
 =?us-ascii?Q?PCXMPf2CzYlV/28joegnfHjYLvWIcTuOLL1BUN4VQ8eaFc57TqI/V4rmee14?=
 =?us-ascii?Q?jhydyN4+gpDawwuutu2VpbuSM3eBL8LpT5XZyHID1OfhsbpFqh094ZH4hZ8G?=
 =?us-ascii?Q?+uKou/qwjIcdNTp3QVQ9yz/QKza+cQ2+j46TcySvgq8OnuynplTDYym6G0sV?=
 =?us-ascii?Q?aC/PsJUkOrEmPP23/DSAvTU0AjEKoqX5Ze/ARxi45JQItx+vBRtmBrkDlm3e?=
 =?us-ascii?Q?hFtQjf4/5DeyDisL89JNpPznj5awvyPEmSbWCpKM7YT3Gq64k55UcjXUSaMI?=
 =?us-ascii?Q?BqknXu+Fx+LtLuFAsu0GIunHQ1OsFayy4n5IEPanheINUumSCTPsapZ/IQXt?=
 =?us-ascii?Q?Ob5OspErlFiaPXHLsvHPJlw9CnYWwIX2a8mQGRqjyr4vxuj5AXRaotwozLVt?=
 =?us-ascii?Q?x7QSiLk3H2YE2oI3PuG9eYo+wEGCFZA4Zmjut7otU5HkdZO+7dZ/Fcbn4emk?=
 =?us-ascii?Q?b75mH44PK8i+jg+FvT4omN+Oqcfs4AId2YFvo6CbZIEv5EqzkNypa5KxAO5s?=
 =?us-ascii?Q?h3IRZzTaG9i9YvhooO3RBb0v/rxMZU3l6eDR3CljZUDLxaUBua2qG7ACiiy3?=
 =?us-ascii?Q?n3unrWGuv5AnbxwSkrmBvZusyWsuXDbDx/wPN6nfJ5UxV2XVo4UKhW2NG+DN?=
 =?us-ascii?Q?ha09znFlwlNlebCCoI3p8olxsEs8F7NiJroWh+tXPhgkYoTiX0Lwmrfjzuj0?=
 =?us-ascii?Q?QAXtfw7h46SVw3XV8CN+frQSat2Mi9oELC5LdHtgQUxymG5gxsp24sv9a64m?=
 =?us-ascii?Q?mNRSs2xXLtmnLFP7upqI9m7aPsj2gWbJ7kqui9fvr75vS28+DGm8Z+K0vhEX?=
 =?us-ascii?Q?LxNVbS4IleZXUajHDDp2Fpd9wtyG6RF9hd91EmObGfi0VwungAhVwKrnYpq5?=
 =?us-ascii?Q?gwtdIbdrXrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iimcg+oZlOqvw0lNfXohAmqa3yLSYONLWcNd765tmCSAXeM1ub+D15KfYJVq?=
 =?us-ascii?Q?0TFk4WtMsdTkndGVZNM8vFnzGj0AIc7vQHdDuSsPeHtvn/SgrCPzcLzHQVH9?=
 =?us-ascii?Q?EWdFrjDku5zwTECzG6cn286OvhV1wV6bLk7gwNE1xlZTMjtIcF3XsaHQDBNQ?=
 =?us-ascii?Q?M785fhtNRe6uCovUt/FP7/Ac1K27AkprFhvzzdbZ3+/RGtFijWF3y7tI5G5Z?=
 =?us-ascii?Q?CsteFnLmx7UkFLXD4K7nTHDN+/6mQsSYfbQ6CFDGGxBE2Q1v6kRj1El7w42x?=
 =?us-ascii?Q?XR6wMYyp+27mMJdJHZmQ37rIgNCxQvJEQw7nZm60pN1fCFpZPSuE5o4fPLa0?=
 =?us-ascii?Q?/S3JyVFd7rujvhkh8+kBZ8wGyW3pP/FGrIOXk/S3wzBbKrVAFS7j5wNO/8Hl?=
 =?us-ascii?Q?yIssNI6dJQVI6Wk06nssJxAQsc1PYdK0tAQXzT730qxvl7HSOVMXJdVJsXCB?=
 =?us-ascii?Q?F9Bf4QWtzQacWo2bczqSH/HdRGU6kCa3+mmGcXOL1/oDzMxOHR6ZhPkIs3u7?=
 =?us-ascii?Q?1c7/zRTD9spnkaPbCWW3rn0K3bTcsrRSKcbOSrdm4BZSv/UGTH2DfOkQn1Bz?=
 =?us-ascii?Q?YHSe5tLll/+FQIvG+XbDPyVWUV1oAk/fxj6N8yiCkuFa9QOK4vxzI2rRQ1bP?=
 =?us-ascii?Q?juaiYxx6gMwuBQgjwwssF2z/yE8EQfzGy3V+jLzDvNIanMoxQwppnT9YeKIA?=
 =?us-ascii?Q?dfln9n3w7f6s62XU4NB6MuRSihp0x8oo6f+wK6PcgHrq2rxdYm7R0EWVR814?=
 =?us-ascii?Q?JjpBs3tWcFcUZ2z+BbvyZLxP4yrfNdNkk5nM36QX7sehtTU5NIwd93KDFBGO?=
 =?us-ascii?Q?jLyTEjZpaF+Y7l7PA7Wq2ugmb7HCoWKVJx7EAZGN5clTZHRww8YtQeywPKLO?=
 =?us-ascii?Q?79HVjgEl/Xp4IFktOUH4JpbCi65Uhd6SWWAIjdf+7qilzMTy2yvBUFaKYrIc?=
 =?us-ascii?Q?bUXVqbhrpP+xW13IndE2Rt1tpMy/5lwkI+ChXBnzYMCkZ5fWHS52rhKGMoQr?=
 =?us-ascii?Q?d/Jp3AqVdEHE4J1L1SZJwjGoGla2CD/X8waLqZwAXKQ38IoUL21Xvsn7ZS3H?=
 =?us-ascii?Q?ZiO50IQAtvByIwtih/Z7mxbN5EqSbSJWFhQgp1HeJLJGY56deu5HIijLqpPS?=
 =?us-ascii?Q?XzLplB9QS9oU+z18hOoqJpGg+K9XkewvzTp1jxRkbqeZxEe3AQjS5WULFTkc?=
 =?us-ascii?Q?Vd1JGiTgA/Nzyq7rC+vKABl5jKdqXXxXmBEZ0mkUiO5/IIiI+JzxkHdAap7/?=
 =?us-ascii?Q?q1oka+K7nv6M/8w1Vr1ympJusldTFvlIfPhCPirXtfwRERDvzhE0Lr//Vzay?=
 =?us-ascii?Q?0LtNxzIrXO1VmK+CqwPE8liysUhyXf65RB9/neKH0iZ2hZB0tWc1xDyaMTA2?=
 =?us-ascii?Q?/ZZqYTzRrxxOhL4+M255LJv2yAlRrgT9JY1+kwkqv8gPjMNoTUKfdk09U1Bd?=
 =?us-ascii?Q?Vn+krQD4w5Wu25kkLAtRk6pPssTWGbdiwCW8q3aRGW99ij3txXDbV2MNCY44?=
 =?us-ascii?Q?mABaS2+/B2xdrxLFu6wAN/7oPZNJPSbKuoVU+muq8o7bGR/hl8AeaiCXeeev?=
 =?us-ascii?Q?tJ9KOm9Gpk9lVXX5MEcVnaOdIFfMMdXtrL+ZWqAp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b932c05a-96e9-4093-7949-08ddc3a3a972
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:44.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlz96FMWiJGKvq14jFKt+8EryTh/LByFB2Jeb+DaKA5OLwDPjR4cR3xY+/sCPr+WWEw+iMTqa3X/TlbtE21KQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Ben Ben-Ishay <benishay@nvidia.com>

This patch implements the data-path for direct data placement (DDP)
and DDGST offloads. NVMEoTCP DDP constructs an SKB from each CQE, while
pointing at NVME destination buffers. In turn, this enables the offload,
as the NVMe-TCP layer will skip the copy when src == dst.

Additionally, this patch adds support for DDGST (CRC32) offload.
HW will report DDGST offload only if it has not encountered an error
in the received packet. We pass this indication in skb->ulp_crc
up the stack to NVMe-TCP to skip computing the DDGST if all
corresponding SKBs were verified by HW.

This patch also handles context resynchronization requests made by
NIC HW. The resync request is passed to the NVMe-TCP layer
to be handled at a later point in time.

Finally, we also use the sk->sk_no_condense bit to avoid skb_condense.
This is critical as every SKB that uses DDP has a hole that fits
perfectly with skb_condense's policy, but filling this hole is
counter-productive as the data there already resides in its
destination buffer.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   6 +
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 357 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |  39 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  46 ++-
 5 files changed, 435 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 7e01096bdde0..c661d46cd520 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index ca32a68a22f7..53bb2b280228 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -596,4 +596,10 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
new file mode 100644
index 000000000000..c647f3615575
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/skbuff_ref.h>
+#include "en_accel/nvmeotcp_rxtx.h"
+#include <linux/mlx5/mlx5_ifc.h>
+#include "en/txrx.h"
+
+#define MLX5E_TC_FLOW_ID_MASK  0x00ffffff
+
+static struct mlx5e_frag_page *mlx5e_get_frag(struct mlx5e_rq *rq,
+					      struct mlx5_cqe64 *cqe)
+{
+	struct mlx5e_frag_page *fp;
+
+	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
+		u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+		u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
+		u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
+		u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+		struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
+		union mlx5e_alloc_units *au = &wi->alloc_units;
+
+		fp = &au->frag_pages[page_idx];
+	} else {
+		/* Legacy */
+		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
+		u16 ci = mlx5_wq_cyc_ctr2ix(wq, be16_to_cpu(cqe->wqe_counter));
+		struct mlx5e_wqe_frag_info *wi = get_frag(rq, ci);
+
+		fp = wi->frag_page;
+	}
+
+	return fp;
+}
+
+static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
+				   struct mlx5e_cqe128 *cqe128)
+{
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+	u32 seq;
+
+	seq = be32_to_cpu(cqe128->resync_tcp_sn);
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->resync_request)
+		ulp_ops->resync_request(queue->sk, seq, ULP_DDP_RESYNC_PENDING);
+}
+
+static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
+{
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+
+	nqe = &queue->ccid_table[queue->ccid];
+	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
+	queue->ccoff_inner = 0;
+	queue->ccsglidx++;
+}
+
+static void
+mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
+			    struct mlx5e_nvmeotcp_queue *queue,
+			    struct mlx5e_nvmeotcp_queue_entry *nqe, u32 fragsz)
+{
+	dma_sync_single_for_cpu(&netdev->dev,
+				nqe->sgl[queue->ccsglidx].offset +
+				queue->ccoff_inner,
+				fragsz, DMA_FROM_DEVICE);
+
+	page_ref_inc(compound_head(sg_page(&nqe->sgl[queue->ccsglidx])));
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			sg_page(&nqe->sgl[queue->ccsglidx]),
+			nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+			fragsz,
+			fragsz);
+}
+
+static void
+mlx5_nvmeotcp_add_tail_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+				 int org_nr_frags, int frag_index)
+{
+	while (org_nr_frags != frag_index) {
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(&org_frags[frag_index]),
+				skb_frag_off(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]));
+		frag_index++;
+	}
+}
+
+static void
+mlx5_nvmeotcp_add_tail(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+		       struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
+		       int offset, int len)
+{
+	struct mlx5e_frag_page *frag_page = mlx5e_get_frag(rq, cqe);
+
+	frag_page->frags++;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			virt_to_page(skb->data), offset, len, len);
+}
+
+static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb,
+					 skb_frag_t *org_frags,
+					 int *frag_index, int remaining)
+{
+	unsigned int frag_size;
+	int nr_frags;
+
+	/* skip @remaining bytes in frags */
+	*frag_index = 0;
+	while (remaining) {
+		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[*frag_index]);
+		if (frag_size > remaining) {
+			skb_frag_off_add(&skb_shinfo(skb)->frags[*frag_index],
+					 remaining);
+			skb_frag_size_sub(&skb_shinfo(skb)->frags[*frag_index],
+					  remaining);
+			remaining = 0;
+		} else {
+			remaining -= frag_size;
+			skb_frag_unref(skb, *frag_index);
+			*frag_index += 1;
+		}
+	}
+
+	/* save original frags for the tail and unref */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	memcpy(&org_frags[*frag_index], &skb_shinfo(skb)->frags[*frag_index],
+	       (nr_frags - *frag_index) * sizeof(skb_frag_t));
+
+	/* remove frags from skb */
+	skb_shinfo(skb)->nr_frags = 0;
+	skb->len -= skb->data_len;
+	skb->truesize -= skb->data_len;
+	skb->data_len = 0;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
+					struct sk_buff *skb,
+					struct mlx5_cqe64 *cqe,
+					u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	skb_frag_t org_frags[MAX_SKB_FRAGS];
+	struct mlx5e_nvmeotcp_queue *queue;
+	int org_nr_frags, frag_index;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) &&
+	    cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	org_nr_frags = skb_shinfo(skb)->nr_frags;
+	mlx5_nvmeotcp_trim_nonlinear(skb, org_frags, &frag_index, cclen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail_nonlinear(skb, org_frags,
+						 org_nr_frags,
+						 frag_index);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) &&
+	    cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	skb_trim(skb, hlen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length -
+			queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail(rq, cqe, queue, skb,
+				       offset_in_page(skb->data) +
+				       hlen + cclen, remaining);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	if (skb->data_len)
+		return mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(rq, skb, cqe,
+							       cqe_bcnt);
+	else
+		return mlx5e_nvmeotcp_rebuild_rx_skb_linear(rq, skb, cqe,
+							    cqe_bcnt);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
new file mode 100644
index 000000000000..5f208cc10bfa
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_RXTX_H__
+#define __MLX5E_NVMEOTCP_RXTX_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <linux/skbuff.h>
+#include "en_accel/nvmeotcp.h"
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe,
+					    u32 cqe_bcnt)
+{
+	struct mlx5e_cqe128 *cqe128;
+
+	if (!cqe_is_nvmeotcp_zc(cqe))
+		return cqe_bcnt;
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	return be16_to_cpu(cqe128->hlen);
+}
+
+#else
+
+static inline bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return true; }
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe,
+					    u32 cqe_bcnt)
+{ return cqe_bcnt; }
+
+#endif /* CONFIG_MLX5_EN_NVMEOTCP */
+#endif /* __MLX5E_NVMEOTCP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 51b24b0525af..683d0c2b7b16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -53,7 +53,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
-#include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_rxtx.h"
 #include "en/xdp.h"
 #include "en/xsk/rx.h"
 #include "en/health.h"
@@ -336,10 +336,6 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 		mlx5e_page_release_fragmented(rq->page_pool, frag->frag_page);
 }
 
-static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
-{
-	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
-}
 
 static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 			      u16 ix)
@@ -1567,7 +1563,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1578,6 +1574,14 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	skb->mac_len = ETH_HLEN;
 
+	if (IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && cqe_is_nvmeotcp(cqe)) {
+		bool ret = mlx5e_nvmeotcp_rebuild_rx_skb(rq, skb, cqe,
+							 cqe_bcnt);
+
+		if (unlikely(!ret))
+			return ret;
+	}
+
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
@@ -1624,6 +1628,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return true;
 }
 
 static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
@@ -1645,7 +1651,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1654,7 +1660,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1871,7 +1877,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1918,7 +1925,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1967,7 +1975,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2007,13 +2016,19 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	} while (data_bcnt);
 }
 
+static u16 mlx5e_get_headlen_hint(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	return min_t(u32, MLX5E_RX_MAX_HEAD,
+		     mlx5_nvmeotcp_get_headlen(cqe, cqe_bcnt));
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
+	u16 headlen = mlx5e_get_headlen_hint(cqe, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 frag_offset    = head_offset;
@@ -2462,7 +2477,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2795,7 +2811,9 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
+
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.34.1


