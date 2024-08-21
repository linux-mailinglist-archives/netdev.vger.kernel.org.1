Return-Path: <netdev+bounces-120513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6929959ABE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD971F240D3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D73199FC3;
	Wed, 21 Aug 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RmzjChlD"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175B199FB3;
	Wed, 21 Aug 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240306; cv=fail; b=MBajLmhUig3MtBi9uYJLRZIu5QNBMFdXysNjFOYsD+PVQhaOxCwc9cPUC+xjCAQqZzxkcLzq4PLODwusZ0rwAcD0fd+ClOEN2gr2nEzpmwiMiq1lEKWx+p+eXXIIACvqY1LNLRtaazHdC3mIPQPER2QkeQ4poflcd2lOqb9x6/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240306; c=relaxed/simple;
	bh=9dLHJxATbWNl9zcVR9pr+NCzhq1GkQcagQKOnHD6gl0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n2xkGNrjpe/qRbiUK8B0wLUusIFqf1hYTVgbnwX/7JdGvCBzZECXdhA5zVr7B5jIf6Bd2WZ06yL/C+Vigx6M70sR/w+AxZXxYxWYJgKxWqN0yZzxCN10R5QzfhuE3A+mRsAJnGBdkXV2y7pYr/ALGmouDDgqnncOtw0KySMC2Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RmzjChlD; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkJ4YY1P3N9UlpEbVWvT4STVTvXk69fcHocwQGAjdvU4UqSerF9/5YJbJdeGS29OKZSPJYGcqBjdt6SBiAj4uU3+KWU/FevHqeUQcvYJ9znmzM7EbsDCA3Cury60a8DHef5fob2mRSSdejlY+l7oosTcw1sMWliKO7qZutz2oKmC37bNEKaEQzx/WO33xgkJboD1b9bgPYZQM78cEtjteFhPwpN8TLgW+2Q6p4eyDmm9ix3qNQtK5MWfrBx9bYDv94zwuK3Ozw1XWji+SUIHVqPgyzgGKop9Pnw/m+4vmBZDii1LXIp1cQIj+3zt7C/36ZCRgddKku0TLJl32Zr+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbmNoin8YCkJC+iXQeIcINvMvShvQL9lyYdGJ+/Pze4=;
 b=Weol4BsBIcU3mnurmp0xob189rUeRZbV4E9KkLKL5mFFB/Cc5N5gJhjbkzwhVZMAskEZz7ufH1hmTQJ31PNBzMrDUUc+8q5UDV1LHhYBidEVSyKmF07gttYJ5dR+7drmvbc/Ya0VkxMLa6lt35Rk1midO+PpmB3sk/1HQkBltw4gYkfLDKSQW/JKqFugFkqqQKHPJftMwOhYEXqZQb0P666O0I4GPZ8TWd9c5jfkvQK4KVYH+mHAtkqqpX0bTQIlhILvu/9EDP1KfgYvbryNUBRcGijZHKfwHvor9fg2SkqoUqMKt36ONiP/x5ISdWpUkVVJ5FcSH20NI5PU+moIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbmNoin8YCkJC+iXQeIcINvMvShvQL9lyYdGJ+/Pze4=;
 b=RmzjChlD0THB3Cyp8jJO1d3mkjiI0ujx1OT4gxO21aLEcAQMOcLoA9+LYYTd/smvM8EbSn87G7xD2CXHIdw2OJu3D5miWaljpE5XCMzLasBqdndbmxsYAxvVxea960wjzUa5phmItuv12jIVFhq0TeYTnnwUO+GyCHry4C/m0vtdGF3OW0APg91gOubP86KhkU+hMobfF/BVBm2tCKoe2eJLRZAGPW4fT14AW+N0/9hhubsIMCvjqoAsceZLQ3F7+Qo70Aua304WlPRf5FI9ex+jMBHasmcgwPftFmxF0yxysagDhR00/xnAhQUmkoOhWCBBNevTE9N4NIaU4dNGsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by KL1PR06MB6070.apcprd06.prod.outlook.com (2603:1096:820:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 11:38:21 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 11:38:21 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] net:xfrm:use IS_ERR() with __xfrm_policy_eval_candidates()
Date: Wed, 21 Aug 2024 07:38:06 -0400
Message-Id: <20240821113808.6744-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|KL1PR06MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed2b46a-e85d-4faa-0c08-08dcc1d5c201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NpM3cBcJ1KlLFHdPGZud2pa/9hUTOgEWaIW+fybAc7gPzmttLnCnvVZiKgM?=
 =?us-ascii?Q?BdbQTyNLs1NAf97J6yJNJTx8UPasyZ2Gj4A9/EIXdsQMEoDmyO3pAWgmemr5?=
 =?us-ascii?Q?CMC5mOlqsKve3+0TdRObUA5yUX+9RIFgMfDL3e7/9LLAT7FWyNnzdi5uCaWA?=
 =?us-ascii?Q?Fw2Tp3VNA94nmEjNst3QtuPjAJmDO4AAyw8iiRknqoKm+JP6myE954gVpspB?=
 =?us-ascii?Q?Jz1qH4w6BKqnMTHxH0Q9NY06NAXsEhi2ZzyLZM5dCNALGg0/3nolQE9OXyH6?=
 =?us-ascii?Q?J+vaO1V2l1DcJpaGyggbfVsA2RA3S6GO5A16YWHfoPYpJxeRePeDYOS1bkLy?=
 =?us-ascii?Q?ElUbrV4ZMKDYBnHMtRqhDzpV7//wcdlSVU0FCrJ4BOlW1AGA6K2g0L1cG+S+?=
 =?us-ascii?Q?3XGmbZMU6TdeGo4UJNDNJsaDVVOrWhAMnVm7D7NHYbdCirowkuASKrBJhxcA?=
 =?us-ascii?Q?m4VH+D0hnd4yRrueYr8XWtymzTIYU0xdkvnk1khO7y45nGbgHzG6PsqAncUX?=
 =?us-ascii?Q?lafHa+ysbDVNBF/ww36VZeFb74omrKufBtti3SbWlosbdt/4teDSpbDb+xb4?=
 =?us-ascii?Q?ibWUxGln5dwHQNslCqrJMnf+Ja7xP3iaDQYf9fGUfNKmpn5k/yr5Xr7Wv8UE?=
 =?us-ascii?Q?ffWItbhWeHKgUy9DIKmrk+NBQuoOdatm9gxaufdeZ5ECncmBYelcyibAi33A?=
 =?us-ascii?Q?ZfsE+BTeLl7iDR6wDuAl8/V7o5TOhF0w7TaIEK8Jr9rH0r1vrF+Elo7pFiJd?=
 =?us-ascii?Q?l2uxcFtGpzbH7FIQHS2Hpx9yX3CJGevxPJJJUBLduJ8nJuXMFQd4zwh9Rh8w?=
 =?us-ascii?Q?RFE8FWx4AiL68tnynI1Xf8kKPQumPKGYrckNiX6OOs9IllbomEckymk9bDps?=
 =?us-ascii?Q?zdnPMaHPgeTrOaJYA0WXeSQHq2jKywydJVt9d+/hZcBIQM/fWcZFT9SMASqU?=
 =?us-ascii?Q?pLeahUi4L5N4f6PKCsriPncSB1OP7QfhGRZ26xy8emVmUJNwxG/jcMOZvjuw?=
 =?us-ascii?Q?Mob2GZDtWKb2gwBKoP2EQsMMXDjIoxBj1rnojGC3XM9lmlFaczkrtNBJab57?=
 =?us-ascii?Q?UIGMOldK2iill/hpBhxMJ/AXJz220EBiAIhQVGq+V6/k9rS/F1oDGiWcSjRE?=
 =?us-ascii?Q?zrUCgrHM+8+fx28nt+d2soyEogit8TBsAMMzDDqZ1N26bXRNiRUK/idDzShw?=
 =?us-ascii?Q?AZaRjpn9jpl605R7MIiq90FH68qQ09my0V/flai2mD47BkApo5P/zuOOu65x?=
 =?us-ascii?Q?ObN4BcA06U5ajwGrGxCYfrKFhZrTSR+6JREGNWO9UjXc17gi1Y80zyiirGca?=
 =?us-ascii?Q?MirZAVN23x2IXDZJP8tLe9oWRuk6EmgAYFB3GUl0Ez3/bitDFx7K+/6BrOhD?=
 =?us-ascii?Q?PFIMBkvTCFmzCjA1a9dOBLPFfd2mC23U3KvuITsLdoOiY1zde/QOdaxC7AOQ?=
 =?us-ascii?Q?o/U1NZid6U4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6z66KdEekyFgb79DUeuGQGA149wIOC3Q7NXA/shWt2hbJ08LkawEUkkX2d+q?=
 =?us-ascii?Q?n20sotfGDrmE4NmdY8721wgWE17gIF2zRw/PqQ5ZuMgG6gmOm1qfUPkEjeRB?=
 =?us-ascii?Q?s7KRR1wpkNNXlsPVPWviWbtsTx9nAB/FH738zI9Ffhynduy0paooEy5BpVNZ?=
 =?us-ascii?Q?FZOMIPGdbTaCovIqUm98FAHC/7IH0w4wD/jwOEY/yEiSfCEo9k9Oi6gizLfc?=
 =?us-ascii?Q?YLOdxSlexSwMXPx9vrQK6V0zyU4ZQDn5GLUV/y5DJIGuUKjYcSo0jEuEJUs4?=
 =?us-ascii?Q?3cM4DvM/f1i7+miVG//10+Y2uRXsi01J/j/9a3ZVKFQzNQZ9MEYsC3z4XeTY?=
 =?us-ascii?Q?JyDauB7vuxEY0JGkXi/OLpzaF34WypweaQiQYYvEDe9M9N1QiQS1NubOkwGu?=
 =?us-ascii?Q?iUrFW9D34XcgPhY4lcIq52JbZE8a2CyXZj4oMrPjdYKXkvD8C1V7ZuBQItJ4?=
 =?us-ascii?Q?0JLkwclkguk6GPWfahjBF9oOXjeKPw0naSslt9ASgqMY2GV11oxREYzkcYDw?=
 =?us-ascii?Q?Cn/iv9VNZj37Q2B1QzAJ2i5zVlSLEDtzjxrWzThHZ2533E52qk0Y82lyLX3e?=
 =?us-ascii?Q?NUraoLDuaYijnZ6hb1P7F3alQO0wLfrLJbv27f6YbrrOn9AY86lql1GIY+rx?=
 =?us-ascii?Q?ECPKHxAiJ/qaKAytZszgYgVXAtb/DX0X5xi97H9BHbZOq46ByrqYyeVRMvCS?=
 =?us-ascii?Q?9nPjXojDQX8jwZsN2UwWhYQV/idy6a5S/P5Q/lljZQMSLtFTiyDJEOfNoHpf?=
 =?us-ascii?Q?hCyOinLfF16nS/OdFQSY9XSOyZogZtqz/PBzVBnzZkvbecl45TaGaCbyPTwb?=
 =?us-ascii?Q?rvY5LmcPfVRkqNXmOh0/qQFqf5cbyfvQh/nRTLHATlmza0YzofhZfVUY7aWq?=
 =?us-ascii?Q?pIyLzIRhiLkxcjrXHtCFZ566ufdABqeVoBUNGFHFKO+pPF4fKxNK8HyMQF5h?=
 =?us-ascii?Q?cWw1id9CAWL0q2Zv5YmL7tCpllCnyknNx25NIA7W0fCv5U2U1qDI79hYSHn1?=
 =?us-ascii?Q?gnGhcTBqlWcaMXP0uUpY8eOaVZMEYaNO71yFxraW9cwpsbvTCgTivT2LocqR?=
 =?us-ascii?Q?KXYucScXH1e7sx2K5hOzJpMVf3yHFd6NJXQRGRs1DsqARjW4C/Q6DYRPlEUO?=
 =?us-ascii?Q?cpLscfGUMX1BZu2y4vyrdIQiaTTSYfZUy/rRy9fbpIB+IF+eZUIpv/hl1r1f?=
 =?us-ascii?Q?R13QuiPT2GpK/BOnWYS4kx4ZIMzj15qtKssqRH/Iugze2HnRDtrXM1ZqsMX3?=
 =?us-ascii?Q?Y8JTUHcGc+14TJRsiMixMfrr4sK9HxsuowvhOoKbN4BXutQLxLdMnjVTsxpt?=
 =?us-ascii?Q?sxABbMXus0w9Nb++jgEKlyMeiVjg9dp1kls+gOHtzdxh37j4vf9mcO8TGGya?=
 =?us-ascii?Q?ZtEGFsBCjc+8ScUOOTd6xCBYY1MJIsBKqmGiT8yEaVjKMSnDJyFszBqCP1t+?=
 =?us-ascii?Q?KQ58FI3FqxhAUkEkOc5eUv2b8RZdxu7LOI5iFTgtgBZlJJ9gRh98svlg2b4Y?=
 =?us-ascii?Q?laHq8yHUexyD+AOJoS1oAgecYNkSmBssvaV7ZfyNMzmyilN5yQwpJxNaexdj?=
 =?us-ascii?Q?39GYilN3KeWN4WvGGESgIfq/3N3Dchlm/fhWvC6k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed2b46a-e85d-4faa-0c08-08dcc1d5c201
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:38:20.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbMDrea+ZuYAm4CJxAdIqx2gj2Ub0I8a+c0RhsrP89eAmRZKiIclGTA44DthBtPqEKHS4ohKeJf1XuDD3Qmgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6070

__xfrm_policy_eval_candidates() function maybe returns
error pointers,So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c56c61b0c12e..2e412a48b981 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2156,7 +2156,7 @@ xfrm_policy_eval_candidates(struct xfrm_pol_inexact_candidates *cand,
 		tmp = __xfrm_policy_eval_candidates(cand->res[i],
 						    prefer,
 						    fl, type, family, if_id);
-		if (!tmp)
+		if (IS_ERR(tmp))
 			continue;
 
 		if (IS_ERR(tmp))
-- 
2.34.1


