Return-Path: <netdev+bounces-217239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F8B37F6A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5335203EB9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7882FA0F2;
	Wed, 27 Aug 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RNy8Yw2+"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012037.outbound.protection.outlook.com [52.101.126.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A11DE4C4;
	Wed, 27 Aug 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288735; cv=fail; b=I0EFVHhkIM1RvX9+yrVOYqkABbn9dkp/xGVqmAMLIv5+W4qhTNt4oJDlP/G0Ti/97KsIepCpEiTvRkAXESmJiQIKsk98H771H4NQGxQoo655AcCkd4SDrOW4PVIbPOs+QZN/uESbKDRqgY6R1jln1vimLaEeKnKABkLDK9TzBIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288735; c=relaxed/simple;
	bh=pEccCHuCk683UR6fcKTC+EkJgmW++HhIDmk8TyQiEJM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gbZmlsbai8tT460be3CKY4xlhX25Wih/I7ERnE07GLxclNSXXF3ZXtJ25vY8XR6GR88mJOVnl1hLgayGqUEhW9xq1zzC7SkYgOqIiWGCd/e+Qxjvd9NON/SOBNyCR6BVnq4Xcslmsc/JO9Q+C2YUXueHC0jAGXAZVE/5JH15LWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RNy8Yw2+; arc=fail smtp.client-ip=52.101.126.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLYoHPk/IDTGUDqscMlrCLDTaKBRT6xNIM3fKP1TS15Jp+TRkK20roE8n2vOkLMkIJhDh1t4vyfhAOY4N3B+tp/1vL1MeECPnnNnavwhqun5eZAvaHdEazEeS2pqoeVJO0Cr8jT5TU9ux7ox9aSOEybALkmc50yszlQ38jHew1qkv74helTsDJjMHAUg/SWgcXmgXY5Xk/JRKV2PlmKrJk6zp+kFcHGG6sCKpw8QA/Qub7UVBfCgNNcp1ExqqEjHRyE4PkHD1Vje931YD7b6x80SnehyyKjRzvU1eGhLzyFEj2RJklSSEXRnT5N8/75nklEZBxn30ahpmznAo8kivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz9FNb28Qu8Y48TBgMEZBdoryYqWdWIl9v4qFmV6W6U=;
 b=I5mxwKwnbhCO0Y4XhFirlcdp1GswARKWKJ9ZFrh6NdNy5/dB1/VhWjlugQM5n9m1l/X4jsj0pG3TjgDR0153e9v2nyzRoADTSqetr4p7XEYqw9tnHQj1iqAVhQbMWUFup9L8TrBiaZvk/ZJnVaR6sbqP72YRlsJn1iHzgE34J9gK5MkIv9TiRIzYCY7s1IufB2T9v9iXYPHNuEisBPBnE/ysHxCA39u/9Mq65Q3zclFmWkTlNdb9c9Wxs4knpvdwTxmXpibus2GeqCKRRVkqUmcDph0WBBVcUAuxmY+fd+F3K48Qhf2RwuvaHFyfparhX/CQ8L3aMcb4W0M8Q4ahJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz9FNb28Qu8Y48TBgMEZBdoryYqWdWIl9v4qFmV6W6U=;
 b=RNy8Yw2+uFhLXMbWtHyajWtgeQ9aKvGrDhHomB8qDZLWbXGKagO0kTenHR655d6KlgQN7dOdJCW7u5kdx54bZ19VPGRV1qi03TCpadaUozsau7ZF8+iJwnf0ZjVo+u34yic7LXV76nSp/XfLr6rYjxkLkA5gU5xhPrqPLhK8cCEvtCdKghbIL7MW3q5EbYz5W0A/9P2rCyJHaED8Wy0kIlpV6MhVKimXRJ46pm5Ycb4B2Lx1r/L8GmnlOdHMCduBmEPBKq3ez4ufrSx9+Vi1iC8G4pgKrnTqHqLBBvpe6TnrPelsOr1nuinEv35h5NKGMDQV1UYjTugRISi7lCxE+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by JH0PR06MB6977.apcprd06.prod.outlook.com (2603:1096:990:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 09:58:50 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:58:50 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:AQUANTIA ETHERNET DRIVER (atlantic)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] net: aquantia: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 17:58:33 +0800
Message-Id: <20250827095836.431248-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|JH0PR06MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd65d27-6d2d-4613-d4b5-08dde55052b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFvhBF19hSkFgOwi0WNRC2d2FBIX8Pso0++JG+ALA7g5WeeLlImC5pSONBU7?=
 =?us-ascii?Q?LOmZZrR11dfsRtVAbe3VNOHFsyUl3bD3rH+1OfWSdBpiAYnh/SGQc5ZK0iLU?=
 =?us-ascii?Q?Har4OduxAszYoQgXdFkImMCEATsrYo7uqa8Gk4ib30tAiYEru9nRyS0NJ0YW?=
 =?us-ascii?Q?GjFvY5iDPLXe2LAmbRTkUuOzcl72XmGEGeMPJOPsKXg4BSQTscG1cFBbQtrC?=
 =?us-ascii?Q?bGQOFlRh/SZCTmzCCHhumwi1LxH4DAecK1A6kxgOOrI5RIBnZjreT8LYjXPG?=
 =?us-ascii?Q?ZhUWlnAf5z53qB7L6wyJUhlsisG+VbA9A2H+biY5qhTGvVjHxGjyxgbaJEnM?=
 =?us-ascii?Q?GGAiMdcWPo2vRhGz5trFfOO6hRrUap/kPpoRDP8vggBtf9UyhQnURJz7/6wa?=
 =?us-ascii?Q?ydsdME605pkr4KmpEduoAanRoRGyGqyrfxCRcl56oYeyPnhqxt4VZsyf+x8L?=
 =?us-ascii?Q?p7iITdDUxo3NxwRGYtniqKkvHHsCD0Lela1E2Kw295qmXJsv6N2D0HuN8jVv?=
 =?us-ascii?Q?rlyD5n0KjRgHv1Wc3NX5zV+fpej98+aZK2rMlw+W8maM+8PNhlkFnH9TEJ39?=
 =?us-ascii?Q?O5lAOi9FY6nK2AYTaKXO32hwgBQeJI7YSbE1fel0Bl6PMliiqTQc2Rr5Vcgn?=
 =?us-ascii?Q?Ltu/g+dG3FFStgGlYzxd788mCnX1JSlCg9Jxsj8oelUe2/5u4JujTxxRJuoE?=
 =?us-ascii?Q?IkND2F2T6Pr7gOEQg1m6/C2TZoSjh2h5vNKdsUK/GBzkUKgA6S/X3qhRo2iP?=
 =?us-ascii?Q?VezB0nCTRJKlHfk2ZLTyE+zOMMnB4IC4/BKa0Yb8BG5BpVV6F3obZulLUg1o?=
 =?us-ascii?Q?slwTENNjkieHnI/FOOZboTOcVnVNe6tyvGCZzStFhvEv4bE8TmrwhqJFu0IC?=
 =?us-ascii?Q?/2XxE9IAaSIdaLuH9CrfytP/Jt9Ckh0zPWxYYKUkq5jTsS0ZT1dytccxZmdw?=
 =?us-ascii?Q?6m/u869eo8YO6Bkl26G+yYXOfYB4PcZ2iTB3cLFYgKBKcdYIONwikWDf7IBr?=
 =?us-ascii?Q?wwNEFd9peqaz8/J7RPfdgHcpunN9EUnayq/+zZN3Bb990ZHYph9xyFZQqV6b?=
 =?us-ascii?Q?7ROy/HmV31MWICH9LueTNYz0un9erJo5uICichoc+91aaWZef7IQ4ZAYPyQT?=
 =?us-ascii?Q?l5PzVuLCZYZUk4IXH3a8hmczD32a5or9Xfe368UP5cnMwkNqh2F1oy9geoMD?=
 =?us-ascii?Q?FbR7MjmHFf2Rf1zYb7KUwmQ1H2Ypcz4YLozMVbvkaTbhm0ndE5CmUKHxqlrD?=
 =?us-ascii?Q?9ChAvLG60c/lhysBAHgTN23qJHox463NLC19Lue+0WYhtNFRXznBgcC8TIyh?=
 =?us-ascii?Q?xvr8GYUVcbWtJzYihZ8z/Ol3H3NrPQxnwBNPrccvK+Ynez6K44HEjGmYXbAS?=
 =?us-ascii?Q?gPZeFAYcY3SBbWOAe0Jv50kmBSFchFxd81lIonqDp09IsTXQwXm/m5OUtqU+?=
 =?us-ascii?Q?wYpcOluBo0UgjmuCSheybvZuviOu6qQnsh52j/4keBU4gMOXLpnIqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmxZ0g+F+qKF+GeTxnAYZxRP4BXgmF/ugKizcouQmKYTKK54pmmF5+My3stA?=
 =?us-ascii?Q?uaGIiWebJOB+ZPc6U7FvSebHTt1tfZ0rBeJiJlPVBM1NNdJWk7sTczo2m8i+?=
 =?us-ascii?Q?KCX1IQ3pxgIUIbk6BKspZ+f1JiOCRF1Sajcvnh2UZS0qFXcPmcyjFMlRLUWJ?=
 =?us-ascii?Q?jKEXGLF6hpJeCLgLgC8Mfz6tUvcqtMvt6kynGXkn30d+rkGiDbbJgcT/jzsN?=
 =?us-ascii?Q?vDWEt95kKtmwi5pWLY90O2IndtuK3brqsRvVw6VVblrA38K978I90f/znLUL?=
 =?us-ascii?Q?Bc+6oN2thG04ML5J5QOavm+bAM/oiB4nhbljpz8rkZZpe/xtt3KtgzXHKvmz?=
 =?us-ascii?Q?3Xv+Z/p1gGhxm6GVIjIm7ka5JTcWF9ud00+62XjQnd9F+JT3aHYaZVPmB2rm?=
 =?us-ascii?Q?kkJJNcxvAPze+eraLm/0CN2Yfn5nIGMSW2IZsAnbO+Z7rEOOVRjCriAnRD29?=
 =?us-ascii?Q?s/2iUkBGRIfjnN83md332erpH+a2gctNMCGF4FMqyX+vTVhZ2cf/0aUUz/J6?=
 =?us-ascii?Q?QX13ABcZkbeW+zCnGmNxW0oz4n/ArIEJxw/MTM0RtMsoP/VmVYXCnnzhQuu+?=
 =?us-ascii?Q?yBCB/8Ceu+yNySSLHcLKzA3OwQrx15yM5LLRqjL0czD3+VyMBWz/3zZ0BW6X?=
 =?us-ascii?Q?r5y4A3151iTPCvTl349sSM14/jKoPpWuhqmCJFRJFjOKzvLBKORcNf3V+1eI?=
 =?us-ascii?Q?/mgQLun4alIoBV0Le2knhE1MtqZpKbP/izt8T1D9qMjN8Ahor8rTH/gBudKn?=
 =?us-ascii?Q?HSHsVM7d+seLyJdEk8BMi8Ja1QZVdy6Zk3wBn8AGB/mGDpN6hT5++4sKeHHa?=
 =?us-ascii?Q?u5KFSJZ3hO4/D3doVSKAmdK5Z1MTIKavwC4r2HC9AkZ7xTny7hrKFKROQiUd?=
 =?us-ascii?Q?lmmM4mH0lWZUuvAhpK6mY9Mhrvzusv+6o+t5yKoj5Bg4OJDWX4iyYD5AkgWX?=
 =?us-ascii?Q?nPq3gSMDoWpfV4eCgjLb1PthSXcj3MuofLcoNXmcQ8I+K7nCv9NjP/9fQRFW?=
 =?us-ascii?Q?LTM4kcAAUL4vnBFRfV1VQhY/4AqtIVmP2mwN3SsnpXiZEddPEkxg994iJxqB?=
 =?us-ascii?Q?wXzyCGKXHYpxJKf5OZCYGG6bbU/agGkfOUr+3yTBxATInB3ZC2SsN/1NOfIX?=
 =?us-ascii?Q?pOpvTGzYScdLmBZa2f2QfqhXltk+wXKhoqfG1ThtezSIm5fCXb/HJcGABW3t?=
 =?us-ascii?Q?iwzN4qQBbTk+L6/72ePCvBC/BZr8DkrI6vKOA51icoDhhDGEHdxif2z1G+fa?=
 =?us-ascii?Q?+GEg+YCmb56szSeiMcUzRnBDWREpgF1kK8DSiK4O5oW5zlyXVgO1G72p7R5i?=
 =?us-ascii?Q?lohwLQg+BINjE1akpG8E0mbAWahLLHMYdhiFR3mbCC4tOh+he8igkK40f23M?=
 =?us-ascii?Q?TFz/ry7Ox2zwjx4Q8nAsUbUX4Kd+E4FUvUQgTp2dKLzf+WHe80oQwU+YrGGG?=
 =?us-ascii?Q?fR8bv29LQjp1sM31dM68I78punek82yKmN4XDVpF8KAU2Zj82UijMYxcgcjA?=
 =?us-ascii?Q?zUwoFI/bnjoVWcw7Nz7XmQTwREkUfXpE4EehKAFQXJ0SWMqui+gxHW+N3Y5s?=
 =?us-ascii?Q?n/uYCZ1MyScmB3rZbYjUIUOTufK6hrB2cCmb9LC7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd65d27-6d2d-4613-d4b5-08dde55052b7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:58:50.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GjYs9xZ+X59soCjzKZSXJGi+jQoxnnQV8wljvfPKT1RkLAqJ1nzqee6LjSuxG0gvhsVZEiDjIno0JxJOSkWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6977

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7e88d7234b14..f5e0f784ec56 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -463,8 +463,7 @@ bool hw_atl_utils_ver_match(u32 ver_expected, u32 ver_actual)
 	ver_match = (dw_major_mask & (ver_expected ^ ver_actual)) ? false : true;
 	if (!ver_match)
 		goto err_exit;
-	ver_match = ((dw_minor_mask & ver_expected) > (dw_minor_mask & ver_actual)) ?
-		false : true;
+	ver_match = (dw_minor_mask & ver_expected) <= (dw_minor_mask & ver_actual);
 
 err_exit:
 	return ver_match;
-- 
2.34.1


