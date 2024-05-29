Return-Path: <netdev+bounces-99113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF38D3BB9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70758B26FDD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48C158213;
	Wed, 29 May 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXKgj5Fa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15701181CF8
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998575; cv=fail; b=vAw8l9vVvVlT9T3b/iLSas49RZzR5X1Dh5n9qESIlGAbxqGH8gYLZHgVNeaA1cMjIRqBxVxXzsKmh3qCLYjE5RoByyojtreROy9j/54v0hx4E4o9M+LBqwMJ2v42XvDH3p+y98HzZkjdZhGg1Pxb4KoSKu9Q6Gk7I4Vo0Y4ns70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998575; c=relaxed/simple;
	bh=lOqNCXmz9J/UY/ldBmzmtciumSTTwL/A+cyh4sOR4FY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tzls0D3zRwLPRXI6dhMVTc9QGncgXzdOpcGUNObZno/443UefkJavMidjDEfKafnyqwQV3YDliIo0X1PiotKr8TosamgqPG06lxRlCQsVIIcNjKBr/YLcljytnof/BWYg+DlPK1ooN7Z3thYB4ZxeTZ4HTGhCwyZ6Rqf1yF6IRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXKgj5Fa; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAvqqsmOqGq8XSsXxgY73zy8ik1b4LZ4catj4KLRt9otKI2cqB2ExZ6BBDn06k4V81sM3ZGUYkjZUag0yYUC/5TceVq013s9MkQ5rfPgB0UIz1O4GW3N2ujWSsPl9seF1cUcQS5yLKSUogz1bIwyjmEQJue4BqaWjbT3qmmuL6s6RASfsCpS+ZOTbyKv38PUVnySfDrqZpSRqCMk6mVfAF0wnC9IYBmLmPfyeYGTXET9xgvK38DYLinLDofyxcmP7s/VrGfyMXJD13N2rR/l450nnXOY+PQtyjvESaH1tscuQ23mXbvYLPPP18xTD25aotSKitnUOK9Z3z54Xs7r4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4la9WlA64sehWqr56UlVneNINQ64IzluQCQusmqqEpo=;
 b=hOBSTGF9zBHSRy9T99AxjqP/03GnpECEYEW1VDFSp3ZIOc/wQEJvLKHXkNBEaZiADSncB0Ziov9+nZ/6iTi8rs6bTSDpTnkdaMJ5O8I8sIxHM4G2VRCFXg8Ng8+DI4wL6+mITZuvrEyHqnd8hswvzjDs4NahX345XvV0dbxeXeHPDBHattRUpHejuIJnk37ABkeHyFkEj07A7omtQitbPszfq2v9WgMhLFW0d2XpuxT/FbJkN0sFn3FStv5e7GaQRI+8MneHLRcNP/OheK0d2mJAxMvpk+G3n1ELroLYmB3rFpxo07YgYe3vbApi38T4wqcm7JpD436nZRtz34AT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4la9WlA64sehWqr56UlVneNINQ64IzluQCQusmqqEpo=;
 b=qXKgj5FaBrycfpPyQhDh9/sZWp1J+eWxsb4o4I+NL3Qa9va43MC6YRUxhi1BSMCuxng6srUb7w32XTImTTlR1sTgbE5VCVg7WvVCIw7Jl9OFU/EaDIDLWDDWDefvhrq4mWWylP7noyk06/FhWizT12SFEr2I6cY4uyu6cIwVE1ZhfSgXgaBDyNE1Xe9kFfswbVXOYJfhyMm+QboVy/Q33eUSWATJPKLoZ1mzyOCHdVLJT7GZckQKwcELoS5RDSmkzVsd51q4/RApu1obkYjdeluiEfXxXPmyY86My9vFdGLBeW+dki4W+MV0zR4RXq9ath1In7uhZ6w5YYlC8zR45g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:02:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:47 +0000
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
Subject: [PATCH v25 19/20] net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload
Date: Wed, 29 May 2024 16:00:52 +0000
Message-Id: <20240529160053.111531-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e6ca3d-75c9-430a-c4f6-08dc7ff8c802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V/cQCXpKw9cj1vTQ7bxx9G0d90PQT/kXKkhcq78kuMSGi7Z86YArCLYQGBam?=
 =?us-ascii?Q?73oRW1tpKxOzIbXNnerHiJgwgaTLSGs0CMRxPw27CAwSUdTU+DP5g2MB99bm?=
 =?us-ascii?Q?vWrp2wbEEXfB7NeQ4vY0ZceC2LJV4GRTOEOGHqOcWSEGsWrdF43k7sN4EzLY?=
 =?us-ascii?Q?8tLvWW9IiBvDYaExRli7hGBRjcydlSZrAmS7jvm3n2Mx7Q8Tr8MoAoxmlm9Y?=
 =?us-ascii?Q?NDs2j/MVzhiX013TuRKM2Kc1n1Qs79uzsXcBWjNeZvKXNbLOboPL1R90uquc?=
 =?us-ascii?Q?DoKK4lYa1c8Gho7PeI0YK0cFDtQWlUFOu7+zmKJA94EfowK9anjVPvaZFTvg?=
 =?us-ascii?Q?Z9LKFyHLazXKjU+DhUmilMNtfcylfxT4LLbbA45P+KQVPa6MLsPN4L9B8ptn?=
 =?us-ascii?Q?moeBvJxceUj1gLMOWuMHfltihVCKWKt5AzS7G3hVrXbPSHzSQOBJ2Q2jMH7u?=
 =?us-ascii?Q?LcjHDgNDyRjSbh1VS4d6Z1S3Dy9ZVlzBHYWiIeOmis+zuMOe1ZS2GjCwXjST?=
 =?us-ascii?Q?tNpGQX4prUcf+gMZE24TMge2r5EKrPUaA1QdDSrq2ron7jyoR9PUiCZDbq4M?=
 =?us-ascii?Q?9GluFqfWPVWF8IeOzaO+I/UjAZwst9zVz77YO8YJ1cUe1acGUtkJhLfq6Xlt?=
 =?us-ascii?Q?UpWucBwMbK1VzqY3uV6dN9aM0bQD66wc2ZNv0vTOPP5axB0bNadwUW7RDy9h?=
 =?us-ascii?Q?hDnrJPtQXdu4cZKyTRI6xPUV7HoB335BQoIwi5WV7QJKfZ0euqHVt+QqwleS?=
 =?us-ascii?Q?UZVy/qRvcgyBBWcnh1TrGXgQEQWzk+txnKA20c2dFaagPzB6EGSoD2YZEC+S?=
 =?us-ascii?Q?CSRTvw3ndSugN6rr/hQS4vK+HfKiqx3PzFn3OPl+daZRiUR0QI9VTQtY2oiN?=
 =?us-ascii?Q?fQrbt/mK6AUqO/PawMWiGgb7GufgiKAb/gL5306Nk5+jobkK0aIRlh1E1HSV?=
 =?us-ascii?Q?Ib45fw5DP23bUE4Z/ykO6F8hOncaHQg4CpETKB7IIGuyxG0L3JZiwab6AyXG?=
 =?us-ascii?Q?DEfDALr1u9xZe45vn9saYZggzCu1UOESSXeMoey8VMTNHNzv9JDgT7ckB8r/?=
 =?us-ascii?Q?+kwE9qSJSkchTXS4/VwLOaIImi6D13bfTnguqUGLW3SqG0JeZon6HtxRGN6M?=
 =?us-ascii?Q?f5Eo2wl8bDGKNc/FoqqFpOtLUTRB5IKmQ/RuiLhbdfC+9CEFGsqVPdvdTfvp?=
 =?us-ascii?Q?KsqfGZmVY+jRfCbGLA6Ayl4nttHjFJ1N3QMC3EiHSjCuBjuvn9u1PlXAXwtH?=
 =?us-ascii?Q?NRzVQXaJWPKRKEVM5fQhM8+ZT5vtUKpyJ0saYxLtZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVsrqB8kLp+LJZOxNM8Q1YD0Re/N7t+vpQh74wnhOWsvM8xmpa0EAcUbRKK0?=
 =?us-ascii?Q?WRaBbrxgHidr+MMD9cMKT/xYjPo5pmSpMrmnoCZlv/frMRVHv2AscErbZZhu?=
 =?us-ascii?Q?pm8CpXDwGUSINwjuK8Hppxr6G+W24VMj5xTaBFHfpIYmckN7x+XhpPPqWw76?=
 =?us-ascii?Q?Ri3higzxYBLxUKQvSNnudWYwhlf/pEYJpzjBF0goF6FZNMgZMt95x6xyb5Fs?=
 =?us-ascii?Q?I2Uy6OT2+MqiheOHRjRj4hiJwmon8vaSWZ9jHslOrqJhJ5+jAZQFhpMHlGOO?=
 =?us-ascii?Q?GNsIa0RskM/PDUFWzm00laz8iW0N064D5/auo0ggYEMMP2a0b2IYFh43HCqv?=
 =?us-ascii?Q?RMwahKTs1xIdsTUCHUMkxEZlWYre9+GYE53apRKWr1VFy4U2BlG8YIKxUBwM?=
 =?us-ascii?Q?6PmcF4TeWS296axg2ORNFCGx3Vggglm8mD95hrqGeYxBvt8wKUCMffc2eW1T?=
 =?us-ascii?Q?VfXRYOcU0s/fg2CC4l5z9jHH3EBhPZb/OIGCHvNVTzoGccN2U7KMxvaj0POD?=
 =?us-ascii?Q?2p1KHVg2xrSVvOw5H8mLMPwPz9QwpAHi/zhKgm3O0iYS7CluXrFfzwNoeq3w?=
 =?us-ascii?Q?vQ9EQ/1BDA+/DFdcrL5z9RbuzDZQUaUMu5zxMrgHBbrBV2jzYeD5h/Zh3Pkx?=
 =?us-ascii?Q?UOXMczuBAfiFBcN/wuj2mRg+CIo1QVILevoGRWCCLutNZ5Wd14JOaemgHmbv?=
 =?us-ascii?Q?s4v+qclEopcDhO8ubCt1zoMxewai9dfwJliUqbxupog+6etlecPSGns2zTEQ?=
 =?us-ascii?Q?Hd/IaJ8a1YyDaDBLM21rkM7adwoJpNkasUqIXnkCFNFpeXtIWo0zV9ZCEfV7?=
 =?us-ascii?Q?LHsH19jOJC6/pwB+k4cdaP6FxoeJVXnQ9CojkKRvUcA9oHg/RUnIx2VeS0Qd?=
 =?us-ascii?Q?yU2wgHnQKR1cTYuJ0kqiGxNd4UaLCLZjskWPprSaKQyrbIjc724J1jZebA/m?=
 =?us-ascii?Q?q+Zx8U4T00CriorLh8LFRlDf9U9tYLY0xo0kwbR5LeTPHz1KQ5NAZyIgPTUG?=
 =?us-ascii?Q?tMERoEuUsZUi7ur+ynsS+CiJuU8cuedNwKnC4QBKGMrdooESR62CeSZaigLb?=
 =?us-ascii?Q?qGPTzC7TSOgxrgXCY+BOuK3XU2Lg8LJjvFSEVJbgS4Vxd/URyEtxXLLQs0cW?=
 =?us-ascii?Q?L71IraCWqD+QObx/L5y3gktXyqt2h1nzUxyUR0tTinuBaa74JtZG+07Enr8b?=
 =?us-ascii?Q?NACtBDE+frRGGA0wyHKsyKQSDidZpjnIN2GGZ38/b/MJD5i3Zplx0Qp7ViNh?=
 =?us-ascii?Q?wPWYPaIpanzzpNFmaHWXhMa8iK5T2Vv3xx0iSLRxF0aqZTba9sBCf+8ZsZv7?=
 =?us-ascii?Q?XYar1RzUioO8B+WP3OE7DTye3s1nNuyFSEzLKUDrXbepKniQB3T4CVAbB2kQ?=
 =?us-ascii?Q?W4SzvHegc4SDYddkjIgbpr7oQIU5dykGuKJ8BvS1RBUS1WqJxGKsEl9PYlwd?=
 =?us-ascii?Q?y4qWqHnqHUyQ5EYl/gCr9afWO9Yc4FahsFYKiVtcP/AQWEHo88hS9HA1evvv?=
 =?us-ascii?Q?nyQWpJdjDHeLtPwC19g0vQtW79YDWF/B7GmFgybkA0OfMCXuTTxJ9L9r3uFJ?=
 =?us-ascii?Q?VHUzNQAR+foTzisr8rwDpjr3i8f3z5j6Nx7iftoO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6ca3d-75c9-430a-c4f6-08dc7ff8c802
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:46.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOiAwRrpeItc9xM4ED/wCPX/aOOT1OVXsBDf5rA+mVKQbuM2JSHt1T3EWWXTvxzuKRgvLw8w/RNLyja1mNiPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

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

Finally, we also use the skb->no_condense bit to avoid skb_condense.
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
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 346 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |  37 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  44 ++-
 5 files changed, 420 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 41cb8f831632..19691917682e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 3c124f708afc..516054e480d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -526,4 +526,10 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
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
index 000000000000..f9e63923a142
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -0,0 +1,346 @@
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
+	struct mlx5e_nvmeotcp_queue_entry *nqe = &queue->ccid_table[queue->ccid];
+
+	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
+	queue->ccoff_inner = 0;
+	queue->ccsglidx++;
+}
+
+static inline void
+mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
+			    struct mlx5e_nvmeotcp_queue *queue,
+			    struct mlx5e_nvmeotcp_queue_entry *nqe, u32 fragsz)
+{
+	dma_sync_single_for_cpu(&netdev->dev,
+				nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
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
+static inline void
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
+static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
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
+mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb,
+					struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
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
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
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
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
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
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
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
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
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
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
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
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
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
+		return mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(rq, skb, cqe, cqe_bcnt);
+	else
+		return mlx5e_nvmeotcp_rebuild_rx_skb_linear(rq, skb, cqe, cqe_bcnt);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
new file mode 100644
index 000000000000..a8ca8a53bac6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
@@ -0,0 +1,37 @@
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
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
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
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return cqe_bcnt; }
+
+#endif /* CONFIG_MLX5_EN_NVMEOTCP */
+#endif /* __MLX5E_NVMEOTCP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index c9be1a65ed8e..88d8fbf24c89 100644
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
 		mlx5e_page_release_fragmented(rq, frag->frag_page);
 }
 
-static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
-{
-	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
-}
 
 static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 			      u16 ix)
@@ -1566,7 +1562,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1577,6 +1573,13 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	skb->mac_len = ETH_HLEN;
 
+	if (IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && cqe_is_nvmeotcp(cqe)) {
+		bool ret = mlx5e_nvmeotcp_rebuild_rx_skb(rq, skb, cqe, cqe_bcnt);
+
+		if (unlikely(!ret))
+			return ret;
+	}
+
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
@@ -1623,6 +1626,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return true;
 }
 
 static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
@@ -1646,7 +1651,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1655,7 +1660,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1869,7 +1874,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1916,7 +1922,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1965,7 +1972,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2011,13 +2019,18 @@ mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	}
 }
 
+static inline u16 mlx5e_get_headlen_hint(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	return min_t(u32, MLX5E_RX_MAX_HEAD, mlx5_nvmeotcp_get_headlen(cqe, cqe_bcnt));
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
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
@@ -2440,7 +2453,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2773,7 +2787,9 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
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


