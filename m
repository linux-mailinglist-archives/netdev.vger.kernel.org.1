Return-Path: <netdev+bounces-49830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDA7F39FA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB88282A21
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1854BED;
	Tue, 21 Nov 2023 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JntkBZwi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85EF4
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 15:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnPAsnoG4Ql/L65np+UWFTFfwUa2rhaJ5aM0xOgrssNnJj7M76hxxNLqQcXuuxqG4HjCnb8/8/sN8wjvdjoiC513qXbz3fTzGRH6Bx9dqxZ/lSZ53g4vyoxOGkDurEnmMOh8Wi9xvHIduBp3UXMY5nre1IcjdmBDfiP+3qk86vp5GLX2nEa41E9I6iTz0PdeTGMuvpF/M84gz3lRv0DJnr1Xw8sgjKX15Epm0pyS9NBG46JMkAQqZPlQmy/FmLpk0Vjo7QkXzK6KTl6k0BMt0ybThoxUuxnPiBGWc+czcyg6GoqY+UE/zrpSEnSzAtv8gt3B+RhcrBrUagfzo1LrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TagciM3ZZql5rWGCqrdL4VuaVw5FrpdZ8CMUBBO2aLs=;
 b=QQaPoIz3vQppOdd6Mq/eft9+Wi4Plyusrd0lQJBhF1GSyLdjOX15CKngg23B75Sf5U2jPJY8GfwKI/VeWadjAudC92g0ftPLI51BA2qOStZ1lutNaNMxlRZgyFA+oRJ7cXpS3Nu5caw9lp8Wd+u9fd72zhlPjL69TAvFQJGE6tWVj/ptjVD+D+LcmGLqMcgiGI9fWG6aPhrtd9rnmhvz7xLblaVkoVpPkfc2vEf9K93LImx7mN1HRmBhf8cDTzmi5XJMSVyBVIYQgmMT6Yo8esUQeE/6xyZeQB9tCQUChCEwEqOYhWyUWN0nC9jyUJTJr3Wds39ZICLZvrssp+flRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TagciM3ZZql5rWGCqrdL4VuaVw5FrpdZ8CMUBBO2aLs=;
 b=JntkBZwiPzmQHdjIXleLRjQNQv3k2bDGCAF0Gq9xjabzrC3Jq5wAreQTegi8WXVPJSWoG798JW68Y34y6+/anpdNWgSBKhhlzUUAW29nxi/pw9QN8FeL67ZGnT4wr4kL24mPwZvQUL0417AORwh15sE8ctcTlX6H/l3QA+Z3cEc6cQBzACxcEo8BYaMslnrJqqikVX5oGM/HgVOo7mD1QALKRLpKz3fUgc3oNUW/bkZHUTcc24OuBKNLCfp8oI2VuKhIlbhAY8fnXC4ElN4XSVdUxlIlXyv/0LtcbbeqyElQOhXzUxt+TsN8O0zIhW3eLSGDSZ50iX6uv4LkAzGrsw==
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
 23:00:46 +0000
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
Subject: [PATCH net v1 1/2] net/mlx5e: Correct snprintf truncation handling for fw_version buffer
Date: Tue, 21 Nov 2023 15:00:21 -0800
Message-Id: <20231121230022.89102-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d8d6c0-2603-4492-c9e4-08dbeae5b28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ENVhXRLlSaOcShgcIjL0H3j2pIl+ngNF/eE0m4zp5wgZszqcZDt7g/IbPQfTXCe04dQC2w3+ENtUySTDgMGu5ZApfu7rq0kQiI8bksxLgVS/p5Ig8YBO8Y41rd//omYA7CqQGyLKEx9NNXoSi/cqFAzehx9hUGkCNHn6f24m/icAFbTpENzSIU17WHK/Gop8dFVFZlzNejanh1UkIKYEMsZuKIsKKE2Rz2Mi/nNxO/aBTmBa2j5FCnuEUovKs9Tf8h13OQBxQgEnWGo5fV8jr1w9ARUf8UD5nsXuHs8ErdfG8QsmSTP4v0D5jkN8kQG2g5iYiG3DHzTksDaZNqwS0yTVnGM0F2+gMSjqIeWjaI454iSz0xcMo8qTxq6QcJeN5AL5cmsaNhHluvMhZF+eU6B+2pNr1j8/ZgpxhN78VjZKQPIRSAEBOU3FW/b/RpSdKN+TV/Q1iwqdjHmYTHhDtGrPs3DEB2p69wVdZwaTAHp2+O7rcsazPF2254Kcxgzb9sOjJZLTAL2QqpR3Wh3Q6D9RCwBOpmcqi5VLN7S0fk3ATKEV2vk/dugn+bwe/kiw5ivZzRnAWfw0KS4ZGFiZcUiRzSxacef32583CbG61Yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(8676002)(8936002)(4326008)(38100700002)(86362001)(41300700001)(36756003)(107886003)(6512007)(2616005)(1076003)(26005)(6666004)(6506007)(83380400001)(478600001)(66476007)(66556008)(54906003)(66946007)(6916009)(316002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CuEjwTJp+qYJIhla9HKKhalSCQPVCFZPkm8UmCSfe8NxkGL1nyXvV/c8gjKI?=
 =?us-ascii?Q?7L/TV9o7uDYBjqiXYRZfPtUmhlv/ybj4h5igPFrhVNaPLEgE7aZEWMOhSTXT?=
 =?us-ascii?Q?mBr5Cu5MSm4AIVkElm0aewnEwhiSytAOpidU89M1OraTRFzHejqbx34cTToi?=
 =?us-ascii?Q?NB8eINZ89DxlBYuvNCtmBeDbIyaN3rVfycVF+9+hWXCB8cyHZl+tidPdDBcb?=
 =?us-ascii?Q?aF4dea3BlE4wK9mSjLkJ9oQtBn5JbkJofOtz7iQwQABr5vKLwVYD7zkJOLvI?=
 =?us-ascii?Q?XXO3Cc893uqQ409Xt6IPfTahal+tlgx5rC3DXBuyebNlu/XhYgfa1vFPnMcG?=
 =?us-ascii?Q?eIGV+xgzJqam/MePeUH4xwfWRKU8tdduYTs4G0aUgr+fvT8JiRg91TvAEb0h?=
 =?us-ascii?Q?okgobj6byQ+v6og61vlloT5OIbdNC9pMxJHRDX+22H7y0m4eq4RuabNn/5g2?=
 =?us-ascii?Q?56aG/pskT5J7SoUAsiyXtl42qkWJYs2uwTb/Ual6sv4PaHq5YQ3CQnaJRjwu?=
 =?us-ascii?Q?kUS3gHUCmvkL5xEvlk9E5ZOSlnRpU9+Ax2wDsu22gGp9GrQdxyUjAfNmidMf?=
 =?us-ascii?Q?sceXoFxyl6+S9ZaLQi5+2b+DK8i/32b+8xqNubJqfOVzwj/3qXcwsq2Ke3uu?=
 =?us-ascii?Q?VrAAb1zIFU2neoQ7jBXRWwpwAh45kkRvsuMs0KfUhcETUpuzDfEJIHyCztda?=
 =?us-ascii?Q?N5OjQJgrz4Bhgo0aOS0li+SBXIdoQx3o6nUy5jPEOcG8wnlpaapTwsFOKH99?=
 =?us-ascii?Q?wmtDEan8YGIaS/fpHg4OU2vhNcSF7ZP44b6EHKkW1yIVu/eXwimK+ibRjKdo?=
 =?us-ascii?Q?4ojN/lCHGA8P6xZB+XgdgFJIneWZ+A7te4bYV/eGog+j6ZZ2plhuIx0tpqmg?=
 =?us-ascii?Q?vbHENFS1kXMQIbbhYPzFoFHoS1ha8YMQYZs4jliA5kjX3w/sQOVLa0TAhGFD?=
 =?us-ascii?Q?LA/Zsxexr2iSoraZ/SSu+V2098elXLpB9oirDBVH8m/s7aG3H/xgjA9vvpVg?=
 =?us-ascii?Q?1KKF791ljY4Doo+/0JkXwFjnVolJzAUcH537xsa1m63E8aPjVFg/fJB+pMMk?=
 =?us-ascii?Q?zCWfRHJ/HCyKVA/Iaf6JTTDP0fbkTjaS0SsQz+lJ5ZeGUzRtm/8QhgDxt8tO?=
 =?us-ascii?Q?wBTQqUOL6TCMmxniY+w/YOt6rQ6hHihh8H4WWlX7CKpoY2j3u8/mXdoqTxmM?=
 =?us-ascii?Q?kdYOSOfcAD+X/adtVI5ytJljhDnHyE7+Qyd0TX3P6K1fWAKKWIQwWWEyGhmr?=
 =?us-ascii?Q?76mKlf7i54akylu3ydvRiV3dZoTsK/gjd/KFIFu9psX1gvxHFdeTmf07Iupv?=
 =?us-ascii?Q?2AzivqB4c8p58XrGGA42Wk2HEOgjhDYiVMdxj0PNi1rXUaA47vRGv4oDyeZ7?=
 =?us-ascii?Q?dI7QFBgFoKGwnAH3g64Sqax0CkIPsVmQhv/QzwrKzXkDcIQ+iZ7O88gi51ef?=
 =?us-ascii?Q?JjbATf7wmogxbV50dt1oDBAmeEJL5oqew7OlBwe7PhO3PV+EGaWLY2vDARCH?=
 =?us-ascii?Q?y3Cnqq1W/iEDuuTMQGZRjgv4wIH2RfB+hz4R2NnJKMbzdn3QS2WZ5CxxWIuq?=
 =?us-ascii?Q?bpHsFpslwu3o2VuMUpkLx2xcfqkq5chy2xXTcQ7Hqzfg+tE9ji8cCAAkdQU/?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d8d6c0-2603-4492-c9e4-08dbeae5b28e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 23:00:46.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsCcfo8blKDZoaTZbigVp0R+kU98bqzfjuM5MzzSW0udUA7wMM3rXx1OOQxErN4tKdkqePQ17kRhZesDWhUIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

snprintf returns the length of the formatted string, excluding the trailing
null, without accounting for truncation. This means that is the return
value is greater than or equal to the size parameter, the fw_version string
was truncated.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Closes: https://lore.kernel.org/netdev/81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com/
Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
Fixes: 41e63c2baa11 ("net/mlx5e: Check return value of snprintf writing to fw_version buffer")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 792a0ea544cd..c7c1b667b105 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -49,7 +49,7 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
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


