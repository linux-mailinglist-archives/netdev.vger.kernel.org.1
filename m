Return-Path: <netdev+bounces-48464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B277EE6B9
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B80F1C20905
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960946431;
	Thu, 16 Nov 2023 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3U2F0a1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD14D49
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d99NncSJS4LxbHSyt3yOGXu6gFIZqGbGQVAAstOqjVqO8balsMO4JwBrtoFMweW4rNo1p7jIXFRanyOP8lwkYyEEzK2ECp2kfQWUgFUX5/Ewi9QDpdDB/6o28vKa4acX4UhiXFit9y4XBg6mewJJJz40xiqtQ1QcETmjCT2ZgTLnJbuOpk7A1dLqwf67Gl+DghLbJXWhpdbQI/CB81nydbPOapyD6xzvCjmbQ9XLKlO44RjwG4KTBNp+VnMXsJydKqDi0tUwhH5km8LUc5PrjmHl8lvlAliswX6ZNi8EUkA5PL9u5fQC0hjIKayeJ0/65Xv//awqQuNQ13ycvkaiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mH9P2ikgRgP7yu/6cLxckBR8k6Z7LPcxRV7YAlTbGY=;
 b=HEjpPEe0T/24LrG0Gl5rdibHeuMhvpipRgZBI957dM3sXjLr2ZUdHJ7mT3mcG82PXS0hNXiblboZZp9++kvgXYBxFjf5mjJrlcCB/IAYmsyuMIcI/X7Ryz3Ti+1ffBpksDglhwF/BxrhViUtWMeNo3D3FMie/XtntI0Xxqswc3tWRvFIH35FyeiVFdEU/cb2qtsciHyLIBclsMQWgI8JguSc0u2ChFziQPS2Z5YF5avfxYicoltSQA83rgg5T7R+Nd9t5x9y4Qy8UhwLDFKzvjsIBmfdt5AGN4sW9noZz/mT99qu/PTehfb6L8abYSkN7W16PrfjCbyg4Asqzm4pJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mH9P2ikgRgP7yu/6cLxckBR8k6Z7LPcxRV7YAlTbGY=;
 b=a3U2F0a1wjgZqg2BMz2bi2gFOBqGcK/ZLl2nKSpuUlR6Vt8D4YpCYsbOuEZHimyA6XsuQBFRxa3YT2B6vXxEnKDkay3W9jv8FVzT9F6moab5xk8HxkpMY1HZrxEy6IQ19efF8Q6rZfqT5bnRX5TN8lZllAcvk0cn2CfogShZau2+fXjlqKm7a3FNx4BC+yMwB3FFkDr7dMHVylTYt0UVQw1SrQO3J/TupU3GV/fbA1bMdKONug1ZllyF5DcFtUYBdwaFfU5zsSg3T7Ti5OzhpfK7AybkbBdbDR/Q8X/TegpdP98WTTNl8u7Din1OvaBb//Fsnx8xvxP7ugFPSQ/FhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:29:15 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 18:29:15 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC net-next v1 3/3] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Thu, 16 Nov 2023 10:29:00 -0800
Message-Id: <20231116182900.46052-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116182900.46052-1-rrameshbabu@nvidia.com>
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0c8ddd-9961-4ebd-17d4-08dbe6d1efdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KoJRZ7LFl1/5whtbKYZEJQVdhCQTkkxYojKgIGCBDp+r8RXnFElCwo6KQLjth3G64xO8+9aa/yF3IR1HtDPenlWmBENbUPIsYAtSg36DiYHjSXok0agI0b8bsvwbmAQZVXELibHG4nr5qklD+QVy4VHI1NlWqMnRKp4YMWfhpTFneb9gzXktXjsFcqa3TBL0C3F/2DNYXCJlPIVnmKUU845PHLrHfLQqzWmC8+CKH6FqfjEQav3xnJSzG1I8ZFbcBtYXhisSiUy54Q5pFzyZHLMU0foagbuixPL797AAeoBHnQnW/lmmyNB6vyS5ZKNF+5DeO/pfi/eIkpqZZqZ5qqzLKF6q8kDYp3sSuesjLHzfjRcjLHG1jOOf9qRVa8gr/FroGieoxqpl2x8GDJCTnX72aS++BqCw2iaEUhKLnMNeXzCdtlYeSWDMsrB1JdVshdWqxaS/I+a3eIJYvwgHwLMTrLo4xX2c/g3SDi82jVJMp40AOQ57DUXxW4OpbvNtKB9PvTQ7BVDePHyvHbHPU/HTOedjHVZVhhtk38Thyp72IvYfxrbGN2CqJiStc4lf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(41300700001)(66476007)(316002)(6916009)(66556008)(54906003)(8676002)(86362001)(5660300002)(2906002)(15650500001)(4326008)(8936002)(83380400001)(38100700002)(6666004)(6486002)(478600001)(36756003)(1076003)(107886003)(2616005)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vlZ44kuM3scYxcHAFxG4XkO30VBlZB5QZgORYr+2EzyQDF3wa8v/CidlNYS0?=
 =?us-ascii?Q?98uiS8Cl0UxXngdo9NQHURIS0apsjAOf79ZwlNNcXNuVfjKubAcM58C1THXv?=
 =?us-ascii?Q?23tMZoSKcFcmlI1N1F7YzLArb5R5V/12Ad6vXntU16yIIhjl+7Fnqr4gDhrb?=
 =?us-ascii?Q?yvqgupcKENlSPjYtIdS0kabXFwBvG2eLGxlMNN7z3Tfm0Jx+hvFabV/WJA3A?=
 =?us-ascii?Q?yXMaVIo+QlLdnn1cAIemNC+ZQgqUKQU+ABVyTpBX9MeoROSPmJIVKbL4Elmt?=
 =?us-ascii?Q?QvLca4CuAU2ECw1DP97w4l0G9TO+vzC2ev0aEUerKQfYZARooyRfGlbeBp+9?=
 =?us-ascii?Q?ewCZQyV10gKkSDLtMZplz+uHzMiQgVhRp6U9vldm1ZngTYSYjwG9Tg3BOBCV?=
 =?us-ascii?Q?letE8VgrBhjEahZyrVHOW2RmbCsyIPgtoFncpuycizwDWE2jTvdZebhRoGNK?=
 =?us-ascii?Q?sH89Jy3lWB9dQoE+3V3rkTHLBajcCsFm7Sco7vamVjbgcLmeuIccwDdwySwU?=
 =?us-ascii?Q?+uUYkkMkHVdB6imqYm0HRrH6HPvVik9wTt9HyugpUXt6vi+BNyWKlrW/WKmc?=
 =?us-ascii?Q?3bD8pNCNwkQT2qdBf3Z3/gyP4sNkBgAwhru/VNLR7G19BAdILzsp/TkzuR6C?=
 =?us-ascii?Q?mWq07soh4RHB44tT5p9ehxqHm9hcHdNnJANClCErIfnw1gVfr1x/1w8w9AOz?=
 =?us-ascii?Q?BicZZ3BTYhzLav6HCANyhCNDdDKRLwkuitCAJNWOw7MxjOVeqQUtvY+Qz9M2?=
 =?us-ascii?Q?4efeWaYYXWx+++JI4luEGhGbljxS57ZjRL0rze17IpT23NZT69SdrJMnMr+m?=
 =?us-ascii?Q?ZoyiJDS1iHLBZn+XJ53VvHtnrw+dR4RQ14MBEs0NurZOq8esHj8v+hqXbwAo?=
 =?us-ascii?Q?fal8agtTGo+Mr3nViNBfawrlMGxsdGcDMzC9muZMRAK5jLFf7QjoZkQHv25X?=
 =?us-ascii?Q?sKXueIQ6WdGi4tzLmgwByLI8lu0lwmPc8FH+gGejtg9718nI19/zPHrljmu6?=
 =?us-ascii?Q?zCa2M+L8u62yrT6oj4C1iyxes3aV1v3EqfHTMyKWj9PRKTg4zny18+1ve0e4?=
 =?us-ascii?Q?C1RdT0i/Bl2Pvi13X5Y4S8Zrueqi+dQV+6OKkikZSTTUth4m26CyfUm3z6VP?=
 =?us-ascii?Q?FBP26rY5X6mxs61KDhlfyWDqeShOBSqnq0wr/pvujWe1BF+GsQ+hRylwxqgl?=
 =?us-ascii?Q?Wzm+4Ssr8xnrGoaq6Iz6EhysBOMWGxDtgNAUVLXL7rxALwCxkcBy9eBX5HM+?=
 =?us-ascii?Q?lVTiF5E6AtuG6dnX4vNWw0WEB+pim79JlQF8g8sFM/1VFmbnUfIM7KkZnwwm?=
 =?us-ascii?Q?jvAZ3WVHoBZTitOSWIFrKHbaJOUH7Cid4PZj5N7RaaVZsAxntQjmG2PR5RcJ?=
 =?us-ascii?Q?fMGOZghYGt2Gk0HO7boymrWITSmpjsArFtRqLfXjRmYq0mGI7kGFwrL5IfLr?=
 =?us-ascii?Q?VqiTlZa8HXmkcBI3fSb3q5hewyJNTG743IG5YWX5UhT5W9WTFFpVnRxXRMFQ?=
 =?us-ascii?Q?0T5Hif/we71ycBUxMzO9cyV/D8r3ZwzAEDW6OK8WZ3zDit0Eo8TtrRHqtQNO?=
 =?us-ascii?Q?v5/Cx6D15tLI86iapioC6/KnWE/MzpHlNLm/mIINcE1xdTX/OjCYooGWrhW/?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0c8ddd-9961-4ebd-17d4-08dbe6d1efdb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 18:29:15.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a/o69SSibiZOKmn9KUZeSZPPCEZYBVYCWyIwwD7EfwHsnnjnvfsk4vE52lc+h0qi4paJeH6a1B/ZYXw+hfz4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index d4ebd8743114..0e5efe0d2c92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -475,6 +475,13 @@ static void update_macsec_epn(struct mlx5e_macsec_sa *sa, const struct macsec_ke
 	epn_state->overlap = next_pn_halves->lower < MLX5_MACSEC_EPN_SCOPE_MID ? 0 : 1;
 }
 
+static int mlx5e_macsec_dev_open(struct macsec_context *ctx)
+{
+	*ctx->offload_md_dst = true;
+
+	return 0;
+}
+
 static int mlx5e_macsec_add_txsa(struct macsec_context *ctx)
 {
 	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
@@ -1608,6 +1615,7 @@ static void mlx5e_macsec_aso_cleanup(struct mlx5e_macsec_aso *aso, struct mlx5_c
 }
 
 static const struct macsec_ops macsec_offload_ops = {
+	.mdo_dev_open = mlx5e_macsec_dev_open,
 	.mdo_add_txsa = mlx5e_macsec_add_txsa,
 	.mdo_upd_txsa = mlx5e_macsec_upd_txsa,
 	.mdo_del_txsa = mlx5e_macsec_del_txsa,
-- 
2.40.1


