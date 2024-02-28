Return-Path: <netdev+bounces-75722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4486AFA9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA01C2510E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BB14C59D;
	Wed, 28 Feb 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cvcic3Ro"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5614C582
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125142; cv=fail; b=tzSV/Um2jseg68F3aZICOxl5uXIKMrq3k2tCwmobJWEAbJ36ws0pRZeu7EmD1OY3fGF4nTcsWAOqXxx3XZXirUqkKq3JNd2MG9g2KNrtWlG4+i0hYTnfd8TNIgfT4yNsUL8x2HZjPopueLeuizM/BvlUD9N8GsMQ0vjh0dhwnic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125142; c=relaxed/simple;
	bh=L+fATSu7wju+xIXEvIlWuzH8g12yUZNew/Psv7Lz+Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbVBP9kQscJ4WinePeAWZNcsr4/D1Wuwo+V6bHuq+r381ZmJk/D0kcGF0obFJIhZ6UVKjvm4IUcFQwwxfMgkYACPLr52WqoOHU2mLd5dXK8j1TgzjcbQ/KLTcqqPKnV7I/72ji1si6yzieCcMr58jAM0CEPfSbmwqU3t97XoNbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cvcic3Ro; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG4nSZBCbljCgMiPKLojJzAjGd/QXR92ugWnokJV9MmEmMYi7SAtziJdShJGvNc3s51o1LO6WDxjp9o56wKObXinCSraPAcBHlV+5Y5FUCurMPl0k9Cncjdb8rvLTipNiQ6ebTmLQLovpXDUFja5JqNfEnBnIyN/NGonGs+8fAlJ9GXzkbafOlDHWCTOftx9zOTuw5c/cM9u5hb1QzNHV4L4sy0AXakTCfPiTtQitY/WhIjnbPtiNwo+vPCwwQUfToxYkNSyMR8Kf5a0bzCLza6ILa5KGKk4G3nnah8Q/U4L8REivBYcxl2iUeHQ6FU+Y/eBiBEHzyE23w+qY7EOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=MrvTT+AXs7H4kkAwmK2l14Vc0yYfg7WC5Gd4HTDqjlLw0PMEZLZZc3U7FPARM5iagBdih+SYUu1dJAS7xzYELBWoT+sJanQI7rhZNCbdlWdUXvtNg4M738B4drwNVPZMj9WF8fzBxYPhW0gaa8QJYXvXyMX1+u+MBlpb6oS8Dz9cnjY+E7jJwhRHcifQ1i5Jr1/ksnA3uHsy1Qji3x/h52J0624a19rjb5RWwaIuwzcwEoLCv0km0hZAI9RK0kCowCq4j2EIyCB6g0UTs/owV2ch596p5lyX8gc6IpDNyrUI/f0idEg91hL1kBrs6wj+sej6o6/V4T4eHnx2Xw6TnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Cvcic3RoJ+F/8wkJLfrdYas93vbFnOdwJe++8EXHIIt8PNl3cOOd8dgucXuBcATeo4TZGFoas/5qDeAzbCxdvcLkDy+QRSQoQZF04Y46JZuGueQg8b6PklSP1pLxAuvu+u+aZQD3QeopX/6Fjd45c+BWaSesBJtRX4G/P2hgnDfo3AhZDb6NLaB1vRP7uddZ8QbHI6vJ6irLVFrstJXCUoaIqO/R2Rb/PqSj7A6iCNRr1gpezZW0x6aR3bgaJVrVTmTkWzXRIjr/N8Bph9xZBgGmgq+kwpzU7NYLZLK4Zv0M0TEFENswAXZ7taj2ISVj6+FA2ONdfwWMctYGY/1R9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:58:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:58 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v23 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed, 28 Feb 2024 12:57:27 +0000
Message-Id: <20240228125733.299384-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: d65152a0-a5b2-4d1d-1ce0-08dc385d06f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dj0U3VWJmXrj9MKzjfDuD7++qEUkcbsVISZL5bIR/HuXhzd4QbVk4tgrkn3k8c1RG/HF6+JrCgpIoaZScJ0e2/L05c+UgL9uxT8X8bYPS19+AoeejxAJc8oMqFbWhPKX3mM6mm79JFOI+Zfpd2SXSvIxjnSXVfy6Z2+1mmQblgORpZp6QaF5cgFhsKewoMl4WMWhyZ/LIpHfI3uv91jdY6ETO6KZl4xz+9hoGJQpfVPOyACkOIYRX9jp8+NQ0hhcq7etGl0wiAbRFsYPNBTjVLYDndk0MZzAfjRYzHpcy2aDW0Uvr4UJ8YlxfsVUOmPDU1UTQ/XdBqp+klF9qBHvpahYTMSgNhEq3qmN7dGkr7nx5xu3mZNhLgkxsF91A9tlJfDUmLdXtnZy52b5tmqhUXdV7ZZRVJbelf1r2x2wIBO7+IZpyPJcimQ7UbDxIDZFW828gmq15I/8hG8jayfmUn64ZbSS2nIdsQfGTUCa9Oe5IpgPVDVFBjs9JWQptMfyEMaE+KFTvTLBQrut/YNGNtc5yz8WGyLNZjeh7s6QmTnwWkhh1p0w3zyvD/YNGwbpkd9gbkuJxTSjrFfFNOa8/cExH1+DhU2t3xML7GqhRNJnJQ8zt5hF3n4+BhwHgZcMFb2K27Zd2zcm8Sk83r4cNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOUlhbjtvt4x8inq3mGg96XvPeeMN+VBCeHBtcdPoaidf4s1FuSZ7Kb9kWT6?=
 =?us-ascii?Q?dpZjlqWtepEOhXxI4Vr+bWBdEASmF1qI3M8PrYOrFgEFQ0dEdJ8AYDJEwzGK?=
 =?us-ascii?Q?qlSIH436lY+LzY/nOVyHYnLP41W8E5erdfbzkBmm3cMDsumktlKSNNUAW9qV?=
 =?us-ascii?Q?VRpB4pk0yzgj29IP4GCP1GMP70uLEs679FHLODH0bRyaRCQgdBBzLCgPTPWx?=
 =?us-ascii?Q?HJnASH+ARrRaSy7r3hxH9WM5L3xiXEWixCmpB01M2O4otkmBgJlLQmD2WEee?=
 =?us-ascii?Q?NcIm6jjPYYOzj+W1nUs4fwAvtpxNzOiASZISTtQyQhDFq4KEThvToCtmP0Ee?=
 =?us-ascii?Q?UlQrN5xG8DHQGc90U8xqgZapORiImwXqIEbP60bKZzB9CijMWynyXds/d51l?=
 =?us-ascii?Q?epdTNpTfrW2Sp4EF3D3WX/M6kcH/FON8kHcoTJ9ykv5Zup5EkKk+2BUKw3NY?=
 =?us-ascii?Q?iBWsa3qUEEgP6D+yDEi8yFQoeoXAstsUP+ntbd+ZhbLb/rNpxJyBz6EC8KWd?=
 =?us-ascii?Q?lOVFAdilmdBBo7IoWAFITzdUsH/t0kfkvlypVkOTyGjJ6jnY8mZ/UdMB+WBf?=
 =?us-ascii?Q?f7C2R25yW4IHI4UrYHGA1XraDmd+XTUXvLeiuiOQ46U48MNCM3T5cw+DRfnh?=
 =?us-ascii?Q?/bqNF9lyGlHiC5JcsHUsooMRg69og1shsNGTtw3kKQOxHr5ZxDPEq9dOL9th?=
 =?us-ascii?Q?VNZXP6sffzcLcVrD3SSy2J0Z/yA87LfTQswDgzJcPUDNvPsrI2jxYV41EmJw?=
 =?us-ascii?Q?G45IF6+hsQnpq0iEa2847/ZyjluQVHYT7xcwu0KgYEs/G5xMD6V7H2FlZX7S?=
 =?us-ascii?Q?5afChg6lvS9TzIRWf07xC1Ex12WBuayH4R7Kz/cN1nHBu0Pa4ReEtPrcOD+T?=
 =?us-ascii?Q?ddiI8biutXC+AtAgRjp/wdZb/mb32IN7TjiOtwRm5btB9SIr2nbWGTv4FKVV?=
 =?us-ascii?Q?0bL2tsMCzDh/NKwjgoGQLVaBzOlNzwNPBeY3Q3Zsy/AMYqRwE8ksI+tUku5f?=
 =?us-ascii?Q?i5T6wq3vyvGHk6xXbY0r7GZuTHDQ/KpsqynVfHOqzTYzbFXF4VKCTDVypcEd?=
 =?us-ascii?Q?VotsxR6XGdD/pN0Iw7jKvuoaQesUBkPjzckS+Ugtx8QgXcJE99PayFw90TLb?=
 =?us-ascii?Q?8bWM71/kBs9tvAaT0G61N6uDcXj2vUGTUL2f5ltPF8LlMD/cjoOalSsl6jsb?=
 =?us-ascii?Q?M912IzYeHCTZoqvezFN/v8G5jQCqPf+gGzx4n+/hONFkYyn9Cwfw/4eiiSNO?=
 =?us-ascii?Q?+g92Nk3X0j5qsCBvpZ2w0zia11wWY80/9NncR1dVdbw2ndLy5K44hgB9dTO+?=
 =?us-ascii?Q?i9q1WJjT00LW/ZBtQTs90666MelWqTpWKvpnteTeYpt9KdCfAmW+bJjVuRxm?=
 =?us-ascii?Q?pXPBBF3YiFArBtoDRxLSG58DAw76dGpU9uSjIlldQNnP8PqX8a7Ml7RAfpR3?=
 =?us-ascii?Q?WWWzPnsDM9Kgj18TFQ0q+BXtBp9bF/PswJ0+iwCea4hCgG3noiqVrKHzCpZX?=
 =?us-ascii?Q?t4Ryzt3Uk7nJBube7D2ZcbOy8DByiTqnN0/KR6n5LU2bXbffVLkxar94Wh+6?=
 =?us-ascii?Q?ZhWct0/GEOi2JWkvRaxFpzArOO8u4ySDLo/DUZBd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65152a0-a5b2-4d1d-1ce0-08dc385d06f2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:58.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NsrVELk/UHqNUrZB+DhTMKn+jX6MpmjuLwH3Xc3CeCRNMAmC9pU+9H8A60Qf8aNjCWpMXYTivmcoXkiOBPGPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

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
index c7d191f66ad1..82a9e2a4f58b 100644
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


