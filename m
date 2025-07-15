Return-Path: <netdev+bounces-207122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783DB05D19
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCB13B05E5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248C2E7F39;
	Tue, 15 Jul 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kuzLG/Au"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300402E7F2C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586185; cv=fail; b=td+6ut6vu7ls51zL/qWJn/WHi0Cr9KTJW3k6hycAladbfNZGltNz3N45VnhXRQXuofDw7uwLQmiifwvZ07FP/tZ+BQ+Q8b0MGPL+gL+BGvkT1CTq20FarmKUJ+jlbQfi4RCVAZIU259ZT64GRFu5gcdiodrAC0PYbyhFwEP2hJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586185; c=relaxed/simple;
	bh=Os44/D96MGVztgd3DgeKIREsTuYYWFaENtaSEUVU90o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n893REOXDJEcA4XNYB90khua+pJuiwSIE11eTrkTlRlQ0Wyg6CX9Tpf8sL9IGzfa2930txGq6iz8uB5ZVmaMTZksJo7K5aFxLfQh48JnDMi6yN33Chh32Oanyl5CituXY9MlnFz6PnfV2iD1eyuGhoEzVaILn5Nl/ihidA3SE/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kuzLG/Au; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPq8VC651W4oHKUvo6xaa7v2/ALhmcSrtalZRvaXkq/FeGWZZI92MqZKKIH+lYxNkasNiMtnemuVGpEbecw/7sCsIkM8+YR/IZykHL5w9y6p3lGckYVreKsbihiHJ/woqhmhWLYiNmmO7zszfmvLzioTTmzeMwud1V32ZeMuu7yhcHvM4SCh9tezgbQ0xnFVcje0ueHbxwt+K4NZBx7F6PM/nazJz4QHLt+W7OPRXZR7CIKiTItMOANK8Iv/cCNVPbIS1NLFQbwFPmi8Tj79D9zrEnCXntXBpRbzb1n9+Hc8KfTkma5OQ78NF4gkI6UjOj8m+Ho3HpJ1076VKFKHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAlD2sZ6C8BdOfzbP5PvW3LufHAihq2z3luHdSSCgT0=;
 b=W6tjGw9q37k26At/dhHaeVOAM92P3eKzrtn97gdJRIXLBnyeqPR7xnK1ztoXvNtVGufHV1T0Z8q8F2lHqy+1Hz1VdSgVacB53Z5OsteVqecAgQ2BBgi91HKc7UQXUhRzCroS9O3lvUQNVw9dHVUUCTAMx4+86W7wt0Fiw9gFuQuXs0O3x0i+cgXDi0XYT6BIj4PYFoPoNyq0Ve4jBwwIVbhVQtZn0Snr6Tq7snU1R0rLq7wmKVP2zg2NoL+2wl3ujacI11Vdakb7rRwF+Gq7o7XrUtRsn6uAn7gvT+YjwEJxWdE6+94zq2WcHpiANd9kINyD80tJTB2DBUCgFTboWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAlD2sZ6C8BdOfzbP5PvW3LufHAihq2z3luHdSSCgT0=;
 b=kuzLG/AuwyFhv7+Ij0pg3f5sAsZlY4QTLWjNyhlrUGwnKjw9xIaluPszdobJdcbtxPpB3z3H5vjjM9p6++D2+24kOnJaCjIxf1QQEbi3C4hxrc5mvyU+v+NoeIQsEVeGt6+6TRgO9vo0ygO3V7Z36+V3IROQ087zVyF2y363ZJPvk0Xf1oZu2YgNU91bs/RbJpq7GdKvWHSRY0GxW1J82rCFMzGuJSIeK2g/bQpt9Ja7XD49s9urlVykX816q+nXhqOKN6pyMfvSLmXjQl3wNak976v4nKh2vdwVtu0cTKstEsXGNoEihH3nlM3KzfYOvVfAuUdcsAWvzAfUZkLVCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:40 +0000
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
Subject: [PATCH v30 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Tue, 15 Jul 2025 13:27:47 +0000
Message-Id: <20250715132750.9619-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f2122d-652f-4a33-8286-08ddc3a3a6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aO7p1cdMPdeWrJGgNEJqZNMxyDyS2hyTIBxaPc8kE4aKS2JDEjzM7aF3yTpR?=
 =?us-ascii?Q?SRJnOk3fohnnQd+brkDzb33KVgDvxkmfP1M7gxhCWYR/7X7XhVJRVGMir3Zm?=
 =?us-ascii?Q?HVjPZLf6hsNhIjrAdlcv1U5aFS/7lMAOq7goA8URo7BKOW5hfbnN85vstGGE?=
 =?us-ascii?Q?vupwVK9La5V4U/sNxtkax8BjpNiZIlLChYCiUo15gMEtsUzRTROgNLMWCLRS?=
 =?us-ascii?Q?Vhnlv5J9374VaduZ5Ne7cYmPriyXDfHVitVrFmvDEhdP4faxk432yq0JfV+G?=
 =?us-ascii?Q?BPgoiD831PAlVmTW7UUS2pNCZb8SiAITYnUJm0XyAN+fCm8wAbioqDWi1Ojy?=
 =?us-ascii?Q?cIlGf7a+baRj+I/W+ZPW7KuZdfPM46HWoOhiw+nb29FZK38Y/2bbt2L7uz1k?=
 =?us-ascii?Q?kK9wyX+6dGWM7XFvs9l6SvsYZRG5ynb7GXgacLXBjHGgVP6PJGlBm8B9l59e?=
 =?us-ascii?Q?DmW4DDnQ9hOQHJH5Qs3jnQWf3VT6kWESY50Gp5aG5Spj4FM/2NPN/Tfbo0Vd?=
 =?us-ascii?Q?QB2d7D6cG59/DX7QLtGrbTlWxtK1KHyZ6MBRZ4+UvlMJ8F+RYo8iR0fNVarc?=
 =?us-ascii?Q?qRxopgDCVDQlSzMrVnPwQSA5pmMFgfnIqqYNK5F1kjkgpR8M1m5UuzWFsm4L?=
 =?us-ascii?Q?4AhNJw4YCmm1+v1v5Z6OoSnjoruOJybZmbzcLhtMK+d+WcHDif3LIp1QlEcn?=
 =?us-ascii?Q?mzNuX6icYnwfHtNkvTJaURVhvX03F38lQKytHHX9/8jufoCXQVhkycFM8im5?=
 =?us-ascii?Q?boRp97tdPrObn6O2eA3iqfNrpNtVlh0WApJX2Pt1eORAw5+vC+8KdYGSU9V9?=
 =?us-ascii?Q?Pe097RnDOEYl2C+9QeDOuBk5ELBXGF54x5aaIAROZztl9WbmMt5fmTEj5AV0?=
 =?us-ascii?Q?0QezWTA5yB++Qpn2pvqXZz7YRS8moWFCK2c9MddRtxHopLwDQ1gHllWn3eW/?=
 =?us-ascii?Q?jT6r+1YNITwTCmE1EcXa9MtjezuwtrcYOsfp+WsvPqTifoczwBeI625H/adH?=
 =?us-ascii?Q?RI69FBMlwQLA0PH7EQPC17NsT70tndDrdk9pZGQSVBWySg8a5KmTqqpkpUkJ?=
 =?us-ascii?Q?6OqF5pO/+G1KhQCoMranAeZlWDKI+LQCtYH9KkYrVqKFOyTrXIwiu9VG+uxb?=
 =?us-ascii?Q?sizVokF02RM4agncwY1EIK3H1cLuBORn9rQe5WJwS0u5o2UanjjpRXM/hj7Q?=
 =?us-ascii?Q?HHf09alExqoFPGpi9+CI4nM+regPSw9uVZQjMUCwIT3cfcdbRjvFIv7QgOzC?=
 =?us-ascii?Q?AUgH5bqCrFMlSEmJVSzh5R4huO2dG7ok5/MGwq8t7Ui9GfGMLd2sAX0S9Xnj?=
 =?us-ascii?Q?E2vXwXooogCASVm95B4Djdfeh7jt5UPHUFxCYomakm2WpxgqvoVwDYY2bqwy?=
 =?us-ascii?Q?QHuLB6SghlqAY+5NDs+5/w1YqvL1KfdK6AMGov4x6cCzAYtqCe2cmMj2UT0s?=
 =?us-ascii?Q?5X152+l7rvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tmix8wSwdk7PBrHQtKYFt4UVDUxKYamUC+URlKQKry2APUixFroZHhIUSw33?=
 =?us-ascii?Q?R0OwUwl5ND9kUUKXpBKy6e3JSKJktrPurZ8tuEf1FdkGB0yiMWb6pjCMAElc?=
 =?us-ascii?Q?63e5zs7NTKwMNWjjR1JXPCWt1R3KA9LF1V2Eei0N2rpDmId1/1+34fmfZFNF?=
 =?us-ascii?Q?p3sG6WFY42vGQZhdSPj4udqyEaSmHHYS6TkwAwvPjsyp+NxBKPbef47UbG7d?=
 =?us-ascii?Q?anqDAqkS5suDphkxYx7YXv9B1Ajo1SkPJqtoldB1y8aIZ5UDrokYFqFQArJc?=
 =?us-ascii?Q?hZA3RciD7ncxtUTPfphABHihzjEdI8fuXpkY+Of8BbRjUYIbLrYJNqQddd/T?=
 =?us-ascii?Q?Fbmfka2BVaA9kW0El4CD0LPZwZbtIFOn3NZZ0F2t8Wo9UnBgrLeIWQMHgbFM?=
 =?us-ascii?Q?tVeiXiV2eJ4/LDX+ZVIDxj5dgK0O1wZMnXep6z9vlVoyjsleo52nPDSxWpox?=
 =?us-ascii?Q?cHp+7+0WeatNhwrOKmXGjG+nMED+XIsAHo1A7uNRHF2bGI+2BAe0TTCcvfBX?=
 =?us-ascii?Q?A1LXF1esNNSxxQPTmZ9y7dxJhM2k1oafgJpeg6nXDVJosD9jLYKs8Y/wLjXI?=
 =?us-ascii?Q?eLagBul2pYzRwi1QSZh4Oj9OaMTqcYmbXGdT3DgrvPi5lRm+eFFU/9Imr6ej?=
 =?us-ascii?Q?tUtlBoqZzwoe1pn0ib3x8RDn/EuA1i8s3KFPpg1L+oxXy3Rk8ANoYgzCb7z6?=
 =?us-ascii?Q?XZunCeHtJ8UPHOtiFpe4+BMhRFhPxP/kJDx1dM1fbQl8sCWR/9LHJmlGDnx7?=
 =?us-ascii?Q?mt3r8aR9G+yfM0hR2KmIDzayY7FB1WE7g50rHBOgz+RpVTOFV6rWyLPryaQI?=
 =?us-ascii?Q?mjhuxISjuFORBs5SJ7w/0WzXkuJBIZX2y3c77SVYNsrV6xpgtUdAs2a6DBJR?=
 =?us-ascii?Q?nnjhFU+2zfTuOSMowxl6itPflV2/h3VFVPOwJVO8oi638MsFZwCX4HmSQH9Z?=
 =?us-ascii?Q?TZDLionBVK981HLmNmCYC8hMZxmfZDDjVRhUJwM/xNheiINi8CW+/VHhmeZy?=
 =?us-ascii?Q?IHnNSyFloB+9mMaGEQioBfI5olmILuHmpKLvei/11O820zknXlLvlQU91Nh/?=
 =?us-ascii?Q?HmdR0cicS7/PHdFmbCV+4oWTFmVxZYogwRwWLhZZ6G2/++31PxeAWeBNkD1i?=
 =?us-ascii?Q?B/PBAi0nIRsgv+ei68FkgHmllLDHVdIs4Cv9M4l7R+7I7BnpHMIGB35aobUA?=
 =?us-ascii?Q?rONCm4g0DjltfVAV0nqwMlU/EhFWW0GL4C4pb3cAoXesTIinoiAdCjdO5w9d?=
 =?us-ascii?Q?rZ5tfMkF5l7TIOjqUeAxI5K7JG7s43XSGT/W/QaGZQLpW7oA5JfUXAMa58wu?=
 =?us-ascii?Q?8pBlFBSzMjs421IefpRFt7V9vyUTXbIY3uGEWTMyNml2WM5/LDH1azVwZCR0?=
 =?us-ascii?Q?G/IMxVdJnV+mF3YFbVwnGKexwwKQynw5ybxQLxnkliYNv847pp8v3uPFEifS?=
 =?us-ascii?Q?6w6zdvcU6AO/bckTHqoZqEMi+6Oa01z3fE6J/EG2oC2GDpFLi4z0e9ZZLWqX?=
 =?us-ascii?Q?thoZb3pvJ/u7z2cqWkegtmh6IuS4u52Sb9s1BHTcBpCcFPOu4LuMx6cohKx6?=
 =?us-ascii?Q?uIunodid657BpuM/nUgLr1PgUWFUwBTuQL4NmAxf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f2122d-652f-4a33-8286-08ddc3a3a6f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:40.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh5rm9G4JdgcdczFzfk9xEn/HCh/q1clZHuwcyP38AyoC7u/zQnobfLMu0McZX0BNYRd2FuXj7reCh3gLMUEbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 58 +++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 61e9a8539983..ca32a68a22f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -73,6 +73,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -264,6 +265,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 48dd242af2bb..639a9187d88c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -173,6 +173,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN |
@@ -285,8 +292,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -298,6 +305,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon
 		 * completion, such as ddp setup
@@ -319,7 +330,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -337,7 +348,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -363,7 +374,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -378,7 +389,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -905,12 +919,44 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     ddp->nents, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
+			     ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 4850c19e18c7..67805adc6fdf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -113,6 +113,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3823844b08c0..51b24b0525af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -963,6 +963,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1


