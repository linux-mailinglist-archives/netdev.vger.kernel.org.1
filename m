Return-Path: <netdev+bounces-220875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC3B4950A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5357D4E1E49
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC1311587;
	Mon,  8 Sep 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FyTg1kM/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F93112BC;
	Mon,  8 Sep 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348343; cv=fail; b=t4lofE/zHDYTNfNrpCSrPNHxnDG5M0eO7vjMi2GZ6Yq6bEWU2gjaiugBypVkIS3ExYibZrSz7IJ4rwL1wSQzZ0g0uo2kGlDPrV7nAhxgkWB9Iv/2U7yjtANFNeQm3xc3+bdgovKPttAVDJk7JiAs/X/O9M+tn1f81CyIoGWI31Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348343; c=relaxed/simple;
	bh=w+5gU0JWAiUzgJZGhDzhh1s7YLvwugeyXPZH95yuszo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjV/RBJrbp/wyLiP+TS8nEptNhCk/YXyRaPxtmaDRfN/4t8m8JZHLVwYWSUrbRd7AKTB8+eQK2At5T980yj3ko008MqcQyxZlp443z0oAaSVhTmZ+qv+2IEgMJUg1qLczwwmYPJSRO2GREPl5eztpwu81koJe4b3M64+elsTbF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FyTg1kM/; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOYgnnGgpINI2LzS30O/VwtYSD0UujjSQ08LVyLqINQTIUhU4TxyHtJtaKAASeapDKNN+aUvgJ5ZtGNlcgBbNhU606y1ghlTY5EUwFdNVVpYwbUH8FC2fzj8HSb0FvrnOTAS9HeZB+YttjHApbft/xR1B0xcHD/BgvaNjeojn9ldpLCB0bi6Vrij3xoiWaMpAIW3JBj3lO60nYOhGhAC3f5C8cEJO7tC3HzI/CwxrZ3yk8BWr76LPRgJAJJoNs45kmUvs2nLWCl8JtffzHFsGDRw6NU+Ojl93d4cuBvhlixkbuznb8g3Di4TTLSTRAeTSTbRpBL2IcR6jo61NdulIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpRPl8fbu+1/hQfhDqpc8JIUp7b2A2J5lRfNAMfiPXg=;
 b=sQFXnLndIf1kFdZVoNZCIxUf5uQi/HsFOP+dLCLg38icBZzMPdFofAZGxVg2Rwmqib2+0S5fgMeeDIMOFTJ1o3BXBHboSJUKtQWRCeHNgP1ezIK7aAPco9cKRvV6aZZknopgX16uF8/83Ie5NNjcxIfRAyLr07SsDFegx4Gn1ZywCl2IPXvEIAMCc1Kvntt+sr7o4khTvQ9rMJkrEvu4uRi0Z/VoXFmLCEh8eguZOSCLh9gxDkXIBvrjjPlHxFuW8B6Cdgc5t+V1nB/pfQjwdK+BY3dIvMZEk3no+AF4VqcU1VbmECy4I1z9mvIwaJ9tVKShhVRPNz/Xzj06x7oULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpRPl8fbu+1/hQfhDqpc8JIUp7b2A2J5lRfNAMfiPXg=;
 b=FyTg1kM/BM5ejwVYH6TkFthDM5loNrEO3DEHnIx9dhvIHYN7lv9Np+2bsn9lCSJFCsGSRAUkyC1w7gKNOBJ35BonHxnxcMCIJdrR4qFVGzxx1pwvaGfb/8FBZt1HAOUbVebdt6pPb5NiIijprarge21EVBfYBIK3BWx0sBpYPSf2YO7LWKpEWOvlmqepWLP91TN8loMkSSAcSSKyZWveH29GJSGoiOrr6ldhkFwuwaD6gAClzmhw15biDVi51GtiPftt1J763OW1/dXmt/IEU1Fbj3OQXsGOGvOwafVg4OXcsLRstRZjANtEkfSJDMU9P3xNx4eEdIhXsNV4gDioVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 16:18:58 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 16:18:58 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v6 net-next 5/6] net: fec: add change_mtu to support dynamic buffer allocation
Date: Mon,  8 Sep 2025 11:17:54 -0500
Message-ID: <20250908161755.608704-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908161755.608704-1-shenwei.wang@nxp.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 459805ff-faaf-4483-1240-08ddeef36a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYxAHsWAXO6uN94Ntbto265GuKhCHttcRAbdlYpaUhtgYbwrIg/b9JIPDUap?=
 =?us-ascii?Q?3boL+EClpCOBYl5Spwccg0MxPOGfweBmTxj4vHgQO0fSnxPgwdW3eLv3hT0z?=
 =?us-ascii?Q?IAlELlUMLwqdFfbz1MPDpvoc1NqB1n9keVT7TeH/9IlnNqLJPl+bZUwu8LLi?=
 =?us-ascii?Q?xHMO44atQztvBnmj1XIoxJXYtcS4VtAjhpQgF3b3tkL2Dm3fM10oWn7JEcjD?=
 =?us-ascii?Q?EIpzK2L3SvWXPA3BLJvcp3/PSnnuvEsz8pzVcRKDmkPzbnNFE6Ni2xfJk6dp?=
 =?us-ascii?Q?hYRd3fuC8pjb1K6+2VALNfmIHrokh+yHvD76Ynm/N75uClbyaxXLmC5ISOt3?=
 =?us-ascii?Q?B8Jzl6LgWh/6ws3DcD2VDsUgZKdF7i6S8SYZtM+5xnRQjtCHDFCJz9y2Bgec?=
 =?us-ascii?Q?AyyNa8FkKP4JIpYC50ETHNDTeMyW4lf4WW+Gxh3DBZgFkK8Gq7XYubIVict1?=
 =?us-ascii?Q?rfsFCRe/Ej9fGGGBwcZk2ko5pFZKm4HGsGEPYMbPRTQebisHgsGHmHFDGGo6?=
 =?us-ascii?Q?xnGu2jIctjqNFscyI1wSF2j1o5gkA2V0dzk75n5DLP7IMB1FotHl0pBqMaAe?=
 =?us-ascii?Q?yxVv5nOdlaukj9NJnNdT4FWObpMmrtlIyjO46h8ZvTDz091bhTmh23gH9Shp?=
 =?us-ascii?Q?GdUR5PaerMyTp5rOKrn/XlN5DRjkDY7k7hIDO7r0UXZl1/g+tKP4tHE7usKn?=
 =?us-ascii?Q?Tbza8hZ/EWaghAvAanJQPtKp/QIeGpTi0A0yZZ7E7tCiqYGTlLQeizQ2EISC?=
 =?us-ascii?Q?JWJAwg2dPnxHctxUOncf+qVsFMuBgh1wUeMrYpqd0Fj3VmYwstKJQXrJmiH6?=
 =?us-ascii?Q?2ssaoVvmd/AAOuTVZoqboH+3ba/sqQwXv7Yqnce83CXg53BR245YtHRfIrtz?=
 =?us-ascii?Q?wmBkPbodGQsB/i9vIhK5DOiUaBVEhmNYKRg7NBxwzD0JdVyn9YbDctKOBN+t?=
 =?us-ascii?Q?rgyp8hPIaW71hVQfVTP+MmY1RK9+wivT83FrruuoUmykYwTdjJZoh7TXZ736?=
 =?us-ascii?Q?0kMOuB6FvaM219CtuUbyjrlNlbv989J45qtZik858lIL4OnnutvBoqUQmnwH?=
 =?us-ascii?Q?vkpUki3uOlt7juWN4e+dF3dIEIxUi4SeDhotvgJXikywotHee5qIwvFKM7Kb?=
 =?us-ascii?Q?/ESYobxg3BKFrbQzYQPJn/ketfhOmjmfxzAzWs+cLy73X7kxqqq0idafixuK?=
 =?us-ascii?Q?JZTrR6mCSaI9ClyhG4JBZsHLxZvzosKy+6FUjIOQ3fS9EITCYbx1O4BkYvGn?=
 =?us-ascii?Q?IN1qZ0pPNST7zcY7dTGcG7Pkwzds0Zh25JhTv4J42TmAd1YkHamOoslaSyzq?=
 =?us-ascii?Q?yQeBS2VX6pqJ/kUx9KW5JvXh+htYQGMHkG4VqFg8pFUHeMkhzONGaJ8bZRZZ?=
 =?us-ascii?Q?tuym10FuK4NBqG95l9M3snzqJM+U8ewurmtXUlNjGHIa2dybhxWTYv4OrFn6?=
 =?us-ascii?Q?2Vt+L76GwZT3mrNR+auXZf4AmKk270PiXUGKqs9oarjzEdWoiB8FNEksBDxz?=
 =?us-ascii?Q?2ux730Ipp9B5j8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9m2drb/3fMTWIWC5jJHCQSP18XQOjC5Y8kx6pXQ/9HJesIqOWFZUQBv3xu6V?=
 =?us-ascii?Q?pBOuwgTZb4ARnGzdRiT1U6EDSivp85+t947ThI98Sa7gCREZFvto+/dJ+C3V?=
 =?us-ascii?Q?x/1MzQbHYzOptc3xacU8E6mlfaYMmQ1vUsaJiSP0gKegmyGSW8WU72jF3J/s?=
 =?us-ascii?Q?hzpZUjuRuPKy+2DjDvzQGPfRGNWXEPCIn4FAKbvbDe96dPr5lGCt38qG98QF?=
 =?us-ascii?Q?ANQ1K8y0ZXOb7Y+CzfAzG1eKsiErAw6n6seyNR+I53p9TMVv+n2vu2PNPmqT?=
 =?us-ascii?Q?tHVxbtLtagrgMNRw9z+qlgPiDuFiZ4tQHO0n328n7BmiI6WmAUmIsJvcngNI?=
 =?us-ascii?Q?2QmZUUY9UPzzOPY/bYRwpMpwyq49OTNZEj4drX+XJa10ld3zks+qBH1s4kdw?=
 =?us-ascii?Q?IbqlDyfeQo/u3km0MeqlJx9LR/Dg4jIcHQD6dgxNLzUFtdx58kmAxKTITIf8?=
 =?us-ascii?Q?LkuSDcmtGTt2xm9xfKw1b0vsskvGz8qdV26BdHHCKtr/b9nAalrghj5RoWf4?=
 =?us-ascii?Q?ZBIiRBvpBZJus3kyP2DB+3CTxSYo/x/ftTPs963wrb1pbwlqgGMEJkpz8nsk?=
 =?us-ascii?Q?+O9ME06K3VjrNN32LNE9RLYkXtRizQOIvNuICqsFvNJOwFxTP6V/pkKx6jMH?=
 =?us-ascii?Q?0D3i3GfFKn1Cq0YNqZx7VUJVu1aZrooPnYL0mdZ6DDB4tZS50GQQ/31Lt2Cy?=
 =?us-ascii?Q?g0b2OKc4QpCehJHp6d07fo76XVv0U+g8relxaaaskV6yIwS2NLXW4xjIqnmm?=
 =?us-ascii?Q?t1TfIEQAr/82CMP8eOlZDt8npJK9/taltN/7uBwQwBOYFf0D7I11fci0JyCl?=
 =?us-ascii?Q?J+ap9WJsv3/kHpvhCr0bq4h2WKn5Boz5/4VtvC8Y43AzXDa7xjcA/RH6x9fo?=
 =?us-ascii?Q?OXL/AKHahJb3ZpVB2IFO5MpW7IfiogWbn3rAX8srFr7FCJ28LaQNvBhJRu5M?=
 =?us-ascii?Q?KVMwcIoYtdKkXJz9AP9Ac4WK6PurLnkKw1glEXkYLyiGP5Bve24m3UAigTIu?=
 =?us-ascii?Q?SwAz9GIPXDzg9absbem6CFJwN7yKQ1fLyKbzaP7dNfgxCO6/zZuqPQEr71a6?=
 =?us-ascii?Q?n4D6qgL67dGampXFleUonVbWtjkENIBfU+W4+MZ1+ZwEIdxJ9Z6wv4TDpo/Z?=
 =?us-ascii?Q?1pAWn2rCiwmjAg4kDFwpMDIP7CKpUKWzHC2PjAHKCVtkCtON//PnszD8HJL3?=
 =?us-ascii?Q?yYDkrFc4YSbdrasYyFZ98lCNSgSLwakY89uiWp/QUdNjdPDvVMkscUhDx+xc?=
 =?us-ascii?Q?18c2r2NbLwBZGiCZpMeZPrfcvk9Ztweyv2PJbtPD57HYfEJSEVu3brsi4kcj?=
 =?us-ascii?Q?31uI1TvyH1HbCWABSH2Of6GOHKxY8ShJRDYen55YnVQailUnIH3QjcXcDrCT?=
 =?us-ascii?Q?0ESlZE8jQu8VH4FRcgW7tiFF1k1cQ1grVvplXkPy81+e8wnlPBWtJEU0GRQ9?=
 =?us-ascii?Q?kTq9QmC4VnBia7VPjidiWsHtvlQFWyTEEt+gJcOmxHQgGnEEx2bryUdspfJy?=
 =?us-ascii?Q?E5gq9HiyReXyFl0FkVN4NYcCyO9rpo9oNQkeefZ75TQsaASpUYns05GOAfMC?=
 =?us-ascii?Q?GU8HCk8I7Cg1UeWpte2xnNTPxuSgvxn6A98/j8/L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459805ff-faaf-4483-1240-08ddeef36a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:58.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrJud1ZqjjzyMzZUFwDKHzt0xn9XsMdE6v6SFIGUH6+/dJWk67UmOqeaUUlH4kpKkNRQyf+zudjOGi/ShtJHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Add a fec_change_mtu() handler to recalculate the pagepool_order based on
the new_mtu value. And update the rx_frame_size accordingly when
pagepool_order changes.

MTU changes are only allowed when the adater is not running.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  5 +++--
 drivers/net/ethernet/freescale/fec_main.c | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f1032a11aa76..0127cfa5529f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -348,10 +348,11 @@ struct bufdesc_ex {
  * the skbuffer directly.
  */
 
+#define FEC_DRV_RESERVE_SPACE (XDP_PACKET_HEADROOM + \
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 #define FEC_ENET_XDP_HEADROOM	(XDP_PACKET_HEADROOM)
 #define FEC_ENET_RX_PAGES	256
-#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_ENET_XDP_HEADROOM \
-		- SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_DRV_RESERVE_SPACE)
 #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index df8b69af5296..a2aa08afa4bd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -468,14 +468,14 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = FEC_ENET_XDP_HEADROOM,
-		.max_len = FEC_ENET_RX_FRSIZE,
+		.max_len = fep->rx_frame_size,
 	};
 	int err;
 
@@ -4022,6 +4022,23 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }
 
+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int order;
+
+	if (netif_running(ndev))
+		return -EBUSY;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN
+			  + FEC_DRV_RESERVE_SPACE);
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
+	fep->pagepool_order = order;
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	return 0;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4031,6 +4048,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
-- 
2.43.0


