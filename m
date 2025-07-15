Return-Path: <netdev+bounces-207125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54709B05CE1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DEE172A33
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9C2E8893;
	Tue, 15 Jul 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jv14pmWC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43B2E6D1C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586195; cv=fail; b=PEe3SwsjEo1jVnCdm4FYzdJfRZsuahExum6oqOOkrennE5TLu9X2fitx7GuXZxnE/m/PLn8VV7x3d8cyUDmE4w1A5c3xkL79pDon9AcbVgShIHeZ1AZmy4RU1sQpilCTD0mDPO3V3+ixGO/YHwvmiwTIxGsslYx36SkHBa51M8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586195; c=relaxed/simple;
	bh=jabXOH6py6J/I+ImFqygh/oE7LJwrSbj3ji1h4xfmAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNyzqSZI0q7pnr/wKr2dimYZYTwtAbJaSG5vkynEQNPHIhXRCWd3QL50ia2ubtKp3RaLEFa0GWLdW+CWgpUDriCmsNWF1vHbQy6yT1W7mIse/0dF6IiL+h4FmNlUg/lGEdWqfsv8p/3fdxJNq5VDc0vwHoYiDr9E5wi6bSA706o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jv14pmWC; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB96kk71M5nRT2CoT38ehjLsl67+YEtQSE6dSlVr2yL8vWLUPC8IhIML7Ir2bcTLMXr+bQHaVk0Ue3e8GHEH9Q2AmZP8xnhPo0Rr2Evhn5b8Rh4ECEUih3bCnJ0VUY/p3Wo1f8CX0AU3aoyHOwLwVqDc/qYTy2DLX6RpUIIIHg0QFRhJHMcF8QSjqyFn+1sFn0XTncoYXGW7+fwWqgGQKHy+3AhDJSAtKy2u0nlNpWeshWmlETV5TFeGEM/rfLG4y53pKVpeztTf0QCRUSfeoF55cB+XHH+4Hj7RL3UTSBYdVBhOBvn6/dz4T5Y4VIwCtl8YYW/Zjv0SmXD5wuTcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBKRuIrQjNw0yTlwaGTqqxr1qFRw3zNGUyvrsqYAu2U=;
 b=nJokj2jzHllJ0pTqZl15/ZNqTT6E1KNxiFRjnYXwwYuJhKrIbjrG3d1z0raKp8VYT0u4Kxc3TFJVae1Q8R2fJRwLWriRb1j1Q5uJLKeJ4LVSpU5mGWnpK/mYDPjPSflngNJ6+k7vbg8RrbOx9JkWKi1KLg53UHIgfoAdgJR+qXBlMktVdE3Ns4roiraY3yYaVR/JwlfELRAZZLUtiHP5SiHXDcNd+Sv2NAwiyqvW4Y0XRGSLm+CmPcx5hrXjdHuK8VFBNU1kO06WFfi9brHY/m0ZcKDLp3ZP3JX0hG+wulyULUeKjn3brgU/JVz9kS2Ha/JUt15qS9DykBd6Cu767w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBKRuIrQjNw0yTlwaGTqqxr1qFRw3zNGUyvrsqYAu2U=;
 b=Jv14pmWCdB3r7uhQcwwjtENEh0RhUseEvqhyCvjwjqYv1db5cSGRdlJpSWFauHsYcBwOalmnSCs7GZ6B+SqHGQQxs2L+n3+1V5cVSHwyw5I1V3AvsHYmo9H+RdT0v2W5qOk/VG8U4LKrGDR7FWOTc1xk7QC/DcwTVl9ucNHwA5rrm8mk3qqfX7mjAfxViI0JdNFUHUDhf4mBha7OBp5N/AxWOWEijeHIeNjcOCE3w3uBJqA6qMPVwKnLFVSxorawK/RdTlcSk03540HV02ij1XZ7GYTGeRHgWuLUNRrlFFEyeo0nV5Faki/6epvkjFlceRddaFb7tSZXPEIgP/YE3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:49 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:49 +0000
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
Subject: [PATCH v30 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Tue, 15 Jul 2025 13:27:49 +0000
Message-Id: <20250715132750.9619-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 17612d53-df84-4963-76a6-08ddc3a3ac0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWhMNRMgHIhdMXNUrsSK3uGT8pd6KSQ5KoPTEi5iLG77Xp1ZbV4uBqvuk5Sl?=
 =?us-ascii?Q?WVid5Y71TT5oymhlxMbIMiM014uCwcbR0926u1qU2ssAh1ePr79vqhD2SPsI?=
 =?us-ascii?Q?yvzuP72WBa5YYJrxORUk8WO0tz383GNdTbmZeiBktgJVGa/ckU/DZPZi4u9G?=
 =?us-ascii?Q?it2yfaonBP5MXyz8gI36Xchoc60+XNSMlWj/ZTiXmGnlyVJmNg/4F6VaudLb?=
 =?us-ascii?Q?JvRxHRM4HirSaXAH/l12D+AeExNjw4Gmoj5FVvFdWjbJKXjWCVqUm+Yx9sbQ?=
 =?us-ascii?Q?/sqHgzmL/+2HyH6rj7pG4NPrCsGLnXiUcLgcgdGo1hrWDoC3TgHyzHlw2fKP?=
 =?us-ascii?Q?OGrcf1DPo5+Qz2gmSZuSu4Kx7FwFJrmsYALCKMtt+nmROEZWHoRaOJbbDZW0?=
 =?us-ascii?Q?tDx5H4x76h5zNQa83KZFxdG88oZULss00ieqyVxoL2rgovqoTmGVVViFU3Mn?=
 =?us-ascii?Q?dpcL8RF1zm7BUk1AFcXW3fF/GetMxmRz9f3nj7qzJa70HmNrc8E/t+Tr9BJl?=
 =?us-ascii?Q?AhRAlhdHTW0bi3W8yT4VtJYVpS97J+Znfb5dLgJlk9ywHQ/CmcddnwVyh01o?=
 =?us-ascii?Q?3lP0IOEJNrrr1byZ2FnXwhphhz41NizsajWlwOj9MlNWbXz8ex4FWmvhxM0b?=
 =?us-ascii?Q?brC8cUg5DiEOEeTe5yOZswd8aPZfCu3Ji43yl1s1/2PoDUfxT0YS65HeGg0Q?=
 =?us-ascii?Q?QWfg2691KAVc0sEuchmq3xbJARDvBvbRRIKKlAjMruJt4fBG2x1RSYh20jqR?=
 =?us-ascii?Q?oN8XkKliOEkuZCGnjvFwXy7rO7rYEsPswUmQAmo/zJod9aQw9hKsQprpuHop?=
 =?us-ascii?Q?XsPp2zbTDV0Eeor6xmC+eRw+fwQkd/6KWNVaifm5Ajns9qYIBs29pQepydBE?=
 =?us-ascii?Q?J/oEIJC4q0K91W2fn9hyft1GgnoShPE/i4tdkXqvOkwEpbCn6mwazoWNx3GI?=
 =?us-ascii?Q?Hh91Ff5FlPpAxOyISTfCC76v/hZC5BEvR2mQRZJY/yB2ekyiBnwRAULl6ylu?=
 =?us-ascii?Q?FHDZ8lBYZRFZ1ivx7Wq3zDc1DkOoTPcE/KrrV5EdINQ5OUpM3ZfkOGjSWV7x?=
 =?us-ascii?Q?PCWsrX8A4EkLgpl/Z6IObDCRKL7zLRu04rFmnAeK0Q4mCG41nKmBHivqu4vg?=
 =?us-ascii?Q?I/V1eR2ZNXjSlu6u5iU2epgu0ZHd0eX0LC0Xb/fX/+iJtrnEGo4mD22lJo0L?=
 =?us-ascii?Q?Vl/4WNV//q85T8oH36gLY/EBB0Mjk/GPmXU+2QCzeoR0D/hzNUohjTZhbzdV?=
 =?us-ascii?Q?SGEGCUvUxAvkhikTPtNhKOKxMfxWYP28zwDX3GMU5pnBSkPDI45o2rCl5IQ+?=
 =?us-ascii?Q?qTf/9F+tKwoiKr0bzOS01mCc1B0bEfLOtcSX6FYLN49DVbu+cVp4oqhEJadN?=
 =?us-ascii?Q?2lnzQFX3tVQB0J7aa2cKvjTqv3+TT7hibl/25aZbJoykumU2UGDgxmQxndyU?=
 =?us-ascii?Q?HARMNi3kHSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+rscht38cnN79aOrYN9GFJgyp/X0acETYe6eId16FYbHSAvWwXOimtrQVNL?=
 =?us-ascii?Q?j51Oz0UOL8CJEcAH0J7kn/q6pXLON2vNEIkpGjE+kSusljw77ymIBar/pFhq?=
 =?us-ascii?Q?XHRW5GGhK+a1ijhZmj+YCfDsfGzt/CEXLGFArbbpV5XUVsU9ImsYKZEkp1os?=
 =?us-ascii?Q?bERIqNlyAQiK1ajQVW6WXGTuSLj8ifCyMftnEGvrQurNp9+8C+r5eFLuoBTh?=
 =?us-ascii?Q?rw2rJvLXbkFm3mhC3nEQ5e0jnFvGG3JhbdXGHz05LZOkybdb9QwupdjF0VA5?=
 =?us-ascii?Q?iOdFSD+fgTeRSIU5qbkbkLw+s6TLSnqnDaxaSDJD1oTgS8lNr58k0sqZt5YI?=
 =?us-ascii?Q?X4HkGU2um5NArif9TyNw5N+4TQEqYj0Q1C4hL8br34tjNwRAa64ThssEvGZD?=
 =?us-ascii?Q?zyfhguK8FWo5dGSV71yATTifLtVzWR9/TGeta7+rv8ULBeR9YHtagc5A6HUZ?=
 =?us-ascii?Q?ZFvn2n6bjSGdmI6ss77wrxAclxq0aGp/91uubCfMYQu/wKukHjTg7vC6wh2o?=
 =?us-ascii?Q?cxyXZuPdByQu1V+xF9qvnN2I8ws1BU6Gmbm2pBJgUuAUeh+zIYPuKa1yIJ3b?=
 =?us-ascii?Q?ZqgQGzOpnSTnYF3QULZnagCChDW3WSoCL49i52r4NXT/ClMHVpVagys+HTAE?=
 =?us-ascii?Q?RbDUThSGuHs44sSWxuRntwJB2bZ2tvFPq+8Hp4r9dZSDtLtonZ22dCdIVWI0?=
 =?us-ascii?Q?yznClzpS45WobiWtTF2jOX6E/lOeye0YeLqZxZkMy9OO8DIsWEiZlPw3hMX7?=
 =?us-ascii?Q?T3ZZoN44QsuuzUK5MewI/2UlUUJ+OBX5DwViSrZBd/9nfjP5ouUg5NIR6kPl?=
 =?us-ascii?Q?8mUtpjA2IvnGDba04byGZF0e+5lXZaVasAauAf5YgkriRIOwybftDJjq/muv?=
 =?us-ascii?Q?NI0igyuh8Oqxzaf3fXoSWEZuoFTN+ix+avDSknxopJRgv0CoE/Dq35n5W2Hc?=
 =?us-ascii?Q?gR9f8R9AqAI5zYQAxXpFHU1sv5uKPH1m5fCE4jNU4CKgvYKRdQs7ffR7boyW?=
 =?us-ascii?Q?veENdDfk1V5nNGb8eJseme1Av/na++xV1mtIj/Ip+08wRI3Y6OC5vIFbCYLU?=
 =?us-ascii?Q?4I6Z6H7zGbRPy2yfgpqHvBh2IqbWz0EuOPaEl/2chbU0c5x82jCtt/X0v22Y?=
 =?us-ascii?Q?HqmTPLAT+9hAHQX7kQRv158emf37B42a9mTYNZbWUcVuS+u/YdXxK2Eb/G9W?=
 =?us-ascii?Q?Q+83BhPlkSb1gAVh0S5UE9dHcquQ0LEiQt8dVdiKmR9CsNi3/gbzpd2m5phN?=
 =?us-ascii?Q?iuS/5kFgrj0Cuk5Cw/EfdH2Ga1YQVmV7bJu3qEYCHgtQ+1QNMylRfE1kKTIx?=
 =?us-ascii?Q?FB2yqjqV6UqOvesbNLWr4YmotAiiAUZhHI7XpuM+6AOXi5TMbyv+GYT9R6dl?=
 =?us-ascii?Q?rxFdgGFREpVvFSQMFJw4ZO+sb6QBskZuKqcoTg/Yq5V23t77w09IaRqMxBFd?=
 =?us-ascii?Q?Klm+OFSIRkBL7Rqbl4lYmLze2/pNLjbKn0qlbQPFKjb4V2wHu17qCTtLjfdn?=
 =?us-ascii?Q?E9ON3x1JIScpmwgkzH/wmeW/J5ZX8JUb8dJrCTyudCBupcg1HV4nRTj0cI85?=
 =?us-ascii?Q?KQ7qgkKQq0R72jtrZzD4yPaUivYsPsiB5x3V+0bG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17612d53-df84-4963-76a6-08ddc3a3ac0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:49.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkXCXYYOq1nCYajMIJell+qJH19b+umWBmCWm7Qr3pw9Yl6OQ6VsOvMpd+g14wVJqrWstIGlxaOg+lG4u/3mFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

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


