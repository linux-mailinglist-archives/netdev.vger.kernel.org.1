Return-Path: <netdev+bounces-202470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E9AEE033
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D6188BBD8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C228C2B5;
	Mon, 30 Jun 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KFJE1gdb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A528C2D0
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292571; cv=fail; b=r0y9r0+9STVdC0QO8nZEvo/b9oWsSxfSnkteYY/Ie+0ZCeMRGTto0BbZbetJunlJhbuyzJByqYMvP2raWXzKhEv8PWgOydOsEij+VsAVHOiYoYnPJxm0D+Ze/PODtrfEnLesvvplJO41cYYLOzveVbCOIQRxVmCPyQbotIjhdUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292571; c=relaxed/simple;
	bh=jabXOH6py6J/I+ImFqygh/oE7LJwrSbj3ji1h4xfmAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bceu0cJ0luwyreV8VPJpKd7/k/HwiFTTn+rz54ET1dtJ5uE0paEl1VT9xVUtN+m15Y1xP5eRsS2jhgrY2YJmqoRbk+GjIL5syCz9x+8K6yBs4uyKIGQFbXz5M54L34zGJjjd6mpOMOek4gBvvg4xdn3eLm6luJMiWO+AKviOje0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KFJE1gdb; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJIQGGbfXAN+vljaZc/CtXsOWm2xSlFr/Bc3OH7QNQ5bxxOLnVbCh64jTmP8LKF9otoRuLw+BA1ieEiRDqv+iVl/mYYSbzRo5kaPftk3Aihz22/+AxJxl/Mh5yru2t50qeYv0cNuQHLVmL95izhsZnBhHCAnJiFd0DQrlmrlMfhQ9XdRl0xse39rF2C9CuKHjoYZeeeneklkSYtIkuKADznJxgjGDGk6fGvimwG7mxtXKx/aaUcmYzVQr68sT2PCti9ekNundiw6laQJUGqdpf6W66Nx1G2l1MGEZoXHlbCvyMyBz9dg5mt0Z9Cpbp+h+uJfsVHNU4yaHUm0wxPI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBKRuIrQjNw0yTlwaGTqqxr1qFRw3zNGUyvrsqYAu2U=;
 b=SbaNvqnEpyVw5cbZId/o0LWUZidkv6n0zjjU3zPw2u1xYNlZ4AekFjEw9F6y9ATlAMtKcFYbBO8c+4iuG/bjCvwp7px8lnx19jC+30wcGL/kpXy5EEDM8/ilmCEv0slNuuGNbJbqHL+wGGoWjKVsVyp5hROnPVQ7ij+Wjg9tnFfR9ztrdMNZpm+AerefyZI6zkeTcgpJlZMlL/rZtUbQVd7qAgahyPhJvqcNdiizwVGKb9N59eqCEZsEq5FS9QlE9wwqISCUbStGV9BvKoDMQ9hcyj9JISBry/IQ9bKUsy846agAVCi/Zg8M4fsLXcqfGgHs8Y2PPS8uQm7+NfhE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBKRuIrQjNw0yTlwaGTqqxr1qFRw3zNGUyvrsqYAu2U=;
 b=KFJE1gdbF9KbqAdyTPZX7p4NNFOzdJLFFux3wgqSb8uTlB1kdBNl4co75aP9kNswmtfFd+wG8sW3GpgsEsrm4VW+tgNvbBMlUZ+UlXC4QrLM3C8FFNUzO8or3aj1lO05ZCrclQ8MDWHWH6IiqajPaidAshVbDwci8zjVVVgzgCPpj+4d+r1jN2nhk1Gbkfk6RWQpa8r2Fm13Jjt306PCqgn1F8PdGqOhCVvLX0/kW1v8ATUgKjjZLnbzPNKmJWjvEMI+/smYRnibdkts1uC8260jX+76KbtIziLNCzQwtwcOY1d+n8XI/9+00Lg1t5XbTmwTYbHdRoAhTMLGpkfEFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 14:09:25 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:09:25 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
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
Subject: [PATCH v29 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Mon, 30 Jun 2025 14:07:37 +0000
Message-Id: <20250630140737.28662-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce3fc55-bdd4-49f7-b4cc-08ddb7dfb82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6/mFvW+ZX9c9EaxraV9CDtXNGM9jEhSXA9Z0C7EsLBaPhiv0AXWJDK5q4tC?=
 =?us-ascii?Q?UBFKwbnYg2gZcqANCBoo2F0cJOwSpGqkDIVxVlDSEE8lzPQHPRb5h7BjmV7/?=
 =?us-ascii?Q?mXGRmAk9OK1s2sR6kI5Z4uz9f2VeyTQrX7YnU7CF0eGpDxTv0NjBdK5i/WbQ?=
 =?us-ascii?Q?+YiWDjbbGdwVckHRaUi+WRviPnX1nHRWtsB6mamxgeq2echwyxYJybddtlCm?=
 =?us-ascii?Q?9CO0IoIyjENXuNG8KXyk2n6CojCYTxze89Is3NqMUidRtR/OIG8CIPmxI83k?=
 =?us-ascii?Q?T2k3LEANaOS0AXDAFO7YJg/6G93J+g9NwRhuGK6OCZOmvWGRLeoBZH4Ma9sW?=
 =?us-ascii?Q?V10Taa0rwYekn/Dw+NAECUswu11AMBBmT1Ik1HPKG/hYOCqge9D7darKjCow?=
 =?us-ascii?Q?WdKkkr9WUucruKAyPAXdVs4H262jb/uGqsTt0HfsP5lE77letxfAaRUPJiW+?=
 =?us-ascii?Q?y5VlX8SHuouJ5ajznoJUUweWeqAN1w9HDYT0W4IDZgusfYwBVi6xvK99mVc3?=
 =?us-ascii?Q?/U128WfIrj9ioHYkikph2CTM2+5nTllAm2g+thKxKqxWkKH4/Ww/lPdGYOJ9?=
 =?us-ascii?Q?RTTZphWsBhCoJU4Sg0/dseNFBm61RslO18xwGJx3gMYfMc0mMp39YlRbQreL?=
 =?us-ascii?Q?SfueMYa/jdL2oTcREL1pesKXEukoFoNJO7xORC8Fkqo3rfMsO4xa5yBKKPKM?=
 =?us-ascii?Q?Bwifu4w0dDzq6Eh2frS6LFr90fzmnoEljcjsbmxX+uqOuYW8iBD3G/ipS5T/?=
 =?us-ascii?Q?/AfC9qbAviT2aiGOpj6nU1L50gBn4JifHD2iedn/8rx4B6TPx+ZqMaipTNSs?=
 =?us-ascii?Q?LdjJkp0cBsMIE14KzS8VxpuJ3QSPbYCiKxoNJw4LqBxOxvHMJsPhPStHau5g?=
 =?us-ascii?Q?wvW6/YOQtOOwzWEIgXaYIVJDJ6sKjdFpY3VBSiiRmNVvpIXz+mQxH62XjouX?=
 =?us-ascii?Q?WVV8aXtAHCa7o0WIff9nn4FgdCZl1Wcv3nbETCP08vbYBfH6wM7t6ltwIgMg?=
 =?us-ascii?Q?xUTEiHwWH1xlfhXfaEdbLNawpTF9+7CimrcAZV5ERWY1fq83yaPgtFfYoriw?=
 =?us-ascii?Q?G5TNO7p+1FrwL/zEJN5Vmacn4Bp3fun1E9HLWDlHsVTXVthfsVwattlf1ubJ?=
 =?us-ascii?Q?yLDStzzzbiYmrn7hDnNSUAA3BSlY6JtVHGezyChktaTf3ZjnCN9RaH6VbI1u?=
 =?us-ascii?Q?3HBGMaUUzcc6eqH2K2lZbvRdd92YWuQyi+VyO1ZSEy+8vsT5sci1gAk15x63?=
 =?us-ascii?Q?ftODc6aC2D0KnSKNn2IFzpMRlb3kqIt0iykA1MV7OOpO0cLyGJk+ow/KQzT+?=
 =?us-ascii?Q?0nHXLX1BrQT63O/yIfuT0ONYGLEETK8nCYR0zq1shjhpABB+Dm3CNy8Savjr?=
 =?us-ascii?Q?FTAnM6IHCkkLVxGsk1qIMaw8c30oWt/XP+gBgaJgMJjSG8Ef6Yi8I3Ih8Utt?=
 =?us-ascii?Q?I+7dwG/rTV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STuchNac+cfXH7GzPBtt2fA7zDkgypHDbxOCnn8Afd+NLj9V+bogUDLMbwqw?=
 =?us-ascii?Q?AQNEXLUEoM6KXaxT8BkGJVzdFYQdlFQwuIJtVVoKoi+XPaslqYYMFgdh/Emp?=
 =?us-ascii?Q?T9r2dT/B/l7ICPDrBAf3iFxBfHb4hfdLuFW6fZfWLLVz3W5Gx42xyqYHeL3B?=
 =?us-ascii?Q?Qt4YfY09ts5IdLBTfJ4On/untQEd0SVvAbmQ/kwl8yiEPtQ7B+MtnmhPlKTh?=
 =?us-ascii?Q?8gx4mGE/93VXf02U1M+QfB+f6tFIsdO/gVPGCXF7EfkxVB6JydNoGOGjI6ma?=
 =?us-ascii?Q?rerIALpgF9UoG9dpIIAzzQ7LUB9o5N1a3o18Eqe85Y+x6lQHJ1yh0vCObFcV?=
 =?us-ascii?Q?jxy+1u85q+APCNoPB++mRtQKo+t9SswK991yHe5K2RDlNeBFB9DF7aU3zms6?=
 =?us-ascii?Q?TREis6oNHcuJtaJgNT9ewEad4nPZgG3uQMrK7QfhOoMzG2RLlWFhfnQG5kIX?=
 =?us-ascii?Q?LahfAI5QjYlz2wvc/lp1XwlQ37lfmCLXIa/e3pUxqKsaIYR74OXEqEMsboud?=
 =?us-ascii?Q?SdluANea5T3jZsmQD/rItQc67hNWMnnEloa7Qg1sIUFcjaHTFtnbhZj1FDg/?=
 =?us-ascii?Q?0TLJB/XqE3LpV7wzD8d21pr2dak98CLSBeO9VI0o/cFleI0biQYSDM2wzr84?=
 =?us-ascii?Q?IFzcTyCNEBnjBZlKO4tDdKgOs6AfVivb2vjizMuiU1B7pCW+lwhpbzvGT/ty?=
 =?us-ascii?Q?HoM5m+ij6hbe3/C8iMlNbtLfn1g8gAjs2znEPankqR4g0y2pL94shw0olAym?=
 =?us-ascii?Q?oOJAr0PfFdKDJRwMhk9iNE6IBrW6RisDd2vpPlHLdFqCns+fotnEjsJqv2fL?=
 =?us-ascii?Q?kxGwI7h36il0YeM4gu+JB+Xhtyzqfkzopr/6bUCxwFvxjpyRCW58xC5IwPYF?=
 =?us-ascii?Q?1nm8x0AF80bL4A+Ta/WrzDICePyyFzRAUzIYp80gtjk1tubZH3FirH4Q3efI?=
 =?us-ascii?Q?LlAGVKdAu07HNyYpd9xweHiTB0NG5imkSFLLNcnqNyABo+BRZHg0nWZEn/sJ?=
 =?us-ascii?Q?OACOMdymXZgJSMRj8+q+0YfX1mZdF15i0robMBRgHu/dwAxCHf5RNt+r0o8B?=
 =?us-ascii?Q?990SC8phh/i8EHPmKPP1MjmxWxhetW41CRrHS+e6hP/LbguiU5cTzCgeOiSJ?=
 =?us-ascii?Q?KibFWv2hFNxZUMSvH/hhXAc0Y8ishZwHZoLx0dkeWBSYLYQURbpsJsmToTfa?=
 =?us-ascii?Q?nvYXL8BDkH6BTpJolGETZCssbUEQ3H+9lSEYSy+okyLM/kduM7imC6l8GG1k?=
 =?us-ascii?Q?OyIVYDclS4dWPN3jaMJddNoO7mOcicyKv+LgkOPU8QtNCwFMIOzdQWcXKptC?=
 =?us-ascii?Q?RpKErPs1ofo4AjZWpuzrLGuquYwEhfA+/+msVU4TpoFskw3sTv536lVugbFv?=
 =?us-ascii?Q?IhxmX9klGTPBPi27tBe+to2gDbvHtYPRvkMJ2cIifXBZxJLVOxBzk2FfH0ex?=
 =?us-ascii?Q?HQmSCCVTbq6zE33TFZnLCyYbLTBEFkEyVtoGgjxM0rjlXhdaLFTsBtf49d8s?=
 =?us-ascii?Q?edqXpfF9tEN14O/Qkh38sVXKffLUR3iNotOWxA2G9FLP2jRiAiZMxe3K1yzd?=
 =?us-ascii?Q?ARNoQuCJT2OWqw+LwXXJ7wBuuHWW7Q8Qjpqx8BZW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce3fc55-bdd4-49f7-b4cc-08ddb7dfb82b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:09:25.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Poq534yO3EFIaM8PZ3XF8YjIA3Rlhp8TzSYh/UVI6K6opz1+bKGZQHWrRvgFQxQpuVdN6/b2Vjh7qzSccp8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 54 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 17 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 ++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 69 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  9 +++
 6 files changed, 151 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index c661d46cd520..89d07eca52d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 639a9187d88c..c4cf48141f02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -670,9 +670,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *nvme_config = &config->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->affinity_hint);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (config->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -700,12 +706,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = nvme_config->dgst;
 	queue->pda = nvme_config->cpda;
-	queue->channel_ix =
-		mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-						 config->affinity_hint);
+	queue->channel_ix = channel_ix;
 	queue->size = nvme_config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -717,6 +722,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -730,6 +736,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -744,6 +751,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
 			     ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -878,25 +887,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -908,8 +926,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+		     DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -957,6 +981,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -991,6 +1016,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1101,6 +1134,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
 	.get_caps = mlx5e_ulp_ddp_get_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 67805adc6fdf..54b0b39825b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr
  *      mapping synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -90,6 +100,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -101,6 +112,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	struct ulp_ddp_dev_caps ddp_caps;
@@ -117,6 +129,8 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -126,5 +140,8 @@ static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en)
 { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index c647f3615575..ea19a076a76f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -146,6 +146,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -157,12 +158,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -238,7 +241,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -250,6 +254,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -259,12 +264,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -340,6 +347,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..7b0dad4fa272
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ulp_ddp_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ulp_ddp_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ulp_ddp_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats,
+					       sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq,
+					rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index def5dea1463d..e350d5d04c21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -132,6 +132,9 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 			struct ethtool_ts_stats *ts_stats);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+struct ulp_ddp_stats;
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -406,6 +409,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1


