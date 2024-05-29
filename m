Return-Path: <netdev+bounces-99112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF778D3BB8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CBFB26F8E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A6184117;
	Wed, 29 May 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4sCBV/U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61E1836EF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998568; cv=fail; b=R1pLbXL5cWDe6zI1X5JgJtshoOglDHa/tNzs8D3t8M94Jgd7+lhs7LXBqC4pxZWnDBkZkfHO/XUHTpHmMCBWmbnYW4T8y5JYSH2kfNpizJtxbhnhBYMFsrCQ6Febnp9Vts2xAAQuHVtEu/U6/m0N13h1iEFR4F4KHOKyMocpKmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998568; c=relaxed/simple;
	bh=cqv3KvDIcSKdkx4B5KOiEXoCc1dzfPUiDHs0AEzmwEg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiiKMV1xuxkCAUuqRbcJpwqJFTbAjxbVSPLjqaObE1VV447p3mDpc2vnxZH/COzB+umLwclVb3Ky0DbFnTk/uQzwatt1oibt9SAZF8c+SJsBYJKtNoIYLrwN4i2mlsYEBp9/bYfyCzY+Tv4Z4OadgmU/ohKlVEB2wHeCLafoF/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R4sCBV/U; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXRn62UMX8OFPScAVqM5V2YA/boVH53A+qb56JLh+7KpizgbwmS2Ptxchf43QcVMKsUUvwC1mHUAIdOhIeqM6Z6DxIBzGV3uqSmQKsxGVvjWGwf434zCkL+3R0xnt87I5y+8icu6BEY3FlK5SjHZ9aiVrsAqWThqHNzi/rXDlIrMzhFIDHXlgRKcQU6t7Jm99q3hsJORSW3k0/7159yXyXLUAUsnmxGplzpBo12xNkW9a8R6daLMsa450GvGfUVKoj20PHeiMMUFvH56vmJZAQLIZ0Ia30CgVj9IDp+j1pRqYEG0Cn/Ekjd5724a1dxheXUeEhOW6qHB4OAZ979QFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqwOu+vuBfIgF9xkon1X2fFZQrJuT/18e3791jeclgA=;
 b=gxrqcJolkemGDsmlO0ZZ16pFu7a40+sAA9UU1/tmGJy3MNM8xcVDoKcRxqYHkDaiewcULfNsd61AiAdHmXO7P05NqSYJoJdX1jJmgFTnXvJDZZZF9gAIaluZ6lx1scrP5fGKcKc+ntSAcPeD6dPaaiNApiBWgrADwn6q8P9wbgevhR2gAbIDvpg72cU5lvuj9Fk5KsBRtgYlGYRsdtejVZtVCdYIjwVlQkiiyfS7JqVtJ69V3B7pCiXecRU8sobedb9aDgySO+iYUbKE+y528MbwtcJeAv9Wf5IclhCENHoq4lsaSIkhsywlmrxVRQXmM6TcKcy+vb2kntXsHq/WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqwOu+vuBfIgF9xkon1X2fFZQrJuT/18e3791jeclgA=;
 b=R4sCBV/Ud7NAF5gDynXwjlStdHD8QTxtMWAWSvjWRXjqz4+fVG82EBh1fLGKDpmoKY1TNLp/1xXd35KqH7el4ExdFcE0YLPm4+O7Mo1RTYnJFTHpbzllKOuTNd/BDNquFyz/HUJuaZDiT5jLT+VFYu3YwssiztGkblv6KYeS4+F30rAJvKG4YTLxPrJvRo8TaCB2PhefKGcB5nlU16fRVJwNhM7pFqP5XPuI5hVwiPB4qylKfQIFTt8B/gjw9VjDwNFVZb3bxPWAMSzFAXwJZuZomu3QA7GPlHRlxTJRhlR447ATWxQaTi1ejzLom+/QsL2mnr28LnnYzIShN1HYiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:02:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:41 +0000
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
Subject: [PATCH v25 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Wed, 29 May 2024 16:00:51 +0000
Message-Id: <20240529160053.111531-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce39a4f-c9ea-4ae4-b834-08dc7ff8c4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4aRlnExobfh87BscNWiBKNWOdAI3RZGOh6gG1/2iGD6Fg5og+Hdc4oBCYnCh?=
 =?us-ascii?Q?ZNQu09+rsULhBH/3VzCyP/m30paWRC5icoIn2WQVdrfAsPbDbDGtWfvu56u4?=
 =?us-ascii?Q?JHS1k2aAoMwLoYVit4ugKnR39FmTWHw0JNEnqO+XvYb38ZI6GAUHV/rDaeiP?=
 =?us-ascii?Q?f/Uys/TiFuwPJuEbmUNdAWXAB06/LOXJvgDw0foMX8a19o1qcWhJMzPYZce5?=
 =?us-ascii?Q?F+Mj8hTt5wkSHMcEgWseXJjL3tdBlHAMNZD/iB2Xrceqp+LJ0bkhWA4NYS/n?=
 =?us-ascii?Q?aQtqBKfCylTHizAlmCfau2qJ3qQ2K5I7+XkfnUB/rI1/hDIgvXCrQFkMae4N?=
 =?us-ascii?Q?HI7/BBk78EwgkWLj9lkRoeDzA8HyBBmlOwDfqmbBTPqAF2DhWYJPS8K82tPY?=
 =?us-ascii?Q?+j5ic263zorQfSmnkqMsG3gocZevhqdTot6x83/4LATEZH1gs8bhtIKp4+Hg?=
 =?us-ascii?Q?rxDHE1KdOoercr20jeXkSzPUurcXk2aqGPSTuYKPIL+RgYjbpJvOFEhn5zGo?=
 =?us-ascii?Q?PjA5H72nIWxSk/3hn8pKavOG2xNTIDppVyCJh1WvA9XdSu7dTwC9J3Dpn9Fq?=
 =?us-ascii?Q?5VxBXS7bnqf8QJuJrjeAv9sktOlogATw7Nq4YYwTpDsdEkKxODYLO0EVo4Vx?=
 =?us-ascii?Q?bl3WJZUJdNoH3RC9Yjtg1i9RNXrMfAaW10Mcip8zGrLdGWe1N12xvydr1/mn?=
 =?us-ascii?Q?L941U1v9nPj6c8/zWh//z8mappZOXPutmTxSCLulEx6crLvRRhWwPSNsG3xh?=
 =?us-ascii?Q?HC4+0tPFGtbH5GKWx9By8jTUvHqWnuJ+EIkauzvcCxoHFWv/uzRoaPhEBdZL?=
 =?us-ascii?Q?sUWaODSZtuCzLxFv3KugCa2qoM4GgLDgOe0pV3jikvuOWVhAr2EfJjUWLmkT?=
 =?us-ascii?Q?VCmZW3/SbaKh0b3qf8er/qL4Tb+lfVPOnBnxBRO6KTK/SIGGoZ8KMdOZhSBM?=
 =?us-ascii?Q?YuCn7yNKzIa8+YkiaEmrLWhDfOiwUTc4LunEw42MwH+47atGuqI9mJVU0DAp?=
 =?us-ascii?Q?f1k0vB+NdD5/g+J/C9NRwxp80OABsD297S0y4EJ9apxmRHk4w23ssvMVeTnj?=
 =?us-ascii?Q?gCFjTumZSrPh5SZ9avAjnbswtbL8gah4js+Fnlm2o+lpJJf10lGm/eQ9OE55?=
 =?us-ascii?Q?LKreSJaIEpvUPTuTBhcAzLYGeVTQl01BTBKljDagK9FyEDP2UqihkFYbuP85?=
 =?us-ascii?Q?hutTN5xtO+DyrNS8cHR/2+GxoKMgDPCnYSxQwEei3NQ1Ke5AzdUB8S7XXfZd?=
 =?us-ascii?Q?AP1ZHjMOWUiuMnJC2ta7TokzJAbyiX3uZ19izRp17A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdvgJ0ee9rFJW107XRJLKN524/oW1RV0VAx5SxK/227QBF9Js4KSqf+3lWFG?=
 =?us-ascii?Q?vXf1sooNGdxu81FnwE8Y72MGFaphpZr3w7z0/HD33KN+3KOwJOy0cogagJyj?=
 =?us-ascii?Q?0yJvyq6LwtNWgXV96DvB4fX5miDCENdiygEYLUtjsB3jtiEkgF2R+8rXkpUU?=
 =?us-ascii?Q?oIFXpLEwuR3Mg+cK4miaSlGz6iCUDiv5Uhd8pEaAx7saP5PUw9oKxQ8PoTyQ?=
 =?us-ascii?Q?4J3cCpvO1/VkF9MZQZW4FyNKHwnbM6E0U4vbYHh1jctltqPzK26hYWoh/NVy?=
 =?us-ascii?Q?G9miaQ5VICBDUSO6CPXz4t4JEfOikguIlIijH31pz5Jj6fosYs1C0muWLwTz?=
 =?us-ascii?Q?vx5NcfPl2Kp7hg+SRP3C31ltU+5AtcJfIVhCDU3jQYzuifA2yc+uPCPsBqj/?=
 =?us-ascii?Q?YrrjxNNwrDDLtxRCVIBKzhpFQDEu6G4dVZvqvqpGr4W+YPORYlknuun4cbsC?=
 =?us-ascii?Q?oHMjpSL22JAhbmL3ipWhrI/ujPPZ3ORUWddnaax6LoDLpxbQNhyqZlu7+j2d?=
 =?us-ascii?Q?Zd/a9PuB6mxCqcZdIqDHoZQRu3pvgPyh0tIyQYpAfTRYA3bTBlyECVDzMWeH?=
 =?us-ascii?Q?Nl0tGEEBLLgbRCdiROuGguj3xswhER7hFrG6UUhPgU9ZPdRzEOaWMh4S62Rm?=
 =?us-ascii?Q?Ezn99ukBG1U1NmccBmfiZhEB3K3lXAaUMfXrWMp9r7eLvI0PxCzNKf6U5iKF?=
 =?us-ascii?Q?kec9uZ8rkI3mAdN0I4xaP/7ewJ1Ch30lYc9UgxnI+aLvhxxPpBLluI5HObBm?=
 =?us-ascii?Q?zl/M6NFgcZwwfrcUSdUwgvUsaQVtzgxm/r34DgjTzEiWda3g6EkqwoOvnwF9?=
 =?us-ascii?Q?6QzkxArAmIgGY1yWE2QAcE6CUn2G1BwSrjEdmVMUwKtbKwvdYaab6EL4zngz?=
 =?us-ascii?Q?dzfVLXTYk5ch8N0+NwB2M/7ARiT1LhsPMo2aLQRb1cKbzP1+RZ1fmAa/oW2R?=
 =?us-ascii?Q?rQH2mIFthi6eqBgzcL+wd9xBNPi2DzdDnMZe2bmgSudzIMEt/4NHP/PXtvUX?=
 =?us-ascii?Q?pzOWRsxIspVbn7TNXBq+HAbPBZmsrWk4TSjLivFQFIUlA1mVCgrkleOSV+jm?=
 =?us-ascii?Q?yjimvYTD9r21rDfJhYtqCCTNWI6uRrN6GbMc3rC9IZG01M7zDMfzvKMOBmlZ?=
 =?us-ascii?Q?L5mysS7Ul8uxWmzBwBY3C2E1kpKyBuoo52JL+OFrtppcJGciuew4scfzHqUD?=
 =?us-ascii?Q?Lqn2udHhMul1BOLtrBajUHYGIhI0lxrLJLP0fXGRThcIvXDdy723W6a8yF1k?=
 =?us-ascii?Q?Ed+ZaDamQC5Ogsl+837DuIYl8TLOsEPvz8l7AHw0Ydy+E9M563PJIGSQGZy5?=
 =?us-ascii?Q?6UvwCZWSmg2NUbdo3Qr8Tl8yyeIETED/2z2FqMEriSNz30pdMx9bFpmHF0Es?=
 =?us-ascii?Q?CZnSy5j06xD+6VjnZkXrKhDBPwoIWYvPluuayM71LCgvBIMCPfhYE4EfSKbe?=
 =?us-ascii?Q?Ra3TljbbjxgT84nKnbDNs4LXYINwHjNEdcHO8K/3KijPIk3jE8B9lSwv8YJ1?=
 =?us-ascii?Q?RC6aCCHuOAwntGP01PB+ovHhr6uef4CpyR39RCLOfftgyD/p1XV8U+uDIQ82?=
 =?us-ascii?Q?WnupT053cL3UurK01S7OHLhanjTtX4Ro8BUMuzuk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce39a4f-c9ea-4ae4-b834-08dc7ff8c4cf
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:41.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2iPt27YPlCQEPMtaG8pUKHzxPbcBtxN8qmLmTWyCRd2CB/Vbtx/4W77ipG8aiZSve27H63jL+z8zsleQNPEoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

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
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index c87dca17d5c8..3c124f708afc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -52,6 +52,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -230,6 +231,9 @@ struct mlx5e_icosq_wqe_info {
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
index 9b107a87789d..5ed60c35faf8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -142,10 +142,11 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
 		       enum wqe_type klm_type)
 {
-	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
-		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
-	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
-		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 id = (klm_type == BSF_KLM_UMR) ?
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT) :
+		 queue->ccid_table[ccid].klm_mkey;
+	u8 opc_mod = (klm_type == BSF_KLM_UMR) ? MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS :
+		     MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
 	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
@@ -158,6 +159,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
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
 					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -259,8 +267,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -272,6 +280,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon completion, such as ddp setup */
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
@@ -290,7 +302,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u32
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -307,7 +319,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -330,7 +342,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -345,7 +357,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wq
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
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
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
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
index 8b29f3fde7f2..13817d8a0aae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -109,6 +109,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 69b2b71663b4..c9be1a65ed8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,6 +968,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
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


