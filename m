Return-Path: <netdev+bounces-49831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7D7F39FB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544A61F22FB8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEB54BFA;
	Tue, 21 Nov 2023 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPiHZsHd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72D191
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 15:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKxWl7QVyXJP260Jvufg1ooQLpz0vDdZjN7Pt3S4stHFlf3SlzrlWOxj6U8WnAumuJdPbbri1YCXFAUVLX4ZzL3echiJdZZHP8W3NBCSHQ6+4ytfyociDmXPviTENG18xHFGipJ5YCToMtI5S+rGtUrPiTJLSO2ewTRC8tgyBSJUM+5CwNFFayLy0AZALZOF6IiQ53jN5/zYiTmBKhsn3wUvMgcTRgjy3+17DdF865cgZTqjwVOIiNwx6yT1Wa6NCnvsuUM96s29GDKnrf6eUv9ThwOaYjQD7Eufr2Lc6TQbCFgGxFls+DPJibL3NCCNtSo04fSyeqXUGq6rYEJ+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FizMkuLUQ9CQ70jsCCHLWmL9hIqLho02Yo/Vmwp5Q1A=;
 b=aDALeqDSis9lS964sj+JUPBJ2gHW/dTI6zGgvEJ+dj5KQzYh2r+x3xuRXyoVasgzacE9RHvS0RNBlGbr0VGtuD3sDmfG3jpu+B+3Ob/K512nEyv266c4KrRdA03VT9QxjO0VU7gTYpJQUF2DZRt6igEUOiuZiPuMaXJGCPB23tKA7FfeXCG3zsMTtri52auXSEAjl2ytU0yfAo8GU/sfY/mZj9vauD3R16I/F4DnwD/ZHku8HZfW6gjZeqhB4xTXknUJiRjnzAq9WV8jhb4GJKG8dY4AykIzoJOc5/s9ayLesedmnCDtOPSfU8t/Yjc58GcqH6nhDYOY4Yx04y6S2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FizMkuLUQ9CQ70jsCCHLWmL9hIqLho02Yo/Vmwp5Q1A=;
 b=DPiHZsHd4LfeW0uC+xl8UT1NDd52PjQbTlpZRur8UHCwYyWghy5yaBiCLiHKXvxaVtnwQK1oy7mhGDEz2TIzv6ZmYYWBOR7qFx9MLBt2fRtFpdfD4TVPYg5I8LPrm/lwAjBcMH8P98+3b1GPeRyqL60km24VgjxVx3dLhqfVCAljIKS1KLBJnTGztSLuzhNsceTf9HunCUKjg5g5FqpMX5ajAL4Hwio8E2KBZyXkScs1khXWT9Escez8QJwiUMM0fJa3lRlnAyzi6NOZZdMbLm2ODJv89A9HkZg0lkkDmesfXUKf5NMwxjZ10o+HyUA13MDp+5DtqpyNEGruWjAl/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 23:00:51 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 23:00:51 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net v1 2/2] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
Date: Tue, 21 Nov 2023 15:00:22 -0800
Message-Id: <20231121230022.89102-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121230022.89102-1-rrameshbabu@nvidia.com>
References: <20231121230022.89102-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fcc057-7ee6-4972-e270-08dbeae5b3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VZDGeeRTrtIAHeaXHhpHxDb+27HsNh4M3jEwjf9mCc2F14fUOUNURLN4xfmoHGMMRD2cZmA6KrOQs9ykjJQCH26PmvBtevpjeE2nr2rPT/uTRC3mS9ydH7rkrojOci/9DEjSD7ESIdEXlrKGLlprAfOMinrfaHucvnN8AGCMDirPVpgyNGvGy/ghF+8dZig6hCX81dDrhvbsmIh/IG+lP5JLC8YwBhriADBhcDsKs3o/thhmTbZz5hBnksSGbcU+gwQhPWvBurVvt+otV0Rg5L8qI8w31r6Glv/hbgvI7YFDQV0JmLUL5zWGOgDhEz98cWxads9lvu3akDhmrnMkk4CVR3mp5DMPRetDxOWJh5DV5FvjVs4J3hpSbcDgZIpUzf3m6MLe2Tdp6y1Wnp3D4sZv8SMRTwWO0gAER8ppRHOxHDmozOY3Rkh652GkZGTkW5TOdFhPKT66G+RandCLrVSxgZ8AP7RUcI7yJLWNX+RR3Rf3nsTWBx0HK7pKw0fOvA2VjYWnK5PlAmHVHMm5L6hDq8G/17+mk7g7wKAw4unTTt3nl+J16mZXB2bHWmDYVzmPqVp0L0RSvepK3e8pSpvCIKa6zy1pO0HdoR61F34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(8676002)(8936002)(4326008)(38100700002)(86362001)(41300700001)(36756003)(107886003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66476007)(66556008)(54906003)(66946007)(6916009)(316002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NF/u0SdUjDZ0DBix80wWtMR1UgxX9Uw7dk73dNqUVTKeZJQQPAisRaKqkUQO?=
 =?us-ascii?Q?KWUtVV6UwmaEqJ1BAloSlBJHsjp+RYLhlAAIvpPU5dpWZbohD3VPwxhGaZBb?=
 =?us-ascii?Q?W8qLMdQrKV6ASAmDd1PB4HDxAPTBQWUwZDX5UISBHydouUMNha3991XxAIGt?=
 =?us-ascii?Q?ZLZH6cbvH08msy5e8oCxCxKGZMeB/sviWAQKbHvstOeDKH8mfhtfLCQW4Jq/?=
 =?us-ascii?Q?LIPSJf8cRtoWSm3NKiJxnJCwM4wbexn/sJWD/MdH7+oOihTFmbzKbVLWSDo+?=
 =?us-ascii?Q?h0izliuAUrINDvqRWNV78ANz3To9I0FU5cFZLiGvzN4NyFc287aZ9NEWjxBy?=
 =?us-ascii?Q?t8MEgM72tCuvaamBScXM6BHi61LChbNx2GuEX6g1tR+r85lapC/IJHOqFvI0?=
 =?us-ascii?Q?Tx+cqYrVcgQFFqibrwHZzsFLF28KU43GPJV4kE0y7kXPHdboG+1u1RGBT0hC?=
 =?us-ascii?Q?YMIauULOhBTEVQPy1uioair3LpJIkzVOXIauZE/PB2erhy1tVktAXHrXJ8ve?=
 =?us-ascii?Q?dY5Lh0eSiOaI9etVL08zS0MZWuyqXfHBzeOR6Vhaep0kc2s8H879M8PW4Rgp?=
 =?us-ascii?Q?Pl1R+EZAVTT+LDr8e1WuYW4l6cZYy40RbNQM2Ql/8F3MyTdBjUzyHq7iazIU?=
 =?us-ascii?Q?r6XViyF+VYJo80dTp4OXA+6T7SXk6SI3ZEpB7M5kFtTE0knV/jA48G+jQxMI?=
 =?us-ascii?Q?btzuMitqASr6VfRVo8L5h9iDpaRW4tMmuo2xRAubMpBklPTKutlZ/Zj1618z?=
 =?us-ascii?Q?BBR+CP8al/RHYkRKsQ89G9YuORrSKQuHleToUqzN7Wkb6euXU0spTco6VNl9?=
 =?us-ascii?Q?Eez9qMULIeG3n7fJTKvlFMbEVVXo+xiJxjJ3BWphie9ysZ4vUvWZ2Vqq7UxD?=
 =?us-ascii?Q?KhJAPQcjJTgsUhdvKWtklDTEzjIFgr48FPDDTmySC2BvbqcTeErIi2qHiL06?=
 =?us-ascii?Q?Txm04j1o1vGvAetJLAYahGxMKy5X0KPc5ZqDEhI0vBzsQRtPPxeS+jX1AK6x?=
 =?us-ascii?Q?abNAxXGeXfGQnaGcYazniZpEcPB5ZI0auroPBitTQ7MIT1d6XrUyKbx8HpMW?=
 =?us-ascii?Q?ERIDcclgAgkcqLNE5eEB+XFiJ5sEVjWL+sEp1fS6WzBWNbVCP7PMLNTQPryL?=
 =?us-ascii?Q?QOqwPs+C7qeIpfRP4+AyLsYT3ntVXK7FthG4LTcb0gviskv6QGGwN8L1QaGx?=
 =?us-ascii?Q?lzokGLxvTiMZWyAGIMCz5Bdr7bV39nDcuPNW2LtYBli8mQIKIOiFjiSFxH01?=
 =?us-ascii?Q?4BGUARKH9ZT6rLA7I7GZc2TeHBBibnB1l2T+U1yxH0M7dm74bIrEklPmMk/s?=
 =?us-ascii?Q?XYT/Ov1/znjN7vZh6rel8vAg0HasIMCLfr+KC/rK7ZKu+ufasBDvuWHq4yzW?=
 =?us-ascii?Q?Y49CoIYMBxOMjqYTrglIMdNhRNoEsm4qr5WjYfxH9tYiteqIIB3yTmghHT2d?=
 =?us-ascii?Q?ronJ8WEaLg0PqDicvPpzS6CxFhhGP8qeYZeVkRDyN+8DwaRYpfDEQxVcTmbx?=
 =?us-ascii?Q?+tMR4QDZIsWC8dx5AcGnUWzvQAqPzqQNLYElJuA1Lspae84jUuQbAqzOtYbX?=
 =?us-ascii?Q?/0/+8ih7mLCZInu9Glxcx/UiwqhX3oZef9TgmZ92MoUrt7kA70Ejv0GCaD7/?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fcc057-7ee6-4972-e270-08dbeae5b3cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 23:00:49.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdbT0sTnOHHOn1dH8A7kjywOohlISTEzuzVDnEUQ9MMFsBXs2qn0fSImDf0Sobxx7h/WhNntrG6vSqVr7CAmew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

snprintf returns the length of the formatted string, excluding the trailing
null, without accounting for truncation. This means that is the return
value is greater than or equal to the size parameter, the fw_version string
was truncated.

Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 3ab682bbcf86..8d6cca6e7755 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -78,7 +78,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
-- 
2.40.1


