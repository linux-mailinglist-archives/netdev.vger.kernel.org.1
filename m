Return-Path: <netdev+bounces-122188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E89604AC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D1B20D63
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085C19752C;
	Tue, 27 Aug 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OK1FOmTF"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010010.outbound.protection.outlook.com [52.101.128.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B514A90;
	Tue, 27 Aug 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748135; cv=fail; b=CujnHA1IuXtKdg816oseUN1NvIvdxt5ZslGa/NGN9HQ6V/1gY9zHrgiTQozy3xo8wYAxXVwfz+8K3RFyOVeTU7wvG572CamL3wLpk32A17P9FwoGWBhcAJRHzoraF31MOfO05fnNSGbFU1rBfvK5cTnOu94+l4SlRHtqsfRVzhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748135; c=relaxed/simple;
	bh=nX7hDOOCDXK+BMZoXusa4C3Sv7Hy80wv9eLtOVORtC0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BiHyzU5c+f+7Q1NGO9LLj7aeuipqsFN8B86JHZbMXjz7lkZv3PAQn/b+p/oEVrAJufAO5ObIUEL/aAh/TRr3Twp5GyTm9wE1u67K2JgBHJCXmJBxWfR+UZVT/nVggWEofAhlJT5mrYyAU3nN2QNbkfpzzp6ny8hbKUKaUM2GZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OK1FOmTF; arc=fail smtp.client-ip=52.101.128.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9xf7VcpOC/MW8tnAF7xkxaR6QiX7s4A+GJvo48AfEfLBLXzpS8l/QuDxJiykvycn0XvNFx6D6LpdzaM6xsdRZNkRicYkBFqGi4WlNwxh/AzQuuQ6arNcL1LnsJF4qCwTsDND8AnrykBAkYFwW7NQNXeRn+ZzBPg4ysue00zfAMCle89GiJS0goXqjRQtYs0YCQcIbLJZ3ZJt9Dlitq7pYvmfu95IOVrTC3BoBKIWEeQjDGo/PncHbQa4v0rj1/JtLAa7cepOdBJPgzlZXFa3CvNCEIZzr4nTQKkasz7Qfk8uc13tP4ttf0RqQyrrQGK8wJhHlBWB8iNfKguZ3SkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytGDzG2iZya6D9tKEOuAvFVFO9wzLIcdurmuBZNxGbM=;
 b=jvI08fW5KB5iZXek7Mzv0ag4yF6R4wKk2HcSLygpnRWWGXKhEa1DyBEKE0bAMyXwI5jeyyignW/lAJ5TxDF8nhzHjs1S9xVTmdh4g4UgILtRheKujz4BonyABekW4P3QA6sezvqKc/o2j9NNl+SKdZ5cWtyrD+JvK1dJ0GraXDx7kLFy+7275AxANoTeS8eGXZkIbUlLC+XdZSjinEVCLq8jpq22gH6Z7f+AA+TFQJqpr3+5M9ffN65r/xaNajQ3Y6qv8IQ2AM2aT+1soEeuvamBvoLs+uM93bjKmrskD8PV/J/sdSnooqtXTQD/NlnQuGBtRFam4dCsNHAHPkFrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytGDzG2iZya6D9tKEOuAvFVFO9wzLIcdurmuBZNxGbM=;
 b=OK1FOmTFFnxAnF1c6YV4DrSy2ZcIn9m8URJrQNVUujJ0wUep3we3zu8d43zVTIXO2VDCDgoHab7s90YKpGzPrDo/+UKpUcrxetxqZvlNa30MxX/CtCWlKFWE1cY8OZQH9BLx5N9bZifgro0GyMmzkEJXXjjMQ7NDiNfDPKxmHQ0qdbOldx8DvNEzJWvvKQ+hNEPn9bRe/v63aM0aLww2x1WBkxds84uGqjuW8FYoSAErq+ZQD8E07drE5Qkrnj7ozaEuT2XLTIWFfXiKfc2DsEE6lmLBlj/tP0LasO4JVlnhMziMHz1ph+uJU1n55hkhiGtqNn2sNmrl3I7qxaIhuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6777.apcprd06.prod.outlook.com (2603:1096:101:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 08:42:07 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:42:07 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: louis.peens@corigine.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: kuba@kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.vom,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] netronome: nfp: Use min macro
Date: Tue, 27 Aug 2024 16:40:05 +0800
Message-Id: <20240827084005.3815912-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::36) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: c612b012-8965-4dd4-d528-08dcc6742213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SD2hwpcW+wZprKIRz91Ve8NE0QLJlj5RPqYsX2QfB/SsN9QV2kmQj9n6Nojt?=
 =?us-ascii?Q?DYtP7uEUGC6DZLu/l6GOjhNUr3VXjDt2wUlBC2pp5clsYsd7Nfl6aEp2qhXV?=
 =?us-ascii?Q?0OQtm0um++hE8AxFS/QnHDvmZ0+ChEU4G60JTAaEgyAl5wkVs8W1SOcdXuE8?=
 =?us-ascii?Q?csJ8DdvH+XW8TRLTZeevxRz52yDyilEhX4QTXFDZCfnY/Ce4aA7bqByGO61J?=
 =?us-ascii?Q?sttR8glFrfFqRW8SIN7TQsCEdS4rHfj55Ct4NJSYmZsuR5RQ2XSkIKEn4Amh?=
 =?us-ascii?Q?Z7E3hTsud3977MGINFSJ2mUF65xavHqCQku2vshCjRUEpnNoP2SqX398BfDp?=
 =?us-ascii?Q?uOaxZ+bHvnrAzCAU/Dy0OWTPnItejNNXYm9nor0STtiVDUqf2JNLXyXGf29y?=
 =?us-ascii?Q?48vdn+dxFn5uNoEm0DVme/P6k5awMB9jP1C/x2EyR65/vz6r6Yy+yZpTiSL0?=
 =?us-ascii?Q?Hhf7PxyYa86Bb+BvI+WiSryFeH4zh0TSF/24Gh65OjFiCAGfm5FxpdboeZUF?=
 =?us-ascii?Q?Fsb18AXW+cKryRWoktOZWFc5I3NDI5pDxsPHBeVrDfV7JJ4/owiBJk2TsqFe?=
 =?us-ascii?Q?KGUaY694RvYtk3fWwavQ1R84ScHv39pqPbdcPsjSkhdZGKVyH0dtVMIB2qdl?=
 =?us-ascii?Q?pmyWJ3nSvyIkqu6p8xFGJ5TPG6mV+vV6utex58ARRlAhtGX1lqQBHcW0L7DN?=
 =?us-ascii?Q?Z0ZWku2Ei+ZgnqkSRLvzSZg1MB/3mQ+3tedlw8r03DenbkyGgwShtDpBuvFH?=
 =?us-ascii?Q?/Fdv7kuDTAKgkeBOxUESfmuyqFqQ9OSfpBeAtBSqkC+oCcODQVh1lH00ZrD1?=
 =?us-ascii?Q?J5T0aTY/f3DZ4XA3U9BkPrq75Wijv/OgJT6JhHptGBJmF7oaGUOCUESaiTqv?=
 =?us-ascii?Q?42Xnn8YykdebemXlr9sNZYUqINQEqVQ1JQ0dZrVrCiDoZpXLtiHZEBVP5v/H?=
 =?us-ascii?Q?aFhzdvC93R13IgUzc3Eb6N71Lzc843lDqewD5bcz1EwFrWBoqxFHzDIoNNsh?=
 =?us-ascii?Q?LDoJoXfkpWU+FKFI9o6vFxYNThO3R0KVLOX+RQVafOFUMzEjNfILVsnCrJJO?=
 =?us-ascii?Q?pyFdumWTAPFBe9EKrcgqBBEWk7Jjg5Y8KgjAXzUDVdvu83j8ZcQD6wnLRFZN?=
 =?us-ascii?Q?/9VDZJQYQvM8C12KLcIGahrEj8J4ur3q8WywgHZKrZNTRnSaB84EJsp7wL7B?=
 =?us-ascii?Q?H8G3c8EkebgGDHUn+z+eq2GEbDs/nabmX6y3jGXeIgWUej9Ham0rWwb/y3S8?=
 =?us-ascii?Q?smpnBKeHcG2226A8WOdFJ1Ii/n5P8gcZFOMOO9MiIiY/y6CdDKvGh72KKkB1?=
 =?us-ascii?Q?qHG4G4mvE+wFKSuzR8JtVlHYq/LworTTRv+78/q+jIQTLlcXc6vkHzTNyE5h?=
 =?us-ascii?Q?FOp66OfxnhyZS2lpVChgxDsXjfGhLV8BnPtzKj7uJ8f2J6B3OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWwQuIcs4dus+0t6/Ps5R1ngBTnGj7P9BLFCaeK6XkguVzzOUqBNsI2sLz6L?=
 =?us-ascii?Q?4AHxgCg/KtTI40aHv8v/HI784STiQUUsg6uUWg1JzFAuuYBitvv3qMF0Afuj?=
 =?us-ascii?Q?SFn0nFV0C6IadlEZ1Hrxfn0Jtkkgx5zzRV/cUo2SoqgPbzvEV9h6itBjXdQm?=
 =?us-ascii?Q?fvPvN4estzN0ajacV3hsXTrm4DBUL0xEW05S+dUrWMci/wVnmF1KHVJ1HBYb?=
 =?us-ascii?Q?4tjNb5w5P51ZVo4yBSQUtjUFxmT5fAX9+JFgBTF8EcbgMDkS3OW5OEOgc7iX?=
 =?us-ascii?Q?DX1oeU3SBJ3qA4gSmi1YXadyyZo9qJO6oco3KjXZE4LSeYT8kLaOOQZ0y5Sa?=
 =?us-ascii?Q?bAbuU71YEbUVScAsvTRVwbtGZEu6b89frLGc2ULrgGDWLTnHUUCi/O23lsm5?=
 =?us-ascii?Q?r2zmesEOKikomfoua0Uy1vUgr4wugHK7TlY/xoA4Hr8sCFMZ3vGg50+2Gcuk?=
 =?us-ascii?Q?uBtMLV8k3iA9DvA2Lz8K2auPJTaFRfGBdo2a37Dc1L6IasQevSCbXpW22dpP?=
 =?us-ascii?Q?JP4PdxHJ4wZ2GZ9unqCPGjyPquX7G6nXgp/Q70LC29e7wtPtw9L+KJD+9//m?=
 =?us-ascii?Q?3hNHLC9ljOumrerV87z9PM+0wa4rUg73Yq9QNWzbU+6YD4G3rBoKqM11Tve3?=
 =?us-ascii?Q?iQWmTlwVlJ8TEcXgQoSSD96GvU/QARFL62hlPtGu8PC6K4Zrs3gNgi2yGoay?=
 =?us-ascii?Q?/a7wtH/s0aVJJ6OGlNFKO3ldAzIDKo5W+TzJYf7VaVTRNXPyZIPWwVVW2Qsw?=
 =?us-ascii?Q?bQfrlOPekianJyUhwDWIEP8TwKg2bxZhgPIzpZYBO77m/BW7aecvxpI++DJZ?=
 =?us-ascii?Q?GhvT2hM6BykQblPWo62/O+iUkJhQql9p4/SwSpRC0k8iQJechuMFmOjaPWST?=
 =?us-ascii?Q?5uCtkv1Y26CdUDhdjYcbWzeqGk7PrvCz5zdMZhhQ0aWm/wjWPcyLg4DR8mG7?=
 =?us-ascii?Q?srixGvKQR7pk4OqZHoMMfBstcY9MTNc+tttkG8AYGgGv6QnYkBZfVq0STvjO?=
 =?us-ascii?Q?gzd9wDe5uFYiIbY/pWqVcnC7V6F52PeGcAv/DrLvAsVYQnWHnSun8HGTyCi0?=
 =?us-ascii?Q?9U+D/NC6eNfJEBBRpbAlbbNCf+jdDF7scM2elCqJvcF+phy2Zi12pvyFC/gp?=
 =?us-ascii?Q?uh9AZW9N+lL0l1Ta6XIL/V2fvjqjboWss1+uwSPbQffWY04hS2mefTIt0dDV?=
 =?us-ascii?Q?ygt/EqytgDHiFEPmeMw4kgPteQ86eBbRGeE3DEmuhY4a3opubkMBLmFDh+Qe?=
 =?us-ascii?Q?5IBp9coZDs6jOgMC5wE6m8LNCK72VrKeN0sbymaOjeaXsBvz3uvmYlSOz7yl?=
 =?us-ascii?Q?8aNY+mVNjnmXsLEtT4Cxu3OHLafMhdcLo8yabw9MqLnemBKAr8C8goNGcqCl?=
 =?us-ascii?Q?Qjnr9HB1abdnTpkiEFeS0HfJrBfaf97nayN/xGe/r16BD19St8IVx4Al4Ook?=
 =?us-ascii?Q?za2lAXY4lec3Rws/3p+J3s+BLsQxwaCik92u4XvJ9ZOqQ2JxYnuLpxUDzKr7?=
 =?us-ascii?Q?vpfCtqdO3MSleWkEPpQyUV+xwPZojOASd2Zl5jO+g08G+UwG73hzHtspj7V2?=
 =?us-ascii?Q?eYsV4cS1mBaXvXfVmSwQn5cyIEkboYTQhAoIdgbk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c612b012-8965-4dd4-d528-08dcc6742213
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:42:07.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYBIVgj67Cz6kT+J2j3qWjnnodrZJueA4gj5GqRoTLW4ch18UqLuM9XPTwvpuEsVT0E3SeaGVpun0lOksdSG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6777

Using min macro not only makes the code more concise and readable
but also improves efficiency sometimes.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c      | 4 +---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 182ba0a8b095..e6cb255ac914 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2857,10 +2857,8 @@ int nfp_net_init(struct nfp_net *nn)
 	/* Set default MTU and Freelist buffer size */
 	if (!nfp_net_is_data_vnic(nn) && nn->app->ctrl_mtu) {
 		nn->dp.mtu = min(nn->app->ctrl_mtu, nn->max_mtu);
-	} else if (nn->max_mtu < NFP_NET_DEFAULT_MTU) {
-		nn->dp.mtu = nn->max_mtu;
 	} else {
-		nn->dp.mtu = NFP_NET_DEFAULT_MTU;
+		nn->dp.mtu = min(nn->max_mtu, NFP_NET_DEFAULT_MTU);
 	}
 	nn->dp.fl_bufsz = nfp_net_calc_fl_bufsz(&nn->dp);
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
index 5cfddc9a5d87..3d7225cb24aa 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
@@ -412,7 +412,7 @@ int nfp_eth_config_commit_end(struct nfp_nsp *nsp)
 
 	if (nfp_nsp_config_modified(nsp)) {
 		ret = nfp_nsp_write_eth_table(nsp, entries, NSP_ETH_TABLE_SIZE);
-		ret = ret < 0 ? ret : 0;
+		ret = min(ret, 0);
 	}
 
 	nfp_eth_config_cleanup_end(nsp);
-- 
2.34.1


