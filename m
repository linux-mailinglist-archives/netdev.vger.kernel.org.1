Return-Path: <netdev+bounces-99106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B58D3BB0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA722821B1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F41836D1;
	Wed, 29 May 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSt/F+/4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9346364D6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998534; cv=fail; b=MMNSDTEqposI4CKeajcZboKfjcT4FXxBrrvumrffVmAuJlAIEvmghMzkIiedHzjWqIkD7lNBPBhVQbUiIqzy4t4+PEW6R5UjaL6P1tN4dct9RAHhP6Sju5EsRbU8pAmyA4pTvSySs3RJhQYe7t7lsbYkwgMaIs4+fd9SL60K1Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998534; c=relaxed/simple;
	bh=fG0PqiKmvKjVUyTkQyTsS/HTOS7Z1/iNZPt9OQ/QVHc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A66kNPFxd9aMngvHM/vkrOldZ5O7wvvdJ9d4LUwuBZE1zv27irUQyo4OGvVkLSN0FqFlNm5oO4D2MGQ0Hc8U7kjVipKsdFCz3hvIf8l/IIcozVguH4WIw8XaagyS6W5QFoBCF0teGgUZLU958slhOfBLQaBqis1nR/wS6sC9f58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSt/F+/4; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwI9YinTTcsg3v3lneqJztWEyqGH96S+C+YdDX0oOqh9xCJKclshXxrA4uQQhWUzoUPREHz8JyBOzolcdqWfp7d6nAri6PUIhMiHZtAmB25ho2s6bFKweYBDxAR7Y3QOm9bNWfGvw8uvkA5Thr7YkSu129yeCufno/wW6V5KkSVPZD6Z69x5SJD06xtu/ottKYdJOsTzqBKXlElH7IBvwfwaVtjCuQol9CKLd1m34+litujd4cvJVxWoc9P1mSdf5JBRG542ll85fvYd5AA1rCJQ1dP+RnI1hdjT0NgjfhavIiVO8ymI0R42idqylaaEJSbZ06t01ti4Fdk5P1Vfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PYycI9FQYHLBojLxyxed7ueqbRyLWDhgnvBJ0GI4G8=;
 b=WtVhwQufzKBB4dzFXn4dNdil+mU8Iy3l5M20QcfSose3YxUzQenPNwfDTvPMxlCJGK1RusqbCMG54vxThaYrOg94xEEAy37m1PHlue1yvHavGHn3uqDJs11mrpZNXG4iTfzvayqdXAB+iC8qLgbgjftY5LnTdVQav8lQTmFpkDPKttm+/0kYKRUux8iPbWkdpp3U5eX9I5Lsi4xzHsev59ksBvPDp47mos+ZlJeX8lZNzRUFR/Izlws/no5y2C+FDvsPr2DiIolP+FHRbZheTO7efq9HiobY+6Y5EdcD3OnTJA90KlUJA5OkFEcEhFRVc6r5uUyhN6xF9V++w4mE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PYycI9FQYHLBojLxyxed7ueqbRyLWDhgnvBJ0GI4G8=;
 b=bSt/F+/4PB2vVhZRROZSTdFuESj+Gvui6TFGfugfBeMzsPwLUqLS9a4m3iuTnhtt6LsT1xMRW57Ey8wI2/m18RvUkgIM/xCKRUxC+XwZUJVbMO1Bs3uxyNFl7FBMNUARzq3va93eA9shbUZdd46+4CCf6MmHkL/3T0Dzq+IuL24Wlnwz2mBwGH3i3Iv11KpQltYQ1FmVPIHeRccRq5J8y25D7lMbEyFO7M9Kw0Qus4YLNpGZ8FyXXOJ69JLOErU0yo0W4ddngjcgrjVFw9eYj/2CGBCBS79gYFO2ln/dnAFiWcQlHmDifBtJsdxmOvBbed/DR3ZOZkT6g793k5IePg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:57 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:54 +0000
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
Subject: [PATCH v25 10/20] net/mlx5e: Rename from tls to transport static params
Date: Wed, 29 May 2024 16:00:43 +0000
Message-Id: <20240529160053.111531-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: c8472c9d-fc66-46f2-30bf-08dc7ff8a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xmf9V1IxXMzuIr8+TjumcxNWM6wthEDzfVY6Tuh9zXB0MU9oNAH7FbiEO7YA?=
 =?us-ascii?Q?7CY9pV6VHRvhjY8IJEaLB/ubA9W53VSHX1PNR9CKZ0vaFJlfd7wbb8sAKn/D?=
 =?us-ascii?Q?OP1bW1a8uF3dXfp0HEHlKnhy1cO8A+/N3w6X4pKC9Yu9BAMfAHS8xcBlP3fe?=
 =?us-ascii?Q?9A4CvxpRVIjtiUJ14FLik4PJGsL8WprE8LcR7Wrzlv9RKGBZJH6Cl8a/p+gs?=
 =?us-ascii?Q?3PR/RVEy2biJzOUlKipPogqIK66neFSHwtOVqdBE/Ra0MMbNwArj3HpKkxiG?=
 =?us-ascii?Q?OplOXHdVAotcCWRQXTVwhn1i/OlByt49pFIjFDPl+I16pdVELFtmEPNQZ2FT?=
 =?us-ascii?Q?eqj87p/FWTuXt3qlL0WMH5i9XAhTK3FeI/5NJMbidV5R54FxC2RadiADCENR?=
 =?us-ascii?Q?TksGt4R552GoG6fjXXwo1WFtbm1i+jvD9lLu/b+xiFJX3z92a9pSrIYrJ3XI?=
 =?us-ascii?Q?sHMn43OpHdtJYz+7uJ6iQJgUAv9tivDxHU5ejZh74KtGWld+a5r7RNtidGJT?=
 =?us-ascii?Q?GHnMvcr9v4HdskUBpqhLGdzdIiP/lDhb8tvvE3beZxzG/Dp5eNIN5yf2D805?=
 =?us-ascii?Q?WJ808cge9WiRlohgmhtYFn4ecUj05asCkjKgFSeg074anYLaCLiHggt2JPKs?=
 =?us-ascii?Q?kw3hBe1VQ2/WqIP/wm8wlo2m78XkqpXWUB+7h5+EKrzKVffs0KLKAmIPf9OG?=
 =?us-ascii?Q?SqmtkhH+tWYfOUNYWSJRwlT45ZS50pSkE9mbz+51BaI8RyPQg4K3+LpRD0eZ?=
 =?us-ascii?Q?3QrwQ6giv2j+Z/UDbbXr3GEjiE1Cd0fxoz70xcIw9tUTL8HZ8vFdT20/iPAG?=
 =?us-ascii?Q?3q4W7IVx7Q+jbN02fnJ2NTkgmRjLCMsXWCm76KCElbuLW/zj+WsNS7N5jzO4?=
 =?us-ascii?Q?1IPT46SCyFzGhprwB1Npo0RRZgDsEVqiH9VwBArRV+KosAP7l0xwrOJemKU3?=
 =?us-ascii?Q?W4H/jYsXcau6LFf+HdQyIzmXkyvlw2OMy4O0+y8d9cobgDa5awKwUse8GNGk?=
 =?us-ascii?Q?pJz5QE2zUZth6xC4m2/gbvpHSD58wJl8S7IK9WuFvXWY277aY/rJU9D3lZEC?=
 =?us-ascii?Q?xMo4kHCLIb1bzeoBqN6WryI2dgp7AKdHTWd94cuaQy+q4oiO1qVjiRyiOWb9?=
 =?us-ascii?Q?ZJVBcZ8cOV68Qpu7TJXNfrOPdmKHl2BN9Y0tiiCO1mOzAOn+r0XPPGwy9Mf/?=
 =?us-ascii?Q?xGPTnd8F0icxOsNbC0c5oBUqa3wU14AN/EvAYAx/fmHd8gl+/Tw6Fvn2Yp2B?=
 =?us-ascii?Q?f8ltkFgFRiLT4UiKbSeI1XU9DpIQRbjfqiNaXW427Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sA8kkO8cYneOvyo0KeT0LwzjmCK/+rumWm6+xnGCAHAU92nF3mDavWu6gAbA?=
 =?us-ascii?Q?1Gde0fqSiE6E/V/M/mVAEgOjiTCjgPmUCQ76STot1m0909k+lYFU33FL7gN9?=
 =?us-ascii?Q?IzjfRjnNaTzXDC5MuH7KkZft1BJoTx4N+XYj/3QY6PNo7H6aQGqKscujkrxk?=
 =?us-ascii?Q?IaXJMlSFPS6qpRtbPp8JhbcPtwWxbfBmnvGzItraGYqrBlk4WBfWEVfTbDXp?=
 =?us-ascii?Q?8UhmodWbYppuapF49oeJ3Ne1YwTaK9tQx6Ae4QI+Ow51Kd55Ti0epNNXsVr0?=
 =?us-ascii?Q?NRKK0R9BSOrdB2G3eqldks+ctXNCADJbAQZzms7Ibs2aQyPjXZMJFRY/ArC1?=
 =?us-ascii?Q?NEmr1z250NbqPhvXm2mfAfzf67dBaPnjqRl+GtjJSi+4ONhrobQ5VswzJPQp?=
 =?us-ascii?Q?aepdFtifQisCieJ3E96S+EkcHVeudgLw1DzDHtuUK8tzqU4GwX7jRELEaxHy?=
 =?us-ascii?Q?YIn//gmsspQrvFmkXvRqDwBpR5qWialFHX3aLjB/Z31XzjDrwx0U1C4EASBf?=
 =?us-ascii?Q?o2WI/AyaWdSaQ6K9qeCbcaDeU2F/X58+VTqa4AjLW9tk82g2eiMS3icjlUuN?=
 =?us-ascii?Q?crIcwRldc71DqulPFcs5YYhCAM8+Qp+zC1UV0J5GGnKiJw8XZ1j0C92M7xYv?=
 =?us-ascii?Q?VYxzyVezIvGZVSlw3yINevn5Rs5VHa+csBPk/k6LyPt+KhjVST6p3IYi3eOO?=
 =?us-ascii?Q?wvi0XUhdbFvQehxPMLL71rx+b2ee7+YdHEM4XYNcVX0uqIb+XOKamlYiQYlr?=
 =?us-ascii?Q?5mkSR+3P01BxW5cgHVPtXiEY8evpvCE4ZkHpA/yozHG10Z9gn2/nRzNjgHrJ?=
 =?us-ascii?Q?7e3tRFOd5pyoO7T/5amWa/HjW/PQGDFwnHHA4WgPPPt9OaFoLcIO++qN+eTy?=
 =?us-ascii?Q?gXyL334lLEXtfEqmVZggkYsCRfIYtgjJhA6ZM38aoZwDnJ/5OIi8v7KOwZAU?=
 =?us-ascii?Q?KklU3TpgCJHIvf//8YL0HX8aEleQOaFDwd/PSI08UnTKqcxtv4d6uYNlhhnO?=
 =?us-ascii?Q?1WUZunzyX25tg4BmebwelP9C0iXf/Dbw0qo+oblkQiz2MSn7Q8TuPBRbP3hl?=
 =?us-ascii?Q?wmFIgOoSzRz5S0dDpOkQXSSauHNeVmFWgTxgQys1g1V27H1nACa/AKymF/UL?=
 =?us-ascii?Q?trKg/M89334SWPkBXjMAeKDwBYoc5OFXgiV+5QqVDoVPVDPNyG5u1VhiXX1z?=
 =?us-ascii?Q?4G6w3Ju8kNA7T3gZ9SgPFzmThMMvx46ZMQSUDfLORr73ayAL0fwzH36gUHG9?=
 =?us-ascii?Q?hUF656c32fxYj2DZwLXAw+6Mifp4sZ1ynwWLN9400/iWZCu2gScdZBboLfa1?=
 =?us-ascii?Q?0/oGZaprpNk1BqFFnIGlJQ3dXIQi7q2gmQQRJoMCWnUUTFuiWL3OW6eQMBZF?=
 =?us-ascii?Q?7MsaEayM0sKEezIIay9Jp0XZX5nW/T3/F3YC+FP1BklMZrxPlGdIPwCX5+PA?=
 =?us-ascii?Q?WnE+J+mbahJxD6jlLpykx6zjmSgQuhnL+zCE4mN9f6aivyVnUNs3mNLutU3j?=
 =?us-ascii?Q?j4OUkPUZUfAZHVy4UU/1mQ5/XXihSwMbZ0VAyhYHuq+lPQPopXtxxFoomqwl?=
 =?us-ascii?Q?nSDN7q75TkMYvStbOycWIM3eaB3oM65UIb8O/PRD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8472c9d-fc66-46f2-30bf-08dc7ff8a904
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:54.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ky08/EdDTsk0OGOOMgVQEhd3CeIoaj+Vt8uOeQUfuhNwrVgrSUj5zUH9j3oXJnMy85bc4nzW67nT7Yd8yKzoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 32 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 36 ++++++++-----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 ++-------
 include/linux/mlx5/device.h                   |  8 ++---
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++--
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..efdf48125848
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..ab7468bddf42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..3c501466634c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index d61be26a4df1..0691995470e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,7 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +550,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..8abea6fe6cd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,25 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx, initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +76,17 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
 	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					     MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords = cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7bb31d9a446..2c86dc56378a 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -454,8 +454,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -463,8 +463,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f468763478ae..00283c18aa0f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12454,12 +12454,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


