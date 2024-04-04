Return-Path: <netdev+bounces-84865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2B898827
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0792B296FF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD7127B40;
	Thu,  4 Apr 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lud1wIk5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2094.outbound.protection.outlook.com [40.107.93.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05615127B46
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234324; cv=fail; b=BjSgUdeZARZh1qZoh+ryRWA0eIoXCyekAdUaIDPYugUdC8FRcwTSFuumG4dZJsKmiTHsR53qKW6NAIzx4z0nKJNYll4MZwmbXi6NVY3fiyGsKrlgdVlnSDlAtOtzzPQm/QQ39tHyXj4QWhSmOtV/tYVasfpOZiPrC1BEf15ARAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234324; c=relaxed/simple;
	bh=L+fATSu7wju+xIXEvIlWuzH8g12yUZNew/Psv7Lz+Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dRTmmDi/qiwtl2NjgCSSOUsTNjLG8E7qeo3FnvfJuJRMamk73t5dgypgZ/pvpozkylmEvfArIW/wy5nlrS03dR9JmhjkcAlEoEIXh7Rn7eXIZvo6EbHpgCRI17DLP8CMTXGhRzvsC44fSZS4TIE8GV2nSyvGpOvMA1uE3Kvg6Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lud1wIk5; arc=fail smtp.client-ip=40.107.93.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+3PNbJUkTmntc5Y0aRmZ1M87KKHaHT50cbxmQ+aPJr4UeepUf6rW4SgEi3R/BYloox1hLNIy9zMQeFSx71lKTLKG15eFRj+TjcONvH0fA2VhmHh4meWwW0ylusvRKQJn9d07nSU1HJ5Jf2isUqU3tIpCItARO7364TlJMzV+Z2ag30r/V/WP5A+kNJmpqnJJSfquzvJrnwYbiwRiliGWTCfBYYkbo3Ih7Y4DfTneG5JXE0rvG9rLEPKXnpwABKj5LHFtzGDGHIq0jcNMRFgvm7sLLrRA6KgqDbPgbmiUEctA9h+D1vgVxRCCgBOVhnb5hMg31G9ic0DxLIrOx31sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=SowMyjpmtz+uuzoxEZ3yNgDrwk+deAv6zURlnxIw0LVft9pZInW1zfANCCL0vZstMuig2BtjFPLhHWlg8GUY2+UjEPszSCQeKwTihrkuvbC63tQreLfJ7ARY6kaDGK5tYdH4tFD7KlNoSvhjX/zGhXtF9V0CC1WiMj9irt88m3o5uuOzSu4LopkbQgu7AlnpHu22H3DU8RnIjFrghskVED6twcmX2SDiQ9+NVccnWHdx8+ufWvd1T/OkeG9UjoDua9u4OavRtpKKX62oSzrb9gIsy1cgB38dslGNa8KYmF4l6IadfzMvhAU3x8DobSbPxodWKJZHfr4G9Bje7qaCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Lud1wIk5xBYOPi2OqzgZdVbbf2sDohxwv1WE8jd+udM9i2Mo3mRJyNtJuXqQ1Br+jMsmzRMZVCkIJEc0u4ibAu5BJRtLNvAwcauK0330irjj8R4Pm731xX3u3r1+dCz8TtOIVBk94/kHpTyU1/26M+kzPmWglKluFwOew9cxqIFNcL1vytgTrVvRI7iQyDrQF16IEwLjiCkeC4IcGKh6D9Y+i3NsipUTy+s2uR85GHtFLDWOz5uKdtuqctf4nTIsHXQ9IJcv5hPhrkVhyic7DgXA5OHCv/dFel+/isVm+JAPGurbpIBc7b1KE43I2WUkGrcg8C5Ge2CRueypj1TPig==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:40 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:40 +0000
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
Subject: [PATCH v24 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Thu,  4 Apr 2024 12:37:11 +0000
Message-Id: <20240404123717.11857-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yKseTHHcCumrPkFGJc+3YGaYr6rmEHJcZQX7lyOsVJ2ew12qefK+0ErhIImzicAe4QnjTcvOVsJpbx6rzh/O6im7dPxGrsDArRHLoo6D1TzTiBzaqGJOcaE5IIDmqvhrbdG+M5J60/baWODskNJRWBq3thcSI0ClODeMW2wVati5Y9s1pBqapaj8SrBcUNL8hcTadC2+HvmHTLs3rT1RJWEobKSfQjNj/nqR4OOdYtrx0yISIXA0YnW8Rz12uW8q9i4wtyOytv5jrDwzM4YoX2yhAIDQNCQe2XpEUnKPpbn1ra/P/xJQUy/EhpuB7xlWnEeHcBVjhd0HwY5lx2Igb7MTUoDSGa9NZTbI+M2pVGv51JTXfzP8AzItx2eqNKCL/l7fu0sM9FFCGKURndf+zfuMAoOI4/comwjBHqqHtlIwkSpuSYURrlJDAAH5jQLITqy7l2jNThydc328KjLlOsXDTKK9bBa75cYZ4lXcjPjpDnY2kNamFiHV5RChi5q7lzmQDPpo/hDysoQkW+Qf5uXUqeK8Hroqjo9e8qUWlXe9cjL8CMU+SqMDyYVt0HHlVP4PBMTQVqzgvSGESax3eju1cxmHT9KbHWfpWPVrB8pVSQraG8jUhqmUbWp+AO6fU4072s+eQWYvaw1BlJRx7FAryrhhOtzQ+AHnVLN2M0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrnQX+WnXdxHFCvxIUF1/G7/2r53DDj3tHpAsLoRBnHNCTCF8MgVkA8+/LS4?=
 =?us-ascii?Q?sl4UM3ZPEF0ytwBbRP0uNLu/rRYIGhJBiAmDBki5vP636Tqa4TgPiKMQrBO0?=
 =?us-ascii?Q?jZZBub6Vy2ih9n8gmWXIOV+jhyf09tvXk3LXQIw7ZO7nkxCsabGMijJIpSQP?=
 =?us-ascii?Q?Dc84xghDTOASF3GZE7/AWw3gz80eAgKzbGcCXRSJC3o0xPgfU/4tlUcGgrJt?=
 =?us-ascii?Q?aUezq9OT1iYf2URuYM313LzMY1EVUcEo9oHMQxbGhNi0ctNk3SF4ClkWJ5pp?=
 =?us-ascii?Q?gYdCJ0jPYXCsANw4kU7Rp+vBLYIRktqMI04YHTq609CBBTmivSmfS4spfxIt?=
 =?us-ascii?Q?61wkq+w1xb93on3TcDs0cxxyMZVwAapPKAAyrqne6XjjO4gZgfsl5XzCvmnT?=
 =?us-ascii?Q?nZiQDo0HkCweos9Od3aERcAklPBQnJZowE4Yq3EPUyArYgoAO1kVyfMgW9jb?=
 =?us-ascii?Q?k/QVSHXJFSdaujQIAbtfYhlaGSDiEGb+Qa/i6tJmdjQrQv8XVjGsDO50OD2v?=
 =?us-ascii?Q?EtEbMPB/hcEklRJIVQjFOTQP/1qcPybvgmK5SLsONt979jHdCqDDc3zAWIQu?=
 =?us-ascii?Q?ofwjz5UbCm2U7p0/Q4ycr5cll09jDfs9ktWK6KL1OZZ+5Udyci2zqEe3FG4X?=
 =?us-ascii?Q?FnLrALh9smtCPZbO8yDZueihKFkFetDodQdYj3owfjqjX6hsCVXxmeGW6wfk?=
 =?us-ascii?Q?uyt0yEZYnxlWWHRMod+9kbqHZOeZPZwviRZscw1wwpZZ1guK0kZdZvIBZWOu?=
 =?us-ascii?Q?jBLsLA+kMowoIIlKDU1SBnd+JEc3/hLd4mZbu4t8U7RPdOGpjQaatsU5z/Ib?=
 =?us-ascii?Q?wFTjqekOucVRJP+WfmryCS+GngCpjIvQI0H7GLzcKXsBYYEuSqH2NptRr1GW?=
 =?us-ascii?Q?hl73Eng05tPNDAnR32npBR+LiKST4f7ObNnPyZHVFbMlekx8GxBXLmna+Jmy?=
 =?us-ascii?Q?Gf9SbIpi9kOVMLBv5Sjg3mxuMnljqf/jlpEWoTn948Y4TMpGGxaqAwHnFBBw?=
 =?us-ascii?Q?rSuoSV9QGDj3dNmtQWbmsD9dJIOYOewa0TwluTKPI5PDfgItsqL/UwECoNyP?=
 =?us-ascii?Q?N2g9JMxqnLsZ4QjqqxK5yA3rqj6A511qZdW3NLx4MVOnolby0ockF+QjN9DS?=
 =?us-ascii?Q?bQl4PCh4YIoqa1VA8zalxQ8qYMQojBJl73WNPWCxP8sGqoRLUo/H9mSLpoHv?=
 =?us-ascii?Q?+g8Cqtl0WmWyNYhs7+/dKUVafTnvxdNxs5ja5iJRgjyRqer/98bOKh5+Sfpr?=
 =?us-ascii?Q?RoiWS67mwgTGxogojDBtEGNO4I+s3DzfIhjHVxLDwgwJoFBFwYewXVa9uaKT?=
 =?us-ascii?Q?tZbcImqo3KWU0g3jM+uQzSanc6oL4qM6MdlI9rwKRh02oKxlB155r8JeatNC?=
 =?us-ascii?Q?HfDPAkAfvg2sLzrZ8RfgTTLFU/TwBMgJPT26u4eG4f3zZeQ0RBGgljMRJfY9?=
 =?us-ascii?Q?5J/4Uxb0K3q2WDHS71RB8p2tfjCMEt2t4J49B8WiKrme/F3kK/fbmF5exx9E?=
 =?us-ascii?Q?vSMXPfS7Kf8A1aPCZcTRBZcC75xFMDWBIyUt7mGpL426/14tVru+4Z9JvPWC?=
 =?us-ascii?Q?kjJupMIM3fM6Cvbn4w+BWCnUbpP9xZjYunKSPnu/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1f8be2-f044-4642-eeb5-08dc54a427d3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:40.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNyQiirWvi0ljgLvJstq9TQIyzmQUdWQiEtK7bKEpRS5JDzTj6qhVIindj7HeUAV8WAFPKLUKaXzFfRwyFstfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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


