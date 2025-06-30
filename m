Return-Path: <netdev+bounces-202460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660BAEE02C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CF01884E66
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4028BA9F;
	Mon, 30 Jun 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RG56cJzI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB128BAAB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292522; cv=fail; b=tBI4EfyrV9PJxmvnnQrwZG5T7N+7baMXxDdjPAa7fog4zD6MKB5ODwaZYnHVztZsoh2d5z4BgShngHsE+lAYBfiwi48AljSOfmbvc5EGfi7ExvzU82Go+/DyiAlcfK4LkBJIdiC7gJeASiAeiAvDeeVhawkaDWujEGQevXOIBc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292522; c=relaxed/simple;
	bh=s+KbnByMn6H3V2NpKvMZ43mTPpK5CZH2IQf054mSkM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlKYv3QjRFz8zgseC+dg/sw0Sg3K5QnThdltdAFBTwA60dFJAfNM0MnLUzxCDLl6nRx4fKHfOoJ6MTYmnEcfhaHd+F7s+lwnT4GBLHoQDw7bw9rhyr/utYuXLsXJLPtpG/hJ4MCcOLu+guwZxZb5aaX/JZKFoXrpA218+s4hCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RG56cJzI; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8BmZZsBBrVu33MMB5A/M6XwLLZqxDH6vYc0thXyCVYXXVayT+qGXXOPsSMGqUNG8YStPICUm0GpbVJaj3u4rqhrUKPxgARBgTVEmmX9mr0KzgI56GWNrs6lWLoaTJa/6Ixwpw3dtfgNCkEFqFU3RZnhoX1ZfEoaDWLfLgpRDbNd0H84NyhBerYtxOr5h50SuZTLbb9/V3c85O7M4Diq8z51xgPNW/prW+GdnSGGw66UWeOTAupTY1Y9FafqOpkFFvE2vPTRKQ5rR6p7D2EMWttcMAiLfuwujqTArDaXpyrI0tPyC6TjuIN8oj+Tn+0/RTyz8aLcM3+sl0Sq5FTmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk8cWX6DVsKCJ+gzpgcsNHaCYwWmttugAAbPHnTHGyI=;
 b=psFOFPA1qQA18TA0azSY6G5P4UGex6yLf/fCLuoiPOHzhikj9eG+EaZ9ys8CpbewRfqIh6PtjVa0TXL6aHA1ZhQXdilS+hXB4e95e7UceGKOK3ct9G5SOYcRzIqCx4fyz3cyGmPG8cjIGgyHrl0sZ+9pEMd/creIz9dqiwLYOr+cFOfzvTfxIFmu3181Kr59De+w1Fj0qeA2DW3gmAdRWsFFprJMbG8RiXG6n+MxkAVYEeMwRq1Mrwb72pIvpyy3F7lVAjbe8CVYWb5eAZMpPeB4ge2MDMk5Gr4pLOrcZjDgpIiWu41RoVLjXUr+5DvZ4tnz2qTElux/4ywfekvvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk8cWX6DVsKCJ+gzpgcsNHaCYwWmttugAAbPHnTHGyI=;
 b=RG56cJzItPACWbCZL/98nCGzIpozxE2aDhBuvVuMJNBpZvaU3PwPi0e0ijDfnRwJAbcX5uO3g85ZTlgJf3l6wIMvDCvMDqzxZgrKWy3Vzcxf+P3gNRyQ/F3sTzOekttqbmgTuBJWvERtGGFJLsENyi6YYmEtwtgoGuN7ezL8TIIXYSOEQdSt9cgQfMxCuw7XHiplaflGatvuILcyxxsxwcF6HBNz29C67DdcwrVjclgZdoFt0DqwCw7DhR6l3CELgLc7I5FqWCrITc2Me4yu6Ei6WOdJs/jVI+rVX1ehDpLVoH8rJMWjsldD20px2Plcp16Ta/AUWrEftAsjkZOBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:37 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:36 +0000
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
Subject: [PATCH v29 10/20] net/mlx5e: Rename from tls to transport static params
Date: Mon, 30 Jun 2025 14:07:27 +0000
Message-Id: <20250630140737.28662-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: af1a2cf3-8683-42c5-89e7-08ddb7df9b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7oM6ZaEOD/kwGlEqHX0DKPNlDBNvCm3HAkSkWYh3aCey3h6krkcPxNg37Fo?=
 =?us-ascii?Q?L8JOult0QysFtl3TNLlYSq4cZp41g0oXJ78ZxfWDwIRH2Hu/gOVDfM4resQ2?=
 =?us-ascii?Q?Icf/Mp4r6dN3mNsj4FQVjAWuNGdxjA15/3ROH3VdYvNuACxO8RFfesKP6jLx?=
 =?us-ascii?Q?biWCykdAKYJl9BIUS7yWdyIsYvnPKbA4rSxPr2JS9Ih2FbN3ekh5pIh2fDp/?=
 =?us-ascii?Q?aRcGrmcpVxCX0PVxP/AKOsQtZSolQwo8AEcq7D7Ygkvn7ZS2DNHc+Sw5CYVg?=
 =?us-ascii?Q?pkErUs1XeNTyymmsQQ7i11r2YYDFSu60X1U2S07ZTM/zQFti2zGYFEGBEYZi?=
 =?us-ascii?Q?FhDo/AcpBbKvMg1wGqYN03VsWf/yuiIApb2xnvIgLHju/AHFxmTpG+rP0xs7?=
 =?us-ascii?Q?jGIzx3mVuGpasJ/53zZ7nC5AyG3P8TUtdbkzsbeTrCbJ6o3xLkSl5kP0TgSE?=
 =?us-ascii?Q?ytPjtBMnaP6Cv1iiNQONaqV+rFYKNF62zkiXSC74KcoaiQMEZRLK4FRm2KDd?=
 =?us-ascii?Q?qF4xxw1nUggGpZJacfq1Om3uEnlJeXi69gI18fMge704COQka2D3zZ1CP1+b?=
 =?us-ascii?Q?iBRdKWigejGUu+yhMQLnM8bZ2vfsdP0KirYrcJwj6bPfcWusIrYwefl5+qVh?=
 =?us-ascii?Q?VOpy7cF6fDn6We5jGE3tAyaLBXvIsqjpKnG/d0VjjERkMXHclAJe91DnoNHu?=
 =?us-ascii?Q?b6OrqE98YrS4Se0P+ajd8K76wBXgurJ/rl0kPlhygXiyBi1SdlWUeZdjD31i?=
 =?us-ascii?Q?9EjdXMDw980Hkv54QZVmdHEhkqt1x3bTwS/xn2+FMvBP4J/cWq5DtGPH3e2R?=
 =?us-ascii?Q?q5ZviqvenRXkLnnMSIyXoQhwnPgF7l+GoNrvVo8aPWWOeRNhL7NzDkim5c1x?=
 =?us-ascii?Q?fPyLfrF8KnU9L0XAgUaotnrVAbJ4P7ylxHg/NcY3QlVNLs3gPejJ3TgZmir1?=
 =?us-ascii?Q?49h94L/llJ5t7TfXJ5TA3xLyzbUYsqho4suDYEQITdQiKGE2MKiM9bvAkhNc?=
 =?us-ascii?Q?6Ggr9hicp2JWV7+F+XWpillrQS3qKRJOnQNl2R5KWysf/6EvvrfxrCJzr7sb?=
 =?us-ascii?Q?Qani9pGTSaAybyxVHibVuHeBaX9P1MNaWxPiZ81Z+/YRLji9Mh3oEwZ/S327?=
 =?us-ascii?Q?z2WVtm1trJck0fgKXX0TeT+ae7R4skISauMwZkZMnTulXtM2OUi6o5TU8NQk?=
 =?us-ascii?Q?5LEUq623ClTv1Myg+c5vN1N2AEdVws7eGOVLRwHPEa0dwxPpc6P40iAk0wIt?=
 =?us-ascii?Q?WQBCrE/LB/jffmKn/CNSdbknkthPVJmKEre2Vy09vZ6o7rH8Se6GsyCanwnN?=
 =?us-ascii?Q?R36Rux7N6az6QvbAz1jSMCQ+7CwL0i4wjYrXC+LrmRdaU5l8iBzNBowvqvu5?=
 =?us-ascii?Q?K1H4LfQN05NJJJLEcEwMImfhlnDhiADBzeJniCuaVJ4hHzFVzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ocN3DE7kRbyilOnUJZl5iE3/a+COAisld9Q0u3LvHsEyXzZA6HxM4PPnfBZ?=
 =?us-ascii?Q?4XBQux+aCSqSZFua+66KPULzVmbXa0Ibbs+1rVOFLKRCpCw9AVZYODxOP3bR?=
 =?us-ascii?Q?qDcEATsSmyuH6sqJYFk0vlWUnpwdSgauDjixFPliV95ZGdUuPH0BRS6Y1uCs?=
 =?us-ascii?Q?zcjgz678tGYcrHfm5hrhIkN6wOgjztqrwJpryQTYLTWZ/Uqg+Xlf1J8HWQgv?=
 =?us-ascii?Q?fP9oWuxYO4cB0Pm6HW5t9S2+JokJWiV1Cy7OG2BpJqHDb317AtWeiOcXaopr?=
 =?us-ascii?Q?yvsbOlFgL8IEfjHC5uPB25OLs7b5frxBoopdnIfXsw+BSeLWQfNfn1aVOnDA?=
 =?us-ascii?Q?+UUuHngvHGCEBrHij+DK8WECP22kWiXbtZGEjVvTIWVJIPTn3PkNSQ8ty+ll?=
 =?us-ascii?Q?I5DWs5KrswjcuneWuPSOwgt1h0xkxUDsfc4b9ad7ng4jpi27c/gaIF1GP0Fn?=
 =?us-ascii?Q?zwGPDpkVN9j1Kg01VbCUGkJ/wbI3SRih1YsRbKSqyMUMb5UawkKRGkgAhRei?=
 =?us-ascii?Q?skA0BJtadMi+KVSvMD9aige4iHQRlp4h5wTAm05wS9/WUhlK/ts1cFkHas3G?=
 =?us-ascii?Q?v6KIcNK7zu8QVqCfXtVeHwy8wslG6CSsfcmlkH/eb3SSWwu4tLLRMmJMzPyF?=
 =?us-ascii?Q?ujvJitKW6kbUqF2DEi7JjLLPGkD8cP/E+fqC3xI9LkKZvTamc99z7SgkX2k7?=
 =?us-ascii?Q?8/ZmpRldyrmLD3DFZ3Vm+kRAx0de0Tf1VhgO99nonCHf9fOpMrGAiB98ElHK?=
 =?us-ascii?Q?RSk6ydn2Lu1pz/DUKl6T0JPxKvDb/D/v34mpNMY69nDK+4kzThHaRerhH9/5?=
 =?us-ascii?Q?Xwz4x2agCir8WgQIm7nBfGe+oR47E4JExAaplXv/hwh+1XkWefXv858n2ITv?=
 =?us-ascii?Q?eQQvY10fsF6l+vAXR8rKGwhOMhC7hdf50wfsIi0XgfxpMcJH5mqzKFGwkEf/?=
 =?us-ascii?Q?HK3uC9oM8PMEoSIj9FV+YpiFkJAQx7x+1BY+JszLIDyxPyFbGDybbeZHUuZ5?=
 =?us-ascii?Q?m4yGWe4EaQ2eMQIkOTM7czhBhZGWtJiO86aEc/gNfmU1Dir81reHkaIS+06p?=
 =?us-ascii?Q?w/C1L8nMzcwQDPpDeWsNz73nv/07Wc65KOt09nKnRb+a2HYieZGkds630c5o?=
 =?us-ascii?Q?S744Dyatxn3OOYYDxB4Ry1n8VBy/LoC2AALqiTiOrBg8O2Dta2SBO9wuB0y3?=
 =?us-ascii?Q?zrHl6UsfckGohWEO+1f2GbSzqffI8Bb9XrZNt1AOLclqcHPk3kwuh+7NTfQ4?=
 =?us-ascii?Q?ktCVAZKYmdY+N8giA8L53rlYym+GcVh8PWBvTau4c6lqYarF3MywVTaEDCrY?=
 =?us-ascii?Q?+MQZgCYs7YA0Qr/R6HK6Lcr+5zmVqaNITJWC1/3N+hHCySHKo957L514YXJA?=
 =?us-ascii?Q?tPzRGN7q31xq5OUhvg6R5/XLhyxCLzZ+sQXr7k7MsMj/hYL2cvKpulOhDNNj?=
 =?us-ascii?Q?rTFOrNRyObnpG1NRfijhAOmINoSm8RUBGDzEFlPNYcWdrerMjdPe6r73q23N?=
 =?us-ascii?Q?UssVy35Mh6RopaydA0q/1B3B4tDQJvJpo0HDJ/gOhF62asOuoPrsDxjBNu4W?=
 =?us-ascii?Q?JmJCZG8uA115kgSvLovZu2T5+v/d9PR5ehxghlEs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1a2cf3-8683-42c5-89e7-08ddb7df9b2f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:36.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRYA57qIqTw64n3ZwDqLu+BWO10kfxVZy0nB5H1mIN+1BZlCefC0cUVuaaYsuhvatxan7uHA1NsNE+vL/prgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

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


