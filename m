Return-Path: <netdev+bounces-99111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4688D3BB7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE531F272AC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C5917BB3A;
	Wed, 29 May 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMEuEg2h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183918410C
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998561; cv=fail; b=i4o5M+whc7tm79/J6UdaWUhwHL8NOFYJiPG0C93sQ/ZKnw87V/YiKDFyanzNo60hcOP47danHlslADuxIN2hhntdjiKQqhDzciKASmNojFbNNiI7nwyvQ7obShfjFCysRNQbL1Ay07lrkMBVMuQtGlxndpiuVR+sgudhYClHSm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998561; c=relaxed/simple;
	bh=LP/W991KwvVjZxLNerbhUQxJuxSIJzhoG82UwwstnYg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U35a2/00fTt8tuTXTrEQ098THYxmFN3NTx3FTTsr6n4E+viBVgF8LihF/SxZ1FL7at7fNS8gSTzeufjqNDhfCggYtn6/jSf/ua4f7YjxdGFeccpRaP/CqH5fTuCn3LXw4aT+70En8D4x7Rg7sGRcTQvhrvEC3c+rn1ZJ4UfEkTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMEuEg2h; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E874R1M3xBbgN3Q1GbJlccGNsbMHC6rGIkboAd8PVkCbEK138RLfcyQEabsj6JYuGtIIUNeNbHMb0elCBim1Mv4YUEr34PA19Gfpa+dhaSZYVO0RNGOHeh9dUj8P49mf9ugjBXd0gyQZhuPrQEIkJJl7OeqAWIEyU9BOYwuibHrsyrV809uLAt0NG497GunzMQ+6WP4FoXI4L4FZHKxymLevwkCkIEfweuv6VubOtriMO4kU9vAoYZy6FCiLcaCNjrnnV9DGTROW7i/ttWUDPf1wvf6AeUg1eMpsbSKoL14Yi/bdEptvgf1zvZJrjXA7DIWfUPnLIFU7J2AZrgh4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=Xr26xYXv49ZT75pyBGX0paaN4/2AA4VZshHDHILB86mqfVoEtAN8B0ZVivmjhA647k+x5w1YVWYtyviiYeWO2yTDcut9lyiiwMmhIbd9Q5ApCk5w5L7CtplNsf+7r2q1s5uB4njXQEPqcurk+/nujxqXqIMAolSHjlTKCcFrhWzTvkENVskjfOXFuNMko0wX6q53wCfoEMgYnpchWemJe3VZh48oOwuOIviwLEDcVtB+WExQre2LkpJgXh3sMh2wTrPvlYM0BnJd9jhs037tv4dtZwH9gcTEZOdcecGgFUGt7Bi9j53MflSzoinj/O6BKFmhheSyLHFshrJyGdHS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=fMEuEg2h48VtAkZp89ZjyTplSU7qs5b0pT3K15VDU+KDG2mgycImg/1hX8C9oTPKYpK89k+qn09fIQJcJyC2tz6OT2LeR86q14PjWMLYlH/7D226urbqRm4sj4SGUGbvFAE1qqcldkiZcKlyKRIwRjY5LpFMyt1j5k41qwHkRNYE1VP5NFdHe2L3iJ4hhSrwp023R/wowkziPm5sfz6A33Dkj8ihqfLkl8m4zb0ls1sGHnXcXBaKTMU2RkOnmn2vzGXLdOsyEdYTjDpvT+Nj/GhtWs+WZKIXkqmXV+jCISgDZWGt2WrjB3qMVkVNSbWl0yGPv9LYtC2r0/QURqVbRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:02:36 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:36 +0000
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
Subject: [PATCH v25 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed, 29 May 2024 16:00:50 +0000
Message-Id: <20240529160053.111531-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: e399943c-5722-4ac1-3931-08dc7ff8c1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DE5QR4HbMjgYTX8Qcdka4hm/JSVkw2xfgBpD2dOR3ItLaGiuKI7ZDNyV1YLC?=
 =?us-ascii?Q?LBdRp1kjtysjSE3PF5eRQDETvnu/D91jjyfr4qPsPKSSoIAcdePgcHEuG/Gu?=
 =?us-ascii?Q?Jv+vOMkGlxXdN+3OCAaDIH9AlF6I0bgsfwEdMzyqTIr8IaZDmCtbvW9Q39qe?=
 =?us-ascii?Q?Extf60cHGICMgOcBe8blFsRilHub/i3qmKQ3A3mLtN5pXG3sbCB1cNUUJLtW?=
 =?us-ascii?Q?Wway8Oo2Bxb1lpcUxveVze8kl3FLuJYNBgFQwkNVCqZ17r8Q1UG5YTpdsv9e?=
 =?us-ascii?Q?QQFDkcUjRCetiGm3fgZsR3lGMB4iTfUtvU0iuPhBjbMkUkeTWKYr2j8MNlu/?=
 =?us-ascii?Q?AFznlcdT37es7G3NvGO71nnT0r/y6TBCI1ycgqBT0deyYtRANKWEyin+fOtf?=
 =?us-ascii?Q?IA1OCYbNyg2ifqMsk73nynK74y4j8409QU4jzesdqlB6RBwwkbk4TRufT5+b?=
 =?us-ascii?Q?+m1dGdIS74TuU4sAa11kSsKuW+LCY36/ire2qVudvravceVaj3S5S+wDWddn?=
 =?us-ascii?Q?6M2EASr2CeQ+h/6g6gloCIPLYhb8NIStB8Sx0HqRi5xS2U69KcPXIjeGXUs+?=
 =?us-ascii?Q?OgL30chlevVCRFGUOoEstNFDhGL0d1SdpGtaWV22TjT+MBcJGlkSY5ttO9pT?=
 =?us-ascii?Q?ae4lLEe8UZ4HAasFx5AYIHGyt5zIZ+O4DYGfNCpS4AUYUZ58EY0nUmzEQloZ?=
 =?us-ascii?Q?6wxTRC8yDfGj5ZFMxjrhtju5CkF0SZ7lZgzVacDPPvTSDzgTVM6TSqFJbYay?=
 =?us-ascii?Q?807p7L+DtIAUCp2NAjutiU8qxeYXhp0ZgWC0BTeyBE1ocThYTbz82l3WrX9c?=
 =?us-ascii?Q?PIpSeGOGd9ocNZCSlYtOVc8YM444oTyGwloHT0LdWVT663QOH2NWL06cKqJA?=
 =?us-ascii?Q?X2ts7kIWYhKn+gWr1ywP+ESAA83XdWceW4j9TwOajcr3bhnIuv3VhWY/T54y?=
 =?us-ascii?Q?fI8GSPkXaP9nJuOHIXjjVxjIH+pmSWYkWWJkAdfaPlwhVXcNtyiCvWFqWTB/?=
 =?us-ascii?Q?TQZ1n5+mQOffQj5JcFHzDo9mpr3d0c9Mc6dqrDklAMg2Pr0lnOLmxP/mbbPv?=
 =?us-ascii?Q?Zd7UryMMh5JVoOLssei115dOZLRtJkA/pWVBsr7ZDPw0g7mwXVR455l+zZ7G?=
 =?us-ascii?Q?uWqcSQhIBTragA3Qvv9jyHqguqRqbUPt4Ejb+vSPecTNN+28tKIUJ5ubdxeC?=
 =?us-ascii?Q?j1UwFsHnZD8k3kbozmbRJ7JjjiFraf7PV2HcMSVbxzk38NUyzRNcqa0P3QIs?=
 =?us-ascii?Q?pNfE8MR0epmEoFVs4qbxfvJCA4cgTNJW2IaceRKQIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0RB5G9lL+eJwXtZ2+v+DcTT6zrVeFJVDoBoMr3DcbWGohuBLEPnjwmPdID7?=
 =?us-ascii?Q?XPjsYFJCX7z3sKONFcflVvLw+tlKKVKE7fS5U8QUQZ4bz8JiYbUXzdXwfcSw?=
 =?us-ascii?Q?jUgdrq0Mh5bxZ1+ZHt4OUQxHqXOYt1dtGzhFmVWGDy18gobhhiFbOVfalZFL?=
 =?us-ascii?Q?7PhjitEOIrsEyGbZMHpLfsZ5Eppk6Nb8br8f6eX7uO4aBiBjY6bKaOBNbZIg?=
 =?us-ascii?Q?Upd3BzxBbBZoNBP1XdU7tcztTKaWBAwIsFqeRbuuiKKF/FdN65zm1YSMoTxh?=
 =?us-ascii?Q?exRxFXYMcnbpcJWtE+18kGPbE5MU/2gqYs3H2YvqECpK5bDm+dRuYdCau1pZ?=
 =?us-ascii?Q?lKIY3X5NmtJxcPCgLJ4vnr8gzSGYFQLRcUXGtJdyMYUrIUQkGi9SP3Hu0yFC?=
 =?us-ascii?Q?zmR7abey1GwcS73ryLXBKZtGO6HTt9PtFLAgX7wdSOqDVd8jAjVamZOili0K?=
 =?us-ascii?Q?cobY1uxN6HB4hR4ixSRgbtG3kw+ffMgtzLr++JwTW4xTSxrnuvEG/sRdIEiY?=
 =?us-ascii?Q?+hV1LjcInCJpXVlSTjnUo84I4FX49DmmbFiSeXovk0otmWcTq+CZTr0cKOnQ?=
 =?us-ascii?Q?SxNmpes1LSKxcCYwKr9zkVaDF9zdoYD2uVyZANfIFzWZQBgGwRKhBqFs7Xaq?=
 =?us-ascii?Q?0vy3dO5cmrcJyY9McOrnG8+Tw0GijT/xTPd32N/mM6ZU3gp41jzTsvlf7th7?=
 =?us-ascii?Q?VV+pKs5Euo9SgkVkCtB7cT4v1BS/pzpBTRrrjnTb753/mbxk6+ybb5JH1mZO?=
 =?us-ascii?Q?PKhHrTjdX7upJVCALWSrGkjpxIktp2CuzMT03qScxX8JsfR9vBN6AaVzl7nn?=
 =?us-ascii?Q?rlNbzXrKPNOoPc+yrINOIKs11dlfr+4yM8AUKVEW9BSVguB1gPJt9TMJJ1UA?=
 =?us-ascii?Q?KdrTY+xxsfuI2d9qQuCb5yyXo2Y6x4KZ4tC6JdpXv4VnB0W6Us00nW/QAUwm?=
 =?us-ascii?Q?G8tfee0XuuCn0KOeAib+ztgHDGsjnVBx/MhNKzGTccr5ZTfII63WGIdJMtIF?=
 =?us-ascii?Q?JOCaVJo/+LLtLVQGtSiPyHzySDDC+BHhND3yzutrtqZR64v5Loy5SC7M5+B7?=
 =?us-ascii?Q?FyNLdonT8MaAsa0L01yXkElwY4UbZS8HNZXGwkUexDL3jQUS7A5pWLVY5Pne?=
 =?us-ascii?Q?tQ3oI6/4lGx4OSsBWV42/UnBJ4GDmrJY3vYBVd2orI6U0C8XEFBJX5S9+lLP?=
 =?us-ascii?Q?rDnR9lpGrjKx8Fb6zXj8BqouLB87qYh2drG8IW8/58CTG/XfZIOd6p3OXWEE?=
 =?us-ascii?Q?NEN2+v6OnMtxSHVc7B7WIpu2G/8/scQlYxcc6sqEQrWQzA8qjp68fP15TFsk?=
 =?us-ascii?Q?VyGP9oRWnMWxohDseWA37JGYi5o/Us6J64W0guQNtOWAExpWhYQO7WIcKnYa?=
 =?us-ascii?Q?u2F0MyCGu+vLaFudcpnsOmNIHoA9ung0x+zIPDpq/9lc6kOimkZ0R6+WUma3?=
 =?us-ascii?Q?VFpDavPE7CbTn+u3uI6FVfWu7dQOexDvkYV7XxD8d7WdXUvZrrQNTVwiTI0m?=
 =?us-ascii?Q?FuEhgfEIpLRAIRUHQtKP0TPJploHZR4pxBANm7olBabqyStHtkos8sG9bbdJ?=
 =?us-ascii?Q?Sc1kB4xqWq16A29RSUyAvRw+DZUie5VHBTfh0gg7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e399943c-5722-4ac1-3931-08dc7ff8c1b9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:35.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvxRTWXrN7mSFOPXP+l/Cel4SZ6Psq3JhXjU//k2/Zn+ALRml5Ej5VIiAteL4VgNswgj/isyHD74d4aUiXRqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 479a2cd03b42..9b107a87789d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


