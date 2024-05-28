Return-Path: <netdev+bounces-98628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67A8D1ECF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878C2B23134
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF16F90F;
	Tue, 28 May 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTqw1NzK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9116F91E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906584; cv=fail; b=fban+5Ms/HRDaqG/tbR2SqFTqBNlKaGGBHJml+yDOSO+psf2CCBhpJ9ChDwO9ElpRzNBWEXH1miRj1YEorG2/YS6poD6eS3cGxHyZWrR6gu+vYOckue5O6pby1y2iGBR5SY8XbEJ7VHHS7uIjtOmAbkWy8hSiL+Cc4IEpRisbNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906584; c=relaxed/simple;
	bh=3/sx/6c8I+1DMVRshZmhZZYHhU+DmswXIcBAwlWtS0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQuOn13ctqJ0u4SztWBwBvflZFwDGbL7uR4pQlLDIQMjINGxbipm5RskbFD5C0Vj7Vx71r6D6EpmW1GZ4sw3MoG/UD+hqYNOsmla8xXwnhRBf9PYje7alFm9EbOH5RjqV1475gSFqZb9gDO49YwFfnBFemtxvzoEMUbOdQGS5Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTqw1NzK; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKqWMK/NXXJ71V+4TRtH/rub4S9j5ei9sRD20XNrfRbbJV3vx7DwXOV3mqyVD79Z2tB4UDQaa2R6Re2lhMcoyX9JA2DE1tr6YxML8f/hG8pKeeujyychoRxaESGVkF5uiByRgLK/Rja7jZwMdIfWWH2217PcK0Z6wbiKqQSSDvyL4CAqackwgteYit58NfFL3rcN+AcyAKsQbzzq8lv7q/Ds94zNSFSRuBOXUNVFxFi2s8PIsA3/EZGTW3KmZ81nFGSJ1fnPXG7Y8ia2TuqopGX/5H/RfIPnAce+zW5krqOPYhizPTeBNrpFKdYByQaNEyuglW0sJIpUJDyqcx2gGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiypAWCJz74EwmD9D2cvMYEI7D9d/OYSBqbpYk/rGKw=;
 b=PKwkWAHyBi0t9aG2mqjK1L4ta5hGCeQOynikGY2LVzkMjZmmaX7DwAZ67IH7sXl3F2RosYo+IM+/FiTswXgBerxR1Wbl0DDGCqtanKjyrAtW2vLB7vrCYh73Q3kc6VTAVQkFqhmETKCvzGtvmnmpxjnrefRjsSFVHK1yKgGLLQ7p4sszRYv8R2LpWwV1LOWi0ZZObmcDik3MR0OEW+UhlRl8PYd0HR6jV3IkUEnwbwZ8WwV5qMzr1gGm0TMom4iVzmcUqU4be9MG5uGph0COAJsgh2YyTZwxMkbri+zPEQPIQKIKhA+BbpV+rkrJUB5OFT4YbRFF8UAtMtgnds4WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiypAWCJz74EwmD9D2cvMYEI7D9d/OYSBqbpYk/rGKw=;
 b=aTqw1NzKMouZsbThbr4HXrDrDewRSFGDdUabeQKJdsku/GSLBeAOPkwauOtW8b8StSvWKugkhk9LND9Y7ftM1tCvHEsSVrGAAOZMbpZyuAA7N6D+s2MPAfyHD4S2LDOnuXuxJFmgt5RzMnQ0kRWuULv3Ue0Cqqf0sn9hsPjAHWP6RnX6HCtDRdOpXlhwaSj3GCz6kMuEkcYEzcDcLc0GKve3rsXNlmNfj1bC9mio9ZRNi/QzjqqAYTE0SE2LGUWOXIhD7FD+4muVya6/rhKua5qBcMWqfS9YAjkjZirWfZvY96P1zkt9y0JZNT3S+/hfxj3HRZanu2+caME2TGzUGw==
Received: from PH1PEPF0001330F.namprd07.prod.outlook.com (2603:10b6:518:1::a)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 14:29:36 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH1PEPF0001330F.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Tue, 28 May 2024 14:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:28:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 01/15] net/mlx5e: SHAMPO, Use net_prefetch API
Date: Tue, 28 May 2024 17:27:53 +0300
Message-ID: <20240528142807.903965-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f203bb3-096d-4888-bc42-08dc7f229921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3wbNZbNdsyFDD1WyhLDtbtSjKQmbovhj6A+GGOOBdinmqXvqRJ5KHVXJRiW?=
 =?us-ascii?Q?sgAXiHik4Iil16jXvso3pUtAfuTK7VMW1Ksy2QDE+kdWa1DHNxC7jCSGK+M8?=
 =?us-ascii?Q?G4TTIJ+Vx9HbzuSjd1w/Kmcl9uSnC0EP4KvCy6ZFf7WYLykadyL3pRCdSoCa?=
 =?us-ascii?Q?W6WkUwKTfUWmRr25qLfSYVg1gcpegHxMZWJI5oaUmPOH1/yFd1XjKNhqp7Tq?=
 =?us-ascii?Q?vJTBWIbgw+YwO/DbePivWKYfZMKgrkxeOyt0stoZl5td2zq4LWJCksgZXCe5?=
 =?us-ascii?Q?Gowc39q0l1vTLs9a92BNBv8mK3UcPTFrMo4xpPZxOAuUjRQFkR4k3GwES769?=
 =?us-ascii?Q?+oEaqrMjrX0W3hXHjdvOZAmlHwRL8wj2n6jtjq3WgBRIeT4cyTI1rlmqQ4eZ?=
 =?us-ascii?Q?dSpO2Q8GOwuK/Mm60u18yO5VehENzPFLYfjHOXokN6OnLWkTsUtdkDemHMYv?=
 =?us-ascii?Q?APuamMd67+ObZ875OsV91Uzc1ITLrpjXvzVFu6kMazOIGyObg3T+YdVjrFZi?=
 =?us-ascii?Q?r7aKEjvii91xliNN2jeY2Gg3lytkjMH7af1O7t4+nM3Jp6agr3x9r+7oYQ9B?=
 =?us-ascii?Q?6Cn6VC/QxtNsPV/quHLW+C1yECpkb7WmTZKB6MJspOfetFTosxNibi0J8H8L?=
 =?us-ascii?Q?xRwS6RA2R+gNr7a+eDH7TBy6GTcXULcwoVZZuWMzRE7Aq7OIDrfN+wda71BM?=
 =?us-ascii?Q?mIaXAVj7+4qaHkm7wI4+UFNlTe+ETJ66JeNKL6eATz+3Mosv+RpeL67FLKZc?=
 =?us-ascii?Q?vxslDQRldjEir3PIPvpnLv7RybCoack6aNU8JsT1XMwO2if5N6F+YpIUrDqu?=
 =?us-ascii?Q?9e2Gmr7EKgoRpLqEEH34fprqbFH6BRWPxq/yDIS3tDPZG+hA1RgHdoZCZ86j?=
 =?us-ascii?Q?HUpEA+NX32S3kbzuTnneBjiBrYL3owtuVxNDQY9pYlQkBUm1q2JatVrMVnnz?=
 =?us-ascii?Q?D8LUdAXGXR3ij8IDAaOgtWRs1PUeBJsvd3y3oUHoe+5Mj5LEvelukqdn369j?=
 =?us-ascii?Q?zj1Xc/f3FN+yY98hghFxx1QbpYjy90le0jafOA6KpjuHkZp2pdvNgzQ9ujz7?=
 =?us-ascii?Q?Ah0negxaNri4bFhXoQ+BrV1+sMGGdepzgncT+Jp9OVom1V/G0lqsrY+Dz4/c?=
 =?us-ascii?Q?6KCV2VG2L9dpcVwYDlnNGt3NGMYRQNjAzLEwTt4mqhCrJvYwycoaMhuvecnb?=
 =?us-ascii?Q?i/RF5qaILA2zspdDKa1O1zk4IDyqyQy0zM+DjHl4FS82DJApCgd09nzZ7N6S?=
 =?us-ascii?Q?hVbGBlzjhcVPjll2EkjLZyQGdeDqiTp6MKEiq9Xpjb8ksXCzHMr7/XvxWRes?=
 =?us-ascii?Q?c1Vhe8Uai3do4T8e5qo/5Q0arwwdv5q9BqpWuyH+G0qE7rMIQqPq0XodLnu4?=
 =?us-ascii?Q?SMeWj2k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:35.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f203bb3-096d-4888-bc42-08dc7f229921
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

Let the SHAMPO functions use the net-specific prefetch API,
similar to all other usages.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b5333da20e8a..369d101bf03c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2212,8 +2212,8 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	if (likely(frag_size <= BIT(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE))) {
 		/* build SKB around header */
 		dma_sync_single_range_for_cpu(rq->pdev, head->addr, 0, frag_size, rq->buff.map_dir);
-		prefetchw(hdr);
-		prefetch(data);
+		net_prefetchw(hdr);
+		net_prefetch(data);
 		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
 
 		if (unlikely(!skb))
@@ -2230,7 +2230,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			return NULL;
 		}
 
-		prefetchw(skb->data);
+		net_prefetchw(skb->data);
 		mlx5e_copy_skb_header(rq, skb, head->frag_page->page, head->addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
-- 
2.31.1


