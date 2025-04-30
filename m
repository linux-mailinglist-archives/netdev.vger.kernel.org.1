Return-Path: <netdev+bounces-186977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74ECAA4623
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461EC4C4DB6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98121CA1E;
	Wed, 30 Apr 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sp5bBAll"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BA21ABDF
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003527; cv=fail; b=dlPG9vAW+WwS/yFsebwdCvlSbbPEoNw6vHjEcsFl/wdO44/dRSWlgyulArXP/TbkjcBEIEX2hcVy7jkDOnFb9NX4QqEwFwBRhviTYxxnFpAZxGqM3xwjfFuUBBRGMhqfZGAikFM3glNvxVKwPKSXZh1vDlOBxghyYZFbTfAWoGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003527; c=relaxed/simple;
	bh=s+KbnByMn6H3V2NpKvMZ43mTPpK5CZH2IQf054mSkM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkFFjS2NBJ4KPF6T3xeAcW8yBzZcS3JAIUxw4+49ZIb8Nqxn+5us8wQ8ZPAvFJSO0tQRfRN7k7jV1CYA1v/YAMGJBJCz3X1gzUwkcfVuqe62Iqra+dF7nZ/EYcgorQmW5xTy+ZuuIGYwjGeHSfjp9BQYB55hIaZE1M0PL8FZL74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sp5bBAll; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNzArYQr6Yn8Q55Ts6nD27pWFwNzOIoCB6pTT08j2+xq3hYoy4Zz7bznNbBiwJWI3BMaQZqsNTpmnCIk/y1Q+xO42tMBd02f9n2A6C0Mr5ByQpkfr0De9u3joF3r6PJpx+Jd8xkGm//fHzerYiR6YBnHdXCs5rd5jTBVlNBxEmUApeYK6ueew7MzYILR7uYyY01jmB5V80GzXpqOElTiHPm9SJa+TAmPsMUXs/r9JTgdKCznSELaIYzFF9Yv75a7/Rb/+UaoEsEcEuHegadbylUWFCT1fvDRwu/lzsZK1l0Hljbklo9d6Qf4zNpxsX63qjOOvkVVyRNMJeJAnnvMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk8cWX6DVsKCJ+gzpgcsNHaCYwWmttugAAbPHnTHGyI=;
 b=msrQbEsDG9BmApBP3unZmDnZw8pe8v0RdyiRC98T3SPmbfbZ95XmQwdWWeC907xVQuVT6etF30lec6Y2P84xXACgAMYnpSfeXh6gJTdNPyOt2r+dDwXZXd7kwGl2XKflhgpJaeCk4pFzp8mTKaBbmIOCi3jqmChTgtbrOCiW9wV4L8e4+r9fwBT/+AsvYQ9k/AMtL1rCV/9l6JcpBmj8jBQV41Ca+JCtgifX/jBiP02z1w1GFZZlpaKkpuInAZdFfuDNpXu0vX6q87r9FVh7wKQStIpk+S4i7VjC68gaIPO2EMqazX2joqs3f1qVzVBMO3TE5b2fEQGu4YNj5fBwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk8cWX6DVsKCJ+gzpgcsNHaCYwWmttugAAbPHnTHGyI=;
 b=sp5bBAll424ju+0hy4H3+e2yLPxhu17j9tVLdR5/6E2Fjq4ILGdwqJ4+iT25UqWWD9mR51WKpg5wAVBZcQVNunEHJAumWsKs2HDT1Aqld/pGBBFmfe8yCQSlTZSRxdcyaeuvPcBQbOw1XYdP2EpVlXDD+DqY2qbcdLVTnDJwWYA1wVK+P4ywdlh8HE57Rkdei5frMTSjo1qhpAtkpuyf9mqU3xksSTgiTXlXBScAqoh2Hknd9zDn5XbHQzh2yvjQQ996Rr+/mhKJyXdOJ9mE35P1IHWKQzsCRqaKHI7OEbmau1ItAPIRe3nkgSgL5ZCNoR9C5Xb3JsN4ajXAS5f9gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 08:58:42 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:42 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 10/20] net/mlx5e: Rename from tls to transport static params
Date: Wed, 30 Apr 2025 08:57:31 +0000
Message-Id: <20250430085741.5108-11-aaptel@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: cd380c7c-979e-49e7-442f-08dd87c534b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhQKJjI78vAt82WGYbmc5rXd2sNBJF/1UyrdSR2BoTHgopX5rLk2Q67JbEx1?=
 =?us-ascii?Q?lyEGRGtSPOsUOzYIy8mnBJAdIR93VftBjcF3C17FZkZ67Srh0nN3yG4zaF54?=
 =?us-ascii?Q?VVfTg8+aqGcdN+T+Qi7BcVYPkNcIWskg59jdJuEugyjfN0cdLG/AmfcoxeOb?=
 =?us-ascii?Q?fXCICLE62Et67tOiL7Jg0gpOvi0obxKOIToCFcOSW5ptTZanX90CFNaRVwJW?=
 =?us-ascii?Q?8V4T/81LPFBKVwaQtnDOZxcsRcMMUlKOqma3YDfcPS5Klx9OoVsfWzgZdeIc?=
 =?us-ascii?Q?tPR64WVbYudQX+l+8ewpi3qmObnRTCWZcQGZ2HzMzxDu1CL26K1MnKq/JIcv?=
 =?us-ascii?Q?WsQBQ77TymkoEZIQe+ftsPynN9FqO4OYLEsuUnp6tSgjmxAMMvYvFkN5BvrE?=
 =?us-ascii?Q?7inuipSx1qHFTY7Mjh7t9CgresaR2fsUIvBIMht3yhEe7+dH8A0zjKqAnEgQ?=
 =?us-ascii?Q?WBTrz18ZVyioJk0WDunoao+M//IlqAwDTWjDb74+g2VPVNYAL8Dwl6IRp+5J?=
 =?us-ascii?Q?LtMUToeh2D45z7H4BXLrUb4AZnOF5FqB2UOE/RpaKFs1qVprIwdDRyJ4if6F?=
 =?us-ascii?Q?7Xv1brNQpL9wbDEU8eHGRUnCaS9esKNcfBQzdGVoLE6p0d6Ny0hASHrAwwaW?=
 =?us-ascii?Q?L0Nmwzq3kgn7GPxSWVjYd9JbzQzDf/QMD+5yCcPoLbddsRQ0zmuPAXSRqhNM?=
 =?us-ascii?Q?drh5gvNnwyk5V70dbS8nras0SIIWgXZyolBQoEVRUoG0ekaCmtalnx0MNOyA?=
 =?us-ascii?Q?SocMIc+DKvZdY8mGUfK2QZaZLFoZMyNyxba8WXfNV24Kyzoeir2TsqFrubhs?=
 =?us-ascii?Q?dvfP9UyHyzO9vznlDnk08wMJvS0fO15teQjLj7d+xv9chtxE+lnH4hLKOBfM?=
 =?us-ascii?Q?xItFQNGpHUI+IKYkhjJnpvu9Le2ma9QG+SjS04eOg/X/uE0aUxHsPdvK7oNs?=
 =?us-ascii?Q?4bxAMm0O8vEcf+CXMJBNJMgQFNHJFkJ400Ou8wGtkQSx73pB5EIQS0sjd5uc?=
 =?us-ascii?Q?cxmNuT0ER+bo1XAbvTQeBeU7jy2V+XdWbBScw1xYO7H5PGAkFyoVI1Bza8SH?=
 =?us-ascii?Q?4YP7KXDS/lP6abeCSFab34iw8+iSQI5zwrJBRwbmPhO1zJWrs/3l++3/zD9P?=
 =?us-ascii?Q?k8DLq2DN3EGWdWJQjYKICDQLaAQvGUAGM85KmmKdtzW5IlppLxqsNTToYzRf?=
 =?us-ascii?Q?TGHMxZ52Iv6fJ8jJLpOPuq+xsB7IVZbrXT/jRKKRz1n7sW9SCkqBlkB7FQn6?=
 =?us-ascii?Q?XvsViLEboAFWe0z/F3j26F4RaK9wFE7Eq6SyuTgVux8N9jRD+u6LMASeULeT?=
 =?us-ascii?Q?u+thxFdLe5R1/k2I2I2ITbBfsb1DloZztvN15bUB5tf4kPbnsEs1ch8OSGee?=
 =?us-ascii?Q?wlftjO+jyg1XJwkCviI5j+xkC75MUNImfrQtGYJPtGgbYIzZhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNOagiVgbVG4Ya8uVfN9cdcwMLbqYeEHWXs7FwgdH/rdqX10t9Njic1ycJKl?=
 =?us-ascii?Q?TdwFUmj+BQlg8qk5nfShjRwj+cEeIEGb8yciENReUjPXE506QtkRMfGsuKZt?=
 =?us-ascii?Q?OUxNRFUeyLSoJUFuMUueAY6iG83E4q60uobsno2Zj14bbfBqvX9mU0ouihYY?=
 =?us-ascii?Q?e+Ifxl7zk5bfYuGFnSx2aFKGQlC3rt5IKp/phu5TrdkelzmuWYV/qrZsOP9Q?=
 =?us-ascii?Q?7Z6FoiqioXLCvZbhLgRMZIlHjo2Uyq7Bls7V6syquNs+aNTR2uaNHd2kyOoT?=
 =?us-ascii?Q?Fi9EeJXkVmLfXjo6ttbcdQLYmhYFE90JyIUsYmlqLaTR80VXpYy/DMC0Gf7S?=
 =?us-ascii?Q?dli5FqabfMAs6YASEwFutcrygqpJwB6FEmJRLY0q6VW3BTgFi67X423YcRV1?=
 =?us-ascii?Q?C3V1L90djOBtOdTsEC8yklopnDOSHqwhOnWt3ahrM5MImhHfMWt+DcICxVKA?=
 =?us-ascii?Q?5Ma+wzHuvpPuxj1lvBjmbd0VpVKYR8WB9UHudCxeoB4viokOLZ0BmY1Ig6LC?=
 =?us-ascii?Q?ziQu/i/ijm11833CROJ2Z/xRxrHUHxJJWPtpnYJlEJtuw4e0AeMgYFleXtnY?=
 =?us-ascii?Q?knvYEP7SqzOg0Mze58IlDgUKPmsYKUoRpXOHeUGZqwBdUVYlFbMi5kQw97NG?=
 =?us-ascii?Q?qwMBrjJ1ybH9r+Mir1UvkQT5xOgVNDJ4sOhs5w/4+jqmiEkM+IA95neptxDB?=
 =?us-ascii?Q?ODBeS7BvwQiHhHznCXkrqFQR4EWu9NjheDrdc2tQ/CDHozcyuyW1E1cYSt47?=
 =?us-ascii?Q?3OCc3tx6UgA3Lg5Ynclxr48ad9PITEtCky74lx2xpGgxSy5ZObxWbuDm66nw?=
 =?us-ascii?Q?j0Y2aYTPpJiBKQRqIXARAc9iQzwpM0aU8EN2WjFhUq9TirKtj6fzLQSEJUw4?=
 =?us-ascii?Q?UEl25siOqaoCrwwQ2sn0kSfbBE9TW0VaKzuc53rGXMmFzEeZa3eQD9/LNu/v?=
 =?us-ascii?Q?GD/dA+hRBvuWKHmAyQZeSI3xfbN9P+UWjcBlQCgLYebEqhAFf0yUhYZ/e2Qt?=
 =?us-ascii?Q?aKTieP+xfC+Re+1Kf53DRybmN5eb0uVSE4Yngxb9NGo2wLn4UwWU6sd0k2Uz?=
 =?us-ascii?Q?JQ2IeZjt6Dw2j0ij++Aag7CsopgNfkCbwJk7FcHc+Db5LJfxf9MLIfQgbEfW?=
 =?us-ascii?Q?KGoYLbJU3wajvzKDqGdgNQqOUti20HlrPLCuFiyYnTL99vVLS/ND+XFtJieL?=
 =?us-ascii?Q?rf0Q3DrOnf3qDU6zOb/WUbJf1KfrkNqf1ZqOMdtV1hJKBsHjSLuXRejvzThZ?=
 =?us-ascii?Q?fTChQfbp61ak7iBgeDZA8WDRwidT4GZ6pwpaYnEX+9QlayJESchDc5el65xm?=
 =?us-ascii?Q?45zuInt2sephMOyrzzfwnq5Wgd2Y8/nJ0XROhy9uWbt7Jj0q3Wq6lQtN7ryx?=
 =?us-ascii?Q?AGCtoNYlIpjiMrcSQ1N+171kqqz1UYe09DgOedSZCux6D0y8Bo74UdbCsXnq?=
 =?us-ascii?Q?fCTBxXdGILPz+jGcjHhtEVQbFgZ8z/IzLVv8tGovkRiJD7sRd1r5hsJBHBVY?=
 =?us-ascii?Q?Sjsj1o7N7xOOHJBePO4uzhzfsdc6qnvSt/AFtMtgttQzx8280ocIAlxaFThp?=
 =?us-ascii?Q?9B9fRqN42GQdTYOQ/llBjxaIvMfsxx/jFo2tsOQM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd380c7c-979e-49e7-442f-08dd87c534b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:42.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haTtGx5WgWput9+D+zgTYB89GMTpOa60vWlaIDng8bQg0hir6L/znKc08i72TEBGUIuKt6Je9ZcUwpPkCDcYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

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
 .../mlx5/core/en_accel/common_utils.h         | 34 +++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  3 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 +--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  9 ++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 41 +++++++++----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 +-------
 include/linux/mlx5/device.h                   |  8 ++--
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++-
 8 files changed, 75 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..b3efed916167
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,34 @@
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
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), \
+		      MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, \
+			 sizeof(struct mlx5e_set_transport_static_params_wqe)))
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
index e3e57c849436..6787440c8b41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,8 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs
+			 < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
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
index 3db31cc10719..cce596d083a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,8 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev,
+			MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +551,12 @@ post_static_params(struct mlx5e_txqsq *sq,
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
index 570a912dd6fa..fb21ee417048 100644
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
@@ -53,25 +49,26 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx,
+				   initial_record_number);
 
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
@@ -80,19 +77,19 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
-	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR |
+					(opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords =
+		cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
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
index 6822cfa5f4ad..b071df6e4e53 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -457,8 +457,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -466,8 +466,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 2c09df4ee574..0e348b2065a8 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12901,12 +12901,16 @@ enum {
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


