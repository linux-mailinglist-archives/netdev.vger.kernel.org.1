Return-Path: <netdev+bounces-84863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9D898826
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D07B2941D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5008662A;
	Thu,  4 Apr 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MOWDiwN9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B880C09
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234316; cv=fail; b=LKsdb/yN8w/FECLHvmn0SRm4RkHUNhR5btSkvytjU8YrLJazux91tm8W91J9FgsNKZhNmethHNd8DICNcr3DldmQbb1mWIvXiRs228g/xDqXjsaTaiKYA5UBChNtbVpyfrPmQ+FK/Z0mivQKqMlPbRlbLk+K4F+62XiEHxgzBS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234316; c=relaxed/simple;
	bh=U1IFTmhtkgLdGCToS/Po69Raan7yQVn9RUwND/VwidU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOIh0TZblAPQiyeDGIgPviOqPY70rYrNxaySOzv3SABiwVh6U/7RSzM4lOqcC7Vt0ifwCD5KFdmFh9sT+ytQan4hzFk95wZWe56Rrgcj99Qh2cCa0/+RZMbP21TOVQeFW7ardOXpX9Zb8d6gay9zkdw2bwm1Qr/VGEFHUg/eWYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MOWDiwN9; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbYlTo4UtYFzlGTkbhlCV6DhgmfzPVHEX/n/VnJRBlNJzd7K+GipQfJtDfgVQAC5AE+xpn76xZcBpN3ydLgwkwYae+AvSecQa5prxFnUspFm2hmDqMmHP1J/+KqaCsKkHCKfUVRdHx42AyPKbZ5TUt9pSReaF+VRPhK/m4BJvFU2DK8TbKsQzj0E2BKw2bJPuZvIQrEyKBXECd4lovcNBPt+0fuOM6Tok9+hyVHjN3o0TEZIAGPSL5shUJEErqeKcpURZ5hG2fLs4bs68wSQKZJa1DLph067yXxd1iI4xjDNYIUjBRje1kJAgqpnFIVHM99bHKhhzF+fpcWy9z+/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/CvMvpBX742JCUvygk0Sukz3HIaj6QKQlHy9C5PGw4=;
 b=D7qCBDpvQinBxGPdWaBMXRMyA6zIlCgR1EJXrP91NnDSOVGf8fH9u9aLFFtCGP3cpzr3BFL3EoIhkutlqX47OSHFZ7XmGYVeyna4ZY/Y4bzwWMxrz3TzSiMCxU/57IkCLGOH8RRc5c2gsfy2eF3Qthp+q5sUeWFkVR1ElsEhFEfdiV/ASLdNSL5JVZpNG5Lqt0nZ4TZciQBXcADpGmr5x2smEFFF3jm3Ep+jrtgRnnRSiML/fWienTaKLRmunmbnS5XeD971FpXvlLtH65tL8Qa0oSW0Pv99c8R2cr+A6diodFYlai+E3q2+DdR189O1V4cN+K4XBEkEPmCCDmWEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/CvMvpBX742JCUvygk0Sukz3HIaj6QKQlHy9C5PGw4=;
 b=MOWDiwN9ZoxzMlnUxECFS152aY8JpNE6PJLAjUMtkQCBwEtl/i6gxpQpds+yW1Wz89pwus27lPhwB5jLLZz+wzKnmGoTObpA03QYc2O0NvrKQ+g0yzpp52aHTwHatOAxpkkWJsCEcesnSu1WQZ8sJ7Anfu2vR3V7SmFcZtQO6yT8to5CDe2JUktsLQWuGaWUa8/VNnLyjj5YKxs8vNvZHH8Cw8pSKt5AopDqVy0xqdl+9QQcIqg/L4nToARJaaB9zrRWDtFU5VfI5aYK3ie+3j/0FNLokvpkEzI/WwPfGGWFMyvrXQzRJ6kya18q8Fvpk5GX8TTZA/b/d3U9XyGzTQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:31 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:31 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v24 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Thu,  4 Apr 2024 12:37:09 +0000
Message-Id: <20240404123717.11857-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
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
	b/0J/71cAbZU1HOHyo6YqkElGXEwb79OM/jOvk2wgmVbE/uT1/FHNz1nhvX4QeixSwp2fAYqEFSh9ZxjbjMlqwfO8NpY9+ZturNUad7r9fxYL5sbVHJAi4mebwemlcT6amu5Jgbba9fWwD7Xo5Fej6DB7mhAKSJxYWTneMphVN9yq3xR8ssp7VvcD3RdFL21gu/0rmnUrmm9oKUo42zr9zGSLqF83GJt9BZLnpIy3bv71JglKMCP0cpJD0C6PUVkDPa0p3sZdKwlrMTgTgQEyzMtXYjxe+jTZOCMCiVFfSv3JzwFgRNWBJ6U3tu8P2rQvgFyL5cwMmT+3SoeMIcWbBAZADviDRpwVYraFiA+4uwupXZrmN9g+uti0y3HZcUrcDJooREX5iLA7+Vv52sakk4LV9sBaVV09E6bneVk8V38qOukYTdOsbttuljc3eqa+4JRivxq4oHCxKtlg6uQJ4mCONJbh1RRkg6vnWxA/+1JpGUWpZ25+izxpxLFt10RDB6GUsUxozSN85BjKrb3FbKbLLOiF5e3hkpobx4yzDl2tVRdRZDlzgJOQVbSdo5h3vMrjLgAMeh0LbYI3vHXVljQz1gjfMRnng3zsFVIg9AX9e4wK7MJ1A7H8YRPjjgFKQJjwV0IFtWrDE3D9QgsUbeukyg07Qrw6IwgV1wq4eI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpMlKVCkGRGOe9mu7G9LVgh9auSnXHe0+kPTa/Pg/23sndwLpbEMlSXdT5en?=
 =?us-ascii?Q?bpOF9aHEfumSVdGn92AXcbUNufI0JOs/7BGnuCKfPszDwgr4q2cxu+ewih/b?=
 =?us-ascii?Q?cGhWSo/lVqIA5jjvCT5TI0brfxAMyMgtOplC2Ueh5uYCVoT9zDnUdW1az5p0?=
 =?us-ascii?Q?XEVYp3/h+VH7DPydgZjK3NL5wF2lKIidOEEhvI1Vv5JrRfWaAyIApl4nBXL5?=
 =?us-ascii?Q?MeV9XwAw9uf9Kg9LPie6ESlbn00VO5uGkuZI9qg/Ja4M+W3SNRNWb14NwqXQ?=
 =?us-ascii?Q?EJrKnydDzkG02Y7J4uAtOsUO+pzQk0URJbOubafm0TO0DSqDku1iB7//1SiJ?=
 =?us-ascii?Q?K0EgXtYaS+agq7IP492BqF37pEJNejPp6n+amdocK2AELUzXyN0beAwJCzlI?=
 =?us-ascii?Q?aoIb2iFF5kyxbE2u0exhGWqLV7t3mB5Jgy6QqOzcE7DRrGns90Vdox7HUyJ1?=
 =?us-ascii?Q?AW0IbiogmWVgMQsB9gOAYjFatPnTpIj7DZ4aHgZUnNN3bucz80YCCprqitJG?=
 =?us-ascii?Q?OUy/gjNBfw9BZqFwNvtpQdLONWUmsKNaJK5WubVyjRrct4ABPq0RLCmQZHe2?=
 =?us-ascii?Q?5P2D7XxuI2o5gK+qXcKpQ0iLhjL+6bVma37xVSBsKYFbwsyMHwBIm5s58Q+X?=
 =?us-ascii?Q?h0aDtfc1JcaHwGjtP4kmsQqniXDK1HvyDri17ET5EIno1qmWV2VaLZ8Tt41X?=
 =?us-ascii?Q?wNLSEmnCb3agmNCEyE8qdjdf/3HtijrQx+Kc+ebT+o9y0pV/pTqLmy0gQuhh?=
 =?us-ascii?Q?MvNp8PvEaEjDTAVlK3NsZP/ECrsymXq3kYXnYN+AbyVRKWMXIEVzNKtjAksS?=
 =?us-ascii?Q?InZ4atpZJWlZ4YTt5C9Je3wI5KLW/GEHKbGjU3SklGNkTNqpZrRSkZneD/no?=
 =?us-ascii?Q?oGhNSIPpAVPPPJNBfELtkWCq58/xP7loccMqlxsaBerAbVzpRjXi7mcuvvHc?=
 =?us-ascii?Q?qWO/4JLdZt88MVskdBwVA2DXisLeSiI+9brdZ58oW2PDx9/LI4lyl/vbuLnb?=
 =?us-ascii?Q?KOY8mj5hUPA9VegB0N1wBmNlk06hKmk9buf7u/JPp5nsJDL6lqBUbtcDQRLB?=
 =?us-ascii?Q?rA1JP4zpfb5jiYbkAr3o6cob///3oj3CXAoXJ7rhTIA6Wh/mRGBEdaafRlgp?=
 =?us-ascii?Q?aPFT2L8vzBe2muXhLV+FDEIm5eY7VTEVRLAYjT0+KiVTjrY2zEySwCsagL4W?=
 =?us-ascii?Q?5ZWOC7UTq9zihMhHVzqg0Nw3lINg4VEqizDQMxpYwOCF+TJ/MZFCRgW4K6in?=
 =?us-ascii?Q?yD9FRlgshgdTJmdrlallUXwtZ/3ZJhUA9mWnwE65HlRGBuqOJN1+X9YFIbB2?=
 =?us-ascii?Q?Y+4TNL6u4lNj6jedUEwtKVJjV8U4cdPkqTSMpDvWVEydKZHRhrjS77Ujifly?=
 =?us-ascii?Q?Uue3TI1kQM3TJdLxPpCo0riTq5z+8OYj1ISUGw5N0sMe3kvgfT//t2IQJPZr?=
 =?us-ascii?Q?6IL/0IJInGx09bLgETIAeITx7TXwL/oyHEBHE7nWHnvmeYFhz2qzoE31t8yF?=
 =?us-ascii?Q?CNSXMNEyl4TiRejiqbDyt7V1odAgeP2rv+q4VopVvITSjyD2/vneSdJHaE4u?=
 =?us-ascii?Q?7UBQ6e6xVhiUXO1//Kg34Tf++povAsWbi0TZlfBB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4c8a39-9721-4720-925e-08dc54a422b1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:31.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ekWLiQ/ZyeXDmjuhPFEQsuqPSCtMxra0oHQIadFUtQ487C1CnjOEtotGQNDs3jze6GLC2hwJXMQsz84uxu9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index e7faf7e73ca4..b76aafa679f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 66783d63ab97..99cea3707bbc 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -882,6 +900,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1429,6 +1470,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f7784cee832e..fe8c8b9bd72e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1468,6 +1468,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
@@ -1492,7 +1506,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3494,6 +3510,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3746,7 +3763,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3777,7 +3796,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12022,6 +12042,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12029,6 +12050,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12402,6 +12424,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12415,6 +12451,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12437,7 +12480,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -12749,4 +12805,15 @@ struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index f0e55bf3ec8b..c2805cf8d7fd 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


