Return-Path: <netdev+bounces-171158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD4A4BB4A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806D01714B9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0F1F1911;
	Mon,  3 Mar 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lq1nE2++"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0921F1527
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995670; cv=fail; b=efN2TU8OeCnw7WZ7Z6SQeZd5KkT+6pxcPMk34DfLpIcDaJPuoYXXgkLiEydyZa0108wCj+ivWuiBNgQQUaeH8oRbX2rnUbXydRhIdKq+boRn5tvBQdstezyR/FK+NNCOOG9gKmfisPVpRCHpYk/Akjyi5fJQiAVy22208jIwB+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995670; c=relaxed/simple;
	bh=aRKPpcjTZlDC24qUfnCBgvTtXvGCTZNwYwmC0b1jgMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+mKzQ3Jz6d9syTHrSu6vwVUbWu9Aj5n8WByxMEDXx/0B55L7+OOh2PnsaR9Dj9kvdWKfk2WS9Nk54lNCWWSZhtm0t/NAulf/EcwSe64JSXaaeajGfWEhBkHTcY+sl2bZa+J+bc082jQ39pCWUv/DUVwT1deEUcH1fAeS8My/OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lq1nE2++; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCuT3Q9sOlXkHoQpt1r/oy5yFBwxoF1hSnGKWjwGcwc6gAmM6Ga/+SnVTSVqmjfA68Jod7EjYcm/uGBiQ4Py5R71bd85cIR3JMXuXuYc18uZIP4zzYONjIdtq4aky8oaFRV90mRjEiSrpz5s+KXVNrbwmoZjyGw2L3/n7NOXmp9Yq3DBaXLypbxjcSIQenM82veZJwHIKxAfz2qIt+gOMxU0e/hNw7TRgRoK20/B22j6vuyA3ySTBLZUKnw9EivHwk1CzRBJOOjhRuR5oQyMmRTuplNufQMY9Xb7yKIenqHQvKkGkghAYatkq2TqVrY4XZUrqAeBf7yWjYKkpJIL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=bc0ij8NErt8n0EWx3YWnRTYb1lJTS96PU0yo3mRxw2HnF7+lOvpN7ukqXFsS4hqI2wL8WxI0/nLhXf8j2TDtIVqk3Q2katv7lS8+QVEx/qWbmpSRin5tRb6vdKDwyEoOLa1mgU1EkA6gNJOl69UHH+q+yEKASU4P/Q0vbFvDQXM/zYsdgPBAVFR3g14TWqVh26p/A224zf5oA7tCu075mzD2Xrt7wcYrEku70TCVXBOJ0rcQQ+ImAC6F9c7b5osIQHLs026wC7kKYKfvzOFoS4Eow4knT+oN9BvvJBqKSxR9LrBSRduU+1PwtsM0d/MqbPgiFvQIx2Qf8IptMp9Wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=Lq1nE2++RDQETzackEFXGuHUZq2OPKyM1AMkh1ehMMVtdzhALjRE4f5vzCYcNCnZzcCsrk0RZr9CBTO7L05eHBD2jiPaiQSxiJFFhRa97YUAIPth1XO/Li+LHQPZYDFh6lJ4gk2cJ35KM5VHoiBZ0i2a0K9oJ7YW5lfWolTwMnsGnTbSHbHjNRiMLkqxbHEQpT8iDSJR4BWMVDaRmgjqJTcBJQbK5/ZSf9hCEMEHZrO+oSsG2XIddG3M7pME2nsZT8IFTUVwuv1t2g9OxJH2ydv7GwVXlq7PS1RBail5E+2pSiIPmzzSfFkeQ/J3UxN0Cj0fAMLBNwKdAahVApl3zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:26 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:26 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Mon,  3 Mar 2025 09:52:58 +0000
Message-Id: <20250303095304.1534-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 50836148-7282-42f0-c448-08dd5a39620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GcEvk4ZnBSoQ6V9K0GZ4xLCPZVXVNucXtRgfIkS2CMQM/J/kpYD8JHYyjllM?=
 =?us-ascii?Q?OM7Q+wc+Ma5cE/kFPcWRB3sR/SZ/ohq0yKugo4k6weuajAx5BzXEUPqvxJK8?=
 =?us-ascii?Q?AIf0BuJcRGJH2Acl3tk7Zx0dyz4PNZuLCJzN7t7l9i1ve68VAasfeogddt/q?=
 =?us-ascii?Q?dCYabkUoDvG/1sxAVzk1HQON6JmiafL4XdGxduqhEkEgzx6ugojC5Rz+ErdM?=
 =?us-ascii?Q?sfXdO4WbBF+t0yhAu0/ifOFDZVGCD2X5M6H1bz96wGNKHtukYIcUMoCBCK90?=
 =?us-ascii?Q?8Fvg/RxTJe4VIqbA9qWYBclDsRE/oChZ6ODSssDzOyN5quJ+28R+hrm9y+GT?=
 =?us-ascii?Q?mIgKNwCsJB5Dg0+gUdTeDWxhjqvQH6ZWRspRNuVF3A7sHGlsBl5pfE3qiNe+?=
 =?us-ascii?Q?p6Ns154XSNozKtkpEVijr/y7FR6xzHa/WPIzS/U9ngyi+RZIzZ/43lg5qnxl?=
 =?us-ascii?Q?K005IKs4liC2I0iEagnhDa3uJC7YzCpvEVBrh3Oh1qeALOsKKE44jYHc587t?=
 =?us-ascii?Q?UMuY5mvgpIwZUQt/hTvCK/clea8qLzLgrFDTXUaQj5mCWH4j66xoHo/JUKRK?=
 =?us-ascii?Q?K/VgBjmFp0S2joVh3YQYNB2m4VcdPcOEgYW2m/FhFLQLzQ0UXOYLpL7W+lpp?=
 =?us-ascii?Q?YcMp6N9v/UzoHui2EMpI1ryGDd5IYeZ/lWuzxzcmZrLu8NC8dC8UCkJ8hLEh?=
 =?us-ascii?Q?TsoyGNdlE/js68/BFrWVjRV8SSzYydPbIePfYoa7KgDoEmG2NWjR+2NQclM2?=
 =?us-ascii?Q?Lfg6SmTTXSDvyvw/0i7NldOkmBtvaU3pRhXLQbBA0GwI2ygaaP49HYJnUKg9?=
 =?us-ascii?Q?CejGmCIPpZQjG+GQwI9iAOwTzqLUUlFCrd75CcFd4GtCbX9mBrLtirlRbP0C?=
 =?us-ascii?Q?eq+MDpjCNMuphTnD9bfL66oNrOjgDVL0hW9RIVI/XEMP90XvTKNT9NjfFVNm?=
 =?us-ascii?Q?iMb1faB1hZF91F60zYL0QjRBQ30hcrjz1x08lVSUauoeRPvAdpFRN10lygv6?=
 =?us-ascii?Q?zT6WPrR36Rv78Kx3AVqhVZLy0FbO8KytwCA6ZCsOWJjiM+C+oyjjn81HvDdG?=
 =?us-ascii?Q?Kf+df8L8n78N6k1zzF+sM0u1fR4RgMIx3lbUrwAtUO6FpPeqJ6xR7gYgjusO?=
 =?us-ascii?Q?ToJKXg1MSw0ZNAg+Ur6TtLKmqw5XU2YQeMsfKQ1tDU7Tf5Ld6XnRq+xrS458?=
 =?us-ascii?Q?TsSDn4MiwyEuiDCUomOmx0F5jkAs6+0dLzEax2aiB9bAO4syru+x9faolTOr?=
 =?us-ascii?Q?h+XmBqLMr44JcHn8/NGUy+QvD7j6IyxT4eo21o3pIP7fjaWW1A4o6406iFtz?=
 =?us-ascii?Q?BZdGQC3KRALbz5a2zXcgYplm6WnZXr0eKJuf0sBgl3r41wpE65PSfo28/jo+?=
 =?us-ascii?Q?5vaTgLoC6/FLmOv6o7R6/PkoGiNU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reajeOUY2fF0Mp8S1aw8wHO+eUXZII/hCQKFnXkK5ylx3Vne+Z/qvUBiZX8s?=
 =?us-ascii?Q?vZmE5HVEh7UAx+Mfj/i1Feca6pB0qUnGGMqPPZAfZtxU+cR/KrjVpzetMAEo?=
 =?us-ascii?Q?Wdg0wf2bWO1oROq5ZlGETr3c7kzLM49Ei9oNU29w2DstsyB8qcwu0XS1cBxM?=
 =?us-ascii?Q?Iuq2x1hkIMEsM91oOLLk588aDZlUKAI8AWXz8aS2sJYTGMVTjJFoF2VglWRb?=
 =?us-ascii?Q?ZfdvV6VTCfE/KT4RneehY1Q+702/dYNwakjJpeumd6nrxpkgKDfhykbUyEA6?=
 =?us-ascii?Q?6asx16y9ZkAJoomjnSmBCTYTtG+NV+A1QQ4A8iwVkJ65YPQQmLrfHvvNJPMd?=
 =?us-ascii?Q?3VfVgf5DlMTqN+g7oQ4f5Pb9CaJ6DHlizZyxNxwFOHmgg7Zv78k7N03uQQEX?=
 =?us-ascii?Q?fjUECo7QtKRSh6ZNvxhXMbBVCukkzK1YuLXf5E3gHsaqWo2qyLe+Se/QgHQ0?=
 =?us-ascii?Q?PaeeGGUlH2kcWGUNn8mvhVtSWbMoF7fhhkDITup7u4MLAclVsYG69ii+WSD6?=
 =?us-ascii?Q?4ohVsI3QFtCZTmTFQYAZ9OzRHAxMi3A2fvACPcj+H7kiyP3AwhmuYvAnYppn?=
 =?us-ascii?Q?C1Xy5wFXu4o/Begg6+ACwlpHRm4AaBfxBgME1i/YTcQWRmySS0DrkCFQ5cjR?=
 =?us-ascii?Q?V2h4K6zbhJiJi1Voup6n1mZcwvY3dEW1iIZ/V+KG/+rEtp5nGGlnL1CJ/7tO?=
 =?us-ascii?Q?XOkk2+hc1LVFiayYwy+Sh6QdOlYdb085Jp20AT4cGnkv33Ykw/1Mr6fkzyc0?=
 =?us-ascii?Q?S0oOZiBoIj9XtjCDJU/42t/tLmS+5bMInwZ6HYgI5DK2jY9S0me1YqLR6Kcl?=
 =?us-ascii?Q?aAkIlJbWewDxDjod0/KCq/Ca0GJ9ciPXoUNz1sAtqbjS3HKFpHs8y93JoJQK?=
 =?us-ascii?Q?29nFjf4Am2T+2Vw8uqc8o5mN1qsTcMM+Xlpg/V+jX2Ia/KbYA0iyx5FZRKLO?=
 =?us-ascii?Q?51d5GZMt0KEiWAQzYei3LxVN5NFt94eeW2Oi15j2vRZSc/BNLuj2LOaPUVBo?=
 =?us-ascii?Q?Kk2hEBJVpnPSJ2ikChyFHelrn7cdWb/mgh0r6SRdF6Bu5yyttUuNJFPL8wNB?=
 =?us-ascii?Q?N/ZWtxNgGKZ8H9tc40i/ncHqBuRWBNgObdTMpTC3eSn3Ha84AQ1hnzOBMMs5?=
 =?us-ascii?Q?eBzczOdrxjmYkiUJAb4tKSwqGTUYorWuo9oZ3XpLieK1KlujVdnNwXZlU66o?=
 =?us-ascii?Q?7R0TA9KEHKwdvATjaEVetzEPQjBCVUo2IraO/pH18IPF070djM71AviPOVuW?=
 =?us-ascii?Q?alVibcSldJ7gxTmLD9W+iIx5X74LnBwYfAEJOPiYn4S2o4xnGxTEEmJ1bZms?=
 =?us-ascii?Q?PkHiZ9iVHnumQIkGy1xxATbmFrWUrKvqfYeefnnR7fsmy4wPrWT3ucC/csKa?=
 =?us-ascii?Q?5642J9Fj89Zh4pn05SLbVSw7PBj044bfsBL896nyEerKoiyF8HgUl8xgAUm8?=
 =?us-ascii?Q?bZ6YhrDqHNcX5DXzdjoc9KMdWR1xa9F/hXOan7oADEuDAOo000JLx8ExuSxH?=
 =?us-ascii?Q?MHCG5v5u61gJ4UjLHJd9B45AKxK99Es7ACgddr4hPZqEv00iBjP+5ErEEkft?=
 =?us-ascii?Q?rRtOEI1iiA4m2W+BXKs5srR4H1TiJy4JmMVdX7iS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50836148-7282-42f0-c448-08dd5a39620f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:26.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2ToOcAR3VpxExCQ873F7MDJNpa3AfJGwX60FFq+Q1Ezwuehm6tPGfj8DN4Z67M49MqoHuMKA/CVB7xQgJobXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Boris Pismenny <borisp@nvidia.com>

Both nvme-tcp and tls acceleration require tcp flow steering.
Add reference counter to share TCP flow steering structure.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4f83e3172767..f5c67f9cb2f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -361,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -372,12 +376,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 {
-	struct mlx5e_accel_fs_tcp *accel_tcp;
+	struct mlx5e_accel_fs_tcp *accel_tcp = mlx5e_fs_get_accel_tcp(fs);
 	int i, err;
 
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mlx5e_fs_get_mdev(fs), ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (accel_tcp) {
+		refcount_inc(&accel_tcp->user_count);
+		return 0;
+	}
+
 	accel_tcp = kzalloc(sizeof(*accel_tcp), GFP_KERNEL);
 	if (!accel_tcp)
 		return -ENOMEM;
@@ -393,6 +402,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1


