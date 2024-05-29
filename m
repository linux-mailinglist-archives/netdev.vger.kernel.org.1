Return-Path: <netdev+bounces-99108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375C8D3BB3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BA41F26027
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DF1836D2;
	Wed, 29 May 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j1xGWXTa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BA184133
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998539; cv=fail; b=Ww5zgd/gTy3R3wTuHtztfFOs3lF00bBsXoFF3mJ2Bv1l57v1rstIXFgV4mYoeewrMqtkrS2qGYvNlYFMJrL7KrP6VH6akJTEjHxi2vZ3i1hEFu09xD0MaA9N44pxTrg/gfIuaA0DlWlViC14mAhiPQWNBSvq+uJz72+zWmFtIXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998539; c=relaxed/simple;
	bh=aRKPpcjTZlDC24qUfnCBgvTtXvGCTZNwYwmC0b1jgMo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnhHFnQ7Anot92jTeo87zcmeiBn4pTBqBdeFTAONfZJvICBMz98dovTL41z32qzYsV3cwYUYySdd1MYiEla1PYL5+RkjzBj9n14wI+Od2Onlkxn9MIXAYggSLNMlpMXsUCsGBaEQE4hD4cd40waCxRboDzSYbmxfFx4EhHNYRRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j1xGWXTa; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD6Dee29VGr1RoSuBeduQhUXZ/TwXqBbkvOaNs5J5f8+OfxMQcfe9UZmoObCKpv40l9zaYS9/HlxShsc7qO7reOF2zzJRIhjXxBed/W4uAJ010VE40q9n+COSH1A7zxMkWrIu8bWZwD60PFWhwSMoYjX80n04di9YXB9nx7wmZJujX5kovW62J2Qk3h8BG2n4nBldSAwruSgo+waPFiiZj0eGTWkiyj9FIe/0A8J8Th/9D0gdRmkluI/qP+ooHfABxN/oYJEaEHUXTW2MSgbrAgPNL0D+7cGG7EXT/Uhj+zKCoCsvWbtUZWwD8YzQY26zkyCrmNvY9odvclva6RPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=gIvUUTKx+kW6EKyj6ZRhhJbzQIdlI5ImeUFmxD4Vsdk5gMyLiC6cMdrYs6TGJ3IsSLN77rxrIHDYSllx5ngHqG45jWQLfs2qtvF9+Hd/nCbSZD1WIIq5XNe6bkz1jNbIy/KY4rmwhmOheJDWY9TsKXhk+YccLbtTJP++3Gu2N2hSrO2WKs8UlSX8f2v4xEdnB5QoubgRN5fTwgh8S6tlot/XYHk0/3qoINr7pQ1pXSq5YVVGNJoSHrH+SDpb9Wu3qVx2gOF+13U63y4UVRUL0MDM4ftWLekfUGk892UF1HBp7woEEjFijOy9YKWh0LZuKTjvzr74xzyenmXyDkTesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbFu0dlFHD4ue6c1H0T2HHV4LvGUohbMvaX4FM2L4mE=;
 b=j1xGWXTaVP03Cr5lm60nmVW273OS+Q5edcerNCLEI05IrksXWnL8BVlq1iPDg3DuWOtP0X3hvlpF4VYEH52v23osE5Zd3IigaCLQ5Jyn2XjNuT6mh/v98cOK7mI/CLz2OMfchIJxEa9UhdXyQ3bQUYdGy66EJdrqhU9l4Bry3zTlipaBJi+LhLZtKyu4GrR7PvHDEnXZwD1nHpnRj0OkqCDm1kp++qNJziNn5nkBYbJ2Kp/im3xrFsHZ46v/AbcjySYFxQyAwaAgOAlLuITVnIzphFaMgZJVXrJMcmUo1O3nWavHJF9FSdPMvB9KRcJ4xZbo91IG+xOag33MucthcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:02:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:15 +0000
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
Subject: [PATCH v25 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Wed, 29 May 2024 16:00:47 +0000
Message-Id: <20240529160053.111531-15-aaptel@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f152471-7d6e-4d20-ac80-08dc7ff8b4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZCyc6uqdMXAgapVQVyi/g/Q2U3sxohxxfwVyf7VtLzr9dVZOfNcfdie5qos?=
 =?us-ascii?Q?CqkK5G1MQ0VH3Du9ObAculZWrM0Hritk2d0i5FcunuAcltgv6m9NkymQz26y?=
 =?us-ascii?Q?QjI6zTxFMoagHMpzJERIjzYc9cxG1S1ndeD10PHhJmCPWnJccGHNEv3iUk9K?=
 =?us-ascii?Q?HC//X9FSaCV9I+ggKKcBvTv0VELzIZp9/PUWcP5QtkMo13+X8kh+kwSGYa8G?=
 =?us-ascii?Q?uk9Xd62/e0Yl5shFLfcL4im03FQrrT0Cbg+H06Ydlx9tgPRxmXgnIP3AQIHl?=
 =?us-ascii?Q?PSpAJ2j4HlLKby4FF6foWHFP9S/D0YRql50iEFU/b3lTWc6VEomiljhk+HcA?=
 =?us-ascii?Q?JJtzHxTlVE7iZLA8H89IWEJYvDyvyrfkwIwKgyr8NcD/53Tu61hK8UJFS2XD?=
 =?us-ascii?Q?uvsWjdWAivG50OdRUVYpXacflB0lrIKUJwag9NM0m8l0eeWDQ7L0Hp012DTO?=
 =?us-ascii?Q?jtGbsJOteKehVmLhmo3Y5ZZkn4ybHR3+0GfoDX7ECSrySP+O2I3hQ4sAlapd?=
 =?us-ascii?Q?z1D6ApoknNUewMUiAyOrvXmJJZn3NOMSwCF0CWZf3HgnZ0wy62WUbLdCvB+W?=
 =?us-ascii?Q?N1aB1Z+iGj1Dk2+bZ7doXwiHjAYLCd/XFSbDKrz/K6pImd74jlEGo45eG9E0?=
 =?us-ascii?Q?GJnn3nmyzlCp0Wxdm+Ax+TjEZa/6rCS2+xlUpPJvu53OmMXOqA7D0qeeISoo?=
 =?us-ascii?Q?/aFBO8QgCg7lOFAjPYZBb3fp8qWwmKfuJ2RMXXZiMUO3BCfspXZPQUO1KJ0S?=
 =?us-ascii?Q?Jjb9WAslYHFwgi04EMFmt/7onXBlbvfk6mHNsJ99YWHKIniQqrbmAxeZ5UEa?=
 =?us-ascii?Q?xLOnG0uTEzyicif9dVMdvnkbxE3xjvC1vZPr/EbiJKyTn5nyGrtmjcrMl026?=
 =?us-ascii?Q?XQl+BWrSPNXfjgivN+Z1y32rOc76hpuOc6Dz6c4JJyQk5Qw3+08a4iP1N+Oy?=
 =?us-ascii?Q?iKdZLQJ+N+aCSyzUHn/MXVdT7fynuXU5lD33obAe9NFBPq6j2D1e+ZlymiOm?=
 =?us-ascii?Q?/F3i6oYVb+b9EwReLlmX6ZXHq1W80WpiwsyXaDgfEOxZiJk32/Oin1K07fZe?=
 =?us-ascii?Q?LLHW7yanNSatjlY+frIv7C5WmeGvh37TGlSYErdjF/y7DgAbwZmUslgGGdwf?=
 =?us-ascii?Q?q/c4BiIQXvcwllEmJmMHEdjDpZgXfE5PjMdnPgYywBsqhjpRXxmKr/bRSG5H?=
 =?us-ascii?Q?EuI+RFnTM526e2EJhQ0XFoujuOnNT0XGaQKSMVqpEZp3xde4JRY8gOk85T9p?=
 =?us-ascii?Q?xPg7YjeNvPGI0231YNkQ/xNYWSeLgmZ8zh2rOebhxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAcXiG8XOFsWQPgr0JiaSku8VKpD00Iup8KA1HJEUxQ/XTAXv1RM6qibok3c?=
 =?us-ascii?Q?MHePSXm7BRN8tHy0+X60XKhoy6r5xrgBlFzZHSrqsLeculrYh+0usry0iCIv?=
 =?us-ascii?Q?uxNV1bUzqv+IaTOkx1/cQp4avZeOrhZjLOwtgmxJJrV+dvlZngogRYaG+82b?=
 =?us-ascii?Q?lNB75bXXQOp9vV6rhl1UvH89BkyuwfGyhapapk2pMmeol5vGBiwaUZhCfxyx?=
 =?us-ascii?Q?cLXznDwTDTYSjCgD17uXt2kgqoggyGPQf/hu0jTTxVecQf2eR9dpMVjcNYP2?=
 =?us-ascii?Q?GaTd25E1GQ8ChhT4J6Pq60rzVTdR8gxUOy3AzE3bQK9PKK5bwBL82tUxh6XY?=
 =?us-ascii?Q?DT3mDzJIAlcvFKdYYxoFVe2F+jJWz9yF1yV+q+q1FWWY0fHuO/Ae+KTQFWmN?=
 =?us-ascii?Q?nyuos9RqRf+u2ecS2OINffFo+vVry5o+ugFnlYxj8+EA2aGuuLbtlhizzR/y?=
 =?us-ascii?Q?oFfX4kdLWtgzttMnYW2Ug51QKP0AbItRXS7//TnK1XwfpiL/ehKVOCDUddgB?=
 =?us-ascii?Q?G2KgtZ7bQsL01jR9m3gzWCkN04HyDj8M1+3isFY43zbLZGLNSwQX7OrawoRA?=
 =?us-ascii?Q?XVlFui1tnnZdwvMPfImtRK/P21oa3ERkc1MuAnAXKofct6pc5UZwhX9vV2Dw?=
 =?us-ascii?Q?Sb2w6aie8xYVvK0ioVRIPFE691ql2P44yUmOn+QySiYPsuV93IMrJlD6eZP8?=
 =?us-ascii?Q?ZgVqddRoukunllDUxo60jsnYXFWvGnsb4QEXOUUj0htT1l8Qc0KC4Ko5ih/q?=
 =?us-ascii?Q?cgAt5/3qRNzj2F5KLe2QlJF3fsLkiDoJe/X0exHU2sMiaa7jXACmsuBDhJyh?=
 =?us-ascii?Q?jwcA74P/+6waIT3MQr6BpFsCuMBm1yo3+IUYZt/OW3hQZ60RM/fVHpkJgg/i?=
 =?us-ascii?Q?I7a0DVg/O3/vacVj2vRQLSPmBOvALcS+WK46icLSeOgAYqAjebQT5Qga35+k?=
 =?us-ascii?Q?OGBqbx/kxAKcdXU6ksCi3s+XQwzJRyKdy3Lf8ZCMKJNenWrUaCMtZEOMeE0m?=
 =?us-ascii?Q?m1n+8kdIsrpQ+AtsYjqAg92S7ibwCqm90Q9BscwNKNXxC0/H78XLhMwWhQ1D?=
 =?us-ascii?Q?uDru8ZUH2c4PSEOFDEkVzqtk2ChUfBYTw+9M1cdp0ujKdWYWKRea+Jr4AH0N?=
 =?us-ascii?Q?s3UsfdHuTlyIvTrYiGGAJ4asxA7KOG13+genf7MuN3AaViCA9ermv6BCMwdK?=
 =?us-ascii?Q?eQOVAYxmzmMCx588Qm6U/sQ5MOAt2SIbsbMlf+pO/CMkqhAT6NJwYitoZrPn?=
 =?us-ascii?Q?MEbBU4ib8A/G4N0q2D6OmIjx5nwonae01cHvVHZbMSSzxDJKx4AkPRiLtHuD?=
 =?us-ascii?Q?zXcRgZ/8jQYu9dCtc9QjP/I+IFPo7VEU0Xh1giuzBxkw5L6QEBYye6yttZwF?=
 =?us-ascii?Q?nWAr/iu6p7Qk/SEnvv1LiQCi+r56tCJXR0VhSBPf7KLU7fp36JGUxehLKzAX?=
 =?us-ascii?Q?+No0eHnjqvfoYyKTcgJFgTPC8hOnIaltNGHCGJOVE5NhxDy1BAcJ02obc1Jy?=
 =?us-ascii?Q?3sLuTkCzaQeaUqz4EiPSFSSZo+tdM/zV644VAY9vudMVRY84fstB7mAwDrYo?=
 =?us-ascii?Q?stql5pWJ5KuhTKZfvS0sPiJGRwabImDRkvVkzT4x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f152471-7d6e-4d20-ac80-08dc7ff8b4ea
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:15.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iNzLTbC/JtgZJbWeiXOGtvOuTSb/GpUmZmliZOF5Qml07gCKlH9qNjKuHsMh+q6Bhbekn8mZTzG6MKN5U24pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

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


