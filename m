Return-Path: <netdev+bounces-186982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19448AA462D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B5F9C4745
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A467821E0AA;
	Wed, 30 Apr 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmdzHiqt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7C2222B9
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003549; cv=fail; b=gj6nb5vc/IcTM+OMZ2HWji+OSKy/pO4O4/eodqx0jvuVP2LNhvZyYxgz26IWimhWCsTcomPzbmWRLJGxD3B+PCnTnh/CRwnryb0oAx/FFZa1ZwaJveAiQJKuVzQd4j2YMI5c80NHq4ckVR81sCcbpmrj9Bve+YgOb9wk1kX3kO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003549; c=relaxed/simple;
	bh=/zKYJ0WtatC7bAZ3xizOE5hcM2q7FyQnDlX9KSMvAmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bx8UDeDqZmsmXpSuC8I+jGq11PM13EJfxKoIoHJ0r6EmH9/qK5LS5BTTeCT7QiTgevglm54ZISTwfbEwWJpFaPxiE40jkDQLY4rZd8IOUjuiy8hE73ZS+e2De3syzPNHfqwkyZZtX6eEsCxcduSkYSglcOWTA2cKOaVGD9ZpEIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmdzHiqt; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6q8NQLXZAEp+95TRq6Rv98NnkzkQQ7w3zfSBzMFH8Z18FBUHiAHkEvienyiOG+4tvP32L9AVU7rbNsyzFdsPL0J9bBxzRSGLl2JSwYlHsYmNiE3Jt5sK9KAeQXYeovh1kPCHRm5BbVCPBWrNSVQEu43GHJe39NDEHyjmPMxESHYaJjqvpuwZo2H/XgX/Mk/j6xJr2O1U5EZnzhWecmW9bC/tEjvwoqtizCjyTi6du7ODfUxfKVJH39pshKZQARLuTF/l/fVRUEX4HOeO190jcmcQi8cbBw10I8cXv0YuPfwowxM1ZRLohcLVjxw09gK16su6vUYXLJ7tAnuS8xzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItsQ2sRjMYm/FKDc8P4g6emhG360XyDfSMXCXilSnI8=;
 b=qabqXSZKPKLPpBkhj+l8CFdMSHl4ZCU2Uuo9fGmomPi6OwpCwHiVsh6m1rirPcla7x5X6EkKtAeIIOK0paSF7LPkCScz9KpYtGaYlmm3nt5Vu1LfuntecUhUEzSR/0Fjasu2YIrVwTSmd9v2TQC5mY08iS484Z0/9mHrBFtgzxEUAljzkICTWk9m0z6ZvoOquWAbJv7StzN0GCdisuEvYGqWWb+8MfIv+nIVNSYl/n2XL3YTfCsLhDWcjrJjQbw/wmEmAkcWb0j6DyUKOsJoyowra3kdxoKrq9y6h0crSfOiQupvBoGrRHQnUbJhkFSDh/smszW7+Z0HRXcsSAeVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItsQ2sRjMYm/FKDc8P4g6emhG360XyDfSMXCXilSnI8=;
 b=NmdzHiqtyBljEtQOXNPjmmfR+N+syk4GJvdNsaDc9bB0GpEANhkjJXrnCdmdmbJfevejCQdlJvYOYqMGmI6ESYI+2IDgcXxtam2+3Il13vP/bw5IZeWLY4t1fx9Ur+YZ68pfkOp3X55dmtaoyWl6s4tH4tamQHy1rMA7HeYG+WewGjXg6judIYiNSP18+EVwbq9mPB4eerUITlX6W4miThqIePbhM9u/JwRAujgxNqAQ4zIxx3iQd39PtREQKSq/fem4RenLdVZ3kdn3UJo5olyGKK7AvcKfHveHroJttlhlGdoV4JWDFNpZp98jtEc6JApE8bqrq10e2dvJH5WrFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:04 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:04 +0000
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
Subject: [PATCH v28 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed, 30 Apr 2025 08:57:36 +0000
Message-Id: <20250430085741.5108-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bc9af5-ce97-4b4f-d973-08dd87c541da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3+FoMfRKSvw+6bxA2HNn6OtSevG/U7HuQN5emJq40PNGvQmOeOqFlmggIAs?=
 =?us-ascii?Q?udQ2gX6BY1hy/RWsojXcdH4dwrvn9ZGBTujRqHE5Aj4cRWEL2iQgEVzj45fx?=
 =?us-ascii?Q?N72axpvEJR//JwRynQgk7b72GAOTRgOy4icv4WX+YJ6wNyxNEQiqAF8jen81?=
 =?us-ascii?Q?eEtuR92AG1RK71cqZMMjUItiLnZeoe/okwXtwAtUkNUGW80QmrJ4k5Knuv2G?=
 =?us-ascii?Q?MxktxZgHKzM7qwinLYsSAIiVGTsyYq3q4jGw4Qj6rPmihjqfNeCndgGYp4t/?=
 =?us-ascii?Q?RqnUh5bIIgoEhhH2qs818B55xJUd4L/oCNFQTOg42J0Y8WXRbLtwWh+rHvMk?=
 =?us-ascii?Q?cHpMu8PcNV9dr9n3eD+fJzvc7ieyD/9SqC6P9lNISrvS3szA9EgcnQe7haFH?=
 =?us-ascii?Q?Yv9uc7qhAvPP81LG+GJ/IGWi22o+qz5Mzta/yzuRxNdhKReSLmCP+Lz01Zi/?=
 =?us-ascii?Q?NeEdgbh4AfoMEDu4WIED/6IcQdISJ/nnbZImMN05WeOE4zKAwahBtcz9yjzp?=
 =?us-ascii?Q?YXG3sGkUFyPz+NymF9ppiKAJXEIukUZgug3CSSc8D6CT91oWF5NDBo4oGVxX?=
 =?us-ascii?Q?WCb/H+jhsSv2Z37ctRzaPYjF+BQP4dkQJnp6p/oVI2eeufKOZpzOVHxMdXFg?=
 =?us-ascii?Q?83BqZ9zF2fjgRR6q4CcGC4gxBzx9OdCo+fuxLTMlCZfL1O9dtjnbss6/h2TZ?=
 =?us-ascii?Q?k6y3j+Or1nZJKLHXAfJqx5BexeQXqZtENel0cNY1KTiIXeWL0faI/sJ6+zLe?=
 =?us-ascii?Q?Em9CSYlzltE5jtMO8AP1o+w2+XD2reDGerW0i1qKAfBabpBCvkmtsE+TYrYq?=
 =?us-ascii?Q?BH6x8DAzTRXLdVYh7ZGTGAJhTKpXITVbAwnGp9SfXPqfIiu0hjr8Jt7tZpCS?=
 =?us-ascii?Q?MGwIbCQ8HQRfqjoTg8WRECvFfBCHE7M/oyWZZ0ALIiVd8a/ImHCu0Gw6uHRR?=
 =?us-ascii?Q?e0tS/s20rdlTGItvxrcdbX4GLL5ubpHWEXmnpDK3+YQKATZ4N3BXy1BRuYho?=
 =?us-ascii?Q?CrzeY/00bjwelCCLGOYx+NH2NUrybk6eAaVZ9lBb2JCxGGh1/79fhjm31DvS?=
 =?us-ascii?Q?9ArQNGpgsgOtfdmW6MWogYzA6bj2vrNwHc7uEqapJ15cDQ8GkkCJRXfSz+nt?=
 =?us-ascii?Q?cXeqdhhaVuLVkDb1Ukl7xDbd2vvTyTngKOUU8n521d1N9/bNx46dWaUeZYCY?=
 =?us-ascii?Q?g2lCd97Ohxe07TBM+n0dEN7SyN6RVXQvlNi03yJA1TMpr+2qFJUop+DTehoL?=
 =?us-ascii?Q?qXk+egPzGNjWEHOCiAyoofsddTdE32Xp3VXFuzNJaDfVCZwiSruKqvOfwQVA?=
 =?us-ascii?Q?CCRaMPe+cEVLPhi9y//KIUujGhsiBMkvBvGavVWONStb1eTtfCm2AuZrt3Ci?=
 =?us-ascii?Q?YQg3Iff8lAcQ0O8hPzso201agH+V0VZb/DnuoYrhLc90ZD+uac2ZhkB6p594?=
 =?us-ascii?Q?nuH6mlV9OHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WlVp7SwA+QFlo2d+YkbJw7GWwd3hbVgHuddTunzlhdk5VAYU+ES0MziyJwE?=
 =?us-ascii?Q?doPpjeWx900lpux6E6kGO4zMEANBmTtD57ghTeLvYr5I43HbUOfjnsQSC+ag?=
 =?us-ascii?Q?qEoWQYcpNfUwlCdfzq+DhyHY9LzqGyRwXjTE8hEOXfWpUU/RO+6RzVpx5Gts?=
 =?us-ascii?Q?AIE6EqpthWdqfUeQeaFxKIPNYzH+DGsOnm1QG5fFv5MsKtH7tbUMBWEoN94f?=
 =?us-ascii?Q?MhYOSGE6q1EXAoGLQDTYA5jvaYEn54Dn3swingV70AAUCfvGEkq42k8gK5+P?=
 =?us-ascii?Q?bEhx57shObqPqUk2stfZOylk1V8DzEXCrBPiyz+nzN32fNnOgAcFM7p+Bku+?=
 =?us-ascii?Q?IgBJ1oWdZ2E9qLqqI1+OIpAsgYLD9OzCeNFxTd5H548JNFO7vIHPMmV5Cfg/?=
 =?us-ascii?Q?N6ruJxZhhK07UvAi8H33g0OoVcn2nPrKCa8dksO19+6v2QrPXZ6j/WWA/VSB?=
 =?us-ascii?Q?3VK35vPT6A2GkserWuAV3KL8ycH8xRFe2bRTdbSX83RgtFwT+fbeepeYYao9?=
 =?us-ascii?Q?51JdL1kPvuL8P8eimxozYWxpBU/+eqr+ZVHIv0RKiE//W39SxYYYVqsqf52T?=
 =?us-ascii?Q?cBinHcjHFTpwYs3tcg0NZNAIs41F7CEBOKoH036zoiS02qrQTLGC7lXpkEuZ?=
 =?us-ascii?Q?oWnF7vP2K9cXNGr/k5YIvgAIG8xXrXxssuz4LTs8wpIB1LJ4g0qVbY1mRjYY?=
 =?us-ascii?Q?cyM0UxJrolFmiMDAEWDr7e5sfzCWhNGudzELhR7Rd64+Ql4yi190Urt9RDHZ?=
 =?us-ascii?Q?xwr+m9L46uooebUR/KmPxPrQ2Z/GvZmZPBsp3QrNuTfKj9KunywX7dQ2QAq7?=
 =?us-ascii?Q?nUMkhza+Iai0I0n+ZrKr9j9UWqlAs5QDrEXGn+ZscthlxU82ZxQfgcAxrxRJ?=
 =?us-ascii?Q?P7mfQp8l+dhvpEVxw4CKFPZBD3Na4N9j6aHo5YvJVyfnI8wvlfGCvKmWWTQ7?=
 =?us-ascii?Q?fv1mVEMOmIq3/tzBBOHAfyxFjQKNtehaq8HzuiE8cTTzvbSfnEyf2899Z8lc?=
 =?us-ascii?Q?RAT+ZIB93U1N+3DM31Ub0C1vV3t3fPfvIunU3pBtIM0aJNtxjBoZS66OjY/B?=
 =?us-ascii?Q?JBWA80rtpMBNXzHKY6QShBfOdHDM10hbCfm7DIIBl7PED8is4eavUfPaRiuG?=
 =?us-ascii?Q?dsZ+I0bZszCk5g5Rk+6QqwwtETfh+m4R1uXcooqSvE3bV6cmXqlVrzjWOG9e?=
 =?us-ascii?Q?bCXaQsg4Fmbvw9n0iI9UhjV5clffjyY4S/K0GVOWV+kODcPciMN8IGWCpU3w?=
 =?us-ascii?Q?ra1fsClZy64VxRXJdzfPaPj4r/tIm9dxw6lnz+Eu03OfW/p0JwUGxxEJ0Rbp?=
 =?us-ascii?Q?fySjZwDBOqvdhJcviK7GSu5g1fqSxR9izdP+eSpe/T5YtdbYAQPh8zx3BYMB?=
 =?us-ascii?Q?oavgasIpezKjHhWTD3YbwIcZ0ytIpAAGek4gJv9AnxBDt1qYob7OMAo6Kf5p?=
 =?us-ascii?Q?aX6PWNEataNj71TCR9zdi3A23dL78X0EvfC5/Qf/n/nE8n5qnG611/h57Ycw?=
 =?us-ascii?Q?40pnfr6ykP2murA4+6iw2i1Mgao2se+LSJ7Q7wJuwNuFjmTLJ2tMNBYW2BRR?=
 =?us-ascii?Q?PeqejURSrqQQgexGroAV5PNXexgaEFgYQSyyLyjB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc9af5-ce97-4b4f-d973-08dd87c541da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:04.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4axof2NV/SK6OMRfM1+irXnROVnDDIbcWVz1iSHtMLBxh3cu64LAwTsk32KF5iIPbJdXU1mBBcFvh5fDcoTP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

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
index 4051f23c0fc4..77a358720bd5 100644
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
index 0d31d012954d..a4d30eb9f571 100644
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
index c4c612ab62c4..5370d238c818 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1056,6 +1056,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
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


