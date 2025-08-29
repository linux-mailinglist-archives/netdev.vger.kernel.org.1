Return-Path: <netdev+bounces-218131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D999AB3B39B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8FE1C80C6A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92A257459;
	Fri, 29 Aug 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nlmaKlcM"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013060.outbound.protection.outlook.com [52.101.127.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274513AC1;
	Fri, 29 Aug 2025 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450058; cv=fail; b=Plq2ktkspeC37iA92noGq+giabz2238yUpDNzNrTuoc23yOxTU74JcQ4p62JnYPH+duXfwPbAU7rw+vluSZrpmunigsIAehlvdl0GyVtwUatMNxZ/54XhCQAzR5nrPr8E5YFCXyJVy7is40P7D0FTRF5MpM93oFU3t7RsOKO33k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450058; c=relaxed/simple;
	bh=as3xdNhdQV/HpqYmRMvJV3Z79BoGKfuGTZcJbY/31o0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J9aieYCWK/3MMj3Rcu4Pu4apI5GVNSlGDvN4hpNKtw7sJxGBPHiu+wAj6UU2Y0QLlp/pnEVXvcHtp+uXBNc9Km9XzjugbvYaYoiWn69HqImcqBVAZ484S7v3sEuf2YTrW6kekbKwFDs8kgSPUHD9P7c6GroqS+IJiS8k4pPG9Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nlmaKlcM; arc=fail smtp.client-ip=52.101.127.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPrWPhRuEyOcQ9G8yxsKOlOvN3LOGXKzE9S58sYiHXdnEsw8ywHniV5mezvkRdb0uPg337klwitcG7YjULxExzQyfJp2ecxwTkBculyjj11BqPFxXexRdRQzu5spByUZqWllXHEv2Zb56PQriWaleNnuxSiGtsBHpXAW6daLobqokQxQz67MgPaKMuqQ+s3SRfmtcYznkgS5B4FsP/2MV7GmQldImvarHtZcbWR+xMpGOeqP0X/PBp24Vo8zrWAbkJt2brtKzT37K/tTxkPIwA2cBlgSY3gMrMO4KP5vKxFJAf1PdEpDtg0Z/vQ9tLycZZVMKFJaXEmVy0mSbDTmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF5wPvqYoESTjVIRGWWGgHslz99bSYtWNt/IvtDLqoE=;
 b=oQ9erxl1SluR2+F/bufcSElLOA7/jxWjutaRonmgev6vQ4P64AWTyQUSkZXLpqV/FvmaRWNLrOpt/xWUIuho/oeVblmUgBRU4oMNo5MrO9qAZNjyIDV9eXrVpdamXXK2kBc54yLj7VATQL+RZb/SL8Ig8l3XDepSwXpuE61AA4uUKF3x729v5Av9aWJxkPJRAeHjkG7ZkhXce7nkH/Rv6uggRA1RUik8VHYU/5/xk341ihCpVbQc+fvIa7lpeaGMJUKE6Y4J/zOQ4aE8+YYZj9rbmyfJcxTjVjYG0IVjbScj6XtMrAGczSQf0qf+px4fhVeHKsI0ZsKS6VCppHMvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF5wPvqYoESTjVIRGWWGgHslz99bSYtWNt/IvtDLqoE=;
 b=nlmaKlcMl3JGPdqTzNu6vA0ekKLpC+T10piZBJTNRJWyImkMCLKMct4x9WZqURtKVZxyIFTXQbMIDtJ5QZlM/mUlDJTYfLghG/OBbiSNFyMAIFriyTdunZ4L6zzcsBxWm3CKIhAY7H1ExzH32U8hUWP/AHucWdiEXZ43HH8HMVlm0xC5aN+MvWFUVG4F2a9jGN4TYHbRHT5WqrCFP4BrgqBZ1Libqvb/sDxv5nb/Ds/5yrmBHVKeVxA41UhIsa2BcJJ/REVS049/Z+Z73KSFr7GG5Lt46AQbbPBxgcwuzO2W29Avz083zA9KKXAk6+8dCU/pdB1z2LFHhbjarkB9Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
 by TY0PR06MB6840.apcprd06.prod.outlook.com (2603:1096:405:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 06:47:34 +0000
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3]) by TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 06:47:33 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [net-next v2] net: stmmac: use us_to_ktime function to replace STMMAC_COAL_TIMER macro
Date: Fri, 29 Aug 2025 14:47:22 +0800
Message-Id: <20250829064722.521577-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To TYZPR06MB7335.apcprd06.prod.outlook.com
 (2603:1096:405:a2::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7335:EE_|TY0PR06MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1075fb-d11c-44ec-bfad-08dde6c7eecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NkTVAEeD9uK3dX+gHzsbg9jcUSxEVq59hWbAJD48bT5yGME5k16Ao9T38q9G?=
 =?us-ascii?Q?cQRTGeVH+OHNhYJt56DLWQTN9b4dURyjjeoOA+lYSxKdpQqNsiInUK5C0bNH?=
 =?us-ascii?Q?J6E/nEkE3Sm+IPfziWId8tBtY/zhvclqUNo++cB6JJ5NngjHnSMFEgCSmcRQ?=
 =?us-ascii?Q?S3zSTA50u+gN73YaewsuATeGPLEaJCVZJ9+GEXLd3pWGa/HHPv+KTvmdbdIO?=
 =?us-ascii?Q?Xz49BLFKUXIj/41/JX8fP1xpCwikyds1Q03pjbhiBqxanUvKa6YiNXLUGhDK?=
 =?us-ascii?Q?Mp/4Scg6v7KE9pnht8xPpYMz5yBpqKPaRsxeUxp+PvdWGUNG4I2WF3BdIlYf?=
 =?us-ascii?Q?6qug82fpgGhI0kRMwbBYyFtzZmKBNUegs578uoUpuBJk8LAsMjazwM437t7l?=
 =?us-ascii?Q?BU0Jw2bshFhTa5B2/UNTm8fgxBNJIzdDHQKFgFmFojhcBMr+2HZIu11f7R82?=
 =?us-ascii?Q?yvQJ8UWBIZsAIGHcJP/jNenIc//p+irAB8ZpWFtTyppqT+naTx1k3SO8AWZd?=
 =?us-ascii?Q?QfoNrCXZQLwlDK/buNwaYB2mS8l8c21xyXAgh7s4NVgLfwbzPblagJ1WkLEs?=
 =?us-ascii?Q?qaCCUy1HhoP3yhSwzpc+EEM7eKeZhIBNfGdiOHGDIwmRMzOxbJrjQkcIurSJ?=
 =?us-ascii?Q?mAog0b5ZzE6w/k+0Ua/plftq2lJbmxqbd3b6YMihMtAwyA0Z6202dzdkyPrR?=
 =?us-ascii?Q?BIketXp/W25zOMO3ekDFJ6A8w6M6hebAlJyWg+a2HB+qWe+DkE1LDoQl0r28?=
 =?us-ascii?Q?6s8dyD+28qUcXbntg9PKvv4IFUp3Xb9rEkLoytZFJAONsKimi+8pbYSV0j/u?=
 =?us-ascii?Q?DXkgGsRki3WGAYK8SSJGcwtlQMpS9FlIQIxvwC4lncJLggvpHZI3/4smwVgG?=
 =?us-ascii?Q?sElcDnKPY/Qnu/CPUGz4ISZs9uQSARP/HLpyHrIlSVZAjXTMf8RAZa9ZG+je?=
 =?us-ascii?Q?GO7+v+VoAnfHeqUPk1sd2Q78JsLia7T1WvOOlHUofdTuOg6LN6RmyuV6W5Ti?=
 =?us-ascii?Q?vQegkf8U/xiAMeZY+Qfd7bhqlREUMxK4mAjbqMUUwCI4/vDrAY3C2xkMzK0b?=
 =?us-ascii?Q?ywn7gzp6QaWAZLwTWJxsXGN80NxJ5tYk4XZzNG9GUYxe3VgUTrU1vL0tozPG?=
 =?us-ascii?Q?6+cF6JeZ7E+TTcnUajGT9XlhenYVir9eo8kplQs/HPCx3FR67KGAPEMFNs0g?=
 =?us-ascii?Q?tDz3SntRVV7q9jlkDsa9GkJT7dxjwKNYeCnfyeOXc5tOqVxTIbcBhRR8+fbk?=
 =?us-ascii?Q?7JUxWIdCUJwf6AGjJ6SCQM7VpFbBsdexW7T9JPVYRVNbt6bhy2C8eeJbibHl?=
 =?us-ascii?Q?vHpjrFepxOI5qUvuaycBR0MHrc9RrXtJtQ6vvxo2zE9bkk4gwNH4BzV5cwPD?=
 =?us-ascii?Q?nOK9rjHLVbzFrmJoL7whkOkCGQ/5kkSPATCzVTBRvr/zRSpWBpEj/rdMHDJE?=
 =?us-ascii?Q?/HTNr9414YyQ9+f/huifuWNAiFwhFW/lXCCP9vliOneHv5T4nkI/CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7335.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQ1P3hxn2cf4E2K5EXmL2i+FppCvYg8ikE0oAmIMreCN/XR47Q90gpZiKmLJ?=
 =?us-ascii?Q?gvCqG+5lA46SoVsME78Zy749JY/zvMM9409YJB0EUNPRLqEVQDHPZeIDjcbK?=
 =?us-ascii?Q?ec6v418Ss3Oie7ruSYwapJeVGVWxizc31hyF5Dof3QH9ILm6CJF7MCnt7Tyx?=
 =?us-ascii?Q?k1Qe659q3EAi4m9O2rBbaU1HxdPSXzLqhQUxlgK/3pT2qAHkq6NNngvwOnO6?=
 =?us-ascii?Q?vOSX0vX5bxK5KrDVE3Tc2k/+W/zlsoPt4u6vJRovwTkKmce1hm37Qj4eXvDp?=
 =?us-ascii?Q?NpBbkIVap3LL9zRDzaT9JDcHWY5ZkA87Iv5UQ7Qbrz21EWWEO3UhBHfu9p7i?=
 =?us-ascii?Q?eD7e34Gf5LUNtYPpYqc9rB2K6dWZH3peNR/BGI8cS0nndWsGweLFJrIaDaGu?=
 =?us-ascii?Q?0H+IQ6howSJte1xPeOp1CJUaPdH7JtNAn/ypOegWspwY/3uDnHF1jKiQ3tcB?=
 =?us-ascii?Q?wBvik+MVbAdYYaBLjaVNYmhiI7cCOyPDPyRtWlTCj3jVTe/P4Be1OWnwMCKH?=
 =?us-ascii?Q?nMo7SuhOwR6VojOl59GyyV0XwQmgxVEo92HoANOzoxLJ0ZSb+Q/aoRh8E+49?=
 =?us-ascii?Q?Hv+psojULU/qhID8xN/Cmk6J6Yw6sFL9Xhe3D2PtNTglNkI2pL2/gVvSNO8s?=
 =?us-ascii?Q?FB0M5Miou5a1Qt/5gfG0ZotUj6purYFNhxjbI/DTNi1LY2Yj0jBV98ELp193?=
 =?us-ascii?Q?xJheTm5pHRtJAWgFoEhuIzF08yHMxlLBb+mUjchA1+zURaFUglLXrnGYFL4t?=
 =?us-ascii?Q?f9BXq4WFsVuHx89iYqRZcuCIdYCmQq9ePFgZfxwIGYnuxiBEVCVVPyuCO3go?=
 =?us-ascii?Q?4XVFfjIQkqAWYgBFqZ1GoaEhyMD2mhptuufxfRZ30+2RD3vvxeuKlLJrVdVB?=
 =?us-ascii?Q?Ju+V49RFr2VmwjdefGd+TFCBwX2D1Xlkv/TbLVMW6oJ+oNEuL8/zXMQXnR6A?=
 =?us-ascii?Q?4z0cDfd/txxlxI/nbrbidOvdhSJyXbaKzT67V5D8uKHJI6i3/VvmXkhjxaMo?=
 =?us-ascii?Q?aY+yCmFCknsBZpEcSnYPnVL7yTl4vf4NEJ3u6aItxAhax48HwQqrWckAGSC2?=
 =?us-ascii?Q?AYxgXh39SJH3LZZqECE4zVJETchvaUzHTVj9dI2R94rg6sqUQTD2S2bWCSHW?=
 =?us-ascii?Q?wZLv/61z5pP0VPPFDzIyGsJ9U1wx+ujbKVLY2HIe5FwmcU6rgO2YgjHdo9O/?=
 =?us-ascii?Q?aHgvxKkMlc9Yw4h5uYNaS2Ezf3ranQxBlG5mIyO+WK+3C6Dxwxlxw45cJ5fj?=
 =?us-ascii?Q?PVB9RvUWGWQ+oFjyAhqzkpJ3eL3E6ZmviRaQT+trL6QLM+SlKCGvRi1gzbPE?=
 =?us-ascii?Q?I7gakBh84oFigwvP/jcib07SX78X2iFGAimzSf7605FiTgwTAWZFP47FPS73?=
 =?us-ascii?Q?oUmZMMkKFF5HIvzES/GqI6IyASLMzvFGvLkmc+0En/MjyoBsA0plp6Ke/KCj?=
 =?us-ascii?Q?2OYYTEV8AFwUUep0v+PnWIryRBTCKMQqTwq/psAYo7D/BGMr360Vk7TTSO8j?=
 =?us-ascii?Q?0qb+xfgJZS/x5Hh3U/P/9nNitXYUD+nZoErYUmR16Y96F5khML+UtAytDBp+?=
 =?us-ascii?Q?/X/8wT3fS1yYY/fP0eggKvE20Q3PCCtO2ccGvGhy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1075fb-d11c-44ec-bfad-08dde6c7eecf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7335.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:47:33.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wZPMcdwfkuoGPxZpNVxG14IP4AzsWBe0d1TJXV8bf555fgCmhv7C6Zs1H5w8lV8OUmsZFkSpZY2a50MF+7YPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6840

Removing the redundant STMMAC_COAL_TIMER macro and replacing it
with us_to_ktime enhances standardization and improves code readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
v2: 
  - remove the STMMAC_COAL_TIMER macro.
  - add "net-next" to the subject.
v1: https://lore.kernel.org/all/20250827020755.59665-1-zhao.xichao@vivo.com/
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f1abf4242cd2..2767ea5bd204 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -144,8 +144,6 @@ static void stmmac_init_fs(struct net_device *dev);
 static void stmmac_exit_fs(struct net_device *dev);
 #endif
 
-#define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
-
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
 {
 	int ret = 0;
@@ -3197,7 +3195,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 	 */
 	if (unlikely(!napi_is_scheduled(napi)))
 		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(tx_coal_timer),
+			      us_to_ktime(tx_coal_timer),
 			      HRTIMER_MODE_REL);
 	else
 		hrtimer_try_to_cancel(&tx_q->txtimer);
-- 
2.34.1


